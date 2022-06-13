DECLARE SUB SHOWWIN (C%, R%, p%, COLOUR%)
DECLARE SUB MAKEMOVE (X%, Y%, Z%, COLOUR%)
DECLARE SUB GETMOVE (X%, Y%, Z%)
DefInt A-Z
Dim E(7), PEEKB(1999)
Randomize Timer
Cls
GoSub INIT
E(1) = 254: E(2) = 18: E(3) = 2: E(4) = 1: E(5) = 2: E(6) = 66: E(7) = 255
Q = 564: G = 628: L = 768
For K = G To G + 63
    PEEKB(K) = 128
Next
For K = S To S + 75
    PEEKB(K) = 128
Next
100 Call GETMOVE(C, R, p)
X = 16 * (p - 1) + 4 * (R - 1) + C - 1
If PEEKB(G + X) <> 128 Then GoTo 100
Call MAKEMOVE(C, R, p, 1)
M = -1: GoSub 1000
GoSub 2000
If W Then Call SHOWWIN(C, R, p, 1): End
If T Then Locate 15, 33: Print " --- Tie game --- ": End
GoSub 3000
M = 1: GoSub 1000
GoSub 2000
GoSub 7000
If W Then Call SHOWWIN(C, R, p, 4): End
If T Then Locate 15, 33: Print " --- Tie game --- ": End
GoTo 100

1000
PEEKB(G + X) = 128 + M
For K = L To L + 303
    If PEEKB(K) <> X Then GoTo 1001
    Y = S + (K - L) \ 4: V = PEEKB(Y)
    If V = 0 Then GoTo 1001
    V = V - 128
    If V = 0 Then
        V = M + 128
    Else
        If (Sgn(V) = Sgn(M)) Then
            V = V + M + 128
        Else
            V = 0
        End If
    End If
    PEEKB(Y) = V
1001 Next
Return

2000
W = 0: T = 1
For K = S To S + 75
    V = PEEKB(K)
    If V Then T = 0
    If Abs(V - 128) = 4 Then W = 1
Next
Return

3000
For K = Q To Q + 63
    PEEKB(K) = 0
Next
For K = S To S + 75
    N = PEEKB(K) - 128
    If N = -128 Then GoTo 3002
    Z = E(N + 4)
    F = L + 4 * (K - S)
    For J = F To F + 3
        X = PEEKB(J)
        If PEEKB(G + X) <> 128 Then GoTo 3001
        V = PEEKB(Q + X)
        If V >= 254 Then GoTo 3001
        V = V + Z: If Z >= 254 Then V = Z
        If V > 255 Then V = 255
        PEEKB(Q + X) = V
    3001 Next
3002 Next
V9 = 0
For K = 0 To 63
    V = PEEKB(Q + K)
    If V > 64 And V < 128 Then V = V - 64
    If V > 16 And V < 32 Then V = V - 16
    If V > V9 Then V9 = V
    PEEKB(Q + K) = V
Next
If V9 < 32 Then GoTo 4000
3800 X = 0
Do
    If PEEKB(Q + X) = V9 Then Return
    X = X + 1
Loop
4000 P4 = 16
For K = L To L + 287 Step 16
    p = 0
    For J = K To K + 15
        p = p + PEEKB(PEEKB(J) + G) - 128
    Next
    If p > P4 Then GoTo 4002
    If p < P4 Then
        P4 = p: V4 = 0: N4 = 0
    End If
    For J = K To K + 15
        X1 = PEEKB(J)
        V = PEEKB(Q + X1)
        If V = 0 Then GoTo 4001
        If V < V4 Then GoTo 4001
        If V > V4 Then
            V4 = V: N4 = 1
        Else
            N4 = N4 + 1
            If Int(Rnd(1) * N4) <> 0 Then GoTo 4001
        End If
        X = X1
    4001 Next
4002 Next
If V4 = 0 Then GoTo 3800
Return

7000
p = X \ 16 + 1
X = X - 16 * (p - 1)
R = X \ 4 + 1
C = (X Mod 4) + 1
Call MAKEMOVE(C, R, p, 4)
Return


INIT:
L = 768
For K = 0 To 63
    PEEKB(L + K) = K
Next
L = L + 64
a = 4: B = 16
For S = 1 To 4
    GoSub 19000
Next
a = 16: B = 1
For S = 1 To 13 Step 4
    GoSub 19000
Next
S = 1: a = 5: B = 16: GoSub 19000
S = 13: a = -3: B = 16: GoSub 19000
S = 1: a = 20: B = 1: GoSub 19000
S = 49: a = -12: B = 1: GoSub 19000
S = 1: a = 17: B = 4: GoSub 19000
S = 49: a = -15: B = 4: GoSub 19000
S = 1: D = 21: GoSub 18000
S = 16: D = 11: GoSub 18000
S = 4: D = 19: GoSub 18000
S = 13: D = 13: GoSub 18000
GoSub DRAWBD
Return

18000
For K = S To S + 3 * D Step D
    PEEKB(L) = K - 1: L = L + 1
Next
Return

19000
For J = S To S + 3 * B Step B
    For K = J To J + 3 * a Step a
        PEEKB(L) = K - 1: L = L + 1
    Next
Next
Return

DRAWBD:
Screen 12
Line (0, 0)-(639, 479), 7, BF
Line (23, 23)-(616, 456), 0, B
Line (24, 24)-(615, 455), 14, BF
Y = 130: GoSub GRID
Y = 230: GoSub GRID
Y = 330: GoSub GRID
Y = 430: GoSub GRID
Paint (24, 24), 3, 0
Return

GRID:
For K = 0 To 4
    Line (120 + 20 * K, Y - 20 * K)-(440 + 20 * K, Y - 20 * K), 0
    Line (120 + 80 * K, Y)-(200 + 80 * K, Y - 80), 0
    Line (117 - K, Y + 2)-(201 - K, Y - 82), 0
    Line (437 + K, Y + 2)-(521 + K, Y - 82), 0
Next
For K = 0 To 1
    Line (117 - K, Y + K + 1)-(437 + K, Y + K + 1), 0
    Line (201 - K, Y - 81 - K)-(521 + K, Y - 81 - K), 0
Next
Return

Sub GETMOVE (X, Y, Z)
    GETPOS:
    If InKey$ = Chr$(27) Then End
    Call getmouse(XX, YY, ZZ)
    Z = (YY - 30) \ 100 + 1
    If Z < 1 Or Z > 4 Then GoTo GETPOS
    Y = ((YY - 30) \ 20) Mod 5
    If Y < 1 Or Y > 4 Then GoTo GETPOS
    If XX + YY - 150 - 100 * Z < 0 Then GoTo GETPOS
    X = (XX + YY - 150 - 100 * Z) \ 80 + 1
    If X < 1 Or X > 4 Then GoTo GETPOS
    If ZZ = 0 Then GoTo GETPOS
End Sub

Sub MAKEMOVE (X, Y, Z, COLOUR)
    Circle (80 * X - 20 * Y + 170, 100 * Z + 20 * Y - 60), 35, 8, , , 4 * (8 / 35) / 3
    Paint Step(0, 0), COLOUR, 8
    Circle (80 * X - 20 * Y + 170, 100 * Z + 20 * Y - 60), 15, 8, , , 4 * (3 / 15) / 3
    Paint Step(0, 0), COLOUR + 8, 8
End Sub

Sub SHOWWIN (C, R, p, COLOUR)
    Dim CC(0 To 3), RR(0 To 3), PP(0 To 3)
    For DC = -1 To 1
        For DR = -1 To 1
            For DP = -1 To 1
                If DC <> 0 Or DR <> 0 Or DP <> 0 Then
                    NDX = 0
                    For K = -3 To 3
                        If C + K * DC < 1 Or C + K * DC > 4 Then GoTo 1
                        If R + K * DR < 1 Or R + K * DR > 4 Then GoTo 1
                        If p + K * DP < 1 Or p + K * DP > 4 Then GoTo 1
                        ID = Point(80 * (C + K * DC) - 20 * (R + K * DR) + 170, 100 * (p + K * DP) + 20 * (R + K * DR) - 60)
                        If ID <> COLOUR + 8 Then Exit For
                        CC(NDX) = C + K * DC
                        RR(NDX) = R + K * DR
                        PP(NDX) = p + K * DP
                        NDX = NDX + 1
                        If NDX = 4 Then GoTo SHOW
                    1 Next
                End If
            Next
        Next
    Next
    SHOW:
    For K = 0 To 3
        Circle (80 * CC(K) - 20 * RR(K) + 170, 100 * PP(K) + 20 * RR(K) - 60), 35, COLOUR + 8, , , 4 * (8 / 35) / 3
        Paint Step(0, 0), COLOUR + 8
        Circle Step(0, 0), 15, 15, , , 4 * (3 / 15) / 3
        Paint Step(0, 0), 15
    Next
End Sub

Sub getmouse (x%, y%, b%)
    b% = 0
    wheel% = 0
    Do
        If _MouseButton(1) Then b% = b% Or 1
        If _MouseButton(2) Then b% = b% Or 2
        If _MouseButton(3) Then b% = b% Or 4
    Loop Until _MouseInput = 0
    x% = _MouseX
    y% = _MouseY
End Sub

