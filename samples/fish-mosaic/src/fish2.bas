DefDbl A-Z

Dim Shared pi, a1, a2, a, b, w1, w2, h

pi = 4 * Atn(1)

a1 = 14
a2 = 4

w = 30 * 7
w1 = w * 5 / 7
w2 = w - w1
h = w * 2 / 7

a = -h / a2 / Sin(pi * w / w1)
a = Exp(Log(a) / w)
b = a1 * pi / w1 / w2

sw = w * 4 + w2
sh = h * 8 + 114

Screen _NewImage(sw, sh, 32)

Line (0, 0)-(sw, sh), _RGB(255, 255, 255), BF

For i = -1 To 4
    For j = -1 To 4
        fish w2 + i * w, 50 + h * j * 2, w, i And 1
        fish sw - w2 - i * w, 50 + h * j * 2 + h, -w, i And 1
    Next
Next

'Sleep
'System

Function f (x, aa)
    f = aa * (a ^ x) * Sin(pi * x / w1)
End Function

Function g (x, v)
    g = b * x * (x - v)
End Function

Sub fish (x0, y0, ww, u)
    Dim c1 As _Unsigned Long
    Dim c2 As _Unsigned Long

    c1 = _RGB(200, 200, 200)
    c2 = _RGB(255, 255, 255)
    If u Then Swap c1, c2

    w = Abs(ww)
    s = Sgn(ww)

    'background
    Color c1
    For x = w To w1 Step -1
        Line (x0 + s * (x - w), y0 - f(x, a2))-(x0 + s * (x - w), y0 - g(x - w, -w2))
    Next
    For x = 0 To w1
        Line (x0 + s * x, y0 - f(x, a2))-(x0 + s * x, y0 + h - f(w1 - x, a1))
    Next
    For x = 0 To w2
        Line (x0 + s * (w - x), y0 + h - g(-x, -w2))-(x0 + s * (w - x), y0 - f(w - x, a2))
    Next
    For xx = 0 To w1 / 3 / 7
        If xx > 0 And xx < w1 / 3 / 7 Then
            x = xx * 3 * 7 + 3
            ox = x0 + s * x
            oy = y0 - f(x, a1)
            oy2 = y0 + h - f(w1 - x, a2)
            For zz = 0 To 3 * 7 + 2
                z = xx * 3 * 7 + zz
                Line (ox, oy)-(x0 + s * z, y0 - f(z, a2))
                Line (ox, oy2)-(x0 + s * z, y0 + h - f(w1 - z, a1))
            Next
        End If
    Next

    Color _RGB(0, 0, 0)
    'closed shape
    PSet (x0, y0)
    For x = 0 To w
        Line -(x0 + s * x, y0 - f(x, a2))
    Next
    For x = 0 To w2
        Line -(x0 + s * (w - x), y0 + h - g(-x, -w2))
    Next
    For x = 0 To w1
        Line -(x0 + s * (w1 - x), y0 + h - f(x, a1))
    Next
    For x = w To w1 Step -1
        Line -(x0 + s * (x - w), y0 - f(x, a2))
    Next
    For x = 0 To w2
        Line -(x0 - s * (w2 - x), y0 - g(x, w2))
    Next
    For x = 0 To w1
        Line -(x0 + s * x, y0 - f(x, a1))
    Next


    'flourish
    Circle (x0 + s * w1, y0 + 21), 3, c2
    Paint (x0 + s * w1, y0 + 21), c2
    Circle (x0 + s * w1, y0 + 21), 3

    For xx = 0 To w1 / 3 / 7
        If xx = 1 Then
            x = xx * 3 * 7 + 3
            PSet (x0 + s * x, y0 - f(x, a1))
        ElseIf xx > 1 And xx < w1 / 3 / 7 - 1 Then
            x = xx * 3 * 7
            Line -(x0 + s * x, y0 - f(x, a2))
            x = x + 3
            Line -(x0 + s * x, y0 - f(x, a1))
        End If
    Next

    For xx = 0 To w1 / 3 / 7
        If xx = 0 Then
            x = (xx + 1) * 3 * 7 + 3
            PSet (x0 + s * x, y0 + h - f(w1 - x, a2))
        ElseIf xx > 0 And xx < w1 / 3 / 7 Then
            x = xx * 3 * 7
            Line -(x0 + s * x, y0 + h - f(w1 - x, a1))
            x = x + 3
            Line -(x0 + s * x, y0 + h - f(w1 - x, a2))
        End If
    Next

    For xx = 1 To w2 / 8 - 1
        x = w - xx * 8
        x2 = w - xx * 6.5 - 7
        Line (x0 + s * (x - w), y0 - f(x, a2))-(x0 + s * (x2 + 2 * 7 - w), y0 - f(x2, a2))
    Next
End Sub

