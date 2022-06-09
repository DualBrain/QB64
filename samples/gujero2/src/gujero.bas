'-----------------------------------------------------------------------
'GUJERO2.BAS by Antoni Gual 2/2004
'For the QBNZ 1/2004 9 liner contest
'-----------------------------------------------------------------------
'Tunnel effect (more or less)
'FFIX recommended. It does compile.
'-----------------------------------------------------------------------
$NoPrefix
DefLng A-Z
Option Explicit
Option ExplicitArray

$Resize:Smooth

Dim As Long i, x, y
Dim As Single a

Screen 13
FullScreen SquarePixels , Smooth

Do
    If i = 1 Then Out &H3C8, 0 Else If i <= 194 Then Out &H3C9, Int((i - 2) / 3)
    If i <= 194 Then GoTo 8
    For y = -100 To 99
        For x = -160 To 159
            If x >= 0 Then If y < 0 Then a = 1.57079632679# + Atn(x / (y + .000001)) Else a = -Atn(y / (x + .000001)) Else If y < 0 Then a = 1.57079632679# + Atn(x / (y + .000001)) Else a = -1.57079632679# + Atn(x / (y + .000001))
            PSet (x + 160, y + 100), (x * x + y * y) * .00003 * ((Int(-10000 * i + 5.2 * Sqr(x * x + y * y)) And &H3F) Xor (Int((191 * a) + 10 * i) And &H3F))
        Next
    Next
    8 i = i + 1
Loop While Len(InKey$) = 0

System 0

