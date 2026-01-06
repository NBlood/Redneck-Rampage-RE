#include "sosm.h"

W32 _wCData1Start = 0;
_MIDI_SYSTEM  _sMIDISystem = { 0 };
W32 ( cdecl far * _lpMIDICBCKFunctions[_MIDI_DRV_FUNCTIONS] )( LPSTR, W32, W32 ) = { 0 };
W32 ( cdecl far * _lpMIDIDIGIFunctions[_MIDI_DRV_FUNCTIONS] )( LPSTR, W32, W32 ) = { 0 };
W32 ( cdecl far * _lpMIDIWAVEFunctions[_MIDI_DRV_FUNCTIONS] )( LPSTR, W32, W32 ) = { 0 };
W32 _wMIDIDriverTotalChannels[_MIDI_DEFINED_DRIVERS] = { 16, 16, 16, 16, 7, 16, 16, 16, 16, 16, 16 };
W32 _wMIDIDriverChannel[ _MIDI_DEFINED_DRIVERS ][ _MIDI_MAX_CHANNELS ] = {
	0, 1, 2, 3, 4, 5, 6, 7, 8, -1, 10, 11, 12, 13, 14, 15,
	0, 1, 2, 3, 4, 5, 6, 7, 8, -1, 10, 11, 12, 13, 14, 15,
	0, 1, 2, 3, 4, 5, 6, 7, 8, -1, 10, 11, 12, 13, 14, 15,
	0, 1, 2, 3, 4, 5, 6, 7, 8, -1, 10, 11, 12, 13, 14, 15,
	1, 2, 3, 4, 5, 6, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 1, 2, 3, 4, 5, 6, 7, 8, -1, 10, 11, 12, 13, 14, 15,
	0, 1, 2, 3, 4, 5, 6, 7, 8, -1, 10, 11, 12, 13, 14, 15,
	0, 1, 2, 3, 4, 5, 6, 7, 8, -1, 10, 11, 12, 13, 14, 15,
	0, 1, 2, 3, 4, 5, 6, 7, 8, -1, 10, 11, 12, 13, 14, 15,
	0, 1, 2, 3, 4, 5, 6, 7, 8, -1, 10, 11, 12, 13, 14, 15,
	0, 1, 2, 3, 4, 5, 6, 7, 8, -1, 10, 11, 12, 13, 14, 15,
};
_MIDI_DRIVER  _sMIDIDriver[_MIDI_MAX_DRIVERS] = { 0 };
VOID ( cdecl far * _lpMIDICBCKFunction )( LPSTR, W32, W32 ) = 0;
_MIDI_DIGI_CHANNEL _sMIDIDIGIChannel[8] = {
	127, 0, 0, 127, 0, 0, 127, 0, 0, 127, 0, 0,
	127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};
_MIDI_DIGI_SYSTEM _sSOSMIDIDIGIDriver[8];
_MIDI_DIGI_QUEUE _sSOSMIDIDIGIQueue[1]; 
W32 _wCData1End = 0;