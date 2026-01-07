.386p
.MODEL FLAT

.DATA

extrn _pMixingBufferEnd:dword
extrn _wMixingSampleEnd:dword
extrn _wMixingSampleWhole:dword
extrn _wMixingSampleFraction:dword
extrn _wVolumeLeft:dword
extrn _wVolumeRight:dword

.CODE

PUBLIC _sosModule15Start
_sosModule15Start PROC
    retn
ENDP

PUBLIC _hmiMIXERRoutines

_hmiMIXERRoutines:
    dd 256 dup(0)

MIXFUNC MACRO TYPE
MIX&TYPE:
    cmp     esi, _wMixingSampleEnd
    jnb     short MRET&TYPE
IF TYPE AND 8
 IF TYPE AND 64
  IF TYPE AND 2
    mov     bx, [esi]
    mov     ax, [esi+2]
  ELSE
    mov     bh, [esi]
    mov     ah, [esi+1]
  ENDIF
 ELSE
  IF TYPE AND 2
    mov     ax, [esi]
    mov     bx, [esi+2]
  ELSE
    mov     ah, [esi]
    mov     bh, [esi+1]
  ENDIF
 ENDIF
 IF TYPE AND 1
    xor     eax, 8000h
    xor     ebx, 8000h
 ENDIF
 IF TYPE AND 4
  IF TYPE AND 32
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    movzx   eax, bx
    imul    word ptr _wVolumeRight
    add     edx, edx
    movsx   edx, dx
    add     [edi+4], edx
  ELSE
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
  ENDIF
    add     edi, 8
 ELSE
  IF TYPE AND 32
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
  ELSE
    movsx   eax, ax
    add     [edi], eax
  ENDIF
    add     edi, 4
 ENDIF
 IF TYPE AND 16
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
 ELSE
  IF TYPE AND 2
    add     esi, 4
  ELSE
    add     esi, 2
  ENDIF
 ENDIF
ELSE
 IF TYPE AND 2
    mov     ax, [esi]
 ELSE
    mov     ah, [esi]
 ENDIF
 IF TYPE AND 1
    xor     eax, 8000h
 ENDIF
 IF TYPE AND 4
  IF TYPE AND 32
    mov     ebx, eax
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    movzx   eax, bx
    imul    word ptr _wVolumeRight
    add     edx, edx
    movsx   edx, dx
    add     [edi+4], edx
  ELSE
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
  ENDIF
    add     edi, 8
 ELSE
  IF TYPE AND 32
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
  ELSE
    movsx   eax, ax
    add     [edi], eax
  ENDIF
    add     edi, 4
 ENDIF
 IF TYPE AND 16
  IF TYPE AND 2
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
  ELSE
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
  ENDIF
 ELSE
  IF TYPE AND 2
    add     esi, 2
  ELSE
    add     esi, 1
  ENDIF
 ENDIF
ENDIF
    cmp     edi, _pMixingBufferEnd
    jbe     short MIX&TYPE
MRET&TYPE:
    retn

BACK&TYPE:
org _hmiMIXERRoutines+&TYPE*4
    dd MIX&TYPE
org BACK&TYPE
ENDM

PUBLIC _hmiMIXERCode
_hmiMIXERCode:

MIXID = 0
REPT 128
    MIXFUNC %MIXID
    MIXID = MIXID + 1
ENDM

PUBLIC _sosModule15End
_sosModule15End PROC
    retn
ENDP

END
