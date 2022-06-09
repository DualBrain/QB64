Type BALL
    X As Double
    Y As Double
    U As Double
    V As Double
    XA As Double
    YA As Double
End Type

Dim Shared nBall As Integer
Dim Shared balls(20) As BALL
Dim Shared dt As Double
Dim Shared radius As Integer
Dim Shared diam As Integer
Dim Shared elastic As Double
Dim Shared fric As _Float
Dim Shared isCollision As Integer
Dim Shared grav As _Float
Dim Shared attract As _Float
Dim Shared bg As Integer
Dim Shared fg As Integer
Dim Shared dela As Integer
Dim Shared gw As Integer
Dim Shared gh As Integer
Dim Shared sBall As Integer
Dim Shared isStart As Integer
gw = 640
gh = 480
radius = 15
diam = 2 * radius
dt = 1
nBall = 10
elastic = 1
fric = 0
grav = 0
attract = 0
isCollision = 0
bg = 1
fg = 15
dela = 0
sBall = 1
isStart = 1

SETUP

Screen 12
Paint (0, 0), bg
Line (0, gh + 1)-(gw, gh + 1), 0
Paint (0, gh + 2), 0

While 1
    For i% = 1 To nBall
        Circle (balls(i%).X, balls(i%).Y), radius, bg
        REDRAW i%
        If i% = sBall Then
            Circle (balls(i%).X, balls(i%).Y), radius, 0
        Else
            Circle (balls(i%).X, balls(i%).Y), radius, fg
        End If
    Next
    k$ = InKey$
    Select Case k$
        Case Chr$(27)
            Cls
            SETUP
            Screen 12
            Paint (0, 0), bg
            Line (0, gh + 1)-(gw, gh + 1), 0
            Paint (0, gh + 2), 0
        Case "=", "+"
            sBall = sBall + 1
            If sBall > nBall Then sBall = 1
        Case "-"
            sBall = sBall - 1
            If sBall < 1 Then sBall = nBall
        Case " "
            While InKey$ <> " ": Wend
        Case Chr$(13)
            balls(sBall).U = 0
            balls(sBall).V = 0
        Case Chr$(0) + "P"
            balls(sBall).V = balls(sBall).V + 1
        Case Chr$(0) + "H"
            balls(sBall).V = balls(sBall).V - 1
        Case Chr$(0) + "M"
            balls(sBall).U = balls(sBall).U + 1
        Case Chr$(0) + "K"
            balls(sBall).U = balls(sBall).U - 1
    End Select
    _Limit 60
Wend


Sub ATTRACTION (i%)
    If attract <> 0 Then
        For j% = i% + 1 To nBall
            xm = balls(j%).X - balls(i%).X
            ym = balls(j%).Y - balls(i%).Y
            dist = xm ^ 2 + ym ^ 2
            If dist < (radius ^ 2) Then dist = radius ^ 2
            balls(i%).U = attract * xm / dist + balls(i%).U
            balls(i%).V = attract * ym / dist + balls(i%).V
            balls(j%).U = attract * xm / dist + balls(j%).U
            balls(j%).V = -attract * ym / dist + balls(j%).V
        Next
    End If
End Sub

Sub ChangeValue (selected, k$)
    Select Case selected
        Case 0
            sBall = nBall
            If k$ = Chr$(0) + "M" Then
                nBall = nBall + 1
                If nBall > 20 Then nBall = 1
            End If
            If k$ = Chr$(0) + "K" Then
                nBall = nBall - 1
                If nBall < 1 Then nBall = 20
            End If
            
            If nBall > 9 Then
                Locate 8, 50
            Else
                Locate 8, 51
            End If
            Print nBall
            If nBall <> sBall Then
                Color 8, 1
                Locate 16, 25
                Print "{R}     TO RESUME SIMULATION"
                Color 15, 1
                isStart = 1
            End If
        Case 8
            If k$ = Chr$(0) + "M" Then
                elastic = elastic + .1
                If elastic >= 10 Then elastic = .1
            End If
            If k$ = Chr$(0) + "K" Then
                elastic = elastic - .1
                If elastic < -9.99 Then elastic = 9.9
            End If
            Locate 9, 46
            Print "       "
            Locate 9, 50
            If elastic >= 1 Then Locate 9, 49
            Print elastic
        Case 1
            If k$ = Chr$(0) + "M" Then
                elastic = elastic + .1
                If elastic > 9.91 Then elastic = .1
            End If
            If k$ = Chr$(0) + "K" Then
                elastic = elastic - .1
                If elastic < .09 Then elastic = 9.91
            End If
            iattract% = (elastic - Int(elastic)) * 10
            If iattract% > 9 Then
                Locate 9, 50
                Print iattract%
                Locate 9, 50
            Else
                Locate 9, 51
                Print iattract%
                Locate 9, 51
            End If
            Locate 9, 49
            Print Int(elastic)
            Locate 9, 51
            Print "."
        Case 2
            If k$ = Chr$(0) + "M" Then
                fric = fric + .001
                If fric >= 1 Then fric = -1
            End If
            If k$ = Chr$(0) + "K" Then
                fric = fric - .001
                If fric <= -1 Then fric = 1
            End If
            Locate 10, 46
            Print "       "
            Locate 10, 48
            If fric = 0 Then Locate 10, 51
            Print fric
        Case 9
            If k$ = Chr$(0) + "M" Then
                fric = fric + .001
                If fric > .099 Then fric = 0
            End If
            If k$ = Chr$(0) + "K" Then
                fric = fric - .001
                If fric < 0 Then fric = .099
            End If
            ifric% = fric * 1000
            If ifric% > 9 Then
                Locate 10, 50
                Print ifric%
                Locate 10, 50
                Print "0"
            Else
                Locate 10, 51
                Print ifric%
                Locate 10, 51
                Print "0"
            End If
        Case 3
            If k$ = Chr$(0) + "M" Then
                grav = grav + .001
                If grav >= 1 Then grav = -1
            End If
            If k$ = Chr$(0) + "K" Then
                grav = grav - .001
                If grav <= -1 Then grav = 1
            End If
            Locate 11, 46
            Print "       "
            Locate 11, 48
            If grav = 0 Then Locate 11, 51
            Print grav

        Case 10
            If k$ = Chr$(0) + "M" Then
                grav = grav + .001
                If grav > .099 Then grav = 0
            End If
            If k$ = Chr$(0) + "K" Then
                grav = grav - .001
                If grav < 0 Then grav = .099
            End If
            igrav% = grav * 1000
            If igrav% > 9 Then
                Locate 11, 50
                Print igrav%
                Locate 11, 50
                Print "0"
            Else
                Locate 11, 51
                Print igrav%
                Locate 11, 51
                Print "0"
            End If
        Case 4
            If k$ = Chr$(0) + "M" Then
                attract = attract + .01
                If attract >= 10 Then attract = -9.99
            End If
            If k$ = Chr$(0) + "K" Then
                attract = attract - .01
                If attract < -9.99 Then attract = 9.99
            End If
            Locate 12, 48
            Print "      "
            Locate 12, 49
            If attract = 0 Then Locate 12, 51
            If attract >= 1 Or attract <= -1 Then Locate 12, 48
            Print attract
        Case 7
            If k$ = Chr$(0) + "M" Then
                attract = attract + .01
                If attract >= 10 Then attract = -9.99
            End If
            If k$ = Chr$(0) + "K" Then
                attract = attract - .01
                If attract < -9.99 Then attract = 9.99
            End If
            iattract% = Int((attract - Int(attract)) * 100)
            If iattract% > 9 Then
                Locate 12, 50
                Print iattract%
            Else
                Locate 12, 51
                Print iattract%
                Locate 12, 51
                Print "0"
            End If
            Locate 12, 48
            Print Int(attract)
            Locate 12, 50
            Print "."
        Case 5
            If k$ = Chr$(0) + "M" Then
                dt = dt + .1
                If dt > 9.9 Then dt = .1
            End If
            If k$ = Chr$(0) + "K" Then
                dt = dt - .1
                If dt <= 0 Then dt = 9.9
            End If
            iattract% = dt * 10
            If iattract% > 9 Then
                Locate 13, 50
                Print iattract%
                Locate 13, 50
            Else
                Locate 13, 51
                Print iattract%
                Locate 13, 51
            End If
            Locate 13, 49
            Print Int(dt)
            Locate 13, 51
            Print "."
        Case 6
            If k$ = Chr$(0) + "M" Then
                dela = dela + 1
                If dela > 9 Then dela = 0
            End If
            If k$ = Chr$(0) + "K" Then
                dela = dela - 1
                If dela < 0 Then dela = 9
            End If
            
            If dela > 9 Then
                Locate 14, 50
                Print dela
            Else
                Locate 14, 51
                Print dela
            End If
    End Select
End Sub

Sub COLLISION (i%)
    For j% = i% + 1 To nBall
        xi = balls(i%).X
        yi = balls(i%).Y
        xj = balls(j%).X
        yj = balls(j%).Y
        dx = xi - xj
        dy = yi - yj
        dist = Sqr(dx ^ 2 + dy ^ 2)
        If (dist < diam) Then
            isCollision = 1
            Circle (balls(i%).X, balls(i%).Y), radius, bg
            Circle (balls(j%).X, balls(j%).Y), radius, bg
            ui = balls(i%).U
            vi = balls(i%).V
            uj = balls(j%).U
            vj = balls(j%).V

            CoefA = (ui - uj) ^ 2 + (vi - vj) ^ 2
            CoefB = 2 * ((ui - uj) * (xi - xj) + (vi - vj) * (yi - yj))
            CoefC = (xi - xj) ^ 2 + (yi - yj) ^ 2 - diam ^ 2

            If (CoefA = 0) Then
                t = -CoefC / CoefB
            Else
                If (dt >= 0) Then
                    t = (-CoefB - Sqr(CoefB ^ 2 - 4 * CoefA * CoefC)) / (2 * CoefA)
                Else
                    t = (-CoefB + Sqr(CoefB ^ 2 - 4 * CoefA * CoefC)) / (2 * CoefA)
                End If
            End If
            xi = xi + t * ui
            yi = yi + t * vi
            xj = xj + t * uj
            yj = yj + t * vj

            mx = (ui + uj) / 2
            my = (vi + vj) / 2
            ui = ui - mx
            vi = vi - my
            uj = uj - mx
            vj = vj - my

            dx = xi - xj
            dy = yi - yj
            dist = Sqr(dx ^ 2 + dy ^ 2)
            dx = dx / dist
            dy = dy / dist

            foo = -(dx * ui + dy * vi)
            ui = ui + 2 * foo * dx
            vi = vi + 2 * foo * dy
            bar = -(dx * uj + dy * vj)
            uj = uj + 2 * bar * dx
            vj = vj + 2 * bar * dy

            e = Sqr(elastic)
            ui = e * (ui + mx)
            vi = e * (vi + my)
            uj = e * (uj + mx)
            vj = e * (vj + my)

            xi = xi - t * ui
            yi = yi - t * vi
            xj = xj - t * uj
            yj = yj - t * vj

            balls(i%).U = ui
            balls(i%).V = vi
            balls(j%).U = uj
            balls(j%).V = vj

            balls(i%).X = xi
            balls(i%).Y = yi
            balls(j%).X = xj
            balls(j%).Y = yj
        End If
    Next
End Sub

Sub CreateFancyBox ()

    Color 15, 1

    Locate 3, 23
    Print Chr$(201)
    Locate 18, 23
    Print Chr$(200)
    Locate 18, 56
    Print Chr$(188)
    Locate 3, 56
    Print Chr$(187)

    Color 1, 0

    For i% = 0 To 13
        For j% = 0 To 32
            Locate 4 + i%, 24 + j%
            Print Chr$(219)
        Next
    Next

    Color 15, 1

    For i% = 0 To 31
        Locate 3, 24 + i%
        Print Chr$(205)
        Locate 18, 24 + i%
        Print Chr$(205)
    Next

    For i% = 0 To 13
        Locate 4 + i%, 23
        Print Chr$(186)
        Locate 4 + i%, 56
        Print Chr$(186)
    Next

End Sub

Sub CreateOtherFancyBox ()

    Color 2, 0

    For i% = 0 To 3
        For j% = 0 To 43
            Locate 20 + i%, 18 + j%
            Print Chr$(219)
        Next
    Next

    Color 15, 2

    For i% = 0 To 41
        Locate 20, 19 + i%
        Print Chr$(205)
        Locate 23, 19 + i%
        Print Chr$(205)
    Next

    For i% = 0 To 1
        Locate 21 + i%, 18
        Print Chr$(186)
        Locate 21 + i%, 61
        Print Chr$(186)

    Next

    Locate 20, 18
    Print Chr$(201)
    Locate 23, 18
    Print Chr$(200)
    Locate 23, 61
    Print Chr$(188)
    Locate 20, 61
    Print Chr$(187)

    Locate 21, 20
    Print "CHANGE SELECTED: +/-"

    Locate 21, 46
    Print "STOP:  {ENTER}"
    Locate 22, 46
    Print "PAUSE: {SPACE}"


    Locate 22, 20
    Print "CHANGE VELOCITY:"

    For i% = 0 To 1
        Locate 22, 37 + (2 * i%)
        Print Chr$(24 + i%)
    Next

    For i% = 1 To 0 Step -1
        Locate 22, 43 - (2 * i%)
        Print Chr$(26 + i%)
    Next


    Color 15, 1

End Sub

Sub delay (ticks%)

    For i% = 1 To ticks%
        st# = Timer
        While Timer = st#: Wend
    Next i%

End Sub

Sub GRAVITY (i%)
    U = balls(i%).U
    V = balls(i%).V
    fricscale = (1 - fric / Sqr(1 + U ^ 2 + V ^ 2))
    balls(i%).U = fricscale * U
    balls(i%).V = fricscale * V + grav
End Sub

Sub PAUSE ()
    While InKey$ = "": Wend
End Sub

Function Rand% (Bottom As Integer, Top As Integer)
    Randomize Timer
    Randomize Rnd
    Rand% = Int((Top - Bottom + 1) * Rnd + Bottom)
End Function

Sub REDRAW (i%)
    balls(i%).X = balls(i%).X + (balls(i%).U * dt)
    balls(i%).Y = balls(i%).Y + (balls(i%).V * dt)
    X = balls(i%).X
    Y = balls(i%).Y
    If X < radius Then
        balls(i%).U = -balls(i%).U
        balls(i%).X = radius
    End If
    If X > (gw - radius) Then
        balls(i%).U = -balls(i%).U
        balls(i%).X = (gw - radius)
    End If
    If Y < radius Then
        balls(i%).V = -balls(i%).V
        balls(i%).Y = radius
    End If
    If Y > (gh - radius) Then
        balls(i%).V = -balls(i%).V
        balls(i%).Y = gh - radius
    End If
    COLLISION i%
    GRAVITY i%
    ATTRACTION i%
End Sub

Sub SETUP ()
    Screen 0
    Cls

    'LOCATE 1, 1
    'PRINT sBall

    CreateFancyBox
    CreateOtherFancyBox

    Locate 4, 28
    Print "COLLIDING BALL SIMULATION"
    Locate 5, 31
    Print "Copyright (c) 2013"
    Locate 6, 32
    Print "Timothy Baxendale"

    Locate 8, 25
    Print "NUMBER OF BALLS"
    Color 6, 1
    Locate 8, 45
    Print Chr$(17)
    Color 15, 1
    Locate 9, 25
    Print "ELASTIC"
    Locate 9, 45
    Print Chr$(17)
    Locate 10, 25
    Print "FRICTION"
    Locate 10, 45
    Print Chr$(17)
    Locate 11, 25
    Print "GRAVITY"
    Locate 11, 45
    Print Chr$(17)
    Locate 12, 25
    Print "ATTRACTION"
    Locate 12, 45
    Print Chr$(17)
    Locate 13, 25
    Print "SPEED"
    Locate 13, 45
    Print Chr$(17)

    ChangeValue 0, ""
    Locate 10, 48
    Print "0.000"
    ChangeValue 1, ""
    Locate 11, 48
    Print "0.000"
    ChangeValue 2, ""
    ChangeValue 3, ""
    ChangeValue 4, ""
    ChangeValue 5, ""
    
    Locate 15, 25
    Print "{ENTER} TO RUN SIMULATION"
    
    If isStart = 1 Then Color 8, 1
    Locate 16, 25
    Print "{R}     TO RESUME SIMULATION"
    If isStart = 1 Then Color 15, 1
    
    Locate 17, 25
    Print "{ESC}   TO EXIT"
    
    Color 6, 1
    Locate 8, 54
    Print Chr$(16)
    Color 15, 1

    Locate 9, 54
    Print Chr$(16)
    Locate 10, 54
    Print Chr$(16)
    Locate 11, 54
    Print Chr$(16)
    Locate 12, 54
    Print Chr$(16)
    Locate 13, 54
    Print Chr$(16)

    selected = 0
    
    While 1
        k$ = InKey$
        Select Case k$
            Case Chr$(27)
                Color 7, 0
                Cls
                End
            Case Chr$(0) + "P"
                Locate 8 + selected, 54
                Print Chr$(16)
                Locate 8 + selected, 45
                Print Chr$(17)
                selected = selected + 1
                If selected > 5 Then selected = 0
                Color 6, 1
                Locate 8 + selected, 54
                Print Chr$(16)
                Locate 8 + selected, 45
                Print Chr$(17)
                Color 15, 1
            Case Chr$(0) + "H"
                Locate 8 + selected, 54
                Print Chr$(16)
                Locate 8 + selected, 45
                Print Chr$(17)
                selected = selected - 1
                If selected < 0 Then selected = 5
                Color 6, 1
                Locate 8 + selected, 54
                Print Chr$(16)
                Locate 8 + selected, 45
                Print Chr$(17)
                Color 15, 1
            Case Chr$(0) + "K"
                ChangeValue selected, k$
            Case Chr$(0) + "M"
                ChangeValue selected, k$
            Case Chr$(13)
                r = 0
                isStart = 0
                GoTo START
            Case "r", "R"
                If isStart = 0 Then
                    r = 1
                    GoTo START
                End If
        End Select
    Wend

    START:
    If r = 0 Then
        sBall = 1
        For i% = 1 To nBall
            balls(i%).X = Rand(1, gw)
            balls(i%).Y = Rand(1, gh)
            balls(i%).U = Rand(1, 500) / 100 - 3
            balls(i%).V = Rand(1, 500) / 100 - 3
        Next
    End If
End Sub

