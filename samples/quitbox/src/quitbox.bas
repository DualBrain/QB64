Rem Sample of a QuitBox. v1.1a PD 2017. -ejo

' declare screen save arrays
Dim Shared TempArrayY(1 To 2000) As Integer
Dim Shared TempArrayZ(1 To 2000) As Integer

' declare box coordinates
Dim Shared Xcoor3 As Integer, Ycoor3 As Integer

' declare mouse variables
Dim Shared MouseX As Integer, MouseY As Integer
Dim Shared MouseButton1 As Integer, MouseButton2 As Integer
Dim Shared MouseButton3 As Integer, MouseWheel As Integer
Dim Shared MousePressed As Integer

' declare box colors
Dim Shared QuitBoxBorderColor As Integer
Dim Shared QuitBoxTitleColor As Integer
Dim Shared QuitBoxTextColor As Integer
Dim Shared QuitBoxButton1Color As Integer
Dim Shared QuitBoxButton2Color As Integer
Dim Shared QuitBoxBackGround As Integer
Dim Shared QuitBoxButtonBackGround As Integer

' declare ascii variables
Dim Shared Hline As Integer, Vline As Integer
Dim Shared ULcorner As Integer, URcorner As Integer
Dim Shared LLcorner As Integer, LRcorner As Integer

' declare color constants
Const Black = 0
Const Blue = 1
Const Green = 2
Const Cyan = 3
Const Red = 4
Const Magenta = 5
Const Brown = 6
Const White = 7
Const Gray = 8
Const LightBlue = 9
Const LightGreen = 10
Const LightCyan = 11
Const LightRed = 12
Const LightMagenta = 13
Const Yellow = 14
Const HighWhite = 15

' set box colors
QuitBoxBorderColor = Yellow
QuitBoxTitleColor = HighWhite
QuitBoxTextColor = HighWhite
QuitBoxButton1Color = HighWhite
QuitBoxButton2Color = White
QuitBoxBackGround = Blue
QuitBoxButtonBackGround = Black

' set ascii characters
Hline = 205
Vline = 186
ULcorner = 201
URcorner = 187
LLcorner = 200
LRcorner = 188

' declare box coordinates.
Xcoor3 = 10
Ycoor3 = 10

' set box button constants
Const OKcancel = 1
Const OK = 2
Const cancel = 3

' start input loop
Cls
Print "Quitbox:"
Do
    Color Yellow, Black
    Print "Enter HELP or QUIT or TEST";
    Color HighWhite, Black
    Input X$
    X$ = UCase$(X$)
    If X$ = "QUIT" Then End
    If X$ = "HELP" Then
        Color HighWhite, Black
        Print "Mouse: Click on <OK> or <Cancel>"
        Print "       Click on title, drag box."
        Print "Keyboard: Enter for OK/Cancel, Escape to cancel,"
        Print "          Cursor left/right, tab/shift-tab to select button,"
        Print "          Control-<cursor> to move box."
        Print "          Alt-<cursor> to move box 4 chars."
        Print "Colors: Ctrl-A Cycle box background, Ctrl-B Cycle button background,"
        Print "        Ctrl-D Cycle border, Ctrl-E Cycle title, Ctrl-F Cycle text,"
        Print "        Ctrl-G Cycle OK button, Ctrl-H Cycle Cancel button."
    End If
    If X$ = "TEST" Then
        X = QuitBox(OKcancel, " Quit ", "Quit. Are you sure?")
        If X Then
            Print "Entered OK"
        Else
            Print "Entered Cancel"
        End If
    End If
Loop
End

' Input: Buttons
'    1 = both buttons, 2 = ok, 3 = cancel
Function QuitBox (Buttons, QuitBoxTitle$, QuitBoxText$)
    ' store screen area.
    CurrentX = CsrLin
    CurrentY = Pos(0)
    Call SaveScreen

    ' reset mouse buttons
    MouseButton1 = 0
    MouseButton2 = 0
    MouseButton3 = 0
    X = ClearMouse

    ' draw box
    If Buttons = 1 Or Buttons = 2 Then
        BoxButton = 1
    Else
        BoxButton = 2
    End If
    GoSub DrawQuitBox

    ' wait for keypress or mouse
    _KeyClear
    Do
        _Limit 30
        X$ = InKey$
        If Len(X$) Then
            Select Case Len(X$)
                Case 1
                    Select Case UCase$(X$)
                        Case "O"
                            If Buttons = 1 Or Buttons = 2 Then
                                BoxButton = 1
                                Exit Do
                            End If
                        Case "C"
                            If Buttons = 1 Or Buttons = 3 Then
                                BoxButton = 2
                                Exit Do
                            End If
                        Case Chr$(13)
                            Exit Do
                        Case Chr$(27)
                            BoxButton = 2
                            Exit Do
                        Case Chr$(9) ' tab
                            If BoxButton = 1 Then
                                If Buttons = 1 Then
                                    BoxButton = 2
                                    GoSub DrawQuitBoxButtons
                                End If
                            Else
                                If Buttons = 1 Then
                                    BoxButton = 1
                                    GoSub DrawQuitBoxButtons
                                End If
                            End If
                        Case Chr$(1) ' ctrl-a
                            QuitBoxBackGround = QuitBoxBackGround + 1
                            If QuitBoxBackGround = 8 Then
                                QuitBoxBackGround = 0
                            End If
                            GoSub DrawQuitBox
                        Case Chr$(2) ' ctrl-b
                            QuitBoxButtonBackGround = QuitBoxButtonBackGround + 1
                            If QuitBoxButtonBackGround = 8 Then
                                QuitBoxButtonBackGround = 0
                            End If
                            GoSub DrawQuitBox
                        Case Chr$(4) ' ctrl-d
                            QuitBoxBorderColor = QuitBoxBorderColor + 1
                            If QuitBoxBorderColor = 16 Then
                                QuitBoxBorderColor = 0
                            End If
                            GoSub DrawQuitBox
                        Case Chr$(5) ' ctrl-e
                            QuitBoxTitleColor = QuitBoxTitleColor + 1
                            If QuitBoxTitleColor = 16 Then
                                QuitBoxTitleColor = 0
                            End If
                            GoSub DrawQuitBox
                        Case Chr$(6) ' ctrl-f
                            QuitBoxTextColor = QuitBoxTextColor + 1
                            If QuitBoxTextColor = 16 Then
                                QuitBoxTextColor = 0
                            End If
                            GoSub DrawQuitBox
                        Case Chr$(7) ' ctrl-g
                            QuitBoxButton1Color = QuitBoxButton1Color + 1
                            If QuitBoxButton1Color = 16 Then
                                QuitBoxButton1Color = 0
                            End If
                            GoSub DrawQuitBox
                        Case Chr$(8) ' ctrl-h
                            QuitBoxButton2Color = QuitBoxButton2Color + 1
                            If QuitBoxButton2Color = 16 Then
                                QuitBoxButton2Color = 0
                            End If
                            GoSub DrawQuitBox
                    End Select
                Case 2
                    Select Case Asc(Right$(X$, 1))
                        Case 75, 15 ' left/shift-tab
                            If BoxButton = 2 Then
                                If Buttons = 1 Then
                                    BoxButton = 1
                                    GoSub DrawQuitBoxButtons
                                End If
                            Else
                                If Buttons = 1 Then
                                    BoxButton = 2
                                    GoSub DrawQuitBoxButtons
                                End If
                            End If
                        Case 77 ' right
                            If BoxButton = 1 Then
                                If Buttons = 1 Then
                                    BoxButton = 2
                                    GoSub DrawQuitBoxButtons
                                End If
                            Else
                                If Buttons = 1 Then
                                    BoxButton = 1
                                    GoSub DrawQuitBoxButtons
                                End If
                            End If
                        Case 141 ' ctrl-up
                            If Xcoor3 > 1 Then
                                Xcoor3 = Xcoor3 - 1
                                Call RestoreScreen
                                GoSub DrawQuitBox
                            End If
                            _KeyClear
                        Case 145 ' ctrl-down
                            If Xcoor3 < 18 Then
                                Xcoor3 = Xcoor3 + 1
                                Call RestoreScreen
                                GoSub DrawQuitBox
                            End If
                            _KeyClear
                        Case 115 ' ctrl-left
                            If Ycoor3 > 1 Then
                                Ycoor3 = Ycoor3 - 1
                                Call RestoreScreen
                                GoSub DrawQuitBox
                            End If
                            _KeyClear
                        Case 116 ' ctrl-right
                            If Ycoor3 < 49 Then
                                Ycoor3 = Ycoor3 + 1
                                Call RestoreScreen
                                GoSub DrawQuitBox
                            End If
                            _KeyClear
                        Case 152 ' alt-up
                            If Xcoor3 > 4 Then
                                Xcoor3 = Xcoor3 - 4
                                Call RestoreScreen
                                GoSub DrawQuitBox
                            Else
                                If Xcoor3 > 1 Then
                                    Xcoor3 = 1
                                    Call RestoreScreen
                                    GoSub DrawQuitBox
                                End If
                            End If
                            _KeyClear
                        Case 160 ' alt-dn
                            If Xcoor3 < 14 Then
                                Xcoor3 = Xcoor3 + 4
                                Call RestoreScreen
                                GoSub DrawQuitBox
                            Else
                                If Xcoor3 < 18 Then
                                    Xcoor3 = 18
                                    Call RestoreScreen
                                    GoSub DrawQuitBox
                                End If
                            End If
                            _KeyClear
                        Case 155 ' alt-left
                            If Ycoor3 > 4 Then
                                Ycoor3 = Ycoor3 - 4
                                Call RestoreScreen
                                GoSub DrawQuitBox
                            Else
                                If Ycoor3 > 1 Then
                                    Ycoor3 = 1
                                    Call RestoreScreen
                                    GoSub DrawQuitBox
                                End If
                            End If
                            _KeyClear
                        Case 157 ' alt-right
                            If Ycoor3 < 45 Then
                                Ycoor3 = Ycoor3 + 4
                                Call RestoreScreen
                                GoSub DrawQuitBox
                            Else
                                If Ycoor3 < 49 Then
                                    Ycoor3 = 49
                                    Call RestoreScreen
                                    GoSub DrawQuitBox
                                End If
                            End If
                            _KeyClear
                    End Select
            End Select
        End If
        X = MouseDriver
        If MouseButton1 Then
            ' hover over titlebar
            If MouseX = Xcoor3 Then
                If MouseY >= Ycoor3 And MouseY <= Ycoor3 + 31 Then
                    ' store mouse XY during click
                    MouseTempX = MouseX
                    MouseTempY = MouseY
                    Do
                        X = MouseDriver
                        If MouseX Or MouseY Then ' drag
                            MoveBox = 0
                            ' difference in mouse X
                            If MouseX <> MouseTempX Then
                                If MouseX >= 1 And MouseX <= 18 Then
                                    Xcoor3 = MouseX
                                    MouseTempX = MouseX
                                    MoveBox = -1
                                End If
                            End If
                            ' difference in mouse Y
                            If MouseY <> MouseTempY Then
                                MoveY = Ycoor3 + (MouseY - MouseTempY)
                                If MoveY >= 1 And MoveY <= 49 Then
                                    Ycoor3 = MoveY
                                    MouseTempY = MouseY
                                    MoveBox = -1
                                End If
                            End If
                            ' move box
                            If MoveBox Then
                                Call RestoreScreen
                                GoSub DrawQuitBox
                            End If
                        End If
                    Loop Until MouseButton1 = 0
                End If
            Else
                If MouseX = Xcoor3 + 4 Then ' click on button
                    If MouseY >= Ycoor3 + 2 And MouseY <= Ycoor3 + 5 Then
                        If Buttons = 1 Or Buttons = 2 Then
                            BoxButton = 1
                            Exit Do
                        End If
                    End If
                    If MouseY >= Ycoor3 + 8 And MouseY <= Ycoor3 + 15 Then
                        If Buttons = 1 Or Buttons = 3 Then
                            BoxButton = 2
                            Exit Do
                        End If
                    End If
                End If
            End If
        Else
            If MouseX = Xcoor3 + 4 Then ' mouseover button
                If MouseY >= Ycoor3 + 2 And MouseY <= Ycoor3 + 5 Then
                    If BoxButton = 2 Then
                        If Buttons = 1 Then
                            BoxButton = 1
                            GoSub DrawQuitBoxButtons
                        End If
                    End If
                End If
                If MouseY >= Ycoor3 + 8 And MouseY <= Ycoor3 + 15 Then
                    If BoxButton = 1 Then
                        If Buttons = 1 Then
                            BoxButton = 2
                            GoSub DrawQuitBoxButtons
                        End If
                    End If
                End If
            End If
        End If
    Loop
    _Delay .2
    _KeyClear
    _Delay .2

    ' restore screen area.
    Call RestoreScreen
    Color White, Black
    Locate CurrentX, CurrentY, 1
    If BoxButton = 1 Then
        QuitBox = -1
    Else
        QuitBox = 0
    End If
    Exit Function

    ' draw box
    DrawQuitBox:
    Color QuitBoxBorderColor, QuitBoxBackGround
    Locate Xcoor3, Ycoor3, 0
    Print Chr$(ULcorner) + String$(30, Hline) + Chr$(URcorner);
    For RowX1 = Xcoor3 + 1 To Xcoor3 + 6
        Locate RowX1, Ycoor3, 0
        Print Chr$(Vline) + Space$(30) + Chr$(Vline);
    Next
    Locate Xcoor3 + 7, Ycoor3, 0
    Print Chr$(LLcorner) + String$(30, Hline) + Chr$(LRcorner);

    ' display box title
    XC = 16 - Len(QuitBoxTitle$) / 2 ' center of titlebar
    XC = Ycoor3 + XC
    If XC < 1 Then XC = 1
    Color QuitBoxTitleColor
    Locate Xcoor3, XC, 0
    Print QuitBoxTitle$;

    ' display quit text
    Color QuitBoxTextColor
    Locate Xcoor3 + 2, Ycoor3 + 2, 0
    Print QuitBoxText$
    GoSub DrawQuitBoxButtons
    Return

    ' display buttuns
    DrawQuitBoxButtons:
    If BoxButton = 1 Then
        Locate Xcoor3 + 4, Ycoor3 + 2, 0
        Color QuitBoxButton1Color, QuitBoxButtonBackGround
        Print "<OK>";
        If Buttons = 1 Then
            Locate Xcoor3 + 4, Ycoor3 + 8, 0
            Color QuitBoxButton2Color, QuitBoxButtonBackGround
            Print "<Cancel>";
        End If
    Else
        Locate Xcoor3 + 4, Ycoor3 + 8, 0
        Color QuitBoxButton1Color, QuitBoxButtonBackGround
        Print "<Cancel>";
        If Buttons = 1 Then
            Locate Xcoor3 + 4, Ycoor3 + 2, 0
            Color QuitBoxButton2Color, QuitBoxButtonBackGround
            Print "<OK>";
        End If
    End If
    Color White, Black
    Return
End Function

' screen save
Sub SaveScreen
    For Var1 = 1 To 25
        For Var2 = 1 To 80
            TempZ1 = Screen(Var1, Var2) ' screen char
            TempZ2 = Screen(Var1, Var2, 1) ' char color
            TempArrayY((Var1 - 1) * 80 + Var2) = TempZ1
            TempArrayZ((Var1 - 1) * 80 + Var2) = TempZ2
        Next
    Next
End Sub

' screen restore
Sub RestoreScreen
    For Var1 = 1 To 25
        For Var2 = 1 To 80
            VarB = Int(TempArrayZ((Var1 - 1) * 80 + Var2) / 16)
            VarF = TempArrayZ((Var1 - 1) * 80 + Var2) Mod 16
            TempZ1 = TempArrayY((Var1 - 1) * 80 + Var2)
            Locate Var1, Var2, 1
            Color VarF, VarB
            _ControlChr Off
            Print Chr$(TempZ1);
            _ControlChr On
        Next
    Next
End Sub

Rem clears mouse buffer.
Function ClearMouse
    While _MouseInput: Wend ' empty buffer
End Function

Rem processes mouse activity.
Function MouseDriver
    Static X1 As Integer, Y1 As Integer ' store old values
    MouseX = 0: MouseY = 0
    If _MouseInput Then
        X = CInt(_MouseX): Y = CInt(_MouseY) ' X,Y return single
        If X <> X1 Or Y <> Y1 Then
            X1 = X: Y1 = Y
            MouseX = Y: MouseY = X ' X,Y are reversed
            While _MouseInput: Wend ' empty buffer
            MousePressed = -1
        End If
        MouseButton1 = _MouseButton(1)
        If MouseButton1 Then
            MouseX = Y1
            MouseY = X1
            MousePressed = -1
        End If
        MouseButton2 = _MouseButton(2)
        If MouseButton2 Then
            MouseX = Y1
            MouseY = X1
            MousePressed = -1
        End If
        MouseButton3 = _MouseButton(3)
        If MouseButton3 Then
            MousePressed = -1
        End If
        MouseWheel = _MouseWheel
    End If
End Function


