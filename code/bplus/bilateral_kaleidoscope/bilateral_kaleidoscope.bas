_Title "Bilateral Kaleidoscope" ' 2023-01-02 NOT May 2022 version by b+
Const sh = 600, sw = 800
Screen _NewImage(sw, sh, 32)
'_ScreenMove 200, 100
_FullScreen
Randomize Timer
Do
    If lc = 0 Then
        dx1 = 0: dx2 = 0: dy1 = 0: dy2 = 0: dr = 0: dg = 0: db = 0
        x1 = sw * Rnd: y1 = sh * Rnd: x2 = sw * Rnd: y2 = sh * Rnd: r = Rnd * 255: g = Rnd * 255: b = Rnd * 255
        While dx1 = 0: dx1 = Rnd * 6 - 3: Wend
        While dx2 = 0: dx2 = Rnd * 6 - 3: Wend
        While dy1 = 0: dy1 = Rnd * 6 - 3: Wend
        While dy2 = 0: dy2 = Rnd * 6 - 3: Wend
        While dr = 0: dr = Rnd * 4 - 2: Wend
        While dg = 0: dg = Rnd * 4 - 2: Wend
        While db = 0: db = Rnd * 4 - 2: Wend
    End If
    Line (x1, y1)-(x2, y2), _RGB32(r, g, b, 100)
    Line (sw - x1, y1)-(sw - x2, y2), _RGB32(r, g, b, 100)
    Line (x1, sh - y1)-(x2, sh - y2), _RGB32(r, g, b, 100)
    Line (sw - x1, sh - y1)-(sw - x2, sh - y2), _RGB32(r, g, b, 100)
    x1 = Remainder(x1 + dx1, sw)
    x2 = Remainder(x2 + dx2, sw)
    y1 = Remainder(y1 + dy1, sh)
    y2 = Remainder(y2 + dy2, sh)
    r = Remainder(r + dr, 255)
    g = Remainder(g + dr, 255)
    b = Remainder(b + db, 255)
    lc = lc + 1
    If ((Rnd > .999) And (lc > 300)) Or (lc > 4000) Then Sleep 1: Cls: lc = 0
    _Limit 60
Loop Until _KeyDown(27)

Function Remainder (n, d)
    If d = 0 Then Exit Function
    Remainder = n - (d) * Int(n / (d))
End Function
