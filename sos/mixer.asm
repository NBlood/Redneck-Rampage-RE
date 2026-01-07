.386p
.MODEL FLAT

.DATA

extrn _hmiMIXERRoutines:far
extrn _hmiXFERRoutines:far

PUBLIC __wSOSData4Start
PUBLIC _pMixingBufferEnd
PUBLIC _wMixingSampleEnd
PUBLIC _wMixingSampleFraction
PUBLIC _wMixingSampleWhole
PUBLIC _wVolumeLeft
PUBLIC _wVolumeRight
PUBLIC _wVolumeMaster
PUBLIC __wSOSData4End

__wSOSData4Start dd 0
dword_1276F0    dd 0
_pMixingBufferEnd dd 0
dword_1276F8    dd 0
dword_1276FC    dd 0
dword_127700    dd 0
_wMixingSampleEnd dd 0
_wMixingSampleFraction dd 0
_wMixingSampleWhole dd 2 dup(0)
dword_127714    dd 0
dword_127718    dd 0
dword_12771C    dd 0
_wVolumeLeft    dd 1FFFh
_wVolumeRight   dd 1FFFh
dword_127728    dd 7FFFh
_wVolumeMaster  dd 7FFFh
dword_127730    dd 0
dword_127734    dd 0
__wSOSData4End  dd 0

.CODE

PUBLIC _sosModule14Start
_sosModule14Start PROC
    retn
ENDP


PUBLIC _hmiDigitalMixer
_hmiDigitalMixer PROC
    push    ebp
    mov     ebp, esp
    push    ebx
    push    ecx
    push    edx
    push    esi
    push    edi
    push    ebp
    mov     eax, [ebp+8]
    mov     ebp, eax
    cmp     dword ptr [ebp+34h], 0
    jz      short L1
    push    es
    xor     edx, edx
    mov     edi, [ebp+3Ch]
    push    ds
    pop     es
    xor     eax, eax
    push    fs
    push    eax
    call    fword ptr [ebp+34h]
    add     esp, 8
    pop     es
    movzx   ebx, ax
    cmp     ebx, [ebp+20h]
    jnz     short L4
    nop
    nop
    nop
    nop
    jmp     L47
L1:
    xor     eax, eax
    mov     edx, 0Ch
    out     dx, al
    jmp     short $+2
    mov     edx, [ebp+18h]
    in      al, dx
    jmp     short $+2
    xchg    al, ah
    in      al, dx
    jmp     short $+2
    xchg    al, ah
    inc     eax
    cmp     edx, 7
    jbe     short L2
    add     eax, eax
L2:
    cmp     eax, [ebp+44h]
    jbe     short L3
    xor     eax, eax
    mov     edx, 0Ch
    out     dx, al
    jmp     short $+2
    mov     eax, [ebp+44h]
    dec     eax
    mov     edx, [ebp+18h]
    out     dx, al
    jmp     short $+2
    xchg    al, ah
    out     dx, al
    jmp     short $+2
    xchg    al, ah
L3:
    mov     ebx, [ebp+44h]
    sub     ebx, eax
    and     ebx, 0FFFCh
L4:
    or      ebx, ebx
    jnz     short L5
    add     ebx, 20h
L5:
    cmp     ebx, [ebp+20h]
    jz      L47
    mov     [ebp+1Ch], ebx
    mov     eax, [ebp+1Ch]
    sub     eax, [ebp+20h]
    jnb     short L6
    mov     eax, [ebp+44h]
    sub     eax, [ebp+20h]
    add     eax, [ebp+1Ch]

L6:
    mov     [ebp+24h], eax
    cmp     dword ptr [ebp+0Ch], 10h
    jz      short L7
    shl     eax, 1
L7:
    shl     eax, 1
    mov     dword_1276F8, eax
    add     eax, [ebp+48h]
    dec     eax
    mov     [ebp+4Ch], eax
    mov     _pMixingBufferEnd, eax
    mov     edi, [ebp+48h]
    mov     ecx, dword_1276F8
    add     ecx, 20h
    xor     eax, eax
    cld
    push    ecx
    shr     ecx, 2
    rep stosd
    pop     ecx
    and     ecx, 3
    rep stosb
    mov     eax, [ebp+1Ch]
    mov     [ebp+20h], eax
    mov     dword ptr [ebp+54h], 0
    mov     dword_127700, 0
    mov     esi, [ebp+30h]
    or      esi, esi
    jz      L32
L8:
    mov     dword_1276F0, esi
    test    dword ptr [esi+20h], 4000h
    jnz     L26
    inc     dword ptr [ebp+54h]
    mov     edi, [ebp+48h]
L9:
    mov     dword_127714, 0
    test    dword ptr [esi+40h], 8000h
    jz      short L10
    nop
    nop
    nop
    nop
    or      dword_127714, 1
L10:
    test    dword ptr [esi+40h], 4000h
    jz      short L11
    nop
    nop
    nop
    nop
    or      dword_127714, 40h
L11:
    cmp     dword ptr [esi+44h], 8000h
    jnz     short L12
    mov     eax, [esi+2Ch]
    and     eax, 7FFFh
    mov     _wVolumeLeft, eax
    mov     eax, [esi+2Ch]
    shr     eax, 10h
    and     eax, 7FFFh
    mov     _wVolumeRight, eax
    jmp     short L15
L12:
    mov     ebx, 7FFFh
    mov     ecx, 7FFFh
    test    dword ptr [esi+44h], 8000h
    jnz     short L13
    mov     ecx, [esi+44h]
    jmp     short L14
L13:
    mov     ebx, 0FFFFh
    sub     ebx, [esi+44h]
L14:
    xor     edx, edx
    mov     eax, [esi+2Ch]
    imul    bx
    add     edx, edx
    mov     _wVolumeLeft, edx
    xor     edx, edx
    mov     eax, [esi+2Ch]
    imul    cx
    add     edx, edx
    mov     _wVolumeRight, edx
L15:
    cmp     _wVolumeLeft, 7FF0h
    jb      short L16
    cmp     _wVolumeRight, 7FF0h
    jnb     short L17
L16:
    or      dword_127714, 20h
L17:
    cmp     dword_127728, 7FF0h
    jnb     short L18
    nop
    nop
    nop
    nop
    or      dword_127714, 20h
    xor     edx, edx
    mov     eax, _wVolumeLeft
    imul    word ptr dword_127728
    add     edx, edx
    mov     _wVolumeLeft, edx
    xor     edx, edx
    mov     eax, _wVolumeRight
    imul    word ptr dword_127728
    add     edx, edx
    mov     _wVolumeRight, edx
L18:
    cmp     dword ptr [esi+38h], 8
    jz      short L19
    or      dword_127714, 2
L19:
    cmp     dword ptr [esi+3Ch], 1
    jz      short L20
    or      dword_127714, 8
L20:
    cmp     dword ptr [ebp+8], 1
    jz      short L21
    or      dword_127714, 4
L21:
    xor     eax, eax
    mov     edx, [esi+34h]
    cmp     edx, [ebp+4]
    jz      short L24
    mov     ecx, [ebp+4]
    shl     ecx, 10h
    div     ecx
    mov     ebx, eax
    shr     ebx, 10h
    shl     eax, 10h
    mov     _wMixingSampleFraction, eax
    mov     eax, ebx
    inc     ebx
    test    dword_127714, 8
    jz      short L22
    shl     eax, 1
    shl     ebx, 1
L22:
    test    dword_127714, 2
    jz      short L23
    nop
    nop
    nop
    nop
    shl     eax, 1
    shl     ebx, 1
L23:
    mov     word ptr _wMixingSampleWhole, ax
    mov     word ptr (_wMixingSampleWhole+4), bx
    or      dword_127714, 10h
L24:
    mov     eax, dword_127714
    shl     eax, 2
    add     eax, offset _hmiMIXERRoutines
    mov     eax, [eax]
    mov     dword_127734, eax
    mov     eax, [esi]
    add     eax, [esi+0Ch]
    mov     _wMixingSampleEnd, eax
    mov     esi, [esi+4]
    mov     ecx, 80000000h
    push    ebp
    xor     eax, eax
    xor     ebx, ebx
    call    dword_127734
    pop     ebp
    mov     dword_1276FC, edi
    mov     edi, esi
    mov     esi, dword_1276F0
    mov     eax, edi
    sub     eax, [esi+4]
    add     [esi+4], eax
    add     [esi+58h], eax
    mov     eax, [esi+4]
    cmp     eax, _wMixingSampleEnd
    jb      L30
    cmp     dword ptr [esi+30h], 0FFFFFFFFh
    jz      L29
    cmp     dword ptr [esi+30h], 0
    jz      short L25
    nop
    nop
    nop
    nop
    dec     dword ptr [esi+30h]
    jmp     L29
L25:
    or      dword ptr [esi+20h], 4000h
    cmp     dword ptr [esi+5Ch], 0
    jz      L30
    mov     dword ptr [esi], 0
    push    ebx
    push    ecx
    push    edx
    push    esi
    push    edi
    push    ebp
    push    esi
    call    dword ptr [esi+5Ch]
    add     esp, 4
    pop     ebp
    pop     edi
    pop     esi
    pop     edx
    pop     ecx
    pop     ebx
    cmp     dword ptr [esi], 0
    jz      L30
    and     dword ptr [esi+20h], 0FFFFBFFFh
    jmp     short L29
    nop
    nop
    nop
L26:
    mov     dword ptr [esi+20h], 0
    cmp     dword ptr [esi+60h], 0
    jz      short L27
    nop
    nop
    nop
    nop
    push    ebx
    push    ecx
    push    edx
    push    esi
    push    edi
    push    ebp
    push    esi
    call    dword ptr [esi+60h]
    add     esp, 4
    pop     ebp
    pop     edi
    pop     esi
    pop     edx
    pop     ecx
    pop     ebx

L27:
    and     dword ptr [esi+20h], 0FFFF7FFFh
    or      dword ptr [esi+20h], 2000h
    cmp     dword_127700, 0
    jnz     short L28
    mov     eax, [esi+0ECh]
    mov     [ebp+30h], eax
    jmp     short L31
    nop
    nop
    nop
L28:
    mov     eax, [esi+0ECh]
    mov     edi, dword_127700
    mov     [edi+0ECh], eax
    jmp     short L31
    nop
    nop
    nop
L29:
    mov     eax, [esi]
    mov     [esi+4], eax
    mov     edi, dword_1276FC
    cmp     edi, [ebp+4Ch]
    jb      L9
L30:
    mov     eax, [ebp+54h]
    cmp     eax, [ebp+14h]
    jnb     short L32
    nop
    nop
    nop
    nop
    mov     dword_127700, esi
L31:
    mov     esi, [esi+0ECh]
    or      esi, esi
    jnz     L8

L32:
    xor     eax, eax
    test    dword ptr [ebp+10h], 8000h
    jz      short L33
    nop
    nop
    nop
    nop
    or      eax, 2
L33:
    test    dword ptr [ebp+10h], 4000h
    jz      short L34
    nop
    nop
    nop
    nop
    or      eax, 8
L34:
    cmp     dword ptr [ebp+0Ch], 8
    jz      short L35
    and     eax, 0FFFFFFFDh
    or      eax, 1
L35:
    cmp     dword ptr [ebp+8], 1
    jz      short L36
    or      eax, 4
L36:
    cmp     dword ptr [ebp+54h], 1
    jbe     short L37
    or      eax, 10h
L37:
    mov     dword_12771C, eax
    shl     eax, 2
    add     eax, offset _hmiXFERRoutines
    mov     eax, [eax]
    mov     dword_127734, eax
    mov     edi, [ebp+28h]
    mov     esi, [ebp+48h]
    mov     ecx, dword_1276F8
    shr     ecx, 2
    mov     edx, ecx
    cmp     dword ptr [ebp+8], 1
    jz      short L38
    shr     ecx, 1
L38:
    cmp     dword ptr [ebp+0Ch], 10h
    jnz     short L39
    shl     edx, 1
L39:
    mov     eax, edi
    add     eax, edx
    cmp     eax, [ebp+40h]
    jb      short L44
    nop
    nop
    nop
    nop
    mov     eax, edx
    mov     ecx, [ebp+40h]
    sub     ecx, [ebp+28h]
    sub     eax, ecx
    push    eax
    cmp     dword ptr [ebp+0Ch], 8
    jz      short L40
    shr     ecx, 1
L40:
    cmp     dword ptr [ebp+8], 1
    jz      short L41
    shr     ecx, 1
L41:
    call    dword_127734
    pop     ecx
    mov     edi, [ebp+3Ch]
    or      ecx, ecx
    jz      short L45
    cmp     dword ptr [ebp+0Ch], 8
    jz      short L42
    shr     ecx, 1
L42:
    cmp     dword ptr [ebp+8], 1
    jz      short L43
    shr     ecx, 1
L43:
    call    dword_127734
    jmp     short L45
L44:
    call    dword_127734

L45:
    mov     [ebp+28h], edi
    cmp     dword ptr [ebp+54h], 0
    jnz     short L47
    mov     eax, [ebp+3Ch]
    add     eax, [ebp+1Ch]
    add     eax, [ebp+2Ch]
    cmp     eax, [ebp+40h]
    jb      short L46
    nop
    nop
    nop
    nop
    sub     eax, [ebp+44h]
L46:
    mov     [ebp+28h], eax
L47:
    pop     ebp
    pop     edi
    pop     esi
    pop     edx
    pop     ecx
    pop     ebx
    pop     ebp
    retn
ENDP


PUBLIC _sosModule14End
_sosModule14End PROC
    retn
ENDP

END
