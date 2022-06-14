DEFSNG a-z
pi = 3.141593
r = 100
a1 = -pi/2
a2 = -pi/2
h=0.001
m=1000
g=1000
sw = 640
sh = 480
 
DIM p1 AS LONG
p1 = _NEWIMAGE(sw,sh,12)
SCREEN _NEWIMAGE(sw,sh,12)
 
DO
        a1p = (6/(m*r^2))*(2*m*v1-3*COS(a1-a2)*m*v2)/(16-9*(COS(a1-a2))^2)
        a1k1 = a1p
        a1k2 = a1p + h*a1k1/2
        a1k3 = a1p + h*a1k2/2
        a1k4 = a1p + h*a1k3
        a2p = (6/(m*r^2))*(8*m*v2-3*COS(a1-a2)*m*v1)/(16-9*(COS(a1-a2))^2)
        a2k1 = a2p
        a2k2 = a2p + h*a2k1/2
        a2k3 = a2p + h*a2k2/2
        a2k4 = a2p + h*a2k3
        na1=a1+h*(a1k1+2*a1k2+2*a1k3+a1k4)/6
        na2=a2+h*(a2k1+2*a2k2+2*a2k3+a2k4)/6
        v1p = -0.5*r^2*(a1p*a2p*SIN(a1-a2)+3*g*SIN(a1)/r)
        v1k1 = v1p
        v1k2 = v1p + h*v1k1/2
        v1k3 = v1p + h*v1k2/2
        v1k4 = v1p + h*v1k3
        v2p = -0.5*r^2*(-a1p*a2p*SIN(a1-a2)+g*SIN(a2)/r)
        v2k1 = v2p
        v2k2 = v2p + h*v2k1/2
        v2k3 = v2p + h*v2k2/2
        v2k4 = v2p + h*v2k3
        nv1=v1+h*(v1k1+2*v1k2+2*v1k3+v1k4)/6
        nv2=v2+h*(v2k1+2*v2k2+2*v2k3+v2k4)/6
        a1=na1
        a2=na2
        v1=nv1
        v2=nv2
 
        _DEST p1
        PSET (sw/2+r*COS(a1-pi/2)+r*COS(a2-pi/2), sh/2-r*SIN(a1-pi/2)-r*SIN(a2-pi/2)),12
        _DEST 0
        _PUTIMAGE, p1
 
        LINE (sw/2, sh/2)-STEP(r*COS(a1-pi/2), -r*SIN(a1-pi/2))
        CIRCLE STEP(0,0),5
        LINE -STEP(r*COS(a2-pi/2), -r*SIN(a2-pi/2))
        CIRCLE STEP(0,0),5
 
        _LIMIT 300
        _DISPLAY
LOOP UNTIL _KEYHIT=27
SYSTEM
