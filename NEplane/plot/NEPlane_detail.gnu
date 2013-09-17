set terminal png
set output "NEPlane_detail.png"
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
set urange [89.9:90]
set vrange [0:360]
set xrange [-0.001:0.001]
set yrange [-0.001:0.001]
set zrange [0.999995:1]
splot cos(u)*cos(v),cos(u)*sin(v),sin(u) with lines lc rgb "cyan" , 'world.dat' with lines lt 2 , 'NEPlane_detail.dat' with lines lt 3