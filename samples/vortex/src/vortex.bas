' Vortex  Antoni Gual 2003
' for Rel's 9 liners contest at QBASICNEWS.COM
'------------------------------------------------------------------------
$NoPrefix
DefLng A-Z
Option Explicit
Option ExplicitArray

$Resize:Smooth
Screen 13
FullScreen SquarePixels , Smooth

Dim a As String
Dim j As Long

2 Palette Len(a$) / 3, 0
a$ = a$ + Chr$(32 - 31 * Sin((Len(a$) - 60 * ((Len(a$) Mod 3) = 2) + 60 * ((Len(a$) Mod 3) = 1)) * 3.14151693# / 128))
Circle (160, 290 - Len(a$) ^ .8), Len(a$) / 2.8, Len(a$) \ 3, , , .5
Circle (160, 290 - Len(a$) ^ .8 + 1), Len(a$) / 2.8, Len(a$) \ 3, , , .5
If Len(a$) < 256 * 3 Then 2 Else Out &H3C8, 0

Do
    j = (j + 1) Mod (Len(a$) - 3)
    Out &H3C9, Asc(Mid$(a$, j + 1, 1))
Loop While Len(InKey$) = 0

System 0

