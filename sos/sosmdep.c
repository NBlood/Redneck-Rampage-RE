#include <stdlib.h>
#include <string.h>
#include "sosm.h"

VOID sosMIDICode4Start( VOID ) { }

W32 sosMIDIInitDependencyList ( PSONG a1, PSTR * a2 )
{
    int v8;
    int v4;
    PSTR vc;
    PSTR v10;
    PTRACK v14;
    PTRACK v18;
    PSTR v1c;
    int v20;
    int v24;
    PSTR v28;

    vc = sosAlloc(a1->wActiveTracks * 5 + 1);

    if (!vc)
    {
        return _ERR_MEMORY_FAIL;
    }

    *a2 = vc;

    v10 = vc++;
    *v10 = 0;

    v14 = a1->pTrackFirst;
    while (v14)
    {
        if ((v14->wFlags & _MAPPED) == 0)
        {
            v10[0]++;
            v1c = vc++;
            *v1c = 0;
            v24 = v14->sSteal.wRawChannel;
            v20 = v14->hDriver;
            v28 = v14->pTrackChannel;
            v18 = a1->pTrackFirst;
            while (v18)
            {
                if ((v18->wFlags & _MAPPED) == 0)
                {
                    if (v18->hDriver == v20 && v18->sSteal.wRawChannel == v24)
                    {
                        v18->wFlags |= _MAPPED;
                        v1c[0]++;
                        v18->pTrackChannel = v28;
                        *((DWORD*)a1->pDependencyPtrs + v18->wTrackIndex) = v1c;
                        v18->pTrackDependencyList = v1c;
                        *(PSTR*)vc = v18;
                        v18->pDependentTrack = *(PTRACK*)(v1c + 1);
                        vc += 4;
                    }
                }
                v18 = v18->pNext;
            }
        }
        v14 = v14->pNext;
    }
    return _ERR_NO_ERROR;
}

VOID sosMIDICode4End( VOID ) { }
