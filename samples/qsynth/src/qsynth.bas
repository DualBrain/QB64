'                                QSYNTH.BAS
'
'        Copyright (C) 1990 Microsoft Corporation. All Rights Reserved.
'
' This program records and plays back songs. To enter a song, use the
' piano keyboard displayed on the screen. You can save, change, and
' delete the songs and change the speed of the song play back.
'
' To run this game, press SHIFT+F5.
'
' To exit this program, press ALT, F, X.
'
' To get help on a BASIC keyword, move the cursor to the keyword and press
' F1 or click the right mouse button.
'
' To view suggestions on changing this game, press Page Down.
'
'
'                             Suggested Changes
'                             -----------------
'
' There are many ways that you can modify this BASIC game.  The CONST
' statements below these comments and the DATA statements at the end
' of this screen can be modified to change the following:
'    Pitch of song playback
'    Background color
'    Text color
'    Pressed piano key color
'    System songs
'
' On the right side of each CONST statement, there is a comment that tells
' you what it does and how big or small you can set the value.  Above the
' DATA statements, there are comments that tell you the format of the
' information stored there.
'
' On your own, you can also add exciting sound and visual effects or make any
' other changes that your imagination can dream up.  By reading the
' Learn BASIC Now book, you'll learn the techniques that will enable you
' to fully customize this game and to create games of your own.
'
'
' If the game won't run after you have changed it, you can exit without
' saving your changes by pressing Alt, F, X and choosing NO.
'
' If you do want to save your changes, press Alt, F, A and enter a filename
' for saving your version of the program.  Before you save your changes,
' however, you should make sure they work by running the program and
' verifying that your changes produce the desired results.  Also, always
' be sure to keep a backup of the original program.
'
DefInt A-Z

' These constants can be modified to change certain aspects of the game.
Const PRESSEDKEYCOLOR = 15 ' Pressed keyboard key color. Range 1-6, 8-15.
Const BACKGROUNDCOLOR = 3 ' Background color. Range 0-7
Const TEXTCOLOR = 0 ' Menu text color. Range 0-15, but not same as BACKGROUNDCOLOR.
Const TITLECOLOR = 15 ' Mode and title color. Range 0-15, but not same as BACKGROUNDCOLOR.
Const PITCH = 4 ' Pitch of songs (higher number means lower pitch)- MUST BE BETWEEN 0 AND 4!!!
Const XTNOTELENGTH = 4 ' Length of the note sound on all PC/XT type machines.  Range 1 to 24.
Const INTROSONG = "T100O2L16CCDFDEL4DL16FEDO1BO2L4C" ' Song played at game introduction


' The following are general constants and their values should not be changed.

' Musical note constants.
Const C = 1
Const DF = 2
Const D = 3
Const EF = 4
Const E = 5
Const F = 6
Const GF = 7
Const G = 8
Const AF = 9
Const A = 10
Const BF = 11
Const B = 12
' Menu constants
Const MAIN = 0
Const PRACTICE = 1
Const RECORD = 2
Const PLAYBACK = 3
Const PLAYING = 6
Const SAVING = 7
Const EDITOR = 8
Const EDITMENU = 9
Const GETNAME = 10
' Other constants
Const MAXSONG = 50 ' # of recordable selections
Const MAXNOTE = 2000 ' # notes available per song
Const FALSE = 0 ' Constant for FALSE value
Const TRUE = Not FALSE ' Constant for TRUE value
Const UP = FALSE ' Up as in key released
Const DOWN = TRUE ' Down as in key pressed
Const CANCEL = 255
Const NOTETICK = .6 ' Length of time rests and notes are
Const RESTTICK = .7 ' played per duration increment
Const CR = 13 ' Carriage Return (Enter)
Const ESC = 27 ' Esc key
Const TABCHAR = 9 ' Tab key

' Structure definitions
Type KeyMap
    Note As Integer ' An array of this type is used to map
    Oct As Integer ' keyboard keys to Note/Oct values.
End Type

Type SongElement ' An array of this type is used to
    Note As Integer ' hold all the information in a song
    Oct As Integer ' (Note, Octave, and Duration of each
    Dur As Integer ' note in the song)
End Type

Type SongIndexCard ' Elements of this type make up the
    naym As String * 25 ' SongIndex section of the song file,
    desc As String * 40 ' describing the name/description of
    Size As Integer ' a song, the length in notes, and the
    Offset As Long ' position of the song in the file.
End Type

Type FileHeader ' This structure is the file header
    Count As Integer ' for the song file, indicating the
    NextNote As Long ' number of songs saved, and position
End Type ' of the next unused byte in the file.

'Declaration of all the FUNCTION and SUB procedures called in this program.
DECLARE FUNCTION ConfirmDelete% ()
DECLARE FUNCTION GetNote$ (Note%)
DECLARE FUNCTION SaveChanges% ()
DECLARE FUNCTION SimpleEdit% (row%, col%, text$, MaxLen%)
DECLARE SUB Center (text$, row%)
DECLARE SUB ChangeTempo (Inc%)
DECLARE SUB ClearMenuScreen (Title$)
DECLARE SUB CreateSongFile ()
DECLARE SUB DeleteSong (SongNo%)
DECLARE SUB DisplayChanges ()
DECLARE SUB DisplayGameTitle ()
DECLARE SUB DisplayIntro ()
DECLARE SUB DisplayMenuText (Menu%)
DECLARE SUB DrawBox (r1%, c1%, r2%, c2%, Title$)
DECLARE SUB DrawKeyboard ()
DECLARE SUB DrawNote (Note%, Octave%, Action%)
DECLARE SUB EditSong (SongNo%)
DECLARE SUB ErrorMessage (msg$)
DECLARE SUB GetNameAndSave ()
DECLARE SUB InitFreq ()
DECLARE SUB LoadDefaultSong (num%)
DECLARE SUB LoadSong (SongNo%)
DECLARE SUB MainMenu ()
DECLARE SUB PlayNote (Note%, Octave%, Duration#)
DECLARE SUB PlaySong ()
DECLARE SUB RecordMenu (NoSave%)
DECLARE SUB RecordMode (NoSave%)
DECLARE SUB SaveSong ()
DECLARE SUB TimeDelay (Dur#)

' SHARED (global) variable declarations for use in this program
Dim Shared Freq(1 To 12) As Integer ' Base array of frequencies
Dim Shared Kyb(1 To 127) As KeyMap ' Keyboard key to piano key array
Dim Shared Song(1 To MAXNOTE) As SongElement ' Array to hold the actual song
Dim Shared Counter As Integer ' Number of notes in Song()
Dim Shared SongName As String * 25 ' Name of Song()
Dim Shared SongDesc As String * 40 ' Description of Song()
Dim Shared TEMPO As Integer ' Tempo of song playback (control)
Dim Shared TFACTOR As Single ' Tempo factor (for actual speed)
Dim Shared FileError As Integer ' Keeps file error status.
Dim Shared SongRecorded As Integer ' Flag used to decide whether or
' not a song was actually recorded
Dim KeyFlags As Integer ' Used to turn NUM LOCK off
Dim BadMode As Integer ' Used to validate screen mode

' Use error trap to test for graphics capability.
On Error GoTo ScreenError ' Set up an error trap.
BadMode = FALSE ' ScreenError will change to TRUE if...
Screen 1 ' this statement fails, which means...

If BadMode = TRUE Then ' no graphic was found.
    Cls
    Locate 11, 13
    Print "CGA, EGA Color, or VGA graphics required to run QSYNTH.BAS"

Else

    Def Seg = 0
    KeyFlags = Peek(1047) ' Keep current keyboard flags.
    If KeyFlags And 32 Then
        Poke 1047, KeyFlags And 223 ' Force the NUM LOCK state to OFF.
    End If
    Def Seg

    On Error GoTo ErrorTrap ' Set the main error trap.
    DisplayIntro ' Display the intro screen.
    FileError = 0

    StartAgain: ' If an error occurs, we start again here.
    DrawKeyboard ' Draw the keyboard on the screen.
    InitFreq ' Map keyboard to piano, and set frequencies.
    MainMenu ' Go to the main menu.
    DisplayChanges ' Display the final screen.

    If KeyFlags And 32 Then ' Restore the keyboard
        Def Seg = 0 ' to the state in which
        Poke 1047, KeyFlags Or 32 ' we found it originally.
        Def Seg
    End If

End If

End ' The end of module-level control flow.


' Error handling routine
ErrorTrap:
errnum = Err
Select Case errnum
    Case 52 TO 76
        If FileError = 0 Then
            ErrorMessage "Cannot access QSYNTH.DAT file."
            FileError = 1
        End If
        Resume Next
    Case Else
        ErrorMessage "Sorry, an unexpected error has occurred."
        Resume StartAgain
End Select

' Error handler for screen test
ScreenError:
BadMode = TRUE
Resume Next


' Data statements for the default hard-coded songs
' The format for the DATA statements for a song is:
'
'     DATA "Song's Name", "Song's Description", Length of song (in "notes")
'     DATA note,octave,duration        ' <- first "note"
'     DATA note,octave,duration        ' <- second "note"
'     DATA note,octave,duration        ' <- third "note", etc.
SONG1:
Data "Yankee","Yankee Doodle Dandy",107
Data 1,0,18,0,0,3,1,0,18,0,0,3,3,0,18,0,0,3,5,0,18,0,0,3,1,0,18,0,0,3
Data 5,0,18,0,0,3,3,0,18,0,0,3,8,-1,18,0,0,3,1,0,18,0,0,3,1,0,18,0,0,3
Data 3,0,18,0,0,3,5,0,18,0,0,3,1,0,38,0,0,6,12,-1,38,0,0,6,1,0,18,0,0,3
Data 1,0,18,0,0,3,3,0,18,0,0,3,5,0,18,0,0,3,6,0,18,0,0,3,5,0,18,0,0,3
Data 3,0,18,0,0,3,1,0,18,0,0,3,12,-1,18,0,0,3,8,-1,18,0,0,3,10,-1,18
Data 0,0,3,12,-1,18,0,0,3,1,0,38,0,0,6,1,0,38,0,0,6,10,-1,38,0,0,3
Data 12,-1,15,10,-1,18,0,0,3,8,-1,18,0,0,3,10,-1,18,0,0,3,12,-1,18
Data 0,0,3,1,0,38,0,0,6,8,-1,38,0,0,3,10,-1,15,8,-1,18,0,0,3,6,-1,18
Data 0,0,3,5,-1,38,0,0,6,8,-1,38,0,0,6,10,-1,38,0,0,3,12,-1,15,10,-1,18
Data 0,0,3,8,-1,18,0,0,3,10,-1,18,0,0,3,12,-1,18,0,0,3,1,0,18,0,0,3
Data 10,-1,18,0,0,3,8,-1,18,0,0,3,1,0,18,0,0,3,12,-1,18,0,0,3,3,0,18
Data 0,0,3,1,0,38,0,0,6,1,0,38,0,0,6

SONG2:
Data "Hat","Mexican Hat Dance",36
Data 1,0,16,6,0,10,0,0,5,1,0,16,6,0,10,0,0,5,1,0,16,6,0,10,0,0,12
Data 1,0,16,6,0,16,8,0,16,6,0,16,5,0,10,0,0,5,6,0,16,8,0,10,0,0,15
Data 1,0,16,5,0,10,0,0,5,1,0,16,5,0,10,0,0,5,1,0,16,5,0,10,0,0,12
Data 1,0,16,5,0,16,6,0,16,5,0,16,3,0,10,0,0,5,5,0,16,6,0,10,0,0,15

'-------------------------------------------------------------------------
'  Center
'
'    Centers the text string it receives on the indicated row.
'
'             PARAMETERS:   text$   -   the text to print
'                           row     -   the row on which to print text$
'-------------------------------------------------------------------------
Sub Center (text$, row)

    Locate row%, 40 - Len(text$) \ 2 + 1 ' Calculate column to start at.
    Print text$;

End Sub

'-------------------------------------------------------------------------
' ChangeTempo
'
'   Changes the current tempo (speed) for song playback.  When the
'   user presses a direction key, this SUB is called with the direction of
'   change as an argument and adjusts the tempo accordingly, and also updates
'   the tempo control on the screen.
'
'             PARAMETERS:   Inc - The amount by which to change the TEMPO
'
'-------------------------------------------------------------------------
Sub ChangeTempo (Inc) Static

    Color 0, 7 ' Erase the TEMPO control lever.
    Locate 23, 17 + TEMPO
    Print Chr$(205)

    If Inc = UP And TEMPO < 45 Then ' Calculate new TEMPO value.
        TEMPO = TEMPO + 1
    ElseIf Inc = DOWN And TEMPO > 1 Then
        TEMPO = TEMPO - 1
    End If

    TFACTOR = 1 + (23 - TEMPO) * .03 ' Calculate new TFACTOR value.
    Locate 23, 17 + TEMPO ' Redisplay the TEMPO control.
    Print Chr$(219)

End Sub

'-------------------------------------------------------------------------
' ClearMenuScreen
'
'   Clears the section of the screen below the keyboard, and centers
'   the title given in Title$ at the top.
'
'             PARAMETERS:   Title$ - The text to display at the top of the
'                                    screen or "RETAIN" to keep current title
'-------------------------------------------------------------------------
Sub ClearMenuScreen (Title$) Static
    
    Color TEXTCOLOR, BACKGROUNDCOLOR
    If Title$ <> "RETAIN" Then ' "RETAIN" means leave the current
        Color TITLECOLOR ' title on the top of the screen.
        Locate 3, 20

        ' Print a 40-character string of spaces with Title$ in the center.
        Print Left$(Space$(20 - Len(Title$) \ 2) + Title$ + Space$(20), 40)
        Color TEXTCOLOR
    End If

    View Print 13 To 25 ' Clear these specific lines.
    Cls
    View Print

End Sub

'-------------------------------------------------------------------------
' ConfirmDelete
'
'   Makes sure that the user really wants to delete the song.
'   Returns TRUE if so, or FALSE if not.
'
'             PARAMETERS:   None
'-------------------------------------------------------------------------
Function ConfirmDelete Static

    Color BACKGROUNDCOLOR, BACKGROUNDCOLOR ' Draw the dialog box.
    DrawBox 13, 38, 24, 78, ""
    Color 0, 7
    DrawBox 15, 41, 20, 75, "Delete Song"
    Locate 17, 43
    Print "Are you sure you want to delete"
    Locate , 43, 1
    Print "the current song? (Y/N) ";

    Do ' Wait for input.
        i$ = UCase$(InKey$)
    Loop Until i$ <> ""

    Locate , , 0 ' Turn off cursor.
    If i$ = "Y" Then ' Return appropriate value.
        ConfirmDelete = TRUE
    Else
        ConfirmDelete = FALSE
    End If

End Function

'-------------------------------------------------------------------------
' CreateSongFile
'
'   Creates the song file QSYNTH.DAT in the proper format.
'
'             PARAMETERS:   None
'-------------------------------------------------------------------------
Sub CreateSongFile Static

    Dim Hdr As FileHeader
    Dim S As SongIndexCard

    Hdr.Count = 0
    Hdr.NextNote = 1 ' Initialize header structure.
    Seek #1, 1
    Put #1, , Hdr ' Put the header in the file.

    For i = 1 To MAXSONG ' Fill in the blank index records.
        Put #1, , S
    Next i

End Sub

'-------------------------------------------------------------------------
' DeleteSong
'
'   Deletes a song from the song list, and deletes the song index card
'   and song data from the file.  To understand how this procedure works, see the
'   SaveSong SUB for a description of the file structure for QSYNTH.DAT.
'
'             PARAMETERS:   SongNo  -       The song number to delete
'-------------------------------------------------------------------------
Sub DeleteSong (SongNo) Static

    Dim HeaderInfo As FileHeader
    Dim S As SongIndexCard
    Dim n As SongElement
    FileError = 0

    Open "QSYNTH.DAT" For Binary As 1
    Get #1, , HeaderInfo
  
    Seek #1, Len(HeaderInfo) + (Len(S) * (SongNo - 1)) + 1
    Get #1, , S ' Get info on song to delete.
    BackPtr = S.Offset ' BackPtr is the location where the
    ' collapse starts copying TO (see below).

    If SongNo = HeaderInfo.Count Then
        ' SongNo was the last song in the list, so we're basically done.  All
        ' there is to do is reduce the number of songs by one, and update the
        ' NextNote pointer in the file header to point to the first note of
        ' the deleted song.  Remember that NextNote always points to the next
        ' available note location in the file.  Note that this leaves all the
        ' data of the deleted song at the end of the file, which will be over-
        ' written the next time a song is saved.
        HeaderInfo.Count = HeaderInfo.Count - 1 ' Reduce # of songs by one
        HeaderInfo.NextNote = S.Offset ' Point NextNote at first note
        ' of deleted song.
        Seek #1, 1 ' Header belongs at beginning
        Put #1, , HeaderInfo ' Write new header.
        Close 1
        Exit Sub
    Else
        ' The song we're deleting is not the last one in the file, so
        ' to delete it, we must "collapse" both the song index part and
        ' the song data part of the file.  "Collapse" here means to copy
        ' all the information appearing in the file after the song we are
        ' deleting up in the file, thus writing over the deleted song.  Then,
        ' the song count and NextNote values in the file header are updated.
        Get #1, , S ' Get info on the next song in the file.
        ForePtr = S.Offset ' ForePtr is where we are copying from.
    End If

    ' First, we need to collapse song index part of the file.  This is done by
    ' moving each song index record after the deleted one up one notch, so that
    ' the deleted song's index record get replaced by the one following it, and
    ' so on.  Also, for each record, the Offset field needs to be adjusted by
    ' the size of the deleted song, which at this point can be calculated by
    ' ForePtr - BackPtr, since ForePtr points to the song data immediately after
    ' the deleted song, and BackPtr points to the deleted song's data.  This
    ' adjustment is necessary because the song data will be collapsed as well.
    For i = SongNo + 1 To HeaderInfo.Count
        Seek #1, Len(HeaderInfo) + (Len(S) * (i - 1)) + 1
        Get #1, , S ' Get the old song index record.
        S.Offset = S.Offset - (ForePtr - BackPtr) ' Make the adjustment
        Seek #1, Len(HeaderInfo) + (Len(S) * (i - 2)) + 1
        Put #1, , S ' and put it in it's new place.
    Next i

    ' Next, we need to collapse the song data part of the file. This is done in
    ' the same way that the song index part was, with the exception that it is
    ' moved up in the file one note at a time.  ALL notes of ALL songs after the
    ' deleted song are copied with the following loop.
    For i = ForePtr To HeaderInfo.NextNote - Len(n) Step Len(n)
        Seek #1, Len(HeaderInfo) + (Len(S) * MAXSONG) + i
        Get #1, , n ' Get a note.
        Seek #1, Len(HeaderInfo) + (Len(S) * MAXSONG) + BackPtr
        Put #1, , n ' Put it at it's new location.
        BackPtr = BackPtr + Len(n) ' Update BackPtr.
    Next i

    ' The last step is to update the file header record.  This is the same as
    ' if we deleted the last song; reduce the song count by one, and point NextNote
    ' at the next AVAILABLE note location in the song data section.  Note that
    ' after the above loop completes, i points to one past the last note of the
    ' last song (which is exactly what we want for NextNote).
    HeaderInfo.Count = HeaderInfo.Count - 1
    HeaderInfo.NextNote = i
    Seek #1, 1
    Put #1, , HeaderInfo ' write the new file header
    Close 1 '  - song is history!

End Sub

'-------------------------------------------------------------------------
' DisplayChanges
'
'   Displays game characteristics that you can easily change via CONST and DATA.
'
'             PARAMETERS:   None
'-------------------------------------------------------------------------
Sub DisplayChanges

    DisplayGameTitle ' Print game title
                         
    Color 7 ' Print suggested changes in white.
    Center "The following game characteristics can be easily changed from", 5
    Center "within QuickBASIC Interpreter.  To change the values of these", 6
    Center "characteristics, locate the corresponding CONST or DATA      ", 7
    Center "statements in the source code and change their values, then  ", 8
    Center "restart the program (press Shift + F5).                      ", 9
    Color 15
    Center "Pitch of song playback ", 11
    Center "Background color       ", 12
    Center "Text color             ", 13
    Center "Pressed piano key color", 14
    Center "System songs           ", 15
    Color 7
    Center "The CONST statements and instructions on changing them are   ", 17
    Center "located at the beginning of the main program.                ", 18

    Do While InKey$ = "": Loop ' Wait for any keypress.
    Cls

End Sub

'-------------------------------------------------------------------------
' DisplayGameTitle
'
'   Displays game title for use in the introduction and suggested changes.
'
'             PARAMETERS:   None
'-------------------------------------------------------------------------
Sub DisplayGameTitle

    ' Set the screen to a normal text, clear it and add blue background.
    Screen 0
    Width 80, 25
    Color 4, 0
    Cls
    
    Locate 1, 2 ' Draw outline around screen with extended ASCII characters.
    Print Chr$(201); String$(76, 205); Chr$(187); ' top border
    For x% = 2 To 24 ' left and right borders
        Locate x%, 2
        Print Chr$(186); Tab(79); Chr$(186);
    Next x%
    Locate 25, 2
    Print Chr$(200); String$(76, 205); Chr$(188); ' bottom border

    ' Print game title centered at top of screen
    Color 0, 4 ' Print title in black on red.
    Center "          Microsoft          ", 1 ' Center game title on lines 1 & 2.
    Center "   Q S Y N T H E S I Z E R   ", 2
    Center "   Press any key to continue   ", 25
    Color 7, 0

End Sub

'-------------------------------------------------------------------------
' DisplayIntro
'
'   Displays game introduction screen.
'
'             PARAMETERS:   None
'-------------------------------------------------------------------------
Sub DisplayIntro

    DisplayGameTitle ' Display game title.

    Color 7
    Center "Copyright (C) 1990 Microsoft Corporation.  All Rights Reserved.", 4
    Center "Microsoft QSynthesizer allows you to record and play back songs", 7
    Center "entered by pressing keys on the keyboard.  You can save up to ", 8
    Center LTrim$(Str$(MAXSONG)) + " songs on disk and play them back as often as you like.  You", 9
    Center "can also use the song editor to fine-tune your songs.         ", 10
    Center "Just follow the directions in the menus to play, record, save,", 12
    Center "edit, and delete your songs.                                  ", 13

    Play INTROSONG ' Play melody while waiting to continue.

    Do While InKey$ = "": Loop ' Wait for any keypress.

End Sub

'-------------------------------------------------------------------------
' DisplayMenuText
'
'   Displays almost all the text, boxes, and other info on the screen.  It
'   uses the parameter (Menu) to determine which screen has been requested.
'
'             PARAMETERS:   Menu - The "Menu" number to be displayed
'-------------------------------------------------------------------------
Sub DisplayMenuText (Menu) Static

    Select Case Menu
        Case MAIN ' Main menu screen.
            ClearMenuScreen ""
            Color 0, 7
            DrawBox 14, 7, 24, 35, "Song List"
            Color TEXTCOLOR, BACKGROUNDCOLOR
            Locate 14, 46
            Print "P - Play current song"
            Locate , 46
            Print "R - Record a new song"
            Locate , 46
            Print "E - Edit song from list"
            Locate , 46
            Print "D - Delete song from list"
            Locate , 46
            Print "S - Practice QSynthesizer"
            Locate , 46
            Print "Q - Quit QSynthesizer"
            Locate 21, 40
            Print "Use the arrow keys to select a song."
            Locate , 41
            Print "Press the corresponding letter to"
            Locate , 44
            Print "make a selection from above."
      
        Case PRACTICE, RECORD ' These two are almost the same (PRACTICE and RECORD modes).
            If Menu = PRACTICE Then
                ClearMenuScreen "Practice Mode"
                Center "When finished practicing, press the Esc key.", 20
            Else
                ClearMenuScreen "Record Mode"
                Center "When finished recording, press the Esc key.", 20
            End If
            Center "To play a note, press the key on the keyboard", 16
            Center "corresponding to the desired note shown on", 17
            Center "the piano above. ", 18

        Case PLAYBACK ' Song playback screen - with the TEMPO control.
            ClearMenuScreen "Playback Mode: " + RTrim$(SongName)
            Color TITLECOLOR
            Locate 14, 40 - (Len(RTrim$(SongDesc)) \ 2)
            Print RTrim$(SongDesc)
            Color TEXTCOLOR
            Center "Use arrow keys to adjust tempo.", 17
            Center "Press Enter to start song playback.", 18
            Center "Press Esc to exit playback mode.", 19
            Color 0, 7
            DrawBox 21, 15, 24, 65, "Tempo Control"
            Locate 22, 17
            Print "Slow"
            Locate 22, 60
            Print "Fast"
            Locate , 17
            Print Chr$(198); String$(22, 205); Chr$(219); String$(22, 205); Chr$(181)
            TEMPO = 23
            TFACTOR = 1
            Color TEXTCOLOR, BACKGROUNDCOLOR

        Case EDITOR ' Song editor screen.
            ClearMenuScreen "Edit Mode: " + RTrim$(SongName)
            Locate 14, 58 - Len(RTrim$(SongDesc)) \ 2
            Color TITLECOLOR
            Print RTrim$(SongDesc)
            Color TEXTCOLOR
            Locate 16, 46
            Print "C - Change current note"
            Locate , 46
            Print "I - Insert new note"
            Locate , 46
            Print "D - Delete current note"
            Locate , 46
            Print "P - Play song"
            Locate 22, 41
            Print "Press the corresponding letter to"
            Locate , 39
            Print "make a selection from the list above."
            Locate , 43
            Print "Press Esc to exit the editor.";
            Color 0, 7
            DrawBox 14, 5, 24, 35, "Note List"
            Color 15
            Locate 15, 6
            Print "Note        Octave   Duration"
            Color 0
            Locate 22, 5
            Print Chr$(195); String$(29, 196); Chr$(180)

        Case GETNAME ' This is the dialog box to get the song name.
            ClearMenuScreen "RETAIN"
            Color 0, 7
            DrawBox 14, 10, 24, 70, "Save Recorded Song"
            DrawBox 15, 26, 17, 53, ""
            DrawBox 18, 26, 20, 68, ""
            Locate 16, 12
            Print "Song's Name:"
            Locate 19, 12
            Print "Description:"
            Locate 22, 15
            Print "Press Tab to change edit fields, and Enter to save."
            Locate 23, 12
            Print "Press Esc to return to main menu without saving the song."

    End Select

End Sub

'-------------------------------------------------------------------------
' DrawBox
'
'   Draws a box using single line characters at the given coordinates.
'
'        PARAMETERS:    r1,c1  - The row and column location of the upper left corner
'                       r2,c2  - The row and column location of the lower right corner
'                       Title$ - The text to place at the top of the box, if any
'-------------------------------------------------------------------------
Sub DrawBox (r1, c1, r2, c2, Title$) Static

    InBoxWidth = c2 - c1 - 1 ' Calculate box width.

    Locate r1, c1 ' Draw the top line.
    Print Chr$(218); String$(InBoxWidth, 196); Chr$(191)

    For t = r1 + 1 To r2 - 1 ' Draw sides of the box.
        Locate t, c1
        Print Chr$(179); Space$(InBoxWidth); Chr$(179);
    Next t

    Locate r2, c1 ' Draw the bottom line.
    Print Chr$(192); String$(InBoxWidth, 196); Chr$(217);

    If Title$ <> "" Then ' Put the title on top.
        Locate r1, c1 + (InBoxWidth \ 2) - (Len(Title$) \ 2)
        Print " "; Title$; " ";
    End If

End Sub

'-------------------------------------------------------------------------
' DrawKeyboard
'
'   Draws the piano keyboard on the screen.
'
'             PARAMETERS:   None
'-------------------------------------------------------------------------
Sub DrawKeyboard Static

    Color TITLECOLOR, BACKGROUNDCOLOR
    Width 80, 25
    Cls

    '  - Print top lines of keyboard.
    Locate 2, 29
    Print "Microsoft QSynthesizer"
    Color 7, 0
    Locate 5, 4
    Print Space$(75)
    Locate , 4
    Print Space$(75)

    '    Print middle section (black/white keys).
    Color 0, 7
    temp$ = Chr$(179) + " " + Chr$(219) + " " + Chr$(219) + " " + Chr$(179) + " "
    temp$ = temp$ + Chr$(219) + " " + Chr$(219) + " " + Chr$(219) + " "
    temp2$ = Chr$(179) + " " + Chr$(222)
    For i = 1 To 3
        Locate , 4
        Print Chr$(219); Chr$(221); Mid$(temp$, 2); temp$;
        Print temp$; temp$; temp$; temp2$; Chr$(219)
    Next i

    '    Print middle section (white keys only).
    For i = 1 To 2
        Locate , 4
        Print Chr$(219); Chr$(221);
        For t = 1 To 35
            Print " "; Chr$(179);
        Next t
        Print " "; Chr$(222); Chr$(219)
    Next i
    Color 7, 0
    Locate , 4
    Print Space$(75)

End Sub

'-------------------------------------------------------------------------
' DrawNote
'
' Highlights or un-highlights the given note on the piano keyboard.
'
'        PARAMETERS:    Note - The note number to draw
'                       Octave - The octave number (-3 to 3) of the note
'                       Action - What to do (DOWN = un-highlight, UP = highlight)
'-------------------------------------------------------------------------
Sub DrawNote (Note, Octave, Action) Static

    If Note = 0 Then Exit Sub ' Note = 0 means do not draw a note

    Select Case Note
        Case A, B, C, D, E, F, G ' Find offset from middle C for a
            Select Case Note ' white key.
                Case A
                    Offset = 10
                Case B
                    Offset = 12
                Case C
                    Offset = 0
                Case D
                    Offset = 2
                Case E
                    Offset = 4
                Case F
                    Offset = 6
                Case G
                    Offset = 8
            End Select
            col = (34 + Offset) + (Octave * 14) ' Calculate column value.
            bottom = 11 ' Bottom of key (row)
            keyColor = 7 ' Color to draw UP key

        Case Else ' Find offset from middle C for a
            Select Case Note ' black key.
                Case DF
                    Offset = 1
                Case EF
                    Offset = 3
                Case GF
                    Offset = 7
                Case AF
                    Offset = 9
                Case BF
                    Offset = 11
            End Select
            col = (34 + Offset) + (Octave * 14) ' Calculate column value.
            bottom = 9 ' Bottom of key (row)
            keyColor = 0 ' Color to draw UP key
    End Select

    If Action = DOWN Then
        Color PRESSEDKEYCOLOR ' Set pressed key color.
    Else
        Color keyColor
    End If

    If col > 5 And col < 77 Then ' Using the calculated row
        For row = 7 To bottom ' and the bottom found, draw
            Locate row, col ' a vertical line of blocks
            Print Chr$(219) ' to fill in key pressed.
        Next row
    End If

End Sub

'-------------------------------------------------------------------------
' EditSong
'
' This is the song editor.  Each of the functions available in the song editor
' are subroutines contained in this subprogram.
'
'        PARAMETERS:    SongNo - The number of the song being edited, indexed
'                                from the beginning of the QSYNTH.DAT file
'-------------------------------------------------------------------------
Sub EditSong (SongNo) Static

    Dim EditNote As SongElement, DrawnNote As SongElement

    '     - Initialize screen and variables.
    DisplayMenuText EDITOR
    Cursor = 1
    WindowTop = 1
    DrawnNote.Note = 0
    Finished = FALSE
    GoSub DisplayNoteTable

    'Poll the keyboard, performing requested functions, until the Esc key is pressed.
    While Not Finished
        Do
            x$ = InKey$ '  - Wait for a keypress.
        Loop Until x$ <> ""

        If Len(x$) > 1 Then '  - Key was a function key
            Color 0, 7
            GoSub DrawNoteCursor ' "undraw" note cursor
            If Right$(x$, 1) = "H" And Cursor > 1 Then ' UP arrow
                Cursor = Cursor - 1
            ElseIf Right$(x$, 1) = "P" And Cursor < Counter Then ' DOWN arrow
                Cursor = Cursor + 1
            End If
            Color 7, 0
            GoSub DrawNoteCursor ' Redraw note cursor.
            GoSub PrintEditorStatus ' Update the current note value.

        Else '    Key was a standard key
            Select Case UCase$(x$)
                Case "C" ' - Change note.
                    EditNote = Song(Cursor)
                    EditTitle$ = "Change a Note"
                    GoSub GetNewNote ' Do the note edit.
                    If Not (Cancelled) Then
                        Song(Cursor) = EditNote
                    End If
                    GoSub DisplayNoteTable ' Update the note list to display change.

                Case "D" ' - Delete note.
                    GoSub DeleteCurrentNote

                Case "I" ' - Insert note
                    EditNote.Note = C
                    EditNote.Oct = 0
                    EditNote.Dur = 4
                    EditTitle$ = "Insert a Note"
                    GoSub GetNewNote ' Do the note edit.
                    If Not (Cancelled) Then
                        GoSub InsertEditNote
                    End If
                    GoSub DisplayNoteTable ' Update the note list.

                Case "P" ' - Play song.
                    DrawNote DrawnNote.Note, DrawnNote.Oct, UP
                    PlaySong ' Play the song.
                    DisplayMenuText EDITOR ' Redraw the editor screen.
                    GoSub DisplayNoteTable ' Update the note table.

                Case Chr$(27) ' - Esc key was pressed!
                    Finished = TRUE ' time to leave

            End Select
        End If
    Wend

    ' - See if the user wants to save his/her changes.
    If SaveChanges Then
        DeleteSong SongNo
        SaveSong
    End If
    DrawNote DrawnNote.Note, DrawnNote.Oct, UP
    Exit Sub

    '     - This subroutine displays the notes in text format in the Note List box.
    DisplayNoteTable:
    GoSub PrintEditorStatus
    For i = 16 To 21
        Locate i, 6
        Color 0, 7
        CurNote = i + WindowTop - 16
        If CurNote <= Counter Then
            GoSub PrintCurNote
        Else
            Print Space$(29)
        End If
    Next i
    Color 7, 0

    '     - This subroutine draws the current note again but in a different color to indicate a "cursor."
    DrawNoteCursor:
    If Cursor < WindowTop Then
        WindowTop = Cursor
        GoTo DisplayNoteTable
    ElseIf Cursor > WindowTop + 5 Then
        WindowTop = Cursor - 5
        GoTo DisplayNoteTable
    End If
    CurNote = Cursor
    Locate Cursor - WindowTop + 16, 6
    GoSub PrintCurNote
    DrawNote DrawnNote.Note, DrawnNote.Oct, UP
    DrawNote Song(CurNote).Note, Song(CurNote).Oct, DOWN
    DrawnNote = Song(CurNote)
    Return

    '     - This subroutine actually does the conversion of the note into text information and prints it out.
    PrintCurNote:
    If Song(CurNote).Note = 0 Then
        Print Using " \        \           ###### "; "<rest>"; Song(CurNote).Dur
    Else
        Print Using " \    \       ##      ###### "; GetNote$(Song(CurNote).Note); Song(CurNote).Oct; Song(CurNote).Dur
    End If
    Return

    '     - This subroutine displays the number of notes in the song and the number of the current note.
    PrintEditorStatus:
    Color 7, 0
    Locate 23, 6
    Print Using " Notes: ####  Current:  #### "; Counter; Cursor
    Return

    '     - This subroutine deletes the current note.
    DeleteCurrentNote:
    If Counter = 1 Then
        ErrorMessage "You cannot delete the last note."
        DisplayMenuText EDITOR
    Else
        Counter = Counter - 1
        For i = Cursor To Counter
            Song(i) = Song(i + 1) ' Delete note up on notch.
        Next i
        If Cursor > Counter Then Cursor = Counter
    End If
    GoTo DisplayNoteTable

    '     - This subroutine controls the input of a new note.  It draws
    '     - the box, processes the keys pressed and changes the note
    '     - values accordingly, until Esc or Enter is pressed.  Before
    '     - this routine is called, the starting values of the new note
    '     - are placed in EditNote; when the edit has been completed, the
    '     - new note's value is placed back into EditNote.
    GetNewNote:
    Color 0, 7 ' Draw the edit box.
    DrawBox 16, 39, 24, 76, EditTitle$
    Locate 18, 42
    Print "Use arrow keys to change values"
    Locate , 42
    Print "Enter when done, Esc to cancel"
    Locate 21, 42
    Color 7, 0
    Print "Note";
    Color 0, 7
    Print "       Octave      Duration"
    EditField = 1
    EditDone = FALSE
    Cancelled = FALSE

    While Not EditDone
        Note$ = GetNote$(EditNote.Note) ' Display the note.
        Locate 22, 42
        If EditNote.Note > 0 Then
            Print Using "\         \  ##         ######"; Note$; EditNote.Oct; EditNote.Dur
        Else
            Print Using "\               \       ######"; "    <rest>"; EditNote.Dur
        End If
  
        Do
            k$ = InKey$
        Loop While k$ = ""
  
        If Len(k$) > 1 Then
            Select Case Right$(k$, 1)
                Case "H", "P" ' Up arrow or Down arrow key pressed
                    If Right$(k$, 1) = "H" Then ' set increment appropriately.
                        Increment = 1
                    Else
                        Increment = -1
                    End If
  
                    Select Case EditField ' Change value according to edit mode.
                        Case 1
                            EditNote.Note = EditNote.Note + Increment
                            If EditNote.Note > B Then
                                EditNote.Note = 0
                                EditNote.Oct = EditNote.Oct + 1
                            ElseIf EditNote.Note < 0 Then
                                EditNote.Note = B
                                EditNote.Oct = EditNote.Oct - 1
                            End If
                        Case 2
                            EditNote.Oct = EditNote.Oct + Increment
                        Case 3
                            EditNote.Dur = EditNote.Dur + Increment
                            If EditNote.Dur < 1 Then EditNote.Dur = 0
                    End Select

                    If EditNote.Oct = 3 Then ' Keep octave value in range.
                        If EditNote.Note > C Then
                            EditNote.Oct = 2
                        End If
                    ElseIf EditNote.Oct > 3 Then
                        EditNote.Oct = 3
                    ElseIf EditNote.Oct < -2 Then
                        EditNote.Oct = -2
                    End If
                  
                Case "K", "M" ' Left arrow or Right arrow key pressed.
                    If Right$(k$, 1) = "K" Then ' Set increment appropriately.
                        Increment = -1
                    Else
                        Increment = 1
                    End If
   
                    EditField = EditField + Increment ' Change edit mode according
                    If EditField > 3 Then EditField = 1 ' to increment's value.
                    If EditField < 1 Then EditField = 3

                    Locate 21, 42 ' Redraw the field titles to
                    Color 0, 7 ' show which one has focus.
                    Print "Note       Octave      Duration"
                    Color 7, 0
                    Select Case EditField
                        Case 1
                            Locate 21, 42
                            Print "Note"
                        Case 2
                            Locate 21, 53
                            Print "Octave"
                        Case 3
                            Locate 21, 65
                            Print "Duration"
                    End Select
                    Color 0, 7
     
            End Select
     
        ElseIf k$ = Chr$(13) Then ' Enter key = exit
            EditDone = TRUE
        ElseIf k$ = Chr$(27) Then ' Esc key = exit/cancel
            Cancelled = TRUE
            EditDone = TRUE
        End If
    Wend
    DisplayMenuText EDITOR ' Redisplay editor screen.
    Return

    '     - This subroutine inserts EditNote into the song just before the current note.
    InsertEditNote:
    Counter = Counter + 1
    For i = Counter To Cursor + 1 Step -1 ' Move all notes from current
        Song(i) = Song(i - 1) ' note down one notch, and put
    Next i ' the new note at the current
    Song(Cursor) = EditNote ' location.
    Cursor = Cursor + 1
    Return

End Sub

'-------------------------------------------------------------------------
' ErrorMessage
'
'   Prints an error message in a box and waits for a keypress.
'
'        PARAMETERS:    msg$ - The message to display in the box.
'-------------------------------------------------------------------------
Sub ErrorMessage (msg$) Static

    Color 15, 4 ' Draw the box.
    DrawBox 15, 15, 19, 65, ""
    Locate 16, 40 - Len(msg$) \ 2
    Print msg$ ' Print the message
    Locate 18, 27
    Print "Press any key to continue"

    Sound 250, 1 ' Make some sound.
    Sound 32767, 2
    Sound 200, 1

    Do While InKey$ = "": Loop ' Wait for a keypress.

End Sub

'-------------------------------------------------------------------------
' GetNameAndSave
'
'   Gets a name and description for a newly recorded song.  If the
'   user presses the Esc key, the song is not saved.
'
'             PARAMETERS:   None
'-------------------------------------------------------------------------
Sub GetNameAndSave Static

    DisplayMenuText GETNAME ' Display the screen info.

    Finished = FALSE
    EditField = 1
    naym$ = ""
    desc$ = ""

    While Finished = FALSE ' Depending on the value of
        Select Case EditField ' EditField, call SimpleEdit
            Case 1 ' with either naym$ or desc$
                RetVal = SimpleEdit(16, 27, naym$, 25) ' as a parameter.  Then, take
                If RetVal = TABCHAR Then EditField = 2 ' a look at the return value:
            Case 2 ' If it was a Tab key, then
                RetVal = SimpleEdit(19, 27, desc$, 40) ' switch to the other edit
                If RetVal = TABCHAR Then EditField = 1 ' field   otherwise, we're done.
        End Select

        If RetVal = ESC Or RetVal = CR Then
            If naym$ = "" And RetVal = CR Then ' Make sure user enters a name.
                ErrorMessage "You must supply a song name."
                DisplayMenuText GETNAME ' Redisplay dialog box.
                Locate 16, 27
                Print naym$
                Locate 19, 27
                Print desc$
            Else
                Finished = TRUE
            End If
        End If
    Wend

    If RetVal = CR Then ' Only save the song if the
        SongName = naym$ ' user pressed Enter to
        SongDesc = desc$ ' terminate the save dialog.
        SaveSong
    End If

End Sub

'-------------------------------------------------------------------------
' GetNote$
'
' Given a note number, return the text representation of that note.
'
'        PARAMETERS: Note - Value of note to be converted
'-------------------------------------------------------------------------
Function GetNote$ (Note) Static

    Select Case Note
        Case C
            GetNote$ = "C"
        Case D
            GetNote$ = "D"
        Case E
            GetNote$ = "E"
        Case F
            GetNote$ = "F"
        Case G
            GetNote$ = "G"
        Case A
            GetNote$ = "A"
        Case B
            GetNote$ = "B"
        Case DF
            GetNote$ = "D flat"
        Case EF
            GetNote$ = "E flat"
        Case GF
            GetNote$ = "G flat"
        Case AF
            GetNote$ = "A flat"
        Case BF
            GetNote$ = "B flat"
    End Select

End Function

'-------------------------------------------------------------------------
' InitFreq
'
'   Initializes the note frequency table and the keyboard map array.
'
'             PARAMETERS:   None
'-------------------------------------------------------------------------
Sub InitFreq Static

    '                    - Initialize frequency table
    Freq(1) = 4186
    Freq(2) = 4435
    Freq(3) = 4699
    Freq(4) = 4978
    Freq(5) = 5274
    Freq(6) = 5588
    Freq(7) = 5920
    Freq(8) = 6272
    Freq(9) = 6645
    Freq(10) = 7040
    Freq(11) = 7459
    Freq(12) = 7902

    ' Initialize keyboard map
    For i = 1 To 127
        Kyb(i).Note = 0 ' Set all keys to 0 first
        Kyb(i).Oct = 0 ' (that means no note is
    Next i ' played if that key is pressed).

    CurNote = C ' Initialize counter variables.
    CurOct = -1

    '
    ' The code below correlates note/octave values with the values
    ' returned by the INP(&H60) function, which is the function that reads
    ' the keyboard port to see what key is pressed.  The numbers returned by
    ' the keys pressed are sequential as follows:
    '
    '      KEY PRESSED             VALUE RETURNED
    '
    '      1 thru 0        ->      2  thru 11
    '      Q thru P        ->      16 thru 25
    '      A thru ;        ->      30 thru 39
    '      Z thru ,        ->      44 thru 51
    '

    'Mapping for Q through P
    Kyb(16).Note = A
    Kyb(16).Oct = -2
    Kyb(17).Note = B
    Kyb(17).Oct = -2
    Kyb(18).Note = C
    Kyb(18).Oct = -1
    Kyb(19).Note = D
    Kyb(19).Oct = -1
    Kyb(20).Note = E
    Kyb(20).Oct = -1
    Kyb(21).Note = F
    Kyb(21).Oct = -1
    Kyb(22).Note = G
    Kyb(22).Oct = -1
    Kyb(23).Note = A
    Kyb(23).Oct = -1
    Kyb(24).Note = B
    Kyb(24).Oct = -1
    Kyb(25).Note = C
    Kyb(25).Oct = 0
    Kyb(26).Note = D
    Kyb(26).Oct = 0
    Kyb(27).Note = E
    Kyb(27).Oct = 0

    'Mapping for 1 through 0
    Kyb(3).Note = BF
    Kyb(3).Oct = -2
    Kyb(5).Note = DF
    Kyb(5).Oct = -1
    Kyb(6).Note = EF
    Kyb(6).Oct = -1
    Kyb(8).Note = GF
    Kyb(8).Oct = -1
    Kyb(9).Note = AF
    Kyb(9).Oct = -1
    Kyb(10).Note = BF
    Kyb(10).Oct = -1
    Kyb(12).Note = DF
    Kyb(12).Oct = 0
    Kyb(13).Note = EF
    Kyb(13).Oct = 0

    'Mapping for Z through .
    Kyb(44).Note = F
    Kyb(44).Oct = 0
    Kyb(45).Note = G
    Kyb(45).Oct = 0
    Kyb(46).Note = A
    Kyb(46).Oct = 0
    Kyb(47).Note = B
    Kyb(47).Oct = 0
    Kyb(48).Note = C
    Kyb(48).Oct = 1
    Kyb(49).Note = D
    Kyb(49).Oct = 1
    Kyb(50).Note = E
    Kyb(50).Oct = 1
    Kyb(51).Note = F
    Kyb(51).Oct = 1
    Kyb(52).Note = G
    Kyb(52).Oct = 1
    Kyb(53).Note = A
    Kyb(53).Oct = 1

    'Mapping for A through ;
    Kyb(31).Note = GF
    Kyb(31).Oct = 0
    Kyb(32).Note = AF
    Kyb(32).Oct = 0
    Kyb(33).Note = BF
    Kyb(33).Oct = 0
    Kyb(35).Note = DF
    Kyb(35).Oct = 1
    Kyb(36).Note = EF
    Kyb(36).Oct = 1
    Kyb(38).Note = GF
    Kyb(38).Oct = 1
    Kyb(39).Note = AF
    Kyb(39).Oct = 1
    Kyb(40).Note = BF
    Kyb(40).Oct = 1

End Sub

'-------------------------------------------------------------------------
' LoadDefaultSong
'
'    Reads the data for either SONG1 or SONG2 into the Song() array.
'
'       PARAMETERS:     num - Indicates which internal song to load
'-------------------------------------------------------------------------
Sub LoadDefaultSong (num) Static

    If num = 1 Then ' Restore appropriate line number.
        Restore SONG1
    Else
        Restore SONG2
    End If

    Read SongName, SongDesc, Counter ' Read global song info.
    For i = 1 To Counter ' Read in the notes.
        Read n, o, Dur
        Song(i).Note = n
        Song(i).Oct = o
        Song(i).Dur = Dur
    Next i

End Sub

'-------------------------------------------------------------------------
' LoadSong
'
'   Given an index into the QSYNTH.DAT file, this SUB loads the song data from
'   the file into the global Song() array.
'
'        PARAMETERS:    SongNo - Index of song to load
'-------------------------------------------------------------------------
Sub LoadSong (SongNo) Static

    Dim HeaderInfo As FileHeader
    Dim S As SongIndexCard
    FileError = 0

    Open "QSYNTH.DAT" For Binary As 1

    ' seek to the beginning of the song index record and read it
    Seek #1, Len(HeaderInfo) + (Len(S) * (SongNo - 1)) + 1
    Get #1, , S
    SongName = S.naym ' Set the global song info.
    SongDesc = S.desc
    Counter = S.Size

    ' seek to the beginning of the actual song information according to the
    ' information in the song index record
    Seek #1, Len(HeaderInfo) + (Len(S) * MAXSONG) + S.Offset

    For i = 1 To Counter ' Read the notes in from disk.
        Get #1, , Song(i)
    Next i
    Close 1

End Sub

'-------------------------------------------------------------------------
' MainMenu
'
'   Handles the main menu.  It waits for a keypress and acts upon it.
'
'             PARAMETERS:   None
'-------------------------------------------------------------------------
Sub MainMenu Static

    Dim S As SongIndexCard
    Dim HeaderInfo As FileHeader ' Dimension variables.
    ReDim i$(1 To 10)

    Cursor = 1
    WindowTop = 1
    SongLoaded = 0
    GoSub LoadSongList

    Finished = FALSE
    While Not Finished
        DisplayMenuText MAIN
        GoSub DisplaySongList
        x$ = ""
        '     Wait for a relevant keypress
        While InStr("PSERDQ" + Chr$(13), x$) = 0 Or x$ = ""
            x$ = UCase$(InKey$)
            If Len(x$) > 1 Then
                If Right$(x$, 1) = "H" And Cursor > 1 Then
                    Cursor = Cursor - 1
                ElseIf Right$(x$, 1) = "P" And Cursor < UBound(i$) Then
                    Cursor = Cursor + 1
                End If
                GoSub DisplaySongList
            End If
        Wend

        Select Case x$
            Case "S"
                RecordMenu (TRUE) ' Practice mode.
  
            Case "P", Chr$(13) ' Load and play the appropriate song.
                If Cursor > 2 Then
                    LoadSong Cursor - 2
                Else
                    LoadDefaultSong Cursor
                End If
                PlaySong

            Case "E" ' Song editor
                If Cursor > 2 Then
                    LoadSong Cursor - 2
                    EditSong Cursor - 2
                Else
                    ErrorMessage "You cannot edit a system song."
                End If

            Case "R" ' Record mode
                SongRecorded = FALSE
                RecordMenu (FALSE)
                If SongRecorded Then
                    GetNameAndSave ' Only ask to save if something was recorded.
                End If
                GoSub LoadSongList

            Case "D" ' Delete song
                If Cursor > 2 Then
                    If ConfirmDelete Then
                        DeleteSong Cursor - 2
                        If Cursor = UBound(i$) Then Cursor = Cursor - 1
                        GoSub LoadSongList
                    End If
                Else
                    ErrorMessage "You cannot delete a system song."
                End If

            Case "Q" ' Quit QSynth.
                Finished = TRUE
        End Select
    Wend
    Exit Sub

    '       This subroutine loads the names of all the songs in the QSYNTH.DAT file.
    LoadSongList:
    Open "QSYNTH.DAT" For Binary As 1
    If LOF(1) = 0 Then
        CreateSongFile ' Create disk file if not there.
    End If
    HeaderInfo.Count = 0
    Get #1, , HeaderInfo
    ReDim i$(1 To 2 + HeaderInfo.Count) ' Size array appropriately.
    Restore SONG1 ' First two songs are provided as DATA statements.
    Read i$(1)
    Restore SONG2
    Read i$(2)

    For i = 3 To UBound(i$) ' Read the rest from disk.
        Get #1, , S
        i$(i) = S.naym
    Next i
    Close 1
    Return

    '       This subroutine displays the song list in the Song List box.
    DisplaySongList:
    Color 0, 7
    For i = 15 To 23
        Locate i, 8
        If i - 15 + WindowTop <= UBound(i$) Then
            Print " "; Left$(i$(i - 15 + WindowTop) + Space$(27), 25); " "
        Else
            Print Space$(27)
        End If
    Next i

    '       This subroutine displays the "cursor" by re-displaying the current song's name in a different color.
    DisplaySongCursor:
    If Cursor < WindowTop Then
        WindowTop = Cursor
        GoTo DisplaySongList
    ElseIf Cursor > WindowTop + 8 Then
        WindowTop = Cursor - 8
        GoTo DisplaySongList
    End If
    Color 7, 0
    Locate 15 + Cursor - WindowTop, 8
    Print " "; Left$(i$(Cursor) + Space$(27), 25); " "
    Color TEXTCOLOR, BACKGROUNDCOLOR
    Return

End Sub

'-------------------------------------------------------------------------
' PlayNote
'
'   Calculates the correct frequency of the note given in the octave
'   given for the duration given.
'
'        PARAMETERS:    Note    -       The note to play
'                       Octave  -       The octave to play the note in
'                       Duration# -     The duration (time) to play the note
'-------------------------------------------------------------------------
Sub PlayNote (Note, Octave, Duration#) Static

    If Note <> 0 Then
        ' Perform equation to find frequency value from the Freq() array
        ThisFreq& = Freq(Note) / (2 ^ (PITCH - Octave))

        If ThisFreq& > 32767 Then ThisFreq& = 32767
        Sound ThisFreq&, Duration#
    Else
        TimeDelay Duration#
    End If

End Sub

'-------------------------------------------------------------------------
' PlaySong
'
'   Performs song playback by running through the Song() array playing
'   each note, and highlighting each note on the keyboard.
'
'             PARAMETERS:   None
'-------------------------------------------------------------------------
Sub PlaySong Static

    DisplayMenuText PLAYBACK

    Do ' Wait for the Enter key,
        i$ = InKey$ ' Adjust the tempo.
        Select Case i$
            Case Chr$(27)
                Exit Sub
            Case Chr$(0) + "H", Chr$(0) + "M"
                ChangeTempo UP
            Case Chr$(0) + "P", Chr$(0) + "K"
                ChangeTempo DOWN
            Case Chr$(13)
                Exit Do
        End Select
    Loop

    Finished = FALSE
    For i = 1 To Counter
        DrawNote Song(i).Note, Song(i).Oct, DOWN
        For j = 1 To Song(i).Dur
            If Song(i).Note > 0 Then
                PlayNote Song(i).Note, Song(i).Oct, NOTETICK * TFACTOR
            Else
                PlayNote 0, 0, RESTTICK * TFACTOR
            End If

            i$ = InKey$ ' Adjust the TEMPO if need be.
            Select Case UCase$(i$)
                Case Chr$(27)
                    Finished = TRUE
                    Exit For
                Case Chr$(0) + "H", Chr$(0) + "M"
                    ChangeTempo UP
                Case Chr$(0) + "P", Chr$(0) + "K"
                    ChangeTempo DOWN
            End Select

        Next j
        DrawNote Song(i).Note, Song(i).Oct, UP ' "Undraw" the pressed key.
        If Finished Then Exit For
    Next i

End Sub

'-------------------------------------------------------------------------
' RecordMenu
'
'   Sets up the screen for record/practice mode.
'
'       PARAMETERS: NoSave  -   Indicates whether the user is doing PRACTICE or RECORD
'-------------------------------------------------------------------------
Sub RecordMenu (NoSave) Static

    If NoSave = TRUE Then
        DisplayMenuText PRACTICE ' Draw the PRACTICE screen.
    Else
        DisplayMenuText RECORD ' Draw the RECORD screen.
    End If
   
    Color 7, 0 ' Show the keyboard helper keys.
    Locate 6, 17: Print "2   4 5   7 8 9   - =   S D F   H J   L ; '"
    Locate 12, 16: Print "Q W E R T Y U I O P [ ] Z X C V B N M , . /"

    RecordMode NoSave
   
    Color , 0 ' Print spaces over both rows.
    Locate 6, 4: Print Space$(75)
    Locate 12, 4: Print Space$(75)
    Color , BACKGROUNDCOLOR
 
End Sub

'-------------------------------------------------------------------------
' RecordMode
'
'   Handles the keypresses from the user and plays
'   and records notes in the global Song() array.  For keyboard input,
'   it uses the INP function to read from the keyboard port (ADDR = 0x60).
'   This is done to determine what key was pressed and how long it was pressed.
'
'       PARAMETERS: NoSave  -   Indicates whether the user is doing PRACTICE or RECORD
'-------------------------------------------------------------------------
Sub RecordMode (NoSave) Static

    Hld$ = ""
    Counter = 1
    Song(Counter).Note = 0
    Song(Counter).Dur = 0
    KeyState = UP
    oi$ = "": n$ = ""
    For i = 1 To 12
        n$ = n$ + Chr$(i)
    Next i
    n$ = Mid$(n$, 10) + n$ + n$ + n$ ' Used for the XT version.
    o$ = "00011111111111122222222222233333333333"

    If Inp(&H60) = 0 Then ' If 0, we must use INKEY$
        XTKeyboard = TRUE ' instead of INP(&H60)
    Else ' because of certain keyboard
        XTKeyboard = FALSE ' controllers that do not
    End If ' keep the last keypress in the &h60 port.
    Do
        i$ = InKey$
    Loop While i$ = "" ' Wait for first keypress.
    If i$ = Chr$(27) Then Exit Sub ' Esc means no song recorded.

    x = 0
    While i$ <> Chr$(27)
        If XTKeyboard Then ' Do this block if XT keyboard
            If i$ = oi$ Then
                If Song(Counter).Note = 0 Then
                    PlayNote Song(Counter).Note, Song(Counter).Oct, RESTTICK
                    Song(Counter).Dur = Song(Counter).Dur + 1
                Else ' a real note
                    PlayNote Song(Counter).Note, Song(Counter).Oct, XTNOTELENGTH * NOTETICK
                    Song(Counter).Dur = Song(Counter).Dur + XTNOTELENGTH
                End If
            ElseIf i$ <> "" Then
                keyloc = InStr("Q2WE4R5TY7U8I9OP-[=]ZSXDCFVBHNJM,L.;/'", UCase$(i$))
                If keyloc = 0 Then
                    DrawNote Song(Counter).Note, Song(Counter).Oct, UP
                    Counter = Counter + 1
                    If Counter > MAXNOTE Then
                        ErrorMessage "Maximum song length reached."
                        GoTo GetOut
                    End If
                    Song(Counter).Note = 0
                    Song(Counter).Oct = 0 ' Rests are counted.
                    Song(Counter).Dur = 0
                    DrawNote Song(Counter).Note, Song(Counter).Oct, DOWN
                Else
                    DrawNote Song(Counter).Note, Song(Counter).Oct, UP
                    Counter = Counter + 1
                    NewNote = Asc(Mid$(n$, keyloc, 1))
                    NewOct = Val(Mid$(o$, keyloc, 1)) - 2

                    If Counter > MAXNOTE Then
                        ErrorMessage "Maximum song length reached."
                        GoTo GetOut
                    End If
                    Song(Counter).Note = NewNote
                    Song(Counter).Oct = NewOct
                    Song(Counter).Dur = XTNOTELENGTH
                    DrawNote Song(Counter).Note, Song(Counter).Oct, DOWN
                    PlayNote Song(Counter).Note, Song(Counter).Oct, XTNOTELENGTH * NOTETICK
                    TimeDelay XTNOTELENGTH * NOTETICK
                End If
            ElseIf i$ = "" Then
                DrawNote Song(Counter).Note, Song(Counter).Oct, UP
                Counter = Counter + 1
                If Counter > MAXNOTE Then
                    ErrorMessage "Maximum song length reached."
                    GoTo GetOut
                End If
                Song(Counter).Note = 0
                Song(Counter).Oct = 0
                Song(Counter).Dur = 0
                DrawNote Song(Counter).Note, Song(Counter).Oct, DOWN
            End If
        
        Else ' Do this block if not XT keyboard.
            ox = x
            Hld$ = Hld$ + i$
            If (Len(Hld$) < 2) And (Song(Counter).Dur > 8) And (Song(Counter).Note <> 0) Then
                x = 1
            Else
                x = Inp(&H60)
            End If

            If ox = x Then ' no change in keypress
                Song(Counter).Dur = Song(Counter).Dur + 1
                If Song(Counter).Note = 0 Then ' a rest
                    PlayNote Song(Counter).Note, Song(Counter).Oct, RESTTICK
                Else ' a real note
                    PlayNote Song(Counter).Note, Song(Counter).Oct, NOTETICK
                End If
                If Len(Hld$) > 1 Then Hld$ = ""

            ElseIf x < 128 Then ' it's a KEYDOWN event
                If KeyState = DOWN Then
                    DrawNote Song(Counter).Note, Song(Counter).Oct, UP
                End If
                Counter = Counter + 1
                If Counter > MAXNOTE Then
                    ErrorMessage "Maximum song length reached."
                    GoTo GetOut
                End If
                Song(Counter).Note = Kyb(x).Note
                Song(Counter).Oct = Kyb(x).Oct
                Song(Counter).Dur = 0
                DrawNote Song(Counter).Note, Song(Counter).Oct, DOWN
                Hld$ = ""
                KeyState = DOWN

            ElseIf (x - 128) <> ox Then ' an old key came up
                x = ox
                Song(Counter).Dur = Song(Counter).Dur + 1
                If Song(Counter).Note = 0 Then ' a rest
                    PlayNote Song(Counter).Note, Song(Counter).Oct, RESTTICK
                Else ' a real note
                    PlayNote Song(Counter).Note, Song(Counter).Oct, NOTETICK
                End If
                If Len(Hld$) > 1 Then Hld$ = ""
                 
            ElseIf KeyState = DOWN Then ' it's a KEYUP event
                KeyState = UP
                DrawNote Song(Counter).Note, Song(Counter).Oct, UP
                Counter = Counter + 1
                If Counter > MAXNOTE Then
                    ErrorMessage "Maximum song length reached."
                    GoTo GetOut
                End If
                Song(Counter).Note = 0
                Song(Counter).Dur = 0
                Hld$ = ""
            End If
        End If
        oi$ = i$
        i$ = InKey$
    Wend

    GetOut:
    DrawNote Song(Counter).Note, Song(Counter).Oct, UP ' Make sure that the last key pressed is released.

    If Counter = 1 Or NoSave = TRUE Then Exit Sub ' No notes recorded or Practice mode.

    While Song(Counter).Note = 0 And Counter > 0 ' Get rid of any rests at the end of the song.
        Counter = Counter - 1
    Wend

    SongRecorded = TRUE ' Let MainMenu know we have recorded a new song.

End Sub

'-------------------------------------------------------------------------
' SaveChanges
'
'   Asks the user if the changes just made to the current song with the song
'   editor should be saved or not.  It returns TRUE if so, or FALSE if not.
'
'             PARAMETERS:   None
'-------------------------------------------------------------------------
Function SaveChanges Static

    Color BACKGROUNDCOLOR, BACKGROUNDCOLOR
    DrawBox 13, 38, 24, 78, ""
    Color 0, 7
    DrawBox 15, 41, 20, 75, "Save Changes"
    Locate 17, 43
    Print "Do you want to save the changes"
    Locate , 43, 1
    Print "made to this song? (Y/N) ";

    Do ' Wait for keypress.
        i$ = UCase$(InKey$)
    Loop Until i$ = "Y" Or i$ = "N"

    Locate , , 0 ' Return appropriate value.
    If i$ = "Y" Then
        SaveChanges = TRUE
    Else
        SaveChanges = FALSE
    End If

End Function

'-------------------------------------------------------------------------
' SaveSong
'
' Saves the current song in the QSYNTH.DAT file, thus adding
' the song to the Song List.  The QSYNTH.DAT file has the following format:
'
'  o A file header having a fixed length (LEN(HeaderInfo), where HeaderInfo
'    is a variable of type FileHeader)
'
'  o A "Song Index Card" area having a fixed length (LEN(S) * MAXSONG, where
'    S is a variable of type SongIndexCard, and MAXSONG is the constant
'    which defines the maximum number of songs which can be saved in the file)
'
'  o A "Song Data" area which is of variable length, since the songs can be of
'    variable length.  Thus, the last MEANINGFUL byte in the file is the last
'    byte of song data of the last song in the file.  It is important to
'    understand that this last note of the last song may not be the last
'    physical byte of the file.  If a song is deleted from the file, the other
'    songs in the file are "moved up", to fill in the "hole" left by the song
'    that was deleted.  However, the file does not decrease in size.  Once the
'    remaining songs are moved up in the file, there exists "old" data starting
'    1 byte after the last note of the last song, and extending to the end of
'    the physical file.
'
'    The end of the meaningful data in the file can always be found using the
'    NextNote field of the FileHeader structure.  This value ALWAYS points to
'    the next AVAILABLE note position in the song data area of the file.  Thus,
'    the last byte of the last song in the file is at location NextNote-1.
'
'    IMPORTANT NOTE:  NextNote is relative to the beginning of the song data
'                     area, NOT the physical beginning of the file!  So, the
'                     physical location of the next available note can be found
'                     by:  LEN(Header) + LEN(S)*MAXSONG + Header.NextNote
'
'    Understanding this file structure is crucial to understanding how the
'    SaveSong and DeleteSong procedures work.  Here in SaveSong, the Song Index
'    Card is written to the FileHeader.Count+1 record of the SongIndexCard part
'    of the file, and the actual song data is written to the file starting at
'    the NextNote byte of the file.  (See the DeleteNote procedure for details
'    on how songs are deleted from the file).
'
'             PARAMETERS:   None
'-------------------------------------------------------------------------
Sub SaveSong Static

    Dim S As SongIndexCard
    Dim HeaderInfo As FileHeader
    FileError = 0

    Open "QSYNTH.DAT" For Binary As 1 ' Open the file.
    Get #1, , HeaderInfo ' Get header info.

    ' Seek to the next available song index record.  The Count field of the
    ' header record is 1-based, so LEN(S)*HeaderInfo.Count + 1 is the first
    ' byte of song index record #(Count+1)
    Seek #1, Len(HeaderInfo) + (Len(S) * HeaderInfo.Count) + 1

    S.naym = SongName ' Insert data for current song.
    S.desc = SongDesc
    S.Size = Counter
    S.Offset = HeaderInfo.NextNote ' PUT it into the file at the
    Put #1, , S ' file position found by the SEEK statement.

    ' Seek to the next available note position in the song data section.  This
    ' is found using the NextNote field of the file header structure.  Remember
    ' the NextNote pointer is relative to the start of the song data area,
    ' and not the physical beginning of the file, so we have to add the size of
    ' the file header and the song index card sections as well.
    Seek #1, Len(HeaderInfo) + (Len(S) * MAXSONG) + HeaderInfo.NextNote

    For i = 1 To Counter ' Write each note of the song
        Put #1, , Song(i) ' to the file.
    Next i

    ' Update the header information (increment the song count, and point
    ' NextNote at the next available note in the file by adding the size of the
    ' newly saved song to the current value of NextNote.
    HeaderInfo.Count = HeaderInfo.Count + 1
    HeaderInfo.NextNote = HeaderInfo.NextNote + (Counter * Len(Song(1)))
    Seek #1, 1 ' Seek to the start.
    Put #1, , HeaderInfo ' Write the new header.
    Close 1 ' The song is saved!

End Sub

'-------------------------------------------------------------------------
' SimpleEdit
'
' This function is a very simple one-line edit routine.  It allows entry of
' text up to a given maximum length, and the editing capabilities are
' limited to backspace (to delete the last character typed).  It returns a
' code indicating which terminator key was pressed:  Esc, Enter or Tab.
'
'        PARAMETERS:    row,col - Row and column position of first character
'                                 in text
'                       Text$   - String variable to place edited text (can
'                                 contain the initial value of the text)
'                       MaxLen  - Maximum length allowed for the entered text
'-------------------------------------------------------------------------
Function SimpleEdit (row, col, text$, MaxLen) Static

    Locate row, col, 1 ' Turn on the cursor.
    Print text$;

    Finished = FALSE
    While Not Finished
        i$ = InKey$
        Select Case i$
            Case Chr$(13)
                Finished = TRUE ' Enter key pressed.
                SimpleEdit = CR

            Case Chr$(27)
                Finished = TRUE ' Esc key pressed.
                SimpleEdit = ESC

            Case Chr$(9)
                Finished = TRUE ' Tab key pressed.
                SimpleEdit = TABCHAR

            Case Chr$(8) ' Backspace key pressed.
                If Len(text$) > 0 Then
                    text$ = Left$(text$, Len(text$) - 1)
                    Locate row, col
                    Print text$; " ";
                    Locate row, col + Len(text$)
                End If

            Case Chr$(32) TO Chr$(126)
                If Len(text$) < MaxLen Then ' Normal key - add it to text$.
                    text$ = text$ + i$
                    Print i$;
                End If
        End Select
    Wend

    Locate , , 0 ' Turn cursor off.

End Function

'-------------------------------------------------------------------------
' TimeDelay
'
'   Waits for a length of time equal to a SOUND 0, Cur# statement.
'
'        PARAMETERS:    Dur#    -       Duration of delay
'-------------------------------------------------------------------------
Sub TimeDelay (Dur#) Static

    x# = Timer ' Wait until Dur# seconds pass.
    While (Timer - x#) < (Dur# / 18.2): Wend

End Sub

