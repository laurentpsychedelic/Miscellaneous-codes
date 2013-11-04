OBJS = time.o
CC = g++
OPTIONS = "-s"
CFLAGS = -Wall
LFLAGS = ${OPTIONS}
INCLUDES = 
LIBS = 

default: rebuild

rebuild: clean time

clean:
	rm -vf *o
	rm -vf time

time: time.o
	$(CC) -o time $(OBJS) $(LIBS) $(LFLAGS) 

time.o:
	$(CC) -c -o time.o time.cpp $(CFLAGS) $(INCLUDES)

run: time
	./time
