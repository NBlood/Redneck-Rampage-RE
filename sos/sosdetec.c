#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dos.h>
#include <i86.h>
#include <io.h>
#include <sys\stat.h>
#include <sys\types.h>
#include <fcntl.h>
#include "sos.h"

VOID sosModule4Start(VOID) {}

W32 sosDIGIDetectInit(PSTR a1)
{
    int v1;
    int v2;
    if (_sDETSystem.wFlags & _SOS_DET_SYSTEM_INITIALIZED)
    {
        return _ERR_DETECT_INITIALIZED;
    }

    if (a1)
    {
        strcpy(_sDETSystem.szTempDriverPath, a1);
        strcat(_sDETSystem.szTempDriverPath, "hmidet.386");
    }
    else
        strcpy(_sDETSystem.szTempDriverPath, "hmidet.386");

    _sDETSystem.hFile = open(_sDETSystem.szTempDriverPath, O_BINARY);

    if (_sDETSystem.hFile == -1)
        return _ERR_DRV_FILE_FAIL;

    read(_sDETSystem.hFile, &_sDETSystem.sFileHeader, sizeof(_SOS_DRV_FILEHEADER));

    _sDETSystem.lpBufferDS = sosAllocateFarMem(4096, &_sDETSystem.hMemory, &_sDETSystem.dwLinear);

    if (!_sDETSystem.lpBufferDS)
    {
        return _ERR_MEMORY_FAIL;
    }

    _sDETSystem.lpBufferCS = sosCreateAliasCS(_sDETSystem.lpBufferDS);

    if (sosDRVLockMemory(_sDETSystem.dwLinear, 4096))
        return _ERR_MEMORY_FAIL;

    lseek(_sDETSystem.hFile, 0, SEEK_SET);
    _sDETSystem.wFlags |= _SOS_DET_SYSTEM_INITIALIZED;
    return _ERR_NO_ERROR;
}

W32 sosDIGIDetectUnInit(VOID)
{
    _sDETSystem.wFlags &= ~_SOS_DET_SYSTEM_INITIALIZED;
    close(_sDETSystem.hFile);
    if (sosDRVUnLockMemory(_sDETSystem.dwLinear, 4096))
        return _ERR_MEMORY_FAIL;

    sosFreeSelector(_sDETSystem.lpBufferDS, _sDETSystem.hMemory);
    sosFreeSelector(_sDETSystem.lpBufferCS, _sDETSystem.hMemory);

    return _ERR_NO_ERROR;
}

W32 sosDIGIDetectFindHardware(W32 a1, PSOSDIGIDRIVER a2)
{
    DWORD v4;
    DWORD v8;
    DWORD vc;
    DWORD v10;
    DWORD v14;
    DWORD v18;
    char *v1c;

    v4 = 0;
    v8 = 0;
    v18 = 0;
    v1c = 0;

    if (!a2)
        return _ERR_INVALID_POINTER;
    if (a1 < 0xe000 || a1 > 0xe200)
        return _ERR_INVALID_DRIVER_ID;

    _sDETSystem.wDriverIndexCur = 0;
    lseek(_sDETSystem.hFile, 0, SEEK_SET);
    read(_sDETSystem.hFile, &_sDETSystem.sFileHeader, sizeof(_SOS_DRV_FILEHEADER));
    while (_sDETSystem.wDriverIndexCur <= _sDETSystem.sFileHeader.wDrivers && !v4)
    {
        vc = lseek(_sDETSystem.hFile, 0, SEEK_CUR);
        read(_sDETSystem.hFile, &_sDETSystem.sDriverHeader, sizeof(_SOS_DRV_DRIVERHEADER));
        v14 = _sDETSystem.sDriverHeader.wSize;
        if (_sDETSystem.sDriverHeader.wDeviceID == a1
            && (_sDETSystem.sDriverHeader.wExtenderType & _SOS_RATIONAL))
        {
            v4 = 1;
            _dos_read(_sDETSystem.hFile, _sDETSystem.lpBufferDS, v14, &v10);
        }
        else
            lseek(_sDETSystem.hFile, v14, SEEK_CUR);
        _sDETSystem.wDriverIndexCur++;
    }

    if (v4)
    {
        sosDetDRVGetCapsInfo(_sDETSystem.lpBufferCS, _sDETSystem.lpBufferDS, &_sDETSystem.sCaps);
        if (_sDETSystem.sCaps.wFlags & _SOS_DCAPS_ENV_NEEDED)
        {
            sosDetDRVEnvStringInit(_sDETSystem.lpBufferCS, _sDETSystem.lpBufferDS);
            v18 = 0;
            while (sosDetDRVGetEnvString(v18))
            {
                v1c = getenv(sosDetDRVGetEnvString(v18));
                sosDetDRVSetEnvString(v18, v1c);
                v18++;
            }
        }

        v8 = sosDetDRVExist(_sDETSystem.lpBufferCS, _sDETSystem.lpBufferDS);
        if (v8)
        {
            sosDetDRVGetCapsInfo(_sDETSystem.lpBufferCS, _sDETSystem.lpBufferDS, &a2->sCaps);
            _sDETSystem.pCaps = &a2->sCaps;
            a2->sHardware.wPort = v8;
            a2->wID = a2->sCaps.wID;
            _sDETSystem.dwDriverIndex = vc;
            return _ERR_NO_ERROR;
        }
        else
            return _ERR_DETECTION_FAILURE;
    }
    return _ERR_NO_DRIVER_FOUND;
}

W32 sosDIGIDetectGetCaps(W32 a1, PSOSDIGIDRIVER a2)
{
    DWORD v4;
    DWORD v8;
    DWORD vc;
    DWORD v10;

    v8 = 0;
    if (!a2)
        return _ERR_INVALID_POINTER;
    if (a1 < 0xe000 || a1 > 0xe200)
        return _ERR_INVALID_DRIVER_ID;

    _sDETSystem.wDriverIndexCur = 0;
    lseek(_sDETSystem.hFile, 0, SEEK_SET);
    read(_sDETSystem.hFile, &_sDETSystem.sFileHeader, sizeof(_SOS_DRV_FILEHEADER));
    while (_sDETSystem.wDriverIndexCur <= _sDETSystem.sFileHeader.wDrivers && !v8)
    {
        vc = lseek(_sDETSystem.hFile, 0, SEEK_CUR);
        read(_sDETSystem.hFile, &_sDETSystem.sDriverHeader, sizeof(_SOS_DRV_DRIVERHEADER));
        v4 = _sDETSystem.sDriverHeader.wSize;
        if (_sDETSystem.sDriverHeader.wDeviceID == a1
            && (_sDETSystem.sDriverHeader.wExtenderType & _SOS_RATIONAL))
        {
            v8 = 1;
            _dos_read(_sDETSystem.hFile, _sDETSystem.lpBufferDS, v4, &v10);
        }
        else
            lseek(_sDETSystem.hFile, v4, SEEK_CUR);
        _sDETSystem.wDriverIndexCur++;
    }
    if (v8)
    {
        sosDetDRVGetCapsInfo(_sDETSystem.lpBufferCS, _sDETSystem.lpBufferDS, &a2->sCaps);
        _sDETSystem.pCaps = &a2->sCaps;
        _sDETSystem.dwDriverIndex = vc;
        return _ERR_NO_ERROR;
    }
    return _ERR_NO_DRIVER_FOUND;
}

W32 sosDIGIDetectFindFirst(PSOSDIGIDRIVER a1)
{
    DWORD v4;
    DWORD v8;
    DWORD vc;
    DWORD v10;
    DWORD v14;
    DWORD v18;
    char *v1c;

    v8 = 0;
    vc = 0;
    v18 = 0;
    v1c = 0;
    if (!a1)
        return _ERR_INVALID_POINTER;

    vc = 0;
    _sDETSystem.wDriverIndexCur = 0;
    lseek(_sDETSystem.hFile, 0, SEEK_SET);
    read(_sDETSystem.hFile, &_sDETSystem.sFileHeader, sizeof(_SOS_DRV_FILEHEADER));
    while (_sDETSystem.wDriverIndexCur <= _sDETSystem.sFileHeader.wDrivers && !v8)
    {
        v10 = lseek(_sDETSystem.hFile, 0, SEEK_CUR);
        read(_sDETSystem.hFile, &_sDETSystem.sDriverHeader, sizeof(_SOS_DRV_DRIVERHEADER));
        v4 = _sDETSystem.sDriverHeader.wSize;
        if (_sDETSystem.sDriverHeader.wExtenderType & _SOS_RATIONAL)
        {
            _dos_read(_sDETSystem.hFile, _sDETSystem.lpBufferDS, v4, &v14);
            sosDetDRVGetCapsInfo(_sDETSystem.lpBufferCS, _sDETSystem.lpBufferDS, &_sDETSystem.sCaps);
            if (_sDETSystem.sCaps.wFlags & _SOS_DCAPS_ENV_NEEDED)
            {
                sosDetDRVEnvStringInit(_sDETSystem.lpBufferCS, _sDETSystem.lpBufferDS);
                v18 = 0;
                while (sosDetDRVGetEnvString(v18))
                {
                    v1c = getenv(sosDetDRVGetEnvString(v18));
                    sosDetDRVSetEnvString(v18, v1c);
                    v18++;
                }
            }

            vc = sosDetDRVExist(_sDETSystem.lpBufferCS, _sDETSystem.lpBufferDS);
            if (vc)
            {
                _sDETSystem.dwDriverIndex = v10;
                sosDetDRVGetCapsInfo(_sDETSystem.lpBufferCS, _sDETSystem.lpBufferDS, &a1->sCaps);
                _sDETSystem.pCaps = &a1->sCaps;
                a1->sHardware.wPort = vc;
                a1->wID = a1->sCaps.wID;
                return _ERR_NO_ERROR;
            }
        }
        else
            lseek(_sDETSystem.hFile, v4, SEEK_CUR);
        _sDETSystem.wDriverIndexCur++;
    }
    return _ERR_NO_DRIVER_FOUND;
}

W32 sosDIGIDetectFindNext(PSOSDIGIDRIVER a1)
{
    DWORD v4;
    DWORD v8;
    DWORD vc;
    DWORD v10;
    DWORD v14;
    DWORD v18;
    char* v1c;


    v8 = 0;
    vc = 0;
    v18 = 0;
    v1c = 0;
    if (!a1)
        return _ERR_INVALID_POINTER;

    vc = 0;
    while (_sDETSystem.wDriverIndexCur <= _sDETSystem.sFileHeader.wDrivers && !v8)
    {
        v10 = lseek(_sDETSystem.hFile, 0, SEEK_CUR);
        read(_sDETSystem.hFile, &_sDETSystem.sDriverHeader, sizeof(_SOS_DRV_DRIVERHEADER));
        v4 = _sDETSystem.sDriverHeader.wSize;
        if (_sDETSystem.sDriverHeader.wExtenderType & _SOS_RATIONAL)
        {
            _dos_read(_sDETSystem.hFile, _sDETSystem.lpBufferDS, v4, &v14);
            sosDetDRVGetCapsInfo(_sDETSystem.lpBufferCS, _sDETSystem.lpBufferDS, &_sDETSystem.sCaps);
            if (_sDETSystem.sCaps.wFlags & _SOS_DCAPS_ENV_NEEDED)
            {
                sosDetDRVEnvStringInit(_sDETSystem.lpBufferCS, _sDETSystem.lpBufferDS);
                v18 = 0;
                while (sosDetDRVGetEnvString(v18))
                {
                    v1c = getenv(sosDetDRVGetEnvString(v18));
                    sosDetDRVSetEnvString(v18, v1c);
                    v18++;
                }
            }

            vc = sosDetDRVExist(_sDETSystem.lpBufferCS, _sDETSystem.lpBufferDS);
            if (vc)
            {
                _sDETSystem.dwDriverIndex = v10;
                sosDetDRVGetCapsInfo(_sDETSystem.lpBufferCS, _sDETSystem.lpBufferDS, &a1->sCaps);
                _sDETSystem.pCaps = &a1->sCaps;
                a1->sHardware.wPort = vc;
                a1->wID = a1->sCaps.wID;
                return _ERR_NO_ERROR;
            }
        }
        else
            lseek(_sDETSystem.hFile, v4, SEEK_CUR);
        _sDETSystem.wDriverIndexCur++;
    }
    return _ERR_NO_DRIVER_FOUND;
}

W32 sosDIGIDetectGetSettings(PSOSDIGIDRIVER a1)
{
    DWORD v4;

    if (!a1)
        return _ERR_INVALID_POINTER;
    lseek(_sDETSystem.hFile, _sDETSystem.dwDriverIndex, SEEK_SET);
    v4 = 0;
    while (a1->sCaps.lpDMAList[v4] != (short)-1)
    {
        sosDIGIInitForWindows(a1->sCaps.lpDMAList[v4]);
        v4++;
    }
    sosDetDRVGetSettings(_sDETSystem.lpBufferCS, _sDETSystem.lpBufferDS);

    v4 = 0;
    while (a1->sCaps.lpDMAList[v4] != (short)-1)
    {
        sosDIGIUnInitForWindows(a1->sCaps.lpDMAList[v4]);
        v4++;
    }

    a1->sHardware.wPort = wDetectPort;
    a1->sHardware.wDMA = wDetectDMA;
    a1->sHardware.wIRQ = wDetectIRQ;
    a1->sHardware.wParam = wDetectParam;
    if (!(a1->sCaps.wFlags & _SOS_DCAPS_AUTO_REINIT))
    {
        if (wDetectIRQ > 1 && wDetectIRQ < 16)
            return _ERR_NO_ERROR;
        return _ERR_INVALID_IRQ;
    }
    return _ERR_NO_ERROR;
}

W32 sosDIGIDetectVerifySettings(PSOSDIGIDRIVER a1)
{
    DWORD v4;
    DWORD v8;
    DWORD vc;
    DWORD v10;
    DWORD v14;
    W32 v18;

    if (!a1)
        return _ERR_INVALID_POINTER;

    v4 = a1->sHardware.wPort;
    vc = a1->sHardware.wDMA;
    v8 = a1->sHardware.wIRQ;
    if (!(a1->sCaps.wFlags & _SOS_DCAPS_AUTO_REINIT))
    {
        if (v8 < 2 || v8 > 15)
            return _ERR_INVALID_IRQ;
    }

    sosDIGIInitForWindows(a1->sHardware.wDMA);
    v18 = sosDetDRVVerifySettings(_sDETSystem.lpBufferCS, v4, v8, vc, _sDETSystem.lpBufferDS);
    sosDIGIUnInitForWindows(a1->sHardware.wDMA);
    return v18;
}

VOID sosModule4End(VOID) {}
