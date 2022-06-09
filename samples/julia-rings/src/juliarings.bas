' The Lord of the Julia Rings
' The Fellowship of the Julia Ring
' Free Basic
' Relsoft
' Rel.BetterWebber.com
'
' Converted to QB64 format by Galleon (FB specific code commented)

DEFLNG A-Z

''$include: 'TinyPTC.bi'
''$include: 'user32.bi'

'option explicit

CONST SCR_WIDTH = 320 * 2
CONST SCR_HEIGHT = 240 * 2

CONST SCR_SIZE = SCR_WIDTH * SCR_HEIGHT
CONST SCR_MIDX = SCR_WIDTH \ 2
CONST SCR_MIDY = SCR_HEIGHT \ 2

CONST FALSE = 0, TRUE = NOT FALSE

CONST PI = 3.141593
CONST MAXITER = 20
CONST MAXSIZE = 4

DIM Buffer(SCR_SIZE - 1) AS LONG
DIM Lx(SCR_WIDTH - 1) AS SINGLE
DIM Ly(SCR_HEIGHT - 1) AS SINGLE
DIM sqrt(SCR_SIZE - 1) AS SINGLE

'if( ptc_open( "FreeBASIC Julia (Relsoft)", SCR_WIDTH, SCR_HEIGHT ) = 0 ) then
'   end -1
'end if

SCREEN _NEWIMAGE(SCR_WIDTH, SCR_HEIGHT, 32), , 1, 0

DIM px AS LONG, py AS LONG
DIM p AS SINGLE, q AS SINGLE
DIM xmin AS SINGLE, xmax AS SINGLE, ymin AS SINGLE, ymax AS SINGLE
DIM theta AS SINGLE
DIM deltax AS SINGLE, deltay AS SINGLE
DIM x AS SINGLE, y AS SINGLE
DIM xsquare AS SINGLE, ysquare AS SINGLE
DIM ytemp AS SINGLE
DIM temp1 AS SINGLE, temp2 AS SINGLE
DIM i AS LONG, pixel AS LONG
DIM t AS _UNSIGNED LONG, frame AS _UNSIGNED LONG
DIM ty AS SINGLE
DIM r AS LONG, g AS LONG, b AS LONG
DIM red AS LONG, grn AS LONG, blu AS LONG
DIM tmp AS LONG, i_last AS LONG

DIM cmag AS SINGLE
DIM cmagsq AS SINGLE
DIM zmag AS SINGLE
DIM drad AS SINGLE
DIM drad_L AS SINGLE
DIM drad_H AS SINGLE
DIM ztot AS SINGLE
DIM ztoti AS LONG

'pointers to array "buffer"
'dim p_buffer as long ptr, p_bufferl as long ptr

xmin = -2.0
xmax = 2.0
ymin = -1.5
ymax = 1.5

deltax = (xmax - xmin) / (SCR_WIDTH - 1)
deltay = (ymax - ymin) / (SCR_HEIGHT - 1)

FOR i = 0 TO SCR_WIDTH - 1
    Lx(i) = xmin + i * deltax
NEXT i

FOR i = 0 TO SCR_HEIGHT - 1
    Ly(i) = ymax - i * deltay
NEXT i

FOR i = 0 TO SCR_SIZE - 1
    sqrt(i) = SQR(i)
NEXT i

'dim hwnd as long
'hwnd = GetActiveWindow

DIM stime AS LONG, Fps AS SINGLE, Fps2 AS SINGLE

stime = TIMER

DO

    '    p_buffer = @buffer(0)
    '    p_bufferl = @buffer(SCR_SIZE-1)

    frame = (frame + 1) AND &H7FFFFFFF
    theta = frame * PI / 180

    p = COS(theta) * SIN(theta * .7)
    q = SIN(theta) + SIN(theta)
    p = p * .6
    q = q * .6

    cmag = SQR(p * p + q * q)
    cmagsq = (p * p + q * q)
    drad = 0.04
    drad_L = (cmag - drad)
    drad_L = drad_L * drad_L
    drad_H = (cmag + drad)
    drad_H = drad_H * drad_H

    FOR py = 0 TO (SCR_HEIGHT \ 2) - 1
        ty = Ly(py)
        FOR px = 0 TO SCR_WIDTH - 1
            x = Lx(px)
            y = ty
            xsquare = 0
            ysquare = 0
            ztot = 0
            i = 0
            WHILE (i < MAXITER) AND ((xsquare + ysquare) < MAXSIZE)
                xsquare = x * x
                ysquare = y * y
                ytemp = x * y * 2
                x = xsquare - ysquare + p
                y = ytemp + q
                zmag = (x * x + y * y)
                IF (zmag < drad_H) AND (zmag > drad_L) AND (i > 0) THEN
                    ztot = ztot + (1 - (ABS(zmag - cmagsq) / drad))
                    i_last = i
                END IF
                i = i + 1
                IF zmag > 4.0 THEN
                    EXIT WHILE
                END IF
            WEND

            IF ztot > 0 THEN
                i = CINT(SQR(ztot) * 500)
            ELSE
                i = 0
            END IF
            IF i < 256 THEN
                red = i
            ELSE
                red = 255
            END IF

            IF i < 512 AND i > 255 THEN
                grn = i - 256
            ELSE
                IF i >= 512 THEN
                    grn = 255
                ELSE
                    grn = 0
                END IF
            END IF

            IF i <= 768 AND i > 511 THEN
                blu = i - 512
            ELSE
                IF i >= 768 THEN
                    blu = 255
                ELSE
                    blu = 0
                END IF
            END IF

            tmp = INT((red + grn + blu) \ 3)
            red = INT((red + grn + tmp) \ 3)
            grn = INT((grn + blu + tmp) \ 3)
            blu = INT((blu + red + tmp) \ 3)

            SELECT CASE (i_last MOD 3)
                CASE 1
                    tmp = red
                    red = grn
                    grn = blu
                    blu = tmp
                CASE 2
                    tmp = red
                    blu = grn
                    red = blu
                    grn = tmp
            END SELECT

            'pixel = red shl 16 or grn shl 8 or blu
            '*p_buffer = pixel
            '*p_bufferl = pixel
            'p_buffer = p_buffer + Len(long)
            'p_bufferl = p_bufferl - Len(long)
            pixel = _RGB32(red, grn, blu)
            PSET (px, py), pixel
            PSET (SCR_WIDTH - 1 - px, SCR_HEIGHT - 1 - py), pixel

        NEXT px
    NEXT py

    'calc fps
    Fps = Fps + 1
    IF stime + 1 < TIMER THEN
        Fps2 = Fps
        Fps = 0
        stime = TIMER
    END IF

    '    SetWindowText hwnd, "FreeBasic Julia Rings FPS:" + str$(Fps2)
    LOCATE 1, 1: PRINT "QB64 Julia Rings FPS:" + STR$(Fps2)

    'ptc_update @buffer(0)
    PCOPY 1, 0

LOOP UNTIL INKEY$ <> ""

'ptc_close

END
