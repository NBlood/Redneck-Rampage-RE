#include <i86.h>
#include "dpmi.h"

unsigned int dpmi_RealToLinear(unsigned int a1)
{
    return ((a1 & 0xffff0000) >> 12) + (a1 & 0xffff);
}

void *dpmi_allocmem(int a1, unsigned short *a2, unsigned int *a3, unsigned int *a4, unsigned int *a5)
{
    union REGS r;

    r.w.ax = 0x100;
    r.w.bx = a1;
    int386(0x31, &r, &r);

    if (r.x.cflag)
    {
        *a4 = r.w.ax;
        *a5 = r.w.bx;
        return 0;
    }
    *a2 = r.w.ax;
    *a3 = r.w.dx;

    return (void*)(r.w.ax << 4);
}

int dpmi_freemem(int a1)
{
    union REGS r;

    r.w.ax = 0x101;
    r.w.dx = a1;
    int386(0x31, &r, &r);
    return 1;
}

int dpmi_lockmem(void far * a1, unsigned int a2)
{
    union REGS r;

    unsigned int t = FP_OFF(a1);
    
    r.w.ax = 0x600;
    r.w.bx = t >> 16;
    r.w.cx = t;
    r.w.si = a2 >> 16;
    r.w.di = a2;
    int386(0x31, &r, &r);

    if (r.x.cflag)
        return 0;

    return 1;
}

int dpmi_unlockmem(void far * a1, unsigned int a2)
{
    union REGS r;

    unsigned int t = FP_OFF(a1);
    
    r.w.ax = 0x601;
    r.w.bx = t >> 16;
    r.w.cx = t;
    r.w.si = a2 >> 16;
    r.w.di = a2;
    int386(0x31, &r, &r);

    if (r.x.cflag)
        return 0;

    return 1;
}

int dpmi_rmint(unsigned int a1, RMREGS *a2)
{
    union REGS r;
    struct SREGS sregs;

    memset(&sregs, 0, sizeof(sregs));

    r.w.ax = 0x300;
    r.h.bl = a1;
    r.h.bh = 0;
    r.w.cx = 0;
    sregs.es = FP_SEG(a2);
    r.x.edi = FP_OFF(a2);
    int386x(0x31, &r, &r, &sregs);

    if (r.x.cflag)
        return 0;

    return 1;
}
