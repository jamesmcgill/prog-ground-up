.include "linux64.s"
.include "record-def.s"

.section .data

#This is the name of the file we will read from
file_name:
 .ascii "test.dat\0"

.section .bss
.lcomm record_buffer, RECORD_SIZE

 .section .text
 .globl _start
_start:

.equ ST_IN_FD, -8
.equ ST_OUT_FD, -16

movq %rsp, %rbp          #Setup Base stack pointer
subq $16, %rsp           #Make room for 2 file descriptors

movq $SYS_OPEN, %rax     #Prime syscall
movq $file_name, %rdi    #filename to open
movq $0, %rsi            #read flags
movq $0666, %rdx         #mode
syscall

movq %rax, ST_IN_FD(%rbp)      #store the file descriptor
movq $STDOUT, ST_OUT_FD(%rbp)  #store the output file descriptor


read_record_loop:
pushq ST_IN_FD(%rbp)
pushq $record_buffer
call read_record
addq $16, %rsp

#Check the returned read size is what was expected
cmpq $RECORD_SIZE, %rax
jne finished_reading

#Otherwise, print the record

pushq $RECORD_FIRSTNAME + record_buffer
call count_chars
addq $8, %rsp
movq %rax, %rdx

movq $SYS_WRITE, %rax
movq ST_OUT_FD(%rbp), %rdi
movq $RECORD_FIRSTNAME + record_buffer, %rsi
syscall


pushq ST_OUT_FD(%rbp)
call write_newline
addq $8, %rsp

#Next record
jmp read_record_loop

finished_reading:

#Close the file
movq $SYS_CLOSE, %rax            #Prime the syscall
movq ST_IN_FD(%rbp), %rdi
syscall

#Cleanup
movq %rbp, %rsp

#Exit
movq $SYS_EXIT, %rax
movq $0, %rdi
syscall





