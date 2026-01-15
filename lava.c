//-------------------------------------------------------------------------
/*
Copyright (C) 1996, 2003 - 3D Realms Entertainment
Copyright (C) 2017-2019 Nuke.YKT

This file is part of Duke Nukem 3D version 1.5 - Atomic Edition

Duke Nukem 3D is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

Original Source: 1996 - Todd Replogle
Prepared for public release: 03/21/2003 - Charlie Wiederhold, 3D Realms
*/
//-------------------------------------------------------------------------
#include "duke3d.h"

#ifdef DEMO

#define LAVASIZ 128
#define LAVALOGSIZ 7
#define LAVAMAXDROPS 32
static char lavabakpic[(LAVASIZ+4)*(LAVASIZ+4)], lavainc[LAVASIZ];
static long lavanumdrops, lavanumframes;
static long lavadropx[LAVAMAXDROPS], lavadropy[LAVAMAXDROPS];
static long lavadropsiz[LAVAMAXDROPS], lavadropsizlookup[LAVAMAXDROPS];
static long lavaradx[32][128], lavarady[32][128], lavaradcnt[32];
#endif

#ifdef DEMO

short torchcnt;
short jaildoorcnt;

short torchsector[64];
short torchsectorshade[64];
short torchtype[64];

short lightnincnt;

short jaildoorsound[32];
long jaildoordrag[32];
long jaildoorspeed[32];
short jaildoorsecthtag[32];
long jaildoordist[32];
short jaildoordir[32];
short jaildooropen[32];
short jaildoorsect[32];

short lightninsector[64];
short lightninsectorshade[64];
#elif defined(RRRA)
extern int lp1, lp2, lp3, lp4;
short torchcnt;
short jaildoorcnt;
short minecartcnt;

short torchsector[64];
short torchsectorshade[64];
short torchtype[64];

short jaildoorsound[32];
long jaildoordrag[32];
long jaildoorspeed[32];
short jaildoorsecthtag[32];
long jaildoordist[32];
short jaildoordir[32];
short jaildooropen[32];
short jaildoorsect[32];

short lightninsector[64];
short lightninsectorshade[64];

short minecartdir[16];
long minecartspeed[16];
short minecartchildsect[16];
short minecartsound[16];
long minecartdist[16];
long minecartdrag[16];
short minecartopen[16];
short minecartsect[16];

short lightnincnt;
#elif defined(TEY)

short torchsectorshade[64];
short torchtype[64];
short torchsector[64];
extern int lp1, lp2, lp3, lp4, lp5, lp6, lp7, lp8, lp9, lp10;

extern int lp11, lp12;


short jaildoorcnt;
short minecartcnt;
short torchcnt;

short jaildoorsect[32];
short lightninsectorshade[64];
short minecartsect[16];
short minecartopen[16];
long minecartdrag[16];
short jaildooropen[32];
short jaildoordir[32];
long jaildoordist[32];
short lightninsector[64];
long minecartdist[16];
short jaildoorsecthtag[32];
long jaildoorspeed[32];
short minecartchildsect[16];
long jaildoordrag[32];
short jaildoorsound[32];
short minecartdir[16];
short minecartsound[16];
long minecartspeed[16];

short lightnincnt;
#else
short torchcnt;
short jaildoorcnt;
short minecartcnt;

extern char _wp1,_wp2,_wp3,_wp4,_wp5,_wp6;

short torchsector[64];
short torchsectorshade[64];
short torchtype[64];

short lightnincnt;

short jaildoorsound[32];
long jaildoordrag[32];
long jaildoorspeed[32];
short jaildoorsecthtag[32];
long jaildoordist[32];
short jaildoordir[32];
short jaildooropen[32];
short jaildoorsect[32];

short minecartdir[16];
long minecartspeed[16];
short minecartchildsect[16];
short minecartsound[16];
long minecartdist[16];
long minecartdrag[16];
short minecartopen[16];
short minecartsect[16];

short lightninsector[64];
short lightninsectorshade[64];
#endif

#ifdef DEMO
initlava()
{
	long x, y, z, r;

	for(x=-16;x<=16;x++)
		for(y=-16;y<=16;y++)
		{
			r = ksqrt(x*x + y*y);
			lavaradx[r][lavaradcnt[r]] = x;
			lavarady[r][lavaradcnt[r]] = y;
			lavaradcnt[r]++;
		}

	for(z=0;z<16;z++)
		lavadropsizlookup[z] = 8 / (ksqrt(z)+1);

	for(z=0;z<LAVASIZ;z++)
		lavainc[z] = klabs((((z^17)>>4)&7)-4)+12;

	lavanumdrops = 0;
	lavanumframes = 0;
}

#pragma aux addlava =\
	"mov al, byte ptr [ebx-133]",\
	"mov dl, byte ptr [ebx-1]",\
	"add al, byte ptr [ebx-132]",\
	"add dl, byte ptr [ebx+131]",\
	"add al, byte ptr [ebx-131]",\
	"add dl, byte ptr [ebx+132]",\
	"add al, byte ptr [ebx+1]",\
	"add al, dl",\
	parm [ebx]\
	modify exact [eax edx]\

movelava(char *dapic)
{
	long i, j, x, y, z, zz, dalavadropsiz, dadropsizlookup;
	long dalavax, dalavay, *ptr, *ptr2;

	for(z=min(LAVAMAXDROPS-lavanumdrops-1,3);z>=0;z--)
	{
		lavadropx[lavanumdrops] = (rand()&(LAVASIZ-1));
		lavadropy[lavanumdrops] = (rand()&(LAVASIZ-1));
		lavadropsiz[lavanumdrops] = 1;
		lavanumdrops++;
	}

	for(z=lavanumdrops-1;z>=0;z--)
	{
		dadropsizlookup = lavadropsizlookup[lavadropsiz[z]]*(((z&1)<<1)-1);
		dalavadropsiz = lavadropsiz[z];
		dalavax = lavadropx[z]; dalavay = lavadropy[z];
		for(zz=lavaradcnt[lavadropsiz[z]]-1;zz>=0;zz--)
		{
			i = (((lavaradx[dalavadropsiz][zz]+dalavax)&(LAVASIZ-1))<<LAVALOGSIZ);
			i += ((lavarady[dalavadropsiz][zz]+dalavay)&(LAVASIZ-1));
			dapic[i] += dadropsizlookup;
			if (dapic[i] < 192) dapic[i] = 192;
		}

		lavadropsiz[z]++;
		if (lavadropsiz[z] > 10)
		{
			lavanumdrops--;
			lavadropx[z] = lavadropx[lavanumdrops];
			lavadropy[z] = lavadropy[lavanumdrops];
			lavadropsiz[z] = lavadropsiz[lavanumdrops];
		}
	}

		//Back up dapic with 1 pixel extra on each boundary
		//(to prevent anding for wrap-around)
	ptr = (long *)dapic;
	ptr2 = (long *)((LAVASIZ+4)+1+((long)lavabakpic));
	for(x=0;x<LAVASIZ;x++)
	{
		for(y=(LAVASIZ>>2);y>0;y--) *ptr2++ = ((*ptr++)&0x1f1f1f1f);
		ptr2++;
	}
	for(y=0;y<LAVASIZ;y++)
	{
		lavabakpic[y+1] = (dapic[y+((LAVASIZ-1)<<LAVALOGSIZ)]&31);
		lavabakpic[y+1+(LAVASIZ+1)*(LAVASIZ+4)] = (dapic[y]&31);
	}
	for(x=0;x<LAVASIZ;x++)
	{
		lavabakpic[(x+1)*(LAVASIZ+4)] = (dapic[(x<<LAVALOGSIZ)+(LAVASIZ-1)]&31);
		lavabakpic[(x+1)*(LAVASIZ+4)+(LAVASIZ+1)] = (dapic[x<<LAVALOGSIZ]&31);
	}
	lavabakpic[0] = (dapic[LAVASIZ*LAVASIZ-1]&31);
	lavabakpic[LAVASIZ+1] = (dapic[LAVASIZ*(LAVASIZ-1)]&31);
	lavabakpic[(LAVASIZ+4)*(LAVASIZ+1)] = (dapic[LAVASIZ-1]&31);
	lavabakpic[(LAVASIZ+4)*(LAVASIZ+2)-1] = (dapic[0]&31);

	ptr = (long *)dapic;
	for(x=0;x<LAVASIZ;x++)
	{
		i = (long)&lavabakpic[(x+1)*(LAVASIZ+4)+1];
		j = i+LAVASIZ;
		for(y=i;y<j;y+=4)
		{
			*ptr++ = ((addlava(y+0)&0x70)>>3)+
						((addlava(y+1)&0x70)<<5)+
						((addlava(y+2)&0x70)<<13)+
						((addlava(y+3)&0x70)<<21)+
						0xc2c2c2c2;
		}
	}

	lavanumframes++;
}

#endif

void dotorch(void)
{
#ifdef RRRA
    int ds;
    short j;
    short i;
    short endwall;
    short startwall;
    char shade;
#else
    int ds;
    short j, i;
    short startwall, endwall;
    char shade;
#endif
    ds = TRAND&8;
    for (i = 0; i < torchcnt; i++)
    {
        shade = torchsectorshade[i] - ds;
        switch (torchtype[i])
        {
            case 0:
                sector[torchsector[i]].floorshade = shade;
                sector[torchsector[i]].ceilingshade = shade;
                break;
            case 1:
                sector[torchsector[i]].ceilingshade = shade;
                break;
            case 2:
                sector[torchsector[i]].floorshade = shade;
                break;
            case 4:
                sector[torchsector[i]].ceilingshade = shade;
                break;
            case 5:
                sector[torchsector[i]].floorshade = shade;
                break;
        }
        startwall = sector[torchsector[i]].wallptr;
        endwall = startwall + sector[torchsector[i]].wallnum;
        for (j = startwall; j < endwall; j++)
        {
            if (wall[j].lotag != 1)
            {
                switch (torchtype[i])
                {
                    case 0:
                        wall[j].shade = shade;
                        break;
                    case 1:
                        wall[j].shade = shade;
                        break;
                    case 2:
                        wall[j].shade = shade;
                        break;
                    case 3:
                        wall[j].shade = shade;
                        break;
                }
            }
        }
    }
}

#ifdef DEMO
int jailtime = 0;
int oldjailtime = 0;
#endif

void dojaildoor(void)
{
    short i, j;
    short startwall, endwall;
    long x, y;
    long speed;
#ifdef DEMO
    int tics;
    int now;
#endif

#ifdef DEMO

    oldjailtime = jailtime;
    now = totalclock;
    tics = now - oldjailtime;
    jailtime = now;

    if (ud.pause_on == 1)
        return;
#endif

    for (i = 0; i < jaildoorcnt; i++)
    {
#ifdef DEMO
        speed = (jaildoorspeed[i] * tics) >> 4;
#else
        if (numplayers < 2)
            speed = jaildoorspeed[i];
        else
            speed = jaildoorspeed[i];
#endif
        if (speed < 2)
            speed = 2;
        if (jaildooropen[i] == 1)
        {
            jaildoordrag[i] -= speed;
            if (jaildoordrag[i] <= 0)
            {
                jaildoordrag[i] = 0;
                jaildooropen[i] = 2;
                switch (jaildoordir[i])
                {
                    case 10:
                        jaildoordir[i] = 30;
                        break;
                    case 20:
                        jaildoordir[i] = 40;
                        break;
                    case 30:
                        jaildoordir[i] = 10;
                        break;
                    case 40:
                        jaildoordir[i] = 20;
                        break;
                }
            }
            else
            {
                startwall = sector[jaildoorsect[i]].wallptr;
                endwall = startwall + sector[jaildoorsect[i]].wallnum;
                for (j = startwall; j < endwall; j++)
                {
                    switch (jaildoordir[i])
                    {
                        case 10:
                            x = wall[j].x;
                            y = wall[j].y + speed;
                            break;
                        case 20:
                            x = wall[j].x - speed;
                            y = wall[j].y;
                            break;
                        case 30:
                            x = wall[j].x;
                            y = wall[j].y - speed;
                            break;
                        case 40:
                            x = wall[j].x + speed;
                            y = wall[j].y;
                            break;
                    }
                    dragpoint(j,x,y);
                }
            }
        }
        if (jaildooropen[i] == 3)
        {
            jaildoordrag[i] -= speed;
            if (jaildoordrag[i] <= 0)
            {
                jaildoordrag[i] = 0;
                jaildooropen[i] = 0;
                switch (jaildoordir[i])
                {
                    case 10:
                        jaildoordir[i] = 30;
                        break;
                    case 20:
                        jaildoordir[i] = 40;
                        break;
                    case 30:
                        jaildoordir[i] = 10;
                        break;
                    case 40:
                        jaildoordir[i] = 20;
                        break;
                }
            }
            else
            {
                startwall = sector[jaildoorsect[i]].wallptr;
                endwall = startwall + sector[jaildoorsect[i]].wallnum;
                for (j = startwall; j < endwall; j++)
                {
                    switch (jaildoordir[i])
                    {
                        case 10:
                            x = wall[j].x;
                            y = wall[j].y + speed;
                            break;
                        case 20:
                            x = wall[j].x - speed;
                            y = wall[j].y;
                            break;
                        case 30:
                            x = wall[j].x;
                            y = wall[j].y - speed;
                            break;
                        case 40:
                            x = wall[j].x + speed;
                            y = wall[j].y;
                            break;
                    }
                    dragpoint(j,x,y);
                }
            }
        }
    }
}

#ifndef DEMO
void moveminecart(void)
{
#ifdef RRRA
    short i;
    short j;
    short nextj;
    short endwall;
    short startwall;
    long y;
    long speed;
    long max_y;
    short csect;
    long cx;
    long cy;
    long min_x;
    long x;
    long min_y;
    long max_x;
    long unk;
#else
    short i;
    short j;
    short csect;
    short startwall;
    short endwall;
    long speed;
    long y;
    long x;
    short nextj;
    long cx;
    long cy;
    long unk;
    long max_x;
    long min_y;
    long max_y;
    long min_x;
#endif
    for (i = 0; i < minecartcnt; i++)
    {
        speed = minecartspeed[i];
        if (speed < 2)
            speed = 2;

        if (minecartopen[i] == 1)
        {
            minecartdrag[i] -= speed;
            if (minecartdrag[i] <= 0)
            {
                minecartdrag[i] = minecartdist[i];
                minecartopen[i] = 2;
                switch (minecartdir[i])
                {
                    case 10:
                        minecartdir[i] = 30;
                        break;
                    case 20:
                        minecartdir[i] = 40;
                        break;
                    case 30:
                        minecartdir[i] = 10;
                        break;
                    case 40:
                        minecartdir[i] = 20;
                        break;
                }
            }
            else
            {
                startwall = sector[minecartsect[i]].wallptr;
                endwall = startwall + sector[minecartsect[i]].wallnum;
                for (j = startwall; j < endwall; j++)
                {
                    switch (minecartdir[i])
                    {
                        case 10:
                            x = wall[j].x;
                            y = wall[j].y + speed;
                            break;
                        case 20:
                            x = wall[j].x - speed;
                            y = wall[j].y;
                            break;
                        case 30:
                            x = wall[j].x;
                            y = wall[j].y - speed;
                            break;
                        case 40:
                            x = wall[j].x + speed;
                            y = wall[j].y;
                            break;
                    }
                    dragpoint(j,x,y);
                }
            }
        }
        if (minecartopen[i] == 2)
        {
            minecartdrag[i] -= speed;
            if (minecartdrag[i] <= 0)
            {
                minecartdrag[i] = minecartdist[i];
                minecartopen[i] = 1;
                switch (minecartdir[i])
                {
                    case 10:
                        minecartdir[i] = 30;
                        break;
                    case 20:
                        minecartdir[i] = 40;
                        break;
                    case 30:
                        minecartdir[i] = 10;
                        break;
                    case 40:
                        minecartdir[i] = 20;
                        break;
                }
            }
            else
            {
                startwall = sector[minecartsect[i]].wallptr;
                endwall = startwall + sector[minecartsect[i]].wallnum;
                for (j = startwall; j < endwall; j++)
                {
                    switch (minecartdir[i])
                    {
                        case 10:
                            x = wall[j].x;
                            y = wall[j].y + speed;
                            break;
                        case 20:
                            x = wall[j].x - speed;
                            y = wall[j].y;
                            break;
                        case 30:
                            x = wall[j].x;
                            y = wall[j].y - speed;
                            break;
                        case 40:
                            x = wall[j].x + speed;
                            y = wall[j].y;
                            break;
                    }
                    dragpoint(j,x,y);
                }
            }
        }
        csect = minecartchildsect[i];
        startwall = sector[csect].wallptr;
        endwall = startwall + sector[csect].wallnum;
        max_x = max_y = -0x20000;
        min_x = min_y = 0x20000;
        for (j = startwall; j < endwall; j++)
        {
            x = wall[j].x;
            y = wall[j].y;
            if (x > max_x)
                max_x = x;
            if (y > max_y)
                max_y = y;
            if (x < min_x)
                min_x = x;
            if (y < min_y)
                min_y = y;
        }
        cx = (max_x + min_x) >> 1;
        cy = (max_y + min_y) >> 1;
        j = headspritesect[csect];
        while (j != -1)
        {
            nextj = nextspritesect[j];
            if (badguy(&sprite[j]))
                setsprite(j,cx,cy,sprite[j].z);
            j = nextj;
        }
    }
}

#endif
