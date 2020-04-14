    .section        __TEXT,__text,regular,pure_instructions
    .p2align        4, 0x90
    .globl _main
  _main: 
            
movl 23, %ebx
neg %ebx
movl $ebx, %ecx
movl $ecx, %ebx
mov $ebx, %ecx
movl $ecx, %eax
 
    ret
