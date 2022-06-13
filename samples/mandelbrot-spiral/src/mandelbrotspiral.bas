DECLARE FUNCTION mandel% (ox!, oy!, limit!)
'public domain
Screen 12
Dim red(15) As Integer, green(15) As Integer, blue(15) As Integer
For i = 0 To 15: Read red(i): Next
For i = 0 To 15: Read green(i): Next
For i = 0 To 15: Read blue(i): Next
For i = 0 To 15: Palette i, 65536 * blue(i) + 256& * green(i) + red(i): Next
Data 0,63,63,63,63,63,47,31,31,47,47,47,55,59,59,63
Data 0,31,39,47,55,63,63,63,55,47,39,31,31,31,31,31
Data 0,31,31,31,31,31,31,31,47,63,63,63,63,63,52,42
real = -.77195: imag = -.116
incr = .0000025#
For y = 0 To 479
    r = real
    For x = 0 To 639
        colour = mandel(r, imag, 256)
        If (colour <> 256) Then colour = 1 + colour Mod 15 Else colour = 0
        PSet (x, y), colour
        r = r + incr
    Next
    imag = imag + incr
Next
j = 14
Do
    For i = 0 To 15
        colour = i + j
        If colour < 0 Then colour = colour + 15
        If colour > 14 Then colour = colour - 15
        Palette 1 + colour, 65536 * blue(i) + 256& * green(i) + red(i)
    Next
    j = j - 1
    If j < 0 Then j = j + 15
    T! = Timer + .05
    If T! >= 86400 Then T! = T! - 86400
    Do
        If InKey$ = Chr$(27) Then System
    Loop While T! > Timer
Loop

Function mandel% (ox, oy, limit)
    x = ox: y = oy
    For c% = limit To 1 Step -1
        xx = x * x: yy = y * y
        If xx + yy >= 4 Then Exit For
        y = x * y * 2 + oy
        x = xx - yy + ox
    Next
    mandel = c%
End Function

