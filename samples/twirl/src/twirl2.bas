'Twirl by Antoni Gual, from an idea  by Steve Nunnaly
'for Rel's 9 LINER contest at QBASICNEWS.COM  1/2003
'------------------------------------------------------------------------
$NoPrefix
DefLng A-Z
Option Explicit
Option ExplicitArray

$Resize:Smooth
Screen 13
FullScreen SquarePixels , Smooth

Dim As Single i, w, xmid, ymid

For i = 0 To 199
    Circle (160, 100), i, (i Mod 16) + 32, , , .8
Next

Dim b2%(5000)

Do
    w = (w + .3)
    xmid = 140 + Sin(7 * w / 1000) * 110
    ymid = 80 + Sin(11 * w / 1000) * 59
    Get ((xmid - (Sin(w) * 28)), (ymid - (Cos(w) * 20)))-((xmid - (Sin(w) * 28)) + 40, (ymid - (Cos(w) * 20)) + 40), b2%()
    Put ((xmid - (Sin(w - .04) * 27.16)), (ymid - (Cos(w - .04) * 19.4))), b2%(), PSet

    Delay .001
Loop While Len(InKey$) = 0

System 0

