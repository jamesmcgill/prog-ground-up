 #PURPOSE: This program find the maximum number of a set of data items
 #

 # %rbx - Hold the index of the data item being examined
 # %rdi - Largest data item found
 # %rax - Current data item
 #
 # The following memory locations are used:
 #
 # data_items - contains the item data. A 0 is used to terminate the data
 #

 .section .data

data_items:
 .quad 3,67,34,222,45,75,54,34,44,33,22,11,66,0

 .section .text

 .globl _start
_start:
 movq $0, %rbx                        # set index to 0
 movq data_items(,%rbx,8), %rax       # load first byte of data
 movq %rax, %rdi                      # first item is biggest

start_loop:
 cmpq $0, %rax                        # End of Data?
 je loop_exit
 incq %rbx                            # Increment index
 movq data_items(,%rbx,8), %rax       # load next byte
 cmpq %rdi, %rax                      # Is new Max?
 jle start_loop
 movq %rax, %rdi                      # set new Max
 jmp start_loop

loop_exit:
 movq $60, %rax
 syscall

