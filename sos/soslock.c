#include <stdio.h>
#include <stdlib.h>
#include <dos.h>
#include <i86.h>
#include <string.h>
#include "sos.h"


VOID sosModule8Start(VOID) {}

W32 sosDIGILockLibrary(VOID)
{
    if (sosDRVLockMemory((DWORD)sosModule1Start, (DWORD)sosModule1End - (DWORD)sosModule1Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)sosModule2Start, (DWORD)sosModule2End - (DWORD)sosModule2Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)sosModule3Start, (DWORD)sosModule3End - (DWORD)sosModule3Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)sosModule4Start, (DWORD)sosModule4End - (DWORD)sosModule4Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)sosModule5Start, (DWORD)sosModule5End - (DWORD)sosModule5Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)sosModule6Start, (DWORD)sosModule6End - (DWORD)sosModule6Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)sosModule7Start, (DWORD)sosModule7End - (DWORD)sosModule7Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)sosModule8Start, (DWORD)sosModule8End - (DWORD)sosModule8Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)sosModule9Start, (DWORD)sosModule9End - (DWORD)sosModule9Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)sosModule10Start, (DWORD)sosModule10End - (DWORD)sosModule10Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)sosModule11Start, (DWORD)sosModule11End - (DWORD)sosModule11Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)sosModule12Start, (DWORD)sosModule12End - (DWORD)sosModule12Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)sosModule13Start, (DWORD)sosModule13End - (DWORD)sosModule13Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)sosModule14Start, (DWORD)sosModule14End - (DWORD)sosModule14Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)sosModule15Start, (DWORD)sosModule15End - (DWORD)sosModule15Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)sosModule16Start, (DWORD)sosModule16End - (DWORD)sosModule16Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)&_wSOSData1Start, (DWORD)&_wSOSData1End - (DWORD)&_wSOSData1Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)&_wSOSData2Start, (DWORD)&_wSOSData2End - (DWORD)&_wSOSData2Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)&_wSOSData3Start, (DWORD)&_wSOSData3End - (DWORD)&_wSOSData3Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVLockMemory((DWORD)&_wSOSData4Start, (DWORD)&_wSOSData4End - (DWORD)&_wSOSData4Start))
        return _ERR_MEMORY_FAIL;

    return _ERR_NO_ERROR;
}

W32 sosDIGIUnLockLibrary(VOID)
{
    if (sosDRVUnLockMemory((DWORD)sosModule1Start, (DWORD)sosModule1End - (DWORD)sosModule1Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)sosModule2Start, (DWORD)sosModule2End - (DWORD)sosModule2Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)sosModule3Start, (DWORD)sosModule3End - (DWORD)sosModule3Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)sosModule4Start, (DWORD)sosModule4End - (DWORD)sosModule4Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)sosModule5Start, (DWORD)sosModule5End - (DWORD)sosModule5Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)sosModule6Start, (DWORD)sosModule6End - (DWORD)sosModule6Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)sosModule7Start, (DWORD)sosModule7End - (DWORD)sosModule7Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)sosModule8Start, (DWORD)sosModule8End - (DWORD)sosModule8Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)sosModule9Start, (DWORD)sosModule9End - (DWORD)sosModule9Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)sosModule10Start, (DWORD)sosModule10End - (DWORD)sosModule10Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)sosModule11Start, (DWORD)sosModule11End - (DWORD)sosModule11Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)sosModule12Start, (DWORD)sosModule12End - (DWORD)sosModule12Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)sosModule13Start, (DWORD)sosModule13End - (DWORD)sosModule13Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)sosModule14Start, (DWORD)sosModule14End - (DWORD)sosModule14Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)sosModule15Start, (DWORD)sosModule15End - (DWORD)sosModule15Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)sosModule16Start, (DWORD)sosModule16End - (DWORD)sosModule16Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)&_wSOSData1Start, (DWORD)&_wSOSData1End - (DWORD)&_wSOSData1Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)&_wSOSData2Start, (DWORD)&_wSOSData2End - (DWORD)&_wSOSData2Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)&_wSOSData3Start, (DWORD)&_wSOSData3End - (DWORD)&_wSOSData3Start))
        return _ERR_MEMORY_FAIL;
    if (sosDRVUnLockMemory((DWORD)&_wSOSData4Start, (DWORD)&_wSOSData4End - (DWORD)&_wSOSData4Start))
        return _ERR_MEMORY_FAIL;

    return _ERR_NO_ERROR;
}

VOID sosModule8End(VOID) {}
