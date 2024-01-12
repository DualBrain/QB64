_Title "Impossible Oval" 'b+ 2023-01-23

Screen _NewImage(800, 600, 32)
Dim As Long block
block = _NewImage(80, 40, 32)
_Dest block
For y = 0 To 40
    Line (0, y)-(100, y), midInk~&(80, 0, 0, 255, 100, 100, 1 - y / 40), BF
Next
_Dest 0
r = 230: a = 0
Do
    x = 410 + r * 1.5 * Cos(a): y = 300 + r * Sin(a)
    _PutImage (x - 50, y - 20), block, 0
    a = a + .002
    _Limit 1000
Loop Until a >= _Pi(2.47)

Function midInk~& (r1%, g1%, b1%, r2%, g2%, b2%, fr##)
    midInk~& = _RGB32(r1% + (r2% - r1%) * fr##, g1% + (g2% - g1%) * fr##, b1% + (b2% - b1%) * fr##)
End Function
