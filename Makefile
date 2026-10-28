#
# Makefile
#
CMINI = libcmini/lib

CFLAGS  = -Wall -O -fomit-frame-pointer -DATARI -Wno-unused-variable -Wno-unused-value -Wno-parentheses
LDFLAGS = -s -nostdlib $(CMINI)/crt0.o
LDLIBS  = -L$(CMINI) -lcmini -lgcc -lcmini -lldg -lcmini

TARGET = dosfs.ldg

# list header files here
HEADER = dosfs.h

# list C files here
#
COBJS = dosfs.c main.c
#
# list assembler files here
SOBJS =

SRCFILES = $(HEADER) $(COBJS) $(SOBJS)

#############################
CROSSPREFIX=/opt/cross-mint/bin/m68k-atari-mint-
PREFIX=/opt/cross-mint
PATH = $(PREFIX)/m68k-atari-mint/bin:$(PREFIX)/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
LD_LIBRARY_PATH=$(PREFIX)/lib:$(PREFIX)/m68k-atari-mint/lib:$LD_LIBRARY_PATH

CC = $(CROSSPREFIX)gcc
AS = $(CC)
AR = $(CROSSPREFIX)ar
RANLIB = $(CROSSPREFIX)ranlib
STRIP = $(CROSSPREFIX)strip
FLAGS = $(CROSSPREFIX)flags
STACK = $(CROSSPREFIX)stack

OBJS = $(COBJS:.c=.o)

all: $(TARGET)
	$(STRIP) ./build/68000/$(TARGET)
	-@rm -f ./build/68000/*.o
	$(STRIP) ./build/68020/$(TARGET)
	-@rm -f ./build/68020/*.o
	$(STRIP) ./build/ColdFire/$(TARGET)
	-@rm -f ./build/ColdFire/*.o
	@echo All done

clean:
	-@rm -f ./build/68000/*.o
	-@rm -f ./build/68000/$(TARGET)
	-@rm -f ./build/68020/*.o
	-@rm -f ./build/68020/$(TARGET)
	-@rm -f ./build/ColdFire/*.o
	-@rm -f ./build/ColdFire/$(TARGET)
	@echo Cleaned

new: clean
	-@rm -f ./build/68000/$(TARGET)
	-@rm -f ./build/68020/$(TARGET)
	-@rm -f ./build/ColdFire/$(TARGET)
	$(MAKE) all


.SUFFIXES:
.SUFFIXES: .c .S .o

.c.o:
	$(CC) $(CFLAGS) -m68000 -c $*.c -o ./build/68000/$*.o
	$(CC) $(CFLAGS) -m68020-60 -c $*.c -o ./build/68020/$*.o
	$(CC) $(CFLAGS) -mcpu=5475 -c $*.c -o ./build/ColdFire/$*.o

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) ./build/68000/*.o -o ./build/68000/$(TARGET) -m68000 $(LDLIBS)
	$(CC) $(LDFLAGS) ./build/68020/*.o -o ./build/68020/$(TARGET) -m68020-60 $(LDLIBS)
	$(CC) $(LDFLAGS) ./build/ColdFire/*.o -o ./build/ColdFire/$(TARGET) -mcpu=5475 $(LDLIBS)

