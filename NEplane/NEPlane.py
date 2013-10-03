from numpy import arange, allclose
from math import pi, sin, cos, sqrt

def geographicToCartesian(theta, phi):
    return [ cos(phi) * cos(theta), cos(phi) * sin(theta), sin(phi) ]

def distance(theta1, phi1, theta2, phi2):
    p1 = geographicToCartesian(theta1, phi1)
    p2 = geographicToCartesian(theta2, phi2)
    return sqrt((p2[0]-p1[0])**2 + (p2[1]-p1[1])**2 + (p2[2]-p1[2])**2)

def NEPlane(direction, step, start_theta = 0, start_phi = 0, filename = 'plot/NEPlane.dat'):
    initFile(filename)
    D = 0
    theta = start_theta
    old_phi = start_phi
    old_theta = theta
    for phi in arange(start_phi, pi/2, step * sin(direction)):        
        theta = theta + step * cos(direction) / cos(phi)
        D = D + distance(old_theta, old_phi, theta, phi)
        if theta >= 2*pi:
            theta = theta - 2*pi
        old_phi = phi
        old_theta = theta
        appendResultToFile(filename, theta*180/pi, phi*180/pi)
        print("(" + str(phi*180/pi) + "," + str(theta*180/pi) + ") D=" + str(D))
    return D

def initFile(filename):
    f = open(filename, 'w')
    f.close()
def appendResultToFile(filename, theta, phi):
    f = open(filename, 'a')
    f.write(str(theta) + '\t' + str(phi) + '\n')

if __name__ == '__main__':
    D = NEPlane(pi/4, pi/10000)
    assert allclose(D, pi/2 / sin(pi/4), atol = 0.01), "Distance calculated different from predicted! " + str(D) + "!=" + str(pi/2 / sin(pi/4))
    NEPlane(pi/4, pi/1000000, start_theta = 498.591563012*pi/180, start_phi = 89.9736810518*pi/180, filename = 'plot/NEPlane_detail.dat')
    NEPlane(pi/4, pi/1000000000, start_theta = 862.027255904*pi/180, start_phi = 89.9999005712*pi/180, filename = 'plot/NEPlane_detail2.dat')









