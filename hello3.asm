section .data
	SYS_WRITE equ 1
	STD_OUT   equ 1
	SYS_EXIT  equ 60
	EXIT_CODE equ 0
        LF        equ 0xa
	WRONG_ARGC db "Must be two command line argument", LF 

section .text
        global _start

_start:
	pop rcx
	cmp rcx, 3
	jne argcError

	add rsp, 8
	pop rsi
	call str_to_int

	mov r10, rax
	pop rsi
	call str_to_int
        add rax, r10

;; number counter
        xor r12, r12
;; convert to string
        jmp int_to_str_lf

argcError:
        mov     rax, 1
	mov     rdi, 1
        mov     rsi, WRONG_ARGC
        mov     rdx, 34
        syscall
	jmp exit

str_to_int:
        xor rax, rax
        mov rcx,  10
next:
        cmp [rsi], byte 0
	je return_str
        mul rcx
	mov bl, [rsi]
        sub bl, 48
	add rax, rbx
	inc rsi
	jmp next

return_str:
	ret

int_to_str_lf:
        push LF
        inc r12
        mov rbx, 10
int_to_str:
        xor rdx, rdx
	div rbx
        add rdx, 0x30
	push rdx
	inc r12
	cmp rax, 0x0
	jne int_to_str
	;;;; calculate number length
        mov rax, r12
        mov r12, 8
        mul r12
	mov rdx, rax
	;;;; print sum
	mov rax, SYS_WRITE
	mov rdi, STD_OUT
	mov rsi, rsp
	;; call sys_write
	syscall
exit:
	mov rax, SYS_EXIT
	mov rdi, EXIT_CODE
	syscall
