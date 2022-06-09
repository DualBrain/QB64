'{A little rotating sphere, by Glen Jeh, 8/12/1994, use freely}
'{Try messing with the constants...code is squished a little}
' Converted to BASIC by William Yu (05-28-96)
'
' Uncomment the delay if you compile the program
' The screen updates too fast

$NoPrefix
DefLng A-Z
Option Explicit
Option ExplicitArray

$Resize:Smooth

Const Scale = 50 ' x and y are multiplied by scale and divided by distance
Const Radius = 80 ' mystery constant
Const DelayTime = 1 ' Delay(DelayTime) to slow it down..
Const Slices = 12 ' number of slices
Const PPS = 20 ' points per slice

Type PointType
    x As Integer
    y As Integer
    Z As Integer
End Type

Dim Shared points(1 To Slices, 1 To PPS) As PointType
Dim Shared Ball(1 To Slices, 1 To PPS) As PointType
Dim Shared XAngle, YAngle, ZAngle
Dim Shared SinTable(0 To 255) As Integer
Dim Shared CosTable(0 To 255) As Integer
Dim Shared Distance, Dir

Dim As Long i

For i = 0 To 255
    SinTable(i) = Int(Sin(2 * Pi / 255 * i) * 128)
    CosTable(i) = Int(Cos(2 * Pi / 255 * i) * 128)
Next

Randomize Timer

Screen 7
FullScreen SquarePixels , Smooth

i = 0
Distance = 100
Dir = -3
SetupBall
XAngle = 0
YAngle = 0
ZAngle = 0
Do
    i = 1 - i
    PCopy 3, 2
    Screen , , 2, 0
    Rotate
    DrawPoints 14 + i
    XAngle = XAngle + 3
    YAngle = YAngle + 2
    ZAngle = ZAngle + 1
    Distance = Distance + Dir
    If XAngle > 250 Then XAngle = 0
    If YAngle > 250 Then YAngle = 0
    If ZAngle > 250 Then ZAngle = 0
    If Distance >= 300 Then Dir = -3
    If Distance <= 30 Then Dir = 2
    PCopy 2, 0
    Screen , , 2, 0
    Limit 60
Loop Until InKey$ <> ""
Cls
Screen 0
Width 80

System 0

'{mystery procedure}
Sub DrawPoints (Colour)
    Dim As Long i, i2
    For i = 1 To Slices
        For i2 = 1 To PPS
            If (points(i, i2).Z >= 0) And (points(i, i2).x <= 319) And (points(i, i2).x >= 0) And (points(i, i2).y >= 0) And (points(i, i2).y < 199) Then
                PSet (points(i, i2).x, points(i, i2).y), Colour
            End If
        Next i2
    Next i
End Sub

Sub Rotate
    'UPDATES all (X,Y,Z) coordinates according to XAngle,YAngle,ZAngle
    Dim As Long i, i2, TempY, TempZ, TempX, OldTempX
    For i = 1 To Slices
        For i2 = 1 To PPS
            '{rotate on X-axis}
            TempY = (Ball(i, i2).y * CosTable(XAngle) - Ball(i, i2).Z * SinTable(XAngle)) / 128
            TempZ = (Ball(i, i2).y * SinTable(XAngle) + Ball(i, i2).Z * CosTable(XAngle)) / 128
            ' {rotate on y-anis}
            TempX = (Ball(i, i2).x * CosTable(YAngle) - TempZ * SinTable(YAngle)) / 128
            TempZ = (Ball(i, i2).x * SinTable(YAngle) + TempZ * CosTable(YAngle)) / 128
            '{rotate on z-axis}
            OldTempX = TempX
            TempX = (TempX * CosTable(ZAngle) - TempY * SinTable(ZAngle)) / 128
            TempY = (OldTempX * SinTable(ZAngle) + TempY * CosTable(ZAngle)) / 128
            points(i, i2).x = (TempX * Scale) / Distance + 320 / 2
            points(i, i2).y = (TempY * Scale) / Distance + 200 / 2
            points(i, i2).Z = TempZ
        Next i2
    Next i
End Sub

'{sets up the ball's data..}
Sub SetupBall ' {set up the points}
    Dim As Long SliceLoop, PPSLoop
    Dim As Single Phi, Theta

    For SliceLoop = 1 To Slices
        Phi! = Pi / Slices * SliceLoop ' 0 <= Phi <= Pi
        For PPSLoop = 1 To PPS
            Theta! = 2 * Pi / PPS * PPSLoop ' 0 <= Theta <= 2*Pi
            '{convert Radius,Thetha,Phi to (x,y,z) coordinates}
            Ball(SliceLoop, PPSLoop).y = Int(Radius * Sin(Phi!) * Cos(Theta!))
            Ball(SliceLoop, PPSLoop).x = Int(Radius * Sin(Phi!) * Sin(Theta!))
            Ball(SliceLoop, PPSLoop).Z = Int(Radius * Cos(Phi!))
        Next PPSLoop
    Next SliceLoop
End Sub

