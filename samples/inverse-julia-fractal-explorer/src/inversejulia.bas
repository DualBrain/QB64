DEFSNG A-Z

DIM SHARED px, py, cx, cy

SCREEN _NEWIMAGE(1024, 768, 256)

COLOR 255
FOR i% = 0 TO 255
    r% = INT((i% / 255) ^ .9323335 * 255)
    g% = INT((i% / 255) ^ 1.576838 * 255)
    b% = INT((i% / 255) ^ 3.484859 * 255)
    _PALETTECOLOR i%, _RGB32(r%, g%, b%)
NEXT

'####################################################################################################################

setSeed _MOUSEX, _MOUSEY

DO
    IF _MOUSEINPUT THEN
        n% = 0
        _DISPLAY
        CLS
        setSeed _MOUSEX, _MOUSEY
    END IF

    DO 'Marsaglia polar method for random gaussian
        u = RND * 2 - 1
        v = RND2 * 2 - 1
        s = u * u + v * v
    LOOP WHILE s >= 1 OR s = 0
    s = SQR(-2 * LOG(s) / s) * 0.5
    u = u * s * 2
    v = v * s * 2

    calcInverseJulia u, v, 1

    n% = n% + 1
    IF n% = 300 THEN
        n% = 0
        _DISPLAY
    END IF
LOOP

'####################################################################################################################

SUB setSeed (x, y)
    cx = (x / _WIDTH - 0.5) * 4
    cy = (0.5 - y / _HEIGHT) * 3
END SUB

'####################################################################################################################

SUB calcInverseJulia (x, y, depth%)
    re = x - cx
    im = y - cy

    a = SQR(re * re + im * im)
    x = SQR((a + re) * 0.5)
    IF im < 0 THEN y = -SQR((a - re) * 0.5) ELSE y = SQR((a - re) * 0.5)

    PSET2 (x / 4 + 0.5) * _WIDTH, (0.5 - y / 3) * _HEIGHT, 0.02
    PSET2 (x / -4 + 0.5) * _WIDTH, (0.5 + y / 3) * _HEIGHT, 0.02
    IF depth% < 32 THEN
        IF RND < 0.5 THEN calcInverseJulia x, y, depth% + 1 ELSE calcInverseJulia -x, -y, depth% + 1
    END IF
END SUB

'####################################################################################################################

SUB PSET2 (x, y, i)
    x% = INT(x)
    y% = INT(y)
    dx = x - x%
    dy = y - y%

    q3 = dx * dy
    q2 = (1 - dx) * dy
    q1 = dx * (1 - dy)
    q0 = (1 - dx) * (1 - dy)

    PSET (x%, y%), (1 - (1 - q0 * i) * (1 - POINT(x%, y%) / 255)) * 255
    PSET (x% + 1, y%), (1 - (1 - q1 * i) * (1 - POINT(x% + 1, y%) / 255)) * 255
    PSET (x%, y% + 1), (1 - (1 - q2 * i) * (1 - POINT(x%, y% + 1) / 255)) * 255
    PSET (x% + 1, y% + 1), (1 - (1 - q3 * i) * (1 - POINT(x% + 1, y% + 1) / 255)) * 255
END SUB

'####################################################################################################################

FUNCTION RND2 STATIC
    seed&& = (25214903917&& * seed&& + 11&&) MOD 281474976710656&&
    RND2 = seed&& / 281474976710656&&
END FUNCTION

