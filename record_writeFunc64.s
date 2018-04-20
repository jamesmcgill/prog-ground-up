.include "record-def.s"
.include "linux64.s"

#Write one record to a file
#
#Requires the following pushed on the stack before calling
# 1) Open file File Descriptor (where the record will be written to)
# 2) Buffer Location (where the record should be read from)
#
# Return value in %rax

#STACK LOCATIONS
.equ FD_OUT, 24
.equ BUFFER_IN, 16

.section .text
.globl write_record
.type write_record, @function

write_record:
pushq %rbp
movq %rsp, %rbp

movq $SYS_WRITE, %rax            #Prime the syscall
movq FD_OUT(%rbp), %rdi          #Set the File Descriptor
movq BUFFER_IN(%rbp), %rsi       #Set the ouput Buffer
movq $RECORD_SIZE, %rdx          #Buffer size
syscall

popq %rbp
ret



