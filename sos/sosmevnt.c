#include <stdlib.h>
#include <i86.h>
#include "sosm.h"

VOID sosMIDICode8Start(VOID) {}

// fixme: variable order
BOOL sosMIDIProcessEvent(PSONG a1, PTRACK a2, W32 a3, W32 a4, W32 a5,
    W32 a6, BYTE a7)
{
	DWORD v4;

	DWORD v28;

	_MIDI_NOTE* v8;
	_MIDI_NOTE *vc;
	_MIDI_NOTE **v10;

	DWORD v14;
	DWORD v18;
	BYTE *v1c;
	DWORD u1;

	switch (a3 & 0xf0)
	{
		case _MIDI_NOTE_ON:
			a2->pData += (DWORD)a7 + 2;
			a2->pData += sosMIDIGetDeltaTime(a2->pData, &v4);
			if (!(a2->wFlags & _SUPRESSED))
			{
				v28 = 0;
				while (a1->pNoteList[v28].bNote != 0xff)
				{
					v28++;
				}
				v8 = &a1->pNoteList[v28];
				v8->pSong = a1;
				v8->pTrack = a2;
				v8->bNote = a4;
				v8->dwDelta = v4;
				v8->bDriverAndChannel = (BYTE)a2->sSteal.wRemapChannel | ((BYTE)a2->hDriver << 4);
				v8->pNext = NULL;
				if (!a1->pNoteLast)
				{
					a1->pNoteFirst = v8;
					a1->pNoteLast = v8;
				}
				else
				{
					a1->pNoteLast->pNext = v8;
					a1->pNoteLast = v8;
				}
				if (a2->sSteal.wRemapChannel == 9)
				{
					if (a1->wFlags & _MUTE)
						a5 = 0;
					else
						a5 = (a5 * a2->pDriverChannel->wVolumeScalar) / 127;
				}
				sosMIDISendMIDIEvent(a2->hDriver, _MIDI_NOTE_ON | a2->sSteal.wRemapChannel,
					a4, a5, 3);
			}
			return 1;
		case _MIDI_NOTE_OFF:
			if (!(a2->wFlags & _SUPRESSED))
			{
				sosMIDISendMIDIEvent(a2->hDriver, _MIDI_NOTE_ON | a2->sSteal.wRemapChannel,
					a4, 0, 3);
			}
			return 0;
		case _MIDI_CONTROL:
			switch (a4)
			{
				case _MIDI_ALL_NOTES_OFF_CTRLR:
					if (!(a2->wFlags & _SUPRESSED))
					{
						v8 = a1->pNoteFirst;
						v10 = &a1->pNoteFirst;
						vc = NULL;
						while (v8)
						{
							if (v8->bDriverAndChannel == ((a2->hDriver << 4) | a2->sSteal.wRemapChannel))
							{
								sosMIDISendMIDIEvent(a2->hDriver, _MIDI_NOTE_ON | a2->sSteal.wRemapChannel,
									v8->bNote, 0, 3);
								if (!vc)
								{
									*v10 = v8->pNext;
									if (!v8->pNext)
										a1->pNoteLast = NULL;
								}
								else
								{
									if (!v8->pNext)
										a1->pNoteLast = vc;
									*v10 = v8->pNext;
								}
								v8->bNote = 0xff;
								v8->bDriverAndChannel = 0xff;
							}
							else
							{
								vc = v8;
								v10 = &v8->pNext;
							}
							v8 = v8->pNext;
						}
					}
					return 1;
				case _MIDI_VOLUME_CTRLR:
					if (!(a2->wFlags & _SUPRESSED))
					{
						v28 = (a1->sVolume.wVolume * a5) / 127;
						v28 = (v28 * _sMIDISystem.wVolume) / 127;
						v28 = (v28 * a2->pDriverChannel->wDriverVolume) / 127;
						a2->pDriverChannel->wVolume = a5;
						a2->pDriverChannel->wVolumeScalar = v28;
						if (a2->pDriverChannel->wChannel != 9)
						{
							sosMIDISendMIDIEvent(a2->hDriver, _MIDI_CONTROL | a2->sSteal.wRemapChannel,
								a4, v28, 3);
						}
					}
					v18 = a1->bCtrlrIndexes[_MIDI_VOLUME_CTRLR];
					a2->pTrackChannel[v18] = a5;
					a2->pData += (DWORD)a7 + 2;
					return 1;
				case _MIDI_DISABLE_CONTROLLER_RESTORE:
					if (a5 == _MIDI_ALL_CONTROLLERS)
					{
						a2->sBranch.dwCtrlFlags[0] = 0;
						a2->sBranch.dwCtrlFlags[1] = 0;
						a2->sBranch.dwCtrlFlags[2] = 0;
						a2->sBranch.dwCtrlFlags[3] = 0;
						a2->pData += (DWORD)a7 + 2;
						return 1;
					}
					else
					{
						a2->sBranch.dwCtrlFlags[a5 >> 5] &= ~(1 << (a5 & 32)); // ???
						a2->pData += (DWORD)a7 + 2;
						return 1;
					}
				case _MIDI_ENABLE_CONTROLLER_RESTORE:
					if (a5 == _MIDI_ALL_CONTROLLERS)
					{
						a2->sBranch.dwCtrlFlags[0] = 0xff;
						a2->sBranch.dwCtrlFlags[1] = 0xff;
						a2->sBranch.dwCtrlFlags[2] = 0xff;
						a2->sBranch.dwCtrlFlags[3] = 0xff;
						a2->pData += (DWORD)a7 + 2;
						return 1;
					}
					else
					{
						a2->sBranch.dwCtrlFlags[a5 >> 5] &= ~(1 << (a5 & 32)); // ???
						a2->pData += (DWORD)a7 + 2;
						return 1;
					}
				case _MIDI_LOCK_CHANNEL:
					if (a5)
					{
						if (!(a2->wFlags & _SUPRESSED))
						{
							a2->pDriverChannel->wFlags |= _MIDI_CHANNEL_LOCKED;
						}
						else
						{
							a2->pDependentTrack->wFlags |= _MIDI_CHANNEL_LOCKED;
							sosMIDIStealTrackListRemove(a2);
							sosMIDIAcquireChannel(a2);
						}
					}
					else
					{
						if (!(a2->wFlags & _SUPRESSED))
						{
							a2->pDriverChannel->wFlags &= ~_MIDI_CHANNEL_LOCKED;
							a2->pDependentTrack->wFlags &= ~_MIDI_CHANNEL_LOCKED;
							sosMIDIAcquireChannel(sosMIDIStealTrackListRetreive());
						}
						else
						{
							a2->pDependentTrack->wFlags &= ~_MIDI_CHANNEL_LOCKED;
						}
					}
					a2->pData += (DWORD)a7 + 2;
					return 1;
				case _MIDI_STEAL_CHANNEL:
					if (a5)
						sosMIDIAcquireChannel(a2);
					else
					{
						if (!(a2->wFlags & _SUPRESSED))
						{
							sosMIDIReleaseChannel(a2);
						}
					}
					a2->pData += (DWORD)a7 + 2;
					return 1;
				case _MIDI_SET_PRIORITY:
					v28 = a2->sSteal.wPriority;
					a2->sSteal.wPriority = a5;

					if (a2->wFlags & _SUPRESSED)
					{
						if (a5 < v28)
						{
							sosMIDIStealTrackListRemove(a2);
							sosMIDIAcquireChannel(a2);
						}
					}
					else
					{
						a2->pDriverChannel->wOwnerPriority = a5;
						if (a5 > v28)
						{
							sosMIDIAcquireChannel(sosMIDIStealTrackListRetreive());
						}
					}
					a2->pData += (DWORD)a7 + 2;
					return 1;
				case _MIDI_TRIGGER_CTRLR:
					if (a1->pfnTriggerCallback)
						a1->pfnTriggerCallback(a1->hSong, a2->wTrackIndex, a5);
					a2->pData += (DWORD)a7 + 2;
					return 1;
				default:
					if (!(a2->wFlags & _SUPRESSED))
					{
						sosMIDISendMIDIEvent(a2->hDriver, _MIDI_CONTROL | a2->sSteal.wRemapChannel,
							a4, a5, 3);
					}
					v18 = a1->bCtrlrIndexes[a4];
					a2->pTrackChannel[v18] = a5;
					a2->pData += (DWORD)a7 + 2;
					return 1;

			}
			break;
		case _MIDI_PROGRAM:
			if (!(a2->wFlags & _SUPRESSED))
			{
				sosMIDISendMIDIEvent(a2->hDriver, _MIDI_PROGRAM | a2->sSteal.wRemapChannel,
					a4, a5, 2);
			}
			v18 = a1->bCtrlrIndexes[_MIDI_CTRLR_PROGRAM_CHANGE];
			a2->pTrackChannel[v18] = a4;
			a2->pData += (DWORD)a7 + 1;
			return 1;
		case _MIDI_BEND:
			if (!(a2->wFlags & _SUPRESSED))
			{
				sosMIDISendMIDIEvent(a2->hDriver, _MIDI_BEND | a2->sSteal.wRemapChannel,
					a4, a5, 3);
			}
			v18 = a1->bCtrlrIndexes[_MIDI_CTRLR_PITCH_BEND];
			a2->pTrackChannel[v18] = a5;
			a2->pData += (DWORD)a7 + 2;
			return 1;
		case _MIDI_AFTERTOUCH:
			if (!(a2->wFlags & _SUPRESSED))
			{
				sosMIDISendMIDIEvent(a2->hDriver, _MIDI_AFTERTOUCH | a2->sSteal.wRemapChannel,
					a4, a5, 3);
			}
			v18 = a1->bCtrlrIndexes[_MIDI_CTRLR_AFTERTOUCH];
			a2->pTrackChannel[v18] = a4;
			a2->pData += (DWORD)a7 + 2;
			return 1;
		case _MIDI_CHANNEL_PRESSURE:
			if (!(a2->wFlags & _SUPRESSED))
			{
				sosMIDISendMIDIEvent(a2->hDriver, _MIDI_CHANNEL_PRESSURE | a2->sSteal.wRemapChannel,
					a4, a5, 2);
			}
			v18 = a1->bCtrlrIndexes[_MIDI_CTRLR_CHANNEL_PRESSURE];
			a2->pTrackChannel[v18] = a4;
			a2->pData += (DWORD)a7 + 1;
			return 1;
		default:
			switch (a3)
			{
				case _MIDI_SYSEX:
					v14 = *(DWORD*)(a2->pData + a7);
					sosMIDISendMIDIData(a2->hDriver, MK_FP(getDS(), a2->pData + a7 + 4), v14);
					a2->pData += (DWORD)a7 + 4 + v14;
					return 1;
				case _MIDI_TRACK_EVENT:
					if (a4 == _MIDI_END_OF_TRACK)
					{
						a2->wFlags &= ~_ACTIVE;
						a1->wActiveTracks--;
						if (a2->wFlags & _SUPRESSED)
							sosMIDIStealTrackListRemove(a2);
						if (&a1->pTrackFirst == a2->pPrev)
						{
							a1->pTrackFirst = a2->pNext;
							if (a2->pNext)
								a2->pNext->pPrev = &a1->pTrackFirst;
							if (!a2->pNext)
								a1->pTrackLast = NULL;
						}
						else
						{
							a2->pPrev->pNext = a2->pNext;
							if (a2->pNext)
							{
								a2->pNext->pPrev = a2->pPrev;
							}
							else
							{
								a1->pTrackLast = a2->pPrev;
							}
						}
						if (!a1->pTrackFirst)
						{
							sosMIDIStopSong(a1->hSong);
							if (a1->pfnSongCallback)
								a1->pfnSongCallback(a1->hSong);
						}
					}
					return 0;
				case _MIDI_HMI_EVENT:
					switch (a4)
					{
						case _MIDI_LOCAL_BRANCH_DATA:
							a2->pData += a2->pData[4] + 9;
							return 1;
						case _MIDI_LOCAL_BRANCH:
							if (a1->pfnBranchCallback)
							{
								_sMIDISystem.wTrackBranched = 0;
								if (!a1->pfnBranchCallback(a1->hSong, a2->wTrackIndex, a5 & 127))
								{
									if (!_sMIDISystem.wTrackBranched)
									{
										a2->pData += 8;
										return 1;
									}
									return 0;
								}
							}
							a2->pData = (BYTE*)a2 + *(DWORD*)(a2->pData + 4);
							a2->pData += 4;
							sosMIDIProcessEvent(a1, a2, _MIDI_CONTROL | a2->sSteal.wRemapChannel,
								_MIDI_ALL_NOTES_OFF_CTRLR, 0, 0, 0);
							if (!(a2->wFlags & _SUPRESSED))
							{
								sosMIDIUpdateChannel(a2);
							}
							a2->pData += a2->pData[0] + 1;
							a2->dwTotalTicks = *(DWORD*)a2->pData;
							a2->pData += 4;
							a2->pData += sosMIDIGetDeltaTime(a2->pData, &a2->dwDelta);
							return 0;
						case _MIDI_LOCAL_LOOP_COUNT:
						case _MIDI_GLOBAL_LOOP_COUNT:
							a2->pData[2] = a2->pData[3];
							a2->pData += 4;
							return 1;
						case _MIDI_LOCAL_LOOP_END:
							v1c = (BYTE*)a2 + *(DWORD*)(a2->pData + 8);
							if (*v1c)
							{
								if (*v1c != 0xff)
									(*v1c)--;
								if (a1->pfnLoopCallback)
								{
									_sMIDISystem.wTrackBranched = 0;
									if (!a1->pfnLoopCallback(a1->hSong, a2->wTrackIndex,
										*v1c))
									{
										if (!_sMIDISystem.wTrackBranched)
										{
											a2->pData += 12;
											return 1;
										}
										return 0;
									}

								}
								a2->pData = (BYTE*)a2 + *(DWORD*)(a2->pData + 4) + 4;
								sosMIDIProcessEvent(a1, a2, _MIDI_CONTROL | a2->sSteal.wRemapChannel,
									_MIDI_ALL_NOTES_OFF_CTRLR, 0, 0, 0);
								if (!(a2->wFlags & _SUPRESSED))
								{
									sosMIDIUpdateChannel(a2);
								}
								a2->pData += a2->pData[0] + 1;
								a2->dwTotalTicks = *(DWORD*)a2->pData;
								a2->pData += 4;
								a2->pData += sosMIDIGetDeltaTime(a2->pData, &a2->dwDelta);
								return 0;
							}
							a2->pData += 12;
							return 1;
						case _MIDI_GLOBAL_LOOP_END:
							v1c = (BYTE*)a2 + *(DWORD*)(a2->pData + 4);
							if (*v1c)
							{
								if (*v1c != 0xff)
									(*v1c)--;
								if (a1->pfnLoopCallback)
								{
									_sMIDISystem.wTrackBranched = 0;
									if (!a1->pfnLoopCallback(a1->hSong, 0xff, *v1c))
									{
										if (!_sMIDISystem.wTrackBranched)
										{
											a2->pData += 8;
											return 1;
										}
										return 0;
									}

								}
								sosMIDIBranchSong(a1, *(short*)(a2->pData + 2));
								a1->dwTotalTicks = a2->dwTotalTicks;
								return 0;
							}
							a2->pData += 8;
							return 1;
						case _MIDI_GLOBAL_BRANCH:
							if (a1->pfnBranchCallback)
							{
								_sMIDISystem.wTrackBranched = 0;
								if (!a1->pfnBranchCallback(a1->hSong, 0xff, a5 & 0x7f))
								{
									if (!_sMIDISystem.wTrackBranched)
									{
										a2->pData += 4;
										return 1;
									}
									return 0;
								}
							}
							sosMIDIBranchSong(a1, *(short*)(a2->pData + 2));
							a1->dwTotalTicks = a2->dwTotalTicks;
							return 0;
					}
			}
			return 1;
	}
}

BOOL sosMIDIProcessSongEvents(PSONG a1)
{
	short v4;
	if (!(a1->wFlags & 32) && (a1->sVolume.wFlags & _ACTIVE))
	{
		a1->sVolume.wTicks--;
		a1->sVolume.wSkipCurrent--;
		switch (a1->sVolume.wDirection)
		{
			case _MIDI_FADE_OUT:
			case _MIDI_FADE_OUT_STOP:
				a1->sVolume.dwFadeVolume -= a1->sVolume.dwFraction;
				if (!a1->sVolume.wSkipCurrent)
				{
					sosMIDISetSongVolume(a1->hSong, a1->sVolume.dwFadeVolume >> 16);
					a1->sVolume.wSkipCurrent = a1->sVolume.wSkip;
				}
				if ((a1->sVolume.wDirection & _MIDI_FADE_OUT_STOP) != 0 && !a1->sVolume.wTicks)
				{
					a1->sVolume.wFlags &= ~_ACTIVE;
					sosMIDIStopSong(a1->hSong);
					if (a1->pfnSongCallback)
						a1->pfnSongCallback(a1->hSong);
					return 0;
				}
				break;
			case _MIDI_FADE_IN:
				a1->sVolume.dwFadeVolume += a1->sVolume.dwFraction;
				if (!a1->sVolume.wSkipCurrent)
				{
					sosMIDISetSongVolume(a1->hSong, a1->sVolume.dwFadeVolume >> 16);
					a1->sVolume.wSkipCurrent = a1->sVolume.wSkip;
				}
				break;
		}
		if (!a1->sVolume.wTicks)
		{
			a1->sVolume.wFlags &= ~_ACTIVE;
			sosMIDISetSongVolume(a1->hSong, a1->sVolume.wEnd);
		}
	}
	return 1;
}

VOID sosMIDICode8End(VOID) {}


