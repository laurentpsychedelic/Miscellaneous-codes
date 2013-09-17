set terminal png
set output "NEPlane.png"
set border
set yzeroaxis
set xtics
set ytics
set angles degrees
set title "North-East plane (spherical plot)"
set ticslevel 0
set view 40,70,0.8,1.2
set mapping spherical
set parametric
set samples 32
set isosamples 9
set urange [0:90]
set vrange [0:360]
set zrange [0:1]
splot cos(u)*cos(v),cos(u)*sin(v),sin(u) with lines lc rgb "cyan" , 'world.dat' with lines lt 2 , 'NEPlane.dat' with lines lt 3