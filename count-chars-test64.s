.include "linux64.s"
.include "record-def.s"

.section .data

#Constant Data to be written
record1:
 .ascii "Fredrick\0"

 .section .text
 .globl _start
_start:

movq %rsp, %rbp          #Setup Base stack pointer

#Count
pushq $record1
call count_chars

movq %rax, %rdi  # Move count into return value

#Exit
movq $SYS_EXIT, %rax
syscall





