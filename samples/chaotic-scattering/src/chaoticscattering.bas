DEFINT A-Z
sw = 640
sh = 480
DIM pi AS DOUBLE
DIM t AS DOUBLE
DIM a AS DOUBLE, b AS DOUBLE
DIM a1 AS DOUBLE, a2 AS DOUBLE

DIM x AS DOUBLE, y AS DOUBLE
DIM x0 AS DOUBLE, y0 AS DOUBLE
DIM x1 AS DOUBLE, y1 AS DOUBLE

pi = 3.141593

SCREEN _NEWIMAGE(sw, sh, 12)

r = 150
rr = 100

xx = sw / 2
yy = sh / 2

DO
    DO
        mx = _MOUSEX
        my = _MOUSEY
        mb = _MOUSEBUTTON(1)
    LOOP WHILE _MOUSEINPUT

    LINE (0, 0)-(sw, sh), 0, BF
    FOR b = 0 TO 2 * pi STEP 2 * pi / 3
        CIRCLE (r * COS(b) + sw / 2, r * SIN(b) + sh / 2), rr
    NEXT

    IF mb THEN
        f = -1
        DO WHILE mb
            DO
                mb = _MOUSEBUTTON(1)
            LOOP WHILE _MOUSEINPUT
        LOOP
        FOR b = 0 TO 2 * pi STEP 2 * pi / 3
            x1 = r * COS(b) + sw / 2
            y1 = r * SIN(b) + sh / 2
            IF (mx - x1) ^ 2 + (my - y1) ^ 2 < rr * rr THEN f = 0
        NEXT
        IF f THEN
            xx = mx
            yy = my
            f = -1
        END IF
    END IF

    x0 = xx
    y0 = yy

    a = _ATAN2(my - yy, mx - xx)

    t = 0
    DO
        t = t + 1
        x = t * COS(a) + x0
        y = t * SIN(a) + y0
        IF x < 0 OR x > sw OR y < 0 OR y > sh THEN EXIT DO
        FOR b = 0 TO 2 * pi STEP 2 * pi / 3
            x1 = r * COS(b) + sw / 2
            y1 = r * SIN(b) + sh / 2
            IF (x - x1) ^ 2 + (y - y1) ^ 2 < rr * rr THEN
                a1 = _ATAN2(y - y1, x - x1)
                a2 = 2 * a1 - a - pi

                LINE (x0, y0)-(x, y), 14

                x0 = x
                y0 = y
                a = a2
                t = 0
                EXIT FOR
            END IF
        NEXT
    LOOP

    LINE (x0, y0)-(x, y), 14

    _DISPLAY
    _LIMIT 50
LOOP UNTIL _KEYHIT = 27
SYSTEM


