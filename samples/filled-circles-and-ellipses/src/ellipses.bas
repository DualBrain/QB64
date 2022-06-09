Screen _NewImage(800, 600, 32)

Dim TransRed As _Unsigned Long
Dim TransGreen As _Unsigned Long
Dim TransBlue As _Unsigned Long
TransRed = _RGBA(255, 0, 0, 128)
TransGreen = _RGBA(0, 255, 0, 128)
TransBlue = _RGBA(0, 0, 255, 128)

Call CircleFill(100, 100, 75, TransRed)
Call CircleFill(120, 120, 75, TransBlue)

Call EllipseFill(550, 100, 150, 75, TransBlue)
Call EllipseFill(570, 120, 150, 75, TransGreen)

Call EllipseTilt(200, 400, 150, 75, 0, TransGreen)
Call EllipseTilt(220, 420, 150, 75, 3.14 / 4, TransRed)

Call EllipseTiltFill(0, 550, 400, 150, 75, 3.14 / 6, TransRed)
Call EllipseTiltFill(0, 570, 420, 150, 75, 3.14 / 4, TransGreen)

End

Sub CircleFill (CX As Integer, CY As Integer, R As Integer, C As _Unsigned Long)
    ' CX = center x coordinate
    ' CY = center y coordinate
    '  R = radius
    '  C = fill color
    Dim Radius As Integer, RE As Integer
    Dim X As Integer, Y As Integer
    Radius = Abs(R)
    RE = -Radius
    X = Radius
    Y = 0
    If Radius = 0 Then PSet (CX, CY), C: Exit Sub
    Line (CX - X, CY)-(CX + X, CY), C, BF
    While X > Y
        RE = RE + Y * 2 + 1
        If RE >= 0 Then
            If X <> Y + 1 Then
                Line (CX - Y, CY - X)-(CX + Y, CY - X), C, BF
                Line (CX - Y, CY + X)-(CX + Y, CY + X), C, BF
            End If
            X = X - 1
            RE = RE - X * 2
        End If
        Y = Y + 1
        Line (CX - X, CY - Y)-(CX + X, CY - Y), C, BF
        Line (CX - X, CY + Y)-(CX + X, CY + Y), C, BF
    Wend
End Sub

Sub EllipseFill (CX As Integer, CY As Integer, a As Integer, b As Integer, C As _Unsigned Long)
    ' CX = center x coordinate
    ' CY = center y coordinate
    '  a = semimajor axis
    '  b = semiminor axis
    '  C = fill color
    If a = 0 Or b = 0 Then Exit Sub
    Dim h2 As _Integer64
    Dim w2 As _Integer64
    Dim h2w2 As _Integer64
    Dim x As Integer
    Dim y As Integer
    w2 = a * a
    h2 = b * b
    h2w2 = h2 * w2
    Line (CX - a, CY)-(CX + a, CY), C, BF
    Do While y < b
        y = y + 1
        x = Sqr((h2w2 - y * y * w2) \ h2)
        Line (CX - x, CY + y)-(CX + x, CY + y), C, BF
        Line (CX - x, CY - y)-(CX + x, CY - y), C, BF
    Loop
End Sub

Sub EllipseTilt (CX, CY, a, b, ang, C As _Unsigned Long)
    '  CX = center x coordinate
    '  CY = center y coordinate
    '   a = semimajor axis
    '   b = semiminor axis
    ' ang = clockwise orientation of semimajor axis in radians (0 default)
    '   C = fill color
    For k = 0 To 6.283185307179586 + .025 Step .025
        i = a * Cos(k) * Cos(ang) + b * Sin(k) * Sin(ang)
        j = -a * Cos(k) * Sin(ang) + b * Sin(k) * Cos(ang)
        i = i + CX
        j = -j + CY
        If k <> 0 Then
            Line -(i, j), C
        Else
            PSet (i, j), C
        End If
    Next
End Sub

Sub EllipseTiltFill (destHandle&, CX, CY, a, b, ang, C As _Unsigned Long)
    '  destHandle& = destination handle
    '  CX = center x coordinate
    '  CY = center y coordinate
    '   a = semimajor axis
    '   b = semiminor axis
    ' ang = clockwise orientation of semimajor axis in radians (0 default)
    '   C = fill color
    Dim max As Integer, mx2 As Integer, i As Integer, j As Integer
    Dim prc As _Unsigned Long
    Dim D As Integer, S As Integer
    D = _Dest: S = _Source
    prc = _RGB32(255, 255, 255, 255)
    If a > b Then max = a + 1 Else max = b + 1
    mx2 = max + max
    tef& = _NewImage(mx2, mx2)
    _Dest tef&
    _Source tef&
    For k = 0 To 6.283185307179586 + .025 Step .025
        i = max + a * Cos(k) * Cos(ang) + b * Sin(k) * Sin(ang)
        j = max + a * Cos(k) * Sin(ang) - b * Sin(k) * Cos(ang)
        If k <> 0 Then
            Line (lasti, lastj)-(i, j), prc
        Else
            PSet (i, j), prc
        End If
        lasti = i: lastj = j
    Next
    Dim xleft(mx2) As Integer, xright(mx2) As Integer, x As Integer, y As Integer
    For y = 0 To mx2
        x = 0
        While Point(x, y) <> prc And x < mx2
            x = x + 1
        Wend
        xleft(y) = x
        While Point(x, y) = prc And x < mx2
            x = x + 1
        Wend
        While Point(x, y) <> prc And x < mx2
            x = x + 1
        Wend
        If x = mx2 Then xright(y) = xleft(y) Else xright(y) = x
    Next
    _Dest destHandle&
    For y = 0 To mx2
        If xleft(y) <> mx2 Then Line (xleft(y) + CX - max, y + CY - max)-(xright(y) + CX - max, y + CY - max), C, BF
    Next
    _Dest D: _Dest S
    _FreeImage tef&
End Sub


