'OPTION _EXPLICIT

Do Until _ScreenExists: Loop
_Title "Integrators"

Screen _NewImage(1280, 480, 32)

Const Black = _RGB32(0, 0, 0)
Const Blue = _RGB32(0, 0, 255)
Const Gray = _RGB32(128, 128, 128)
Const Green = _RGB32(0, 128, 0)
Const Red = _RGB32(255, 0, 0)
Const White = _RGB32(255, 255, 255)
Const Yellow = _RGB32(255, 255, 0)

problem$ = ProblemPrompt$(0)

' Initial conditions
q10 = 0
p10 = 0
q20 = 0
p20 = 0
Select Case Val(Left$(problem$, 1))
    Case 1
        dt = .003
        cyclic = 1
        delayfactor = 1000
        scalebig = 20
        scalesmall = dt * 5
        m1 = 1
        m2 = 1
        g = 1
        Select Case (Right$(problem$, 1))
            Case "a"
                q10 = 1: p10 = -.2: q20 = 0: p20 = 1
            Case "b"
                q10 = .5: p10 = 1: q20 = -.5: p20 = 1
            Case "c"
                q10 = 1: p10 = .5: q20 = 0: p20 = 1.15
        End Select
    Case 2
        dt = .001
        cyclic = 0
        delayfactor = 1000
        scalebig = 20
        scalesmall = dt * 10
        m1 = 1
        m2 = 1
        g = 1
        Select Case (Right$(problem$, 1))
            Case "a"
                q10 = 1: p10 = 0: q20 = 0: p20 = 1.22437
        End Select
    Case 3
        dt = .03
        cyclic = 0
        delayfactor = 1000
        scalebig = 10
        scalesmall = dt * 7.5
        m = 1
        k = 1
        Select Case (Right$(problem$, 1))
            Case "a"
                q10 = 0: p10 = 2
            Case "b"
                q10 = 2: p10 = 0
        End Select
    Case 4
        dt = .003
        cyclic = 1
        delayfactor = 50000
        scalebig = 12
        scalesmall = dt * 7.5
        m = 1
        k = 1
        Select Case (Right$(problem$, 1))
            Case "a"
                q10 = 0: p10 = 2: q20 = 0: p20 = 2
            Case "b"
                q10 = 2: p10 = 0: q20 = -2: p20 = 0
            Case "c"
                q10 = 2: p10 = 0: q20 = 0: p20 = 0
        End Select
    Case 5
        dt = .03
        cyclic = 1
        delayfactor = 500000
        scalebig = 10
        scalesmall = dt * 5
        m = 1
        g = 1
        l = 1
        Select Case (Right$(problem$, 1))
            Case "a"
                q10 = 0: p10 = 1.5: scalebig = 10
        End Select
    Case 6
        dt = .03
        cyclic = 1
        delayfactor = 500000
        scalebig = 10
        scalesmall = dt * 5
        m = 1
        g = 1
        l = 1
        Select Case (Right$(problem$, 1))
            Case "a"
                q10 = 0: p10 = 2.19
            Case "b"
                q10 = 0: p10 = 2.25
        End Select
    Case 7, 8
        dt = .03
        cyclic = 1
        delayfactor = 500000
        scalebig = 10
        scalesmall = dt * 5
        m = 1
        g = 1
        l = 1
        Select Case (Right$(problem$, 1))
            Case "a"
                q10 = 0: p10 = -1.5
            Case "b"
                q10 = 0: p10 = 1.999
            Case "c"
                q10 = 0: p10 = 2.001
        End Select
    Case Else
        problem$ = ProblemPrompt$(0)
End Select

Cls
Call DrawAxes

' Main loop.
iterations = 0
q1 = q10
p1 = p10
q2 = q20
p2 = p20

Do

    For thedelay = 0 To delayfactor: Next

    q1temp = q1
    p1temp = p1
    q2temp = q2
    p2temp = p2

    Select Case Val(Left$(problem$, 1))
        Case 1
            ' Particle in r^-1 central potential - Symplectic integrator
            q1 = q1temp + dt * (p1temp / m2)
            q2 = q2temp + dt * (p2temp / m2)
            p1 = p1temp - dt * g * m1 * m2 * (q1 / ((q1 ^ 2 + q2 ^ 2) ^ (3 / 2)))
            p2 = p2temp - dt * g * m1 * m2 * (q2 / ((q1 ^ 2 + q2 ^ 2) ^ (3 / 2)))
        Case 2
            ' Particle in r^-2 central potential - Symplectic integrator
            q1 = q1temp + dt * (p1temp / m2)
            q2 = q2temp + dt * (p2temp / m2)
            p1 = p1temp - dt * g * m1 * m2 * ((3 / 2) * q1 / ((q1 ^ 2 + q2 ^ 2) ^ (5 / 2)))
            p2 = p2temp - dt * g * m1 * m2 * ((3 / 2) * q2 / ((q1 ^ 2 + q2 ^ 2) ^ (5 / 2)))
        Case 3
            ' Mass on a spring - Forward Euler method
            q1 = q1temp + (p1temp / m) * dt
            p1 = p1temp - (q1temp * k) * dt
            ' Mass on a spring - Backward Euler method
            q2 = (q2temp + (p2temp / m) * dt) / (1 + dt ^ 2)
            p2 = (p2temp - (q2temp * k) * dt) / (1 + dt ^ 2)
        Case 4
            ' Two equal masses connected by three springs - Symplectic integrator
            q1 = q1temp + m * (p1temp) * dt
            p1 = p1temp - dt * k * (2 * (q1temp + m * (p1temp) * dt) - (q2temp + m * (p2temp) * dt))
            q2 = q2temp + m * (p2temp) * dt
            p2 = p2temp - dt * k * (2 * (q2temp + m * (p2temp) * dt) - (q1temp + m * (p1temp) * dt))
        Case 5
            ' Plane pendulum - Forward Euler method
            q1 = q1temp + (p1temp / m) * dt
            p1 = p1temp - (g / l) * Sin(q1temp) * dt
        Case 6
            ' Plane pendulum - Runge-Kutta 4th
            k1w = -(g / l) * Sin(q1temp)
            k1t = p1temp
            w2 = p1temp + k1w * dt / 2
            t2 = q1temp + k1t * dt / 2
            k2w = -(g / l) * Sin(t2)
            k2t = w2
            w3 = p1temp + k2w * dt / 2
            t3 = q1temp + k2t * dt / 2
            k3w = -(g / l) * Sin(t3)
            k3t = w3
            w4 = p1temp + k3w * dt
            t4 = q1temp + k3t * dt
            k4w = -(g / l) * Sin(t4)
            dwdt = (k1w + 2 * k2w + 2 * k3w + k4w) / 6
            dtdt = (k1t + 2 * k2t + 2 * k3t + k4t) / 6
            p1 = p1temp + dwdt * dt
            q1 = q1temp + dtdt * dt
        Case 7
            ' Plane pendulum - Symplectic integrator
            q1 = q1temp + dt * (p1temp / m)
            p1 = p1temp - dt * (g / l) * (Sin(q1))
        Case 8
            ' Plane pendulum - Modified Euler method
            q1 = q1temp + (p1temp / m) * dt
            p1 = p1temp - (g / l) * Sin(q1) * dt
    End Select

    x = (iterations * scalesmall - 180)
    If (x <= 80) Then
        x = x + (320 - _Width / 2)
        Call cpset(x, (q1 * scalebig + 160), Yellow) ' q1 plot
        Call cpset(x, (p1 * scalebig + 60), Yellow) ' p1 plot
        Call cpset(x, (q2 * scalebig - 60), Red) ' q2 plot
        Call cpset(x, (p2 * scalebig - 160), Red) ' p2 plot
    Else
        If (cyclic = 1) Then
            iterations = 0
            Paint (1, 1), _RGBA(0, 0, 0, 100)
            Call DrawAxes
        Else
            Exit Do
        End If
    End If

    ' Phase portrait
    Call cpset((q1temp * (2 * scalebig) + (190 + (320 - _Width / 2))), (p1temp * (2 * scalebig) + 100), Yellow)
    Call cpset((q1 * (2 * scalebig) + (190 + (320 - _Width / 2))), (p1 * (2 * scalebig) + 100), Gray)
    Call cpset((q2temp * (2 * scalebig) + (190 + (320 - _Width / 2))), (p2temp * (2 * scalebig) + 100), Red)
    Call cpset((q2 * (2 * scalebig) + (190 + (320 - _Width / 2))), (p2 * (2 * scalebig) + 100), White)

    ' Position portrait
    Call cpset((q1temp * (2 * scalebig) + (190 + (320 - _Width / 2))), (q2temp * (2 * scalebig) - 100), Blue)
    Call cpset((q1 * (2 * scalebig) + (190 + (320 - _Width / 2))), (q2 * (2 * scalebig) - 100), White)

    ' System portrait - Requires 2x wide window.
    Select Case Val(Left$(problem$, 1))
        Case 4
            Call cline(160, 0, 220 + 20 * q1, 0, Green)
            Call cline(220 + 20 * q1, 0, 380 + 20 * q2, 0, Yellow)
            Call cline(380 + 20 * q2, 0, 440, 0, Green)
            Call ccircle(220 + 20 * q1temp, 0, 15, Black)
            Call ccircle(220 + 20 * q1, 0, 15, Blue)
            Call ccircle(380 + 20 * q2temp, 0, 15, Black)
            Call ccircle(380 + 20 * q2, 0, 15, Red)
        Case 5, 6, 7, 8
            Call cline(200, 0, 400, 0, White)
            Call cline(300, 0, 300 + 100 * Sin(q1temp), -100 * Cos(q1temp), Black)
            Call cline(300, 0, 300 + 100 * Sin(q1), -100 * Cos(q1), Blue)
    End Select

    iterations = iterations + 1

    '_DISPLAY
    '_Limit 1000

Loop Until InKey$ <> ""
Do: Loop Until InKey$ <> ""

End

Function ProblemPrompt$ (dummy As Integer)
    Dim p As String
    _KeyClear
    Cls
    Color White
    Print " Type a problem number and press ENTER."
    Print
    Print " PROBLEM"
    Print " 1) Particle in r^-1 central potential"
    Print "    a) Perturbed motion ......................... Stable, Symplectic"
    Print "    b) Elliptical motion ........................ Stable, Symplectic"
    Print "    c) Eccentric elliptical motion .............. Stable, Symplectic"
    Print " 2) Particle in r^-2 central potential"
    Print "    a) Attempted circular motion ................ Unstable, Symplectic"
    Print " 3) Mass on a spring"
    Print "    a) Initial Momentum ..........*Incorrect*.... Unstable, Euler"
    Print "    b) Initial Displacement ......*Incorrect*.... Unstable, Euler"
    Print " 4) Two equal masses connected by three springs"
    Print "    a) Symmetric mode ........................... Stable, Symplectic"
    Print "    b) Antisymmetric mode ....................... Stable, Symplectic"
    Print "    c) Perturbed motion ......................... Stable, Symplectic"
    Print " 5) Plane pendulum (Part I)"
    Print "    a) Initial Momentum ..........*Incorrect*.... Unstable, Euler"
    Print " 6) Plane pendulum (Part III)"
    Print "    a) Sub-critical case ........................ Stable, RK4"
    Print "    b) Over-critical case ....................... Stable, RK4"
    Print " 7) Plane pendulum (Part III)"
    Print "    a) Initial Displacement ..................... Stable, Symplectic"
    Print "    b) Sub-critical case ........................ Stable, Symplectic"
    Print "    c) Over-critical case ....................... Stable, Symplectic"
    Print " 8) Plane pendulum (Part IV)"
    Print "    a) Initial Displacement ..................... Stable, Mixed Euler"; ""
    Print
    Input " Enter a problem (ex. 1a): ", p
    p = LTrim$(RTrim$(LCase$(p)))
    ProblemPrompt = p
End Function

Sub DrawAxes
    Cls
    ' Axis for q1 plot
    Color White
    Locate 2, 3: Print "Generalized"
    Locate 3, 3: Print "Coordinates"
    Call cline(-_Width / 2 + 140, 160, -_Width / 2 + 400, 160, Gray)
    Color White: Locate 5, 3: Print "Position q1(t)"
    Color Gray: Locate 6, 3: Print "q1(0) ="; q10
    ' Axis for p1 plot
    Call cline(-_Width / 2 + 140, 60, -_Width / 2 + 400, 60, Gray)
    Color White: Locate 11, 3: Print "Momentum p1(t)"
    Color Gray: Locate 12, 3: Print "p1(0) ="; p10
    ' Axis for q2 plot
    Call cline(-_Width / 2 + 140, -60, -_Width / 2 + 400, -60, Gray)
    Color White: Locate 18, 3: Print "Position q2(t)"
    Color Gray: Locate 19, 3: Print "q2(0) ="; q20
    ' Axis for p2 plot
    Call cline(-_Width / 2 + 140, -160, -_Width / 2 + 400, -160, Gray)
    Color White: Locate 25, 3: Print "Momentum p2(t)"
    Color Gray: Locate 26, 3: Print "p2(0) ="; p20
    ' Axes for q & p plots
    Color White
    Locate 2, 60: Print "Phase and"
    Locate 3, 58: Print "Position Plots"
    Locate 4, 66: Print "p"
    Locate 10, 76: Print "q"
    Call cline((190 + (320 - _Width / 2)), 80 + 100, (190 + (320 - _Width / 2)), -80 + 100, Gray)
    Call cline((190 + (320 - _Width / 2)) - 100, 100, (190 + (320 - _Width / 2)) + 100, 100, Gray)
    Locate 17, 66: Print "q2"
    Locate 23, 75: Print "q1"
    Call cline((190 + (320 - _Width / 2)), -80 - 100, (190 + (320 - _Width / 2)), 80 - 100, Gray)
    Call cline((190 + (320 - _Width / 2)) - 100, -100, (190 + (320 - _Width / 2)) + 100, -100, Gray)
End Sub

Sub cline (x1, y1, x2, y2, col As _Unsigned Long)
    Line (_Width / 2 + x1, -y1 + _Height / 2)-(_Width / 2 + x2, -y2 + _Height / 2), col
End Sub

Sub ccircle (x1, y1, rad, col As _Unsigned Long)
    Circle (_Width / 2 + x1, -y1 + _Height / 2), rad, col
End Sub

Sub cpset (x1, y1, col As _Unsigned Long)
    PSet (_Width / 2 + x1, -y1 + _Height / 2), col
End Sub
