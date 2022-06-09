'    Release: MINI-CLOCK by Folker Fritz
'    Version: 1.0 (1999-10-31)
'     Status: 100% Freeware
'      EMail: folker.fritz@gmx.de
'   Homepage: http://www.quickbasic.6x.to

$NoPrefix
DefSng A-Z
$Resize:Smooth

Screen 12
FullScreen SquarePixels , Smooth

Width 80, 60
FELT 0, 0, 639, 479, 7
FELT 36, 78, 597, 154, 0

Screen 12
Circle (320, 300), 85, 15
XCXX = Val(Mid$(Time$, 7, 2))
XCXY = Val(Mid$(Time$, 4, 2))
XCXZ = Val(Mid$(Time$, 1, 2))
1.1
XCXB = Pi * 2 / 12 - .0001
XCXD = Pi * 2 / 60 - .0001
XCXE = Pi * 2 / 60 - .0001
456

If InKey$ <> "" Then
    End
    System 0
End If

If XCXX <> Val(Mid$(Time$, 7, 2)) Then XCXX = Val(Mid$(Time$, 7, 2)): GFF = 1 Else GFF = 0: GoTo 456
If XCXY <> Val(Mid$(Time$, 4, 2)) Then XCXY = Val(Mid$(Time$, 4, 2)): GFG = 1 Else GFG = 0
If XCXZ <> Val(Mid$(Time$, 1, 2)) Then XCXZ = Val(Mid$(Time$, 1, 2)): GFH = 1 Else GFH = 0
XCXC = Val(Mid$(Time$, 1, 2))
XCXF = Val(Mid$(Time$, 4, 2))
XCXG = Val(Mid$(Time$, 7, 2))
If XCXC > 12 Then XCXC = XCXC - 12
If XCXC < 4 Then XCXC = XCXC + 12
If XCXC > 3 Then XCXC = XCXC - 3
If XCXF < 16 Then XCXF = XCXF + 60
If XCXF > 15 Then XCXF = XCXF - 15
If XCXG < 16 Then XCXG = XCXG + 60
If XCXG > 15 Then XCXG = XCXG - 15
If GFF = 1 Then Circle (320, 300), 80, 7, -2 * Pi + XCXII, -2 * Pi + XCXII: GFF = 1: XCXX = Val(Mid$(Time$, 7, 2))
If GFG = 1 Then Circle (320, 300), 60, 7, -2 * Pi + XCXHH, -2 * Pi + XCXHH: GFG = 0: XCXY = Val(Mid$(Time$, 4, 2))
If GFH = 1 Then Circle (320, 300), 40, 7, -2 * Pi + XCXAA, -2 * Pi + XCXAA: GFH = 1: XCXZ = Val(Mid$(Time$, 1, 2))
XCXA = XCXB * XCXC
XCXH = XCXD * XCXF
XCXI = XCXE * XCXG
XCXAA = XCXA
XCXHH = XCXH
XCXII = XCXI
Circle (320, 300), 40, 15, -2 * Pi + XCXA, -2 * Pi + XCXA
Circle (320, 300), 60, 12, -2 * Pi + XCXH, -2 * Pi + XCXH
Circle (320, 300), 80, 8, -2 * Pi + XCXI, -2 * Pi + XCXI
If TEMPTIME$ <> Time$ Then TEMPTIME$ = Time$: DATUM
KLPRINT Mid$(Date$, 4, 2) + ".", 18, 576, 10, 4
KLPRINT Mid$(Date$, 1, 2) + ".", 18, 594, 10, 4
KLPRINT Mid$(Date$, 7, 4), 18, 611, 10, 4
KLPRINT "MINI-CLOCK   Version 1.00", 18, 242, 0, 4
KLPRINT "12", 219, 314, 0, 15
KLPRINT "3", 310, 409, 0, 15
KLPRINT "9", 310, 227, 0, 15
KLPRINT "6", 403, 317, 0, 15
KLPRINT "1", 231, 364, 0, 15
KLPRINT "2", 265, 398, 0, 15
KLPRINT "11", 231, 266, 0, 15
KLPRINT "10", 265, 233, 0, 15
KLPRINT "4", 357, 397, 0, 15
KLPRINT "5", 391, 365, 0, 15
KLPRINT "8", 357, 239, 0, 15
KLPRINT "7", 390, 271, 0, 15
Color 15
A = -1
B = -1
C = -1
D = -1
E = -1
F = -1
Locate 14, 27: Print "лл"
Locate 16, 27: Print "лл"
Locate 14, 51: Print "лл"
Locate 16, 51: Print "лл"
20
If A <> Val(Mid$(Time$, 1, 1)) Then A = Val(Mid$(Time$, 1, 1)): GoTo 2 Else GoTo 1
2
Select Case A
    Case 0:
        Locate 12, 7: Print "лллллллл"
        Locate 13, 7: Print "лл    лл"
        Locate 14, 7: Print "лл    лл"
        Locate 15, 7: Print "лл    лл"
        Locate 16, 7: Print "лл    лл"
        Locate 17, 7: Print "лл    лл"
        Locate 18, 7: Print "лллллллл"
    Case 1
        Locate 12, 7: Print "      лл"
        Locate 13, 7: Print "      лл"
        Locate 14, 7: Print "      лл"
        Locate 15, 7: Print "      лл"
        Locate 16, 7: Print "      лл"
        Locate 17, 7: Print "      лл"
        Locate 18, 7: Print "      лл"
    Case 2:
        Locate 12, 7: Print "лллллллл"
        Locate 13, 7: Print "      лл"
        Locate 14, 7: Print "      лл"
        Locate 15, 7: Print "лллллллл"
        Locate 16, 7: Print "лл      "
        Locate 17, 7: Print "лл      "
        Locate 18, 7: Print "лллллллл"
End Select
1
If B <> Val(Mid$(Time$, 2, 1)) Then B = Val(Mid$(Time$, 2, 1)): GoTo 4 Else GoTo 3
4
Select Case B
    Case 0:
        Locate 12, 17: Print "лллллллл"
        Locate 13, 17: Print "лл    лл"
        Locate 14, 17: Print "лл    лл"
        Locate 15, 17: Print "лл    лл"
        Locate 16, 17: Print "лл    лл"
        Locate 17, 17: Print "лл    лл"
        Locate 18, 17: Print "лллллллл"
    Case 1
        Locate 12, 17: Print "      лл"
        Locate 13, 17: Print "      лл"
        Locate 14, 17: Print "      лл"
        Locate 15, 17: Print "      лл"
        Locate 16, 17: Print "      лл"
        Locate 17, 17: Print "      лл"
        Locate 18, 17: Print "      лл"
    Case 2:
        Locate 12, 17: Print "лллллллл"
        Locate 13, 17: Print "      лл"
        Locate 14, 17: Print "      лл"
        Locate 15, 17: Print "лллллллл"
        Locate 16, 17: Print "лл      "
        Locate 17, 17: Print "лл      "
        Locate 18, 17: Print "лллллллл"
    Case 3:
        Locate 12, 17: Print "лллллллл"
        Locate 13, 17: Print "      лл"
        Locate 14, 17: Print "      лл"
        Locate 15, 17: Print "лллллллл"
        Locate 16, 17: Print "      лл"
        Locate 17, 17: Print "      лл"
        Locate 18, 17: Print "лллллллл"
    Case 4:
        Locate 12, 17: Print "лл    лл"
        Locate 13, 17: Print "лл    лл"
        Locate 14, 17: Print "лл    лл"
        Locate 15, 17: Print "лллллллл"
        Locate 16, 17: Print "      лл"
        Locate 17, 17: Print "      лл"
        Locate 18, 17: Print "      лл"
    Case 5:
        Locate 12, 17: Print "лллллллл"
        Locate 13, 17: Print "лл      "
        Locate 14, 17: Print "лл      "
        Locate 15, 17: Print "лллллллл"
        Locate 16, 17: Print "      лл"
        Locate 17, 17: Print "      лл"
        Locate 18, 17: Print "лллллллл"
    Case 6:
        Locate 12, 17: Print "лллллллл"
        Locate 13, 17: Print "лл      "
        Locate 14, 17: Print "лл      "
        Locate 15, 17: Print "лллллллл"
        Locate 16, 17: Print "лл    лл"
        Locate 17, 17: Print "лл    лл"
        Locate 18, 17: Print "лллллллл"
    Case 7:
        Locate 12, 17: Print "лллллллл"
        Locate 13, 17: Print "      лл"
        Locate 14, 17: Print "      лл"
        Locate 15, 17: Print "      лл"
        Locate 16, 17: Print "      лл"
        Locate 17, 17: Print "      лл"
        Locate 18, 17: Print "      лл"
    Case 8:
        Locate 12, 17: Print "лллллллл"
        Locate 13, 17: Print "лл    лл"
        Locate 14, 17: Print "лл    лл"
        Locate 15, 17: Print "лллллллл"
        Locate 16, 17: Print "лл    лл"
        Locate 17, 17: Print "лл    лл"
        Locate 18, 17: Print "лллллллл"
    Case 9:
        Locate 12, 17: Print "лллллллл"
        Locate 13, 17: Print "лл    лл"
        Locate 14, 17: Print "лл    лл"
        Locate 15, 17: Print "лллллллл"
        Locate 16, 17: Print "      лл"
        Locate 17, 17: Print "      лл"
        Locate 18, 17: Print "лллллллл"
End Select
3
If C <> Val(Mid$(Time$, 4, 1)) Then C = Val(Mid$(Time$, 4, 1)): GoTo 6 Else GoTo 5
6
Select Case C
    Case 0:
        Locate 12, 31: Print "лллллллл"
        Locate 13, 31: Print "лл    лл"
        Locate 14, 31: Print "лл    лл"
        Locate 15, 31: Print "лл    лл"
        Locate 16, 31: Print "лл    лл"
        Locate 17, 31: Print "лл    лл"
        Locate 18, 31: Print "лллллллл"
    Case 1
        Locate 12, 31: Print "      лл"
        Locate 13, 31: Print "      лл"
        Locate 14, 31: Print "      лл"
        Locate 15, 31: Print "      лл"
        Locate 16, 31: Print "      лл"
        Locate 17, 31: Print "      лл"
        Locate 18, 31: Print "      лл"
    Case 2:
        Locate 12, 31: Print "лллллллл"
        Locate 13, 31: Print "      лл"
        Locate 14, 31: Print "      лл"
        Locate 15, 31: Print "лллллллл"
        Locate 16, 31: Print "лл      "
        Locate 17, 31: Print "лл      "
        Locate 18, 31: Print "лллллллл"
    Case 3:
        Locate 12, 31: Print "лллллллл"
        Locate 13, 31: Print "      лл"
        Locate 14, 31: Print "      лл"
        Locate 15, 31: Print "лллллллл"
        Locate 16, 31: Print "      лл"
        Locate 17, 31: Print "      лл"
        Locate 18, 31: Print "лллллллл"
    Case 4:
        Locate 12, 31: Print "лл    лл"
        Locate 13, 31: Print "лл    лл"
        Locate 14, 31: Print "лл    лл"
        Locate 15, 31: Print "лллллллл"
        Locate 16, 31: Print "      лл"
        Locate 17, 31: Print "      лл"
        Locate 18, 31: Print "      лл"
    Case 5:
        Locate 12, 31: Print "лллллллл"
        Locate 13, 31: Print "лл      "
        Locate 14, 31: Print "лл      "
        Locate 15, 31: Print "лллллллл"
        Locate 16, 31: Print "      лл"
        Locate 17, 31: Print "      лл"
        Locate 18, 31: Print "лллллллл"
    Case 6:
        Locate 12, 31: Print "лллллллл"
        Locate 13, 31: Print "лл      "
        Locate 14, 31: Print "лл      "
        Locate 15, 31: Print "лллллллл"
        Locate 16, 31: Print "лл    лл"
        Locate 17, 31: Print "лл    лл"
        Locate 18, 31: Print "лллллллл"
    Case 7:
        Locate 12, 31: Print "лллллллл"
        Locate 13, 31: Print "      лл"
        Locate 14, 31: Print "      лл"
        Locate 15, 31: Print "      лл"
        Locate 16, 31: Print "      лл"
        Locate 17, 31: Print "      лл"
        Locate 18, 31: Print "      лл"
    Case 8:
        Locate 12, 31: Print "лллллллл"
        Locate 13, 31: Print "лл    лл"
        Locate 14, 31: Print "лл    лл"
        Locate 15, 31: Print "лллллллл"
        Locate 16, 31: Print "лл    лл"
        Locate 17, 31: Print "лл    лл"
        Locate 18, 31: Print "лллллллл"
    Case 9:
        Locate 12, 31: Print "лллллллл"
        Locate 13, 31: Print "лл    лл"
        Locate 14, 31: Print "лл    лл"
        Locate 15, 31: Print "лллллллл"
        Locate 16, 31: Print "      лл"
        Locate 17, 31: Print "      лл"
        Locate 18, 31: Print "лллллллл"
End Select
5
If D <> Val(Mid$(Time$, 5, 1)) Then D = Val(Mid$(Time$, 5, 1)): GoTo 8 Else GoTo 7
8
Select Case D
    Case 0:
        Locate 12, 41: Print "лллллллл"
        Locate 13, 41: Print "лл    лл"
        Locate 14, 41: Print "лл    лл"
        Locate 15, 41: Print "лл    лл"
        Locate 16, 41: Print "лл    лл"
        Locate 17, 41: Print "лл    лл"
        Locate 18, 41: Print "лллллллл"
    Case 1
        Locate 12, 41: Print "      лл"
        Locate 13, 41: Print "      лл"
        Locate 14, 41: Print "      лл"
        Locate 15, 41: Print "      лл"
        Locate 16, 41: Print "      лл"
        Locate 17, 41: Print "      лл"
        Locate 18, 41: Print "      лл"
    Case 2:
        Locate 12, 41: Print "лллллллл"
        Locate 13, 41: Print "      лл"
        Locate 14, 41: Print "      лл"
        Locate 15, 41: Print "лллллллл"
        Locate 16, 41: Print "лл      "
        Locate 17, 41: Print "лл      "
        Locate 18, 41: Print "лллллллл"
    Case 3:
        Locate 12, 41: Print "лллллллл"
        Locate 13, 41: Print "      лл"
        Locate 14, 41: Print "      лл"
        Locate 15, 41: Print "лллллллл"
        Locate 16, 41: Print "      лл"
        Locate 17, 41: Print "      лл"
        Locate 18, 41: Print "лллллллл"
    Case 4:
        Locate 12, 41: Print "лл    лл"
        Locate 13, 41: Print "лл    лл"
        Locate 14, 41: Print "лл    лл"
        Locate 15, 41: Print "лллллллл"
        Locate 16, 41: Print "      лл"
        Locate 17, 41: Print "      лл"
        Locate 18, 41: Print "      лл"
    Case 5:
        Locate 12, 41: Print "лллллллл"
        Locate 13, 41: Print "лл      "
        Locate 14, 41: Print "лл      "
        Locate 15, 41: Print "лллллллл"
        Locate 16, 41: Print "      лл"
        Locate 17, 41: Print "      лл"
        Locate 18, 41: Print "лллллллл"
    Case 6:
        Locate 12, 41: Print "лллллллл"
        Locate 13, 41: Print "лл      "
        Locate 14, 41: Print "лл      "
        Locate 15, 41: Print "лллллллл"
        Locate 16, 41: Print "лл    лл"
        Locate 17, 41: Print "лл    лл"
        Locate 18, 41: Print "лллллллл"
    Case 7:
        Locate 12, 41: Print "лллллллл"
        Locate 13, 41: Print "      лл"
        Locate 14, 41: Print "      лл"
        Locate 15, 41: Print "      лл"
        Locate 16, 41: Print "      лл"
        Locate 17, 41: Print "      лл"
        Locate 18, 41: Print "      лл"
    Case 8:
        Locate 12, 41: Print "лллллллл"
        Locate 13, 41: Print "лл    лл"
        Locate 14, 41: Print "лл    лл"
        Locate 15, 41: Print "лллллллл"
        Locate 16, 41: Print "лл    лл"
        Locate 17, 41: Print "лл    лл"
        Locate 18, 41: Print "лллллллл"
    Case 9:
        Locate 12, 41: Print "лллллллл"
        Locate 13, 41: Print "лл    лл"
        Locate 14, 41: Print "лл    лл"
        Locate 15, 41: Print "лллллллл"
        Locate 16, 41: Print "      лл"
        Locate 17, 41: Print "      лл"
        Locate 18, 41: Print "лллллллл"
End Select
7
If E <> Val(Mid$(Time$, 7, 1)) Then E = Val(Mid$(Time$, 7, 1)): GoTo 10 Else GoTo 9
10
Select Case E
    Case 0:
        Locate 12, 55: Print "лллллллл"
        Locate 13, 55: Print "лл    лл"
        Locate 14, 55: Print "лл    лл"
        Locate 15, 55: Print "лл    лл"
        Locate 16, 55: Print "лл    лл"
        Locate 17, 55: Print "лл    лл"
        Locate 18, 55: Print "лллллллл"
    Case 1
        Locate 12, 55: Print "      лл"
        Locate 13, 55: Print "      лл"
        Locate 14, 55: Print "      лл"
        Locate 15, 55: Print "      лл"
        Locate 16, 55: Print "      лл"
        Locate 17, 55: Print "      лл"
        Locate 18, 55: Print "      лл"
    Case 2:
        Locate 12, 55: Print "лллллллл"
        Locate 13, 55: Print "      лл"
        Locate 14, 55: Print "      лл"
        Locate 15, 55: Print "лллллллл"
        Locate 16, 55: Print "лл      "
        Locate 17, 55: Print "лл      "
        Locate 18, 55: Print "лллллллл"
    Case 3:
        Locate 12, 55: Print "лллллллл"
        Locate 13, 55: Print "      лл"
        Locate 14, 55: Print "      лл"
        Locate 15, 55: Print "лллллллл"
        Locate 16, 55: Print "      лл"
        Locate 17, 55: Print "      лл"
        Locate 18, 55: Print "лллллллл"
    Case 4:
        Locate 12, 55: Print "лл    лл"
        Locate 13, 55: Print "лл    лл"
        Locate 14, 55: Print "лл    лл"
        Locate 15, 55: Print "лллллллл"
        Locate 16, 55: Print "      лл"
        Locate 17, 55: Print "      лл"
        Locate 18, 55: Print "      лл"
    Case 5:
        Locate 12, 55: Print "лллллллл"
        Locate 13, 55: Print "лл      "
        Locate 14, 55: Print "лл      "
        Locate 15, 55: Print "лллллллл"
        Locate 16, 55: Print "      лл"
        Locate 17, 55: Print "      лл"
        Locate 18, 55: Print "лллллллл"
    Case 6:
        Locate 12, 55: Print "лллллллл"
        Locate 13, 55: Print "лл      "
        Locate 14, 55: Print "лл      "
        Locate 15, 55: Print "лллллллл"
        Locate 16, 55: Print "лл    лл"
        Locate 17, 55: Print "лл    лл"
        Locate 18, 55: Print "лллллллл"
    Case 7:
        Locate 12, 55: Print "лллллллл"
        Locate 13, 55: Print "      лл"
        Locate 14, 55: Print "      лл"
        Locate 15, 55: Print "      лл"
        Locate 16, 55: Print "      лл"
        Locate 17, 55: Print "      лл"
        Locate 18, 55: Print "      лл"
    Case 8:
        Locate 12, 55: Print "лллллллл"
        Locate 13, 55: Print "лл    лл"
        Locate 14, 55: Print "лл    лл"
        Locate 15, 55: Print "лллллллл"
        Locate 16, 55: Print "лл    лл"
        Locate 17, 55: Print "лл    лл"
        Locate 18, 55: Print "лллллллл"
    Case 9:
        Locate 12, 55: Print "лллллллл"
        Locate 13, 55: Print "лл    лл"
        Locate 14, 55: Print "лл    лл"
        Locate 15, 55: Print "лллллллл"
        Locate 16, 55: Print "      лл"
        Locate 17, 55: Print "      лл"
        Locate 18, 55: Print "лллллллл"
End Select
9
If F <> Val(Mid$(Time$, 8, 1)) Then F = Val(Mid$(Time$, 8, 1)): GoTo 12 Else GoTo 1.1
12
Select Case F
    Case 0:
        Locate 12, 65: Print "лллллллл"
        Locate 13, 65: Print "лл    лл"
        Locate 14, 65: Print "лл    лл"
        Locate 15, 65: Print "лл    лл"
        Locate 16, 65: Print "лл    лл"
        Locate 17, 65: Print "лл    лл"
        Locate 18, 65: Print "лллллллл"
    Case 1:
        Locate 12, 65: Print "      лл"
        Locate 13, 65: Print "      лл"
        Locate 14, 65: Print "      лл"
        Locate 15, 65: Print "      лл"
        Locate 16, 65: Print "      лл"
        Locate 17, 65: Print "      лл"
        Locate 18, 65: Print "      лл"
    Case 2:
        Locate 12, 65: Print "лллллллл"
        Locate 13, 65: Print "      лл"
        Locate 14, 65: Print "      лл"
        Locate 15, 65: Print "лллллллл"
        Locate 16, 65: Print "лл      "
        Locate 17, 65: Print "лл      "
        Locate 18, 65: Print "лллллллл"
    Case 3:
        Locate 12, 65: Print "лллллллл"
        Locate 13, 65: Print "      лл"
        Locate 14, 65: Print "      лл"
        Locate 15, 65: Print "лллллллл"
        Locate 16, 65: Print "      лл"
        Locate 17, 65: Print "      лл"
        Locate 18, 65: Print "лллллллл"
    Case 4:
        Locate 12, 65: Print "лл    лл"
        Locate 13, 65: Print "лл    лл"
        Locate 14, 65: Print "лл    лл"
        Locate 15, 65: Print "лллллллл"
        Locate 16, 65: Print "      лл"
        Locate 17, 65: Print "      лл"
        Locate 18, 65: Print "      лл"
    Case 5:
        Locate 12, 65: Print "лллллллл"
        Locate 13, 65: Print "лл      "
        Locate 14, 65: Print "лл      "
        Locate 15, 65: Print "лллллллл"
        Locate 16, 65: Print "      лл"
        Locate 17, 65: Print "      лл"
        Locate 18, 65: Print "лллллллл"
    Case 6:
        Locate 12, 65: Print "лллллллл"
        Locate 13, 65: Print "лл      "
        Locate 14, 65: Print "лл      "
        Locate 15, 65: Print "лллллллл"
        Locate 16, 65: Print "лл    лл"
        Locate 17, 65: Print "лл    лл"
        Locate 18, 65: Print "лллллллл"
    Case 7:
        Locate 12, 65: Print "лллллллл"
        Locate 13, 65: Print "      лл"
        Locate 14, 65: Print "      лл"
        Locate 15, 65: Print "      лл"
        Locate 16, 65: Print "      лл"
        Locate 17, 65: Print "      лл"
        Locate 18, 65: Print "      лл"
    Case 8:
        Locate 12, 65: Print "лллллллл"
        Locate 13, 65: Print "лл    лл"
        Locate 14, 65: Print "лл    лл"
        Locate 15, 65: Print "лллллллл"
        Locate 16, 65: Print "лл    лл"
        Locate 17, 65: Print "лл    лл"
        Locate 18, 65: Print "лллллллл"
    Case 9:
        Locate 12, 65: Print "лллллллл"
        Locate 13, 65: Print "лл    лл"
        Locate 14, 65: Print "лл    лл"
        Locate 15, 65: Print "лллллллл"
        Locate 16, 65: Print "      лл"
        Locate 17, 65: Print "      лл"
        Locate 18, 65: Print "лллллллл"
End Select
GoTo 1.1

DefInt A-Z
Sub DATUM
    KLPRINT Time$, 18, 5, 10, 4
    If Mid$(Time$, 1, 2) <> "00" Then GoTo 3.1
    If Mid$(Time$, 4, 2) <> "00" Then GoTo 3.1
    If Mid$(Time$, 7, 2) <> "00" Then GoTo 3.1
    KLPRINT Mid$(Date$, 4, 2) + ".", 18, 576, 10, 4
    KLPRINT Mid$(Date$, 1, 2) + ".", 18, 594, 10, 4
    KLPRINT Mid$(Date$, 7, 4), 18, 611, 10, 4
    3.1:
End Sub

Sub FELT (X, Y, XX, YY, FARBEN)
    Line (X, Y)-(X, YY), 15
    Line (X, Y)-(XX, Y), 15
    Line (X, YY)-(XX, YY), 8
    Line (XX, Y)-(XX, YY), 8
    View (X + 2, Y + 2)-(XX - 2, YY - 2), FARBEN, FARBEN
    View (0, 0)-(639, 479)
End Sub

Sub KLPRINT (B$, B, K, G, I)
    C = Len(B$)
    B$ = UCase$(B$)
    D = K - 6
    E = B - 14
    If G <> 10 Then E = E - G
    7.1: F = F + 1
    H = F * 6
    If F = C + 1 Then GoTo 198
    If G = 10 Then
        View (D + H, E)-(D + H + 4, E + 6), 7, 7
        View (0, 0)-(639, 479)
    End If
    If Mid$(B$, F, 1) = " " Then
        GoTo 123
    ElseIf Mid$(B$, F, 1) = "A" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "B" Then
        PSet (D + H, E + 0), I: PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "C" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I
        PSet (D + H, E + 3), I
        PSet (D + H, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "D" Then
        PSet (D + H, E + 0), I: PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "E" Then
        PSet (D + H, E + 0), I: PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 1), I
        PSet (D + H, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I
        PSet (D + H, E + 4), I
        PSet (D + H, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "F" Then
        PSet (D + H, E + 0), I: PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 1), I
        PSet (D + H, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I
        PSet (D + H, E + 4), I
        PSet (D + H, E + 5), I
        PSet (D + H, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "G" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 3, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "H" Then
        PSet (D + H, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "I" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H + 2, E + 1), I
        PSet (D + H + 2, E + 2), I
        PSet (D + H + 2, E + 3), I
        PSet (D + H + 2, E + 4), I
        PSet (D + H + 2, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "J" Then
        PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H + 3, E + 1), I
        PSet (D + H + 3, E + 2), I
        PSet (D + H + 3, E + 3), I
        PSet (D + H + 3, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 3, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "K" Then
        PSet (D + H, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 3, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 2, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 1, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 2, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 3, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "L" Then
        PSet (D + H, E + 0), I
        PSet (D + H, E + 1), I
        PSet (D + H, E + 2), I
        PSet (D + H, E + 3), I
        PSet (D + H, E + 4), I
        PSet (D + H, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "M" Then
        PSet (D + H, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 1, E + 1), I: PSet (D + H + 3, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 2, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "N" Then
        PSet (D + H, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 1, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 2, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 2, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 3, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "O" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "P" Then
        PSet (D + H, E + 0), I: PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I
        PSet (D + H, E + 4), I
        PSet (D + H, E + 5), I
        PSet (D + H, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "Q" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 2, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 3, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "R" Then
        PSet (D + H, E + 0), I: PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 2, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 3, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "S" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 1), I
        PSet (D + H, E + 2), I
        PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I
        PSet (D + H + 4, E + 4), I
        PSet (D + H + 4, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "T" Then
        PSet (D + H, E + 0), I: PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H + 2, E + 1), I
        PSet (D + H + 2, E + 2), I
        PSet (D + H + 2, E + 3), I
        PSet (D + H + 2, E + 4), I
        PSet (D + H + 2, E + 5), I
        PSet (D + H + 2, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "U" Then
        PSet (D + H, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "V" Then
        PSet (D + H, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H + 1, E + 3), I: PSet (D + H + 3, E + 3), I
        PSet (D + H + 1, E + 4), I: PSet (D + H + 3, E + 4), I
        PSet (D + H + 2, E + 5), I
        PSet (D + H + 2, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "W" Then
        PSet (D + H, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 2, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 1, E + 5), I: PSet (D + H + 3, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "X" Then
        PSet (D + H, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H + 1, E + 2), I: PSet (D + H + 3, E + 2), I
        PSet (D + H + 2, E + 3), I
        PSet (D + H + 1, E + 4), I: PSet (D + H + 3, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "Y" Then
        PSet (D + H, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H + 1, E + 3), I: PSet (D + H + 3, E + 3), I
        PSet (D + H + 2, E + 4), I
        PSet (D + H + 2, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "Z" Then
        PSet (D + H, E + 0), I: PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H + 3, E + 2), I
        PSet (D + H + 2, E + 3), I
        PSet (D + H + 1, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "." Then
        PSet (D + H + 1, E + 5), I: PSet (D + H + 2, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "," Then
        PSet (D + H + 1, E + 4), I: PSet (D + H + 2, E + 4), I
        PSet (D + H + 1, E + 5), I: PSet (D + H + 2, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 1, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "&" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 3, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 2, E + 2), I
        PSet (D + H + 1, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 2, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 3, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "(" Then
        PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H + 1, E + 1), I
        PSet (D + H, E + 2), I
        PSet (D + H, E + 3), I
        PSet (D + H, E + 4), I
        PSet (D + H + 1, E + 5), I
        PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = ")" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I
        PSet (D + H + 3, E + 1), I
        PSet (D + H + 4, E + 2), I
        PSet (D + H + 4, E + 3), I
        PSet (D + H + 4, E + 4), I
        PSet (D + H + 3, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "1" Then
        PSet (D + H + 3, E + 0), I
        PSet (D + H + 2, E + 1), I: PSet (D + H + 3, E + 1), I
        PSet (D + H + 1, E + 2), I: PSet (D + H + 3, E + 2), I
        PSet (D + H + 3, E + 3), I
        PSet (D + H + 3, E + 4), I
        PSet (D + H + 3, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "2" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H + 3, E + 3), I
        PSet (D + H + 2, E + 4), I
        PSet (D + H + 1, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "3" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H + 4, E + 2), I
        PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I
        PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "4" Then
        PSet (D + H + 3, E + 0), I
        PSet (D + H + 2, E + 1), I: PSet (D + H + 3, E + 1), I
        PSet (D + H + 1, E + 2), I: PSet (D + H + 3, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H + 3, E + 4), I
        PSet (D + H + 3, E + 5), I
        PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "5" Then
        PSet (D + H, E + 0), I: PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 1), I
        PSet (D + H, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I
        PSet (D + H + 4, E + 4), I
        PSet (D + H + 4, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "6" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "7" Then
        PSet (D + H, E + 0), I: PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H + 3, E + 2), I
        PSet (D + H + 3, E + 3), I
        PSet (D + H + 2, E + 4), I
        PSet (D + H + 2, E + 5), I
        PSet (D + H + 2, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "8" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "9" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "0" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 3, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 1, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = ":" Then
        PSet (D + H + 1, E + 1), I: PSet (D + H + 2, E + 1), I
        PSet (D + H + 1, E + 2), I: PSet (D + H + 2, E + 2), I
        PSet (D + H + 1, E + 4), I: PSet (D + H + 2, E + 4), I
        PSet (D + H + 1, E + 5), I: PSet (D + H + 2, E + 5), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "-" Then
        PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I
        PSet (D + H + 3, E + 3), I: PSet (D + H + 4, E + 3), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "$" Then
        PSet (D + H + 2, E + 0), I
        PSet (D + H + 1, E + 1), I: PSet (D + H + 2, E + 1), I: PSet (D + H + 3, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 2, E + 2), I
        PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I
        PSet (D + H + 2, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 1, E + 5), I: PSet (D + H + 2, E + 5), I: PSet (D + H + 3, E + 5), I
        PSet (D + H + 2, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "*" Then
        PSet (D + H, E + 1), I: PSet (D + H + 2, E + 1), I: PSet (D + H + 4, E + 1), I
        PSet (D + H + 1, E + 2), I: PSet (D + H + 2, E + 2), I: PSet (D + H + 3, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 1, E + 3), I: PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H + 1, E + 4), I: PSet (D + H + 2, E + 4), I: PSet (D + H + 3, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 2, E + 5), I: PSet (D + H + 4, E + 5), I
    ElseIf Mid$(B$, F, 1) = "/" Then
        PSet (D + H + 4, E + 0), I
        PSet (D + H + 3, E + 1), I
        PSet (D + H + 3, E + 2), I
        PSet (D + H + 2, E + 3), I
        PSet (D + H + 1, E + 4), I
        PSet (D + H + 1, E + 5), I
        PSet (D + H, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "\" Then
        PSet (D + H, E + 0), I
        PSet (D + H + 1, E + 1), I
        PSet (D + H + 1, E + 2), I
        PSet (D + H + 2, E + 3), I
        PSet (D + H + 3, E + 4), I
        PSet (D + H + 3, E + 5), I
        PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "[" Then
        PSet (D + H, E + 0), I: PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I
        PSet (D + H, E + 1), I
        PSet (D + H, E + 2), I
        PSet (D + H, E + 3), I
        PSet (D + H, E + 4), I
        PSet (D + H, E + 5), I
        PSet (D + H, E + 6), I: PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "]" Then
        PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H + 4, E + 1), I
        PSet (D + H + 4, E + 2), I
        PSet (D + H + 4, E + 3), I
        PSet (D + H + 4, E + 4), I
        PSet (D + H + 4, E + 5), I
        PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "_" Then
        PSet (D + H, E + 6), I: PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: PSet (D + H + 4, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "" Or Mid$(B$, F, 1) = "" Then
        PSet (D + H, E + 0), I: PSet (D + H + 4, E + 0), I
        PSet (D + H, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 4, E + 5), I
        PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I
    ElseIf Mid$(B$, F, 1) = "!" Then
        PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I
        PSet (D + H + 1, E + 1), I: PSet (D + H + 2, E + 1), I: PSet (D + H + 3, E + 1), I
        PSet (D + H + 2, E + 2), I
        PSet (D + H + 2, E + 5), I
        PSet (D + H + 2, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = ">" Then
        PSet (D + H + 1, E + 0), I
        PSet (D + H + 2, E + 1), I
        PSet (D + H + 3, E + 2), I
        PSet (D + H + 4, E + 3), I
        PSet (D + H + 3, E + 4), I
        PSet (D + H + 2, E + 5), I
        PSet (D + H + 1, E + 6), I: GoTo 123
    ElseIf Mid$(B$, F, 1) = "@" Then
        PSet (D + H, E + 0), 7: PSet (D + H + 1, E + 0), I: PSet (D + H + 2, E + 0), I: PSet (D + H + 3, E + 0), I: PSet (D + H + 4, E + 0), 7
        PSet (D + H, E + 1), I: PSet (D + H + 1, E + 1), 7: PSet (D + H + 2, E + 1), 7: PSet (D + H + 3, E + 1), 7: PSet (D + H + 4, E + 1), I
        PSet (D + H, E + 2), I: PSet (D + H + 1, E + 2), 7: PSet (D + H + 2, E + 2), I: PSet (D + H + 3, E + 2), I: PSet (D + H + 4, E + 2), I
        PSet (D + H, E + 3), I: PSet (D + H + 1, E + 3), 7: PSet (D + H + 2, E + 3), I: PSet (D + H + 3, E + 3), I: PSet (D + H + 4, E + 3), I
        PSet (D + H, E + 4), I: PSet (D + H + 1, E + 4), 7: PSet (D + H + 2, E + 4), I: PSet (D + H + 3, E + 4), I: PSet (D + H + 4, E + 4), I
        PSet (D + H, E + 5), I: PSet (D + H + 1, E + 5), 7: PSet (D + H + 2, E + 5), 7: PSet (D + H + 3, E + 5), 7: PSet (D + H + 4, E + 5), 7
        PSet (D + H, E + 6), 7: PSet (D + H + 1, E + 6), I: PSet (D + H + 2, E + 6), I: PSet (D + H + 3, E + 6), I: PSet (D + H + 4, E + 6), 7
    ElseIf Mid$(B$, F, 1) = "<" Then
        PSet (D + H + 3, E + 0), I
        PSet (D + H + 2, E + 1), I
        PSet (D + H + 1, E + 2), I
        PSet (D + H, E + 3), I
        PSet (D + H + 1, E + 4), I
        PSet (D + H + 2, E + 5), I
        PSet (D + H + 3, E + 6), I: GoTo 123
    123 End If
    If F - 1 < C Then GoTo 7.1
    198:
End Sub

