#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <dos.h>
#include <i86.h>
#include <io.h>
#include <sys\stat.h>
#include <sys\types.h>
#include <fcntl.h>
#include <malloc.h>
#include "sos.h"


VOID sosModule7Start(VOID) {}

W32 sosDIGILoadDriver(W32 a1, HANDLE a2, LPSTR *a3, LPSTR *a4, PSTR a5, PSTR a6, W32 *a7)
{
	int v4;
	DWORD v8 = 0;
	DWORD vc = 0;
	DWORD v10;

	if (a2 > _SOS_MAX_DRIVERS)
		return _ERR_INVALID_HANDLE;

	if (a1 < 0xe000 || a1 > 0xe200)
		return _ERR_INVALID_DRIVER_ID;

	strcpy(_sSOSSystem.szTempDriverPath, _sSOSSystem.szDriverPath);
	strcat(_sSOSSystem.szTempDriverPath, "hmidrv.386");

	v4 = open(_sSOSSystem.szTempDriverPath, 0x200);
	if (v4 == -1)
		return _ERR_DRV_FILE_FAIL;

	read(v4, &_sSOSSystem.sFileHeader, sizeof(_SOS_DRV_FILEHEADER));
	while (v8 <= _sSOSSystem.sFileHeader.wDrivers && !vc)
	{
		read(v4, &_sSOSSystem.sDriverHeader, sizeof(_SOS_DRV_DRIVERHEADER));
		if (_sSOSSystem.sDriverHeader.wDeviceID == a1 && (_sSOSSystem.sDriverHeader.wExtenderType & _SOS_RATIONAL))
		{
			vc = 1;
			if ((*a4 = sosAllocateFarMem(_sSOSSystem.sDriverHeader.wSize, a5, a7)) == NULL)
				return _ERR_MEMORY_FAIL;
			*a3 = sosCreateAliasCS(*a4);

			if (sosDRVLockMemory(*(DWORD*)a6, _sSOSSystem.sDriverHeader.wSize))
				return _ERR_MEMORY_FAIL;

			_dos_read(v4, *a4, _sSOSSystem.sDriverHeader.wSize, &v10);
			*a5 = _sSOSSystem.sDriverHeader.wSize;
		}
		else
			lseek(v4, _sSOSSystem.sDriverHeader.wSize, SEEK_CUR);
		v8++;
	}

	close(v4);

	return _ERR_NO_ERROR;
}

W32 sosDIGIUnLoadDriver(HANDLE a1)
{
	PSOSDIGIDRIVER v4;

	if (a1 > _SOS_MAX_DRIVERS)
		return _ERR_INVALID_HANDLE;

	v4 = _sSOSSystem.pDriver[a1];
	if (!v4)
		return _ERR_INVALID_HANDLE;

	if (sosDRVUnLockMemory(v4->dwLinear, v4->wSize))
		return _ERR_MEMORY_FAIL;

	sosFreeSelector(v4->lpDriverDS, v4->dwLinear);
	sosFreeSelector(v4->lpDriverCS, v4->dwLinear);

	return _ERR_NO_ERROR;
}

VOID sosModule7End(VOID) {}
