' The woman is Heather Thomas

DEFINT A-Z
SCREEN 12
DIM dots(7), x(7, 7), y(7, 7), c1(7), c2(28), pixel(7, 7), w(3), y$(30)
cps! = 12.83 ' cost per set
FOR i = 1 TO 28: READ y$(i): NEXT i
FOR n = 1 TO 7
    READ dots(n)
    FOR dot = 1 TO dots(n)
        READ x(n, dot), y(n, dot)
    NEXT dot
NEXT n
xb = 10: xe = 350 ' x begin and end
yb = 0: ye = 470 ' y begin and end
OPEN "heath.bmp" FOR RANDOM AS #1 LEN = 1: FIELD #1, 1 AS t$
FOR y1 = yb TO ye STEP 8
    FOR x1 = xb TO xe STEP 8
        n = 0
        FOR y2 = 0 TO 7
            FOR x2 = 0 TO 7
                x3 = x1 + x2
                y3 = y1 + y2
                r& = CDBL(479 - y3) * 640 + x3 + 441
                GET #1, r&
                d = ASC(t$) \ 13
                IF d > 15 THEN d = 15
                pixel(x2, y2) = -(d > 7) ' for 3 problem
                n = n + d
            NEXT x2
        NEXT y2
        n = n / 155 ' 175
        IF n > 6 THEN n = 6
        x$ = x$ + CHR$(48 + n) ' for counting tiles used
        IF LEN(x$) = 2 THEN ' got left & right
            FOR i = 1 TO 28
                IF x$ = y$(i) THEN c2(i) = c2(i) + 1: EXIT FOR
            NEXT i
            x$ = ""
        END IF
        IF n = 3 THEN ' default bottom left - top right
            IF (l = 3) OR (l = 7) THEN ' can't change direction if the
                n = l ' last piece was also a 3
            ELSE
                FOR zi = 0 TO 3
                    w(zi) = 0
                NEXT zi
                FOR y2 = 0 TO 7
                    FOR x2 = 0 TO 7
                        xi = x2 \ 4 ' 0 or 1
                        yi = y2 \ 4 ' 0 or 1
                        zi = xi * 2 + yi ' 0-3
                        ' LOCATE zi + 1, 1: PRINT zi;
                        w(zi) = w(zi) + pixel(x2, y2)
                    NEXT x2
                NEXT y2
                IF (w(1) + w(2)) > (w(0) + w(3)) THEN n = 7
            END IF
        END IF
        l = n ' save last used (for 3)
        d = dots(n)
        c1(n) = c1(n) + 1
        FOR dot = 1 TO d
            tx = (x1 + 4) + x(n, dot) * 2 - xb
            ty = (y1 + 4) + y(n, dot) * 2 - yb
            PSET (tx, ty), 15
        NEXT dot
        IF INKEY$ = CHR$(27) THEN CLOSE: SCREEN 0, 0, 0, 0: END
        nd = nd + 1
    NEXT x1
    GOSUB Status
NEXT y1
DO: _LIMIT 10
LOOP UNTIL LEN(INKEY$)
SYSTEM

Status:
FOR i = 0 TO 7
    'COLOR i
    LOCATE i + 2, 49: PRINT USING "####"; i; c1(i);
NEXT i
RESTORE count
FOR i = 1 TO 28
    LOCATE i + 1, 60: PRINT " ";
    LOCATE i + 1, 60
    IF c2(i) >= max THEN
        max = c2(i)
        PRINT "*";
    ELSE
        PRINT " ";
    END IF
    PRINT y$(i);
    PRINT USING " #### "; c2(i);
    c! = c2(i) * cps!
    c! = c! + c! * .07
    PRINT USING "####.##"; c!;
NEXT i
xn = (xe - xb) / 16
yn = (ye - yb) / 8
LOCATE 27, 52: PRINT xn;
LOCATE 28, 52: PRINT yn;
LOCATE 29, 52: PRINT xn * yn;
RETURN

count:
DATA 00,01,02,03,04,05,06
DATA 11,12,13,14,15,16
DATA 22,23,24,25,26
DATA 33,34,35,36
DATA 44,45,46
DATA 55,56
DATA 66

dots:
DATA 1,0,0
DATA 2,0,-1,0,1
DATA 3,-1,-1,0,0,1,1
DATA 4,-1,1,-1,-1,1,-1,1,1
DATA 5,-1,1,-1,-1,1,-1,1,1,0,0
DATA 6,-1,1,-1,0,-1,-1,1,1,1,0,1,-1
DATA 3,1,-1,0,0,-1,1

