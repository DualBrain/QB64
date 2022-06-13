'$lang:"qb" 'BO5.BAS 'kinem 'QB4.5
Screen 13: Dim circ(26): Circle (2, 2), 2: qb = (Point(2, 0) > 0): Cls
Line (1, 0)-(3, 0): Line (1, 4)-(3, 4): Line (0, 1)-(0, 3): Line (4, 1)-(4, 3)
Get (0, 0)-(4, 4), circ()
Line (0, 30)-(319, 50), 3, BF: Line (0, 70)-(319, 80), 2, BF: siz = 20
Line (0, 80)-(319, 90), 1, BF: Line (0, 0)-(319, 10), 4, BF: px = 160
Locate 25, 1: Print "press space to start";: Do: i$ = InKey$: vx = 2: vy = 2
Loop Until i$ = " ": Locate 25, 1: Print String$(20, 32);: bx = 80: by = 100
Put (bx - 2, by - 2), circ(), Xor
1 If opx <> px Or siz <> osiz Then Line (opx - 20, 192)-(opx + 20, 199), 0, BF
Line (px - siz, 192)-(px + siz, 199), 7, BF: opx = px: osiz = siz
Line (px - siz, 199)-(px - siz + 7, 192), 8
Line (px + siz, 199)-(px + siz - 7, 192), 8
i$ = Right$(InKey$, 1): If i$ = "M" And px < 317 - siz Then px = px + 3
If i$ = "K" And px > siz + 2 Then px = px - 3
Put (bx - 2, by - 2), circ(), Xor
bx = bx + vx: by = by + vy: If bx < 2 Then vx = Abs(vx): bx = 2
If bx > 317 Then vx = -Abs(vx): bx = 317
If by < 2 Then vy = Abs(vy): by = 2: If siz > 7 Then siz = siz - 1
Put (bx - 2, by - 2), circ(), Xor
bt = Point(bx, by): t = Timer: Do: Loop Until Timer - t >= .05
If bt And bt < 7 Then
    Put (bx - 2, by - 2), circ(), Xor
    vy = -vy: For r = 0 To RR Step 1: Circle (bx, by), r, 0
    Circle (bx, by + 1), r, 0: Next: Put (bx - 2, by - 2), circ(), Xor
    s = s + bt * (1 - (vy < 0)): Locate 1, 1: Print "score"; s: RR = RR + .5
End If: dx = bx - px
If by > 190 And Abs(dx) < siz + 1 Then vy = -vy: vx = vx + dx / siz
If i$ <> Chr$(27) And by < 193 GoTo 1
If Not qb Then t = Timer: Do: Loop Until Timer - t >= .25: Sleep

