vpath %.cpp      src
vpath %.h        include

CPP = g++
OPTIONS = -s
CFLAGS = -Wall $(MAKE_OPTIONS) $(OPTIONS)
LFLAGS = $(OPTIONS)
INCLUDE_LIBS = -I lib
INCLUDES = -I include $(INCLUDE_LIBS)

Main.exe: Main.o lib/jsmn/jsmn.o
Main.o: Main.cpp ITrustedVariable.hpp

%.exe: %.o
	$(CPP) -o $@ $^ $(LFLAGS)
%.hpp:
	
%.o: %.cpp
	$(CPP) -c -o $@ $< $(CFLAGS) $(INCLUDES)
