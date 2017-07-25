vpath %.c        src
vpath %.cpp      src
vpath %.h        include
vpath %.hpp      include

CPP = g++
OPTIONS = -s
INCLUDES = -I include 
CFLAGS = -Wall -pedantic -D MAIN_EXPORTS ${MAKE_OPTIONS} ${OPTIONS}
LIBS = -lws2_32 -luserenv
LFLAGS = ../staticlib/target/i686-pc-windows-gnu/release/staticlib.lib ${LIBS} ${OPTIONS}
# Compile with dwarf-2 stack unwinding GCC!!

default: rebuild


rebuild: clean build
clean:
	rm -vf *.o Main.exe

build: Main.exe
Main.exe: Main.o
	${CPP} -o $@ $^ ${LFLAGS} 
Main.o: Main.cpp
	${CPP} -c -o $@ $< ${CFLAGS} ${INCLUDES}
