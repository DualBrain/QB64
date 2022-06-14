'INITIAL STAKES =   $1000
'MANDATORY BET =  $10
'PAYOFFS:  [ N N - ] = 7 times N 
'          [ N N N ] = 10 times N times N
'_______________________________________________
' THUS: [ 2 2 - ] =  7*2 = $14 [ 2 2 2 ] = 10*2*2 = $40
'      [ 3 3 - ] = $21     [ 3 3 3 ] = $90
'      [ 4 4 - ] = $28     [ 4 4 4 ] = $160
'      [ 5 5 - ] = $35     [ 5 5 5 ] = $250
'      [ 6 6 - ] = $42     [ 6 6 6 ] = $360
'      [ 7 7 - ] = $49     [ 7 7 7 ] = $490
'      [ 8 8 - ] = $56     [ 8 8 8 ] = $640
'      [ 9 9 - ] = $63     [ 9 9 9 ] = $810
SCREEN 1: COLOR 8: CLS : S = 1000!: DO: RANDOMIZE TIMER: LOCATE 6, 16: PRINT "$"; S: SLEEP: S = S - 10: FOR I = 1 TO 250: FOR T = 1 TO 3: V% = RND * 8 + 1.5: V(T) = V%: NEXT: LOCATE 12, 15: A = V(1): B = V(2): C = V(3): PRINT A; B; C; : SOUND 3000! - I * 10, .06: NEXT: X = A = B AND B = C: W = X = 0 AND A = B: D = 7 * A * W + 10 * A * A * X: S = S - D: LOOP
'NOTE: To speed up or slow down play,
'you may substitute another value for 250.

