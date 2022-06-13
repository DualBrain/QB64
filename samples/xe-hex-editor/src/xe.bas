'============
'XE.BAS v1.10
'============
'A simple Binary File (HEX) editor.
'Coded by Dav on AUG 25, 2011 using QB64.
'Visit my website for more sourcecode at:
'http://www.qbasicnews.com/dav
'
'==========================================================================
'* * * *          USE THIS PROGRAM AT YOUR OWN RISK ONLY!!          * * * *
'==========================================================================
'
' New in XE v1.10:
' ~~~~~~~~~~~~~~~
'
' * ADDED: Now can View/Edit files in TWO modes - HEX (default) or ASCII.
'          ASCII mode allows for faster browsing through the file.
'          Toggle between HEX/ASCII mode by pressing ENTER while viewing.
' * ADDED: Shows Usage information when starting, added help in source.
' * ADDED: Now shows currently opened file in the TITLE menu (full name).
'          Short filename (8.3) is shown at top left line, after FILE:
' * ADDED: Now Uses Win API to test for file instead of using TEMP files.
' * ADDED: Can open file on READ-ONLY medium like CD's (because of above).
' * FIXED: Fixed error in FILTER that prevented letters from showing.
' * FIXED: Fixed several display bugs, and tweaked the layout more.
'
' THINGS TO DO:
'                  Add HEX Searching too.
'                  EAdd TEXT view for reading text files?
'                  Add a Create File option?
'                  Add (I) Info - Display File Information
'                  Add a File Copy to location...
'                  Highlight found text when searching
'
'==========================================================================
'
' ABOUT:
' ~~~~~
'
' XE is a simple Binary File Editor (also called a HEX editor) that lets
' you view and edit raw data bytes of a file.  With XE you can peek inside
' EXE/DLL files and see what information they may contain.  XE also has the
' capacity to change bytes by either typing in ASCII characters or entering
' the HEX value for each byte.
'
' Since the very nature of XE is to alter file data you should always use
' EXTREME caution when editing file - AND ALWAYS MAKE BACKUPS FIRST!
'
'==========================================================================
'
' HOW TO USE:
' ~~~~~~~~~~
'
' XE accepts command line arguments.  You can drag/drop a file onto XE or
' specify a file to load from the command prompt, like "XE.EXE file.ext".
' If you don't specify a filename on startup, XE will ask you for one.
'
' There are TWO ways to View & Edit files - in HEX (default) or ASCII mode.
'
' Files are first opened in HEX mode displaying 2 windows of data.  The
' right window shows the charaters while the larger left window shows HEX
' values for them. HEX mode is best for patching and is the only way to
' edit the HEX values of bytes.
'
'
' Pressing ENTER switches to ASCII (non-HEX) mode, showing a larger page
' of raw data bytes - the ASCII chracter data only.  This mode is best for
' skimming through files faster.  ENTER toggles view mode back and forth.
'
' While viewing a file you can browse through the file using the ARROWS,
' PAGEUP/DOWN, HOME and the END key to scroll up and down.
'
' The currently opened filename is shown with full path in the title bar,
' and its short filename (8.3) is displayed in the FILE: area just below.
'
' While viewing a file, press E to enter into EDIT mode and begin editing
' bytes at the current position. If you're in HEX mode (2 windows), you can
' edit bytes either by typing characters on the right side or entering HEX
' values on the left window.  Press TAB to switch windows to edit in.
' Press ESC to save or disgard changes and to exit editing mode.
'
' Press M for a complete MENU listing all of the Key COMMANDS.
'
'==========================================================================
'
' COMMAND:
' ~~~~~~~~
'
'         E  =  Enters EDIT MODE. Only the displayed bytes can be edited.
'
'       TAB  =  Switchs panes (the cursor) while editing in HEX mode.
'
'         S  =  Searches file for a string starting at the current byte.
'               A Match-Case option is available.  A high beep alerts you
'               when match is found. A Low beep sounds when EOF reached.
'
'         N  =  Finds NEXT Match after a do a string search.
'
'         F  =  Toggles FILTERING of all non-standard-text characters.
'               A flashing "F" is at the top-left corner when FILTER ON.
'
'         G  =  GOTO a certain byte position (number) in the file.
'
'         L  =  GOTO a specified location (Hex value) of the file.
'
'     ENTER  =  Toggles HEX and ASCII view modes.  The ASCII mode lets
'               you browse more data per page.  You can EDIT in both
'               modes but can only enter in HEX vaules in HEX mode.
'
'       ESC  =  EXITS out of editing mode, and also EXITS the program.
'
' ALT+ENTER  =  Toggle FULLSCREEN/WINDOWED mode of the XE program.
'
'==========================================================================
'==========================================================================

Declare Library
    Function GetShortPathNameA (lpszLongPath As String, lpszShortPath As String, Byval cchBuffer As Long)
End Declare

_Title "XE v1.10"

If Command$ = "" Then
    Print
    Print " ============"
    Print " XE.EXE v1.10"
    Print " ============"
    Print " A Simple Binary File (HEX) Editor."
    Print " Coded by Dav AUG 25th, 2011 using QB64"
    Print " Website: http://www.qbasicnews.com/dav"
    Print
    Print " USAGE: Drag & Drop a file on the XE program to open it."
    Print "        Or feed XE a file from the command prompt: XE.EXE filename.ext"
    Print "        You can also specify the file below (you must give full path)."
    Print "        Read XE.TXT or the XE.BAS Source for detailed help."
    Print
    Line Input " FILE TO OPEN> ", File$
    If File$ = "" Then End
Else
    File$ = Command$
End If

ShortFileName$ = Space$(260)
Result = GetShortPathNameA(File$ + Chr$(0), ShortFileName$, Len(ShortFileName$))

If Result = 0 Then
    Print " File not found!"
    End
End If

'=== trim off any spaces...
ShortFileName$ = LTrim$(RTrim$(ShortFileName$))

'=== Just get the 8.3 name, removing any path name
ts$ = ""
For q = Len(ShortFileName$) To 1 Step -1
    t$ = Mid$(ShortFileName$, q, 1)
    If t$ = "/" Or t$ = "\" Then Exit For
    ts$ = t$ + ts$
Next
ShortFileName$ = ts$


Open File$ For Binary As 7

_Title "XE v1.10 - " + File$

DisplayView% = 1 'Default to 2-PANE view

Screen 0: Width 80, 25: Def Seg = &HB800

Color 15, 1: Cls: Locate 1, 1, 0

BC& = 1

If DisplayView% = 1 Then
    Buff% = (16 * 24)
Else
    Buff% = (79 * 24)
End If

If Buff% > LOF(7) Then Buff% = LOF(7)

'======================
' MAIN DISPLAY ROUTINE
'======================

Do
    Seek #7, BC&
    PG$ = Input$(Buff%, 7)

    If DisplayView% = 1 Then
        If Len(PG$) < (16 * 24) Then
            Pflag% = 1: Plimit% = Len(PG$)
            PG$ = PG$ + String$(16 * 24 - Len(PG$), Chr$(0))
        End If

        '=== right window
        y% = 2: x% = 63
        For c% = 1 To Len(PG$)
            tb% = Asc(Mid$(PG$, c%, 1))
            '=== show . instead of a null
            If tb% = 0 Then tb% = 46
            If Filter% = 1 Then
                Select Case tb%
                    Case 0 To 31, 123 To 255: tb% = 32
                End Select
            End If
            Poke (y% - 1) * 160 + (x% - 1) * 2, tb%
            x% = x% + 1: If x% = 79 Then x% = 63: y% = y% + 1
        Next

        '=== show left side
        y% = 2: x% = 15
        For c% = 1 To Len(PG$)
            tb% = Asc(Mid$(PG$, c%, 1))
            tb$ = Hex$(tb%): If Len(tb$) = 1 Then tb$ = "0" + tb$
            Locate y%, x%: Print tb$; " ";
            x% = x% + 3: If x% >= 62 Then x% = 15: y% = y% + 1
        Next

    Else

        '...DisplayView% = 0, Full view...

        If Len(PG$) < (79 * 24) Then 'Enough to fill screen?
            Pflag% = 1: Plimit% = Len(PG$) 'No? Mark this and pad
            PG$ = PG$ + Space$(79 * 24 - Len(PG$)) 'data with spaces.
        End If
        y% = 2: x% = 1 'Screen location where data begins displaying
        For c% = 1 To Len(PG$) 'Show all the bytes.
            tb% = Asc(Mid$(PG$, c%, 1)) 'Check the ASCII value.
            If Filter% = 1 Then 'If Filter is turned on,
                Select Case tb% 'changes these values to spaces
                    Case 0 To 32, 123 To 255: tb% = 32
                End Select
            End If
            Poke (y% - 1) * 160 + (x% - 1) * 2, tb% 'Poke bytes on screen
            'This line calculates when to go to next row.
            x% = x% + 1: If x% = 80 Then x% = 1: y% = y% + 1
        Next

    End If

    GoSub DrawTopBar

    '=== Get user input
    Do
        Do Until L$ <> "": L$ = InKey$: Loop
        K$ = L$: L$ = ""
        GoSub DrawTopBar
        Select Case UCase$(K$)
            Case Chr$(27): Exit Do
            Case "M": GoSub Menu:
            Case "N"
                If s$ <> "" Then
                    GoSub Search
                    GoSub DrawTopBar
                End If
            Case "E"
                If DisplayView% = 1 Then
                    GoSub EditBIN
                Else
                    GoSub EditBin3
                End If
                GoSub DrawTopBar
            Case "F"
                If Filter% = 0 Then Filter% = 1 Else Filter% = 0
            Case "G"
                Locate 1, 1: Print String$(80 * 3, 32);
                Locate 1, 3: Print "TOTAL BYTES>"; LOF(7)
                Input "  GOTO BYTE# > ", GB$
                If GB$ <> "" Then
                    TMP$ = ""
                    For m% = 1 To Len(GB$)
                        G$ = Mid$(GB$, m%, 1) 'to numerical vales
                        Select Case Asc(G$)
                            Case 48 To 57: TMP$ = TMP$ + G$
                        End Select
                    Next: GB$ = TMP$
                    If Val(GB$) < 1 Then GB$ = "1"
                    If Val(GB$) > LOF(7) Then GB$ = Str$(LOF(7))
                    If GB$ <> "" Then BC& = 0 + Val(GB$)
                End If
            Case "L"
                Locate 1, 1: Print String$(80 * 3, 32);
                Locate 1, 3: 'PRINT "TOTAL BYTES>"; LOF(7)
                Input "  GOTO HEX LOCATION-> ", GB$
                If GB$ <> "" Then
                    GB$ = "&H" + GB$
                    If Val(GB$) < 1 Then GB$ = "1"
                    If Val(GB$) > LOF(7) Then GB$ = Str$(LOF(7))
                    If GB$ <> "" Then BC& = 0 + Val(GB$)
                End If
            Case "S": s$ = ""
                Locate 1, 1: Print String$(80 * 3, 32);
                Locate 1, 3: Input "Search for> ", s$
                If s$ <> "" Then
                    Print "  CASE sensitive (Y/N)? ";
                    I$ = Input$(1): I$ = UCase$(I$)
                    If I$ = "Y" Then CaseOn% = 1 Else CaseOn% = 0
                    GoSub Search
                End If
                GoSub DrawTopBar
            Case Chr$(13)
                If DisplayView% = 1 Then
                    DisplayView% = 0
                    Buff% = (79 * 24)
                Else
                    DisplayView% = 1
                    Buff% = (16 * 24)
                End If
                GoSub DrawTopBar
            Case Chr$(0) + Chr$(72)
                If DisplayView% = 1 Then
                    If BC& > 15 Then BC& = BC& - 16
                Else
                    If BC& > 78 Then BC& = BC& - 79
                End If
            Case Chr$(0) + Chr$(80)
                If DisplayView% = 1 Then
                    If BC& < LOF(7) - 15 Then BC& = BC& + 16
                Else
                    If BC& < LOF(7) - 78 Then BC& = BC& + 79
                End If
            Case Chr$(0) + Chr$(73): BC& = BC& - Buff%: If BC& < 1 Then BC& = 1
            Case Chr$(0) + Chr$(81): If BC& < LOF(7) - Buff% Then BC& = BC& + Buff%
            Case Chr$(0) + Chr$(71): BC& = 1
            Case Chr$(0) + Chr$(79): If Not EOF(7) Then BC& = LOF(7) - Buff%
        End Select
    Loop Until K$ <> ""
Loop Until K$ = Chr$(27) 'OR K$ = CHR$(13)

Close 7
Def Seg

System

'==============================================================================
'                                GOSUB ROUTINES
'==============================================================================

'=============
Search:
'=============

'==== A work-a-round for the EOF bug
'CLOSE 7
'OPEN File$ FOR BINARY AS #7
'SEEK 7, BC&
'===================================

If Not EOF(7) Then
    Do
        B$ = Input$(Buff%, 7): BC& = BC& + Buff%
        If CaseOn% = 0 Then B$ = UCase$(B$): s$ = UCase$(s$)
        d$ = InKey$: If d$ <> "" Then Exit Do
        If InStr(1, B$, s$) Then Sound 4000, .5: Exit Do
    Loop Until InStr(1, B$, s$) Or EOF(7)
    If EOF(7) Then Sound 2000, 1: Sound 1000, 1
    BC& = BC& - Len(s$)
End If
Return


'=============
EditBIN:
'=============

Pane% = 1

x% = 63: If rightx% Then y% = CsrLin Else y% = 2
leftx% = 15

test% = Pos(0)

If test% = 15 Or test% = 16 Then x% = 63: leftx% = 15
If test% = 18 Or test% = 19 Then x% = 64: leftx% = 18
If test% = 21 Or test% = 22 Then x% = 65: leftx% = 21
If test% = 24 Or test% = 25 Then x% = 66: leftx% = 24
If test% = 27 Or test% = 28 Then x% = 67: leftx% = 27
If test% = 30 Or test% = 31 Then x% = 68: leftx% = 30
If test% = 33 Or test% = 34 Then x% = 69: leftx% = 33
If test% = 36 Or test% = 37 Then x% = 70: leftx% = 36
If test% = 39 Or test% = 40 Then x% = 71: leftx% = 39
If test% = 42 Or test% = 43 Then x% = 72: leftx% = 42
If test% = 45 Or test% = 46 Then x% = 73: leftx% = 45
If test% = 48 Or test% = 49 Then x% = 74: leftx% = 48
If test% = 51 Or test% = 52 Then x% = 75: leftx% = 51
If test% = 54 Or test% = 55 Then x% = 76: leftx% = 54
If test% = 57 Or test% = 58 Then x% = 77: leftx% = 57
If test% = 60 Or test% = 61 Then x% = 78: leftx% = 60

GoSub DrawEditBar:

Locate y%, x%, 1, 1, 30

Do
    Do
        E$ = InKey$
        If E$ <> "" Then
            Select Case E$
                Case Chr$(9)
                    If Pane% = 1 Then
                        Pane% = 2: GoTo EditBin2
                    Else
                        Pane% = 1: GoTo EditBIN
                    End If
                Case Chr$(27): Exit Do
                Case Chr$(0) + Chr$(72): If y% > 2 Then y% = y% - 1
                Case Chr$(0) + Chr$(80): If y% < 25 Then y% = y% + 1
                Case Chr$(0) + Chr$(75): If x% > 63 Then x% = x% - 1: leftx% = leftx% - 3
                Case Chr$(0) + Chr$(77): If x% < 78 Then x% = x% + 1: leftx% = leftx% + 3
                Case Chr$(0) + Chr$(73), Chr$(0) + Chr$(71): y% = 2
                Case Chr$(0) + Chr$(81), Chr$(0) + Chr$(79): y% = 25
                Case Else
                    'IF (BC& + (y% - 2) * 16 + x% - 1) <= LOF(7) AND E$ <> CHR$(8) THEN
                    If (BC& + ((y% - 2) * 16 + x% - 1) - 62) <= LOF(7) And E$ <> Chr$(8) Then
                        changes% = 1

                        '=== new color for changed bytes...
                        Color 1, 15: Locate y%, x%: Print " ";
                        Locate y%, leftx%
                        tb$ = Hex$(Asc(E$)): If Len(tb$) = 1 Then tb$ = "0" + tb$
                        Print tb$;

                        Poke (y% - 1) * 160 + (x% - 1) * 2, Asc(E$)
                        Mid$(PG$, ((y% - 2) * 16 + x% * 1) - 62) = E$
                        If x% < 78 Then x% = x% + 1: leftx% = leftx% + 3 'skip space
                    End If
            End Select
        End If
    Loop Until E$ <> ""
    Locate y%, x%
Loop Until E$ = Chr$(27)

'===========
SaveChanges:
'===========

If changes% = 1 Then
    Sound 4500, .2: Color 15, 4: Locate , , 0
    Locate 10, 29: Print Chr$(201); String$(21, 205); Chr$(187);
    Locate 11, 29: Print Chr$(186); " Save Changes (Y/N)? "; Chr$(186);
    Locate 12, 29: Print Chr$(200); String$(21, 205); Chr$(188);
    N$ = Input$(1): Color 15, 1
    If UCase$(N$) = "Y" Then
        If Pflag% = 1 Then PG$ = Left$(PG$, Plimit%)
        Put #7, BC&, PG$:
    End If
End If
Color 15, 1: Cls: Locate 1, 1, 0
Return

'===========
EditBin2:
'===========

Color 1, 7
x% = 15: 'y% = 2
rightx% = 63

test% = Pos(0)
If test% = 63 Then x% = 15: rightx% = 63
If test% = 64 Then x% = 18: rightx% = 64
If test% = 65 Then x% = 21: rightx% = 65
If test% = 66 Then x% = 24: rightx% = 66
If test% = 67 Then x% = 27: rightx% = 67
If test% = 68 Then x% = 30: rightx% = 68
If test% = 69 Then x% = 33: rightx% = 69
If test% = 70 Then x% = 36: rightx% = 70
If test% = 71 Then x% = 39: rightx% = 71
If test% = 72 Then x% = 42: rightx% = 72
If test% = 73 Then x% = 45: rightx% = 73
If test% = 74 Then x% = 48: rightx% = 74
If test% = 75 Then x% = 51: rightx% = 75
If test% = 76 Then x% = 54: rightx% = 76
If test% = 77 Then x% = 57: rightx% = 77
If test% = 78 Then x% = 60: rightx% = 78

GoSub DrawEditBar:

Locate y%, x%, 1, 1, 30

Do
    Do
        E$ = InKey$
        If E$ <> "" Then
            Select Case E$
                Case Chr$(9)
                    If Pane% = 1 Then
                        Pane% = 2: GoTo EditBin2
                    Else
                        Pane% = 1: GoTo EditBIN
                    End If
                Case Chr$(27): Exit Do
                Case Chr$(0) + Chr$(72): If y% > 2 Then y% = y% - 1
                Case Chr$(0) + Chr$(80): If y% < 25 Then y% = y% + 1
                Case Chr$(0) + Chr$(75) 'right arrow....
                    If x% > 15 Then
                        Select Case x%
                            Case 17, 18, 20, 21, 23, 24, 26, 27, 29, 30, 32, 33, 35, 36, 38, 39, 41, 42, 44, 45, 47, 48, 50, 51, 53, 54, 56, 57, 59, 60, 62, 63
                                x% = x% - 2
                                rightx% = rightx% - 1
                            Case Else: x% = x% - 1
                        End Select
                    End If
                    'IF rightx% > 63 THEN rightx% = rightx% - 1
                Case Chr$(0) + Chr$(77)
                    If x% < 61 Then
                        Select Case x%
                            Case 16, 17, 19, 20, 22, 23, 25, 26, 28, 29, 31, 32, 34, 35, 37, 38, 40, 41, 43, 44, 46, 47, 49, 50, 52, 53, 55, 56, 58, 59, 61, 62
                                x% = x% + 2
                                rightx% = rightx% + 1
                            Case Else: x% = x% + 1
                        End Select
                    End If
                    'IF rightx% < 78 THEN rightx% = rightx% + 1
                Case Chr$(0) + Chr$(73), Chr$(0) + Chr$(71): y% = 2
                Case Chr$(0) + Chr$(81), Chr$(0) + Chr$(79): y% = 25
                Case Else
                    If (BC& + ((y% - 2) * 16 + rightx% - 1) - 62) <= LOF(7) And E$ <> Chr$(8) Then
                        Select Case UCase$(E$)
                            Case "A", "B", "C", "D", "E", "F", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"
                                E$ = UCase$(E$)
                                changes% = 1
                                Color 1, 15: Locate y%, x%: Print " ";
                                Poke (y% - 1) * 160 + (x% - 1) * 2, Asc(E$)
                                If x% < 62 Then

                                    Select Case x%
                                        Case 16, 17, 19, 20, 22, 23, 25, 26, 28, 29, 31, 32, 34, 35, 37, 38, 40, 41, 43, 44, 46, 47, 49, 50, 52, 53, 55, 56, 58, 59, 61, 62
                                            e2$ = Chr$(Val("&H" + Chr$(Screen(y%, x% - 1)) + Chr$(Screen(y%, x%))))
                                            'locate 1,1 : print e2$
                                            '===== reflect changes on right panel
                                            Color 1, 15: Locate y%, rightx%: Print " ";
                                            Poke (y% - 1) * 160 + (rightx% - 1) * 2, Asc(e2$)
                                            Mid$(PG$, ((y% - 2) * 16 + rightx% * 1) - 62) = e2$
                                            '=== dont advance cursor if at last place
                                            If x% < 61 Then
                                                rightx% = rightx% + 1
                                                x% = x% + 2
                                            End If
                                        Case Else: x% = x% + 1
                                    End Select
                                End If
                        End Select

                    End If
            End Select
        End If
    Loop Until E$ <> ""
    Locate y%, x%
Loop Until E$ = Chr$(27)

GoTo SaveChanges:


'===========
EditBin3:
'===========

Color 1, 7
x% = 1: y% = 2
changes% = 0

GoSub DrawEditBar

Locate 2, 1, 1, 1, 30

Do
    Do
        E$ = InKey$
        If E$ <> "" Then
            Select Case E$
                Case Chr$(27): Exit Do
                Case Chr$(0) + Chr$(72): If y% > 2 Then y% = y% - 1
                Case Chr$(0) + Chr$(80): If y% < 25 Then y% = y% + 1
                Case Chr$(0) + Chr$(75): If x% > 1 Then x% = x% - 1
                Case Chr$(0) + Chr$(77): If x% < 79 Then x% = x% + 1
                Case Chr$(0) + Chr$(73), Chr$(0) + Chr$(71): y% = 2
                Case Chr$(0) + Chr$(81), Chr$(0) + Chr$(79): y% = 25
                Case Else
                    If (BC& + (y% - 2) * 79 + x% - 1) <= LOF(7) And E$ <> Chr$(8) Then
                        changes% = 1
                        '=== new color for changed bytes
                        Color 1, 15: Locate y%, x%: Print " ";
                        Locate y%, x%

                        Poke (y% - 1) * 160 + (x% - 1) * 2, Asc(E$)
                        Mid$(PG$, (y% - 2) * 79 + x% * 1) = E$
                        If x% < 79 Then x% = x% + 1
                    End If
            End Select
        End If
    Loop Until E$ <> ""
    GoSub DrawEditBar
    Locate y%, x%
Loop Until E$ = Chr$(27)

GoTo SaveChanges:

'===========
DrawEditBar:
'===========

If DisplayView% = 1 Then
    Locate 1, 1:
    Color 31, 4: Print "  EDIT MODE: ";
    Color 15, 4
    Print " Press TAB to switch editing sides "; Chr$(179); " Arrows move cursor "; Chr$(179); " ESC=Exit ";
Else
    Locate 1, 1
    Color 31, 4: Print " EDIT MODE ";
    Color 15, 4
    Print Chr$(179); " Arrows move cursor "; Chr$(179); " ESC=Exit "; Chr$(179);
    Locate 1, 45: Print String$(35, " ");

    Locate 1, 46
    CurrentByte& = BC& + (y% - 2) * 79 + x% - 1
    CurrentValue% = Asc(Mid$(PG$, (y% - 2) * 79 + x% * 1, 1))
    If CurrentByte& > LOF(7) Then
        Print Space$(9); "PAST END OF FILE";
    Else
        Print "Byte:"; LTrim$(Str$(CurrentByte&));
        Print ", ASC:"; LTrim$(Str$(CurrentValue%));
        Print ", HEX:"; RTrim$(Hex$(CurrentValue%));
    End If
End If

Return


'============
DrawTopBar:
'============

Locate 1, 1: Color 1, 15: Print String$(80, 32);
Locate 1, 1
If Filter% = 1 Then
    Color 30, 4: Print "F";: Color 1, 15
Else
    Print " ";
End If

Print "FILE: "; ShortFileName$;

Print " "; Chr$(179); " Bytes:"; LOF(7);
EC& = BC& + Buff%: If EC& > LOF(7) Then EC& = LOF(7)
Print Chr$(179); " Viewing:"; RTrim$(Str$(BC&)); "-"; LTrim$(Str$(EC&));
Locate 1, 70: Print Chr$(179); " M = Menu";
Color 15, 1
'== Draw bar on right side of screen
For d% = 2 To 25
    Locate d%, 80: Print Chr$(176);
Next

If DisplayView% = 1 Then
    '== Draw lines down screen
    For d% = 2 To 25
        Locate d%, 79: Print Chr$(179);
        Locate d%, 62: Print Chr$(179);
        'add space around numbers...
        '(full screen messes it...)
        Locate d%, 13: Print " " + Chr$(179);
        Locate d%, 1: Print Chr$(179) + " ";
    Next

    '=== Draw location
    For d% = 2 To 25
        Locate d%, 3
        nm$ = Hex$(BC& - 32 + (d% * 16))
        If Len(nm$) = 9 Then nm$ = "0" + nm$
        If Len(nm$) = 8 Then nm$ = "00" + nm$
        If Len(nm$) = 7 Then nm$ = "000" + nm$
        If Len(nm$) = 6 Then nm$ = "0000" + nm$
        If Len(nm$) = 5 Then nm$ = "00000" + nm$
        If Len(nm$) = 4 Then nm$ = "000000" + nm$
        If Len(nm$) = 3 Then nm$ = "0000000" + nm$
        If Len(nm$) = 2 Then nm$ = "00000000" + nm$
        If Len(nm$) = 1 Then nm$ = "000000000" + nm$
        Print nm$;
    Next
End If

Marker% = CInt(BC& / LOF(7) * 23)
Locate Marker% + 2, 80: Print Chr$(178);
Return

'========
Menu:
'========

Sound 4500, .2: Color 15, 0: Locate , , 0
Locate 5, 24: Print Chr$(201); String$(34, 205); Chr$(187);
For m = 6 To 20
    Locate m, 24: Print Chr$(186); Space$(34); Chr$(186);
Next
Locate 21, 24: Print Chr$(200); String$(34, 205); Chr$(188);

Locate 6, 26: Print "Use the arrow keys, page up/down";
Locate 7, 26: Print "and Home/End keys to navigate.";
Locate 9, 26: Print "E = Enter into file editing mode";
Locate 10, 26: Print "F = Toggles the filter ON or OFF";
Locate 11, 26: Print "G = Goto a certain byte position";
Locate 12, 26: Print "L = Goto a certain HEX location";
Locate 13, 26: Print "S = Searches for string in file";
Locate 14, 26: Print "N = Find next match after search";
Locate 16, 26: Print "ENTER = Toggle HEX/ASCII modes";
Locate 17, 26: Print "TAB   = switch window (HEX mode)";
Locate 18, 26: Print "ESC   = EXITS this program";
Locate 20, 26: Print "ALT+ENTER for full screen window";
Pause$ = Input$(1)
Color 15, 1: Cls: Locate 1, 1, 0
Return

