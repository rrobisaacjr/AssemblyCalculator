global _start
global addition
global subtraction
global division
global askUserTwoNumbers
global convertAnswerToStringandDisplay

section .data
	; System Call Variables / Constants
	LF equ 10									; Line feed (new line character)
    NULL equ 0									; Null terminator
    SYS_EXIT equ 60								; System call number for exit
    STDOUT equ 1								; Standard output file descriptor
    SYS_WRITE equ 1								; System call number for write
    STDIN equ 0									; Standard input file descriptor
    SYS_READ equ 0								; System call number for read

	; String Text Variables
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

section .bss
	; String Storage Variables
    num1Char resb 3                              ; Reserve 3 byte-items for first input
    num2Char resb 3                              ; Reserve 3 byte-items for second input
    ansChar resb 3                               ; Reserve 3 byte-items for the sum, difference, and quotient string

section .text
_start:
	call printNewLine

	; Write menu message to standard output
	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, msg
	mov rdx, msgLen
	syscall

	; Read input from standard input into choice
	mov rax, SYS_READ
	mov rdi, STDIN
	mov rsi, choice
	mov rdx, 2
	syscall

	sub byte[choice], 30h						; Convert ASCII digit to numerical value for choice

	; Compare the value in choice and jump to different functions
    cmp byte[choice], 1
    je askUserTwoNumbers						; If choice is addition, ask user two numbers
    cmp byte[choice], 2
    je askUserTwoNumbers						; If choice is subtraction, ask user two numbers
    cmp byte[choice], 3
    je askUserTwoNumbers						; If choice is integer division, ask user two numbers
    cmp byte[choice], 0							
    je exit_here								; If choice is exit, exit the program

	jmp _start									; If invalid choice, loop the menu 

; Exit function
exit_here:
	mov rax, SYS_EXIT
	xor rdi, rdi
	syscall

; Function for writing a new line to standard output for convenience and aesthetics
printNewLine:
	mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, newLine
	mov rdx, newLineLen
	syscall
	ret


addition:
    ; Addition Proper -------------------------------------------------------------------------------------------------------------------
    mov al, byte[num1]              
    add al, byte[num2]
	mov byte[sum], al

    mov al, byte[sum]                   		; Sum is moved to al
	
	call convertAnswerToStringandDisplay		; Sum in al will be processed for output display
	call printNewLine

    jmp _start    								; Jump back to _start to loop execution

subtraction:
	; Subtraction Proper -------------------------------------------------------------------------------------------------------------------
    mov al, byte[num1]              
    sub al, byte[num2]
	mov byte[difference], al

	mov ah, 0

    mov al, byte[difference]            		; Difference is moved to al
	
	call convertAnswerToStringandDisplay		; Difference in al will be processed for output display
	call printNewLine

    jmp _start									; Jump back to _start to loop execution

division:
	; Integer Division Proper -------------------------------------------------------------------------------------------------------------------
    mov al, byte[num1]              
    div byte[num2]
	mov byte[quotient], al

	mov ah, 0

    mov al, byte[quotient]              		; Quotient is moved to al
	
	call convertAnswerToStringandDisplay		; Quotient in al will be processed for output display
	call printNewLine
	
    jmp _start									; Jump back to _start to loop execution

; Function for asking user two two-digit numbers and converts them into numerical values for operation
askUserTwoNumbers:
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

    ; Print the prompt message for entering a two-digit number
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

    ; Convert num1Char into numerical and store to num1
    mov al, byte[num1Char]						; first character move to al
    sub al, 30h									; ASCII character into numerical

    mul byte[ten]								; first character is tens in numerical, multiple by 10
    mov byte[num1], al							; transfer tens digit to num1

    mov al, byte[num1Char+1]					; second character move to al
    sub al, 30h									; ASCII character into numerical
    add byte[num1], al							; just add the ones digit to num1 with the numerical tens digit

    ; Convert num2Char into numerical and store to num2
    mov al, byte[num2Char]						; first character move to al
    sub al, 30h									; ASCII character into numerical

    mul byte[ten]								; first character is tens in numerical, multiple by 10
    mov byte[num2], al							; transfer tens digit to num2

    mov al, byte[num2Char+1]					; second character move to al
    sub al, 30h									; ASCII character into numerical
    add byte[num2], al							; just add the ones digit to num1 with the numerical tens digit

    ; reset num1Char and num2Char
    mov byte[num1Char], 30h
    mov byte[num1Char+1], 30h
    mov byte[num1Char+2], NULL

    mov byte[num2Char], 30h
    mov byte[num2Char+1], 30h
    mov byte[num1Char+2], NULL

	; After processing inputs, compare the value again in choice and jump to different functions
    cmp byte[choice], 1
    je addition									; If previous choice was addition, proceed to addition function
    cmp byte[choice], 2
    je subtraction								; If previous choice was subtraction, proceed to subtraction function
    cmp byte[choice], 3
    je division									; If previous choice was integer division, proceed to division function

; Function for converting the sum, difference, or quotient into string and displays them
convertAnswerToStringandDisplay:
	; Hundreds place numerical to character
	div byte[hundred]                   		; al is divided by 100
	add al, 30h                         		; al converted to ASCII character
	mov byte[ansChar], al               		; al is placed on hundreds place (first item)
	mov al, ah                          		; remainder overwrites al
	mov ah, 0                           		; ah resets
    
    ; Tens place numerical to character
	div byte[ten]                       		; al is divided by 10
	add al, 30h                         		; al converted to ASCII character
	mov byte[ansChar+1], al             		; al is placed on tens place (second item)
	mov al, ah                          		; remainder overwrites al                          
	mov ah, 0                           		; ah resets

    ; Ones place numerical to character
	add al, 30h                         		; expected that al is ones digit, convert to ASCII character
	mov byte[ansChar+2], al             		; al is placed on ones place (third item)

    ; Print ansChar (the string version of sum, difference, or quotient)
    mov rax, SYS_WRITE
	mov rdi, STDOUT
	mov rsi, ansChar
	mov rdx, 3
	syscall

	ret