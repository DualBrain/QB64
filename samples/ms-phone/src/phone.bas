'For faster operation
DefInt A-Z

'Declaration of sub programs
DECLARE SUB ScrollDown ()
DECLARE SUB Initialize ()
DECLARE SUB PhoneEditor ()
DECLARE FUNCTION GetString$ (row, col, start$, end$, vis, max)

'Declaration of constants
Const TRUE = -1
Const false = Not TRUE

'declaration of global arrays
Dim Shared ScrollUpAsm(1 To 7) 'Stores asm routine to scroll up
Dim Shared ScrollDownAsm(1 To 7) 'Stores asm routine to scroll down

'Program
Initialize
PhoneEditor

'assembly routines
Data &HB8,&H01,&H06,&HB9,&H00,&H02,&HBA,&H4F,&H17,&HB7,&H00,&HCD,&H10,&HCB
Data &HB8,&H01,&H07,&HB9,&H00,&H02,&HBA,&H4F,&H17,&HB7,&H00,&HCD,&H10,&HCB

'                              Max Chars   Max
'       Title$     Column      Visible     Chars
Data "Name",2,19,30
Data "Phone",22,19,20
Data "Address",42,19,30
Data "City",62,9,20
Data "St",72,2,2
Data "Zip",75,5,5

'This funtion gets string input at location row,col.  The string to
'input is at most MAX characters long, and no more than VIS chars may be
'displayed.  The initial string is sent in START$, and the resulting
'string is returned as END$
'The function itself returns the keystroke that was used to exit this
'routine, for example, arrow keys, function keys, return, escape, etc...
'
Function GetString$ (row, col, start$, end$, vis, max)

    'establish current string
    curr$ = LTrim$(Left$(start$, max))

    'force cursor to exist
    Locate , , 1

    finished = false
    Do
        GoSub GetStringShowText
        GoSub GetStringGetKey

        If Len(kbd$) > 1 Then 'Exit if special key
            finished = TRUE
            GetString$ = kbd$
        Else
            Select Case kbd$
                Case Chr$(13), Chr$(27), Chr$(9) 'Exit if special key
                    finished = TRUE
                    GetString$ = kbd$
                
                Case Chr$(8) 'Handle backspace
                    If curr$ <> "" Then
                        curr$ = Left$(curr$, Len(curr$) - 1)
                    End If

                Case " " TO "}" 'Handle any text key
                    If Len(curr$) < max Then
                        curr$ = curr$ + kbd$
                    End If

                Case Else 'Beep for anything else
                    Beep
            End Select
        End If

    Loop Until finished

    end$ = curr$
    Exit Function
    

    GetStringShowText: 'Show at most VIS chars
    Locate row, col 'of string
    If Len(curr$) > vis Then
        Print Right$(curr$, vis);
    Else
        Print curr$; Space$(vis - Len(curr$));
        Locate row, col + Len(curr$)
    End If
    Return


    GetStringGetKey: 'Standard inkey loop
    Do
        kbd$ = InKey$
    Loop While kbd$ = ""
    Return

End Function

Sub Initialize

    'set up screen
    Width , 25
    View Print
    Locate , , 1

    'read in first asm routine
    P = VarPtr(ScrollUpAsm(1))
    Def Seg = VarSeg(ScrollUpAsm(1))
    For i = 0 To 13
        Read j
        Poke (P + i), j
    Next i

    'read in second asm routine
    P = VarPtr(ScrollDownAsm(1))
    Def Seg = VarSeg(ScrollDownAsm(1))
    For i = 0 To 13
        Read j
        Poke (P + i), j
    Next i

    'return segment to normal
    Def Seg

End Sub

Sub PhoneEditor

    'Dimension arrays
    Dim edit$(6) 'Current line being edited
    Dim Title$(6) 'Column titles
    Dim col(6) 'Column locations
    Dim vis(6) 'Maximum visible chars
    Dim max(6) 'Maximum chars allowes
    Dim io$(6) 'Used to RANDOM access file I/O
    Dim name1$(6) 'Temp storage to print names
    Dim name2$(6) 'Temp storage to print names
    Dim index(2000) 'Tells the editor where to find name on disk
    Dim key$(2000) 'Used for sorting

    'prepare screen
    For a = 1 To 6
        Read Title$(a), col(a), vis(a), max(a)
    Next a

    u1$ = "³\                 \³\                 \³\                 \³\       \³\\³\   \³"
    u2$ = "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÅÄÄÄÄÄ´"
    u3$ = "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÁÄÄÄÄÄÙ"
        
    Color 14, 1
    Cls
    
    Print Using u1$; Title$(1); Title$(2); Title$(3); Title$(4); Title$(5); Title$(6);
    Print u2$
    Locate 25, 1
    Print "          <F2=Exit>  <F5=Sort>  <F6=Print>  <F9=Insert>  <F10=Delete>";

    'Open random access file
    Open "Phone.dat" For Random As #1 Len = 107
    Field #1, 30 As io$(1), 20 As io$(2), 30 As io$(3), 15 As io$(4), 2 As io$(5), 5 As io$(6)
    Field #1, 11 As ioValid$, 5 As ioMaxRecord$

    'get first record, if it's a new file, it will initialize it.
    'Record #1 contains the code word "THISISVALID" indicating the file is
    'properly initialized, and the number of records in the file
    Get #1, 1
    If ioValid$ <> "THISISVALID" Then
        For a = 1 To 6
            LSet io$(a) = ""
        Next a
        Put #1, 2
        LSet ioValid$ = "THISISVALID"
        RSet ioMaxRecord$ = "1"
        Put #1, 1
    End If

    maxRecord = Val(ioMaxRecord$)

    'Set up initial index
    For a = 1 To maxRecord
        index(a) = a
    Next a


    'Initialize editor variables
    currTopLine = 1
    GoSub printWholeScreen

    currRow = 1
    currCol = 1
    GoSub GetLine

    finished = false

    'Main editor loop
    Do
        GoSub ShowCursor
        GoSub EditItem
        GoSub HideCursor

        'Respond to user keystroke
        Select Case kbd$
            Case Chr$(0) + "H" 'up
                GoSub MoveUp
            Case Chr$(0) + "P" 'down
                GoSub MoveDown
            Case Chr$(0) + "K", Chr$(0) + Chr$(15) 'left or backtab
                currCol = (currCol + 4) Mod 6 + 1
            Case Chr$(0) + "M", Chr$(9) 'right, or tab
                currCol = (currCol) Mod 6 + 1
            Case Chr$(0) + "G" 'Home
                currCol = 1
            Case Chr$(0) + "O" 'End
                currCol = 6
            Case Chr$(0) + "I" 'Page up
                currRow = 1
                currTopLine = currTopLine - 22
                If currTopLine < 1 Then
                    currTopLine = 1
                End If
                GoSub printWholeScreen
                currRow = 1
                GoSub GetLine
            Case Chr$(0) + "Q" 'Page Down
                currRow = 1
                currTopLine = currTopLine + 22
                If currTopLine > maxRecord Then
                    currTopLine = maxRecord
                End If
                GoSub printWholeScreen
                currRow = 1
                GoSub GetLine
            Case Chr$(0) + "<" 'F2
                finished = TRUE
            Case Chr$(0) + "?" 'F5
                GoSub sort
            Case Chr$(0) + "@": 'F6
                GoSub PrintPhoneBook
            Case Chr$(0) + "C" 'F9
                GoSub AddRecord
            Case Chr$(0) + "D"
                GoSub DeleteRecord 'F10
            Case Chr$(13) 'Enter
            Case Else
                Beep
        End Select
    Loop Until finished
    Close
    Exit Sub


    MoveUp:
    If currRow = 1 Then
        If currTopLine = 1 Then
            Beep
        Else
            ScrollDown
            currTopLine = currTopLine - 1
            GoSub GetLine
            GoSub PrintLine
        End If
    Else
        currRow = currRow - 1
        GoSub GetLine
    End If
    Return

    MoveDown:
    If (currRow + currTopLine - 1) >= maxRecord Then
        Beep
    Else
        If currRow = 22 Then
            ScrollDown
            currTopLine = currTopLine + 1
            GoSub GetLine
            GoSub PrintLine
        Else
            currRow = currRow + 1
            GoSub GetLine
        End If
    End If
    Return

    PrintPhoneBook:
    Cls
    Print "THIS IS A TEMPORARY PRINT ROUTINE"

    For a = 1 To maxRecord Step 2
        If a <= maxRecord Then
            Get #1, index(a) + 1
            For b = 1 To 6
                name1$(b) = RTrim$(io$(b))
            Next b
        Else
            For b = 1 To 6
                name1$(b) = ""
            Next b
        End If
        If a + 1 <= maxRecord Then
            Get #1, index(a + 1) + 1
            For b = 1 To 6
                name2$(b) = RTrim$(io$(b))
            Next b
        Else
            For b = 1 To 6
                name2$(b) = ""
            Next b
        End If
        u$ = "\" + Space$(35) + "\\" + Space$(38) + "\"
        Print Using u$; name1$(1); name2$(1)
        Print Using u$; name1$(3); name2$(3)
        Print Using u$; name1$(4) + "," + name1$(5) + "  " + name1$(6); name2$(4) + "," + name2$(5) + "  " + name2$(6)
        Print Using u$; name1$(2); name2$(2)
        Print
        Print
        Input a$
    Next a
    
    GoSub printWholeScreen
    Return

    ShowCursor:
    Color 0, 7
    Locate currRow + 2, col(currCol)
    Print Left$(edit$(currCol) + Space$(vis(currCol)), vis(currCol));
    Return

    HideCursor:
    Color 14, 1
    Locate currRow + 2, col(currCol)
    Print Left$(edit$(currCol) + Space$(vis(currCol)), vis(currCol));
    Return

    EditItem:
    'Wait for a keystroke
    Color 0, 7
    Do
        kbd$ = InKey$
    Loop Until kbd$ <> ""

    'if a text char, edit the line, else return
    If kbd$ >= " " And kbd$ <= "~" Then
        kbd$ = GetString$(currRow + 2, col(currCol), kbd$, back$, vis(currCol), max(currCol))
        edit$(currCol) = back$
        GoSub putLine
    End If
    Return


    PrintLine:
    Color 14, 1
    currRecord = currTopLine + currRow - 1
    Locate currRow + 2, 1
    If currRecord = maxRecord + 1 Then
        Print u3$;
    ElseIf currRecord > maxRecord Then
        Print Space$(80);
    Else
        Print Using u1$; edit$(1); edit$(2); edit$(3); edit$(4); edit$(5); edit$(6);
    End If
    Return


    DeleteRecord:
    If maxRecord = 1 Then
        Beep
    Else
        currRecord = currTopLine + currRow - 1 'init currRecord
        maxRecord = maxRecord - 1 'Decrement maxRecord
        theRecord = index(currRecord) 'Save pointer to currRecord

        'Removing a name leaves a hole.  So...
        'Squeeze actual physical data records on disk
        For a = index(currRecord) To maxRecord
            Get #1, a + 2
            Put #1, a + 1
        Next a

        'Squeeze the index stored in memory.
        For a = currRecord To maxRecord
            index(a) = index(a + 1)
        Next a

        'Now that the actuall records were moved on disk, we need to
        'decrement the value of every pointer in the index array
        'that pointed to a name that was moved.
        For a = 1 To maxRecord
            If index(a) > theRecord Then
                index(a) = index(a) - 1
            End If
        Next a

        'Update record#1
        LSet ioValid$ = "THISISVALID"
        RSet ioMaxRecord$ = Str$(maxRecord)
        Put #1, 1

        'Reprint screen, restablish cursor position
        GoSub printWholeScreen
        currRecord = currTopLine + currRow - 1
        If currRecord > maxRecord Then
            GoSub MoveUp
        End If
        GoSub GetLine
    End If
    Return


    AddRecord:
    If maxRecord < 2000 Then
        currRecord = currTopLine + currRow - 1 'Establish current record#
        maxRecord = maxRecord + 1 'Increment maxRecord
        For a = 1 To 6 'Clear IO buffer
            LSet io$(a) = ""
        Next a
        Put #1, maxRecord + 1 'Insert into last pos in file

        'We just added the new record to the physical file, now we
        'need to make room in the index
        a = maxRecord
        While a > currRecord
            index(a + 1) = index(a)
            a = a - 1
        Wend
    
        'Assign new spot in index to the new record
        index(currRecord + 1) = maxRecord

        'Update first record
        LSet ioValid$ = "THISISVALID"
        RSet ioMaxRecord$ = Str$(maxRecord)
        Put #1, 1

        GoSub printWholeScreen
        GoSub GetLine
    Else
        Beep
    End If
    Return



    printWholeScreen:
    temp = currRow
    For currRow = 1 To 22
        currRecord = currTopLine + currRow - 1
        If currRecord <= maxRecord Then
            GoSub GetLine
        End If
        GoSub PrintLine
    Next currRow
    currRow = temp
    Return


    putLine:
    currRecord = currTopLine + currRow - 1
    For a = 1 To 6
        LSet io$(a) = edit$(a)
    Next a
    Put #1, index(currRecord) + 1
    Return

    GetLine:
    currRecord = currTopLine + currRow - 1
    Get #1, index(currRecord) + 1
    For a = 1 To 6
        edit$(a) = io$(a)
    Next a
    Return


    sort:
    'Scan database, collect the strings from the current col in key$()
    For a = 1 To maxRecord
        Get #1, index(a) + 1
        key$(a) = io$(currCol)
    Next a

    'do the bubble sort
    Do
        swapFlag = false
        For i = 1 To maxRecord - 1
            If key$(i) > key$(i + 1) Then
                Swap key$(i), key$(i + 1)
                Swap index(i), index(i + 1)
                swapFlag = TRUE
            End If
        Next i
    Loop Until Not swapFlag
        
    'Reprint the screen
    currTopLine = 1
    GoSub printWholeScreen
    currRow = 1
    GoSub GetLine
    Return

End Sub

Sub ScrollDown

    'Call the asm routine stored in the array
    Def Seg = VarSeg(ScrollDownAsm(1))
    Call Absolute(VarPtr(ScrollDownAsm(1)))
    Def Seg

End Sub

Sub ScrollUp

    'call the asm routnie stored in the array
    Def Seg = VarSeg(ScrollUpAsm(1))
    Call Absolute(VarPtr(ScrollUpAsm(1)))
    Def Seg

End Sub

