#include <stdio.h>
#include <dos.h>
#include <string.h>
#include <conio.h>
#include "sos.h"
#include "dpmi.h"
#include "vbe.h"
#include "mvelib32.h"

unsigned char nf_wqty;
unsigned char nf_hqty;
unsigned char nf_fqty;

typedef struct {
    unsigned char f_0[20];
    unsigned short f_14;
    unsigned short f_16;
    unsigned short f_18;
    unsigned int f_1a;
} mveheader_t;

typedef struct {
    char *f_0;
    unsigned int f_4;
} sndqueue_t;

unsigned short prev_timer2;

unsigned int opt_hscale_adj;

static unsigned int opt_fastmode = 0;
unsigned int opt_hscale_step = 4;
unsigned int gfx_curpage = 0;
unsigned int gfx_page_y[2] = { 0,0 };
unsigned int sf_auto_dbl = 0;

unsigned short snd_8to16[] = {
0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 47, 51, 56, 61,
66, 72, 79, 86, 94, 102, 112, 122, 133, 145, 158, 173, 189, 206, 225, 245,
267, 292, 318, 348, 379, 414, 452, 493, 538, 587, 640, 699, 763, 832, 908, 991,
1081, 1180, 1288, 1405, 1534, 1673, 1826, 1993, 2175, 2373, 2590, 2826, 3084, 3365, 3672, 4008,
4373, 4772, 5208, 5683, 6202, 6767, 7385, 8059, 8794, 9597, 10472, 11428, 12471, 13609, 14851, 16206,
17685, 19298, 21060, 22981, 25078, 27367, 29864, 32589, 35563, 38808, 42350, 46214, 50431, 55033, 60055, 65535,
1, 1, 5481, 10503, 15105, 19322, 23186, 26728, 29973, 32947, 35672, 38169, 40458, 42555, 44476, 46238,
47851, 49330, 50685, 51927, 53065, 54108, 55064, 55939, 56742, 57477, 58151, 58769, 59334, 59853, 60328, 60764,
61163, 61528, 61864, 62171, 62452, 62710, 62946, 63163, 63361, 63543, 63710, 63863, 64002, 64131, 64248, 64356,
64455, 64545, 64628, 64704, 64773, 64837, 64896, 64949, 64998, 65043, 65084, 65122, 65157, 65188, 65218, 65244,
65269, 65291, 65311, 65330, 65347, 65363, 65378, 65391, 65403, 65414, 65424, 65434, 65442, 65450, 65457, 65464,
65470, 65475, 65480, 65485, 65489, 65493, 65494, 65495, 65496, 65497, 65498, 65499, 65500, 65501, 65502, 65503,
65504, 65505, 65506, 65507, 65508, 65509, 65510, 65511, 65512, 65513, 65514, 65515, 65516, 65517, 65518, 65519,
65520, 65521, 65522, 65523, 65524, 65525, 65526, 65527, 65528, 65529, 65530, 65531, 65532, 65533, 65534, 65535
};

static HANDLE snd_hDriver = -1;

static HANDLE sync_hTimer = -1;
volatile unsigned int sync_time = 0;
static int sync_late = 0;
static int sync_FrameDropped = 0;

static mve_cb_alloc mem_alloc;
static mve_cb_free mem_free;

// asm routines

void cdecl mve_ShowFrameField(void* a1, unsigned int a2, unsigned int a3, unsigned int a4, unsigned int a5, unsigned int a6, unsigned int a7, unsigned int a8, unsigned int a9, unsigned int a10);
void cdecl mve_ShowFrameFieldHi(void* a1, unsigned int a2, unsigned int a3, unsigned int a4, unsigned int a5, unsigned int a6, unsigned int a7, unsigned int a8, unsigned int a9, unsigned int a10);
void cdecl mve_sfShowFrameChg(unsigned int a1, unsigned int a2, unsigned int a3, unsigned int a4, unsigned int a5, void *a6, unsigned int a7, unsigned int a8);
void cdecl mve_sfHiColorShowFrameChg(unsigned int a1, unsigned int a2, unsigned int a3, unsigned int a4, unsigned int a5, void *a6, unsigned int a7, unsigned int a8);
void cdecl MVE_SetPalette(void *a1, unsigned int a2, unsigned int a3);
void cdecl palLoadCompPalette(void *a1);
void cdecl gfxMode(unsigned int a1);
void cdecl gfxLoadCrtc(void *a1, unsigned int a2, unsigned int a3);
void cdecl gfxGetCrtc(void *a1);
void cdecl gfxVres(unsigned int a1, void *a2);
void cdecl MVE_gfxWaitRetrace(unsigned int a1);
void cdecl MVE_gfxSetSplit(unsigned int a1);


void cdecl MVE_memCallbacks(mve_cb_alloc a1, mve_cb_free a2)
{
    mem_alloc = a1;
    mem_free = a2;
}

static void MemFree(memstruct_t *a1)
{
    if (a1->f_4 && a1->f_c)
    {
        dpmi_unlockmem(a1->f_0, a1->f_4);
    }
    if (a1->f_8 && mem_free)
    {
        mem_free(a1->f_0);
        a1->f_8 = 0;
    }
    a1->f_4 = 0;
}

static void MemInit(memstruct_t *a1, unsigned int a2, void *a3)
{
    if (!a3)
        return;
    MemFree(a1);
    a1->f_0 = a3;
    a1->f_4 = a2;
    a1->f_8 = 0;
    if (a1->f_c)
        dpmi_lockmem(a3, a2);
}

static void MemLock(memstruct_t *a1, unsigned int a2)
{
    if (a2)
    {
        if (!a1->f_c && a1->f_4)
            dpmi_lockmem(a1->f_0, a1->f_4);
    }
    else
    {
        if (a1->f_c && a1->f_4)
            dpmi_unlockmem(a1->f_0, a1->f_4);
    }
    a1->f_c = a2;
}

static void *MemAlloc(memstruct_t *a1, unsigned int a2)
{
    void *p;
    if (a1->f_4 >= a2)
        return a1->f_0;

    if (mem_alloc)
    {
        MemFree(a1);
        a2 += 100;
        p = mem_alloc(a2);
        if (!p)
            return NULL;
        MemInit(a1, a2, p);
        a1->f_8 = 1;
        return a1->f_0;
    }
    return NULL;
}

void cdecl syncCallback(void);
void cdecl syncReset(unsigned int a1);
void cdecl syncInit2(void);
int cdecl syncMaybeWait(void);
unsigned int cdecl syncMaybeWaitLevel(unsigned int a1);
unsigned int cdecl syncTime(void);

static unsigned int sync_period;
int sync_wait_quanta;

static void syncRelease(void)
{
    if (sync_hTimer != -1)
    {
        sosTIMERRemoveEvent(sync_hTimer);
        sync_hTimer = -1;
        sync_time = 0;
    }
}

static void syncCallbackF(void)
{
    syncCallback();
}

static int syncInit(unsigned int a1, int a2)
{
    static int dword_125FF0 = 1;
    static void *off_125FF4 = syncCallback;
    int v2 = -((a1 * 10000) / 8380 * a2);

    if (sync_hTimer == -1 || a1 != sync_period || v2 != sync_wait_quanta)
    {
        if (sync_hTimer != -1)
        {
            syncMaybeWait();
            sync_time += sync_wait_quanta;
        }
        sync_period = a1;
        sync_wait_quanta = v2;

        syncRelease();

        if (dword_125FF0)
        {
            dpmi_lockmem(&prev_timer2, sizeof(prev_timer2));
            dpmi_lockmem(&sync_time, sizeof(sync_time));
        }

        if (dword_125FF0)
        {
            dpmi_lockmem(off_125FF4, 1024);
            dpmi_lockmem(&syncCallbackF, 1024);
            dword_125FF0 = 0;
        }

        if (sosTIMERRegisterEvent(119, syncCallbackF, &sync_hTimer))
        {
            sync_hTimer = -1;
            return 0;
        }
        syncInit2();

    }
    return 1;
}

static int syncWait(void)
{
    int ret = 0;
    if (sync_hTimer != -1)
    {
        ret = syncMaybeWait();
        sync_time += sync_wait_quanta;
    }
    return ret;
}

static int syncWaitLevel(unsigned int a1)
{
    int ret = 0;
    if (sync_hTimer != -1)
    {
        ret = syncMaybeWaitLevel(a1);
        sync_time += sync_wait_quanta;
    }
    return ret;
}

static void syncSync(void)
{
    if (sync_hTimer != -1)
        syncMaybeWait();
}

void cdecl MVE_logDumpStats(void)
{
    printf("Logging support disabled.\n");
}

static mve_cb_read io_read;
static int io_handle;
static unsigned int io_next_hdr;
static memstruct_t io_mem_buf;

void cdecl MVE_ioCallbacks(mve_cb_read a1)
{
    io_read = a1;
}

static void *ioRead(int a1);

static int ioReset(int a1)
{
    mveheader_t *p;
    io_handle = a1;
    p = (mveheader_t*)ioRead(30);
    if (!p || strcmp(p->f_0, "Interplay MVE File\x1a\x0") || p->f_18 != ~p->f_16 + 0x1234
        || p->f_16 != 0x100 || p->f_14 != 0x1a)
    {
        return 0;
    }

    io_next_hdr = p->f_1a;
    return 1;
}

void cdecl MVE_memIO(void *a1, unsigned int a2)
{
    MemInit(&io_mem_buf, a2, a1);
}

static void *ioRead(unsigned int a1)
{
    void *p = MemAlloc(&io_mem_buf, a1);
    if (!p)
        return NULL;
    if (!io_read(io_handle, p, a1))
        return NULL;
    return p;
}

static void *ioNextRecord(void)
{
    unsigned char *p = ioRead((unsigned short)io_next_hdr + 4);
    if (!p)
        return NULL;
    io_next_hdr = *(unsigned int*)(p + (unsigned short)io_next_hdr);
    return p;
}

static void ioRelease(void)
{
    MemFree(&io_mem_buf);
}

static int snd_comp16;
static int snd_target_pad;
static void* snd_buf;
static volatile unsigned int snd_processed;
static int snd_total_processed;
static int snd_target;
static int snd_stereo;
static unsigned int snd_done;
static volatile unsigned int snd_cnt;
static volatile unsigned int snd_empty;
static unsigned int snd_buf_base_len;
static unsigned int snd_buf_len;
static volatile int snd_empty2;
static int snd_fill;
static unsigned int snd_buf_cur;
static memstruct_t snd_mem_buf;
static _SOS_SAMPLE snd_SampleData;
static sndqueue_t snd_queue[60];

unsigned int cdecl getDMAByteCnt(unsigned int a1);
void cdecl sndDecompM16(void* a1, void* a2, unsigned int a3);
void cdecl sndDecompS16(void* a1, void* a2, unsigned int a3);
void cdecl sndDecompM8(void* a1, void* a2, unsigned int a3);
void cdecl sndDecompS8(void* a1, void* a2, unsigned int a3);
void cdecl sndCnv16to8(void* a1, void* a2, unsigned int a3);

static HANDLE snd_SampleHandle = -1;
static int snd_paused = 0;
static int snd_vol = 0x7fff7fff;
static mve_cb_SoundHook snd_SoundHook;
static int snd_bits16;

W32 sosDIGIGetBytesPlayed(HANDLE a1, HANDLE a2)
{
    _SOS_DIGI_DRIVER *v1;
    _SOS_SAMPLE *v2;
    DWORD v20;
    DWORD v28;
    DWORD v1c;
    DWORD v18;
    WORD v24;
    WORD v14;
    WORD t;
    DWORD t2;
    DWORD t3;
    DWORD t4;
    DWORD t5;
    DWORD t6;
    v1 = _sSOSSystem.pDriver[a1];
    if (!v1)
        return 0;
    v2 = &v1->pSamples[a2];
    if (!v2)
        return 0;

    if (!(v2->wFlags & 0x8000))
        return 0;

    v20 = v1->wDMABufferSize;
    v28 = v1->wDMACountRegister;

    _disable();

    v1c = v2->wTotalBytesProcessed;

    v18 = v1->pXFERPosition - v1->pDMABuffer;

    v14 = getDMAByteCnt(v28);
    t = getDMAByteCnt(v28);
    if (v14 < t)
        v14 = t;
    _enable();

    t2 = v20 - v14;
    if (t2 <= v18)
    {
        t2 = v18 - t2;
    }
    else
    {
        t2 = v18 + v20 - t2;
    }

    t4 = v2->wRate;
    if (v2->wChannels == 2)
        t4 *= 2;
    if (v2->wBitsPerSample == 16)
        t4 *= 2;

    t5 = v1->wDriverRate;
    if (v1->wDriverChannels == 2)
        t5 *= 2;
    if (v1->wDriverBitsPerSample == 16)
        t5 *= 2;

    t2 = (t2 * t4) / t5;

    if (t2 > v1c)
        return 0;

    return v1c - t2;
}

static void cdecl snd_SampleCallback(_SOS_SAMPLE *a1)
{
    if (!snd_paused && snd_cnt > 0 && snd_SampleHandle != -1)
    {
        a1->pSample = snd_queue[snd_empty].f_0;
        a1->wLength = snd_queue[snd_empty].f_4;
        snd_processed += a1->wLength;
        if (snd_empty == 59)
            snd_empty = 0;
        else
            ++snd_empty;
        --snd_cnt;
    }
    else
        snd_SampleHandle = -1;
}

static void cdecl snd_SampleCallback2(_SOS_SAMPLE *a1)
{
    snd_done = 1;
}

void cdecl MVE_AIL_sndInit(void)
{
    snd_hDriver = -1;
}

void cdecl MVE_SOS_sndInit(int a1)
{
    snd_hDriver = a1;
}

unsigned int cdecl MVE_sndVolume(unsigned int a1)
{
    unsigned int ret = snd_vol;

    snd_vol = a1 & 0x7fff7fff;

    return ret;
}

void cdecl MVE_rmemSND(void)
{
}

static void sndReset(void)
{
    int handle;
    if (snd_hDriver == -1)
        return;
    handle = snd_SampleHandle;
    if (handle == -1)
        return;
    sosDIGIStopSample(snd_hDriver, handle);
    snd_SampleHandle = -1;
}

static int sndConfigure(unsigned int a1, unsigned int a2, unsigned int a3, unsigned int a4, unsigned a5, unsigned int a6)
{
    static int dword_126004 = 1;
    _SOS_CAPABILITIES caps;
    if (snd_hDriver == -1)
        return 1;
    syncSync();
    sndReset();
    snd_stereo = a3;
    snd_bits16 = a5;
    snd_comp16 = a6;
    if (a3)
    {
        sosDIGIGetDeviceCaps(snd_hDriver, &caps);
        if (caps.wChannels == 0)
        {
            a4 <<= 1;
            a3 = 0;
        }
    }
    memset(&snd_SampleData, 0, sizeof(snd_SampleData));

    snd_SampleData.wChannels = a3 ? 2 : 1;
    snd_SampleData.wFormat = a5 ? 0 : 0x8000;
    snd_SampleData.wBitsPerSample = a5 ? 16 : 8;
    snd_SampleData.wRate = a4;
    snd_SampleData.wVolume = snd_vol;
    snd_SampleData.wPanPosition = 0x8000;
    snd_SampleData.pfnSampleProcessed = snd_SampleCallback;
    snd_SampleData.pfnSampleDone = snd_SampleCallback2;
    snd_buf_base_len = a2;
    snd_buf_len = (a2 >> 1) + a2;

    snd_buf = MemAlloc(&snd_mem_buf, snd_buf_len);

    if (!snd_buf)
        return 0;
    MemLock(&snd_mem_buf, 1);
    if (dword_126004)
    {
        dpmi_lockmem(snd_SampleCallback, 4096);
        dpmi_lockmem(snd_SampleCallback2, 4096);
        dpmi_lockmem(&snd_SampleData, sizeof(snd_SampleData));
        dpmi_lockmem(snd_queue, sizeof(snd_queue));
        dpmi_lockmem(&snd_processed, sizeof(snd_processed));
        dpmi_lockmem(&snd_empty, sizeof(snd_empty));
        dpmi_lockmem(&snd_hDriver, sizeof(snd_hDriver));
        dpmi_lockmem(&snd_SampleHandle, sizeof(snd_SampleHandle));
        dpmi_lockmem(&snd_done, sizeof(snd_done));
        dword_126004 = 0;
    }

    snd_fill = 0;
    snd_empty = 0;
    snd_empty2 = 0;
    snd_cnt = 0;
    snd_target_pad = 0;
    snd_buf_cur = 0;
    snd_paused = 0;
    snd_processed = 0;
    snd_total_processed = 0;
    snd_done = 1;
    snd_target = 0;

    return 1;
}

static void sndSync(void)
{
    int v1;
    int v2;
    unsigned int v3;
    unsigned int handle;
    v1 = syncWaitLevel(sync_wait_quanta >> 2);

    sync_late = v1 > (-sync_wait_quanta >> 1) && !sync_FrameDropped;
    sync_FrameDropped = 0;

    if (snd_hDriver == -1)
        return;

    if (!snd_target_pad)
        snd_target_pad = snd_queue[0].f_4;

    v2 = 0;
    while (1)
    {
        handle = snd_SampleHandle;
        if (handle != -1 ? 1 : 0)
        {
            v3 = sosDIGIGetBytesPlayed(snd_hDriver, handle);
            if (v3 + snd_total_processed + snd_target_pad < snd_target)
                v2 = 1;
            else
                break;
        }
        else
            break;
    }
    if (v2)
    {
        syncReset(sync_wait_quanta + (sync_wait_quanta >> 2));
    }

    handle = snd_SampleHandle;
    if (handle != -1 ? 1 : 0)
    {
        v3 = sosDIGIGetBytesPlayed(snd_hDriver, handle);
        if (v3 + snd_total_processed > snd_target + snd_target_pad)
            snd_SampleHandle = -1;
    }

    if (snd_done && snd_SampleHandle == -1 && snd_cnt
        && snd_total_processed + snd_processed <= snd_target)
    {
        snd_SampleData.pSample = snd_queue[snd_empty].f_0;
        snd_SampleData.wLength = snd_queue[snd_empty].f_4;
        snd_total_processed += snd_processed;
        snd_processed = snd_SampleData.wLength;
        if (snd_empty == 59)
            snd_empty = 0;
        else
            ++snd_empty;
        --snd_cnt;
        snd_done = 0;
        snd_SampleHandle = sosDIGIStartSample(snd_hDriver, &snd_SampleData);
        while (1)
        {
            handle = snd_SampleHandle;
            if (handle != -1 ? 1 : 0)
            {
                if (sosDIGIGetBytesPlayed(snd_hDriver, handle) == 0 ? 1 : 0)
                {
                }
                else
                    break;
            }
            else
                break;
        }

        syncReset(sync_wait_quanta);
    }
    if (snd_empty2 != snd_fill)
    {
        snd_target += snd_queue[snd_empty2].f_4;
        if (snd_empty2 == 59)
            snd_empty2 = 0;
        else
            ++snd_empty2;
    }
}

void cdecl MVE_sndSoundHook(mve_cb_SoundHook a1)
{
    snd_SoundHook = a1;
}

static void sndAdd(void *a1, unsigned int a2)
{
    if (snd_hDriver == -1 || snd_fill + 1 == (snd_empty2 ? snd_empty2 : 60))
        return;

    snd_paused = 0;
    if (snd_buf_cur + a2 > snd_buf_len)
        snd_buf_cur = 0;

    if (a1 && snd_SoundHook)
    {
        snd_SoundHook((unsigned char*)snd_buf + snd_buf_cur, a2, 1, snd_bits16);
    }
    else if (a1)
    {
        if (snd_comp16)
        {
            if (snd_stereo)
                sndDecompS16((unsigned char*)snd_buf + snd_buf_cur, a1, a2);
            else
                sndDecompM16((unsigned char*)snd_buf + snd_buf_cur, a1, a2);
        }
        else
        {
            memcpy((unsigned char*)snd_buf + snd_buf_cur, a1, a2);
        }
    }
    else
    {
        memset((unsigned char*)snd_buf + snd_buf_cur, snd_bits16 ? 0 : 128, a2);
    }

    snd_queue[snd_fill].f_0 = (unsigned char*)snd_buf + snd_buf_cur;
    snd_queue[snd_fill].f_4 = a2;
    if (snd_fill == 59)
        snd_fill = 0;
    else
        ++snd_fill;
    ++snd_cnt;
    snd_buf_cur += a2;
}

static void sndRelease(void)
{
    MemFree(&snd_mem_buf);
}

static void sndPause(void)
{
    if (snd_hDriver == -1)
        return;

    snd_paused = 1;
}

static void sndResume(void)
{
    if (snd_hDriver == -1)
        return;

    snd_paused = 0;
}
void* nf_buf_cur;

static memstruct_t nf_mem_buf1;
static memstruct_t nf_mem_buf2;

extern int wp11, wp12;
extern int wp13, wp14;

void cdecl MVE_memVID(void *a1, void *a2, unsigned int a3)
{
    MemInit(&nf_mem_buf1, a3, a1);
    MemInit(&nf_mem_buf2, a3, a2);
}

unsigned int nf_height;
unsigned int nf_back_right;
unsigned int nf_new_line;
unsigned int nf_new_y;
unsigned int nf_new_x;
unsigned int nf_new_w;
void* nf_buf_prv;
unsigned int nf_new_h;
unsigned int nf_width;
unsigned int nf_hicolor;
unsigned int nf_new_row0;

void cdecl nfHiColorDecomp(void* a1, unsigned int a2, unsigned int a3, unsigned int a4, unsigned int a5);
void cdecl nfHiColorDecompChg(void* a1, void* a2, void* a3, unsigned int a4, unsigned int a5, unsigned int a6, unsigned int a7);
void cdecl nfDecomp(void* a1, unsigned int a2, unsigned int a3, unsigned int a4, unsigned int a5);
void cdecl nfDecompChg(void* a1, void* a2, void* a3, unsigned int a4, unsigned int a5, unsigned int a6, unsigned int a7);
void cdecl nfPkConfig(void);
void cdecl nfPkDecomp(void* a1, void* a2, unsigned int a3, unsigned int a4, unsigned int a5, unsigned int a6);
void cdecl nfPkDecompH(void* a1, void* a2, unsigned int a3, unsigned int a4, unsigned int a5, unsigned int a6);
void cdecl nfHPkDecomp(void* a1, void* a2, unsigned int a3, unsigned int a4, unsigned int a5, unsigned int a6);

static int nfConfig(unsigned int a1, unsigned int a2, unsigned int a3, unsigned int a4)
{
    unsigned int total;
    nf_wqty = a1;
    nf_hqty = a2;
    nf_fqty = a3;
    nf_width = a1 * 8;
    nf_height = a2 * a3 * 8;

    if (opt_fastmode)
        nf_height >>= 1;
    nf_new_line = nf_width * a3 - 8;
    nf_hicolor = a4;
    if (a4)
    {
        nf_width <<= 1;
        nf_new_line <<= 1;
    }
    nf_new_row0 = a3 * 8 * nf_width;
    nf_back_right = a3 * 7 * nf_width;

    total = nf_width * nf_height;
    nf_buf_cur = MemAlloc(&nf_mem_buf1, total);
    nf_buf_prv = MemAlloc(&nf_mem_buf2, total);

    if (!nf_buf_cur || !nf_buf_prv)
        return 0;

    nfPkConfig();
    return 1;
}

static void nfRelease(void)
{
    MemFree(&nf_mem_buf1);
    MemFree(&nf_mem_buf2);
}

static void nfAdvance(void)
{
    void *t = nf_buf_prv;
    nf_buf_prv = nf_buf_cur;
    nf_buf_cur = t;
}

extern int wp9;

static unsigned int sf_ResolutionHeight;
unsigned int sf_WinGran;
static unsigned int sf_ScreenHeight;
static unsigned int sf_ResolutionWidth;
static unsigned int sf_ScreenWidth;
unsigned int sf_LineWidth;
static unsigned int sf_hicolor;
unsigned int cdecl(*sf_SetBank)(void);

extern int wp1, wp2, wp3, wp4, wp5, wp6, wp7, wp8, wp10, wp15;

static mve_cb_ShowFrame sf_ShowFrame = MVE_ShowFrame;
static unsigned int sf_auto = 1;
static unsigned int sf_auto_mode = 0;

unsigned int sf_WriteWin;
void* sf_WriteWinLimit;
void* sf_WriteWinPtr;
unsigned int sf_WinSize;
unsigned int sf_WinGranPerSize;

static void sfVGA(unsigned int a1, unsigned int a2, unsigned int a3, unsigned int a4)
{
    sf_ScreenWidth = a1;
    sf_ScreenHeight = a2;
    sf_ResolutionWidth = a3;
    sf_ResolutionHeight = a4;

    sf_LineWidth = a1;
    if (opt_fastmode & 4)
        sf_LineWidth <<= 1;
    sf_SetBank = NULL;
    sf_auto = 0;
    sf_WinSize = 0x10000;
    sf_WriteWinPtr = (void*)dpmi_RealToLinear(0xa0000000);
    sf_WriteWinLimit = (unsigned char*)sf_WriteWinPtr + sf_WinSize;
    sf_WinGran = 0x10000;
    sf_WinGranPerSize = 1;
    sf_hicolor = 0;
}

void cdecl MVE_sfSVGA(unsigned int a1, unsigned int a2, unsigned int a3, unsigned int a4, void* a5, unsigned int a6, unsigned int a7,
    void *a8, unsigned int a9)
{
    sf_ScreenWidth = a1;
    sf_ScreenHeight = a2;
    sf_ResolutionWidth = a1;
    sf_ResolutionHeight = a2;

    sf_LineWidth = a3;
    if (opt_fastmode & 4)
        sf_LineWidth <<= 1;

    sf_WriteWin = a4;
    sf_WinSize = a6;
    sf_WriteWinPtr = a5;
    sf_WriteWinLimit = (unsigned char *)a5 + a6;
    sf_WinGran = a7;
    sf_SetBank = a8;

    if (a7)
        sf_WinGranPerSize = a6 / a7;
    else
        sf_WinGranPerSize = 1;

    sf_auto = 0;
    sf_hicolor = a9;
}

static void sfShowFrame(int a1, int a2, unsigned int a3)
{
    unsigned int v1;
    v1 = ((((nf_width * 4) / opt_hscale_step) - 12) & ~15) + 12;
    opt_hscale_adj = nf_width - (v1 >> 2) * opt_hscale_step;

    if (a1 < 0)
    {
        if (nf_hicolor)
            a1 = (sf_ScreenWidth - (v1 >> 1)) >> 1;
        else
            a1 = (sf_ScreenWidth - v1) >> 1;
    }
    if (nf_hicolor)
        a1 <<= 1;

    if (a2 < 0)
    {
        if (opt_fastmode & 4)
            a2 = (sf_ScreenHeight - (nf_height << 1)) >> 1;
        else
            a2 = (sf_ScreenHeight - nf_height) >> 1;
    }

    a1 &= ~3;
    gfx_curpage ^= 1;
    a2 += gfx_page_y[gfx_curpage];
    if (opt_fastmode & 4)
        a2 >>= 1;

    if (a3)
        mve_ShowFrameField(nf_buf_cur, nf_width, nf_height, nf_new_x, nf_new_y, nf_new_w, nf_new_h, a1, a2, a3);
    else if (opt_hscale_step != 4)
        sf_ShowFrame(nf_buf_cur, nf_width, nf_height, 0, nf_new_y, v1, nf_new_h, a1, a2);
    else
        sf_ShowFrame(nf_buf_cur, nf_width, nf_height, nf_new_x, nf_new_y, nf_new_w, nf_new_h, a1, a2);
}

void cdecl MVE_sfCallbacks(mve_cb_ShowFrame a1)
{
    sf_ShowFrame = a1;
}

void cdecl MVE_ShowFrame(void *a1, unsigned int a2, unsigned int a3, unsigned int a4, unsigned int a5, unsigned int a6, unsigned int a7, unsigned int a8, unsigned int a9)
{
    if (sf_hicolor && !nf_hicolor)
        mve_ShowFrameFieldHi(a1, a2, a3, a4, a5, a6, a7, a8, a9, 0);
    else
        mve_ShowFrameField(a1, a2, a3, a4, a5, a6, a7, a8, a9, 0);
}

static void sfShowFrameChg(int a1, int a2, void *a3)
{
    if (a1 < 0)
        a1 = (sf_ScreenWidth - nf_width) >> 1;

    if (a2 < 0)
    {
        if (opt_fastmode & 4)
            a2 = (sf_ScreenHeight - (nf_height << 1)) >> 1;
        else
            a2 = (sf_ScreenHeight - nf_height) >> 1;
    }

    a1 &= ~3;
    gfx_curpage ^= 1;
    a2 += gfx_page_y[gfx_curpage];
    if (opt_fastmode & 4)
        a2 >>= 1;

    if (nf_hicolor)
        mve_sfHiColorShowFrameChg(0, nf_new_x >> 4, nf_new_y / (nf_fqty * 8), nf_new_w >> 4, nf_new_h / (nf_fqty * 8), a3, nf_new_x + a1, nf_new_y + a2);
    else
        mve_sfShowFrameChg(0, nf_new_x >> 3, nf_new_y / (nf_fqty * 8), nf_new_w >> 3, nf_new_h / (nf_fqty * 8), a3, nf_new_x + a1, nf_new_y + a2);
}

static mve_cb_SetPalette pal_SetPalette = MVE_SetPalette;
unsigned char pal_tbl[768];
unsigned short pal15_tbl[256];

void cdecl MVE_palCallbacks(mve_cb_SetPalette a1)
{
    pal_SetPalette = a1;
}

static void palMakePal15(void)
{
    unsigned int i;
    unsigned short *dst;
    unsigned char *src;
    int r, g, b;
    int t;
    if (!sf_hicolor)
        return;
    i = 256;
    src = pal_tbl;
    dst = pal15_tbl;
    do
    {
        r = *src++ >> 1;
        g = *src++ >> 1;
        b = *src++ >> 1;

        *dst++ = (r << 10) | (g << 5) | (b << 0);

    } while (--i);
}

static void palSetPalette(unsigned int a1, unsigned int a2)
{
    if (!sf_hicolor)
        pal_SetPalette(pal_tbl, a1, a2);
}

static void palClrPalette(unsigned int a1, unsigned int a2)
{
    static unsigned char buf[768];
    if (!sf_hicolor)
        pal_SetPalette(buf, a1, a2);
}

typedef struct {
    unsigned char r, g, b;
} rgb_t;

static void palMakeSynthPalette(int a1, int a2, int a3, int a4, int a5, int a6)
{
    int i;
    int j;
    rgb_t *pp = (rgb_t*)pal_tbl;
    for (i = 0; i < a2; i++)
    {
        for (j = 0; j < a3; j++)
        {
            pp[a1 + a3 * i + j].r = (i * 63) / (a2 - 1);
            pp[a1 + a3 * i + j].g = 0;
            pp[a1 + a3 * i + j].b = (j * 63) / (a3 - 1) * 5 / 8;
        }
    }
    for (i = 0; i < a5; i++)
    {
        for (j = 0; j < a6; j++)
        {
            pp[a4 + a6 * i + j].r = 0;
            pp[a4 + a6 * i + j].g = (i * 63) / (a5 - 1);
            pp[a4 + a6 * i + j].b = (j * 63) / (a6 - 1) * 5 / 8;
        }
    }
}

static void palLoadPalette(unsigned char *a1, unsigned int a2, unsigned int a3)
{
    memcpy(&pal_tbl[a2 * 3], a1, a3 * 3);
}

typedef struct {
    unsigned int f_0;
    unsigned int f_4;
    unsigned int f_8;
    unsigned int f_c;
    unsigned int f_10;
    unsigned int f_14;
    unsigned int f_18;
    unsigned int f_1c;
    unsigned int f_20;
    unsigned int f_24;
    unsigned int f_28;
    unsigned int f_2c;
    unsigned int f_30;
    unsigned int f_34;
    unsigned int f_38;
    unsigned int f_3c;
    unsigned int f_40;
    unsigned int f_44;
    unsigned int f_48;
    unsigned int f_4c;
    unsigned int f_50;
    unsigned int f_54;
    unsigned int f_58;
    unsigned int f_5c;
    unsigned int f_60;
    unsigned int f_64;
    unsigned int f_68;
    unsigned int f_6c;
    unsigned int f_70;
    unsigned int f_74;
    unsigned int f_78;
    unsigned int f_7c;
    unsigned int f_80;
    unsigned int f_84;
    unsigned int f_88;
    unsigned int f_8c;
    unsigned int f_90;
    unsigned int f_94;
    unsigned int f_98;
    unsigned int f_9c;
    unsigned int f_a0;
    unsigned int f_a4;
    unsigned int f_a8;
} gfxstruct1_t;

static void gfxConfig(gfxstruct1_t *a1)
{
    unsigned char config[25];
    unsigned char v14;
    unsigned char v18;
    if (!a1)
    {
        gfxMode(0x13);
        return;
    }

    config[0] = a1->f_c - 5;
    config[1] = a1->f_10;
    config[2] = a1->f_14;
    config[3] = (a1->f_a4 << 7) | (a1->f_24 << 5) | (a1->f_20 & 31);
    config[4] = a1->f_18;
    config[5] = ((a1->f_20 & 32) << 2) | (a1->f_28 << 5) | (a1->f_1c & 31);
    config[6] = a1->f_2c - 2;
    config[7] = ((a1->f_38 & 0x200) >> 2) | ((a1->f_30 & 0x200) >> 3) | (((a1->f_2c - 2) & 0x200) >> 4) | ((a1->f_44 & 0x100) >> 4) | ((a1->f_34 & 0x100) >> 5)
        | ((a1->f_38 & 0x100) >> 6)
        | ((a1->f_30 & 0x100) >> 7)
        | (((a1->f_2c - 2) & 0x100) >> 8);
    config[8] = (a1->f_54 << 5) | a1->f_48;
    config[9] = (a1->f_68 << 7) | ((a1->f_44 & 0x200) >> 3) | ((a1->f_34 & 0x200) >> 4) | a1->f_50;
    config[10] = (a1->f_90 << 5) | a1->f_94;
    config[11] = (a1->f_9c << 5) | a1->f_98;
    config[12] = a1->f_58 >> 8;
    config[13] = a1->f_58;
    config[14] = a1->f_8c >> 8;
    config[15] = a1->f_8c;
    config[16] = a1->f_38;
    config[17] = (a1->f_a8 << 7) | (a1->f_a0 << 6) | (a1->f_3c & 0x3f);
    config[18] = a1->f_30;
    config[19] = a1->f_5c >> 1;
    config[20] = (a1->f_60 << 6) | (a1->f_64 << 5) | a1->f_4c;
    config[21] = a1->f_34;
    config[22] = a1->f_40 & 0x7f;
    config[23] = (a1->f_6c << 7) | (a1->f_70 << 6) | (a1->f_74 << 5) | (a1->f_78 << 4) | (a1->f_7c << 3) | (a1->f_80 << 2) | (a1->f_84 << 1)
        | a1->f_88;
    config[24] = a1->f_44;

    if (a1->f_0)
        v14 = 6;
    else
        v14 = 14;
    v18 = a1->f_8;
    if (a1->f_4)
        gfxMode(0x13);
    gfxLoadCrtc(config, v14, v18);

    memset((void*)dpmi_RealToLinear(0xA0000000), 0, 0x10000);
}

void gfxSimpleGraphicsSetup(gfxstruct1_t *a1, unsigned int a2, unsigned int a3, unsigned int a4, unsigned int a5,
    unsigned int a6, unsigned int a7, unsigned int a8, unsigned int a9, unsigned int a10,
    unsigned int a11, unsigned int a12, unsigned int a13, unsigned int a14, unsigned int a15, unsigned int a16)
{
    unsigned int v1;
    a1->f_0 = a15;
    a1->f_4 = a16;

    v1 = 35;
    if (a13 == 360)
        v1 = 39;
    if (a14 == 350 || a14 == 175)
        v1 |= 0x80;
    else if (a14 == 480 || a14 == 240)
        v1 |= 0xc0;
    else
        v1 |= 0x40;

    a1->f_8 = v1;

    if (!a9)
        a9 = 112;
    if (!a10)
        a10 = 532;

    a1->f_c = a9;
    a1->f_10 = (a6 >> 2) - 1;
    a1->f_14 = a1->f_10 + a3;
    a1->f_18 = a11;
    a1->f_1c = a11 + 12;
    a1->f_20 = (a1->f_c - 2) - a2;
    a1->f_24 = 0;
    a1->f_28 = 0;
    a1->f_2c = a10;
    a1->f_30 = a7 - 1;
    a1->f_34 = a1->f_30 + a5;
    a1->f_38 = a12;
    a1->f_3c = a12 + 2;
    a1->f_40 = (a1->f_2c - 2) - a4;
    a1->f_44 = 0x3ff;
    a1->f_48 = 0;
    a1->f_4c = 0;
    a1->f_50 = 0;
    a1->f_54 = 0;
    a1->f_58 = 0;
    a1->f_5c = a8 >> 2;
    a1->f_60 = 1;
    a1->f_64 = 0;
    a1->f_68 = a14 > 240 ? 0 : 1;
    a1->f_6c = 1;
    a1->f_70 = 1;
    a1->f_74 = 1;
    a1->f_78 = 0;
    a1->f_7c = 0;
    a1->f_80 = 0;
    a1->f_84 = 1;
    a1->f_88 = 1;
    a1->f_8c = 0x31;
    a1->f_90 = 0;
    a1->f_94 = 0;
    a1->f_98 = 0;
    a1->f_9c = 0;
    a1->f_a0 = 0;
    a1->f_a4 = 1;
    a1->f_a8 = 1;
}

static void gfxXMODE(unsigned int a1, unsigned int a2, unsigned int a3, unsigned int a4, unsigned int a5,
    unsigned int a6, unsigned int a7, unsigned int a8, unsigned int a9, unsigned int a10,
    unsigned int a11, unsigned int a12, unsigned int a13, unsigned int a14, unsigned int a15)
{
    gfxstruct1_t gfx;
    gfxSimpleGraphicsSetup(&gfx, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15);
    gfxConfig(&gfx);
}

static void ForceVres2(unsigned char a1, unsigned int a2, unsigned int a3, unsigned int a4,
    unsigned int a5, unsigned int a6, unsigned int a7, unsigned int a8)
{
    unsigned char config[25];
    unsigned int v1;
    unsigned int v2;
    unsigned int v5;
    unsigned int v3;
    unsigned int v4;
    v1 = a3 - 1;
    v2 = v1 + a7;
    v3 = a4 + 2;
    v4 = a2 - 2;
    v5 = v4 - a8;

    config[6] = a2 - 2;
    config[7] = ((a4 & 0x200) >> 2) | ((v1 & 0x200) >> 3) | ((v4 & 0x200) >> 4) | ((v2 & 0x100) >> 5)
        | ((a4 & 0x100) >> 6)
        | ((v1 & 0x100) >> 7)
        | ((v4 & 0x100) >> 8);
    config[9] = (a5 << 7) | ((v2 & 0x200) >> 4) | a6;
    config[16] = a4;
    config[17] = v3 & 15;
    config[18] = v1;
    config[21] = v2;
    config[22] = v5;

    gfxVres(a1, config);
}

static void ForceVres350(void)
{
    ForceVres2(167, 420, 350, 370, 0, 0, 0, 0);
}

static void ForceVres400(void)
{
    ForceVres2(99, 432, 400, 408, 0, 0, 0, 0);
}

static int sfVESA(unsigned int a1)
{
    ModeInfo info;
    unsigned int v1;
    unsigned int v2;
    unsigned int v3;
    unsigned int v4;
    unsigned int v5;
    unsigned int v6;
    unsigned int v7;
    unsigned int v8;
    unsigned char v9;
    unsigned int v11;

    v1 = 0;
    v2 = 0;
    if (a1 & 0x8000)
    {
        v1 = 1;
        a1 &= 0x7fff;
    }

    if (a1 == 0xf01)
    {
        if (!vbe_SetSvgaMode(0x101))
            goto FAIL;

        outp(0x3d4, 9);
        outp(0x3d5, 2);
        v2 = 0xa0;
        a1 = 0x101;
    }
    else if (a1 == 0xf00)
    {
        if (!vbe_SetSvgaMode(0x101))
            goto FAIL;
        ForceVres350();
        v2 = 350;
        a1 = 0x101;
    }
    else if (a1)
    {
        if (!vbe_SetSvgaMode(a1))
        {
            if (a1 != 0x100)
                goto FAIL;
            if (!vbe_SetSvgaMode(0x101))
                goto FAIL;
            ForceVres400();
            v2 = 0x190;
            a1 = 0x101;
        }
    }
    else
    {
        if (!vbe_GetVideoMode(&a1))
            goto FAIL;
    }

    if (!vbe_GetModeInfo(a1, &info, &v3, &v4))
        goto FAIL;

    if ((info.WinAAttributes & 5) == 5)
    {
        v5 = 0;
        v6 = v3;
    }
    else if ((info.WinBAttributes & 5) == 5)
    {
        v5 = 1;
        v6 = v4;
    }
    else
    {
        v5 = 0;
        v6 = dpmi_RealToLinear(0xa0000000);
    }
    if (info.ModeAttributes & 2)
    {
        v7 = info.XResolution;
        v8 = info.YResolution;
    }
    else
    {
        switch (a1)
        {
            case 0x100:
                v7 = 640;
                v8 = 400;
                break;
            case 0x101:
                v7 = 640;
                v8 = 480;
                break;
            case 0x102:
            case 0x103:
                v7 = 800;
                v8 = 600;
                break;
            case 0x104:
            case 0x105:
                v7 = 1024;
                v8 = 768;
                break;
            case 0x106:
            case 0x107:
                v7 = 1280;
                v8 = 1024;
                break;
            default:
                goto FAIL;
        }
    }
    if (v2)
        v8 = v2;

    if (v1)
    {
        outp(0x3d4, 9);
        v9 = inp(0x3d5);
        if ((v9 & 0x80) == 0)
        {
            outp(0x3d4, 9);
            outp(0x3d5, v9 | 0x80);
            v8 >>= 1;
        }
    }

    info.WinFuncPtr = (void*)GenWinFuncPtr;
    v11 = (info.ModeAttributes & 2) != 0 && (info.BitsPerPixel == 15 || info.BitsPerPixel == 16);

    MVE_sfSVGA(v7, v8, info.BytesPerScanLine, v5, (void*)v6, info.WinSize << 10, info.WinGranularity << 10, info.WinFuncPtr, v11);

    return 1;

FAIL:
    return 0;
}

unsigned int cdecl MVE_gfxMode(short a1)
{
    switch (a1)
    {
        case -1:
            sf_auto = 1;
            sf_auto_mode = 0;
            return 1;
        case 19:
            gfxConfig(0);
        case -2:
            sfVGA(320, 200, 320, 200);
            return 1;
        case -3:
            gfxXMODE(0, 0, 0, 0, 248, 264, 248, 100, 0, 77, 380, 320, 350, 0, 1);
            sfVGA(248, 264, 320, 350);
            return 1;
        case -4:
            gfxXMODE(0, 0, 0, 0, 224, 288, 224, 0, 0, 77, 400, 360, 480, 0, 1);
            sfVGA(224, 288, 360, 480);
            return 1;
        case -5:
            gfxXMODE(0, 0, 0, 0, 288, 448, 288, 100, 0, 82, 480, 320, 240, 0, 1);
            sfVGA(288, 224, 320, 240);
            return 1;
        case -6:
            if (!sfVESA(0x101))
                return 0;
            sf_ScreenWidth = 320;
            sf_ResolutionWidth = 320;
            gfxXMODE(0, 0, 0, 0, 320, 480, sf_LineWidth, 100, 0, 82, 480, 320, 480, 0, 1);
            return 1;
        case 269:
            return sfVESA(a1) || sfVESA(0x110);
        default:
            return sfVESA(a1);
    }
}

void cdecl MVE_gfxReset(void)
{
    gfxMode(3);
    sf_auto = 1;
    sf_auto_mode = 0;
}

void cdecl MVE_gfxSetDoubleBuffer(unsigned int a1, unsigned int a2, unsigned int a3)
{
    gfx_curpage = a3 & 1;
    gfx_page_y[0] = a1;
    gfx_page_y[1] = a2;
}

void cdecl MVE_gfxGetDoubleBuffer(unsigned int *a1, unsigned int *a2)
{
    *a1 = gfx_page_y[gfx_curpage];
    *a2 = gfx_page_y[gfx_curpage^1];
}

void cdecl MVE_sfAutoDoubleBuffer(unsigned int a1)
{
    sf_auto_dbl = a1;
}

static mve_cb_ctl rm_ctl;
static int rm_dx;
static int rm_dy;
static unsigned int rm_track_bit;
static unsigned int rm_len;
static void* rm_p;

void cdecl MVE_rmCallbacks(mve_cb_ctl a1)
{
    rm_ctl = a1;
}

void cdecl MVE_rmFastMode(unsigned int a1)
{
    opt_fastmode = a1;
}

void cdecl MVE_rmHScale(unsigned int a1)
{
    if (a1 == 3)
        opt_hscale_step = 3;
    else
        opt_hscale_step = 4;
}

static unsigned int rm_FrameCount;
static unsigned int rm_FrameDropCount;

void cdecl MVE_rmFrameCounts(unsigned int *a1, unsigned int *a2)
{
    *a1 = rm_FrameCount;
    *a2 = rm_FrameDropCount;
}


static unsigned int rm_hold = 0;
static unsigned int rm_active = 0;

int cdecl MVE_rmPrepMovie(int a1, unsigned int a2, unsigned int a3, 
    unsigned int a4)
{
    rm_dx = a2;
    rm_dy = a3;

    rm_track_bit = 1 << a4;
    if (rm_track_bit == 0)
        rm_track_bit = 1;

    if (!ioReset(a1))
    {
        MVE_rmEndMovie();
        return -8;
    }

    rm_p = ioNextRecord();
    rm_len = 0;
    if (!rm_p)
    {
        MVE_rmEndMovie();
        return -2;
    }
    rm_active = 1;
    rm_hold = 0;
    rm_FrameCount = 0;
    rm_FrameDropCount = 0;

    return 0;
}

unsigned int cdecl MVE_rmHoldMovie(void)
{
    if (!rm_hold)
    {
        sndPause();
        rm_hold = 1;
    }
    syncWait();
    return 0;
}

typedef struct {
    unsigned short f_0;
    unsigned char f_2;
    unsigned char f_3;
} mvestruct1_t;

typedef struct {
    unsigned int f_0;
    unsigned short f_4;
} mvestruct2_t;

typedef struct {
    unsigned short f_0;
    unsigned short f_2_0 : 1;
    unsigned short f_2_1 : 1;
    unsigned short f_2_2 : 1;
    unsigned short f_4;
    unsigned int f_6;
} mvestruct3_t;

typedef struct {
    unsigned short f_0;
    unsigned short f_2;
    unsigned short f_4;
    unsigned short f_6;
} mvestruct4_t;

typedef struct {
    unsigned char _f_0[4];
    unsigned short f_4;
    unsigned short f_6;
    unsigned short f_8;
    unsigned short f_a;
    unsigned short f_c;
    unsigned char f_e[1];
} mvestruct5_t;

typedef struct {
    unsigned short f_0;
    unsigned short f_2;
    unsigned short f_4;
} mvestruct6_t;

typedef struct {
    unsigned short f_0;
    unsigned short f_2;
    unsigned short f_4;
    unsigned char f_6[1];
} mvestruct7_t;

typedef struct {
    unsigned char _f_0[4];
    unsigned short f_4;
} mvestruct8_t;

typedef struct {
    unsigned char f_0;
    unsigned char f_1;
    unsigned char f_2;
    unsigned char f_3;
    unsigned char f_4;
    unsigned char f_5;
} mvestruct9_t;

typedef struct {
    unsigned short f_0;
    unsigned short f_2;
    unsigned char f_4[1];
} mvestruct10_t;

typedef struct {
    unsigned char _f_0[4];
    unsigned short f_4;
    unsigned short f_6;
    unsigned short f_8;
    unsigned short f_a;
    unsigned short f_c;
    unsigned char f_e[1];
} mvestruct11_t;

typedef struct {
    unsigned char _f_0[4];
    unsigned short f_4;
    unsigned short f_6;
    unsigned short f_8;
    unsigned short f_a;
    unsigned short f_c;
    unsigned char f_e[1];
} mvestruct12_t;


int cdecl MVE_rmStepMovie(void)
{
    unsigned int v2;
    void *v3;
    void *v4;
    int v5;
    unsigned char *v6;
    mvestruct1_t v7;
    unsigned int v8;
    unsigned int v9;
    unsigned int v10;
    unsigned int v11;
    short v12;
    unsigned int v13;
    unsigned int v14;
#if 0
    mvestruct1_t *t1;
    mvestruct2_t *t2;
    mvestruct3_t *t3;
    mvestruct4_t *t4;
    mvestruct5_t *t5;
    mvestruct6_t *t6;
    mvestruct7_t *t7;
    mvestruct8_t *t8;
    mvestruct9_t *t9;
    mvestruct10_t *t10;
    mvestruct11_t *t11;
    mvestruct12_t *t12;
#endif

    v2 = rm_len;
    v6 = rm_p;
    if (!rm_active)
        return -10;

    if (rm_hold)
    {
        sndResume();
        rm_hold = 0;
    }
    while(1)
    {
        v3 = 0; v4 = 0;
        if (v6 == 0)
        {
            v5 = -2;
            goto L1;
        }
L5:
        v6 = v6 + v2;
        v7 = *(mvestruct1_t*)v6;
        v6 = v6 + 4;
        v2 = v7.f_0;
        switch (v7.f_2)
        {
            case 0:
                v5 = -1;
                goto L4;
            case 1:
                v2 = 0, v6 = ioNextRecord();
                break;
            case 2:
            {
                mvestruct2_t *t2 = (mvestruct2_t*)v6;
                if (!syncInit(t2->f_0, t2->f_4))
                {
                    v5 = -3;
                    goto L1;
                }
                goto L5;
            }
            case 3:
            {
                mvestruct3_t *t3 = (mvestruct3_t*)v6;
                v8 = v7.f_3 >= 1 ? t3->f_2_2 : 0;
                v9 = t3->f_6;
                if (v7.f_3 == 0)
                    v9 &= 0xffff;
                if (!sndConfigure(t3->f_0, v9, t3->f_2_0, t3->f_4, t3->f_2_1, v8))
                {
                    v5 = -4;
                    goto L1;
                }
                goto L5;
            }
            case 4:
                sndSync();
                goto L5;
            case 5:
            {
                mvestruct4_t* t4 = (mvestruct4_t*)v6;
                v13 = v7.f_3 >= 2 ? t4->f_6 : 0;
                v14 = v7.f_3 >= 1 ? t4->f_4 : 1;
                if (!nfConfig(t4->f_0, t4->f_2, v14,
                    v13))
                {
                    v5 = -5;
                    goto L1;
                }

                v10 = (nf_width * 4) / opt_hscale_step;
                v10 &= ~15;
                if (nf_hicolor)
                    v10 >>= 1;

                if (v10 + (rm_dx < 0 ? 0 : rm_dx) > sf_ScreenWidth
                    || nf_height + (rm_dy < 0 ? 0 : rm_dy) > sf_ScreenHeight)
                {
                    v5 = -6;
                    goto L1;
                }
                if (nf_hicolor && !sf_hicolor)
                {
                    v5 = -6;
                    goto L1;
                }
                goto L5;
            }
            case 6:
            {
                mvestruct5_t *t5 = (mvestruct5_t*)v6;
                if (t5->f_c & 1)
                    nfAdvance();
                nfDecomp(t5->f_e, t5->f_4, t5->f_6, t5->f_8, t5->f_a);
                goto L5;
            }
            case 7:
            {
                mvestruct6_t* t6 = (mvestruct6_t*)v6;
                v11 = 0;
                rm_FrameCount++;
                if (v7.f_3 >= 1)
                    v11 = t6->f_4;
                if (gfx_page_y[1] == 0 && t6->f_2 && !v3)
                {
                    palClrPalette(t6->f_0, t6->f_2);
                }
                else if (gfx_page_y[1] == 0)
                {
                    palSetPalette(t6->f_0, t6->f_2);
                }
                if (v3)
                {
                    sfShowFrameChg(rm_dx, rm_dy, v3);
                }
                else if (sync_late && !t6->f_2)
                {
                    sync_FrameDropped = 1;
                    rm_FrameDropCount++;
                }
                else
                {
                    sfShowFrame(rm_dx, rm_dy, v11);
                }
                if (gfx_page_y[1] == 0 && t6->f_2 != 0 && v3 == 0)
                {
                    int y = t6->f_0;
                    int x = t6->f_2;
                    palSetPalette(y,x);
                }
                else if (gfx_page_y[1] != 0)
                {
                    if (t6->f_2)
                    {
                        _disable();
                        MVE_gfxWaitRetrace(1);
                        MVE_gfxWaitRetrace(0);
                    }
                    vbe_SetDisplayStart(0, gfx_page_y[gfx_curpage]);
                    if (t6->f_2)
                        MVE_gfxWaitRetrace(1);
                    palSetPalette(t6->f_0, t6->f_2);
                    if (t6->f_2)
                        _enable();
                }

                goto L2;
            }
            case 8:
            case 9:
            {
                mvestruct7_t *t7 = (mvestruct7_t*)v6;
                if (t7->f_2 & rm_track_bit)
                {
                    sndAdd(v7.f_2 == 8 ? t7->f_6 : 0, t7->f_4);
                }
                goto L5;
            }
            case 10:
            {
                mvestruct8_t *t8 = (mvestruct8_t*)v6;
                if (sf_auto)
                {
                    v12 = t8->f_4;
                    if (opt_fastmode && (opt_fastmode & 4) == 0)
                        v12 |= 0x8000;
                    if (v12 != sf_auto_mode)
                    {
                        if (!MVE_gfxMode(v12))
                        {
                            v5 = -7;
                            goto L1;
                        }
                        if (sf_auto_dbl)
                        {
                            MVE_gfxSetDoubleBuffer(0, sf_ResolutionHeight, 0);
                        }
                    }
                    sf_auto = 1;
                    sf_auto_mode = v12;
                }
                goto L5;
            }
            case 11:
            {
                mvestruct9_t *t9 = (mvestruct9_t*)v6;
                palMakeSynthPalette(t9->f_0, t9->f_1, t9->f_2, t9->f_3, t9->f_4, t9->f_5);
                palMakePal15();
                goto L5;
            }
            case 12:
            {
                mvestruct10_t *t10 = (mvestruct10_t*)v6;
                palLoadPalette(t10->f_4, t10->f_0, t10->f_2);
                palMakePal15();
                goto L5;
            }
            case 13:
                palLoadCompPalette(v6);
                palMakePal15();
                goto L5;
            case 14:
                v3 = v6;
                goto L5;
            case 15:
                v4 = v6;
                goto L5;
            case 16:
            {
                mvestruct11_t *t11 = (mvestruct11_t*)v6;
                if (t11->f_c & 1)
                    nfAdvance();
                nfDecompChg(v3, v4, t11->f_e, t11->f_4, t11->f_6, t11->f_8, t11->f_a);
                goto L5;
            }
            case 17:
            {
                mvestruct12_t* t12 = v6;
                if (v7.f_3 < 3)
                {
                    v5 = -8;
                    goto L1;
                }
                if (t12->f_c & 1)
                    nfAdvance();
                if (nf_hicolor)
                {
                    if (opt_fastmode)
                    {
                        v5 = -8;
                        goto L1;
                    }

                    nfHPkDecomp(v4, t12->f_e, t12->f_4, t12->f_6, t12->f_8, t12->f_a);
                }
                else if ((opt_fastmode & 3) == 1)
                {
                    nfPkDecompH(v4, t12->f_e, t12->f_4, t12->f_6, t12->f_8, t12->f_a);
                }
                else if ((opt_fastmode & 3) == 2)
                {
                    nfPkDecompH(v4, t12->f_e, t12->f_4, t12->f_6, t12->f_8, t12->f_a);
                }
                else
                {
                    nfPkDecomp(v4, t12->f_e, t12->f_4, t12->f_6, t12->f_8, t12->f_a);
                }
                goto L5;
            }
            default:
                goto L5;
        }
    }
L1:
    MVE_rmEndMovie();
L4:
    return v5;
L2:
    rm_p = v6;
    rm_len = v2;
    return 0;
}

void cdecl MVE_rmEndMovie(void)
{
    if (!rm_active)
        return;
    syncWait();
    syncRelease();
    sndReset();
    rm_active = 0;
}

int cdecl MVE_RunMovie(int a1, unsigned int a2, unsigned int a3,
    unsigned int a4)
{
    int ret = MVE_rmPrepMovie(a1, a2, a3, a4);
    if (!ret)
    {
        do
        {
            ret = MVE_rmStepMovie();
            if (ret == 0)
            {
                do
                {
                    ret = rm_ctl();
                    if (ret != -1)
                        break;
                    ret = MVE_rmHoldMovie();
                } while (ret == 0);
            }
        } while (ret == 0);
    }
    MVE_rmEndMovie();
    if (ret == -1)
        ret = 0;
    return ret;
}

int cdecl MVE_RunMovieContinue(int a1, unsigned int a2, unsigned int a3,
    unsigned int a4)
{
    int ret = MVE_rmPrepMovie(a1, a2, a3, a4);
    if (!ret)
    {
        do
        {
            ret = MVE_rmStepMovie();
            if (ret == 0)
            {
                do
                {
                    ret = rm_ctl();
                    if (ret != -1)
                        break;
                    ret = MVE_rmHoldMovie();
                } while (ret == 0);
            }
        } while (ret == 0);
    }
    if (ret == -1)
        ret = 0;
    return ret;
}

void cdecl MVE_ReleaseMem(void)
{
    MVE_rmEndMovie();
    ioRelease();
    sndRelease();
    nfRelease();
}

char* cdecl MVE_strerror(int a1)
{
    char *MovieErrors[] = {
        "Movie aborted with special code",
        "Movie aborted",
        "Movie completed normally",
        "Movie completed normally",
        "File I/O error or Unable to allocate I/O buffers",
        "Unable to create timer",
        "Unable to allocate sound buffers",
        "Unable to allocate video buffers",
        "Insufficient screen resolution for movie",
        "Unable to setup graphics mode used by movie",
        "Invalid movie file",
        "Incorrect screen color mode",
        "StepMovie() without PrepMovie()",
        "Unknown movie error code"
    };

    if (a1 >= 2)
        a1 = 2;
    if (a1 <= -11)
        a1 = -11;
    return MovieErrors[2 - a1];
}

static void frLoad(loadsave_t *a1)
{
    io_read = a1->f_4;
    io_mem_buf = a1->f_8;
    io_handle = a1->f_18;
    io_next_hdr = a1->f_1c;
    nf_mem_buf1 = a1->f_28;
    nf_mem_buf2 = a1->f_38;
    nf_buf_cur = a1->f_48;
    nf_buf_prv = a1->f_4c;
    nf_wqty = a1->f_50;
    nf_hqty = a1->f_51;
    nf_fqty = a1->f_52;
    nf_hicolor = a1->f_54;
    nf_width = a1->f_58;
    nf_height = a1->f_5c;
    nf_new_line = a1->f_60;
    nf_new_row0 = a1->f_64;
    nf_back_right = a1->f_68;
}

static void frSave(loadsave_t *a1)
{
    a1->f_4 = io_read;
    a1->f_8 = io_mem_buf;
    a1->f_18 = io_handle;
    a1->f_1c = io_next_hdr;
    a1->f_28 = nf_mem_buf1;
    a1->f_38 = nf_mem_buf2;
    a1->f_48 = nf_buf_cur;
    a1->f_4c = nf_buf_prv;
    a1->f_50 = nf_wqty;
    a1->f_51 = nf_hqty;
    a1->f_52 = nf_fqty;
    a1->f_54 = nf_hicolor;
    a1->f_58 = nf_width;
    a1->f_5c = nf_height;
    a1->f_60 = nf_new_line;
    a1->f_64 = nf_new_row0;
    a1->f_68 = nf_back_right;
}

void * cdecl MVE_frOpen(mve_cb_read a1, int a2, mve_cb_fr a3)
{
    loadsave_t *ls;
    loadsave_t ls2;
    unsigned int ret;
    if (!mem_alloc)
        return 0;

    ls = mem_alloc(sizeof(loadsave_t));
    if (!ls)
        return 0;
    memset(ls, 0, sizeof(loadsave_t));
    frSave(&ls2);
    frLoad(ls);
    io_read = a1;
    ret = ioReset(a2) == 0;
    ls->f_0 = a3;
    if (!ret)
    {
        ls->f_20 = ioNextRecord();
        ls->f_24 = 0;
    }
    frSave(ls);
    frLoad(&ls2);
    if (ret)
    {
        MVE_frClose(ls);
        return NULL;
    }
    return ls;
}

int cdecl MVE_frGet(loadsave_t *ls, void **a2, unsigned int *a3, unsigned int *a4)
{
    unsigned int v2;
    void *v4;
    int v5;
    mvestruct1_t v7;
    loadsave_t ls2;
    unsigned int v11;
    unsigned int v13;
    unsigned int v14;
    unsigned int v8;
    mvestruct4_t* t4;
    mvestruct6_t* t6;
    mvestruct12_t* t12;
    unsigned char *v6;

    frSave(&ls2);
    frLoad(ls);

    v6 = ls->f_20;
    v2 = ls->f_24;
    v5 = 0;

    for (; 1; v6 = ioNextRecord(), v2 = 0)
    {
        v4 = 0;
        if (!v6)
        {
            v5 = -2;
            goto L1;
        }
L5:
        v6 = v6 + v2;
        v7 = *(mvestruct1_t*)v6;
        v6 = v6 + 4;
        v2 = v7.f_0;
        switch (v7.f_2)
        {
            default:
                if (ls->f_0)
                {
                    v5 = ls->f_0(v7.f_2, v7.f_3, v6);
                    if (v5)
                    {
                        goto L1;
                    }
                }
                goto L5;
            case 0:
                v5 = -1;
                goto L1;
            case 5:
                t4 = (mvestruct4_t*)v6;
                v13 = v7.f_3 >= 2 ? t4->f_6 : 0;
                v8 = opt_fastmode;
                opt_fastmode = 0;
                if (v13 || !nfConfig(t4->f_0, t4->f_2, v7.f_3 >= 1 ? t4->f_4 : 1, v13))
                {
                    opt_fastmode = v8;
                    v5 = -5;
                    goto L1;
                }
                opt_fastmode = v8;
                goto L5;
            case 7:
                t6 = (mvestruct6_t*)v6;
                v11 = 0;
                if (v7.f_3 >= 1)
                    v11 = t6->f_4;
                if (v11)
                {
                    v5 = -8;
                    goto L1;
                }
                *a2 = nf_buf_cur;
                *a3 = nf_width;
                *a4 = nf_height;
                goto L1;
            case 15:
                v4 = v6;
                goto L5;
            case 17:
                t12 = (mvestruct12_t*)v6;
                if (v7.f_3 < 3)
                {
                    v5 = -8;
                    goto L1;
                }
                if (t12->f_c & 1)
                    nfAdvance();
                if (nf_hicolor)
                {
                    v5 = -8;
                    goto L1;
                }
                else
                {
                    nfPkConfig();
                    nfPkDecomp(v4, t12->f_e, t12->f_4, t12->f_6, t12->f_8, t12->f_a);
                }
                goto L5;
            case 1:
                break;
        }
    }

L1:
    frSave(ls);
    ls->f_20 = v6;
    ls->f_24 = v2;
    frLoad(&ls2);
    nfPkConfig();
    return v5;
}

void cdecl MVE_frClose(loadsave_t *ls)
{
    loadsave_t ls2;
    frSave(&ls2);
    frLoad(ls);
    ioRelease();
    nfRelease();
    frLoad(&ls2);
    if (mem_free)
        mem_free(ls);
}
