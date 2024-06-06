
; Reynaldo R. Isaac Jr.         CMSC 131 - AB5L         STRUCTURES
global _start
global printNewLine

section .data
	LF equ 10									; Line feed (new line character)
    NULL equ 0									; Null terminator
    SYS_EXIT equ 60								; System call number for exit
    STDOUT equ 1								; Standard output file descriptor
    SYS_WRITE equ 1								; System call number for write
    STDIN equ 0									; Standard input file descriptor
    SYS_READ equ 0								; System call number for read

    msg db "************MENU***********", LF, "[1] Addition", LF, "[2] Subtraction", LF, "[3] Integer Division", LF, "[0] Exit", LF, "**************************", LF, "Choice: ", NULL
												; Menu message
	msgLen equ $-msg							; Length of menu message
	msgQ db "Enter a two-digit number: ", NULL	; Prompt message for entering a number
	msgQLen equ $-msgQ							; Length of prompt message

    newLine db LF, NULL							; New line string
	newLineLen equ $-newLine					; Length of new line string

    ; Numerical Variables
    choice db 0									; Variable to store user's choice
	num1 db 0									; Variable to store first number
	num2 db 0									; Variable to store second number

    sum db 0									; Variable to store sum in numerical format
	difference db 0								; Variable to store difference in numerical format
	quotient db 0								; Variable to store quotient in numerical format

    ; Helper Variables
    ten db 10						    		; Variable to 10 value
    hundred db 100								; Variable to 100 value

    ; String Variables
    ; num1Char db 0, 0, 0, 0  ; Allocate 3 bytes and initialize them to 0

section .bss
    num1Char resb 3                              ; Reserve 3 byte-items for first input
    num2Char resb 3                              ; Reserve 3 byte-items for second input
    ansChar resb 3                               ; Reserve 3 byte-items for second input

section .text
_start:
    call printNewLine

	; Print the prompt message for entering a two-digit number
	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, msgQ
	mov rdx, msgQLen
	syscall

	; Read the user's input into num1
	mov rax, SYS_READ
	mov rdi, STDIN
	mov rsi, num1Char							; Address of num1Char where the input will be stored
	mov rdx, 3									; Number of bytes to read (including newline)
	syscall

	; Print num1Char
	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, num1Char
	mov rdx, 2
	syscall

    ; Print the prompt message for entering a two-digit number
    call printNewLine
	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, msgQ
	mov rdx, msgQLen
	syscall
    
	; Read the user's input into num2
	mov rax, SYS_READ
	mov rdi, STDIN
	mov rsi, num2Char							; Address of num2Char where the input will be stored
	mov rdx, 3									; Number of bytes to read (including newline)
	syscall
    
    ; Print num2Char
	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, num2Char
	mov rdx, 2
	syscall
    call printNewLine
    call printNewLine

    ; Convert num1Char into numerical and store to num1
    mov al, byte[num1Char]
    sub al, 30h

    mul byte[ten]
    mov byte[num1], al

    mov al, byte[num1Char+1]
    sub al, 30h
    add byte[num1], al

    ; Convert num2Char into numerical and store to num2
    mov al, byte[num2Char]
    sub al, 30h

    mul byte[ten]
    mov byte[num2], al

    mov al, byte[num2Char+1]
    sub al, 30h
    add byte[num2], al

    ; reset num1Char and num2Char
    mov byte[num1Char], 30h
    mov byte[num1Char+1], 30h
    mov byte[num1Char+2], NULL

    mov byte[num2Char], 30h
    mov byte[num2Char+1], 30h
    mov byte[num1Char+2], NULL

    ; ; Addition Proper -----------------------
    ; mov al, byte[num1]              
    ; add al, byte[num2]
	; mov byte[sum], al

    ; ; Hundreds place numerical to character
    ; mov al, byte[sum]                   ; sum is moved to al
	; div byte[hundred]                   ; al is divided by 0
	; add al, 30h                         ; al converted to ASCII character
	; mov byte[ansChar], al               ; al is placed on hundreds place (first item)
	; mov al, ah                          ; remainder overwrites al
	; mov ah, 0                           ; ah resets
    
    ; ; Tens place numerical to character
	; div byte[ten]                       ; al is divided by 10
	; add al, 30h                         ; al converted to ASCII character
	; mov byte[ansChar+1], al             ; al is placed on tens place (second item)
	; mov al, ah                          ; remainder overwrites al                          
	; mov ah, 0                           ; ah resets

    ; ; Ones place numerical to character
	; add al, 30h                         ; expected that al is ones digit, convert to ASCII character
	; mov byte[ansChar+2], al             ; al is placed on ones place (third item)

    ; ; Print ansChar
    ; mov rax, SYS_WRITE
	; mov rdi, STDOUT
	; mov rsi, ansChar
	; mov rdx, 3
	; syscall
    ; call printNewLine

    ; ; Subtraction Proper -------------------------
    ; mov al, byte[num1]              
    ; sub al, byte[num2]
	; mov byte[difference], al

    ; ; Hundreds place numerical to character
    ; mov al, byte[difference]            ; sum is moved to al
	; div byte[hundred]                   ; al is divided by 0
	; add al, 30h                         ; al converted to ASCII character
	; mov byte[ansChar], al        ; al is placed on hundreds place (first item)
	; mov al, ah                          ; remainder overwrites al
	; mov ah, 0                           ; ah resets
    
    ; ; Tens place numerical to character
	; div byte[ten]                       ; al is divided by 10
	; add al, 30h                         ; al converted to ASCII character
	; mov byte[ansChar+1], al             ; al is placed on tens place (second item)
	; mov al, ah                          ; remainder overwrites al                          
	; mov ah, 0                           ; ah resets

    ; ; Ones place numerical to character
	; add al, 30h                         ; expected that al is ones digit, convert to ASCII character
	; mov byte[ansChar+2], al             ; al is placed on ones place (third item)

    ; ; Print ansChar
    ; mov rax, SYS_WRITE
	; mov rdi, STDOUT
	; mov rsi, ansChar
	; mov rdx, 3
	; syscall
    ; call printNewLine

    ; ; Integer Division Proper -----------------------
    ; mov al, byte[num1]              
    ; div byte[num2]
	; mov byte[quotient], al

    ; ; Hundreds place numerical to character
    ; mov al, byte[quotient]              ; sum is moved to al
	; div byte[hundred]                   ; al is divided by 0
	; add al, 30h                         ; al converted to ASCII character
	; mov byte[ansChar], al               ; al is placed on hundreds place (first item)
	; mov al, ah                          ; remainder overwrites al
	; mov ah, 0                           ; ah resets
    
    ; ; Tens place numerical to character
	; div byte[ten]                       ; al is divided by 10
	; add al, 30h                         ; al converted to ASCII character
	; mov byte[ansChar+1], al             ; al is placed on tens place (second item)
	; mov al, ah                          ; remainder overwrites al                          
	; mov ah, 0                           ; ah resets

    ; ; Ones place numerical to character
	; add al, 30h                         ; expected that al is ones digit, convert to ASCII character
	; mov byte[ansChar+2], al             ; al is placed on ones place (third item)

    ; ; Print ansChar
    ; mov rax, SYS_WRITE
	; mov rdi, STDOUT
	; mov rsi, ansChar
	; mov rdx, 3
	; syscall
    ; call printNewLine

exit_here:
	mov rax, SYS_EXIT
	xor rdi, rdi
	syscall

; Write a new line to standard output
printNewLine:
	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, newLine
	mov rdx, newLineLen
	syscall
	ret


