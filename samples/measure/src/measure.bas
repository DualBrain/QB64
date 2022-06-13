'  MEASURE.BAS - A program for performing measurement conversions
'     by Antonio & Alfonso De Pasquale
'
'  Copyright (C) 1993 DOS Resource Guide
'                     80 Elm Street
'                     Peterborough NH  03458
'  Published in Issue #13, January 1994, page 50
'

DECLARE SUB BOX (r1, c1, r2, c2)
DECLARE SUB CMENU (m$, maxval, v$())

FILLARRAYS:
    DIM length(10), area(7), weight(10), liquid(10), dry(6)
    DIM length$(10), area$(7), weight$(10), liquid$(10), dry$(6)
    DIM v$(10)
   
    FOR x = 1 TO 10: READ length(x): NEXT x
    FOR x = 1 TO 7: READ area(x): NEXT x
    FOR x = 1 TO 10: READ weight(x): NEXT x
    FOR x = 1 TO 10: READ liquid(x): NEXT x
    FOR x = 1 TO 6: READ dry(x): NEXT x
    FOR x = 1 TO 10: READ length$(x): NEXT x
    FOR x = 1 TO 7: READ area$(x): NEXT x
    FOR x = 1 TO 10: READ weight$(x): NEXT x
    FOR x = 1 TO 10: READ liquid$(x): NEXT x
    FOR x = 1 TO 6: READ dry$(x): NEXT x
 
MAINMENU:
    DO
        CLS
        BOX 1, 21, 3, 57
        LOCATE 2, 25: PRINT "**  Measurement Converter  **"
        BOX 5, 5, 15, 75
        LOCATE 6, 10: PRINT "Please Select One of the Following:"
        LOCATE 8, 10: PRINT "(1)   For Length           Conversions"
        LOCATE 9, 10: PRINT "(2)   For Area             Conversions"
        LOCATE 10, 10: PRINT "(3)   For Weight           Conversions"
        LOCATE 11, 10: PRINT "(4)   For Liquid Capacity  Conversions"
        LOCATE 12, 10: PRINT "(5)   For Dry Capacity     Conversions"
        LOCATE 14, 10: INPUT "Type In Your Selection (or Press ENTER to Quit): ", sel$
        sel = VAL(sel$): IF sel > 0 AND sel < 6 THEN GOSUB CONVERTMENU
    LOOP UNTIL sel = 0
    CLS
    END

CONVERTMENU:
    DO
        GOSUB CLEARSCREEN
        BOX 4, 1, 18, 34: BOX 4, 35, 18, 79: BOX 19, 1, 23, 79
        LOCATE 5, 3
        SELECT CASE sel
            CASE 1
                m$ = "Length Conversions"
                maxval = 10
                FOR x = 1 TO maxval: v$(x) = length$(x): NEXT x
            CASE 2
                m$ = "Area Conversions"
                maxval = 7
                FOR x = 1 TO maxval: v$(x) = area$(x): NEXT x
            CASE 3
                m$ = "Weight Conversions"
                maxval = 10
                FOR x = 1 TO maxval: v$(x) = weight$(x): NEXT x
            CASE 4
                m$ = "Liquid Capacity Conversions"
                maxval = 10
                FOR x = 1 TO maxval: v$(x) = liquid$(x): NEXT x
            CASE 5
                m$ = "Dry Capacity Conversions"
                maxval = 6
                FOR x = 1 TO maxval: v$(x) = dry$(x): NEXT x
        END SELECT
        CMENU m$, maxval, v$()
        GOSUB ENTRY
    LOOP UNTIL unit1 = 0 OR unit2 = 0 OR num = 0
    RETURN

ENTRY:
    GOSUB GETFROM: IF unit1 = 0 THEN RETURN
    GOSUB GETTO: IF unit2 = 0 THEN RETURN
    GOSUB GETVALUE: IF num = 0 THEN RETURN
    GOSUB CONVERTVALUE
    RETURN

GETFROM:
    x$ = SPACE$(15)
    LOCATE 7, 37: PRINT "Select the unit you wish to convert FROM"
    LOCATE 8, 37: INPUT "Selection: ", x$
    x = VAL(x$): IF x < 0 OR x > maxval THEN GOTO GETFROM
    unit1 = x
    RETURN

GETTO:
    x$ = SPACE$(15)
    LOCATE 10, 37: PRINT "Select the unit you wish to convert TO"
    LOCATE 11, 37: INPUT "Selection: ", x$
    x = VAL(x$): IF x < 0 OR x > maxval THEN GOTO GETTO
    unit2 = x
    RETURN

GETVALUE:
    x$ = SPACE$(15)
    LOCATE 13, 37: PRINT "Type the value to convert (ENTER cancels)"
    LOCATE 14, 37: INPUT "Value: ", x$
    x = VAL(x$): x = INT((x + .005) * 100) / 100
    LOCATE 14, 43: PRINT x; SPACE$(5)
    maxval = 99999: IF x < 0 OR x > maxval THEN GOTO GETVALUE
    num = x
    RETURN

CONVERTVALUE:
    SELECT CASE sel
        CASE 1
            cnval = num * length(unit1) / length(unit2)
            m1$ = length$(unit1)
            m2$ = length$(unit2)
        CASE 2
            cnval = num * area(unit1) / area(unit2)
            m1$ = area$(unit1)
            m2$ = area$(unit2)
        CASE 3
            cnval = num * weight(unit1) / weight(unit2)
            m1$ = weight$(unit1)
            m2$ = weight$(unit2)
        CASE 4
            cnval = num * liquid(unit1) / liquid(unit2)
            m1$ = liquid$(unit1)
            m2$ = liquid$(unit2)
        CASE 5
            cnval = num * dry(unit1) / dry(unit2)
            m1$ = dry$(unit1)
            m2$ = dry$(unit2)
    END SELECT
    cnval = INT((cnval + .005) * 100) / 100
    LOCATE 20, 5: PRINT USING "###,###.## "; num;
    PRINT m1$; " is equal to ";
    PRINT USING "###,###.## "; cnval;
    PRINT m2$
    LOCATE 22, 25: PRINT "*** Press ENTER to continue ***"
    DO UNTIL INKEY$ = CHR$(13): LOOP
    RETURN

CLEARSCREEN:
    FOR x = 4 TO 23: LOCATE x, 1: PRINT SPACE$(79): NEXT x
    RETURN

DATASECTION:
    DATA .3937, 1, 12, 36, 39.37, 72, 39370, 63360, 71013.24, 190080
    DATA .1550003, 1, 144, 1296, 1550.003, 4014489600, 6272640
    DATA .01543236, 1, 3.086, 15.43236, 437.5, 480, 7000, 5760, 15432.36, 11520000
    DATA 1, 1.333333, 4, 8, 64, 128, 256, 270.51218, 1024, 7660.052
    DATA .0297616, 1, 1.816166, 2, 16, 64

    DATA "Centimeters", "Inches", "Feet", "Yards", "Meters", "Fathoms"
    DATA "Kilometers", "Statute Miles", "Nautical Miles", "Leagues"

    DATA "Square Centimeters", "Square Inches", "Square Feet", "Square Yards"
    DATA "Square Meters", "Square Miles", "Acres"

    DATA "Milligrams", "Grains", "Carats", "Grams", "Ounces (Avoirdupois)"
    DATA "Ounces (Troy)", "Pounds (Avoirdupois)", "Pounds (Troy)"
    DATA "Kilograms", "Tons"

    DATA "Drams", "Teaspoons", "Tablespoons", "Fluid Ounces", "Cups", "Pints"
    DATA "Quarts", "Liters", "Gallons", "Cubic Feet"

    DATA "Cubic Inches", "Pints", "Liters", "Quarts", "Pecks", "Bushels"

SUB BOX (r1, c1, r2, c2)
   
    LOCATE r1, c1
    PRINT CHR$(218);
    FOR x = (c1 + 1) TO (c2 - 1)
        PRINT CHR$(196);
    NEXT x
    PRINT CHR$(191)

    FOR x = (r1 + 1) TO (r2 - 1)
        LOCATE x, c1
        PRINT CHR$(179); SPACE$(c2 - c1 - 1); CHR$(179)
    NEXT x

    LOCATE r2, c1
    PRINT CHR$(192);
    FOR x = (c1 + 1) TO (c2 - 1)
        PRINT CHR$(196);
    NEXT x
    PRINT CHR$(217)

END SUB

SUB CMENU (m$, maxval, v$())
   
    vpos = 7
    LOCATE 5, 4
    PRINT m$
    FOR x = 1 TO maxval
        LOCATE vpos, 4
        PRINT USING "(##) - "; x;
        PRINT v$(x)
        vpos = vpos + 1
    NEXT x

END SUB

