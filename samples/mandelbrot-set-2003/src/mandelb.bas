'MANDELBROT by Antoni Gual 2003
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------

$NoPrefix
DefLng A-Z
Option Explicit
Option ExplicitArray

$Resize:Smooth

Dim As Long x, iter
Dim As Single im2, im, re

Screen 13
FullScreen SquarePixels , Smooth

Do
    iter = 0
    x = (x + 123) Mod 64000

    3 im2 = im * im

    If iter Then im = 2 * re * im + (CSng(x \ 320) / 100 - 1) Else im = 0
    If iter Then re = re * re - im2 + (CSng(x Mod 320) / 120 - 1.9) Else re = 0
    iter = iter + 1

    If Abs(re) + Abs(im) > 2 Or iter > 254 Then PSet (x Mod 320, x \ 320), iter Else GoTo 3
Loop While Len(InKey$) = 0

System 0

