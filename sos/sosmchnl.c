#include <stdlib.h>
#include "sosm.h"

VOID sosMIDICode3Start(VOID) {}

BOOL sosMIDIAcquireChannel(PTRACK a1)
{
    DWORD v4;
    DWORD v8;
    _MIDI_DRIVER *vc;
    PCHANNEL v10;
    DWORD v14;
    PCHANNEL v18;
    DWORD v1c;
    _MIDI_TRACK *v20;
    _MIDI_TRACK **v24;
    DWORD v28;
    DWORD v2c;

    v28 = 0;
    if (!a1)
        return 0;

    vc = &_sMIDIDriver[a1->hDriver];
    v4 = *(BYTE*)vc->pChannel;
    v10 = (BYTE*)vc->pChannel + 1;
    if (a1->sSteal.wRawChannel == 9)
    {
        a1->sSteal.wRemapChannel = 9;
        a1->wFlags &= ~_SUPRESSED;
        a1->pDriverChannel = v10 + 9;
        return 0;
    }
    if (!(a1->wFlags & _SUPRESSED))
    {
        return 0;
    }
    for (v8 = 0; v8 < v4; v8++)
    {
        if (!(v10[v8].wFlags & _ACTIVE))
            break;
    }
    if (v8 != v4)
    {
        v10 += v8;
        v24 = a1->pTrackDependencyList;

        v1c = *(BYTE*)v24;

        v24 = (BYTE*)v24 + 1;

        if (a1->pDependentTrack->wFlags & 0x0400)
        {
            v10->wFlags |= 0x0400;
        }
        for (v8 = 0; v8 < v1c; v8++)
        {
            a1 = v24[v8];
            a1->pDriverChannel = v10;
            a1->wFlags &= ~0x10;
            if (a1->wFlags & _ACTIVE)
                v28++;
            v10->wFlags |= _ACTIVE;
            a1->sSteal.wRemapChannel = v10->wChannel;
            a1->pDependentTrack->wFlags &= ~0x0400;
        }
        v10->wTracks = v28;
        v10->pOwnerSong = a1->pSong;
        v10->wOwnerPriority = a1->sSteal.wPriority;
        v10->pOwnerDependency = a1->pTrackDependencyList;
        sosMIDISendChannelInfo(a1);
        return 0;
    }

    v14 = a1->sSteal.wPriority;
    v2c = 0;
    for (v8 = 0; v8 < v4; v8++)
    {
        if (v10[v8].wOwnerPriority > v14 && (v10[v8].wFlags & 0x0400) == 0)
        {
            v2c = 1;
            v14 = v10[v8].wOwnerPriority;
            v18 = &v10[v8];
        }
    }
    if (a1->pDependentTrack->wFlags & 0x0400)
    {
        v14 = 9;
        for (v8 = 0; v8 < v4; v8++)
        {
            if (!(v10[v8].wFlags & 0x0400) && v14 >= v10[v8].wOwnerPriority)
            {
                v2c = 1;
                v14 = v10[v8].wOwnerPriority;
                v18 = &v10[v8];
            }
        }
    }
    if (v2c)
    {
        v24 = v18->pOwnerDependency;
        v1c = *(BYTE*)v24;
        v24 = (BYTE*)v24 + 1;
        for (v8 = 0; v8 < v1c; v8++)
        {
            v20 = v24[v8];
            sosMIDIStealTrackListInsert(v20);
            sosMIDIProcessEvent(v20->pSong, v20, _MIDI_CONTROL | v20->sSteal.wRemapChannel,
                _MIDI_ALL_NOTES_OFF_CTRLR, 0, 0, 0);
            v20->wFlags |= 0x10;
        }
        a1->sSteal.wRemapChannel = v18->wChannel;
        sosMIDIProcessEvent(a1->pSong, a1, _MIDI_CONTROL | a1->sSteal.wRemapChannel,
            _MIDI_ALL_NOTES_OFF_CTRLR, 0, 0, 0);
        v18->pOwnerSong = a1->pSong;
        v18->wOwnerPriority = a1->sSteal.wPriority;
        v18->pOwnerDependency = a1->pTrackDependencyList;
        v24 = a1->pTrackDependencyList;
        v1c = *(BYTE*)v24;
        v24 = (BYTE*)v24 + 1;
        if (a1->pDependentTrack->wFlags & 0x0400)
        {
            v18->wFlags |= 0x0400;
        }
        for (v8 = 0; v8 < v1c; v8++)
        {
            v20 = v24[v8];
            v20->sSteal.wRemapChannel = v18->wChannel;
            v20->pDriverChannel = v18;
            v20->wFlags &= ~0x0410;
            if (a1->wFlags & _ACTIVE)
                v28++;
        }
        v18->wTracks = v28;
        sosMIDISendChannelInfo(a1);
        return 0;
    }
    if (!(a1->wFlags & 0x0020))
    {
        sosMIDIStealTrackListInsert(a1);
    }
    return 1;
}

VOID sosMIDIReleaseChannel(PTRACK a1)
{
    PCHANNEL v4;
    v4 = a1->pDriverChannel;
    if (v4->wChannel != -1)
    {
        a1->wFlags |= 0x0010;
        v4->wTracks--;
        if (!v4->wTracks)
        {
            v4->wFlags &= ~0x8400;
            sosMIDIAcquireChannel(sosMIDIStealTrackListRetreive());
        }
    }
}

VOID sosMIDISendChannelInfo(PTRACK a1)
{
    DWORD v4;
    DWORD v8;
    BYTE *vc;
    BYTE *v10;
    DWORD v14;

    sosMIDISendMIDIEvent(a1->hDriver, _MIDI_CONTROL | a1->sSteal.wRemapChannel,
        _MIDI_RESET_CONTROLLERS_CTRLR, 0, 3);
    vc = a1->pSong->bCtrlrIndexes;
    v10 = a1->pTrackChannel;

    v8 = 0;
    for (v4 = 0; v4 < 127; v4++)
    {
        if (*(LPSTR)vc++ != 0xff)
        {
            if (*(LPSTR)(v10 + v8) != 0xff)
            {
                switch (v4)
                {
                    case _MIDI_CTRLR_PROGRAM_CHANGE:
                        sosMIDISendMIDIEvent(a1->hDriver, _MIDI_PROGRAM | a1->sSteal.wRemapChannel,
                            v10[v8], 0, 2);
                        break;
                    case _MIDI_CTRLR_PITCH_BEND:
                        sosMIDISendMIDIEvent(a1->hDriver, _MIDI_BEND | a1->sSteal.wRemapChannel,
                            0, v10[v8], 3);
                        break;
                    case _MIDI_CTRLR_AFTERTOUCH:
                        sosMIDISendMIDIEvent(a1->hDriver, _MIDI_AFTERTOUCH | a1->sSteal.wRemapChannel,
                            v10[v8], 0, 3);
                        break;
                    case _MIDI_CTRLR_CHANNEL_PRESSURE:
                        sosMIDISendMIDIEvent(a1->hDriver, _MIDI_CHANNEL_PRESSURE | a1->sSteal.wRemapChannel,
                            v10[v8], 0, 2);
                        break;
                    case _MIDI_VOLUME_CTRLR:
                        v14 = v10[v8];
                        a1->pDriverChannel->wVolume = v14;
                        v14 = (a1->pSong->sVolume.wVolume * v14) / 127;
                        v14 = (v14 * _sMIDISystem.wVolume) / 127;
                        v14 = (v14 * a1->pDriverChannel->wDriverVolume) / 127;
                        a1->pDriverChannel->wVolumeScalar = v14;
                        sosMIDISendMIDIEvent(a1->hDriver, _MIDI_CONTROL | a1->sSteal.wRemapChannel,
                            v4, v14, 3);
                        break;
                    default:
                        sosMIDISendMIDIEvent(a1->hDriver, _MIDI_CONTROL | a1->sSteal.wRemapChannel,
                            v4, *(LPSTR)(v10 + v8), 3);
                        break;

                }
            }
            v8++;
        }
    }
}

VOID sosMIDIUpdateChannel(PTRACK a1)
{
    BYTE u1;
    BYTE v8;
    DWORD vc;
    BYTE *v10;
    DWORD v14;
    DWORD v18;
    DWORD v1c;

    v10 = a1->pData;
    vc = (DWORD)(*v10++) >> 1;
    for (v14 = 0; v14 < vc; v14++)
    {
        v8 = *v10++;
        if (a1->sBranch.dwCtrlFlags[(DWORD)v8 >> 5] & (1 << (v8 & 32)))
        {
            v18 = a1->pSong->bCtrlrIndexes[v8];
            a1->pTrackChannel[v18] = *v10;
            switch (v8)
            {
                case _MIDI_CTRLR_PROGRAM_CHANGE:
                    sosMIDISendMIDIEvent(a1->hDriver, _MIDI_PROGRAM | a1->sSteal.wRemapChannel,
                        *v10++, 0, 2);
                    break;
                case _MIDI_CTRLR_PITCH_BEND:
                    sosMIDISendMIDIEvent(a1->hDriver, _MIDI_BEND | a1->sSteal.wRemapChannel,
                        0, *v10++, 3);
                    break;
                case _MIDI_CTRLR_AFTERTOUCH:
                    sosMIDISendMIDIEvent(a1->hDriver, _MIDI_AFTERTOUCH | a1->sSteal.wRemapChannel,
                        *v10++, *v10++, 3);
                    break;
                case _MIDI_CTRLR_CHANNEL_PRESSURE:
                    sosMIDISendMIDIEvent(a1->hDriver, _MIDI_CHANNEL_PRESSURE | a1->sSteal.wRemapChannel,
                        *v10++, 0, 2);
                    break;
                case _MIDI_VOLUME_CTRLR:
                    v1c = *v10++;
                    a1->pDriverChannel->wVolume = v1c;
                    v1c = (a1->pSong->sVolume.wVolume * v1c) / 127;
                    v1c = (v1c * _sMIDISystem.wVolume) / 127;
                    v1c = (v1c * a1->pDriverChannel->wDriverVolume) / 127;
                    a1->pDriverChannel->wVolumeScalar = v1c;
                    sosMIDISendMIDIEvent(a1->hDriver, _MIDI_CONTROL | a1->sSteal.wRemapChannel,
                        v14, v1c, 3);
                    break;
                default:
                    sosMIDISendMIDIEvent(a1->hDriver, _MIDI_CONTROL | a1->sSteal.wRemapChannel,
                        v8, *v10++, 3);
                    break;
            }
        }
        else
            v10++;
    }
}

W32 sosMIDIResetChannelStealing(HANDLE a1)
{
    DWORD v4;
    DWORD v8;
    DWORD vc;
    DWORD v10;
    PSONG v14;
    PTRACK v18;
    PTRACK *v1c;

    int u1;

    v14 = _sMIDISystem.pSongList[a1];

    v1c = v14->pChannelTrackDependencyLists;
    v4 = *(BYTE*)v1c;
    v1c = (BYTE*)v1c + 1;
    for (vc = 0; vc < v4; vc++)
    {
        v8 = *(BYTE*)v1c;
        v1c = (BYTE*)v1c + 1;
        for (v10 = 0; v10 < v8; v10++)
        {
            v18 = *v1c;
            sosMIDIStealTrackListRemove(v18);
            sosMIDIProcessEvent(v14, v18, _MIDI_CONTROL, _MIDI_ALL_NOTES_OFF_CTRLR,
                0, 0, 0);
            if (!(v18->wFlags & 0x0010))
            {
                sosMIDIReleaseChannel(v18);
            }
            v1c++;
        }
    }
    return 0;
}

VOID sosMIDICode3End(VOID) {}

