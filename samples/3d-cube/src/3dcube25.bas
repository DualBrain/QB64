'3d cube
'polygon filled using paint. ;*)
'I could probably shorten the code in less than 20 lines but
'I'd rather make another 25 liner. ;*)
'Relsoft 2003

$NoPrefix

$Resize:Smooth
Screen 9, , 1, 0
FullScreen SquarePixels , Smooth

Dim CubeM!(8, 7), CubeV(12, 2)
For V = 1 To 8 + 12
    If V < 9 Then Read CubeM!(V, 0), CubeM!(V, 1), CubeM!(V, 2) Else Read CubeV(V - 8, 0), CubeV(V - 8, 1), CubeV(V - 8, 2)
Next
Do
    ax! = (ax! + .01) * -(ax! < 6.283186)
    ay! = (ay! + .01) * -(ay! < 6.283186)
    az! = (az! + .01) * -(az! < 6.283186)
    For I = 1 To 8
        CubeM!(I, 6) = (256 * ((CubeM!(I, 0) * (Cos(ay!) * Cos(az!)) + CubeM!(I, 1) * (Cos(ax!) * -Sin(az!) + Sin(ax!) * Sin(ay!) * Cos(az!)) + CubeM!(I, 2) * (-Sin(ax!) * -Sin(az!) + Cos(ax!) * Sin(ay!) * Cos(az!)))) \ (256 - ((CubeM!(I, 0) * (-Sin(ay!)) + CubeM!(I, 1) * (Sin(ax!) * Cos(ay!)) + CubeM!(I, 2) * (Cos(ax!) * Cos(ay!)))))) + 320
        CubeM!(I, 7) = -(256 * ((CubeM!(I, 0) * (Cos(ay!) * Sin(az!)) + CubeM!(I, 1) * (Cos(ax!) * Cos(az!) + Sin(ax!) * Sin(ay!) * Sin(az!)) + CubeM!(I, 2) * (-Sin(ax!) * Cos(az!) + Cos(az!) * Sin(ay!) * Sin(az!)))) \ (256 - ((CubeM!(I, 0) * (-Sin(ay!)) + CubeM!(I, 1) * (Sin(ax!) * Cos(ay!)) + CubeM!(I, 2) * (Cos(ax!) * Cos(ay!)))))) + 175
    Next
    Line (0, 0)-(639, 350), 0, BF
    For I = 1 To 12
        If (CubeM!(CubeV(I, 2), 6) - CubeM!(CubeV(I, 0), 6)) * (CubeM!(CubeV(I, 1), 7) - CubeM!(CubeV(I, 0), 7)) - (CubeM!(CubeV(I, 1), 6) - CubeM!(CubeV(I, 0), 6)) * (CubeM!(CubeV(I, 2), 7) - CubeM!(CubeV(I, 0), 7)) < -256 Then
            Line (CubeM!(CubeV(I, 0), 6), CubeM!(CubeV(I, 0), 7))-(CubeM!(CubeV(I, 1), 6), CubeM!(CubeV(I, 1), 7)), I + 2
            Line (CubeM!(CubeV(I, 1), 6), CubeM!(CubeV(I, 1), 7))-(CubeM!(CubeV(I, 2), 6), CubeM!(CubeV(I, 2), 7)), I + 2
            Line (CubeM!(CubeV(I, 2), 6), CubeM!(CubeV(I, 2), 7))-(CubeM!(CubeV(I, 0), 6), CubeM!(CubeV(I, 0), 7)), I + 2
            Paint ((CubeM!(CubeV(I, 0), 6) + CubeM!(CubeV(I, 1), 6) + CubeM!(CubeV(I, 2), 6)) \ 3, (CubeM!(CubeV(I, 0), 7) + CubeM!(CubeV(I, 1), 7) + CubeM!(CubeV(I, 2), 7)) \ 3), I + 2
        End If
    Next
    PCopy 1, 0
    Limit 60
Loop Until InKey$ <> ""

System 0

Data -80,-80,-80,80,-80,-80,80,80,-80,-80,80,-80,-80,-80,80,80,-80,80,80,80,80,-80,80,80
Data 5,1,8,1,4,8,6,5,7,5,8,7,2,6,3,6,7,3,1,2,4,2,3,4,4,3,8,3,7,8,5,6,1,6,2,1

