vpath %.cpp      src
vpath %.h        include

CC  = gcc
CPP = g++
OPTIONS = -s
CFLAGS = -Wall -pedantic $(MAKE_OPTIONS) $(OPTIONS)
LFLAGS = $(OPTIONS)
INCLUDES = -I include

Main.exe: Main.o
Main.o: Main.cpp ITrustedVariable.hpp

%.exe: %.o
	$(CPP) -o $@ $^ $(LFLAGS)
%.hpp:
	

%.o: %.cpp
	$(CPP) -c -o $@ $< $(CFLAGS) $(INCLUDES)
