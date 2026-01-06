#include <stdlib.h>
#include <string.h>
#include "sosm.h"


VOID sosMIDICode16Start(VOID) {}

W32 sosMIDIStartSong(HANDLE a1)
{
    W32 v4;
    PSONG v8;
    HANDLE vc;
    if (a1 >= _MIDI_MAX_SONGS)
        return _ERR_INVALID_HANDLE;
    v8 = _sMIDISystem.pSongList[a1];
    if (!v8)
        return _ERR_INVALID_HANDLE;
    if (!(v8->wFlags & _INITIALIZED))
        return _ERR_NOT_INITIALIZED;

    v4 = sosTIMERRegisterEvent(v8->wPlayRate, sosMIDIProcessSong, &vc);
    if (v4)
        return v4;

    v8->hEvent = vc;
    _sTIMERSystem.wMIDIEventSongHandle[v8->hEvent] = (BYTE)a1;
    v8->wFlags |= _ACTIVE;
    return _ERR_NO_ERROR;
}

W32 sosMIDIStopSong(HANDLE a1)
{
    W32 v4;
    PSONG v8;
    if (a1 >= _MIDI_MAX_SONGS)
        return _ERR_INVALID_HANDLE;
    v8 = _sMIDISystem.pSongList[a1];
    if (!v8)
        return _ERR_INVALID_HANDLE;
    if (!(v8->wFlags & _INITIALIZED))
        return _ERR_NOT_INITIALIZED;
    if (!(v8->wFlags & _ACTIVE))
        return _ERR_NOT_INITIALIZED;
    if ((HANDLE)v8->hEvent != -1)
        sosTIMERRemoveEvent(v8->hEvent);
    _sTIMERSystem.wMIDIEventSongHandle[v8->hEvent] = 0xff;
    v8->hEvent = -1;
    if (v8->wFlags & _ACTIVE)
    {
        sosMIDIResetChannelStealing(a1);
        v8->wFlags &= ~_ACTIVE;
        sosMIDIResetSong(v8->hSong);
    }
    return _ERR_NO_ERROR;
}

BOOL sosMIDISongDone(HANDLE a1)
{
    PSONG v4;
    if (a1 >= _MIDI_MAX_SONGS)
        return _ERR_INVALID_HANDLE;
    v4 = _sMIDISystem.pSongList[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;
    if (v4->wFlags & _ACTIVE)
        return 0;
    return 1;
}

VOID sosMIDICode16End(VOID) {}
