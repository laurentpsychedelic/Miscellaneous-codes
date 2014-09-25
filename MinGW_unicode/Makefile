vpath %.c        src
vpath %.cpp      src
vpath %.h        include

CPP = g++ #"$(shell cygpath -u "C:/Program Files/mingw-w64/i686-4.9.1-win32-dwarf-rt_v3-rev1/mingw32/bin/g++.exe")"
OPTIONS = -s
INCLUDES = -I include 
CFLAGS = -Wall -pedantic ${MAKE_OPTIONS} ${OPTIONS}
LFLAGS = -Wl,--subsystem,windows -static-libgcc -static-libstdc++ ${LIBS} ${OPTIONS}

.PHONY: check_init_parameters
check_init_parameters:
# Check if GCC is MinGW-w64 (with Unicode support) version (not cygwin)
ifneq ($(shell $(CPP) -dumpmachine 2>&1 | sed 's/[\r\n]//g'),i686-w64-mingw32)
	$(error GCC must be of the MinGW flavor with Unicode support [MinGW-w64(32bits)] (gcc -dumpmachine >> i686-w64-mingw32), not Cygwin! (now: "$(shell gcc -dumpmachine | sed 's/[\r\n]//g')"))
else
	$(info GCC flavor OK: $(shell $(CPP) -dumpmachine | sed 's/[\r\n]//g'))
endif

ifneq ($(UNICODE),)
	$(eval CFLAGS=${CFLAGS} -D_UNICODE -DUNICODE)
	$(eval LFLAGS=-municode ${LFLAGS})
	$(info ** Unicode support **)
endif
-include check_init_parameters

default: rebuild
rebuild: clean build
clean:
	rm -vf *.o *.exe

build: Main.exe
Main.exe: Main.o
Main.o: Main.cpp

Main.exe: Main.o
	$(CPP) -o $@ $^ ${LFLAGS} 
Main.o: Main.cpp
	$(CPP) -c -o $@ $< ${CFLAGS} ${INCLUDES}
