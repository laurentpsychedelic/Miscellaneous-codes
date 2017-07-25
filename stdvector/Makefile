vpath %.c        src
vpath %.cpp      src
vpath %.h        include
vpath %.hpp      include

CC = gcc
CPP = g++
OPTIONS = -s
INCLUDES = -I include 
CFLAGS = -Wall -pedantic -std=c++11 -D MAIN_EXPORTS ${MAKE_OPTIONS} ${OPTIONS}
LIBS = 
LFLAGS = -Wl,--subsystem,windows -static-libgcc -static-libstdc++ ${LIBS} ${OPTIONS}

default: rebuild

run: rebuild
	./Main.exe

rebuild: clean build
clean:
	rm -vf *.o Main.exe

build: Main.exe

Main.exe: Main.o
	${CPP} -o $@ $^ ${LFLAGS} 
Main.o: Main.cpp
	${CPP} -c -o $@ $< ${CFLAGS} ${INCLUDES}
