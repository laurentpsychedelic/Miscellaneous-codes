CC = g++
OPTIONS = "-g"
CFLAGS = -Wall -pedantic ${MAKE_OPTIONS} ${OPTIONS}
LFLAGS = 

default: rebuild

test_leak: rebuild
	valgrind --leak-check=full ./main > valgrind_report 2>&1

rebuild: clean build

clean:
	rm -vf main.o
	rm -vf main

build: main.o
	$(CC) -o main main.o $(LFLAGS)

main.o:
	$(CC) -c -o main.o main.cpp $(CFLAGS)
