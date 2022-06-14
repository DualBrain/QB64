' NUMBER BLASTER/BLASTER.BAS
' R. K. Fink  9/14/94
' Copyright (C) 1994 DOS World Magazine
' Published in Issue #19, January 1995, page 56

DefInt A-Z
DECLARE SUB LEGEND ()
DECLARE SUB BUILDBRD ()
DECLARE FUNCTION GETMOVE (ROW)
DECLARE SUB SHOWMOVE (ROW)
DECLARE SUB SHOWSCORE (YRSCORE, COMPSCORE)
DECLARE FUNCTION CALCMOVE (ROW, COL, CLR)
DECLARE SUB ZING (ROW)
DECLARE FUNCTION COMPMOVE (ROW)
DECLARE SUB GENERATE ()
DECLARE SUB SHOWBLKS (SCHEMENO)
DECLARE SUB CLEARBRD ()

Dim Shared SCHEME1(0 To 15) As Integer
Dim Shared SCHEME2(0 To 15) As Integer
Dim Shared SCHEME3(0 To 15) As Integer
Dim Shared SCHEMENO As Integer
Dim Shared BLKVALUE(9 To 20, 19 To 30) As Integer
Dim Shared ROW, COL, CLR, VALUE, TURN As Integer
Dim Shared SCORE, COMPSCORE, YRSCORE As Integer

'Data for scoring patterns
Data 2,11,1,2,22,7,2,29,4,3,8,2,3,11,1
Data 3,14,3,3,17,5,3,18,5,3,21,7,3,25,6
Data 3,29,4,4,14,3,4,26,6,4,29,4

Screen 0: Cls: Width 40

Do 'Screen dazzler and randomizer
    Call GENERATE
    Call SHOWBLKS(1)
    Call SHOWBLKS(2)
Loop Until InKey$ <> ""

'Palette Using SCHEME3()

'Program begins here

Color 4, 0
Cls: LEGEND: BUILDBRD
Color 4, 0

Locate 23, 1: Print "Who's first...<y>ou or the <c>omputer";

Do
    X$ = InKey$

    If UCase$(X$) = "C" Then YOU = 1: Exit Do
    If UCase$(X$) = "Y" Then YOU = 0: Exit Do

Loop

Locate 23, 5: Print Spc(34);: Call CLEARBRD
If YOU Then GoTo COMPLAY

'You go first
RESTART:
Call SHOWMOVE(GETMOVE(ROW))
YRSCORE = YRSCORE + CALCMOVE(ROW, COL, CLR)
Call SHOWSCORE(YRSCORE, COMPSCORE)

'Now the computer goes
COMPLAY:
Call SHOWMOVE(COMPMOVE(ROW))
If ROW = -1 Then GoTo FINISHED
COMPSCORE = COMPSCORE + CALCMOVE(ROW, COL, CLR)
Call SHOWSCORE(YRSCORE, COMPSCORE)
GoTo RESTART

FINISHED:
Beep

Locate 23, 1: Print "OK.  Final Scores >>>>";
Sleep (5)

Locate 24, 1
Print "Press Enter to replay, Esc to quit";

Do
    X$ = InKey$
    If X$ = Chr$(13) Then Run

    If X$ = Chr$(27) Then
        Screen 0: Color 7, 0: System
    End If

Loop

Sub BUILDBRD
    For N = 10 To 19 'Column numbers
        Locate N, 5
        Color 7, 0
        Print Str$(N - 10);
    Next N
    For N = 10 To 19
        For M = 7 To 18
            Locate N, M
            Print "-";
    Next M: Next N
    'Build the board
    For N = 10 To 19
        For M = 20 To 29
            Locate N, M
            VALUE = (Rnd * 6) + 1
            BLKVALUE(N, M) = VALUE
            Color 0, (Rnd * 6 + 1)
            Print Using "#"; VALUE;
    Next M: Next N
End Sub

Function CALCMOVE (ROW, COL, CLR)
    SCORE = BLKVALUE(ROW, COL)
    BLKVALUE(ROW, COL) = 0
    Color 4, 0
    Select Case CLR
        Case 1 'Blue block
            SCORE = SCORE + BLKVALUE(ROW - 1, COL)
            BLKVALUE(ROW - 1, COL) = 0
            Locate ROW - 1, COL: Print " ";
        Case 2 'Green (single block)
            BLKVALUE(ROW, COL) = 0
        Case 3 'Cyan
            SCORE = SCORE + BLKVALUE(ROW + 1, COL)
            BLKVALUE(ROW + 1, COL) = 0
            Locate ROW + 1, COL: Print " ";
        Case 4 'Red
            SCORE = SCORE + BLKVALUE(ROW - 1, COL) + BLKVALUE(ROW + 1, COL)
            BLKVALUE(ROW - 1, COL) = 0: BLKVALUE(ROW + 1, COL) = 0
            Locate ROW - 1, COL: Print " ";
            Locate ROW + 1, COL: Print " ";
        Case 5 'Magenta
            SCORE = SCORE + BLKVALUE(ROW, COL + 1)
            BLKVALUE(ROW, COL + 1) = 0
            Locate ROW, COL + 1: Print " ";
        Case 6 'Yellow
            SCORE = SCORE + BLKVALUE(ROW + 1, COL + 1)
            BLKVALUE(ROW + 1, COL + 1) = 0
            Locate ROW + 1, COL + 1: Print " ";
        Case 7 'White
            SCORE = SCORE + BLKVALUE(ROW - 1, COL + 1)
            BLKVALUE(ROW - 1, COL + 1) = 0
            Locate ROW - 1, COL + 1: Print " ";
    End Select
    CALCMOVE = SCORE
End Function

Sub CLEARBRD
    For N = 10 To 19
        For M = 7 To 18
            Locate N, M
            Print " ";
    Next M: Next N
End Sub

Function COMPMOVE (ROW)
    Locate 23, 1
    Print Spc(22);
    Locate 23, 1
    Print " I'm thinking! ";
    Sleep (2) 'Delay the computer
    BIG = 0
    ROW = 10: N = 10
    GETBIGGEST:
    For M = 20 To 30
        CHECK = BLKVALUE(N, M)
        If CHECK <> 0 Then Exit For
    Next M
    If CHECK > BIG Then
        BIG = CHECK
        ROW = N
    End If
    N = N + 1
    If N < 21 GoTo GETBIGGEST
    If BIG <> 0 Then
        Call ZING(ROW)
    Else ROW = -1
    End If
    COMPMOVE = ROW
End Function

Sub GENERATE
    For N = 1 To 15
        SCHEME1(N) = Int(Rnd * 15)
        SCHEME1(0) = 0
        SCHEME2(N) = Int(Rnd * 15)
        SCHEME2(0) = 0
        SCHEME3(N) = N
        SCHEME3(0) = 0
    Next N
End Sub

Function GETMOVE (ROW)
    Color 4, 0
    AGAIN:
    Locate 23, 1
    Print Spc(20);
    Locate 23, 1
    Print "Your move. Which row?";
    While ROW = 0 Or ROW$ = ""
        ROW$ = InKey$
        ROW = InStr("0123456789", ROW$)
    Wend 'Wait for a number key
    ROW = ROW + 9
    Call ZING(ROW)
    Locate 23, 1
    Print Spc(20);
    GETMOVE = ROW
End Function

Sub LEGEND
    Restore
    For N = 1 To 14: Read I, J, K
        Locate I, J: Color K: Print Chr$(219);
    Next N
    Locate 6, 11: Print "Scoring Patterns"
    Locate 7, 5: Print String$(30, "-");
End Sub

Sub SHOWBLKS (SCHEMENO)
    If SCHEMENO = 1 Then
        'Palette Using SCHEME1()
        'Else Palette Using SCHEME2()
    End If
    GoSub SHOWEM
    Exit Sub

    SHOWEM:
    For N = 10 To 20
        For M = 20 To 30
            Locate N, M
            Color 0, (Rnd * 6 + 1), 0
            CHAR = Rnd * 6
            Print Using "#"; CHAR;
            Locate N, M
    Next M: Next N
    Locate 3, 5
    Color Rnd * 6, 0
    Print "Ready for NUMBER BLASTER?"
    Print
    Print "        Press a key when ready..."
    Return
End Sub

Sub SHOWMOVE (ROW)
    If ROW = -1 Then Exit Sub
    For M = 20 To 30
        CLR = Screen(ROW, M, 1)
        CLR = (CLR And 112) / 16
        If CLR <> 0 Then GoTo FOUND
    Next M
    'Row is empty
    Exit Sub
    FOUND:
    Locate ROW, M
    Print " "; 'Null block
    COL = M
End Sub

Sub SHOWSCORE (YRSCORE, COMPSCORE)
    Locate 22, 24
    Color 4, 0
    Print "S C O R E S"
    Locate 23, 24
    Print Spc(15);
    Locate 23, 24
    Print "You"; YRSCORE; " ME!"; COMPSCORE;
End Sub

Sub ZING (ROW)
    For M = 7 To 18
        Color 7, 0
        Locate (ROW), M
        Print "=";: For N = 1 To 8000: Next N
        Locate (ROW), M
        Print " ";
    Next M
End Sub

