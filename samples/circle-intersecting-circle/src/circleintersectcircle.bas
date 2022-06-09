SCREEN 12

C1x = -100
C1y = 50
C2x = 100
C2y = 100
r1 = 150
r2 = 100

DO
    DO WHILE _MOUSEINPUT
        IF _MOUSEBUTTON(1) THEN
            C2x = _MOUSEX - 320
            C2y = 240 - _MOUSEY
        END IF
        IF _MOUSEBUTTON(2) THEN
            C1x = _MOUSEX - 320
            C1y = 240 - _MOUSEY
        END IF
    LOOP

    CLS
    CIRCLE (320 + C1x, C1y * -1 + 240), r1, 8
    CIRCLE (320 + C2x, C2y * -1 + 240), r2, 7

    ''' Toggle between the two functions here.
    CALL IntersectTwoCircles(C1x, C1y, r1, C2x, C2y, r2, i1x, i1y, i2x, i2y)
    'CALL intersect2circs(C1x, C1y, r1, C2x, C2y, r2, i1x, i1y, i2x, i2y)
    '''
    LOCATE 1, 1: PRINT i1x, i1y, i2x, i2y

    IF (i1x OR i1y OR i2x OR i2y) THEN
        CIRCLE (320 + i1x, i1y * -1 + 240), 3, 14
        CIRCLE (320 + i2x, i2y * -1 + 240), 3, 15
    END IF

    _DISPLAY
    _LIMIT 30
LOOP

SUB IntersectTwoCircles (c1x, c1y, r1, c2x, c2y, r2, i1x, i1y, i2x, i2y)
    i1x = 0: i1y = 0: i2x = 0: i2y = 0
    Dx = c1x - c2x
    Dy = c1y - c2y
    D2 = Dx ^ 2 + Dy ^ 2
    IF (D2 ^ .5 < (r1 + r2)) THEN
        F = (-D2 + r2 ^ 2 - r1 ^ 2) / (2 * r1)
        a = Dx / F
        b = Dy / F
        g = a ^ 2 + b ^ 2
        IF (g > 1) THEN
            h = SQR(g - 1)
            i1x = c1x + r1 * (a + b * h) / g
            i1y = c1y + r1 * (b - a * h) / g
            i2x = c1x + r1 * (a - b * h) / g
            i2y = c1y + r1 * (b + a * h) / g
        END IF
    END IF
END SUB

SUB intersect2circs (c1x, c1y, r1, c2x, c2y, r2, i1x, i1y, i2x, i2y)
    d = ((c1x - c2x) ^ 2 + (c1y - c2y) ^ 2) ^ .5
    alpha = _ACOS((r1 ^ 2 + d ^ 2 - r2 ^ 2) / (2 * r1 * d))
    x1 = r1 * COS(alpha)
    l = r1 * SIN(alpha)
    angle = _ATAN2(c2y - c1y, c2x - c1x)
    p3x = c1x + x1 * COS(angle)
    p3y = c1y + x1 * SIN(angle)
    i1x = p3x + l * COS(angle - _PI / 2)
    i1y = p3y + l * SIN(angle - _PI / 2)
    i2x = p3x + l * COS(angle + _PI / 2)
    i2y = p3y + l * SIN(angle + _PI / 2)
END SUB


