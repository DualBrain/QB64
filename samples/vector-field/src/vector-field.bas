OPTION _EXPLICIT

DO UNTIL _SCREENEXISTS: LOOP
_TITLE "Vector Field"

' Meta
RANDOMIZE TIMER

CONST Aquamarine = _RGB32(127, 255, 212)
CONST Lime = _RGB32(0, 255, 0)

DIM SHARED XSize
DIM SHARED YSize
DIM SHARED XCells
DIM SHARED YCells
DIM SHARED NPC
XSize = 30
YSize = 30
XCells = 30
YCells = 30
NPC = .1 * SQR(XCells * YCells)
SCREEN _NEWIMAGE(XSize * XCells, YSize * YCells, 32)


TYPE Vector
    x AS DOUBLE
    y AS DOUBLE
END TYPE

TYPE FieldLine
    Center AS Vector
    Tangent AS Vector
END TYPE

TYPE Particle
    Displacement AS Vector
    Velocity AS Vector
    Shade AS _UNSIGNED LONG
END TYPE

TYPE Charge
    Center AS Vector
    Radial AS Vector
    Angular AS Vector
END TYPE

DIM SHARED VectorField(XCells, YCells) AS FieldLine
DIM SHARED Particles(XCells, YCells, NPC) AS Particle
DIM SHARED Charges(100) AS Charge
DIM SHARED ChargeCount

ChargeCount = 1
Charges(ChargeCount).Center.x = 0
Charges(ChargeCount).Center.y = 0
Charges(ChargeCount).Radial.x = .05
Charges(ChargeCount).Radial.y = .05
Charges(ChargeCount).Angular.x = 0
Charges(ChargeCount).Angular.y = 0

DIM i AS INTEGER
DIM j AS INTEGER
DIM k AS INTEGER

FOR i = 1 TO XCells
    FOR j = 1 TO YCells
        VectorField(i, j).Center.x = (1 / 2) * XSize * (2 * i - XCells) - XSize / 2
        VectorField(i, j).Center.y = (1 / 2) * YSize * (2 * j - YCells) - YSize / 2
        FOR k = 1 TO NPC
            Particles(i, j, k).Shade = Lime
            Particles(i, j, k).Displacement.x = XSize * (RND - .5)
            Particles(i, j, k).Displacement.y = YSize * (RND - .5)
        NEXT
    NEXT
NEXT

CALL CalculateField

DIM x AS DOUBLE
DIM y AS DOUBLE

DO
    DO WHILE _MOUSEINPUT
        x = _MOUSEX
        y = _MOUSEY
        IF ((x > 0) AND (x < _WIDTH) AND (y > 0) AND (y < _HEIGHT)) THEN
            Charges(ChargeCount).Center.x = (x - _WIDTH / 2)
            Charges(ChargeCount).Center.y = (-y + _HEIGHT / 2)
            CALL CalculateField
        END IF
    LOOP

    k = _KEYHIT
    SELECT CASE k
        CASE 49
            Charges(ChargeCount).Radial.x = .05
            Charges(ChargeCount).Radial.y = .05
            Charges(ChargeCount).Angular.x = 0
            Charges(ChargeCount).Angular.y = 0
        CASE 50
            Charges(ChargeCount).Radial.x = -.05
            Charges(ChargeCount).Radial.y = -.05
            Charges(ChargeCount).Angular.x = 0
            Charges(ChargeCount).Angular.y = 0
        CASE 51
            Charges(ChargeCount).Radial.x = .05
            Charges(ChargeCount).Radial.y = -.05
            Charges(ChargeCount).Angular.x = 0
            Charges(ChargeCount).Angular.y = 0
        CASE 52
            Charges(ChargeCount).Radial.x = -.05
            Charges(ChargeCount).Radial.y = .05
            Charges(ChargeCount).Angular.x = 0
            Charges(ChargeCount).Angular.y = 0
        CASE 53
            Charges(ChargeCount).Radial.x = 0
            Charges(ChargeCount).Radial.y = 0
            Charges(ChargeCount).Angular.x = .05
            Charges(ChargeCount).Angular.y = -.05
        CASE 54
            Charges(ChargeCount).Radial.x = 0
            Charges(ChargeCount).Radial.y = 0
            Charges(ChargeCount).Angular.x = -.05
            Charges(ChargeCount).Angular.y = .05
        CASE 48
            ChargeCount = 1
        CASE 32
            ChargeCount = ChargeCount + 1
            Charges(ChargeCount).Center.x = Charges(ChargeCount - 1).Center.x
            Charges(ChargeCount).Center.y = Charges(ChargeCount - 1).Center.y
            Charges(ChargeCount).Radial.x = Charges(ChargeCount - 1).Radial.x
            Charges(ChargeCount).Radial.y = Charges(ChargeCount - 1).Radial.y
            Charges(ChargeCount).Angular.x = Charges(ChargeCount - 1).Angular.x
            Charges(ChargeCount).Angular.y = Charges(ChargeCount - 1).Angular.y
    END SELECT
    IF (k <> 0) THEN
        CALL CalculateField
    END IF
    _KEYCLEAR

    LINE (0, 0)-(_WIDTH, _HEIGHT), _RGBA(0, 0, 0, 20), BF

    DIM xc AS DOUBLE
    DIM yc AS DOUBLE
    DIM xd AS DOUBLE
    DIM yd AS DOUBLE
    DIM xx AS DOUBLE
    DIM yy AS DOUBLE

    LOCATE 1, 1: PRINT "Press 1-6 to change charge type. Press space to fix charge, 0 to clear."
    FOR i = 1 TO XCells
        FOR j = 1 TO YCells
            xc = VectorField(i, j).Center.x
            yc = VectorField(i, j).Center.y
            FOR k = 1 TO NPC
                xd = 0
                yd = 0
                xx = Particles(i, j, k).Displacement.x + .1 * Particles(i, j, k).Velocity.x
                yy = Particles(i, j, k).Displacement.y + .1 * Particles(i, j, k).Velocity.y
                IF (xx < -XSize / 2) THEN
                    xd = -xx + XSize / 2
                END IF
                IF (xx > XSize / 2) THEN
                    xd = -xx - XSize / 2
                END IF
                IF (yy < -YSize / 2) THEN
                    yd = -yy + YSize / 2
                END IF
                IF (yy > YSize / 2) THEN
                    yd = -yy + -YSize / 2
                END IF
                Particles(i, j, k).Displacement.x = xx + xd
                Particles(i, j, k).Displacement.y = yy + yd
                CALL cpset(xc + Particles(i, j, k).Displacement.x, yc + Particles(i, j, k).Displacement.y, Particles(i, j, k).Shade)
            NEXT
        NEXT
    NEXT
    _LIMIT 60
    _DISPLAY
LOOP

END

SUB CalculateField
    DIM i AS INTEGER
    DIM j AS INTEGER
    DIM k AS INTEGER
    DIM dx AS DOUBLE
    DIM dy AS DOUBLE
    DIM d2 AS DOUBLE
    DIM xx AS DOUBLE
    DIM yy AS DOUBLE
    FOR i = 1 TO XCells
        FOR j = 1 TO YCells
            xx = 0
            yy = 0
            FOR k = 1 TO ChargeCount
                dx = VectorField(i, j).Center.x - Charges(k).Center.x
                dy = VectorField(i, j).Center.y - Charges(k).Center.y
                d2 = 5000 / (dx * dx + dy * dy)
                xx = xx + (Charges(k).Radial.x * dx * d2) + (Charges(k).Angular.x * dy * d2)
                yy = yy + (Charges(k).Radial.y * dy * d2) + (Charges(k).Angular.y * dx * d2)
            NEXT
            VectorField(i, j).Tangent.x = xx
            VectorField(i, j).Tangent.y = yy
            FOR k = 1 TO NPC
                Particles(i, j, k).Velocity.x = VectorField(i, j).Tangent.x
                Particles(i, j, k).Velocity.y = VectorField(i, j).Tangent.y
            NEXT
        NEXT
    NEXT
END SUB

SUB cpset (x1, y1, col AS _UNSIGNED LONG)
    PSET (_WIDTH / 2 + x1, -y1 + _HEIGHT / 2), col
END SUB

