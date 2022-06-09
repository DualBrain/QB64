_TITLE "Lissajous Curve Table"
 
$RESIZE:ON
 
TYPE vector
    x AS SINGLE
    y AS SINGLE
END TYPE
 
DIM SHARED angle
DIM SHARED w
DIM SHARED rows, cols
 
SCREEN _NEWIMAGE(800, 800, 32)
 
setup:
angle = 0
w = 80
rows = INT(_HEIGHT / w) - 1
cols = INT(_WIDTH / w) - 1
REDIM dot(rows, cols) AS vector
 
plot = _NEWIMAGE(_WIDTH, _HEIGHT, 32)
_DEST plot
CLS
_DEST 0
 
DO
    IF _RESIZE THEN
        oldScreen = _DEST
        SCREEN _NEWIMAGE(_RESIZEWIDTH, _RESIZEHEIGHT, 32)
        _FREEIMAGE oldScreen
        _FREEIMAGE plot
        GOTO setup
    END IF
 
    _PUTIMAGE , plot
 
    d = w - 0.2 * w
    r = d / 2
 
    FOR i = 0 TO cols
        cx = w + i * w + w / 2
        cy = w / 2
        CIRCLE (cx, cy), r
 
        x = r * COS(angle * (i + 1) - _PI(.5))
        y = r * SIN(angle * (i + 1) - _PI(.5))
 
        LINE (cx + x, 0)-(cx + x, _HEIGHT), _RGB32(127, 127, 127)
        CircleFill cx + x, cy + y, 4, _RGB32(28, 222, 50)
        CircleFill cx + x, cy + y, 2, _RGB32(11, 33, 249)
 
        FOR j = 0 TO rows
            dot(j, i).x = cx + x
        NEXT
    NEXT
 
    FOR i = 0 TO rows
        cx = w / 2
        cy = w + i * w + w / 2
        CIRCLE (cx, cy), r
 
        x = r * COS(angle * (i + 1) - _PI(.5))
        y = r * SIN(angle * (i + 1) - _PI(.5))
 
        LINE (0, cy + y)-(_WIDTH, cy + y), _RGB32(127, 127, 127)
        CircleFill cx + x, cy + y, 4, _RGB32(28, 222, 50)
        CircleFill cx + x, cy + y, 2, _RGB32(11, 33, 249)
 
        FOR j = 0 TO cols
            dot(i, j).y = cy + y
        NEXT
    NEXT
 
    _DEST plot
    LINE (0, 0)-(_WIDTH, _HEIGHT), _RGBA32(0, 0, 0, 4), BF
    FOR j = 0 TO rows
        FOR i = 0 TO cols
            CircleFill dot(j, i).x, dot(j, i).y, 1, hsb(_R2D(angle), 127, 127, 255)
        NEXT
    NEXT
 
    angle = angle + 0.01
    IF angle > _PI(2) THEN angle = 0
 
    _DEST 0
 
    _DISPLAY
    _LIMIT 30
LOOP
 
SUB CircleFill (x AS LONG, y AS LONG, R AS LONG, C AS _UNSIGNED LONG)
    DIM x0 AS SINGLE, y0 AS SINGLE
    DIM e AS SINGLE
 
    x0 = R
    y0 = 0
    e = -R
    DO WHILE y0 < x0
        IF e <= 0 THEN
            y0 = y0 + 1
            LINE (x - x0, y + y0)-(x + x0, y + y0), C, BF
            LINE (x - x0, y - y0)-(x + x0, y - y0), C, BF
            e = e + 2 * y0
        ELSE
            LINE (x - y0, y - x0)-(x + y0, y - x0), C, BF
            LINE (x - y0, y + x0)-(x + y0, y + x0), C, BF
            x0 = x0 - 1
            e = e - 2 * x0
        END IF
    LOOP
    LINE (x - R, y)-(x + R, y), C, BF
END SUB
 
FUNCTION map! (value!, minRange!, maxRange!, newMinRange!, newMaxRange!)
    map! = ((value! - minRange!) / (maxRange! - minRange!)) * (newMaxRange! - newMinRange!) + newMinRange!
END FUNCTION
 
FUNCTION hsb~& (__H AS _FLOAT, __S AS _FLOAT, __B AS _FLOAT, A AS _FLOAT)
    DIM H AS _FLOAT, S AS _FLOAT, B AS _FLOAT
 
    H = map(__H, 0, 255, 0, 360)
    S = map(__S, 0, 255, 0, 1)
    B = map(__B, 0, 255, 0, 1)
 
    IF S = 0 THEN
        hsb~& = _RGBA32(B * 255, B * 255, B * 255, A)
        EXIT FUNCTION
    END IF
 
    DIM fmx AS _FLOAT, fmn AS _FLOAT
    DIM fmd AS _FLOAT, iSextant AS INTEGER
    DIM imx AS INTEGER, imd AS INTEGER, imn AS INTEGER
 
    IF B > .5 THEN
        fmx = B - (B * S) + S
        fmn = B + (B * S) - S
    ELSE
        fmx = B + (B * S)
        fmn = B - (B * S)
    END IF
 
    iSextant = INT(H / 60)
 
    IF H >= 300 THEN
        H = H - 360
    END IF
 
    H = H / 60
    H = H - (2 * INT(((iSextant + 1) MOD 6) / 2))
 
    IF iSextant MOD 2 = 0 THEN
        fmd = (H * (fmx - fmn)) + fmn
    ELSE
        fmd = fmn - (H * (fmx - fmn))
    END IF
 
    imx = _ROUND(fmx * 255)
    imd = _ROUND(fmd * 255)
    imn = _ROUND(fmn * 255)
 
    SELECT CASE INT(iSextant)
        CASE 1
            hsb~& = _RGBA32(imd, imx, imn, A)
        CASE 2
            hsb~& = _RGBA32(imn, imx, imd, A)
        CASE 3
            hsb~& = _RGBA32(imn, imd, imx, A)
        CASE 4
            hsb~& = _RGBA32(imd, imn, imx, A)
        CASE 5
            hsb~& = _RGBA32(imx, imn, imd, A)
        CASE ELSE
            hsb~& = _RGBA32(imx, imd, imn, A)
    END SELECT
 
END FUNCTION
 