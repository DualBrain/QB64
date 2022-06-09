'Can't Contain Me - A game developed in QB64
'@FellippeHeitor fellippeheitor@gmail.com

CONST true = -1, false = NOT true

TYPE vector
    x AS SINGLE
    y AS SINGLE
    z AS SINGLE
END TYPE

TYPE NewObject
    pos AS vector
    dir AS vector
    w AS INTEGER
    h AS INTEGER
    dragXoff AS INTEGER
    dragYoff AS INTEGER
    color AS _UNSIGNED LONG
    img AS LONG
    selected AS _BYTE
    lost AS _BYTE
    added AS _BYTE
END TYPE

SCREEN _NEWIMAGE(896, 504, 32)
DO UNTIL _SCREENEXISTS: LOOP
_TITLE "Can't contain me"

RANDOMIZE TIMER

DIM icon AS LONG
icon = _NEWIMAGE(64, 64, 32)
_DEST icon
LINE (0, 0)-(63, 63), _RGB32(RND * 200, RND * 200, RND * 200), BF
CIRCLE (32, 32), 5, _RGB32(255, 255, 255)
PAINT (32, 32)
_DEST 0
_ICON icon
_FREEIMAGE icon

COLOR , 0
DIM obj(1 TO 10) AS NewObject, barn AS NewObject
DIM drag AS _BYTE, f AS LONG
DIM k AS LONG, i AS LONG

barn.w = 300
barn.h = 300
barn.pos.x = _WIDTH / 2 - barn.w / 2
barn.pos.y = _HEIGHT / 2 - barn.h / 2

GOSUB resetPieces

DO
    k = _KEYHIT

    IF k = 27 THEN SYSTEM

    IF (_KEYDOWN(100305) OR _KEYDOWN(100306)) AND (k = ASC("a") OR k = ASC("A")) THEN
        FOR i = 1 TO UBOUND(obj)
            obj(i).selected = true
        NEXT
    END IF

    WHILE _MOUSEINPUT: WEND

    IF NOT Won THEN
        IF _MOUSEBUTTON(1) THEN
            IF NOT drag THEN
                drag = true
                dragSelect = true
                dragx = _MOUSEX
                dragy = _MOUSEY
                clickedBox = false
                FOR i = 1 TO UBOUND(obj)
                    IF hovering(obj(i)) AND obj(i).added = false THEN
                        dragSelect = false
                        clickedBox = true

                        obj(i).dragXoff = _MOUSEX - obj(i).pos.x
                        obj(i).dragYoff = _MOUSEY - obj(i).pos.y

                        FOR j = 1 TO UBOUND(obj)
                            IF j <> i THEN
                                IF NOT _KEYDOWN(100305) AND NOT _KEYDOWN(100306) THEN
                                    IF obj(i).selected = false THEN obj(j).selected = false
                                END IF

                                obj(j).dragXoff = _MOUSEX - obj(j).pos.x
                                obj(j).dragYoff = _MOUSEY - obj(j).pos.y
                            END IF
                        NEXT

                        obj(i).selected = true

                        EXIT FOR
                    END IF
                NEXT
            END IF
        ELSE
            IF drag THEN
                drag = false
                dragSelect = false
            END IF
        END IF
    ELSE
        IF _MOUSEBUTTON(1) THEN
            IF NOT mousepressed THEN
                GOSUB resetPieces
            ELSE
                drag = false
                dragSelect = false
            END IF
        ELSE
            mousepressed = false
        END IF
    END IF

    LINE (0, 0)-(_WIDTH - 1, _HEIGHT - 1), _RGBA32(0, 0, 0, 30), BF

    FOR i = 1 TO UBOUND(obj)
        IF NOT obj(i).lost THEN
            obj(i).lost = obj(i).pos.x > _WIDTH OR obj(i).pos.y > _HEIGHT OR obj(i).pos.x + obj(i).w < 0 OR obj(i).pos.y + obj(i).h < 0
            IF obj(i).lost THEN
                'score = score - 5
            END IF
        END IF

        IF NOT obj(i).lost THEN
            IF obj(i).img < -1 THEN
            ELSE
                LINE (obj(i).pos.x, obj(i).pos.y)-STEP(obj(i).w - 1, obj(i).h - 1), obj(i).color, BF
                CIRCLE (obj(i).pos.x + obj(i).w / 2, obj(i).pos.y + obj(i).h / 2), 2, _RGB32(255, 255, 255)
                PAINT (obj(i).pos.x + obj(i).w / 2, obj(i).pos.y + obj(i).h / 2)
            END IF

            IF obj(i).selected THEN
                IF obj(i).img < -1 THEN
                ELSE
                    LINE (obj(i).pos.x - 2, obj(i).pos.y - 2)-STEP(obj(i).w + 3, obj(i).h + 3), _RGBA32(255, 255, 255, 150), B , 21845
                END IF
            ELSEIF hovering(obj(i)) AND NOT Won THEN
                IF obj(i).img < -1 THEN
                ELSE
                    LINE (obj(i).pos.x, obj(i).pos.y)-STEP(obj(i).w - 1, obj(i).h - 1), _RGBA32(255, 255, 255, 100), BF
                END IF
            END IF
        END IF

        IF drag AND obj(i).selected AND NOT dragSelect THEN
            obj(i).pos.x = dragx + (_MOUSEX - dragx) - obj(i).dragXoff
            obj(i).pos.y = dragy + (_MOUSEY - dragy) - obj(i).dragYoff
        END IF

        IF NOT isInside(obj(i), barn) THEN
            vector.add obj(i).pos, obj(i).dir
            IF isInside(obj(i), barn) THEN vector.mult obj(i).dir, -1
            DO WHILE isInside(obj(i), barn)
                vector.add obj(i).pos, obj(i).dir
            LOOP
        ELSE
            vector.add obj(i).pos, obj(i).dir
            IF NOT isInside(obj(i), barn) THEN vector.mult obj(i).dir, -1
            DO WHILE NOT isInside(obj(i), barn)
                vector.add obj(i).pos, obj(i).dir
            LOOP

            IF obj(i).added = false THEN
                score = score + 10
                obj(i).added = true

                'pieces get agitated when contained...
                obj(i).dir.x = obj(i).dir.x * 5
                obj(i).dir.y = obj(i).dir.y * 5
            ELSE
                obj(i).selected = false
            END IF
        END IF
    NEXT

    LINE (barn.pos.x - obj(1).w / 2, barn.pos.y - obj(1).h / 2)-STEP(barn.w + obj(1).w - 1, barn.h + obj(1).h - 1), _RGBA32(255, 255, 255, 100), BF

    IF dragSelect THEN
        LINE (dragx, dragy)-(_MOUSEX, _MOUSEY), _RGBA32(127, 172, 255, 100), BF
        LINE (dragx, dragy)-(_MOUSEX, _MOUSEY), _RGB32(127, 172, 255), B

        DIM rect AS NewObject
        rect.pos.x = dragx
        rect.pos.y = dragy
        rect.w = _MOUSEX - dragx
        rect.h = _MOUSEY - dragy

        FOR i = 1 TO UBOUND(obj)
            IF isInside(obj(i), rect) AND obj(i).added = false THEN obj(i).selected = true ELSE obj(i).selected = false
        NEXT
    END IF

    Won = true
    LostPieces = 0
    FOR i = 1 TO UBOUND(obj)
        IF NOT obj(i).lost THEN
            IF NOT obj(i).added THEN Won = false: EXIT FOR
        ELSE
            LostPieces = LostPieces + 1
        END IF
    NEXT

    IF Won THEN
        IF LostPieces = 1 THEN
            m$ = "All but 1 piece contained!"
        ELSEIF LostPieces = UBOUND(obj) THEN
            m$ = "You lose... no pieces contained..."
        ELSEIF LostPieces > 1 THEN
            m$ = "All but" + STR$(LostPieces) + " pieces contained!"
        ELSE
            m$ = "All pieces contained!"
        END IF
        COLOR _RGB32(0, 0, 0)
        _PRINTSTRING (_WIDTH / 2 - _PRINTWIDTH(m$) / 2 + 1, _HEIGHT / 2 - _FONTHEIGHT - 1), m$
        _PRINTSTRING (_WIDTH / 2 - _PRINTWIDTH(m$) / 2 - 1, _HEIGHT / 2 - _FONTHEIGHT - 1), m$
        _PRINTSTRING (_WIDTH / 2 - _PRINTWIDTH(m$) / 2 + 1, _HEIGHT / 2 - _FONTHEIGHT + 1), m$
        _PRINTSTRING (_WIDTH / 2 - _PRINTWIDTH(m$) / 2 - 1, _HEIGHT / 2 - _FONTHEIGHT + 1), m$
        COLOR _RGB32(255, 255, 255)
        _PRINTSTRING (_WIDTH / 2 - _PRINTWIDTH(m$) / 2, _HEIGHT / 2 - _FONTHEIGHT), m$
        m$ = "Your score:" + STR$(score)
        COLOR _RGB32(0, 0, 0)
        _PRINTSTRING (_WIDTH / 2 - _PRINTWIDTH(m$) / 2 - 1, _HEIGHT / 2 + _FONTHEIGHT - 1), m$
        _PRINTSTRING (_WIDTH / 2 - _PRINTWIDTH(m$) / 2 + 1, _HEIGHT / 2 + _FONTHEIGHT + 1), m$
        _PRINTSTRING (_WIDTH / 2 - _PRINTWIDTH(m$) / 2 + 1, _HEIGHT / 2 + _FONTHEIGHT - 1), m$
        _PRINTSTRING (_WIDTH / 2 - _PRINTWIDTH(m$) / 2 - 1, _HEIGHT / 2 + _FONTHEIGHT + 1), m$
        COLOR _RGB32(255, 255, 255)
        _PRINTSTRING (_WIDTH / 2 - _PRINTWIDTH(m$) / 2, _HEIGHT / 2 + _FONTHEIGHT), m$
        IF _MOUSEBUTTON(1) THEN mousepressed = true
    ELSE
        _PRINTSTRING (0, 0), "Score:" + STR$(score)
        _PRINTSTRING (0, _FONTHEIGHT), "Time:" + STR$(INT(TIMER - start#))
    END IF

    _DISPLAY

    _LIMIT 30
LOOP

SYSTEM

resetPieces:
FOR i = 1 TO UBOUND(obj)
    obj(i).w = 40
    obj(i).h = 40
    obj(i).lost = false
    obj(i).added = false
    obj(i).selected = false
    createVector obj(i).dir, p5random(-1, 1), p5random(-1, 1)
    obj(i).color = _RGB32(RND * 200, RND * 200, RND * 200)
    DO
        createVector obj(i).pos, RND * (_WIDTH - obj(i).w), RND * (_HEIGHT - obj(i).h)
    LOOP WHILE isInside(obj(i), barn)
NEXT

start# = TIMER
Won = false
score = 0
RETURN

FUNCTION hovering%% (this AS NewObject)
    hovering = _MOUSEX > this.pos.x AND _MOUSEX < this.pos.x + this.w - 1 AND _MOUSEY > this.pos.y AND _MOUSEY < this.pos.y + this.h - 1
END FUNCTION

FUNCTION isInside%% (this AS NewObject, __rect AS NewObject)
    DIM rect AS NewObject

    rect = __rect
    IF rect.w < 0 THEN rect.w = ABS(rect.w): rect.pos.x = rect.pos.x - rect.w
    IF rect.h < 0 THEN rect.h = ABS(rect.h): rect.pos.y = rect.pos.y - rect.h

    isInside%% = rect.pos.x < this.pos.x + this.w AND rect.pos.x + rect.w > this.pos.x AND rect.pos.y < this.pos.y + this.h AND rect.pos.y + rect.h > this.pos.y
END FUNCTION

'Elements below have been borrowed from the p5js.bas library:
FUNCTION p5random! (mn!, mx!)
    IF mn! > mx! THEN
        SWAP mn!, mx!
    END IF
    p5random! = RND * (mx! - mn!) + mn!
END FUNCTION

SUB createVector (v AS vector, x AS SINGLE, y AS SINGLE)
    v.x = x
    v.y = y
END SUB

SUB vector.add (v1 AS vector, v2 AS vector)
    v1.x = v1.x + v2.x
    v1.y = v1.y + v2.y
    v1.z = v1.z + v2.z
END SUB

SUB vector.mult (v AS vector, n AS SINGLE)
    v.x = v.x * n
    v.y = v.y * n
    v.z = v.z * n
END SUB
