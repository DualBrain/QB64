DefInt A-Z
Screen 12
Dim Shared COLOUR
X = 0
Y = 0
Z = 0
D = (640 - 480) / 2

LOOP1:
If InKey$ = Chr$(27) Then End
Call getmouse(X, Y, Z)
If Z = 0 Then GoTo LOOP1
If Z = 1 Then GoTo DRAW1
Cls
DRAW1:
COLOUR = Int(Rnd(1) * 15) + 1
Call SOLIDCIRCLE(X, Y, 3)
Call SOLIDCIRCLE(X, 480 - Y, 3)
Call SOLIDCIRCLE(640 - X, Y, 3)
Call SOLIDCIRCLE(640 - X, 480 - Y, 3)
Call SOLIDCIRCLE(Y + D, X - D, 3)
Call SOLIDCIRCLE(480 - Y + D, X - D, 3)
Call SOLIDCIRCLE(Y + D, 480 - X + D, 3)
Call SOLIDCIRCLE(480 - Y + D, 480 - X + D, 3)
GoTo LOOP1

Sub SOLIDCIRCLE (X, Y, RAD)
    Circle (X, Y), RAD, COLOUR
    Paint (X, Y), COLOUR
End Sub

Sub getmouse (x%, y%, b%)
    b% = 0
    wheel% = 0
    Do
        If _MouseButton(1) Then b% = b% Or 1
        If _MouseButton(2) Then b% = b% Or 2
        If _MouseButton(3) Then b% = b% Or 4
    Loop Until _MouseInput = 0
    x% = _MouseX
    y% = _MouseY
End Sub

