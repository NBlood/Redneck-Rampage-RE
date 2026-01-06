.386p
.MODEL SMALL

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
    dd offset L1
    dd offset loc_E2FC3
    dd offset loc_E2FE6
    dd offset loc_E3005
    dd offset loc_E3029
    dd offset loc_E304A
    dd offset loc_E3070
    dd offset loc_E3092
    dd offset loc_E30B9
    dd offset loc_E30DA
    dd offset loc_E3106
    dd offset loc_E3129
    dd offset loc_E3157
    dd offset loc_E317E
    dd offset loc_E31B0
    dd offset loc_E31D9
    dd offset loc_E320D
    dd offset loc_E3234
    dd offset loc_E3260
    dd offset loc_E328D
    dd offset loc_E32BF
    dd offset loc_E32E9
    dd offset loc_E3318
    dd offset loc_E3348
    dd offset loc_E337D
    dd offset loc_E33AC
    dd offset loc_E33E6
    dd offset loc_E3417
    dd offset loc_E3453
    dd offset loc_E3488
    dd offset loc_E34C8
    dd offset loc_E34FF
    dd offset loc_E3541
    dd offset loc_E356B
    dd offset loc_E359A
    dd offset loc_E35C5
    dd offset loc_E35F5
    dd offset loc_E3633
    dd offset loc_E3676
    dd offset loc_E36B5
    dd offset loc_E36F9
    dd offset loc_E3726
    dd offset loc_E375E
    dd offset loc_E378D
    dd offset loc_E37C7
    dd offset loc_E3806
    dd offset loc_E3850
    dd offset loc_E3891
    dd offset loc_E38DD
    dd offset loc_E3910
    dd offset loc_E3948
    dd offset loc_E3981
    dd offset loc_E39BF
    dd offset loc_E3A06
    dd offset loc_E3A52
    dd offset loc_E3A9F
    dd offset loc_E3AF1
    dd offset loc_E3B2C
    dd offset loc_E3B72
    dd offset loc_E3BAF
    dd offset loc_E3BF7
    dd offset loc_E3C44
    dd offset loc_E3C9C
    dd offset loc_E3CEB
    dd offset loc_E3D45
    dd offset loc_E3D63
    dd offset loc_E3D86
    dd offset loc_E3DA5
    dd offset loc_E3DC9
    dd offset loc_E3DEA
    dd offset loc_E3E10
    dd offset loc_E3E32
    dd offset loc_E3E59
    dd offset loc_E3E7A
    dd offset loc_E3EA6
    dd offset loc_E3EC9
    dd offset loc_E3EF7
    dd offset loc_E3F1E
    dd offset loc_E3F50
    dd offset loc_E3F79
    dd offset loc_E3FAD
    dd offset loc_E3FD4
    dd offset loc_E4000
    dd offset loc_E402D
    dd offset loc_E405F
    dd offset loc_E4089
    dd offset loc_E40B8
    dd offset loc_E40E8
    dd offset loc_E411D
    dd offset loc_E414C
    dd offset loc_E4186
    dd offset loc_E41B7
    dd offset loc_E41F3
    dd offset loc_E4228
    dd offset loc_E4268
    dd offset loc_E429F
    dd offset loc_E42E1
    dd offset loc_E430B
    dd offset loc_E433A
    dd offset loc_E4365
    dd offset loc_E4395
    dd offset loc_E43D3
    dd offset loc_E4416
    dd offset loc_E4455
    dd offset loc_E4499
    dd offset loc_E44C6
    dd offset loc_E44FE
    dd offset loc_E452D
    dd offset loc_E4567
    dd offset loc_E45A6
    dd offset loc_E45F0
    dd offset loc_E4631
    dd offset loc_E467D
    dd offset loc_E46B0
    dd offset loc_E46E8
    dd offset loc_E4721
    dd offset loc_E475F
    dd offset loc_E47A6
    dd offset loc_E47F2
    dd offset loc_E483F
    dd offset loc_E4891
    dd offset loc_E48CC
    dd offset loc_E4912
    dd offset loc_E494F
    dd offset loc_E4997
    dd offset loc_E49E4
    dd offset loc_E4A3C
    dd offset loc_E4A8B
    dd 80h dup(0)

PUBLIC _hmiMIXERCode
_hmiMIXERCode:

L1:
    cmp     esi, _wMixingSampleEnd
    jnb     short L2
    mov     ah, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short L1
L2:
    retn

loc_E2FC3:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E2FE5
    mov     ah, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E2FC3
locret_E2FE5:
    retn

loc_E2FE6:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3004
    mov     ax, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E2FE6

locret_E3004:
    retn

loc_E3005:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3028
    mov     ax, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3005

locret_E3028:
    retn

loc_E3029:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3049
    mov     ah, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3029

locret_E3049:
    retn

loc_E304A:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E306F
    mov     ah, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E304A
locret_E306F:
    retn

loc_E3070:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3091
    mov     ax, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3070
locret_E3091:
    retn

loc_E3092:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E30B8
    mov     ax, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3092

locret_E30B8:
    retn

loc_E30B9:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E30D9
    mov     ah, [esi]
    mov     bh, [esi+1]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E30B9

locret_E30D9:
    retn

loc_E30DA:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3105
    mov     ah, [esi]
    mov     bh, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E30DA
locret_E3105:
    retn

loc_E3106:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3128
    mov     ax, [esi]
    mov     bx, [esi+2]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3106

locret_E3128:
    retn

loc_E3129:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3156
    mov     ax, [esi]
    mov     bx, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3129
locret_E3156:
    retn

loc_E3157:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E317D
    mov     ah, [esi]
    mov     bh, [esi+1]
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3157

locret_E317D:
    retn

loc_E317E:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E31AF
    mov     ah, [esi]
    mov     bh, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E317E
locret_E31AF:
    retn

loc_E31B0:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E31D8
    mov     ax, [esi]
    mov     bx, [esi+2]
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E31B0

locret_E31D8:
    retn

loc_E31D9:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E320C
    mov     ax, [esi]
    mov     bx, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E31D9
locret_E320C:
    retn

loc_E320D:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3233
    mov     ah, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E320D

locret_E3233:
    retn

loc_E3234:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E325F
    mov     ah, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3234

locret_E325F:
    retn

loc_E3260:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E328C
    mov     ax, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3260

locret_E328C:
    retn

loc_E328D:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E32BE
    mov     ax, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E328D

locret_E32BE:
    retn

loc_E32BF:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E32E8
    mov     ah, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E32BF

locret_E32E8:
    retn

loc_E32E9:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3317
    mov     ah, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E32E9

locret_E3317:
    retn

loc_E3318:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3347
    mov     ax, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3318
locret_E3347:
    retn

loc_E3348:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E337C
    mov     ax, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3348

locret_E337C:
    retn

loc_E337D:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E33AB
    mov     ah, [esi]
    mov     bh, [esi+1]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E337D

locret_E33AB:
    retn

loc_E33AC:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E33E5
    mov     ah, [esi]
    mov     bh, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E33AC

locret_E33E5:
    retn

loc_E33E6:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3416
    mov     ax, [esi]
    mov     bx, [esi+2]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E33E6

locret_E3416:
    retn

loc_E3417:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3452
    mov     ax, [esi]
    mov     bx, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3417
locret_E3452:
    retn

loc_E3453:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3487
    mov     ah, [esi]
    mov     bh, [esi+1]
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3453
locret_E3487:
    retn

loc_E3488:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E34C7
    mov     ah, [esi]
    mov     bh, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3488
locret_E34C7:
    retn

loc_E34C8:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E34FE
    mov     ax, [esi]
    mov     bx, [esi+2]
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E34C8

locret_E34FE:
    retn
loc_E34FF:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3540
    mov     ax, [esi]
    mov     bx, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E34FF

locret_E3540:
    retn

loc_E3541:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E356A
    mov     ah, [esi]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3541

locret_E356A:
    retn

loc_E356B:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3599
    mov     ah, [esi]
    xor     eax, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E356B

locret_E3599:
    retn

loc_E359A:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E35C4
    mov     ax, [esi]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E359A

locret_E35C4:
    retn

loc_E35C5:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E35F4
    mov     ax, [esi]
    xor     eax, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E35C5

locret_E35F4:
    retn

loc_E35F5:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3632
    mov     ah, [esi]
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
    add     edi, 8
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E35F5

locret_E3632:
    retn

loc_E3633:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3675
    mov     ah, [esi]
    xor     eax, 8000h
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
    add     edi, 8
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3633

locret_E3675:
    retn

loc_E3676:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E36B4
    mov     ax, [esi]
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
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3676

locret_E36B4:
    retn

loc_E36B5:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E36F8
    mov     ax, [esi]
    xor     eax, 8000h
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
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E36B5

locret_E36F8:
    retn

loc_E36F9:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3725
    mov     ah, [esi]
    mov     bh, [esi+1]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E36F9

locret_E3725:
    retn

loc_E3726:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E375D
    mov     ah, [esi]
    mov     bh, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3726

locret_E375D:
    retn

loc_E375E:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E378C
    mov     ax, [esi]
    mov     bx, [esi+2]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E375E

locret_E378C:
    retn

loc_E378D:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E37C6
    mov     ax, [esi]
    mov     bx, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E378D

locret_E37C6:
    retn

loc_E37C7:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3805
    mov     ah, [esi]
    mov     bh, [esi+1]
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
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E37C7

locret_E3805:
    retn

loc_E3806:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E384F
    mov     ah, [esi]
    mov     bh, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
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
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3806

locret_E384F:
    retn

loc_E3850:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3890
    mov     ax, [esi]
    mov     bx, [esi+2]
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
    add     edi, 8
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3850

locret_E3890:
    retn

loc_E3891:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E38DC
    mov     ax, [esi]
    mov     bx, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
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
    add     edi, 8
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3891

locret_E38DC:
    retn

loc_E38DD:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E390F
    mov     ah, [esi]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E38DD

locret_E390F:
    retn

loc_E3910:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3947
    mov     ah, [esi]
    xor     eax, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3910

locret_E3947:
    retn

loc_E3948:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3980
    mov     ax, [esi]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3948

locret_E3980:
    retn

loc_E3981:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E39BE
    mov     ax, [esi]
    xor     eax, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3981

locret_E39BE:
    retn

loc_E39BF:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3A05
    mov     ah, [esi]
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
    add     edi, 8
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E39BF

locret_E3A05:
    retn

loc_E3A06:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3A51
    mov     ah, [esi]
    xor     eax, 8000h
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
    add     edi, 8
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3A06

locret_E3A51:
    retn

loc_E3A52:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3A9E
    mov     ax, [esi]
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
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3A52

locret_E3A9E:
    retn

loc_E3A9F:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3AF0
    mov     ax, [esi]
    xor     eax, 8000h
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
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3A9F

locret_E3AF0:
    retn

loc_E3AF1:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3B2B
    mov     ah, [esi]
    mov     bh, [esi+1]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3AF1

locret_E3B2B:
    retn

loc_E3B2C:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3B71
    mov     ah, [esi]
    mov     bh, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3B2C
locret_E3B71:
    retn

loc_E3B72:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3BAE
    mov     ax, [esi]
    mov     bx, [esi+2]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3B72

locret_E3BAE:
    retn

loc_E3BAF:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3BF6
    mov     ax, [esi]
    mov     bx, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3BAF
locret_E3BF6:
    retn

loc_E3BF7:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3C43
    mov     ah, [esi]
    mov     bh, [esi+1]
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
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3BF7

locret_E3C43:
    retn

loc_E3C44:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3C9B
    mov     ah, [esi]
    mov     bh, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
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
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3C44
locret_E3C9B:
    retn

loc_E3C9C:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3CEA
    mov     ax, [esi]
    mov     bx, [esi+2]
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
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3C9C

locret_E3CEA:
    retn

loc_E3CEB:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3D44
    mov     ax, [esi]
    mov     bx, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
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
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3CEB

locret_E3D44:
    retn

loc_E3D45:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3D62
    mov     ah, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3D45
locret_E3D62:
    retn

loc_E3D63:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3D85
    mov     ah, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3D63

locret_E3D85:
    retn

loc_E3D86:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3DA4
    mov     ax, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3D86

locret_E3DA4:
    retn

loc_E3DA5:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3DC8
    mov     ax, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3DA5

locret_E3DC8:
    retn

loc_E3DC9:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3DE9
    mov     ah, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3DC9

locret_E3DE9:
    retn

loc_E3DEA:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3E0F
    mov     ah, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3DEA

locret_E3E0F:
    retn

loc_E3E10:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3E31
    mov     ax, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3E10

locret_E3E31:
    retn

loc_E3E32:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3E58
    mov     ax, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3E32

locret_E3E58:
    retn

loc_E3E59:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3E79
    mov     bh, [esi]
    mov     ah, [esi+1]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3E59

locret_E3E79:
    retn

loc_E3E7A:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3EA5
    mov     bh, [esi]
    mov     ah, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3E7A

locret_E3EA5:
    retn

loc_E3EA6:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3EC8
    mov     bx, [esi]
    mov     ax, [esi+2]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3EA6

locret_E3EC8:
    retn

loc_E3EC9:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3EF6
    mov     bx, [esi]
    mov     ax, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3EC9

locret_E3EF6:
    retn

loc_E3EF7:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3F1D
    mov     bh, [esi]
    mov     ah, [esi+1]
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3EF7

locret_E3F1D:
    retn

loc_E3F1E:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3F4F
    mov     bh, [esi]
    mov     ah, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3F1E
locret_E3F4F:
    retn

loc_E3F50:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3F78
    mov     bx, [esi]
    mov     ax, [esi+2]
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3F50

locret_E3F78:
    retn

loc_E3F79:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3FAC
    mov     bx, [esi]
    mov     ax, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3F79
locret_E3FAC:
    retn

loc_E3FAD:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3FD3
    mov     ah, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3FAD
locret_E3FD3:
    retn

loc_E3FD4:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E3FFF
    mov     ah, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E3FD4
locret_E3FFF:
    retn

loc_E4000:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E402C
    mov     ax, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4000
locret_E402C:
    retn

loc_E402D:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E405E
    mov     ax, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E402D
locret_E405E:
    retn

loc_E405F:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4088
    mov     ah, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E405F
locret_E4088:
    retn

loc_E4089:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E40B7
    mov     ah, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4089
locret_E40B7:
    retn

loc_E40B8:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E40E7
    mov     ax, [esi]
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E40B8
locret_E40E7:
    retn

loc_E40E8:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E411C
    mov     ax, [esi]
    xor     eax, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     [edi+4], eax
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E40E8
locret_E411C:
    retn

loc_E411D:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E414B
    mov     bh, [esi]
    mov     ah, [esi+1]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E411D
locret_E414B:
    retn

loc_E414C:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4185
    mov     bh, [esi]
    mov     ah, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E414C
locret_E4185:
    retn

loc_E4186:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E41B6
    mov     bx, [esi]
    mov     ax, [esi+2]
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4186
locret_E41B6:
    retn

loc_E41B7:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E41F2
    mov     bx, [esi]
    mov     ax, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E41B7
locret_E41F2:
    retn

loc_E41F3:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4227
    mov     bh, [esi]
    mov     ah, [esi+1]
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E41F3
locret_E4227:
    retn

loc_E4228:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4267
    mov     bh, [esi]
    mov     ah, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4228
locret_E4267:
    retn

loc_E4268:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E429E
    mov     bx, [esi]
    mov     ax, [esi+2]
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4268
locret_E429E:
    retn

loc_E429F:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E42E0
    mov     bx, [esi]
    mov     ax, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
    movsx   eax, ax
    add     [edi], eax
    movsx   ebx, bx
    add     [edi+4], ebx
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E429F
locret_E42E0:
    retn

loc_E42E1:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E430A
    mov     ah, [esi]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E42E1
locret_E430A:
    retn

loc_E430B:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4339
    mov     ah, [esi]
    xor     eax, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E430B
locret_E4339:
    retn

loc_E433A:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4364
    mov     ax, [esi]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E433A
locret_E4364:
    retn

loc_E4365:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4394
    mov     ax, [esi]
    xor     eax, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4365
locret_E4394:
    retn

loc_E4395:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E43D2
    mov     ah, [esi]
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
    add     edi, 8
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4395
locret_E43D2:
    retn

loc_E43D3:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4415
    mov     ah, [esi]
    xor     eax, 8000h
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
    add     edi, 8
    add     esi, 1
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E43D3
locret_E4415:
    retn

loc_E4416:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4454
    mov     ax, [esi]
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
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4416

locret_E4454:
    retn

loc_E4455:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4498
    mov     ax, [esi]
    xor     eax, 8000h
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
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4455

locret_E4498:
    retn

loc_E4499:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E44C5
    mov     bh, [esi]
    mov     ah, [esi+1]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4499

locret_E44C5:
    retn

loc_E44C6:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E44FD
    mov     bh, [esi]
    mov     ah, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E44C6

locret_E44FD:
    retn

loc_E44FE:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E452C
    mov     bx, [esi]
    mov     ax, [esi+2]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E44FE

locret_E452C:
    retn

loc_E452D:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4566
    mov     bx, [esi]
    mov     ax, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E452D
locret_E4566:
    retn

loc_E4567:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E45A5
    mov     bh, [esi]
    mov     ah, [esi+1]
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
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4567
locret_E45A5:
    retn

loc_E45A6:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E45EF
    mov     bh, [esi]
    mov     ah, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
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
    add     edi, 8
    add     esi, 2
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E45A6

locret_E45EF:
    retn

loc_E45F0:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4630
    mov     bx, [esi]
    mov     ax, [esi+2]
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
    add     edi, 8
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E45F0

locret_E4630:
    retn

loc_E4631:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E467C
    mov     bx, [esi]
    mov     ax, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
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
    add     edi, 8
    add     esi, 4
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4631
locret_E467C:
    retn

loc_E467D:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E46AF
    mov     ah, [esi]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E467D

locret_E46AF:
    retn

loc_E46B0:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E46E7
    mov     ah, [esi]
    xor     eax, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E46B0

locret_E46E7:
    retn

loc_E46E8:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4720
    mov     ax, [esi]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E46E8

locret_E4720:
    retn

loc_E4721:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E475E
    mov     ax, [esi]
    xor     eax, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4721
locret_E475E:
    retn

loc_E475F:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E47A5
    mov     ah, [esi]
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
    add     edi, 8
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E475F
locret_E47A5:
    retn

loc_E47A6:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E47F1
    mov     ah, [esi]
    xor     eax, 8000h
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
    add     edi, 8
    add     ecx, _wMixingSampleFraction
    adc     esi, _wMixingSampleWhole
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E47A6
locret_E47F1:
    retn

loc_E47F2:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E483E
    mov     ax, [esi]
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
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E47F2
locret_E483E:
    retn

loc_E483F:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4890
    mov     ax, [esi]
    xor     eax, 8000h
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
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E483F
locret_E4890:
    retn

loc_E4891:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E48CB
    mov     bh, [esi]
    mov     ah, [esi+1]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4891
locret_E48CB:
    retn

loc_E48CC:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4911
    mov     bh, [esi]
    mov     ah, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E48CC
locret_E4911:
    retn

loc_E4912:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E494E
    mov     bx, [esi]
    mov     ax, [esi+2]
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4912
locret_E494E:
    retn

loc_E494F:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4996
    mov     bx, [esi]
    mov     ax, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
    movzx   eax, ax
    imul    word ptr _wVolumeLeft
    add     edx, edx
    movsx   edx, dx
    add     [edi], edx
    add     edi, 4
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E494F
locret_E4996:
    retn

loc_E4997:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E49E3
    mov     bh, [esi]
    mov     ah, [esi+1]
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
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4997
locret_E49E3:
    retn

loc_E49E4:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4A3B
    mov     bh, [esi]
    mov     ah, [esi+1]
    xor     eax, 8000h
    xor     ebx, 8000h
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
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E49E4
locret_E4A3B:
    retn

loc_E4A3C:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4A8A
    mov     bx, [esi]
    mov     ax, [esi+2]
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
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4A3C

locret_E4A8A:
    retn

loc_E4A8B:
    cmp     esi, _wMixingSampleEnd
    jnb     short locret_E4AE4
    mov     bx, [esi]
    mov     ax, [esi+2]
    xor     eax, 8000h
    xor     ebx, 8000h
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
    add     edi, 8
    xor     ebp, ebp
    add     ecx, _wMixingSampleFraction
    adc     ebp, ebp
    add     esi, _wMixingSampleWhole[ebp*4]
    cmp     edi, _pMixingBufferEnd
    jbe     short loc_E4A8B

locret_E4AE4:
    retn

PUBLIC _sosModule15End
_sosModule15End PROC
    retn
ENDP

END