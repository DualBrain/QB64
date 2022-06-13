'_OE

Do Until _ScreenExists: Loop
_Title "If these curves were smoother they'd steal your wife."

' Hardware
Screen _NewImage(800, 600, 32)
_ScreenMove (_DesktopWidth \ 2 - _Width \ 2) - 3, (_DesktopHeight \ 2 - _Height \ 2) - 29

' Meta
Randomize Timer

' Data structures
Type Vector
    x As Double
    y As Double
End Type
 
' Object type
Type Object
    Elements As Integer
    Shade As _Unsigned Long
End Type
 
' Object storage
Dim Shared Shape(300) As Object
Dim Shared PointChain(300, 500) As Vector
Dim Shared TempChain(300, 500) As Vector
Dim Shared ShapeCount As Integer
Dim Shared SelectedShape As Integer
 
Dim Shared MasterDraw As String

' Initialize
ShapeCount = 0
 
' Main loop
Do
    Locate 1, 1: Print ShapeCount
    Call UserInput
    Call Graphics
    _Limit 120
Loop
 
System
 
Sub UserInput
    TheReturn = 0
    ' Keyboard input
    kk = _KeyHit
    Select Case kk
        Case 32
            Do: Loop Until _KeyHit
            While _MouseInput: Wend
            _KeyClear
            Call NewMouseShape(7.5, 400, 15)
            Cls
        Case Asc("e"), Asc("E")
            Open "Curves" + LTrim$(RTrim$(Str$(Int(Timer)))) + ".txt" For Output As #1
            Print #1, MasterDraw
            Close #1
    End Select
    If (kk) Then
        _KeyClear
    End If
End Sub
 
Sub Graphics
    Dim k As Integer
    Dim x1 As Double
    Dim x2 As Double
    Dim y1 As Double
    Dim y2 As Double
    MasterDraw = ""
    Line (0, 0)-(_Width, _Height), _RGBA(0, 0, 0, 255), BF
    Call cPrintstring(16 * 17, "PRESS SPACE and then drag MOUSE 1 to draw a new shape.")
    For k = 1 To ShapeCount
        z$ = "c" + Str$(Shape(k).Shade) + " "
        For i = 1 To Shape(k).Elements - 1
            x1 = PointChain(k, i).x
            y1 = PointChain(k, i).y
            x2 = PointChain(k, i + 1).x
            y2 = PointChain(k, i + 1).y
            Call lineSmooth(x1, y1, x2, y2, Shape(k).Shade)

            ''''
            '' Fellippe, this was it ...
            'dr = Sqr((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
            'ang = (180 / 3.1416 * Atn((y2 - y1) / (x2 - x1)))
            'If (x2 < x1) Then
            '    ang = 180 + ang
            'End If
            'z$ = z$ + "TA " + Str$(ang - 90) + " U" + Str$(dr) + " "
            ''''
        Next
        ' Make a point to get DRAW started.
        'Call cPset(PointChain(k, 1).x, PointChain(k, 1).y, Shape(k).Shade)
        ' Draw replaces CLine.
        'MasterDraw = MasterDraw + z$ + "___"
        'Draw z$
    Next
    _Display
End Sub
 
Sub NewMouseShape (rawresolution As Double, targetpoints As Integer, smoothiterations As Integer)
    ShapeCount = ShapeCount + 1
    numpoints = 0
    xold = 999 ^ 999
    yold = 999 ^ 999
    Do
        Do While _MouseInput
            x = _MouseX
            y = _MouseY
            If (x > 0) And (x < _Width) And (y > 0) And (y < _Height) Then
                If _MouseButton(1) Then
                    x = x - (_Width / 2)
                    y = -y + (_Height / 2)
                    delta = Sqr((x - xold) ^ 2 + (y - yold) ^ 2)
                    If (delta > rawresolution) And (numpoints < targetpoints - 1) Then
                        numpoints = numpoints + 1
                        PointChain(ShapeCount, numpoints).x = x
                        PointChain(ShapeCount, numpoints).y = y
                        Call cPset(x, y, _RGB(0, 255, 255))
                        xold = x
                        yold = y
                    End If
                End If
            End If
        Loop
        _Display
    Loop Until Not _MouseButton(1) And (numpoints > 1)
 
    Do While (numpoints < targetpoints)
        rad2max = -1
        kmax = -1
        For k = 1 To numpoints - 1
            xfac = PointChain(ShapeCount, k).x - PointChain(ShapeCount, k + 1).x
            yfac = PointChain(ShapeCount, k).y - PointChain(ShapeCount, k + 1).y
            rad2 = xfac ^ 2 + yfac ^ 2
            If rad2 > rad2max Then
                kmax = k
                rad2max = rad2
            End If
        Next
        For j = numpoints To kmax + 1 Step -1
            PointChain(ShapeCount, j + 1).x = PointChain(ShapeCount, j).x
            PointChain(ShapeCount, j + 1).y = PointChain(ShapeCount, j).y
        Next
        PointChain(ShapeCount, kmax + 1).x = (1 / 2) * (PointChain(ShapeCount, kmax).x + PointChain(ShapeCount, kmax + 2).x)
        PointChain(ShapeCount, kmax + 1).y = (1 / 2) * (PointChain(ShapeCount, kmax).y + PointChain(ShapeCount, kmax + 2).y)
        numpoints = numpoints + 1
    Loop
 
    For j = 1 To smoothiterations
        For k = 2 To numpoints - 1
            TempChain(ShapeCount, k).x = (1 / 2) * (PointChain(ShapeCount, k - 1).x + PointChain(ShapeCount, k + 1).x)
            TempChain(ShapeCount, k).y = (1 / 2) * (PointChain(ShapeCount, k - 1).y + PointChain(ShapeCount, k + 1).y)
        Next
        For k = 2 To numpoints - 1
            PointChain(ShapeCount, k).x = TempChain(ShapeCount, k).x
            PointChain(ShapeCount, k).y = TempChain(ShapeCount, k).y
        Next
    Next
 
    Shape(ShapeCount).Elements = numpoints
    Shape(ShapeCount).Shade = _RGB(100 + Int(Rnd * 155), 100 + Int(Rnd * 155), 100 + Int(Rnd * 155))
    SelectedShape = ShapeCount
End Sub
 
Sub cPset (x1 As Double, y1 As Double, col As _Unsigned Long)
    PSet (_Width / 2 + x1, -y1 + _Height / 2), col
End Sub

Sub cLine (x1 As Double, y1 As Double, x2 As Double, y2 As Double, col As _Unsigned Long)
    Line (_Width / 2 + x1, -y1 + _Height / 2)-(_Width / 2 + x2 - 0, -y2 + _Height / 2 + 0), col
End Sub
 
Sub cPrintstring (y, a As String)
    _PrintString (_Width / 2 - (Len(a) * 8) / 2, -y + _Height / 2), a
End Sub
 
Sub lineSmooth (x0, y0, x1, y1, c As _Unsigned Long)
    'Credit: FellippeHeitor qb64.org (2020)
    '        Adapted from https://en.wikipedia.org/w/index.php?title=Xiaolin_Wu%27s_line_algorithm&oldid=852445548
    'Edit:   Correction to alpha channel (2020-11-20)

    Dim plX As Integer, plY As Integer, plI

    Dim steep As _Byte
    steep = Abs(y1 - y0) > Abs(x1 - x0)

    If steep Then
        Swap x0, y0
        Swap x1, y1
    End If

    If x0 > x1 Then
        Swap x0, x1
        Swap y0, y1
    End If

    Dim dx, dy, gradient
    dx = x1 - x0
    dy = y1 - y0
    gradient = dy / dx

    If dx = 0 Then
        gradient = 1
    End If

    'handle first endpoint
    Dim xend, yend, xgap, xpxl1, ypxl1
    xend = _Round(x0)
    yend = y0 + gradient * (xend - x0)
    xgap = (1 - ((x0 + .5) - Int(x0 + .5)))
    xpxl1 = xend 'this will be used in the main loop
    ypxl1 = Int(yend)
    If steep Then
        plX = ypxl1
        plY = xpxl1
        plI = (1 - (yend - Int(yend))) * xgap
        GoSub plot

        plX = ypxl1 + 1
        plY = xpxl1
        plI = (yend - Int(yend)) * xgap
        GoSub plot
    Else
        plX = xpxl1
        plY = ypxl1
        plI = (1 - (yend - Int(yend))) * xgap
        GoSub plot

        plX = xpxl1
        plY = ypxl1 + 1
        plI = (yend - Int(yend)) * xgap
        GoSub plot
    End If

    Dim intery
    intery = yend + gradient 'first y-intersection for the main loop

    'handle second endpoint
    Dim xpxl2, ypxl2
    xend = _Round(x1)
    yend = y1 + gradient * (xend - x1)
    xgap = ((x1 + .5) - Int(x1 + .5))
    xpxl2 = xend 'this will be used in the main loop
    ypxl2 = Int(yend)
    If steep Then
        plX = ypxl2
        plY = xpxl2
        plI = (1 - (yend - Int(yend))) * xgap
        GoSub plot

        plX = ypxl2 + 1
        plY = xpxl2
        plI = (yend - Int(yend)) * xgap
        GoSub plot
    Else
        plX = xpxl2
        plY = ypxl2
        plI = (1 - (yend - Int(yend))) * xgap
        GoSub plot

        plX = xpxl2
        plY = ypxl2 + 1
        plI = (yend - Int(yend)) * xgap
        GoSub plot
    End If

    'main loop
    Dim x
    If steep Then
        For x = xpxl1 + 1 To xpxl2 - 1
            plX = Int(intery)
            plY = x
            plI = (1 - (intery - Int(intery)))
            GoSub plot

            plX = Int(intery) + 1
            plY = x
            plI = (intery - Int(intery))
            GoSub plot

            intery = intery + gradient
        Next
    Else
        For x = xpxl1 + 1 To xpxl2 - 1
            plX = x
            plY = Int(intery)
            plI = (1 - (intery - Int(intery)))
            GoSub plot

            plX = x
            plY = Int(intery) + 1
            plI = (intery - Int(intery))
            GoSub plot

            intery = intery + gradient
        Next
    End If

    Exit Sub

    plot:
    ' Change to regular PSET for standard coordinate orientation.
    Call cPset(plX, plY, _RGB32(_Red32(c), _Green32(c), _Blue32(c), plI * _Alpha32(c)))
    Return
End Sub
 
