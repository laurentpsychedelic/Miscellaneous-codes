[ [ Math.PI/4, Math.PI/10000 ], [ Math.PI/4, Math.PI/1000000, 498.591563012*Math.PI/180, 89.9736810518*Math.PI/180, 'plot/NEPlane_detail.dat' ], [ Math.PI/4, Math.PI/1000000000, 86227255904*Math.PI/180, 89.9999005712*Math.PI/180, 'plot/NEPlane_detail2.dat' ] ].each { args -> { direction, step_phi, start_theta = 0, start_phi = 0, filename = 'plot/NEPlane.dat' -> new File(filename).withWriter { out -> def theta = start_theta; start_phi.toBigDecimal().step((Math.PI/2).toBigDecimal(), step_phi.toBigDecimal()) { phi -> theta += step_phi * Math.cos(direction) / Math.cos(phi); out.writeLine("${theta*180/Math.PI}\t${phi*180/Math.PI}") } } }.call(args) }

/*[ [ Math.PI/4, Math.PI/10000 ],
  [ Math.PI/4, Math.PI/1000000, 498.591563012*Math.PI/180, 89.9736810518*Math.PI/180, 'plot/NEPlane_detail.dat' ],
  [ Math.PI/4, Math.PI/1000000000, 86227255904*Math.PI/180, 89.9999005712*Math.PI/180, 'plot/NEPlane_detail2.dat' ]
].each { args ->
    { direction, step_phi, start_theta = 0, start_phi = 0, filename = 'plot/NEPlane.dat' ->
        new File(filename).withWriter { out ->
            def theta = start_theta
            start_phi.toBigDecimal().step((Math.PI/2).toBigDecimal(), step_phi.toBigDecimal()) { phi ->
                theta += step_phi * Math.cos(direction) / Math.cos(phi)
                out.writeLine("${theta*180/Math.PI}\t${phi*180/Math.PI}")
            }
        }
    }.call(args) }*/