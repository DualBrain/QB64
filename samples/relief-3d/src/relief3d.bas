' Created by QB64 community member DANILIN

$NoPrefix
Option Explicit
Option ExplicitArray

Dim As Long n, q, y, x, t, i, j

n = 200
q = 15
Screen 12

Dim a(q + 1, n) 'relup.bas 5d relief up

For x = 1 To q
    For y = 1 To n - 5
        If Int(Rnd * 100) Mod 7 = 5 Then
            a(x, y) = 5
            a(x, y + 1) = 10
            a(x, y + 2) = 20
            a(x, y + 3) = 40
            a(x, y + 4) = 80
            y = y + 5
        End If
    Next
Next

For t = 1 To n - q
    For i = 1 To q - 1
        For j = 1 To q - 1
            a(i, j) = a(i, j + t)
        Next
    Next

    Delay 0.1
    Cls

    For y = 1 To q - 1
        For x = 1 To q - 2
            Line (30 + 20 * x + 20 * y, 400 - 20 * y - a(x, y))-(30 + 20 * (x + 1) + 20 * y, 400 - 20 * y - a(x + 1, y)), (y + t Mod 7) + 1
        Next
    Next

    For x = 1 To q - 1
        For y = 1 To q - 2
            Line (30 + 20 * x + 20 * y, 400 - 20 * y - a(x, y))-(30 + 20 * (x + 1) + 20 * y, 400 - 20 * (y + 1) - a(x, y + 1)), 7
        Next
    Next

    Display
Next

End

