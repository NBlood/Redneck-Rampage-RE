#include <stdlib.h>
#include "sosm.h"

VOID sosMIDICode1Start(VOID) {}

BOOL sosMIDIBranchSong(PSONG a1, W32 a2)
{
    DWORD v4;
    DWORD v8;
    PTRACK vc;
    PTRACK *v10;
    PSTR v14;
    
    if (!(a1->wFlags & _ACTIVE))
    {
        return 1;
    }
    v10 = a1->pTrackList;
    for (v4 = 0; v4 < a1->wTotalTracks; v4++)
    {
        vc = *v10++;
        if (vc->wFlags & 0x1000)
        {
            if (!sosMIDIBranchTrack(vc, a2))
            {
                if (!(vc->wFlags & 0x8000)
                    && (vc->wFlags & 0x1000))
                {
                    sosMIDIAddTrack(a1, vc);
                    a1->wActiveTracks++;
                    v14 = vc->pData;
                    sosMIDIProcessEvent(a1, vc, _MIDI_CONTROL, _MIDI_STEAL_CHANNEL,
                        1, 0, 0);
                    vc->pData = v14;
                }
            }
        }
    }
    return 0;
}

BOOL sosMIDIBranchTrack(PTRACK a1, W32 a2)
{
    PSTR *v4;
    DWORD v8;
    DWORD vc;
    DWORD u1;

    v4 = a1->sBranch.pBranchList;
    if (!v4)
        return 1;
    v8 = *(BYTE*)v4;
    v4 = (BYTE*)v4 + 1;
    for (vc = 0; vc < v8; vc++)
    {
        if (*(short*)v4 == a2)
            break;
        v4 = (BYTE*)v4 + 6;
    }
    if (vc == v8)
        return 1;
    a1->pData = *(DWORD*)((BYTE*)v4 + 2) + 4;
    sosMIDIProcessEvent(a1->pSong, a1, _MIDI_CONTROL | a1->sSteal.wRemapChannel,
        _MIDI_ALL_NOTES_OFF_CTRLR, 0, 0, 0);
    if (!(a1->wFlags & 0x10))
        sosMIDIUpdateChannel(a1);

    a1->pData += a1->pData[0] + 1;
    a1->dwTotalTicks = *(DWORD*)a1->pData;
    a1->pData += 4;
    a1->pData += sosMIDIGetDeltaTime(a1->pData, &a1->dwDelta);
    _sMIDISystem.wTrackBranched = 1;
    return 0;
}

W32 sosMIDIBranchToSongID(HANDLE a1, BYTE a2)
{
    PSONG vc;
    if (a1 >= _MIDI_MAX_SONGS)
        return _ERR_INVALID_HANDLE;
    vc = _sMIDISystem.pSongList[a1];
    if (!vc)
        return _ERR_INVALID_HANDLE;
    if (!(vc->wFlags & _ACTIVE))
        return _ERR_NO_ERROR;
    return sosMIDIBranchSong(_sMIDISystem.pSongList[a1], 0x80 | a2);
}

W32 sosMIDIBranchToTrackID(HANDLE a1, W32 a2, BYTE a3)
{
    PTRACK v8;
    PSONG v14;
    DWORD vc;

    if (a1 >= _MIDI_MAX_SONGS)
        return _ERR_INVALID_HANDLE;
    v14 = _sMIDISystem.pSongList[a1];
    if (!v14)
        return _ERR_INVALID_HANDLE;
    if (!(v14->wFlags & _ACTIVE))
        return _ERR_NO_ERROR;
    for (vc = 0; vc < v14->wTotalTracks; vc++)
    {
        v8 = v14->pTrackList[vc];
        if (v8->wOriginalTrackIndex == a2)
            break;
    }
    return sosMIDIBranchTrack(v8, a3);
}

W32 sosMIDIRegisterLoopFunction(HANDLE a1, W32(*a2)(HANDLE, BYTE, BYTE))
{
    PSONG v4;

    if (a1 >= _MIDI_MAX_SONGS)
        return _ERR_INVALID_HANDLE;
    v4 = _sMIDISystem.pSongList[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;
    v4->pfnLoopCallback = a2;
    return _ERR_NO_ERROR;
}

W32 sosMIDIRegisterBranchFunction(HANDLE a1, W32(*a2)(HANDLE, BYTE, BYTE))
{
    PSONG v4;

    if (a1 >= _MIDI_MAX_SONGS)
        return _ERR_INVALID_HANDLE;
    v4 = _sMIDISystem.pSongList[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;
    v4->pfnBranchCallback = a2;
    return _ERR_NO_ERROR;
}

W32 sosMIDIRegisterTriggerFunction(HANDLE a1, W32(*a2)(HANDLE, BYTE, BYTE))
{
    PSONG v4;

    if (a1 >= _MIDI_MAX_SONGS)
        return _ERR_INVALID_HANDLE;
    v4 = _sMIDISystem.pSongList[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;
    v4->pfnTriggerCallback = a2;
    return _ERR_NO_ERROR;
}

VOID sosMIDICode1End(VOID) {}
