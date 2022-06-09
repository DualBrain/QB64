'public domain
'uses qb64's 2d prototype
DEFDBL A-Z
SCREEN _NEWIMAGE(640, 480, 32)
DIM R(15) AS INTEGER, G(15) AS INTEGER, B(15) AS INTEGER
FOR i = 0 TO 15: READ R(i): NEXT
FOR i = 0 TO 15: READ G(i): NEXT
FOR i = 0 TO 15: READ B(i): NEXT
DATA 0,63,63,63,63,63,31,0,0,31,31,31,47,63,63,63
DATA 0,0,15,31,47,63,63,63,63,31,15,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,31,63,63,63,63,63,42,21

real = -2.2: imag = -1.2
incr = 0.005
FOR y = 0 TO 479
    r = real
    FOR x = 0 TO 639
        colour = (64 - mandel(r, imag, 64)) MOD 16
        colour = _RGB32(R(colour) * 4, G(colour) * 4, B(colour) * 4)
        PSET (x, y), colour
        r = r + incr
    NEXT
    imag = imag + incr
NEXT
SLEEP
SYSTEM

FUNCTION mandel% (ox, oy, limit)
    x = ox: y = oy
    FOR c% = limit TO 1 STEP -1
        xx = x * x: yy = y * y
        IF xx + yy >= 4 THEN EXIT FOR
        y = x * y * 2 + oy
        x = xx - yy + ox
    NEXT
    mandel = c%
END FUNCTION

