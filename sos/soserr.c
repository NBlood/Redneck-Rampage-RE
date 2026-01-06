#include "sos.h"

VOID sosModule5Start(VOID) {}

PSTR sosGetErrorString(W32 a1)
{
	return _pSOSErrorStrings[a1];
}

VOID sosModule5End(VOID) {}
