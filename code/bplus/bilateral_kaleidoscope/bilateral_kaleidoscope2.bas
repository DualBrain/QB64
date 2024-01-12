_Title "Bilateral Kaleidoscope 2 - shape shifter" ' 2023-01-02 NOT May 2022 version by b+
Const sh = 600, sw = 800: linelimit = 400
Type lion
    As Single x1, y1, x2, y2
    As _Unsigned Long c
End Type
Dim Shared l(linelimit) As lion, li As Long
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
    Cls
    For i = 0 To li
        Line (l(i).x1, l(i).y1)-(l(i).x2, l(i).y2), l(i).c
        Line (sw - l(i).x1, l(i).y1)-(sw - l(i).x2, l(i).y2), l(i).c
        Line (l(i).x1, sh - l(i).y1)-(l(i).x2, sh - l(i).y2), l(i).c
        Line (sw - l(i).x1, sh - l(i).y1)-(sw - l(i).x2, sh - l(i).y2), l(i).c
    Next
    x1 = Remainder(x1 + dx1, sw)
    x2 = Remainder(x2 + dx2, sw)
    y1 = Remainder(y1 + dy1, sh)
    y2 = Remainder(y2 + dy2, sh)
    r = Remainder(r + dr, 255)
    g = Remainder(g + dr, 255)
    b = Remainder(b + db, 255)
    If li < linelimit Then
        li = li + 1
        l(li).x1 = x1: l(li).y1 = y1: l(li).x2 = x2: l(li).y2 = y2: l(li).c = _RGB32(r, g, b, 100)
    Else
        For i = 0 To linelimit - 1
            l(i) = l(i + 1)
        Next
        l(linelimit).x1 = x1: l(linelimit).y1 = y1: l(linelimit).x2 = x2: l(linelimit).y2 = y2: l(linelimit).c = _RGB32(r, g, b, 100)
    End If
    lc = lc + 1
    If lc > 4000 Then Sleep 1: Cls: lc = 0: li = 0
    _Display
    _Limit 100
Loop Until _KeyDown(27)

Function Remainder (n, d)
    If d = 0 Then Exit Function
    Remainder = n - (d) * Int(n / (d))
End Function
