#include <stdio.h>
#include <stdlib.h>
#include <dos.h>
#include <i86.h>
#include <string.h>
#include "sos.h"

VOID sosModule10Start(VOID) {}

W32 sosDIGIInitSystem(PSTR a1, W32 a2)
{
	DWORD v4;

	v4 = sosDIGILockLibrary();
	if (v4)
		return v4;

	_sSOSSystem.wFlags |= _SOS_SYSTEM_INITIALIZED;
	if (a1)
		strcpy(_sSOSSystem.szDriverPath, a1);
	else
		_sSOSSystem.szDriverPath[0] = 0;
	return _ERR_NO_ERROR;
}

W32 sosDIGIUnInitSystem(VOID)
{
	DWORD v4;

	v4 = sosDIGIUnLockLibrary();
	if (v4)
		return _ERR_NO_ERROR;

	_sSOSSystem.wFlags &= ~_SOS_SYSTEM_INITIALIZED;
	return _ERR_NO_ERROR;
}

VOID sosModule10End(VOID) {}
