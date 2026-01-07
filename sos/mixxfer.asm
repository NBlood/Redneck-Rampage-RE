.386p
.MODEL FLAT

.CODE

PUBLIC _sosModule16Start
_sosModule16Start PROC
    retn
ENDP

PUBLIC _hmiXFERRoutines

_hmiXFERRoutines:
    dd offset L1
    dd offset L2
    dd offset L3
    dd offset L4
    dd offset L5
    dd offset L6
    dd offset L7
    dd offset L8
    dd offset L9
    dd offset L10
    dd offset L11
    dd offset L12
    dd offset L14
    dd offset L15
    dd offset L16
    dd offset L17
    dd offset L18
    dd offset L22
    dd offset L26
    dd offset L30
    dd offset L34
    dd offset L41
    dd offset L48
    dd offset L55
    dd offset L62
    dd offset L66
    dd offset L70
    dd offset L74
    dd offset L78
    dd offset L85
    dd offset L92
    dd offset L99
    dd 0E0h dup(0)

PUBLIC _hmiXFERCode
_hmiXFERCode:

L1:
    mov     eax, [esi]
    add     esi, 4
    mov     [edi], ah
    add     edi, 1
    dec     ecx
    jnz     short _hmiXFERCode
    retn
L2:
    mov     eax, [esi]
    add     esi, 4
    mov     [edi], ax
    add     edi, 2
    dec     ecx
    jnz     short L2
    retn
L3:
    mov     eax, [esi]
    add     esi, 4
    xor     eax, 8000h
    mov     [edi], ah
    add     edi, 1
    dec     ecx
    jnz     short L3
    retn
L4:
    mov     eax, [esi]
    add     esi, 4
    xor     eax, 8000h
    mov     [edi], ax
    add     edi, 2
    dec     ecx
    jnz     short L4
    retn
L5:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    mov     bl, ah
    mov     [edi], bx
    add     edi, 2
    dec     ecx
    jnz     short L5
    retn
L6:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    mov     [edi], ax
    mov     [edi+2], bx
    add     edi, 4
    dec     ecx
    jnz     short L6
    retn
L7:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    xor     eax, 8000h
    xor     ebx, 8000h
    mov     bl, ah
    mov     [edi], bx
    add     edi, 2
    dec     ecx
    jnz     short L7
    retn
L8:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    xor     eax, 8000h
    xor     ebx, 8000h
    mov     [edi], ax
    mov     [edi+2], bx
    add     edi, 4
    dec     ecx
    jnz     short L8
    retn
L9:
    mov     eax, [esi]
    add     esi, 4
    mov     [edi], ah
    add     edi, 1
    dec     ecx
    jnz     short L9
    retn
L10:
    mov     eax, [esi]
    add     esi, 4
    mov     [edi], ax
    add     edi, 2
    dec     ecx
    jnz     short L10
    retn
L11:
    mov     eax, [esi]
    add     esi, 4
    xor     eax, 8000h
    mov     [edi], ah
    add     edi, 1
    dec     ecx
    jnz     short L11
    retn
L12:
    mov     eax, [esi]
    add     esi, 4
    xor     eax, 8000h
    mov     [edi], ax
    add     edi, 2
    dec     ecx
    jnz     short L12
    retn
L14:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    mov     al, bh
    mov     [edi], ax
    add     edi, 2
    dec     ecx
    jnz     short L14
    retn
L15:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    mov     [edi], bx
    mov     [edi+2], ax
    add     edi, 4
    dec     ecx
    jnz     short L15
    retn
L16:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    xor     eax, 8000h
    xor     ebx, 8000h
    mov     al, bh
    mov     [edi], ax
    add     edi, 2
    dec     ecx
    jnz     short L16
    retn
L17:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    xor     eax, 8000h
    xor     ebx, 8000h
    mov     [edi], bx
    mov     [edi+2], ax
    add     edi, 4
    dec     ecx
    jnz     short L17
    retn
L18:
    mov     eax, [esi]
    add     esi, 4
    cmp     eax, 7FFFh
    jg      short L20
    cmp     eax, 0FFFF8000h
    jl      short L21
L19:
    mov     [edi], ah
    add     edi, 1
    dec     ecx
    jnz     short L18
    retn
L20:
    mov     eax, 7FFFh
    jmp     short L19
L21:
    mov     eax, 0FFFF8000h
    jmp     short L19
L22:
    mov     eax, [esi]
    add     esi, 4
    cmp     eax, 7FFFh
    jg      short L24
    cmp     eax, 0FFFF8000h
    jl      short L25
L23:
    mov     [edi], ax
    add     edi, 2
    dec     ecx
    jnz     short L22
    retn
L24:
    mov     eax, 7FFFh
    jmp     short L23
L25:
    mov     eax, 0FFFF8000h
    jmp     short L23
L26:
    mov     eax, [esi]
    add     esi, 4
    cmp     eax, 7FFFh
    jg      short L28
    cmp     eax, 0FFFF8000h
    jl      short L29
L27:
    xor     eax, 8000h
    mov     [edi], ah
    add     edi, 1
    dec     ecx
    jnz     short L26
    retn
L28:
    mov     eax, 7FFFh
    jmp     short L27
L29:
    mov     eax, 0FFFF8000h
    jmp     short L27
L30:
    mov     eax, [esi]
    add     esi, 4
    cmp     eax, 7FFFh
    jg      short L32
    cmp     eax, 0FFFF8000h
    jl      short L33
L31:
    xor     eax, 8000h
    mov     [edi], ax
    add     edi, 2
    dec     ecx
    jnz     short L30
    retn
L32:
    mov     eax, 7FFFh
    jmp     short L31
L33:
    mov     eax, 0FFFF8000h
    jmp     short L31
L34:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    cmp     eax, 7FFFh
    jg      short L37
    cmp     eax, 0FFFF8000h
    jl      short L38
L35:
    cmp     ebx, 7FFFh
    jg      short L39
    cmp     ebx, 0FFFF8000h
    jl      short L40
L36:
    mov     bl, ah
    mov     [edi], bx
    add     edi, 2
    dec     ecx
    jnz     short L34
    retn
L37:
    mov     eax, 7FFFh
    jmp     short L35
L38:
    mov     eax, 0FFFF8000h
    jmp     short L35
L39:
    mov     ebx, 7FFFh
    jmp     short L36
L40:
    mov     ebx, 0FFFF8000h
    jmp     short L36
L41:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    cmp     eax, 7FFFh
    jg      short L44
    cmp     eax, 0FFFF8000h
    jl      short L45
L42:
    cmp     ebx, 7FFFh
    jg      short L46
    cmp     ebx, 0FFFF8000h
    jl      short L47
L43:
    mov     [edi], ax
    mov     [edi+2], bx
    add     edi, 4
    dec     ecx
    jnz     short L41
    retn
L44:
    mov     eax, 7FFFh
    jmp     short L42
L45:
    mov     eax, 0FFFF8000h
    jmp     short L42
L46:
    mov     ebx, 7FFFh
    jmp     short L43
L47:
    mov     ebx, 0FFFF8000h
    jmp     short L43
L48:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    cmp     eax, 7FFFh
    jg      short L51
    cmp     eax, 0FFFF8000h
    jl      short L52
L49:
    cmp     ebx, 7FFFh
    jg      short L53
    cmp     ebx, 0FFFF8000h
    jl      short L54
L50:
    xor     eax, 8000h
    xor     ebx, 8000h
    mov     bl, ah
    mov     [edi], bx
    add     edi, 2
    dec     ecx
    jnz     short L48
    retn
L51:
    mov     eax, 7FFFh
    jmp     short L49
L52:
    mov     eax, 0FFFF8000h
    jmp     short L49
L53:
    mov     ebx, 7FFFh
    jmp     short L50
L54:
    mov     ebx, 0FFFF8000h
    jmp     short L50
L55:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    cmp     eax, 7FFFh
    jg      short L58
    cmp     eax, 0FFFF8000h
    jl      short L59
L56:
    cmp     ebx, 7FFFh
    jg      short L60
    cmp     ebx, 0FFFF8000h
    jl      short L61
L57:
    xor     eax, 8000h
    xor     ebx, 8000h
    mov     [edi], ax
    mov     [edi+2], bx
    add     edi, 4
    dec     ecx
    jnz     short L55
    retn
L58:
    mov     eax, 7FFFh
    jmp     short L56
L59:
    mov     eax, 0FFFF8000h
    jmp     short L56
L60:
    mov     ebx, 7FFFh
    jmp     short L57
L61:
    mov     ebx, 0FFFF8000h
    jmp     short L57
L62:
    mov     eax, [esi]
    add     esi, 4
    cmp     eax, 7FFFh
    jg      short L64
    cmp     eax, 0FFFF8000h
    jl      short L65
L63:
    mov     [edi], ah
    add     edi, 1
    dec     ecx
    jnz     short L62
    retn
L64:
    mov     eax, 7FFFh
    jmp     short L63
L65:
    mov     eax, 0FFFF8000h
    jmp     short L63
L66:
    mov     eax, [esi]
    add     esi, 4
    cmp     eax, 7FFFh
    jg      short L68
    cmp     eax, 0FFFF8000h
    jl      short L69
L67:
    mov     [edi], ax
    add     edi, 2
    dec     ecx
    jnz     short L66
    retn
L68:
    mov     eax, 7FFFh
    jmp     short L67
L69:
    mov     eax, 0FFFF8000h
    jmp     short L67
L70:
    mov     eax, [esi]
    add     esi, 4
    cmp     eax, 7FFFh
    jg      short L72
    cmp     eax, 0FFFF8000h
    jl      short L73
L71:
    xor     eax, 8000h
    mov     [edi], ah
    add     edi, 1
    dec     ecx
    jnz     short L70
    retn
L72:
    mov     eax, 7FFFh
    jmp     short L71
L73:
    mov     eax, 0FFFF8000h
    jmp     short L71
L74:
    mov     eax, [esi]
    add     esi, 4
    cmp     eax, 7FFFh
    jg      short L76
    cmp     eax, 0FFFF8000h
    jl      short L77
L75:
    xor     eax, 8000h
    mov     [edi], ax
    add     edi, 2
    dec     ecx
    jnz     short L74
    retn
L76:
    mov     eax, 7FFFh
    jmp     short L75
L77:
    mov     eax, 0FFFF8000h
    jmp     short L75
L78:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    cmp     eax, 7FFFh
    jg      short L81
    cmp     eax, 0FFFF8000h
    jl      short L82
L79:
    cmp     ebx, 7FFFh
    jg      short L83
    cmp     ebx, 0FFFF8000h
    jl      short L84
L80:
    mov     al, bh
    mov     [edi], ax
    add     edi, 2
    dec     ecx
    jnz     short L78
    retn
L81:
    mov     eax, 7FFFh
    jmp     short L79
L82:
    mov     eax, 0FFFF8000h
    jmp     short L79
L83:
    mov     ebx, 7FFFh
    jmp     short L80
L84:
    mov     ebx, 0FFFF8000h
    jmp     short L80
L85:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    cmp     eax, 7FFFh
    jg      short L88
    cmp     eax, 0FFFF8000h
    jl      short L89
L86:
    cmp     ebx, 7FFFh
    jg      short L90
    cmp     ebx, 0FFFF8000h
    jl      short L91
L87:
    mov     [edi], bx
    mov     [edi+2], ax
    add     edi, 4
    dec     ecx
    jnz     short L85
    retn
L88:
    mov     eax, 7FFFh
    jmp     short L86
L89:
    mov     eax, 0FFFF8000h
    jmp     short L86
L90:
    mov     ebx, 7FFFh
    jmp     short L87
L91:
    mov     ebx, 0FFFF8000h
    jmp     short L87
L92:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    cmp     eax, 7FFFh
    jg      short L95
    cmp     eax, 0FFFF8000h
    jl      short L96
L93:
    cmp     ebx, 7FFFh
    jg      short L97
    cmp     ebx, 0FFFF8000h
    jl      short L98
L94:
    xor     eax, 8000h
    xor     ebx, 8000h
    mov     al, bh
    mov     [edi], ax
    add     edi, 2
    dec     ecx
    jnz     short L92
    retn
L95:
    mov     eax, 7FFFh
    jmp     short L93
L96:
    mov     eax, 0FFFF8000h
    jmp     short L93
L97:
    mov     ebx, 7FFFh
    jmp     short L94
L98:
    mov     ebx, 0FFFF8000h
    jmp     short L94
L99:
    mov     eax, [esi]
    mov     ebx, [esi+4]
    add     esi, 8
    cmp     eax, 7FFFh
    jg      short L102
    cmp     eax, 0FFFF8000h
    jl      short L103
L100:
    cmp     ebx, 7FFFh
    jg      short L104
    cmp     ebx, 0FFFF8000h
    jl      short L105
L101:
    xor     eax, 8000h
    xor     ebx, 8000h
    mov     [edi], bx
    mov     [edi+2], ax
    add     edi, 4
    dec     ecx
    jnz     short L99
    retn
L102:
    mov     eax, 7FFFh
    jmp     short L100
L103:
    mov     eax, 0FFFF8000h
    jmp     short L100
L104:
    mov     ebx, 7FFFh
    jmp     short L101
L105:
    mov     ebx, 0FFFF8000h
    jmp     short L101


PUBLIC _sosModule16End
_sosModule16End PROC
    retn
ENDP


END
