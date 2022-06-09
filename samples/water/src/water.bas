$NoPrefix
DefSng A-Z
$Resize:Smooth

Screen 13
FullScreen SquarePixels , Smooth

Randomize Timer

Dim Shared Buffer%(32001)
Buffer%(0) = 320 * 8
Buffer%(1) = 200

Dim Shared buffer1(320, 200) As Single
Dim Shared buffer2(320, 200) As Single

Dim Shared wave_nr
wave_nr = 1
set_palette 0, 0.24, 0
fade = 0.0
Do
    set_random_pixels 1, 256
    wave
    water
    update_screen
    swap_buffers

    If (fade < 0.24) Then
        fade = fade + 0.002
        set_palette 0, fade, 0
    End If
Loop Until InKey$ <> ""

System 0


Sub water
    Dim c As Single

    For x = 319 To 1 Step -1
        For y = 1 To 199

            c = ((buffer2(x - 1, y) + buffer2(x + 1, y) + buffer2(x, y - 1) + buffer2(x, y + 1)) / 2) - buffer1(x, y)
            c = c * 0.99
            If (c > 256) Then c = 256
            If (c < 0) Then c = 0

            buffer1(x, y) = c * 0.95

        Next
    Next
End Sub

Sub wave
    buffer2(160 + Sin(wave_nr / 20) * 60, 100 + Cos(wave_nr / 20) * 40) = 256
    wave_nr = wave_nr + 1
End Sub

Sub set_random_pixels (nr, col)
    For a = 0 To nr
        x = 1 + Rnd * 318
        y = 1 + Rnd * 198
        buffer2(x, y) = col
    Next
End Sub

Sub swap_buffers
    Dim tmp(320, 200) As Single
    For a = 1 To 320
        For b = 1 To 200
            tmp(a, b) = buffer1(a, b)
            buffer1(a, b) = buffer2(a, b)
            buffer2(a, b) = tmp(a, b)
            set_pixel a, b, CInt(buffer1(a, b))
        Next
    Next
End Sub

Sub update_screen
    Put (0, 0), Buffer%(), PSet
End Sub

Sub set_pixel (x%, y%, col%)
    Def Seg = VarSeg(Buffer%(32001))
    Poke 320& * y% + x% + 4, col% + 50
    Def Seg
End Sub

Function get_pixel (x%, y%)
    Def Seg = VarSeg(Buffer%(32001))
    get_pixel = Peek(320& * y% + x% + 4)
    Def Seg
End Function


Sub clear_screen
    For a = 4 To 32001
        Buffer%(a) = 0
    Next
End Sub

Sub set_palette (r, b, g)
    cr = 0.0
    cb = 0.0
    cg = 0.0
    For p = 0 To 255
        cr = cr + r
        cb = cb + b
        cg = cg + g
        pal_col = (CInt(cb) * 65536) + (CInt(cg) * 256) + CInt(cr)
        Palette p, pal_col
    Next
End Sub

