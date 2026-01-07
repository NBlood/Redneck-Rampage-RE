#ifndef _DPMI_H_
#define _DPMI_H_

struct _RMREGSX {
    unsigned int edi;
    unsigned int esi;
    unsigned int ebp;
    unsigned int pad1 : 32;
    unsigned int ebx;
    unsigned int edx;
    unsigned int ecx;
    unsigned int eax;
};

struct _RMREGSW {
    unsigned short di;
    unsigned short pad1 : 16;
    unsigned short si;
    unsigned short pad2 : 16;
    unsigned short bp;
    unsigned short pad3 : 16;
    unsigned int pad4 : 32;
    unsigned short bx;
    unsigned short pad5 : 16;
    unsigned short dx;
    unsigned short pad6 : 16;
    unsigned short cx;
    unsigned short pad7 : 16;
    unsigned short ax;
    unsigned short pad8 : 16;
    unsigned short flags;
    unsigned short es;
    unsigned short ds;
    unsigned short fs;
    unsigned short gs;
    unsigned short ip;
    unsigned short cs;
    unsigned short sp;
    unsigned short ss;
};

struct _RMREGSB {
    unsigned int pad1 : 32;
    unsigned int pad2 : 32;
    unsigned int pad3 : 32;
    unsigned int pad4 : 32;
    unsigned char bl;
    unsigned char bh;
    unsigned char pad5 : 8;
    unsigned char pad6 : 8;
    unsigned char dl;
    unsigned char dh;
    unsigned char pad7 : 8;
    unsigned char pad8 : 8;
    unsigned char cl;
    unsigned char ch;
    unsigned char pad9 : 8;
    unsigned char pad10 : 8;
    unsigned char al;
    unsigned char ah;
    unsigned char pad11 : 8;
    unsigned char pad12 : 8;
};

typedef union
{
    struct _RMREGSX x;
    struct _RMREGSW w;
    struct _RMREGSB h;
} RMREGS;

unsigned int dpmi_RealToLinear(unsigned int a1);
void *dpmi_allocmem(int a1, unsigned short *a2, unsigned int *a3, unsigned int *a4, unsigned int *a5);
int dpmi_freemem(int a1);
int dpmi_lockmem(void far * a1, unsigned int a2);
int dpmi_unlockmem(void far * a1, unsigned int a2);
int dpmi_rmint(unsigned int a1, RMREGS *a2);

#endif // !_DPMI_H_
