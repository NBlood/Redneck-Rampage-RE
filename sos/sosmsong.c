#include <stdlib.h>
#include <string.h>
#include "sosm.h"

VOID sosMIDICode18Start(VOID) {}

W32 sosMIDIInitSong(PSOSMIDISONG a1, HANDLE* a2)
{
    DWORD v4;
    DWORD v8;
    PTRACK vc;
    _MIDI_SONG *v10;
    DWORD v14;

    v10 = a1->pSong;

    if (strcmp(v10->szHMIChunk, _MIDI_SONG_CHUNK))
    {
        return 14;
    }

    for (v4 = 0; v4 < 32; v4++)
    {
        if (!_sMIDISystem.pSongList[v4])
            break;
    }

    if (v4 == 32)
        return 11;

    v8 = v4;

    memcpy(&v10->sInit, a1, 32);

    _sMIDISystem.pSongList[v8] = v10;

    v10->pfnSongCallback = a1->pfnSongCallback;
    v10->hSong = v8;

    v10->hEvent = -1;
    v10->sVolume.wVolume = 127;
    v10->sVolume.wFlags = 0;
    if ((v10->wFlags & 0x4000) == 0)
    {
        v10->pPatchNames = (DWORD)v10 + (BYTE*)v10->pPatchNames;
        v10->pDependencyPtrs = (DWORD)v10 + (BYTE*)v10->pDependencyPtrs;
        v10->pTempoChangeList = (DWORD)v10 + (BYTE*)v10->pTempoChangeList;
        v10->pTimeChangeList = (DWORD)v10 + (BYTE*)v10->pTimeChangeList;
        v10->pTrackList = (DWORD)v10 + (BYTE*)v10->pTrackList;
    }

    v10->dwTotalTicks = 0;
    v10->dwGlobalTicks = 0;
    v10->wActiveTracks = 0;
    v10->pTrackFirst = 0;
    v10->pTrackLast = 0;

    for (v4 = 0; v4 < v10->wTotalTracks; v4++)
    {
        if ((v10->wFlags & 0x4000) == 0)
        {
            v10->pTrackList[v4] = (DWORD)v10->pTrackList[v4] + (BYTE*)v10;
        }

        vc = v10->pTrackList[v4];
        if (!sosMIDIInitTrack(v10, vc))
        {
            v10->wActiveTracks++;
            sosMIDIAddTrack(v10, vc);
        }
        else
            vc->wFlags &= ~0x8000;
    }
    if (v10->wActiveTracks == 0)
        return 26;

    if ((v10->pNoteList = sosAlloc(v10->wTotalNotes * 18)) == 0)
        return 5;

    memset(v10->pNoteList, 0xff, v10->wTotalNotes * 18);
    v10->pNoteFirst = 0;
    v10->pNoteLast = 0;
    v14 = sosMIDIInitDependencyList(v10, &v10->pChannelTrackDependencyLists);
    if (v14)
        return v14;

    v10->wFlags |= 0x5000;
    v10->pNext = 0;
    *a2 = v8;
    return 0;
}

W32 sosMIDIUnInitSong(HANDLE a1)
{
    DWORD v4;
    PTRACK v8;
    PSONG vc;
    DWORD v10;

    if (a1 >= 32)
        return 10;

    vc = _sMIDISystem.pSongList[a1];
    if (!vc)
        return 10;

    for (v4 = 0; v4 < vc->wTotalTracks; v4++)
    {
        v8 = vc->pTrackList[v4];

        if (v8->wFlags & 0x1000)
        {
            switch (_sMIDIDriver[v8->hDriver].wID)
            {
                case 0xa005:
                    if (sosMIDIFlushTriggeredPatches(v8->hDriver, v8))
                        return 1;
                    break;

            }
        }
    }

    _sMIDISystem.pSongList[a1] = 0;

    sosFree(vc->pNoteList, vc->wTotalNotes * 18);

    v10 = 0;
    
    for (v4 = 0; v4 < vc->wTotalTracks; v4++)
    {
        v8 = vc->pTrackList[v4];
        if (!sosMIDIInitTrack(vc, v8))
            v10++;
    }

    sosFree(vc->pChannelTrackDependencyLists, v10 * 5 + 1);
    vc->wFlags &= ~0x1000;
    return 0;
}

W32 sosMIDIResetSong(HANDLE a1)
{
    DWORD v4;
    PTRACK v8;
    PSONG vc;

    if (a1 >= 32)
        return 10;

    vc = _sMIDISystem.pSongList[a1];

    if ((vc->wFlags & 0x1000) == 0)
        return 24;

    vc = _sMIDISystem.pSongList[a1];
    if (!vc)
        return 10;

    vc->sVolume.wVolume = 127;
    vc->sVolume.wFlags = 0;

    vc->dwTotalTicks = 0;
    vc->dwGlobalTicks = 0;
    vc->wActiveTracks = 0;
    vc->pTrackFirst = 0;
    vc->pTrackLast = 0;
    vc->pNoteFirst = 0;
    vc->pNoteLast = 0;

    for (v4 = 0; v4 < vc->wTotalTracks; v4++)
    {
        v8 = vc->pTrackList[v4];
        if (!sosMIDIInitTrack(vc, v8))
        {
            vc->wActiveTracks++;
            sosMIDIAddTrack(vc, v8);
        }
    }

    memset(vc->pNoteList, 0xff, vc->wTotalNotes * 18);

    if (!vc->wActiveTracks)
        return 26;
    return 0;
}

VOID sosMIDIProcessSong(VOID)
{
    BYTE v4;
    DWORD v8;
    BYTE *vc;
    PTRACK v10;
    PSONG v14;
    PNOTE v18;
    PNOTE v1c;

    v14 = _sMIDISystem.pSongList[_sTIMERSystem.wMIDIActiveSongHandle];
    if (v14)
    {
        if (!(v14->wFlags & 0x20))
        {
            if ((DWORD)v14->wFlags & 0x8000)
            {
                v14->dwTotalTicks++;
                v14->dwGlobalTicks++;
                v18 = v14->pNoteFirst;
                v1c = 0;
                while (v18)
                {
                    if (v18->dwDelta-- == 0)
                    {
                        sosMIDIProcessEvent(v18->pSong, v18->pTrack, 128, v18->bNote, 0, 0, 0);
                        if (!v1c)
                        {
                            v14->pNoteFirst = v18->pNext;
                            if (!v18->pNext)
                                v14->pNoteLast = NULL;
                        }
                        else
                        {
                            v1c->pNext = v18->pNext;
                            if (!v18->pNext)
                                v14->pNoteLast = v1c;
                        }
                        v18->bNote = 0xff;
                        v18->bDriverAndChannel = 0xff;
                    }
                    else
                    {
                        v1c = v18;
                    }
                    v18 = v18->pNext;
                }

                sosMIDIProcessSongEvents(v14);
                v10 = v14->pTrackFirst;
                while (v10)
                {
                    v10->dwTotalTicks++;
                    while (((DWORD)v14->wFlags & 0x8000) && v10->dwDelta-- == 0)
                    {
                        vc = v10->pData;
                        if (*vc >= 0x80)
                        {
                            v4 = 1;
                            v10->bRunningStatus = *vc;
                        }
                        else
                            v4 = 0;

                        if (sosMIDIProcessEvent(v14, v10, v10->bRunningStatus, vc[v4], vc[v4 + 1], vc[v4 + 2], v4))
                        {
                            v10->pData += sosMIDIGetDeltaTime(v10->pData, &v10->dwDelta);
                        }
                    }
                    v10 = v10->pNext;
                }
            }
        }
    }
}

VOID sosMIDIAddSong(PSONG a1)
{
    PSONG v4;
    PSONG *v8;

    v4 = _sMIDISystem.pSongFirst;
    v8 = &_sMIDISystem.pSongFirst;

    while (v4)
    {
        v8 = &v4->pNext;
        v4 = v4->pNext;
    }

    a1->pNext = *v8;
    *v8 = a1;
}

W32 sosMIDIGetSongNotesOn(HANDLE a1)
{
    PSONG v4;
    PNOTE v8;
    DWORD vc;

    vc = 0;

    if (a1 >= 32)
        return 10;

    v4 = _sMIDISystem.pSongList[a1];
    if (!v4)
        return 0;

    v8 = v4->pNoteFirst;
    while (v8)
    {
        v8 = v8->pNext;
        vc++;
    }

    return vc;
}

VOID sosMIDICode18End(VOID) {}
