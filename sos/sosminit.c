#include <io.h>
#include <sys\stat.h>
#include <sys\types.h>
#include <dos.h>
#include <i86.h>
#include <string.h>
#include "sosm.h"

VOID sosMIDICode9Start(VOID) {}

W32 sosMIDIInitDriver(PSOSMIDIDRIVER a1, HANDLE *a2)
{
    char far * unk;
    DWORD v8;
    DWORD vc;
    DWORD v10;
    DWORD v4;
    _MIDI_CHANNEL* v18;
    for (v8 = 0; v8 < 8; v8++)
    {
        if (_sMIDIDriver[v8].wID == 0)
        {
            break;
        }
    }
    if (v8 == 9)
        return _ERR_NO_HANDLES;
    vc = v8;
    _sMIDIDriver[vc].wID = a1->wID;
    switch (a1->wID)
    {
        case _MIDI_TRIGGERED:
            for (v8 = 0; v8 < _MIDI_DRV_FUNCTIONS; v8++)
            {
                _sMIDIDriver[vc].lpfnFunction[v8] = _lpMIDIDIGIFunctions[v8];
            }
            _sMIDIDriver[vc].lpfnDataFunction = _lpMIDIDIGIFunctions[0];
            v10 = _sMIDIDriver[vc].lpfnFunction[_MIDI_DRV_INIT]((LPSTR)&a1->sDIGIInit, vc, 0);
            if (v10)
                return v10;
            break;
        case _MIDI_CALLBACK:
            for (v8 = 0; v8 < _MIDI_DRV_FUNCTIONS; v8++)
            {
                _sMIDIDriver[vc].lpfnFunction[v8] = _lpMIDICBCKFunctions[v8];
            }
            _sMIDIDriver[vc].lpfnDataFunction = _lpMIDICBCKFunctions[0];
            v10 = _sMIDIDriver[vc].lpfnFunction[_MIDI_DRV_INIT]((LPSTR)&a1->sDIGIInit, vc, 0);
            if (v10)
                return v10;
            break;
        case _MIDI_WAVE_TABLE_SYNTH:
            for (v8 = 0; v8 < _MIDI_DRV_FUNCTIONS; v8++)
            {
                _sMIDIDriver[vc].lpfnFunction[v8] = _lpMIDIWAVEFunctions[v8];
            }
            _sMIDIDriver[vc].lpfnDataFunction = _lpMIDIDIGIFunctions[0];
            v10 = _sMIDIDriver[vc].lpfnFunction[_MIDI_DRV_INIT]((LPSTR)&a1->sDIGIInit, vc, 0);
            if (v10)
                return v10;
            break;
        default:
            if (a1->lpDriverMemoryDS)
            {
                _sMIDIDriver[vc].lpDS = a1->lpDriverMemoryDS;
                _sMIDIDriver[vc].lpCS = a1->lpDriverMemoryCS;
            }
            else
            {
                v10 = sosMIDILoadDriver(a1->wID, vc, (LPSTR*)&_sMIDIDriver[vc].lpCS, (LPSTR*)&_sMIDIDriver[vc].lpDS,
                    (PSTR)&_sMIDIDriver[vc].hMemory, (PSTR)&_sMIDIDriver[vc].wSize, (DWORD*)&_sMIDIDriver[vc].dwLinear);
                if (v10)
                    return v10;
                a1->lpDriverMemoryCS = _sMIDIDriver[vc].lpCS;
                a1->lpDriverMemoryDS = _sMIDIDriver[vc].lpDS;
            }
            sosMIDIDRVGetFuncsPtr(_sMIDIDriver[vc].lpCS, _sMIDIDriver[vc].lpDS, (LPSTR)&_sMIDIDriver[vc].lpfnFunction);
            //sosMIDIDRVGetFuncsPtr(_sMIDIDriver[vc].lpCS, _sMIDIDriver[vc].lpDS, (LPSTR)&_sMIDIDriver[vc] + 0x12);
            _sMIDIDriver[vc].lpfnDataFunction = _sMIDIDriver[vc].lpfnFunction[0];
            v10 = _sMIDIDriver[vc].lpfnFunction[_MIDI_DRV_INIT]((LPSTR)a1->sHardware.wParam, a1->sHardware.wIRQ, a1->sHardware.wPort);
            if (v10)
            {
                sosMIDIUnLoadDriver(vc);
                a1->lpDriverMemoryDS = 0;
                a1->lpDriverMemoryCS = 0;
                return v10;
            }
            _sMIDIDriver[vc].wFlags |= _LOADED;
            break;
    }
    switch (a1->wID)
    {
        case _MIDI_GUS:
            break;
    }

    v4 = _wMIDIDriverTotalChannels[a1->wID - 0xa000];
    if (!_sMIDIDriver[vc].pChannel)
    {
        _sMIDIDriver[vc].pChannel = (PCHANNEL)sosAlloc(v4 * sizeof(_MIDI_CHANNEL) + 1);

        if (!_sMIDIDriver[vc].pChannel)
            return _ERR_MEMORY_FAIL;
    }

    v18 = _sMIDIDriver[vc].pChannel;
    memset(v18, 0, v4 * sizeof(_MIDI_CHANNEL));
    *(BYTE*)v18 = v4;
    v18 = (_MIDI_CHANNEL*)((BYTE*)v18 + 1);
    for (v8 = 0; v8 < v4; v8++)
    {
        if ((v18->wChannel = _wMIDIDriverChannel[a1->wID - 0xa000][v8]) == -1)
            v18->wFlags = _MIDI_CHANNEL_LOCKED | _ACTIVE;
        else
            v18->wFlags = 0;
        v18->wDriverVolume = 127;
        v18->pOwnerSong = (void*)-1;
        v18->wOwnerPriority = 9;
        v18->wVolume = 127;
        v18->pOwnerDependency = 0;
        v18->wTracks = 0;
        v18++;
    }
    _sMIDIDriver[vc].wFlags |= _INITIALIZED;
    *a2 = vc;
    sosMIDIResetDriver(vc);
    return 0;
}

W32 sosMIDIUnInitDriver(HANDLE a1, BOOL a2)
{
    DWORD unk[2];
    DWORD v8;
    if (a1 >= 8)
        return _ERR_INVALID_HANDLE;
    if (!(_sMIDIDriver[a1].wFlags & _INITIALIZED))
        return _ERR_NOT_INITIALIZED;
    sosMIDIResetDriver(a1);
    switch (_sMIDIDriver[a1].wID)
    {
        case _MIDI_GUS:
            sosTIMERRemoveEvent(_sMIDIDriver[a1].hEvent);
            break;
    }
    _sMIDIDriver[a1].lpfnFunction[_MIDI_DRV_UNINIT](0, a1, 0);
    if (a2 && (_sMIDIDriver[a1].wFlags & _LOADED) != 0)
    {
        sosMIDIUnLoadDriver(a1);
        _sMIDIDriver[a1].lpDS = 0;
        _sMIDIDriver[a1].lpCS = 0;
    }
    if (a2)
    {
        sosFree(_sMIDIDriver[a1].pChannel,
            _wMIDIDriverTotalChannels[_sMIDIDriver[a1].wID - 0xa000] * sizeof(_MIDI_CHANNEL) + 1);
        _sMIDIDriver[a1].pChannel = NULL;
        _sMIDIDriver[a1].wFlags &= ~_LOADED;
    }
    _sMIDIDriver[a1].wFlags &= ~_INITIALIZED;
    _sMIDIDriver[a1].wID = 0;
    return 0;
}

W32 sosMIDIResetDriver(HANDLE a1)
{
    BYTE v28[16];
    DWORD v8;
    DWORD vc;
    DWORD v4;
    _MIDI_CHANNEL* v14;

    v14 = _sMIDIDriver[a1].pChannel;
    v8 = *(BYTE*)v14;
    v14 = (_MIDI_CHANNEL*)((BYTE*)v14 + 1);
    for (v4 = 0; v4 < v8; v4++)
    {
        if (v14->wChannel != -1)
        {
            v28[0] = _MIDI_CONTROL | v14->wChannel;
            v28[1] = _MIDI_ALL_NOTES_OFF_MIDI;
            v28[2] = 0;
            sosMIDISendMIDIData(a1, v28, 3);
            v28[0] = _MIDI_CONTROL | v14->wChannel;
            v28[1] = _MIDI_VOLUME_CTRLR;
            v28[2] = 0;
            sosMIDISendMIDIData(a1, v28, 3);
            v28[0] = _MIDI_CONTROL | v14->wChannel;
            v28[1] = _MIDI_RESET_CONTROLLERS_CTRLR;
            v28[2] = 0;
            sosMIDISendMIDIData(a1, v28, 3);
        }
        v14++;
    }
    return 0;
}

VOID sosMIDICode9End(VOID) {}
