'* QCards - A simple database using a cardfile user interface.
'* Each record in the database is represented by a card. The user
'* can scroll through the cards using normal scrolling keys.
'* Other commands allow the user to edit, add, sort, find, or
'* delete cards.
'*
'* Input:  Keyboard - user commands and entries
'*         File - database records
'*
'* Output: Screen - card display and help
'*         File - database records
'*

' The module-level code begins here.

'*************** Declarations and definitions begin here ************

DefInt A-Z 'Resets default data type from single precision to integer

' Define names similar to keyboard names with equivalent key codes.
Const SPACE = 32, ESC = 27, ENTER = 13, TABKEY = 9
Const DOWN = 80, UP = 72, LEFT = 75, RIGHT = 77
Const HOME = 71, ENDK = 79, PGDN = 81, PGUP = 73
Const INS = 82, DEL = 83, NULL = 0
Const CTRLD = 4, CTRLG = 7, CTRLH = 8, CTRLS = 19, CTRLV = 22

' Define English names for color-specification numbers. Add BRIGHT to
' any color to get bright version.
Const BLACK = 0, BLUE = 1, GREEN = 2, CYAN = 3, RED = 4, MAGENTA = 5
Const YELLOW = 6, WHITE = 7, BRIGHT = 8

' Assign colors to different kinds of text. By changing the color
' assigned, you can change the color of the QCARDS display. The
' initial colors are chosen because they work for color or
' black-and-white displays.
Const BACKGROUND = BLACK, NORMAL = WHITE, HILITE = WHITE + BRIGHT
' Codes for normal and highlight (used in data statements)
Const CNORMAL = 0, CHILITE = 1

' Screen positions - Initialized for 25 rows. Screen positions can be
' modified for 43-row mode if you have an EGA or VGA adapter.
Const HELPTOP = 15, HELPBOT = 23, HELPLEFT = 60, HELPWID = 20
Const CARDSPERSCREEN = 7, LASTROW = 25

' Miscellaneous symbolic constants
Const FALSE = 0, TRUE = Not FALSE
Const CURSORON = 1, CURSOROFF = 0

' File names
Const TMPFILE$ = "$$$87y$.$5$" ' Unlikely file name
Const DISKFILE$ = "QCARDS.DAT"
' Field names
Const NPERSON = 0, NNOTE = 1, NMONTH = 2, NDAY = 3
Const NYEAR = 4, NPHONE = 5, NSTREET = 6, NCITY = 7
Const NSTATE = 8, NZIP = 9, NFIELDS = NZIP + 1

' Declare user-defined type (a data structure) for random-access
' file records.
Type PERSON
    CardNum As Integer 'First element is card number
    Names As String * 37 'Names (in order for alpha. sort)
    Note As String * 31 'Note about person
    Month As Integer 'Birth month
    Day As Integer 'Birth day
    Year As Integer 'Birth year
    Phone As String * 12 'Phone number
    Street As String * 29 'Street address
    City As String * 13 'City
    State As String * 2 'State
    Zip As String * 5 'Zip code
End Type

' SUB procedure declarations begin here.

DECLARE SUB Alarm ()

DECLARE SUB DirectionKey (Choice$, TopCard%, LastCard%)
DECLARE SUB AsciiKey (Choice$, TopCard%, LastCard%)
DECLARE SUB CleanUp (LastCard%)
DECLARE SUB ClearHelp ()
DECLARE SUB DrawCards ()
DECLARE SUB EditCard (Card AS PERSON)
DECLARE SUB InitIndex (LastCard%)
DECLARE SUB PrintLabel (Card AS PERSON)
DECLARE SUB SortIndex (SortField%, LastCard%)
DECLARE SUB ShowViewHelp ()
DECLARE SUB ShowTopCard (WorkCard AS PERSON)
DECLARE SUB ShowEditHelp ()
DECLARE SUB ShowCmdLine ()
DECLARE SUB ShowCards (TopCard%, LastCard%)

' FUNCTION procedure declarations begin here.
DECLARE FUNCTION EditString$ (InString$, Length%, NextField%)
DECLARE FUNCTION FindCard% (TopCard%, LastCard%)
DECLARE FUNCTION Prompt$ (Msg$, Row%, Column%, Length%)
DECLARE FUNCTION SelectField% ()

' Procedure declarations end here.


' Define a dummy record as a work card.
Dim Card As PERSON

'*************** Declarations and definitions end here **************

' The execution-sequence logic of QCARDS begins here.

' Open data file QCARDS.DAT for random access using file #1

Open DISKFILE$ For Random As #1 Len = Len(Card)


' To count records in file, divide the length of the file by the
' length of a single record; use integer division (\) instead of
' normal division (/). Assign the resulting value to LastCard.

LastCard = LOF(1) \ Len(Card)




' Redefine the Index array to hold the records in the file plus
' 20 extra (the extra records allow the user to add cards).
' This array is dynamic - this means the number of elements
' in Index() varies depending on the size of the file.
' Also, Index() is a shared procedure, so it is available to
' all SUB and FUNCTION procedures in the program.
'
' Note that an error trap lets QCARDS terminate with an error
' message if the memory available is not sufficient. If no
' error is detected, the error trap is turned off following the
' REDIM statement.

On Error GoTo MemoryErr
ReDim Shared Index(1 To LastCard + 20) As PERSON
On Error GoTo 0


' Use the block IF...THEN...ELSE statement to decide whether
' to load the records from the disk file QCARDS.DAT into the
' array of records called Index() declared earlier. In the IF
' part, you will check to see if there are actually records
' in the file. If there are, LastCard will be greater than 0,
' and you can call the InitIndex procedure to load the records
' into Index(). LastCard is 0 if there are no records in the
' file yet. If there are no records in the file, the ELSE
' clause is executed. The code between ELSE and END IF starts
' the Index() array at card 1.

If LastCard <> 0 Then
    Call InitIndex(LastCard)
Else
    Card.CardNum = 1
    Index(1) = Card
    Put #1, 1, Card
End If



' Use the DrawCards procedure to initialize the screen
' and draw the cards. Then, set the first card as the top
' card. Finally, pass the variables TopCard and LastCard
' as arguments to the ShowCards procedure. The call to
' ShowCards places all the data for TopCard on the front
' card on the screen, then it places the top-line
' information (the person's name) on the remaining cards.

Call DrawCards
TopCard = 1
Call ShowCards(TopCard, LastCard)



' Keep the picture on the screen forever with an unconditional
' DO...LOOP statement. The DO part of the statement goes on
' the next code line. The LOOP part goes just before the END
' statement. This loop encloses the central logic that lets
' a user interact with QCARDS.

Do



    ' Get user keystroke with a conditional DO...LOOP statement.
    ' Within the loop, use the INKEY$ function to capture a user
    ' keystroke, which is then assigned to a string variable. The
    ' WHILE part of the LOOP line keeps testing the string
    ' variable. Until a key is pressed, INKEY$ keeps returning a
    ' null (that is a zero-length) string, represented by "".
    ' When a key is pressed, INKEY$ returns a string with a
    ' length greater than zero, and the loop terminates.

    ' DO...LOOP with test at the bottom of the loop
    Do
        Choice$ = InKey$
    Loop While Choice$ = ""




    ' Use the LEN function to find out whether Choice$ is greater
    ' than a single character (i.e. a single byte). If Choice$ is
    ' a single character (that is, it is less than 2 bytes long),
    ' the key pressed was an ordinary "typewriter keyboard"
    ' character (these are usually called ASCII keys because they
    ' are part of the ASCII character set). When the user enters
    ' an ASCII character, it indicates a choice of one of the QCARDS
    ' commands from the command line at the bottom of the screen.
    ' If the user did press an ASCII key, use the LCASE$ function
    ' to convert it to lower case (in the event the capital letter
    ' was entered).
    '
    ' The ELSE clause is only executed if Choice$ is longer than a
    ' single character (and therefore not a command-line key).
    ' If Choice$ is not an ASCII key, it represents an "extended"
    ' key. (The extended keys include the DIRECTION keys on the
    ' numeric keypad, which is why QCARDS looks for them.) The
    ' RIGHT$ function is then used trim away the extra byte,
    ' leaving a value that may correspond to one of the DIRECTION
    ' keys. Use a SELECT CASE construction to respond to those key-
    ' presses that represent numeric-keypad DIRECTION keys.

    If Len(Choice$) = 1 Then
        ' Handle ASCII keys.
        Call AsciiKey(Choice$, TopCard, LastCard)

    Else
        ' Convert 2-byte extended code to 1-byte ASCII code and handle.
        Choice$ = Right$(Choice$, 1)
        Call DirectionKey(Choice$, TopCard, LastCard)


    End If


    ' Adjust the cards according to the key pressed by the user,
    ' then call the ShowCards procedure to show adjusted stack.

    If TopCard < 1 Then TopCard = LastCard + TopCard
    If TopCard > LastCard Then TopCard = TopCard - LastCard
    If TopCard <= 0 Then TopCard = 1
    Call ShowCards(TopCard, LastCard)


    ' This is the bottom of the unconditional DO loop.

Loop

End

' The execution sequence of the module-level code ends here.
' The program may terminate elsewhere for legitimate reasons,
' but the normal execution sequence ends here. Statements
' beyond the END statement are executed only in response to
' other statements.
                           
' This first label, MemoryErr, is an error handler.

MemoryErr:
Print "Not enough memory. Can't read file."
End

' Data statements for screen output - initialized for 25 rows. Can be
' modified for 43-row mode if you have an EGA or VGA adapter.

CardScreen:
Data "                  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
Data "                  ³                                       ³"
Data "               ÚÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÍÍµ"
Data "               ³                                       ³  ³"
Data "            ÚÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÍÍµ  ³"
Data "            ³                                       ³  ³  ³"
Data "         ÚÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÍÍµ  ³  ³"
Data "         ³                                       ³  ³  ³  ³"
Data "      ÚÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÍÍµ  ³  ³  ³"
Data "      ³                                       ³  ³  ³  ³  ³"
Data "   ÚÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÍÍµ  ³  ³  ÃÄÄÙ"
Data "   ³                                       ³  ³  ³  ³  ³"
Data "ÚÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÍÍµ  ³  ³  ÃÄÄÙ"
Data "³ _____________________________________ ³  ³  ³  ³  ³"
Data "ÆÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍµ  ³  ³  ÃÄÄÙ"
Data "³ Note: _______________________________ ³  ³  ³  ³"
Data "³                                       ³  ³  ÃÄÄÙ"
Data "³ Birth: __/__/__   Phone: ___-___-____ ³  ³  ³"
Data "³                                       ³  ÃÄÄÙ"
Data "³ Street: _____________________________ ³  ³"
Data "³                                       ÃÄÄÙ"
Data "³ City: ____________ ST: __  Zip: _____ ³"
Data "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

' Color codes and strings for view-mode help

ViewHelp:
Data 0,"Select card with:"
Data 1,"      UP"
Data 1,"      DOWN"
Data 1,"      PGUP"
Data 1,"      PGDN"
Data 1,"      HOME"
Data 1,"      END"
Data 1,""
Data 1,""

' Color codes and strings for edit-mode help

EditHelp:
Data 0,"Next field:"
Data 1,"      TAB"
Data 0,"Accept card:"
Data 1,"      ENTER"
Data 0,"Edit field:"
Data 1,"      DEL     BKSP"
Data 1,"      RIGHT   LEFT"
Data 1,"      HOME    END"
Data 1,"      INS     ESC"

' Row, column, and length of each field

FieldPositions:
Data 14,6,37: ' Names
Data 16,12,31: ' Note
Data 18,13,2: ' Month
Data 18,16,2: ' Day
Data 18,19,2: ' Year
Data 18,31,12: ' Phone
Data 20,14,29: ' Street
Data 22,12,13: ' City
Data 22,29,2: ' State
Data 22,38,5: ' Zip
Data 0,0,0

Sub Alarm
    ' The Alarm procedure uses the SOUND statement to send
    ' signals to the computer's speaker and sound an alarm
    '
    '
    ' Parameters: None
    '
    ' Output: Sends an alarm to the user

    ' Change the numbers to vary the sound
    For Tone = 600 To 2000 Step 40
        Sound Tone, Tone / 7000
    Next Tone


End Sub

'*
'* AsciiKey - Handles ASCII keys. You can add new commands by
'* assigning keys and actions here and adding them to the command
'* line displayed by the ShowCmdLine SUB. For example, you could add
'* L (for Load new file) to prompt the user for a new database file.
'*
'* Params: UserChoice$ - key pressed by the user
'*         TopCard - the number of the current record
'*         LastCard - the number of records
'*
Sub AsciiKey (UserChoice$, TopCard%, LastCard%)
    Dim WorkCard As PERSON

    Select Case LCase$(UserChoice$)
        ' Edit the current card.
        Case "e"
            Call ShowEditHelp
            Tmp$ = Prompt$("Editing Card...", LASTROW, 1, 0)
            Call EditCard(Index(TopCard))
            Put #1, Index(TopCard).CardNum, Index(TopCard)
            Locate , , CURSOROFF
            Call ShowViewHelp

            ' Add and edit a blank or duplicate card.
        Case "a", "c"
            If UserChoice$ = "c" Then
                WorkCard = Index(TopCard) ' Duplicate of top card
            Else
                WorkCard.CardNum = 0 ' Initialize new card.
                WorkCard.Names = ""
                WorkCard.Note = ""
                WorkCard.Month = 0
                WorkCard.Day = 0
                WorkCard.Year = 0
                WorkCard.Phone = ""
                WorkCard.Street = ""
                WorkCard.City = ""
                WorkCard.State = ""
                WorkCard.Zip = ""
            End If
            TopCard = LastCard + 1
            LastCard = TopCard
            Index(TopCard) = WorkCard
            Index(TopCard).CardNum = TopCard
            Call ShowCards(TopCard, LastCard)
            Call ShowEditHelp
            Tmp$ = Prompt$("Editing Card...", LASTROW, 1, 0)
            Call EditCard(Index(TopCard))
            Put #1, Index(TopCard).CardNum, Index(TopCard)
            Locate , , CURSOROFF
            Call ShowViewHelp

            ' Move deleted card to end and adjust last card.
        Case "d"
            For Card = TopCard To LastCard - 1
                Swap Index(Card + 1), Index(Card)
            Next Card
            LastCard = LastCard - 1

            ' Find a specified card.
        Case "f"
            Call ShowEditHelp
            Tmp$ = "Enter fields for search (blank fields are ignored)"
            Tmp$ = Prompt$(Tmp$, LASTROW, 1, 0)
            Card = FindCard(TopCard, LastCard)
            If Card Then
                TopCard = Card
            Else
                Beep
                Call ClearHelp
                Tmp$ = "Can't find card. Press any key..."
                Tmp$ = Prompt$(Tmp$, LASTROW, 1, 1)
            End If
            Locate , , CURSOROFF
            Call ShowViewHelp

            ' Sorts cards by a specified field.
        Case "s"
            Call ClearHelp
            Tmp$ = "TAB to desired sort field, then press ENTER"
            Tmp$ = Prompt$(Tmp$, LASTROW, 1, 0)
            Call SortIndex(SelectField, LastCard)
            TopCard = 1
            Call ShowViewHelp

            ' Prints address of top card on printer.
        Case "p"
            Call PrintLabel(Index(TopCard))

            ' Terminates the program.
        Case "q", Chr$(ESC)
            Call CleanUp(LastCard)
            Locate , , CURSORON
            Cls
            End
        Case Else
            Beep
    End Select

End Sub

'*
'* CleanUp - Writes all records from memory to a file. Deleted
'* records (past the last card) will not be written. The valid records
'* are written to a temporary file. The old file is deleted, and the
'* new file is given the old name.
'*
'* Params: LastCard - the number of valid records
'*
'* Output: Valid records to DISKFILE$ through TMPFILE$
'*
Sub CleanUp (LastCard)

    ' Write records to temporary file in their current sort order.
    Open TMPFILE$ For Random As #2 Len = Len(Index(1))
    For Card = 1 To LastCard
        Put #2, Card, Index(Card)
    Next

    ' Delete old file and replace it with new version.
    Close
    Kill DISKFILE$
    Name TMPFILE$ As DISKFILE$

End Sub

'*
'* ClearHelp - Writes spaces to the help area of the screen.
'*
'* Params: None
'*
'* Output: Blanks to the screen
'*
Sub ClearHelp

    ' Clear key help
    Color NORMAL, BACKGROUND
    For Row = HELPTOP To HELPBOT
        Locate Row, HELPLEFT
        Print Space$(HELPWID)
    Next

    ' Clear command line
    Locate LASTROW, 1
    Print Space$(80);

End Sub

Sub DirectionKey (Choice$, TopCard%, LastCard%)
    Select Case Choice$
        Case Chr$(DOWN)
            TopCard = TopCard - 1
        Case Chr$(UP)
            TopCard = TopCard + 1
        Case Chr$(PGDN)
            TopCard = TopCard - CARDSPERSCREEN
        Case Chr$(PGUP)
            TopCard = TopCard + CARDSPERSCREEN
        Case Chr$(HOME)
            TopCard = LastCard
        Case Chr$(ENDK)
            TopCard = 1
        Case Else
            Call Alarm
    End Select

End Sub

'*
'* DrawCards - Initializes screen by setting the color, setting the
'* width and height, clearing the screen, and hiding the cursor. Then
'* writes card text and view-mode help to the screen.
'*
'* Params: None
'*
'* Output: Text to the screen
'*
Sub DrawCards

    ' Clear screen to current color.
    Width 80, LASTROW
    Color NORMAL, BACKGROUND
    Cls
    Locate , , CURSOROFF, 0, 7

    ' Display line characters that form cards.
    Restore CardScreen
    For Row = 1 To 23
        Locate Row, 4
        Read Tmp$
        Print Tmp$;
    Next

    ' Display help.
    Call ShowViewHelp

End Sub

'*
'* EditCard - Edits each field of a specified record.
'*
'* Params: Card - the record to be edited
'*
'* Return: Since Card is passed by reference, the edited version is
'*         effectively returned.
'*
Sub EditCard (Card As PERSON)

    ' Set NextFlag and continue editing each field.
    ' NextFlag is cleared when the user presses ENTER.

    NextFlag = TRUE
    Do

        Restore FieldPositions

        ' Start with first field.
        Read Row, Column, Length
        Locate Row, Column
        ' Edit string fields directly.
        Card.Names = EditString(RTrim$(Card.Names), Length, NextFlag)
        ' Result of edit determines whether to continue.
        If NextFlag = FALSE Then Exit Sub

        Read Row, Column, Length
        Locate Row, Column
        Card.Note = EditString(RTrim$(Card.Note), Length, NextFlag)
        If NextFlag = FALSE Then Exit Sub

        Read Row, Column, Length
        Locate Row, Column
        ' Convert numeric fields to strings for editing.
        Tmp$ = LTrim$(Str$(Card.Month))
        Tmp$ = EditString(Tmp$, Length, NextFlag)
        ' Convert result back to number.
        Card.Month = Val(Tmp$)
        Locate Row, Column
        Print Using "##_/"; Card.Month;
        If NextFlag = FALSE Then Exit Sub

        Read Row, Column, Length
        Locate Row, Column
        Tmp$ = LTrim$(Str$(Card.Day))
        Tmp$ = EditString(Tmp$, Length, NextFlag)
        Card.Day = Val(Tmp$)
        Locate Row, Column
        Print Using "##_/"; Card.Day;
        If NextFlag = FALSE Then Exit Sub

        Read Row, Column, Length
        Locate Row, Column
        Tmp$ = LTrim$(Str$(Card.Year))
        Tmp$ = EditString(Tmp$, Length, NextFlag)
        Card.Year = Val(Tmp$)
        Locate Row, Column
        Print Using "##"; Card.Year;
        If NextFlag = FALSE Then Exit Sub

        Read Row, Column, Length
        Locate Row, Column
        Card.Phone = EditString(RTrim$(Card.Phone), Length, NextFlag)
        RSet Card.Phone = Card.Phone
        If NextFlag = FALSE Then Exit Sub

        Read Row, Column, Length
        Locate Row, Column
        Card.Street = EditString(RTrim$(Card.Street), Length, NextFlag)
        If NextFlag = FALSE Then Exit Sub

        Read Row, Column, Length
        Locate Row, Column
        Card.City = EditString(RTrim$(Card.City), Length, NextFlag)
        If NextFlag = FALSE Then Exit Sub

        Read Row, Column, Length
        Locate Row, Column
        Card.State = EditString(RTrim$(Card.State), Length, NextFlag)
        If NextFlag = FALSE Then Exit Sub

        Read Row, Column, Length
        Locate Row, Column
        Card.Zip = EditString(RTrim$(Card.Zip), Length, NextFlag)
        If NextFlag = FALSE Then Exit Sub

    Loop

End Sub

'*
'* EditString$ - Edits a specified string. This function
'* implements a subset of editing functions used in the QuickBASIC
'* environment and in Windows. Common editing keys are recognized,
'* including direction keys, DEL, BKSP, INS (for insert and overwrite
'* modes), ESC, and ENTER. TAB is recognized only if the NextField
'* flag is set. CTRL-key equivalents are recognized for most keys.
'* A null string can be specified if no initial value is desired.
'* You could modify this function to handle additional QB edit
'* commands, such as CTRL+A (word back) and CTRL+F (word forward).
'*
'* Params: InString$ - The input string (can be null)
'*         Length - Maximum length of string (the function beeps and
'*           refuses additional keys if the user tries to enter more)
'*         NextField - Flag indicating on entry whether to accept TAB
'*           key; on exit, indicates whether the user pressed
'*           TAB (TRUE) or ENTER (FALSE)
'*
'* Input:  Keyboard
'* Ouput:  Screen - Noncontrol keys are echoed.
'*         Speaker - beep if key is invalid or string is too long
'*
'* Return: The edited string
'*
Function EditString$ (InString$, Length, NextField)
    Static Insert

    ' Initialize variables and clear field to its maximum length.
    Work$ = InString$
    Row = CsrLin: Column = Pos(0)
    FirstTime = TRUE
    P = Len(Work$): MaxP = P
    Print Space$(Length);

    ' Since Insert is STATIC, its value is maintained from one
    ' call to the next. Insert is 0 (FALSE) the first time the
    ' function is called.
    If Insert Then
        Locate Row, Column, CURSORON, 6, 7
    Else
        Locate Row, Column, CURSORON, 0, 7
    End If

    ' Reverse video on entry.
    Color BACKGROUND, NORMAL
    Print Work$;

    ' Process keys until either TAB or ENTER is pressed.
    Do

        ' Get a key -- either a one-byte ASCII code or a two-byte
        ' extended code.
        Do
            Choice$ = InKey$
        Loop While Choice$ = ""

        'Translate two-byte extended codes to the one meaningful byte.
        If Len(Choice$) = 2 Then
            Choice$ = Right$(Choice$, 1)
            Select Case Choice$

                ' Translate extended codes to ASCII control codes.
                Case Chr$(LEFT)
                    Choice$ = Chr$(CTRLS)
                Case Chr$(RIGHT)
                    Choice$ = Chr$(CTRLD)
                Case Chr$(INS)
                    Choice$ = Chr$(CTRLV)
                Case Chr$(DEL)
                    Choice$ = Chr$(CTRLG)

                    ' Handle HOME and END keys, since they don't have
                    ' control codes. Send NULL as a signal to ignore.
                Case Chr$(HOME)
                    P = 0
                    Choice$ = Chr$(NULL)
                Case Chr$(ENDK)
                    P = MaxP
                    Choice$ = Chr$(NULL)

                    ' Make other key choices invalid.
                Case Else
                    Choice$ = Chr$(1)
            End Select
        End If

        ' Handle one-byte ASCII codes.
        Select Case Asc(Choice$)

            ' If it is null, ignore it.
            Case NULL

                ' Accept field (and card if NextField is used).
            Case ENTER
                NextField = FALSE
                Exit Do

                ' Accept the field unless NextField is used. If NextField
                ' is cleared, TAB is invalid.
            Case TABKEY
                If NextField Then
                    Exit Do
                Else
                    Beep
                End If

                ' Restore the original string.
            Case ESC
                Work$ = InString$
                Locate Row, Column, CURSOROFF
                Print Space$(MaxP)
                Exit Do

                ' CTRL+S or LEFT arrow moves cursor to left.
            Case CTRLS
                If P > 0 Then
                    P = P - 1
                    Locate , P + Column
                Else
                    Beep
                End If

                ' CTRL+D or RIGHT arrow moves cursor to right.
            Case CTRLD
                If P < MaxP Then
                    P = P + 1
                    Locate , P + Column
                Else
                    Beep
                End If

                ' CTRL+G or DEL deletes character under cursor.
            Case CTRLG
                If P < MaxP Then
                    Work$ = Left$(Work$, P) + Right$(Work$, MaxP - P - 1)
                    MaxP = MaxP - 1
                Else
                    Beep
                End If

                ' CTRL+H or BKSP deletes character to left of cursor.
            Case CTRLH, 127
                If P > 0 Then
                    Work$ = Left$(Work$, P - 1) + Right$(Work$, MaxP - P)
                    P = P - 1
                    MaxP = MaxP - 1
                End If

                ' CTRL+V or INS toggles between insert & overwrite modes.
            Case CTRLV
                Insert = Not Insert
                If Insert Then
                    Locate , , , 6, 7
                Else
                    Locate , , , 0, 7
                End If

                ' Echo ASCII characters to screen.
            Case Is >= SPACE

                ' Clear the field if this is first keystroke, then
                ' start from the beginning.
                If FirstTime Then
                    Locate , Column
                    Color NORMAL, BACKGROUND
                    Print Space$(MaxP);
                    Locate , Column
                    P = 0: MaxP = P
                    Work$ = ""
                End If

                ' If insert mode and cursor not beyond end, insert
                ' character.
                If Insert Then
                    If MaxP < Length Then
                        Work$ = Left$(Work$, P) + Choice$ + Right$(Work$, MaxP - P)
                        MaxP = MaxP + 1
                        P = P + 1
                    Else
                        Beep
                    End If

                Else
                    ' If overwrite mode and cursor at end (but
                    ' not beyond), insert character.
                    If P = MaxP Then
                        If MaxP < Length Then
                            Work$ = Work$ + Choice$
                            MaxP = MaxP + 1
                            P = P + 1
                        Else
                            Beep
                        End If

                        ' If overwrite mode and before end, overwrite
                        ' character.
                    Else
                        Mid$(Work$, P + 1, 1) = Choice$
                        P = P + 1
                    End If
                End If

                ' Consider other key choices invalid.
            Case Else
                Beep
        End Select
       
        ' Print the modified string.
        Color NORMAL, BACKGROUND
        Locate , Column, CURSOROFF
        Print Work$ + " ";
        Locate , Column + P, CURSORON
        FirstTime = FALSE

    Loop

    ' Print the final string and assign it to function name.
    Color NORMAL, BACKGROUND
    Locate Row, Column, CURSOROFF
    Print Work$;
    EditString$ = Work$
    Locate Row, Column

End Function

'*
'* FindCard - Finds a specified record. The user specifies as many
'* fields to search for as desired. The search begins at the card
'* after the current card and proceeds until the specified record or
'* the current card is reached. Specified records are retained between
'* calls to make repeat searching easier. This SUB could be enhanced
'* to find partial matches of string fields.
'*
'* Params: TopCard - number of top card
'*         LastCard - number of last card
'*
'* Params: None
'*
'* Return: Number (zero-based) of the selected field
'*
Function FindCard% (TopCard%, LastCard%)

    Static TmpCard As PERSON, NotFirst

    ' Initialize string fields to null on the first call. (Note that
    ' the variables TmpCard and NotFirst, declared STATIC above,
    ' retain their values between subsequent calls.)
    If NotFirst = FALSE Then
        TmpCard.Names = ""
        TmpCard.Note = ""
        TmpCard.Phone = ""
        TmpCard.Street = ""
        TmpCard.City = ""
        TmpCard.State = ""
        TmpCard.Zip = ""
        NotFirst = TRUE
    End If

    ' Show top card, then use EditCardFunction to specify fields
    ' for search.
    Call ShowTopCard(TmpCard)
    Call EditCard(TmpCard)

    ' Search until a match is found or all cards have been checked.
    Card = TopCard
    Do
        Card = Card + 1
        If Card > LastCard Then Card = 1
        Found = 0

        ' Test name to see if it's a match.
        Select Case RTrim$(UCase$(TmpCard.Names))
            Case "", RTrim$(UCase$(Index(Card).Names))
                Found = Found + 1
            Case Else
        End Select
                                   
        ' Test note text.
        Select Case RTrim$(UCase$(TmpCard.Note))
            Case "", RTrim$(UCase$(Index(Card).Note))
                Found = Found + 1
            Case Else
        End Select
                                   
        ' Test month.
        Select Case TmpCard.Month
            Case 0, Index(Card).Month
                Found = Found + 1
            Case Else
        End Select
                                 
        ' Test day.
        Select Case TmpCard.Day
            Case 0, Index(Card).Day
                Found = Found + 1
            Case Else
        End Select
                                 
        ' Test year.
        Select Case TmpCard.Year
            Case 0, Index(Card).Year
                Found = Found + 1
            Case Else
        End Select
                                 
        ' Test phone number.
        Select Case RTrim$(UCase$(TmpCard.Phone))
            Case "", RTrim$(UCase$(Index(Card).Phone))
                Found = Found + 1
            Case Else
        End Select
                                 
        ' Test street address.
        Select Case RTrim$(UCase$(TmpCard.Street))
            Case "", RTrim$(UCase$(Index(Card).Street))
                Found = Found + 1
            Case Else
        End Select
                                  
        ' Test city.
        Select Case RTrim$(UCase$(TmpCard.City))
            Case "", RTrim$(UCase$(Index(Card).City))
                Found = Found + 1
            Case Else
        End Select
                                  
        ' Test state.
        Select Case RTrim$(UCase$(TmpCard.State))
            Case "", RTrim$(UCase$(Index(Card).State))
                Found = Found + 1
            Case Else
        End Select
                                  
        ' Test zip code.
        Select Case TmpCard.Zip
            Case "", RTrim$(UCase$(Index(Card).Zip))
                Found = Found + 1
            Case Else
        End Select

        ' If match is found, set function value and quit, else
        ' next card.
        If Found = NFIELDS - 1 Then
            FindCard% = Card
            Exit Function
        End If

    Loop Until Card = TopCard

    ' Return FALSE when no match is found.
    FindCard% = FALSE

End Function

'*
'* InitIndex - Reads records from file and assigns each value to
'* array records. Index values are set to the actual order of the
'* records in the file. The order of records in the array may change
'* because of sorting or additions, but the CardNum field always
'* has the position in which the record actually occurs in the file.
'*
'* Params: LastCard - number of records in array
'*
'* Input:  File DISKFILE$
'*
Sub InitIndex (LastCard) Static
    Dim Card As PERSON

    For Record = 1 To LastCard
    
        ' Read a record from the file and put each field in the array.
        Get #1, Record, Card
        Index(Record).CardNum = Record
        Index(Record).Names = Card.Names
        Index(Record).Note = Card.Note
        Index(Record).Month = Card.Month
        Index(Record).Day = Card.Day
        Index(Record).Year = Card.Year
        Index(Record).Phone = Card.Phone
        Index(Record).Street = Card.Street
        Index(Record).City = Card.City
        Index(Record).State = Card.State
        Index(Record).Zip = Card.Zip

    Next Record

End Sub

'*
'* PrintLabel - Prints the name, address, city, state, and zip code
'* from a card. This SUB could easily be modified to print a return
'* address or center the address on an envelope.
'*
'* Params: Card - all the data about a person
'*
'* Output: Printer
'*
Sub PrintLabel (Card As PERSON)

    LPrint Card.Names
    LPrint Card.Street
    LPrint Card.City; ", "; Card.State; Card.Zip
    LPrint

End Sub

'*
'* Prompt$ - Prints a prompt at a specified location on the screen
'* and (optionally) gets a user response. This function can take one
'* of three different actions depending on the length parameter.
'*
'* Params: Msg$ - message or prompt (can be "" for no message)
'*         Row
'*         Column
'*         Length - one of the following:
'*           <1 - Don't wait for response
'*            1 - Get character response
'*           >1 - Get string response up to length
'*
'* Output: Keyboard
'* Output: Screen - noncontrol characters echoed
'*
'* Return: String entered by user
'*
Function Prompt$ (Msg$, Row, Column, Length)

    Locate Row, Column
    Print Msg$;
    
    Select Case Length
        Case Is <= 0 ' No return
            Prompt$ = ""
        Case 1 ' Character return
            Locate , , CURSORON
            Prompt$ = Input$(1)
        Case Else ' String return
            Prompt$ = EditString("", Length, FALSE)
    End Select

End Function

'*
'* SelectField - Enables a user to select a field using TAB key.
'* TAB moves to the next field. ENTER selects the current field.
'*
'* Params: None
'*
'* Return: Number (zero-based) of the selected field
'*
Function SelectField%

    ' Get first cursor position and set first FieldNum.
    Restore FieldPositions
    Read Row, Column, Length
    FieldNum = 0

    ' Rotate cursor through fields.
    Do

        ' Set cursor on current field.
        Locate Row, Column, CURSORON

        ' Get a TAB or ENTER.
        Do
            Ky = Asc(Input$(1))
        Loop Until (Ky = ENTER) Or (Ky = TABKEY)

        ' If ENTER pressed, turn off cursor and return field.
        If Ky = ENTER Then
            
            Locate , , CURSOROFF
            SelectField% = FieldNum
            Exit Function

            ' Otherwise, it was TAB, so advance to next field.
        Else

            FieldNum = FieldNum + 1
            Read Row, Column, Length
            If Row = 0 Then
                Restore FieldPositions
                Read Row, Column, Length
                FieldNum = 0
            End If

        End If

    Loop

End Function

'*
'* ShowCards - Shows all the fields of the top card and the top
'* field of the other visible cards.
'*
'* Params: TopCard - number of top card
'*         LastCard - number of last card
'*
'* Output: Screen
'*
Sub ShowCards (TopCard, LastCard)

    ' Show each field of top card.
    Call ShowTopCard(Index(TopCard))

    ' Show the Names field for other visible cards.
    Card = TopCard
    Restore FieldPositions
    Read Row, Column, Length
    For Count = 2 To CARDSPERSCREEN

        ' Show location and card number for next highest card.
        Row = Row - 2: Column = Column + 3
        Card = Card + 1
        If Card > LastCard Then Card = 1

        Locate Row, Column
        Print Space$(Length)

        Locate Row, Column
        Print Index(Card).Names

    Next Count

End Sub

'*
'* ShowCmdLine - Puts command line on screen with highlighted key
'* characters. Modify this SUB if you add additional commands.
'*
'* Params: None
'*
'* Output: Screen
'*
Sub ShowCmdLine

    Locate LASTROW, 1
    Color HILITE, BACKGROUND: Print " E";
    Color NORMAL, BACKGROUND: Print "dit Top   ";
    Color HILITE, BACKGROUND: Print "A";
    Color NORMAL, BACKGROUND: Print "dd New   ";
    Color HILITE, BACKGROUND: Print "C";
    Color NORMAL, BACKGROUND: Print "opy to New   ";
    Color HILITE, BACKGROUND: Print "D";
    Color NORMAL, BACKGROUND: Print "elete   ";
    Color HILITE, BACKGROUND: Print "F";
    Color NORMAL, BACKGROUND: Print "ind   ";
    Color HILITE, BACKGROUND: Print "S";
    Color NORMAL, BACKGROUND: Print "ort   ";
    Color HILITE, BACKGROUND: Print "P";
    Color NORMAL, BACKGROUND: Print "rint   ";
    Color HILITE, BACKGROUND: Print "Q";
    Color NORMAL, BACKGROUND: Print "uit ";

End Sub

'*
'* ShowEditHelp - Reads colors and strings for edit-mode help and
'* puts them on screen.
'*
'* Params: None
'*
'* Output: Screen
'*
Sub ShowEditHelp

    ' Clear old help and display new.
    ClearHelp
    Restore EditHelp
    For Row = HELPTOP To HELPBOT
        Read Clr
        If Clr = CNORMAL Then
            Color NORMAL, BACKGROUND
        Else
            Color HILITE, BACKGROUND
        End If
        Locate Row, HELPLEFT
        Read Tmp$
        Print Tmp$;
    Next

    ' Restore normal color.
    Color NORMAL, BACKGROUND

End Sub

'*
'* ShowTopCard - Shows all the fields of the top card.
'*
'* Params: WorkCard - record to be displayed as top card
'*
'* Output: Screen
'*
Sub ShowTopCard (WorkCard As PERSON)

    ' Display each field of current card.
    Restore FieldPositions
    Read Row, Column, Length
    Locate Row, Column
    Print Space$(Length);
    Locate Row, Column
    Print WorkCard.Names;

    Read Row, Column, Length
    Locate Row, Column
    Print Space$(Length);
    Locate Row, Column
    Print WorkCard.Note;

    Read Row, Column, Length
    Locate Row, Column
    Print Space$(Length);
    Locate Row, Column
    Print Using "##_/"; WorkCard.Month; WorkCard.Day;
    Print Using "##"; WorkCard.Year;
    Read Row, Column, Length, Row, Column, Length

    Read Row, Column, Length
    Locate Row, Column
    Print Space$(Length);
    Locate Row, Column
    Print WorkCard.Phone;

    Read Row, Column, Length
    Locate Row, Column
    Print Space$(Length);
    Locate Row, Column
    Print WorkCard.Street;

    Read Row, Column, Length
    Locate Row, Column
    Print Space$(Length);
    Locate Row, Column
    Print WorkCard.City;

    Read Row, Column, Length
    Locate Row, Column
    Print Space$(Length);
    Locate Row, Column
    Print WorkCard.State;

    Read Row, Column, Length
    Locate Row, Column
    Print Space$(Length)
    Locate Row, Column
    Print WorkCard.Zip;

End Sub

'*
'* ShowViewHelp - Reads colors and strings for view-mode help and
'* puts them on screen.
'*
'* Params: None
'*
'* Output: Screen
'*
Sub ShowViewHelp

    ' Clear old help and display new.
    ClearHelp
    Restore ViewHelp
    For Row = HELPTOP To HELPBOT
        Read Clr
        If Clr = CNORMAL Then
            Color NORMAL, BACKGROUND
        Else
            Color HILITE, BACKGROUND
        End If
        Locate Row, HELPLEFT
        Read Tmp$
        Print Tmp$;
    Next

    ' Restore color and show command line.
    Color NORMAL, BACKGROUND
    ShowCmdLine

End Sub

'*
'* SortIndex - Sorts all records in memory according to a specified
'* field. After the sort, the first record in memory becomes the top
'* card. Note that although the order is changed in memory, the order
'* remains the same in the file. The true file order is shown by the
'* CardNum field of each record. This SUB uses the Shell sort
'* algorithm.
'*
'* Params: SortField - 0-based number of the field to sort on
'*         LastCard - number of last card
'*
Sub SortIndex (SortField, LastCard)

    ' Set comparison offset to half the number of records.
    Offset = LastCard \ 2

    ' Loop until offset gets to zero.
    Do While Offset > 0

        Limit = LastCard - Offset

        Do

            ' Assume no switches at this offset.
            Switch = FALSE

            ' Compare elements for the specified field and switch
            ' any that are out of order.
            For i = 1 To Limit
                Select Case SortField
                    Case NPERSON
                        If Index(i).Names > Index(i + Offset).Names Then
                            Swap Index(i), Index(i + Offset)
                            Switch = i
                        End If
                    Case NNOTE
                        If Index(i).Note > Index(i + Offset).Note Then
                            Swap Index(i), Index(i + Offset)
                            Switch = i
                        End If
                    Case NMONTH
                        If Index(i).Month > Index(i + Offset).Month Then
                            Swap Index(i), Index(i + Offset)
                            Switch = i
                        End If
                    Case NDAY
                        If Index(i).Day > Index(i + Offset).Day Then
                            Swap Index(i), Index(i + Offset)
                            Switch = i
                        End If
                    Case NYEAR
                        If Index(i).Year > Index(i + Offset).Year Then
                            Swap Index(i), Index(i + Offset)
                            Switch = i
                        End If
                    Case NPHONE
                        If Index(i).Phone > Index(i + Offset).Phone Then
                            Swap Index(i), Index(i + Offset)
                            Switch = i
                        End If
                    Case NSTREET
                        If Index(i).Street > Index(i + Offset).Street Then
                            Swap Index(i), Index(i + Offset)
                            Switch = i
                        End If
                    Case NCITY
                        If Index(i).City > Index(i + Offset).City Then
                            Swap Index(i), Index(i + Offset)
                            Switch = i
                        End If
                    Case NSTATE
                        If Index(i).State > Index(i + Offset).State Then
                            Swap Index(i), Index(i + Offset)
                            Switch = i
                        End If
                    Case NZIP
                        If Index(i).Zip > Index(i + Offset).Zip Then
                            Swap Index(i), Index(i + Offset)
                            Switch = i
                        End If
                End Select

            Next i

            ' Sort on next pass only to location where last switch
            ' was made.
            Limit = Switch

        Loop While Switch

        ' No switches at last offset. Try an offset half as big.
        Offset = Offset \ 2
    Loop

End Sub

