section .data
    CR equ $0D
    LF equ $0A
    msg db      "hello, world!",CR,LF,0

section .text
    global _start
_start:
    BITS 32
    mov     eax, 1
    mov     edi, 1
    mov     esi, msg
    mov     edx, 16
    syscall
    mov    eax, 60
    mov    edi, 0
    syscall
