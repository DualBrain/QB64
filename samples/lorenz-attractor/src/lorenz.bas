' Created by QB64 community member vince.

$NoPrefix
Option Explicit
Option ExplicitArray

Screen NewImage(640, 480, 32)

Title "Rotating Lorenz Attractor"

Dim As Double p, s, b, h, x, y, z, i, rot, xx, yy
p = 28
s = 10
b = 8 / 3
h = 0.01

Display

Do
    Limit 60
    Cls
    rot = rot + 0.01
    x = 0.3
    y = 0.3
    z = 0.456
    xx = x * Cos(rot) - y * Sin(rot)
    yy = x * Sin(rot) + y * Cos(rot)

    PSet (Width / 2 + 35 * xx * 700 / (yy + 2500), Height - 35 * z * 700 / (yy + 2500)), RGB(255, 255, 0)
    For i = 0 To 14000
        x = x + h * s * (y - x)
        y = y + h * (x * (p - z) - y)
        z = z + h * (x * y - b * z)
        xx = x * Cos(rot) - y * Sin(rot)
        yy = x * Sin(rot) + y * Cos(rot)
        Line -(Width / 2 + 35 * xx * 700 / (yy + 2500), Height - 35 * z * 700 / (yy + 2500)), RGB(255, 255, 0)
    Next
    Display
Loop While Len(InKey$) = 0

System 0

