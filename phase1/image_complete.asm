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

        
DB 0x42,0x42,0x42,0x42,0x32,0x00,0x00,0x00,0x91,0xD8,0xF1,0x6D,0x70,0x20,0x3A,0xAB
DB 0x67,0x9A,0x0B,0xC4,0x91,0xFB,0xC7,0x66,0x0F,0xFC,0xCD,0xCC,0xB4,0x02,0xFA,0xD7
DB 0x77,0xB4,0x54,0x38,0xAB,0x1F,0x0E,0xE3,0x8E,0xD3,0x0D,0xEB,0x99,0xC3,0x93,0xFE
DB 0xD1,0x2B,0x1B,0x11,0xC6,0x11,0xEF,0xC8,0xCA,0x2F
