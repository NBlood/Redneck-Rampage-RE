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

#include "types.h"
#include "develop.h"
#include "scriplib.h"
#include "file_lib.h"
#include "gamedefs.h"
#include "keyboard.h"
#include "util_lib.h"
#include "function.h"
#include "control.h"
#include "fx_man.h"
#include "sounds.h"
#include "config.h"
#include "sndcards.h"

#include "duke3d.h"

extern long lastvisinc;

void animatesprites(long x,long y,short a,long smoothratio)
{
    short i, j, k, p, sect, bg;
    long l, t1,t3,t4;
    spritetype *s,*t;

    bg = 0;

    for(j=0;j < spritesortcnt; j++)
    {
        t = &tsprite[j];
        i = t->owner;
        s = &sprite[t->owner];

        switch(t->picnum)
        {
            case BLOODPOOL:
            case FOOTPRINTS:
            case FOOTPRINTS2:
            case FOOTPRINTS3:
            case FOOTPRINTS4:
                if(t->shade == 127) continue;
                break;
            case CHAIR3:

                k = (((t->ang+3072+128-a)&2047)>>8)&7;
                if(k>4)
                {
                    k = 8-k;
                    t->cstat |= 4;
                }
                else t->cstat &= ~4;
                t->picnum = s->picnum+k;
                break;
            case BLOODSPLAT1:
            case BLOODSPLAT2:
            case BLOODSPLAT3:
            case BLOODSPLAT4:
                if(ud.lockout) t->xrepeat = t->yrepeat = 0;
                else if(t->pal == 6)
                {
                    t->shade = -127;
                    continue;
                }
            case BULLETHOLE:
            case CRACK1:
            case CRACK2:
            case CRACK3:
            case CRACK4:
                t->shade = 16;
                continue;
#ifdef RRRA
            case RRTILE1947:
            case RRTILE2859:
            case RRTILE3774:
            case RRTILE5088:
            case RRTILE8094:
            case RRTILE8096:
                continue;
#endif
            case NEON1:
            case NEON2:
            case NEON3:
            case NEON4:
            case NEON5:
            case NEON6:
                continue;
            default:
                if( ( (t->cstat&16) ) || ( badguy(t) && t->extra > 0) || t->statnum == 10)
                {
                    if (shadedsector[s->sectnum] == 1 && s->statnum != 1)
                    {
                        s->shade = 16;
                        t->shade = 16;
                    }
                    continue;
                }
        }

        if (sector[t->sectnum].ceilingstat&1)
        {
            if (badguy(s))
                l = s->shade;
            else
                l = s->shade;
        }
        else
            l = sector[t->sectnum].floorshade;

        if(l < -127) l = -127;
        if(l > 128) l =  127;
        t->shade = l;
    }


    for(j=0;j < spritesortcnt; j++ )  //Between drawrooms() and drawmasks()
    {                             //is the perfect time to animate sprites
        t = &tsprite[j];
        i = t->owner;
        s = &sprite[i];

        switch(s->picnum)
        {
            case SECTOREFFECTOR:
                if(t->lotag == 27 && ud.recstat == 1)
                {
                    t->picnum = 11+((totalclock>>3)&1);
                    t->cstat |= 128;
                }
                else
                    t->xrepeat = t->yrepeat = 0;
                break;
            case FEM10:
            case NAKED1:
            case FEMMAG1:
            case FEMMAG2:
            case STATUE:
            case STATUEFLASH:
            case OOZ:
            case WALLBLOOD1:
            case WALLBLOOD2:
            case WALLBLOOD3:
            case WALLBLOOD4:
            case WALLBLOOD5:
            case SUSHIPLATE1:
            case SUSHIPLATE2:
            case SUSHIPLATE3:
            case SUSHIPLATE4:
            case DOLPHIN1:
            case DOLPHIN2:
            case TOUGHGAL:
                if(ud.lockout)
                {
                    t->xrepeat = t->yrepeat = 0;
                    continue;
                }
        }

        if( t->statnum == 99 ) continue;
        if( s->statnum != 1 && s->picnum == APLAYER && ps[s->yvel].newowner == -1 && s->owner >= 0 )
        {
            t->x -= mulscale16(65536-smoothratio,ps[s->yvel].posx-ps[s->yvel].oposx);
            t->y -= mulscale16(65536-smoothratio,ps[s->yvel].posy-ps[s->yvel].oposy);
            t->z = ps[s->yvel].oposz + mulscale16(smoothratio,ps[s->yvel].posz-ps[s->yvel].oposz);
            t->z += (40<<8);
            s->xrepeat = 24;
            s->yrepeat = 17;
        }
        else if( ( s->statnum == 0 && s->picnum != CRANEPOLE) || s->statnum == 10 || s->statnum == 6 || s->statnum == 4 || s->statnum == 5 || s->statnum == 1 )
        {
            t->x -= mulscale16(65536-smoothratio,s->x-hittype[i].bposx);
            t->y -= mulscale16(65536-smoothratio,s->y-hittype[i].bposy);
            t->z -= mulscale16(65536-smoothratio,s->z-hittype[i].bposz);
        }

        sect = s->sectnum;
        t1 = T2;t3 = T4;t4 = T5;

        switch(s->picnum)
        {
            case RESPAWNMARKERRED:
            case RESPAWNMARKERYELLOW:
            case RESPAWNMARKERGREEN:
                t->picnum = 861+( (totalclock>>4) & 13);
                if (s->picnum == RESPAWNMARKERRED)
                    t->pal = 0;
                else if (s->picnum == RESPAWNMARKERYELLOW)
                    t->pal = 1;
                else
                    t->pal = 2;
                if (ud.marker == 0)
                    t->xrepeat = t->yrepeat = 0;
                break;
            case DUKELYINGDEAD:
                s->xrepeat = 24;
                s->yrepeat = 17;
                if (s->extra > 0)
                    t->z += (6<<8);
                break;
            case BLOODPOOL:
            case FOOTPRINTS:
            case FOOTPRINTS2:
            case FOOTPRINTS3:
            case FOOTPRINTS4:
                if(t->pal == 6)
                    t->shade = -127;
            case MONEY:
            case MONEY+1:
                if(ud.lockout && s->pal == 2)
                {
                    t->xrepeat = t->yrepeat = 0;
                    continue;
                }
                break;
            case TRIPBOMBSPRITE:
                continue;
            case FORCESPHERE:
                if(t->statnum == 5)
                {
                    short sqa,sqb;

                    sqa =
                        getangle(
                            sprite[s->owner].x-ps[screenpeek].posx,
                            sprite[s->owner].y-ps[screenpeek].posy);
                    sqb =
                        getangle(
                            sprite[s->owner].x-t->x,
                            sprite[s->owner].y-t->y);

                    if( klabs(getincangle(sqa,sqb)) > 512 )
                        if( ldist(&sprite[s->owner],t) < ldist(&sprite[ps[screenpeek].i],&sprite[s->owner]) )
                            t->xrepeat = t->yrepeat = 0;
                }
                continue;
            case BURNING:
                if( sprite[s->owner].statnum == 10 )
                {
                    if( display_mirror == 0 && sprite[s->owner].yvel == screenpeek && ps[sprite[s->owner].yvel].over_shoulder_on == 0 )
                        t->xrepeat = 0;
                    else
                    {
                        t->ang = getangle(x-t->x,y-t->y);
                        t->x = sprite[s->owner].x;
                        t->y = sprite[s->owner].y;
                        t->x += sintable[(t->ang+512)&2047]>>10;
                        t->y += sintable[t->ang&2047]>>10;
                    }
                }
                break;

            case ATOMICHEALTH:
                t->z -= (4<<8);
                break;
            case CRYSTALAMMO:
                t->shade = (sintable[(totalclock<<4)&2047]>>10);
                break;
            case SHRINKSPARK:
#ifdef RRRA
                if (sprite[s->owner].picnum == CHEER || sprite[s->owner].picnum == CHEERSTAYPUT)
                {
                    t->picnum = CHEERBLADE+( (totalclock>>4)&3 );
                    t->shade = -127;
                }
                else
#endif
                t->picnum = SHRINKSPARK+( (totalclock>>4)&7 );
                break;
#ifdef RRRA
            case CHEERBOMB:
                t->picnum = CHEERBOMB+( (totalclock>>4)&3 );
                break;
#endif
            case SPIT:
#ifdef RRRA
                if (sprite[s->owner].picnum == MINION && sprite[s->owner].pal == 8)
                    t->picnum = RRTILE3500+( (totalclock>>4)%6 );
                else if (sprite[s->owner].picnum == MINION && sprite[s->owner].pal == 19)
                {
                    t->picnum = RRTILE5090+( (totalclock>>4)&3 );
                    t->shade = -127;
                }
                else if (sprite[s->owner].picnum == MAMA)
                {
                    k = getangle(s->x-x,s->y-y);
                    k = (((s->ang+3072+128-k)&2047)>>8)&7;
                    if(k>4)
                    {
                        k = 8-k;
                        t->cstat |= 4;
                    }
                    else t->cstat &= ~4;
                    t->picnum = RRTILE7274+k;
                }
                else
#endif
                t->picnum = SPIT+( (totalclock>>4)&3 );
                break;
#ifdef RRRA
            case EMPTYBIKE:
                 k = getangle(s->x-x,s->y-y);
                 k = (((s->ang+3072+128-k)&2047)/170);
                 if(k > 6)
                 {
                    k = 12-k;
                    t->cstat |= 4;
                 }
                 else t->cstat &= ~4;
                 t->picnum = EMPTYBIKE+k;
                 break;
            case EMPTYBOAT:
                 k = getangle(s->x-x,s->y-y);
                 k = (((s->ang+3072+128-k)&2047)/170);
                 if(k > 6)
                 {
                    k = 12-k;
                    t->cstat |= 4;
                 }
                 else t->cstat &= ~4;
                 t->picnum = EMPTYBOAT+k;
                 break;
#endif
            case RPG:
                 k = getangle(s->x-x,s->y-y);
                 k = (((s->ang+3072+128-k)&2047)/170);
                 if(k > 6)
                 {
                    k = 12-k;
                    t->cstat |= 4;
                 }
                 else t->cstat &= ~4;
                 t->picnum = RPG+k;
                 break;
#ifdef RRRA
            case RPG2:
                 k = getangle(s->x-x,s->y-y);
                 k = (((s->ang+3072+128-k)&2047)/170);
                 if(k > 6)
                 {
                    k = 12-k;
                    t->cstat |= 4;
                 }
                 else t->cstat &= ~4;
                 t->picnum = RPG2+k;
                 break;
#endif

            case RECON:

                k = getangle(s->x-x,s->y-y);
                if( T1 < 4 )
                    k = (((s->ang+3072+128-k)&2047)/170);
                else k = (((s->ang+3072+128-k)&2047)/170);

                if(k>6)
                {
                    k = 12-k;
                    t->cstat |= 4;
                }
                else t->cstat &= ~4;

                if( klabs(t3) > 64 ) k += 7;
                t->picnum = RECON+k;

                break;

            case APLAYER:

                p = s->yvel;

                if(t->pal == 1) t->z -= (18<<8);

                if(ps[p].over_shoulder_on > 0 && ps[p].newowner < 0 )
                {
                    t->cstat |= 2;
                    if ( screenpeek == myconnectindex && numplayers >= 2 )
                    {
                        t->x = omyx+mulscale16((long)(myx-omyx),smoothratio);
                        t->y = omyy+mulscale16((long)(myy-omyy),smoothratio);
                        t->z = omyz+mulscale16((long)(myz-omyz),smoothratio)+(40<<8);
                        t->ang = omyang+mulscale16((long)(((myang+1024-omyang)&2047)-1024),smoothratio);
                        t->sectnum = mycursectnum;
                    }
                }

                if( ( display_mirror == 1 || screenpeek != p || s->owner == -1 ) && ud.multimode > 1 && ud.showweapons && sprite[ps[p].i].extra > 0 && ps[p].curr_weapon > 0 )
                {
                    memcpy((spritetype *)&tsprite[spritesortcnt],(spritetype *)t,sizeof(spritetype));

                    tsprite[spritesortcnt].statnum = 99;

                    tsprite[spritesortcnt].yrepeat = ( t->yrepeat>>3 );
                    if(t->yrepeat < 4) t->yrepeat = 4;

                    tsprite[spritesortcnt].shade = t->shade;
                    tsprite[spritesortcnt].cstat = 0;

                    switch(ps[p].curr_weapon)
                    {
                        case PISTOL_WEAPON:      tsprite[spritesortcnt].picnum = FIRSTGUNSPRITE;       break;
                        case SHOTGUN_WEAPON:     tsprite[spritesortcnt].picnum = SHOTGUNSPRITE;        break;
                        case CHAINGUN_WEAPON:    tsprite[spritesortcnt].picnum = CHAINGUNSPRITE;       break;
                        case RPG_WEAPON:         tsprite[spritesortcnt].picnum = RPGSPRITE;            break;
#ifdef RRRA
                        case RA16_WEAPON:        tsprite[spritesortcnt].picnum = RPGSPRITE;
#endif
                        case HANDREMOTE_WEAPON:
                        case HANDBOMB_WEAPON:    tsprite[spritesortcnt].picnum = HEAVYHBOMB;           break;
                        case TRIPBOMB_WEAPON:    tsprite[spritesortcnt].picnum = TRIPBOMBSPRITE;       break;
                        case BOWLING_WEAPON:     tsprite[spritesortcnt].picnum = 3437;                 break;
                        case SHRINKER_WEAPON:    tsprite[spritesortcnt].picnum = SHRINKSPARK;          break;
                        case GROW_WEAPON:        tsprite[spritesortcnt].picnum = SHRINKSPARK;          break;
                        case FREEZE_WEAPON:      tsprite[spritesortcnt].picnum = DEVISTATORSPRITE;     break;
                        case DEVISTATOR_WEAPON:  tsprite[spritesortcnt].picnum = FREEZESPRITE;         break;
                    }

                    if(s->owner >= 0)
                        tsprite[spritesortcnt].z = ps[p].posz-(12<<8);
                    else tsprite[spritesortcnt].z = s->z-(51<<8);
                    if(ps[p].curr_weapon == HANDBOMB_WEAPON)
                    {
                        tsprite[spritesortcnt].xrepeat = 10;
                        tsprite[spritesortcnt].yrepeat = 10;
                    }
#ifdef RRRA
                    else if(ps[p].OnMotorcycle || ps[p].OnBoat)
                    {
                        tsprite[spritesortcnt].xrepeat = 0;
                        tsprite[spritesortcnt].yrepeat = 0;
                    }
#endif
                    else
                    {
                        tsprite[spritesortcnt].xrepeat = 16;
                        tsprite[spritesortcnt].yrepeat = 16;
                    }
                    tsprite[spritesortcnt].pal = 0;
                    spritesortcnt++;
                }

                if(s->owner == -1)
                {
                    k = (((s->ang+3072+128-a)&2047)>>8)&7;
                    if(k>4)
                    {
                        k = 8-k;
                        t->cstat |= 4;
                    }
                    else t->cstat &= ~4;

                    if(sector[t->sectnum].lotag == 2) k += 1795-1405;
                    else if( (hittype[i].floorz-s->z) > (64<<8) ) k += 60;

                    t->picnum += k;
                    t->pal = ps[p].palookup;

                    goto PALONLY;
                }

                if( ps[p].on_crane == -1 && (sector[s->sectnum].lotag&0x7ff) != 1 )
                {
                    l = s->z-hittype[ps[p].i].floorz+(3<<8);
                    if( l > 1024 && s->yrepeat > 32 && s->extra > 0 )
                        s->yoffset = (signed char)(l/(s->yrepeat<<2));
                    else s->yoffset=0;
                }

                if(ps[p].newowner > -1)
                {
                    t4 = *(actorscrptr[APLAYER]+1);
                    t3 = 0;
                    t1 = *(actorscrptr[APLAYER]+2);
                }

                if(ud.camerasprite == -1 && ps[p].newowner == -1)
                    if(s->owner >= 0 && display_mirror == 0 && ps[p].over_shoulder_on == 0 )
                        if( ud.multimode < 2 || ( ud.multimode > 1 && p == screenpeek ) )
                {
                    t->owner = -1;
                    t->xrepeat = t->yrepeat = 0;
                    continue;
                }

                PALONLY:

                if( sector[sect].floorpal )
                    t->pal = sector[sect].floorpal;

                if(s->owner == -1) continue;

                if( t->z > hittype[i].floorz && t->xrepeat < 32 )
                    t->z = hittype[i].floorz;

#ifdef RRRA
                if (ps[p].OnMotorcycle && p == screenpeek)
                {
                    t->picnum = RRTILE7219;
                    t->xrepeat = 18;
                    t->yrepeat = 18;
                    t4 = 0;
                    t3 = 0;
                    t1 = 0;
                }
                else if (ps[p].OnMotorcycle)
                {
                    k = (((s->ang+3072+128-a)&2047)/170);
                    if(k>6)
                    {
                        k = 12-k;
                        t->cstat |= 4;
                    }
                    else t->cstat &= ~4;

                    t->picnum = RRTILE7213+k;
                    t->xrepeat = 18;
                    t->yrepeat = 18;
                    t4 = 0;
                    t3 = 0;
                    t1 = 0;
                }
                else if (ps[p].OnBoat && p == screenpeek)
                {
                    t->picnum = RRTILE7190;
                    t->xrepeat = 32;
                    t->yrepeat = 32;
                    t4 = 0;
                    t3 = 0;
                    t1 = 0;
                }
                else if (ps[p].OnBoat)
                {
                    k = (((s->ang+3072+128-a)&2047)/170);
                    if(k>6)
                    {
                        k = 12-k;
                        t->cstat |= 4;
                    }
                    else t->cstat &= ~4;

                    t->picnum = RRTILE7184+k;
                    t->xrepeat = 32;
                    t->yrepeat = 32;
                    t4 = 0;
                    t3 = 0;
                    t1 = 0;
                }
#endif

                break;

            case MINJIBA:
            case MINJIBB:
            case MINJIBC:
#ifdef RRRA
                if (t->pal == 19)
                    t->shade = -127;
#endif
            case JIBS1:
            case JIBS2:
            case JIBS3:
            case JIBS4:
            case JIBS5:
            case JIBS6:
            case DUKEGUN:
            case DUKETORSO:
            case DUKELEG:
            case BILLYJIBA:
            case BILLYJIBB:
            case HULKJIBA:
            case HULKJIBB:
            case HULKJIBC:
            case COOTJIBA:
            case COOTJIBB:
            case COOTJIBC:
#ifdef RRRA
            case RRTILE2460:
            case RRTILE2465:
            case BIKEJIBA:
            case BIKEJIBB:
            case BIKEJIBC:
            case BIKERJIBA:
            case BIKERJIBB:
            case BIKERJIBC:
            case BIKERJIBD:
            case CHEERJIBA:
            case CHEERJIBB:
            case CHEERJIBC:
            case CHEERJIBD:
            case FBOATJIBA:
            case FBOATJIBB:
            case RABBITJIBA:
            case RABBITJIBB:
            case RABBITJIBC:
            case MAMAJIBA:
            case MAMAJIBB:
#endif
                if(ud.lockout)
                {
                    t->xrepeat = t->yrepeat = 0;
                    continue;
                }
                if(t->pal == 6) t->shade = -120;

                if (shadedsector[s->sectnum] == 1)
                    t->shade = 16;
                
            case SCRAP1:
            case SCRAP2:
            case SCRAP3:
            case SCRAP4:
            case SCRAP5:
            case SCRAP6:
            case SCRAP6+1:
            case SCRAP6+2:
            case SCRAP6+3:
            case SCRAP6+4:
            case SCRAP6+5:
            case SCRAP6+6:
            case SCRAP6+7:

                if(t->picnum == SCRAP1 && s->yvel >= 0)
                    t->picnum = s->yvel;
                else t->picnum += T1;

                if( sector[sect].floorpal )
                    t->pal = sector[sect].floorpal;
                break;

            case WATERBUBBLE:
                if(sector[t->sectnum].floorpicnum == FLOORSLIME)
                {
                    t->pal = 7;
                    break;
                }
            default:

                if( sector[sect].floorpal )
                    t->pal = sector[sect].floorpal;
                break;
        }

        if( actorscrptr[s->picnum] && (t->cstat & 48) != 48)
        {
            if(t4)
            {
                l = *(long *)(t4+8);

                switch( l )
                {
                    case 2:
                        k = (((s->ang+3072+128-a)&2047)>>8)&1;
                        break;

                    case 3:
                    case 4:
                        k = (((s->ang+3072+128-a)&2047)>>7)&7;
                        if(k > 3)
                        {
                            t->cstat |= 4;
                            k = 7-k;
                        }
                        else t->cstat &= ~4;
                        break;

                    case 5:
                        k = getangle(s->x-x,s->y-y);
                        k = (((s->ang+3072+128-k)&2047)>>8)&7;
                        if(k>4)
                        {
                            k = 8-k;
                            t->cstat |= 4;
                        }
                        else t->cstat &= ~4;
                        break;
                    case 7:
                        k = getangle(s->x-x,s->y-y);
                        k = (((s->ang+3072+128-k)&2047)/170);
                        if(k>6)
                        {
                            k = 12-k;
                            t->cstat |= 4;
                        }
                        else t->cstat &= ~4;
                        break;
                    case 8:
                        k = (((s->ang+3072+128-a)&2047)>>8)&7;
                        t->cstat &= ~4;
                        break;
                    default:
                        bg = badguy(s);
                        if (bg && s->statnum == 2 && s->extra > 0)
                        {
                            k = getangle(s->x-x,s->y-y);
                            k = (((s->ang+3072+128-k)&2047)>>8)&7;
                            if(k>4)
                            {
                                k = 8-k;
                                t->cstat |= 4;
                            }
                            else t->cstat &= ~4;
                            break;
                        }
                        k = 0;
                        bg = 0;
                        break;
                }

                if (bg)
                    t->picnum += k + ( *(long *)t4 ) + l * t3;
                else
                    t->picnum += k + ( *(long *)t4 ) + l * t3;

                if(l > 0) while(tilesizx[t->picnum] == 0 && t->picnum > 0 )
                    t->picnum -= l;       //Hack, for actors

                if( hittype[i].dispicnum >= 0)
                    hittype[i].dispicnum = t->picnum;
            }
            else if(display_mirror == 1)
                t->cstat |= 4;
        }

#ifndef RRRA
        if (s->picnum == SBMOVE)
            t->shade = -127;
#endif

        if( s->statnum == 13 || badguy(s) || (s->picnum == APLAYER && s->owner >= 0) )
            if( (s->cstat&48) == 0 && t->statnum != 99 )
                if(s->picnum != EXPLOSION2 && s->picnum != DOMELITE)
                    if(s->picnum != TORNADO)
                        if(s->picnum != EXPLOSION3)
#ifndef RRRA
                            if(s->picnum != SBMOVE)
#endif
        {
            if( hittype[i].dispicnum < 0 )
            {
                hittype[i].dispicnum++;
                continue;
            }
            else if( ud.shadows && spritesortcnt < (MAXSPRITESONSCREEN-2))
            {
                long daz,xrep,yrep;

#ifdef RRRA
                if (sector[sect].lotag == 160) continue;
#endif
                if( (sector[sect].lotag&0xff) > 2 || s->statnum == 4 || s->statnum == 5 || s->picnum == DRONE )
                    daz = sector[sect].floorz;
                else
                    daz = hittype[i].floorz;

                if( (s->z-daz) < (8<<8) )
                    if( ps[screenpeek].posz < daz )
                {
                    memcpy((spritetype *)&tsprite[spritesortcnt],(spritetype *)t,sizeof(spritetype));

                    tsprite[spritesortcnt].statnum = 99;

                    tsprite[spritesortcnt].yrepeat = ( t->yrepeat>>3 );
                    if(t->yrepeat < 4) t->yrepeat = 4;

                    tsprite[spritesortcnt].shade = 127;
                    tsprite[spritesortcnt].cstat |= 2;

                    tsprite[spritesortcnt].z = daz;
                    xrep = tsprite[spritesortcnt].xrepeat;// - (klabs(daz-t->z)>>11);
                    tsprite[spritesortcnt].xrepeat = xrep;
                    tsprite[spritesortcnt].pal = 4;

                    yrep = tsprite[spritesortcnt].yrepeat;// - (klabs(daz-t->z)>>11);
                    tsprite[spritesortcnt].yrepeat = yrep;
                    spritesortcnt++;
                }
            }
        }


        switch(s->picnum)
        {
            case EXPLOSION2:
            case FREEZEBLAST:
            case ATOMICHEALTH:
            case FIRELASER:
            case SHRINKSPARK:
            case CHAINGUN:
            case RPG:
            case EXPLOSION3:
            case COOLEXPLOSION1:
            case OWHIP:
            case UWHIP:
#ifdef RRRA
            case RPG2:
            case RRTILE1790:
#endif
                if(t->picnum == EXPLOSION2)
                {
                    ps[screenpeek].visibility = -127;
                    lastvisinc = totalclock+32;
                    restorepalette = 1;
                    t->pal = 0;
                }
                else if(t->picnum == FIRELASER)
                {
                    t->picnum = FIRELASER+((totalclock>>2)&5);
                }
                t->shade = -127;
                break;
            case UFOBEAM:
            case RRTILE3586:
            case RRTILE3587:
                t->cstat |= 32768;
                s->cstat |= 32768;
                break;
            case DESTRUCTO:
                t->cstat |= 32768;
                break;
            case FIRE:
            case BURNING:
                if( sprite[s->owner].picnum != TREE1 && sprite[s->owner].picnum != TREE2 )
                    t->z = sector[t->sectnum].floorz;
                t->shade = -127;
                break;
            case RRTILE1878:
            case RRTILE1952:
            case RRTILE1953:
            case RRTILE1990:
            case RRTILE2050:
            case RRTILE2056:
            case RRTILE2072:
            case RRTILE2075:
            case RRTILE2083:
            case RRTILE2097:
            case RRTILE2156:
            case RRTILE2157:
            case RRTILE2158:
            case RRTILE2159:
            case RRTILE2160:
            case RRTILE2161:
            case RRTILE2175:
            case RRTILE2176:
            case RRTILE2357:
            case RRTILE2564:
            case RRTILE2573:
            case RRTILE2574:
            case RRTILE2583:
            case RRTILE2604:
            case RRTILE2689:
            case RRTILE2893:
            case RRTILE2894:
            case RRTILE2915:
            case RRTILE2945:
            case RRTILE2946:
            case RRTILE2947:
            case RRTILE2948:
            case RRTILE2949:
            case RRTILE2977:
            case RRTILE2978:
            case RRTILE3116:
            case RRTILE3171:
            case RRTILE3216:
            case RRTILE3720:
#ifdef RRRA
            case WALLLIGHT3:
            case WALLLIGHT1:
            case RRTILE3668:
            case RRTILE3795:
            case RRTILE5035:
            case RRTILE7505:
            case RRTILE7506:
            case RRTILE7533:
            case RRTILE8216:
            case RRTILE8218:
            case RRTILE8220:
#endif
                t->shade = -127;
                break;
#ifdef RRRA
            case CHEER:
                if (t->picnum >= CHEER+102 && t->picnum <= CHEER+151)
                    t->shade = -127;
                break;
            case MINION:
                if (t->pal == 19)
                    t->shade = -127;
                break;
            case BIKER:
                if (t->picnum >= BIKER+54 && t->picnum <= BIKER+58)
                    t->shade = -127;
                else if (t->picnum >= BIKER+84 && t->picnum <= BIKER+88)
                    t->shade = -127;
                break;
            case BILLYRAY:
            case BILLYRAYSTAYPUT:
                if (t->picnum >= BILLYRAY+5 && t->picnum <= BILLYRAY+9)
                    t->shade = -127;
                break;
#endif
            case RRTILE2034:
                t->picnum = RRTILE2034+(totalclock&1);
                break;
            case RRTILE2944:
                t->shade = -127;
                t->picnum = RRTILE2944+((totalclock>>2)&4);
                break;
            case PLAYERONWATER:

                k = (((t->ang+3072+128-a)&2047)>>8)&7;
                if(k>4)
                {
                    k = 8-k;
                    t->cstat |= 4;
                }
                else t->cstat &= ~4;

                t->picnum = s->picnum+k+((T1<4)*5);
                t->shade = sprite[s->owner].shade;
                break;
            case MUD:
                t->picnum = MUD+t1;
                break;
            case WATERSPLASH2:
                t->picnum = WATERSPLASH2+t1;
                break;
            case REACTOR2:
                t->picnum = s->picnum + T3;
                break;
            case SHELL:
                t->picnum = s->picnum+(T1&1);
            case SHOTGUNSHELL:
                t->cstat |= 12;
                if(T1 > 1) t->cstat &= ~4;
                if(T1 > 2) t->cstat &= ~12;
                break;
            case FRAMEEFFECT1:
                if(s->owner >= 0 && sprite[s->owner].statnum < MAXSTATUS)
                {
                    if(sprite[s->owner].picnum == APLAYER)
                        if(ud.camerasprite == -1)
                            if(screenpeek == sprite[s->owner].yvel && display_mirror == 0)
                    {
                        t->owner = -1;
                        break;
                    }
                    if( (sprite[s->owner].cstat&32768) == 0 )
                    {
                        if(sprite[s->owner].picnum == APLAYER)
                            t->picnum = 1554;
                        else
                            t->picnum = hittype[s->owner].dispicnum;
                        t->pal = sprite[s->owner].pal;
                        t->shade = sprite[s->owner].shade;
                        t->ang = sprite[s->owner].ang;
                        t->cstat = 2|sprite[s->owner].cstat;
                    }
                }
                break;
            
            case CAMERA1:
            case RAT:
                k = (((t->ang+3072+128-a)&2047)>>8)&7;
                if(k>4)
                {
                    k = 8-k;
                    t->cstat |= 4;
                }
                else t->cstat &= ~4;
                t->picnum = s->picnum+k;
                break;
        }

        hittype[i].dispicnum = t->picnum;
        if(sector[t->sectnum].floorpicnum == MIRROR)
            t->xrepeat = t->yrepeat = 0;
    }
}
