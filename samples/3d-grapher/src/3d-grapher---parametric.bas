'##############################################################################
'3D Grapher in QB64 using OpenGL
'
'Contributors:
'  Ashish Kushwaha
'  FellipeHeitor
'  STxAxTIC
'
'See README.bm.

OPTION _EXPLICIT

REM $INCLUDE: 'sxript.bi'
REM $Include: 'sxmath.bi'

DO UNTIL _SCREENEXISTS: LOOP
_TITLE "3D Grapher"

_ACCEPTFILEDROP

SCREEN _NEWIMAGE(600, 600, 32)

DECLARE LIBRARY
    SUB gluLookAt (BYVAL eyeX#, BYVAL eyeY#, BYVAL eyeZ#, BYVAL centerX#, BYVAL centerY#, BYVAL centerZ#, BYVAL upX#, BYVAL upY#, BYVAL upZ#)
END DECLARE

' Types.
TYPE rgb
    r AS SINGLE
    g AS SINGLE
    b AS SINGLE
END TYPE

TYPE vector
    x AS DOUBLE
    y AS DOUBLE
    z AS DOUBLE
END TYPE

TYPE paraSpec
    p AS INTEGER
    i AS STRING
    x AS STRING
    y AS STRING
    z AS STRING
END TYPE

' Master switch for SUB _GL().
DIM SHARED glAllow AS INTEGER

' Plot structure.
DIM SHARED mainEquation AS paraSpec
DIM SHARED paraVert1(2500) AS vector
DIM SHARED paraVert2(50, 50) AS vector
DIM SHARED paraShade1(2500) AS rgb
DIM SHARED paraShade2(50, 50) AS rgb

' Camera settings.
DIM SHARED xRot AS DOUBLE
DIM SHARED yRot AS DOUBLE
DIM SHARED zoomFactor

' Render settings.
DIM SHARED graph_render_mode

' Initialize.
zoomFactor = 1.0
CALL setShade

' Sphere
mainEquation.p = 2
mainEquation.i = "<let(theta,(3.14159/(50-1))*([u]-1)),let(phi,(2*3.14159/(50-1))*[v])>"
mainEquation.x = "15 * sin([theta]) * cos([phi])"
mainEquation.y = "15 * sin([theta]) * sin([phi])"
mainEquation.z = "15 * cos([theta])"

IF (COMMAND$ <> "") THEN
    OPEN COMMAND$ FOR INPUT AS #1
    INPUT #1, mainEquation.p '      number of parameters
    LINE INPUT #1, mainEquation.i ' helper calcuations
    LINE INPUT #1, mainEquation.x ' x-equation
    LINE INPUT #1, mainEquation.y ' y-equation
    LINE INPUT #1, mainEquation.z ' z-equation
    CLOSE #1
END IF

' Prime main loop.
CALL initSequence

' Main loop.
DO
    CALL mouseProcess
    CALL keyProcess
    CALL CheckFile
    _LIMIT 60
LOOP

END

SUB _GL () STATIC
    IF (glAllow = 0) THEN EXIT SUB

    ' Environment.
    _glClear _GL_COLOR_BUFFER_BIT OR _GL_DEPTH_BUFFER_BIT
    _glEnable _GL_DEPTH_TEST
    _glEnable _GL_BLEND
    _glMatrixMode _GL_PROJECTION

    _gluPerspective 50, 1, 0.1, 40
    _glMatrixMode _GL_MODELVIEW

    _glLoadIdentity

    gluLookAt 0, 7, 15, 0, 0, 0, 0, 1, 0

    ' Set camera angle.
    _glRotatef xRot, 1, 0, 0
    _glRotatef yRot, 0, 1, 0

    ' Set camera zoom.
    _glScalef zoomFactor, zoomFactor, zoomFactor

    ' Draw axes.
    _glBegin _GL_LINES
    _glLineWidth 2.0
    ' x-axis
    _glColor3f 1, 0, 0
    _glVertex3f -5, 0, 0
    _glVertex3f 5, 0, 0
    ' z-axis
    _glColor3f 0, 1, 0
    _glVertex3f 0, -5, 0
    _glVertex3f 0, 5, 0
    ' y-axis
    _glColor3f 0, 0, 1
    _glVertex3f 0, 0, -5
    _glVertex3f 0, 0, 5
    _glEnd

    ' Draw the surface.
    DIM k1 AS INTEGER
    DIM k2 AS INTEGER
    IF (mainEquation.p = 1) THEN
        FOR k1 = 1 TO 2500 - 1
            _glBegin _GL_LINE_STRIP
            _glColor4f paraShade1(k1).r, paraShade1(k1).g, paraShade1(k1).b, 1
            _glLineWidth 1.0
            _glVertex3f paraVert1(k1).x, paraVert1(k1).z, paraVert1(k1).y
            _glVertex3f paraVert1(k1 + 1).x, paraVert1(k1 + 1).z, paraVert1(k1 + 1).y
            _glEnd
        NEXT
    END IF
    IF (mainEquation.p = 2) THEN
        FOR k1 = 1 TO 50 - 1
            FOR k2 = 1 TO 50 - 1
                IF (graph_render_mode = 1) THEN _glBegin _GL_TRIANGLE_STRIP ELSE _glBegin _GL_LINE_STRIP
                _glColor4f paraShade2(k1, k2).r, paraShade2(k1, k2).g, paraShade2(k1, k2).b, 1
                _glLineWidth 1.0
                _glVertex3f paraVert2(k1, k2).x, paraVert2(k1, k2).z, paraVert2(k1, k2).y
                _glVertex3f paraVert2(k1 + 1, k2).x, paraVert2(k1 + 1, k2).z, paraVert2(k1 + 1, k2).y
                _glVertex3f paraVert2(k1 + 1, k2 + 1).x, paraVert2(k1 + 1, k2 + 1).z, paraVert2(k1 + 1, k2 + 1).y
                _glEnd

                IF (graph_render_mode = 1) THEN _glBegin _GL_TRIANGLE_STRIP ELSE _glBegin _GL_LINE_STRIP
                _glColor4f paraShade2(k1, k2).r, paraShade2(k1, k2).g, paraShade2(k1, k2).b, 1
                _glLineWidth 1.0
                _glVertex3f paraVert2(k1, k2).x, paraVert2(k1, k2).z, paraVert2(k1, k2).y
                _glVertex3f paraVert2(k1, k2 + 1).x, paraVert2(k1, k2 + 1).z, paraVert2(k1, k2 + 1).y
                _glVertex3f paraVert2(k1 + 1, k2 + 1).x, paraVert2(k1 + 1, k2 + 1).z, paraVert2(k1 + 1, k2 + 1).y
                _glEnd
            NEXT
        NEXT
    END IF
END SUB

SUB initSequence
    CLS
    PRINT "Generating..."
    _DISPLAY
    CALL generatePlot
    CLS , 1
    COLOR , 1
    'PRINT "(params) = " + mainEquation.i
    PRINT "x = " + mainEquation.x
    PRINT "y = " + mainEquation.y
    PRINT "z = " + mainEquation.z
    _DISPLAY
    _GLRENDER _BEHIND
    graph_render_mode = -1 ' 1=solid surface, -1=lines
    glAllow = 1
END SUB

SUB mouseProcess
    DIM x AS DOUBLE
    DIM y AS DOUBLE
    WHILE _MOUSEINPUT
        IF (zoomFactor > 0.1) THEN
            zoomFactor = zoomFactor + _MOUSEWHEEL * 0.05
        ELSE
            zoomFactor = 0.11
        END IF
    WEND
    IF (_MOUSEBUTTON(1)) THEN
        x = _MOUSEX
        y = _MOUSEY
        WHILE _MOUSEBUTTON(1)
            WHILE _MOUSEINPUT: WEND
            yRot = yRot + (_MOUSEX - x)
            xRot = xRot + (_MOUSEY - y)
            x = _MOUSEX
            y = _MOUSEY
        WEND
    END IF
END SUB

SUB keyProcess
    DIM k AS INTEGER
    k = _KEYHIT
    IF (k = ASC(" ")) THEN graph_render_mode = graph_render_mode * -1
    _KEYCLEAR
END SUB

SUB CheckFile
    DIM theFile AS STRING
    IF (_TOTALDROPPEDFILES > 0) THEN
        IF (_FILEEXISTS(_DROPPEDFILE$(1))) THEN
            glAllow = 0
            theFile = _DROPPEDFILE$(1)
            OPEN theFile FOR INPUT AS #1
            INPUT #1, mainEquation.p
            LINE INPUT #1, mainEquation.i
            LINE INPUT #1, mainEquation.x
            LINE INPUT #1, mainEquation.y
            LINE INPUT #1, mainEquation.z
            CLOSE #1
            CALL initSequence
            glAllow = 1
        END IF
        _FINISHDROP
    END IF
END SUB

SUB generatePlot
    DIM a AS STRING
    DIM k1 AS INTEGER
    DIM k2 AS INTEGER
    IF (mainEquation.p = 1) THEN
        FOR k1 = 1 TO 2500
            a = SxriptEval$("let(u," + STR$(k1) + ")")
            a = SxriptEval$(mainEquation.i)
            paraVert1(k1).x = VAL(SxriptEval$(mainEquation.x))
            paraVert1(k1).y = VAL(SxriptEval$(mainEquation.y))
            paraVert1(k1).z = VAL(SxriptEval$(mainEquation.z))
        NEXT
    END IF
    IF (mainEquation.p = 2) THEN
        FOR k1 = 1 TO 50
            FOR k2 = 1 TO 50
                a = SxriptEval$("let(u," + STR$(k1) + ")")
                a = SxriptEval$("let(v," + STR$(k2) + ")")
                a = SxriptEval$(mainEquation.i)
                paraVert2(k1, k2).x = VAL(SxriptEval$(mainEquation.x))
                paraVert2(k1, k2).y = VAL(SxriptEval$(mainEquation.y))
                paraVert2(k1, k2).z = VAL(SxriptEval$(mainEquation.z))
            NEXT
        NEXT
    END IF
END SUB

SUB setShade
    DIM k1 AS INTEGER
    DIM k2 AS INTEGER
    FOR k1 = 1 TO 2500
        paraShade1(k1).r = 1 - k1 / 2500
        paraShade1(k1).g = .25
        paraShade1(k1).b = k1 / 2500
    NEXT
    FOR k1 = 1 TO 50
        FOR k2 = 1 TO 50
            paraShade2(k1, k2).r = .1 + .9 * SIN(3.14159 * k1 / 50) ^ 2
            paraShade2(k1, k2).g = 0
            paraShade2(k1, k2).b = 1 - .9 * SIN(3.14159 * k2 / 50) ^ 2
        NEXT
    NEXT
END SUB

REM $INCLUDE: 'sxript.bm'
REM $Include: 'sxmath.bm'

''' LEGACY CODE

''By Fellipe Heitor
'FUNCTION INPUTBOX (tTitle$, tMessage$, InitialValue AS STRING, NewValue AS STRING, Selected)
'    'INPUTBOX ---------------------------------------------------------------------
'    'Show a dialog and allow user input. Returns 1 = OK or 2 = Cancel.            '
'    '                                                                             '
'    '- tTitle$ is the desired dialog title. If not provided, it'll be "Input"     '
'    '                                                                             '
'    '- tMessage$ is the prompt that'll be shown to the user. You can show         '
'    '   a multiline message by adding line breaks with CHR$(10).                  '
'    '                                                                             '
'    ' - InitialValue can be passed both as a string literal or as a variable.     '
'    '                                                                             '
'    '- Actual user input is returned by altering NewValue, so it must be          '
'    '   passed as a variable.                                                     '
'    '                                                                             '
'    '- Selected indicates wheter the initial value will be preselected when the   '
'    '   dialog is first shown. -1 preselects the whole text; positive values      '
'    '   select only part of the initial value (from the character position passed '
'    '   to the end of the initial value).                                         '
'    '                                                                             '
'    'Intended for use with 32-bit screen modes.                                   '
'    '------------------------------------------------------------------------------

'    'Variable declaration:
'    DIM Message$, Title$, CharW AS INTEGER, MaxLen AS INTEGER
'    DIM lineBreak AS INTEGER, totalLines AS INTEGER, prevlinebreak AS INTEGER
'    DIM Cursor AS INTEGER, Selection.Start AS INTEGER, InputViewStart AS INTEGER
'    DIM FieldArea AS INTEGER, DialogH AS INTEGER, DialogW AS INTEGER
'    DIM DialogX AS INTEGER, DialogY AS INTEGER, InputField.X AS INTEGER
'    DIM TotalButtons AS INTEGER, B AS INTEGER, ButtonLine$
'    DIM cb AS INTEGER, DIALOGRESULT AS INTEGER, i AS INTEGER
'    DIM message.X AS INTEGER, SetCursor#, cursorBlink%
'    DIM DefaultButton AS INTEGER, k AS LONG
'    DIM shiftDown AS _BYTE, ctrlDown AS _BYTE, Clip$
'    DIM FindLF%, s1 AS INTEGER, s2 AS INTEGER
'    DIM Selection.Value$
'    DIM prevCursor AS INTEGER, ss1 AS INTEGER, ss2 AS INTEGER, mb AS _BYTE
'    DIM mx AS INTEGER, my AS INTEGER, nmx AS INTEGER, nmy AS INTEGER
'    DIM FGColor AS LONG, BGColor AS LONG

'    'Data type used for the dialog buttons:
'    TYPE BUTTONSTYPE
'        ID AS LONG
'        CAPTION AS STRING * 120
'        X AS INTEGER
'        Y AS INTEGER
'        W AS INTEGER
'    END TYPE

'    'Color constants. You can customize colors by changing these:
'    CONST TitleBarColor = _RGB32(0, 178, 179)
'    CONST DialogBGColor = _RGB32(255, 255, 255)
'    CONST TitleBarTextColor = _RGB32(0, 0, 0)
'    CONST DialogTextColor = _RGB32(0, 0, 0)
'    CONST InputFieldColor = _RGB32(200, 200, 200)
'    CONST InputFieldTextColor = _RGB32(0, 0, 0)
'    CONST SelectionColor = _RGBA32(127, 127, 127, 100)

'    'Initial variable setup:
'    Message$ = tMessage$
'    Title$ = RTRIM$(LTRIM$(tTitle$))
'    IF Title$ = "" THEN Title$ = "Input"
'    NewValue = RTRIM$(LTRIM$(InitialValue))
'    DefaultButton = 1

'    'Save the current drawing page so it can be restored later:
'    FGColor = _DEFAULTCOLOR
'    BGColor = _BACKGROUNDCOLOR
'    PCOPY 0, 1

'    'Figure out the print width of a single character (in case user has a custom font applied)
'    CharW = _PRINTWIDTH("_")

'    'Place a color overlay over the old screen image so the focus is on the dialog:
'    LINE (0, 0)-STEP(_WIDTH - 1, _HEIGHT - 1), _RGBA32(170, 170, 170, 170), BF

'    'Message breakdown, in case CHR$(10) was used as line break:
'    REDIM MessageLines(1) AS STRING
'    MaxLen = 1
'    DO
'        lineBreak = INSTR(lineBreak + 1, Message$, CHR$(10))
'        IF lineBreak = 0 AND totalLines = 0 THEN
'            totalLines = 1
'            MessageLines(1) = Message$
'            MaxLen = LEN(Message$)
'            EXIT DO
'        ELSEIF lineBreak = 0 AND totalLines > 0 THEN
'            totalLines = totalLines + 1
'            REDIM _PRESERVE MessageLines(1 TO totalLines) AS STRING
'            MessageLines(totalLines) = RIGHT$(Message$, LEN(Message$) - prevlinebreak + 1)
'            IF LEN(MessageLines(totalLines)) > MaxLen THEN MaxLen = LEN(MessageLines(totalLines))
'            EXIT DO
'        END IF
'        IF totalLines = 0 THEN prevlinebreak = 1
'        totalLines = totalLines + 1
'        REDIM _PRESERVE MessageLines(1 TO totalLines) AS STRING
'        MessageLines(totalLines) = MID$(Message$, prevlinebreak, lineBreak - prevlinebreak)
'        IF LEN(MessageLines(totalLines)) > MaxLen THEN MaxLen = LEN(MessageLines(totalLines))
'        prevlinebreak = lineBreak + 1
'    LOOP

'    Cursor = LEN(NewValue)
'    Selection.Start = 0
'    InputViewStart = 1
'    FieldArea = _WIDTH \ CharW - 4
'    IF FieldArea > 62 THEN FieldArea = 62
'    IF Selected > 0 THEN Selection.Start = Selected: Selected = -1

'    'Calculate dialog dimensions and print coordinates:
'    DialogH = _FONTHEIGHT * (6 + totalLines) + 10
'    DialogW = (CharW * FieldArea) + 10
'    IF DialogW < MaxLen * CharW + 10 THEN DialogW = MaxLen * CharW + 10

'    DialogX = _WIDTH / 2 - DialogW / 2
'    DialogY = _HEIGHT / 2 - DialogH / 2
'    InputField.X = (DialogX + (DialogW / 2)) - (((FieldArea * CharW) - 10) / 2) - 4

'    'Calculate button's print coordinates:
'    TotalButtons = 2
'    DIM Buttons(1 TO TotalButtons) AS BUTTONSTYPE
'    B = 1
'    Buttons(B).ID = 1: Buttons(B).CAPTION = "< OK >": B = B + 1
'    Buttons(B).ID = 2: Buttons(B).CAPTION = "< Cancel >": B = B + 1
'    ButtonLine$ = " "
'    FOR cb = 1 TO TotalButtons
'        ButtonLine$ = ButtonLine$ + RTRIM$(LTRIM$(Buttons(cb).CAPTION)) + " "
'        Buttons(cb).Y = DialogY + 5 + _FONTHEIGHT * (5 + totalLines)
'        Buttons(cb).W = _PRINTWIDTH(RTRIM$(LTRIM$(Buttons(cb).CAPTION)))
'    NEXT cb
'    Buttons(1).X = _WIDTH / 2 - _PRINTWIDTH(ButtonLine$) / 2
'    FOR cb = 2 TO TotalButtons
'        Buttons(cb).X = Buttons(1).X + _PRINTWIDTH(SPACE$(INSTR(ButtonLine$, RTRIM$(LTRIM$(Buttons(cb).CAPTION)))))
'    NEXT cb

'    'Main loop:
'    DIALOGRESULT = 0
'    _KEYCLEAR
'    DO: _LIMIT 500
'        'Draw the dialog.
'        LINE (DialogX, DialogY)-STEP(DialogW - 1, DialogH - 1), DialogBGColor, BF
'        LINE (DialogX, DialogY)-STEP(DialogW - 1, _FONTHEIGHT + 1), TitleBarColor, BF
'        COLOR TitleBarTextColor
'        _PRINTSTRING (_WIDTH / 2 - _PRINTWIDTH(Title$) / 2, DialogY + 1), Title$

'        COLOR DialogTextColor, _RGBA32(0, 0, 0, 0)
'        FOR i = 1 TO totalLines
'            message.X = _WIDTH / 2 - _PRINTWIDTH(MessageLines(i)) / 2
'            _PRINTSTRING (message.X, DialogY + 5 + _FONTHEIGHT * (i + 1)), MessageLines(i)
'        NEXT i

'        'Draw the input field
'        LINE (InputField.X - 2, DialogY + 3 + _FONTHEIGHT * (3 + totalLines))-STEP(FieldArea * CharW, _FONTHEIGHT + 4), InputFieldColor, BF
'        COLOR InputFieldTextColor
'        _PRINTSTRING (InputField.X, DialogY + 5 + _FONTHEIGHT * (3 + totalLines)), MID$(NewValue, InputViewStart, FieldArea)

'        'Selection highlight:
'        GOSUB SelectionHighlight

'        'Cursor blink:
'        IF TIMER - SetCursor# > .4 THEN
'            SetCursor# = TIMER
'            IF cursorBlink% = 1 THEN cursorBlink% = 0 ELSE cursorBlink% = 1
'        END IF
'        IF cursorBlink% = 1 THEN
'            LINE (InputField.X + (Cursor - (InputViewStart - 1)) * CharW, DialogY + 5 + _FONTHEIGHT * (3 + totalLines))-STEP(0, _FONTHEIGHT), _RGB32(0, 0, 0)
'        END IF

'        'Check if buttons have been clicked or are being hovered:
'        GOSUB CheckButtons

'        'Draw buttons:
'        FOR cb = 1 TO TotalButtons
'            _PRINTSTRING (Buttons(cb).X, Buttons(cb).Y), RTRIM$(LTRIM$(Buttons(cb).CAPTION))
'            IF cb = DefaultButton THEN
'                COLOR _RGB32(255, 255, 0)
'                _PRINTSTRING (Buttons(cb).X, Buttons(cb).Y), "<" + SPACE$(LEN(RTRIM$(LTRIM$(Buttons(cb).CAPTION))) - 2) + ">"
'                COLOR _RGB32(0, 178, 179)
'                _PRINTSTRING (Buttons(cb).X - 1, Buttons(cb).Y - 1), "<" + SPACE$(LEN(RTRIM$(LTRIM$(Buttons(cb).CAPTION))) - 2) + ">"
'                COLOR _RGB32(0, 0, 0)
'            END IF
'        NEXT cb

'        _DISPLAY

'        'Process input:
'        k = _KEYHIT
'        IF k = 100303 OR k = 100304 THEN shiftDown = -1
'        IF k = -100303 OR k = -100304 THEN shiftDown = 0
'        IF k = 100305 OR k = 100306 THEN ctrlDown = -1
'        IF k = -100305 OR k = -100306 THEN ctrlDown = 0

'        SELECT CASE k
'            CASE 13: DIALOGRESULT = 1
'            CASE 27: DIALOGRESULT = 2
'            CASE 32 TO 126 'Printable ASCII characters
'                IF k = ASC("v") OR k = ASC("V") THEN 'Paste from clipboard (Ctrl+V)
'                    IF ctrlDown THEN
'                        Clip$ = _CLIPBOARD$
'                        FindLF% = INSTR(Clip$, CHR$(13))
'                        IF FindLF% > 0 THEN Clip$ = LEFT$(Clip$, FindLF% - 1)
'                        FindLF% = INSTR(Clip$, CHR$(10))
'                        IF FindLF% > 0 THEN Clip$ = LEFT$(Clip$, FindLF% - 1)
'                        IF LEN(RTRIM$(LTRIM$(Clip$))) > 0 THEN
'                            IF NOT Selected THEN
'                                IF Cursor = LEN(NewValue) THEN
'                                    NewValue = NewValue + Clip$
'                                    Cursor = LEN(NewValue)
'                                ELSE
'                                    NewValue = LEFT$(NewValue, Cursor) + Clip$ + MID$(NewValue, Cursor + 1)
'                                    Cursor = Cursor + LEN(Clip$)
'                                END IF
'                            ELSE
'                                s1 = Selection.Start
'                                s2 = Cursor
'                                IF s1 > s2 THEN SWAP s1, s2
'                                NewValue = LEFT$(NewValue, s1) + Clip$ + MID$(NewValue, s2 + 1)
'                                Cursor = s1 + LEN(Clip$)
'                                Selected = 0
'                            END IF
'                        END IF
'                        k = 0
'                    END IF
'                ELSEIF k = ASC("c") OR k = ASC("C") THEN 'Copy selection to clipboard (Ctrl+C)
'                    IF ctrlDown THEN
'                        _CLIPBOARD$ = Selection.Value$
'                        k = 0
'                    END IF
'                ELSEIF k = ASC("x") OR k = ASC("X") THEN 'Cut selection to clipboard (Ctrl+X)
'                    IF ctrlDown THEN
'                        _CLIPBOARD$ = Selection.Value$
'                        GOSUB DeleteSelection
'                        k = 0
'                    END IF
'                ELSEIF k = ASC("a") OR k = ASC("A") THEN 'Select all text (Ctrl+A)
'                    IF ctrlDown THEN
'                        Cursor = LEN(NewValue)
'                        Selection.Start = 0
'                        Selected = -1
'                        k = 0
'                    END IF
'                END IF

'                IF k > 0 THEN
'                    IF NOT Selected THEN
'                        IF Cursor = LEN(NewValue) THEN
'                            NewValue = NewValue + CHR$(k)
'                            Cursor = Cursor + 1
'                        ELSE
'                            NewValue = LEFT$(NewValue, Cursor) + CHR$(k) + MID$(NewValue, Cursor + 1)
'                            Cursor = Cursor + 1
'                        END IF
'                        IF Cursor > FieldArea THEN InputViewStart = (Cursor - FieldArea) + 2
'                    ELSE
'                        s1 = Selection.Start
'                        s2 = Cursor
'                        IF s1 > s2 THEN SWAP s1, s2
'                        NewValue = LEFT$(NewValue, s1) + CHR$(k) + MID$(NewValue, s2 + 1)
'                        Selected = 0
'                        Cursor = s1 + 1
'                    END IF
'                END IF
'            CASE 8 'Backspace
'                IF LEN(NewValue) > 0 THEN
'                    IF NOT Selected THEN
'                        IF Cursor = LEN(NewValue) THEN
'                            NewValue = LEFT$(NewValue, LEN(NewValue) - 1)
'                            Cursor = Cursor - 1
'                        ELSEIF Cursor > 1 THEN
'                            NewValue = LEFT$(NewValue, Cursor - 1) + MID$(NewValue, Cursor + 1)
'                            Cursor = Cursor - 1
'                        ELSEIF Cursor = 1 THEN
'                            NewValue = RIGHT$(NewValue, LEN(NewValue) - 1)
'                            Cursor = Cursor - 1
'                        END IF
'                    ELSE
'                        GOSUB DeleteSelection
'                    END IF
'                END IF
'            CASE 21248 'Delete
'                IF NOT Selected THEN
'                    IF LEN(NewValue) > 0 THEN
'                        IF Cursor = 0 THEN
'                            NewValue = RIGHT$(NewValue, LEN(NewValue) - 1)
'                        ELSEIF Cursor > 0 AND Cursor <= LEN(NewValue) - 1 THEN
'                            NewValue = LEFT$(NewValue, Cursor) + MID$(NewValue, Cursor + 2)
'                        END IF
'                    END IF
'                ELSE
'                    GOSUB DeleteSelection
'                END IF
'            CASE 19200 'Left arrow key
'                GOSUB CheckSelection
'                IF Cursor > 0 THEN Cursor = Cursor - 1
'            CASE 19712 'Right arrow key
'                GOSUB CheckSelection
'                IF Cursor < LEN(NewValue) THEN Cursor = Cursor + 1
'            CASE 18176 'Home
'                GOSUB CheckSelection
'                Cursor = 0
'            CASE 20224 'End
'                GOSUB CheckSelection
'                Cursor = LEN(NewValue)
'        END SELECT

'        'Cursor adjustments:
'        GOSUB CursorAdjustments
'    LOOP UNTIL DIALOGRESULT > 0

'    _KEYCLEAR
'    INPUTBOX = DIALOGRESULT

'    'Restore previous display:
'    PCOPY 1, 0
'    COLOR FGColor, BGColor
'    EXIT SUB

'    CursorAdjustments:
'    IF Cursor > prevCursor THEN
'        IF Cursor - InputViewStart + 2 > FieldArea THEN InputViewStart = (Cursor - FieldArea) + 2
'    ELSEIF Cursor < prevCursor THEN
'        IF Cursor < InputViewStart - 1 THEN InputViewStart = Cursor
'    END IF
'    prevCursor = Cursor
'    IF InputViewStart < 1 THEN InputViewStart = 1
'    RETURN

'    CheckSelection:
'    IF shiftDown = -1 THEN
'        IF Selected = 0 THEN
'            Selected = -1
'            Selection.Start = Cursor
'        END IF
'    ELSEIF shiftDown = 0 THEN
'        Selected = 0
'    END IF
'    RETURN

'    DeleteSelection:
'    NewValue = LEFT$(NewValue, s1) + MID$(NewValue, s2 + 1)
'    Selected = 0
'    Cursor = s1
'    RETURN

'    SelectionHighlight:
'    IF Selected THEN
'        s1 = Selection.Start
'        s2 = Cursor
'        IF s1 > s2 THEN
'            SWAP s1, s2
'            IF InputViewStart > 1 THEN
'                ss1 = s1 - InputViewStart + 1
'            ELSE
'                ss1 = s1
'            END IF
'            ss2 = s2 - s1
'            IF ss1 + ss2 > FieldArea THEN ss2 = FieldArea - ss1
'        ELSE
'            ss1 = s1
'            ss2 = s2 - s1
'            IF ss1 < InputViewStart THEN ss1 = 0: ss2 = s2 - InputViewStart + 1
'            IF ss1 > InputViewStart THEN ss1 = ss1 - InputViewStart + 1: ss2 = s2 - s1
'        END IF
'        Selection.Value$ = MID$(NewValue, s1 + 1, s2 - s1)

'        LINE (InputField.X + ss1 * CharW, DialogY + 5 + _FONTHEIGHT * (3 + totalLines))-STEP(ss2 * CharW, _FONTHEIGHT), _RGBA32(255, 255, 255, 150), BF
'    END IF
'    RETURN

'    CheckButtons:
'    'Hover highlight:
'    WHILE _MOUSEINPUT: WEND
'    mb = _MOUSEBUTTON(1): mx = _MOUSEX: my = _MOUSEY
'    FOR cb = 1 TO TotalButtons
'        IF (mx >= Buttons(cb).X) AND (mx <= Buttons(cb).X + Buttons(cb).W) THEN
'            IF (my >= Buttons(cb).Y) AND (my < Buttons(cb).Y + _FONTHEIGHT) THEN
'                LINE (Buttons(cb).X, Buttons(cb).Y)-STEP(Buttons(cb).W, _FONTHEIGHT - 1), _RGBA32(230, 230, 230, 235), BF
'            END IF
'        END IF
'    NEXT cb

'    IF mb THEN
'        IF mx >= InputField.X AND my >= DialogY + 3 + _FONTHEIGHT * (3 + totalLines) AND mx <= InputField.X + (FieldArea * CharW - 10) AND my <= DialogY + 3 + _FONTHEIGHT * (3 + totalLines) + _FONTHEIGHT + 4 THEN
'            'Clicking inside the text field positions the cursor
'            WHILE _MOUSEBUTTON(1)
'                _LIMIT 500
'                mb = _MOUSEINPUT
'            WEND
'            Cursor = ((mx - InputField.X) / CharW) + (InputViewStart - 1)
'            IF Cursor > LEN(NewValue) THEN Cursor = LEN(NewValue)
'            Selected = 0
'            RETURN
'        END IF

'        FOR cb = 1 TO TotalButtons
'            IF (mx >= Buttons(cb).X) AND (mx <= Buttons(cb).X + Buttons(cb).W) THEN
'                IF (my >= Buttons(cb).Y) AND (my < Buttons(cb).Y + _FONTHEIGHT) THEN
'                    DefaultButton = cb
'                    WHILE _MOUSEBUTTON(1): _LIMIT 500: mb = _MOUSEINPUT: WEND
'                    mb = 0: nmx = _MOUSEX: nmy = _MOUSEY
'                    IF nmx = mx AND nmy = my THEN DIALOGRESULT = cb
'                    RETURN
'                END IF
'            END IF
'        NEXT cb
'    END IF
'    RETURN
'END FUNCTION

'FUNCTION hsb~& (__H AS _FLOAT, __S AS _FLOAT, __B AS _FLOAT, A AS _FLOAT)
'    'method adapted form http://stackoverflow.com/questions/4106363/converting-rgb-to-hsb-colors
'    DIM H AS _FLOAT, S AS _FLOAT, B AS _FLOAT

'    H = map(__H, 0, 255, 0, 360)
'    S = map(__S, 0, 255, 0, 1)
'    B = map(__B, 0, 255, 0, 1)

'    IF S = 0 THEN
'        hsb~& = _RGBA32(B * 255, B * 255, B * 255, A)
'        EXIT FUNCTION
'    END IF

'    DIM fmx AS _FLOAT, fmn AS _FLOAT
'    DIM fmd AS _FLOAT, iSextant AS INTEGER
'    DIM imx AS INTEGER, imd AS INTEGER, imn AS INTEGER

'    IF B > .5 THEN
'        fmx = B - (B * S) + S
'        fmn = B + (B * S) - S
'    ELSE
'        fmx = B + (B * S)
'        fmn = B - (B * S)
'    END IF

'    iSextant = INT(H / 60)

'    IF H >= 300 THEN
'        H = H - 360
'    END IF

'    H = H / 60
'    H = H - (2 * INT(((iSextant + 1) MOD 6) / 2))

'    IF iSextant MOD 2 = 0 THEN
'        fmd = (H * (fmx - fmn)) + fmn
'    ELSE
'        fmd = fmn - (H * (fmx - fmn))
'    END IF

'    imx = _ROUND(fmx * 255)
'    imd = _ROUND(fmd * 255)
'    imn = _ROUND(fmn * 255)

'    SELECT CASE INT(iSextant)
'        CASE 1
'            hsb~& = _RGBA32(imd, imx, imn, A)
'        CASE 2
'            hsb~& = _RGBA32(imn, imx, imd, A)
'        CASE 3
'            hsb~& = _RGBA32(imn, imd, imx, A)
'        CASE 4
'            hsb~& = _RGBA32(imd, imn, imx, A)
'        CASE 5
'            hsb~& = _RGBA32(imx, imn, imd, A)
'        CASE ELSE
'            hsb~& = _RGBA32(imx, imd, imn, A)
'    END SELECT
'END FUNCTION

'SUB getEquation
'    DIM inputStatus AS INTEGER
'    CLS
'    inputStatus = INPUTBOX("Equation Editor", "Enter the expression for z = (ex. x*y)", mainEquation, mainEquation, -1)
'    IF (inputStatus = 2) THEN END
'END SUB

'FUNCTION map! (value!, minRange!, maxRange!, newMinRange!, newMaxRange!)
'    map! = ((value! - minRange!) / (maxRange! - minRange!)) * (newMaxRange! - newMinRange!) + newMinRange!
'END FUNCTION

