# @megstechcorner.com
# All rights reserved.

CC = gcc

WARNINGS = -Wall -W -Wstrict-prototypes -Wmissing-prototypes -Wsystem-headers
CFLAGS = -g -msoft-float -O -fno-stack-protector
CPPFLAGS = -nostdinc -I. -Ilib -Ilib/kernel 
ASFLAGS = -Wa,--gstabs
LDFLAGS = -T link.ld -melf_i386
DEPS = -MMD -MF $(@:.o=.d)

all: kernel.elf

# Kernel code
kernel_SRC = start.S

SUBDIRS = kernel
SOURCES = $(foreach dir,$(SUBDIRS),$($(dir)_SRC))
OBJECTS = $(patsubst %.c,%.o,$(patsubst %.S,%.o,$(SOURCES)))
DEPENDS = $(patsubst %.o,%.d,$(OBJECTS))

%.o: %.c
	$(CC) -m32 -c $< -o $@ $(CFLAGS) $(CPPFLAGS) $(WARNINGS) $(DEFINES) $(DEPS)

%.o: %.S
	$(CC) -m32 -c $< -o $@ $(ASFLAGS) $(CPPFLAGS) $(DEFINES) $(DEPS)

kernel.elf: $(OBJECTS)
	ld $(LDFLAGS) $(OBJECTS) -o kernel.elf

os: kernel.elf
	mkdir -p iso/boot/grub
	cp kernel.elf iso/boot/kernel.elf
	cp stage2_eltorito iso/boot/grub/
	cp menu.lst iso/boot/grub
	genisoimage -R                              \
				-b boot/grub/stage2_eltorito    \
				-no-emul-boot                   \
				-boot-load-size 4               \
				-A os                           \
				-input-charset utf8             \
				-quiet                          \
				-boot-info-table                \
				-o os.iso                       \
				iso

clean:
	rm -f $(OBJECTS) $(DEPENDS) 
	rm kernel.elf
	rm -rf iso
	rm os.iso
