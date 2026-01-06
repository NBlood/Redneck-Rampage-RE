#include <dos.h>
#include <i86.h>
#include "sos.h"


VOID sosModule2Start(VOID) {}


W32 sosDIGIGetDeviceCaps(HANDLE a1, PSOSCAPABILITIES a2)
{
	PSOSDIGIDRIVER v4;

	v4 = _sSOSSystem.pDriver[a1];
	if (!v4)
		return _ERR_DRIVER_NOT_LOADED;
	if (a2)
		sosDRVGetCapsPtr(v4->lpDriverCS, v4->lpDriverDS, a2);
	else
		return _ERR_INVALID_POINTER;

	return _ERR_NO_ERROR;
}

VOID sosModule2End(VOID) {}
