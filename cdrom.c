/***************************************************************************
 *    CDROM.C  - CD-ROM interface code (audio routines)                    *
 *                                                                         *
 ***************************************************************************/

#include <stdio.h>
#include <dos.h>
#include <malloc.h>
#include <sys\types.h>
#include <sys\stat.h>
#include <fcntl.h>

#define   CMDBUFSIZE     22

#define   IOCMD2         0x4402
#define   IOCMD3         0x4403

//** IOCTL3 commands
#define   CD_OPENDOORCMD 0x00
#define   CD_CLOSEDOORCMD 0x05
#define   CD_RESETCMD    0x02

//** IOCTL2 commands
#define   CD_STATUSCMD   0x06

short cddrive,
     cddrives,
     cdhdl,
     cdhitrack,
     cdlotrack,
     cdtracktoplay;

long leadout;

unsigned short bufoff[100],bufseg[100],
     cmdoff,cmdseg,
     devoff,devseg,
     nameoff,nameseg,
     rmoff,rmseg;

char cddevname[9],
     far *namebuf;

char far *cddevadr;

struct redbook {
     char frame;
     char second;
     char minute;
     char unused;
     char control;
} redbook[20];

struct rmregs {
     unsigned long edi,esi,ebp;
     unsigned long reserved;
     unsigned long ebx,edx,ecx,eax;
     unsigned short flags,es,ds,fs,gs,ip,cs,sp,ss;
} rmregs;

void
rmint86(short intno,struct rmregs *rmptr)
{
}

void far *
alcmem(short bytes)
{
     union REGS regs;

     regs.x.eax=0x0100;
     regs.x.ebx=((bytes+16)/16);
     int386(0x31,&regs,&regs);
     if (regs.x.cflag == 0) {
          rmseg=regs.x.eax;
          rmoff=0x0000;
          return((void far *)(rmseg<<4));
     }
     return(NULL);
}

int
ismscdex(void)
{
     return 1;
}

int
ismojocd(void)
{
     return 1;
}

void
cd_getname(void)
{
}

void
sendIOcmd(short hdl,short bytes,short cmd)
{
}

void
cd_opendoor(short cdhdl)
{
}

void
cd_closedoor(short cdhdl)
{
}

void
cd_reset(short cdhdl)
{
}

void
cd_getaudiodisk(short cdhdl)
{
}

void
cd_getaudiotrack(short cdhdl,char tno)
{
}

int
cd_init(void)
{
     return 0;
}

void
cd_uninit(void)
{
}

void
cd_stopplay(void)
{
}

int
cd_playtrack(char tno)
{
     return 0;
}

void
cd_resumeplay(void)
{
}

void initcdrom(void)
{
}

void playcdromsong(void)
{
}

void shutdowncdrom(void)
{
}
