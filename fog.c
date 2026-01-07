

#define dword_1DC1C8 dword_a
#define dword_1DC1CC dword_b
#define dword_1DC1D0 dword_c
#define dword_1DC1D4 dword_d
#define dword_1DC1D8 dword_e

char* dword_1DC1C8, * dword_1DC1CC, * dword_1DC1D0, * dword_1DC1D4, * dword_1DC1D8;
signed char byte_11A3E0[] = {
    0, 0, 1, 1, 1, 32, 16, 24, 12, 12, 12, 24, 24, 24, 32,
    32, 32, 32, 0, 0, 0, 0, 0, 0, 0, 0
}; // fixme
#include "duke3d.h"

void sub_86730(short unk)
{
    static char byte_11A3FA = 0;
    if (!byte_11A3FA)
    {
        short i;
        char table[768];
        byte_11A3FA = 1;
        dword_1DC1C8 = palookup[0];
        dword_1DC1CC = palookup[30];
        dword_1DC1D0 = palookup[33];
        dword_1DC1D4 = palookup[23];
        dword_1DC1D8 = palookup[8];
        for (i = 0; i < 256; i++)
        {
            table[i] = i;
        }
        makepalookup(50,table,byte_11A3E0[8],byte_11A3E0[9],byte_11A3E0[10], 1);
        makepalookup(51,table,byte_11A3E0[8],byte_11A3E0[9],byte_11A3E0[10], 1);
    }
    if (!unk)
    {
        palookup[0] = dword_1DC1C8;
        palookup[30] = dword_1DC1CC;
        palookup[33] = dword_1DC1D0;
        palookup[23] = dword_1DC1D4;
        palookup[8] = dword_1DC1D8;
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
