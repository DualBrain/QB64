' BIG_LEDS.BAS
' by Scott Edwards
' Copyright (C) 1994 DOS World Magazine
' Published in Issue #19, January 1995, page 62


DECLARE SUB DISPLAY (THEVALUE%)
DECLARE SUB LED (XORIGIN%, YORIGIN%, SEGS%)
DEFINT A-Z
SCREEN 12: CLS

CONST SCALE = 4
CONST OFFSET = 35 * SCALE

'DECODE() holds the patterns of LEDs that form the digits zero to 9.
DIM SHARED DECODE(10) AS INTEGER

'These string constants hold instructions used by the DRAW command
'to draw the segments of the LED displays. The names A through G
'are consistent with the labeling for LED displays.
'
'Because QBasic allows simple math, but not string manipulation,
'in calculating CONST values, you must manually adjust the scale
'values to match that used in the constant SCALE, above.
CONST A$ = "S4 B M+0,-242 B R4 E8 R80 F8 G8 L80 H8 B R10"
CONST B$ = "S4 B M+104,-123 H8 U100 E8 F8 D100 G8 B U10"
CONST C$ = "S4 B M+104,0 H8 U100 E8 F8 D100 G8 B U10"
CONST D$ = "S4 B M+0,+4 B R4 E8 R80 F8 G8 L80 H8 B R10"
CONST E$ = "S4 H8 U100 E8 F8 D100 G8 B U10"
CONST F$ = "S4 B M+0,-123 H8 U100 E8 F8 D100 G8 B U10"
CONST G$ = "S4 B M+0,-120 B R4 E8 R80 F8 G8 L80 H8 B R10"

CONST LIT = 4           'Color of LEDs.
CONST UNLIT = 0         'Color of LEDs when off.
CONST XBASE = 60        'Position in pixels from left edge of screen.
CONST YBASE = 300       'Position in pixels from top of screen.

'Sets up the array DECODE() with the LED segment patterns for zero
'through 9.
FOR I = 0 TO 9: READ DECODE(I): NEXT I

'Main program loop. Substitute your own routines here.
FOR X = 0 TO 9999
        DISPLAY (X): SLEEP 1
        IF INKEY$ <> "" THEN SYSTEM
NEXT X
END

'The data for the DECODE() array.
DATA 63, 6, 91, 79, 102, 109, 125, 7, 127, 111

'Given a value between zero and 9999, this subroutine prepares data
'that the LED soubroutine needs to display the digits on the screen.
SUB DISPLAY (THEVALUE%)

ONES = DECODE(THEVALUE MOD 10): THEVALUE = THEVALUE \ 10
TENS = DECODE(THEVALUE MOD 10): THEVALUE = THEVALUE \ 10
HUNDREDS = DECODE(THEVALUE MOD 10): THEVALUE = THEVALUE \ 10
THOUSANDS = DECODE(THEVALUE MOD 10): THEVALUE = THEVALUE \ 10
LED (XBASE + OFFSET * 3), (YBASE), (ONES)
LED (XBASE + OFFSET * 2), (YBASE), (TENS)
LED (XBASE + OFFSET), (YBASE), (HUNDREDS)
LED (XBASE), (YBASE), (THOUSANDS)

END SUB

'Given an x,y position on the screen, and an integer representing the
'segments to turn on or off, this subroutine draws one LED digit on
'the screen. The integer SEGS% may be any value between zero and 127,
'but only the values supplied by DECODE() will look like actual
'numbers.
SUB LED (XORIGIN%, YORIGIN%, SEGS%)

LITUP$ = STR$(LIT)
DARK$ = STR$(UNLIT)
LOCON$ = "B M" + STR$(XORIGIN%) + "," + STR$(YORIGIN%) + " C" + LITUP$
LOCOFF$ = "B M" + STR$(XORIGIN%) + "," + STR$(YORIGIN%) + " C" + DARK$

FILL$ = "P" + LITUP$ + "," + LITUP$
BLANK$ = "P" + DARK$ + "," + DARK$

IF SEGS% AND 1 THEN DRAW LOCON$ + A$ + FILL$ ELSE DRAW LOCOFF$ + A$ + BLANK$
IF SEGS% AND 2 THEN DRAW LOCON$ + B$ + FILL$ ELSE DRAW LOCOFF$ + B$ + BLANK$
IF SEGS% AND 4 THEN DRAW LOCON$ + C$ + FILL$ ELSE DRAW LOCOFF$ + C$ + BLANK$
IF SEGS% AND 8 THEN DRAW LOCON$ + D$ + FILL$ ELSE DRAW LOCOFF$ + D$ + BLANK$
IF SEGS% AND 16 THEN DRAW LOCON$ + E$ + FILL$ ELSE DRAW LOCOFF$ + E$ + BLANK$
IF SEGS% AND 32 THEN DRAW LOCON$ + F$ + FILL$ ELSE DRAW LOCOFF$ + F$ + BLANK$
IF SEGS% AND 64 THEN DRAW LOCON$ + G$ + FILL$ ELSE DRAW LOCOFF$ + G$ + BLANK$

END SUB

