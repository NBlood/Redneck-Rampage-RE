#include <stdlib.h>
#include "sosm.h"

VOID sosMIDICode21Start(VOID) {}

BOOL sosMIDIInitTrack(PSONG a1, PTRACK a2)
{
    DWORD v4;
    DWORD v8;
    BYTE *vc;
    DWORD v10;

    a2->wFlags |= 0x10;
    a2->pSong = a1;

    if (!(a2->wFlags & 0x1000))
    {
        if (sosMIDIMapTrack(a2))
            return 1;

        switch (_sMIDIDriver[a2->hDriver].wID)
        {
            case 0xa005:
                if (sosMIDILoadTriggeredPatches(a2->hDriver, a2))
                    return 1;
                break;
        }
    }

    a2->pDriverChannel = _sMIDIDriver[a2->hDriver].pChannel;

    a2->pStealNext = 0;
    a2->dwTotalTicks = 0;
    if (a2->wFlags & 0x1000)
    {
        a2->pData = a2->pDataInit;
    }
    else
    {
        a2->pDataInit = (DWORD)a2 + (BYTE*)a2->pDataInit;
        a2->pData = a2->pDataInit;
        a2->pTrackChannel = (DWORD)a2 + (BYTE*)a2->pTrackChannel;
        if (a2->pTrackNames)
            a2->pTrackNames = (DWORD)a2 + (BYTE*)a2->pTrackNames;
        if (a2->sBranch.pBranchList)
        {
            a2->sBranch.pBranchList = (DWORD)a2 + (BYTE*)a2->sBranch.pBranchList;
            v8 = *(BYTE*)a2->sBranch.pBranchList;
            vc = (BYTE*)a2->sBranch.pBranchList + 1;
            for (v4 = 0; v4 < v8; v4++)
            {
                vc += 2;

                *(DWORD*)vc += (DWORD)a2;
                vc += 4;
            }
        }
    }

    a2->pData += sosMIDIGetDeltaTime(a2->pData, &a2->dwDelta);

    a2->wFlags |= 0x9000;
    a2->sBranch.dwCtrlFlags[0] = 0xff;
    a2->sBranch.dwCtrlFlags[1] = 0xff;
    a2->sBranch.dwCtrlFlags[2] = 0xff;
    a2->sBranch.dwCtrlFlags[3] = 0xff;

    return 0;
}

VOID sosMIDIStealTrackListInsert(PTRACK a1)
{
    PTRACK v4;
    int v8;
    PTRACK* vc;
    if (!_sMIDISystem.pStealList)
    {
        _sMIDISystem.pStealList = a1;
        a1->pStealNext = 0;
        a1->wFlags |= 0x20;
        return;
    }

    v4 = _sMIDISystem.pStealList;
    vc = &_sMIDISystem.pStealList;
    while (v4 && a1->sSteal.wPriority >= v4->sSteal.wPriority)
    {
        vc = &v4->pStealNext;
        v4 = v4->pStealNext;
    }
    if ((a1->wFlags & 0x20) == 0)
    {
        a1->pStealNext = *vc;
        *vc = a1;
    }
    a1->wFlags |= 0x20;
}

PTRACK sosMIDIStealTrackListRetreive(VOID)
{
    PTRACK v4;

    v4 = _sMIDISystem.pStealList;
    while (v4 && (v4->wFlags & 0x8010) == 0)
    {
        v4 = v4->pStealNext;
    }
    if (v4)
    {
        _sMIDISystem.pStealList = v4->pStealNext;
        v4->wFlags &= ~0x20;
    }
    return v4;
}

PTRACK sosMIDIStealTrackListRemove(PTRACK a1)
{
    PTRACK v4;
    PTRACK *v8;

    v4 = _sMIDISystem.pStealList;
    v8 = &_sMIDISystem.pStealList;
    while (v4 && a1 != v4)
    {
        v8 = &v4->pStealNext;
        v4 = v4->pStealNext;
    }
    if (v4)
    {
        *v8 = v4->pStealNext;
        a1->wFlags &= ~0x20;
    }
    return v4;
}

VOID sosMIDIAddTrack(PSONG a1, PTRACK a2)
{
    PTRACK v4;
    PTRACK v8;
    PTRACK *vc;

    v4 = a1->pTrackFirst;
    vc = &a1->pTrackFirst;
    v8 = &a1->pTrackFirst;

    while (v4 && a2->wTrackIndex > v4->wTrackIndex)
    {
        vc = &v4->pNext;
        v8 = v4;
        v4 = v4->pNext;
    }
    a2->pNext = *vc;
    a2->pPrev = v8;
    *vc = a2;
    a2->wFlags |= 0x8000;
}

VOID sosMIDICode21End(VOID) {}
