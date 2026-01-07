#ifndef _MVELIB32_H_
#define _MVELIB32_H_

typedef void* cdecl (*mve_cb_alloc)(unsigned int a1);
typedef void cdecl (*mve_cb_free)(void *a1);
typedef unsigned int cdecl (*mve_cb_read)(int a1, void *a2, unsigned int a3);
typedef void cdecl (*mve_cb_SoundHook)(unsigned char *a1, unsigned int a2, unsigned int a3, unsigned int a4);
typedef void cdecl (*mve_cb_ShowFrame)(unsigned char *a1, unsigned int a2, unsigned int a3, unsigned int a4, unsigned int a5, unsigned int a6, unsigned int a7, unsigned int a8, unsigned int a9);
typedef void cdecl (*mve_cb_SetPalette)(unsigned char *a1, unsigned int a2, unsigned int a3);
typedef int cdecl (*mve_cb_ctl)(void);

typedef int cdecl (*mve_cb_fr)(unsigned int a1, unsigned int a2, void *a3);

typedef struct {
    void *f_0;
    unsigned int f_4;
    unsigned int f_8;
    unsigned int f_c;
} memstruct_t;

typedef struct {
    mve_cb_fr f_0;
    mve_cb_read f_4;
    memstruct_t f_8;
    int f_18;
    unsigned int f_1c;
    void *f_20;
    unsigned int f_24;
    memstruct_t f_28;
    memstruct_t f_38;
    void *f_48;
    void *f_4c;
    unsigned char f_50;
    unsigned char f_51;
    unsigned char f_52;
    unsigned char _f_53[1];
    unsigned int f_54;
    unsigned int f_58;
    unsigned int f_5c;
    unsigned int f_60;
    unsigned int f_64;
    unsigned int f_68;
} loadsave_t;

void cdecl MVE_memCallbacks(mve_cb_alloc a1, mve_cb_free a2);
void cdecl MVE_logDumpStats(void);
void cdecl MVE_ioCallbacks(mve_cb_read a1);
void cdecl MVE_memIO(void* a1, unsigned int a2);
void cdecl MVE_AIL_sndInit(void);
void cdecl MVE_SOS_sndInit(int a1);
unsigned int cdecl MVE_sndVolume(unsigned int a1);
void cdecl MVE_rmemSND(void);
void cdecl MVE_memVID(void *a1, void *a2, unsigned int a3);
void cdecl MVE_sfSVGA(unsigned int a1, unsigned int a2, unsigned int a3, unsigned int a4, void* a5, unsigned int a6, unsigned int a7,
    unsigned int cdecl (*a8)(void), unsigned int a9);
void cdecl MVE_sfCallbacks(mve_cb_ShowFrame a1);
void cdecl MVE_ShowFrame(void *a1, unsigned int a2, unsigned int a3, unsigned int a4, unsigned int a5, unsigned int a6, unsigned int a7, unsigned int a8, unsigned int a9);
void cdecl MVE_palCallbacks(mve_cb_SetPalette a2);
unsigned int cdecl MVE_gfxMode(short a1);
void cdecl MVE_gfxReset(void);
void cdecl MVE_gfxSetDoubleBuffer(unsigned int a1, unsigned int a2, unsigned int a3);
void cdecl MVE_gfxGetDoubleBuffer(unsigned int *a1, unsigned int *a2);
void cdecl MVE_sfAutoDoubleBuffer(unsigned int a1);
void cdecl MVE_rmCallbacks(mve_cb_ctl a1);
void cdecl MVE_rmFastMode(unsigned int a1);
void cdecl MVE_rmHScale(unsigned int a1);
void cdecl MVE_rmFrameCounts(unsigned int *a1, unsigned int *a2);
int cdecl MVE_rmPrepMovie(int a1, unsigned int a2, unsigned int a3,
    unsigned int a4);
unsigned int cdecl MVE_rmHoldMovie(void);
int cdecl MVE_rmStepMovie(void);
void cdecl MVE_rmEndMovie(void);
int cdecl MVE_RunMovie(int a1, unsigned int a2, unsigned int a3,
    unsigned int a4);
int cdecl MVE_RunMovieContinue(int a1, unsigned int a2, unsigned int a3,
    unsigned int a4);
void cdecl MVE_ReleaseMem(void);
char* cdecl MVE_strerror(int a1);
void * cdecl MVE_frOpen(mve_cb_read a1, int a2, mve_cb_fr a3);
int cdecl MVE_frGet(loadsave_t *ls, void **a2, unsigned int *a3, unsigned int *a4);
void cdecl MVE_frClose(loadsave_t *a1);

#endif // !_MVELIB32_H_
