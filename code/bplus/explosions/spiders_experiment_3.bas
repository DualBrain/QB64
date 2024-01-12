'https://qb64.boards.net/thread/98/explosions

Option _Explicit
_Title "Spiders with Box and Pixel Collisions Experiment 3" 'b+ 2023-01-30/31
' 2023-02-08 Another experiment in handling Spider collisions,
' At collision, explosion!
' Tweaked number of spiders, speeds, colors and sizes and sound if collide

' !!!!!!!!!!!!!!!!!!!          Escape to Quit         !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

'                 !!! Speaker volume around 20 maybe! !!!

Randomize Timer
Dim Shared xmax As Integer, ymax As Integer
xmax = _DesktopWidth
ymax = _DesktopHeight
Const nSpinners = 40
Type SpinnerType
    As Single x, y, dx, dy, sz
    c As _Unsigned Long
End Type
Dim Shared s(1 To nSpinners) As SpinnerType

Type boxType ' for PixelCollison&
    As Long img, x, y, w, h
    c As _Unsigned Long
End Type

Type particle 'setup for explosions =======================================
    As Long life, death
    As Single x, y, dx, dy, r
    As _Unsigned Long c
End Type

Dim Shared nDots
nDots = 2000
ReDim Shared dots(nDots) As particle '=====================================


Dim As Long i, j, iImg, jImg, lc, i2, sc, intx, inty
Dim As boxType sIo, sJo

sc = _ScreenImage
Screen _NewImage(xmax, ymax, 32)
'_ScreenMove 0, 0
_FullScreen
For i = 1 To nSpinners
    newSpinner i
Next
i2 = 1
While InKey$ <> Chr$(27)
    '_Title Str$(i2) + " spiders"     ' when testing spider speeds
    _PutImage , sc, 0
    lc = lc + 1
    If lc Mod 50 = 49 Then
        lc = 0
        If i2 < nSpinners Then i2 = i2 + 1
    End If
    For i = 1 To i2

        'ready for collision check

        ' max sz = .75 which needs 140 x 140 image square  +++++++++++++++++++++++++
        iImg = _NewImage(140, 140, 32)
        _Dest iImg
        drawSpinner iImg, 70, 70, s(i).sz, _Atan2(s(i).dy, s(i).dx), s(i).c
        _Dest 0
        sIo.x = s(i).x - 70
        sIo.y = s(i).y - 70
        sIo.w = 140
        sIo.h = 140 ' this meets requirements for collision obj1
        sIo.img = iImg ' ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

        For j = i + 1 To i2
            ' max sz = .75 which needs 140 x 140 image square +++++++++++++++++++++
            jImg = _NewImage(140, 140, 32)
            _Dest jImg
            drawSpinner jImg, 70, 70, s(j).sz, _Atan2(s(j).dy, s(j).dx), s(j).c
            _Dest 0
            sJo.x = s(j).x - 70
            sJo.y = s(j).y - 70
            sJo.w = 140
            sJo.h = 140 ' this meets requirements for collision obj1
            sJo.img = jImg
            If PixelCollision&(sIo, sJo, intx, inty) Then '+++++++++++++++++++++++++++++++++++++++
                Sound Rnd * 7000 + 400, .05
                explode s(i).x, s(i).y, 150 * s(i).sz, 200, 200, 200
                newSpinner i
                's(i).x = s(i).x + s(i).dx + rndCW(0, 3.5)
                's(i).y = s(i).y + s(i).dy + rndCW(0, 3.5)
                's(j).x = s(j).x + s(j).dx + rndCW(0, 3.5)
                's(j).y = s(j).y + s(j).dy + rndCW(0, 3.5)
                Exit For
            End If
            _FreeImage jImg
        Next
        s(i).x = s(i).x + s(i).dx + rndCW(0, 3.5)
        s(i).y = s(i).y + s(i).dy + rndCW(0, 3.5)
        If s(i).x < -100 Or s(i).x > xmax + 100 Or s(i).y < -100 Or s(i).y > ymax + 100 Then newSpinner i
        _PutImage (s(i).x - 70, s(i).y - 70), iImg, 0
        _FreeImage iImg
    Next
    drawDots
    _Display
    _Limit 30
Wend

Sub newSpinner (i As Integer) 'set Spinners dimensions start angles, color?
    Dim r
    s(i).sz = rndCW(.5, .25) ' * .55 + .2
    If Rnd < .5 Then r = -1 Else r = 1
    s(i).dx = (s(i).sz * Rnd * 8 + 1) * r * 2: s(i).dy = (s(i).sz * Rnd * 8 + 1) * r * 2
    r = Int(Rnd * 4)
    Select Case r
        Case 0: s(i).x = Rnd * (xmax - 120) + 60: s(i).y = 0: If s(i).dy < 0 Then s(i).dy = -s(i).dy
        Case 1: s(i).x = Rnd * (xmax - 120) + 60: s(i).y = ymax: If s(i).dy > 0 Then s(i).dy = -s(i).dy
        Case 2: s(i).x = 0: s(i).y = Rnd * (ymax - 120) + 60: If s(i).dx < 0 Then s(i).dx = -s(i).dx
        Case 3: s(i).x = xmax: s(i).y = Rnd * (ymax - 120) + 60: If s(i).dx > 0 Then s(i).dx = -s(i).dx
    End Select
    r = Rnd * 80 + 40
    s(i).c = _RGB32(r, 20 + rndCW(.5 * r, 15), 10 + rndCW(.25 * r, 10))
End Sub

Sub drawSpinner (idest&, x As Integer, y As Integer, scale As Single, heading As Single, c As _Unsigned Long)
    Dim x1, x2, x3, x4, y1, y2, y3, y4, r, a, a1, a2, lg, d, rd, red, blue, green
    Static switch As Integer
    switch = switch + 2
    switch = switch Mod 16 + 1
    red = _Red32(c): green = _Green32(c): blue = _Blue32(c)
    r = 10 * scale
    x1 = x + r * Cos(heading): y1 = y + r * Sin(heading)
    r = 2 * r 'lg lengths
    For lg = 1 To 8
        If lg < 5 Then
            a = heading + .9 * lg * _Pi(1 / 5) + (lg = switch) * _Pi(1 / 10)
        Else
            a = heading - .9 * (lg - 4) * _Pi(1 / 5) - (lg = switch) * _Pi(1 / 10)
        End If
        x2 = x1 + r * Cos(a): y2 = y1 + r * Sin(a)
        drawLink idest&, x1, y1, 3 * scale, x2, y2, 2 * scale, _RGB32(red + 20, green + 10, blue + 5)
        If lg = 1 Or lg = 2 Or lg = 7 Or lg = 8 Then d = -1 Else d = 1
        a1 = a + d * _Pi(1 / 12)
        x3 = x2 + r * 1.5 * Cos(a1): y3 = y2 + r * 1.5 * Sin(a1)
        drawLink idest&, x2, y2, 2 * scale, x3, y3, scale, _RGB32(red + 35, green + 17, blue + 8)
        rd = Int(Rnd * 8) + 1
        a2 = a1 + d * _Pi(1 / 8) * rd / 8
        x4 = x3 + r * 1.5 * Cos(a2): y4 = y3 + r * 1.5 * Sin(a2)
        drawLink idest&, x3, y3, scale, x4, y4, scale, _RGB32(red + 50, green + 25, blue + 12)
    Next
    r = r * .5
    fcirc x1, y1, r, _RGB32(red - 20, green - 10, blue - 5)
    x2 = x1 + (r + 1) * Cos(heading - _Pi(1 / 12)): y2 = y1 + (r + 1) * Sin(heading - _Pi(1 / 12))
    fcirc x2, y2, r * .2, &HFF000000
    x2 = x1 + (r + 1) * Cos(heading + _Pi(1 / 12)): y2 = y1 + (r + 1) * Sin(heading + _Pi(1 / 12))
    fcirc x2, y2, r * .2, &HFF000000
    r = r * 2
    x1 = x + r * .9 * Cos(heading + _Pi): y1 = y + r * .9 * Sin(heading + _Pi)
    TiltedEllipseFill idest&, x1, y1, r, .7 * r, heading + _Pi, _RGB32(red, green, blue)
End Sub

Sub drawLink (idest&, x1, y1, r1, x2, y2, r2, c As _Unsigned Long)
    Dim a, a1, a2, x3, x4, x5, x6, y3, y4, y5, y6
    a = _Atan2(y2 - y1, x2 - x1)
    a1 = a + _Pi(1 / 2)
    a2 = a - _Pi(1 / 2)
    x3 = x1 + r1 * Cos(a1): y3 = y1 + r1 * Sin(a1)
    x4 = x1 + r1 * Cos(a2): y4 = y1 + r1 * Sin(a2)
    x5 = x2 + r2 * Cos(a1): y5 = y2 + r2 * Sin(a1)
    x6 = x2 + r2 * Cos(a2): y6 = y2 + r2 * Sin(a2)
    fquad idest&, x3, y3, x4, y4, x5, y5, x6, y6, c
    fcirc x1, y1, r1, c
    fcirc x2, y2, r2, c
End Sub

'need 4 non linear points (not all on 1 line) list them clockwise so x2, y2 is opposite of x4, y4
Sub fquad (idest&, x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer, x3 As Integer, y3 As Integer, x4 As Integer, y4 As Integer, c As _Unsigned Long)
    ftri idest&, x1, y1, x2, y2, x4, y4, c
    ftri idest&, x3, y3, x4, y4, x1, y1, c
End Sub

Sub ftri (idest&, x1, y1, x2, y2, x3, y3, K As _Unsigned Long)
    Dim a&
    a& = _NewImage(1, 1, 32)
    _Dest a&
    PSet (0, 0), K
    _Dest idest&
    _MapTriangle _Seamless(0, 0)-(0, 0)-(0, 0), a& To(x1, y1)-(x2, y2)-(x3, y3)
    _FreeImage a& '<<< this is important!
End Sub

Sub fcirc (CX As Integer, CY As Integer, R As Integer, C As _Unsigned Long)
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

Sub TiltedEllipseFill (destHandle&, x0, y0, a, b, ang, c As _Unsigned Long)
    Dim TEmax As Integer, mx2 As Integer, i As Integer, j As Integer, k As Single, lasti As Single, lastj As Single
    Dim prc As _Unsigned Long, tef As Long
    prc = _RGB32(255, 255, 255, 255)
    If a > b Then TEmax = a + 1 Else TEmax = b + 1
    mx2 = TEmax + TEmax
    tef = _NewImage(mx2, mx2)
    _Dest tef
    _Source tef 'point wont read without this!
    For k = 0 To 6.2832 + .05 Step .1
        i = TEmax + a * Cos(k) * Cos(ang) + b * Sin(k) * Sin(ang)
        j = TEmax + a * Cos(k) * Sin(ang) - b * Sin(k) * Cos(ang)
        If k <> 0 Then
            Line (lasti, lastj)-(i, j), prc
        Else
            PSet (i, j), prc
        End If
        lasti = i: lastj = j
    Next
    Dim xleft(mx2) As Integer, xright(mx2) As Integer, x As Integer, y As Integer
    For y = 0 To mx2
        x = 0
        While Point(x, y) <> prc And x < mx2
            x = x + 1
        Wend
        xleft(y) = x
        While Point(x, y) = prc And x < mx2
            x = x + 1
        Wend
        While Point(x, y) <> prc And x < mx2
            x = x + 1
        Wend
        If x = mx2 Then xright(y) = xleft(y) Else xright(y) = x
    Next
    _Dest destHandle&
    For y = 0 To mx2
        If xleft(y) <> mx2 Then Line (xleft(y) + x0 - TEmax, y + y0 - TEmax)-(xright(y) + x0 - TEmax, y + y0 - TEmax), c, BF
    Next
    _FreeImage tef
End Sub

Function BoxCollision% (b1x, b1y, b1w, b1h, b2x, b2y, b2w, b2h)
    ' x, y represent the box left most x and top most y
    ' w, h represent the box width and height which is the usual way sprites / tiles / images are described
    ' such that boxbottom = by + bh
    '        and boxright = bx + bw

    If (b1y + b1h < b2y) Or (b1y > b2y + b2h) Or (b1x > b2x + b2w) Or (b1x + b1w < b2x) Then
        BoxCollision% = 0
    Else
        BoxCollision% = -1
    End If
End Function

' this needs max, min functions as well as BoxCollision%
Sub Intersect2Boxes (b1x, b1y, b1w, b1h, b2x, b2y, b2w, b2h, bix As Long, biy As Long, biw As Long, bih As Long)
    If b2x >= b1x And b2x <= b1x + b1w And b2y >= b1y And b2y <= b1y + b1h Then 'top left corner in 2nd box
        bix = b2x: biy = b2y
        If b2x + b2w <= b1x + b1w Then biw = b2w Else biw = b1x + b1w - b2x
        If b2y + b2h <= b1y + b1h Then bih = b2h Else bih = b1y + b1h - b2y
    ElseIf b2x >= b1x And b2x <= b1x + b1w And b2y + b2h >= b1y And b2y + b2h <= b1y + b1h Then 'bottom left corner of 2nd box in first
        bix = b2x
        If b2x + b2w <= b1x + b1w Then biw = b2w Else biw = b1x + b1w - b2x
        If b2y <= b1y Then biy = b1y: bih = b2y + b2h - b1y Else biy = b2y: bih = b2h
    ElseIf b2x + b2w >= b1x And b2x + b2w <= b1x + b1w And b2y >= b1y And b2y <= b1y + b1h Then 'right top corner 2nd box in first
        If b2x >= b1x Then bix = b2x: biw = b2w Else bix = b1x: biw = b2x + b2w - b1x
        biy = b2y
        If b2y + b2h <= b1y + b1h Then bih = b2h Else bih = b1y + b1h - b2y
    ElseIf b2x + b2w >= b1x And b2x + b2w <= b1x + b1w And b2y + b2h >= b1y And b2y + b2h <= b1y + b1h Then 'left bottom corners in first box
        If b2x >= b1x Then bix = b2x: biw = b2w Else bix = b1x: biw = b2x + b2w - b1x
        If b2y >= b1y Then biy = b2y: bih = b2h Else biy = b1y: bih = b2y + b2h - b1y
    ElseIf BoxCollision%(b1x, b1y, b1w, b1h, b2x, b2y, b2w, b2h) Then
        bix = max(b1x, b2x): biy = max(b1y, b2y)
        biw = min(b1x + b1w, b2x + b2w) - bix: bih = min(b1y + b1h, b2y + b2h) - biy
    Else 'no intersect
        bix = -1: biy = -1: biw = 0: bih = 0
    End If
End Sub

Function max (a, b)
    If a > b Then max = a Else max = b
End Function

Function min (a, b)
    If a < b Then min = a Else min = b
End Function

' this sub needs Intersect2Boxes which uses  max, min, and BoxCollision Functions
Function PixelCollision& (img1 As boxType, img2 As boxType, intx As Long, inty As Long)
    ' boxType here needs at least an x, y, w, h and img
    Dim As Long x, y, ix, iy, iw, ih
    Dim As _Unsigned Long p1, p2
    intx = -1: inty = -1 ' no collision set
    Intersect2Boxes img1.x, img1.y, img1.w, img1.h, img2.x, img2.y, img2.w, img2.h, ix, iy, iw, ih
    If ix <> -1 Then ' the boxes intersect
        y = iy: x = ix
        Do
            _Source img1.img
            p1 = Point(x - img1.x, y - img1.y) ' point minus img x, y location = location in image I hope
            _Source img2.img
            p2 = Point(x - img2.x, y - img2.y)
            If (p1 <> 0) And (p2 <> 0) Then
                PixelCollision& = -1: intx = x: inty = y: Exit Function
            End If
            If (x + 1) > (ix + iw - 1) Then ' get rid of 2 slow For Loops
                x = ix: y = y + 1
                If y >= (iy + ih - 1) Then
                    _Source 0: Exit Function
                Else
                    y = y + 1
                End If
            Else
                x = x + 1
            End If
        Loop
    End If
End Function

Function rndCW (C As Single, range As Single) 'center +/-range weights to center
    rndCW = C + Rnd * range - Rnd * range
End Function

' explode sets up old dead particles for display for a life
' This sub sets up Dots to display with DrawDots
Sub explode (x, y, spread, cr, cg, cb)
    ' x, y explosion origin
    ' spread is diameter of area to cover from it number of dots, number of frames and speed are calculated

    ' setup
    'Type particle
    '    As Long life, death
    '    As Single x, y, dx, dy, r
    '    As _Unsigned Long c
    'End Type

    'Dim Shared nDots
    'nDots = 2000
    'ReDim Shared dots(nDots) As particle

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
            dots(i).r = rndCW(rAve, rAve) ' radius
            dots(i).c = _RGB32(cr + Rnd * 40 - 20, cg + Rnd * 40 - 20, cb + Rnd * 40 - 20) 'color
            dotCount = dotCount + 1
            If dotCount >= newDots Then Exit Sub
        End If
    Next
End Sub

Sub drawDots ' this sub needs fcirc to Fill Circles and Sub Explode sets up the Dots to draw.
    ' setup in main
    'Type particle
    '    As Long life, death
    '    As Single x, y, dx, dy, r
    '    As _Unsigned Long c
    'End Type

    'Dim Shared nDots
    'nDots = 2000
    'ReDim Shared dots(nDots) As particle

    Dim As Long i
    For i = 1 To nDots ' display of living particles
        If dots(i).life Then
            fcirc dots(i).x, dots(i).y, dots(i).r, dots(i).c
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


