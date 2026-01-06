#include <stdlib.h>
#include "sosm.h"

VOID sosMIDICode12Start(VOID) {}

BOOL sosMIDILockLibrary(VOID)
{
    sosDRVLockMemory((DWORD)sosMIDICode1Start, (DWORD)sosMIDICode1End - (DWORD)sosMIDICode1Start);
    sosDRVLockMemory((DWORD)sosMIDICode2Start, (DWORD)sosMIDICode2End - (DWORD)sosMIDICode2Start);
    sosDRVLockMemory((DWORD)sosMIDICode3Start, (DWORD)sosMIDICode3End - (DWORD)sosMIDICode3Start);
    sosDRVLockMemory((DWORD)sosMIDICode4Start, (DWORD)sosMIDICode4End - (DWORD)sosMIDICode4Start);
    sosDRVLockMemory((DWORD)sosMIDICode5Start, (DWORD)sosMIDICode5End - (DWORD)sosMIDICode5Start);
    sosDRVLockMemory((DWORD)sosMIDICode6Start, (DWORD)sosMIDICode6End - (DWORD)sosMIDICode6Start);
    sosDRVLockMemory((DWORD)sosMIDICode7Start, (DWORD)sosMIDICode7End - (DWORD)sosMIDICode7Start);
    sosDRVLockMemory((DWORD)sosMIDICode8Start, (DWORD)sosMIDICode8End - (DWORD)sosMIDICode8Start);
    sosDRVLockMemory((DWORD)sosMIDICode9Start, (DWORD)sosMIDICode9End - (DWORD)sosMIDICode9Start);
    sosDRVLockMemory((DWORD)sosMIDICode10Start, (DWORD)sosMIDICode10End - (DWORD)sosMIDICode10Start);
    sosDRVLockMemory((DWORD)sosMIDICode11Start, (DWORD)sosMIDICode11End - (DWORD)sosMIDICode11Start);
    sosDRVLockMemory((DWORD)sosMIDICode12Start, (DWORD)sosMIDICode12End - (DWORD)sosMIDICode12Start);
    sosDRVLockMemory((DWORD)sosMIDICode13Start, (DWORD)sosMIDICode13End - (DWORD)sosMIDICode13Start);
    sosDRVLockMemory((DWORD)sosMIDICode14Start, (DWORD)sosMIDICode14End - (DWORD)sosMIDICode14Start);
    sosDRVLockMemory((DWORD)sosMIDICode15Start, (DWORD)sosMIDICode15End - (DWORD)sosMIDICode15Start);
    sosDRVLockMemory((DWORD)sosMIDICode16Start, (DWORD)sosMIDICode16End - (DWORD)sosMIDICode16Start);
    sosDRVLockMemory((DWORD)sosMIDICode17Start, (DWORD)sosMIDICode17End - (DWORD)sosMIDICode17Start);
    sosDRVLockMemory((DWORD)sosMIDICode18Start, (DWORD)sosMIDICode18End - (DWORD)sosMIDICode18Start);
    sosDRVLockMemory((DWORD)sosMIDICode19Start, (DWORD)sosMIDICode19End - (DWORD)sosMIDICode19Start);
    sosDRVLockMemory((DWORD)sosMIDICode20Start, (DWORD)sosMIDICode20End - (DWORD)sosMIDICode20Start);
    sosDRVLockMemory((DWORD)sosMIDICode21Start, (DWORD)sosMIDICode21End - (DWORD)sosMIDICode21Start);
    sosDRVLockMemory((DWORD)sosMIDICode22Start, (DWORD)sosMIDICode22End - (DWORD)sosMIDICode22Start);
    sosDRVLockMemory((DWORD)sosMIDICode23Start, (DWORD)sosMIDICode23End - (DWORD)sosMIDICode23Start);
    sosDRVLockMemory((DWORD)&_wCData1Start, (DWORD)&_wCData1End - (DWORD)&_wCData1Start);
    return 0;
}

BOOL sosMIDIUnLockLibrary(VOID)
{
    sosDRVUnLockMemory((DWORD)sosMIDICode1Start, (DWORD)sosMIDICode1End - (DWORD)sosMIDICode1Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode2Start, (DWORD)sosMIDICode2End - (DWORD)sosMIDICode2Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode3Start, (DWORD)sosMIDICode3End - (DWORD)sosMIDICode3Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode4Start, (DWORD)sosMIDICode4End - (DWORD)sosMIDICode4Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode5Start, (DWORD)sosMIDICode5End - (DWORD)sosMIDICode5Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode6Start, (DWORD)sosMIDICode6End - (DWORD)sosMIDICode6Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode7Start, (DWORD)sosMIDICode7End - (DWORD)sosMIDICode7Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode8Start, (DWORD)sosMIDICode8End - (DWORD)sosMIDICode8Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode9Start, (DWORD)sosMIDICode9End - (DWORD)sosMIDICode9Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode10Start, (DWORD)sosMIDICode10End - (DWORD)sosMIDICode10Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode11Start, (DWORD)sosMIDICode11End - (DWORD)sosMIDICode11Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode12Start, (DWORD)sosMIDICode12End - (DWORD)sosMIDICode12Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode13Start, (DWORD)sosMIDICode13End - (DWORD)sosMIDICode13Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode14Start, (DWORD)sosMIDICode14End - (DWORD)sosMIDICode14Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode15Start, (DWORD)sosMIDICode15End - (DWORD)sosMIDICode15Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode16Start, (DWORD)sosMIDICode16End - (DWORD)sosMIDICode16Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode17Start, (DWORD)sosMIDICode17End - (DWORD)sosMIDICode17Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode18Start, (DWORD)sosMIDICode18End - (DWORD)sosMIDICode18Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode19Start, (DWORD)sosMIDICode19End - (DWORD)sosMIDICode19Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode20Start, (DWORD)sosMIDICode20End - (DWORD)sosMIDICode20Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode21Start, (DWORD)sosMIDICode21End - (DWORD)sosMIDICode21Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode22Start, (DWORD)sosMIDICode22End - (DWORD)sosMIDICode22Start);
    sosDRVUnLockMemory((DWORD)sosMIDICode23Start, (DWORD)sosMIDICode23End - (DWORD)sosMIDICode23Start);
    sosDRVUnLockMemory((DWORD)&_wCData1Start, (DWORD)&_wCData1End - (DWORD)&_wCData1Start);
    return 0;
}

VOID sosMIDICode12End(VOID) {}
