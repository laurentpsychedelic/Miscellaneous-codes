vpath %.c        src
vpath %.cpp      src
vpath %.h        include
vpath %.hpp      include

UNICODE=true

CPP = g++
OPTIONS = -s
INCLUDES = -I include 
CFLAGS = -Wall -pedantic -D MESSAGEREADER_EXPORTS ${MAKE_OPTIONS} ${OPTIONS}
LIBS = 
LFLAGS = -shared -Wl,--subsystem,windows -static-libgcc -static-libstdc++ ${LIBS} ${OPTIONS}

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
	rm -vf *.o MessageReader.dll

build: MessageReader.dll
MessageReader.dll: MessageReader.o
	${CPP} -o $@ $^ ${LFLAGS}

MessageReader.o: Main.cpp
	${CPP} -c -o $@ $< ${CFLAGS} ${INCLUDES}
