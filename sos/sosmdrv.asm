.386p
.MODEL FLAT
.CODE

PUBLIC _sosMIDICode23Start
_sosMIDICode23Start PROC
    retn
ENDP

PUBLIC _sosMIDIDRVGetCapsInfo
_sosMIDIDRVGetCapsInfo PROC
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
    lfs     edi, [ebp+10h]
    call    fword ptr [ebp+8]
    push    ds
    les     edi, [ebp+18h]
    lds     esi, [ebp+10h]
    mov     esi, edx
    mov     ecx, 40h
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

PUBLIC _sosMIDIDRVGetFuncsPtr
_sosMIDIDRVGetFuncsPtr PROC
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
    lfs     edi, [ebp+10h]
    call    fword ptr [ebp+8]
    mov     esi, edi
    les     edi, [ebp+18h]
    mov     ecx, 1Bh
L1:
    mov     eax, fs:[esi]
    mov     es:[edi], eax
    add     edi, 4
    mov     ax, [ebp+0Ch]
    mov     es:[edi], ax
    add     edi, 2
    add     esi, 8
    loop    L1
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


PUBLIC _sosMIDIDRVSpecialFunction
_sosMIDIDRVSpecialFunction PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     eax, [ebp+18h]
    lfs     edi, [ebp+10h]
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

PUBLIC _xint3
_xint3 PROC
    int     3
    retn
ENDP


PUBLIC _xgetES
_xgetES PROC
    push    ds
	pop     es
	mov     ax, ds
    retn
ENDP


PUBLIC _sosMIDICode23End
_sosMIDICode23End PROC
    retn
ENDP


END
