SCREEN 12: DO: Z = 2000!: X = 300: Y = 343: R = 30: A = .1: N = .2: CLS : SOUND Z * 2, .1: FOR I = 1 TO 100: CIRCLE (X, Y), R, 0, , , B: B = A: H = -5 - 10 * (I > 50): Y = Y + H: CIRCLE (X, Y), R, 15, , , A: S = A > 1: S = S - 1 * NOT (S): N = N * S: A = A + N: NEXT: SOUND Z, .1: LOCATE 22, 38: RANDOMIZE TIMER: PRINT CHR$(72 - 12 * (RND > .5)): SLEEP 2: LOOP

