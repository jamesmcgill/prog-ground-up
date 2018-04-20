 #PURPOSE: This program find the maximum number of a set of data items
 #

 # %edi - Hold the index of the data item being examined
 # %ebx - Largest data item found
 # %eax - Current data item
 #
 # The following memory locations are used:
 #
 # data_items - contains the item data. A 0 is used to terminate the data
 #

 .section .data

data_items:
 .long 3,67,34,222,45,75,54,34,44,33,22,11,66,0

 .section .text

 .globl _start
_start:
 movl $0, %edi                        # set index to 0
 movl data_items(,%edi,4), %eax       # load first byte of data
 movl %eax, %ebx                      # first item is biggest

start_loop:
 cmpl $0, %eax                        # End of Data?
 je loop_exit
 incl %edi                            # Increment index
 movl data_items(,%edi,4), %eax       # load next byte
 cmpl %ebx, %eax                      # Is new Max?
 jle start_loop
 movl %eax, %ebx                      # set new Max
 jmp start_loop

loop_exit:
 movl $1, %eax
 int $0x80

