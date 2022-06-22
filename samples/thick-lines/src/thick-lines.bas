Const false = 0, true = Not false

Dim x1, y1, x2, y2
Dim mouseDown As _Byte
Dim totalDots As Integer
Dim thickness As Integer

thickness = 10

Screen _NewImage(800, 600, 32)

Do
    While _MouseInput: thickness = thickness + _MouseWheel: Wend

    If thickness < 1 Then thickness = 1

    If _MouseButton(1) Then
        If Not mouseDown Then
            mouseDown = true
            totalDots = totalDots + 1
            If totalDots > 2 Then totalDots = 1
            Select Case totalDots
                Case 1
                    x1 = _MouseX
                    y1 = _MouseY
                Case 2
                    x2 = _MouseX
                    y2 = _MouseY
            End Select
        End If
    Else
        mouseDown = false
    End If

    Cls
    Print "Click to set the initial line coordinate,"
    Print "click again to set the final line coordinate."
    Print "Use the mousewheel to make the line thicker/thinner."
    Print "Current thickness:"; thickness

    If totalDots = 1 Then
        PSet (x1, y1)
    Else
        thickLine x1, y1, x2, y2, thickness
    End If
    _Display
    _Limit 30
Loop

Sub thickLine (x1 As Single, y1 As Single, x2 As Single, y2 As Single, lineWeight%)
    Dim a As Single, x0 As Single, y0 As Single
    Dim prevDest As Long, prevColor As _Unsigned Long
    Static colorSample As Long

    If colorSample = 0 Then
        colorSample = _NewImage(1, 1, 32)
    End If

    prevDest = _Dest
    prevColor = _DefaultColor
    _Dest colorSample
    PSet (0, 0), prevColor
    _Dest prevDest

    a = _Atan2(y2 - y1, x2 - x1)
    a = a + _Pi / 2
    x0 = 0.5 * lineWeight% * Cos(a)
    y0 = 0.5 * lineWeight% * Sin(a)

    _MapTriangle _Seamless(0, 0)-(0, 0)-(0, 0), colorSample To(x1 - x0, y1 - y0)-(x1 + x0, y1 + y0)-(x2 + x0, y2 + y0), , _Smooth
    _MapTriangle _Seamless(0, 0)-(0, 0)-(0, 0), colorSample To(x1 - x0, y1 - y0)-(x2 + x0, y2 + y0)-(x2 - x0, y2 - y0), , _Smooth
End Sub

