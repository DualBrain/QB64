Option _Explicit
DefLng A-Z

Dim sw, sh
Dim h, w, a
Dim img
Dim x0, y0, x, y, dz
Dim tl, tr, bl, br
Dim r, g, b
Dim i, j, t

sw = 640
sh = 480

Dim Shared pi As Double
pi = 4 * Atn(1)

Screen _NewImage(sw, sh, 32)

h = 300
w = 1.9 * h
a = h / 7

img = _NewImage(w, h, 32)
_Dest img
x0 = 0
y0 = 0

Line (0, 0)-Step(w, h), _RGB(255, 255, 255), BF
For i = 0 To 6
    Line (0, i * h * 2 / 13)-Step(w, h / 13), _RGB(255 * 0.698, 255 * 0.132, 255 * 0.203), BF
Next
Line (0, 0)-Step(w * 2 / 5, h * 7 / 13), _RGB(255 * 0.234, 255 * 0.233, 255 * 0.430), BF

For i = 0 To 4
    For j = 0 To 5
        starf (j * 2 + 1) * w * 2 / (5 * 12), (i * 2 + 1) * h * 7 / 130, h * 4 / (13 * 5 * 2), _RGB(255, 255, 255)
    Next
Next

For i = 1 To 4
    For j = 1 To 5
        starf (j * 2) * w * 2 / (5 * 12), (i * 2) * h * 7 / 130, h * 4 / (13 * 5 * 2), _RGB(255, 255, 255)
    Next
Next

_Dest 0
'_putimage (sw/2 - w/2, sh/2 - h/2), img
_Source img

x0 = sw / 2 - w / 2 '+ sw
y0 = sh / 2 - h / 2 '+ sh

Dim t As Double
Dim z As Double

Dim xx As Double, yy As Double
Dim dx As Double, dy As Double
Do
    t = t + 0.2

    Line (0, 0)-Step(sw, sh), _RGB(0, 0, 0), BF

    For y = 0 To h + a * 0.707 Step 1
        For x = 0 To w + a * 0.707 Step 1
            z = (0.1 + 0.4 * (x / w)) * a * Sin(x / 35 - y / 70 - t) + 0.5 * a
            dz = 50 * a * Cos(x / 35 - y / 70 - t) / 35

            xx = x + z * 0.707 - a * 0.707
            yy = y - z * 0.707

            If (Int(xx) >= 0 And Int(xx) < w - 1 And Int(yy) >= 0 And Int(yy) < h - 1) Then
                tl = Point(Int(xx), Int(yy))
                tr = Point(Int(xx) + 1, Int(yy))
                bl = Point(Int(xx), Int(yy) + 1)
                br = Point(Int(xx) + 1, Int(yy) + 1)

                dx = xx - Int(xx)
                dy = yy - Int(yy)

                r = _Round((1 - dy) * ((1 - dx) * _Red(tl) + dx * _Red(tr)) + dy * ((1 - dx) * _Red(bl) + dx * _Red(br)))
                g = _Round((1 - dy) * ((1 - dx) * _Green(tl) + dx * _Green(tr)) + dy * ((1 - dx) * _Green(bl) + dx * _Green(br)))
                b = _Round((1 - dy) * ((1 - dx) * _Blue(tl) + dx * _Blue(tr)) + dy * ((1 - dx) * _Blue(bl) + dx * _Blue(br)))

                r = r + dz
                g = g + dz
                b = b + dz

                If r < 0 Then r = 0
                If r > 255 Then r = 255
                If g < 0 Then g = 0
                If g > 255 Then g = 255
                If b < 0 Then b = 0
                If b > 255 Then b = 255

                PSet (x0 + x, y0 - a * 0.707 + y), _RGB(r, g, b)
            End If
        Next
    Next

    _Display
    _Limit 50
Loop Until _KeyHit = 27

Sleep
System

Sub starf (x, y, r, c)
    Dim i, xx, yy
    PSet (x + r * Cos(pi / 2), y - r * Sin(pi / 2)), c
    For i = 0 To 5
        xx = r * Cos(i * 4 * pi / 5 + pi / 2)
        yy = r * Sin(i * 4 * pi / 5 + pi / 2)
        Line -(x + xx, y - yy), c
    Next
    Paint (x, y), c
    For i = 0 To 5
        xx = r * Cos(i * 4 * pi / 5 + pi / 2) / 2
        yy = r * Sin(i * 4 * pi / 5 + pi / 2) / 2
        Paint (x + xx, y - yy), c
    Next
End Sub


