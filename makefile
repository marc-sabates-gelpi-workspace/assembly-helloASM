hello:	hello.o
	ld -o hello hello.o

hello.o:	hello.asm
	nasm -f elf64 -o hello.o hello.asm

clean:
	rm -f *.o hello
