vpath %.cpp      src
vpath %.h        include

CPP = g++
OPTIONS = -s
INCLUDES = -I include 
CFLAGS = -Wall -pedantic ${MAKE_OPTIONS} ${OPTIONS}
LFLAGS = ${LIBS} ${OPTIONS}

Main.exe: Main.o

%.exe: %.o
	${CPP} -o $@ $^ ${LFLAGS} 
%.o: %.cpp
	${CPP} -c -o $@ $< ${CFLAGS} ${INCLUDES}
