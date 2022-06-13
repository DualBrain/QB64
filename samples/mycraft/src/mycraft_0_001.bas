CONST MaxVis& = 15 'how many squares away you can see (warning: massive performance implications at this stage)
CONST HardwareOnly& = 1 'set to 1 to disable the software "SCREEN" (you will lose PRINTed debugging output but will get performance gains)

IF _DIREXISTS("mycraft") THEN CHDIR "mycraft"
IF _DIREXISTS("blocks") = 0 OR _DIREXISTS("items") = 0 THEN
    PRINT "Could not locate resource files"
    END
END IF

DEFLNG A-Z
$RESIZE:ON
'$DYNAMIC

SCREEN _NEWIMAGE(1024, 600, 32)

'Generate Perlin Noise
'Modified from http://forum.qbasicnews.com/index.php?action=printpage;topic=3459.0
'-generates noise from 0 to 255
'-doesn't use x=0,y=0
'-noise tiles
DEFSNG A-Z
Iter = 8
BumpFactor = 1.2
CloudWidth% = 2 ^ Iter + 1
CloudHeight% = 2 ^ Iter + 1

DIM Cloud%(CloudWidth%, CloudHeight%)
DIM CloudBumpFactor(CloudWidth%, CloudHeight%) AS SINGLE
'1.5=undulating hills (mostly walkable, quite bumpy)
'2.0=ultra-flat
DIM CloudDirectionBias(CloudWidth%, CloudHeight%) AS SINGLE '-0.3 to 0.3
FOR x = 0 TO CloudWidth%
    FOR y = 0 TO CloudHeight%
        '1.3=perfect mountains
        '1.5=plains
        CloudBumpFactor(x, y) = 1.3 '1.4 '+ x * 0.002 '1.2 + x
    NEXT
NEXT
FOR x = 0 TO CloudWidth%
    FOR y = 0 TO CloudHeight%
        CloudDirectionBias(x, y) = 0 '0.3 'x * 0.0008 '1.1 + x * 0.004 '1.2 + x
    NEXT
NEXT
RANDOMIZE TIMER
T0 = TIMER
' Init the corners
Cloud%(1, 1) = 128
Cloud%(1, CloudHeight%) = 128
Cloud%(CloudWidth%, 1) = 128
Cloud%(CloudWidth%, CloudHeight%) = 128

' Init the edges
FOR Rank% = 1 TO Iter

    dx = 2 ^ (Iter - Rank% + 1)
    dy = 2 ^ (Iter - Rank% + 1)
    Nx% = 2 ^ (Rank% - 1) + 1
    Ny% = 2 ^ (Rank% - 1) + 1

    FOR kx = 1 TO Nx% - 1
        x% = (kx - 1) * dx + 1: y% = 1
        Alt% = (Cloud%(x%, y%) + Cloud%(x% + dx, y%)) / 2

        '        zNew% = Bump%(Alt%, Rank%, BumpFactor)
        zNew% = Bump%(Alt%, Rank%, CloudBumpFactor(x% + dx / 2, 1), CloudDirectionBias(x% + dx / 2, 1))

        Cloud%(x% + dx / 2, 1) = zNew%
        Cloud%(x% + dx / 2, CloudHeight%) = zNew%
    NEXT kx

    FOR ky = 1 TO Ny% - 1
        x% = 1: y% = (ky - 1) * dy + 1
        Alt% = (Cloud%(x%, y%) + Cloud%(x%, y% + dy)) / 2
        '        zNew% = Bump%(Alt%, Rank%, BumpFactor)
        zNew% = Bump%(Alt%, Rank%, CloudBumpFactor(1, y% + dy / 2), CloudDirectionBias(1, y% + dy / 2))


        Cloud%(1, y% + dy / 2) = zNew%
        Cloud%(CloudWidth%, y% + dy / 2) = zNew%
    NEXT ky

NEXT Rank%


' Fill the clouds
FOR Rank% = 1 TO Iter

    dx = 2 ^ (Iter - Rank% + 1): dy = dx
    Nx% = 2 ^ (Rank% - 1) + 1: Ny% = Nx%

    FOR kx = 1 TO Nx% - 1
        FOR ky = 1 TO Ny% - 1
            x% = (kx - 1) * dx + 1
            y% = (ky - 1) * dy + 1

            Alt% = (Cloud%(x%, y%) + Cloud%(x% + dx, y%) + Cloud%(x%, y% + dy) + Cloud%(x% + dx, y% + dy)) / 4
            Cloud%(x% + dx / 2, y% + dy / 2) = Bump%(Alt%, Rank%, CloudBumpFactor(x% + dx / 2, y% + dy / 2), CloudDirectionBias(x% + dx / 2, y% + dy / 2))
            Alt% = (Cloud%(x%, y%) + Cloud%(x% + dx, y%)) / 2
            IF y% <> 1 THEN Cloud%(x% + dx / 2, y%) = Bump%(Alt%, Rank%, CloudBumpFactor(x% + dx / 2, y%), CloudDirectionBias(x% + dx / 2, y%))
            Alt% = (Cloud%(x%, y%) + Cloud%(x%, y% + dy)) / 2
            IF x% <> 1 THEN Cloud%(x%, y% + dy / 2) = Bump%(Alt%, Rank%, CloudBumpFactor(x%, y% + dy / 2), CloudDirectionBias(x%, y% + dy / 2))
            Alt% = (Cloud%(x% + dx, y%) + Cloud%(x% + dx, y% + dy)) / 2
            IF (x% + dx) <> CloudWidth% THEN Cloud%(x% + dx, y% + dy / 2) = Bump%(Alt%, Rank%, CloudBumpFactor(x% + dx, y% + dy / 2), CloudDirectionBias(x% + dx, y% + dy / 2))
            Alt% = (Cloud%(x%, y% + dy) + Cloud%(x% + dx, y% + dy)) / 2
            IF (y% + dy) <> CloudHeight% THEN Cloud%(x% + dx / 2, y% + dy) = Bump%(Alt%, Rank%, CloudBumpFactor(x% + dx / 2, y% + dy), CloudDirectionBias(x% + dx / 2, y% + dy))

        NEXT ky
    NEXT kx

NEXT Rank%
dt = TIMER - T0
FOR x = 0 TO CloudWidth%
    FOR y = 0 TO CloudHeight%
        PSET (x, y), _RGB(Cloud%(x, y), 0, 0)
    NEXT
NEXT

DEFLNG A-Z

DIM SHARED MapLimitX AS LONG, MapLimitY AS LONG, MapLimitZ AS LONG
MapLimitX = CloudWidth% - 1: MapLimitY = CloudHeight% - 1: MapLimitZ = 100




DIM SHARED TexLast
TexLast = 0
DIM SHARED Tex(1000, 15, 3) AS LONG 'handle, brightness, hue-specific to time of day

DIM SHARED darken
darken = _NEWIMAGE(1, 1)
_DEST darken
_DONTBLEND
PSET (0, 0), _RGBA(0, 0, 0, 50)
_BLEND
_DEST 0


_MOUSEHIDE


DIM PX AS SINGLE
DIM PY AS SINGLE
DIM PZ AS SINGLE

DIM oPX AS SINGLE
DIM oPY AS SINGLE
DIM oPZ AS SINGLE

PZ = 70


'TYPE BoxType
'    left AS LONG
'    right AS LONG
'    top AS LONG
'    bottom AS LONG
'    front AS LONG
'    back AS LONG
'END TYPE

'DIM SHARED Box(1000) AS BoxType

'load textures
grass = LoadTexture("grass")
water = LoadTexture("water")

'I = 0
'I = I + 1

'h = grass
'Box(I).left = h
'Box(I).right = h
'Box(I).top = h
'Box(I).bottom = h
'Box(I).front = h
'Box(I).back = h



TYPE MapBlockType
    Typ AS LONG '0=air, 1=...
    Vis AS LONG
    Lit AS LONG 'light offset
END TYPE

DIM Blk(-1 TO MapLimitX + 1, -1 TO MapLimitY + 1, -1 TO MapLimitZ + 1) AS MapBlockType


'place bottom layer (a single layer of "rock" which cannot be crossed)
z = 0
FOR x = 0 TO MapLimitX
    FOR y = 0 TO MapLimitY
        Blk(x, y, z).Typ = 1: boxcount = boxcount + 1
    NEXT
NEXT


DIM GM(-1 TO MapLimitX + 1, -1 TO MapLimitY + 1)
'get GM
FOR x = 0 TO MapLimitX
    FOR y = 0 TO MapLimitY
        h = Cloud%(x + 1, y + 1) \ 4 + 30
        GM(x, y) = h
    NEXT
NEXT

FOR f = 5 TO 8
    'despeckle "pinacles"
    FOR x = 0 TO MapLimitX
        FOR y = 0 TO MapLimitY
            h = GM(x, y)
            c = 0
            c2 = 0
            FOR x2 = x - 1 TO x + 1
                FOR y2 = y - 1 TO y + 1
                    IF x2 <> x OR y2 <> y THEN
                        h2 = GM(x2, y2)
                        IF h2 < h THEN c = c + 1
                        IF h2 > h THEN c2 = c2 + 1
                    END IF
                NEXT
            NEXT
            IF c >= 5 THEN
                GM(x, y) = GM(x, y) - 1
                'END
                'GM(x, y) = 2
            END IF
            IF c2 >= 5 THEN
                GM(x, y) = GM(x, y) + 1
            END IF

        NEXT
    NEXT
NEXT

wl = 128 \ 4 + 30 - 3

'place "dirt"
FOR x = 0 TO MapLimitX
    FOR y = 0 TO MapLimitY
        zz = GM(x, y)
        FOR z = zz TO 1 STEP -1
            Blk(x, y, z).Typ = 1
        NEXT
    NEXT
NEXT

'place water


FOR x = 0 TO MapLimitX
    FOR y = 0 TO MapLimitY
        zz = GM(x, y)
        IF zz < wl THEN
            Blk(x, y, wl).Typ = 2
        END IF
    NEXT
NEXT


IF 1 = 0 THEN
    zrange = 10
    FOR basez = 1 TO MapLimitZ - zrange - 50
        FOR I = 1 TO (MapLimitX * MapLimitY) * 10

            x = INT(RND * (MapLimitX + 1))
            y = INT(RND * (MapLimitY + 1))
            z = basez + INT(RND * (10)) 'cannot replace lowest layer

            '''    IF Blk(x, y, z).Typ = 0 AND Blk(x, y, z - 1).Typ <> 0 THEN
            n = 0
            FOR z2 = z - 1 TO z + 1
                FOR y2 = y - 1 TO y + 1
                    FOR x2 = x - 1 TO x + 1
                        dist = ABS(x2 - x) + ABS(y2 - y) + ABS(z2 - z)
                        IF dist <= 2 THEN

                            x3 = x2: y3 = y2: z3 = z2
                            MapOffset x3, y3, z3
                            IF Blk(x3, y3, z3).Typ > 0 THEN
                                n = n + 1
                            END IF

                        END IF
                    NEXT
                NEXT
            NEXT

            IF n >= 3 THEN
                Blk(x, y, z).Typ = 1: boxcount = boxcount + 1
                IF z > highestz THEN highestz = z
            END IF


            '''END IF
        NEXT
    NEXT 'basez
    'fill map till top reached

END IF


'assess visibility

FOR z = 0 TO MapLimitZ
    FOR x = 0 TO MapLimitX
        FOR y = 0 TO MapLimitY
            IF Blk(x, y, z).Typ THEN
                visible = 0
                FOR x2 = x - 1 TO x + 1
                    IF Blk(x2, y, z).Typ <> 1 THEN visible = 1
                NEXT

                FOR y2 = y - 1 TO y + 1
                    IF Blk(x, y2, z).Typ <> 1 THEN visible = 1
                NEXT
                FOR z2 = z - 1 TO z + 1
                    IF Blk(x, y, z2).Typ <> 1 THEN visible = 1
                NEXT

                IF visible = 1 THEN
                    Blk(x, y, z).Vis = 1: viscount = viscount + 1
                END IF
            END IF
        NEXT
    NEXT
NEXT

'assess lighting offsets
FOR z = 0 TO MapLimitZ
    FOR x = 0 TO MapLimitX
        FOR y = 0 TO MapLimitY
            IF Blk(x, y, z).Vis THEN 'it is visible
                count = 0
                FOR z2 = z + 1 TO z + 5
                    FOR y2 = y - 1 TO y + 1
                        FOR x2 = x - 1 TO x + 1
                            IF Blk(x2, y2, z2).Typ <> 0 THEN count = count + 1
                        NEXT
                    NEXT
                NEXT
                IF count > 30 THEN count = 30
                Blk(x, y, z).Lit = -count / 2

            END IF
        NEXT
    NEXT
NEXT




DIM SHARED ax AS SINGLE, ay AS SINGLE
DIM SHARED SINax AS SINGLE
DIM SHARED COSax AS SINGLE
DIM SHARED SINay AS SINGLE
DIM SHARED COSay AS SINGLE


TYPE Point3D
    x AS SINGLE
    y AS SINGLE
    z AS SINGLE
END TYPE

TYPE TexturePoint3D
    p AS Point3D
    tx AS SINGLE
    ty AS SINGLE
END TYPE


TYPE Triangle3D
    p1 AS TexturePoint3D
    p2 AS TexturePoint3D
    p3 AS TexturePoint3D
    textureHandle AS LONG
END TYPE

TYPE Rect3D
    p1 AS TexturePoint3D
    p2 AS TexturePoint3D
    p3 AS TexturePoint3D
    p4 AS TexturePoint3D
    textureHandle AS LONG
END TYPE

DIM SHARED vert(1 TO 8) AS Point3D
DIM SHARED side(1 TO 6) AS Rect3D







zz = -10

IF HardwareOnly THEN
    _DISPLAYORDER _HARDWARE
    bgImage = _NEWIMAGE(1, 1, 32)
    _DEST bgImage
    PSET (0, 0), _RGB(180, 220, 255)
    _DEST 0
    bgImage = _COPYIMAGE(bgImage, 33)
END IF

DIM SHARED ETT AS DOUBLE
ETT = TIMER(0.001)
DIM SHARED ET AS SINGLE

DIM SHARED TOD AS SINGLE
TOD = 0

'gun32 = _LOADIMAGE("items\gun1.png", 32)
gun32 = _LOADIMAGE("items\sworddiamond.png", 32)
gun = _COPYIMAGE(gun32, 33)

'sets of vertexes for scaling/rotation/etc


DIM SHARED VertexSource AS LONG
DIM SHARED VertexCount AS LONG 'the number of vertices to apply an operation to
DIM SHARED VertexLast AS LONG
VertexLast = 0
DIM SHARED VertexX(1 TO 10000) AS SINGLE
DIM SHARED VertexY(1 TO 10000) AS SINGLE
DIM SHARED VertexZ(1 TO 10000) AS SINGLE
DIM SHARED VertexTX(1 TO 10000) AS SINGLE
DIM SHARED VertexTY(1 TO 10000) AS SINGLE

DIM SHARED TriangleSource AS LONG 'the base index of the first triangle's vertex

DIM SHARED TriangleLast AS LONG
TriangleLast = 0
DIM SHARED TriangleCount AS LONG 'the number of triangles to apply an operation to
DIM SHARED TriangleVertex(1 TO 10000) AS LONG

TYPE MODEL
    VertexCount AS LONG
    FirstVertex AS LONG
    FirstTriangle AS LONG
    TriangleCount AS LONG
END TYPE
DIM SHARED Model(1 TO 10000) AS MODEL



'add object
tex = gun
tx = _WIDTH(tex)
ty = _HEIGHT(tex)
p = VertexLast
t = TriangleLast
d = 1




'convert 2D image into a 3D object by giving it depth

'place image onto a canvas which has an extra unit on each size
tex = gun32
w = _WIDTH(tex)
h = _HEIGHT(tex)
I = _NEWIMAGE(w + 2, h + 2, 32)
_DONTBLEND I
_PUTIMAGE (1, 1), tex, I

_SOURCE I
_DEST I
DIM col AS LONG
FOR y = 1 TO h
    FOR x = 1 TO w
        col = POINT(x, y)
        alpha = _ALPHA(col)

        col2 = POINT(x, y - 1)
        alpha2 = _ALPHA(col2)

        IF alpha2 = 0 AND alpha <> 0 THEN


            x1 = x - 1
            y1 = y - 1




            bp = p

            t = t + 1: TriangleVertex(t) = bp + 1
            t = t + 1: TriangleVertex(t) = bp + 2
            t = t + 1: TriangleVertex(t) = bp + 3
            t = t + 1: TriangleVertex(t) = bp + 1
            t = t + 1: TriangleVertex(t) = bp + 3
            t = t + 1: TriangleVertex(t) = bp + 4

            p = p + 1: VertexX(p) = x1: VertexY(p) = -y1: VertexZ(p) = 0
            VertexTX(p) = x1: VertexTY(p) = y1
            p = p + 1: VertexX(p) = x1 + 1: VertexY(p) = -y1: VertexZ(p) = 0
            VertexTX(p) = x1: VertexTY(p) = y1
            p = p + 1: VertexX(p) = x1 + 1: VertexY(p) = -y1: VertexZ(p) = d
            VertexTX(p) = x1: VertexTY(p) = y1
            p = p + 1: VertexX(p) = x1: VertexY(p) = -y1: VertexZ(p) = d
            VertexTX(p) = x1: VertexTY(p) = y1


        END IF



        col2 = POINT(x - 1, y)
        alpha2 = _ALPHA(col2)

        IF alpha2 = 0 AND alpha <> 0 THEN

            x1 = x - 1
            y1 = y - 1




            bp = p

            t = t + 1: TriangleVertex(t) = bp + 1
            t = t + 1: TriangleVertex(t) = bp + 2
            t = t + 1: TriangleVertex(t) = bp + 3
            t = t + 1: TriangleVertex(t) = bp + 1
            t = t + 1: TriangleVertex(t) = bp + 3
            t = t + 1: TriangleVertex(t) = bp + 4

            p = p + 1: VertexX(p) = x1: VertexY(p) = -y1: VertexZ(p) = 0
            VertexTX(p) = x1: VertexTY(p) = y1
            p = p + 1: VertexX(p) = x1: VertexY(p) = -y1: VertexZ(p) = d
            VertexTX(p) = x1: VertexTY(p) = y1
            p = p + 1: VertexX(p) = x1: VertexY(p) = -y1 - 1: VertexZ(p) = d
            VertexTX(p) = x1: VertexTY(p) = y1
            p = p + 1: VertexX(p) = x1: VertexY(p) = -y1 - 1: VertexZ(p) = 0
            VertexTX(p) = x1: VertexTY(p) = y1

        END IF














    NEXT
NEXT

_SOURCE 0
_DEST 0

itemPicture = I








FOR oz = 0 TO d STEP d
    bp = p

    t = t + 1: TriangleVertex(t) = bp + 1
    t = t + 1: TriangleVertex(t) = bp + 2
    t = t + 1: TriangleVertex(t) = bp + 3
    t = t + 1: TriangleVertex(t) = bp + 1
    t = t + 1: TriangleVertex(t) = bp + 3
    t = t + 1: TriangleVertex(t) = bp + 4

    p = p + 1: VertexX(p) = 0: VertexY(p) = 0: VertexZ(p) = oz
    VertexTX(p) = -0.49: VertexTY(p) = -0.49
    p = p + 1: VertexX(p) = tx: VertexY(p) = 0: VertexZ(p) = oz
    VertexTX(p) = tx - 1 + 0.49: VertexTY(p) = -0.49
    p = p + 1: VertexX(p) = tx: VertexY(p) = -ty: VertexZ(p) = oz
    VertexTX(p) = tx - 1 + 0.49: VertexTY(p) = ty - 1 + 0.49
    p = p + 1: VertexX(p) = 0: VertexY(p) = -ty: VertexZ(p) = oz
    VertexTX(p) = -0.49: VertexTY(p) = ty - 1 + 0.49


NEXT


VertexCount = p - VertexLast
TriangleCount = (t - TriangleLast) \ 3


m = 1
Model(m).VertexCount = VertexCount
Model(m).FirstVertex = VertexLast + 1
Model(m).TriangleCount = TriangleCount
Model(m).FirstTriangle = TriangleLast + 1

VertexLast = p
TriangleLast = t



DO

    T# = TIMER(0.001)
    ET = T# - ETT
    ETT = T#

    TOD = TOD + ET
    IF TOD >= 24 THEN TOD = TOD - 24

    SINax = SIN(ax)
    COSax = COS(ax)
    SINay = SIN(ay)
    COSay = COS(ay)



    IF HardwareOnly THEN
        _PUTIMAGE (0, 0)-(_WIDTH - 1, _HEIGHT - 1), bgImage
    ELSE
        CLS , _RGB(180, 220, 255)
    END IF




    LOCATE 1, 1
    PRINT TOD

    PRINT boxcount, viscount

    PRINT zz




    RANDOMIZE TIMER 'USING 1


    OX = INT(PX)
    OY = INT(PY)
    oz = INT(PZ)

    PRINT PX, PY, PZ
    PRINT OX, OY, oz


    x = OX
    y = OY
    z = oz
    MapOffset x, y, z
    PRINT x, y, z, "!"

    _PUTIMAGE (0, 0), itemPicture

    nn = 0



    'opaque pass
    FOR mapz = oz + MaxVis TO oz - MaxVis STEP -1
        FOR mapx = OX - MaxVis TO OX + MaxVis
            FOR mapy = OY - MaxVis TO OY + MaxVis
                x = mapx
                y = mapy
                z = mapz
                MapOffset x, y, z
                IF Blk(x, y, z).Vis THEN
                    typ = Blk(x, y, z).Typ
                    IF typ = 1 THEN
                        DrawCube mapx - PX, mapz - PZ, mapy - PY, typ, Blk(x, y, z).Lit
                    END IF
                END IF
            NEXT
        NEXT
    NEXT

    'semi-tranparent pass
    '_DEPTHBUFFER LOCK
    FOR mapz = oz - MaxVis TO oz + MaxVis
        FOR mapx = OX - MaxVis TO OX + MaxVis
            FOR mapy = OY - MaxVis TO OY + MaxVis
                x = mapx
                y = mapy
                z = mapz
                MapOffset x, y, z
                IF Blk(x, y, z).Vis THEN
                    typ = Blk(x, y, z).Typ
                    IF typ = 2 THEN
                        DrawCube mapx - PX, mapz - PZ, mapy - PY, typ, Blk(x, y, z).Lit
                    END IF
                END IF
            NEXT
        NEXT
    NEXT



    'draw object(s)

    'preserve offsets of permanent content
    oldVertexLast = VertexLast
    oldTriangleLast = TriangleLast

    VertexSource = Model(1).FirstVertex
    TriangleSource = Model(1).FirstTriangle
    TriangleCount = Model(1).TriangleCount
    VertexCount = Model(1).VertexCount


    TriangleSource = TriangleLast + 1
    VertexSource = VertexLast + 1
    CopyModel (1)

    tex = gun

    'orient pointing forwards
    VertexRotateXZ_YZ -90, 0
    'scale
    VertexScale 0.1 * 0.7 * 2
    'move to right hand
    VertexTranslate 1, 0, -2 - 0.5

    'render the objects
    _DEPTHBUFFER _CLEAR
    _DEPTHBUFFER ON

    FOR t = TriangleSource TO TriangleSource + TriangleCount * 3 - 3 STEP 3
        p1 = TriangleVertex(t)
        p2 = TriangleVertex(t + 1)
        p3 = TriangleVertex(t + 2)
_maptriangle(    VertexTX(p1),    VertexTY(p1))-(    VertexTX(p2),    VertexTY(p2))-(    VertexTX(p3),    VertexTY(p3)), _
tex to _
(VertexX(p1),Vertexy(p1),Vertexz(p1))-(VertexX(p2),Vertexy(p2),Vertexz(p2))-(VertexX(p3),Vertexy(p3),Vertexz(p3))

    NEXT















    'move vertically
    ms! = .1
    IF _KEYDOWN(ASC("q")) THEN PZ = PZ + ms! * 4
    IF _KEYDOWN(ASC("z")) THEN PZ = PZ - ms! * 4

    oPX = PX: oPY = PY: oPZ = PZ

    DO
        k$ = INKEY$
        IF k$ = " " THEN 'jump (teleport up 2 squares)
            PZ = PZ + 2
        END IF
    LOOP UNTIL k$ = ""

    IF _KEYDOWN(ASC("w")) THEN 'walk forwards
        PX = PX + SIN(ax) * ms!
        PY = PY - COS(ax) * ms!
        'PZ = PZ + SIN(ay) * ms!
    END IF


    IF _KEYDOWN(ASC("s")) THEN 'walk backwards
        PX = PX - SIN(ax) * ms!
        PY = PY + COS(ax) * ms!
        'PZ = PZ - SIN(ay) * ms!
    END IF



    PZ = PZ - 1 * ms!

    x = INT(PX)
    y = INT(PY)
    z = INT(PZ)
    MapOffset x, y, z
    t = Blk(x, y, z).Typ
    IF t = 1 THEN
        '        PX = oPX
        '        PY = oPY
        '        PZ = oPZ
    END IF


    'calculate x/y/z dist to adjacent blocks

    'check z movement



    newpx! = PX
    newpy! = PY
    newpz! = PZ


    PX = oPX
    PY = oPY
    PZ = newpz!

    x = INT(PX)
    y = INT(PY)
    z = INT(PZ)

    ox! = PX - INT(PX)
    oy! = PY - INT(PY)
    oz! = PZ - INT(PZ)

    '    IF PX >= 0 THEN
    dx1! = ox!
    dx2! = 1 - ox!
    '    ELSE
    '   dx2! = ox!
    '  dx1! = 1 - ox!
    ' END IF

    '  IF PY >= 0 THEN
    dy1! = oy!
    dy2! = 1 - oy!
    '   ELSE
    '      dy2! = oy!
    '     dy1! = 1 - oy!
    'END IF

    ' IF PZ >= 0 THEN
    dz1! = oz!
    dz2! = 1 - oz!
    '  ELSE
    '  dz2! = oz!
    ' dz1! = 1 - oz!
    'END IF



    'PRINT
    'PRINT PX; PY; PZ
    'PRINT dx1!; dx2!; dy1!; dy2!; dz1!; dz2!;
    'PRINT

    FOR z2 = z - 1 TO z + 1

        relevant = 0
        IF z2 = z THEN relevant = 0 'if we are already in the square--too bad!

        'IF z2 <> z THEN
        'check z relevance
        '                   relvant = 0
        IF z2 < z AND dz1! < 0.4 THEN relevant = 1
        IF z2 > z AND dz2! < 0.4 THEN relevant = 1
        IF relevant THEN PRINT z2

        IF relevant THEN


            FOR y2 = y - 1 TO y + 1
                FOR x2 = x - 1 TO x + 1

                    dx = ABS(x2 - x)
                    dy = ABS(y2 - y)
                    relevant = 0
                    IF dx + dy THEN
                        'check if location should be checked
                        dx! = 0
                        IF x2 > x THEN dx! = dx2!
                        IF x2 < x THEN dx! = dx1!
                        dy! = 0
                        IF y2 > y THEN dy! = dy2!
                        IF y2 < y THEN dy! = dy1!
                        IF dx! < 0.4 AND dy! < 0.4 THEN
                            relevant = 1
                            PRINT "["; x2 - x; ","; y2 - y; "]";
                        END IF
                    ELSE
                        relevant = 1
                    END IF
                    'END IF

                    IF relevant THEN
                        x3 = x2: y3 = y2: z3 = z2
                        MapOffset x3, y3, z3
                        t2 = Blk(x3, y3, z3).Typ
                        IF t2 = 1 THEN
                            'PZ = oPZ
                            newpz! = oPZ

                        END IF
                    END IF
                NEXT
            NEXT

        END IF
    NEXT



































    PX = newpx!
    PY = oPY
    PZ = newpz!


    x = INT(PX)
    y = INT(PY)
    z = INT(PZ)

    ox! = PX - INT(PX)
    oy! = PY - INT(PY)
    oz! = PZ - INT(PZ)

    '    IF PX >= 0 THEN
    dx1! = ox!
    dx2! = 1 - ox!
    '    ELSE
    '   dx2! = ox!
    '  dx1! = 1 - ox!
    ' END IF

    '  IF PY >= 0 THEN
    dy1! = oy!
    dy2! = 1 - oy!
    '   ELSE
    '      dy2! = oy!
    '     dy1! = 1 - oy!
    'END IF

    ' IF PZ >= 0 THEN
    dz1! = oz!
    dz2! = 1 - oz!
    '  ELSE
    '  dz2! = oz!
    ' dz1! = 1 - oz!
    'END IF


    z2 = z

    FOR x2 = x - 1 TO x + 1
        relevant = 0
        IF x2 < x AND dx1! < 0.4 THEN relevant = 1
        IF x2 > x AND dx2! < 0.4 THEN relevant = 1
        IF relevant THEN


            FOR y2 = y - 1 TO y + 1
                FOR z2 = z - 1 TO z + 1

                    dy = ABS(y2 - y)
                    dz = ABS(z2 - z)

                    relevant = 0

                    IF dy + dz THEN
                        'check if location should be checked

                        dz! = 0
                        IF z2 > z THEN dz! = dz2!
                        IF z2 < z THEN dz! = dz1!

                        dy! = 0
                        IF y2 > y THEN dy! = dy2!
                        IF y2 < y THEN dy! = dy1!

                        IF dy! < 0.4 AND dz! < 0.4 THEN
                            relevant = 1
                        END IF


                    ELSE
                        relevant = 1
                    END IF

                    IF relevant THEN
                        x3 = x2: y3 = y2: z3 = z2
                        MapOffset x3, y3, z3
                        t2 = Blk(x3, y3, z3).Typ
                        IF t2 = 1 THEN
                            'PX = oPX
                            newpx! = oPX

                        END IF
                    END IF
                NEXT
            NEXT
        END IF
    NEXT



    PX = newpx!
    PY = newpy!
    PZ = newpz!

    x = INT(PX)
    y = INT(PY)
    z = INT(PZ)

    ox! = PX - INT(PX)
    oy! = PY - INT(PY)
    oz! = PZ - INT(PZ)

    '    IF PX >= 0 THEN
    dx1! = ox!
    dx2! = 1 - ox!
    '    ELSE
    '   dx2! = ox!
    '  dx1! = 1 - ox!
    ' END IF

    '  IF PY >= 0 THEN
    dy1! = oy!
    dy2! = 1 - oy!
    '   ELSE
    '      dy2! = oy!
    '     dy1! = 1 - oy!
    'END IF

    ' IF PZ >= 0 THEN
    dz1! = oz!
    dz2! = 1 - oz!
    '  ELSE
    '  dz2! = oz!
    ' dz1! = 1 - oz!
    'END IF


    z2 = z

    FOR y2 = y - 1 TO y + 1
        relevant = 0
        IF y2 < y AND dy1! < 0.4 THEN relevant = 1
        IF y2 > y AND dy2! < 0.4 THEN relevant = 1
        IF relevant THEN

            FOR z2 = z - 1 TO z + 1

                FOR x2 = x - 1 TO x + 1

                    dx = ABS(x2 - x)
                    dz = ABS(z2 - z)

                    relevant = 0
                    IF dx + dz THEN
                        'check if location should be checked

                        dz! = 0
                        IF z2 > z THEN dz! = dz2!
                        IF z2 < z THEN dz! = dz1!

                        dx! = 0
                        IF x2 > x THEN dx! = dx2!
                        IF x2 < x THEN dx! = dx1!

                        IF dx! < 0.4 AND dz! < 0.4 THEN
                            relevant = 1
                        END IF
                    ELSE
                        relevant = 1
                    END IF

                    IF relevant THEN
                        x3 = x2: y3 = y2: z3 = z2
                        MapOffset x3, y3, z3
                        t2 = Blk(x3, y3, z3).Typ
                        IF t2 = 1 THEN
                            '                        PY = oPY
                            newpy! = oPY

                        END IF
                    END IF
                NEXT
            NEXT
        END IF
    NEXT

    PX = newpx!
    PY = newpy!
    PZ = newpz!




    DO WHILE _MOUSEINPUT
        mmx = mmx + _MOUSEMOVEMENTX
        mmy = mmy + _MOUSEMOVEMENTY
    LOOP
    PRINT mmx, mmy

    ax = mmx / 100
    ay = -mmy / 400

    my = _MOUSEY
    MX = _MOUSEX

    _LIMIT 30
    _DISPLAY

    VertexLast = oldVertexLast
    TriangleLast = oldTriangleLast

    IF _RESIZE THEN
        oldscreen = _DEST
        SCREEN _NEWIMAGE(_RESIZEWIDTH, _RESIZEHEIGHT, 32)
        _FREEIMAGE oldscreen
    END IF

LOOP

SUB DrawCube (x AS SINGLE, y AS SINGLE, z AS SINGLE, typ AS LONG, lit AS LONG)


DEFSNG A-Z
DEFLNG I

size = 1

FOR i = 1 TO 8
    vert(i).x = x: vert(i).y = y: vert(i).z = z
    IF i > 4 THEN vert(i).y = vert(i).y + size
    IF i = 2 OR i = 3 OR i = 6 OR i = 7 THEN vert(i).x = vert(i).x + size
    IF i = 3 OR i = 4 OR i = 7 OR i = 8 THEN vert(i).z = vert(i).z + size
NEXT

'rotate verticies horizontally x/z
FOR i = 1 TO 8

    x = vert(i).x
    z = vert(i).z
    x2 = SINax * z + x * COSax
    z2 = COSax * z - SINax * x
    x = x2
    z = z2
    vert(i).x = x
    vert(i).z = z


    y = vert(i).y
    z = vert(i).z
    y2 = SINay * z + y * COSay
    z2 = COSay * z - SINay * y
    y = y2
    z = z2
    vert(i).y = y
    vert(i).z = z


NEXT

'base:
'1-2
'| |
'4-3
'top:
'5-6
'| |
'8-7

i = 0


'front
i = i + 1
side(i).p1.p = vert(8)
side(i).p2.p = vert(7)
side(i).p3.p = vert(3)
side(i).p4.p = vert(4)

'right
i = i + 1
side(i).p1.p = vert(7)
side(i).p2.p = vert(6)
side(i).p3.p = vert(2)
side(i).p4.p = vert(3)


'back
i = i + 1
side(i).p1.p = vert(6)
side(i).p2.p = vert(5)
side(i).p3.p = vert(1)
side(i).p4.p = vert(2)

'left
i = i + 1
side(i).p1.p = vert(5)
side(i).p2.p = vert(8)
side(i).p3.p = vert(4)
side(i).p4.p = vert(1)


'top
i = i + 1
side(i).p1.p = vert(5)
side(i).p2.p = vert(6)
side(i).p3.p = vert(7)
side(i).p4.p = vert(8)


'bottom
i = i + 1
side(i).p1.p = vert(4)
side(i).p2.p = vert(3)
side(i).p3.p = vert(2)
side(i).p4.p = vert(1)

b = 1
FOR i = 1 TO 6

    'IF i = 1 THEN t = Box(b).front
    'IF i = 2 THEN t = Box(b).right
    'IF i = 3 THEN t = Box(b).back
    'IF i = 4 THEN t = Box(b).left
    'IF i = 5 THEN t = Box(b).top
    'IF i = 6 THEN t = Box(b).bottom

    l = lit - i
    IF i = 5 THEN l = l + 5
    IF l < -15 THEN l = -15

    t = Tex(typ, 15 + l, 0)

    IF typ = 1 THEN
        _DONTBLEND t

        _MAPTRIANGLE _CLOCKWISE (0, 0)-(63, 0)-(63, 63), t TO(side(i).p1.p.x, side(i).p1.p.y, side(i).p1.p.z)-(side(i).p2.p.x, side(i).p2.p.y, side(i).p2.p.z)-(side(i).p3.p.x, side(i).p3.p.y, side(i).p3.p.z), , _SMOOTHSHRUNK
        _MAPTRIANGLE _CLOCKWISE (0, 0)-(63, 63)-(0, 63), t TO(side(i).p1.p.x, side(i).p1.p.y, side(i).p1.p.z)-(side(i).p3.p.x, side(i).p3.p.y, side(i).p3.p.z)-(side(i).p4.p.x, side(i).p4.p.y, side(i).p4.p.z), , _SMOOTHSHRUNK




    END IF

    IF (typ = 2 AND i = 5) THEN
        _BLEND t
        _MAPTRIANGLE (0, 0)-(63, 0)-(63, 63), t TO(side(i).p1.p.x, side(i).p1.p.y, side(i).p1.p.z)-(side(i).p2.p.x, side(i).p2.p.y, side(i).p2.p.z)-(side(i).p3.p.x, side(i).p3.p.y, side(i).p3.p.z), , _SMOOTHSHRUNK
        _MAPTRIANGLE (0, 0)-(63, 63)-(0, 63), t TO(side(i).p1.p.x, side(i).p1.p.y, side(i).p1.p.z)-(side(i).p3.p.x, side(i).p3.p.y, side(i).p3.p.z)-(side(i).p4.p.x, side(i).p4.p.y, side(i).p4.p.z), , _SMOOTHSHRUNK

    END IF


NEXT

DEFLNG A-Z
END SUB


FUNCTION LoadTexture (filename$)
TexLast = TexLast + 1
T = TexLast
path$ = "blocks\"
PRINT path$ + filename$ + ".png"
i = _LOADIMAGE(path$ + filename$ + ".png", 32)
i2 = _COPYIMAGE(i)
FOR l = 15 TO 0 STEP -1
    _PUTIMAGE , darken, i2
    FOR TOD = 0 TO 3 'time of day (will support sunrise & sunset)
        '_DEST i2
        'LOCATE 1, 1
        'PRINT l;
        'PRINT tod;
        _DEST 0
        Tex(T, l, TOD) = _COPYIMAGE(i2, 33)
    NEXT
NEXT
LoadTexture = TexLast
END FUNCTION

SUB MapOffset (x, y, z)
IF x >= 0 THEN
    x = x MOD (MapLimitX + 1)
ELSE
    x = ((MapLimitX + 1) - ((-x) * -1)) MOD (MapLimitX + 1)
END IF
IF y >= 0 THEN
    y = y MOD (MapLimitY + 1)
ELSE
    y = ((MapLimitY + 1) - ((-y) * -1)) MOD (MapLimitY + 1)
END IF
IF z < 0 THEN
    z = 0
END IF
IF z > MapLimitZ THEN
    z = MapLimitZ
END IF
END SUB



DEFSNG A-Z
FUNCTION Bump% (Alt%, Rank%, BumpFactor, Bias)

DO
    DO
        r = RND - .5 + Bias
    LOOP WHILE r < -.5 OR r > 0.5
    dAlt = r / (BumpFactor ^ Rank%) * Alt%
LOOP WHILE Alt% + dAlt < 0 OR Alt% + dAlt > 255

Bump% = INT(Alt% + dAlt)

END FUNCTION
DEFLNG A-Z


DEFSNG A-Z
SUB VertexTranslate (x, y, z)
DIM p AS LONG
FOR p = VertexSource TO VertexSource + VertexCount - 1
    VertexX(p) = VertexX(p) + x
    VertexY(p) = VertexY(p) + y
    VertexZ(p) = VertexZ(p) + z
NEXT
END SUB
DEFLNG A-Z


DEFSNG A-Z
SUB VertexScale (s)
DIM p AS LONG
FOR p = VertexSource TO VertexSource + VertexCount - 1
    VertexX(p) = VertexX(p) * s
    VertexY(p) = VertexY(p) * s
    VertexZ(p) = VertexZ(p) * s
NEXT
END SUB
DEFLNG A-Z

DEFSNG A-Z
'positive XZ/a1 is clockwise (when viewing from above)
'positive YZ/a2 is clockwise (when viewing from the right)
SUB VertexRotateXZ_YZ (a1, a2)
DIM p AS LONG

a1_rad = a1 * -0.0174532925
a1_sin = SIN(a1_rad): a1_cos = COS(a1_rad)

a2_rad = a2 * 0.0174532925
a2_sin = SIN(a2_rad): a2_cos = COS(a2_rad)

FOR p = VertexSource TO VertexSource + VertexCount - 1

    x = VertexX(p)
    y = VertexY(p)
    z = VertexZ(p)

    x2 = a1_sin * z + x * a1_cos
    z = a1_cos * z - a1_sin * x
    x = x2

    y2 = a2_sin * z + y * a2_cos
    z = a2_cos * z - a2_sin * y
    y = y2

    VertexX(p) = x
    VertexY(p) = y
    VertexZ(p) = z

NEXT
END SUB
DEFLNG A-Z

SUB CopyModel (m)

v2 = VertexLast

dif = (v2 + 1) - Model(m).FirstVertex

FOR v1 = Model(m).FirstVertex TO Model(m).FirstVertex + Model(m).VertexCount - 1
    v2 = v2 + 1
    VertexX(v2) = VertexX(v1)
    VertexY(v2) = VertexY(v1)
    VertexZ(v2) = VertexZ(v1)
    VertexTX(v2) = VertexTX(v1)
    VertexTY(v2) = VertexTY(v1)
NEXT
VertexLast = v2

t2 = TriangleLast
FOR t1 = Model(m).FirstTriangle TO Model(m).FirstTriangle + Model(m).TriangleCount * 3 - 1
    t2 = t2 + 1
    TriangleVertex(t2) = TriangleVertex(t1) + dif
NEXT
TriangleLast = t2

END SUB
