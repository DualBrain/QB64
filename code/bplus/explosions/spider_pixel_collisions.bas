'https://qb64.boards.net/thread/90/pixel-collision-app
Option _Explicit
_Title "Spider Pixel Collisions" 'b+ 2023-01-23    !!! Speaker volume around 20 maybe! !!!

' !!!!!!!!!!!!!!!!!!!          Escape to Quit         !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

Randomize Timer
Dim Shared xmax As Integer, ymax As Integer
xmax = _DesktopWidth
ymax = _DesktopHeight
Const nSpinners = 30
Type SpinnerType
    x As Single
    y As Single
    dx As Single
    dy As Single
    a As Single
    sz As Single
    c As _Unsigned Long
End Type
Dim Shared s(1 To nSpinners) As SpinnerType

Type TypeSPRITE '             sprite definition        ' for Terry's PixelCollide +++++++++++++++++++
    image As Long '           sprite image
    x1 As Integer '           upper left X
    y1 As Integer '           upper left Y
    x2 As Integer '           lower right X
    y2 As Integer '           lower right Y
End Type

Type TypePOINT '              x,y point definition
    x As Integer '            x coordinate
    y As Integer '            y coordinate
End Type '   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Dim power1, power2, power
Dim As Long i, imoved, j, iImg, jImg, lc, i2, sc
Dim As TypeSPRITE sIo, sJo
Dim intxy As TypePOINT
sc = _ScreenImage
Screen _NewImage(xmax, ymax, 32)
_FullScreen
For i = 1 To nSpinners
    newSpinner i
Next
i2 = 1
While InKey$ <> Chr$(27)
    _PutImage , sc, 0
    lc = lc + 1
    If lc Mod 100 = 99 Then
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
        sIo.x1 = s(i).x - 70
        sIo.y1 = s(i).y - 70
        sIo.x2 = sIo.x1 + 140
        sIo.y2 = sIo.y1 + 140 ' this meets requirements for collision obj1
        sIo.image = iImg ' ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

        s(i).a = _Atan2(s(i).dy, s(i).dx)
        power1 = (s(i).dx ^ 2 + s(i).dy ^ 2) ^ .5
        imoved = 0
        For j = i + 1 To i2

            ' max sz = .75 which needs 140 x 140 image square +++++++++++++++++++++
            jImg = _NewImage(140, 140, 32)
            _Dest jImg
            drawSpinner jImg, 70, 70, s(j).sz, _Atan2(s(j).dy, s(j).dx), s(j).c
            _Dest 0
            sJo.x1 = s(j).x - 70
            sJo.y1 = s(j).y - 70
            sJo.x2 = sIo.x1 + 140
            sJo.y2 = sIo.y1 + 140 ' this meets requirements for collision obj1
            sJo.image = jImg

            'PixelCollide (Obj1 As TypeSPRITE, Obj2 As TypeSPRITE, Intersect As TypePOINT)
            If PixelCollide(sIo, sJo, intxy) Then '+++++++++++++++++++++++++++++++++++++++
                '_SndPlay bump
                Sound Rnd * 5000 + 1000, .1 * Rnd
                If Rnd > .7 Then
                    imoved = 1
                    s(i).a = _Atan2(s(i).y - s(j).y, s(i).x - s(j).x)
                    s(j).a = _Atan2(s(j).y - s(i).y, s(j).x - s(i).x)
                    'update new dx, dy for i and j balls
                    power2 = (s(j).dy ^ 2 + s(j).dy ^ 2) ^ .5
                    power = (power1 + power2) / 2
                    s(i).dx = power * Cos(s(i).a)
                    s(i).dy = power * Sin(s(i).a)
                    s(j).dx = power * Cos(s(j).a)
                    s(j).dy = power * Sin(s(j).a)
                    s(i).x = s(i).x + s(i).dx
                    s(i).y = s(i).y + s(i).dy
                    s(j).x = s(j).x + s(j).dx
                    s(j).y = s(j).y + s(j).dy
                    Exit For
                End If
            End If
            _FreeImage jImg
        Next
        If imoved = 0 Then
            s(i).x = s(i).x + s(i).dx
            s(i).y = s(i).y + s(i).dy
        End If
        If s(i).x < -100 Or s(i).x > xmax + 100 Or s(i).y < -100 Or s(i).y > ymax + 100 Then newSpinner i
        'drawSpinner s(i).x, s(i).y, s(i).sz, _Atan2(s(i).dy, s(i).dx), s(i).c
        _PutImage (s(i).x - 70, s(i).y - 70), iImg, 0
        _FreeImage iImg
    Next
    _Display
    _Limit 15
Wend

Sub newSpinner (i As Integer) 'set Spinners dimensions start angles, color?
    Dim r
    s(i).sz = Rnd * .25 + .5
    If Rnd < .5 Then r = -1 Else r = 1
    s(i).dx = (s(i).sz * Rnd * 8) * r * 2 + 2: s(i).dy = (s(i).sz * Rnd * 8) * r * 2 + 2
    r = Int(Rnd * 4)
    Select Case r
        Case 0: s(i).x = Rnd * (xmax - 120) + 60: s(i).y = 0: If s(i).dy < 0 Then s(i).dy = -s(i).dy
        Case 1: s(i).x = Rnd * (xmax - 120) + 60: s(i).y = ymax: If s(i).dy > 0 Then s(i).dy = -s(i).dy
        Case 2: s(i).x = 0: s(i).y = Rnd * (ymax - 120) + 60: If s(i).dx < 0 Then s(i).dx = -s(i).dx
        Case 3: s(i).x = xmax: s(i).y = Rnd * (ymax - 120) + 60: If s(i).dx > 0 Then s(i).dx = -s(i).dx
    End Select
    r = Rnd * 155 + 40
    s(i).c = _RGB32(Rnd * .5 * r, r, Rnd * .25 * r)
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
    Dim max As Integer, mx2 As Integer, i As Integer, j As Integer, k As Single, lasti As Single, lastj As Single
    Dim prc As _Unsigned Long, tef As Long
    prc = _RGB32(255, 255, 255, 255)
    If a > b Then max = a + 1 Else max = b + 1
    mx2 = max + max
    tef = _NewImage(mx2, mx2)
    _Dest tef
    _Source tef 'point wont read without this!
    For k = 0 To 6.2832 + .05 Step .1
        i = max + a * Cos(k) * Cos(ang) + b * Sin(k) * Sin(ang)
        j = max + a * Cos(k) * Sin(ang) - b * Sin(k) * Cos(ang)
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
        If xleft(y) <> mx2 Then Line (xleft(y) + x0 - max, y + y0 - max)-(xright(y) + x0 - max, y + y0 - max), c, BF
    Next
    _FreeImage tef
End Sub

Function PixelCollide (Obj1 As TypeSPRITE, Obj2 As TypeSPRITE, Intersect As TypePOINT)
    '--------------------------------------------------------------------------------------------------------
    '- Checks for pixel perfect collision between two rectangular areas. -
    '- Returns -1 if in collision                                        -
    '- Returns  0 if no collision                                        -
    '-                                                                   -
    '- obj1 - rectangle 1 coordinates                                    -
    '- obj2 - rectangle 2 coordinates                                    -
    '---------------------------------------------------------------------
    Dim x%, y%
    Dim x1%, y1% ' upper left x,y coordinate of rectangular collision area
    Dim x2%, y2% ' lower right x,y coordinate of rectangular collision area
    Dim Test1& '   overlap image 1 to test for collision
    Dim Test2& '   overlap image 2 to test for collision
    Dim Hit% '     -1 (TRUE) if a collision occurs, 0 (FALSE) otherwise
    Dim Osource& ' original source image handle
    Dim p1~& '     alpha value of pixel on image 1
    Dim p2~& '     alpha value of pixel on image 2

    Obj1.x2 = Obj1.x1 + _Width(Obj1.image) - 1 '  calculate lower right x,y coordinates of both objects
    Obj1.y2 = Obj1.y1 + _Height(Obj1.image) - 1
    Obj2.x2 = Obj2.x1 + _Width(Obj2.image) - 1
    Obj2.y2 = Obj2.y1 + _Height(Obj2.image) - 1
    Hit% = 0 '                                    assume no collision

    '+-------------------------------------+
    '| perform rectangular collision check |
    '+-------------------------------------+

    If Obj1.x2 >= Obj2.x1 Then '                  rect 1 lower right X >= rect 2 upper left  X ?
        If Obj1.x1 <= Obj2.x2 Then '              rect 1 upper left  X <= rect 2 lower right X ?
            If Obj1.y2 >= Obj2.y1 Then '          rect 1 lower right Y >= rect 2 upper left  Y ?
                If Obj1.y1 <= Obj2.y2 Then '      rect 1 upper left  Y <= rect 2 lower right Y ?

                    '+-----------------------------------------------------------------------+
                    '| rectangular collision detected, perform pixel perfect collision check |
                    '+-----------------------------------------------------------------------+

                    If Obj2.x1 <= Obj1.x1 Then x1% = Obj1.x1 Else x1% = Obj2.x1 '        calculate overlapping coordinates
                    If Obj2.y1 <= Obj1.y1 Then y1% = Obj1.y1 Else y1% = Obj2.y1
                    If Obj2.x2 <= Obj1.x2 Then x2% = Obj2.x2 Else x2% = Obj1.x2
                    If Obj2.y2 <= Obj1.y2 Then y2% = Obj2.y2 Else y2% = Obj1.y2
                    Test1& = _NewImage(x2% - x1% + 1, y2% - y1% + 1, 32) '               make overlap image of object 1
                    Test2& = _NewImage(x2% - x1% + 1, y2% - y1% + 1, 32) '               make overlap image of object 2
                    _PutImage (-(x1% - Obj1.x1), -(y1% - Obj1.y1)), Obj1.image, Test1& ' place overlap area of object 1
                    _PutImage (-(x1% - Obj2.x1), -(y1% - Obj2.y1)), Obj2.image, Test2& ' place overlap area of object 2
                    x% = 0 '                                                             reset overlap area coordinate counters
                    y% = 0
                    Osource& = _Source '                                                 remember calling source
                    Do '                                                                 begin pixel collide loop
                        _Source Test1& '                                                 read from image 1
                        p1~& = _Alpha32(Point(x%, y%)) '                                 get alpha level of pixel
                        _Source Test2& '                                                 read from image 2
                        p2~& = _Alpha32(Point(x%, y%)) '                                 get alpha level of pixel
                        If (p1~& <> 0) And (p2~& <> 0) Then '                            are both pixels transparent?
                            Hit% = -1 '                                                  no, there must be a collision
                            Intersect.x = x1% + x% '                                     return collision coordinates
                            Intersect.y = y1% + y% '
                        End If
                        x% = x% + 1 '                                                    increment column counter
                        If x% > _Width(Test1&) - 1 Then '                                beyond last column?
                            x% = 0 '                                                     yes, reset x
                            y% = y% + 1 '                                                increment row counter
                        End If
                    Loop Until y% > _Height(Test1&) - 1 Or Hit% '                        leave when last row or collision detected
                    _Source Osource& '                                                   restore calling source
                    _FreeImage Test1& '                                                  remove temporary image from RAM
                    _FreeImage Test2&
                End If
            End If
        End If
    End If
    PixelCollide = Hit% '                                                                return result of collision check

End Function
