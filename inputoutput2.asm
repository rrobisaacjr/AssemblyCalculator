global _start

section .data
	LF equ 10
	NULL equ 0
	SYS_EXIT equ 60
	STDOUT equ 1
	SYS_WRITE equ 1

	var db 0
	newLine db LF, NULL
	newLineLen equ $-newLine

section .text
_start:
	mov byte[var], "A"
	add byte[var], 32

	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, var
	mov rdx, 1
	syscall

	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, newLine
	mov rdx, newLineLen
	syscall

exit_here:
	mov rax, SYS_EXIT
	xor rdi, rdi
	syscall