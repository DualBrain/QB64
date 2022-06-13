Start:
Screen 12
Line (0, 0)-(640, 480), 15, BF
Locate 1, 1: Print String$(80, 32)
Brushtype = 1

Do
    Do While _MouseInput: Loop
    If Brushtype = 1 And _MouseButton(1) Then Line (mousex, mousey)-(_MouseX, _MouseY), 0
    If Brushtype = 2 And _MouseButton(1) Then For r = 0 To 6: Line (mousex + r, mousey + r)-(_MouseX + r, _MouseY + r), 0: Next r
    If Brushtype = 3 And _MouseButton(1) Then For r = 0 To 6: Line (mousex, mousey + r)-(_MouseX, _MouseY + r), 0: Next r
    If Brushtype = 4 And _MouseButton(1) Then For r = 0 To 44: Circle (_MouseX, _MouseY), r, r: Next r

    If _MouseButton(2) Then Paint (_MouseX, _MouseY), 0

    A$ = InKey$
    If A$ = " " Then GoTo Start: ' reset
    If A$ = "1" Then Let Brushtype = 1 ' normal brush
    If A$ = "2" Then Let Brushtype = 2 ' calligraphy 1
    If A$ = "3" Then Let Brushtype = 3 ' calligraphy 2
    If A$ = "4" Then Let Brushtype = 4 ' rainbow

    mousex = _MouseX
    mousey = _MouseY

    Locate 1, 1: Print " QB64 Draw "; Chr$(179); " X:"; _MouseX; "Y:"; _MouseY; " Press 1-4 for different pencils  ";
Loop

