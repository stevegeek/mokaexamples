# This Makefile assumes you have GNU gcc 2.3 or better and a suitable
# runtime library with object support.  It also works on a NeXT.
# Don't know about Stepstone.

.SUFFIXES: .o .m
.m.o:
	$(CC) -c $(CFLAGS) $<

# Use this on a NeXT
#CC=		cc
#LIBS=
# Use this with GNU CC on a non-NeXT,
# and avoid the GCC moaning on using #import.
CC=		gcc -Wno-import
LIBS=		-lobjc
LDFLAGS=	-L/usr/local/lib -L/usr/gnu/lib

CFLAGS=		-Wall -g
OFILES=		main.o Node.o Queue.o Stack.o Float.o Char.o

demo: $(OFILES)
	$(CC) $(CFLAGS) $(LDFLAGS) -o demo $(OFILES) $(LIBS)

clean:
	rm -f $(OFILES) demo

Char.o : Char.m Char.h

Float.o : Float.m Float.h

Node.o : Node.m Node.h

Queue.o : Queue.m Queue.h Node.h

Stack.o : Stack.m Stack.h Node.h

main.o : main.m Queue.h Node.h Stack.h Float.h
