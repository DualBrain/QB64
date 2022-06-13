1 '  SAVER.BAS by David Ferrier
2 '  Copyright (C) 1992 DOS Resource Guide
3 '  Published in Issue #5, page 8
4 '  This program works with both QBasic and GW-Basic
100 ' Moving line screen saver using QBasic or GW-Basic graphics
120 '----------------INITIALIZE LINE---------------
130 SCREEN 9: CLS : COL = 14
140 X1DIFF = -2: Y1DIFF = 5: X2DIFF = -3: Y2DIFF = 4
150 X1 = 50: Y1 = 100: X2 = 200: Y2 = 300
160 '----------------DISPLAY LINE------------------
170 WHILE 1 = 1
180 X1 = X1 + X1DIFF: Y1 = Y1 + Y1DIFF
190 X2 = X2 + X2DIFF: Y2 = Y2 + Y2DIFF
200 LINE (X1V, Y1V)-(X2V, Y2V), 0
210 LINE (X1, Y1)-(X2, Y2), COL
220 X1V = X1: Y1V = Y1: X2V = X2: Y2V = Y2
230 IF X1 > 640 OR X1 < 1 THEN X1DIFF = X1DIFF * -1
240 IF Y1 > 350 OR Y1 < 1 THEN Y1DIFF = Y1DIFF * -1
250 IF X2 > 640 OR X2 < 1 THEN X2DIFF = X2DIFF * -1
260 IF Y2 > 350 OR Y2 < 1 THEN Y2DIFF = Y2DIFF * -1
270 IF INKEY$ <> "" THEN SYSTEM
280 WEND

