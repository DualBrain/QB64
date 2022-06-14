CLS : CLEAR : P$(2) = "YES": P$(1) = "NO": DO: PRINT : PRINT "GUESS: "; : SLEEP: G$ = UCASE$(INKEY$): PRINT G$: RANDOMIZE TIMER: C$ = CHR$(72 - 12 * (RND > .5)): PRINT "COIN:  "; C$, : T = 1 + (G$ <> C$): PRINT P$(T + 1): SOUND 4000 * T, .5: A(T) = A(T) + 1: N = A(0): Y = A(1): PRINT "YES="; Y, "NO="; N, "SCORE="; CINT((Y / (Y + N) * 100)); "%": LOOP

