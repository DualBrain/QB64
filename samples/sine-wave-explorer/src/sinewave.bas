$NoPrefix
DefLng A-Z
Option Explicit
Option ExplicitArray

$Resize:Smooth
Screen 2
AllowFullScreen SquarePixels , Smooth

Dim As Long Style, Cycles
Dim As Single X, Y

' Viewport sized to proper scale for graph:
View (20, 2)-(620, 172), , 1

' Make window large enough to graph sine wave from
' 0 radians to pi radians:
Window (0, -1.1)-(2 * Pi, 1.1)
Style = &HFF00 ' Use to make dashed line.
View Print 23 To 24 ' Scroll printed output in rows 23, 24.
Do
    Print Tab(20);
    Input "Number of cycles (0 to end): ", Cycles
    Cls
    Line (2 * Pi, 0)-(0, 0), , , Style ' Draw the x axis.
    If Cycles > 0 Then

        '  Start at (0,0) and plot the graph:
        For X = 0 To 2 * Pi Step .01
            Y = Sin(Cycles * X) ' Calculate the y coordinate.
            Line -(X, Y) ' Draw a line to new point.
        Next X
    End If
Loop While Cycles > 0

System 0

