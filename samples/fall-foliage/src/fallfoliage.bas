_Title "Fall Foliage 2017-10-21 by bplus"
'fall foliage.bas SmallBASIC 0.12.9 (B+=MGA) 2017-10-21
'test landscape and portrait views for Android
'xmx = min(xmax, 400) : ymx = min(700, ymax) 'portrait
'OK it's just plain better in landscape view

'now for full viewing enjoyment
'xmx = xmax : ymx = ymax

Const xmx = 1200
Const ymx = 700
Common Shared rad
DefSng A-Z

rad = _Pi(1 / 180)
Screen _NewImage(xmx, ymx, 32)
_ScreenMove 100, 20 'adjust as needed _MIDDLE needs a delay .5 or more for me


n = 3
While 1
    If n < 15 Then n = n + 3
    horizon = rand%(.8 * ymx, .9 * ymx)
    For i = 0 To horizon
        midInk 0, 0, 128, 10, 120, 128, i / horizon
        lien 0, i, xmx, i
    Next
    For i = horizon To ymx
        midInk 70, 108, 30, 60, 10, 5, (i - horizon) / (ymx - horizon)
        lien 0, i, xmx, i
    Next
    For i = 1 To xmx * ymx * .00018
        leaf rand%(0, xmx), rand%(horizon * 1.002, ymx)
    Next
    If n < .01 * xmx Then trees = n Else trees = rand%(.002 * xmx, .03 * xmx)
    For i = 1 To trees
        y = horizon + .04 * ymx + i / trees * (ymx - horizon - .1 * ymx)
        r = .01 * y: h = rand%(y * .15, y * .18)
        branch rand%(10, xmx - 10), y, r, 90, h, 0
    Next
    fRect xmx, 0, xmax, ymax, 0
    fRect 0, ymx, xmx, ymax, 0
    _Display
    Sleep 2
Wend

Sub branch (xx, yy, startrr, angDD, lengthh, levv)
    x = xx: y = yy
    lev = levv
    length = lengthh
    angD = angDD
    startr = startrr
    x2 = x + Cos(rad * (angD)) * length
    y2 = y - Sin(rad * (angD)) * length
    dx = (x2 - x) / length
    dy = (y2 - y) / length
    bc& = _RGB(30 + 6 * lev, 15 + 3 * lev, 5 + 2 * lev)
    For i = 0 To length
        Color bc&
        fCirc x + dx * i, y + dy * i, startr
    Next
    If lev > 1 Then leaf x2, y2
    If .8 * startr < .1 Or lev > 7 Or length < 3 Then Exit Sub
    lev = lev + 1
    branch x2, y2, .8 * startr, angD + 22 + rand%(-10, 19), rand%(.75 * length, .9 * length), lev
    branch x2, y2, .8 * startr, angD - 22 - rand%(-10, 19), rand%(.75 * length, .9 * length), lev
End Sub

'Steve McNeil's  copied from his forum   note: Radius is too common a name
Sub fCirc (CX As Long, CY As Long, R As Long)
    Dim subRadius As Long, RadiusError As Long
    Dim X As Long, Y As Long

    subRadius = Abs(R)
    RadiusError = -subRadius
    X = subRadius
    Y = 0

    If subRadius = 0 Then PSet (CX, CY): Exit Sub

    ' Draw the middle span here so we don't draw it twice in the main loop,
    ' which would be a problem with blending turned on.
    Line (CX - X, CY)-(CX + X, CY), , BF

    While X > Y
        RadiusError = RadiusError + Y * 2 + 1
        If RadiusError >= 0 Then
            If X <> Y + 1 Then
                Line (CX - Y, CY - X)-(CX + Y, CY - X), , BF
                Line (CX - Y, CY + X)-(CX + Y, CY + X), , BF
            End If
            X = X - 1
            RadiusError = RadiusError - X * 2
        End If
        Y = Y + 1
        Line (CX - X, CY - Y)-(CX + X, CY - Y), , BF
        Line (CX - X, CY + Y)-(CX + X, CY + Y), , BF
    Wend
End Sub

Sub fRect (x1, y1, x2, y2, c&)
    Line (x1, y1)-(x2, y2), c&, BF
End Sub

Sub fRectStep (x1, y1, x2, y2)
    Line (x1, y1)-Step(x2, y2), , BF
End Sub

Sub lien (x1, y1, x2, y2)
    Line (x1, y1)-(x2, y2)
End Sub

Sub leaf (x, y)
    sp = 15: leafs = rand%(xmx * ymx * .00001, xmx * ymx * .00002)
    For n = 1 To leafs
        Color _RGB(rand%(50, 250), rand%(25, 255), rand%(0, 40))
        xoff = x + Rnd * sp - Rnd * sp
        yoff = y + Rnd * sp - Rnd * sp
        woff = 3 + Rnd * 3
        hoff = 3 + Rnd * 3
        fRectStep xoff, yoff, woff, hoff
    Next
End Sub

Sub midInk (r1%, g1%, b1%, r2%, g2%, b2%, fr##)
    Color _RGB(r1% + (r2% - r1%) * fr##, g1% + (g2% - g1%) * fr##, b1% + (b2% - b1%) * fr##)
End Sub

Function rand% (lo%, hi%)
    rand% = Int(Rnd * (hi% - lo% + 1)) + lo%
End Function



