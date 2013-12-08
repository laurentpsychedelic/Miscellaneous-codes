.PHONY: run
default: show

rebuild: clean
	ghc decay.hs

clean:
	rm -vf decay
	rm -vf decay.hi
	rm -vf decay.o

run:
	./decay

plot:
	gnuplot decay.gnu

show: rebuild run plot
	gnome-open decay.eps
