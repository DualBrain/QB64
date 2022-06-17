'CHDIR ".\samples\pete\pongtennis"

DECLARE SUB challengeMatchDay ()
DECLARE SUB challengeMode ()
DECLARE SUB matchDayMenu ()
DECLARE SUB calender ()
DECLARE SUB career ()
DECLARE SUB worldRankings ()
DECLARE SUB backWallRally ()
DECLARE SUB training ()
DECLARE SUB targetPractice ()
DECLARE SUB tournament ()
DECLARE SUB preMatchDay ()
DECLARE SUB options ()
DECLARE SUB matchDay ()
DECLARE SUB getInfo ()
DECLARE FUNCTION rand! (c!)
Dim Shared points(2)
Dim Shared realPoints$(2)
Dim Shared games(2)
Dim Shared sets(2)
Dim Shared forename$(32)
Dim Shared surname$(32)
Dim Shared speedRating(32)
Dim Shared speed(32)
Dim Shared power(32)
Dim Shared accuracy(32)
Dim Shared colour$(15)
Dim Shared winners(2)
Dim Shared aces(2)
Dim Shared faults(2)
Dim Shared errors(2)
Dim Shared player(33)
Dim Shared flag(32)
Dim Shared in(32)
Dim Shared tournamentPlayer(33)
Dim Shared round$(5)
Dim Shared arp(32)
Dim Shared rankPoints(10, 32)
Dim Shared minorRating(32)
Dim Shared rank(32)
Dim Shared month$(12)
Dim Shared days(12)
Dim Shared day(24)
Dim Shared month(24)
Dim Shared qual(34)
Dim Shared tourney$(34)
Dim Shared qual$(34)
Dim Shared entrants(6)
Dim Shared rounds(34)
Dim Shared cPlayerNumber(2, 6)
Dim Shared cGames(2, 6)
Dim Shared cSets(2, 6)
Dim Shared cGamesToWin(6)
Dim Shared cSetsToWin(6)
Dim Shared cAmount(6)
Dim Shared cDescription$(6, 6)
Dim Shared cCompleted(6)
Common Shared challenge, day, month, year, userDone, winner, userColour, opponentColour, forename$, surname$, l$, r$, u$, d$, opponent, gamesToWin, setsToWin, gamesToWin2

Screen 0
Call getInfo
gamesToWin = 6
gamesToWin2 = 2
setsToWin = 1
userColour = 11
opponentColour = 4
colour$(3) = "CYAN"
colour$(4) = "RED"
colour$(5) = "PURPLE"
colour$(6) = "ORANGE"
colour$(7) = "WHITE"
colour$(8) = "GREY"
colour$(9) = "TURQOUISE"
colour$(10) = "GREEN"
colour$(11) = "BLUE"
colour$(12) = "LIGHT RED"
colour$(13) = "PINK"
colour$(14) = "YELLOW"
colour$(15) = "BRIGHT WHITE"
name$ = "USER"

Color 15, 2
Cls
Locate 16, 32
Print "PONG TENNIS"
Color 7, 2
Locate 20, 30
Print "BY ALEX BEIGHTON"
Do
Loop Until InKey$ = Chr$(13)

Color 15, 2
Cls
Locate 16, 32
Print "KEY CONFIG"
Locate 20, 25
Color 7, 2
Print "PLEASE ENTER THE "; Chr$(34); "LEFT"; Chr$(34); " KEY"
Do
    l$ = InKey$
Loop Until l$ <> ""
Color 15, 2
Cls
Locate 16, 32
Print "KEY CONFIG"
Locate 20, 24
Color 7, 2
Print "PLEASE ENTER THE "; Chr$(34); "RIGHT"; Chr$(34); " KEY"
Do
    r$ = InKey$
Loop Until r$ <> ""
Color 15, 2
Cls
Locate 16, 32
Print "KEY CONFIG"
Locate 20, 26
Color 7, 2
Print "PLEASE ENTER THE "; Chr$(34); "UP"; Chr$(34); " KEY"
Do
    u$ = InKey$
Loop Until u$ <> ""
Color 15, 2
Cls
Locate 16, 32
Print "KEY CONFIG"
Locate 20, 25
Color 7, 2
Print "PLEASE ENTER THE "; Chr$(34); "DOWN"; Chr$(34); " KEY"
Do
    d$ = InKey$
Loop Until d$ <> ""
Color 15, 2
Cls
Locate 16, 32
Print "PLEASE ENTER YOUR FORENAME"
Locate 20, 32
Color 7, 2
Print "MY FORENAME IS"
Do
    Locate 20, 48
    Input forename$
Loop Until forename$ <> ""
Color 15, 2
Cls
Locate 16, 32
Print "PLEASE ENTER YOUR SURNAME"
Locate 20, 32
Color 7, 2
Print "MY SURNAME IS"
Do
    Locate 20, 48
    Input surname$
Loop Until surname$ <> ""

210 Color 15, 2
Cls
os = 1
180 Color 15, 2
Locate 16, 28
Print "SELECT GAME MODE"
If os = 1 Then Color 2, 7 Else Color 7, 2
Locate 20, 28
Print "PLAY NOW"
If os = 2 Then Color 2, 7 Else Color 7, 2
Locate 22, 28
Print "TOURNAMENT MODE"
If os = 3 Then Color 2, 7 Else Color 7, 2
Locate 24, 28
Print "CAREER MODE"
If os = 4 Then Color 2, 7 Else Color 7, 2
Locate 26, 28
Print "TRAINING MODE"
If os = 5 Then Color 2, 7 Else Color 7, 2
Locate 28, 28
Print "CHALLENGE MODE"
If os = 6 Then Color 2, 7 Else Color 7, 2
Locate 30, 28
Print "QUIT GAME"

170 Select Case InKey$
    Case Is = u$
        os = os - 1
        If os < 1 Then os = 6
        GoTo 180
    Case Is = d$
        os = os + 1
        If os > 6 Then os = 1
        GoTo 180
    Case Is = Chr$(13)
    Case Else
        GoTo 170
End Select

challenge = 0
Select Case os
    Case Is = 1
        Call preMatchDay
        GoTo 180
    Case Is = 2
        Call tournament
        GoTo 180
    Case Is = 3
        Rem CALL career
        GoTo 180
    Case Is = 4
        Call training
        GoTo 180
    Case Is = 5
        Call challengeMode
        GoTo 180
    Case Is = 6
        Color 7, 2
        End
End Select

Sub backWallRally
    450 a = 37
    b = 32
    y = 36
    z = 40
    t = 0
    w = 26
    x = 1
    bs = 1
    rally = 0
    rallyEnd = 0
    alreadyAdded = 0
    hitTarget = 0
    totals = 0
    speed = 0
    direction = 1
    directionbs = 1

    Color 15, 2
    Cls

    Locate 16, 24
    Print "BACK WALL RALLY"
    Color 7, 2
    Locate 20, 24
    Print "Rally with the back wall as many times as"
    Locate 21, 24
    Print "possible before the ball goes out, or you"
    Locate 22, 24
    Print "miss the ball. Every time the ball makes"
    Locate 23, 24
    Print "contact with the back wall, you will score"
    Locate 24, 24
    Print "a point. The higher your score at the end,"
    Locate 25, 24
    Print "the better. However, it's not that simple -"
    Locate 26, 24
    Print "throughout your rally, a solid object will"
    Locate 27, 24
    Print "be bouncing between the walls and gradally"
    Locate 28, 24
    Print "increasing in size. Hit the object and it's"
    Locate 29, 24
    Print "game over!"
    Color 15, 2
    Locate 33, 24
    Print "PRESS RETURN TO BEGIN BACK WALL RALLY"
    Do
    Loop Until InKey$ = Chr$(13)

    alreadyAdded = 0
    Color 15, 2
    Cls
    For i = 2 To 20
        Color 1, 15
        Locate 2, i
        Print Chr$(219)
    Next i
    Color 15, 1
    Locate 2, 2
    Print surname$

    tt = Timer
    Do
        Locate 2, 21
        Color 15, 3
        Print "  RALLY "; rally

        For i = 1 To bs
            Color 14, 2
            Locate w, x + i
            Print Chr$(219)
        Next i

        For i = 1 To 17
            Color userColour, 2
            If b + i > 0 And b + i < 81 Then Locate a, b + i
            Color 6, 2
            If b + i > 0 And b + i < 81 Then Print Chr$(223)
        Next i

        Locate y, z
        Color 10, 2
        Print "o"

        Select Case InKey$
            Case Is = l$
                For i = 1 To 17
                    If b + i > 0 And b + i < 81 Then Locate a, b + i
                    Color 6, 2
                    If b + i > 0 And b + i < 81 Then Print " "
                Next i
                b = b - 1
            Case Is = r$
                For i = 1 To 17
                    If b + i > 0 And b + i < 81 Then Locate a, b + i
                    Color 6, 2
                    If b + i > 0 And b + i < 81 Then Print " "
                Next i
                b = b + 1
            Case Is = Chr$(13)
                If y < b - 3 Then GoTo 350
                If y > b + 13 Then GoTo 350
                If speed <> 0 Then GoTo 350
                speed = 10
                ballHit = b - z + 9
                directionlr = 1
                For i = 1 To 8
                    If ballHit = -i Then directionlr = 2
                    If ballHit = -i Then ballHit = i
                Next i
        350 End Select

        If speed = 0 Then GoTo 360
        moveAmount = (15 - speed) / 200
        moveAmount = Int(moveAmount * 1000) / 1000
        Select Case Timer
            Case Is >= t + moveAmount
                Color 2, 2
                Locate y, z
                Print " "
                If direction = 1 Then y = y - 1 Else y = y + 1
                t = Timer
                totals = totals + 1
        End Select

        Select Case totals
            Case Is >= changeAmount
                Color 2, 2
                Locate y, z
                Print " "
                If directionlr = 1 Then z = z - 1 Else z = z + 1
                If ballHit = 8 And directionlr = 1 And serveHit <> 1 Then z = z - 1
                If ballHit = 8 And directionlr = 2 And serveHit <> 1 Then z = z + 1
                totals = 0
        End Select

        hit1 = 0
        If y = a - 1 And z <= b + 17 And z >= b + 1 Then hit1 = 1 Else hit1 = 0
        Select Case hit1
            Case Is = 1
                ballHit = b - z + 9
                directionlr = 1
                direction = 1
                For i = 1 To 8
                    If ballHit = -i Then directionlr = 2
                    If ballHit = -i Then ballHit = i
                Next i
        End Select
        360 If ballHit = 0 Then changeAmount = 100 Else changeAmount = 9 - ballHit
        If b < -12 Then b = -12
        If b > 75 Then b = 75
        If d < -12 Then d = -12
        If d > 75 Then d = 75
        If y < 1 Then y = 1
        If y > 47 Then y = 47
        If z < 1 Then z = 1
        If z > 80 Then z = 80
        If y = 3 Then direction = 2
        If y = 3 And alreadyAdded = 0 Then rally = rally + 1
        If y = 3 And alreadyAdded = 0 Then alreadyAdded = 1
        If y = 4 Then alreadyAdded = 0
        outOfBounds = 0
        If y > 42 Then outOfBounds = 1
        If z < 2 Then outOfBounds = 1
        If z > 79 Then outOfBounds = 1

        For i = 1 To bs
            Color 2, 2
            If y = w And z = x + i Then rallyEnd = 1
        Next i

        Select Case outOfBounds
            Case Is = 1
                rallyEnd = 1
                speed = 0
                a = 37
                b = 32
                y = 36
                z = 40
                t = 0
                totals = 0
                speed = 0
                direction = 1
                alreadyAdded = 0
                Color 15, 2
                Cls
                For i = 2 To 20
                    Color 1, 15
                    Locate 2, i
                    Print Chr$(219)
                Next i
                Color 15, 1
                Locate 2, 2
                Print surname$
        End Select

        Select Case Timer - tt
            Case Is >= .005
                For i = 1 To bs
                    Color 2, 2
                    Locate w, x + i
                    Print " "
                Next i
                If directionbs = 1 Then x = x + 1 Else x = x - 1
                tt = Timer
        End Select

        If directionbs = 2 Then GoTo 400
        Select Case x + bs
            Case Is >= 80
                directionbs = 2
        End Select
        400 If directionbs = 1 Then GoTo 410
        Select Case x
            Case Is <= 1
                directionbs = 1
                bs = bs + 1
        End Select
    410 Loop Until rallyEnd = 1

    Color 15, 2
    Cls
    For i = 2 To 20
        Color 1, 15
        Locate 2, i
        Print Chr$(219)
    Next i
    Color 15, 1
    Locate 2, 2
    Print surname$
    Locate 2, 21
    Color 15, 3
    Print "  RALLY "; rally

    Color 15, 2
    Locate 16, 24
    Select Case rally
        Case Is > 29
            Print "THAT WAS AN UNBELIEVEABLE EFFORT! WELL PLAYED!"
        Case 24 TO 29
            Print "WELL DONE! THAT WAS AN EXCELLENT PERFORMANCE."
        Case 19 TO 23
            Print "VERY IMPRESSIVE! YOU SHOULD BE PLEASED WITH THAT SCORE."
        Case 16 TO 18
            Print "GOOD SCORE, BUT STILL A LOT OF IMPROVEMENT TO BE MADE."
        Case 12 TO 15
            Print "NOT A BAD SCORE, BUT YOU CAN DO MUCH BETTER."
        Case 9 TO 11
            Print "BY NO MEANS IMPRESSIVE. TRY AGAIN."
        Case 6 TO 8
            Print "THAT WAS ABSOLUTLY DREADFUL. ENOUGH SAID."
        Case 3 TO 5
            Print "THAT WAS SHOCKING. HAVE YOU EVER PLAYED THIS GAME BEFORE?"
        Case 0 TO 2
            Print "THE ONLY WAS TO DESCRIBE THAT PERFORMANCE IS EMBARRASING."
    End Select

    Locate 20, 24
    Print "YOUR SCORE:"
    Color 7, 2
    Locate 20, 36
    Print rally
    Locate 28, 24
    Print "PRESS RETURN TO GO BACK TO THE MAIN MENU"
    Locate 30, 24
    Print "PRESS SPACE TO TRY BACK WALL RALLY AGAIN"
    440 Select Case InKey$
        Case Is = Chr$(13)
        Case Is = Chr$(32)
            GoTo 450
        Case Else
            GoTo 440
    End Select
End Sub

Sub calender
    Color 15, 2
    Cls
    Locate 2, 5
    Print forename$(32); " "; surname$(32); "        "; day; " "; month$(month); " "; year
    Locate 5, 5
    Print "CALENDER"
    Locate 9, 5
    Print "DATE"
    Locate 9, 20
    Print "TOURNAMENT"
    Locate 9, 60
    Print "QUALIFICATION"

    For i = 1 To 24
        If qual(i) = 1 Then Color 15, 2 Else Color 7, 2
        Locate i + 10, 4
        Print day(i); month$(month(i))
        Locate i + 10, 20
        Print tourney$(i)
        Locate i + 10, 60
        Print qual$(qual(i))
    Next i
    Do
    Loop Until InKey$ = Chr$(13)
    Color 15, 2
    Cls
End Sub

Sub career
    os = 1
    Color 15, 2
    Cls
    470 Color 15, 2
    Locate 16, 24
    Print "CAREER MODE"
    Color 7, 2
    If os = 1 Then Color 2, 7 Else Color 7, 2
    Locate 20, 24
    Print "NEW CAREER"
    If os = 2 Then Color 2, 7 Else Color 7, 2
    Locate 22, 24
    Print "LOAD CAREER"

    460 Select Case InKey$
        Case Is = u$
            os = os - 1
            If os < 1 Then os = 2
            GoTo 470
        Case Is = d$
            os = os + 1
            If os > 2 Then os = 1
            GoTo 470
        Case Is = Chr$(13)
        Case Else
            GoTo 460
    End Select

    Select Case os
        Case Is = 1
        Case Is = 2
            GoTo 470
    End Select
    year = 2006
    day = 1
    month = 1
    forename$(32) = forename$
    surname$(32) = surname$

    Do
        z = 0
        arp(i) = 0
        For i = 1 To 32
            For j = 1 To 9
                arp(i) = arp(i) + rankPoints(j, i)
            Next j
            arp(i) = Int(arp(i) / 10)
            minorRating(i) = i / 1000
        Next i
        For i = 1 To 32
            rank(i) = 33
        Next i
        For i = 1 To 32
            For j = 1 To 32
                If arp(i) + minorRating(i) >= arp(j) + minorRating(j) Then rank(i) = rank(i) - 1
            Next j
        Next i

        Do
            Color 15, 2
            Cls
            os = 1
            490 Color 15, 2
            Locate 2, 24
            Print forename$(32); " "; surname$(32); "        "; day; month$(month); year
            Locate 16, 24
            Print "CAREER MODE"
            Color 7, 2
            Locate 20, 24
            If os = 1 Then Color 2, 7 Else Color 7, 2
            Print "CALENDER"
            Locate 22, 24
            If os = 2 Then Color 2, 7 Else Color 7, 2
            Print "PLAYER STATISTICS"
            Locate 24, 24
            If os = 3 Then Color 2, 7 Else Color 7, 2
            Print "WORLD RANKINGS"
            Locate 26, 24
            If os = 4 Then Color 2, 7 Else Color 7, 2
            Print "GO TO NEXT TOURNAMENT"
            Locate 28, 24
            If os = 5 Then Color 2, 7 Else Color 7, 2
            Print "CAREER OPTIONS"
            Locate 30, 24
            If os = 6 Then Color 2, 7 Else Color 7, 2
            Print "QUIT CAREER"

            480 Select Case InKey$
                Case Is = u$
                    os = os - 1
                    If os < 1 Then os = 6
                    GoTo 490
                Case Is = d$
                    os = os + 1
                    If os > 6 Then os = 1
                    GoTo 490
                Case Is = Chr$(13)
                Case Else
                    GoTo 480
            End Select

            Select Case os
                Case Is = 1
                    Call calender
                    os = 1
                    GoTo 490
                Case Is = 3
                    Call worldRankings
                    os = 3
                    GoTo 490
                Case Is = 4
                    z = 1
                    GoTo 490
                Case Is = 6
                    GoTo 500
                Case Else
                    GoTo 490
            End Select
            week = week + 1
            If week = 53 Then year = year + 1
            If week = 53 Then week = 1
        Loop Until z = 1
    Loop Until year = 11
    500 Color 15, 2
    Cls
End Sub

Sub challengeMatchDay
    Color 15, 2
    Cls
    Locate 16, 24
    If cCompleted(challenge) = 1 Then Print "MATCH "; challenge; " (Completed)" Else Print "MATCH "; challenge; " (Not Completed)"
    Color 7, 2
    For i = 1 To cAmount(challenge)
        Locate (i * 2) + 18, 24
        Print cDescription$(i, challenge)
    Next i
    Locate 36, 24
    Color 15, 2
    Print "PRESS RETURN TO GO TO THE MATCH"
    Do
    Loop Until InKey$ = Chr$(13)
    Call matchDay
End Sub

Sub challengeMode
    os = 1
    610 Color 15, 2
    Cls
    Locate 16, 24
    Print "CHALLENGE MODE"
    For i = 1 To 6
        Locate (i * 2) + 18, 24
        If os = i Then Color 2, 7 Else Color 7, 2
        If cCompleted(i) = 1 Then Print "MATCH "; i; " (Completed)" Else Print "MATCH "; i; " (Not Completed)"
    Next i
    Locate 32, 24
    If os = 7 Then Color 2, 7 Else Color 7, 2
    Print "RETURN TO MAIN MENU"

    600 Select Case InKey$
        Case Is = u$
            os = os - 1
            If os < 1 Then os = 7
            GoTo 610
        Case Is = d$
            os = os + 1
            If os > 7 Then os = 1
            GoTo 610
        Case Is = Chr$(13)
        Case Else
            GoTo 600
    End Select

    Select Case os
        Case Is = 7
        Case Else
            challenge = os
            Call challengeMatchDay
    End Select
    Color 15, 2
    Cls
End Sub















Sub getInfo
    Open "t.txt" For Input As #1
    For i = 1 To 31
        Input #1, forename$(i)
        Input #1, surname$(i)
        Input #1, speedRating(i)
        Input #1, power(i)
        Input #1, accuracy(i)
        Input #1, arp(i)
    Next i
    Close
    For i = 1 To 31
        speed(i) = 11 - speedRating(i)
        speed(i) = speed(i) * 25
    Next i
    round$(1) = "ROUND 1"
    round$(2) = "ROUND 2"
    round$(3) = "QUARTER-FINALS"
    round$(4) = "SEMI-FINALS"
    round$(5) = "FINAL"
    For j = 1 To 32
        For i = 1 To 10
            rankPoints(i, j) = arp(j)
        Next i
    Next j

    'OPEN "t2.txt" FOR INPUT AS #1
    'FOR i = 1 TO 24
    'INPUT #1, day(i)
    'INPUT #1, month(i)
    'INPUT #1, qual(i)
    'INPUT #1, tourney$(i)
    'NEXT i
    'CLOSE

    month$(1) = "JANUARY"
    days(1) = 31
    month$(2) = "FEBRUARY"
    days(2) = 28
    month$(3) = "MARCH"
    days(3) = 31
    month$(4) = "APRIL"
    days(4) = 30
    month$(5) = "MAY"
    days(5) = 31
    month$(6) = "JUNE"
    days(6) = 30
    month$(7) = "JULY"
    days(7) = 31
    month$(8) = "AUGUST"
    days(8) = 31
    month$(9) = "SEPTEMBER"
    days(9) = 30
    month$(10) = "OCTOBER"
    days(10) = 31
    month$(11) = "NOVEMBER"
    days(11) = 30
    month$(12) = "DECEMBER"
    days(12) = 31

    qual$(1) = "No qualification"
    qual$(2) = "1-16 in Rankings"
    qual$(3) = "17-32 in Rankings"
    qual$(4) = "1-10 in Rankings"
    qual$(5) = "11-20 in Rankings"
    qual$(6) = "21-32 in Rankings"

    entrants(1) = 32
    entrants(2) = 16
    entrants(3) = 16
    entrants(4) = 8
    entrants(5) = 8
    entrants(6) = 8

    rounds(1) = 5
    rounds(2) = 4
    rounds(3) = 4
    rounds(4) = 3
    rounds(5) = 3
    rounds(6) = 3

    Open "t3.txt" For Input As #1
    For i = 1 To 6
        Input #1, cPlayerNumber(1, i)
        Input #1, cGames(1, i)
        Input #1, cSets(1, i)
        Input #1, cPlayerNumber(2, i)
        Input #1, cGames(2, i)
        Input #1, cSets(2, i)
        Input #1, cGamesToWin(i)
        Input #1, cSetsToWin(i)
        Input #1, cAmount(i)
        For j = 1 To cAmount(i)
            Input #1, cDescription$(j, i)
        Next j
        cCompleted(i) = 0
    Next i
    Close
End Sub


















Sub matchDay
    If challenge > 0 Then oGamesToWin = gamesToWin
    If challenge > 0 Then gamesToWin = cGamesToWin(challenge)
    If challenge > 0 Then oSetsToWin = setsToWin
    If challenge > 0 Then setsToWin = cSetsToWin(challenge)
    If challenge > 0 Then oForename$ = forename$
    If challenge > 0 Then forename$ = forename$(cPlayerNumber(1, challenge))
    If challenge > 0 Then oSurname$ = surname$
    If challenge > 0 Then surname$ = surname$(cPlayerNumber(1, challenge))
    If challenge > 0 Then opponent = cPlayerNumber(2, challenge)
    For i = 1 To 2
        points(i) = 0
        realPoints$(i) = ""
        If challenge > 0 Then games(i) = cGames(i, challenge) Else games(i) = 0
        If challenge > 0 Then sets(i) = cSets(i, challenge) Else sets(i) = 0
        winners(i) = 0
        aces(i) = 0
        faults(i) = 0
        errors(i) = 0
    Next i

    side = 1
    speed = 0
    serve = 1
    serveHit = 0
    direction = 1
    realPoints$(1) = "0"
    realPoints$(2) = "0"

    Color 0, 2
    Cls
    Do
        Select Case speed
            Case Is = 0
                a = 37
                b = 32
                c = 16
                If serve = 1 Then d = 32 Else d = rand(12) + 25
                If serve = 1 Then y = 36 Else y = 17
                z = 41
        End Select
        total = 0
        totals = 0
        moveAmount = 0
        tt = 0
        t = 0
        noOutChance = 0

        Color 0, 2
        Cls
        For i = 1 To 2
            Locate 1 + i, 2
            Color 7, 1
            Print "                  "
            Locate 1 + i, 2
            Color 7, 1
            If i = 1 And serve = 1 Then Print surname$; " *"
            If i = 1 And serve = 2 Then Print surname$
            If i = 2 And serve = 1 Then Print surname$(opponent);
            If i = 2 And serve = 2 Then Print surname$(opponent); " *"
            Locate 1 + i, 20
            Color 7, 3
            Print "    "
            Locate 1 + i, 21
            Color 7, 3
            Print realPoints$(i)
            Locate 1 + i, 24
            Color 7, 4
            Print "    "
            Color 7, 4
            Locate 1 + i, 24
            Print games(i)
            Locate 1 + i, 28
            Color 7, 6
            Print "    "
            Color 7, 6
            Locate 1 + i, 28
            Print sets(i)
            If i = 1 Then j = 2 Else j = 1
            Select Case realPoints$(i)
                Case Is = "A"
                    Locate 1 + i, 32
                    Color 7, 6
                    Print "ADVANTAGE"
                Case Is = "40"
                    Locate 1 + i, 32
                    Color 7, 6
                    If realPoints$(j) <> "40" And realPoints$(j) <> "A" And serve = i Then Print "GAME POINT"
                    If realPoints$(j) <> "40" And realPoints$(j) <> "A" And serve <> i Then Print "BREAK POINT"
                    Locate 1 + i, 32
                    If realPoints$(j) <> "40" And realPoints$(j) <> "A" And gamesToWin - games(i) = 1 And setsToWin - sets(i) = 1 Then Print "MATCH POINT"
                    Locate 1 + i, 32
                    If realPoints$(j) <> "40" And realPoints$(j) <> "A" And gamesToWin - games(i) = 1 And setsToWin - sets(i) <> 1 Then Print "           "
                    Locate 1 + i, 32
                    If realPoints$(j) <> "40" And realPoints$(j) <> "A" And gamesToWin - games(i) = 1 And setsToWin - sets(i) <> 1 Then Print "SET POINT  "
            End Select
        Next i

        winner = 0
        ttt = Timer
        Do

            For i = 1 To 17
                If b + i > 0 And b + i < 81 Then Locate a, b + i
                Color userColour, 2
                If b + i > 0 And b + i < 81 Then Print Chr$(223)
            Next i
            For i = 1 To 17
                If d + i > 0 And d + i < 81 Then Locate c, d + i
                Color opponentColour, 2
                If d + i > 0 And d + i < 81 Then Print Chr$(220)
            Next i
            Locate y, z
            Color 10, 2
            Print Chr$(111)

            zz = 0
            Do
                Select Case InKey$
                    Case Is = l$
                        zz = 1
                        For i = 1 To 17
                            If b + i > 0 And b + i < 81 Then Locate a, b + i
                            Color 6, 2
                            If b + i > 0 And b + i < 81 Then Print " "
                        Next i
                        b = b - 1
                    Case Is = r$
                        zz = 1
                        For i = 1 To 17
                            If b + i > 0 And b + i < 81 Then Locate a, b + i
                            Color 6, 2
                            If b + i > 0 And b + i < 81 Then Print " "
                        Next i
                        b = b + 1
                    Case Is = Chr$(13)
                        If speed <> 0 Then GoTo 80
                        If y < b - 4 Then GoTo 80
                        If y > b + 12 Then GoTo 80
                        If serve = 1 And speed = 0 Then direction = 1
                        If serve = 1 And speed = 0 Then serveHit = 1
                        If serve = 1 And speed = 0 Then speed = 10
                        longHit = rand(12 - accuracy(opponent))
                        Select Case longHit
                            Case Is = 1
                                If d > 28 Then sideHit = 1 Else sideHit = 2
                                290 If sideHit = 1 Then e = rand(3) + 0 Else e = rand(3) + 14
                                If e = 1 Or e = 17 Then GoTo 290
                            Case Else
                                e = rand(17)
                        End Select

                        ballHit = b - z + 9
                        directionlr = 1
                        For i = 1 To 8
                            If ballHit = -i Then directionlr = 2
                            If ballHit = -i Then ballHit = i
                        Next i
                        If ballHit = 0 Then changeAmount = 100 Else changeAmount = 9 - ballHit
                80 End Select

                If speed = 0 Then GoTo 40
                moveAmount = (15 - speed) / 200
                moveAmount = Int(moveAmount * 1000) / 1000
                Select Case Timer
                    Case Is >= t + moveAmount
                        zz = 1
                        Color 2, 2
                        Locate y, z
                        Print " "
                        If direction = 1 Then y = y - 1 Else y = y + 1
                        t = Timer
                        totals = totals + 1
                End Select

                If zz = 1 Then GoTo 140
                Select Case totals
                    Case Is >= changeAmount
                        zz = 1
                        Color 2, 2
                        Locate y, z
                        Print " "
                        If directionlr = 1 Then z = z - 1 Else z = z + 1
                        If ballHit = 8 And directionlr = 1 And serveHit <> 1 Then z = z - 1
                        If ballHit = 8 And directionlr = 2 And serveHit <> 1 Then z = z + 1
                        totals = 0
                End Select

                If zz = 1 Then GoTo 140
                40 If serve = 1 And speed = 0 Then GoTo 140
                fatigue = Int(Timer - ttt)
                If fatigue > 40 Then fatigue = 40
                opponentMove = rand(speed(opponent) + fatigue)
                Select Case opponentMove
                    Case Is = 1
                        zz = 1
                        If speed <> 0 Then GoTo 100
                        If tt > 0 Then GoTo 110
                        tt = Timer
                        110 If Timer - tt < 1.5 Then GoTo 100
                        direction = 2
                        speed = 10
                        ballHit = d - z + 9
                        serveHit = 1
                        serveNow = 1
                        100 If speed = 0 Then GoTo 120
                        For i = 1 To 17
                            If d + i > 0 And d + i < 81 Then Locate c, d + i
                            Color 2, 2
                            If d + i > 0 And d + i < 81 And d + e <> z Then Print " "
                        Next i
                        Select Case d + e
                            Case Is < z
                                d = d + 1
                            Case Is > z
                                d = d - 1
                        End Select
                120 End Select
            140 Loop Until zz = 1

            90 If y = c + 1 And z <= d + 17 And z >= d + 1 Then hit2 = 1 Else hit2 = 0
            If y = a - 1 And z <= b + 17 And z >= b + 1 Then hit1 = 1 Else hit1 = 0

            Select Case hit1
                Case Is = 1
                    serveHit = 0
                    longHit = rand(12 - accuracy(opponent))
                    Select Case longHit
                        Case Is = 1
                            If d > 28 Then sideHit = 1 Else sideHit = 2
                            280 If sideHit = 1 Then e = rand(4) + 0 Else e = rand(4) + 13
                            If e = 1 And d < 50 And d > 30 Then GoTo 280
                            If e = 17 And d < 50 And d > 30 Then GoTo 280
                        Case Else
                            e = rand(17)
                    End Select
            End Select

            Select Case hit2
                Case Is = 1
                    If serveNow = 0 Then serveHit = 0
                    ballHit = d - z + 9
                    direction = 2
                    If speed <> 0 Then speed = power(opponent)
            End Select
            Select Case hit1
                Case Is = 1
                    ballHit = b - z + 9
                    direction = 1
                    If speed <> 0 Then speed = 10
            End Select
            serveNow = 0

            If hit2 = 0 And hit1 = 0 Then GoTo 50
            directionlr = 1
            For i = 1 To 8
                If ballHit = -i Then directionlr = 2
                If ballHit = -i Then ballHit = i
            Next i

            50 If ballHit = 0 Then changeAmount = 100 Else changeAmount = 9 - ballHit
            If b < -12 Then b = -12
            If b > 75 Then b = 75
            If d < -12 Then d = -12
            If d > 75 Then d = 75
            If y < 6 Then y = 6
            If y > 47 Then y = 47
            If z < 1 Then z = 1
            If z > 80 Then z = 80

            If winner > 0 Then GoTo 160
            finish = 0
            If y = 15 Then winner = 1
            If y = 15 And serveHit <> 1 Then winners(1) = winners(1) + 1
            If y = 15 And serveHit = 1 Then aces(1) = aces(1) + 1
            If y = 38 Then winner = 2
            If y = 38 And serveHit <> 1 Then winners(2) = winners(2) + 1
            If y = 38 And serveHit = 1 Then aces(2) = aces(2) + 1
            If y = 15 Then noOutChance = 1
            If y = 38 Then noOutChance = 1
            If z <= 1 And direction = 1 Then winner = 2
            If z <= 1 And direction = 1 And serveHit <> 1 Then errors(1) = errors(1) + 1
            If z <= 1 And direction = 1 And serveHit = 1 Then faults(1) = faults(1) + 1
            If z <= 1 And direction = 2 Then winner = 1
            If z <= 1 And direction = 2 And serveHit <> 1 Then errors(2) = errors(2) + 1
            If z <= 1 And direction = 2 And serveHit = 1 Then faults(2) = faults(2) + 1
            If z >= 80 And direction = 1 Then winner = 2
            If z >= 80 And direction = 1 And serveHit <> 1 Then errors(1) = errors(1) + 1
            If z >= 80 And direction = 1 And serveHit = 1 Then faults(1) = faults(1) + 1
            If z >= 80 And direction = 2 Then winner = 1
            If z >= 80 And direction = 2 And serveHit <> 1 Then errors(2) = errors(2) + 1
            If z >= 80 And direction = 2 And serveHit = 1 Then faults(2) = faults(2) + 1
            160 If y = 6 Then finish = 1
            If y = 47 Then finish = 2
            If z <= 1 And direction = 1 Then finish = 2
            If z <= 1 And direction = 2 Then finish = 1
            If z >= 80 And direction = 1 Then finish = 2
            If z >= 80 And direction = 2 Then finish = 1
            If noOutChance = 1 Then GoTo 240
            Select Case winner
                Case Is > 0
                    Locate 24, 38
                    Color 15, 2
                    Print "OUT!"
                    For t = 1 To 180000
                    Next t
            End Select
            240 Select Case y
                Case Is <= 15
                    Locate 24, 38
                    Color 15, 2
                    If serveHit = 1 Then Print "ACE!"
                Case Is >= 38
                    Locate 24, 38
                    Color 15, 2
                    If serveHit = 1 Then Print "ACE!"
            End Select
        Loop Until finish <> 0

        points(winner) = points(winner) + 1
        Select Case points(winner)
            Case Is = 4
                If winner = 1 Then loser = 2 Else loser = 1
                Select Case points(loser)
                    Case Is = 4
                        points(winner) = 3
                        points(loser) = 3
                    Case Is < 3
                        points(winner) = 5
                End Select
        End Select

        For i = 1 To 2
            Select Case points(i)
                Case Is = 0
                    realPoints$(i) = "0"
                Case Is = 1
                    realPoints$(i) = "15"
                Case Is = 2
                    realPoints$(i) = "30"
                Case Is = 3
                    realPoints$(i) = "40"
                Case Is = 4
                    realPoints$(i) = "A"
                Case Is = 5
                    points(1) = 0
                    points(2) = 0
                    realPoints$(1) = "0"
                    realPoints$(2) = "0"
                    games(i) = games(i) + 1
                    If serve = 1 Then serve = 2 Else serve = 1
            End Select
            If games(i) = gamesToWin Then sets(i) = sets(i) + 1
            If games(i) = gamesToWin Then games(1) = 0
            If games(i) = gamesToWin Then games(2) = 0
        Next i
        speed = 0
    Loop Until sets(1) = 1 Or sets(2) = setsToWin

    Color 0, 2
    Cls
    For i = 1 To 2
        Locate 1 + i, 2
        Color 7, 1
        Print "                  "
        Locate 1 + i, 2
        Color 7, 1
        If i = 1 And serve = 1 Then Print surname$; " *"
        If i = 1 And serve = 2 Then Print surname$
        If i = 2 And serve = 1 Then Print surname$(opponent);
        If i = 2 And serve = 2 Then Print surname$(opponent); " *"
        Locate 1 + i, 20
        Color 7, 3
        Print "    "
        Locate 1 + i, 21
        Color 7, 3
        Print realPoints$(i)
        Locate 1 + i, 24
        Color 7, 4
        Print "    "
        Color 7, 4
        Locate 1 + i, 24
        Print games(i)
        Locate 1 + i, 28
        Color 7, 6
        Print "    "
        Color 7, 6
        Locate 1 + i, 28
        Print sets(i)
    Next i
    Color 15, 2
    Locate 30, 20
    Select Case sets(1)
        Case Is > sets(2)
            If challenge = 1 Then cCompleted(challenge) = 1
            Print forename$; " "; surname$; " BEAT "; forename$(opponent); " "; surname$(opponent); " "; sets(1); "-"; sets(2)
        Case Else
            Print forename$(opponent); " "; surname$(opponent); " BEAT "; forename$; " "; surname$; " "; sets(2); "-"; sets(1)
    End Select
    Color 7, 2
    Locate 34, 20
    Print "PRESS RETURN TO VIEW THE MATCH STATISTICS"
    Do
    Loop Until InKey$ = Chr$(13)

    Color 15, 2
    Cls
    For i = 1 To 2
        Locate 1 + i, 2
        Color 7, 1
        Print "                  "
        Locate 1 + i, 2
        Color 7, 1
        If i = 1 And serve = 1 Then Print surname$; " *"
        If i = 1 And serve = 2 Then Print surname$
        If i = 2 And serve = 1 Then Print surname$(opponent);
        If i = 2 And serve = 2 Then Print surname$(opponent); " *"
        Locate 1 + i, 20
        Color 7, 3
        Print "    "
        Locate 1 + i, 21
        Color 7, 3
        Print realPoints$(i)
        Locate 1 + i, 24
        Color 7, 4
        Print "    "
        Color 7, 4
        Locate 1 + i, 24
        Print games(i)
        Locate 1 + i, 28
        Color 7, 6
        Print "    "
        Color 7, 6
        Locate 1 + i, 28
        Print sets(i)
    Next i

    Color 15, 2
    Locate 28, 20
    Print surname$
    Locate 28, 48
    Print surname$(opponent)
    Locate 30, 33
    Print "TOTAL SETS"
    Locate 32, 32
    Print "TOTAL POINTS"
    Locate 34, 36
    Print "ACES"
    Locate 36, 34
    Print "WINNERS"
    Locate 38, 30
    Print "SERVICE FAULTS"
    Locate 40, 30
    Print "UNFORCED ERRORS"
    Color 7, 2
    Locate 30, 25
    Print sets(1)
    Locate 30, 47
    Print sets(2)
    Locate 32, 25
    Print aces(1) + winners(1) + faults(2) + errors(2)
    Locate 32, 47
    Print aces(2) + winners(2) + faults(1) + errors(1)
    Locate 34, 25
    Print aces(1)
    Locate 34, 47
    Print aces(2)
    Locate 36, 25
    Print winners(1)
    Locate 36, 47
    Print winners(2)
    Locate 38, 25
    Print faults(1)
    Locate 38, 47
    Print faults(2)
    Locate 40, 25
    Print errors(1)
    Locate 40, 47
    Print errors(2)
    Do
    Loop Until InKey$ = Chr$(13)
    Color 15, 2
    Cls
    If challenge > 0 Then gamesToWin = oGamesToWin
    If challenge > 0 Then setsToWin = oSetsToWin
    If challenge > 0 Then forename$ = oForename$
    If challenge > 0 Then surname$ = oSurname$
End Sub

Sub matchDayMenu
    560 os = 1
    Color 15, 2
    Cls
    550 Locate 16, 24
    Color 15, 2
    Print "MATCH DAY"
    Locate 20, 24
    Print forename$; " "; surname$; " V "; forename$(opponent); " "; surname$(opponent)
    Locate 22, 24
    Print "First to "; gamesToWin; " games"
    Locate 24, 24
    If setsToWin = 1 Then Print "First to  1  set" Else Print "First to "; setsToWin; " sets"
    Locate 30, 24
    If os = 1 Then Color 2, 7 Else Color 7, 2
    Print "MATCH OPTIONS"
    Locate 32, 24
    If os = 2 Then Color 2, 7 Else Color 7, 2
    Print "GO TO MATCH"

    540 Select Case InKey$
        Case Is = u$
            os = os - 1
            If os < 1 Then os = 2
            GoTo 550
        Case Is = d$
            os = os + 1
            If os > 2 Then os = 1
            GoTo 550
        Case Is = Chr$(13)
        Case Else
            GoTo 540
    End Select

    Select Case os
        Case Is = 1
            Call options
            GoTo 560
        Case Is = 2
            Call matchDay
    End Select
End Sub

Sub options
    Color 15, 2
    os = 1
    230 Color 15, 2
    Cls
    If gamesToWin2 = 1 Then gamesToWin = 3 Else gamesToWin = 6
    Color 15, 2
    Locate 16, 32
    Print "OPTIONS"
    If os = 1 Then Color 2, 7 Else Color 7, 2
    Locate 20, 32
    Print "GAMES IN A SET   : FIRST TO "; gamesToWin
    If os = 2 Then Color 2, 7 Else Color 7, 2
    Locate 22, 32
    Print "SETS IN A MATCH  : FIRST TO "; setsToWin
    If os = 3 Then Color 2, 7 Else Color 7, 2
    Locate 24, 32
    Print "USER'S RACKET    : "; colour$(userColour)
    If os = 4 Then Color 2, 7 Else Color 7, 2
    Locate 26, 32
    Print "OPPONENT'S RACKET: "; colour$(opponentColour)
    If os = 5 Then Color 2, 7 Else Color 7, 2
    Locate 28, 32
    Print "RETURN TO MATCH MENU"

    220 Select Case InKey$
        Case Is = u$
            os = os - 1
            If os < 1 Then os = 5
            GoTo 230
        Case Is = d$
            os = os + 1
            If os > 5 Then os = 1
            GoTo 230
        Case Is = l$
            If os = 1 Then gamesToWin2 = gamesToWin2 - 1
            If os = 2 Then setsToWin = setsToWin - 1
            If gamesToWin2 < 1 Then gamesToWin2 = 2
            If setsToWin < 1 Then setsToWin = 3
            If os = 3 Then userColour = userColour - 1
            If userColour < 3 Then userColour = 15
            If os = 4 Then opponentColour = opponentColour - 1
            If opponentColour < 3 Then opponentColour = 15
            GoTo 230
        Case Is = r$
            If os = 1 Then gamesToWin2 = gamesToWin2 + 1
            If os = 2 Then setsToWin = setsToWin + 1
            If gamesToWin2 > 2 Then gamesToWin2 = 1
            If setsToWin > 3 Then setsToWin = 1
            If os = 3 Then userColour = userColour + 1
            If userColour > 15 Then userColour = 3
            If os = 4 Then opponentColour = opponentColour + 1
            If opponentColour > 15 Then opponentColour = 3
            GoTo 230
        Case Is = Chr$(13)
            If os <> 5 Then GoTo 220
        Case Else
            GoTo 220
    End Select
    Color 15, 2
    Cls
End Sub

Sub preMatchDay
    os = 1
    Color 15, 2
    Cls
    200 Color 15, 2
    Locate 16, 24
    Print "SELECT YOUR OPPONENT"
    Color 7, 2
    Locate 20, 24
    Print Chr$(29); " "; forename$(os); " "; surname$(os); " "; Chr$(29); "                    "
    Locate 24, 24
    Color 15, 2
    Print "SPEED:"
    Locate 26, 24
    Color 15, 2
    Print "POWER:"
    Locate 28, 24
    Color 15, 2
    Print "ACCURACY:"
    For i = 1 To 10
        Locate 24, i + 34
        Color 4, 2
        If i <= speedRating(os) Then Print Chr$(219) Else Print " "
        Locate 26, i + 34
        Color 5, 2
        If i <= power(os) Then Print Chr$(219) Else Print " "
        Locate 28, i + 34
        Color 6, 2
        If i <= accuracy(os) Then Print Chr$(219) Else Print " "
    Next i

    190 Select Case InKey$
        Case Is = l$
            os = os - 1
            If os < 1 Then os = 31
            GoTo 200
        Case Is = r$
            os = os + 1
            If os > 31 Then os = 1
            GoTo 200
        Case Is = Chr$(13)
        Case Else
            GoTo 190
    End Select

    opponent = os
    Call matchDayMenu
End Sub

Function rand (c)
    Randomize Timer
    rand = Int(c * Rnd(1)) + 1
End Function

Sub targetPractice
    430 a = 37
    b = 32
    score = 0
    w = 6
    Select Case target
        Case Is > 4
            location = rand(2)
            If location = 1 Then x = rand(16) Else x = rand(16) + 55
        Case Else
            x = rand(68)
    End Select
    y = 36
    z = 40
    t = 0
    alreadyAdded = 0
    hitTarget = 0
    totals = 0
    speed = 0
    direction = 1

    Color 15, 2
    Cls

    Locate 16, 24
    Print "TARGET PRACTICE"
    Color 7, 2
    Locate 20, 24
    Print "There are 10 targets to hit, each one slightly"
    Locate 21, 24
    Print "smaller than the last. Every time you hit the"
    Locate 22, 24
    Print "back wall, hit the ball out, or miss the ball,"
    Locate 23, 24
    Print "your score will increase by 1 point. The lower"
    Locate 24, 24
    Print "your score at the end, the better. Shown next"
    Locate 25, 24
    Print "to your name are firstly, the amount of targets"
    Locate 26, 24
    Print "you've hit so far, followed by your points."
    Locate 27, 24
    Print "Remember to keep your points low!"
    Color 15, 2
    Locate 35, 24
    Print "PRESS RETURN TO BEGIN TARGET PRACTICE"
    Do
    Loop Until InKey$ = Chr$(13)

    score = 0
    For target = 1 To 10
        w = 6
        Select Case target
            Case Is > 4
                location = rand(2)
                If location = 1 Then x = rand(16) Else x = rand(16) + 55
            Case Else
                x = rand(68)
        End Select

        alreadyAdded = 0
        hitTarget = 0
        If y = w Then y = y + 2
        If y - w = 1 Then y = y + 1
        Color 15, 2
        Cls
        For i = 2 To 20
            Color 1, 15
            Locate 2, i
            Print Chr$(219)
        Next i
        Color 15, 1
        Locate 2, 2
        Print surname$

        Do
            Locate 2, 21
            Color 15, 4
            Print target - 1
            Locate 2, 24
            Color 15, 5
            Print "  SCORE "; score

            For i = 1 To 11 - target
                Locate w, x + i
                Color target + 2, 2
                Print Chr$(219)
            Next i

            For i = 1 To 17
                Color userColour, 2
                If b + i > 0 And b + i < 81 Then Locate a, b + i
                Color 6, 2
                If b + i > 0 And b + i < 81 Then Print Chr$(223)
            Next i

            Locate y, z
            Color 10, 2
            Print "o"

            Select Case InKey$
                Case Is = l$
                    For i = 1 To 17
                        If b + i > 0 And b + i < 81 Then Locate a, b + i
                        Color 6, 2
                        If b + i > 0 And b + i < 81 Then Print " "
                    Next i
                    b = b - 1
                Case Is = r$
                    For i = 1 To 17
                        If b + i > 0 And b + i < 81 Then Locate a, b + i
                        Color 6, 2
                        If b + i > 0 And b + i < 81 Then Print " "
                    Next i
                    b = b + 1
                Case Is = Chr$(13)
                    If y < b - 3 Then GoTo 330
                    If y > b + 13 Then GoTo 330
                    If speed <> 0 Then GoTo 330
                    speed = 10
                    ballHit = b - z + 9
                    directionlr = 1
                    For i = 1 To 8
                        If ballHit = -i Then directionlr = 2
                        If ballHit = -i Then ballHit = i
                    Next i
            330 End Select

            If speed = 0 Then GoTo 320
            moveAmount = (15 - speed) / 200
            moveAmount = Int(moveAmount * 1000) / 1000
            Select Case Timer
                Case Is >= t + moveAmount
                    Color 2, 2
                    Locate y, z
                    Print " "
                    If direction = 1 Then y = y - 1 Else y = y + 1
                    t = Timer
                    totals = totals + 1
            End Select

            Select Case totals
                Case Is >= changeAmount
                    Color 2, 2
                    Locate y, z
                    Print " "
                    If directionlr = 1 Then z = z - 1 Else z = z + 1
                    If ballHit = 8 And directionlr = 1 And serveHit <> 1 Then z = z - 1
                    If ballHit = 8 And directionlr = 2 And serveHit <> 1 Then z = z + 1
                    totals = 0
            End Select

            hit1 = 0
            If y = a - 1 And z <= b + 17 And z >= b + 1 Then hit1 = 1 Else hit1 = 0
            Select Case hit1
                Case Is = 1
                    ballHit = b - z + 9
                    directionlr = 1
                    direction = 1
                    For i = 1 To 8
                        If ballHit = -i Then directionlr = 2
                        If ballHit = -i Then ballHit = i
                    Next i
            End Select
            320 If ballHit = 0 Then changeAmount = 100 Else changeAmount = 9 - ballHit
            If b < -12 Then b = -12
            If b > 75 Then b = 75
            If d < -12 Then d = -12
            If d > 75 Then d = 75
            If y < 1 Then y = 1
            If y > 47 Then y = 47
            If z < 1 Then z = 1
            If z > 80 Then z = 80
            If y = 2 Then direction = 2
            If y = 2 And alreadyAdded = 0 Then score = score + 1
            If y = 2 And alreadyAdded = 0 Then alreadyAdded = 1
            If y = 3 Then alreadyAdded = 0
            outOfBounds = 0
            If y > 42 Then outOfBounds = 1
            If z < 2 Then outOfBounds = 1
            If z > 79 Then outOfBounds = 1

            For i = 1 To 11 - target
                If y = w + 1 And z = x + i Then hitTarget = 1
                If y = w And z = x + i Then hitTarget = 1
            Next i
            If hitTarget = 1 Then direction = 2

            Select Case outOfBounds
                Case Is = 1
                    score = score + 1
                    speed = 0
                    a = 37
                    b = 32
                    y = 36
                    z = 40
                    t = 0
                    totals = 0
                    speed = 0
                    direction = 1
                    alreadyAdded = 0
                    Color 15, 2
                    Cls
                    For i = 2 To 20
                        Color 1, 15
                        Locate 2, i
                        Print Chr$(219)
                    Next i
                    Color 15, 1
                    Locate 2, 2
                    Print surname$
            End Select
        Loop Until hitTarget = 1
    Next target

    Color 15, 2
    Cls
    For i = 2 To 20
        Color 1, 15
        Locate 2, i
        Print Chr$(219)
    Next i
    Color 15, 1
    Locate 2, 2
    Print surname$
    Locate 2, 21
    Color 15, 4
    Print target - 1
    Locate 2, 25
    Color 15, 3
    Print "  SCORE "; score

    Color 15, 2
    Locate 16, 24
    Select Case score
        Case Is < 10
            Print "THAT WAS AN UNBELIEVEABLE EFFORT! WELL PLAYED!"
        Case 10 TO 18
            Print "WELL DONE! THAT WAS AN EXCELLENT PERFORMANCE."
        Case 19 TO 26
            Print "VERY IMPRESSIVE! YOU SHOULD BE PLEASED WITH THAT SCORE."
        Case 27 TO 35
            Print "GOOD SCORE, BUT STILL A LOT OF IMPROVEMENT TO BE MADE."
        Case 36 TO 42
            Print "NOT A BAD SCORE, BUT YOU CAN DO MUCH BETTER."
        Case 43 TO 50
            Print "BY NO MEANS IMPRESSIVE. TRY AGAIN."
        Case 51 TO 56
            Print "HAVE YOU FORGOTTEN THAT THE IDEA IS TO GET A LOW SCORE?"
        Case 57 TO 62
            Print "THAT WAS ABSOLUTELY DREADFUL. ENOUGH SAID."
        Case Is > 62
            Print "THAT WAS SHOCKING. HAVE YOU EVER PLAYED THIS GAME BEFORE?"
    End Select

    Locate 20, 24
    Print "YOUR SCORE:"
    Color 7, 2
    Locate 20, 36
    Print score
    Locate 28, 24
    Print "PRESS RETURN TO GO BACK TO THE MAIN MENU"
    Locate 30, 24
    Print "PRESS SPACE TO TRY TARGET PRACTICE AGAIN"
    420 Select Case InKey$
        Case Is = Chr$(13)
        Case Is = Chr$(32)
            GoTo 430
        Case Else
            GoTo 420
    End Select
End Sub

Sub tournament
    forename$(32) = forename$
    surname$(32) = surname$

    For i = 1 To 32
        in(i) = 1
        flag(i) = 0
    Next i

    For roundNumber = 1 To 5
        Select Case roundNumber
            Case Is = 1
                entrants = 32
            Case Is = 2
                entrants = 16
            Case Is = 3
                entrants = 8
            Case Is = 4
                entrants = 4
            Case Is = 5
                entrants = 2
        End Select

        For i = 1 To 32
            flag(i) = 0
        Next i

        For i = 1 To entrants
            Do
                tournamentPlayer(i) = rand(32)
            Loop Until flag(tournamentPlayer(i)) = 0 And in(tournamentPlayer(i)) = 1
            flag(tournamentPlayer(i)) = 1
        Next i

        userIn = 0
        Color 15, 2
        Cls
        Locate 6, 5
        If roundNumber = 5 Then Print "THE FINAL:" Else Print round$(roundNumber); " FIXUTES:"
        For i = 1 To 32
            For j = 1 To entrants
                If tournamentPlayer(j) = 32 Or tournamentPlayer(j + 1) = 32 Then Color 15, 2 Else Color 7, 2
                If tournamentPlayer(j) = 32 Or tournamentPlayer(j + 1) = 32 Then userIn = 1
                Locate j + 10, 5
                If tournamentPlayer(j) = i Then Print forename$(i); " "; surname$(i)
                Locate j + 10, 40
                If tournamentPlayer(j + 1) = i Then Print forename$(i); " "; surname$(i)
                Locate j + 10, 32
                Print "V"
                j = j + 1
            Next j
        Next i
        Color 15, 2
        Locate 44, 5
        If userIn = 1 Then Print "PRESS RETURN TO GO TO YOUR NEXT MATCH" Else Print "YOU ARE OUT OF THE TOURNAMENT. PRESS RETURN TO SKIP TO THE NEXT ROUND"
        Do
        Loop Until InKey$ = Chr$(13)

        userDone = 0
        For j = 1 To entrants
            If tournamentPlayer(j) = 32 Or tournamentPlayer(j + 1) = 32 Then userMatch = 1 Else userMatch = 0
            If userMatch = 1 Then userDone = userDone + 1
            Select Case userMatch
                Case Is = 1
                    If userDone > 1 Then GoTo 270
                    If tournamentPlayer(j) = 32 Then opponent = tournamentPlayer(j + 1) Else opponent = tournamentPlayer(j)
                    Call matchDayMenu
                    If winner = 1 Then in(opponent) = 0 Else in(32) = 0
                Case Else
                    270 totalRating = speedRating(tournamentPlayer(j)) + power(tournamentPlayer(j)) + accuracy(tournamentPlayer(j)) + speedRating(tournamentPlayer(j + 1)) + power(tournamentPlayer(j + 1)) + accuracy(tournamentPlayer(j + 1))
                    randTR = rand(totalRating)
                    Select Case randTR
                        Case Is <= speedRating(tournamentPlayer(j)) + power(tournamentPlayer(j)) + accuracy(tournamentPlayer(j))
                            in(tournamentPlayer(j + 1)) = 0
                        Case Else
                            in(tournamentPlayer(j)) = 0
                    End Select
            End Select
            j = j + 1
        Next j
    Next roundNumber

    Color 7, 2
    Cls
    For i = 34 To 44
        Locate 6, i
        Print Chr$(219)
    Next i
    Locate 7, 34
    Print Chr$(219); Chr$(219)
    Locate 7, 43
    Print Chr$(219); Chr$(219)
    Locate 8, 35
    Print Chr$(219); Chr$(219); Chr$(219)
    Locate 8, 41
    Print Chr$(219); Chr$(219); Chr$(219)
    For i = 37 To 41
        Locate 9, i
        Print Chr$(219)
    Next i

    For j = 10 To 20
        For i = 36 To 42
            Locate j, i
            Print Chr$(219)
        Next i
    Next j

    Color 7, 0
    For i = 35 To 43
        Locate 21, i
        If i > 36 And i < 42 Then Print Chr$(196) Else Print " "
    Next i
    For i = 34 To 44
        Locate 22, i
        If i > 35 And i < 43 Then Print Chr$(196) Else Print " "
    Next i
    For i = 33 To 45
        Locate 23, i
        If i > 34 And i < 44 Then Print Chr$(196) Else Print " "
    Next i

    Color 15, 2
    Locate 30, 20
    Print "TOURNAMENT WINNER:"
    Color 7, 2
    Locate 30, 40
    For i = 1 To 32
        If in(i) = 1 Then Print forename$(i); " "; surname$(i)
    Next i
    Locate 34, 20
    Print "PRESS RETURN TO GO BACK TO THE MAIN MENU"
    Do
    Loop Until InKey$ = Chr$(13)
    Color 15, 2
    Cls
End Sub

Sub training
    os = 1
    Color 15, 2
    Cls
    310 Color 15, 2
    Locate 16, 32
    Print "SELECT TRAINING TYPE"
    Locate 20, 32
    If os = 1 Then Color 2, 7 Else Color 7, 2
    Print "TARGET PRACTICE"
    Locate 22, 32
    If os = 2 Then Color 2, 7 Else Color 7, 2
    Print "BACK WALL RALLY"
    Locate 24, 32
    If os = 3 Then Color 2, 7 Else Color 7, 2
    Print "RETURN TO MAIN MENU"

    300 Select Case InKey$
        Case Is = u$
            os = os - 1
            If os < 1 Then os = 3
            GoTo 310
        Case Is = d$
            os = os + 1
            If os > 3 Then os = 1
            GoTo 310
        Case Is = Chr$(13)
        Case Else
            GoTo 300
    End Select

    Select Case os
        Case Is = 1
            Call targetPractice
        Case Is = 2
            Call backWallRally
        Case Is = 3
    End Select

    Color 15, 2
    Cls
End Sub

Sub worldRankings
    Color 15, 2
    Cls
    Locate 2, 5
    Print forename$(32); " "; surname$(32); "        "; day; " "; month$(month); " "; year
    Locate 5, 5
    Print "WORLD RANKINGS:"
    Locate 9, 5
    Print "RANK"
    Locate 9, 12
    Print "PLAYER"
    Locate 9, 38
    Print "RANK POINTS"
    For i = 1 To 32
        If i = 32 Then Color 15, 2 Else Color 7, 2
        Locate rank(i) + 10, 4
        Print rank(i)
        Locate rank(i) + 10, 12
        Print forename$(i); " "; surname$(i)
        Locate rank(i) + 10, 37
        Print arp(i)
    Next i
    Do
    Loop Until InKey$ = Chr$(13)
    Color 15, 2
    Cls
End Sub

