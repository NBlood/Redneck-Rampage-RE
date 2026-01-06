#include <stdio.h>
#include <stdlib.h>
#include <dos.h>
#include <i86.h>
#include <string.h>
#include "sos.h"


VOID sosModule6Start(VOID) {}

W32 sosDIGIInitDriver(PSOSDIGIDRIVER a1, HANDLE *a2)
{
	DWORD v4;
	DWORD v8;
	W32 vc;

	for (v4 = 0; v4 < _SOS_MAX_DRIVERS; v4++)
	{
		if (!_sSOSSystem.pDriver[v4])
			break;
	}

	if (v4 == _SOS_MAX_DRIVERS + 1)
		return _ERR_NO_HANDLES;

	_sSOSSystem.pDriver[v4] = a1;

	if (!a1->lpDriverDS)
	{
		vc = sosDIGILoadDriver(a1->wID, v4, &a1->lpDriverCS, &a1->lpDriverDS,
			&a1->hMemory, &a1->wSize, &a1->dwLinear);
		if (vc)
			return vc;
		if ((a1->pSamples = sosAlloc(sizeof(_SOS_SAMPLE) * _SOS_MIXER_CHANNELS)) == NULL)
			return _ERR_MEMORY_FAIL;
		if ((a1->pMixingBuffer = sosAlloc(a1->wDMABufferSize * 4)) == NULL)
		{
			sosFree(a1->pSamples, sizeof(_SOS_SAMPLE) * _SOS_MIXER_CHANNELS);
			return _ERR_MEMORY_FAIL;
		}

		a1->wFlags |= _SOS_DRV_LOADED;
	}

	memset(a1->pSamples, 0, sizeof(_SOS_SAMPLE) * _SOS_MIXER_CHANNELS);
	vc = sosDIGIGetDeviceCaps(v4, &a1->sCaps);
	if (vc)
		return vc;

	if (!a1->pDMABuffer)
	{
		a1->wFlags |= _SOS_DRV_DMA_BUFFER_ALLOCATED;
		if ((a1->pDMABuffer = sosDIGIAllocDMABuffer(a1->wDMABufferSize, &a1->dwLinear, &a1->hMemory, &a1->lpDMABuffer)) == NULL)
		{
			sosDIGIUnLoadDriver(v4);
			return _ERR_MEMORY_FAIL;
		}
		if (a1->sCaps.wBitsPerSample == 8)
		{
			if (a1->sCaps.wFlags & _SOS_DCAPS_SIGNED_DATA)
			{
				for (v8 = 0; v8 < a1->wDMABufferSize; v8++)
				{
					a1->pDMABuffer[v8] = 0;
				}
			}
			else
			{
				for (v8 = 0; v8 < a1->wDMABufferSize; v8++)
				{
					a1->pDMABuffer[v8] = 0x80;
				}
			}
		}
		else
		{
			for (v8 = 0; v8 < a1->wDMABufferSize; v8++)
			{
				a1->pDMABuffer[v8] = 0;
			}
		}
	}

	a1->pDMABufferEnd = a1->pDMABuffer + a1->wDMABufferSize;
	a1->wDMACountRegister = _wSOSDMAPortList[a1->sHardware.wDMA];
	a1->pXFERPosition = a1->pDMABuffer;
	a1->pMixingBufferEnd = a1->pMixingBuffer + a1->wDMABufferSize * 4;
	a1->wMixingBufferSize = 0x20 + a1->wDMABufferSize * 4;
	a1->pSampleList = NULL;
	a1->wActiveChannels = -1;
	a1->wXFERJumpAhead = 0x400;
	a1->wMixerChannels = _SOS_MIXER_CHANNELS;
	a1->wDriverBitsPerSample = a1->sCaps.wBitsPerSample;
	a1->wDriverChannels = a1->sCaps.wChannels + 1;
	a1->wDriverFormat = _PCM_UNSIGNED;
	a1->pfnMixFunction = _pSOSMixerStubs[v4];
	a1->wDMAPosition = 0;
	a1->wDMALastPosition = 0;
	a1->wDMADistance = 0;
	if (a1->sCaps.wFlags & _SOS_DCAPS_PSEUDO_DMA1)
		a1->pfnPseudoDMAFunction = (VOID(far*)(VOID))sosDRVSetupCallFunctions(a1->lpDriverCS, a1->lpDriverDS);

	sosDIGIInitForWindows(a1->sHardware.wDMA);
	sosDRVInit(a1->lpDriverCS, a1->lpDriverDS, a1->sHardware.wPort, a1->sHardware.wIRQ, a1->sHardware.wDMA,
		a1->sHardware.wParam, a1->sHardware.wParam, a1->sHardware.wParam);
	sosDRVSetAction(a1->lpDriverCS, a1->lpDriverDS);
	sosDRVSetRate(a1->lpDriverCS, a1->lpDriverDS, a1->wDriverRate);
	sosDRVStart(a1->lpDriverCS, a1->lpDriverDS, a1->dwDMAPhysical, a1->wDMABufferSize);
	a1->wFlags |= _SOS_DRV_INITIALIZED;
	*a2 = v4;
	sosDIGISetMasterVolume(v4, 0x7fff);
	return _ERR_NO_ERROR;
}

W32 sosDIGIUnInitDriver(HANDLE a1, BOOL a2, BOOL a3)
{
	PSOSDIGIDRIVER v4;

	v4 = _sSOSSystem.pDriver[a1];

	if (!v4)
		return _ERR_INVALID_HANDLE;

	if (!(v4->wFlags & 2))
		return _ERR_DRIVER_NOT_LOADED;

	v4->pSampleList = NULL;

	sosDRVStop(v4->lpDriverCS, v4->lpDriverDS);
	sosDRVUnInit(v4->lpDriverCS, v4->lpDriverDS);
	sosDIGIUnInitForWindows(v4->sHardware.wDMA);
	if ((v4->wFlags & _SOS_DRV_DMA_BUFFER_ALLOCATED) != 0 && a2)
	{
		v4->wFlags &= ~_SOS_DRV_DMA_BUFFER_ALLOCATED;
		if ((sosDRVIsWindowsActive() & 0xff) == 3)
		{
			sosFreeVDSPage(FP_SEG(v4->lpDMABuffer), v4->wDMARealSeg, v4->dwDMAPhysical);
		}
		else
		{
			sosRealFree(FP_SEG(v4->lpDMABuffer));
			v4->wFlags &= ~_SOS_DRV_DMA_BUFFER_ALLOCATED;
		}
	}
	if ((v4->wFlags & _SOS_DRV_LOADED) != 0 && a3)
	{
		sosDIGIUnLoadDriver(a1);
		v4->lpDriverDS = NULL;
		v4->lpDriverCS = NULL;
		sosFree(v4->pMixingBuffer, v4->wMixingBufferSize);
		sosFree(v4->pSamples, sizeof(_SOS_SAMPLE) * _SOS_MIXER_CHANNELS);
		v4->wFlags &= ~_SOS_DRV_LOADED;
	}
	_sSOSSystem.pDriver[a1] = NULL;
	v4->wFlags &= ~_SOS_DRV_INITIALIZED;
	return _ERR_NO_ERROR;
}

PSTR sosDIGIAllocDMABuffer(W32 a1, DWORD *a2, W32 *a3, LPSTR *a4)
{
	int v4;
	if ((sosDRVIsWindowsActive() & 0XFF) == 3)
	{
		if (sosAllocVDSPage(a4, a3, a2))
			return _ERR_NO_ERROR;
		sosDRVLockMemory(*(DWORD*)a4, a1);
		return *a4;
	}

	if (!sosRealAlloc((a1 >> 4) + 4, a2, &v4))
		return _ERR_MEMORY_FAIL;

	while ((*a2 & 0xffff) > 0xffff - a1)
	{
		if (!sosRealAlloc((a1 >> 4) + 4, a2, &v4))
		{
			sosRealFree(v4);
			return _ERR_MEMORY_FAIL;
		}
	}

	*a4 = MK_FP(v4, 0);

	return *a2;
}

W32  sosAllocVDSPage(LPSTR *a1, W32 *a2, DWORD *a3)
{
	W32 v4;
	W32 v8;
	W32 vc;
	_SOS_VDS_STRUCT far * v30;
	DWORD v14 = 0;
	DWORD v18 = 0;
	W32 v1c;

	*a1 = NULL;
	*a2 = NULL;
	*a3 = NULL;

	v4 = 0;
	if (sosDRVAllocVDSStruct(32, &vc, &v4))
		return _ERR_NO_ERROR;

	v30 = MK_FP(vc, 0);
	v30->region_size = 0x1000;

	v18 = sosDRVVDSGetBuffer(v4);
	_fmemcpy(&_sSOSSystem.sVDS, v30, sizeof(_SOS_VDS_STRUCT));
	sosDRVFreeVDSStruct(vc, v4);
	if (!v18)
	{
		_sSOSSystem.sVDS.physical &= ~0xfff;
		v1c = sosDRVMakeDMASelector(_sSOSSystem.sVDS.physical);
		v14 = _sSOSSystem.sVDS.physical;
		*a1 = MK_FP(0, v1c);
		*a3 = v14;
		return _ERR_NO_ERROR;
	}

	return _ERR_MEMORY_FAIL;
}

VOID  sosFreeVDSPage(W32 a1, W32 a2, LONG a3)
{
	_SOS_VDS_STRUCT far* v18;
	W32 v8;
	W32 vc;

	sosDRVAllocVDSStruct(32, &v8, &vc);
	v18 = MK_FP(v8, 0);
	_fmemcpy(v18, &_sSOSSystem.sVDS, sizeof(_SOS_VDS_STRUCT));
	sosDRVVDSFreeBuffer(vc);
	sosDRVFreeVDSStruct(v8, vc);
}

VOID sosDIGIMixFunction0(VOID)
{
	hmiDigitalMixer(_sSOSSystem.pDriver[0]);
}

VOID sosDIGIMixFunction1(VOID)
{
	hmiDigitalMixer(_sSOSSystem.pDriver[1]);
}

VOID sosDIGIMixFunction2(VOID)
{
	hmiDigitalMixer(_sSOSSystem.pDriver[2]);
}

VOID sosDIGIMixFunction3(VOID)
{
	hmiDigitalMixer(_sSOSSystem.pDriver[3]);
}

VOID sosDIGIMixFunction4(VOID)
{
	hmiDigitalMixer(_sSOSSystem.pDriver[4]);
}

VOID sosModule6End(VOID) {}
