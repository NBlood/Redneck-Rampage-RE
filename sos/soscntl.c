#include "sos.h"

VOID sosModule3Start(VOID) {}

W32 sosDIGIGetDMAPosition(HANDLE a1)
{
    PSOSDIGIDRIVER v4;
    v4 = _sSOSSystem.pDriver[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;
    return v4->wDMAPosition;
}

extern DWORD wVolumeMaster;

W32 sosDIGISetMasterVolume(HANDLE a1, W32 a2)
{
    DWORD v4;

    v4 = wVolumeMaster;
    a2 &= 0x7fff;
    wVolumeMaster = a2;
    return v4;
}

W32 sosDIGISetSampleVolume(HANDLE a1, HANDLE a2, W32 a3)
{
    PSOSDIGIDRIVER v4;
    _SOS_SAMPLE *v8;
    DWORD vc;

    v4 = _sSOSSystem.pDriver[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;

    v8 = &v4->pSamples[a2];

    if (!v8)
        return _ERR_INVALID_HANDLE;

    if (v8->wFlags & _ACTIVE)
    {
        vc = v8->wVolume;
        v8->wVolume = a3;
    }
    else
        return _ERR_INVALID_HANDLE;

    return vc;
}

W32 sosDIGIGetSampleVolume(HANDLE a1, HANDLE a2)
{
    PSOSDIGIDRIVER v4;
    _SOS_SAMPLE *v8;

    v4 = _sSOSSystem.pDriver[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;

    v8 = &v4->pSamples[a2];

    if (!v8)
        return _ERR_INVALID_HANDLE;

    if (v8->wFlags & _ACTIVE)
    {
        return v8->wVolume;
    }
    return _ERR_INVALID_HANDLE;
}

W32 sosDIGIGetBytesProcessed(HANDLE a1, HANDLE a2)
{
    PSOSDIGIDRIVER v4;
    _SOS_SAMPLE* v8;

    v4 = _sSOSSystem.pDriver[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;

    v8 = &v4->pSamples[a2];

    if (!v8)
        return _ERR_INVALID_HANDLE;

    if (v8->wFlags & _ACTIVE)
    {
        return v8->wTotalBytesProcessed;
    }
    return _ERR_INVALID_HANDLE;
}

W32 sosDIGIGetLoopCount(HANDLE a1, HANDLE a2)
{
    PSOSDIGIDRIVER v4;
    _SOS_SAMPLE* v8;

    v4 = _sSOSSystem.pDriver[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;

    v8 = &v4->pSamples[a2];

    if (!v8)
        return _ERR_INVALID_HANDLE;

    if (v8->wFlags & _ACTIVE)
    {
        return v8->wLoopCount;
    }
    return _ERR_INVALID_HANDLE;
}

W32 sosDIGISetPanLocation(HANDLE a1, HANDLE a2, W32 a3)
{
    PSOSDIGIDRIVER v4;
    _SOS_SAMPLE *v8;
    DWORD vc;

    v4 = _sSOSSystem.pDriver[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;

    v8 = &v4->pSamples[a2];

    if (!v8)
        return _ERR_INVALID_HANDLE;

    if (v8->wFlags & _ACTIVE)
    {
        vc = v8->wPanPosition;
        v8->wPanPosition = a3;

        return vc;
    }
    else
        return _ERR_INVALID_HANDLE;
}
W32 sosDIGIGetPanLocation(HANDLE a1, HANDLE a2)
{
    PSOSDIGIDRIVER v4;
    _SOS_SAMPLE* v8;

    v4 = _sSOSSystem.pDriver[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;

    v8 = &v4->pSamples[a2];

    if (!v8)
        return _ERR_INVALID_HANDLE;

    if (v8->wFlags & _ACTIVE)
    {
        return v8->wPanPosition;
    }
    return _ERR_INVALID_HANDLE;
}

W32 sosDIGISetSampleRate(HANDLE a1, HANDLE a2, W32 a3)
{
    PSOSDIGIDRIVER v4;
    _SOS_SAMPLE *v8;
    DWORD vc;

    v4 = _sSOSSystem.pDriver[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;

    v8 = &v4->pSamples[a2];

    if (!v8)
        return _ERR_INVALID_HANDLE;

    if (v8->wFlags & _ACTIVE)
    {
        vc = v8->wRate;
        v8->wRate = a3;

        return vc;
    }
    else
        return _ERR_INVALID_HANDLE;
}

W32 sosDIGIGetSampleRate(HANDLE a1, HANDLE a2)
{
    PSOSDIGIDRIVER v4;
    _SOS_SAMPLE* v8;

    v4 = _sSOSSystem.pDriver[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;

    v8 = &v4->pSamples[a2];

    if (!v8)
        return _ERR_INVALID_HANDLE;

    if (v8->wFlags & _ACTIVE)
    {
        return v8->wRate;
    }
    return _ERR_INVALID_HANDLE;
}

W32 sosDIGIGetPanSpeed(HANDLE a1, HANDLE a2)
{
    PSOSDIGIDRIVER v4;
    _SOS_SAMPLE* v8;

    v4 = _sSOSSystem.pDriver[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;

    v8 = &v4->pSamples[a2];

    if (!v8)
        return _ERR_INVALID_HANDLE;

    if (v8->wFlags & _ACTIVE)
    {
        return v8->wPanSpeed;
    }
    return _ERR_INVALID_HANDLE;
}

W32 sosDIGIGetSampleID(HANDLE a1, HANDLE a2)
{
    PSOSDIGIDRIVER v4;
    _SOS_SAMPLE* v8;

    v4 = _sSOSSystem.pDriver[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;

    v8 = &v4->pSamples[a2];

    if (!v8)
        return _ERR_INVALID_HANDLE;

    return v8->wID;
}

W32 sosDIGIGetSampleHandle(HANDLE a1, HANDLE a2)
{
    PSOSDIGIDRIVER v4;
    DWORD v8;

    v4 = _sSOSSystem.pDriver[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;

    for (v8 = 0; v8 < v4->wMixerChannels; v8++)
    {
        if (v4->pSamples[v8].wID == a2)
        {
            return v4->pSamples[v8].hSample;
        }
    }
    return -1;
}

W32 sosDIGISamplesPlaying(HANDLE a1)
{
    PSOSDIGIDRIVER v4;

    v4 = _sSOSSystem.pDriver[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;

    return v4->wActiveChannels;
}

BOOL sosDIGISampleDone(HANDLE a1, HANDLE a2)
{
    PSOSDIGIDRIVER v4;
    _SOS_SAMPLE* v8;

    v4 = _sSOSSystem.pDriver[a1];
    if (!v4)
        return _ERR_INVALID_HANDLE;

    v8 = &v4->pSamples[a2];

    if (!v8)
        return _ERR_INVALID_HANDLE;

    return !(v8->wFlags & _ACTIVE);
}

VOID sosModule3End(VOID) {}
