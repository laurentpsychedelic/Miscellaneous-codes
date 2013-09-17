set terminal png
set output "NEPlane-mercator_detail2.png"
set title "North-East plane (Mercator projection)"
set title ""
set key on
set border
set yzeroaxis
set xtics
set ytics
set xrange [0:360]
set yrange [89.99999:90]
plot 'world.dat' with lines lt 2 , 'NEPlane_detail2.dat' with lines lt 3