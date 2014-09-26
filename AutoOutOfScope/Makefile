vpath %.cpp      src
vpath %.h        include
vpath %.hpp      include

CPP = g++
OPTIONS = -s
INCLUDES = -I include 
CFLAGS = -Wall -pedantic -std=c++11 ${MAKE_OPTIONS} ${OPTIONS}
LFLAGS = ${LIBS} ${OPTIONS}

default: rebuild
rebuild: clean build

clean:
	rm -vf *.o Main

build: Main
Main: Main.o
	${CPP} -o $@ $^ ${LFLAGS} 
Main.o: Main.cpp AutoOutOfScope.hpp
	${CPP} -c -o $@ $< ${CFLAGS} ${INCLUDES}
