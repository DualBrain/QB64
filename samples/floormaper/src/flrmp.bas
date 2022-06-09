'Floormaper by Antoni Gual
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------
$NoPrefix
DefLng A-Z
Option Explicit
Option ExplicitArray

$Resize:Smooth

Dim As Long r, y, y1, x
Dim As Single y2

Screen 13
FullScreen SquarePixels , Smooth

Do
    r = (r + 1) And 15
    For y = 1 To 99
        y1 = ((1190 / y + r) And 15)
        y2 = 6 / y
        For x = 0 To 319
            PSet (x, y + 100), CInt((159 - x) * y2) And 15 Xor y1 + 16
        Next
    Next
    Limit 60
Loop While Len(InKey$) = 0

System 0
