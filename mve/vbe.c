#include "vbe.h"
#include "dpmi.h"

void *vbe_buffer;
unsigned short vbe_buffer_segment;
unsigned int vbe_buffer_handle;

int vbe_InitBuffer(void)
{
    unsigned int v10, v14;
    if (vbe_buffer)
        return 1;

    vbe_buffer = dpmi_allocmem(128, &vbe_buffer_segment, &vbe_buffer_handle, &v10, &v14);
    return (vbe_buffer != 0) != 0;
}

int vbe_GetVgaInfo(VgaInfo *a1)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));

    s.h.ah = 0x4f;
    s.h.al = 0x00;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    s.w.es = vbe_buffer_segment;
    s.w.di = 0x00;
    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;

    *a1 = *(VgaInfo*)vbe_buffer;

    a1->OEMString = (char*)dpmi_RealToLinear((unsigned int)a1->OEMString);
    a1->VideoModes = (unsigned short*)dpmi_RealToLinear((unsigned int)a1->VideoModes);

    return 1;
}

int vbe_GetModeInfo(unsigned int a1, ModeInfo *a2, unsigned int *a3, unsigned int *a4)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));
    s.h.ah = 0x4f;
    s.h.al = 0x01;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    s.w.cx = a1;
    s.w.es = vbe_buffer_segment;
    s.w.di = 0x00;
    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;

    *a2 = *(ModeInfo*)vbe_buffer;

    a2->WinFuncPtr = (unsigned char*)dpmi_RealToLinear((unsigned int)a2->WinFuncPtr);
    *a3 = dpmi_RealToLinear(a2->WinASegment << 16);
    *a4 = dpmi_RealToLinear(a2->WinBSegment << 16);

    return 1;
}

int vbe_GetPMInfo(PMInfo *a1)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));

    s.h.ah = 0x4f;
    s.h.al = 0x01;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    s.w.cx = 0xffff;
    s.w.es = vbe_buffer_segment;
    s.w.di = 0x00;
    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;

    *a1 = *(PMInfo*)vbe_buffer;

    a1->SetBank = (unsigned char*)dpmi_RealToLinear((unsigned int)a1->SetBank);
    a1->GetBank = (unsigned char*)dpmi_RealToLinear((unsigned int)a1->GetBank);
    a1->SetDisplayStart = (unsigned char*)dpmi_RealToLinear((unsigned int)a1->SetDisplayStart);

    return 1;
}

int vbe_SetSvgaMode(unsigned int a1)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));

    s.h.ah = 0x4f;
    s.h.al = 0x02;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    s.w.bx = a1;
    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;
    return 1;
}

int vbe_GetVideoMode(unsigned int *a1)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));

    s.h.ah = 0x4f;
    s.h.al = 0x03;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;

    *a1 = s.w.bx;
    return 1;
}

int vbe_GetVideoStateSize(unsigned int a1, unsigned int *a2)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));

    s.h.ah = 0x4f;
    s.h.al = 0x04;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    s.h.dl = 0;
    s.w.cx = a1;
    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;

    *a2 = s.w.bx << 6;
    return 1;
}

int vbe_SaveVideoState(unsigned int a1, void *a2, unsigned int a3)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));

    s.h.ah = 0x4f;
    s.h.al = 0x04;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    s.h.dl = 1;
    s.w.cx = a1;
    s.w.es = vbe_buffer_segment;
    s.w.bx = 0;
    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;

    memcpy(a2, a3, vbe_buffer);
    return 1;
}

int vbe_RestoreVideoState(unsigned int a1, void *a2, unsigned int a3)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));

    s.h.ah = 0x4f;
    s.h.al = 0x04;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    s.h.dl = 2;
    s.w.cx = a1;
    s.w.es = vbe_buffer_segment;
    s.w.bx = 0;

    memcpy(vbe_buffer, a3, a2);

    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;
    return 1;
}

int cdecl vbe_SetWindowPosition(unsigned int a1, unsigned int a2)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));

    s.h.ah = 0x4f;
    s.h.al = 0x05;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    s.h.bh = 0;
    s.h.bl = a1;
    s.w.dx = a2;

    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;
    return 1;
}

int cdecl vbe_GetWindowPosition(unsigned int a1, unsigned int *a2)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));

    s.h.ah = 0x4f;
    s.h.al = 0x05;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    s.h.bh = 1;
    s.h.bl = a1;

    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;

    *a2 = s.w.dx;

    return 1;
}


int vbe_SetScanLineLength(unsigned int *a1, unsigned int *a2, unsigned int *a3)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));

    s.h.ah = 0x4f;
    s.h.al = 0x06;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    s.h.bl = 0;
    s.w.cx = *a1;

    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;

    *a1 = s.w.cx;
    *a2 = s.w.bx;
    *a3 = s.w.dx;

    return 1;
}


int vbe_GetScanLineLength(unsigned int *a1, unsigned int *a2, unsigned int *a3)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));

    s.h.ah = 0x4f;
    s.h.al = 0x06;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    s.h.bl = 1;

    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;

    *a1 = s.w.cx;
    *a2 = s.w.bx;
    *a3 = s.w.dx;

    return 1;
}


int vbe_SetDisplayStart(unsigned int a1, unsigned int a2)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));

    s.h.ah = 0x4f;
    s.h.al = 0x07;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    s.h.bh = 0;
    s.h.bl = 0;
    s.w.cx = a1;
    s.w.dx = a2;

    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;

    return 1;
}


int vbe_GetDisplayStart(unsigned int *a1, unsigned int *a2)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));

    s.h.ah = 0x4f;
    s.h.al = 0x07;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    s.h.bl = 1;

    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;

    *a1 = s.w.cx;
    *a2 = s.w.dx;

    return 1;
}


int vbe_SetDacWidth(unsigned int *a1)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));

    s.h.ah = 0x4f;
    s.h.al = 0x08;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    s.h.bl = 0;
    s.h.bh = *a1;

    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;

    *a1 = s.h.bh;

    return 1;
}


int vbe_GetDacWidth(unsigned int *a1)
{
    RMREGS s;
    if (!vbe_InitBuffer())
        return 0;

    memset(&s, 0, sizeof(s));

    s.h.ah = 0x4f;
    s.h.al = 0x08;
    s.w.ss = vbe_buffer_segment;
    s.w.sp = 0x800;
    s.h.bl = 1;

    if (!dpmi_rmint(0x10, &s) || s.w.ax != 0x4f)
        return 0;

    *a1 = s.h.bh;

    return 1;
}
