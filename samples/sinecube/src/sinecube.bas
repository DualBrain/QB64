'sinecube 2006 mennonite
'public domain

$NoPrefix
DefLng A-Z
Option Explicit
Option ExplicitArray

$Resize:Smooth
Screen 12
FullScreen SquarePixels , Smooth

Dim blox(40, 40, 40) As Integer
Dim As Long l, y, x, by, bx, z
Dim As Single mm
Dim As String b

Line (0, 0)-(639, 479), , B

l = 8

b$ = b$ + "00000000..."
b$ = b$ + "llnnnnnnl.."
b$ = b$ + "l8lnnnnnnl."
b$ = b$ + "l88llllllll"
b$ = b$ + "l88l000000l"
b$ = b$ + "l88l000000l"
b$ = b$ + "l88l000000l"
b$ = b$ + "l88l000000l"
b$ = b$ + ".l8l000000l"
b$ = b$ + "..ll000000l"
b$ = b$ + "...llllllll"

blox(2, 3, 32) = 1

For l = 8 * 32 To 1 Step -8
    For y = 4 To 4 * 32 Step 4
        For x = 8 * 32 To 1 Step -8
            mm = Sin(x * y * l * 3.14): If mm < 0 Then mm = -1 Else If mm > 0 Then mm = 1
            If blox(x / 8, y / 4, l / 8) = mm + 1 Then
                For by = 1 To 11
                    For bx = 1 To 11
                        If Right$(Left$(b$, (by - 1) * 11 + bx), 1) <> "." Then
                            z = 11
                            PSet (x + bx - 1 + y - 3, by - 1 + y + l + 4), Asc(Right$(Left$(b$, (by - 1) * 11 + bx), 1)) Mod 16 + (y Mod 2)
                        End If

                    Next bx
                Next by
            End If
            If InKey$ = Chr$(27) Then End
            Delay .001
        Next
    Next
Next

Sleep

System 0

