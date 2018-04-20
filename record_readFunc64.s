.include "record-def.s"
.include "linux64.s"

#Read one record from a file
#
#Requires the following pushed on the stack before calling
# 1) Open file File Descriptor (where the record is)
# 2) Buffer Location (where the record should be written to)
#
# Return value in %rax

#STACK LOCATIONS
.equ FD_IN, 24
.equ BUFFER_OUT, 16

.section .text
.globl read_record
.type read_record, @function

read_record:
pushq %rbp
movq %rsp, %rbp

movq $SYS_READ, %rax              #Prime the syscall
movq FD_IN(%rbp), %rdi            #Set the File Descriptor
movq BUFFER_OUT(%rbp), %rsi       #Set the ouput Buffer
movq $RECORD_SIZE, %rdx           #Buffer size
syscall

popq %rbp
ret



