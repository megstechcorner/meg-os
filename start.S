/** @megstechcorner.com  
    All rights reserved.
**/

.global start 

.equ MAGIC_NUMBER, 0x1BADB002     # define the magic number constant
.equ FLAGS,        0x0            # multiboot flags
.equ CHECKSUM,     -MAGIC_NUMBER  # calculate the checksum
                                  # (magic number + checksum + flags should equal 0)

    .text                 
.align 4    

    .long MAGIC_NUMBER          
    .long FLAGS                    
    .long CHECKSUM  

start:

loop:
    mov $826, %eax
    jmp loop
