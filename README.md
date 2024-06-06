# Assembly Program

This assembly program demonstrates a simple menu-driven calculator allowing users to perform addition, subtraction, and integer division on two-digit numbers.

## Program Description

The program provides a menu with the following options:
- **[1] Addition**
- **[2] Subtraction**
- **[3] Integer Division**
- **[0] Exit**

Upon selecting an operation, the program prompts the user to enter two two-digit numbers. After receiving the input, it performs the selected operation and displays the result.

## Program Structure

### Constants and System Calls
- Defines various constants for system calls and ASCII characters.
- Initializes strings for menu messages, prompts, and new lines.

### Sections
1. **.data**: Contains initialized data such as system call variables, menu messages, and numerical variables.
2. **.bss**: Contains storage variables for user input.
3. **.text**: Contains the program's executable code, including the main `_start` routine and various functions.

### Functions
- **_start**: Entry point of the program. Displays the menu, reads user input, and directs program flow based on the selected option.
- **addition**: Performs addition of two numbers and displays the result.
- **subtraction**: Performs subtraction of two numbers and displays the result.
- **division**: Performs integer division of two numbers and displays the result.
- **askUserTwoNumbers**: Prompts the user to enter two two-digit numbers, converts them to numerical format, and calls the appropriate operation function.
- **convertAnswerToStringandDisplay**: Converts the numerical result to a string and displays it.

## How to Use

1. Clone the repository or download the assembly file.
2. Assemble the assembly file using NASM:
   
   ```bash
   nasm -felf64 isaacrr_exer9.asm
   ld isaacrr_exer9.o
   ./a.out
   ```
3. Simulate/test the program by providing needed input.
