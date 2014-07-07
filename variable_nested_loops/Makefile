vpath %.c        src
vpath %.cpp      src
vpath test_%.cpp test
vpath %.h        include

CPP = gcc
CPP = g++
OPTIONS = -s
INCLUDES = -I include 
CFLAGS = -Wall -pedantic ${MAKE_OPTIONS} ${OPTIONS}
LFLAGS = ${LIBS} ${OPTIONS}

Main.exe: Main.o

%.exe: %.o
	${CPP} -o $@ $^ ${LFLAGS} 
%.dll: %.o
	${CPP} -o $@ $^ ${LFLAGS} 
%.o: %.cpp
	${CPP} -c -o $@ $< ${CFLAGS} ${INCLUDES}
