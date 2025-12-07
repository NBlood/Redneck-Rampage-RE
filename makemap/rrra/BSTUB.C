// "Build Engine & Tools" Copyright (c) 1993-1997 Ken Silverman
// Ken Silverman's official web site: "http://www.advsys.net/ken"
// See the included license file "BUILDLIC.TXT" for license info.
// This file has been modified from Ken Silverman's original release

#include <fcntl.h>
#include <io.h>
#include <sys\types.h>
#include <sys\stat.h>
#include "build.h"
#include "pragmas.h"
#include "names.h"
#include <dos.h>

signed char byte_11A3E0[] = {
	0, 0, 1, 1, 1, 32, 16, 24, 12, 12, 12, 24, 24, 24, 32,
	32, 32, 32, 0, 0, 0, 0, 0, 0, 0, 0
};
char char_5152E = 0;

extern char keystatus[256];

static char tempbuf[256];
extern long qsetmode;
extern short searchsector, searchwall, searchstat;
extern long zmode, kensplayerheight;
extern short defaultspritecstat;

extern short temppicnum, tempcstat, templotag, temphitag, tempextra;
extern char tempshade, temppal, tempxrepeat, tempyrepeat;
extern char somethingintab;

#define NUMOPTIONS 8
#define NUMKEYS 19
static long vesares[13][2] = {320,200,360,200,320,240,360,240,320,400,
									360,400,640,350,640,400,640,480,800,600,
									1024,768,1280,1024,1600,1200};
static char option[NUMOPTIONS] = {0,0,0,0,0,0,1,0};
static char keys[NUMKEYS] =
{
	0xc8,0xd0,0xcb,0xcd,0x2a,0x9d,0x1d,0x39,
	0x1e,0x2c,0xd1,0xc9,0x33,0x34,
	0x9c,0x1c,0xd,0xc,0xf,
};

extern char buildkeys[NUMKEYS];

extern long frameplace, xdimenscale, ydimen;
extern long posx, posy, posz, horiz;
extern short ang, cursectnum;

static long hang = 0;
extern long stretchhline(long,long,long,long,long,long);
#pragma aux stretchhline parm [eax][ebx][ecx][edx][esi][edi];


extern char names[MAXTILES][17];
static char lo[32];
static short cursprite = 0;
static char onnames = 4;

//Detecting 2D / 3D mode:
//   qsetmode is 200 in 3D mode
//   qsetmode is 350/480 in 2D mode
//
//You can read these variables when F5-F8 is pressed in 3D mode only:
//
//   If (searchstat == 0)  WALL        searchsector=sector, searchwall=wall
//   If (searchstat == 1)  CEILING     searchsector=sector
//   If (searchstat == 2)  FLOOR       searchsector=sector
//   If (searchstat == 3)  SPRITE      searchsector=sector, searchwall=sprite
//   If (searchstat == 4)  MASKED WALL searchsector=sector, searchwall=wall
//
//   searchsector is the sector of the selected item for all 5 searchstat's
//
//   searchwall is undefined if searchstat is 1 or 2
//   searchwall is the wall if searchstat = 0 or 4
//   searchwall is the sprite if searchstat = 3 (Yeah, I know - it says wall,
//                                      but trust me, it's the sprite number)

long ofinetotalclock, ototalclock, averagefps;
#define AVERAGEFRAMES 32
static long frameval[AVERAGEFRAMES], framecnt = 0;

#pragma aux inittimer42 =\
	"in al, 0x61",\
	"or al, 1",\
	"out 0x61, al",\
	"mov al, 0xb4",\
	"out 0x43, al",\
	"xor al, al",\
	"out 0x42, al",\
	"out 0x42, al",\
	modify exact [eax]\

#pragma aux uninittimer42 =\
	"in al, 0x61",\
	"and al, 252",\
	"out 0x61, al",\
	modify exact [eax]\

#pragma aux gettimer42 =\
	"mov al, 0x84",\
	"out 0x43, al",\
	"in al, 0x42",\
	"shl eax, 24",\
	"in al, 0x42",\
	"rol eax, 8",\
	modify [eax]\

void func_423A1(short unk)
{
	static char* int_1D483C, * int_1D4838, * int_1D4834, * int_1D4830, * int_1D482C;
    short i;
    char table[768];
    if (!char_5152E)
    {
        char_5152E = 1;
        int_1D483C = palookup[0];
        int_1D4838 = palookup[30];
        int_1D4834 = palookup[33];
        int_1D4830 = palookup[23];
        int_1D482C = palookup[8];
        for (i = 0; i < 256; i++)
        {
            table[i] = i;
        }
        makepalookup(50,table,byte_11A3E0[8],byte_11A3E0[9],byte_11A3E0[10], 1);
        makepalookup(51,table,byte_11A3E0[8],byte_11A3E0[9],byte_11A3E0[10], 1);
    }
    if (!unk)
    {
        palookup[0] = int_1D483C;
        palookup[30] = int_1D4838;
        palookup[33] = int_1D4834;
        palookup[23] = int_1D4830;
        palookup[8] = int_1D482C;
    }
    else if (unk == 2)
    {
        palookup[0] = palookup[50];
        palookup[30] = palookup[51];
        palookup[33] = palookup[51];
        palookup[23] = palookup[51];
        palookup[8] = palookup[54];
    }
}

extern int _wp1, _wp2;

char GAMEpalette[768];
char WATERpalette[768];
char SLIMEpalette[768];
char TITLEpalette[768];
char REALMSpalette[768];
char BOSS1palette[768];

ReadGamePalette()
{
 int i,fp;
 if((fp=kopen4load("palette.dat",0)) == -1) return;
 kread(fp,GAMEpalette,768);
 for(i=0;i<768;++i) GAMEpalette[i]=GAMEpalette[i];
 kclose(fp);
}


void ReadPaletteTable()
{
 short unk;
 char table[768];
 int i,j,fp;
 char num_tables,lookup_num;
 if((fp=kopen4load("lookup.dat",0)) == -1) return;
 kread(fp,&num_tables,1);
 for(j=0;j<num_tables;j++)
 {
  kread(fp,&lookup_num,1);
  kread(fp,tempbuf,256);
  makepalookup(lookup_num,tempbuf,0,0,0,1);
 }
 kread(fp,WATERpalette,768);
 kread(fp,SLIMEpalette,768);
 kread(fp,TITLEpalette,768);
 kread(fp,REALMSpalette,768);
 kread(fp,BOSS1palette,768);

    SLIMEpalette[765] = SLIMEpalette[766] = SLIMEpalette[767] = 0;
	WATERpalette[765] = WATERpalette[766] = WATERpalette[767] = 0;

 kclose(fp);
 ReadGamePalette();

    for (j = 0; j < 768; j++)
        table[j] = j;
    for (j = 0; j < 32; j++)
        table[j] = j + 32;

    makepalookup(7,table,0,0,0,1);

    for (j = 0; j < 768; j++)
        table[j] = j;
    makepalookup(30,table,0,0,0,1);
    makepalookup(31,table,0,0,0,1);
    makepalookup(32,table,0,0,0,1);
    makepalookup(33,table,0,0,0,1);
    unk = 63;
    for (j = 64; j < 80; j++)
    {
        unk--;
        table[j] = unk;
        table[j + 16] = j - 24;
    }
    table[80] = 80;
    table[81] = 81;
    for (j = 0; j < 32; j++)
    {
        table[j] = j + 32;
    }
    makepalookup(34,table,0,0,0,1);

    for (j = 0; j < 768; j++)
        table[j] = j;
    for (j = 0; j < 16; j++)
        table[j] = j + 129;
    for (j = 16; j < 32; j++)
        table[j] = j + 192;
    makepalookup(35,table,0,0,0,1);
}// end ReadPaletteTable

int curpalette=0;

SetBOSS1Palette()
{int x;
 if(curpalette==3) return;
 curpalette=3;
 kensetpalette(BOSS1palette);
}


SetSLIMEPalette()
{int x;
 if(curpalette==2) return;
 curpalette=2;
 kensetpalette(SLIMEpalette);
}

SetWATERPalette()
{int x;
 if(curpalette==1) return;
 curpalette=1;
 kensetpalette(WATERpalette);
}


SetGAMEPalette()
{int x;
 if(curpalette==0) return;
 curpalette=0;
 kensetpalette(GAMEpalette);
}

kensetpalette(char *vgapal)
{
        long i;
        char vesapal[1024];

        for(i=0;i<256;i++)
        {
                vesapal[i*4+0] = vgapal[i*3+2];
                vesapal[i*4+1] = vgapal[i*3+1];
                vesapal[i*4+2] = vgapal[i*3+0];
                vesapal[i*4+3] = 0;
        }
        VBE_setPalette(0L,256L,vesapal);
}

static char timerinited = 0;
void ExtInit(void)
{
	long i, fil;

	printf("------------------------------------------------------------------------------\n");
	printf("   BUILD.EXE copyright(c) 1996 by Ken Silverman.  You are granted the\n");
	printf("   right to use this software for your personal use only.  This is a\n");
	printf("   special version to be used with \"Redneck Rampage Rides Again\" and may\n");
	printf("   not work properly with other Build engine games.  Please refer to\n");
	printf("   license.doc for distribution rights\n");
	printf("                        Press a key to continue\n");
	printf("------------------------------------------------------------------------------\n");
	getch();

	initgroupfile("stuff.dat");
	if ((fil = open("setup.dat",O_BINARY|O_RDWR,S_IREAD)) != -1)
	{
		read(fil,&option[0],NUMOPTIONS);
		read(fil,&keys[0],NUMKEYS);
		memcpy((void *)buildkeys,(void *)keys,NUMKEYS);   //Trick to make build use setup.dat keys
		close(fil);
	}
	if (option[4] > 0) option[4] = 0;
	initmouse();
	initengine();
	vidoption = option[0]; xdim = vesares[option[6]&15][0]; ydim = vesares[option[6]&15][1];

		//You can load your own palette lookup tables here if you just
		//copy the right code!
	for(i=0;i<256;i++)
		tempbuf[i] = ((i+32)&255);  //remap colors for screwy palette sectors
	makepalookup(16,tempbuf,0,0,0,1);

	kensplayerheight = 32;
	zmode = 0;
	defaultspritecstat = 0;
	pskyoff[0] = 0; pskyoff[1] = 0; pskybits = 1;

	ReadPaletteTable();
	setgamemode(1,640,480);
	inittimer42();
	timerinited = 1;
}

void ExtUnInit(void)
{
	uninittimer42();
	uninitgroupfile();
}

static long daviewingrange, daaspect, horizval1, horizval2;
void ExtPreCheckKeys(void)
{
	long cosang, sinang, dx, dy, mindx, i;

 if(sector[cursectnum].lotag==2)
 { if(sector[cursectnum].floorpal==8) SetBOSS1Palette();
   else SetWATERPalette();
 }
 else SetGAMEPalette();

	if (keystatus[0x3e])  //F4 - screen re-size
	{
		keystatus[0x3e] = 0;
		PutScale();
	}

	if (keystatus[0xc7])
	{
		hang = 0;
		horiz = 100;
	}
}

void ExtAnalyzeSprites(void)
{
	long i;
	spritetype *tspr;

	for(i=0,tspr=&tsprite[0];i<spritesortcnt;i++,tspr++)
	{
#if 0
		tspr->shade += 6;
		if (sector[tspr->sectnum].ceilingstat&1)
			tspr->shade += sector[tspr->sectnum].ceilingshade;
		else
			tspr->shade += sector[tspr->sectnum].floorshade;
#endif
	}
}

void ExtCheckKeys(void)
{
	long i, j, p, y, dx, dy, cosang, sinang, bufplc, tsizy, tsizyup15;

	if (qsetmode == 200)    //In 3D mode
	{
		if (hang != 0)
		{
			bufplc = waloff[4094]+(mulscale16(horiz-100,xdimenscale)+(tilesizx[4094]>>1))*tilesizy[4094];
			setviewback();
			cosang = sintable[(hang+512)&2047];
			sinang = sintable[hang&2047];
			dx = dmulscale1(xdim,cosang,ydim,sinang);
			dy = dmulscale1(-ydim,cosang,xdim,sinang);

			tsizy = tilesizy[4094];
			tsizyup15 = (tsizy<<15);
			dx = mulscale14(dx,daviewingrange);
			dy = mulscale14(dy,daaspect);
			sinang = mulscale14(sinang,daviewingrange);
			cosang = mulscale14(cosang,daaspect);
			p = ylookup[windowy1]+frameplace+windowx2+1;
			for(y=windowy1;y<=windowy2;y++)
			{
				i = divscale16(tsizyup15,dx);
				stretchhline(0,(xdim>>1)*i+tsizyup15,xdim>>2,i,mulscale32(i,dy)*tsizy+bufplc,p);
				dx -= sinang; dy += cosang; p += ylookup[1];
			}
			walock[4094] = 1;

			sprintf(tempbuf,"%ld",(hang*180)>>10);
			printext256(0L,8L,31,-1,tempbuf,1);
		}

		if (keystatus[0xa]) setaspect(viewingrange+(viewingrange>>8),yxaspect+(yxaspect>>8));
		if (keystatus[0xb]) setaspect(viewingrange-(viewingrange>>8),yxaspect-(yxaspect>>8));
		if (keystatus[0xc]) setaspect(viewingrange,yxaspect-(yxaspect>>8));
		if (keystatus[0xd]) setaspect(viewingrange,yxaspect+(yxaspect>>8));

		if (!timerinited)
		{
			timerinited = 1;
			inittimer42();  //Must init here because VESA 0x4F02 messes timer 2
		}
		i = totalclock-ototalclock; ototalclock += i;
		j = ofinetotalclock-gettimer42(); ofinetotalclock -= j;
		i = ((i*(1193181/120)-(j&65535)+32768)&0xffff0000)+(j&65535);
		if (i) { frameval[framecnt&(AVERAGEFRAMES-1)] = 11931810/i; framecnt++; }
			//Print MAX FRAME RATE
		i = frameval[(framecnt-1)&(AVERAGEFRAMES-1)];
		for(j=AVERAGEFRAMES-1;j>0;j--) i = max(i,frameval[j]);
		averagefps = ((averagefps*3+i)>>2);
		if (averagefps > 600) averagefps = 600;
		sprintf(tempbuf,"%ld.%ld",averagefps/10,averagefps%10);
		printext256(0L,0L,31,-1,tempbuf,1);

		editinput();
	}
	else
	{
		timerinited = 0;
	}
}

void PutScale(void)
{
	int i;

	for (i = 0; i < MAXSPRITES; i++)
	{
		if (tilesizx[sprite[i].picnum] == 0 || tilesizy[sprite[i].picnum] == 0)
			sprite[i].picnum = 0;
		switch (sprite[i].picnum)
		{
			case 7936:
				func_423A1(2);
				break;
			case VIXEN:
				if (sprite[i].pal == 34)
				{
					sprite[i].xrepeat = 22;
					sprite[i].yrepeat = 21;
				}
				else
				{
					sprite[i].xrepeat = 22;
					sprite[i].yrepeat = 20;
				}
				break;
			case HULK:
			case HULKSTAYPUT:
			case HULKJUMP:
			case HULKHANG:
			case HULKHANGDEAD:
				sprite[i].xrepeat = 32;
				sprite[i].yrepeat = 32;
				break;
			case COOT:
			case COOTSTAYPUT:
				sprite[i].xrepeat = 24;
				sprite[i].yrepeat = 18;
				break;
			case DRONE:
				sprite[i].xrepeat = 14;
				sprite[i].yrepeat = 7;
				break;
			case BILLYCOCK:
			case BILLYRAY:
			case BILLYRAYSTAYPUT:
				//
			case BRAYSNIPER:
				//sprite[i].xrepeat = 25;
				//sprite[i].yrepeat = 21;
				//break;
			case BUBBASTAND:
				sprite[i].xrepeat = 25;
				sprite[i].yrepeat = 21;
				break;
			case COW:
				sprite[i].xrepeat = 32;
				sprite[i].yrepeat = 32;
				break;
			case HEN:
			case HENSTAYPUT:
			case HENSTAND:
				if (sprite[i].pal == 35)
				{
					sprite[i].xrepeat = 42;
					sprite[i].yrepeat = 30;
				}
				else
				{
					sprite[i].xrepeat = 21;
					sprite[i].yrepeat = 15;
				}
				break;
			case MINION:
			case MINIONSTAYPUT:
				sprite[i].xrepeat = 16;
				sprite[i].yrepeat = 16;
				break;
			case DOGRUN:
				//sprite[i].xrepeat = 16;
				//sprite[i].yrepeat = 16;
				//break;
			case PIG:
				sprite[i].xrepeat = 16;
				sprite[i].yrepeat = 16;
				break;
			case RABBIT:
				sprite[i].xrepeat = 18;
				sprite[i].yrepeat = 18;
				break;
			case BIKER:
				sprite[i].xrepeat = 28;
				sprite[i].yrepeat = 22;
				break;
			case BIKERB:
				//sprite[i].xrepeat = 28;
				//sprite[i].yrepeat = 22;
				//break;
			case CHEERB:
				sprite[i].xrepeat = 28;
				sprite[i].yrepeat = 22;
				break;
			case CHEER:
			case CHEERSTAYPUT:
				sprite[i].xrepeat = 20;
				sprite[i].yrepeat = 20;
				break;
			case EMPTYBIKE:
			case EMPTYBOAT:
				sprite[i].xrepeat = 18;
				sprite[i].yrepeat = 18;
				break;
			case TORNADO:
				sprite[i].xrepeat = 64;
				sprite[i].yrepeat = 128;
				break;
			case LTH:
				sprite[i].xrepeat = 24;
				sprite[i].yrepeat = 22;
				break;
			case UFO1:
			case UFO2:
			case UFO3:
			case UFO4:
			case UFO5:
				sprite[i].xrepeat = 32;
				sprite[i].yrepeat = 32;
				break;
			case 40:
				sprite[i].xrepeat = 9;
				sprite[i].yrepeat = 9;
				break;
			case 26:
				sprite[i].xrepeat = 9;
				sprite[i].yrepeat = 9;
				break;
			case 21:
				sprite[i].xrepeat = 16;
				sprite[i].yrepeat = 16;
				break;
			case 29:
				sprite[i].xrepeat = 18;
				sprite[i].yrepeat = 17;
				break;
			case 49:
				sprite[i].xrepeat = 18;
				sprite[i].yrepeat = 17;
				break;
			case 52:
				sprite[i].xrepeat = 13;
				sprite[i].yrepeat = 9;
				break;
			case 55: //
				sprite[i].xrepeat = 13;
				sprite[i].yrepeat = 9;
				break;
			case 53:
				sprite[i].xrepeat = 8;
				sprite[i].yrepeat = 8;
				break;
			case 51:
				sprite[i].xrepeat = 5;
				sprite[i].yrepeat = 4;
				break;
			case 57:
				sprite[i].xrepeat = 8;
				sprite[i].yrepeat = 6;
				break;
			case 60:
				sprite[i].xrepeat = 11;
				sprite[i].yrepeat = 12;
				break;
			case 59:
				sprite[i].xrepeat = 6;
				sprite[i].yrepeat = 4;
				break;
			case 56:
				sprite[i].xrepeat = 19;
				sprite[i].yrepeat = 16;
				break;
			case 41:
				sprite[i].xrepeat = 15;
				sprite[i].yrepeat = 15;
				break;
			case 27:
				sprite[i].xrepeat = 11;
				sprite[i].yrepeat = 11;
				break;
			case 3437:
				sprite[i].xrepeat = 11;
				sprite[i].yrepeat = 11;
				break;
			case 23:
				sprite[i].xrepeat = 16;
				sprite[i].yrepeat = 14;
				break;
			case 25:
				sprite[i].xrepeat = 22;
				sprite[i].yrepeat = 13;
				break;
			case 43:
				sprite[i].xrepeat = 12;
				sprite[i].yrepeat = 7;
				break;
			case 32:
				sprite[i].xrepeat = 10;
				sprite[i].yrepeat = 9;
				break;
			case 42:
				sprite[i].xrepeat = 10;
				sprite[i].yrepeat = 9;
				break;
			case 5595: //
				sprite[i].xrepeat = 8;
				sprite[i].yrepeat = 8;
				break;
			case 24:
				sprite[i].xrepeat = 17;
				sprite[i].yrepeat = 16;
				break;
			case 78:
				sprite[i].xrepeat = 32;
				sprite[i].yrepeat = 32;
				break;
			case BOATAMMO:
				sprite[i].xrepeat = 16;
				sprite[i].yrepeat = 16;
				break;
			case CHEERBOAT:
				sprite[i].xrepeat = 32;
				sprite[i].yrepeat = 32;
				break;
			case 8487:
				sprite[i].xrepeat = 32;
				sprite[i].yrepeat = 32;
				break;
			case 8489:
				sprite[i].xrepeat = 32;
				sprite[i].yrepeat = 32;
				break;
			case HULKBOAT:
				sprite[i].xrepeat = 48;
				sprite[i].yrepeat = 48;
				break;
			case MINIONBOAT:
				sprite[i].xrepeat = 16;
				sprite[i].yrepeat = 16;
				break;
			case 14:
				sprite[i].xrepeat = 20;
				sprite[i].yrepeat = 20;
				break;

#if 0
			case 22:
				sprite[i].xrepeat = 32;
				sprite[i].yrepeat = 32;
				break;
			case 61: //
				sprite[i].xrepeat = 32;
				sprite[i].yrepeat = 32;
				break;
			case 28: //
				sprite[i].xrepeat = 32;
				sprite[i].yrepeat = 32;
				break;
			case 47:
				sprite[i].xrepeat = 32;
				sprite[i].yrepeat = 32;
				break;
			case 3845:
				sprite[i].xrepeat = 24;
				sprite[i].yrepeat = 17;
				break;
			case 5015:
				sprite[i].xrepeat = 48;
				sprite[i].yrepeat = 48;
				break;
			case 4352:
				sprite[i].xrepeat = 20;
				sprite[i].yrepeat = 20;
				break;
			case 1930:
				sprite[i].xrepeat = 64;
				sprite[i].yrepeat = 64;
				break;
#endif
		}
	}
}

void ExtCleanUp(void)
{
}

void ExtLoadMap(const char *mapname)
{
	func_423A1(0);
	PutScale();
}

void ExtSaveMap(const char *mapname)
{
}

const char *ExtGetSectorCaption(short sectnum)
{
	if ((sector[sectnum].lotag|sector[sectnum].hitag) == 0)
	{
		tempbuf[0] = 0;
	}
	else
	{
		sprintf(tempbuf,"%hu,%hu",(unsigned short)sector[sectnum].hitag,
										  (unsigned short)sector[sectnum].lotag);
	}
	return(tempbuf);
}

const char *ExtGetWallCaption(short wallnum)
{
	if ((wall[wallnum].lotag|wall[wallnum].hitag) == 0)
	{
		tempbuf[0] = 0;
	}
	else
	{
		sprintf(tempbuf,"%hu,%hu",(unsigned short)wall[wallnum].hitag,
										  (unsigned short)wall[wallnum].lotag);
	}
	return(tempbuf);
}

void SpriteName(short spritenum, char *lo2)
{
    sprintf(lo2,names[sprite[spritenum].picnum]);
}

const char *ExtGetSpriteCaption(short spritenum)
{


    if( onnames!=5 &&
        onnames!=6 &&
        (!(onnames==3 || onnames==4))
      )
    {
        tempbuf[0] = 0;
        return(tempbuf);
    }

    if( onnames==5 &&
        ( ((unsigned short)sprite[spritenum].picnum <= 9 ) ||
        ((unsigned short)sprite[spritenum].picnum == SEENINE )
        )
        )
    { tempbuf[0] = 0; return(tempbuf); }

    if( onnames==6 &&
        (unsigned short)sprite[spritenum].picnum != (unsigned short)sprite[cursprite].picnum
      )
    { tempbuf[0] = 0; return(tempbuf); }

    tempbuf[0] = 0;
    if ((sprite[spritenum].lotag|sprite[spritenum].hitag) == 0)
    {
        SpriteName(spritenum,lo);
        if(lo[0]!=0)
        {
            if(sprite[spritenum].pal==1) sprintf(tempbuf,"%s-M",lo);
            else sprintf(tempbuf,"%s",lo);
        }
    }
    else
        if( (unsigned short)sprite[spritenum].picnum == 175)
        {
            sprintf(lo,"%hu",(unsigned short)sprite[spritenum].lotag);
            sprintf(tempbuf,"%hu,%s",(unsigned short)sprite[spritenum].hitag,lo);
        }
        else
            {
                SpriteName(spritenum,lo);
                sprintf(tempbuf,"%hu,%hu %s",
                (unsigned short)sprite[spritenum].hitag,
                (unsigned short)sprite[spritenum].lotag,
                lo);
            }
            return(tempbuf);
}

//printext16 parameters:
//printext16(long xpos, long ypos, short col, short backcol,
//           char name[82], char fontsize)
//  xpos 0-639   (top left)
//  ypos 0-479   (top left)
//  col 0-15
//  backcol 0-15, -1 is transparent background
//  name
//  fontsize 0=8*8, 1=3*5

//drawline16 parameters:
// drawline16(long x1, long y1, long x2, long y2, char col)
//  x1, x2  0-639
//  y1, y2  0-143  (status bar is 144 high, origin is top-left of STATUS BAR)
//  col     0-15

void ExtShowSectorData(short sectnum)   //F5
{
	if (qsetmode == 200)    //In 3D mode
	{
	}
	else
	{
		clearmidstatbar16();             //Clear middle of status bar

		sprintf(tempbuf,"Sector %d",sectnum);
		printext16(8,32,11,-1,tempbuf,0);

		printext16(8,48,11,-1,"8*8 font: ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz 0123456789",0);
		printext16(8,56,11,-1,"3*5 font: ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz 0123456789",1);

		drawline16(320,68,344,80,4);       //Draw house
		drawline16(344,80,344,116,4);
		drawline16(344,116,296,116,4);
		drawline16(296,116,296,80,4);
		drawline16(296,80,320,68,4);
	}
}

void ExtShowWallData(short wallnum)       //F6
{
	if (qsetmode == 200)    //In 3D mode
	{
	}
	else
	{
		clearmidstatbar16();             //Clear middle of status bar

		sprintf(tempbuf,"Wall %d",wallnum);
		printext16(8,32,11,-1,tempbuf,0);
	}
}

void ExtShowSpriteData(short spritenum)   //F6
{
	if (qsetmode == 200)    //In 3D mode
	{
	}
	else
	{
		clearmidstatbar16();             //Clear middle of status bar

		sprintf(tempbuf,"Sprite %d",spritenum);
		printext16(8,32,11,-1,tempbuf,0);
	}
}

void ExtEditSectorData(short sectnum)    //F7
{
	short nickdata;

	if (qsetmode == 200)    //In 3D mode
	{
			//Ceiling
		if (searchstat == 1)
			sector[searchsector].ceilingpicnum++;   //Just a stupid example

			//Floor
		if (searchstat == 2)
			sector[searchsector].floorshade++;      //Just a stupid example
	}
	else                    //In 2D mode
	{
		sprintf(tempbuf,"Sector (%ld) Nick's variable: ",sectnum);
		nickdata = 0;
		nickdata = getnumber16(tempbuf,nickdata,65536L);

		printmessage16("");              //Clear message box (top right of status bar)
		ExtShowSectorData(sectnum);
	}
}

void ExtEditWallData(short wallnum)       //F8
{
	short nickdata;

	if (qsetmode == 200)    //In 3D mode
	{
	}
	else
	{
		sprintf(tempbuf,"Wall (%ld) Nick's variable: ",wallnum);
		nickdata = 0;
		nickdata = getnumber16(tempbuf,nickdata,65536L);

		printmessage16("");              //Clear message box (top right of status bar)
		ExtShowWallData(wallnum);
	}
}

void ExtEditSpriteData(short spritenum)   //F8
{
	short nickdata;

	if (qsetmode == 200)    //In 3D mode
	{
	}
	else
	{
		sprintf(tempbuf,"Sprite (%ld) Nick's variable: ",spritenum);
		nickdata = 0;
		nickdata = getnumber16(tempbuf,nickdata,65536L);
		printmessage16("");

		printmessage16("");              //Clear message box (top right of status bar)
		ExtShowSpriteData(spritenum);
	}
}

faketimerhandler()
{
}

	//Just thought you might want my getnumber16 code
/*
getnumber16(char namestart[80], short num, long maxnumber)
{
	char buffer[80];
	long j, k, n, danum, oldnum;

	danum = (long)num;
	oldnum = danum;
	while ((keystatus[0x1c] != 2) && (keystatus[0x1] == 0))  //Enter, ESC
	{
		sprintf(&buffer,"%s%ld_ ",namestart,danum);
		printmessage16(buffer);

		for(j=2;j<=11;j++)                //Scan numbers 0-9
			if (keystatus[j] > 0)
			{
				keystatus[j] = 0;
				k = j-1;
				if (k == 10) k = 0;
				n = (danum*10)+k;
				if (n < maxnumber) danum = n;
			}
		if (keystatus[0xe] > 0)    // backspace
		{
			danum /= 10;
			keystatus[0xe] = 0;
		}
		if (keystatus[0x1c] == 1)   //L. enter
		{
			oldnum = danum;
			keystatus[0x1c] = 2;
			asksave = 1;
		}
	}
	keystatus[0x1c] = 0;
	keystatus[0x1] = 0;
	return((short)oldnum);
}
*/
