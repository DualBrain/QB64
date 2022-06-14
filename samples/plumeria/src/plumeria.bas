DefDbl A-Z
pi = 4 * Atn(1)
Screen _NewImage(640, 640, 32)
_Title "Plumeria"
For t = 0 To 2 * _Pi Step 0.001
    x = 190 * Cos(t) + 200 * Cos(t * 6)
    y = 190 * Sin(t) + 200 * Sin(t * 6)
    d = Sqr(x * x + y * y)
    If d < 250 Then
        c = 255 - d
        If d > od Or d > 110 Then
            PSet (320 + x, 320 + y), _RGB(255, 200 - 0.8 * c, 225 - 0.8 * c)
        End If
    End If
    od = d
Next
'Sleep
System

