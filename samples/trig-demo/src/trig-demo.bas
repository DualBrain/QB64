Screen 12

' Origin in Cartesian coordinates. (Changes when mouse is clicked.)
OriginX = -100
OriginY = -100

' Point of interest in Cartesian coordinates. (Changes while mouse moves.)
x = _MouseX
y = _MouseY
If x > 0 And x < 640 And y > 0 And y < 480 Then
    GoSub unconvert
    OriginX = x
    OriginY = y
Else
    ThePointX = 100
    ThePointY = 100
End If

' Main loop.
Do
    Do While _MouseInput
        x = _MouseX
        y = _MouseY
    Loop
    If x > 0 And x < 640 And y > 0 And y < 480 Then

        GoSub unconvert
        ThePointX = x
        ThePointY = y

        If _MouseButton(1) Then
            x = _MouseX
            y = _MouseY
            GoSub unconvert
            OriginX = x
            OriginY = y
        End If

    End If

    GoSub DrawEverything

Loop

End

DrawEverything:
Cls
' Make Cartesian grid.
For x = OriginX To 640 Step 10
    Line (x, 0)-(x, 480), 8
Next
For x = OriginX To 0 Step -10
    Line (x, 0)-(x, 480), 8
Next
For y = OriginY To 480 Step 10
    Line (0, -y + 240)-(640, -y + 240), 8
Next
For y = OriginY To -240 Step -10
    Line (0, -y + 240)-(640, -y + 240), 8
Next
x = OriginX
y = OriginY
GoSub convert
Line (0, y)-(640, y), 7
Line (x, 0)-(x, 480), 7
_PrintString (640 - 8 * 6, y), "X-axis"
_PrintString (x, 0), "Y-axis"
_PrintString (x, y), "Origin"
' Draw the circle on which the position vector lives.
Radius = Sqr((ThePointX - OriginX) ^ 2 + (ThePointY - OriginY) ^ 2)
x = OriginX
y = OriginY
GoSub convert
Circle (x, y), Radius, 7
' Draw the vertical component.
x = OriginX
y = OriginY
GoSub convert
x1 = x
y1 = y
x = ThePointX
y = OriginY
GoSub convert
x2 = x
y2 = y
Line (x1, y1)-(x2, y2), 9
Line (x1, y1 + 1)-(x2, y2 + 1), 9
Line (x1, y1 - 1)-(x2, y2 - 1), 9
' Draw the horizontal component.
x = ThePointX
y = OriginY
GoSub convert
x1 = x
y1 = y
x = ThePointX
y = ThePointY
GoSub convert
x2 = x
y2 = y
Line (x1, y1)-(x2, y2), 4
Line (x1 - 1, y1)-(x2 - 1, y2), 4
Line (x1 + 1, y1)-(x2 + 1, y2), 4
' Draw position vector (aka the Hypotenuse).
x = OriginX
y = OriginY
GoSub convert
x1 = x
y1 = y
x = ThePointX
y = ThePointY
GoSub convert
x2 = x
y2 = y
Line (x1, y1)-(x2, y2), 10
Line (x1 + 1, y1)-(x2 + 1, y2), 10
Line (x1, y1 + 1)-(x2, y2 + 1), 10
' Write text.
Color 7
Locate 3, 60: Print "-------Origin-------"
Locate 4, 60: Print "Cartesian/Polar/Qb64:"
'Locate 3, 61: Print "X=0   , Y=0"
'Locate 4, 61: Print "R=0   , Ang=undef"
Locate 5, 61: Print "x="; OriginX + 320; ", "; "y="; -OriginY + 240
Locate 7, 60: Print "-------Cursor-------"
Locate 8, 60: Print "Cartesian/Polar/Qb64:"
Locate 9, 61: Print "X="; ThePointX - OriginX; ", "; "Y="; ThePointY - OriginY
' Deal with radius calculation.
Radius = Sqr((ThePointX - OriginX) ^ 2 + (ThePointY - OriginY) ^ 2)
If Radius < .0001 Then Radius = .0001
Locate 10, 61: Print "R="; Int(Radius); ", "; "Ang="; TheAngle
' Deal with the anlge calculation.
xdiff = ThePointX - OriginX
ydiff = ThePointY - OriginY
If xdiff > 0 And ydiff > 0 Then ' First quadrant
    TheAngle = Int((180 / 3.14159) * Atn(ydiff / xdiff))
End If
If xdiff < 0 And ydiff > 0 Then ' Second quadrant
    TheAngle = 180 + Int((180 / 3.14159) * Atn(ydiff / xdiff))
End If
If xdiff < 0 And ydiff < 0 Then ' Third quadrant
    TheAngle = 180 + Int((180 / 3.14159) * Atn(ydiff / xdiff))
End If
If xdiff > 0 And ydiff < 0 Then ' Fourth quadrant
    TheAngle = 360 + Int((180 / 3.14159) * Atn(ydiff / xdiff))
End If
If Sqr(ydiff ^ 2) < .0001 Then ydiff = .0001
If Sqr(xdiff ^ 2) < .0001 Then xdiff = .0001
Locate 11, 61: Print "x="; ThePointX + 320; ", "; "y="; -ThePointY + 240
Locate 13, 60: Print "--------Trig--------"
Locate 14, 61: Print "sin(Ang)=";: Color 4: Print "Opp";: Color 7: Print "/";: Color 10: Print "Hyp";: Color 7
Locate 15, 61: Print "        ="; Using "##.###"; ydiff / Radius
Locate 16, 61: Print "cos(Ang)=";: Color 9: Print "Adj";: Color 7: Print "/";: Color 10: Print "Hyp";: Color 7
Locate 17, 61: Print "        ="; Using "##.###"; xdiff / Radius
Locate 18, 61: Print "tan(Ang)=";: Color 4: Print "Opp";: Color 7: Print "/";: Color 9: Print "Adj";: Color 7
Locate 19, 61: Print "        ="; Using "####.###"; ydiff / xdiff
_Display
Return

convert:
' Converts Cartesian coordinates to QB64 coordinates.
x0 = x: y0 = y
x = x0 + 320
y = -y0 + 240
Return

unconvert:
' Converts QB64 coordinates to Cartesian coordinates.
x0 = x: y0 = y
x = x0 - 320
y = -y0 + 240
Return



