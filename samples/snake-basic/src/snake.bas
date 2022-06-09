$NoPrefix
$Resize:Smooth

Screen 7
FullScreen SquarePixels , Smooth
Cls

Type Player
    score As Integer
    Nomen As String * 10
    Colr As Integer
End Type

Dim Shared SortArray(10) As Player

Locate 2, 5
Color 1, 0
Print "Copyright (c) 2013 Tim Baxendale"
Color 15, 0
RECT -1, 67, 321, 50, 2
Locate 12, 16
Print "SNAKE 3.3!"
Locate 24, 8
Color 4, 0
Print "Press any key to start..."
Do
Loop While InKey$ = ""

Dim wrap%, startSize%, lenIncrease%, foodTime%, dt%, pv%
GoTo SETTINGS

START:

Color 15, 0
Cls

xmove% = 10
ymove% = 0
Dim bodyX%(511)
Dim bodyY%(511)
Dim score As Integer
score = 0
size% = startSize%
For i% = size% To 0 Step -1
    bodyX%(i%) = 140
    bodyY%(i%) = 80
Next

foodOut% = 0
Dim foodPos%(1)
t# = Timer
IsChanged = 0

While 1
    'Get the pressed key
    key$ = InKey$
    Do
    Loop While InKey$ <> ""
    Select Case key$
        Case Chr$(27)
            End
        Case Chr$(0) + "H"
            If ymove% <> 10 Then
                ymove% = -10
                xmove% = 0
            End If
        Case Chr$(0) + "P"
            If ymove% <> -10 Then
                ymove% = 10
                xmove% = 0
            End If
        Case Chr$(0) + "K"
            If xmove% <> 10 Then
                ymove% = 0
                xmove% = -10
            End If
        Case Chr$(0) + "M"
            If xmove% <> -10 Then
                ymove% = 0
                xmove% = 10
            End If
        Case " "
            Locate 1, 1
            Print "Game Paused"
            Do
            Loop While InKey$ <> " "
    End Select

    'Time for food?
    If Timer - t# > foodTime% And foodOut% = 0 Then
        t# = Timer
        foodOut% = 1
        foodPos%(0) = Rand(0, 20) * 10
        foodPos%(1) = Rand(1, 18) * 10
    End If

    'Is the food out?
    If foodOut% = 1 Then
        RECT foodPos%(0) + 1, foodPos%(1) + 1, 8, 8, 4
        Paint (foodPos%(0) + 2, foodPos%(1) + 2), 4, 4
    End If
  
    'Did ya get it?
    If foodOut% = 1 And (intersects(bodyX%(0), bodyY%(0), 8, 8, foodPos%(0), foodPos%(1)) Or intersects(bodyX%(0), bodyY%(0), 8, 8, foodPos%(0) + 4, foodPos%(1) + 4)) Then
        Paint (foodPos%(0) + 2, foodPos%(1) + 2), 1, 0
        size% = size% + lenIncrease%
        foodOut% = 0
        score = score + pv%
        If snd% = 1 Then Sound 300, 1
        IsChanged = 1
    End If

    'Erase the tail
    If IsChanged = 0 Then
        Paint (bodyX%(size%) + 2, bodyY%(size%) + 2), 0, 0
    Else
        IsChanged = 0
    End If

    'Move the body
    X = bodyX%(0) + xmove%
    y = bodyY%(0) + ymove%
   
    'Sort the body arrays
    For i% = size% To 0 Step -1
        bodyX%(i% + 1) = bodyX%(i%)
        bodyY%(i% + 1) = bodyY%(i%)
        If X = bodyX%(i%) And y = bodyY%(i%) Then
            GoTo DEAD
        End If
        If X < 0 Or X >= 320 Then
            If wrap% = 0 Then
                GoTo DEAD
            Else
                If X < 0 Then
                    X = 310
                Else
                    X = 0
                End If
            End If
        End If
        If y < 10 Or y >= 200 Then
            If wrap% = 0 Then
                GoTo DEAD
            Else
                If y < 10 Then
                    y = 190
                Else
                    y = 10
                End If
            End If
        End If
    Next

    bodyX%(0) = X
    bodyY%(0) = y

    'Draw the damn thing
    RECT bodyX%(0) + 1, bodyY%(0) + 1, 8, 8, 1
    Paint (bodyX%(0) + 2, bodyY%(0) + 2), 1, 1
 
    Delay dt% / 10

    'Show me da score!
    Locate 1, 1
    Print "Score: ", score
    Line (0, 9)-(320, 9), 2
    'RECT 0, 9, 319, 190, 15
Wend

DEAD:
Palette 0, 4
Color 15, 4
Locate 12, 16
Print "You Died!"
If snd% = 1 Then Sound 37, 18
Locate 23, 7
Print "Press space to continue..."
Do
Loop While InKey$ <> " "
Color 15, 0
HIGHSCORE score
GoTo START

SETTINGS:
Open "CONFIG.DAT" For Random As #1
If LOF(1) <= 0 Then
    wrap% = 0
    Put #1, 1, wrap%
    startSize% = 4
    Put #1, 2, startSize%
    lenIncrease% = 3
    Put #1, 3, lenIncrease%
    foodTime% = 5
    Put #1, 4, foodTime%
    dt% = 1
    Put #1, 5, dt%
    pv% = 5
    Put #1, 6, pv%
    snd% = 1
    Put #1, 7, snd%
End If
Get #1, 1, wrap%
Get #1, 2, startSize%
Get #1, 3, lenIncrease%
Get #1, 4, foodTime%
Get #1, 5, dt%
Get #1, 6, pv%
Get #1, 7, snd%
Close #1
GoTo START

Sub FOOD
    X% = Rand(0, 200)
    y% = Rand(0, 180)
    RECT X%, y%, 20, 20, 3
End Sub

Sub HIGHSCORE (score%)
    Dim p As Player
    Open "SCORE.DAT" For Random As #1
    If LOF(1) <= 0 Then
        For i = 1 To 10
            p.Nomen = RandomName$
            p.score = Rand(1, 20) * 5
            p.Colr = 1
            Put #1, i, p
        Next
    End If

    Cls

    ISHIGHSCORE = 0

    For i = 1 To 10
        Get #1, i, p
        SortArray(i) = p
        If p.score < score% Then
            ISHIGHSCORE = 1
        End If
    Next

    If ISHIGHSCORE = 1 Then
        Dim newPlayer As Player
        Print "You got a high score!"
        Do
            Input "Please enter your name: ", Nomen$
        Loop While Len(Nomen$) = 0 Or Len(Nomen$) > 10
        newPlayer.Nomen = Nomen$
        newPlayer.score = score%
        newPlayer.Colr = 15
        SortArray(0) = newPlayer
    End If

    QuickSort 0, 10

    place = 1
    cnt = 1
    Cls
    Print "", "High Scores"
    Print ""

    For i = 10 To 1 Step -1
        If SortArray(i).score = last% Then
            place = place - 1
        End If
        Color (SortArray(i).Colr), 0
        Locate (cnt * 2) + 1, 9
        Print place; ">"
        Locate (cnt * 2) + 1, 15
        Print SortArray(i).Nomen
        Locate (cnt * 2) + 1, 27
        Print SortArray(i).score,
        Print ""
        Put #1, i, SortArray(i)
        last% = SortArray(i).score
        place = place + 1
        cnt = cnt + 1
    Next
    Close #1
    Color 3

    Color 4, 0
    Locate 23, 4
    Print "Press ESC to exit or R to restart"
    While 1
        k$ = InKey$

        If k$ = Chr$(27) Then End
        If k$ = "r" Then GoTo Restart

    Wend
    Restart:
End Sub

Function intersects (x1%, y1%, w1%, h1%, x2%, y2%)
    If x2% < x1% + w1% And x2% > x1% And y2% < y1% + h1% And y2% > y1% Then
        intersects = Int(1)
    Else
        intersects = Int(0)
    End If
End Function

DefInt A-Z
' ============================== QuickSort ===================================
'   QuickSort works by picking a random "pivot" element in SortArray, then
'   moving every element that is bigger to one side of the pivot, and every
'   element that is smaller to the other side.  QuickSort is then called
'   recursively with the two subdivisions created by the pivot.  Once the
'   number of elements in a subdivision reaches two, the recursive calls end
'   and the array is sorted.
' ============================================================================
'
Sub QuickSort (LOW, HIGH)
    If LOW < HIGH Then

        ' Only two elements in this subdivision; swap them if they are out of
        ' order, then end recursive calls:
        If HIGH - LOW = 1 Then
            If SortArray(LOW).score > SortArray(HIGH).score Then
                Swap SortArray(LOW), SortArray(HIGH)
                'SwapBars Low, High
            End If
        Else

            ' Pick a pivot element at random, then move it to the end:
            RandIndex = RandInt%(LOW, HIGH)
            Swap SortArray(HIGH), SortArray(RandIndex)
            'SwapBars High, RandIndex
            Partition = SortArray(HIGH).score
            Do

                ' Move in from both sides towards the pivot element:
                i = LOW: J = HIGH
                Do While (i < J) And (SortArray(i).score <= Partition)
                    i = i + 1
                Loop
                Do While (J > i) And (SortArray(J).score >= Partition)
                    J = J - 1
                Loop

                ' If we haven't reached the pivot element, it means that two
                ' elements on either side are out of order, so swap them:
                If i < J Then
                    Swap SortArray(i), SortArray(J)
                    'SwapBars i, J
                End If
            Loop While i < J

            ' Move the pivot element back to its proper place in the array:
            Swap SortArray(i), SortArray(HIGH)
            'SwapBars i, High

            ' Recursively call the QuickSort procedure (pass the smaller
            ' subdivision first to use less stack space):
            If (i - LOW) < (HIGH - i) Then
                QuickSort LOW, i - 1
                QuickSort i + 1, HIGH
            Else
                QuickSort i + 1, HIGH
                QuickSort LOW, i - 1
            End If
        End If
    End If
End Sub

DefSng A-Z
Function Rand (Bottom, Top)
    Randomize Timer
    Randomize Rnd
    Rand = Int((Top - Bottom + 1) * Rnd + Bottom)
End Function

DefInt A-Z
' =============================== RandInt% ===================================
'   Returns a random integer greater than or equal to the Lower parameter
'   and less than or equal to the Upper parameter.
' ============================================================================
'
Function RandInt% (lower, Upper) Static
    RandInt% = Int(Rnd * (Upper - lower + 1)) + lower
End Function

DefSng A-Z
Function RandomName$ ()
    Select Case Rand(0, 22)
        Case 0
            RandomName$ = "Dan"
        Case 1
            RandomName$ = "Matt"
        Case 2
            RandomName$ = "Annie"
        Case 3
            RandomName$ = "Mary C"
        Case 4
            RandomName$ = "Jake"
        Case 5
            RandomName$ = "Michael G"
        Case 6
            RandomName$ = "Timothy P"
        Case 7
            RandomName$ = "Stephen F"
        Case 8
            RandomName$ = "Joseph P"
        Case 9
            RandomName$ = "Kate"
        Case 10
            RandomName$ = "Peter A"
        Case 11
            RandomName$ = "John C"
        Case 12
            RandomName$ = "Gracie"
        Case 13
            RandomName$ = "Claire"
        Case 14
            RandomName$ = "Frank"
        Case 15
            RandomName$ = "Meaghan"
        Case 16
            RandomName$ = "Maddie"
        Case 17
            RandomName$ = "Andrew"
        Case 18
            RandomName$ = "Jason"
        Case 19
            RandomName$ = "Paul"
        Case 20
            RandomName$ = "David"
        Case 21
            RandomName$ = "Jon Jon"
        Case 22
            RandomName$ = "Emilie"
    End Select
End Function

Sub RECT (X%, y%, W%, H%, C%)
    Line (X%, y%)-(X% + W%, y%), C%
    Line (X%, y%)-(X%, y% + H%), C%
    Line (X% + W%, y%)-(X% + W%, y% + H%), C%
    Line (X%, y% + H%)-(X% + W%, y% + H%), C%
End Sub

