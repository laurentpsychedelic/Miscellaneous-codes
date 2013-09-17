set terminal png
set output "NEPlane-mercator.png"
set title "North-East plane (Mercator projection)"
set title ""
set key on
set border
set yzeroaxis
set xtics
set ytics
set xrange [0:360]
set yrange [0:90]
plot 'world.dat' with lines lt 2 , 'NEPlane.dat' with lines lt 3