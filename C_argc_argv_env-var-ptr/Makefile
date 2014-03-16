OBJS = ShowEnv.o
CC = gcc
OPTIONS = "-s"
CFLAGS = -Wall
LFLAGS = ${OPTIONS}
INCLUDES = 
LIBS = 

default: run

run: rebuild
	./ShowEnv

rebuild: clean build

clean:
	rm -vf ./*.o
	rm -vf ./ShowEnv

build: ShowEnv.o
	$(CC) -o ShowEnv $(OBJS) $(LIBS) $(LFLAGS)

ShowEnv.o:
	$(CC) -c -o ShowEnv.o ShowEnv.c $(CFLAGS) $(INCLUDES)
