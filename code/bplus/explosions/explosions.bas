'https://qb64.boards.net/thread/98/explosions
Option _Explicit
_Title "Explosions test" 'b+ revisit 2023-02-08

Const xmax = 800, ymax = 600
Screen _NewImage(xmax, ymax, 32)
_ScreenMove (1280 - xmax) / 2 + 30, (760 - ymax) / 2
Randomize Timer
Type particle ' ===================================== Explosions Setup
    As Long life, death
    As Single x, y, dx, dy, r
    As _Unsigned Long c
End Type

Dim Shared nDots
nDots = 2000
ReDim Shared dots(nDots) As particle ' ==============================
Dim As Long mx, my, mb

Do
    Cls
    While _MouseInput: Wend
    mx = _MouseX: my = _MouseY: mb = _MouseButton(1)
    Circle (mx, my), 5
    If mb Then
        ' explode sets up dots and runs them out over several loops
        Explode mx, my, 150, 120, 60, 30
        Circle (mx, my), 150
        _Display
        _Delay .2 ' alittle delay for user to release mousebutton
    End If
    DrawDots
    _Display
    _Limit 30 ' or 60
Loop
Print "done"

' This sub sets up Dots array to display with DrawDots
' this sub uses rndCW and requires some setup in main
Sub Explode (x, y, spread, cr, cg, cb)
    ' x, y explosion origin
    ' spread is diameter of area to cover from it number of dots, number of frames and speed are calculated
    ' cr, cg, cb for _RGB32() color +-20

    ' setup for explosions in main
    'Type particle ' ===================================== Explosions Setup
    '    As Long life, death
    '    As Single x, y, dx, dy, r
    '    As _Unsigned Long c
    'End Type

    'Dim Shared nDots
    'nDots = 2000
    'ReDim Shared dots(nDots) As particle ' ==============================

    Dim As Long i, dotCount, newDots
    Dim angle, speed, rd, rAve, frames
    newDots = spread / 2 ' quota
    frames = spread / 5
    speed = spread / frames ' 0 to spread in frames
    rAve = .5 * spread / Sqr(newDots)
    For i = 1 To nDots ' find next available dot
        If dots(i).life = 0 Then
            dots(i).life = 1 ' turn on display
            dots(i).death = frames
            angle = _Pi(2 * Rnd)
            dots(i).x = x: dots(i).y = y ' origin
            rd = Rnd
            dots(i).dx = rd * speed * Cos(angle) ' moving
            dots(i).dy = rd * speed * Sin(angle)
            dots(i).r = RndCW(rAve, rAve) ' radius
            dots(i).c = _RGB32(cr + Rnd * 40 - 20, cg + Rnd * 40 - 20, cb + Rnd * 40 - 20) 'color
            dotCount = dotCount + 1
            If dotCount >= newDots Then Exit Sub
        End If
    Next
End Sub

' this sub uses FCirc and requires some setup in main
Sub DrawDots ' this sub needs fcirc to Fill Circles and Sub Explode sets up the Dots to draw.
    ' setup in main for explosions
    'Type particle ' ===================================== Explosions Setup
    '    As Long life, death
    '    As Single x, y, dx, dy, r
    '    As _Unsigned Long c
    'End Type

    'Dim Shared nDots
    'nDots = 2000
    'ReDim Shared dots(nDots) As particle ' ==============================

    Dim As Long i
    For i = 1 To nDots ' display of living particles
        If dots(i).life Then
            FCirc dots(i).x, dots(i).y, dots(i).r, dots(i).c
            ' update dot
            If dots(i).life + 1 >= dots(i).death Then
                dots(i).life = 0
            Else
                dots(i).life = dots(i).life + 1
                ' might want air resistence or gravity added to dx or dy
                dots(i).x = dots(i).x + dots(i).dx
                dots(i).y = dots(i).y + dots(i).dy
                If dots(i).x < 0 Or dots(i).x > xmax Then dots(i).life = 0
                If dots(i).y < 0 Or dots(i).y > ymax Then dots(i).life = 0
                dots(i).r = dots(i).r * 1 - (dots(i).life / dots(i).death) ' puff!
                If dots(i).r <= 0 Then dots(i).life = 0
            End If
        End If
    Next
End Sub

'from Steve Gold standard
Sub FCirc (CX As Integer, CY As Integer, R As Integer, C As _Unsigned Long)
    Dim Radius As Integer, RadiusError As Integer
    Dim X As Integer, Y As Integer
    Radius = Abs(R): RadiusError = -Radius: X = Radius: Y = 0
    If Radius = 0 Then PSet (CX, CY), C: Exit Sub
    Line (CX - X, CY)-(CX + X, CY), C, BF
    While X > Y
        RadiusError = RadiusError + Y * 2 + 1
        If RadiusError >= 0 Then
            If X <> Y + 1 Then
                Line (CX - Y, CY - X)-(CX + Y, CY - X), C, BF
                Line (CX - Y, CY + X)-(CX + Y, CY + X), C, BF
            End If
            X = X - 1
            RadiusError = RadiusError - X * 2
        End If
        Y = Y + 1
        Line (CX - X, CY - Y)-(CX + X, CY - Y), C, BF
        Line (CX - X, CY + Y)-(CX + X, CY + Y), C, BF
    Wend
End Sub

Function RndCW (C As Single, range As Single) 'center +/-range weights to center
    RndCW = C + Rnd * range - Rnd * range
End Function
