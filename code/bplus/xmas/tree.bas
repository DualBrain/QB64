Option _Explicit
_Title "Programmable Tree Lights v3" ' b+ 2020-12-19 2022-12-18 fixed k$ v3 random position lights
Randomize Timer
Const Xmax = 700, Ymax = 700, N_Rows = 10, N_Cols = 2 * N_Rows - 1
Const X_Spacer = 30, Y_Spacer = 52, X_Offset = 50
Type ColorSeed
    Red As Single
    Green As Single
    Blue As Single
End Type
Dim Shared ColorSet(10) As ColorSeed, ColorSetIndex As Long
Dim Shared pR, pG, pB, pN, pStart, pMode$
Dim Shared TG(1 To N_Cols, 1 To N_Rows) As Long
Screen _NewImage(Xmax, Ymax, 32)
_Delay .25
_ScreenMove _Middle
Dim As Long i, row, Col, nstars, back, cc
Dim horizon, r, land
Dim l$, o$, b$, k$
' setup some color seeds in ColorSet user can change out with Shift + digit key
For i = 0 To 9 ' 10 random color seeds
    resetPlasma
    ColorSet(i).Red = pR: ColorSet(i).Green = pG: ColorSet(i).Blue = pB
Next

'Stringing the lights on tree, adjusted to fit mostly on the tree   2*N - 1 Pryramid
For row = 1 To 10
    l$ = xStr$(2 * row - 1, "X")
    o$ = xStr$(10 - row, "O")
    b$ = o$ + l$ + o$
    For Col = 1 To N_Cols
        If Mid$(b$, Col, 1) = "O" Then TG(Col, row) = 0 Else TG(Col, row) = -1
    Next
    Print b$
Next

' making the stars
horizon = Ymax - 4 * r
nstars = 100
Dim xstar(100), ystar(100), rstar(100)
For i = 1 To 100
    xstar(i) = Rnd * (Xmax): ystar(i) = Rnd * horizon:
    If i < 75 Then
        rstar(i) = 0
    ElseIf i < 95 Then
        rstar(i) = 1
    Else
        rstar(i) = 2
    End If
Next
Cls
' make a circle tree and align circles to tree with spacers and offsets with new Pyramid Scheme
'Pinetree 25, 30, 650, 600
'FOR row = 1 TO N_Rows
'    FOR col = 1 TO N_Cols
'        IF TG(col, row) THEN CIRCLE (col * X_Spacer + X_Offset, row * Y_Spacer), 10
'    NEXT
'NEXT

' making the background
back = _NewImage(_Width, _Height, 32)
Cls
horizon = Ymax - 100
For i = 0 To horizon
    Line (0, i)-(Xmax, i), _RGB32(i / horizon * 70, i / horizon * 22, 60 * (i) / horizon)
Next
land = Ymax - horizon
For i = horizon To Ymax
    cc = 128 + (i - horizon) / land * 127
    Line (0, i)-(Xmax, i), _RGB32(cc, cc, cc)
Next
For i = 1 To 100
    fcirc xstar(i), ystar(i), rstar(i), &HFFEEEEFF
Next
_PutImage , 0, back

ColorSetIndex = 1: pMode$ = "h"
show ' avoid the pause for key checking
Do
    k$ = InKey$
    If Len(k$) Then
        If InStr("0123456789", k$) > 0 Then
            ColorSetIndex = Val(k$)
        ElseIf InStr("vhde", k$) > 0 Then
            pMode$ = k$
        End If
    End If
    _PutImage , back, 0
    show
    _Display
    _Limit 10
Loop Until _KeyDown(27)

Sub show
    Dim row, prow, col
    Pinetree 25, 30, 650, 600
    _Title "Programmable Tree Lights (0-9) Color Set: " + TS$(ColorSetIndex) + "  (v, h, d, e) Mode: " + pMode$
    pR = ColorSet(ColorSetIndex).Red: pG = ColorSet(ColorSetIndex).Green: pB = ColorSet(ColorSetIndex).Blue
    pStart = pStart + 1
    Select Case pMode$
        Case "h"
            For row = 1 To N_Rows
                prow = pStart + row
                For col = 1 To N_Cols
                    pN = prow
                    If TG(col, row) Then Lite col * X_Spacer + X_Offset, row * Y_Spacer + 7 * Sin(col * X_Spacer + X_Offset) - 1.3 * col, Plasma~&
                Next
            Next
        Case "v"
            For row = 1 To N_Rows
                For col = 1 To N_Cols
                    pN = pStart + col
                    If TG(col, row) Then Lite col * X_Spacer + X_Offset, row * Y_Spacer + 7 * Sin(col * X_Spacer + X_Offset) - 1.3 * col, Plasma~&
                Next
            Next
        Case "d"
            For row = 1 To N_Rows
                For col = 1 To N_Cols
                    pN = pStart + col - row
                    If TG(col, row) Then Lite col * X_Spacer + X_Offset, row * Y_Spacer + 7 * Sin(col * X_Spacer + X_Offset) - 1.3 * col, Plasma~&
                Next
            Next
        Case "e"
            For row = 1 To N_Rows
                For col = 1 To N_Cols
                    pN = pStart + row + col
                    If TG(col, row) Then Lite col * X_Spacer + X_Offset, row * Y_Spacer + 7 * Sin(col * X_Spacer + X_Offset) - 1.3 * col, Plasma~&
                Next
            Next

    End Select
End Sub

Sub Lite (x, y, c As _Unsigned Long)
    Dim cR, cG, cB, cA, r
    cAnalysis c, cR, cG, cB, cA
    For r = 35 To 0 Step -2
        fcirc x, y, r, _RGB32(cR, cG, cB, 1)
    Next
    fcirc x, y, 4, c
End Sub

Sub Pinetree (treeX, treeY, wide, high)
    Dim bpx, bpy, tpx, bpxx, bpyy, aa, ra, tpy, ht, xs, xsh, rs, tpxx, tpyy, fra, x1, x2, y1, y2, wf, hf
    'tannen baum by PeterMaria W  orig 440x460
    'fits here  LINE (0, 0)-(440, 410), , B
    Static t&
    If t& = 0 Then
        t& = _NewImage(440, 410, 32)
        _Dest t&
        bpx = 220: bpy = 410
        tpx = bpx
        For aa = -4 To 4
            bpxx = bpx + aa
            bpyy = bpy - 390
            Line (bpxx, bpy)-(bpx, bpyy), _RGB32(30, 30, 0)
        Next
        ra = 160
        tpy = bpy - 40
        For ht = 1 To 40
            For xs = -100 To 100 Step 40
                xsh = xs / 100
                rs = Rnd * 4 / 10
                tpxx = tpx + (xsh * ra)
                tpyy = tpy - rs * ra
                Line (tpx, tpy)-(tpxx, tpyy), _RGB32(50, 40, 20)
                For aa = 1 To 30
                    fra = Rnd * 10 / 10 * ra
                    x1 = tpx + (xsh * fra)
                    y1 = tpy - rs * fra
                    x2 = tpx + xsh * (fra + ra / 5)
                    y2 = tpy - rs * fra + (-rs + (Rnd * 8) / 10 - 0.4) * (ra / 5)
                    Line (x1, y1)-(x2, y2), _RGB32(Rnd * 80, Rnd * 70 + 40, Rnd * 60)
                Next
            Next
            ra = ra - 4
            tpy = tpy - 9
        Next
        _Dest 0
    End If
    wf = wide / 440: hf = high / 410
    _PutImage (treeX, treeY)-Step(440 * wf, 410 * hf), t&, 0
End Sub

Sub cAnalysis (c As _Unsigned Long, outRed, outGrn, outBlu, outAlp)
    outRed = _Red32(c): outGrn = _Green32(c): outBlu = _Blue32(c): outAlp = _Alpha32(c)
End Sub

Function Plasma~& ()
    pN = pN + 1 'dim shared cN as _Integer64, pR as integer, pG as integer, pB as integer
    Plasma~& = _RGB32(127 + 127 * Sin(pR * pN), 127 + 127 * Sin(pG * pN), 127 + 127 * Sin(pB * pN))
End Function

Sub resetPlasma ()
    pR = Rnd ^ 2: pG = Rnd ^ 2: pB = Rnd ^ 2: pN = 0
End Sub

Function xStr$ (x, strng$)
    Dim i, rtn$
    For i = 1 To x
        rtn$ = rtn$ + strng$
    Next
    xStr$ = rtn$
End Function

Function TS$ (n As Integer)
    TS$ = _Trim$(Str$(n))
End Function

'from Steve Gold standard
Sub fcirc (CX As Integer, CY As Integer, R As Integer, C As _Unsigned Long)
    Dim Radius As Integer, RadiusError As Integer
    Dim X As Integer, Y As Integer
    Radius = Abs(R): RadiusError = -Radius: X = Radius: Y = 0
    If Radius = 0 Then PSet (CX, CY), C: Exit Sub
    Line (CX - X, CY)-(CX + X, CY), C, BF
    While X > Y
        RadiusError = RadiusError + Y * 2 + 1
        If RadiusError >= 0 Then
            If X <> Y + 1 Then
                Line (CX - Y, CY - X)-(CX + Y, CY - X), C
                Line (CX - Y, CY + X)-(CX + Y, CY + X), C
            End If
            X = X - 1
            RadiusError = RadiusError - X * 2
        End If
        Y = Y + 1
        Line (CX - X, CY - Y)-(CX + X, CY - Y), C
        Line (CX - X, CY + Y)-(CX + X, CY + Y), C
    Wend
End Sub
