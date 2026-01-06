#include <stdlib.h>
#include <stdio.h>
#include <dos.h>
#include <i86.h>
#include <io.h>
#include <sys\stat.h>
#include <sys\types.h>
#include "sos.h"

VOID sosModule11Start(VOID) {}

W32 sosTIMERInitSystem(W32 a1, W32 a2)
{
    if (a2 & _SOS_TIMER_DPMI)
        _bTIMERDPMI = 1;
    else
        _bTIMERDPMI = 0;
    if (!(a2 & _SOS_DEBUG_NO_TIMER))
    {
        _bTIMERInstalled = 1;
        _sTIMERSystem.wFlags |= _SOS_TIMER_INITIALIZED;
        sosTIMERDRVDisable();
        sosTIMERDRVInit(0xffff, sosTIMERHandler);
        sosTIMERDRVEnable();
    }
    else
        _sTIMERSystem.wFlags &= ~_SOS_TIMER_INITIALIZED;

    if (a1 && !(a2 & _SOS_DEBUG_NO_TIMER))
    {
        if (a1 == _TIMER_DOS_RATE)
        {
            sosTIMERSetRate(0xffff);
            _sTIMERSystem.wEventRate[_TIMER_MAX_EVENTS - 1] = _TIMER_DOS_RATE;
        }
        else
        {
            sosTIMERSetRate(1193180 / a1);
            _sTIMERSystem.wEventRate[_TIMER_MAX_EVENTS - 1] = a1;
        }
        _sTIMERSystem.pfnEvent[_TIMER_MAX_EVENTS - 1] = sosTIMEROldHandler;
        _sTIMERSystem.dwAdditiveFraction[_TIMER_MAX_EVENTS - 1] = 0x10000;
    }
    else
        _sTIMERSystem.wChipDivisor = 0xffff;
    return _ERR_NO_ERROR;
}

W32 sosTIMERUnInitSystem(W32 a1)
{
    if (_sTIMERSystem.wFlags & _SOS_TIMER_INITIALIZED)
    {
        sosTIMERDRVDisable();
        sosTIMERDRVUnInit();
        sosTIMERDRVEnable();
    }
    return _ERR_NO_ERROR;
}

W32 sosTIMERRegisterEvent(W32 a1, VOID(*a2)(VOID),
    HANDLE *a3)
{
    DWORD v4;
    DWORD v8;
    DWORD vc;
    DWORD v10;

    vc = 0;

    for (v4 = 0; v4 < _TIMER_MAX_EVENTS; v4++)
    {
        if (!_sTIMERSystem.pfnEvent[v4])
            break;
    }
    if (v4 >= _TIMER_MAX_EVENTS)
        return _ERR_NO_HANDLES;
    if (_sTIMERSystem.wFlags & _SOS_TIMER_INITIALIZED)
    {
        sosTIMERDRVDisable();
    }

    v8 = v4;
    _sTIMERSystem.pfnEvent[v4] = a2;
    _sTIMERSystem.wEventRate[v4] = a1;

    if (1193180 / a1 < _sTIMERSystem.wChipDivisor)
    {
        sosTIMERSetRate(1193180 / a1);
        vc = (_sTIMERSystem.wChipDivisor << 16) / (1193180 / a1);
    }
    for (v4 = 0; v4 < _TIMER_MAX_EVENTS; v4++)
    {
        if (_sTIMERSystem.pfnEvent[v4])
        {
            if (_sTIMERSystem.wEventRate[v4] == _TIMER_DOS_RATE)
            {
                if (_sTIMERSystem.wChipDivisor == 0xffff)
                    _sTIMERSystem.dwAdditiveFraction[v4] = 0x10000;
                else
                    _sTIMERSystem.dwAdditiveFraction[v4] =
                    1192755 / (1193180 / _sTIMERSystem.wChipDivisor);
            }
            else
            {
                _sTIMERSystem.dwAdditiveFraction[v4] =
                    (_sTIMERSystem.wEventRate[v4] << 16) / (1193180 / _sTIMERSystem.wChipDivisor);
            }

            if (vc)
            {
                v10 = (_sTIMERSystem.dwCurrentSummation[v4] * (vc & 0xffff)) >> 16;
                v10 += (_sTIMERSystem.dwCurrentSummation[v4] * (vc >> 16)) >> 16;
                _sTIMERSystem.dwCurrentSummation[v4] = v10;
            }
        }
    }
    if (_sTIMERSystem.wFlags & _SOS_TIMER_INITIALIZED)
    {
        sosTIMERDRVEnable();
    }
    *a3 = v8;
    return _ERR_NO_ERROR;
}

W32 sosTIMERAlterEventRate(HANDLE a1, W32 a2)
{
    DWORD v4;
    if (a1 >= _TIMER_MAX_EVENTS)
        return _ERR_INVALID_HANDLE;
    if (_sTIMERSystem.pfnEvent[a1])
    {
        if (_sTIMERSystem.wFlags & _SOS_TIMER_INITIALIZED)
        {
            sosTIMERDRVDisable();
        }

        _sTIMERSystem.wEventRate[a1] = a2;

        if (1193180 / a2 < _sTIMERSystem.wChipDivisor)
        {
            sosTIMERSetRate(1193180 / a2);
        }
        for (v4 = 0; v4 < _TIMER_MAX_EVENTS; v4++)
        {
            if (_sTIMERSystem.pfnEvent[v4])
            {
                if (_sTIMERSystem.wEventRate[v4] == _TIMER_DOS_RATE)
                {
                    if (_sTIMERSystem.wChipDivisor == 0xffff)
                        _sTIMERSystem.dwAdditiveFraction[v4] = 0x10000;
                    else
                        _sTIMERSystem.dwAdditiveFraction[v4] =
                        1192755 / (1193180 / _sTIMERSystem.wChipDivisor);
                }
                else
                {
                    _sTIMERSystem.dwAdditiveFraction[v4] =
                        (_sTIMERSystem.wEventRate[v4] << 16) / (1193180 / _sTIMERSystem.wChipDivisor);
                }
                _sTIMERSystem.dwCurrentSummation[v4] = 0;
            }
        }
        if (_sTIMERSystem.wFlags & _SOS_TIMER_INITIALIZED)
        {
            sosTIMERDRVEnable();
        }
    }
    else
        return _ERR_INVALID_HANDLE;

    return _ERR_NO_ERROR;
}

W32 sosTIMERRemoveEvent(HANDLE a1)
{
    DWORD v4;
    DWORD v8;

    v8 = 0;
    _sTIMERSystem.pfnEvent[a1] = NULL;
    for (v4 = 0; v4 < _TIMER_MAX_EVENTS; v4++)
    {
        if (_sTIMERSystem.pfnEvent[v4])
        {
            if (_sTIMERSystem.wEventRate[v4] > v8 && _sTIMERSystem.wEventRate[v4] != 0xff00)
            {
                v8 = _sTIMERSystem.wEventRate[v4];
            }
        }
    }
    if (v8)
    {
        sosTIMERSetRate(1193180 / v8);
    }
    else
        sosTIMERSetRate(0xffff);
    if (_sTIMERSystem.wFlags & _SOS_TIMER_INITIALIZED)
    {
        sosTIMERDRVDisable();
    }
    for (v4 = 0; v4 < _TIMER_MAX_EVENTS; v4++)
    {
        if (_sTIMERSystem.pfnEvent[v4])
        {
            if (_sTIMERSystem.wEventRate[v4] == _TIMER_DOS_RATE)
            {
                if (_sTIMERSystem.wChipDivisor == 0xffff)
                    _sTIMERSystem.dwAdditiveFraction[v4] = 0x10000;
                else
                    _sTIMERSystem.dwAdditiveFraction[v4] =
                    1192755 / (1193180 / _sTIMERSystem.wChipDivisor);
            }
            else
            {
                _sTIMERSystem.dwAdditiveFraction[v4] =
                    (_sTIMERSystem.wEventRate[v4] << 16) / (1193180 / _sTIMERSystem.wChipDivisor);
            }
            _sTIMERSystem.dwCurrentSummation[v4] = 0;
        }
    }
    if (_sTIMERSystem.wFlags & _SOS_TIMER_INITIALIZED)
    {
        sosTIMERDRVEnable();
    }
    return _ERR_NO_ERROR;
}

W32 sosTIMERGetEventRate(HANDLE a1)
{
    return _sTIMERSystem.wEventRate[a1];
}

W32 sosTIMERSetRate(HANDLE a1)
{
    _sTIMERSystem.wChipDivisor = a1;
    sosTIMERDRVSetRate(a1);
    return _ERR_NO_ERROR;
}

VOID sosTIMERHandler(VOID)
{
    DWORD v4;

    for (v4 = 0; v4 < _TIMER_MAX_EVENTS; v4++)
    {
        if (_sTIMERSystem.pfnEvent[v4])
        {
            _sTIMERSystem.dwCurrentSummation[v4] += _sTIMERSystem.dwAdditiveFraction[v4];
            if (_sTIMERSystem.dwCurrentSummation[v4] & 0x10000)
            {
                _sTIMERSystem.dwCurrentSummation[v4] &= 0xffff;
                if (_sTIMERSystem.wMIDIEventSongHandle[v4] != 0xff)
                    _sTIMERSystem.wMIDIActiveSongHandle = _sTIMERSystem.wMIDIEventSongHandle[v4];
                _sTIMERSystem.pfnEvent[v4]();
            }
        }
    }
}

VOID sosTIMEROldHandler(VOID)
{
    sosTIMERDRVCallOld();
}

VOID sosModule11End(VOID) {}
