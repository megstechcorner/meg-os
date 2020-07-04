/** @megstechcorner.com  
    All rights reserved.
**/

.global start 

.equ MAGIC_NUMBER, 0x1BADB002     # define the magic number constant
.equ FLAGS,        0x0            # multiboot flags
.equ CHECKSUM,     -MAGIC_NUMBER  # calculate the checksum
                                  # (magic number + checksum + flags should equal 0)
.equ KERNEL_STACK_SIZE, 4096      # 4KB for kernel stack.

    .text                 
.align 4    

    .long MAGIC_NUMBER          
    .long FLAGS                    
    .long CHECKSUM  

start:
    # Set up stack.
    mov $kernel_stack, %esp
    addl $KERNEL_STACK_SIZE, %esp

    call main

loop:
    jmp loop    

    .bss
.align 4096                                     
.lcomm kernel_stack, KERNEL_STACK_SIZE    # Reserve 4kb kernel stack  