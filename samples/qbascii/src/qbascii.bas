'*****************************************************************************
' Name:         QBASCII.BAS
' Author:       Jeremy Munn
' Date:         07/28/2012
' Description:  ASCII drawing program with save & load features.
'*****************************************************************************

$NoPrefix
DefInt A-Z

'*****************************************************************************
' CONSTANTS
'*****************************************************************************
' Common constants
Const FALSE = 0, TRUE = Not FALSE

' Keys constants
Const KEYS.TAB = 9
Const KEYS.RETURN = 13
Const KEYS.ESCAPE = 27
Const KEYS.SPACE = 32
Const KEYS.UP = 72
Const KEYS.LEFT = 75
Const KEYS.RIGHT = 77
Const KEYS.DOWN = 80
Const KEYS.PAGEUP = 73
Const KEYS.PAGEDOWN = 81
Const KEYS.BACKSPACE = 8
Const KEYS.INSERT = 82
Const KEYS.DELETE = 83
Const KEYS.HOME = 71
Const KEYS.END = 79

Const KEYS.CTRL.N = 14
Const KEYS.CTRL.O = 15
Const KEYS.CTRL.S = 19
Const KEYS.CTRL.Q = 17

Const KEYS.CTRL.LEFT = 115
Const KEYS.CTRL.RIGHT = 116
Const KEYS.CTRL.PAGEUP = 132
Const KEYS.CTRL.PAGEDOWN = 118
Const KEYS.CTRL.HOME = 119
Const KEYS.CTRL.END = 117

Const KEYS.F1 = 59

' Style constants
Const STYLE.FILL.NONE = 1
Const STYLE.FILL.SOLID = 2
Const STYLE.BORDER.SINGLE = 4
Const STYLE.BORDER.DOUBLE = 8
Const STYLE.BORDER.SOLID = 16
Const STYLE.BORDER.MIXED = 32
Const STYLE.BORDER.MIXEDINV = 64

' Program-specific constants
Const SCREEN.WIDTH = 80
Const SCREEN.HEIGHT = 25

'*****************************************************************************
' USER-DEFINED TYPES
'*****************************************************************************
Type AsciiType
    code As Integer
    row As Integer
    col As Integer
    fg As Integer
    bg As Integer
End Type

'*****************************************************************************
' SUB / FUNCTION DECLARATIONS
'*****************************************************************************
DECLARE SUB Mouse (funk)

DECLARE SUB AddAsciiToBuffer (pAscii AS AsciiType)
DECLARE SUB Center (pRow, pText$)
DECLARE SUB ClearAsciiBuffer (pBufferId, pLength)
DECLARE SUB DrawAscii (pAscii AS AsciiType)
DECLARE SUB DrawWindow (pR1, pC1, pR2, pC2, pStyle, pTitle$)
DECLARE SUB GetAsciiFromBuffer (pAscii AS AsciiType)
DECLARE SUB ShowAsciiSelection (pAscii AS AsciiType)
DECLARE SUB Init ()
DECLARE SUB LoadFile ()
DECLARE SUB SaveFile ()
DECLARE SUB ShiftAsciiColumn (pRow, pCol, pLength)
DECLARE SUB DrawRow (pRow)
DECLARE SUB DrawStatusBar (pAscii AS AsciiType, showStatus)
DECLARE SUB ShowUsage ()


DECLARE FUNCTION GetRowFromBuffer (pBufferId)
DECLARE FUNCTION GetColFromBuffer (pBufferId)
DECLARE FUNCTION GetRowColBuffer (pRow, pCol)
DECLARE FUNCTION ConfirmQuit ()
DECLARE FUNCTION ConfirmNewFile ()
DECLARE FUNCTION QBInput$ (pLength, pDefault$)
DECLARE FUNCTION Trim$ (pString$)

'*****************************************************************************
' GLOBAL VARIABLES
'*****************************************************************************
Dim Shared gBlankAscii As AsciiType
Dim Shared gAsciiBuffer(SCREEN.WIDTH * SCREEN.HEIGHT) As AsciiType
Dim Shared gFileName$
Dim Shared mouseV, mouseH, mouseB

'*****************************************************************************
' INITIALIZE
'*****************************************************************************
Screen 0: Color 7, 0: Cls
Mouse 0

Dim ascii As AsciiType, oldAscii As AsciiType

gFileName$ = "UNTITLED.QBA"
gBlankAscii.code = 0
gBlankAscii.fg = 7
gBlankAscii.bg = 0

ascii.code = 1
ascii.row = 12
ascii.col = 40
ascii.fg = 7
ascii.bg = 0

oldAscii = ascii
oldMouseV = mouseV
oldMouseH = mouseH
oldMouseB = mouseB
ClearAsciiBuffer -1, -1
isInsertMode = FALSE
isDeleteMode = FALSE
isQuit = FALSE

'*****************************************************************************
' MAIN
'*****************************************************************************
DrawAscii oldAscii
DrawAscii ascii

oldAscii = ascii
GetAsciiFromBuffer oldAscii

needsRender = TRUE

Do
    keyPress$ = InKey$
    Mouse 3
 
    If oldMouseV <> mouseV Or oldMouseH <> mouseH Or oldMouseB <> mouseB Then
        needsRender = TRUE
     
        If mouseV <> ascii.row Then
            If mouseV > 0 And mouseV <= SCREEN.HEIGHT Then
                ascii.row = mouseV
            End If
        End If

        If mouseH <> ascii.col Then
            If mouseH > 0 And mouseH <= SCREEN.WIDTH Then
                ascii.col = mouseH
            End If
        End If

        If mouseB = 1 And Not isInsertMode Then
            AddAsciiToBuffer ascii
        End If

        If mouseB = 2 And Not isInsertMode Then
            isDeleteMode = TRUE
            bufferId = GetRowColBuffer(ascii.row, ascii.col)
            ClearAsciiBuffer bufferId, 1
        Else
            isDeleteMode = FALSE
        End If
    End If

    If keyPress$ > "" Then
        needsRender = TRUE

        Select Case Asc(keyPress$)
         
            Case KEYS.TAB
                If Not isInsertMode Then
                    ShowAsciiSelection ascii
                End If
         
            Case KEYS.ESCAPE
                pShowStatus = Not pShowStatus

                If Not pShowStatus Then
                    DrawStatusBar ascii, FALSE
                End If
         
            Case KEYS.SPACE
                If Not isInsertMode Then
                    AddAsciiToBuffer ascii
                Else
                    If ascii.col < SCREEN.WIDTH Then
                        bufferId = GetRowColBuffer(ascii.row, SCREEN.WIDTH)
                     
                        'Only shift if the last column is blank
                        If gAsciiBuffer(bufferId).code = gBlankAscii.code Then
                            ShiftAsciiColumn ascii.row, ascii.col, 1
                            ascii.col = ascii.col + 1
                        End If
                    End If
                End If
         
            Case KEYS.BACKSPACE
                If isInsertMode Then
                    If ascii.col > 1 Then
                        ShiftAsciiColumn ascii.row, ascii.col, -1
                        ascii.col = ascii.col - 1
                    End If
                End If
         
            Case Is > 32
                If Not isInsertMode Then
                    ascii.code = Asc(keyPress$)
                End If
         
            Case Else
                Select Case Asc(Right$(keyPress$, 1))
                 
                    Case KEYS.UP
                        ascii.row = ascii.row - 1
                        If ascii.row < 1 Then ascii.row = SCREEN.HEIGHT
                 
                    Case KEYS.DOWN
                        ascii.row = ascii.row + 1
                        If ascii.row > SCREEN.HEIGHT Then ascii.row = 1
                 
                    Case KEYS.RIGHT
                        ascii.col = ascii.col + 1
                        If ascii.col > SCREEN.WIDTH Then ascii.col = 1
                 
                    Case KEYS.LEFT
                        ascii.col = ascii.col - 1
                        If ascii.col < 1 Then ascii.col = SCREEN.WIDTH

                    Case KEYS.CTRL.LEFT
                        'starting at current position -1, find the previous non-space char
                        'if already at first non-space char, set row, col to first
                        bufferId = GetRowColBuffer(ascii.row, ascii.col)
                        For i = bufferId - 1 To 1 Step -1
                            If gAsciiBuffer(i).code > gBlankAscii.code Then
                                Exit For
                            End If
                        Next i

                        If i < 1 Then i = 1

                        ascii.row = GetRowFromBuffer(i)
                        ascii.col = GetColFromBuffer(i)

                    Case KEYS.CTRL.RIGHT
                        'starting at current position +1, find the next non-space char
                        'if already at last non-space char, set row, col to last
                        bufferId = GetRowColBuffer(ascii.row, ascii.col)
                        For i = bufferId + 1 To UBound(gAsciiBuffer)
                            If gAsciiBuffer(i).code > gBlankAscii.code Then
                                Exit For
                            End If
                        Next i

                        If i > UBound(gAsciiBuffer) Then i = UBound(gAsciiBuffer)

                        ascii.row = GetRowFromBuffer(i)
                        ascii.col = GetColFromBuffer(i)
                 
                    Case KEYS.HOME
                        'left-to-right, find first blank char
                        'if ascii.col already at first blank char, set col to 1
                        'if blank char not found, set col to 1
                        For c = 1 To SCREEN.WIDTH
                            bufferId = GetRowColBuffer(ascii.row, c)
                            If gAsciiBuffer(bufferId).code <> gBlankAscii.code Then
                                If ascii.col = c Then c = 1
                                Exit For
                            End If
                        Next c

                        If c > SCREEN.WIDTH Then c = 1

                        ascii.col = c

                    Case KEYS.END
                        'right-to-left, find first blank char
                        'if ascii.col already at last blank char, set col to last col
                        'if blank char not found, set col to last col
                        For c = SCREEN.WIDTH To 1 Step -1
                            bufferId = GetRowColBuffer(ascii.row, c)
                            If gAsciiBuffer(bufferId).code <> gBlankAscii.code Then
                                If ascii.col = c Then c = SCREEN.WIDTH
                                Exit For
                            End If
                        Next c

                        If c < 1 Then c = SCREEN.WIDTH

                        ascii.col = c

                    Case KEYS.CTRL.HOME
                        'start from buffer(1) loop until non-space char
                        'if already at first non-space char, set row, col to 1
                        For i = 1 To UBound(gAsciiBuffer)
                            If gAsciiBuffer(i).code <> 32 Then
                                bufferRow = GetRowFromBuffer(i)
                                bufferCol = GetColFromBuffer(i)
                                                         
                                If ascii.row = bufferRow And ascii.col = bufferCol Then
                                    i = 1
                                End If

                                Exit For
                            End If
                        Next i

                        If i > UBound(gAsciiBuffer) Then i = 1
                     
                        ascii.row = GetRowFromBuffer(i)
                        ascii.col = GetColFromBuffer(i)

                    Case KEYS.CTRL.END
                        'start from UBOUND(buffer) loop down until non-space char
                        'if already at last non-space char, set row, col to last
                        For i = UBound(gAsciiBuffer) To 1 Step -1
                            If gAsciiBuffer(i).code <> 32 Then
                                bufferRow = GetRowFromBuffer(i)
                                bufferCol = GetColFromBuffer(i)

                                If ascii.row = bufferRow And ascii.col = bufferCol Then
                                    i = UBound(gAsciiBuffer)
                                End If

                                Exit For
                            End If
                        Next i

                        If i < 1 Then i = UBound(gAsciiBuffer)

                        ascii.row = GetRowFromBuffer(i)
                        ascii.col = GetColFromBuffer(i)

                    Case KEYS.PAGEUP
                        ascii.fg = ascii.fg + 1
                        If ascii.fg > 15 Then ascii.fg = 0
                 
                    Case KEYS.PAGEDOWN
                        ascii.fg = ascii.fg - 1
                        If ascii.fg < 0 Then ascii.fg = 15
                 
                    Case KEYS.CTRL.PAGEUP
                        ascii.bg = ascii.bg + 1
                        If ascii.bg > 7 Then ascii.bg = 0
                 
                    Case KEYS.CTRL.PAGEDOWN
                        ascii.bg = ascii.bg - 1
                        If ascii.bg < 0 Then ascii.bg = 7
                 
                    Case KEYS.CTRL.N
                        If ConfirmNewFile Then Run

                    Case KEYS.CTRL.O
                        LoadFile
                 
                    Case KEYS.CTRL.S
                        SaveFile

                    Case KEYS.CTRL.Q
                        isQuit = ConfirmQuit
                 
                    Case KEYS.INSERT
                        isInsertMode = Not isInsertMode
                        DrawAscii oldAscii

                    Case KEYS.DELETE
                        If Not isInsertMode Then
                            bufferId = GetRowColBuffer(ascii.row, ascii.col)
                            ClearAsciiBuffer bufferId, 1
                        Else
                            ShiftAsciiColumn ascii.row, ascii.col + 1, -1
                        End If

                        'Only shift if the last column is blank
                        'IF gAsciiBuffer(bufferId).code = gBlankAscii.code THEN
                        '  ShiftAsciiColumn ascii.row, ascii.col, 1
                        '  ascii.col = ascii.col + 1
                        'END IF

                    Case KEYS.F1
                        ShowUsage

                End Select
        End Select
    End If 'IF keyPress$ > ""

    If needsRender Then
        If Not isInsertMode Then
            DrawAscii oldAscii
            DrawAscii ascii
        End If

        If pShowStatus Then
            DrawStatusBar ascii, TRUE
         
            'need this extra DrawAscii call because ascii would get overwritten
            ' after DrawStatusBar
            'DrawAscii ascii
        End If

        needsRender = FALSE
    End If

    If isInsertMode Then
        Locate ascii.row, ascii.col, 1, 29, 31
    ElseIf isDeleteMode Then
        Locate ascii.row, ascii.col, 1, 1, 4
    Else
        Locate , , 0 ' Turn the cursor off
    End If

    oldAscii = ascii
    GetAsciiFromBuffer oldAscii

    oldMouseV = mouseV
    oldMouseH = mouseH
    oldMouseB = mouseB
Loop Until isQuit

'*****************************************************************************
' CLEANUP
'*****************************************************************************
Color 7, 0
Locate , , 0 ' Turn the cursor off
System 0

Sub AddAsciiToBuffer (pAscii As AsciiType)
    bufferId = GetRowColBuffer(pAscii.row, pAscii.col)

    gAsciiBuffer(bufferId).code = pAscii.code
    gAsciiBuffer(bufferId).row = pAscii.row
    gAsciiBuffer(bufferId).col = pAscii.col
    gAsciiBuffer(bufferId).fg = pAscii.fg
    gAsciiBuffer(bufferId).bg = pAscii.bg
End Sub

Sub Center (pRow, pText$)
    iLength = Len(pText$)

    If iLength < 1 Or iLength > 80 Then iLength = 80
    If pRow < 1 Or pRow > 25 Then pRow = CsrLin

    iRelPos = (SCREEN.WIDTH / 2) - (iLength / 2)

    Locate pRow, iRelPos
    Print pText$;
End Sub

Sub ClearAsciiBuffer (pBufferId, pLength)
    bufferStart = 1
    If pBufferId > 0 Then bufferStart = pBufferId
 
    bufferLength = UBound(gAsciiBuffer)
    If pLength > 0 Then bufferLength = pLength

    For i = bufferStart To (bufferStart + bufferLength) - 1
        gBlankAscii.row = GetRowFromBuffer(i)
        gBlankAscii.col = GetColFromBuffer(i)
    
        gAsciiBuffer(i) = gBlankAscii
        DrawAscii gAsciiBuffer(i)
    Next i
End Sub

Function ConfirmNewFile
    newFile = FALSE
    PCopy 0, 1
    Color 15, 4
    Locate , , 0 ' Turn the cursor off
    DrawWindow 10, 14, -1, -1, STYLE.BORDER.MIXEDINV + STYLE.FILL.SOLID, "Start New File"
    Center 12, "Are you sure you want to start a new file? (Y/N)"
    ans$ = Input$(1)
    If UCase$(ans$) = "Y" Then newFile = TRUE
    PCopy 1, 0
    ConfirmNewFile = newFile
End Function

Function ConfirmQuit
    isQuit = FALSE
    PCopy 0, 1
    Color 15, 4
    Locate , , 0 ' Turn the cursor off
    DrawWindow 10, 20, -1, -1, STYLE.BORDER.MIXEDINV + STYLE.FILL.SOLID, "Quit QBASCII"
    Center 12, "Are you sure you want to quit? (Y/N)"
    ans$ = Input$(1)
    If UCase$(ans$) = "Y" Then isQuit = TRUE
    PCopy 1, 0
    ConfirmQuit = isQuit
End Function

Sub DrawAscii (pAscii As AsciiType)
    Color pAscii.fg, pAscii.bg
    Locate pAscii.row, pAscii.col, 0 'Make sure the cursor is off
    Print Chr$(pAscii.code);
End Sub

Sub DrawRow (pRow)
    bufferId = GetRowColBuffer(pRow, 1)
    Dim rowAscii As AsciiType
    For i = 1 To SCREEN.WIDTH
        rowAscii.row = pRow
        rowAscii.col = i

        GetAsciiFromBuffer rowAscii
        DrawAscii rowAscii
    Next i
End Sub

Sub DrawStatusBar (pAscii As AsciiType, pShowStatus)
    Static row
    Static oldRow

    If Not pShowStatus Then
        DrawRow row
        Exit Sub
    End If

    If row = 0 Then
        oldRow = 25
        row = 25
    End If
 
    If pAscii.row = 25 Then
        oldRow = row
        row = 1

        If row <> oldRow Then
            DrawRow oldRow
        End If

    ElseIf pAscii.row = 1 Then
        oldRow = row
        row = 25

        If row <> oldRow Then
            DrawRow oldRow
        End If
    End If
 
    Color 0, 7
    Locate row, 1
    Print "Char: "; Chr$(pAscii.code); " ";
    Print "Code: ";
    Print Using "###"; pAscii.code;
    Print " row: ";: Print Using "##"; pAscii.row;
    Print " col: ";: Print Using "##"; pAscii.col;
    Print " FG: ";: Color pAscii.fg, 0: Print Chr$(219);
    Color 0, 7
    Print " BG: ";: Color pAscii.bg, 0: Print Chr$(219);
    Color 0, 7:
    Print "                ";
    Print Using "File: \           \"; gFileName$;
End Sub

Sub DrawWindow (pR1, pC1, pR2, pC2, pStyle, pTitle$)
    Dim styles$

    Select Case pStyle
        Case Is > STYLE.BORDER.MIXEDINV
            styles$ = Chr$(205) + Chr$(179) + Chr$(213) + Chr$(184) + Chr$(212) + Chr$(190)
            pStyle = pStyle - STYLE.BORDER.MIXEDINV
        Case Is > STYLE.BORDER.MIXED
            styles$ = Chr$(196) + Chr$(186) + Chr$(214) + Chr$(183) + Chr$(211) + Chr$(189)
            pStyle = pStyle - STYLE.BORDER.MIXED
        Case Is > STYLE.BORDER.DOUBLE
            styles$ = Chr$(205) + Chr$(186) + Chr$(201) + Chr$(187) + Chr$(200) + Chr$(188)
            pStyle = pStyle - STYLE.BORDER.DOUBLE
        Case Is > STYLE.BORDER.SINGLE
            styles$ = Chr$(196) + Chr$(179) + Chr$(218) + Chr$(191) + Chr$(192) + Chr$(217)
            pStyle = pStyle - STYLE.BORDER.SINGLE
        Case Is > STYLE.BORDER.SOLID
            styles$ = Chr$(219) + Chr$(219) + Chr$(219) + Chr$(219) + Chr$(219) + Chr$(219)
            pStyle = pStyle - STYLE.BORDER.SOLID
    End Select

    If pR2 = -1 Then
        pR2 = SCREEN.HEIGHT - pR1
    End If

    If pC2 = -1 Then
        pC2 = SCREEN.WIDTH - pC1
    End If

    Locate pR1, pC1: Print Mid$(styles$, 3, 1);
    For col = pC1 + 1 To pC2 - 1
        Locate pR1, col: Print Mid$(styles$, 1, 1);
    Next col

    If pTitle$ <> "" Then
        pTitle$ = "[ " + pTitle$ + " ]"
        iCenter = pC1 + ((pC2 - pC1) \ 2)
        Locate pR1, iCenter - (Len(pTitle$) \ 2)
        Print pTitle$;
    End If

    Locate pR1, pC2: Print Mid$(styles$, 4, 1);
    For row = pR1 + 1 To pR2 - 1
        Locate row, pC1: Print Mid$(styles$, 2, 1);
        If pStyle = STYLE.FILL.SOLID Then
            Print String$(pC2 - pC1 - 1, " ");
        End If
        Locate row, pC2: Print Mid$(styles$, 2, 1);
    Next row
    Locate pR2, pC1: Print Mid$(styles$, 5, 1);
    For col = pC1 + 1 To pC2 - 1
        Locate pR2, col: Print Mid$(styles$, 1, 1);
    Next col
    Locate pR2, pC2: Print Mid$(styles$, 6, 1);
End Sub

Sub GetAsciiFromBuffer (pAscii As AsciiType)
    bufferId = GetRowColBuffer(pAscii.row, pAscii.col)
 
    pAscii.code = gAsciiBuffer(bufferId).code
    pAscii.row = gAsciiBuffer(bufferId).row
    pAscii.col = gAsciiBuffer(bufferId).col
    pAscii.fg = gAsciiBuffer(bufferId).fg
    pAscii.bg = gAsciiBuffer(bufferId).bg
End Sub

Function GetColFromBuffer (pBufferId)
    row = GetRowFromBuffer(pBufferId)
    GetColFromBuffer = SCREEN.WIDTH - ((row * SCREEN.WIDTH) - pBufferId)
End Function

Function GetRowColBuffer (pRow, pCol)
    GetRowColBuffer = (SCREEN.WIDTH * pRow) - SCREEN.WIDTH + pCol
End Function

Function GetRowFromBuffer (pBufferId)
    GetRowFromBuffer = Int((pBufferId - 1) / SCREEN.WIDTH) + 1
End Function

Sub LoadFile
    PCopy 0, 1
    Color 15, 1
    Locate , , 0 ' Turn the cursor off
    DrawWindow 10, 23, -1, -1, STYLE.BORDER.MIXEDINV + STYLE.FILL.SOLID, "Load QBASCII File"
    Center 12, "Filename: " + Space$(12)
    Locate , Pos(0) - 12
    Color 15, 0
    Print Space$(12);
    Locate , Pos(0) - 12 'Locate to beginning of input
    Color 15, 0
    fileInput$ = QBInput$(12, gFileName$)
    PCopy 1, 0
    If fileInput$ <> "" Then
        isValidFile = TRUE
        isFileFound = FALSE

        If Not UCase$(Right$(Trim$(fileInput$), 4)) = ".QBA" Then
            If Len(fileInput$) <= 8 Then
                fileInput$ = fileInput$ + ".QBA"
            Else
                isValidFile = FALSE
            End If
        End If

        If isValidFile Then
            gFileName$ = UCase$(fileInput$)
            Open gFileName$ For Binary As #1
            If LOF(1) > 0 Then isFileFound = TRUE
            Close #1
     
            If isFileFound Then
                Open gFileName$ For Random As #1 Len = Len(gBlankAscii)
                For i = 1 To SCREEN.WIDTH * SCREEN.HEIGHT
                    Get #1, i, gAsciiBuffer(i)
                Next i
                Close #1

                For i = 1 To SCREEN.WIDTH * SCREEN.HEIGHT
                    DrawAscii gAsciiBuffer(i)
                Next i

                PCopy 0, 1
                Color 15, 1
                DrawWindow 11, 25, -1, -1, STYLE.BORDER.MIXEDINV + STYLE.FILL.SOLID, ""
                Center 12, gFileName$ + " Loaded"
                Sleep 2
                PCopy 1, 0
            Else
                Kill gFileName$
                PCopy 0, 1
                Color 15, 4
                DrawWindow 11, 25, -1, -1, STYLE.BORDER.MIXEDINV + STYLE.FILL.SOLID, ""
                Center 12, "File not found: " + gFileName$
                Sleep 2
                PCopy 1, 0
            End If 'isFileFound
        Else
            PCopy 0, 1
            Color 15, 4
            DrawWindow 11, 25, -1, -1, STYLE.BORDER.MIXEDINV + STYLE.FILL.SOLID, ""
            Center 12, "Invalid File Name"
            Sleep 2
            PCopy 1, 0
        End If 'isValidFile
    End If 'fileInput$ <> ""
End Sub

Sub Mouse (funk)
    '"QBMouse.bas" Written 1999 by: Daryl R. Dubbs

    'SHARED mouseH, mouseV, mouseB
    Static crsr 'track whether Cursor is shown
    If funk% = 1 Then crsr = 1 'show Cursor
    If funk% = 2 And crsr = 0 Then Exit Sub 'don't hide cursor more than onced
    If funk% = 2 And crsr = 1 Then crsr = 0 'Hide cursor

    Poke 100, 184: Poke 101, funk: Poke 102, 0 'Poke machine code necessary for
    Poke 103, 205: Poke 104, 51: Poke 105, 137 'using the mouse into memeory
    Poke 106, 30: Poke 107, 170: Poke 108, 10 'starting at offset 100 in the
    Poke 109, 137: Poke 110, 14: Poke 111, 187 'current segment. This code
    Poke 112, 11: Poke 113, 137: Poke 114, 22 'then executed as a unit, via the
    Poke 115, 204: Poke 116, 12: Poke 117, 203 'statement "Call Absolute"
    Call Absolute(100) 'Call machine code
    
    mouseB = Peek(&HAAA) 'Get values for buttons
    mouseH = CInt((Peek(&HBBB) + Peek(&HBBC) * 256) / 8) 'Horizontal position (2 bytes)
    mouseV = CInt((Peek(&HCCC) + Peek(&HCCD) * 256) / 8) 'Vertical position (2 bytes)
End Sub

Function QBInput$ (pLength, pDefault$)
    inputLength = pLength
    defaultLength = Len(pDefault$)

    If defaultLength > inputLength Then inputLength = defaultLength

    inputText$ = Space$(inputLength)

    If defaultLength > 0 Then Mid$(inputText$, 1) = pDefault$

    iCsrPos = 0
    rowOffset = CsrLin
    colOffset = Pos(0)

    Locate , , 1, 0, 1
    Print inputText$;
    Do
        keyPress$ = InKey$

        If keyPress$ > "" Then
            Select Case Asc(keyPress$)
            
                Case KEYS.ESCAPE
                    inputText$ = ""
                    isCancel = TRUE
            
                Case KEYS.RETURN
                    isReturn = TRUE

                Case KEYS.BACKSPACE
                    If iCsrPos > 0 Then
                        iCsrPos = iCsrPos - 1
                        For i = iCsrPos To inputLength - 1
                            Mid$(inputText$, i + 1) = Mid$(inputText$, i + 2, 1)
                        Next i
                        Mid$(inputText$, inputLength) = " "
                    Else
                    End If

                    ' 0-9 A-Z, a-z
                Case 48 TO 57, 65 TO 90, 97 TO 122
                    If isInsert Then
                        If iCsrPos < inputLength Then iCsrPos = iCsrPos + 1
                        Mid$(inputText$, iCsrPos) = keyPress$
                    Else
                        If Right$(inputText$, 1) = " " Then
                            If iCsrPos < inputLength Then
                                iCsrPos = iCsrPos + 1
                                If iCsrPos <> inputLength Then
                                    s$ = Mid$(inputText$, iCsrPos, inputLength - 1)
                                    Mid$(inputText$, iCsrPos + 1) = s$
                                End If
                                Mid$(inputText$, iCsrPos) = keyPress$
                            End If
                        End If
                    End If
                    
                    If iCsrPos = inputLength Then iCsrPos = iCsrPos - 1
            
                Case Else
                
                    Select Case Asc(Right$(keyPress$, 1))
                    
                        Case KEYS.INSERT
                            isInsert = Not isInsert
                         
                        Case KEYS.DELETE
                            For i = iCsrPos To inputLength - 1
                                If i = inputLength - 1 Then
                                    Mid$(inputText$, inputLength) = " "
                                Else
                                    Mid$(inputText$, i + 1) = Mid$(inputText$, i + 2, 1)
                                End If
                            Next i

                        Case KEYS.HOME
                            iCsrPos = 0

                        Case KEYS.END
                            iCsrPos = inputLength - 1
                    
                        Case KEYS.LEFT
                            If iCsrPos > 0 Then iCsrPos = iCsrPos - 1

                        Case KEYS.RIGHT
                            If iCsrPos < inputLength - 1 Then iCsrPos = iCsrPos + 1

                    End Select

            End Select

            Locate , colOffset: Print inputText$;

        End If

        If isInsert Then
            Locate , , 1, 0, 31
        Else
            Locate , , 1, 29, 31
        End If
        Locate rowOffset, colOffset + iCsrPos
     
    Loop Until isCancel Or isReturn

    'Turn cursor off
    Locate , , 0

    QBInput = LTrim$(RTrim$(inputText$))
End Function

Sub SaveFile
    PCopy 0, 1
    Color 15, 1
    Locate , , 0 ' Turn the cursor off
    DrawWindow 10, 23, -1, -1, STYLE.BORDER.MIXEDINV + STYLE.FILL.SOLID, "Save QBASCII File"
    Center 12, "Filename: " + Space$(12)
    Locate , Pos(0) - 12
    Color 15, 0
    Print Space$(12);
    Locate , Pos(0) - 12
    fileInput$ = QBInput$(12, gFileName$)
    PCopy 1, 0
    If fileInput$ <> "" Then
        isValidFile = TRUE
        isFileFound = FALSE

        If Not UCase$(Right$(Trim$(fileInput$), 4)) = ".QBA" Then
            If Len(fileInput$) <= 8 Then
                fileInput$ = fileInput$ + ".QBA"
            Else
                isValidFile = FALSE
            End If
        End If
        
        If isValidFile Then
            gFileName$ = UCase$(fileInput$)
            Open gFileName$ For Random As #1 Len = Len(gBlankAscii)
            For i = 1 To UBound(gAsciiBuffer)
                Put #1, i, gAsciiBuffer(i)
            Next i
            Close #1

            PCopy 0, 1
            Color 15, 1
            DrawWindow 11, 25, -1, -1, STYLE.BORDER.MIXEDINV + STYLE.FILL.SOLID, ""
            Center 12, gFileName$ + " Saved"
            Sleep 2
            PCopy 1, 0
        Else
            PCopy 0, 1
            Color 15, 4
            DrawWindow 11, 25, -1, -1, STYLE.BORDER.MIXEDINV + STYLE.FILL.SOLID, ""
            Center 12, "Invalid File Name"
            Sleep 2
            PCopy 1, 0
        End If 'isValidFile
    End If 'fileInput$ <> ""
End Sub

Sub ShiftAsciiColumn (pRow, pCol, pShiftDir)
    bufferId = GetRowColBuffer(pRow, pCol)
    pLength = SCREEN.WIDTH - pCol

    If pShiftDir > 0 Then
        For i = bufferId + pLength To bufferId Step -1
            gAsciiBuffer(i).code = gAsciiBuffer(i - 1).code
            gAsciiBuffer(i).fg = gAsciiBuffer(i - 1).fg
            gAsciiBuffer(i).bg = gAsciiBuffer(i - 1).bg
            DrawAscii gAsciiBuffer(i)
        Next i

        ClearAsciiBuffer bufferId, 1
    Else
        For i = bufferId - 1 To bufferId + pLength
            gAsciiBuffer(i).code = gAsciiBuffer(i + 1).code
            gAsciiBuffer(i).fg = gAsciiBuffer(i + 1).fg
            gAsciiBuffer(i).bg = gAsciiBuffer(i + 1).bg

            If gAsciiBuffer(i).col = SCREEN.WIDTH Then
                ClearAsciiBuffer i, 1
            Else
                DrawAscii gAsciiBuffer(i)
            End If
        Next i
    End If
End Sub

Sub ShowAsciiSelection (pAscii As AsciiType)
    rowOffset = 4
    colOffset = 22
    colSpacing = 2
    rowMax = 15
    colMax = 17

    PCopy 0, 1
    Color 15, 1
    DrawWindow rowOffset, colOffset, rowOffset + 18, colOffset + 36, STYLE.BORDER.MIXEDINV + STYLE.FILL.SOLID, "Select an ASCII char"

    Color 7, 1
    For r = 1 To rowMax
        For c = 1 To colMax
            asciiCode = asciiCode + 1
            Locate r + rowOffset, c * colSpacing + colOffset
         
            Select Case asciiCode
                Case 1 TO 6, 8, 14 TO 27, Is > 33
                    Print Chr$(asciiCode);
                Case Else
                    Print Chr$(32);
            End Select
            
        Next c
    Next r

    isSelected = FALSE
    isDone = FALSE
    selCode = pAscii.code
    selRow = (selCode + colMax - 1) \ colMax
    selCol = selCode - (selRow * colMax - colMax)
    needsRender = TRUE

    Do
        keyPress$ = InKey$
        Mouse 3

        If oldMouseV <> mouseV Or oldMouseH <> mouseH Or oldMouseB <> mouseB Then
            needsRender = TRUE
        
            If mouseV <> selRow Then
                If mouseV > 0 And mouseV <= rowMax Then
                    selRow = mouseV
                End If
            End If

            If mouseH <> selCol Then
                If mouseH > 0 And mouseH <= colMax Then
                    selCol = mouseH
                End If
            End If

            If mouseB = 1 Then
                isSelected = TRUE
            End If
        End If

        If keyPress$ > "" Then
            needsRender = TRUE
            Select Case Asc(keyPress$)
                Case KEYS.ESCAPE, KEYS.TAB
                    isDone = TRUE
                Case KEYS.RETURN
                    isSelected = TRUE
                Case Else
                    Select Case Asc(Right$(keyPress$, 1))
                        Case KEYS.UP
                            selRow = selRow - 1
                            If selRow < 1 Then selRow = rowMax
                        Case KEYS.DOWN
                            selRow = selRow + 1
                            If selRow > rowMax Then selRow = 1
                        Case KEYS.LEFT
                            selCol = selCol - 1
                            If selCol < 1 Then selCol = colMax
                        Case KEYS.RIGHT
                            selCol = selCol + 1
                            If selCol > colMax Then selCol = 1
                    End Select
            End Select
        End If

        If needsRender Then
            selCode = selRow * colMax - colMax + selCol

            Select Case selCode
                Case 1 TO 6, 8, 14 TO 27, Is > 33
                Case Else
                    selCode = 32
            End Select

            Color 15, 1: Locate rowOffset + 17, colOffset + 9
            Print "ASCII: "; Chr$(selCode); " Code:"; selCode;

            Locate rowOffset + selRow, colOffset + selCol * colSpacing, 1, 0, 4
         
            needsRender = FALSE
        End If
     
        If isSelected Then
            pAscii.code = selCode
        End If

        oldMouseV = mouseV
        oldMouseH = mouseH
        oldMouseB = mouseB
    Loop Until isSelected Or isDone
 
    Locate , , 0 ' Turn the cursor off
    PCopy 1, 0
End Sub

Sub ShowUsage
    PCopy 0, 1
    Color 15, 1
    Locate , , 0 ' Turn the cursor off
    DrawWindow 2, 6, 24, 75, STYLE.BORDER.MIXEDINV + STYLE.FILL.SOLID, "Using QBASCII"
    Locate 3, 8
    Print "                        <F1>   Show usage (this screen)";
    Locate 4, 8
    Print "                    <Escape>   Show / Hide status bar";
    Locate 6, 8
    Print "                    <Ctrl+Q>   Quit";
    Locate 7, 8
    Print "                    <Ctrl+N>   New file";
    Locate 8, 8
    Print "                    <Ctrl+O>   Open file";
    Locate 9, 8
    Print "                    <Ctrl+S>   Save file";
    Locate 11, 8
    Print "  <Up>,<Down>,<Left>,<Right>   Move in specified direction";
    Locate 12, 8
    Print "                     <Space>   Plot ASCII char at position";
    Locate 13, 8
    Print "                       <Tab>   ASCII char selection window";
    Locate 14, 8
    Print "         <PageUp>,<PageDown>   Change char foreground color";
    Locate 15, 8
    Print "<Ctrl+PageUp><Ctrl+PageDown>   Change char background color";
    Locate 16, 8
    Print "    <Ctrl+Left>,<Ctrl+Right>   Move to previous / next char";
    Locate 17, 8
    Print "                <Home>,<End>   Move to first / last char on row";
    Locate 18, 8
    Print "      <Ctrl+Home>,<Ctrl+End>   Move to first / last char on screen";
    Locate 20, 8
    Print "                    <Insert>   Toggle insert mode";
    Locate 21, 8
    Print "       <Space> (insert mode)   Insert a space at position";
    Locate 22, 8
    Print "   <Backspace> (insert mode)   Remove char to left of position";
    Locate 23, 8
    Print "         <Del> (insert mode)   Remove char at position";

    ans$ = Input$(1)
    PCopy 1, 0
End Sub

