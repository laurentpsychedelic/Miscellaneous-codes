set terminal postscript eps color enhanced "Helvetica" 20
set output "decay.eps"
set title "Exponential decay"
m0=100000.0;r0=10000.0;l=0.1
m(x) = m0 * exp ( -l * x )
r(x) = r0 * exp ( -l * x )
#fit m(x) 'decay.dat' using 1:2 via m0, l
plot "decay.dat" using 1:2 title 'Number of remaining particles' with points lc rgb "black", \
     m(x) with lines lc rgb "black", \
     "decay.dat" using 1:3 title "Differential ({/Symbol \265}radiations)" with points lc rgb "red", \
     r(x) with lines lc rgb "red"