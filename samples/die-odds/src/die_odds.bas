T%(2) = 0: SCREEN 13: DO: CLS : L = 198: DO: RANDOMIZE TIMER: R = INT(RND * 160 + RND * 160): C = INT(R / 29 + 2): C = C + 2 * (C - 7) * (C > 7): I = L: DO: ERASE T%: GET (R, I + 1)-(R, I + 1), T%: PSET (R, I), C: PRESET (R, I - 1): I = I + 1: LOOP WHILE (I < 199 AND T%(2) = 0): T = I - 1 = L: L = L + T: SOUND 4000, .05: LOOP UNTIL L = 10: LOOP

