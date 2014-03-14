WINDRES = i686-w64-mingw32-windres
OBJS = bootstrapper.o
CC = i686-w64-mingw32-g++
OPTIONS = "-s"
CFLAGS = -Wall
LFLAGS = ${OPTIONS}
INCLUDES = 
LIBS = 

default: run

run: rebuild

rebuild: clean build

clean:
	rm -vf *.o

build: resources bootstrapper.o
	$(CC) -o bootstrapper.exe $(OBJS) res.bin $(LIBS) $(LFLAGS) 

resources:
	$(WINDRES) res/resources.rc -o res.bin

bootstrapper.o:
	$(CC) -c -o bootstrapper.o Bootstrap.cpp $(CFLAGS) $(INCLUDES)
