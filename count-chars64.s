#PURPOSE:  Count the characters until a null byte is reached.
#
#INPUT:    The address of the character string
#
#OUTPUT:   Returns the count in %eax
#
#PROCESS:
#  Registers used:
#    %ecx - character count
#    %al - current character
#    %edx - current character address

.type count_chars, @function
.globl count_chars

#This is where our one parameter is on the stack
.equ ST_STRING_START_ADDRESS, 16
count_chars:
 pushq %rbp
 movq %rsp, %rbp

 movq ST_STRING_START_ADDRESS(%rbp), %rbx
 movq $0, %rax                            #Initial count

loop_start:
#Exit if we reached the null terminator
 movb (%rbx), %cl
 cmpb $0, %cl
 je loop_end

#Otherwise increment pointer & count then loop
 incq %rbx
 incq %rax
 jmp loop_start

loop_end:
 movq %rbp, %rsp
 popq %rbp
 ret
