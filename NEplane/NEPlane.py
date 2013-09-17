from numpy import arange
from math import pi
from math import sin
from math import cos

def NEPlane(direction, step, start_theta = 0, start_phi = 0, filename = 'plot/NEPlane.dat'):
    theta = start_theta
    for phi in arange(start_phi, pi/2, step * sin(direction)):
        theta = theta + step * cos(direction) / cos(phi)
        if theta >= 2*pi:
            theta = theta - 2*pi
        writeResult(filename, theta*180/pi, phi*180/pi)
        print("(" + str(phi*180/pi) + "," + str(theta*180/pi) + ")")

def writeResult(filename, theta, phi):
    f = open(filename, 'a')
    f.write(str(theta) + '\t' + str(phi) + '\n')

if __name__ == '__main__':
    NEPlane(pi/4, pi/10000)
    NEPlane(pi/4, pi/1000000, start_theta = 498.591563012*pi/180, start_phi = 89.9736810518*pi/180, filename = 'plot/NEPlane_detail.dat')
    NEPlane(pi/4, pi/1000000000, start_theta = 862.027255904*pi/180, start_phi = 89.9999005712*pi/180, filename = 'plot/NEPlane_detail2.dat')









