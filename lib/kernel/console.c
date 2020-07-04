#include <console.h>
#include <stdarg.h>
#include <stdio.h>

#include "devices/vga.h"

static void vprintf_helper (char, void *);

/* The standard vprintf() function,
   which is like printf() but uses a va_list.
   Writes its output to both vga display and serial port. */
int
vprintf (const char *format, va_list args) 
{
  int char_cnt = 0;
  __vprintf (format, args, vprintf_helper, &char_cnt);
  return char_cnt;
}

/* Writes string S to the console, followed by a new-line
   character. */
int
puts (const char *s) 
{
  while (*s != '\0')
    putchar(*s++);
  putchar('\n');

  return 0;
}

/* Writes the N characters in BUFFER to the console. */
void
putbuf (const char *buffer, size_t n) 
{
  while (n-- > 0)
    putchar(*buffer++);
}

/* Writes C to the vga display and serial port. */
int
putchar (int c) 
{
  vga_putc (c);  
  return c;
}

/* Helper function for vprintf(). */
static void
vprintf_helper (char c, void *char_cnt_) 
{
  int *char_cnt = char_cnt_;
  (*char_cnt)++;
  putchar(c);
}
