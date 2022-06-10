'-----------------------------------------------------------------------------------------------------
'qtrek
'star trek themed game for QB64
'https://github.com/strathausen/qtrek.bas
'-----------------------------------------------------------------------------------------------------

'-----------------------------------------------------------------------------------------------------
' These are some metacommands and compiler options for QB64 to write modern & type-strict code
'-----------------------------------------------------------------------------------------------------
' This will disable prefixing all modern QB64 calls using a underscore prefix.
$NoPrefix
' Whatever indentifiers are not defined, should default to signed longs (ex. constants and functions).
DefInt A-Z
' All variables must be defined.
Option Explicit
' All arrays must be defined.
Option ExplicitArray
' Array lower bounds should always start from 1 unless explicitly specified.
' This allows a(4) as integer to have 4 members with index 1-4.
Option Base 1
' All arrays should be static by default. Allocate dynamic array using ReDim
'$Static
' This allows the executable window & it's contents to be resized.
$Resize:Smooth
'FullScreen SquarePixels , Smooth
Title "QTrek"
'-----------------------------------------------------------------------------------------------------

Dim Shared x%, y%, xp%, yp%, lx%, ly%, kstn%
Dim Shared ex%, ey%, enm%, ez%, ek%, eex%
Dim Shared snd%, snp%, cb%, cf%
Dim Shared trf%, punkte%, gshl%
Dim ys(0 To 49) As Integer, zs(0 To 49) As Integer, xs(0 To 49) As Single
Dim As Integer prm, lvl, str, qty, fv, pv, lv, lx2, fa
Dim As Integer pb(0 To 2), xp(0 To 2), yp(0 To 2)
Dim As Integer fb(0 To 5), xf(0 To 5), yf(0 To 5)

On Error GoTo errorhandler
Screen 13
'Umgebungsvariablen
prm% = Point(0, 0)
snp% = Point(1, 0)
lvl% = Point(2, 0)
Cls
Randomize Timer
Close
Palette 6, 60
Palette 5, 50
Palette 4, 40
Palette 3, 30
Palette 2, 20

'IF prm% = 0 THEN COLOR 12: PRINT : PRINT : PRINT : PRINT "  Sie mÅssen das Spiel mit der Datei": PRINT "  "; CHR$(34); "UNAD2.BAT"; CHR$(34); " starten!": SLEEP: SYSTEM

'Vorberechnungen fÅr Sterne
For str% = 0 To 49 + qty% * 10
    xs(str%) = Rnd * 320
    zs%(str%) = Rnd * 14 + 2
    ys%(str%) = Rnd * 180
Next

'Variablen
x% = 20
y% = 100
ex% = 300
ey% = 102
gshl% = 10
enm% = 15

Do

    For str% = 0 To 49
        PSet (xs(str%), ys%(str%)), 0
        xs(str%) = xs(str%) - zs%(str%) / 8 - 1
        If xs(str%) < 0 Then xs(str%) = 320
        PSet (xs(str%), ys%(str%)), zs%(str%) + 15
    Next

    gdisplay

    If KeyDown(18432) Then Line (x%, y%)-(x% + 20, y% + 9), 0, BF: y% = y% - 1
    If KeyDown(20480) Then Line (x%, y%)-(x% + 20, y% + 9), 0, BF: y% = y% + 1
    If KeyDown(19200) Then Line (x%, y%)-(x% + 20, y% + 9), 0, BF: x% = x% - 1
    If KeyDown(19712) Then Line (x%, y%)-(x% + 20, y% + 9), 0, BF: x% = x% + 1
    If KeyDown(110) Or KeyDown(78) Then fv% = 1
    If KeyDown(103) Or KeyDown(71) Then pv% = 1
    If KeyDown(104) Or KeyDown(72) Then If lv% = 0 Then lv% = 1
    If KeyDown(115) Or KeyDown(83) Then If snp% = 0 Then snp% = 1 Else snp% = 0

    bounce

    crash
    If enm% = 0 Then eex% = eex% + 1
    Line (ex%, ey%)-Step(21, 7), 0, BF 'öberzeichnen
    If eex% > 1 Then Line (ex%, ey% - 3)-(ex% + 25, ey% + 15), 0, BF
    'Fortbewegung
    ex% = ex% - 3
    'Durchlauf
    If ex% < -25 Then ex% = 340: enm% = 15: eex% = 0: snd% = 0: ey% = Int(Rnd * 100) + 50: punkte% = punkte% - 100
    'Sicherung
    If ey% > 170 Then ey% = 170: ez% = 0
    If ey% < 0 Then ey% = 0: ez% = 0

    If eex% = 1 Then trf% = trf% + 1: punkte% = punkte% + 400
    Select Case Int(eex% / 2)
        Case 0: enemy
        Case 1: xxf1: snd% = 1
        Case 2: xxf2
        Case 3: xxf3
        Case 4: xxf4
        Case 5: xxf5
        Case 6: xxf6
        Case 7: xxf7
        Case 8: xxf8
        Case 9: xxf9
        Case 10: xxf10
        Case 11: xxf11
        Case 12: xxf12
        Case 13: Line (ex%, ey% - 3)-(ex% + 25, ey% + 15), 0, BF: ex% = -21: enm% = 15: eex% = 0
    End Select
    ship
    srnd

    ' Laser
    If lv% = 1 Then lx% = x% + 20: ly% = y% + 7: If ly% >= ey% And ly% <= ey% + 7 And ex% > x% And eex% = 0 Then lx2% = ex% + 7: snd% = 17: enm% = enm% - 4: punkte% = punkte% + 10 Else lx2% = 320: snd% = 17: punkte% = punkte% - 5
    If lv% >= 1 Then
        lv% = lv% + 1
        Line (lx%, ly%)-(lx2%, ly%), 46
        If lv% = 3 Then lv% = 0: Line (lx%, ly%)-(lx2%, ly%), 0
    End If

    ' Engine - Plasma
    For fa% = 0 To 2
        If pv% = 1 And pb%(fa%) = 0 Then pb%(fa%) = 1: pv% = 0: snd% = 21
        If pb%(fa%) = 1 Then xp%(fa%) = x% + 14: yp%(fa%) = y% + 7: pb%(fa%) = 2
        If pb%(fa%) = 2 Then
            xp%(fa%) = xp%(fa%) + 9
            Line (xp%(fa%), yp%(fa%))-(xp%(fa%) + 9, yp%(fa%)), 6
            Line (xp%(fa%), yp%(fa%))-(xp%(fa%) - 8, yp%(fa%)), 0
            If xp%(fa%) > 340 Then pb%(fa%) = 0: punkte% = punkte% - 7
            If xp%(fa%) > ex% And xp%(fa%) < ex% + 17 And yp%(fa%) >= ey% And yp%(fa%) <= ey% + 7 And eex% = 0 Then pb%(fa%) = 0: Line (xp%(fa%) + 9, yp%(fa%))-(xp%(fa%) - 8, yp%(fa%)), 0: enm% = enm% - 4: punkte% = punkte% + 14
        End If
    Next

    ' Photon Torpedos
    For fa% = 0 To 5
        If fv% = 1 And fb%(fa%) = 0 Then fb%(fa%) = 1: fv% = 0: snd% = 10
        If fb%(fa%) = 1 Then xf%(fa%) = x% + 16: yf%(fa%) = y% + 7: fb%(fa%) = 2
        If fb%(fa%) = 2 Then
            xf%(fa%) = xf%(fa%) + 3
            photon xf%(fa%), yf%(fa%)
            If xf%(fa%) > 320 Then fb%(fa%) = 0: punkte% = punkte% - 8
            If xf%(fa%) > ex% And xf%(fa%) < ex% + 21 And yf%(fa%) >= ey% And yf%(fa%) <= ey% + 7 And eex% = 0 And eex% = 0 Then fb%(fa%) = 0: Line (xf%(fa%), yf%(fa%) - 1)-(xf%(fa%) + 10, yf%(fa%) + 1), 0, BF: enm% = enm% - 5: punkte% = punkte% + 16
        End If
    Next

    Limit 60
Loop Until KeyDown(27)

System 0

'Handle errors by not handling errors
errorhandler:
Resume Next

Sub a
    PSet Step(3, -4), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%
End Sub

Sub ae
    PSet Step(2, -4), cf%
    PSet Step(3, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%
End Sub

Sub gdisplay
    cf% = 43
    Draw "bm5,198"
    kra

    box1
    empty 1
    : p: u: n: k: t: e: dpt
    cf% = 43 + 48
    prnumber punkte%, 4

    box1
    empty 1
    cf% = 43
    : t: r: e: f: f: e: r: dpt
    If trf% > 99 Then trf% = 99
    cf% = 43 + 48
    prnumber trf%, 2

    box1
    empty 1
    cf% = 43
    : s: c: h: i: l: d: e: dpt
    Line Step(3, -4)-Step(gshl% * 2, 4), 41, BF
    If gshl% = 10 Then Line Step(1, -4)-Step(0, 4), 41 Else Line Step(1, -4)-Step(20 - gshl% * 2, 4), 113, BF
    Draw "bm+2,0"

    box 30
    empty 1
    : f: e: i: n: d
    If enm% < 0 Then enm% = 0
    Line Step(3, -4)-Step(enm% * 2, 4), 41, BF
    If enm% = 15 Then Line Step(1, -4)-Step(0, 4), 41 Else Line Step(1, -4)-Step(30 - enm% * 2, 4), 113, BF
    Draw "bm+2,0"
    box1
    krz

End Sub

Sub b
    PSet Step(2, -4), cf%
    PSet Step(1, 0), cf%

    PSet Step(-1, 1), cf%
    PSet Step(2, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    Draw "bm+1, 0"
End Sub

Sub box (kbox As Integer)
    Line Step(3, -6)-Step(kbox%, 8), 104, B
    Paint Step(-1, -1), 32, 104
    Draw "bm+2,-1"
End Sub

Sub box1
    Line Step(3, -6)-Step(4, 8), 104, B
    Paint Step(-1, -1), 32, 104
    Draw "bm+1,-1"
End Sub

Sub c
    PSet Step(3, -4), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%

    PSet Step(0, 1), cf%

    PSet Step(0, 1), cf%

    PSet Step(1, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
End Sub

Sub crash
    If x% >= ex% - 20 And x% <= ex% + 15 And y% >= ey% - 8 And y% <= ey% + 7 And enm% > 0 Then enm% = 0: trf% = trf% - 1: punkte% = punkte% - 400: gshl% = gshl% - 1
End Sub

Sub d
    PSet Step(2, -4), cf%
    PSet Step(1, 0), cf%

    PSet Step(-1, 1), cf%
    PSet Step(2, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    Draw "bm+1, 0"
End Sub

Sub dpt
    PSet Step(2, -3), cf%

    PSet Step(0, 2), cf%

    Draw "bm+0,1"
End Sub

Sub e
    PSet Step(3, -4), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%

    PSet Step(0, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%

    PSet Step(0, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
End Sub

Sub f
    PSet Step(3, -4), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%

    PSet Step(0, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%

    PSet Step(0, 1), cf%
    Draw "bm+2, 0"
End Sub

Sub enemy
    'Jump line
    ez% = ez% + 1
    If ez% = 10 Then ek% = CInt(Rnd * 2 - 1): ez% = 0
    If ez% = 20 Then ek% = 0
    ey% = ey% + ek%
    PSet (ex% + 8, ey%), 178
    PSet (ex% + 9, ey%), 130
    PSet (ex% + 10, ey%), 24
    PSet (ex% + 11, ey%), 25
    PSet (ex% + 12, ey%), 24
    PSet (ex% + 13, ey%), 24
    PSet (ex% + 14, ey%), 24
    PSet (ex% + 15, ey%), 24
    PSet (ex% + 16, ey%), 23
    PSet (ex% + 17, ey%), 21
    PSet (ex% + 18, ey%), 19
    PSet (ex% + 5, ey% + 1), 178
    PSet (ex% + 6, ey% + 1), 106
    PSet (ex% + 7, ey% + 1), 106
    PSet (ex% + 8, ey% + 1), 106
    PSet (ex% + 9, ey% + 1), 130
    PSet (ex% + 10, ey% + 1), 154
    PSet (ex% + 11, ey% + 1), 25
    PSet (ex% + 12, ey% + 1), 25
    PSet (ex% + 13, ey% + 1), 25
    PSet (ex% + 14, ey% + 1), 25
    PSet (ex% + 15, ey% + 1), 25
    PSet (ex% + 16, ey% + 1), 25
    PSet (ex% + 17, ey% + 1), 24
    PSet (ex% + 18, ey% + 1), 23
    PSet (ex% + 19, ey% + 1), 22
    PSet (ex% + 20, ey% + 1), 19
    PSet (ex% + 2, ey% + 2), 178
    PSet (ex% + 3, ey% + 2), 106
    PSet (ex% + 4, ey% + 2), 106
    PSet (ex% + 5, ey% + 2), 106
    PSet (ex% + 6, ey% + 2), 130
    PSet (ex% + 7, ey% + 2), 154
    PSet (ex% + 8, ey% + 2), 24
    PSet (ex% + 9, ey% + 2), 24
    PSet (ex% + 10, ey% + 2), 24
    PSet (ex% + 11, ey% + 2), 24
    PSet (ex% + 12, ey% + 2), 21
    PSet (ex% + 13, ey% + 2), 22
    PSet (ex% + 14, ey% + 2), 23
    PSet (ex% + 15, ey% + 2), 25
    PSet (ex% + 16, ey% + 2), 25
    PSet (ex% + 17, ey% + 2), 25
    PSet (ex% + 18, ey% + 2), 25
    PSet (ex% + 19, ey% + 2), 24
    PSet (ex% + 20, ey% + 2), 23
    PSet (ex% + 21, ey% + 2), 20
    PSet (ex%, ey% + 3), 21
    PSet (ex% + 1, ey% + 3), 22
    PSet (ex% + 2, ey% + 3), 23
    PSet (ex% + 3, ey% + 3), 23
    PSet (ex% + 4, ey% + 3), 24
    PSet (ex% + 5, ey% + 3), 24
    PSet (ex% + 6, ey% + 3), 24
    PSet (ex% + 7, ey% + 3), 24
    PSet (ex% + 8, ey% + 3), 24
    PSet (ex% + 9, ey% + 3), 22
    PSet (ex% + 10, ey% + 3), 20
    PSet (ex% + 11, ey% + 3), 19
    PSet (ex% + 15, ey% + 3), 22
    PSet (ex% + 16, ey% + 3), 25
    PSet (ex% + 17, ey% + 3), 25
    PSet (ex% + 18, ey% + 3), 25
    PSet (ex% + 19, ey% + 3), 23
    PSet (ex% + 20, ey% + 3), 20
    PSet (ex% + 3, ey% + 4), 20
    PSet (ex% + 4, ey% + 4), 22
    PSet (ex% + 5, ey% + 4), 22
    PSet (ex% + 6, ey% + 4), 20
    PSet (ex% + 7, ey% + 4), 19
    PSet (ex% + 14, ey% + 4), 23
    PSet (ex% + 15, ey% + 4), 26
    PSet (ex% + 16, ey% + 4), 25
    PSet (ex% + 17, ey% + 4), 24
    PSet (ex% + 18, ey% + 4), 21
    PSet (ex% + 19, ey% + 4), 19
    PSet (ex% + 20, ey% + 4), 17
    PSet (ex% + 9, ey% + 5), 18
    PSet (ex% + 10, ey% + 5), 21
    PSet (ex% + 11, ey% + 5), 23
    PSet (ex% + 12, ey% + 5), 24
    PSet (ex% + 13, ey% + 5), 26
    PSet (ex% + 14, ey% + 5), 27
    PSet (ex% + 15, ey% + 5), 25
    PSet (ex% + 16, ey% + 5), 22
    PSet (ex% + 17, ey% + 5), 20
    PSet (ex% + 18, ey% + 5), 18
    PSet (ex% + 8, ey% + 6), 42
    PSet (ex% + 9, ey% + 6), 41
    PSet (ex% + 10, ey% + 6), 42
    PSet (ex% + 11, ey% + 6), 43
    PSet (ex% + 12, ey% + 6), 44
    PSet (ex% + 13, ey% + 6), 26
    PSet (ex% + 14, ey% + 6), 24
    PSet (ex% + 15, ey% + 6), 20
    PSet (ex% + 16, ey% + 6), 18
    PSet (ex% + 10, ey% + 7), 19
    PSet (ex% + 11, ey% + 7), 21
    PSet (ex% + 12, ey% + 7), 23
    PSet (ex% + 13, ey% + 7), 21
End Sub

Sub g
    PSet Step(3, -4), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%

    PSet Step(0, 1), cf%
    PSet Step(2, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
End Sub

Sub h
    PSet Step(2, -4), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%
End Sub

Sub i
    PSet Step(2, -4), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-1, 1), cf%

    PSet Step(0, 1), cf%

    PSet Step(0, 1), cf%

    PSet Step(-1, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
End Sub

Sub k
    PSet Step(2, -4), cf%
    PSet Step(2, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(2, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%
End Sub

Sub klma1
    PSet Step(3, -4), cf%

    PSet Step(-1, 1), cf%

    PSet Step(0, 1), cf%

    PSet Step(0, 1), cf%

    PSet Step(1, 1), cf%
End Sub

Sub klma2
    PSet Step(4, -4), cf%

    PSet Step(-1, 1), cf%

    PSet Step(-1, 1), cf%

    PSet Step(1, 1), cf%

    PSet Step(1, 1), cf%
End Sub

Sub klmz1
    PSet Step(2, -4), cf%

    PSet Step(1, 1), cf%

    PSet Step(0, 1), cf%

    PSet Step(0, 1), cf%

    PSet Step(-1, 1), cf%
    Draw "bm+1,0"
End Sub

Sub klmz2
    PSet Step(2, -4), cf%

    PSet Step(1, 1), cf%

    PSet Step(1, 1), cf%

    PSet Step(-1, 1), cf%

    PSet Step(-1, 1), cf%
    Draw "bm+2,0"
End Sub

Sub kra
    Circle Step(6, -3), 5, 104, Pi / 2.1, 3.1 * Pi / 2
    Line Step(0, 4)-Step(0, -8), 104
    Paint Step(-4, 3), 32, 104
    Draw "bm+4, 3"
End Sub

Sub krz
    Circle Step(3, -2), 5, 104, 2.9 * Pi / 2, Pi / 2
    Line Step(0, 4)-Step(0, -8), 104
    Paint Step(4, 3), 32, 104
    Draw "bm+1, 3"
End Sub

Sub l
    PSet Step(2, -4), cf%

    PSet Step(0, 1), cf%

    PSet Step(0, 1), cf%

    PSet Step(0, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
End Sub

Sub empty (lr As Integer)
    Draw "bm +" + Str$(lr%) + ",0"
End Sub

Sub empty2
    PSet Step(1, -4), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
End Sub

Sub m
    PSet Step(3, -4), cf%
    PSet Step(2, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(2, 0), cf%
    PSet Step(2, 0), cf%

    PSet Step(-4, 1), cf%
    PSet Step(4, 0), cf%

    PSet Step(-4, 1), cf%
    PSet Step(4, 0), cf%
End Sub

Sub minus
    PSet Step(1, -4), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
End Sub

Sub n
    PSet Step(2, -4), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(2, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(2, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%
         
    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%
End Sub

Sub o
    PSet Step(3, -4), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(1, 0), cf%
    Draw "bm+1, 0"
End Sub

Sub oe
    PSet Step(2, -4), cf%
    PSet Step(3, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(1, 0), cf%
    Draw "bm+1, 0"
End Sub

Sub p
    PSet Step(3, -4), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%

    PSet Step(0, 1), cf%
    Draw "bm+3, 0"
End Sub

Sub photon (xf As Integer, yf As Integer)
    PSet (xf% + 3, yf% - 1), 0
    PSet (xf% + 4, yf% - 1), 0
    PSet (xf% + 5, yf% - 1), 0
    PSet (xf% + 6, yf% - 1), 185 + Int(Rnd * 3)
    PSet (xf% + 7, yf% - 1), 113 + Int(Rnd * 3)
    PSet (xf% + 8, yf% - 1), 41 + Int(Rnd * 3)
    PSet (xf% + 9, yf% - 1), 113 + Int(Rnd * 3)
    PSet (xf% + 1, yf%), 0
    PSet (xf% + 2, yf%), 0
    PSet (xf% + 3, yf%), 0
    PSet (xf% + 4, yf%), 185 + Int(Rnd * 3)
    PSet (xf% + 5, yf%), 113 + Int(Rnd * 3)
    PSet (xf% + 6, yf%), 113 + Int(Rnd * 3)
    PSet (xf% + 7, yf%), 41 + Int(Rnd * 3)
    PSet (xf% + 8, yf%), 41 + Int(Rnd * 3)
    PSet (xf% + 9, yf%), 41 + Int(Rnd * 3)
    PSet (xf% + 10, yf%), 113 + Int(Rnd * 3)
    PSet (xf% + 3, yf% + 1), 0
    PSet (xf% + 4, yf% + 1), 0
    PSet (xf% + 5, yf% + 1), 0
    PSet (xf% + 6, yf% + 1), 185 + Int(Rnd * 3)
    PSet (xf% + 7, yf% + 1), 113 + Int(Rnd * 3)
    PSet (xf% + 8, yf% + 1), 41 + Int(Rnd * 3)
    PSet (xf% + 9, yf% + 1), 113 + Int(Rnd * 3)
End Sub

Sub punkt
    PSet Step(2, 0), cf%
End Sub

Sub q
    PSet Step(3, -4), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(2, 0), cf%

    PSet Step(-1, 1), cf%
    PSet Step(2, 0), cf%
End Sub

Sub r
    PSet Step(3, -4), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(2, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(3, 0), cf%
End Sub

Sub s
    PSet Step(3, -4), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-3, 1), cf%

    PSet Step(1, 1), cf%
    PSet Step(1, 0), cf%

    PSet Step(1, 1), cf%

    PSet Step(-3, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    Draw "bm+1, 0"
End Sub

Sub ship
    PSet (x% + 3, y%), 20
    PSet (x% + 4, y%), 22
    PSet (x% + 5, y%), 23
    PSet (x% + 6, y%), 23
    PSet (x% + 7, y%), 21
    PSet (x% + 8, y%), 177
    PSet (x% + 2, y% + 1), 21
    PSet (x% + 3, y% + 1), 23
    PSet (x% + 4, y% + 1), 23
    PSet (x% + 5, y% + 1), 21
    PSet (x% + 6, y% + 1), 21
    PSet (x% + 7, y% + 1), 201
    PSet (x% + 8, y% + 1), 105
    PSet (x% + 9, y% + 1), 105
    PSet (x% + 10, y% + 1), 177
    PSet (x% + 11, y% + 1), 177
    PSet (x% + 1, y% + 2), 21
    PSet (x% + 2, y% + 2), 23
    PSet (x% + 3, y% + 2), 23
    PSet (x% + 4, y% + 2), 22
    PSet (x% + 5, y% + 2), 21
    PSet (x% + 6, y% + 2), 200
    PSet (x% + 7, y% + 2), 105
    PSet (x% + 8, y% + 2), 104
    PSet (x% + 9, y% + 2), 104
    PSet (x% + 10, y% + 2), 104
    PSet (x% + 11, y% + 2), 104
    PSet (x% + 12, y% + 2), 105
    PSet (x% + 13, y% + 2), 177
    PSet (x% + 14, y% + 2), 177
    PSet (x%, y% + 3), 20
    PSet (x% + 1, y% + 3), 23
    PSet (x% + 2, y% + 3), 23
    PSet (x% + 3, y% + 3), 22
    PSet (x% + 4, y% + 3), 21
    PSet (x% + 5, y% + 3), 21
    PSet (x% + 6, y% + 3), 21
    PSet (x% + 7, y% + 3), 200
    PSet (x% + 8, y% + 3), 105
    PSet (x% + 9, y% + 3), 105
    PSet (x% + 10, y% + 3), 200
    PSet (x% + 11, y% + 3), 223
    PSet (x% + 12, y% + 3), 21
    PSet (x% + 13, y% + 3), 21
    PSet (x% + 14, y% + 3), 20
    PSet (x% + 15, y% + 3), 19
    PSet (x% + 16, y% + 3), 18
    PSet (x%, y% + 4), 21
    PSet (x% + 1, y% + 4), 22
    PSet (x% + 2, y% + 4), 21
    PSet (x% + 3, y% + 4), 20
    PSet (x% + 4, y% + 4), 20
    PSet (x% + 5, y% + 4), 20
    PSet (x% + 6, y% + 4), 21
    PSet (x% + 7, y% + 4), 21
    PSet (x% + 8, y% + 4), 21
    PSet (x% + 9, y% + 4), 21
    PSet (x% + 10, y% + 4), 21
    PSet (x% + 11, y% + 4), 21
    PSet (x% + 12, y% + 4), 20
    PSet (x% + 13, y% + 4), 19
    PSet (x% + 14, y% + 4), 19
    PSet (x% + 15, y% + 4), 18
    PSet (x% + 16, y% + 4), 17
    PSet (x% + 1, y% + 5), 18
    PSet (x% + 2, y% + 5), 19
    PSet (x% + 3, y% + 5), 19
    PSet (x% + 4, y% + 5), 19
    PSet (x% + 5, y% + 5), 19
    PSet (x% + 6, y% + 5), 19
    PSet (x% + 7, y% + 5), 20
    PSet (x% + 8, y% + 5), 21
    PSet (x% + 9, y% + 5), 21
    PSet (x% + 10, y% + 5), 20
    PSet (x% + 11, y% + 5), 19
    PSet (x% + 12, y% + 5), 18
    PSet (x% + 13, y% + 5), 17
    PSet (x% + 2, y% + 6), 17
    PSet (x% + 3, y% + 6), 18
    PSet (x% + 4, y% + 6), 18
    PSet (x% + 5, y% + 6), 18
    PSet (x% + 6, y% + 6), 18
    PSet (x% + 7, y% + 6), 18
    PSet (x% + 8, y% + 6), 21
    PSet (x% + 9, y% + 6), 22
    PSet (x% + 10, y% + 6), 23
    PSet (x% + 11, y% + 6), 23
    PSet (x% + 12, y% + 6), 23
    PSet (x% + 13, y% + 6), 23
    PSet (x% + 14, y% + 6), 22
    PSet (x% + 15, y% + 6), 23
    PSet (x% + 16, y% + 6), 117
    PSet (x% + 17, y% + 6), 189
    PSet (x% + 6, y% + 7), 23
    PSet (x% + 8, y% + 7), 24
    PSet (x% + 10, y% + 7), 24
    PSet (x% + 12, y% + 7), 25
    PSet (x% + 13, y% + 7), 24
    PSet (x% + 14, y% + 7), 24
    PSet (x% + 15, y% + 7), 144
    PSet (x% + 16, y% + 7), 44 + Int(Rnd * -4)
    PSet (x% + 17, y% + 7), 43 + Int(Rnd * -4)
    PSet (x% + 18, y% + 7), 117
    PSet (x% + 19, y% + 7), 189
    PSet (x% + 7, y% + 8), 19
    PSet (x% + 8, y% + 8), 20
    PSet (x% + 9, y% + 8), 20
    PSet (x% + 10, y% + 8), 21
    PSet (x% + 11, y% + 8), 21
    PSet (x% + 12, y% + 8), 21
    PSet (x% + 13, y% + 8), 21
    PSet (x% + 14, y% + 8), 21
    PSet (x% + 15, y% + 8), 22
    PSet (x% + 16, y% + 8), 117
    PSet (x% + 17, y% + 8), 189

    kstn% = kstn% + 1
    Select Case kstn%
        Case 1
            PSet (x% + 4, y% + 7), 6
            PSet (x% + 5, y% + 7), 5
            PSet (x% + 7, y% + 7), 4
            PSet (x% + 9, y% + 7), 3
            PSet (x% + 11, y% + 7), 2
        Case 2
            PSet (x% + 4, y% + 7), 5
            PSet (x% + 5, y% + 7), 4
            PSet (x% + 7, y% + 7), 3
            PSet (x% + 9, y% + 7), 2
            PSet (x% + 11, y% + 7), 6
        Case 3
            PSet (x% + 4, y% + 7), 4
            PSet (x% + 5, y% + 7), 3
            PSet (x% + 7, y% + 7), 2
            PSet (x% + 9, y% + 7), 6
            PSet (x% + 11, y% + 7), 5
        Case 4
            PSet (x% + 4, y% + 7), 3
            PSet (x% + 5, y% + 7), 2
            PSet (x% + 7, y% + 7), 6
            PSet (x% + 9, y% + 7), 5
            PSet (x% + 11, y% + 7), 4
        Case 5
            PSet (x% + 4, y% + 7), 2
            PSet (x% + 5, y% + 7), 6
            PSet (x% + 7, y% + 7), 5
            PSet (x% + 9, y% + 7), 4
            PSet (x% + 11, y% + 7), 3
            kstn% = 0
    End Select
End Sub

Sub bounce
    If x% > 300 Then x% = 300
    If x% < 0 Then x% = 0
    If y% > 180 Then y% = 180
    If y% < 0 Then y% = 0
End Sub

Sub srnd
    If snp% = 0 Then snd% = 0 Else Play "l64"
    Select Case snd%

        Case 0
            Play "p64"

        Case 1 'Explosion
            Play "n15"
            snd% = 2
        Case 2
            Play "n25"
            snd% = 3
        Case 3
            Play "n10"
            snd% = 4
        Case 4
            Play "n20"
            snd% = 5
        Case 5
            Play "n16"
            snd% = 6
        Case 6
            Play "n12"
            snd% = 7
        Case 7
            Play "n29"
            snd% = 8
        Case 8
            Play "n17"
            snd% = 9
        Case 9
            Play "n20"
            snd% = 0

        Case 10 'Torpedos
            Play "n20"
            snd% = 11
        Case 11
            Play "n22"
            snd% = 12
        Case 12
            Play "n24"
            snd% = 13
        Case 13
            Play "n26"
            snd% = 14
        Case 14
            Play "n28"
            snd% = 15
        Case 15
            Play "n30"
            snd% = 0

        Case 17 'Phaser
            Play "n32"
            snd% = 18
        Case 18
            Play "n31"
            snd% = 19
        Case 19
            Play "n32"
            snd% = 0

        Case 21 'Plasma
            Play "n28"
            snd% = 22
        Case 22
            Play "n27"
            snd% = 23
        Case 23
            Play "n26"
            snd% = 24
        Case 24
            Play "n24"
            snd% = 25
        Case 25
            Play "n22"
            snd% = 26
        Case 26
            Play "n20"
            snd% = 0

    End Select
End Sub

Sub stars
    PSet (226, 9), 23
    PSet (245, 10), 25
    PSet (4, 152), 29
    PSet (207, 52), 21
    PSet (149, 59), 26
    PSet (92, 60), 28
    PSet (303, 72), 24
    PSet (225, 106), 25
    PSet (276, 158), 22
    PSet (307, 174), 17
    PSet (265, 164), 25
    PSet (315, 182), 20
    PSet (222, 36), 20
    PSet (170, 21), 31
    PSet (216, 3), 25
    PSet (32, 20), 28
    PSet (91, 9), 21
    PSet (122, 60), 31
    PSet (313, 80), 21
    PSet (51, 32), 26
    PSet (131, 82), 27
    PSet (104, 126), 20
    PSet (59, 116), 18
    PSet (146, 181), 20
    PSet (251, 75), 21
    PSet (294, 126), 26
    PSet (137, 19), 25
    PSet (222, 182), 29
    PSet (7, 108), 30
    PSet (137, 135), 24
    PSet (164, 92), 22
    PSet (129, 53), 17
    PSet (78, 145), 17
    PSet (124, 72), 24
    PSet (49, 94), 20
    PSet (201, 108), 19
    PSet (300, 130), 24
    PSet (124, 21), 28
    PSet (147, 150), 25
    PSet (266, 3), 20
    PSet (23, 21), 21
    PSet (41, 0), 25
    PSet (210, 108), 29
    PSet (26, 38), 27
    PSet (145, 71), 19
    PSet (225, 185), 24
    PSet (28, 151), 23
    PSet (147, 98), 20
    PSet (105, 19), 25
    PSet (54, 185), 18
    PSet (142, 54), 30
    PSet (240, 54), 27
    PSet (82, 17), 17
    PSet (103, 158), 21
    PSet (75, 96), 20
    PSet (108, 8), 24
    PSet (65, 172), 25
    PSet (241, 185), 21
    PSet (173, 16), 26
    PSet (131, 122), 18
    PSet (295, 124), 22
    PSet (47, 95), 20
    PSet (317, 26), 17
    PSet (110, 109), 30
    PSet (172, 81), 29
    PSet (264, 134), 27
    PSet (318, 67), 24
    PSet (132, 139), 19
    PSet (135, 108), 29
    PSet (173, 85), 24
    PSet (72, 123), 24
    PSet (217, 177), 22
    PSet (96, 58), 19
    PSet (169, 44), 25
    PSet (116, 175), 24
    PSet (61, 136), 28
    PSet (196, 156), 19
    PSet (258, 40), 31
    PSet (21, 12), 28
    PSet (121, 92), 18
    PSet (36, 34), 17
    PSet (228, 106), 25
    PSet (69, 93), 28
    PSet (240, 79), 30
    PSet (238, 17), 26
    PSet (228, 3), 23
    PSet (128, 55), 31
    PSet (256, 139), 23
    PSet (235, 55), 22
    PSet (138, 188), 18
    PSet (206, 69), 18
    PSet (59, 15), 23
    PSet (306, 108), 24
    PSet (311, 43), 22
    PSet (126, 56), 24
    PSet (44, 103), 31
    PSet (178, 181), 26
    PSet (141, 138), 17
    PSet (241, 140), 24
    PSet (49, 44), 21
    PSet (251, 10), 24
    PSet (242, 160), 21
    PSet (311, 160), 27
    PSet (289, 175), 23
    PSet (39, 120), 28
    PSet (222, 80), 17
    PSet (53, 32), 24
    PSet (129, 21), 21
    PSet (205, 169), 24
    PSet (60, 179), 22
    PSet (103, 154), 20
    PSet (143, 47), 30
    PSet (195, 74), 22
    PSet (275, 117), 30
    PSet (165, 66), 30
    PSet (82, 51), 19
    PSet (111, 0), 28
    PSet (269, 55), 27
    PSet (129, 162), 28
    PSet (140, 15), 23
    PSet (108, 142), 21
    PSet (255, 30), 25
    PSet (305, 48), 31
    PSet (36, 96), 26
    PSet (191, 180), 25
    PSet (78, 172), 18
    PSet (140, 151), 20
    PSet (121, 79), 24
    PSet (86, 116), 20
    PSet (25, 179), 18
    PSet (208, 180), 20
    PSet (303, 169), 23
    PSet (157, 153), 29
    PSet (122, 39), 21
    PSet (132, 30), 26
    PSet (31, 41), 27
    PSet (161, 36), 31
    PSet (150, 0), 23
    PSet (92, 150), 30
    PSet (263, 35), 18
    PSet (3, 30), 22
    PSet (60, 125), 30
    PSet (186, 145), 19
    PSet (82, 5), 29
    PSet (250, 158), 21
    PSet (144, 111), 29
    PSet (180, 40), 20
    PSet (116, 114), 22
    PSet (169, 85), 25
    PSet (16, 109), 20
    PSet (308, 186), 31
    PSet (268, 81), 29
    PSet (316, 51), 19
    PSet (222, 3), 22
    PSet (221, 22), 18
    PSet (92, 79), 25
    PSet (99, 59), 29
    PSet (99, 75), 23
    PSet (269, 81), 27
    PSet (210, 81), 31
    PSet (206, 103), 20
    PSet (186, 149), 23
    PSet (289, 56), 27
    PSet (284, 56), 22
    PSet (4, 58), 31
    PSet (243, 116), 26
    PSet (85, 101), 28
    PSet (274, 18), 25
    PSet (132, 14), 23
    PSet (223, 99), 23
    PSet (302, 16), 25
    PSet (170, 123), 18
    PSet (59, 56), 17
    PSet (48, 84), 25
    PSet (178, 156), 17
    PSet (129, 11), 21
    PSet (192, 103), 25
    PSet (105, 181), 28
    PSet (184, 86), 27
    PSet (52, 11), 20
    PSet (242, 100), 22
    PSet (218, 158), 17
    PSet (254, 96), 20
    PSet (192, 181), 31
    PSet (209, 2), 26
    PSet (308, 1), 31
    PSet (23, 58), 25
    PSet (258, 8), 17
    PSet (180, 62), 23
    PSet (163, 146), 23
    PSet (103, 14), 23
    PSet (183, 152), 25
    PSet (208, 161), 23
    PSet (255, 144), 27
    PSet (233, 38), 28
    PSet (22, 49), 31
    PSet (262, 43), 19
    PSet (75, 185), 20
    PSet (81, 142), 26
    PSet (247, 151), 21
    PSet (263, 143), 30
End Sub

Sub sz
    PSet Step(3, -4), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(2, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(2, 0), cf%
    Draw "bm+1, 0"
End Sub

Sub t
    PSet Step(2, -4), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-2, 1), cf%

    PSet Step(0, 1), cf%

    PSet Step(0, 1), cf%

    PSet Step(0, 1), cf%
    Draw "bm+2, 0"
End Sub

Sub u
    PSet Step(2, -4), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(1, 0), cf%
    Draw "bm+1, 0"
End Sub

Sub ue
    PSet Step(2, -4), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 2), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-2, 1), cf%
    PSet Step(1, 0), cf%
    Draw "bm+1, 0"
End Sub

Sub v
    PSet Step(2, -4), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(3, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(2, 0), cf%

    PSet Step(-1, 1), cf%
    Draw "bm+2, 0"
End Sub

Sub w
    PSet Step(2, -4), cf%
    PSet Step(4, 0), cf%

    PSet Step(-4, 1), cf%
    PSet Step(2, 0), cf%
    PSet Step(2, 0), cf%

    PSet Step(-4, 1), cf%
    PSet Step(2, 0), cf%
    PSet Step(2, 0), cf%

    PSet Step(-4, 1), cf%
    PSet Step(2, 0), cf%
    PSet Step(2, 0), cf%

    PSet Step(-3, 1), cf%
    PSet Step(2, 0), cf%
    Draw "bm+1, 0"
End Sub

Sub xxf1
    PSet (ex% + 8, ey% + 0), 178
    PSet (ex% + 9, ey% + 0), 130
    PSet (ex% + 10, ey% + 0), 23
    PSet (ex% + 11, ey% + 0), 24
    PSet (ex% + 12, ey% + 0), 24
    PSet (ex% + 13, ey% + 0), 24
    PSet (ex% + 14, ey% + 0), 24
    PSet (ex% + 15, ey% + 0), 25
    PSet (ex% + 16, ey% + 0), 25
    PSet (ex% + 17, ey% + 0), 24
    PSet (ex% + 18, ey% + 0), 21
    PSet (ex% + 19, ey% + 0), 19
    PSet (ex% + 5, ey% + 1), 178
    PSet (ex% + 6, ey% + 1), 106
    PSet (ex% + 7, ey% + 1), 106
    PSet (ex% + 8, ey% + 1), 106
    PSet (ex% + 9, ey% + 1), 130
    PSet (ex% + 10, ey% + 1), 154
    PSet (ex% + 11, ey% + 1), 26
    PSet (ex% + 12, ey% + 1), 26
    PSet (ex% + 13, ey% + 1), 42
    PSet (ex% + 14, ey% + 1), 43
    PSet (ex% + 15, ey% + 1), 44
    PSet (ex% + 16, ey% + 1), 43
    PSet (ex% + 17, ey% + 1), 44
    PSet (ex% + 18, ey% + 1), 42
    PSet (ex% + 19, ey% + 1), 19
    PSet (ex% + 20, ey% + 1), 19
    PSet (ex% + 2, ey% + 2), 178
    PSet (ex% + 3, ey% + 2), 106
    PSet (ex% + 4, ey% + 2), 106
    PSet (ex% + 5, ey% + 2), 106
    PSet (ex% + 6, ey% + 2), 130
    PSet (ex% + 7, ey% + 2), 154
    PSet (ex% + 8, ey% + 2), 25
    PSet (ex% + 9, ey% + 2), 25
    PSet (ex% + 10, ey% + 2), 25
    PSet (ex% + 11, ey% + 2), 23
    PSet (ex% + 12, ey% + 2), 21
    PSet (ex% + 13, ey% + 2), 21
    PSet (ex% + 14, ey% + 2), 22
    PSet (ex% + 15, ey% + 2), 43
    PSet (ex% + 16, ey% + 2), 44
    PSet (ex% + 17, ey% + 2), 44
    PSet (ex% + 18, ey% + 2), 43
    PSet (ex% + 19, ey% + 2), 42
    PSet (ex% + 20, ey% + 2), 23
    PSet (ex% + 21, ey% + 2), 21
    PSet (ex% + 0, ey% + 3), 21
    PSet (ex% + 1, ey% + 3), 22
    PSet (ex% + 2, ey% + 3), 23
    PSet (ex% + 3, ey% + 3), 23
    PSet (ex% + 4, ey% + 3), 24
    PSet (ex% + 5, ey% + 3), 24
    PSet (ex% + 6, ey% + 3), 24
    PSet (ex% + 7, ey% + 3), 24
    PSet (ex% + 8, ey% + 3), 24
    PSet (ex% + 9, ey% + 3), 21
    PSet (ex% + 10, ey% + 3), 21
    PSet (ex% + 11, ey% + 3), 20
    PSet (ex% + 12, ey% + 3), 20
    PSet (ex% + 14, ey% + 3), 24
    PSet (ex% + 15, ey% + 3), 25
    PSet (ex% + 16, ey% + 3), 25
    PSet (ex% + 17, ey% + 3), 43
    PSet (ex% + 18, ey% + 3), 24
    PSet (ex% + 19, ey% + 3), 20
    PSet (ex% + 20, ey% + 3), 19
    PSet (ex% + 21, ey% + 3), 19
    PSet (ex% + 3, ey% + 4), 20
    PSet (ex% + 4, ey% + 4), 22
    PSet (ex% + 5, ey% + 4), 22
    PSet (ex% + 6, ey% + 4), 20
    PSet (ex% + 7, ey% + 4), 19
    PSet (ex% + 13, ey% + 4), 24
    PSet (ex% + 14, ey% + 4), 25
    PSet (ex% + 15, ey% + 4), 25
    PSet (ex% + 16, ey% + 4), 25
    PSet (ex% + 17, ey% + 4), 21
    PSet (ex% + 18, ey% + 4), 20
    PSet (ex% + 19, ey% + 4), 20
    PSet (ex% + 20, ey% + 4), 19
    PSet (ex% + 9, ey% + 5), 22
    PSet (ex% + 10, ey% + 5), 24
    PSet (ex% + 11, ey% + 5), 25
    PSet (ex% + 12, ey% + 5), 25
    PSet (ex% + 13, ey% + 5), 25
    PSet (ex% + 14, ey% + 5), 25
    PSet (ex% + 15, ey% + 5), 24
    PSet (ex% + 16, ey% + 5), 20
    PSet (ex% + 17, ey% + 5), 20
    PSet (ex% + 18, ey% + 5), 19
    PSet (ex% + 8, ey% + 6), 42
    PSet (ex% + 9, ey% + 6), 41
    PSet (ex% + 10, ey% + 6), 42
    PSet (ex% + 11, ey% + 6), 43
    PSet (ex% + 12, ey% + 6), 44
    PSet (ex% + 13, ey% + 6), 25
    PSet (ex% + 14, ey% + 6), 20
    PSet (ex% + 15, ey% + 6), 19
    PSet (ex% + 16, ey% + 6), 19
    PSet (ex% + 9, ey% + 7), 20
    PSet (ex% + 10, ey% + 7), 21
    PSet (ex% + 11, ey% + 7), 22
    PSet (ex% + 12, ey% + 7), 22
    PSet (ex% + 13, ey% + 7), 20
    PSet (ex% + 14, ey% + 7), 19
End Sub

Sub xxf10
    PSet (ex% + 15, ey% + -1), 40
    PSet (ex% + 16, ey% + -1), 41
    PSet (ex% + 13, ey% + 0), 41
    PSet (ex% + 14, ey% + 0), 40
    PSet (ex% + 15, ey% + 0), 42
    PSet (ex% + 16, ey% + 0), 40
    PSet (ex% + 17, ey% + 0), 40
    PSet (ex% + 8, ey% + 1), 40
    PSet (ex% + 14, ey% + 1), 40
    PSet (ex% + 16, ey% + 3), 40
    PSet (ex% + 19, ey% + 3), 41
    PSet (ex% + 21, ey% + 3), 40
    PSet (ex% + 8, ey% + 4), 40
    PSet (ex% + 13, ey% + 4), 42
    PSet (ex% + 14, ey% + 4), 40
    PSet (ex% + 20, ey% + 4), 41
    PSet (ex% + 11, ey% + 5), 41
    PSet (ex% + 9, ey% + 6), 41
    PSet (ex% + 15, ey% + 6), 42
    PSet (ex% + 19, ey% + 6), 42
    PSet (ex% + 12, ey% + 7), 41
    PSet (ex% + 14, ey% + 7), 41
    PSet (ex% + 15, ey% + 7), 42
    PSet (ex% + 16, ey% + 7), 41
    PSet (ex% + 17, ey% + 7), 42
    PSet (ex% + 11, ey% + 8), 41
    PSet (ex% + 13, ey% + 8), 42
    PSet (ex% + 14, ey% + 8), 41
    PSet (ex% + 15, ey% + 8), 41
    PSet (ex% + 11, ey% + 9), 40
    PSet (ex% + 12, ey% + 9), 41
    PSet (ex% + 13, ey% + 9), 41
    PSet (ex% + 14, ey% + 9), 40
    PSet (ex% + 12, ey% + 10), 40
End Sub

Sub xxf11
    PSet (ex% + 13, ey% + 0), 41
    PSet (ex% + 16, ey% + 0), 40
    PSet (ex% + 14, ey% + 1), 40
    PSet (ex% + 21, ey% + 3), 43
    PSet (ex% + 14, ey% + 4), 40
    PSet (ex% + 15, ey% + 6), 42
    PSet (ex% + 12, ey% + 7), 41
    PSet (ex% + 13, ey% + 8), 41
    PSet (ex% + 14, ey% + 8), 43
    PSet (ex% + 15, ey% + 8), 41
    PSet (ex% + 11, ey% + 9), 42
    PSet (ex% + 13, ey% + 9), 43
    PSet (ex% + 12, ey% + 10), 40
End Sub

Sub xxf12
    PSet (ex% + 14, ey% + 8), 40
    PSet (ex% + 11, ey% + 9), 41
    PSet (ex% + 13, ey% + 9), 42
    PSet (ex% + 14, ey% + 10), 40
End Sub

Sub xxf2
    PSet (ex% + 16, ey% + -1), 41
    PSet (ex% + 8, ey% + 0), 178
    PSet (ex% + 9, ey% + 0), 130
    PSet (ex% + 10, ey% + 0), 23
    PSet (ex% + 11, ey% + 0), 24
    PSet (ex% + 12, ey% + 0), 42
    PSet (ex% + 13, ey% + 0), 24
    PSet (ex% + 14, ey% + 0), 24
    PSet (ex% + 15, ey% + 0), 42
    PSet (ex% + 16, ey% + 0), 42
    PSet (ex% + 17, ey% + 0), 41
    PSet (ex% + 18, ey% + 0), 21
    PSet (ex% + 19, ey% + 0), 19
    PSet (ex% + 5, ey% + 1), 178
    PSet (ex% + 6, ey% + 1), 106
    PSet (ex% + 7, ey% + 1), 106
    PSet (ex% + 8, ey% + 1), 106
    PSet (ex% + 9, ey% + 1), 130
    PSet (ex% + 10, ey% + 1), 154
    PSet (ex% + 11, ey% + 1), 42
    PSet (ex% + 12, ey% + 1), 43
    PSet (ex% + 13, ey% + 1), 43
    PSet (ex% + 14, ey% + 1), 42
    PSet (ex% + 15, ey% + 1), 43
    PSet (ex% + 16, ey% + 1), 43
    PSet (ex% + 17, ey% + 1), 44
    PSet (ex% + 18, ey% + 1), 42
    PSet (ex% + 19, ey% + 1), 19
    PSet (ex% + 20, ey% + 1), 19
    PSet (ex% + 2, ey% + 2), 178
    PSet (ex% + 3, ey% + 2), 106
    PSet (ex% + 4, ey% + 2), 106
    PSet (ex% + 5, ey% + 2), 106
    PSet (ex% + 6, ey% + 2), 130
    PSet (ex% + 7, ey% + 2), 154
    PSet (ex% + 8, ey% + 2), 25
    PSet (ex% + 9, ey% + 2), 25
    PSet (ex% + 10, ey% + 2), 25
    PSet (ex% + 11, ey% + 2), 23
    PSet (ex% + 12, ey% + 2), 42
    PSet (ex% + 13, ey% + 2), 21
    PSet (ex% + 14, ey% + 2), 44
    PSet (ex% + 15, ey% + 2), 43
    PSet (ex% + 16, ey% + 2), 44
    PSet (ex% + 17, ey% + 2), 44
    PSet (ex% + 18, ey% + 2), 43
    PSet (ex% + 19, ey% + 2), 42
    PSet (ex% + 20, ey% + 2), 23
    PSet (ex% + 21, ey% + 2), 21
    PSet (ex% + 0, ey% + 3), 21
    PSet (ex% + 1, ey% + 3), 22
    PSet (ex% + 2, ey% + 3), 23
    PSet (ex% + 3, ey% + 3), 23
    PSet (ex% + 4, ey% + 3), 24
    PSet (ex% + 5, ey% + 3), 24
    PSet (ex% + 6, ey% + 3), 24
    PSet (ex% + 7, ey% + 3), 24
    PSet (ex% + 8, ey% + 3), 24
    PSet (ex% + 9, ey% + 3), 21
    PSet (ex% + 10, ey% + 3), 21
    PSet (ex% + 11, ey% + 3), 20
    PSet (ex% + 12, ey% + 3), 20
    PSet (ex% + 14, ey% + 3), 24
    PSet (ex% + 15, ey% + 3), 25
    PSet (ex% + 16, ey% + 3), 44
    PSet (ex% + 17, ey% + 3), 43
    PSet (ex% + 18, ey% + 3), 42
    PSet (ex% + 19, ey% + 3), 20
    PSet (ex% + 20, ey% + 3), 19
    PSet (ex% + 21, ey% + 3), 19
    PSet (ex% + 3, ey% + 4), 20
    PSet (ex% + 4, ey% + 4), 22
    PSet (ex% + 5, ey% + 4), 22
    PSet (ex% + 6, ey% + 4), 20
    PSet (ex% + 7, ey% + 4), 19
    PSet (ex% + 13, ey% + 4), 42
    PSet (ex% + 14, ey% + 4), 43
    PSet (ex% + 15, ey% + 4), 44
    PSet (ex% + 16, ey% + 4), 43
    PSet (ex% + 17, ey% + 4), 42
    PSet (ex% + 18, ey% + 4), 20
    PSet (ex% + 19, ey% + 4), 20
    PSet (ex% + 20, ey% + 4), 19
    PSet (ex% + 9, ey% + 5), 19
    PSet (ex% + 10, ey% + 5), 21
    PSet (ex% + 11, ey% + 5), 22
    PSet (ex% + 12, ey% + 5), 24
    PSet (ex% + 13, ey% + 5), 25
    PSet (ex% + 14, ey% + 5), 25
    PSet (ex% + 15, ey% + 5), 43
    PSet (ex% + 16, ey% + 5), 20
    PSet (ex% + 17, ey% + 5), 20
    PSet (ex% + 18, ey% + 5), 19
    PSet (ex% + 8, ey% + 6), 19
    PSet (ex% + 9, ey% + 6), 19
    PSet (ex% + 10, ey% + 6), 42
    PSet (ex% + 11, ey% + 6), 44
    PSet (ex% + 12, ey% + 6), 43
    PSet (ex% + 13, ey% + 6), 24
    PSet (ex% + 14, ey% + 6), 20
    PSet (ex% + 15, ey% + 6), 19
    PSet (ex% + 16, ey% + 6), 19
    PSet (ex% + 8, ey% + 7), 41
    PSet (ex% + 9, ey% + 7), 42
    PSet (ex% + 10, ey% + 7), 44
    PSet (ex% + 11, ey% + 7), 26
    PSet (ex% + 12, ey% + 7), 23
    PSet (ex% + 13, ey% + 7), 21
    PSet (ex% + 14, ey% + 7), 19
    PSet (ex% + 8, ey% + 8), 19
    PSet (ex% + 9, ey% + 8), 22
    PSet (ex% + 10, ey% + 8), 24
    PSet (ex% + 11, ey% + 8), 22
End Sub

Sub xxf3
    PSet (ex% + 18, ey% + -3), 41
    PSet (ex% + 11, ey% + -2), 41
    PSet (ex% + 13, ey% + -2), 41
    PSet (ex% + 16, ey% + -2), 42
    PSet (ex% + 17, ey% + -2), 44
    PSet (ex% + 18, ey% + -2), 43
    PSet (ex% + 19, ey% + -2), 42
    PSet (ex% + 10, ey% + -1), 41
    PSet (ex% + 11, ey% + -1), 42
    PSet (ex% + 12, ey% + -1), 43
    PSet (ex% + 15, ey% + -1), 42
    PSet (ex% + 16, ey% + -1), 44
    PSet (ex% + 17, ey% + -1), 43
    PSet (ex% + 18, ey% + -1), 44
    PSet (ex% + 21, ey% + -1), 41
    PSet (ex% + 8, ey% + 0), 178
    PSet (ex% + 9, ey% + 0), 41
    PSet (ex% + 10, ey% + 0), 42
    PSet (ex% + 11, ey% + 0), 43
    PSet (ex% + 12, ey% + 0), 43
    PSet (ex% + 13, ey% + 0), 42
    PSet (ex% + 14, ey% + 0), 24
    PSet (ex% + 15, ey% + 0), 42
    PSet (ex% + 16, ey% + 0), 44
    PSet (ex% + 17, ey% + 0), 43
    PSet (ex% + 18, ey% + 0), 43
    PSet (ex% + 19, ey% + 0), 42
    PSet (ex% + 20, ey% + 0), 42
    PSet (ex% + 21, ey% + 0), 44
    PSet (ex% + 22, ey% + 0), 43
    PSet (ex% + 23, ey% + 0), 42
    PSet (ex% + 5, ey% + 1), 42
    PSet (ex% + 6, ey% + 1), 43
    PSet (ex% + 7, ey% + 1), 106
    PSet (ex% + 8, ey% + 1), 106
    PSet (ex% + 9, ey% + 1), 130
    PSet (ex% + 10, ey% + 1), 43
    PSet (ex% + 11, ey% + 1), 42
    PSet (ex% + 12, ey% + 1), 44
    PSet (ex% + 13, ey% + 1), 43
    PSet (ex% + 14, ey% + 1), 44
    PSet (ex% + 15, ey% + 1), 43
    PSet (ex% + 16, ey% + 1), 43
    PSet (ex% + 17, ey% + 1), 44
    PSet (ex% + 18, ey% + 1), 42
    PSet (ex% + 19, ey% + 1), 44
    PSet (ex% + 20, ey% + 1), 44
    PSet (ex% + 21, ey% + 1), 43
    PSet (ex% + 22, ey% + 1), 42
    PSet (ex% + 2, ey% + 2), 178
    PSet (ex% + 3, ey% + 2), 106
    PSet (ex% + 4, ey% + 2), 42
    PSet (ex% + 5, ey% + 2), 43
    PSet (ex% + 6, ey% + 2), 44
    PSet (ex% + 7, ey% + 2), 43
    PSet (ex% + 8, ey% + 2), 25
    PSet (ex% + 9, ey% + 2), 25
    PSet (ex% + 10, ey% + 2), 43
    PSet (ex% + 11, ey% + 2), 44
    PSet (ex% + 12, ey% + 2), 43
    PSet (ex% + 13, ey% + 2), 21
    PSet (ex% + 14, ey% + 2), 44
    PSet (ex% + 15, ey% + 2), 43
    PSet (ex% + 16, ey% + 2), 44
    PSet (ex% + 17, ey% + 2), 44
    PSet (ex% + 18, ey% + 2), 43
    PSet (ex% + 19, ey% + 2), 43
    PSet (ex% + 20, ey% + 2), 43
    PSet (ex% + 21, ey% + 2), 44
    PSet (ex% + 0, ey% + 3), 21
    PSet (ex% + 1, ey% + 3), 22
    PSet (ex% + 2, ey% + 3), 23
    PSet (ex% + 3, ey% + 3), 23
    PSet (ex% + 4, ey% + 3), 24
    PSet (ex% + 5, ey% + 3), 43
    PSet (ex% + 6, ey% + 3), 43
    PSet (ex% + 7, ey% + 3), 24
    PSet (ex% + 8, ey% + 3), 24
    PSet (ex% + 9, ey% + 3), 41
    PSet (ex% + 10, ey% + 3), 42
    PSet (ex% + 11, ey% + 3), 42
    PSet (ex% + 12, ey% + 3), 44
    PSet (ex% + 14, ey% + 3), 24
    PSet (ex% + 15, ey% + 3), 25
    PSet (ex% + 16, ey% + 3), 44
    PSet (ex% + 17, ey% + 3), 43
    PSet (ex% + 18, ey% + 3), 44
    PSet (ex% + 19, ey% + 3), 42
    PSet (ex% + 20, ey% + 3), 44
    PSet (ex% + 21, ey% + 3), 43
    PSet (ex% + 22, ey% + 3), 41
    PSet (ex% + 3, ey% + 4), 20
    PSet (ex% + 4, ey% + 4), 22
    PSet (ex% + 5, ey% + 4), 22
    PSet (ex% + 6, ey% + 4), 20
    PSet (ex% + 7, ey% + 4), 19
    PSet (ex% + 10, ey% + 4), 41
    PSet (ex% + 12, ey% + 4), 43
    PSet (ex% + 13, ey% + 4), 42
    PSet (ex% + 14, ey% + 4), 43
    PSet (ex% + 15, ey% + 4), 44
    PSet (ex% + 16, ey% + 4), 43
    PSet (ex% + 17, ey% + 4), 42
    PSet (ex% + 18, ey% + 4), 43
    PSet (ex% + 19, ey% + 4), 44
    PSet (ex% + 20, ey% + 4), 43
    PSet (ex% + 12, ey% + 5), 43
    PSet (ex% + 13, ey% + 5), 44
    PSet (ex% + 14, ey% + 5), 44
    PSet (ex% + 15, ey% + 5), 43
    PSet (ex% + 16, ey% + 5), 44
    PSet (ex% + 17, ey% + 5), 42
    PSet (ex% + 18, ey% + 5), 42
    PSet (ex% + 19, ey% + 5), 41
    PSet (ex% + 21, ey% + 5), 42
    PSet (ex% + 11, ey% + 6), 42
    PSet (ex% + 12, ey% + 6), 41
    PSet (ex% + 13, ey% + 6), 43
    PSet (ex% + 14, ey% + 6), 44
    PSet (ex% + 15, ey% + 6), 44
    PSet (ex% + 16, ey% + 6), 42
    PSet (ex% + 18, ey% + 6), 41
    PSet (ex% + 10, ey% + 7), 19
    PSet (ex% + 11, ey% + 7), 23
    PSet (ex% + 12, ey% + 7), 43
    PSet (ex% + 13, ey% + 7), 42
    PSet (ex% + 14, ey% + 7), 24
    PSet (ex% + 15, ey% + 7), 42
    PSet (ex% + 16, ey% + 7), 43
    PSet (ex% + 17, ey% + 7), 42
    PSet (ex% + 9, ey% + 8), 19
    PSet (ex% + 10, ey% + 8), 24
    PSet (ex% + 11, ey% + 8), 44
    PSet (ex% + 12, ey% + 8), 42
    PSet (ex% + 13, ey% + 8), 25
    PSet (ex% + 14, ey% + 8), 23
    PSet (ex% + 15, ey% + 8), 41
    PSet (ex% + 10, ey% + 9), 43
    PSet (ex% + 11, ey% + 9), 42
    PSet (ex% + 12, ey% + 9), 22
    PSet (ex% + 13, ey% + 9), 21
End Sub

Sub xxf4
    PSet (ex% + 18, ey% + -3), 42
    PSet (ex% + 20, ey% + -3), 40
    PSet (ex% + 11, ey% + -2), 41
    PSet (ex% + 13, ey% + -2), 41
    PSet (ex% + 16, ey% + -2), 42
    PSet (ex% + 17, ey% + -2), 44
    PSet (ex% + 18, ey% + -2), 43
    PSet (ex% + 19, ey% + -2), 44
    PSet (ex% + 20, ey% + -2), 42
    PSet (ex% + 10, ey% + -1), 41
    PSet (ex% + 11, ey% + -1), 42
    PSet (ex% + 12, ey% + -1), 43
    PSet (ex% + 14, ey% + -1), 44
    PSet (ex% + 15, ey% + -1), 44
    PSet (ex% + 16, ey% + -1), 44
    PSet (ex% + 17, ey% + -1), 43
    PSet (ex% + 18, ey% + -1), 44
    PSet (ex% + 19, ey% + -1), 44
    PSet (ex% + 21, ey% + -1), 43
    PSet (ex% + 22, ey% + -1), 43
    PSet (ex% + 6, ey% + 0), 40
    PSet (ex% + 7, ey% + 0), 42
    PSet (ex% + 8, ey% + 0), 178
    PSet (ex% + 9, ey% + 0), 41
    PSet (ex% + 10, ey% + 0), 42
    PSet (ex% + 11, ey% + 0), 43
    PSet (ex% + 12, ey% + 0), 43
    PSet (ex% + 13, ey% + 0), 42
    PSet (ex% + 14, ey% + 0), 24
    PSet (ex% + 15, ey% + 0), 42
    PSet (ex% + 16, ey% + 0), 44
    PSet (ex% + 17, ey% + 0), 43
    PSet (ex% + 18, ey% + 0), 43
    PSet (ex% + 19, ey% + 0), 42
    PSet (ex% + 20, ey% + 0), 42
    PSet (ex% + 21, ey% + 0), 44
    PSet (ex% + 22, ey% + 0), 43
    PSet (ex% + 23, ey% + 0), 42
    PSet (ex% + 4, ey% + 1), 41
    PSet (ex% + 5, ey% + 1), 43
    PSet (ex% + 6, ey% + 1), 43
    PSet (ex% + 7, ey% + 1), 44
    PSet (ex% + 8, ey% + 1), 43
    PSet (ex% + 9, ey% + 1), 130
    PSet (ex% + 10, ey% + 1), 43
    PSet (ex% + 11, ey% + 1), 42
    PSet (ex% + 12, ey% + 1), 44
    PSet (ex% + 13, ey% + 1), 43
    PSet (ex% + 14, ey% + 1), 44
    PSet (ex% + 15, ey% + 1), 42
    PSet (ex% + 16, ey% + 1), 43
    PSet (ex% + 17, ey% + 1), 42
    PSet (ex% + 18, ey% + 1), 43
    PSet (ex% + 19, ey% + 1), 44
    PSet (ex% + 20, ey% + 1), 44
    PSet (ex% + 21, ey% + 1), 43
    PSet (ex% + 22, ey% + 1), 43
    PSet (ex% + 23, ey% + 1), 44
    PSet (ex% + 2, ey% + 2), 178
    PSet (ex% + 3, ey% + 2), 43
    PSet (ex% + 4, ey% + 2), 42
    PSet (ex% + 5, ey% + 2), 43
    PSet (ex% + 6, ey% + 2), 44
    PSet (ex% + 7, ey% + 2), 43
    PSet (ex% + 8, ey% + 2), 25
    PSet (ex% + 9, ey% + 2), 25
    PSet (ex% + 10, ey% + 2), 43
    PSet (ex% + 11, ey% + 2), 44
    PSet (ex% + 12, ey% + 2), 43
    PSet (ex% + 13, ey% + 2), 21
    PSet (ex% + 14, ey% + 2), 42
    PSet (ex% + 15, ey% + 2), 43
    PSet (ex% + 16, ey% + 2), 41
    PSet (ex% + 17, ey% + 2), 42
    PSet (ex% + 18, ey% + 2), 42
    PSet (ex% + 19, ey% + 2), 43
    PSet (ex% + 20, ey% + 2), 43
    PSet (ex% + 21, ey% + 2), 44
    PSet (ex% + 0, ey% + 3), 21
    PSet (ex% + 1, ey% + 3), 22
    PSet (ex% + 2, ey% + 3), 41
    PSet (ex% + 3, ey% + 3), 42
    PSet (ex% + 4, ey% + 3), 41
    PSet (ex% + 5, ey% + 3), 43
    PSet (ex% + 6, ey% + 3), 43
    PSet (ex% + 7, ey% + 3), 43
    PSet (ex% + 8, ey% + 3), 44
    PSet (ex% + 9, ey% + 3), 43
    PSet (ex% + 10, ey% + 3), 44
    PSet (ex% + 11, ey% + 3), 42
    PSet (ex% + 12, ey% + 3), 44
    PSet (ex% + 14, ey% + 3), 24
    PSet (ex% + 15, ey% + 3), 25
    PSet (ex% + 16, ey% + 3), 43
    PSet (ex% + 17, ey% + 3), 41
    PSet (ex% + 18, ey% + 3), 44
    PSet (ex% + 19, ey% + 3), 42
    PSet (ex% + 20, ey% + 3), 44
    PSet (ex% + 21, ey% + 3), 43
    PSet (ex% + 22, ey% + 3), 42
    PSet (ex% + 3, ey% + 4), 20
    PSet (ex% + 4, ey% + 4), 22
    PSet (ex% + 5, ey% + 4), 42
    PSet (ex% + 6, ey% + 4), 42
    PSet (ex% + 7, ey% + 4), 19
    PSet (ex% + 8, ey% + 4), 42
    PSet (ex% + 9, ey% + 4), 43
    PSet (ex% + 10, ey% + 4), 41
    PSet (ex% + 12, ey% + 4), 43
    PSet (ex% + 13, ey% + 4), 42
    PSet (ex% + 14, ey% + 4), 43
    PSet (ex% + 15, ey% + 4), 44
    PSet (ex% + 16, ey% + 4), 43
    PSet (ex% + 17, ey% + 4), 43
    PSet (ex% + 18, ey% + 4), 43
    PSet (ex% + 19, ey% + 4), 44
    PSet (ex% + 20, ey% + 4), 43
    PSet (ex% + 10, ey% + 5), 44
    PSet (ex% + 12, ey% + 5), 43
    PSet (ex% + 13, ey% + 5), 44
    PSet (ex% + 14, ey% + 5), 44
    PSet (ex% + 15, ey% + 5), 43
    PSet (ex% + 16, ey% + 5), 44
    PSet (ex% + 17, ey% + 5), 44
    PSet (ex% + 18, ey% + 5), 43
    PSet (ex% + 19, ey% + 5), 42
    PSet (ex% + 21, ey% + 5), 42
    PSet (ex% + 22, ey% + 5), 42
    PSet (ex% + 11, ey% + 6), 42
    PSet (ex% + 12, ey% + 6), 41
    PSet (ex% + 13, ey% + 6), 43
    PSet (ex% + 14, ey% + 6), 44
    PSet (ex% + 15, ey% + 6), 44
    PSet (ex% + 16, ey% + 6), 42
    PSet (ex% + 18, ey% + 6), 43
    PSet (ex% + 19, ey% + 6), 43
    PSet (ex% + 10, ey% + 7), 43
    PSet (ex% + 11, ey% + 7), 44
    PSet (ex% + 12, ey% + 7), 43
    PSet (ex% + 13, ey% + 7), 42
    PSet (ex% + 14, ey% + 7), 24
    PSet (ex% + 15, ey% + 7), 42
    PSet (ex% + 16, ey% + 7), 43
    PSet (ex% + 17, ey% + 7), 42
    PSet (ex% + 18, ey% + 7), 43
    PSet (ex% + 20, ey% + 7), 42
    PSet (ex% + 21, ey% + 7), 41
    PSet (ex% + 9, ey% + 8), 43
    PSet (ex% + 10, ey% + 8), 23
    PSet (ex% + 11, ey% + 8), 42
    PSet (ex% + 12, ey% + 8), 44
    PSet (ex% + 13, ey% + 8), 43
    PSet (ex% + 14, ey% + 8), 43
    PSet (ex% + 15, ey% + 8), 41
    PSet (ex% + 18, ey% + 8), 41
    PSet (ex% + 10, ey% + 9), 43
    PSet (ex% + 11, ey% + 9), 43
    PSet (ex% + 12, ey% + 9), 22
    PSet (ex% + 13, ey% + 9), 43
    PSet (ex% + 14, ey% + 9), 42
End Sub

Sub xxf5
    PSet (ex% + 13, ey% + -3), 42
    PSet (ex% + 14, ey% + -3), 41
    PSet (ex% + 15, ey% + -3), 41
    PSet (ex% + 18, ey% + -3), 41
    PSet (ex% + 20, ey% + -3), 40
    PSet (ex% + 23, ey% + -3), 41
    PSet (ex% + 11, ey% + -2), 41
    PSet (ex% + 13, ey% + -2), 41
    PSet (ex% + 14, ey% + -2), 42
    PSet (ex% + 16, ey% + -2), 42
    PSet (ex% + 17, ey% + -2), 42
    PSet (ex% + 18, ey% + -2), 43
    PSet (ex% + 19, ey% + -2), 41
    PSet (ex% + 20, ey% + -2), 42
    PSet (ex% + 21, ey% + -2), 42
    PSet (ex% + 22, ey% + -2), 41
    PSet (ex% + 4, ey% + -1), 40
    PSet (ex% + 9, ey% + -1), 41
    PSet (ex% + 10, ey% + -1), 42
    PSet (ex% + 11, ey% + -1), 42
    PSet (ex% + 12, ey% + -1), 41
    PSet (ex% + 14, ey% + -1), 44
    PSet (ex% + 15, ey% + -1), 44
    PSet (ex% + 16, ey% + -1), 44
    PSet (ex% + 17, ey% + -1), 43
    PSet (ex% + 18, ey% + -1), 44
    PSet (ex% + 19, ey% + -1), 44
    PSet (ex% + 21, ey% + -1), 43
    PSet (ex% + 22, ey% + -1), 43
    PSet (ex% + 24, ey% + -1), 41
    PSet (ex% + 6, ey% + 0), 40
    PSet (ex% + 7, ey% + 0), 42
    PSet (ex% + 8, ey% + 0), 44
    PSet (ex% + 9, ey% + 0), 41
    PSet (ex% + 10, ey% + 0), 42
    PSet (ex% + 11, ey% + 0), 43
    PSet (ex% + 12, ey% + 0), 43
    PSet (ex% + 13, ey% + 0), 42
    PSet (ex% + 14, ey% + 0), 44
    PSet (ex% + 15, ey% + 0), 42
    PSet (ex% + 16, ey% + 0), 44
    PSet (ex% + 17, ey% + 0), 43
    PSet (ex% + 18, ey% + 0), 43
    PSet (ex% + 19, ey% + 0), 42
    PSet (ex% + 20, ey% + 0), 42
    PSet (ex% + 21, ey% + 0), 44
    PSet (ex% + 22, ey% + 0), 42
    PSet (ex% + 23, ey% + 0), 42
    PSet (ex% + 3, ey% + 1), 40
    PSet (ex% + 4, ey% + 1), 41
    PSet (ex% + 5, ey% + 1), 43
    PSet (ex% + 6, ey% + 1), 43
    PSet (ex% + 7, ey% + 1), 44
    PSet (ex% + 8, ey% + 1), 43
    PSet (ex% + 9, ey% + 1), 44
    PSet (ex% + 10, ey% + 1), 43
    PSet (ex% + 11, ey% + 1), 42
    PSet (ex% + 12, ey% + 1), 44
    PSet (ex% + 13, ey% + 1), 44
    PSet (ex% + 14, ey% + 1), 44
    PSet (ex% + 15, ey% + 1), 42
    PSet (ex% + 16, ey% + 1), 43
    PSet (ex% + 17, ey% + 1), 42
    PSet (ex% + 18, ey% + 1), 43
    PSet (ex% + 19, ey% + 1), 44
    PSet (ex% + 20, ey% + 1), 44
    PSet (ex% + 21, ey% + 1), 43
    PSet (ex% + 22, ey% + 1), 43
    PSet (ex% + 23, ey% + 1), 43
    PSet (ex% + 24, ey% + 1), 42
    PSet (ex% + 25, ey% + 1), 41
    PSet (ex% + 1, ey% + 2), 41
    PSet (ex% + 2, ey% + 2), 42
    PSet (ex% + 3, ey% + 2), 43
    PSet (ex% + 4, ey% + 2), 42
    PSet (ex% + 5, ey% + 2), 43
    PSet (ex% + 6, ey% + 2), 44
    PSet (ex% + 7, ey% + 2), 43
    PSet (ex% + 8, ey% + 2), 44
    PSet (ex% + 9, ey% + 2), 44
    PSet (ex% + 10, ey% + 2), 44
    PSet (ex% + 11, ey% + 2), 44
    PSet (ex% + 12, ey% + 2), 43
    PSet (ex% + 13, ey% + 2), 44
    PSet (ex% + 14, ey% + 2), 42
    PSet (ex% + 15, ey% + 2), 42
    PSet (ex% + 16, ey% + 2), 41
    PSet (ex% + 17, ey% + 2), 42
    PSet (ex% + 18, ey% + 2), 41
    PSet (ex% + 19, ey% + 2), 43
    PSet (ex% + 20, ey% + 2), 43
    PSet (ex% + 21, ey% + 2), 44
    PSet (ex% + 24, ey% + 2), 40
    PSet (ex% + 0, ey% + 3), 41
    PSet (ex% + 1, ey% + 3), 43
    PSet (ex% + 2, ey% + 3), 43
    PSet (ex% + 3, ey% + 3), 42
    PSet (ex% + 4, ey% + 3), 41
    PSet (ex% + 5, ey% + 3), 43
    PSet (ex% + 6, ey% + 3), 43
    PSet (ex% + 7, ey% + 3), 43
    PSet (ex% + 8, ey% + 3), 44
    PSet (ex% + 9, ey% + 3), 43
    PSet (ex% + 10, ey% + 3), 44
    PSet (ex% + 11, ey% + 3), 42
    PSet (ex% + 12, ey% + 3), 44
    PSet (ex% + 13, ey% + 3), 44
    PSet (ex% + 14, ey% + 3), 44
    PSet (ex% + 15, ey% + 3), 43
    PSet (ex% + 16, ey% + 3), 42
    PSet (ex% + 17, ey% + 3), 41
    PSet (ex% + 18, ey% + 3), 44
    PSet (ex% + 19, ey% + 3), 42
    PSet (ex% + 20, ey% + 3), 44
    PSet (ex% + 21, ey% + 3), 43
    PSet (ex% + 22, ey% + 3), 42
    PSet (ex% + 2, ey% + 4), 41
    PSet (ex% + 3, ey% + 4), 43
    PSet (ex% + 4, ey% + 4), 43
    PSet (ex% + 5, ey% + 4), 42
    PSet (ex% + 6, ey% + 4), 42
    PSet (ex% + 7, ey% + 4), 44
    PSet (ex% + 8, ey% + 4), 42
    PSet (ex% + 9, ey% + 4), 43
    PSet (ex% + 10, ey% + 4), 41
    PSet (ex% + 12, ey% + 4), 43
    PSet (ex% + 13, ey% + 4), 42
    PSet (ex% + 14, ey% + 4), 43
    PSet (ex% + 15, ey% + 4), 44
    PSet (ex% + 16, ey% + 4), 43
    PSet (ex% + 17, ey% + 4), 43
    PSet (ex% + 18, ey% + 4), 43
    PSet (ex% + 19, ey% + 4), 44
    PSet (ex% + 20, ey% + 4), 43
    PSet (ex% + 23, ey% + 4), 41
    PSet (ex% + 3, ey% + 5), 42
    PSet (ex% + 4, ey% + 5), 43
    PSet (ex% + 6, ey% + 5), 41
    PSet (ex% + 8, ey% + 5), 42
    PSet (ex% + 9, ey% + 5), 43
    PSet (ex% + 10, ey% + 5), 43
    PSet (ex% + 11, ey% + 5), 44
    PSet (ex% + 12, ey% + 5), 43
    PSet (ex% + 13, ey% + 5), 44
    PSet (ex% + 14, ey% + 5), 43
    PSet (ex% + 15, ey% + 5), 43
    PSet (ex% + 16, ey% + 5), 44
    PSet (ex% + 17, ey% + 5), 44
    PSet (ex% + 18, ey% + 5), 43
    PSet (ex% + 19, ey% + 5), 42
    PSet (ex% + 21, ey% + 5), 42
    PSet (ex% + 22, ey% + 5), 42
    PSet (ex% + 9, ey% + 6), 41
    PSet (ex% + 11, ey% + 6), 42
    PSet (ex% + 12, ey% + 6), 41
    PSet (ex% + 13, ey% + 6), 43
    PSet (ex% + 14, ey% + 6), 44
    PSet (ex% + 15, ey% + 6), 44
    PSet (ex% + 16, ey% + 6), 42
    PSet (ex% + 18, ey% + 6), 43
    PSet (ex% + 19, ey% + 6), 43
    PSet (ex% + 23, ey% + 6), 41
    PSet (ex% + 10, ey% + 7), 41
    PSet (ex% + 11, ey% + 7), 43
    PSet (ex% + 12, ey% + 7), 42
    PSet (ex% + 13, ey% + 7), 42
    PSet (ex% + 14, ey% + 7), 44
    PSet (ex% + 15, ey% + 7), 42
    PSet (ex% + 16, ey% + 7), 43
    PSet (ex% + 17, ey% + 7), 42
    PSet (ex% + 18, ey% + 7), 43
    PSet (ex% + 20, ey% + 7), 42
    PSet (ex% + 21, ey% + 7), 41
    PSet (ex% + 9, ey% + 8), 41
    PSet (ex% + 10, ey% + 8), 23
    PSet (ex% + 11, ey% + 8), 42
    PSet (ex% + 12, ey% + 8), 43
    PSet (ex% + 13, ey% + 8), 43
    PSet (ex% + 14, ey% + 8), 43
    PSet (ex% + 15, ey% + 8), 41
    PSet (ex% + 16, ey% + 8), 40
    PSet (ex% + 18, ey% + 8), 41
    PSet (ex% + 22, ey% + 8), 40
    PSet (ex% + 10, ey% + 9), 40
    PSet (ex% + 11, ey% + 9), 42
    PSet (ex% + 12, ey% + 9), 22
    PSet (ex% + 13, ey% + 9), 43
    PSet (ex% + 14, ey% + 9), 42
    PSet (ex% + 15, ey% + 9), 41
    PSet (ex% + 13, ey% + 10), 40
End Sub

Sub xxf6
    PSet (ex% + 13, ey% + -3), 42
    PSet (ex% + 14, ey% + -3), 41
    PSet (ex% + 15, ey% + -3), 41
    PSet (ex% + 18, ey% + -3), 41
    PSet (ex% + 21, ey% + -3), 40
    PSet (ex% + 11, ey% + -2), 41
    PSet (ex% + 13, ey% + -2), 41
    PSet (ex% + 14, ey% + -2), 42
    PSet (ex% + 16, ey% + -2), 42
    PSet (ex% + 17, ey% + -2), 41
    PSet (ex% + 18, ey% + -2), 42
    PSet (ex% + 19, ey% + -2), 40
    PSet (ex% + 21, ey% + -2), 42
    PSet (ex% + 22, ey% + -2), 41
    PSet (ex% + 24, ey% + -2), 41
    PSet (ex% + 4, ey% + -1), 43
    PSet (ex% + 9, ey% + -1), 41
    PSet (ex% + 10, ey% + -1), 42
    PSet (ex% + 11, ey% + -1), 42
    PSet (ex% + 12, ey% + -1), 41
    PSet (ex% + 14, ey% + -1), 40
    PSet (ex% + 15, ey% + -1), 43
    PSet (ex% + 16, ey% + -1), 43
    PSet (ex% + 17, ey% + -1), 43
    PSet (ex% + 18, ey% + -1), 43
    PSet (ex% + 19, ey% + -1), 41
    PSet (ex% + 21, ey% + -1), 43
    PSet (ex% + 22, ey% + -1), 43
    PSet (ex% + 5, ey% + 0), 41
    PSet (ex% + 6, ey% + 0), 40
    PSet (ex% + 7, ey% + 0), 42
    PSet (ex% + 8, ey% + 0), 44
    PSet (ex% + 9, ey% + 0), 41
    PSet (ex% + 10, ey% + 0), 42
    PSet (ex% + 11, ey% + 0), 43
    PSet (ex% + 12, ey% + 0), 43
    PSet (ex% + 13, ey% + 0), 42
    PSet (ex% + 14, ey% + 0), 43
    PSet (ex% + 15, ey% + 0), 42
    PSet (ex% + 16, ey% + 0), 44
    PSet (ex% + 17, ey% + 0), 42
    PSet (ex% + 18, ey% + 0), 40
    PSet (ex% + 19, ey% + 0), 42
    PSet (ex% + 20, ey% + 0), 42
    PSet (ex% + 21, ey% + 0), 44
    PSet (ex% + 22, ey% + 0), 41
    PSet (ex% + 23, ey% + 0), 42
    PSet (ex% + 3, ey% + 1), 41
    PSet (ex% + 4, ey% + 1), 43
    PSet (ex% + 5, ey% + 1), 42
    PSet (ex% + 6, ey% + 1), 43
    PSet (ex% + 7, ey% + 1), 44
    PSet (ex% + 8, ey% + 1), 43
    PSet (ex% + 9, ey% + 1), 43
    PSet (ex% + 10, ey% + 1), 43
    PSet (ex% + 11, ey% + 1), 42
    PSet (ex% + 12, ey% + 1), 40
    PSet (ex% + 13, ey% + 1), 43
    PSet (ex% + 14, ey% + 1), 44
    PSet (ex% + 15, ey% + 1), 43
    PSet (ex% + 16, ey% + 1), 41
    PSet (ex% + 17, ey% + 1), 42
    PSet (ex% + 19, ey% + 1), 41
    PSet (ex% + 20, ey% + 1), 43
    PSet (ex% + 21, ey% + 1), 42
    PSet (ex% + 22, ey% + 1), 40
    PSet (ex% + 24, ey% + 1), 40
    PSet (ex% + 1, ey% + 2), 41
    PSet (ex% + 2, ey% + 2), 42
    PSet (ex% + 3, ey% + 2), 42
    PSet (ex% + 4, ey% + 2), 41
    PSet (ex% + 6, ey% + 2), 41
    PSet (ex% + 7, ey% + 2), 43
    PSet (ex% + 8, ey% + 2), 44
    PSet (ex% + 9, ey% + 2), 42
    PSet (ex% + 10, ey% + 2), 41
    PSet (ex% + 11, ey% + 2), 41
    PSet (ex% + 13, ey% + 2), 40
    PSet (ex% + 14, ey% + 2), 42
    PSet (ex% + 15, ey% + 2), 41
    PSet (ex% + 16, ey% + 2), 41
    PSet (ex% + 19, ey% + 2), 40
    PSet (ex% + 20, ey% + 2), 42
    PSet (ex% + 21, ey% + 2), 44
    PSet (ex% + 0, ey% + 3), 41
    PSet (ex% + 1, ey% + 3), 43
    PSet (ex% + 2, ey% + 3), 43
    PSet (ex% + 3, ey% + 3), 41
    PSet (ex% + 6, ey% + 3), 40
    PSet (ex% + 7, ey% + 3), 42
    PSet (ex% + 8, ey% + 3), 44
    PSet (ex% + 9, ey% + 3), 43
    PSet (ex% + 10, ey% + 3), 44
    PSet (ex% + 11, ey% + 3), 42
    PSet (ex% + 12, ey% + 3), 41
    PSet (ex% + 13, ey% + 3), 41
    PSet (ex% + 14, ey% + 3), 44
    PSet (ex% + 15, ey% + 3), 43
    PSet (ex% + 16, ey% + 3), 42
    PSet (ex% + 17, ey% + 3), 41
    PSet (ex% + 18, ey% + 3), 42
    PSet (ex% + 19, ey% + 3), 41
    PSet (ex% + 20, ey% + 3), 44
    PSet (ex% + 21, ey% + 3), 40
    PSet (ex% + 22, ey% + 3), 42
    PSet (ex% + 2, ey% + 4), 41
    PSet (ex% + 3, ey% + 4), 42
    PSet (ex% + 4, ey% + 4), 41
    PSet (ex% + 5, ey% + 4), 42
    PSet (ex% + 6, ey% + 4), 41
    PSet (ex% + 7, ey% + 4), 44
    PSet (ex% + 8, ey% + 4), 42
    PSet (ex% + 9, ey% + 4), 43
    PSet (ex% + 10, ey% + 4), 41
    PSet (ex% + 12, ey% + 4), 42
    PSet (ex% + 13, ey% + 4), 42
    PSet (ex% + 14, ey% + 4), 43
    PSet (ex% + 15, ey% + 4), 44
    PSet (ex% + 16, ey% + 4), 42
    PSet (ex% + 17, ey% + 4), 42
    PSet (ex% + 18, ey% + 4), 42
    PSet (ex% + 19, ey% + 4), 44
    PSet (ex% + 20, ey% + 4), 41
    PSet (ex% + 24, ey% + 4), 42
    PSet (ex% + 25, ey% + 4), 41
    PSet (ex% + 3, ey% + 5), 42
    PSet (ex% + 4, ey% + 5), 43
    PSet (ex% + 6, ey% + 5), 41
    PSet (ex% + 8, ey% + 5), 42
    PSet (ex% + 9, ey% + 5), 43
    PSet (ex% + 10, ey% + 5), 43
    PSet (ex% + 11, ey% + 5), 44
    PSet (ex% + 12, ey% + 5), 43
    PSet (ex% + 13, ey% + 5), 44
    PSet (ex% + 14, ey% + 5), 43
    PSet (ex% + 15, ey% + 5), 43
    PSet (ex% + 16, ey% + 5), 44
    PSet (ex% + 17, ey% + 5), 41
    PSet (ex% + 18, ey% + 5), 43
    PSet (ex% + 19, ey% + 5), 41
    PSet (ex% + 9, ey% + 6), 41
    PSet (ex% + 11, ey% + 6), 42
    PSet (ex% + 12, ey% + 6), 41
    PSet (ex% + 13, ey% + 6), 43
    PSet (ex% + 14, ey% + 6), 44
    PSet (ex% + 15, ey% + 6), 44
    PSet (ex% + 16, ey% + 6), 42
    PSet (ex% + 18, ey% + 6), 41
    PSet (ex% + 19, ey% + 6), 42
    PSet (ex% + 23, ey% + 6), 41
    PSet (ex% + 24, ey% + 6), 42
    PSet (ex% + 10, ey% + 7), 41
    PSet (ex% + 11, ey% + 7), 43
    PSet (ex% + 12, ey% + 7), 42
    PSet (ex% + 13, ey% + 7), 42
    PSet (ex% + 14, ey% + 7), 44
    PSet (ex% + 15, ey% + 7), 42
    PSet (ex% + 16, ey% + 7), 43
    PSet (ex% + 17, ey% + 7), 42
    PSet (ex% + 18, ey% + 7), 43
    PSet (ex% + 9, ey% + 8), 41
    PSet (ex% + 10, ey% + 8), 44
    PSet (ex% + 11, ey% + 8), 43
    PSet (ex% + 12, ey% + 8), 44
    PSet (ex% + 13, ey% + 8), 43
    PSet (ex% + 14, ey% + 8), 43
    PSet (ex% + 15, ey% + 8), 41
    PSet (ex% + 16, ey% + 8), 40
    PSet (ex% + 18, ey% + 8), 41
    PSet (ex% + 22, ey% + 8), 40
    PSet (ex% + 23, ey% + 8), 40
    PSet (ex% + 10, ey% + 9), 40
    PSet (ex% + 11, ey% + 9), 42
    PSet (ex% + 12, ey% + 9), 43
    PSet (ex% + 13, ey% + 9), 43
    PSet (ex% + 14, ey% + 9), 42
    PSet (ex% + 15, ey% + 9), 41
    PSet (ex% + 11, ey% + 10), 40
    PSet (ex% + 12, ey% + 10), 42
    PSet (ex% + 13, ey% + 10), 40
End Sub

Sub xxf7
    PSet (ex% + 14, ey% + -3), 39
    PSet (ex% + 15, ey% + -3), 41
    PSet (ex% + 18, ey% + -3), 41
    PSet (ex% + 11, ey% + -2), 41
    PSet (ex% + 13, ey% + -2), 41
    PSet (ex% + 14, ey% + -2), 42
    PSet (ex% + 16, ey% + -2), 42
    PSet (ex% + 17, ey% + -2), 41
    PSet (ex% + 18, ey% + -2), 42
    PSet (ex% + 19, ey% + -2), 40
    PSet (ex% + 21, ey% + -2), 40
    PSet (ex% + 25, ey% + -2), 41
    PSet (ex% + 4, ey% + -1), 43
    PSet (ex% + 9, ey% + -1), 41
    PSet (ex% + 10, ey% + -1), 42
    PSet (ex% + 11, ey% + -1), 42
    PSet (ex% + 12, ey% + -1), 41
    PSet (ex% + 14, ey% + -1), 40
    PSet (ex% + 15, ey% + -1), 43
    PSet (ex% + 16, ey% + -1), 43
    PSet (ex% + 17, ey% + -1), 43
    PSet (ex% + 18, ey% + -1), 42
    PSet (ex% + 19, ey% + -1), 41
    PSet (ex% + 21, ey% + -1), 41
    PSet (ex% + 22, ey% + -1), 40
    PSet (ex% + 5, ey% + 0), 41
    PSet (ex% + 6, ey% + 0), 40
    PSet (ex% + 7, ey% + 0), 42
    PSet (ex% + 8, ey% + 0), 42
    PSet (ex% + 9, ey% + 0), 41
    PSet (ex% + 10, ey% + 0), 42
    PSet (ex% + 11, ey% + 0), 43
    PSet (ex% + 12, ey% + 0), 42
    PSet (ex% + 13, ey% + 0), 41
    PSet (ex% + 14, ey% + 0), 43
    PSet (ex% + 15, ey% + 0), 42
    PSet (ex% + 16, ey% + 0), 44
    PSet (ex% + 17, ey% + 0), 42
    PSet (ex% + 19, ey% + 0), 40
    PSet (ex% + 20, ey% + 0), 42
    PSet (ex% + 22, ey% + 0), 43
    PSet (ex% + 23, ey% + 0), 42
    PSet (ex% + 3, ey% + 1), 41
    PSet (ex% + 4, ey% + 1), 43
    PSet (ex% + 5, ey% + 1), 42
    PSet (ex% + 6, ey% + 1), 43
    PSet (ex% + 7, ey% + 1), 42
    PSet (ex% + 8, ey% + 1), 43
    PSet (ex% + 9, ey% + 1), 42
    PSet (ex% + 10, ey% + 1), 41
    PSet (ex% + 11, ey% + 1), 40
    PSet (ex% + 14, ey% + 1), 40
    PSet (ex% + 15, ey% + 1), 43
    PSet (ex% + 16, ey% + 1), 41
    PSet (ex% + 20, ey% + 1), 42
    PSet (ex% + 21, ey% + 1), 41
    PSet (ex% + 22, ey% + 1), 40
    PSet (ex% + 1, ey% + 2), 41
    PSet (ex% + 2, ey% + 2), 42
    PSet (ex% + 3, ey% + 2), 42
    PSet (ex% + 6, ey% + 2), 41
    PSet (ex% + 7, ey% + 2), 42
    PSet (ex% + 8, ey% + 2), 41
    PSet (ex% + 14, ey% + 2), 42
    PSet (ex% + 15, ey% + 2), 41
    PSet (ex% + 20, ey% + 2), 42
    PSet (ex% + 21, ey% + 2), 44
    PSet (ex% + 0, ey% + 3), 41
    PSet (ex% + 1, ey% + 3), 43
    PSet (ex% + 2, ey% + 3), 43
    PSet (ex% + 8, ey% + 3), 42
    PSet (ex% + 9, ey% + 3), 41
    PSet (ex% + 13, ey% + 3), 41
    PSet (ex% + 14, ey% + 3), 42
    PSet (ex% + 15, ey% + 3), 43
    PSet (ex% + 16, ey% + 3), 42
    PSet (ex% + 17, ey% + 3), 41
    PSet (ex% + 19, ey% + 3), 41
    PSet (ex% + 20, ey% + 3), 44
    PSet (ex% + 21, ey% + 3), 40
    PSet (ex% + 22, ey% + 3), 42
    PSet (ex% + 2, ey% + 4), 41
    PSet (ex% + 3, ey% + 4), 42
    PSet (ex% + 5, ey% + 4), 42
    PSet (ex% + 6, ey% + 4), 41
    PSet (ex% + 7, ey% + 4), 42
    PSet (ex% + 8, ey% + 4), 42
    PSet (ex% + 9, ey% + 4), 42
    PSet (ex% + 10, ey% + 4), 41
    PSet (ex% + 12, ey% + 4), 42
    PSet (ex% + 13, ey% + 4), 42
    PSet (ex% + 14, ey% + 4), 43
    PSet (ex% + 15, ey% + 4), 41
    PSet (ex% + 16, ey% + 4), 42
    PSet (ex% + 17, ey% + 4), 42
    PSet (ex% + 18, ey% + 4), 42
    PSet (ex% + 19, ey% + 4), 44
    PSet (ex% + 20, ey% + 4), 41
    PSet (ex% + 3, ey% + 5), 42
    PSet (ex% + 4, ey% + 5), 43
    PSet (ex% + 6, ey% + 5), 41
    PSet (ex% + 8, ey% + 5), 42
    PSet (ex% + 9, ey% + 5), 43
    PSet (ex% + 10, ey% + 5), 42
    PSet (ex% + 11, ey% + 5), 41
    PSet (ex% + 12, ey% + 5), 42
    PSet (ex% + 13, ey% + 5), 43
    PSet (ex% + 14, ey% + 5), 43
    PSet (ex% + 16, ey% + 5), 40
    PSet (ex% + 18, ey% + 5), 43
    PSet (ex% + 19, ey% + 5), 41
    PSet (ex% + 9, ey% + 6), 41
    PSet (ex% + 11, ey% + 6), 42
    PSet (ex% + 12, ey% + 6), 41
    PSet (ex% + 13, ey% + 6), 43
    PSet (ex% + 14, ey% + 6), 42
    PSet (ex% + 15, ey% + 6), 42
    PSet (ex% + 16, ey% + 6), 42
    PSet (ex% + 18, ey% + 6), 41
    PSet (ex% + 19, ey% + 6), 42
    PSet (ex% + 10, ey% + 7), 41
    PSet (ex% + 11, ey% + 7), 43
    PSet (ex% + 12, ey% + 7), 42
    PSet (ex% + 13, ey% + 7), 42
    PSet (ex% + 14, ey% + 7), 44
    PSet (ex% + 15, ey% + 7), 42
    PSet (ex% + 16, ey% + 7), 43
    PSet (ex% + 17, ey% + 7), 42
    PSet (ex% + 18, ey% + 7), 43
    PSet (ex% + 24, ey% + 7), 40
    PSet (ex% + 9, ey% + 8), 41
    PSet (ex% + 10, ey% + 8), 44
    PSet (ex% + 11, ey% + 8), 43
    PSet (ex% + 12, ey% + 8), 44
    PSet (ex% + 13, ey% + 8), 43
    PSet (ex% + 14, ey% + 8), 43
    PSet (ex% + 15, ey% + 8), 41
    PSet (ex% + 16, ey% + 8), 40
    PSet (ex% + 18, ey% + 8), 41
    PSet (ex% + 10, ey% + 9), 40
    PSet (ex% + 11, ey% + 9), 42
    PSet (ex% + 12, ey% + 9), 43
    PSet (ex% + 13, ey% + 9), 43
    PSet (ex% + 14, ey% + 9), 42
    PSet (ex% + 15, ey% + 9), 41
    PSet (ex% + 11, ey% + 10), 40
    PSet (ex% + 12, ey% + 10), 42
    PSet (ex% + 13, ey% + 10), 40
End Sub

Sub xxf8
    PSet (ex% + 15, ey% + -3), 41
    PSet (ex% + 18, ey% + -3), 41
    PSet (ex% + 13, ey% + -2), 41
    PSet (ex% + 17, ey% + -2), 41
    PSet (ex% + 18, ey% + -2), 42
    PSet (ex% + 19, ey% + -2), 40
    PSet (ex% + 21, ey% + -2), 40
    PSet (ex% + 4, ey% + -1), 42
    PSet (ex% + 9, ey% + -1), 41
    PSet (ex% + 10, ey% + -1), 42
    PSet (ex% + 11, ey% + -1), 42
    PSet (ex% + 12, ey% + -1), 41
    PSet (ex% + 15, ey% + -1), 40
    PSet (ex% + 16, ey% + -1), 42
    PSet (ex% + 17, ey% + -1), 42
    PSet (ex% + 18, ey% + -1), 42
    PSet (ex% + 22, ey% + -1), 40
    PSet (ex% + 7, ey% + 0), 40
    PSet (ex% + 8, ey% + 0), 42
    PSet (ex% + 9, ey% + 0), 41
    PSet (ex% + 10, ey% + 0), 41
    PSet (ex% + 12, ey% + 0), 41
    PSet (ex% + 13, ey% + 0), 41
    PSet (ex% + 14, ey% + 0), 43
    PSet (ex% + 15, ey% + 0), 41
    PSet (ex% + 16, ey% + 0), 44
    PSet (ex% + 17, ey% + 0), 42
    PSet (ex% + 20, ey% + 0), 42
    PSet (ex% + 22, ey% + 0), 42
    PSet (ex% + 23, ey% + 0), 40
    PSet (ex% + 4, ey% + 1), 41
    PSet (ex% + 6, ey% + 1), 40
    PSet (ex% + 7, ey% + 1), 41
    PSet (ex% + 8, ey% + 1), 41
    PSet (ex% + 9, ey% + 1), 42
    PSet (ex% + 14, ey% + 1), 40
    PSet (ex% + 15, ey% + 1), 43
    PSet (ex% + 16, ey% + 1), 41
    PSet (ex% + 21, ey% + 1), 41
    PSet (ex% + 1, ey% + 2), 40
    PSet (ex% + 7, ey% + 2), 41
    PSet (ex% + 14, ey% + 2), 42
    PSet (ex% + 15, ey% + 2), 41
    PSet (ex% + 20, ey% + 2), 42
    PSet (ex% + 21, ey% + 2), 44
    PSet (ex% + 0, ey% + 3), 41
    PSet (ex% + 1, ey% + 3), 42
    PSet (ex% + 8, ey% + 3), 42
    PSet (ex% + 9, ey% + 3), 41
    PSet (ex% + 13, ey% + 3), 41
    PSet (ex% + 14, ey% + 3), 41
    PSet (ex% + 15, ey% + 3), 41
    PSet (ex% + 16, ey% + 3), 42
    PSet (ex% + 17, ey% + 3), 41
    PSet (ex% + 19, ey% + 3), 41
    PSet (ex% + 20, ey% + 3), 44
    PSet (ex% + 21, ey% + 3), 40
    PSet (ex% + 22, ey% + 3), 42
    PSet (ex% + 3, ey% + 4), 42
    PSet (ex% + 7, ey% + 4), 42
    PSet (ex% + 8, ey% + 4), 42
    PSet (ex% + 9, ey% + 4), 42
    PSet (ex% + 10, ey% + 4), 41
    PSet (ex% + 12, ey% + 4), 42
    PSet (ex% + 13, ey% + 4), 42
    PSet (ex% + 14, ey% + 4), 42
    PSet (ex% + 17, ey% + 4), 42
    PSet (ex% + 18, ey% + 4), 42
    PSet (ex% + 19, ey% + 4), 42
    PSet (ex% + 20, ey% + 4), 41
    PSet (ex% + 4, ey% + 5), 43
    PSet (ex% + 6, ey% + 5), 41
    PSet (ex% + 8, ey% + 5), 42
    PSet (ex% + 9, ey% + 5), 43
    PSet (ex% + 10, ey% + 5), 42
    PSet (ex% + 11, ey% + 5), 41
    PSet (ex% + 12, ey% + 5), 42
    PSet (ex% + 13, ey% + 5), 40
    PSet (ex% + 18, ey% + 5), 43
    PSet (ex% + 19, ey% + 5), 41
    PSet (ex% + 9, ey% + 6), 41
    PSet (ex% + 15, ey% + 6), 42
    PSet (ex% + 18, ey% + 6), 41
    PSet (ex% + 19, ey% + 6), 42
    PSet (ex% + 12, ey% + 7), 41
    PSet (ex% + 13, ey% + 7), 41
    PSet (ex% + 14, ey% + 7), 41
    PSet (ex% + 15, ey% + 7), 42
    PSet (ex% + 16, ey% + 7), 43
    PSet (ex% + 17, ey% + 7), 42
    PSet (ex% + 11, ey% + 8), 41
    PSet (ex% + 12, ey% + 8), 43
    PSet (ex% + 13, ey% + 8), 43
    PSet (ex% + 14, ey% + 8), 43
    PSet (ex% + 15, ey% + 8), 41
    PSet (ex% + 16, ey% + 8), 40
    PSet (ex% + 10, ey% + 9), 40
    PSet (ex% + 11, ey% + 9), 42
    PSet (ex% + 12, ey% + 9), 43
    PSet (ex% + 13, ey% + 9), 44
    PSet (ex% + 14, ey% + 9), 42
    PSet (ex% + 15, ey% + 9), 41
    PSet (ex% + 11, ey% + 10), 40
    PSet (ex% + 12, ey% + 10), 42
    PSet (ex% + 13, ey% + 10), 40
End Sub

Sub xxf9
    PSet (ex% + 16, ey% + -3), 40
    PSet (ex% + 13, ey% + -2), 41
    PSet (ex% + 18, ey% + -2), 42
    PSet (ex% + 9, ey% + -1), 41
    PSet (ex% + 10, ey% + -1), 42
    PSet (ex% + 11, ey% + -1), 42
    PSet (ex% + 12, ey% + -1), 41
    PSet (ex% + 15, ey% + -1), 40
    PSet (ex% + 16, ey% + -1), 42
    PSet (ex% + 17, ey% + -1), 42
    PSet (ex% + 18, ey% + -1), 42
    PSet (ex% + 8, ey% + 0), 42
    PSet (ex% + 12, ey% + 0), 41
    PSet (ex% + 13, ey% + 0), 41
    PSet (ex% + 14, ey% + 0), 43
    PSet (ex% + 15, ey% + 0), 41
    PSet (ex% + 16, ey% + 0), 44
    PSet (ex% + 17, ey% + 0), 42
    PSet (ex% + 22, ey% + 0), 42
    PSet (ex% + 8, ey% + 1), 40
    PSet (ex% + 9, ey% + 1), 42
    PSet (ex% + 14, ey% + 1), 40
    PSet (ex% + 15, ey% + 1), 43
    PSet (ex% + 16, ey% + 1), 41
    PSet (ex% + 14, ey% + 2), 42
    PSet (ex% + 15, ey% + 2), 41
    PSet (ex% + 20, ey% + 2), 40
    PSet (ex% + 21, ey% + 2), 41
    PSet (ex% + 13, ey% + 3), 41
    PSet (ex% + 14, ey% + 3), 41
    PSet (ex% + 15, ey% + 3), 42
    PSet (ex% + 16, ey% + 3), 40
    PSet (ex% + 19, ey% + 3), 41
    PSet (ex% + 20, ey% + 3), 42
    PSet (ex% + 21, ey% + 3), 40
    PSet (ex% + 22, ey% + 3), 42
    PSet (ex% + 7, ey% + 4), 41
    PSet (ex% + 8, ey% + 4), 40
    PSet (ex% + 12, ey% + 4), 42
    PSet (ex% + 13, ey% + 4), 42
    PSet (ex% + 14, ey% + 4), 40
    PSet (ex% + 17, ey% + 4), 42
    PSet (ex% + 18, ey% + 4), 42
    PSet (ex% + 19, ey% + 4), 42
    PSet (ex% + 20, ey% + 4), 41
    PSet (ex% + 8, ey% + 5), 41
    PSet (ex% + 9, ey% + 5), 42
    PSet (ex% + 10, ey% + 5), 42
    PSet (ex% + 11, ey% + 5), 41
    PSet (ex% + 12, ey% + 5), 41
    PSet (ex% + 18, ey% + 5), 41
    PSet (ex% + 19, ey% + 5), 41
    PSet (ex% + 9, ey% + 6), 41
    PSet (ex% + 15, ey% + 6), 42
    PSet (ex% + 18, ey% + 6), 41
    PSet (ex% + 19, ey% + 6), 42
    PSet (ex% + 12, ey% + 7), 41
    PSet (ex% + 14, ey% + 7), 41
    PSet (ex% + 15, ey% + 7), 42
    PSet (ex% + 16, ey% + 7), 43
    PSet (ex% + 17, ey% + 7), 42
    PSet (ex% + 11, ey% + 8), 41
    PSet (ex% + 12, ey% + 8), 42
    PSet (ex% + 13, ey% + 8), 42
    PSet (ex% + 14, ey% + 8), 43
    PSet (ex% + 15, ey% + 8), 41
    PSet (ex% + 11, ey% + 9), 40
    PSet (ex% + 12, ey% + 9), 43
    PSet (ex% + 13, ey% + 9), 41
    PSet (ex% + 14, ey% + 9), 42
    PSet (ex% + 12, ey% + 10), 40
End Sub

Sub z
    PSet Step(3, -4), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-1, 1), cf%

    PSet Step(-1, 1), cf%

    PSet Step(-1, 1), cf%

    PSet Step(-1, 1), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
End Sub

Sub z0
    PSet Step(1, -4), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
End Sub

Sub z1
    PSet Step(1, -4), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
End Sub

Sub z2
    PSet Step(1, -4), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
End Sub

Sub z3
    PSet Step(1, -4), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
End Sub

Sub z4
    PSet Step(1, -4), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
End Sub

Sub z5
    PSet Step(1, -4), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
End Sub

Sub z6
    PSet Step(1, -4), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
End Sub

Sub z7
    PSet Step(1, -4), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
End Sub

Sub z8
    PSet Step(1, -4), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
End Sub

Sub z9
    PSet Step(1, -4), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cb%
    PSet Step(1, 0), cf%

    PSet Step(-4, 1), cb%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cf%
    PSet Step(1, 0), cb%
End Sub

'Print number on the screen
Sub prnumber (num As Integer, stl As Integer)
    Dim As Integer tsd, hnd, znr, enr

    tsd% = Int(Abs(num%) / 1000)
    hnd% = Int((Abs(num%) - tsd% * 1000) / 100)
    znr% = Int((Abs(num%) - tsd% * 1000 - hnd% * 100) / 10)
    enr% = Abs(num%) - tsd% * 1000 - hnd% * 100 - znr% * 10

    If tsd% = 0 And hnd% = 0 And znr% = 0 Then znr% = -1
    If tsd% = 0 And hnd% = 0 Then hnd% = -1
    If tsd% = 0 Then tsd% = -1

    If tsd% <= 0 And hnd% <= 0 And znr% <= 0 And num% < 0 Then znr% = -2
    If tsd% <= 0 And hnd% <= 0 And znr% >= 0 And num% < 0 Then hnd% = -2
    If tsd% <= 0 And hnd% >= 0 And znr% >= 0 And num% < 0 Then tsd% = -2
    If tsd% >= 0 And hnd% >= 0 And znr% >= 0 And num% < 0 Then minus Else empty2

    If stl% = 4 Then
        Select Case tsd%
            Case -2: minus
            Case -1: empty2
            Case 0: z0
            Case 1: z1
            Case 2: z2
            Case 3: z3
            Case 4: z4
            Case 5: z5
            Case 6: z6
            Case 7: z7
            Case 8: z8
            Case 9: z9
        End Select
    End If

    If stl% >= 3 Then
        Select Case hnd%
            Case -2: minus
            Case -1: empty2
            Case 0: z0
            Case 1: z1
            Case 2: z2
            Case 3: z3
            Case 4: z4
            Case 5: z5
            Case 6: z6
            Case 7: z7
            Case 8: z8
            Case 9: z9
        End Select
    End If

    If stl% >= 2 Then
        Select Case znr%
            Case -2: minus
            Case -1: empty2
            Case 0: z0
            Case 1: z1
            Case 2: z2
            Case 3: z3
            Case 4: z4
            Case 5: z5
            Case 6: z6
            Case 7: z7
            Case 8: z8
            Case 9: z9
        End Select
    End If

    Select Case enr%
        Case 0: z0
        Case 1: z1
        Case 2: z2
        Case 3: z3
        Case 4: z4
        Case 5: z5
        Case 6: z6
        Case 7: z7
        Case 8: z8
        Case 9: z9
    End Select

End Sub

