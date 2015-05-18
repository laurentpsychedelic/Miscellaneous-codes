vpath %.c        src
vpath %.cpp      src
vpath %.h        include
vpath %.hpp      include

UNICODE=true

CC = gcc
CPP = g++
OPTIONS = -s
INCLUDES = -I include 
CFLAGS = -Wall -pedantic -D MESSAGESENDER_EXPORTS ${MAKE_OPTIONS} ${OPTIONS}
LIBS = 
LFLAGS = -Wl,--subsystem,windows -static-libgcc -static-libstdc++ ${LIBS} ${OPTIONS}

default: rebuild


PHONY: check_init_parameters
check_init_parameters:
ifneq ($(UNICODE),)
	$(eval CFLAGS=${CFLAGS} -D_UNICODE -DUNICODE)
	$(eval LFLAGS=-municode ${LFLAGS})
endif
-include check_init_parameters

rebuild: clean build
clean:
	rm -vf *.o MessageSender.exe

build: MessageSender.exe
MessageSender.exe: MessageSender.o
	${CPP} -o $@ $^ ${LFLAGS}
MessageSender.o: Main.cpp
	${CPP} -c -o $@ $< ${CFLAGS} ${INCLUDES}
