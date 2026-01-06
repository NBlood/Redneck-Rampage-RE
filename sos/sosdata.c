#include "sos.h"

W32 _wSOSData1Start = 0;
_SOS_SYSTEM _sSOSSystem = {
	0,
	{ 0 },
	{ 0 },
	{ 0 },
	{ -1, -1, -1, -1, -1 },
};

_SOS_TIMER_SYSTEM _sTIMERSystem = {
    0, -1,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1
};

_SOS_DET_SYSTEM _sDETSystem = { 0 };

PSTR _pSOSErrorStrings[] = {
    "Error Code Does Not Indicate An Error",
    "Specified Driver Is Not Loaded",
    "Specified Pointer Is NULL",
    "Detection System Is Already Initialized",
    "File Open Failure",
    "Memory Allocation Failure",
    "Invalid Driver ID",
    "Driver Not Found",
    "Detection System Failed To Find Hardware",
    "Driver Already Loaded Using Specified Handle",
    "Invalid Handle",
    "No Handles Available",
    "Hardware Already Paused",
    "Hardware Not Paused",
    "Data Is Not Valid",
    "HMI*.386 File Open Failure",
    "Incorrect Port",
    "Incorrect IRQ",
    "Incorrect DMA",
    "Incorrect DMA/IRQ",
    "Stream Already Playing",
    "Stream Empty",
    "Stream Already Paused",
    "Stream Not Paused"
};

W32 _wSOSDMAPortList[] = {
    1, 3, 5, 7, 0xc2, 0xc6, 0xca, 0xce
};

VOID(*_pSOSMixerStubs[_SOS_MAX_DRIVERS])(VOID) =
{
    sosDIGIMixFunction0,
    sosDIGIMixFunction1,
    sosDIGIMixFunction2,
    sosDIGIMixFunction3,
    sosDIGIMixFunction4,
};

W32 _wSOSData1End = 0;
