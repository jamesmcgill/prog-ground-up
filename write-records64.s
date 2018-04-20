.include "linux64.s"
.include "record-def.s"

.section .data

#Constant Data to be written
record1:
 .ascii "Fredrick\0"
 .rept 31   #Padding to 40 bytes
 .byte 0
 .endr

 .ascii "Bartlett\0"
 .rept 31   #Padding to 40 bytes
 .byte 0
 .endr

 .ascii "4242 S Prairie\nTulsa, OK 55555\0"
 .rept 209   #Padding to 240 bytes
 .byte 0
 .endr

 .long 45

record2:
 .ascii "Marilyn\0"
 .rept 32 #Padding to 40 bytes
 .byte 0
 .endr

 .ascii "Taylor\0"
 .rept 33 #Padding to 40 bytes
 .byte 0
 .endr

 .ascii "2224 S Johannan St\nChicago, IL 12345\0"
 .rept 203 #Padding to 240 bytes
 .byte 0
 .endr

 .long 29

record3:
 .ascii "Derrick\0"
 .rept 32 #Padding to 40 bytes
 .byte 0
 .endr

 .ascii "McIntire\0"
 .rept 31 #Padding to 40 bytes
 .byte 0
 .endr

 .ascii "500 W Oakland\nSan Diego, CA 54321\0"
 .rept 206 #Padding to 240 bytes
 .byte 0
 .endr

 .long 36

#This is the name of the file we will write to
file_name:
 .ascii "test.dat\0"

.equ ST_FILE_DESC, -8

 .section .text
 .globl _start
_start:

movq %rsp, %rbp          #Setup Base stack pointer
subq $8, %rsp            #make room for file descriptor

movq $SYS_OPEN, %rax      #Prime syscall
movq $file_name, %rdi    #filename to open
movq $0101, %rsi         #write flags (Create if not exist)
movq $0666, %rdx         #mode
syscall

movq %rax, ST_FILE_DESC(%rbp)      #store the file descriptor

#Write Record1
pushq $record1
call write_record
addq $8, %rsp

pushq $record2
call write_record
addq $8, %rsp

pushq $record3
call write_record
addq $8, %rsp

#Close the file
movq $SYS_CLOSE, %rax            #Prime the syscall
movq ST_FILE_DESC(%rbp), %rdi
syscall

#Cleanup
movq %rbp, %rsp

#Exit
movq $SYS_EXIT, %rax
movq $0, %rdi
syscall





