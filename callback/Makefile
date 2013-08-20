OBJS = callback.o
CC = g++
OPTIONS = "-s"
CFLAGS = -Wall -pedantic ${MAKE_OPTIONS} ${OPTIONS}
LFLAGS = ${OPTIONS}
INCLUDES = 
LIBS = 

default: rebuild

rebuild: clean callback

run:
	./callback

clean:
	rm -vf *o
	rm -vf callback

callback: callback.o
	$(CC) -o callback $(OBJS) $(LIBS) $(LFLAGS) 

callback.o:
	$(CC) -c -o callback.o callback.cpp $(CFLAGS) $(INCLUDES)
