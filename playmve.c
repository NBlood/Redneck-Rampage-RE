#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dos.h>
#include "mvelib32.h"
#include "sos.h"

_SOS_DIGI_DRIVER sosDriver;

int dword_32D3A0[32]; // fixme
int blaster[8]; // fixme

int dword_11A82C = 0;
HANDLE dword_11A830 = -1;
HANDLE dword_11A834 = -1;

char *cardlist[] = {
    "SB",
    "SBPro",
    "SBProMono",
    "SB16",
    "SB16Mono",
    "SB16-16",
    "SB16Mono-16",
    "PAS",
    "PASMono",
    "PAS-16",
    "PASMono-16",
    "AdlibGold",
    "AdlibGoldMono",
    "AdlibGold-16",
    "AdlibGoldMono-16",
    "Yamaha",
    "Microsoft",
    "MicrosoftMono",
    "Microsoft-16",
    "MicrosoftMono-16",
    "AudioDrive",
    "AudioDriveMono",
    "AudioDrive-16",
    "AudioDriveMono-16",
    "SoundScape",
    "SoundScapeMono",
    "SoundScape-16",
    "SoundScapeMono-16",
    "Gus",
    "GusMono",
    "Gus-16",
    "GusMono-16",
    "GusMax",
    "GusMaxMono",
    "GusMax-16",
    "GusMaxMono-16",
    "WaveJammer",
    "WaveJammerMono",
    "WaveJammer-16",
    "WaveJammerMono-16",
    "Tempocs",
    "TempocsMono",
    "Tempocs-16",
    "TempocsMono-16"
};

unsigned short cardid[] = {
    _SOUND_BLASTER_8_MONO,
    _SOUND_BLASTER_8_ST,
    _SBPRO_8_MONO,
    _SB16_8_ST,
    _SB16_8_MONO,
    _SB16_16_ST,
    _SB16_16_MONO,
    _MV_PAS_8_ST,
    _MV_PAS_8_MONO,
    _MV_PAS_16_ST,
    _MV_PAS_16_MONO,
    _ADLIB_GOLD_8_ST,
    _ADLIB_GOLD_8_MONO,
    _ADLIB_GOLD_16_ST,
    _ADLIB_GOLD_16_MONO,
    _YAMAHA_8_MONO,
    _MICROSOFT_8_ST,
    _MICROSOFT_8_MONO,
    _MICROSOFT_16_ST,
    _MICROSOFT_16_MONO,
    _ESS_AUDIODRIVE_8_ST,
    _ESS_AUDIODRIVE_8_MONO,
    _ESS_AUDIODRIVE_16_ST,
    _ESS_AUDIODRIVE_16_MONO,
    _SOUNDSCAPE_8_ST,
    _SOUNDSCAPE_8_MONO,
    _SOUNDSCAPE_16_ST,
    _SOUNDSCAPE_16_MONO,
    _GUS_8_ST,
    _GUS_8_MONO,
    _GUS_16_ST,
    _GUS_16_MONO,
    _GUS_MAX_8_ST,
    _GUS_MAX_8_MONO,
    _GUS_MAX_16_ST,
    _GUS_MAX_16_MONO,
    _WAVEJAMMER_8_ST,
    _WAVEJAMMER_8_MONO,
    _WAVEJAMMER_16_ST,
    _WAVEJAMMER_16_MONO,
    _TEMPOCS_8_ST,
    _TEMPOCS_8_MONO,
    _TEMPOCS_16_ST,
    _TEMPOCS_16_MONO
};

int dword_11A940 = 1;
int dword_11A944 = 1;

void * cdecl func_A8570(unsigned int a1)
{
    return malloc(a1);
}

void cdecl func_A8594(void* a1)
{
    free(a1);
}

void func_A85B0(unsigned short a1, unsigned short a2, unsigned short a3)
{
    blaster[0] = a1;
    blaster[2] = a2;
    blaster[4] = a3;
}

unsigned short func_A85F0(char *a1)
{
    int i;
    int v8;
    char *vc;
    if (!*a1)
        return 0xffff;

    v8 = strtol(a1, &vc, 0);
    if (!*vc)
        return v8;

    for (i = 0; i < 44; ++i)
    {
        if (!strcmpi(a1, cardlist[i]))
        {
            return cardid[i];
        }
    }

    return 0xffff;
}

void func_A8688(void)
{
    int i;
    for (i = 0; i < 44; ++i)
    {
        printf("%s ", cardlist[i]);
    }
    exit(1);
}

void func_A86DC(char *a1, char *a2)
{
    unsigned short v1;
    unsigned short v2;

    sosDriver.wDriverRate = 22050;
    sosDriver.wDMABufferSize = 8192;

    v1 = func_A85F0(a1);

    sosTIMERInitSystem(_TIMER_DOS_RATE, 0);
    if (v1 == 0xffff)
    {
        dword_11A830 = -1;
        MVE_SOS_sndInit(-1);
        return;
    }

    v2 = sosDIGIDetectInit(a2);
    if (v2)
    {
        printf("Error: %s", sosGetErrorString(v2));
        exit(1);
    }
    if (v1 == 0)
        v2 = sosDIGIDetectFindFirst(&sosDriver);
    else
        v2 = sosDIGIDetectFindHardware(v1, &sosDriver);
    if (v2)
    {
        printf("Error: %s", sosGetErrorString(v2));
        sosDIGIDetectUnInit();
        exit(1);
    }
    sosDriver.sHardware.wPort = blaster[0];
    sosDriver.sHardware.wIRQ = blaster[2];
    sosDriver.sHardware.wDMA = blaster[4];
    sosDriver.sHardware.wParam = -1;
    if (v2)
    {
        printf("Error: %s", sosGetErrorString(v2));
        sosDIGIDetectUnInit();
        exit(1);
    }
    sosDIGIDetectUnInit();
    sosDIGIInitSystem(a2, 0);
    v2 = sosDIGIInitDriver(&sosDriver, &dword_11A830);
    if (v2)
    {
        printf("Error: %s", sosGetErrorString(v2));
        dword_11A830 = -1;
        exit(1);
    }
    v2 = sosTIMERRegisterEvent(120, sosDriver.pfnMixFunction, &dword_11A834);
    if (v2)
    {
        printf("Error: %s", sosGetErrorString(v2));
        dword_11A834 = -1;
        exit(1);
    }
    MVE_SOS_sndInit(dword_11A830);
}

void func_A88DC(void)
{
    if (dword_11A834 != -1)
        sosTIMERRemoveEvent(dword_11A834);
    sosTIMERUnInitSystem(0);
    if (dword_11A830 != -1)
    {
        sosDIGIUnInitDriver(dword_11A830, 1, 1);
        sosDIGIUnInitSystem();
    }
}


unsigned int cdecl func_A8930(int a1, void *a2, unsigned int a3)
{
    unsigned int v2;
    int v1;
    v1 = _dos_read(a1, a2, a3, &v2);

    if (v1 || v2 != a3)
        return 0;
    return 1;
}

int cdecl func_A8984(void)
{
    static int dword_11A948 = 0;
    if (kbhit())
    {
        getch();
        return 1;
    }
    ++dword_11A948;
    return 0;
}

extern int FXDevice;

void playmve(char *a1, char *a2, char a3)
{
    static int dword_11A94C = 0;
    int v1;
    int v2;
    char drive[4];
    char dir[132];
    char buf[144];
    if (_dos_open(a1, 512, &v1))
        return;

    MVE_memCallbacks(func_A8570, func_A8594);
    _splitpath(a1, drive, dir, NULL, NULL);
    strcpy(buf, drive);
    strcat(buf, dir);

    if (!dword_11A94C)
    {
        switch (FXDevice)
        {
            case 0:
                func_A86DC("SB", buf);
                break;
            case 6:
                func_A86DC("SB16-16", buf);
                break;
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
            default:
                func_A86DC("", buf);
                break;
        }

        dword_11A94C = 1;
    }

    MVE_ioCallbacks(func_A8930);
    MVE_rmCallbacks(func_A8984);

    dword_32D3A0[4] = 0;

    v2 = MVE_RunMovie(v1, -1, -1, 0);
    MVE_ReleaseMem();
    if (a3)
        func_A88DC();
    _dos_close(v1);
}
