run:
	nasm -f elf32 image_complete.asm
	ld -m elf_i386 image_complete.o -o phase1
clean:
	rm -f image_complete.o
	rm -f phase1