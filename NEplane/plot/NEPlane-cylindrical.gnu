set terminal png
set output "NEPlane-cylindrical.png"
set title "North-East plane (cylindrical plot)"
set ticslevel 0.0
set angles degrees
set view 40,70,0.8,1.2
set mapping cylindrical
set parametric
set samples 32
set isosamples 13
set urange [-180:180]
set vrange [0:90]
set zrange [0:90]
splot cos(u),sin(u),v with lines lc rgb "cyan" , 'world.dat' with lines lt 2 , 'NEPlane.dat' with lines lc rgb "blue" lt 3