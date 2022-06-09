SCREEN 12

xorig = 0
yorig = 0

CALL cline(xorig, yorig, xorig + _WIDTH, yorig, 8)
CALL cline(xorig, yorig, xorig + -_WIDTH, yorig, 8)
CALL cline(xorig, yorig, xorig, yorig + _HEIGHT, 8)
CALL cline(xorig, yorig, xorig, yorig - _HEIGHT, 8)

xzoom = 20
yzoom = 20

' Initialize line
b = -2
d = 2
lineang = .1
vx = COS(lineang)
vy = SIN(lineang)
m = vy / vx

' Initialize ellipse
x0 = 2
y0 = -2
ellipsearg = .2
amag = 10
ax = amag * COS(ellipsearg)
ay = amag * SIN(ellipsearg)
bmag = 5
bx = bmag * COS(ellipsearg + 3.14 / 2)
by = bmag * SIN(ellipsearg + 3.14 / 2)

DO

    DO WHILE _MOUSEINPUT
        x = _MOUSEX
        y = _MOUSEY
        IF ((x > 0) AND (x < _WIDTH) AND (y > 0) AND (y < _HEIGHT)) THEN
            IF _MOUSEBUTTON(1) THEN
                x = _MOUSEX
                y = _MOUSEY
                x0 = (x - _WIDTH / 2) / xzoom
                y0 = (-y + _HEIGHT / 2) / yzoom
            END IF
            IF _MOUSEBUTTON(2) THEN
                x = _MOUSEX
                y = _MOUSEY
                d = (x - _WIDTH / 2) / xzoom
                b = (-y + _HEIGHT / 2) / yzoom
            END IF
            IF _MOUSEWHEEL > 0 THEN
                lineang = lineang + .01
                vx = COS(lineang)
                vy = SIN(lineang)
                m = vy / vx
            END IF
            IF _MOUSEWHEEL < 0 THEN
                lineang = lineang - .01
                vx = COS(lineang)
                vy = SIN(lineang)
                m = vy / vx
            END IF
        END IF
    LOOP

    SELECT CASE _KEYHIT
        CASE 18432
            bmag = bmag + .1
            bx = bmag * COS(ellipsearg + 3.14 / 2)
            by = bmag * SIN(ellipsearg + 3.14 / 2)
        CASE 20480
            bmag = bmag - .1
            bx = bmag * COS(ellipsearg + 3.14 / 2)
            by = bmag * SIN(ellipsearg + 3.14 / 2)
        CASE 19200
            ellipsearg = ellipsearg - .1
            ax = amag * COS(ellipsearg)
            ay = amag * SIN(ellipsearg)
            bx = bmag * COS(ellipsearg + 3.14 / 2)
            by = bmag * SIN(ellipsearg + 3.14 / 2)
        CASE 19712
            ellipsearg = ellipsearg + .1
            ax = amag * COS(ellipsearg)
            ay = amag * SIN(ellipsearg)
            bx = bmag * COS(ellipsearg + 3.14 / 2)
            by = bmag * SIN(ellipsearg + 3.14 / 2)
    END SELECT

    ' Intersections
    a2 = ax ^ 2 + ay ^ 2
    b2 = bx ^ 2 + by ^ 2
    av = ax * vx + ay * vy
    bv = bx * vx + by * vy
    rbx = d - x0
    rby = b - y0
    adbr = ax * rbx + ay * rby
    bdbr = bx * rbx + by * rby
    aa = av ^ 2 / a2 ^ 2 + bv ^ 2 / b2 ^ 2
    bb = 2 * (av * adbr / a2 ^ 2 + bv * bdbr / b2 ^ 2)
    cc = adbr ^ 2 / a2 ^ 2 + bdbr ^ 2 / b2 ^ 2 - 1
    arg = bb ^ 2 - 4 * aa * cc
    IF (arg > 0) THEN
        alpha1 = (-bb + SQR(arg)) / (2 * aa)
        alpha2 = (-bb - SQR(arg)) / (2 * aa)
        x1 = alpha1 * vx + d
        x2 = alpha2 * vx + d
        y1 = alpha1 * vy + b
        y2 = alpha2 * vy + b
    ELSE
        x1 = -999
        y1 = -999
        x2 = -999
        y2 = -999
    END IF

    GOSUB draweverything

    _LIMIT 60
    _DISPLAY
LOOP

END

draweverything:
CLS
PAINT (1, 1), 15
COLOR 0, 15
LOCATE 1, 1: PRINT "LClick=Move ellipse, RClick=Move line, Scroll=Tilt line, Arrows=Shift ellipse"
FOR alpha = -20 TO 20 STEP .001
    x = alpha * vx + d
    y = alpha * vy + b
    CALL ccircle(xorig + x * xzoom, yorig + y * yzoom, 1, 1)
NEXT
FOR t = 0 TO 6.284 STEP .001
    x = x0 + ax * COS(t) + bx * SIN(t)
    y = y0 + ay * COS(t) + by * SIN(t)
    CALL ccircle(xorig + x * xzoom, yorig + y * yzoom, 1, 4)
NEXT
CALL ccircle(xorig + x1 * xzoom, yorig + y1 * yzoom, 10, 1)
CALL ccircle(xorig + x2 * xzoom, yorig + y2 * yzoom, 10, 1)
RETURN

SUB cline (x1, y1, x2, y2, col)
    LINE (_WIDTH / 2 + x1, -y1 + _HEIGHT / 2)-(_WIDTH / 2 + x2, -y2 + _HEIGHT / 2), col
END SUB

SUB ccircle (x1, y1, r, col)
    CIRCLE (_WIDTH / 2 + x1, -y1 + _HEIGHT / 2), r, col
END SUB
