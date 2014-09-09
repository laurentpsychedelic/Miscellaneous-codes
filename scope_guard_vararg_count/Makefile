vpath %.cpp      src
vpath %.hpp      include

CPP = g++
OPTIONS = -s
INCLUDES = -I include 
CFLAGS = -Wall -fpermissive -pedantic -std=c++11 ${MAKE_OPTIONS} ${OPTIONS}
LFLAGS = ${LIBS} ${OPTIONS}

Main.exe: Main.o
Main.cpp: ScopeGuard.hpp

clean:
	rm -vf *.o Main.exe

%.exe: %.o
	${CPP} -o $@ $^ ${LFLAGS} 
%.dll: %.o
	${CPP} -o $@ $^ ${LFLAGS} 
%.o: %.cpp
	${CPP} -c -o $@ $< ${CFLAGS} ${INCLUDES}
