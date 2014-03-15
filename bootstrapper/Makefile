WINDRES = windres
OBJS = bootstrapper.o
CC = g++
OPTIONS = "-s"
CFLAGS = -Wall
LFLAGS = -mwindows ${OPTIONS}
INCLUDES = 
LIBS = 

default: run

run: rebuild
	./bootstrapper.exe arg1 arg2 "long arg with spaces"

rebuild: clean build

clean:
	rm -vf *.o

build: resources bootstrapper.o
	$(CC) -o bootstrapper.exe $(OBJS) res.bin $(LIBS) $(LFLAGS) 

resources:
	$(WINDRES) res/resources.rc -o res.bin

bootstrapper.o:
	$(CC) -c -o bootstrapper.o Bootstrap.cpp $(CFLAGS) $(INCLUDES)
