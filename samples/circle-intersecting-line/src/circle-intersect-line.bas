_TITLE "Circle Intersect Line" ' b+ 2020-01-31 develop
' Find point on line perpendicular to line at another point" 'B+ 2019-12-15
' further for a Line and Circle Intersect, making full use of the information from the link below.

CONST xmax = 800, ymax = 600
SCREEN _NEWIMAGE(xmax, ymax, 32)
_SCREENMOVE 300, 40

DO
    CLS
    IF testTangent = 0 THEN 'test plug in set of border conditions not easy to click
        PRINT "First set here is a plug in test set for vertical lines."
        mx(1) = 200: my(1) = 100: mx(2) = 200: my(2) = 400 'line  x = 200
        mx(3) = 400: my(3) = 300: mx(4) = 150: my(4) = 300 ' circle origin (center 400, 300) then radius test 200 tangent, 150 more than tangent, 250 short
        FOR i = 1 TO 4
            CIRCLE (mx(i), my(i)), 2
        NEXT
        IF mx(1) <> mx(2) THEN
            slopeYintersect mx(1), my(1), mx(2), my(2), m, Y0 ' Y0 otherwise know as y Intersect
            LINE (0, Y0)-(xmax, m * xmax + Y0), &HFF0000FF
            LINE (mx(1), my(1))-(mx(2), my(2))
        ELSE
            LINE (mx(1), 0)-(mx(1), ymax), &HFF0000FF
            LINE (mx(1), my(1))-(mx(2), my(2))
        END IF
        testTangent = 1
    ELSE
        PRINT "First 2 clicks will form a line, 3rd the circle origin and 4th the circle radius:"
        WHILE pi < 4 'get 4 mouse clicks
            _PRINTSTRING (20, 20), SPACE$(20)
            _PRINTSTRING (20, 20), "Need 4 clicks, have" + STR$(pi)
            WHILE _MOUSEINPUT: WEND
            IF _MOUSEBUTTON(1) AND oldMouse = 0 THEN 'new mouse down
                pi = pi + 1
                mx(pi) = _MOUSEX: my(pi) = _MOUSEY
                CIRCLE (mx(pi), my(pi)), 2
                IF pi = 2 THEN 'draw first line segment then line
                    IF mx(1) <> mx(2) THEN
                        slopeYintersect mx(1), my(1), mx(2), my(2), m, Y0 ' Y0 otherwise know as y Intersect
                        LINE (0, Y0)-(xmax, m * xmax + Y0), &HFF0000FF
                        LINE (mx(1), my(1))-(mx(2), my(2))
                    ELSE
                        LINE (mx(1), 0)-(mx(1), ymax), &HFF0000FF
                        LINE (mx(1), my(1))-(mx(2), my(2))
                    END IF
                END IF
            END IF
            oldMouse = _MOUSEBUTTON(1)
            _DISPLAY
            _LIMIT 60
        WEND
    END IF
    p = mx(3): q = my(3)
    r = SQR((mx(3) - mx(4)) ^ 2 + (my(3) - my(4)) ^ 2)
    CIRCLE (p, q), r, &HFFFF0000
    IF mx(1) = mx(2) THEN 'line is vertical so if r =
        IF r = ABS(mx(1) - mx(3)) THEN ' one point tangent intersect
            PRINT "Tangent point is "; TS$(mx(1)); ", "; TS$(my(3))
            CIRCLE (mx(1), my(3)), 2, &HFFFFFF00
            CIRCLE (mx(1), my(3)), 4, &HFFFFFF00
        ELSEIF r < ABS(mx(1) - mx(3)) THEN 'no intersect
            PRINT "No intersect, radius too small."
        ELSE '2 point intersect
            ydist = SQR(r ^ 2 - (mx(1) - mx(3)) ^ 2)
            y1 = my(3) + ydist
            y2 = my(3) - ydist
            PRINT "2 Point intersect (x1, y1) = "; TS$(mx(1)); ", "; TS$(y1); "  (x2, y2) = "; TS$(mx(1)); ", "; TS$(y2)
            CIRCLE (mx(1), y1), 2, &HFFFFFF00 'marking intersect points yellow
            CIRCLE (mx(1), y2), 2, &HFFFFFF00
            CIRCLE (mx(1), y1), 4, &HFFFFFF00 'marking intersect points yellow
            CIRCLE (mx(1), y2), 4, &HFFFFFF00

        END IF
    ELSE
        'OK the calculations!
        'from inserting eq ofline into eq of circle where line intersects circle see reference
        ' https://math.stackexchange.com/questions/228841/how-do-i-calculate-the-intersections-of-a-straight-line-and-a-circle
        A = m ^ 2 + 1
        B = 2 * (m * Y0 - m * q - p)
        C = q ^ 2 - r ^ 2 + p ^ 2 - 2 * Y0 * q + Y0 ^ 2
        D = B ^ 2 - 4 * A * C 'telling part of Quadratic formula = 0 then circle is tangent  or > 0 then 2 intersect points
        IF D < 0 THEN ' no intersection
            PRINT "m, y0 "; TS$(m); ", "; TS$(Y0)
            PRINT "(p, q) "; TS$(p); ", "; TS$(q)
            PRINT "A: "; TS$(A)
            PRINT "B: "; TS$(B)
            PRINT "C: "; TS$(C)
            PRINT "D: "; TS$(D); " negative so no intersect."
        ELSEIF D = 0 THEN ' one point tangent
            x1 = (-B + SQR(D)) / (2 * A)
            y1 = m * x1 + Y0
            PRINT "Tangent Point Intersect (x1, y1) = "; TS$(x1); ", "; TS$(y1)
            CIRCLE (x1, y1), 2, &HFFFFFF00 'yellow circle should be on line perprendicular to 3rd click point
            CIRCLE (x1, y1), 4, &HFFFFFF00 'yellow circle should be on line perprendicular to 3rd click point
        ELSE
            '2 points
            x1 = (-B + SQR(D)) / (2 * A): y1 = m * x1 + Y0
            x2 = (-B - SQR(D)) / (2 * A): y2 = m * x2 + Y0
            PRINT "2 Point intersect (x1, y1) = "; TS$(x1); ", "; TS$(y1); "  (x2, y2) = "; TS$(x2); ", "; TS$(y2)
            CIRCLE (x1, y1), 2, &HFFFFFF00 'marking intersect points yellow
            CIRCLE (x2, y2), 2, &HFFFFFF00
            CIRCLE (x1, y1), 4, &HFFFFFF00 'marking intersect points yellow
            CIRCLE (x2, y2), 4, &HFFFFFF00
        END IF
    END IF
    _DISPLAY
    INPUT "press enter to continue, any + enter to quit "; q$
    IF LEN(q$) THEN SYSTEM
    pi = 0 'point index
LOOP UNTIL _KEYDOWN(27)

SUB slopeYintersect (X1, Y1, X2, Y2, slope, Yintercept) ' fix for when x1 = x2
    slope = (Y2 - Y1) / (X2 - X1)
    Yintercept = slope * (0 - X1) + Y1
END SUB

FUNCTION TS$ (n)
    TS$ = _TRIM$(STR$(n))
END FUNCTION



