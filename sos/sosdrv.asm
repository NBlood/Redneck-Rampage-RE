.386p
.MODEL SMALL

.DATA

PUBLIC __wSOSData2Start
__wSOSData2Start dd 0

byte_107EA      db 50h dup(0)
dword_1083A     dd 0
dword_1083E     dd 0
dword_10842     dd 0
dword_10846     dd 0
dword_1084A     dd 0
                dd 0
                dd 0
                dd 0
                dd 0
                dd 0
                dd 0
                dd 0
                dd 0
                dd 0
                dd 0
                dd 0
byte_1087A      db 50h dup(0)
PUBLIC _wDetectPort
_wDetectPort    dd 0
PUBLIC _wDetectDMA
_wDetectDMA     dd 0
PUBLIC _wDetectIRQ
_wDetectIRQ     dd 0
PUBLIC _wDetectParam
_wDetectParam   dd 0
word_108DA      dw 0
PUBLIC __wSOSData2End
__wSOSData2End dd 0

.CODE

extrn __GETDS:near

PUBLIC _sosModule12Start
_sosModule12Start PROC
    retn
ENDP

PUBLIC _sosDRVLockMemory
_sosDRVLockMemory PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     cx, [ebp+8]
    mov     bx, [ebp+0Ah]
    mov     di, [ebp+0Ch]
    mov     si, [ebp+0Eh]
    mov     ax, 600h
    int     31h
    mov     eax, 0
    jnb     loc_10035
    mov     eax, 1
loc_10035:
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDRVUnLockMemory
_sosDRVUnLockMemory PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     cx, [ebp+8]
    mov     bx, [ebp+0Ah]
    mov     di, [ebp+0Ch]
    mov     si, [ebp+0Eh]
    mov     ax, 601h
    int     31h
    mov     eax, 0
    jnb     loc_10072
    mov     eax, 1
loc_10072:
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosAllocateFarMem
_sosAllocateFarMem PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     ax, 0
    mov     cx, 1
    int     31h
    push    eax
    mov     word_108DA, ax
    push    eax
    mov     bx, ax
    mov     ax, 8
    xor     cx, cx
    mov     edx, [ebp+8]
    int     31h
    pop     eax
    mov     ax, 501h
    xor     ebx, ebx
    mov     ecx, [ebp+8]
    add     cx, 50h
    int     31h
    jnb     loc_100D0
    pop     eax
    mov     eax, 0
    mov     edx, 0
    jmp     loc_1011E
loc_100D0:
    push    ebx
    mov     ebx, [ebp+0Ch]
    mov     [ebx], si
    mov     [ebx+2], di
    pop     ebx
    pop     eax
    push    eax
    mov     esi, [ebp+10h]
    mov     [esi], cx
    mov     [esi+2], bx
    mov     dx, cx
    mov     cx, bx
    mov     bx, ax
    mov     ax, 7
    int     31h
    movzx   ecx, word_108DA
    lar     ecx, ecx
    shr     ecx, 8
    or      cx, 4000h
    mov     bx, word_108DA
    mov     ax, 9
    int     31h
    pop     eax
    xor     edx, edx
    mov     dx, ax
    xor     eax, eax
loc_1011E:
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosFreeSelector
_sosFreeSelector PROC
    push    eax
    mov     ax, ds
    mov     gs, ax
    pop     eax
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     si, [ebp+10h]
    mov     di, [ebp+12h]
    mov     ax, 502h
    int     31h
    mov     ax, 1
    mov     bx, [ebp+0Ch]
    int     31h
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosCreateAliasCS
_sosCreateAliasCS PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     ax, 0
    mov     cx, 1
    int     31h
    push    eax
    push    eax
    push    eax
    push    eax
    mov     bx, [ebp+0Ch]
    mov     ax, 6
    int     31h
    pop     ebx
    mov     ax, 7
    int     31h
    xor     ebx, ebx
    mov     bx, [ebp+0Ch]
    lsl     edx, ebx
    mov     ax, 8
    pop     ebx
    xor     ecx, ecx
    int     31h
    mov     ax, 9
    pop     ebx
    lar     ecx, ebx
    shr     ecx, 8
    or      cx, 4008h
    int     31h
    pop     edx
    xor     eax, eax
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosRealAlloc
_sosRealAlloc PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    xor     eax, eax
    mov     ax, 100h
    mov     ebx, [ebp+8]
    add     ebx, 100h
    int     31h
    mov     esi, [ebp+0Ch]
    shl     eax, 4
    mov     [esi], eax
    mov     esi, [ebp+10h]
    mov     [esi], dx
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosRealFree
_sosRealFree PROC
    mov     ax, ds
    mov     gs, ax
    mov     es, ax
    mov     fs, ax
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    xor     eax, eax
    mov     ax, 101h
    mov     edx, [ebp+0Ch]
    int     31h
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDRVGetCapsInfo
_sosDRVGetCapsInfo proc near
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     eax, 8
    lfs     edi, fword ptr [ebp+10h]
    mov     dx, ds
    call    fword ptr [ebp+8]
    push    ds
    push    ds
    pop     es
    mov     edi, [ebp+18h]
    lds     esi, fword ptr [ebp+10h]
    mov     esi, edx
    mov     ecx, 6Ah
    cld
    rep movsb
    pop     ds
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDRVGetCapsPtr
_sosDRVGetCapsPtr PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     eax, 8
    lfs     edi, fword ptr [ebp+10h]
    mov     dx, ds
    call    fword ptr [ebp+8]
    push    ds
    push    es
    push    ds
    pop     es
    mov     edi, [ebp+18h]
    lds     esi, fword ptr [ebp+10h]
    mov     esi, edx
    mov     ecx, 6Ah
    cld
    rep movsb
    pop     es
    pop     ds
    push    ds
    push    es
    push    ds
    pop     es
    mov     edi, [ebp+18h]
    mov     ds, word ptr [ebp+14h]
    mov     word ptr es:[edi+44h], ds
    mov     word ptr es:[edi+4Ch], ds
    mov     word ptr es:[edi+54h], ds
    mov     word ptr es:[edi+5Ch], ds
    pop     es
    pop     ds
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDRVStop
_sosDRVStop PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     eax, 5
    lfs     edi, fword ptr [ebp+10h]
    call    fword ptr [ebp+8]
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDetDRVExist
_sosDetDRVExist PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     eax, 0
    lfs     edi, fword ptr [ebp+10h]
    call    fword ptr [ebp+8]
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDetDRVGetSettings
_sosDetDRVGetSettings PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     eax, 1
    lfs     edi, fword ptr [ebp+10h]
    call    fword ptr [ebp+8]
    mov     word ptr _wDetectPort, ax
    mov     al, ch
    cbw
    mov     word ptr _wDetectIRQ, ax
    mov     al, cl
    cbw
    mov     word ptr _wDetectDMA, ax
    mov     word ptr _wDetectParam, dx
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDetDRVGetCapsInfo
_sosDetDRVGetCapsInfo PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    push    es
    mov     eax, 2
    lfs     edi, fword ptr [ebp+10h]
    call    fword ptr [ebp+8]
    push    ds
    push    ds
    pop     es
    mov     edi, [ebp+18h]
    lds     esi, fword ptr [ebp+10h]
    mov     esi, edx
    mov     ecx, 6Ah
    cld
    rep movsb
    pop     ds
    pop     es
    push    ds
    push    es
    push    ds
    pop     es
    mov     edi, [ebp+18h]
    mov     ds, word ptr [ebp+14h]
    mov     word ptr es:[edi+44h], ds
    mov     word ptr es:[edi+4Ch], ds
    mov     word ptr es:[edi+54h], ds
    mov     word ptr es:[edi+5Ch], ds
    pop     es
    pop     ds
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDetDRVVerifySettings
_sosDetDRVVerifySettings PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     ebx, [ebp+10h]
    mov     eax, [ebp+14h]
    mov     ch, al
    mov     eax, [ebp+18h]
    mov     cl, al
    mov     eax, 3
    lfs     edi, fword ptr [ebp+1Ch]
    call    fword ptr [ebp+8]
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDRVUnInit
_sosDRVUnInit PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     eax, 1
    lfs     edi, fword ptr [ebp+10h]
    call    fword ptr [ebp+8]
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDRVInit
_sosDRVInit PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    lfs     edi, fword ptr [ebp+10h]
    mov     eax, 0
    mov     bx, [ebp+18h]
    mov     cx, [ebp+1Ch]
    mov     dx, [ebp+20h]
    mov     ch, dl
    mov     si, [ebp+2Ch]
    call    fword ptr [ebp+8]
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDRVStart
_sosDRVStart PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    lfs     edi, fword ptr [ebp+10h]
    mov     eax, 4
    mov     ecx, [ebp+1Ch]
    mov     edi, [ebp+18h]
    call    fword ptr [ebp+8]
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP


PUBLIC _sosDRVSetRate
_sosDRVSetRate PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    lfs     edi, fword ptr [ebp+10h]
    mov     eax, 2
    mov     ebx, [ebp+18h]
    call    fword ptr [ebp+8]
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDRVSetAction
_sosDRVSetAction PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    lfs     edi, fword ptr [ebp+10h]
    mov     eax, 3
    mov     bx, 8
    call    fword ptr [ebp+8]
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDIGIHandleVDS
_sosDIGIHandleVDS PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     ax, 1600h
    int     2Fh
    cmp     ax, 0A03h
    mov     eax, [ebp+14h]
    jnz     loc_104B3
loc_104B3:
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDIGIInitForWindows
_sosDIGIInitForWindows PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     ax, 1600h
    int     2Fh
    cmp     al, 3
    jnz     loc_104E8
    mov     ah, 81h
    mov     al, 0Bh
    mov     ebx, [ebp+8]
    xor     dx, dx
    int     4Bh
    mov     ax, 0
loc_104E8:
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDIGIUnInitForWindows
_sosDIGIUnInitForWindows PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     ax, 1600h
    int     2Fh
    cmp     al, 3
    jnz     loc_1051D
    mov     ah, 81h
    mov     al, 0Ch
    mov     ebx, [ebp+8]
    xor     dx, dx
    int     4Bh
    mov     ax, 0

loc_1051D:
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDetDRVEnvStringInit
_sosDetDRVEnvStringInit PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    lfs     edi, fword ptr [ebp+10h]
    mov     eax, 4
    call    fword ptr [ebp+8]
    mov     dword_1083A, esi
    mov     dword_10842, edi
    mov     ax, word ptr [ebp+14h]
    mov     word ptr dword_1083E, ax
    mov     word ptr dword_10846, ax
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDetDRVGetEnvString
_sosDetDRVGetEnvString PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    push    ds
    push    ds
    pop     es
    mov     edi, offset byte_107EA
    mov     ebx, [ebp+8]
    lds     esi, fword ptr dword_1083A
    mov     esi, [esi+ebx*4]
    cmp     esi, 0FFFFFFFFh
    jnz     loc_10598
    xor     eax, eax
    pop     ds
    jmp     loc_105A6
loc_10598:
    mov     ecx, 50h
    cld
    repne movsb
    pop     ds
    mov     eax, offset byte_107EA
loc_105A6:
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDetDRVSetEnvString
_sosDetDRVSetEnvString PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    les     esi, fword ptr dword_10842
    mov     eax, [ebp+8]
    mov     ebx, eax
    shl     eax, 1
    shl     ebx, 2
    add     ebx, eax
    mov     eax, [ebp+0Ch]
    mov     es:[esi+ebx], eax
    mov     word ptr es:[esi+ebx+4], ds
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP


PUBLIC _sosDRVGetFreeMemory
_sosDRVGetFreeMemory PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     ax, 500h
    int     31h
    push    ds
    pop     es
    mov     edi, offset dword_1084A
    int     31h
    mov     eax, dword_1084A
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDRVIsWindowsActive
_sosDRVIsWindowsActive PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     ax, 1600h
    int     2Fh
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDRVAllocVDSStruct
_sosDRVAllocVDSStruct PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     ax, 100h
    mov     ebx, [ebp+8]
    int     31h
    jnb     loc_10654
    mov     eax, 1
    jmp     loc_10665

loc_10654:
    mov     esi, [ebp+0Ch]
    mov     [esi], dx
    mov     esi, [ebp+10h]
    mov     [esi], ax
    mov     eax, 0

loc_10665:
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDRVFreeVDSStruct
_sosDRVFreeVDSStruct PROC
                mov     ax, ds
                mov     gs, ax
                mov     fs, ax
                mov     es, ax
                push    ebp
                mov     ebp, esp
                push    esi
                push    edi
                push    ebx
                push    ecx
                push    fs
                push    gs
                push    es
                mov     ax, 101h
                mov     dx, [ebp+0Ch]
                int     31h
                mov     ax, 0
                pop     es
                pop     gs
                pop     fs
                pop     ecx
                pop     ebx
                pop     edi
                pop     esi
                pop     ebp
                retn
ENDP

PUBLIC _sosDRVVDSGetBuffer
_sosDRVVDSGetBuffer PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     esi, offset byte_1087A
    mov     dword ptr [esi+1Ch], 8107h
    mov     dword ptr [esi+14h], 0
    mov     ax, [ebp+8]
    mov     [esi+22h], ax
    mov     dword ptr [esi], 0
    mov     ax, 300h
    mov     bl, 4Bh
    mov     bh, 0
    mov     cx, 0
    mov     edi, offset byte_1087A
    push    ds
    pop     es
    int     31h
    mov     esi, offset byte_1087A
    and     word ptr [esi+20h], 1
    jnz     loc_106FA
    mov     eax, 0
    jmp     loc_106FF

loc_106FA:
    mov     eax, 1

loc_106FF:
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP


PUBLIC _sosDRVVDSFreeBuffer
_sosDRVVDSFreeBuffer PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     esi, offset byte_1087A
    mov     dword ptr [esi+1Ch], 8108h
    mov     dword ptr [esi+14h], 0
    mov     ax, [ebp+8]
    mov     [esi+22h], ax
    mov     dword ptr [esi], 0
    mov     ax, 300h
    mov     bl, 4Bh
    mov     bh, 0
    mov     cx, 0
    mov     edi, offset byte_1087A
    push    ds
    pop     es
    int     31h
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDRVMakeDMASelector
_sosDRVMakeDMASelector PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     ax, 800h
    mov     bx, [ebp+0Ah]
    mov     cx, [ebp+8]
    mov     si, 0
    mov     di, 4000h
    int     31h
    mov     ax, bx
    shl     eax, 10h
    mov     ax, cx
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDRVFreeDMASelector
_sosDRVFreeDMASelector PROC
    mov     ax, ds
    mov     gs, ax
    mov     fs, ax
    mov     es, ax
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     ax, 1
    mov     bx, [ebp+0Ch]
    int     31h
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _sosDRVSetupCallFunctions
_sosDRVSetupCallFunctions PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    push    esi
    push    es
    mov     ax, 0Bh
    lfs     edi, fword ptr [ebp+10h]
    call    fword ptr [ebp+8]
    pop     es
    pop     esi
    pop     es
    pop     gs
    pop     fs
    pop     ecx
    pop     ebx
    pop     edi
    pop     esi
    pop     ebp
    retn
ENDP

PUBLIC _getDS
_getDS PROC
    mov     ax, ds
    retn
ENDP
    mov     ax, cs
    retn

PUBLIC _sosModule12End
_sosModule12End PROC
    retn
ENDP

END
