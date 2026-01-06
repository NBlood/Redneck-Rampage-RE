.386p
.MODEL SMALL

.DATA

PUBLIC __wSOSData3Start
__wSOSData3Start dd 0
dword_102A8     dd 0
dword_102AC     dd 0
                dd 0
dword_102B4     dd 0
word_102B8      dw 0
off_102BA       dd offset dword_122CA
dword_102BE     dd 0
dword_102C2     dd 0
dword_102C6     dd 0
                db 2000h dup(0)
dword_122CA     dd 0
dword_122CE     dd 0
word_122D2      dw 0
PUBLIC __bTIMERInstalled
__bTIMERInstalled dd 0
PUBLIC __bTIMERDPMI
__bTIMERDPMI    dd 0
PUBLIC __wSOSData3End
__wSOSData3End dd 0

.CODE

extrn __GETDS:near

PUBLIC _sosModule13Start
_sosModule13Start PROC
    retn
ENDP

PUBLIC _sosTIMERDRVHandler
_sosTIMERDRVHandler PROC
    push    ax
    mov     ax, 20h
    out     20h, al
    pop     ax
    push    ds
    call    __GETDS
    cmp     word_122D2, 1
    jz      loc_10073
    sti
    push    ax
    mov     ax, 20h
    out     20h, al
    pop     ax
    mov     word_122D2, 1
    mov     dword_102C2, esp
    mov     word ptr dword_102C6, ss
    lss     esp, fword ptr off_102BA
    pusha
    push    es
    push    fs
    push    gs
    push    ds
    pop     es
    mov     dword_122CA, esp
    call    dword_102B4
    pop     gs
    pop     fs
    pop     es
    popa
    lss     esp, fword ptr dword_102C2
    mov     word_122D2, 0
loc_10073:
    pop     ds
    iret
ENDP

PUBLIC _sosTIMERDRVSetRate
_sosTIMERDRVSetRate PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    cmp     __bTIMERInstalled, 0
    jz      loc_100B0
    mov     dx, 21h
    in      al, dx
    or      al, 1
    out     dx, al
    mov     dx, 43h
    mov     al, 36h
    out     dx, al
    mov     dx, 40h
    mov     eax, [ebp+8]
    out     dx, al
    mov     al, ah
    out     dx, al
    mov     dx, 21h
    in      al, dx
    and     al, 0FEh
    out     dx, al
loc_100B0:
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

PUBLIC _sosTIMERDRVInit
_sosTIMERDRVInit PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    mov     edi, [ebp+0Ch]
    mov     dword_102B4, edi
    mov     word_102B8, ds
    mov     word ptr dword_102BE, ds
    cmp     __bTIMERInstalled, 0
    jz      loc_1016B
    mov     dx, 21h
    in      al, dx
    or      al, 1
    out     dx, al
    cmp     __bTIMERDPMI, 0
    jz      loc_1012A
    mov     ax, 204h
    mov     bl, 8
    int     31h
    mov     dword_102A8, edx
    mov     word ptr dword_102AC, cx
    mov     ax, 205h
    mov     bl, 8
    mov     edx, offset _sosTIMERDRVHandler
    mov     cx, cs
    int     31h
    jmp     loc_10151
loc_1012A:
    mov     ax, 3508h
    int     21h
    mov     dword_102A8, ebx
    mov     word ptr dword_102AC, es
    push    ds
    xor     ax, ax
    mov     es, ax
    mov     ax, 2508h
    mov     edx, offset _sosTIMERDRVHandler
    push    cs
    pop     ds
    int     21h
    pop     ds
loc_10151:
    mov     dx, 43h
    mov     al, 36h
    out     dx, al
    mov     dx, 40h
    mov     eax, [ebp+8]
    out     dx, al
    mov     al, ah
    out     dx, al
    mov     dx, 21h
    in      al, dx
    and     al, 0FEh
    out     dx, al
loc_1016B:
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

PUBLIC _sosTIMERDRVDisable
_sosTIMERDRVDisable PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    cmp     __bTIMERInstalled, 0
    jz      loc_10197
    mov     dx, 21h
    in      al, dx
    or      al, 1
    out     dx, al
loc_10197:
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

PUBLIC _sosTIMERDRVEnable
_sosTIMERDRVEnable PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    cmp     __bTIMERInstalled, 0
    jz      loc_101C3
    mov     dx, 21h
    in      al, dx
    and     al, 0FEh
    out     dx, al
loc_101C3:
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

PUBLIC _sosTIMERDRVUnInit
_sosTIMERDRVUnInit PROC
    push    ebp
    mov     ebp, esp
    push    esi
    push    edi
    push    ebx
    push    ecx
    push    fs
    push    gs
    push    es
    cmp     __bTIMERInstalled, 0
    jz      loc_1023F
    mov     dx, 21h
    in      al, dx
    or      al, 1
    out     dx, al
    cmp     __bTIMERDPMI, 0
    jz      loc_10216
    mov     ax, 205h
    mov     bl, 8
    mov     cx, word ptr dword_102AC
    mov     edx, dword_102A8
    int     31h
    jmp     loc_1022D
loc_10216:
    push    ds
    mov     ax, 2508h
    mov     cx, word ptr dword_102AC
    mov     edx, dword_102A8
    mov     ds, cx
    int     21h
    pop     ds
loc_1022D:
    mov     dx, 40h
    mov     ax, 0
    out     dx, al
    out     dx, al
    mov     dx, 21h
    in      al, dx
    and     al, 0FEh
    out     dx, al
loc_1023F:
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

PUBLIC _sosTIMERDRVCallOld
_sosTIMERDRVCallOld PROC
    cmp     __bTIMERInstalled, 0
    jz      locret_102A2
    mov     word_122D2, 0
    mov     esp, dword_122CA
    pop     gs
    pop     fs
    pop     es
    popa
    lss     esp, fword ptr dword_102C2
    mov     dword_122CE, eax
    pop     eax
    mov     word ptr dword_122CA, ax
    push    eax
    push    eax
    mov     eax, dword_102A8
    mov     [esp], eax
    mov     eax, dword_102AC
    mov     [esp+4], eax
    mov     eax, dword_122CE
    push    eax
    mov     ax, word ptr dword_122CA
    mov     ds, ax
loc_102A0:
    pop     eax
    retf
locret_102A2:
    retn
ENDP

PUBLIC _sosModule13End
_sosModule13End PROC
    retn
ENDP

END
