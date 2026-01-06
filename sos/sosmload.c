#include <stdlib.h>
#include <dos.h>
#include <i86.h>
#include <io.h>
#include <sys\stat.h>
#include <sys\types.h>
#include <fcntl.h>
#include <string.h>
#include "sosm.h"

VOID sosMIDICode11Start(VOID) {}

W32 sosMIDILoadDriver(W32 a1, HANDLE a2, LPSTR *a3, LPSTR *a4, PSTR a5,
    PSTR a6, DWORD *a7)
{
    int v4;
    DWORD v8;
    DWORD vc;
    DWORD v10;
    DWORD v14;
    
    BYTE far * v34;
    BYTE far * v3c;

    DWORD v1c;

    vc = 0;
    v10 = 0;
    if (a2 >= 8)
        return 10;

    if (_sMIDIDriver[a2].wFlags & 0x100)
        return 9;

    if (a1 < 0xa000 || a1 > 0xa200)
        return 6;
    strcpy(_sMIDISystem.szPathTemp, _sMIDISystem.szPath);
    strcat(_sMIDISystem.szPathTemp, "HMIMDRV.386");
    
    v4 = open(_sMIDISystem.szPathTemp, 0x200);
    if (v4 == -1)
        return 15;

    read(v4, &_sMIDIDriver[a2].sDriverHeader, 0x30);

    while (v10 <= _sMIDIDriver[a2].sDriverHeader.dwNext && !vc)
    {
        read(v4, &_sMIDIDriver[a2].sDriverHeader, 0x30);
        v8 = _sMIDIDriver[a2].sDriverHeader.wSize;
        if (_sMIDIDriver[a2].sDriverHeader.wID == a1)
        {
            vc = 1;
            v3c = sosAllocateFarMem(v8 + 16, a5, &v1c);
            if (!v3c)
                return 5;
            v34 = sosCreateAliasCS(v3c);
            sosDRVLockMemory(v1c, v8);

            _dos_read(v4, v3c, v8, &v14);

            *a3 = v34;
            *a4 = v3c;
            *a6 = v8;
            *a7 = v1c;
        }
        else
            lseek(v4, v8, SEEK_CUR);

        v10++;
    }
    close(v4);
    if (!vc)
        return 7;
    return 0;
}

W32 sosMIDIUnLoadDriver(HANDLE a1)
{
    if (a1 >= 8)
        return 10;
    sosDRVUnLockMemory(_sMIDIDriver[a1].dwLinear, _sMIDIDriver[a1].wSize);
    sosFreeSelector(_sMIDIDriver[a1].lpCS, _sMIDIDriver[a1].hMemory);
    sosFreeSelector(_sMIDIDriver[a1].lpDS, _sMIDIDriver[a1].hMemory);
    return 0;
}

VOID sosMIDICode11End(VOID) {}