' TILEDEMO.BAS
'   by Greg Ennen
' Copyright (C) 1995 DOS World
' Published in Issue #21, May 1995, page 57

CLS
SCREEN 9

'Blue/gray background screen
TILE1$ = CHR$(&HAA) + CHR$(&HAA) + CHR$(&HAA) + CHR$(&H0) + CHR$(&H55) + CHR$(&H0) + CHR$(&H0) + CHR$(&H0) + CHR$(&HAA) + CHR$(&HAA) + CHR$(&HAA) + CHR$(&H0) + CHR$(&H55) + CHR$(&H0) + CHR$(&H0) + CHR$(&H0) + CHR$(&HAA) + CHR$(&HAA) + CHR$(&HAA) + CHR$(&H0) + CHR$(&H55) + CHR$(&H0) + CHR$(&H0) + CHR$(&H0) + CHR$(&HAA) + CHR$(&HAA) + CHR$(&HAA) + CHR$(&H0) + CHR$(&H55) + CHR$(&H0) + CHR$(&H0) + CHR$(&H0)

'Red-brick pattern
TILE2$ = CHR$(&H4) + CHR$(&H4) + CHR$(&HFF) + CHR$(&H4) + CHR$(&H4) + CHR$(&H4) + CHR$(&HFF) + CHR$(&H4) + CHR$(&H4) + CHR$(&H4) + CHR$(&HFF) + CHR$(&H4) + CHR$(&HFF) + CHR$(&HFF) + CHR$(&HFF) + CHR$(&HFF) + CHR$(&H20) + CHR$(&H20) + CHR$(&HFF) + CHR$(&H20) + CHR$(&H20) + CHR$(&H20) + CHR$(&HFF) + CHR$(&H20) + CHR$(&H20) + CHR$(&H20) + CHR$(&HFF) + CHR$(&H20) + CHR$(&HFF) + CHR$(&HFF) + CHR$(&HFF) + CHR$(&HFF)

'Squiggle pattern
TILE3$ = CHR$(&HF0) + CHR$(&H30) + CHR$(&HF0) + CHR$(&HC0) + CHR$(&HFC) + CHR$(&HC) + CHR$(&H3C) + CHR$(&H30) + CHR$(&H3F) + CHR$(&H3) + CHR$(&HF) + CHR$(&HC) + CHR$(&HF) + CHR$(&H0) + CHR$(&H3) + CHR$(&H3) + CHR$(&HF) + CHR$(&HC) + CHR$(&HF) + CHR$(&H3) + CHR$(&H3F) + CHR$(&H30) + CHR$(&H3C) + CHR$(&HC) + CHR$(&HFC) + CHR$(&HC0) + CHR$(&HF0) + CHR$(&H30) + CHR$(&HF0) + CHR$(&H0) + CHR$(&HC0) + CHR$(&HC0)

LINE (0, 0)-(639, 45), 15, B
LOCATE 2, 12
PRINT "Examples of tiling effects possible with QBasic's PAINT statement";
LOCATE 6, 9
PRINT "These patterns were";
LOCATE 7, 8
PRINT "created with TILE.BAS.";
LOCATE 13, 46
PRINT "You may add any of";
LOCATE 14, 46
PRINT "your own creations";
LOCATE 15, 45
PRINT "to your own programs.";
LINE (50, 60)-(235, 250), 15, B
LINE (50, 60)-(235, 105), 15, B
CIRCLE (430, 200), 175, 15
CIRCLE (430, 200), 100, 15

'Paint the background screen
PAINT (638, 300), TILE1$

'Paint the red bricks
PAINT (200, 200), TILE2$

'Paint the squiggles
PAINT (535, 300), TILE3$

