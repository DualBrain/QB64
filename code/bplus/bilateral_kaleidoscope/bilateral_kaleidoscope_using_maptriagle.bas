_Title "Kaleidoscope" 'b+ 2022-05-24
' it so obvious to use maptriangle!
Randomize Timer
Dim Shared sH, sW, sHd2, sWd2
sH = 700: sW = 700: sHd2 = sH / 2: sWd2 = sW / 2
Screen _NewImage(700, 700, 32)
_ScreenMove 290, 0
Do Until _KeyDown(27)
    If Rnd > .05 Then Line (0, 0)-(sW - 1, sH - 1), _RGB32(0, 0, 0, 10), BF Else Cls
    n = (n + 1) Mod 66 + 4
    If n Mod 2 Then n = n + 1
    ReDim px(0 To n - 1), py(0 To n - 1)
    circleDivN = _Pi(2 / n)
    For i = 0 To n - 1
        px(i) = sWd2 + sHd2 * Cos(i * circleDivN)
        py(i) = sHd2 + sHd2 * Sin(i * circleDivN)
    Next
    For i = 1 To 700
        Line (Rnd * sW, Rnd * sH)-Step(Rnd * 5, Rnd * 5), _RGB32(Rnd * 255, Rnd * 255, Rnd * 255), BF
        Circle (Rnd * sW, Rnd * sH), Rnd * 8 + 2, _RGB32(Rnd * 255, Rnd * 255, Rnd * 255)
    Next
    For i = 1 To 30
        w = Rnd * 700
        Line (sWd2 - w / 2, Rnd * sH)-Step(w, Rnd * 5), _RGB32(Rnd * 255, Rnd * 255, Rnd * 255), BF
    Next
    For s = 0 To n - 1
        For i = 0 To n - 1
            _MapTriangle (sWd2, sHd2)-(px((i + s) Mod n), py((i + s) Mod n))-(px((i + 1 + s) Mod n), py((i + 1 + s) Mod n)), 0 To(sWd2, sHd2)-(px((i + 2 + s) Mod n), py((i + 2 + s) Mod n))-(px((i + 1 + s) Mod n), py((i + 1 + s) Mod n))
        Next
    Next
    _Display
    _Limit 2
Loop
