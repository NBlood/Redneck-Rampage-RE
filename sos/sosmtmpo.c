#include <stdlib.h>
#include "sosm.h"

VOID sosMIDICode20Start(VOID) {}

W32 sosMIDISongAlterTempo(HANDLE a1, W32 a2)
{
    DWORD v4;
    DWORD v8;
    PSONG vc;
    if (a1 >= 32)
        return 10;


    vc = _sMIDISystem.pSongList[a1];

    if (!vc)
        return 10;

    if ((vc->wFlags & 0x1000) == 0)
        return 24;

    if (vc->hEvent == -1)
        return 10;

    v4 = (a2 << 16) / 100;

    v8 = (vc->wPlayRate * v4) >> 16;

    if (v8 == 0)
        v8 = 1;

    sosTIMERAlterEventRate(vc->hEvent, v8);
    return sosTIMERGetEventRate(vc->hEvent);
}

W32 sosMIDIGetSongLocation(HANDLE a1, W32 *a2, W32 *a3, W32 *a4)
{
    PSONG v4;

    if (a1 >= 32)
        return 10;

    v4 = _sMIDISystem.pSongList[a1];

    if (!v4)
        return 10;

    sosMIDICalculateLocation(v4, v4->dwTotalTicks, a2, a3, a4);
    return 0;
}

W32 sosMIDIGetTrackLocation(HANDLE a1, W32 a2, W32 *a3, W32 *a4, W32 *a5)
{
    PSONG v4;
    DWORD v8;
    PTRACK vc;

    if (a1 >= 32)
        return 10;

    v4 = _sMIDISystem.pSongList[a1];

    if (!v4)
        return 10;

    for (v8 = 0; v8 < v4->wTotalTracks; v8++)
    {
        vc = v4->pTrackList[v8];
        if (vc->wOriginalTrackIndex == a2)
            break;
    }

    sosMIDICalculateLocation(v4, vc->dwTotalTicks, a3, a4, a5);
    return 0;
}

W32 sosMIDICalculateLocation(PSONG a1, DWORD a2, W32 *a3, W32 *a4, W32 *a5)
{
    DWORD v4;
    DWORD v8;
    BYTE *vc;
    DWORD v10;
    DWORD v14;
    DWORD v18;
    DWORD v1c;
    DWORD v20;
    BYTE *v24;
    DWORD v28;
    DWORD v2c;
    DWORD v30;
    DWORD v34;
    DWORD v38;
    DWORD v3c;

    v4 = 0;
    v28 = 0;
    v2c = 0;
    v30 = 0;
    v38 = 0;
    v8 = a2;
    vc = a1->pTempoChangeList;
    v1c = *vc++;

    vc += 4;
    while (v8 && --v1c != -1)
    {
        v14 = *(DWORD*)vc;
        vc += 4;
        if (v1c)
        {
            v10 = *(DWORD*)vc;
            vc += 4;
        }
        else
            v10 = -1;

        if (v10 > v8)
            v10 = v8;

        v8 -= v10;


        v18 = (((a1->wTicksPerQuarterNote * v14) / 60) << 16) / a1->wPlayRate;

        v4 += (v18 * v10) >> 16;
    }

    v24 = a1->pTimeChangeList;
    v20 = *v24++;
    v24 += 4;
    while (v4 && --v20 != -1)
    {
        v3c = *(DWORD*)v24;
        v24 += 4;
        if (v20)
        {
            v10 = *(DWORD*)v24;
            v24 += 4;
        }
        else
            v10 = -1;

        v10 -= v38;

        v38 += v10;

        if (v10 > v4)
            v10 = v4;

        v4 -= v10;

        v34 = (v10 << 16) / a1->wTicksPerQuarterNote / v3c;

        v28 += v34;
        if (!v4 || !v20)
        {
            v10 -= (v34 * v3c * a1->wTicksPerQuarterNote) >> 16;
            v2c = v10 / a1->wTicksPerQuarterNote;
            v10 -= v2c * a1->wTicksPerQuarterNote;
            v30 = v10;
        }

    }

    *a3 = v28;
    *a4 = v2c;
    *a5 = v30;
    return 0;
}

VOID sosMIDICode20End(VOID) {}
