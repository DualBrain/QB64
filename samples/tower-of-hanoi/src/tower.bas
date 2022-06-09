$NoPrefix
DefLng A-Z
Option Explicit
Option ExplicitArray

$Resize:Smooth
AllowFullScreen SquarePixels , Smooth

Const NUMDISCS = 9 ' alter this line to change number of discs

Dim Shared TOWERS(0 To 2, 1 To NUMDISCS), TOP(0 To 2), COLORS(1 To NUMDISCS), NUMMOVES As Long
Dim As Long i, choice

Cls

TOP(0) = NUMDISCS: TOP(1) = 0: TOP(2) = 0
For i = 1 To NUMDISCS
    TOWERS(0, i) = NUMDISCS - i + 1
    Read COLORS(i)
Next
Data 6,9,4,10,11,12,13,14
Data 6,9,4,10,11,12,13,14
Locate 1, 26
Print Chr$(218); String$(14, Chr$(196)); Chr$(191)
Locate 2, 26
Print Chr$(179); "TOWER OF HANOI"; Chr$(179)
Locate 3, 26
Print Chr$(192); String$(14, Chr$(196)); Chr$(217)
Print String$(80, Chr$(196))
Print
Print "1: AUTO"
Print "2: HUMAN"
Print String$(20, Chr$(196))
While choice <> 1 And choice <> 2
    Input "CHOOSE ONE: ", choice
Wend
If choice = 1 Then Call AUTO Else Call PLAYGAME

Sub AUTO
    Call SHOWDISCS
    Call MOVEPILE(NUMDISCS, 0, 2)
End Sub

Sub INSTRUCT
    Dim null As String

    Print "The TOWER OF HANOI is a mathematical game or puzzle. It consists"
    Print "of three pegs and a number of discs which can slide onto any peg."
    Print "The puzzle starts with the discs stacked in order of size on one peg."
    Print
    Print "The object of the game is to move the entire stack onto another peg,"
    Print "obeying the following rules:"
    Print Tab(2); Chr$(248); " Only one disc may be moved at a time."
    Print Tab(2); Chr$(248); " Each move consists of taking the upper disc from"
    Print Tab(4); "one peg and sliding it onto another peg, on top of any discs"
    Print Tab(4); "that may already be on that peg."
    Print Tab(2); Chr$(248); " No disc may be placed on top of another disc."
    Print "PRESS ANY KEY TO CONTINUE..."
    null$ = Input$(1)
End Sub

Sub MOVEDISC (START, FINISH)
    TOWERS(FINISH, TOP(FINISH) + 1) = TOWERS(START, TOP(START))
    TOP(FINISH) = TOP(FINISH) + 1
    TOWERS(START, TOP(START)) = 0
    TOP(START) = TOP(START) - 1
    NUMMOVES = NUMMOVES + 1
    Call SHOWDISCS
    Delay .1
    If InKey$ = Chr$(27) Then End
End Sub

Sub MOVEPILE (N, START, FINISH)
    If N > 1 Then Call MOVEPILE(N - 1, START, 3 - START - FINISH)
    Call MOVEDISC(START, FINISH)
    If N > 1 Then Call MOVEPILE(N - 1, 3 - START - FINISH, FINISH)
End Sub

Sub PLAYGAME
    Dim null As String, k As String
    Dim As Long start, finish

    Do
        Input "WOULD YOU LIKE INSTRUCTIONS"; null$
        null$ = UCase$(Left$(LTrim$(null$), 1))
        If null$ = "Y" Then Call INSTRUCT: Exit Do
        If null$ = "N" Then Exit Do
    Loop
    Call SHOWDISCS
    Do
        Locate 1, 1
        Color 7
        Print "TYPE NUMBER OF START PEG FOLLOWED BY NUMBER OF END PEG"
        Print "LEFT = 1", "MIDDLE = 2", "RIGHT=3"
        Do
            k$ = InKey$
            Select Case k$
                Case Chr$(27)
                    End
                Case "1"
                    start = 0
                    Exit Do
                Case "2"
                    start = 1
                    Exit Do
                Case "3"
                    start = 2
                    Exit Do
            End Select
        Loop
        Do
            k$ = InKey$
            Select Case k$
                Case Chr$(27)
                    End
                Case "1"
                    finish = 0
                    Exit Do
                Case "2"
                    finish = 1
                    Exit Do
                Case "3"
                    finish = 2
                    Exit Do
            End Select
        Loop
        If TOP(start) = 0 Then Print "There are no discs on that peg.": GoTo 1
        If start = finish Then Print "The start peg is the same as the end peg.": GoTo 1
        If TOP(finish) > 0 Then
            If TOWERS(start, TOP(start)) > TOWERS(finish, TOP(finish)) Then Print "You may not put a larger disc on top of a smaller disc.": GoTo 1
        End If
        Call MOVEDISC(start, finish)
        If TOP(0) = 0 And TOP(1) = 0 Then Exit Do
        If TOP(0) = 0 And TOP(2) = 0 Then Exit Do
    1 Loop
End Sub

Sub SHOWDISCS
    Dim As Long i, x

    Cls
    Locate 1, 60: Print "MOVES: "; NUMMOVES
    Locate 25, 1
    Print String$(80, Chr$(196));
    For i = 1 To TOP(0)
        Locate 25 - i, i + 1
        x = TOWERS(0, i)
        If x = 0 Then Exit For
        Color COLORS(x): Print String$(x * 2, Chr$(219));
    Next
    For i = 1 To TOP(1)
        Locate 25 - i, i + NUMDISCS * 3
        x = TOWERS(1, i)
        If x = 0 Then Exit For
        Color COLORS(x): Print String$(x * 2, Chr$(219));
    Next
    For i = 1 To TOP(2)
        Locate 25 - i, i + NUMDISCS * 6
        x = TOWERS(2, i)
        If x = 0 Then Exit For
        Color COLORS(x): Print String$(x * 2, Chr$(219));
    Next
End Sub
