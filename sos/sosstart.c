#include "sos.h"

VOID sosModule9Start(VOID) {}

W32 sosDIGIStartSample(HANDLE a1, PSOSSAMPLE a2)
{
	DWORD v4;
	PSOSSAMPLE v8;
	PSOSDIGIDRIVER vc;

	vc = _sSOSSystem.pDriver[a1];
	if (!vc)
		return _ERR_INVALID_HANDLE;

	for (v4 = 0; v4 < vc->wMixerChannels; v4++)
	{
		if (!(vc->pSamples[v4].wFlags & _SACTIVE))
			break;
	}

	if (v4 == vc->wMixerChannels)
		return _ERR_NO_SLOTS;

	memcpy(&vc->pSamples[v4], a2, sizeof(_SOS_SAMPLE));
	vc->pSamples[v4].pSampleCurrent = a2->pSample;
	vc->pSamples[v4].hSample = v4;
	v8 = vc->pSampleList;
	if (v8 == 0)
	{
		vc->pSamples[v4].pNext = NULL;
		vc->pSamples[v4].wFlags |= _SACTIVE;
		vc->pSampleList = &vc->pSamples[v4];
	}
	else
	{
		while (v8->pNext)
			v8 = v8->pNext;

		vc->pSamples[v4].pNext = NULL;
		vc->pSamples[v4].wFlags |= _SACTIVE;
		v8->pNext = &vc->pSamples[v4];
	}

	return v4;
}

W32 sosDIGIStopSample(HANDLE a1, HANDLE a2)
{
	PSOSDIGIDRIVER v4;

	v4 = _sSOSSystem.pDriver[a1];
	if (!v4)
		return _ERR_INVALID_HANDLE;
	if (!(v4->pSamples[a1].wFlags & _SACTIVE))
		return _ERR_NO_ERROR;
	v4->pSamples[a1].wFlags |= _SPROCESSED;
	return _ERR_NO_ERROR;
}

W32 sosDIGIStopAllSamples(HANDLE a1)
{
	PSOSDIGIDRIVER v4;
	DWORD v8;

	v4 = _sSOSSystem.pDriver[a1];
	if (!v4)
		return _ERR_INVALID_HANDLE;

	for (v8 = 0; v8 < v4->wMixerChannels; v8++)
	{
		v4->pSamples[v8].wFlags |= _SPROCESSED;
	}
	return _ERR_NO_ERROR;
}

VOID sosModule9End(VOID) {}
