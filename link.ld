/** @megstechcorner.com  
    All rights reserved.
**/

ENTRY(start)                /* the name of the entry label */

SECTIONS {
    . = 0x100000;
    _kernel_start = .;

    .text ALIGN (0x1000) :   /* align at 4 KB */
    {
        *(.text)             /* all text sections from all files */
    }

    RODATA_START = .;
    .rodata ALIGN (0x1000) : /* align at 4 KB */
    {
        *(.rodata*)          /* all read-only data sections from all files */
    }

    DATA_START = .;
    .data ALIGN (0x1000) :   /* align at 4 KB */
    {
        *(.data)             /* all data sections from all files */
    }

    BSS_START = .;
    .bss ALIGN (0x1000) :    /* align at 4 KB */
    {
        *(COMMON)            /* all COMMON sections from all files */
        *(.bss)              /* all bss sections from all files */
    }

    _kernel_end = .;
}
