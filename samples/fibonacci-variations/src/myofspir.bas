OPTION _EXPLICIT
 
DO UNTIL _SCREENEXISTS: LOOP
_TITLE "Fibonacci Spiral Explorer"
 
SCREEN _NEWIMAGE(800, 600, 32)
 
DIM SHARED pi AS DOUBLE
pi = 4 * ATN(1)
 
TYPE Vector
    x AS DOUBLE
    y AS DOUBLE
END TYPE
 
DIM SHARED CompassCart AS Vector
DIM SHARED CompassTheta AS Vector
DIM SHARED p AS SINGLE
DIM SHARED zoom AS SINGLE
 
FOR p = 0 TO 1 - .002 STEP .002
    zoom = 50 * (1.9 - .9 * p)
    CALL DrawEverything
    _DISPLAY
    _LIMIT 60
NEXT
SLEEP 1
 
DO
 
    IF (_KEYDOWN(18432) = -1) THEN ' Up-arrow
        zoom = zoom * (1 + 0.01)
    END IF
    IF (_KEYDOWN(20480) = -1) THEN ' Down-arrow
        zoom = zoom * (1 - 0.01)
    END IF
    IF (_KEYDOWN(19200) = -1) THEN ' Left-arrow
        IF (p > 0) THEN p = p - .005
        _DELAY .025
    END IF
    IF (_KEYDOWN(19712) = -1) THEN ' Right-arrow
        p = p + .005
        _DELAY .025
    END IF
    _KEYCLEAR
 
    CALL DrawEverything
    LOCATE 1, 50: PRINT "Adjust Parameter and Zoom with arrow keys."
 
    _DISPLAY
    _LIMIT 60
LOOP
 
SYSTEM
 
SUB DrawEverything
    DIM LastPoint AS Vector
    DIM x1 AS DOUBLE
    DIM y1 AS DOUBLE
    DIM x2 AS DOUBLE
    DIM y2 AS DOUBLE
    DIM j AS INTEGER
    DIM Step1 AS DOUBLE
    DIM Step2 AS DOUBLE
    DIM StepTemp AS DOUBLE
 
    CompassCart.x = 1
    CompassCart.y = -1
    CompassTheta.x = pi
    CompassTheta.y = 3 * pi / 2
    Step1 = 0
    Step2 = 1
 
    LastPoint.x = 0
    LastPoint.y = 0
 
    CLS
    LOCATE 1, 1: PRINT "Parameter="; p
    LOCATE 2, 1: PRINT "Zoom="; zoom
    FOR j = 1 TO 10
 
        CALL StepCompass
        StepTemp = Step2
        Step2 = p * Step2 + Step1
        Step1 = StepTemp
 
        x1 = LastPoint.x
        y1 = LastPoint.y
        x2 = x1 + SQR(2) * Step2 * CompassCart.x
        y2 = y1 + SQR(2) * Step2 * CompassCart.y
        CALL clineb(x1 * zoom, y1 * zoom, x2 * zoom, y2 * zoom, _RGBA(255, 255, 255, 155))
 
        IF (CompassCart.x = 1) AND (CompassCart.y = 1) THEN
            CALL ccircle(x1 * zoom, y2 * zoom, SQR(2) * Step2 * zoom, _RGBA(255, 0, 255, 255), CompassTheta.x, CompassTheta.y)
        END IF
        IF (CompassCart.x = -1) AND (CompassCart.y = 1) THEN
            CALL ccircle(x2 * zoom, y1 * zoom, SQR(2) * Step2 * zoom, _RGBA(255, 0, 255, 255), CompassTheta.x, CompassTheta.y)
        END IF
        IF (CompassCart.x = -1) AND (CompassCart.y = -1) THEN
            CALL ccircle(x1 * zoom, y2 * zoom, SQR(2) * Step2 * zoom, _RGBA(255, 0, 255, 255), CompassTheta.x, CompassTheta.y)
        END IF
        IF (CompassCart.x = 1) AND (CompassCart.y = -1) THEN
            CALL ccircle(x2 * zoom, y1 * zoom, SQR(2) * Step2 * zoom, _RGBA(255, 0, 255, 255), CompassTheta.x, CompassTheta.y)
        END IF
 
        LastPoint.x = x2
        LastPoint.y = y2
    NEXT
 
END SUB
 
SUB StepCompass
    DIM xx AS INTEGER
    DIM yy AS INTEGER
    xx = CompassCart.x
    yy = CompassCart.y
    IF (xx = 1) AND (yy = 1) THEN
        CompassCart.x = -1
        CompassCart.y = 1
        CompassTheta.x = 0
        CompassTheta.y = pi / 2
    END IF
    IF (xx = -1) AND (yy = 1) THEN
        CompassCart.x = -1
        CompassCart.y = -1
        CompassTheta.x = pi / 2
        CompassTheta.y = pi
    END IF
    IF (xx = -1) AND (yy = -1) THEN
        CompassCart.x = 1
        CompassCart.y = -1
        CompassTheta.x = pi
        CompassTheta.y = 3 * pi / 2
    END IF
    IF (xx = 1) AND (yy = -1) THEN
        CompassCart.x = 1
        CompassCart.y = 1
        CompassTheta.x = 3 * pi / 2
        CompassTheta.y = 2 * pi
    END IF
END SUB
 
SUB cpset (x1 AS DOUBLE, y1 AS DOUBLE, col AS _UNSIGNED LONG)
    PSET (_WIDTH / 2 + x1, -y1 + _HEIGHT / 2), col
END SUB
 
SUB clineb (x1 AS DOUBLE, y1 AS DOUBLE, x2 AS DOUBLE, y2 AS DOUBLE, col AS _UNSIGNED LONG)
    LINE (_WIDTH / 2 + x1, -y1 + _HEIGHT / 2)-(_WIDTH / 2 + x2, -y2 + _HEIGHT / 2), col, B
END SUB
 
SUB ccircle (x1 AS DOUBLE, y1 AS DOUBLE, rad AS DOUBLE, col AS _UNSIGNED LONG, ang1 AS DOUBLE, ang2 AS DOUBLE)
    CIRCLE (_WIDTH / 2 + x1, -y1 + _HEIGHT / 2), rad, col, ang1, ang2
END SUB