'Antoni Gual raycaster
'Modified from Entropy's an 36-lines entry for the Biskbart's
'40-lines QB Raycaster Compo of fall-2001
'
'Added multikey handler
'Step emulation
'Added different textures, including clouds
'Separe
'with some of my ideas

'to do:
'   add screen buffer
'   optimize rendering loop
'   interpolate rays
'   shadowing
'   subpixel precision
'   make it a game???

$NoPrefix
DefLng A-Z
Option Explicit
Option ExplicitArray

$Resize:Smooth
Screen 13
FullScreen SquarePixels , Smooth

Dim map(9, 9) As Integer 'the map
Dim tex(31, 31, 4) As Integer 'texture array
Dim foff(15) As Integer 'walk simulation vertical offset
Dim kbd(128) As Integer 'keyboard reader array
Dim frames As Long
Dim persplut(200) As Single 'vertical offsets for roof and floor
Dim d1(319) As Integer 'temporal arrays raycaster->renderer
Dim d2(319) As Integer
Dim tx(319) As Integer
Dim tm(319) As Integer
Dim dx(319) As Single
Dim dy(319) As Single

Dim As Long i, j, i1, j1, d1, d, d2

'read map,do fixed part of persp lut (sky is always in the infinite)
For i = 0 To 99
    Read map(i \ 10, i Mod 10)
    persplut(i) = 25590 / (i - 100)
Next

'make texture maps (should be read from file)
For i = 0 To 31
    For j = 0 To 31
        tex(i, j, 0) = (i Xor j) 'xor walls
        i1 = i - 16
        j1 = j - 16
        tex(i, j, 1) = Sqr((i1 * i1) + (j1 * j1)) 'concentric ground tiles
        tex(i, j, 2) = 16 - Sqr((i1 * i1) + (j1 * j1))
    Next
Next

'cloudy texture 1
d1 = 64
d = 32
tex(0, 0, 3) = 32
While d > 1
    d2 = d \ 2
    For i = 0 To 31 Step d
        For j = 0 To 31 Step d
            tex((i + d2) And 31, j, 3) = (tex(i, j, 3) + tex((i + d) And 31, j, 3) + (Rnd - .5) * d1) / 2
            tex(i, (j + d2) And 31, 3) = (tex(i, j, 3) + tex(i, (j + d) And 31, 3) + (Rnd - .5) * d1) / 2
            tex((i + d2) And 31, (j + d2) And 31, 3) = (tex(i, j, 3) + tex((i + d) And 31, (j + d) And 31, 3) + (Rnd - .5) * d1) / 2
        Next
    Next
    d1 = d1 / 2
    d = d2
Wend

'cloudy texture for sky
d1 = 64
d = 32
tex(0, 0, 4) = 32
While d > 1
    d2 = d \ 2
    For i = 0 To 31 Step d
        For j = 0 To 31 Step d
            tex((i + d2) And 31, j, 4) = (tex(i, j, 4) + tex((i + d) And 31, j, 4) + (Rnd - .5) * d1) / 2
            tex(i, (j + d2) And 31, 4) = (tex(i, j, 4) + tex(i, (j + d) And 31, 4) + (Rnd - .5) * d1) / 2
            tex((i + d2) And 31, (j + d2) And 31, 4) = (tex(i, j, 4) + tex((i + d) And 31, (j + d) And 31, 4) + (Rnd - .5) * d1) / 2
        Next
    Next
    d1 = d1 / 2
    d = d2
Wend

Dim pioct As Single

'fill step-simulation vertical offset
pioct! = Pi / 8!
For i = 0 To 15
    foff(i) = Abs(Cos(i * pioct!) * 64)
Next


'set palette
Out &H3C8, 0
'grey:walls
For i = 0 To 63
    Out &H3C9, i: Out &H3C9, i: Out &H3C9, i
Next
'green:ground
For i = 0 To 63
    Out &H3C9, 0: Out &H3C9, 63 - i: Out &H3C9, 0
Next
'blue:sky
For i = 0 To 63
    Out &H3C9, 63 - i / 2: Out &H3C9, 63 - i / 2: Out &H3C9, 63
Next

'launch raytracer
'erase key buffer and set num lock off
Def Seg = &H40: Poke &H1C, Peek(&H1A): Poke &H17, Peek(&H17) And Not 32

Dim tim As Single
tim! = Timer

Dim As Long ini, k, turn, mov, f, foff, y, x, sdx, sdy, xm, ym, md1, md2, tx, d21, p, mmap, tt
Dim As Single rtf, rtl, inf, incu, xpos, ypos, angle, xpos2, ypos2, calc, dxc, dxs, dyc, dys
Dim As Single xpos32, xp1, ypos32, yp1, dx, dy, nextxt, dxt, nextyt, dyt, ti, pl

frames = 0


'SUB raytrace
rtf = 2048
rtl = .0001
inf = 3000000
incu = .05
xpos = 1.5
ypos = 1.5
angle = 0
ini = 1
'frames loop
Do

    Wait &H3DA, 8
    Wait &H3DA, 8, 8

    frames = frames + 1

    'keyboard input
    k = Inp(&H60):
    If k Then
        kbd(k And 127) = -((k And 128) = 0)
        Def Seg = &H40: Poke &H1C, Peek(&H1A)
        If kbd(1) Then GoTo EXITDO1
        turn = kbd(&H4D) - kbd(&H4B): kbd(&H4D) = 0: kbd(&H4B) = 0
        mov = kbd(80) - kbd(72) + ini
    End If
    'a movement has happened, update and collision detect
    If turn Or mov Then
        angle = angle + turn * .1
        xpos2 = mov * Cos(angle) * incu
        ypos2 = mov * Sin(angle) * incu

        'calculate walk offsets,and floor part of perspective
        f = f + mov
        foff = foff(f And 15)
        calc = 25600 - 32 * foff
        For y = 100 To 199: persplut(y) = calc / (y - 99): Next

        If ini Then ini = 0
        dxc = Cos(angle) * incu
        dxs = Sin(angle) * incu / 160
        dyc = Cos(angle) * incu / 160
        dys = Sin(angle) * incu
        'colision detector

        If map(Int(ypos - incu), Int(xpos - xpos2 - xpos2 - incu)) = 0 Then
            If map(Int(ypos - incu), Int(xpos - xpos2 - xpos2 + incu)) = 0 Then
                If map(Int(ypos + incu), Int(xpos - xpos2 - xpos2 - incu)) = 0 Then
                    If map(Int(ypos + incu), Int(xpos - xpos2 - xpos2 + incu)) = 0 Then
                        xpos = xpos - xpos2
                        xpos32 = xpos * 32
                        xp1! = (xpos - Int(xpos)) * rtf
                    End If
                End If
            End If
        End If
        If map(Int(ypos - ypos2 - ypos2 - incu), Int(xpos - incu)) = 0 Then
            If map(Int(ypos - ypos2 - ypos2 + incu), Int(xpos - incu)) = 0 Then
                If map(Int(ypos - ypos2 - ypos2 - incu), Int(xpos + incu)) = 0 Then
                    If map(Int(ypos - ypos2 - ypos2 + incu), Int(xpos + incu)) = 0 Then
                        ypos = ypos - ypos2
                        ypos32 = ypos * 32
                        yp1! = (ypos - Int(ypos)) * rtf
                    End If
                End If
            End If
        End If


        'raycast loop
        For x = 0 To 319
            'INIT RAYCASTER
            dx = dxc - (x - 160) * dxs
            dy = (x - 160) * dyc + dys
            dx(x) = dx
            dy(x) = dy
            Select Case dx
                Case Is < -rtl
                    nextxt = -xp1! / dx
                    dxt = -rtf / dx
                Case Is > rtl
                    nextxt = (rtf - xp1!) / dx
                    dxt = rtf / dx
                Case Else
                    nextxt = inf
            End Select
            Select Case dy
                Case Is < -rtl
                    nextyt = -yp1! / dy
                    dyt = -rtf / dy
                Case Is > rtl
                    nextyt = (rtf - yp1!) / dy
                    dyt = rtf / dy
                Case Else
                    nextyt = inf
            End Select
            sdx = Sgn(dx): sdy = Sgn(dy)
            xm = Int(xpos): ym = Int(ypos)

            'cast a ray and increase distance  until a wall is hit
            Do
                If nextxt < nextyt Then

                    xm = xm + sdx
                    If map(ym, xm) Then ti = rtf / nextxt: GoTo exitdo2
                    nextxt = nextxt + dxt
                Else
                    'ny% = ny% + 1
                    ym = ym + sdy
                    If map(ym, xm) Then ti = rtf / nextyt: GoTo exitdo2
                    nextyt = nextyt + dyt
                End If
            Loop
            exitdo2:
            'Enter texture index, top, bottom into table for this direction

            tm(x) = map(ym, xm) Mod 5
            d1 = 99 - Int((800 + foff) * ti)
            If d1 > md1 Then md1 = d1
            d1(x) = d1
            d2 = 102 + Int((800 - foff) * ti)
            d2(x) = d2
            If d2 < md2 Then md2 = d2
            tx(x) = ((xpos + ypos + (dx + dy) / ti) * 32) And 31

        Next
    End If

    'rendering  loop (too many products and divisions)

    Def Seg = &HA000
    For x = 0 To 319
        d1 = d1(x)
        d2 = d2(x)
        tx = tx(x)
        d21 = d2 - d1
        dx = dx(x)
        dy = dy(x)
        p = x
        mmap = tm(x)
        For y = 0 To 199
            pl = persplut(y)
            Select Case y
                'sky
                Case Is < d1
                    tt = 128 + tex(dx * pl And 31, dy * pl And 31, 4)
                    'wall
                Case Is < d2
                    tt = 10 + tex(32 * (y - d1) \ d21, tx, mmap)
                    'ground
                Case Else
                    tt = 56 + tex((xpos32 + dx * pl) And 31, (ypos32 + dy * pl) And 31, 4)
            End Select
            Poke p&, tt
            p& = p& + 320
        Next
    Next
Loop
EXITDO1:

Dim a As String
Color 12
Locate 1, 1: Print frames / (Timer - tim!); " fps"
a = Input$(1)
End

'map data
Data 7,8,7,8,7,8,7,8,7,8
Data 7,0,0,0,0,0,0,0,0,8
Data 8,0,9,1,0,2,10,2,0,7
Data 7,0,1,9,0,0,0,10,0,8
Data 8,0,0,0,0,0,0,0,0,7
Data 7,0,3,11,3,11,0,0,0,8
Data 8,0,11,0,0,3,0,0,0,7
Data 7,0,3,0,0,11,0,0,0,8
Data 8,0,0,0,0,0,0,0,0,7
Data 8,7,8,7,8,7,8,7,8,8

