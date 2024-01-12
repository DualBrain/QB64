Option _Explicit



Do Until _ScreenExists: Loop

_Title "Epicycles"



Screen _NewImage(800, 600, 32)



Type Vector

    x As Double

    y As Double

End Type



Dim RunningMode As Integer ' 0=mouse, 1=lissajoux, 2=etc

RunningMode = 0



Dim As Long N, j, kh, i, m

Dim As Double x0, y0, xp, yp, t



Dim As Vector RawDataPoint(0 To 100000)



Do

    Cls

    Line (0, 0)-(_Width, _Height), _RGB(255, 255, 255, 255), BF

    Color _RGB(0, 0, 0), _RGB(255, 255, 255)

    Locate 1, 1

    Print "Click & Drag to draw a curve."

    Line (0, _Height / 2)-(_Width, _Height / 2), _RGB32(0, 0, 0, 255)

    Line (_Width / 2, 0)-(_Width / 2, _Height), _RGB32(0, 0, 0, 255)

    _Display



    N = 0

    If (Command$ = "") Then

        If (RunningMode = 0) Then

            If (N = 0) Then

                N = GatherMousePoints&(RawDataPoint(), 5)

            End If

        End If

        If (RunningMode <> 0) Then

            N = 250

            For j = 0 To N - 1

                RawDataPoint(j).x = 0

                RawDataPoint(j).y = 0

            Next

        End If

    Else

        RunningMode = 0

        Open Command$ For Input As #1

        Do While Not EOF(1)

            Input #1, x0, y0

            RawDataPoint(N).x = x0

            RawDataPoint(N).y = y0

            N = N + 1

        Loop

        Close #1

        Sleep

    End If



    ReDim GivenPoint(0 To N) As Vector

    For j = 0 To N - 1

        GivenPoint(j) = RawDataPoint(j)

    Next



    ReDim As Vector Q(N - 1)

    ReDim As Double rad(N - 1)

    ReDim As Double phase(N - 1)

    ReDim As Long omega(N - 1)

    ReDim As Double urad(N - 1)

    ReDim As Double uphase(N - 1)

    ReDim As Long uomega(N - 1)

    ReDim As Vector CalculatedPath(N)

    ReDim As Vector ProtoPath(N * 60)

    ReDim As Vector PathSegmentsA(N, N)

    ReDim As Vector PathSegmentsB(N, N)



    For j = 0 To N - 1

        omega(j) = j

        If (j > N / 2) Then omega(j) = j - N

        DFT Q(j).x, Q(j).y, GivenPoint(), j

        rad(j) = Sqr(Q(j).x * Q(j).x + Q(j).y * Q(j).y)

        phase(j) = _Atan2(Q(j).y, Q(j).x)

    Next



    If (RunningMode = 1) Then

        For j = 0 To (N - 1)

            rad(j) = 0

            phase(j) = 0

        Next

        Dim aa

        Dim bb

        '''

        aa = 1

        bb = 3

        '''

        rad(aa) = 30

        rad(bb) = 30

        phase(aa) = -_Pi

        phase(bb) = 3 * _Pi / 4

        rad(N - aa) = 30

        rad(N - bb) = 30

        phase(N - aa) = 0

        phase(N - bb) = -3 * _Pi / 4

    End If



    If (RunningMode = 2) Then

        For j = 0 To (N - 1)

            rad(j) = 0

            phase(j) = 0

        Next

        '''

        aa = 1

        bb = 1

        '''

        rad(aa) = 50

        phase(aa) = -_Pi / 2

        rad(N - bb) = 25

        phase(N - bb) = _Pi / 2

    End If



    For j = 0 To N - 1

        uomega(j) = omega(j)

        urad(j) = rad(j)

        uphase(j) = phase(j)

    Next



    Call QuickSort(0, N - 1, rad(), phase(), omega())



    ''''

    'Open "epi-out.txt" For Output As #1

    'For j = 0 To N - 1

    '    Print #1, omega(j), Chr$(9), rad(j), Chr$(9), phase(j)

    'Next

    'Close #1

    ''''

    'Open "epi-uout.txt" For Output As #1

    'For j = 0 To N - 1

    '    Print #1, uomega(j), Chr$(9), urad(j), Chr$(9), uphase(j)

    'Next

    'Close #1

    ''''



    m = 0

    CalculatedPath(0).x = GivenPoint(0).x

    CalculatedPath(0).y = GivenPoint(0).y

    For t = 0 To 2 * _Pi Step 2 * _Pi / N

        x0 = 0

        y0 = 0

        For j = 0 To N - 1

            PathSegmentsA(m, j).x = x0

            PathSegmentsA(m, j).y = y0

            xp = rad(j) * Cos(phase(j) + t * omega(j))

            yp = -rad(j) * Sin(phase(j) + t * omega(j))

            x0 = x0 + xp

            y0 = y0 + yp

            PathSegmentsB(m, j).x = x0

            PathSegmentsB(m, j).y = y0

        Next

        CalculatedPath(m).x = x0

        CalculatedPath(m).y = y0

        m = m + 1

    Next



    i = 0



    _KeyClear

    Do



        m = 0

        For t = 0 To (2 * _Pi) Step (2 * _Pi / (N * 60))

            x0 = 0

            y0 = 0

            For j = 0 To N - 1

                xp = rad(j) * Cos(phase(j) + t * omega(j))

                yp = -rad(j) * Sin(phase(j) + t * omega(j))

                x0 = x0 + xp

                y0 = y0 + yp

                If (j = i) Then

                    ProtoPath(m).x = x0

                    ProtoPath(m).y = y0

                    Exit For

                End If

            Next

            m = m + 1

        Next



        For j = 0 To N - 1

            kh = _KeyHit

            Cls

            Locate 1, 1

            Print "Approximation "; _Trim$(Str$(i)); " of "; _Trim$(Str$(N - 1)); ". Press any key to restart."

            Line (_Width / 2, _Height - 100)-(_Width / 2, _Height - 40), _RGB32(0, 0, 0, 55)

            For m = 0 To N - 1

                Call CCircleF(GivenPoint(m).x, GivenPoint(m).y, 3, _RGB(155, 155, 155, 255))

            Next

            For m = 0 To N - 2

                Call LineSmooth(CalculatedPath(m).x, CalculatedPath(m).y, CalculatedPath(m + 1).x, CalculatedPath(m + 1).y, _RGB32(0, 0, 0, 75))

            Next

            For m = 0 To i

                Call CCircle(PathSegmentsA(j, m).x, PathSegmentsA(j, m).y, rad(m), _RGB32(0, 127, 255, 155))

                Call LineSmooth(PathSegmentsA(j, m).x, PathSegmentsA(j, m).y, PathSegmentsB(j, m).x, PathSegmentsB(j, m).y, _RGB32(28, 28, 255, 155))

            Next

            For m = 0 To (j - 0) * 60

                Call CCircleF(ProtoPath(m).x, ProtoPath(m).y, 1, _RGB32(255, 0, 255 * m / j, 255))

                'CALL LineSmooth(ProtoPath(m).x, ProtoPath(m).y, ProtoPath(m + 60).x, ProtoPath(m + 60).y, _RGB32(255, 0, 255 * m / j, 255))

            Next

            Dim nn

            nn = N

            'IF nn > 100 THEN nn = 100

            For m = 0 To N - 1

                y0 = .9 * _Width / nn

                x0 = uomega(m) * y0 - y0 / 2

                Call CLineBF(x0, -(_Height) / 2 + 40, x0 + y0, -(_Height) / 2 + 40 + 20 * Log(1 + urad(m)), _RGB32(0, 0, 0, 55))

                If (urad(m) > .001) Then

                    Call CLineBF(x0, -(_Height) / 2 + 40, x0 + y0, -(_Height) / 2 + 40 + 10 * (uphase(m)), _RGB32(255, 0, 0, 55))

                End If

            Next

            For m = 0 To i

                y0 = .9 * _Width / nn

                x0 = omega(m) * y0 - y0 / 2

                Call CLineBF(x0, -(_Height) / 2 + 40, x0 + y0, -(_Height) / 2 + 40 + 20 * Log(1 + rad(m)), _RGB32(0, 0, 0, 155))

                If (rad(m) > .001) Then

                    Call CLineBF(x0, -(_Height) / 2 + 40, x0 + y0, -(_Height) / 2 + 40 + 10 * (phase(m)), _RGB32(255, 0, 0, 105))

                End If

            Next



            '_DELAY .5

            _Delay .1 / N

            _Display

            _Limit 60



            If (kh <> 0) Then Exit Do

        Next



        If (i = N - 1) Then

            'i = 0

        Else

            i = i + 1 + Int(Sqr(i))

            If (i >= N) Then i = N - 1

        End If



        If (kh <> 0) Then

            kh = 0

            Exit Do

        End If



        'SLEEP 15

        _Delay 1



    Loop

Loop



Sleep

System



Sub DFT (re As Double, im As Double, arr() As Vector, j0 As Long)

    Dim As Long n, k

    Dim As Double u, v, arg

    n = UBound(arr)

    re = 0

    im = 0

    For k = 0 To n

        arg = 2 * _Pi * k * j0 / n

        cmul u, v, Cos(arg), Sin(arg), arr(k).x, arr(k).y

        re = re + u

        im = im - v

    Next

    re = re / n

    im = im / n

End Sub



Sub cmul (u As Double, v As Double, xx As Double, yy As Double, aa As Double, bb As Double)

    u = xx * aa - yy * bb

    v = xx * bb + yy * aa

End Sub



Sub CCircle (x0 As Double, y0 As Double, rad As Double, shade As _Unsigned Long)

    Circle (_Width / 2 + x0, -y0 + _Height / 2), rad, shade

End Sub



Sub CPset (x0 As Double, y0 As Double, shade As _Unsigned Long)

    PSet (_Width / 2 + x0, -y0 + _Height / 2), shade

End Sub



Sub CLine (x0 As Double, y0 As Double, x1 As Double, y1 As Double, shade As _Unsigned Long)

    Line (_Width / 2 + x0, -y0 + _Height / 2)-(_Width / 2 + x1, -y1 + _Height / 2), shade

End Sub



Sub CLineBF (x0 As Double, y0 As Double, x1 As Double, y1 As Double, shade As _Unsigned Long)

    Line (_Width / 2 + x0, -y0 + _Height / 2)-(_Width / 2 + x1, -y1 + _Height / 2), shade, BF

End Sub



Sub CCircleF (x As Long, y As Long, r As Long, c As Long)

    Dim As Long xx, yy, e

    xx = r

    yy = 0

    e = -r

    Do While (yy < xx)

        If (e <= 0) Then

            yy = yy + 1

            Call CLineBF(x - xx, y + yy, x + xx, y + yy, c)

            Call CLineBF(x - xx, y - yy, x + xx, y - yy, c)

            e = e + 2 * yy

        Else

            Call CLineBF(x - yy, y - xx, x + yy, y - xx, c)

            Call CLineBF(x - yy, y + xx, x + yy, y + xx, c)

            xx = xx - 1

            e = e - 2 * xx

        End If

    Loop

    Call CLineBF(x - r, y, x + r, y, c)

End Sub



Sub LineSmooth (x0 As Single, y0 As Single, x1 As Single, y1 As Single, c As _Unsigned Long)

    ' source: https://en.wikipedia.org/w/index.php?title=Xiaolin_Wu%27s_line_algorithm&oldid=852445548

    ' translated: FellippeHeitor @ qb64.org

    ' bugfixed for alpha channel



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

    Call CPset(plX, plY, _RGB32(_Red32(c), _Green32(c), _Blue32(c), plI * _Alpha32(c)))

    Return

End Sub



Function GatherMousePoints& (arr() As Vector, res As Double)

    Dim As Long i

    Dim As Double mx, my, xx, yy, delta, xold, yold

    xold = 0

    yold = 0

    i = 0

    Do

        Do While _MouseInput

            mx = _MouseX

            my = _MouseY

            If _MouseButton(1) Then

                xx = mx - (_Width / 2)

                yy = -my + (_Height / 2)

                delta = Sqr((xx - xold) ^ 2 + (yy - yold) ^ 2)

                If (delta > res) Then

                    Call CCircleF(xx, yy, 3, _RGB(0, 0, 0))

                    _Display

                    arr(i).x = xx

                    arr(i).y = yy

                    xold = xx

                    yold = yy

                    i = i + 1

                End If

            End If

        Loop

        If ((i > 2) And (Not _MouseButton(1))) Then Exit Do

        If (i > 999) Then Exit Do

    Loop

    GatherMousePoints& = i

End Function



Sub QuickSort (LowLimit As Long, HighLimit As Long, rad() As Double, phase() As Double, omega() As Long)

    Dim As Long piv

    If (LowLimit < HighLimit) Then

        piv = Partition(LowLimit, HighLimit, rad(), phase(), omega())

        Call QuickSort(LowLimit, piv - 1, rad(), phase(), omega())

        Call QuickSort(piv + 1, HighLimit, rad(), phase(), omega())

    End If

End Sub



Function Partition (LowLimit As Long, HighLimit As Long, rad() As Double, phase() As Double, omega() As Long)

    Dim As Long i, j

    Dim As Double pivot, tmp

    pivot = rad(HighLimit)

    i = LowLimit - 1

    For j = LowLimit To HighLimit - 1

        tmp = rad(j) - pivot

        If (tmp >= 0) Then

            i = i + 1

            Swap rad(i), rad(j)

            Swap phase(i), phase(j)

            Swap omega(i), omega(j)

        End If

    Next

    Swap rad(i + 1), rad(HighLimit)

    Swap phase(i + 1), phase(HighLimit)

    Swap omega(i + 1), omega(HighLimit)

    Partition = i + 1

End Function





