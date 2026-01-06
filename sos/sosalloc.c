#include <stdio.h>
#include <stdlib.h>
#include <dos.h>
#include <i86.h>
#include <string.h>
#include <malloc.h>
#include "sos.h"

VOID sosModule1Start(VOID) {};

PSTR sosAlloc(W32 a1)
{
    PSTR v4;
    if (_sSOSSystem.pMemAllocFunction)
    {
        return _sSOSSystem.pMemAllocFunction(a1);
    }

    v4 = malloc(a1);
    if (v4)
    {
        if (sosDRVLockMemory((DWORD)v4, a1))
            return 0;
    }
    return v4;
}

VOID sosFree(PSTR a1, W32 a2)
{
    if (_sSOSSystem.pMemAllocFunction)
    {
        _sSOSSystem.pMemFreeFunction(a1, a2);
        return;
    }
    sosDRVUnLockMemory((DWORD)a1, a2);
    free(a1);
}

VOID sosSetMemAllocFunction ( PSTR ( *a1 )( DWORD ) )
{
    _sSOSSystem.pMemAllocFunction = a1;
}
VOID sosSetMemFreeFunction ( VOID ( *a1 )( PSTR, W32 ) )
{
    _sSOSSystem.pMemFreeFunction = a1;
}

VOID sosModule1End(VOID) {};
