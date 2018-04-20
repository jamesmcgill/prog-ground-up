# prog-ground-up
x86-64 assembly on Linux examples from the book Programming from the Ground Up.

http://programminggroundup.blogspot.de/2007/01/programming-from-ground-up.html

Converted to 64bit ABI with the help of:  
http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/


## Building example:
`gcc -nostdlib record_writeFunc64.s write-records64.s -o write-records`  
or  
`as maximum64.s -o maximum64.o`  
`ld maximum64.o -o maximum`

