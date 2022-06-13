DefLng A-Z
Randomize Timer
Screen _NewImage(80, 25, 0)
Dim Shared seed(0 To _Width + 1, 0 To _Height + 1) As _Byte
Dim Shared board(0 To _Width + 1, 0 To _Height + 1) As _Byte
Dim Shared temp(0 To _Width + 1, 0 To _Height + 1) As _Byte

'Random board layout generator
'FOR y = 1 TO _HEIGHT
'    FOR x = 1 TO _WIDTH
'        IF RND > 0.6 THEN board(x, y) = 1
'    NEXT x
'NEXT y

'Manual board layout (comment out this loop to use the above randomizer)
Do
    Do While _MouseInput
        x = _MouseX
        y = _MouseY
        If _MouseButton(1) Then
            seed(x, y) = 1
            board(x, y) = 1
            Locate y, x
            Print Chr$(219);
        ElseIf _MouseButton(2) Then
            seed(x, y) = 1
            board(x, y) = 0
            Locate y, x
            Print " ";
        End If
    Loop
    Select Case InKey$
        Case Chr$(13): Exit Do
        Case "l"
            Input "File to load: ", ifile$
            If Not _FileExists(ifile$) Then
                Print "Not found"
            Else
                Open ifile$ For Binary As #1
                Get #1, , h&
                Get #1, , w&
                If h& <> _Height Or w& <> _Width Then
                    Print "Incompatible size - file is"; w&; "by"; h&; " but window is"; _Height; "by"; _Width;
                Else
                    For y = 1 To _Height
                        For x = 1 To _Width
                            Get #1, , seed(x, y)
                            board(x, y) = seed(x, y)
                        Next x
                    Next y
                    Exit Do
                End If
            End If
    End Select
Loop

Do
    For y = 1 To _Height
        For x = 1 To _Width
            neighbours = 0
            If board(x - 1, y - 1) Then neighbours = neighbours + 1
            If board(x, y - 1) Then neighbours = neighbours + 1
            If board(x + 1, y - 1) Then neighbours = neighbours + 1
            If board(x - 1, y) Then neighbours = neighbours + 1
            If board(x + 1, y) Then neighbours = neighbours + 1
            If board(x - 1, y + 1) Then neighbours = neighbours + 1
            If board(x, y + 1) Then neighbours = neighbours + 1
            If board(x + 1, y + 1) Then neighbours = neighbours + 1
            If neighbours = 3 Then temp(x, y) = 1
            If neighbours = 2 And board(x, y) Then temp(x, y) = 1
            If neighbours > 3 Or neighbours < 2 Then temp(x, y) = 0
        Next x
    Next y
    redraw
    _Limit 10
    If InKey$ = Chr$(27) Then
        Locate 1, 1
        Input "Save original pattern (y/n)? ", c$
        If c$ = "Y" Or c$ = "y" Then Input "File name: ", ofile$
        Input "Save current state (y/n)? ", c$
        If c$ = "Y" Or c$ = "y" Then Input "File name: ", cfile$
        Exit Do
    End If
Loop

If ofile$ <> "" Then
    Open ofile$ For Binary As #1
    h& = _Height
    w& = _Width
    Put #1, , h&
    Put #1, , w&
    For y = 1 To _Height
        For x = 1 To _Width
            Put #1, , seed(x, y)
        Next x
    Next y
    Close #1
End If

If cfile$ <> "" Then
    Open cfile$ For Binary As #1
    h& = _Height
    w& = _Width
    Put #1, , h&
    Put #1, , w&
    For y = 1 To _Height
        For x = 1 To _Width
            Put #1, , board(x, y)
        Next x
    Next y
    Close #1
End If

Sub redraw
    Cls
    For y = 1 To _Height
        For x = 1 To _Width
            board(x, y) = temp(x, y)
            If board(x, y) Then Locate y, x: Print Chr$(219);
        Next x
    Next y
    _Display
End Sub

