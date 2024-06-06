global _start
section .data
    LF equ 10
    NULL equ 0
    SYS_EXIT equ 60
    STDOUT equ 1
    SYS_WRITE equ 1
    STDIN equ 0
    SYS_READ equ 0

    ten db 10
    hundred db 100

    num1 db 0
    num2 db 0

    num1Char db "26", NULL
    num2Char db "31", NULL

section .text
_start:

    mov al, byte[num1Char]
    sub al, 30h

    mul byte[ten]
    mov byte[num1], al

    mov al, byte[num1Char+1]
    sub al, 30h
    add byte[num1], al

    mov al, byte[num2Char]
    sub al, 30h

    mul byte[ten]
    mov byte[num2], al

    mov al, byte[num2Char+1]
    sub al, 30h
    add byte[num2], al

    mov byte[num1Char], 30h
    mov byte[num1Char+1], 30h

    mov byte[num2Char], 30h
    mov byte[num2Char+1], 30h

exit_here:
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall
