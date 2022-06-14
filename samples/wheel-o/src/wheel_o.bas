K = 3 / 172: P = 1000!: J = 10: R = 36: DO: CLS : PRINT : PRINT "$"; P: PRINT : INPUT "BET"; B: INPUT "NUM"; N: LOCATE J, 53: PRINT "<--": L = 0: FOR S = 1 TO R * RND + R: L = L + R: C = L: FOR I = 0 TO 9: LOCATE SIN(C * K) * 5 + J, COS(C * K) * 12 + R: PRINT I: C = C + R: NEXT: NEXT: BEEP: T = L / 360: W% = J - (T - INT(T)) * J: F = N = W%: P = P - B * J * F + B * NOT F: SLEEP 2: LOOP

