$NoPrefix
DefLng A-Z
$Resize:Smooth

Screen 13
FullScreen SquarePixels , Smooth

Randomize Timer

Dim Shared Buffer%(32001)
Buffer%(0) = 320 * 8
Buffer%(1) = 200

b = 0
g = 0
For a = 150 To 100 Step -1
    r = a / 5
    set_pal a, b, g, r
Next

For a = 100 To 0 Step -1
    g = g - 1
    b = b - 1
    r = r - 1
    set_pal a, b, g, r
Next

g = 0
For a = 150 To 255 Step 1

    b = 0
    g = g + 1
    r = a / 5
    If (g > 62) Then
        g = 62
    End If
    set_pal a, b, g, r
Next

Do
    l = l + 1
    fire
    update_screen

    If (l > 1) Then
        If b = 0 Then
            a = a + 1
        End If
        If b = 1 Then
            a = a - 1
        End If
        set_random_pixels a, 255
        If (a < 50) Then
            b = 0
        End If
        If (a > 200) Then
            b = 1
        End If
        l = 0
    End If

Loop Until InKey$ <> ""

System 0


Sub fire
    For y = 200 To 1 Step -1
        For x = 1 To 320 Step 1
            med_col = 0
            med_col = med_col + get_pixel(x - 1, y + 1)
            med_col = med_col + get_pixel(x + 1, y + 1)
            med_col = med_col + get_pixel(x, y + 1)
            med_col = med_col + get_pixel(x, y)
            med_col = med_col + Rnd * 3
            med_col = med_col / 4.04
            set_pixel x, y, med_col
        Next
    Next
End Sub

Sub set_random_pixels (nr, col)
    row = 201
    For x = 1 To 320
        set_pixel x, row, 0
    Next
    For a = 0 To nr
        x = Rnd * 320
        set_pixel x, row, col
        set_pixel x + 1, row, col
        set_pixel x - 1, row, col
    Next
End Sub

Sub update_screen
    Put (0, 0), Buffer%(), PSet
End Sub

Sub set_pixel (x%, y%, col%)
    Def Seg = VarSeg(Buffer%(32001))
    Poke 320& * y% + x% + 4, col%
    Def Seg
End Sub

Function get_pixel (x%, y%)
    Def Seg = VarSeg(Buffer%(32001))
    get_pixel = Peek(320& * y% + x% + 4)
    Def Seg
End Function

Sub set_pal (p, b, g, r)
    b = CInt(b)
    g = CInt(g)
    r = CInt(r)

    If (b > 62) Then b = 62
    If (g > 62) Then g = 62
    If (r > 62) Then r = 62
    If (b < 0) Then b = 0
    If (g < 0) Then g = 0
    If (r < 0) Then r = 0
    Palette p, 65536 * b + 256 * g + r
End Sub

