SECTION .text
global start

        jmp short start
        scasd
        ret 0xa3bf
start:
        sub esp,0x100
        xor ecx,ecx
loop1:
        mov [esp+ecx],cl
        inc cl
        jnz loop1
        xor eax,eax
        mov edx,0xdeadbeef
loop2:
        add al,[esp+ecx]
        add al,dl
        ror edx,byte 0x8
        mov bl,[esp+ecx]
        mov bh,[esp+eax]
        mov [esp+eax],bl
        mov [esp+ecx],bh
        inc cl
        jnz loop2
        jmp bottom
function:
        mov ebx,esp
        add ebx,0x4
        pop esp
        pop eax
        cmp eax,0x41414141
        jnz exit
        pop eax
        cmp eax,0x42424242
        jnz exit
        pop edx
        mov ecx,edx
        mov esi,esp
        mov edi,ebx
        sub edi,ecx
        rep movsb
        mov esi,ebx
        mov ecx,edx
        mov edi,ebx
        sub edi,ecx
        xor eax,eax
        xor ebx,ebx
        xor edx,edx
point0x6b:
        inc al
        add bl,[esi+eax]
        mov dl,[esi+eax]
        mov dh,[esi+ebx]
        mov [esi+eax],dh
        mov [esi+ebx],dl
        add dl,dh
        xor dh,dh
        mov bl,[esi+edx]
        mov dl,[edi]
        xor dl,bl
        mov [edi],dl
        inc edi
        dec ecx
        jnz point0x6b
exit:
        xor ebx,ebx
        mov eax,ebx               ;eax = 0
        inc al                    ;al = 1
        int 0x80                  ;Linux system call 当eax = 1时，该调用为exit()
bottom:
        nop
        nop
        call function
        inc ecx
        inc ecx
        inc ecx
        inc ecx
