'Program details:
 
'ad 1:  SUB init - read text "Petr", which is writed to virtual screen and write every pixel position to array T.
'       array T contains pixels positions data, recalculated to 3D in the same way as OpenGL (X = minus values to left, plus values to right, zero is middle,
'       Y = minus values down, plus values up, zero in middle, Z values - visible from -1 to lower values)
'
' I see such a small reproach to myself in the definition of the T array. Next time I would write also new function, that would return a number
' indicating the real number used pixels, because is an unnecessary waste of memory and performance to write  DIM T (16*8) for one character, if this
' character use just 20 pixels.
 
'ad 2: (row 73 in source code): Program read array T. If in T is some record ( T().x >0 ) then is called SUB kostka. SUB kostka create cube in
'      coordinates X, Y, Z and use OpenGL coordinate system.
 
 
 
 
_TITLE "Next MAPTRIANGLE 3D demo"
 
k = _PI(2) / 4 'k is angle 360 / 4 in radians, for 4 cube corners (cube is double quad)
 
TYPE b
    x AS INTEGER
    y AS INTEGER
END TYPE
 
'------------
DIM SHARED texture AS LONG, rot
DIM i AS LONG
 
TYPE T
    x AS SINGLE
    y AS SINGLE
    z AS SINGLE
END TYPE
 
DIM SHARED T(14 * 110) AS T
 
init '                          SEE ad 1
'---------------------
 
 
 
SCREEN _NEWIMAGE(800, 600, 32)
CLS , _RGB32(127, 127, 188)
 
 
DIM B(3) AS b
 
 
B(0).x = -1: B(0).y = -1
B(1).x = 1: B(1).y = -1
B(2).x = -1: B(2).y = -1
B(3).x = 1: B(3).y = -1 '            B() are starting coordinates for cube in middle screen
 
w = _WIDTH(i)
h = _HEIGHT(i)
 
DO
    IF i THEN _FREEIMAGE i '         if exists hardware image (which contains clock), then free it from memory
    j = _NEWIMAGE(150, 100, 32) '    create software image (handle j)
    _DEST j
    CLS , _RGBA32(0, 50, 127, 100)
    clock 0, 0 '                    draw new clock image, which contains current system time to software image (handle j)
    _DEST 0
    '                               copy software image j as hardware image i and then delete software image j
    i = _COPYIMAGE(j, 33)
    _FREEIMAGE j
 
    clock 0, 0 '                    as you see, here you are in DEST 0. Clocks is now paint to screen to left corner (coordinates 0,0)
 
    texture& = i '                  set i handle as texture& handle
    '--------------------
 
    FOR Ys = 0 TO 17 '                            SEE ad 2
        zz2 = zz2 + .01
        FOR Xs = 0 TO 50
            IF T(i4).x > 0 THEN
                X = T(i4).x + 70
                Y = T(i4).y
                z = T(i4).z - 70
                kostka X - zz2, Y, z - 15 + zz2
            END IF
            i4 = i4 + 1
    NEXT Xs, Ys
    i4 = 0
    IF zz2 > 140 THEN zz2 = -50
    '-----------------------------
 
    Sx = 0
    Sz = -2.5
    Sy = -1
 
 
    Rx = 1
    Ry = -1
    Rz = 1
    ' info for rotation. To rotate the bodies, you must have all the points that are rotating in the same center. For this demo, it is easy to specify the radius of rotation,
    ' because all the points are just as far from the center as the cube is a symmetrical body. But if you want to write a 3D game, then if you want to write with MAPTRIANGLE,
    ' you need to map the floor using 4 triangles and calculate the radius for the points on the edges using the Pythagoras theorem:
    '
    '       A--------------------------B     x is your position, as you see, all points use different radius
    '       I\\\                   Y / I     Y is your triangle side 1, next is floor height - Y
    '       I   \\\\\\             Y/  I     X is your triangle side 2, next is floor width - X
    '       I          \\\\\\\\/// xXXXI     third sides calculate using Pythagoras.
    '       I       ////////////    \  I
    '       I //////                 \ I
    '       C--------------------------D
    '
    x1 = Sx + SIN(rot) * Rx: z1 = Sz + COS(rot) * Rz: y1R = Sy + SIN(rot) * Ry
    x2 = Sx + SIN(rot + k) * Rx: z2 = Sz + COS(rot + k) * Rz: y2R = Sy + SIN(rot + k) * Ry
 
    x4 = Sx + SIN((2 * k) + rot) * Rx: z4 = Sz + COS((2 * k) + rot) * Rz: y3R = Sy + SIN((3 * k) + rot) * Ry
    x3 = Sx + SIN((3 * k) + rot) * Rx: z3 = Sz + COS((3 * k) + rot) * Rz: y4R = Sy + SIN((4 * k) + rot) * Ry
 
    y1 = B(0).y
    y2 = B(1).y
    y4 = B(2).y
    y3 = B(3).y
 
 
 
 
    y5 = y1 + 1.5
    y6 = y2 + 1.5
    y7 = y3 + 1.5
    y8 = y4 + 1.5
 
 
    _MAPTRIANGLE (0, h)-(w, h)-(0, 0), i TO(x1, y1, z1)-(x2, y2, z2)-(x3, y3, z3) 'podlaha                 floor
    _MAPTRIANGLE (w, h)-(0, 0)-(w, 0), i TO(x2, y2, z2)-(x3, y3, z3)-(x4, y4, z4) 'podlaha
 
 
    _MAPTRIANGLE (0, h)-(w, h)-(0, 0), i TO(x1, y5, z1)-(x2, y6, z2)-(x3, y7, z3) 'strop                   roof
    _MAPTRIANGLE (w, h)-(0, 0)-(w, 0), i TO(x2, y6, z2)-(x3, y7, z3)-(x4, y8, z4) 'strop
 
    _MAPTRIANGLE (0, h)-(w, h)-(0, 0), i TO(x1, y1, z1)-(x2, y2, z2)-(x1, y5, z1) 'prava stena             right wall
    _MAPTRIANGLE (w, h)-(0, 0)-(w, 0), i TO(x2, y2, z2)-(x1, y5, z1)-(x2, y6, z2) 'prava stena
 
 
    _MAPTRIANGLE (w, h)-(0, h)-(w, 0), i TO(x3, y3, z3)-(x4, y4, z4)-(x3, y7, z3) 'leva stena              left wall
    _MAPTRIANGLE (0, h)-(w, 0)-(0, 0), i TO(x4, y4, z4)-(x3, y7, z3)-(x4, y8, z4) 'leva stena
 
 
    _MAPTRIANGLE (w, h)-(0, h)-(w, 0), i TO(x1, y1, z1)-(x3, y3, z3)-(x1, y5, z1) 'zadni stena             back wall
    _MAPTRIANGLE (0, h)-(w, 0)-(0, 0), i TO(x3, y3, z3)-(x1, y5, z1)-(x3, y7, z3) 'zadni stena
 
 
    _MAPTRIANGLE (0, h)-(w, h)-(0, 0), i TO(x2, y2, z2)-(x4, y4, z4)-(x2, y6, z2) 'predni stena            front wall
    _MAPTRIANGLE (w, h)-(0, 0)-(w, 0), i TO(x4, y4, z4)-(x2, y6, z2)-(x4, y8, z4) 'zadni stena
 
 
    _DISPLAY
    _LIMIT 50
 
    rot = rot + .01
LOOP
 
SUB kostka (x, y, z) 'zadavas levy horni predni roh ,udela kostku v zadane x,y,z                         x y z are coordinates for left upper corner, do cube on this place
 
 
    W = _WIDTH(texture&)
    H = _HEIGHT(texture&)
 
    '                g                       h                                e                  f
    MAPQUAD x + -1.5, y + 1.5, z + -1.5, x + .5, y + 1.5, z + -1.5, x + -1.5, y + -.5, z + -1.5, x + .5, y + -.5, z - 1.5, texture&
    MAPQUAD x + -1, y + 1, z + -1, x + 1, y + 1, z + -1, x + -1.5, y + 1.5, z + -1.5, x + .5, y + 1.5, z + -1.5, texture&
    MAPQUAD x + -1.5, y + -.5, z + -1.5, x + .5, y + -.5, z - 1.5, x + -1, y + -1, z + -1, x + 1, y - 1, z - 1, texture& '
    MAPQUAD x + -1, y + 1, z + -1, x + -1.5, y + 1.5, z + -1.5, x + -1, y + -1, z + -1, x + -1.5, y + -.5, z + -1.5, texture&
    MAPQUAD x + .5, y + 1.5, z + -1.5, x + .5, y + -.5, z - 1.5, x + 1, y - 1, z - 1, x + 1, y + 1, z + -1, texture&
    '                a                     b                    c                       d
    MAPQUAD x + -1, y + 1, z + -1, x + 1, y + 1, z + -1, x + -1, y + -1, z + -1, x + 1, y - 1, z - 1, texture&
 
END SUB
 
 
 
 
SUB MAPQUAD (x1, y1, z1, x2, y2, z2, x3, y3, z3, x4, y4, z4, texture AS LONG)
    W = _WIDTH(texture&)
    H = _HEIGHT(texture&)
 
    _MAPTRIANGLE (0, 0)-(W, 0)-(0, H), texture& TO(x1, y1, z1)-(x2, y2, z2)-(x3, y3, z3)
    _MAPTRIANGLE (W, 0)-(0, H)-(W, H), texture& TO(x2, y2, z2)-(x3, y3, z3)-(x4, y4, z4)
END SUB
 
SUB init
    text$ = " Petr" 'width = 32 pixels (records)
 
    virtual& = _NEWIMAGE(100, 100, 256)
    _DEST virtual&
    PRINT text$
    _SOURCE virtual&
    i = 0
    FOR Y = 17 TO 0 STEP -1
        FOR X = 0 TO 50
            IF POINT(X, Y) <> 0 THEN
                T(i).x = (-8.5 + X)
                T(i).y = -18 + (16 - Y) * 2
                T(i).z = -5 - X '                      this shift cubes in space consecutively. One pixel = One cube.
            END IF
            i = i + 1
    NEXT X, Y
    _DEST 0: _SOURCE 0: _FREEIMAGE virtual&
    i = 0
END SUB
 
 
SUB clock (x, y) '                                     This sub draw software image contains clock
    de = _DEST
    clocka& = _NEWIMAGE(100, 100, 32)
    _DEST clocka&
    vterina = VAL(RIGHT$(TIME$, 2))
    hodina = VAL(LEFT$(TIME$, 2))
    minuta = VAL(MID$(TIME$, 4, 2))
 
    IF hodina > 12 THEN hodina = hodina - 12
    hodina = hodina + (1 / 59) * minuta
 
 
    vt = vterina + 45
    ho = hodina + 45
    mi = minuta + 45
 
    pozicevterina = _PI(2) / 60 * vt
    poziceminuta = _PI(2) / 60 * ho * 5
    pozicehodina = _PI(2) / 60 * mi
 
    xs = 50 + COS(pozicevterina) * 30
    ys = 50 + SIN(pozicevterina) * 30
 
    xm = 50 + COS(poziceminuta) * 35
    ym = 50 + SIN(poziceminuta) * 35
 
    xh = 50 + COS(pozicehodina) * 40
    yh = 50 + SIN(pozicehodina) * 40
 
    FOR n = 1 TO 100
        LINE (n, 0)-(n, 99), _RGB32(127 - n, n, 27 + n), BF
    NEXT n
    LINE (0, 0)-(99, 99), _RGB32(255, 255, 255), B
 
    COLOR _RGBA32(127, 127, 127, 150)
    _PRINTMODE _KEEPBACKGROUND
    _PRINTSTRING (35, 45), "QB64"
    COLOR _RGB32(255, 255, 255)
 
 
    LINE (50, 50)-(xh, yh), _RGB32(255, 255, 0)
    LINE (50, 50)-(xm, ym), _RGB32(255, 255, 0)
    LINE (50, 50)-(xs, ys), _RGB32(0, 255, 255)
    m = 0
    FOR kruh = 0 TO _PI(2) STEP _PI(2) / 60
        PSET (50 + COS(kruh) * 47, 50 + SIN(kruh) * 47)
        IF m MOD 5 = 0 THEN LINE (50 + COS(kruh) * 47, 50 + SIN(kruh) * 47)-(50 + COS(kruh) * 44, 50 + SIN(kruh) * 44), , BF
        m = m + 1
    NEXT kruh
    _DEST de
    _SETALPHA 100, , clocka&
    _PUTIMAGE (x, y), clocka&, de
    _FREEIMAGE clocka&
END SUB
 