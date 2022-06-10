'                    Q B a s i c   M O N E Y   M A N A G E R
'
'                   Copyright (C) Microsoft Corporation 1990
'
' The Money Manager is a personal finance manager that allows you
' to enter account transactions while tracking your account balances
' and net worth.
'
' To run this program, press Shift+F5.
'
' To exit QBasic, press Alt, F, X.
'
' To get help on a BASIC keyword, move the cursor to the keyword and press
' F1 or click the right mouse button.
'


'Set default data type to integer for faster operation
DefInt A-Z

'Sub and function declarations
DECLARE SUB TransactionSummary (item%)
DECLARE SUB LCenter (text$)
DECLARE SUB ScrollUp ()
DECLARE SUB ScrollDown ()
DECLARE SUB Initialize ()
DECLARE SUB Intro ()
DECLARE SUB SparklePause ()
DECLARE SUB Center (row%, text$)
DECLARE SUB FancyCls (dots%, Background%)
DECLARE SUB LoadState ()
DECLARE SUB SaveState ()
DECLARE SUB MenuSystem ()
DECLARE SUB MakeBackup ()
DECLARE SUB RestoreBackup ()
DECLARE SUB Box (Row1%, Col1%, Row2%, Col2%)
DECLARE SUB NetWorthReport ()
DECLARE SUB EditAccounts ()
DECLARE SUB PrintHelpLine (help$)
DECLARE SUB EditTrans (item%)
DECLARE FUNCTION Cvdt$ (X#)
DECLARE FUNCTION Cvst$ (X!)
DECLARE FUNCTION Cvit$ (X%)
DECLARE FUNCTION Menu% (CurrChoiceX%, MaxChoice%, choice$(), ItemRow%(), ItemCol%(), help$(), BarMode%)
DECLARE FUNCTION GetString$ (row%, col%, start$, end$, Vis%, Max%)
DECLARE FUNCTION Trim$ (X$)

'Constants
Const FALSE = 0, TRUE = Not FALSE

'User-defined types
Type AccountType
    Title As String * 20
    AType As String * 1
    Desc As String * 50
End Type

Type Recordtype
    Date As String * 8
    Ref As String * 10
    Desc As String * 50
    Fig1 As Double
    Fig2 As Double
End Type

'Global variables
Dim Shared account(1 To 19) As AccountType 'Stores the 19 account titles
Dim Shared ColorPref 'Color Preference
Dim Shared colors(0 To 20, 1 To 4) 'Different Colors
Dim Shared ScrollUpAsm(1 To 7) 'Assembly Language Routines
Dim Shared ScrollDownAsm(1 To 7)
Dim Shared PrintErr As Integer 'Printer error flag

Def Seg = 0 ' Turn off CapLock, NumLock and ScrollLock
KeyFlags = Peek(1047)
Poke 1047, &H0
Def Seg
  
'Open money manager data file.  If it does not exist in current directory,
'  goto error handler to create and initialize it.
On Error GoTo ErrorTrap
Open "money.dat" For Input As #1
Close
On Error GoTo 0 'Reset error handler

Initialize 'Initialize program
Intro 'Display introduction screen
MenuSystem 'This is the main program
Color 7, 0 'Clear screen and end
Cls

Def Seg = 0 ' Restore CapLock, NumLock and ScrollLock states
Poke 1047, KeyFlags
Def Seg

System 0

' Error handler for program
' If data file not found, create and initialize a new one.
ErrorTrap:
Select Case Err
    ' If data file not found, create and initialize a new one.
    Case 53
        Close
        ColorPref = 1
        For a = 1 To 19
            account(a).Title = ""
            account(a).AType = ""
            account(a).Desc = ""
        Next a
        SaveState
        Resume
    Case 24, 25
        PrintErr = TRUE
        Box 8, 13, 14, 69
        Center 11, "Printer not responding ... Press Space to continue"
        While InKey$ <> "": Wend
        While InKey$ <> " ": Wend
        Resume Next
    Case Else
End Select
Resume Next


'The following data defines the color schemes available via the main menu.
'
'    scrn  dots  bar  back   title  shdow  choice  curs   cursbk  shdow
Data 0,7,15,7,0,7,0,15,0,0
Data 1,9,12,3,0,1,15,0,7,0
Data 3,15,13,1,14,3,15,0,7,0
Data 7,12,15,4,14,0,15,15,1,0

'The following data is actually a machine language program to
'scroll the screen up or down very fast using a BIOS call.
Data &HB8,&H01,&H06,&HB9,&H01,&H04,&HBA,&H4E,&H16,&HB7,&H00,&HCD,&H10,&HCB
Data &HB8,&H01,&H07,&HB9,&H01,&H04,&HBA,&H4E,&H16,&HB7,&H00,&HCD,&H10,&HCB

'Box:
'  Draw a box on the screen between the given coordinates.
Sub Box (Row1, Col1, Row2, Col2) Static

    BoxWidth = Col2 - Col1 + 1

    Locate Row1, Col1
    Print "⁄"; String$(BoxWidth - 2, "ƒ"); "ø";

    For a = Row1 + 1 To Row2 - 1
        Locate a, Col1
        Print "≥"; Space$(BoxWidth - 2); "≥";
    Next a

    Locate Row2, Col1
    Print "¿"; String$(BoxWidth - 2, "ƒ"); "Ÿ";

End Sub

'Center:
'  Center text on the given row.
Sub Center (row, text$)
    Locate row, 41 - Len(text$) / 2
    Print text$;
End Sub

'Cvdt$:
'  Convert a double precision number to a string WITHOUT a leading space.
Function Cvdt$ (X#)

    Cvdt$ = Right$(Str$(X#), Len(Str$(X#)) - 1)

End Function

'Cvit$:
'  Convert an integer to a string WITHOUT a leading space.
Function Cvit$ (X)
    Cvit$ = Right$(Str$(X), Len(Str$(X)) - 1)
End Function

'Cvst$:
'  Convert a single precision number to a string WITHOUT a leading space
Function Cvst$ (X!)
    Cvst$ = Right$(Str$(X!), Len(Str$(X!)) - 1)
End Function

'EditAccounts:
'  This is the full-screen editor which allows you to change your account
'  titles and descriptions
Sub EditAccounts

    'Information about each column
    ReDim help$(4), col(4), Vis(4), Max(4), edit$(19, 3)

    'Draw the screen
    Color colors(7, ColorPref), colors(4, ColorPref)
    Box 2, 1, 24, 80

    Color colors(5, ColorPref), colors(4, ColorPref)
    Locate 1, 1: Print Space$(80)
    Locate 1, 4: Print "Account Editor";
    Color colors(7, ColorPref), colors(4, ColorPref)

    Locate 3, 2: Print "No≥ Account Title      ≥ Description                                      ≥A/L"
    Locate 4, 2: Print "ƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒ"
    u$ = "##≥\                  \≥\                                                \≥ ! "
    For a = 5 To 23
        Locate a, 2
        X = a - 4
        Print Using u$; X; account(X).Title; account(X).Desc; account(X).AType;
    Next a

    'Initialize variables
    help$(1) = "  Account name                             | <F2=Save and Exit> <Escape=Abort>"
    help$(2) = "  Account description                      | <F2=Save and Exit> <Escape=Abort>"
    help$(3) = "  Account type (A = Asset, L = Liability)  | <F2=Save and Exit> <Escape=Abort>"
                        
    col(1) = 5: col(2) = 26: col(3) = 78
    Vis(1) = 20: Vis(2) = 50: Vis(3) = 1
    Max(1) = 20: Max(2) = 50: Max(3) = 1

    For a = 1 To 19
        edit$(a, 1) = account(a).Title
        edit$(a, 2) = account(a).Desc
        edit$(a, 3) = account(a).AType
    Next a

    finished = FALSE

    CurrRow = 1
    CurrCol = 1
    PrintHelpLine help$(CurrCol)

    'Loop until F2 or <ESC> is pressed
    Do
        GoSub EditAccountsShowCursor 'Show Cursor
        Do 'Wait for key
            Kbd$ = InKey$
        Loop Until Kbd$ <> ""

        If Kbd$ >= " " And Kbd$ < "~" Then 'If legal, edit item
            GoSub EditAccountsEditItem
        End If
        GoSub EditAccountsHideCursor 'Hide Cursor so it can move
        'If it needs to
        Select Case Kbd$
            Case Chr$(0) + "H" 'Up Arrow
                CurrRow = (CurrRow + 17) Mod 19 + 1
            Case Chr$(0) + "P" 'Down Arrow
                CurrRow = (CurrRow) Mod 19 + 1
            Case Chr$(0) + "K", Chr$(0) + Chr$(15) 'Left or Shift+Tab
                CurrCol = (CurrCol + 1) Mod 3 + 1
                PrintHelpLine help$(CurrCol)
            Case Chr$(0) + "M", Chr$(9) 'Right or Tab
                CurrCol = (CurrCol) Mod 3 + 1
                PrintHelpLine help$(CurrCol)
            Case Chr$(0) + "<" 'F2
                finished = TRUE
                Save = TRUE
            Case Chr$(27) 'Esc
                finished = TRUE
                Save = FALSE
            Case Chr$(13) 'Return
            Case Else
                Beep
        End Select
    Loop Until finished

    If Save Then
        GoSub EditAccountsSaveData
    End If

    Exit Sub

    EditAccountsShowCursor:
    Color colors(8, ColorPref), colors(9, ColorPref)
    Locate CurrRow + 4, col(CurrCol)
    Print Left$(edit$(CurrRow, CurrCol), Vis(CurrCol));
    Return

    EditAccountsEditItem:
    Color colors(8, ColorPref), colors(9, ColorPref)
    ok = FALSE
    start$ = Kbd$
    Do
        Kbd$ = GetString$(CurrRow + 4, col(CurrCol), start$, end$, Vis(CurrCol), Max(CurrCol))
        edit$(CurrRow, CurrCol) = Left$(end$ + Space$(Max(CurrCol)), Max(CurrCol))
        start$ = ""

        If CurrCol = 3 Then
            X$ = UCase$(end$)
            If X$ = "A" Or X$ = "L" Or X$ = "" Or X$ = " " Then
                ok = TRUE
                If X$ = "" Then X$ = " "
                edit$(CurrRow, CurrCol) = X$
            Else
                Beep
            End If
        Else
            ok = TRUE
        End If
        
    Loop Until ok
    Return

    EditAccountsHideCursor:
    Color colors(7, ColorPref), colors(4, ColorPref)
    Locate CurrRow + 4, col(CurrCol)
    Print Left$(edit$(CurrRow, CurrCol), Vis(CurrCol));
    Return


    EditAccountsSaveData:
    For a = 1 To 19
        account(a).Title = edit$(a, 1)
        account(a).Desc = edit$(a, 2)
        account(a).AType = edit$(a, 3)
    Next a
    SaveState
    Return

End Sub

'EditTrans:
'  This is the full-screen editor which allows you to enter and change
'  transactions
Sub EditTrans (item)

    'Stores info about each column
    ReDim help$(6), col(6), Vis(6), Max(6), CurrString$(3), CurrFig#(5)
    'Array to keep the current balance at all the transactions
    ReDim Balance#(1000)

    'Open random access file
    file$ = "money." + Cvit$(item)
    Open file$ For Random As #1 Len = 84
    Field #1, 8 As IoDate$, 10 As IoRef$, 50 As IoDesc$, 8 As IoFig1$, 8 As IoFig2$
    Field #1, 11 As valid$, 5 As IoMaxRecord$, 8 As IoBalance$

    'Initialize variables
    CurrString$(1) = ""
    CurrString$(2) = ""
    CurrString$(3) = ""
    CurrFig#(4) = 0
    CurrFig#(5) = 0

    Get #1, 1
    If valid$ <> "THISISVALID" Then
        LSet IoDate$ = ""
        LSet IoRef$ = ""
        LSet IoDesc$ = ""
        LSet IoFig1$ = MKD$(0)
        LSet IoFig2$ = MKD$(0)
        Put #1, 2
        LSet valid$ = "THISISVALID"
        LSet IoMaxRecord$ = "1"
        LSet IoBalance$ = MKD$(0)
        Put #1, 1
    End If

    MaxRecord = Val(IoMaxRecord$)

    Balance#(0) = 0
    a = 1
    While a <= MaxRecord
        Get #1, a + 1
        Balance#(a) = Balance#(a - 1) + CVD(IoFig1$) - CVD(IoFig2$)
        a = a + 1
    Wend
    GoSub EditTransWriteBalance

    help$(1) = "Date of transaction (mm/dd/yy) "
    help$(2) = "Transaction reference number   "
    help$(3) = "Transaction description        "
    help$(4) = "Increase asset or debt value   "
    help$(5) = "Decrease asset or debt value   "

    col(1) = 2
    col(2) = 11
    col(3) = 18
    col(4) = 44
    col(5) = 55

    Vis(1) = 8
    Vis(2) = 6
    Vis(3) = 25
    Vis(4) = 10
    Vis(5) = 10

    Max(1) = 8
    Max(2) = 6
    Max(3) = 25
    Max(4) = 10
    Max(5) = 10


    'Draw Screen
    Color colors(7, ColorPref), colors(4, ColorPref)
    Box 2, 1, 24, 80

    Color colors(5, ColorPref), colors(4, ColorPref)
    Locate 1, 1: Print Space$(80);
    Locate 1, 4: Print "Transaction Editor: " + Trim$(account(item).Title);

    Color colors(7, ColorPref), colors(4, ColorPref)
    Locate 3, 2: Print "  Date  ≥ Ref# ≥ Description             ≥ Increase ≥ Decrease ≥   Balance    "
    Locate 4, 2: Print "ƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒ"

    u$ = "\      \≥\    \≥\                       \≥"
    u1$ = "        ≥      ≥                         ≥          ≥          ≥              "
    u1x$ = "ﬂﬂﬂﬂﬂﬂﬂﬂ≥ﬂﬂﬂﬂﬂﬂ≥ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ≥ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ≥ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ≥ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ"
    u2$ = "###,###.##"
    u3$ = "###,###,###.##"
    u4$ = "          "

    CurrTopline = 1
    GoSub EditTransPrintWholeScreen

    CurrRow = 1
    CurrCol = 1
    PrintHelpLine help$(CurrCol) + "|  <F2=Save and Exit> <F9=Insert> <F10=Delete>"

    GoSub EditTransGetLine

    finished = FALSE


    'Loop until <F2> is pressed
    Do
        GoSub EditTransShowCursor 'Show Cursor, Wait for key
        Do: Kbd$ = InKey$: Loop Until Kbd$ <> ""
        GoSub EditTransHideCursor

        If Kbd$ >= " " And Kbd$ < "~" Or Kbd$ = Chr$(8) Then 'If legal key, edit item
            GoSub EditTransEditItem
        End If

        Select Case Kbd$ 'Handle Special keys
            Case Chr$(0) + "H" 'up arrow
                GoSub EditTransMoveUp
            Case Chr$(0) + "P" 'Down arrow
                GoSub EditTransMoveDown
            Case Chr$(0) + "K", Chr$(0) + Chr$(15) 'Left Arrow,BackTab
                CurrCol = (CurrCol + 3) Mod 5 + 1
                PrintHelpLine help$(CurrCol) + "|  <F2=Save and Exit> <F9=Insert> <F10=Delete>"
            Case Chr$(0) + "M", Chr$(9) 'Right Arrow,Tab
                CurrCol = (CurrCol) Mod 5 + 1
                PrintHelpLine help$(CurrCol) + "|  <F2=Save and Exit> <F9=Insert> <F10=Delete>"
            Case Chr$(0) + "G" 'Home
                CurrCol = 1
            Case Chr$(0) + "O" 'End
                CurrCol = 5
            Case Chr$(0) + "I" 'Page Up
                CurrRow = 1
                CurrTopline = CurrTopline - 19
                If CurrTopline < 1 Then
                    CurrTopline = 1
                End If
                GoSub EditTransPrintWholeScreen
                GoSub EditTransGetLine
            Case Chr$(0) + "Q" 'Page Down
                CurrRow = 1
                CurrTopline = CurrTopline + 19
                If CurrTopline > MaxRecord Then
                    CurrTopline = MaxRecord
                End If
                GoSub EditTransPrintWholeScreen
                GoSub EditTransGetLine
            Case Chr$(0) + "<" 'F2
                finished = TRUE
            Case Chr$(0) + "C" 'F9
                GoSub EditTransAddRecord
            Case Chr$(0) + "D" 'F10
                GoSub EditTransDeleteRecord
            Case Chr$(13) 'Enter
            Case Else
                Beep
        End Select
    Loop Until finished

    Close

    Exit Sub


    EditTransShowCursor:
    Color colors(8, ColorPref), colors(9, ColorPref)
    Locate CurrRow + 4, col(CurrCol)
    Select Case CurrCol
        Case 1, 2, 3
            Print Left$(CurrString$(CurrCol), Vis(CurrCol));
        Case 4
            If CurrFig#(4) <> 0 Then
                Print Using u2$; CurrFig#(4);
            Else
                Print Space$(Vis(CurrCol));
            End If
        Case 5
            If CurrFig#(5) <> 0 Then
                Print Using u2$; CurrFig#(5);
            Else
                Print Space$(Vis(CurrCol));
            End If
    End Select
    Return


    EditTransHideCursor:
    Color colors(7, ColorPref), colors(4, ColorPref)
    Locate CurrRow + 4, col(CurrCol)
    Select Case CurrCol
        Case 1, 2, 3
            Print Left$(CurrString$(CurrCol), Vis(CurrCol));
        Case 4
            If CurrFig#(4) <> 0 Then
                Print Using u2$; CurrFig#(4);
            Else
                Print Space$(Vis(CurrCol));
            End If
        Case 5
            If CurrFig#(5) <> 0 Then
                Print Using u2$; CurrFig#(5);
            Else
                Print Space$(Vis(CurrCol));
            End If
    End Select
    Return


    EditTransEditItem:

    CurrRecord = CurrTopline + CurrRow - 1
    Color colors(8, ColorPref), colors(9, ColorPref)

    Select Case CurrCol
        Case 1, 2, 3
            Kbd$ = GetString$(CurrRow + 4, col(CurrCol), Kbd$, new$, Vis(CurrCol), Max(CurrCol))
            CurrString$(CurrCol) = new$
            GoSub EditTransPutLine
            GoSub EditTransGetLine
        Case 4
            start$ = Kbd$
            Do
                Kbd$ = GetString$(CurrRow + 4, col(4), start$, new$, Vis(4), Max(4))
                new4# = Val(new$)
                start$ = ""
            Loop While new4# >= 999999.99# Or new4# < 0

            a = CurrRecord
            While a <= MaxRecord
                Balance#(a) = Balance#(a) + new4# - CurrFig#(4) + CurrFig#(5)
                a = a + 1
            Wend
            CurrFig#(4) = new4#
            CurrFig#(5) = 0
            GoSub EditTransPutLine
            GoSub EditTransGetLine
            GoSub EditTransPrintBalances
            GoSub EditTransWriteBalance
        Case 5
            start$ = Kbd$
            Do
                Kbd$ = GetString$(CurrRow + 4, col(5), start$, new$, Vis(5), Max(5))
                new5# = Val(new$)
                start$ = ""
            Loop While new5# >= 999999.99# Or new5# < 0

            a = CurrRecord
            While a <= MaxRecord
                Balance#(a) = Balance#(a) - new5# + CurrFig#(5) - CurrFig#(4)
                a = a + 1
            Wend
            CurrFig#(4) = 0
            CurrFig#(5) = new5#
            GoSub EditTransPutLine
            GoSub EditTransGetLine
            GoSub EditTransPrintBalances
            GoSub EditTransWriteBalance
        Case Else
    End Select
    GoSub EditTransPrintLine
    Return

    EditTransMoveUp:
    If CurrRow = 1 Then
        If CurrTopline = 1 Then
            Beep
        Else
            ScrollDown
            CurrTopline = CurrTopline - 1
            GoSub EditTransGetLine
            GoSub EditTransPrintLine
        End If
    Else
        CurrRow = CurrRow - 1
        GoSub EditTransGetLine
    End If
    Return

    EditTransMoveDown:
    If (CurrRow + CurrTopline - 1) >= MaxRecord Then
        Beep
    Else
        If CurrRow = 19 Then
            ScrollUp
            CurrTopline = CurrTopline + 1
            GoSub EditTransGetLine
            GoSub EditTransPrintLine
        Else
            CurrRow = CurrRow + 1
            GoSub EditTransGetLine
        End If
    End If
    Return

    EditTransPrintLine:
    Color colors(7, ColorPref), colors(4, ColorPref)
    CurrRecord = CurrTopline + CurrRow - 1
    Locate CurrRow + 4, 2
    If CurrRecord = MaxRecord + 1 Then
        Print u1x$;
    ElseIf CurrRecord > MaxRecord Then
        Print u1$;
    Else
        Print Using u$; CurrString$(1); CurrString$(2); CurrString$(3);
        If CurrFig#(4) = 0 And CurrFig#(5) = 0 Then
            Print Using u4$ + "≥" + u4$ + "≥" + u3$; Balance#(CurrRecord)
        ElseIf CurrFig#(5) = 0 Then
            Print Using u2$ + "≥" + u4$ + "≥" + u3$; CurrFig#(4); Balance#(CurrRecord)
        Else
            Print Using u4$ + "≥" + u2$ + "≥" + u3$; CurrFig#(5); Balance#(CurrRecord)
        End If
    End If
    Return

    EditTransPrintBalances:
    Color colors(7, ColorPref), colors(4, ColorPref)
    For a = 1 To 19
        CurrRecord = CurrTopline + a - 1
        If CurrRecord <= MaxRecord Then
            Locate 4 + a, 66
            Print Using u3$; Balance#(CurrTopline + a - 1);
        End If
    Next a
    Return

    EditTransDeleteRecord:
    If MaxRecord = 1 Then
        Beep
    Else
        CurrRecord = CurrTopline + CurrRow - 1
        MaxRecord = MaxRecord - 1
        a = CurrRecord
        While a <= MaxRecord
            Get #1, a + 2
            Put #1, a + 1
            Balance#(a) = Balance#(a + 1) - CurrFig#(4) + CurrFig#(5)
            a = a + 1
        Wend
        
        LSet valid$ = "THISISVALID"
        LSet IoMaxRecord$ = Cvit$(MaxRecord)
        Put #1, 1
        GoSub EditTransPrintWholeScreen
        CurrRecord = CurrTopline + CurrRow - 1
        If CurrRecord > MaxRecord Then
            GoSub EditTransMoveUp
        End If
        GoSub EditTransGetLine
        GoSub EditTransWriteBalance
    End If
    Return

    EditTransAddRecord:
    CurrRecord = CurrTopline + CurrRow - 1
    a = MaxRecord
    While a > CurrRecord
        Get #1, a + 1
        Put #1, a + 2
        Balance#(a + 1) = Balance#(a)
        a = a - 1
    Wend
    Balance#(CurrRecord + 1) = Balance#(CurrRecord)
    MaxRecord = MaxRecord + 1
    LSet IoDate$ = ""
    LSet IoRef$ = ""
    LSet IoDesc$ = ""
    LSet IoFig1$ = MKD$(0)
    LSet IoFig2$ = MKD$(0)
    Put #1, CurrRecord + 2

    LSet valid$ = "THISISVALID"
    LSet IoMaxRecord$ = Cvit$(MaxRecord)
    Put #1, 1
    GoSub EditTransPrintWholeScreen
    GoSub EditTransGetLine
    Return

    EditTransPrintWholeScreen:
    temp = CurrRow
    For CurrRow = 1 To 19
        CurrRecord = CurrTopline + CurrRow - 1
        If CurrRecord <= MaxRecord Then
            GoSub EditTransGetLine
        End If
        GoSub EditTransPrintLine
    Next CurrRow
    CurrRow = temp
    Return

    EditTransWriteBalance:
    Get #1, 1
    LSet IoBalance$ = MKD$(Balance#(MaxRecord))
    Put #1, 1
    Return

    EditTransPutLine:
    CurrRecord = CurrTopline + CurrRow - 1
    LSet IoDate$ = CurrString$(1)
    LSet IoRef$ = CurrString$(2)
    LSet IoDesc$ = CurrString$(3)
    LSet IoFig1$ = MKD$(CurrFig#(4))
    LSet IoFig2$ = MKD$(CurrFig#(5))
    Put #1, CurrRecord + 1
    Return

    EditTransGetLine:
    CurrRecord = CurrTopline + CurrRow - 1
    Get #1, CurrRecord + 1
    CurrString$(1) = IoDate$
    CurrString$(2) = IoRef$
    CurrString$(3) = IoDesc$
    CurrFig#(4) = CVD(IoFig1$)
    CurrFig#(5) = CVD(IoFig2$)
    Return
End Sub

'FancyCls:
'  Clears screen in the right color, and draws nice dots.
Sub FancyCls (dots, Background)

    View Print 2 To 24
    Color dots, Background
    Cls 2

    For a = 95 To 1820 Step 45
        row = a / 80 + 1
        col = a Mod 80 + 1
        Locate row, col
        Print Chr$(250);
    Next a

    View Print

End Sub

'GetString$:
'  Given a row and col, and an initial string, edit a string
'  VIS is the length of the visible field of entry
'  MAX is the maximum number of characters allowed in the string
Function GetString$ (row, col, start$, end$, Vis, Max)
    curr$ = Trim$(Left$(start$, Max))
    If curr$ = Chr$(8) Then curr$ = ""

    Locate , , 1

    finished = FALSE
    Do
        GoSub GetStringShowText
        GoSub GetStringGetKey

        If Len(Kbd$) > 1 Then
            finished = TRUE
            GetString$ = Kbd$
        Else
            Select Case Kbd$
                Case Chr$(13), Chr$(27), Chr$(9)
                    finished = TRUE
                    GetString$ = Kbd$
                
                Case Chr$(8)
                    If curr$ <> "" Then
                        curr$ = Left$(curr$, Len(curr$) - 1)
                    End If

                Case " " TO "}"
                    If Len(curr$) < Max Then
                        curr$ = curr$ + Kbd$
                    Else
                        Beep
                    End If

                Case Else
                    Beep
            End Select
        End If

    Loop Until finished

    end$ = curr$
    Locate , , 0
    Exit Function
    

    GetStringShowText:
    Locate row, col
    If Len(curr$) > Vis Then
        Print Right$(curr$, Vis);
    Else
        Print curr$; Space$(Vis - Len(curr$));
        Locate row, col + Len(curr$)
    End If
    Return

    GetStringGetKey:
    Kbd$ = ""
    While Kbd$ = ""
        Kbd$ = InKey$
    Wend
    Return
End Function

'Initialize:
'  Read colors in and set up assembly routines
Sub Initialize

    Width , 25
    View Print

    For ColorSet = 1 To 4
        For X = 1 To 10
            Read colors(X, ColorSet)
        Next X
    Next ColorSet

    LoadState

    P = VarPtr(ScrollUpAsm(1))
    Def Seg = VarSeg(ScrollUpAsm(1))
    For I = 0 To 13
        Read J
        Poke (P + I), J
    Next I

    P = VarPtr(ScrollDownAsm(1))
    Def Seg = VarSeg(ScrollDownAsm(1))
    For I = 0 To 13
        Read J
        Poke (P + I), J
    Next I

    Def Seg

End Sub

'Intro:
'  Display introduction screen.
Sub Intro
    Screen 0
    Width 80, 25
    Color 7, 0
    Cls

    Center 4, "Q B a s i c"
    Color 15
    Center 5, "‹     ‹ ‹‹‹‹ ‹   ‹ ‹‹‹‹ ‹   ‹      ‹     ‹ ‹‹‹‹ ‹   ‹ ‹‹‹‹ ‹‹‹‹‹ ‹‹‹‹ ‹‹‹‹‹"
    Center 6, "€ﬂ‹ ‹ﬂ€ €  € €‹  € €    €‹‹‹€      €ﬂ‹ ‹ﬂ€ €  € €‹  € €  € €     €    €   €"
    Center 7, "€  ﬂ  € €  € € ﬂ‹€ €ﬂﬂﬂ   €        €  ﬂ  € €ﬂﬂ€ € ﬂ‹€ €ﬂﬂ€ € ﬂﬂ€ €ﬂﬂﬂ €ﬂ€ﬂﬂ"
    Center 8, "€     € €‹‹€ €   € €‹‹‹   €        €     € €  € €   € €  € €‹‹‹€ €‹‹‹ €  ﬂ‹"
    Color 7
    Center 11, "A Personal Finance Manager written in"
    Center 12, "MS-DOS QBasic"
    Center 24, "Press any key to continue"

    SparklePause
End Sub

'LCenter:
'  Center TEXT$ on the line printer
Sub LCenter (text$)
    LPrint Tab(41 - Len(text$) / 2); text$
End Sub

'LoadState:
'  Load color preferences and account info from MONEY.DAT
Sub LoadState

    Open "money.dat" For Input As #1
    Input #1, ColorPref

    For a = 1 To 19
        Line Input #1, account(a).Title
        Line Input #1, account(a).AType
        Line Input #1, account(a).Desc
    Next a
    
    Close

End Sub

'Menu:
'  Handles Menu Selection for a single menu (either sub menu, or menu bar)
'  currChoiceX  :  Number of current choice
'  maxChoice    :  Number of choices in the list
'  choice$()    :  Array with the text of the choices
'  itemRow()    :  Array with the row of the choices
'  itemCol()    :  Array with the col of the choices
'  help$()      :  Array with the help text for each choice
'  barMode      :  Boolean:  TRUE = menu bar style, FALSE = drop down style
'
'  Returns the number of the choice that was made by changing currChoiceX
'  and returns the scan code of the key that was pressed to exit
'
Function Menu (CurrChoiceX, MaxChoice, choice$(), ItemRow(), ItemCol(), help$(), BarMode)
   
    currChoice = CurrChoiceX

    'if in bar mode, color in menu bar, else color box/shadow
    'bar mode means you are currently in the menu bar, not a sub menu
    If BarMode Then
        Color colors(7, ColorPref), colors(4, ColorPref)
        Locate 1, 1
        Print Space$(80);
    Else
        FancyCls colors(2, ColorPref), colors(1, ColorPref)
        Color colors(7, ColorPref), colors(4, ColorPref)
        Box ItemRow(1) - 1, ItemCol(1) - 1, ItemRow(MaxChoice) + 1, ItemCol(1) + Len(choice$(1)) + 1
        
        Color colors(10, ColorPref), colors(6, ColorPref)
        For a = 1 To MaxChoice + 1
            Locate ItemRow(1) + a - 1, ItemCol(1) + Len(choice$(1)) + 2
            Print Chr$(178); Chr$(178);
        Next a
        Locate ItemRow(MaxChoice) + 2, ItemCol(MaxChoice) + 2
        Print String$(Len(choice$(MaxChoice)) + 2, 178);
    End If
    
    'print the choices
    Color colors(7, ColorPref), colors(4, ColorPref)
    For a = 1 To MaxChoice
        Locate ItemRow(a), ItemCol(a)
        Print choice$(a);
    Next a

    finished = FALSE

    While Not finished
        
        GoSub MenuShowCursor
        GoSub MenuGetKey
        GoSub MenuHideCursor

        Select Case Kbd$
            Case Chr$(0) + "H": GoSub MenuUp
            Case Chr$(0) + "P": GoSub MenuDown
            Case Chr$(0) + "K": GoSub MenuLeft
            Case Chr$(0) + "M": GoSub MenuRight
            Case Chr$(13): GoSub MenuEnter
            Case Chr$(27): GoSub MenuEscape
            Case Else: Beep
        End Select
    Wend

    Menu = currChoice

    Exit Function


    MenuEnter:
    finished = TRUE
    Return

    MenuEscape:
    currChoice = 0
    finished = TRUE
    Return

    MenuUp:
    If BarMode Then
        Beep
    Else
        currChoice = (currChoice + MaxChoice - 2) Mod MaxChoice + 1
    End If
    Return

    MenuLeft:
    If BarMode Then
        currChoice = (currChoice + MaxChoice - 2) Mod MaxChoice + 1
    Else
        currChoice = -2
        finished = TRUE
    End If
    Return

    MenuRight:
    If BarMode Then
        currChoice = (currChoice) Mod MaxChoice + 1
    Else
        currChoice = -3
        finished = TRUE
    End If
    Return

    MenuDown:
    If BarMode Then
        finished = TRUE
    Else
        currChoice = (currChoice) Mod MaxChoice + 1
    End If
    Return

    MenuShowCursor:
    Color colors(8, ColorPref), colors(9, ColorPref)
    Locate ItemRow(currChoice), ItemCol(currChoice)
    Print choice$(currChoice);
    PrintHelpLine help$(currChoice)
    Return

    MenuGetKey:
    Kbd$ = ""
    While Kbd$ = ""
        Kbd$ = InKey$
    Wend
    Return

    MenuHideCursor:
    Color colors(7, ColorPref), colors(4, ColorPref)
    Locate ItemRow(currChoice), ItemCol(currChoice)
    Print choice$(currChoice);
    Return


End Function

'MenuSystem:
'  Main routine that controls the program.  Uses the MENU function
'  to implement menu system and calls the appropriate function to handle
'  the user's selection
Sub MenuSystem

    Dim choice$(20), menuRow(20), menuCol(20), help$(20)
    Locate , , 0
    choice = 1
    finished = FALSE

    While Not finished
        GoSub MenuSystemMain

        subchoice = -1
        While subchoice < 0
            Select Case choice
                Case 1: GoSub MenuSystemFile
                Case 2: GoSub MenuSystemEdit
                Case 3: GoSub MenuSystemAccount
                Case 4: GoSub MenuSystemReport
                Case 5: GoSub MenuSystemColors
            End Select
            FancyCls colors(2, ColorPref), colors(1, ColorPref)

            Select Case subchoice
                Case -2: choice = (choice + 3) Mod 5 + 1
                Case -3: choice = (choice) Mod 5 + 1
            End Select
        Wend
    Wend
    Exit Sub


    MenuSystemMain:
    FancyCls colors(2, ColorPref), colors(1, ColorPref)
    Color colors(7, ColorPref), colors(4, ColorPref)
    Box 9, 19, 14, 61
    Center 11, "Use arrow keys to navigate menu system"
    Center 12, "Press Enter to select a menu item"

    choice$(1) = " File "
    choice$(2) = " Accounts "
    choice$(3) = " Transactions "
    choice$(4) = " Reports "
    choice$(5) = " Colors "

    menuRow(1) = 1: menuCol(1) = 2
    menuRow(2) = 1: menuCol(2) = 8
    menuRow(3) = 1: menuCol(3) = 18
    menuRow(4) = 1: menuCol(4) = 32
    menuRow(5) = 1: menuCol(5) = 41
    
    help$(1) = "Exit the Money Manager"
    help$(2) = "Add/edit/delete accounts"
    help$(3) = "Add/edit/delete account transactions"
    help$(4) = "View and print reports"
    help$(5) = "Set screen colors"
    
    Do
        NewChoice = Menu((choice), 5, choice$(), menuRow(), menuCol(), help$(), TRUE)
    Loop While NewChoice = 0
    choice = NewChoice
    Return

    MenuSystemFile:
    choice$(1) = " Exit           "

    menuRow(1) = 3: menuCol(1) = 2

    help$(1) = "Exit the Money Manager"

    subchoice = Menu(1, 1, choice$(), menuRow(), menuCol(), help$(), FALSE)

    Select Case subchoice
        Case 1: finished = TRUE
        Case Else
    End Select
    Return


    MenuSystemEdit:
    choice$(1) = " Edit Account Titles "

    menuRow(1) = 3: menuCol(1) = 8
    
    help$(1) = "Add/edit/delete accounts"

    subchoice = Menu(1, 1, choice$(), menuRow(), menuCol(), help$(), FALSE)

    Select Case subchoice
        Case 1: EditAccounts
        Case Else
    End Select
    Return


    MenuSystemAccount:

    For a = 1 To 19
        If Trim$(account(a).Title) = "" Then
            choice$(a) = Right$(Str$(a), 2) + ". ------------------- "
        Else
            choice$(a) = Right$(Str$(a), 2) + ". " + account(a).Title
        End If
        menuRow(a) = a + 2
        menuCol(a) = 19
        help$(a) = RTrim$(account(a).Desc)
    Next a

    subchoice = Menu(1, 19, choice$(), menuRow(), menuCol(), help$(), FALSE)

    If subchoice > 0 Then
        EditTrans (subchoice)
    End If
    Return


    MenuSystemReport:
    choice$(1) = " Net Worth Report       "
    menuRow(1) = 3: menuCol(1) = 32
    help$(1) = "View and print net worth report"

    For a = 1 To 19
        If Trim$(account(a).Title) = "" Then
            choice$(a + 1) = Right$(Str$(a), 2) + ". ------------------- "
        Else
            choice$(a + 1) = Right$(Str$(a), 2) + ". " + account(a).Title
        End If
        menuRow(a + 1) = a + 3
        menuCol(a + 1) = 32
        help$(a + 1) = "Print " + RTrim$(account(a).Title) + " transaction summary"
    Next a

    subchoice = Menu(1, 20, choice$(), menuRow(), menuCol(), help$(), FALSE)

    Select Case subchoice
        Case 1
            NetWorthReport
        Case 2 TO 20
            TransactionSummary (subchoice - 1)
        Case Else
    End Select
    Return

    MenuSystemColors:
    choice$(1) = " Monochrome Scheme "
    choice$(2) = " Cyan/Blue Scheme  "
    choice$(3) = " Blue/Cyan Scheme  "
    choice$(4) = " Red/Grey Scheme   "

    menuRow(1) = 3: menuCol(1) = 41
    menuRow(2) = 4: menuCol(2) = 41
    menuRow(3) = 5: menuCol(3) = 41
    menuRow(4) = 6: menuCol(4) = 41

    help$(1) = "Color scheme for monochrome and LCD displays"
    help$(2) = "Color scheme featuring cyan"
    help$(3) = "Color scheme featuring blue"
    help$(4) = "Color scheme featuring red"

    subchoice = Menu(1, 4, choice$(), menuRow(), menuCol(), help$(), FALSE)

    Select Case subchoice
        Case 1 TO 4
            ColorPref = subchoice
            SaveState
        Case Else
    End Select
    Return


End Sub

'NetWorthReport:
'  Prints net worth report to screen and printer
Sub NetWorthReport
    Dim assetIndex(19), liabilityIndex(19)

    maxAsset = 0
    maxLiability = 0

    For a = 1 To 19
        If account(a).AType = "A" Then
            maxAsset = maxAsset + 1
            assetIndex(maxAsset) = a
        ElseIf account(a).AType = "L" Then
            maxLiability = maxLiability + 1
            liabilityIndex(maxLiability) = a
        End If
    Next a

    'Loop until <F2> is pressed
    finished = FALSE
    Do
        u1$ = "\                  \$$###,###,###.##"
        u2$ = "\               \+$$#,###,###,###.##"

        Color colors(5, ColorPref), colors(4, ColorPref)
        Locate 1, 1: Print Space$(80);
        Locate 1, 4: Print "Net Worth Report: " + Date$;
        PrintHelpLine "<F2=Exit>    <F3=Print Report>"

        Color colors(7, ColorPref), colors(4, ColorPref)
        Box 2, 1, 24, 40
        Box 2, 41, 24, 80

        Locate 2, 16: Print " ASSETS "
        assetTotal# = 0
        a = 1
        count1 = 1
        While a <= maxAsset
            file$ = "money." + Cvit$(assetIndex(a))
            Open file$ For Random As #1 Len = 84
            Field #1, 11 As valid$, 5 As IoMaxRecord$, 8 As IoBalance$
            Get #1, 1
            If valid$ = "THISISVALID" Then
                Locate 2 + count1, 3: Print Using u1$; account(assetIndex(a)).Title; CVD(IoBalance$)
                assetTotal# = assetTotal# + CVD(IoBalance$)
                count1 = count1 + 1
            End If
            Close
            a = a + 1
        Wend

        Locate 2, 55: Print " LIABILITIES "
        liabilityTotal# = 0
        a = 1
        count2 = 1
        While a <= maxLiability
            file$ = "money." + Cvit$(liabilityIndex(a))
            Open file$ For Random As #1 Len = 84
            Field #1, 11 As valid$, 5 As IoMaxRecord$, 8 As IoBalance$
            Get #1, 1
            If valid$ = "THISISVALID" Then
                Locate 2 + count2, 43: Print Using u1$; account(liabilityIndex(a)).Title; CVD(IoBalance$)
                liabilityTotal# = liabilityTotal# + CVD(IoBalance$)
                count2 = count2 + 1
            End If
            Close
            a = a + 1
        Wend
        If count2 > count1 Then count1 = count2
        Locate 2 + count1, 25: Print "--------------"
        Locate 2 + count1, 65: Print "--------------"
        Locate 3 + count1, 3: Print Using u2$; "Total assets"; assetTotal#;
        Locate 3 + count1, 43: Print Using u2$; "Total liabilities"; liabilityTotal#

        Color colors(5, ColorPref), colors(4, ColorPref)
        Locate 1, 43: Print Using u2$; "    NET WORTH:"; assetTotal# - liabilityTotal#

        Do: Kbd$ = InKey$: Loop Until Kbd$ <> ""

        Select Case Kbd$ 'Handle Special keys
            Case Chr$(0) + "<" 'F2
                finished = TRUE
            Case Chr$(0) + "=" 'F3
                GoSub NetWorthReportPrint
            Case Else
                Beep
        End Select
    Loop Until finished
    Exit Sub

    NetWorthReportPrint:
    PrintHelpLine ""
   
    Box 8, 20, 14, 62
    Center 10, "Prepare printer on LPT1 for report"
    Center 12, "Hit <Enter> to print, or <Esc> to abort"

    Do: Kbd$ = InKey$: Loop While Kbd$ <> Chr$(13) And Kbd$ <> Chr$(27)

    If Kbd$ = Chr$(13) Then
        Box 8, 20, 14, 62
        Center 11, "Printing report..."
        u0$ = "                     \                  \ "
        u1$ = "                        \                 \ $$###,###,###.##"
        u2$ = "                                              --------------"
        u3$ = "                                               ============="
        u4$ = "                        \               \+$$#,###,###,###.##"
        PrintErr = FALSE
        On Error GoTo ErrorTrap ' test if printer is connected
        LPrint
        If PrintErr = FALSE Then
            LPrint: LPrint: LPrint: LPrint: LPrint
            LCenter "Q B a s i c"
            LCenter "M O N E Y   M A N A G E R"
            LPrint: LPrint
            LCenter "NET WORTH REPORT:  " + Date$
            LCenter "-------------------------------------------"
            LPrint Using u0$; "ASSETS:"
            assetTotal# = 0
            a = 1
            While a <= maxAsset
                file$ = "money." + Cvit$(assetIndex(a))
                Open file$ For Random As #1 Len = 84
                Field #1, 11 As valid$, 5 As IoMaxRecord$, 8 As IoBalance$
                Get #1, 1
                If valid$ = "THISISVALID" Then
                    LPrint Using u1$; account(assetIndex(a)).Title; CVD(IoBalance$)
                    assetTotal# = assetTotal# + CVD(IoBalance$)
                End If
                Close #1
                a = a + 1
            Wend
            LPrint u2$
            LPrint Using u4$; "Total assets"; assetTotal#
            LPrint
            LPrint
            LPrint Using u0$; "LIABILITIES:"
            liabilityTotal# = 0
            a = 1
            While a <= maxLiability
                file$ = "money." + Cvit$(liabilityIndex(a))
                Open file$ For Random As #1 Len = 84
                Field #1, 11 As valid$, 5 As IoMaxRecord$, 8 As IoBalance$
                Get #1, 1
                If valid$ = "THISISVALID" Then
                    LPrint Using u1$; account(liabilityIndex(a)).Title; CVD(IoBalance$)
                    liabilityTotal# = liabilityTotal# + CVD(IoBalance$)
                End If
                Close #1
                a = a + 1
            Wend
            LPrint u2$
            LPrint Using u4$; "Total liabilities"; liabilityTotal#
            LPrint

            LPrint
            LPrint u3$
            LPrint Using u4$; "NET WORTH"; assetTotal# - liabilityTotal#
            LCenter "-------------------------------------------"
            LPrint: LPrint: LPrint
        End If
        On Error GoTo 0
    End If
    Return
End Sub

'PrintHelpLine:
'  Prints help text on the bottom row in the proper color
Sub PrintHelpLine (help$)
    Color colors(5, ColorPref), colors(4, ColorPref)
    Locate 25, 1
    Print Space$(80);
    Center 25, help$
End Sub

'SaveState:
'  Save color preference and account information to "MONEY.DAT" data file.
Sub SaveState
    Open "money.dat" For Output As #2
    Print #2, ColorPref
    
    For a = 1 To 19
        Print #2, account(a).Title
        Print #2, account(a).AType
        Print #2, account(a).Desc
    Next a
    
    Close #2
End Sub

'ScrollDown:
'  Call the assembly program to scroll the screen down
Sub ScrollDown
    Def Seg = VarSeg(ScrollDownAsm(1))
    Call Absolute(VarPtr(ScrollDownAsm(1)))
    Def Seg
End Sub

'ScrollUp:
'  Calls the assembly program to scroll the screen up
Sub ScrollUp
    Def Seg = VarSeg(ScrollUpAsm(1))
    Call Absolute(VarPtr(ScrollUpAsm(1)))
    Def Seg
End Sub

'SparklePause:
'  Creates flashing border for intro screen
Sub SparklePause

    Color 4, 0
    a$ = "*    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    "
    While InKey$ <> "": Wend 'Clear keyboard buffer

    While InKey$ = ""
        For a = 1 To 5
            Locate 1, 1 'print horizontal sparkles
            Print Mid$(a$, a, 80);
            Locate 22, 1
            Print Mid$(a$, 6 - a, 80);

            For b = 2 To 21 'Print Vertical sparkles
                c = (a + b) Mod 5
                If c = 1 Then
                    Locate b, 80
                    Print "*";
                    Locate 23 - b, 1
                    Print "*";
                Else
                    Locate b, 80
                    Print " ";
                    Locate 23 - b, 1
                    Print " ";
                End If
            Next b
        Next a
    Wend
End Sub

'TransactionSummary:
'  Print transaction summary to line printer
Sub TransactionSummary (item)
    FancyCls colors(2, ColorPref), colors(1, ColorPref)
    PrintHelpLine ""
    Box 8, 20, 14, 62
    Center 10, "Prepare printer on LPT1 for report"
    Center 12, "Hit <Enter> to print, or <Esc> to abort"

    Do: Kbd$ = InKey$: Loop While Kbd$ <> Chr$(13) And Kbd$ <> Chr$(27)

    If Kbd$ = Chr$(13) Then
        Box 8, 20, 14, 62
        Center 11, "Printing report..."
        PrintErr = FALSE
        On Error GoTo ErrorTrap ' test if printer is connected
        LPrint
        If PrintErr = FALSE Then
            Print
            LPrint: LPrint: LPrint: LPrint: LPrint
            LCenter "Q B a s i c"
            LCenter "M O N E Y   M A N A G E R"
            LPrint: LPrint
            LCenter "Transaction summary: " + Trim$(account(item).Title)
            LCenter Date$
            LPrint
            u5$ = "--------|------|------------------------|----------|----------|--------------"
            LPrint u5$
            LPrint "  Date  | Ref# | Description            | Increase | Decrease |  Balance   "
            LPrint u5$
            u0$ = "\      \|\    \|\                      \|"
            u2$ = "###,###.##"
            u3$ = "###,###,###.##"
            u4$ = "          "

            file$ = "money." + Cvit$(item)
            Open file$ For Random As #1 Len = 84
            Field #1, 8 As IoDate$, 10 As IoRef$, 50 As IoDesc$, 8 As IoFig1$, 8 As IoFig2$
            Field #1, 11 As valid$, 5 As IoMaxRecord$, 8 As IoBalance$
            Get #1, 1
            If valid$ = "THISISVALID" Then
                Balance# = 0
                MaxRecord = Val(IoMaxRecord$)
                CurrRecord = 1
                While CurrRecord <= MaxRecord

                    Get #1, CurrRecord + 1
                    Fig1# = CVD(IoFig1$)
                    Fig2# = CVD(IoFig2$)

                    LPrint Using u0$; IoDate$; IoRef$; IoDesc$;
                    If Fig2# = 0 And Fig1# = 0 Then
                        LPrint Using u4$ + "|" + u4$ + "|" + u3$; Balance#
                    ElseIf Fig2# = 0 Then
                        Balance# = Balance# + Fig1#
                        LPrint Using u2$ + "|" + u4$ + "|" + u3$; Fig1#; Balance#
                    Else
                        Balance# = Balance# - Fig2#
                        LPrint Using u4$ + "|" + u2$ + "|" + u3$; Fig2#; Balance#
                    End If
                    CurrRecord = CurrRecord + 1
                Wend
                LPrint u5$
                LPrint: LPrint
            End If
            On Error GoTo 0
        End If
        Close
    End If
End Sub

'Trin$:
'  Remove null and spaces from the end of a string.
Function Trim$ (X$)

    If X$ = "" Then
        Trim$ = ""
    Else
        lastChar = 0
        For a = 1 To Len(X$)
            y$ = Mid$(X$, a, 1)
            If y$ <> Chr$(0) And y$ <> " " Then
                lastChar = a
            End If
        Next a
        Trim$ = Left$(X$, lastChar)
    End If
    
End Function

