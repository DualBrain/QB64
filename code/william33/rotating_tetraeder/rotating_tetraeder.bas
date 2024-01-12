'based on a YaBASIC example, ported by William33
'the FillTriangle code is based on a Turbo Pascal example

' https://qb64.boards.net/thread/42/rotating-tetraeder

_TITLE "Tetraeder"

SCREEN _NEWIMAGE(1280, 720, 32)

DIM opoints(4, 3)
RESTORE points
FOR n = 1 TO 4: FOR p = 1 TO 3: READ opoints(n, p): NEXT p: NEXT n

DIM triangles(4, 3)
RESTORE triangles
FOR n = 1 TO 4: FOR p = 1 TO 3: READ triangles(n, p): NEXT p: NEXT n

phi = 0: dphi = 0.1: psi = 0: dpsi = 0.05
DIM points(4, 3)

r = 60: g = 20
dr = 0.5: dg = 1.2: db = 3
DO
    _LIMIT 60
    CLS
    phi = phi + dphi
    psi = psi + dpsi
    FOR n = 1 TO 4
        points(n, 1) = opoints(n, 1) * COS(phi) - opoints(n, 2) * SIN(phi)
        points(n, 2) = opoints(n, 2) * COS(phi) + opoints(n, 1) * SIN(phi)
        p2 = points(n, 2) * COS(psi) - opoints(n, 3) * SIN(psi)
        points(n, 3) = opoints(n, 3) * COS(psi) + points(n, 2) * SIN(psi)
        points(n, 2) = p2
    NEXT n

    r = r + dr: IF (r < 0 OR r > 60) THEN dr = -dr
    g = g + dg: IF (g < 0 OR g > 60) THEN dg = -dg
    b = b + db: IF (b < 0 OR b > 60) THEN db = -db
    dm = dm + 0.01
    m = 120 - 80 * SIN(dm)
    FOR n = 1 TO 4
        p1 = triangles(n, 1)
        p2 = triangles(n, 2)
        p3 = triangles(n, 3)
        n1 = points(p1, 1) + points(p2, 1) + points(p3, 1)
        n2 = points(p1, 2) + points(p2, 2) + points(p3, 2)
        n3 = points(p1, 3) + points(p2, 3) + points(p3, 3)
        IF (n3 > 0) THEN
            sp = n1 * 0.5 - n2 * 0.7 - n3 * 0.6
            COLOR _RGB32(INT(60 + r + 30 * sp) MOD 256, INT(60 + g + 30 * sp) MOD 256, INT(60 + b + 30 * sp) MOD 256)
            FillTriangle INT(_WIDTH / 2) + m * points(p1, 1), INT(_HEIGHT / 2) + m * points(p1, 2), INT(_WIDTH / 2) + m * points(p2, 1), INT(_HEIGHT / 2) + m * points(p2, 2), INT(_WIDTH / 2) + m * points(p3, 1), INT(_HEIGHT / 2) + m * points(p3, 2)
        END IF
    NEXT n
    _DISPLAY

LOOP UNTIL INKEY$ = CHR$(27)

SYSTEM

points:
DATA -1,-1,+1,+1,-1,-1,+1,+1,+1,-1,+1,-1
triangles:
DATA 1,2,4,2,3,4,1,3,4,1,2,3


SUB FillTriangle (xa AS INTEGER, ya AS INTEGER, xb AS INTEGER, yb AS INTEGER, xc AS INTEGER, yc AS INTEGER)
    DIM y1 AS LONG, y2 AS LONG, y3 AS LONG, x1 AS LONG, x2 AS LONG, x3 AS LONG
    DIM dx12 AS LONG, dx13 AS LONG, dx23 AS LONG
    DIM dy12 AS LONG, dy13 AS LONG, dy23 AS LONG, dy AS LONG
    DIM a AS LONG, b AS LONG
    IF ya = yb THEN
        yb = yb + 1
    END IF
    IF ya = yc THEN
        yc = yc + 1
    END IF
    IF yc = yb THEN
        yb = yb + 1
    END IF
    IF (ya <> yb) AND (ya <> yc) AND (yc <> yb) THEN
        IF (ya > yb) AND (ya > yc) THEN
            y1 = ya: x1 = xa
            IF yb > yc THEN
                y2 = yb: x2 = xb
                y3 = yc: x3 = xc
            ELSE
                y2 = yc: x2 = xc
                y3 = yb: x3 = xb
            END IF
        ELSE
            IF (yb > ya) AND (yb > yc) THEN
                y1 = yb: x1 = xb
                IF ya > yc THEN
                    y2 = ya: x2 = xa
                    y3 = yc: x3 = xc
                ELSE
                    y2 = yc: x2 = xc
                    y3 = ya: x3 = xa
                END IF
            ELSE
                IF (yc > yb) AND (yc > ya) THEN
                    y1 = yc: x1 = xc
                    IF yb >= ya THEN
                        y2 = yb: x2 = xb
                        y3 = ya: x3 = xa
                    ELSE
                        y2 = ya: x2 = xa
                        y3 = yb: x3 = xb
                    END IF
                END IF
            END IF
        End if
            dx12 = x2 - x1: dy12 = y2 - y1
            dx23 = x3 - x2: dy23 = y3 - y2
            dx13 = x3 - x1: dy13 = y3 - y1
            a = x2 - ((y2 - y3 + dy23) * dx23) / dy23
            b = x3 + (-dy23 * dx13) / (dy13)
            IF (a < b) THEN
                LINE (a, y2)-(b, y2)
                FOR dy = 0 TO -dy23 - 1
                    a = x2 + ((dy23 + dy) * dx23) / dy23
                    b = x3 + (dy * dx13) / (dy13)
                    LINE (a, dy + y3)-(b, dy + y3)
                NEXT
                FOR dy = -dy23 + 1 TO -dy13
                    a = x2 + ((dy23 + dy) * dx12) / dy12
                    b = x3 + (dy * dx13) / (dy13)
                    LINE (a, dy + y3)-(b, dy + y3)

                NEXT
            ELSE
                LINE (b, y2)-(a, y2)
                FOR dy = 0 TO -dy23 - 1
                    a = x2 + ((dy23 + dy) * dx23) / dy23
                    b = x3 + (dy * dx13) / (dy13)
                    LINE (a, dy + y3)-(b, dy + y3)
                NEXT
                FOR dy = -dy23 + 1 TO -dy13
                    a = x2 + ((dy23 + dy) * dx12) / dy12
                    b = x3 + (dy * dx13) / (dy13)
                    LINE (a, dy + y3)-(b, dy + y3)
                NEXT
            END IF
        END IF

END SUB
