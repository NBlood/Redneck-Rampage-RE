#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <dos.h>
#include <i86.h>
#include <fcntl.h>
#include <io.h>
#include <sys\stat.h>
#include <sys\types.h>
#include "sosm.h"


VOID sosMIDICode5Start(VOID) {}

LPSTR cdecl far sosDIGIGetCallTable(VOID)
{
    return _lpMIDIDIGIFunctions;
}

W32 cdecl far sosDIGISendData(LPSTR a1, W32 a2, W32 a3)
{
    WORD v4;
    WORD v8;
    WORD vc;
    WORD v10;
    WORD v14;
    WORD v18;
    WORD v1c;
    WORD v20;
    _SOS_SAMPLE *v24;
    _MIDI_DIGI_SYSTEM* v28;
    int v2c;
    v28 = &_sSOSMIDIDIGIDriver[a3];

    v1c = v28->hDIGIDriver;
    v20 = v28->hQueue;

    v18 = a1[0];
    v8 = a1[1];
    vc = a1[2];

    v14 = v18 & 15;
    switch (v18 & 0xf0)
    {
        case 0x90:
            if (!v28->psPatchList[v8].pPatchData)
            {
                v8 = v28->sPatchHeader.dwDefaultTriggeredPatch;
                if (v8 == 0xff)
                    return 0;
            }
            v24 = &v28->psPatchList[v8].sSample;
            if (vc)
            {
                if (!v24->wUser[10])
                {
                    v4 = digiQueueDeleteItemMIDI(a3, v8, v14);
                    if (v4 != 0xffff)
                        sosDIGIStopSample(v1c, v4);
                }
                if (_sSOSMIDIDIGIQueue[v20].wUsedVoices >= _sSOSMIDIDIGIQueue[v20].wMaxVoices)
                {
                    v4 = digiQueueGetItem(a3, v14);
                    if (v4 != 0xffff)
                        sosDIGIStopSample(v1c, v4);
                }
                if ((v28->wFlags & 4) == 0)
                {
                    v2c = (v28->wVolume * vc) * 2;
                    v24->wVolume = ((short)v2c << 16) | (short)v2c;
                }
                v24->wUser[11] = v8;
                if (((DWORD)v28->wPanPosition & ~0x7fff) == 0)
                {
                    v24->wPanPosition = (DWORD)v28->wPanPosition << 9;
                }
                v4 = sosDIGIStartSample(v1c, v24);
                if (v4 != 0xffffffff)
                    digiQueueAddItem(a3, v4, v24->wUser[11], vc, v14);
            }
            else
            {
                if (!v24->wUser[10])
                {
                    v4 = digiQueueDeleteItemMIDI(a3, v8, v14);
                    if (v4 != 0xffff)
                        sosDIGIStopSample(v1c, v4);
                }
            }
            break;
        case 0x80:
            if (!v28->psPatchList[v8].pPatchData)
            {
                v8 = v28->sPatchHeader.dwDefaultTriggeredPatch;
                if (v8 == 0xff)
                    return 0;
            }
            if (v28->psPatchList[v8].pPatchData)
            {
                v24 = &v28->psPatchList[v8].sSample;
                if (!v24->wUser[10])
                {
                    v4 = digiQueueDeleteItemMIDI(a3, v8, v14);
                    if (v4 != 0xffff)
                        sosDIGIStopSample(v1c, v4);
                }
            }
            break;
        case 0xb0:
            switch (v8)
            {
                case 0x7b:
                    while (1)
                    {
                        v4 = digiQueueGetItem(a3, v14);
                        if (v4 == 0xffff)
                            break;
                        sosDIGIStopSample(v1c, v4);
                    }
                    break;
                case 7:
                    v28->wVolume = vc;
                    v10 = _sSOSMIDIDIGIQueue[v20].wTail;
                    while (v10 != _sSOSMIDIDIGIQueue[v20].wHead)
                    {
                        if (_sSOSMIDIDIGIQueue[v20].sElement[v10].hSample != 0xffff)
                        {
                            v2c = (vc * _sSOSMIDIDIGIQueue[v20].sElement[v10].wVelocity) * 2;
                            sosDIGISetSampleVolume(v1c, _sSOSMIDIDIGIQueue[v20].sElement[v10].hSample, ((short)v2c << 16) | (short)v2c);
                        }
                        ++v10;
                        v10 &= 31;
                    }
                    break;
                case 10:
                    v28->wPanPosition = vc;
                    v10 = _sSOSMIDIDIGIQueue[v20].wTail;
                    while (v10 != _sSOSMIDIDIGIQueue[v20].wHead)
                    {
                        sosDIGISetPanLocation(v1c, _sSOSMIDIDIGIQueue[v20].sElement[v10].hSample, (WORD)(vc << 9));
                        ++v10;
                        v10 &= 31;
                    }
                    break;
            }
            break;
    }
    return 0;
}

W32 cdecl far sosDIGIInit(LPSTR a1, W32 a2, W32 a3)
{
    WORD far *vc = a1;
    if ((_sSOSSystem.pDriver[vc[2]]->wFlags & 1) == 0)
        return 1;
    

    _sSOSMIDIDIGIDriver[a2].hQueue = digiQueueInit(vc[1]);
    _sSOSMIDIDIGIDriver[a2].hDIGIDriver = vc[2];
    _sSOSMIDIDIGIDriver[a2].wPanPosition |= 0x8000;
    _sSOSMIDIDIGIDriver[a2].wFlags = vc[0];
    _sSOSMIDIDIGIDriver[a2].wFlags |= 2;
    return 0;
}

W32 cdecl far sosDIGIUnInit(LPSTR a1, W32 a2, W32 a3)
{
    digiQueueUnInit(_sSOSMIDIDIGIDriver[a2].hQueue);
    return 0;
}

W32 cdecl far sosDIGIReset(LPSTR a1, W32 a2, W32 a3)
{
    WORD v4 = _sSOSMIDIDIGIQueue[_sSOSMIDIDIGIDriver[a2].hQueue].wMaxVoices;
    digiQueueUnInit(_sSOSMIDIDIGIDriver[a2].hQueue);
    _sSOSMIDIDIGIDriver[a2].hQueue = digiQueueInit(v4);
    return 0;
}

W32 cdecl far sosDIGISetInstrumentData(LPSTR a1, W32 a2, W32 a3)
{
    return 0;
}

VOID cdecl sosMIDIDIGISampleDoneCallback(PSOSSAMPLE a1)
{
    digiQueueDeleteItem(_sSOSMIDIDIGIDriver[a1->wUser[12]].hQueue, a1->hSample);
}

DWORD sosMIDISetDigitalPatchFile(HSOS a1, PSTR a2)
{
    int vc;
    char unk[0x4dc];
    _MIDI_DIGI_SYSTEM *v14;
    
    v14 = &_sSOSMIDIDIGIDriver[a1];

    vc = open(a2, 0x200);
    if (vc != -1)
    {
        read(vc, &v14->sPatchHeader, sizeof(_SOS_DIGI_PATCH_FILE_HEADER)); 
        if (strncmp(&v14->sPatchHeader.szFileID, _SOS_DIGITAL_PATCH_FILE_ID,
            strlen(_SOS_DIGITAL_PATCH_FILE_ID)))
        {
            close(vc);
            return 14;
        }
        if (v14->wFlags & 2)
        {
            if (!v14->sPatchHeader.dwTotalTriggeredPatches)
            {
                close(vc);
                return 14;
            }
        }
        else
        {
            if (!v14->sPatchHeader.dwTotalWavetablePatches)
            {
                close(vc);
                return 14;
            }
        }
        close(vc);
        strcpy(v14->szPatchFile, a2);

        if ((v14->psPatchList = sosAlloc(0xc900)) == 0)
            return 5;

        memset(v14->psPatchList, 0, 0xc900);

        return 0;
    }
    return 14;
}

DWORD sosMIDIReleaseDigitalPatchFile(HSOS a1)
{
    WORD v4;
    _MIDI_DIGI_SYSTEM *v10;
    
    v10 = &_sSOSMIDIDIGIDriver[a1];

    if (!v10->psPatchList)
        return 10;
    for (v4 = 0; v4 < 128; v4++)
    {
        if (v10->psPatchList[v4].pPatchData)
        {
            sosFree(v10->psPatchList[v4].pPatchData,
                v10->psPatchList[v4].sTriggeredPatch.dwPatchDataSize);
        }
    }
    return 0;
}

DWORD sosMIDIFlushTriggeredPatches(HSOS a1, PTRACK a2)
{
    WORD v4;
    _MIDI_DIGI_SYSTEM *vc;

    vc = &_sSOSMIDIDIGIDriver[a1];
    for (v4 = 0; v4 < 128; v4++)
    {
        if (a2->dwDrumInsUsed[v4 / 32] & (1 << (v4 - (v4 / 32) * 32)))
        {
            if (vc->psPatchList[v4].pPatchData)
            {
                if (--*(DWORD*)vc->psPatchList[v4].pPatchData == 0)
                {
                    sosFree(vc->psPatchList[v4].pPatchData,
                        vc->psPatchList[v4].sTriggeredPatch.dwPatchDataSize);
                }
                if (--vc->psPatchList[v4].wOwners == 0)
                {
                    vc->psPatchList[v4].pPatchData = NULL;
                }
            }
        }
    }
    return 0;
}

DWORD sosMIDILoadTriggeredPatches(HSOS a1, PTRACK a2)
{
    _SOS_DIGI_TRIGGERED_PATCH *v24;
    int v18;
    _MIDI_DIGI_SYSTEM *v10;
    _SOS_SAMPLE *v14;
    WORD v4;
    WORD v8;
    

    v10 = &_sSOSMIDIDIGIDriver[a1];

    if (!v10->psPatchList)
        return _ERR_INVALID_HANDLE;

    v18 = open(v10->szPatchFile, 0x200);
    if (v18 == -1)
        return _ERR_INVALID_DATA;

    v8 = v10->sPatchHeader.dwDefaultTriggeredPatch;
    if (v8 != 0xff)
    {
        a2->dwDrumInsUsed[v8 / 32] |= 1 << (v8 - (v8 / 32) * 32);
    }

    for (v4 = 0; v4 < 128; v4++)
    {
        if (a2->dwDrumInsUsed[v4 / 32] & (1 << (v4 - (v4 / 32) * 32)))
        {
            if (!v10->psPatchList[v4].pPatchData)
            {
                if (v10->sPatchHeader.dwTriggeredPatchHeaders[v4])
                {
                    if (!v10->sPatchHeader.dwTriggeredOffset)
                    {
                        close(v18);
                        return _ERR_INVALID_DATA;
                    }
                    lseek(v18, v10->sPatchHeader.dwTriggeredPatchHeaders[v4], SEEK_SET);
                    read(v18, &v10->psPatchList[v4].sTriggeredPatch, 0x9c);
                    if (!v10->psPatchList[v4].sTriggeredPatch.dwPatchDataOffset)
                    {
                        close(v18);
                        return _ERR_INVALID_DATA;
                    }
                    if ((v10->psPatchList[v4].pPatchData = sosAlloc(v10->psPatchList[v4].sTriggeredPatch.dwPatchDataSize + 4)) == 0)
                    {
                        close(v18);
                        return _ERR_MEMORY_FAIL;
                    }
                    lseek(v18, v10->psPatchList[v4].sTriggeredPatch.dwPatchDataOffset, SEEK_SET);
                    read(v18, v10->psPatchList[v4].pPatchData + 4, v10->psPatchList[v4].sTriggeredPatch.dwPatchDataSize);
                    *(DWORD*)v10->psPatchList[v4].pPatchData = 1;
                    v10->psPatchList[v4].wOwners = 1;
                    v14 = &v10->psPatchList[v4].sSample;
                    v24 = &v10->psPatchList[v4].sTriggeredPatch;

                    v14->pSample = v10->psPatchList[v4].pPatchData;
                    v14->wLength = v10->psPatchList[v4].sTriggeredPatch.dwPatchDataSize;
                    v14->wVolume = 0x7fff7fff;
                    v14->wRate = v24->dwSampleRate;
                    v14->wBitsPerSample = v24->wBitsPerSample;
                    v14->wChannels = v24->wChannels;
                    v14->wFormat = v24->wDCOffset;
                    v14->wPanPosition = v24->dwPanPosition;
                    v14->pfnSampleDone = sosMIDIDIGISampleDoneCallback;
                    v14->wUser[10] = v24->wFlags & 0x1000;
                    v14->wUser[12] = a1;
                }
            }
            else
            {
                ++*(DWORD*)v10->psPatchList[v4].pPatchData;
                ++v10->psPatchList[v4].wOwners;
            }
        }
    }
    close(v18);
    if (v8 != 0xff)
    {
        if (!v10->psPatchList[v8].pPatchData)
        {
            v10->sPatchHeader.dwDefaultTriggeredPatch = 0xff;
        }
    }
    return _ERR_NO_ERROR;
}

VOID sosMIDICode5End(VOID) {}
