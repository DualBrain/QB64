'CHDIR ".\samples\pete\nlcm2006"

DECLARE SUB managerInfo ()
DECLARE SUB playerSalary ()
DECLARE SUB finance ()
DECLARE SUB endOfSeason ()
DECLARE SUB training ()
DECLARE SUB loadGame ()
DECLARE SUB saveGame ()
DECLARE SUB batOrder ()
DECLARE SUB statistics ()
DECLARE SUB groupTables ()
DECLARE SUB matchSimulator ()
DECLARE SUB manhattan ()
DECLARE SUB figures2 ()
DECLARE SUB scorecard2 ()
DECLARE SUB changeBowler ()
DECLARE SUB figures ()
DECLARE SUB scorecard ()
DECLARE FUNCTION rand! (c!)
DECLARE SUB matchDay ()
DECLARE SUB fixtures ()
DECLARE SUB getInfo ()
DECLARE SUB teamSheet ()
Dim Shared overSeas1(19)
Dim Shared overSeas2(19)
Dim Shared points(19)
Dim Shared ta(18)
Dim Shared ti(18)
Dim Shared f$(19)
Dim Shared team$(19)
Dim Shared rating(19)
Dim Shared shirt1(19)
Dim Shared shirt2(19)
Dim Shared trousers1(19)
Dim Shared trousers2(19)
Dim Shared cs(19)
Dim Shared wk(19)
Dim Shared cp(19)
Dim Shared ob1(19)
Dim Shared ob2(19)
Dim Shared player$(18, 19)
Dim Shared gb(18, 19)
Dim Shared rs(18, 19)
Dim Shared wt(18, 19)
Dim Shared eb(18, 19)
Dim Shared ba(18, 19)
Dim Shared fa(18, 19)
Dim Shared bat(18, 19)
Dim Shared bowl(18, 19)
Dim Shared wicketKeeper(18, 19)
Dim Shared peak(18, 19)
Dim Shared international(18, 19)
Dim Shared sm(18)
Dim Shared salary(18, 19)
Dim Shared sRuns(18)
Dim Shared sBalls(18)
Dim Shared sInnings(18)
Dim Shared sOuts(18)
Dim Shared hs(18)
Dim Shared batAve(18)
Dim Shared sOvers(18)
Dim Shared sWickets(18)
Dim Shared sConceded(18)
Dim Shared strRte(18)
Dim Shared ecnRte(18)
Dim Shared bbw(18)
Dim Shared bbr(18)
Dim Shared bowlAve(18)
Dim Shared bat$(2)
Dim Shared bowl$(13)
Dim Shared attribute$(6)
Dim Shared tAttribute$(6)
Dim Shared fixture(2, 9, 18)
Dim Shared pitch$(5)
Dim Shared pr(5)
Dim Shared truns(19)
Dim Shared tWickets(19)
Dim Shared tovers(19)
Dim Shared tBalls(19)
Dim Shared runs(11, 19)
Dim Shared balls(11, 19)
Dim Shared o(11, 19)
Dim Shared b(11, 19)
Dim Shared m(11, 19)
Dim Shared r(11, 19)
Dim Shared w(11, 19)
Dim Shared extras(19)
Dim Shared wides(19)
Dim Shared noBalls(19)
Dim Shared byes(19)
Dim Shared legByes(19)
Dim Shared ball$(8)
Dim Shared howOut1$(18, 19)
Dim Shared howOut2$(18, 19)
Dim Shared howOut3$(18, 19)
Dim Shared howOut4$(18, 19)
Dim Shared speed(8)
Dim Shared bowlChange(12, 19)
Dim Shared bowlers(19)
Dim Shared fow(10, 19)
Dim Shared cb(18, 19)
Dim Shared fatigue(18, 19)
Dim Shared in(18, 19)
Dim Shared rpo(50, 2)
Dim Shared groupTeam(10, 2)
Dim Shared rank(19)
Dim Shared position(19)
Dim Shared played(19)
Dim Shared wins(19)
Dim Shared losses(19)
Dim Shared ties(19)
Dim Shared field$(3)
Dim Shared career$(5)
Dim Shared morale(18)
Dim Shared iWeeks(18)
Dim Shared duty(18)
Common Shared directorsRating, fansRating, weekIn, weekOut, money, coinCheat, os, pr, battingSide, bowlingSide, lastSub, gt, bat1, bat2, team, name$, week, year, u$, d$, l$, r$, batSide, bowlSide, opponents, bowler, lbowler, momDone
Call getInfo
fansRating = 40
directorsRating = 40

Color 11, 0
Cls
Locate 16, 20
Print "NATIONAL LEAGUE CRICKET MANAGER 2006"
Locate 19, 28
Color 3, 0
Print "By Alex Beighton"
Do
Loop Until InKey$ = Chr$(13)

Color 11, 0
Cls
Locate 16, 28
Print "KEY CONFIGURATION:"
Color 3, 0
Locate 20, 22
Print "Enter the "; Chr$(34); "up"; Chr$(34); " key on your keypad"
Do
    u$ = InKey$
Loop Until u$ <> ""
Color 11, 0
Cls
Locate 16, 28
Print "KEY CONFIGURATION:"
Color 3, 0
Locate 20, 22
Print "Enter the "; Chr$(34); "down"; Chr$(34); " key on your keypad"
Do
    d$ = InKey$
Loop Until d$ <> ""
Color 11, 0
Cls
Locate 16, 28
Print "KEY CONFIGURATION:"
Color 3, 0
Locate 20, 22
Print "Enter the "; Chr$(34); "left"; Chr$(34); " key on your keypad"
Do
    l$ = InKey$
Loop Until l$ <> ""
Color 11, 0
Cls
Locate 16, 28
Print "KEY CONFIGURATION:"
Color 3, 0
Locate 20, 22
Print "Enter the "; Chr$(34); "right"; Chr$(34); " key on your keypad"
Do
    r$ = InKey$
Loop Until r$ <> ""

gc = 1
910 Color 11, 0
Cls
Locate 16, 20
Print "NATIONAL LEAGUE CRICKET MANAGER 2006"
Locate 19, 28
Color 3, 0
Print "By Alex Beighton"

If gc = 1 Then Color 0, 3 Else Color 3, 0
Locate 25, 30
Print "NEW GAME"
If gc = 2 Then Color 0, 3 Else Color 3, 0
Locate 27, 30
Print "LOAD GAME"
If gc = 3 Then Color 0, 3 Else Color 3, 0
Locate 29, 30
Print "QUIT GAME"

900 Select Case InKey$
    Case Is = u$
        gc = gc - 1
        If gc < 1 Then gc = 3
        GoTo 910
    Case Is = d$
        gc = gc + 1
        If gc > 3 Then gc = 1
        GoTo 910
    Case Is = Chr$(13)
    Case Else
        GoTo 900
End Select

Select Case gc
    Case Is = 2
        Call loadGame
        os = 1
        GoTo 970
    Case Is = 3
        End
End Select

Color 11, 0
Cls
Locate 16, 26
Print "ENTER YOUR NAME"
Color 3, 0
Locate 20, 26
Print "My name is"
Do
    Locate 20, 36
    Input name$
Loop Until name$ <> ""

Color 3, 0
Cls
ct = 1
20 Color 11, 0
Locate 3, 5
Print "SELECT YOUR TEAM..."
Color 3, 0
For i = 1 To 19
    If ct = i Then Color 0, 3 Else Color 3, 0
    Locate 6 + (i * 2), 5
    Print team$(i)
Next i

Color shirt1(ct), 0
For i = 18 To 27
    For j = 38 To 46
        Locate i, j
        Print Chr$(219)
    Next j
Next i
Color shirt2(ct), 0
Locate 22, 40
Print Chr$(219); Chr$(219); Chr$(219); Chr$(219); Chr$(219)
Locate 18, 42
Print Chr$(219)
For i = 18 To 24
    For j = 36 To 37
        Locate i, j
        Print Chr$(219)
    Next j
    For j = 47 To 48
        Locate i, j
        Print Chr$(219)
    Next j
Next i

Color trousers1(ct), 0
For i = 28 To 38
    For j = 38 To 46
        If i > 30 And j > 41 And j < 43 Then GoTo 440
        Locate i, j
        Print Chr$(219)
    440 Next j
Next i

Select Case cs(ct)
    Case Is = 1
        Color trousers2(ct), trousers1(ct)
        For i = 28 To 38
            Locate i, 38
            Print Chr$(221)
            Locate i, 46
            Print Chr$(222)
        Next i
    Case Is = 2
        Color trousers1(ct), trousers2(ct)
        For i = 28 To 38
            Locate i, 38
            Print Chr$(222)
            Locate i, 46
            Print Chr$(221)
        Next i
End Select

Color 11, 0
Locate 8, 36
Print "TEAM    :"
Color 3, 0
Locate 8, 47
Print team$(ct)
Color 11, 0
Locate 10, 36
Print "CAPTAIN :"
Color 3, 0
Locate 10, 47
Print player$(cp(ct), ct)
Color 11, 0
Locate 12, 36
Print "GROUP   :"
Color 3, 0
Locate 12, 47
If groupTeam(1, 1) = ct Or groupTeam(2, 1) = ct Or groupTeam(3, 1) = ct Or groupTeam(4, 1) = ct Or groupTeam(5, 1) = ct Or groupTeam(6, 1) = ct Or groupTeam(7, 1) = ct Or groupTeam(8, 1) = ct Or groupTeam(9, 1) = ct Then Print "DIVISION 1" Else Print "DIVISION 2"

10 Select Case InKey$
    Case Is = u$
        Cls
        ct = ct - 1
        If ct < 1 Then ct = 19
        GoTo 20
    Case Is = d$
        Cls
        ct = ct + 1
        If ct > 19 Then ct = 1
        GoTo 20
    Case Is = Chr$(13)
    Case Else
        GoTo 10
End Select
team = ct

week = 1
year = 2006
os = 1
For i = 1 To 18
    morale(i) = rand(10) + 65
Next i
970 Do
    For i = 1 To 18
        If morale(i) < 25 Then morale(i) = 25
        If morale(i) > 95 Then morale(i) = 95
    Next i
    Select Case os
        Case Is = 9
            For i = 1 To 18
                If iWeeks(i) > 0 Then iWeeks(i) = iWeeks(i) - 1
            Next i
            For i = 1 To 18
                If i > 11 Then morale(i) = morale(i) + (rand(4) - 3) Else morale(i) = morale(i) + rand(4)
                If morale(i) < 25 Then morale(i) = 25
                If morale(i) > 95 Then morale(i) = 95
            Next i
            weekOut = 0
            weekIn = 0
            For i = 1 To 18
                money = money - salary(i, team)
                weekOut = weekOut + salary(i, team)
            Next i
            weekIn = rand(12000) + 40000
            money = money + weekIn
            week = week + 1
            os = 1
            For i = 1 To 18
                If peak(i, team) = 1 Then ir = 4
                If peak(i, team) = 2 Then ir = 8
                If peak(i, team) = 3 Then ir = 12
                If peak(i, team) = 4 Then ir = 16
                If peak(i, team) = 5 Then ir = 20
                If ti(i) < 3 Then ir = ir + 1
                If ti(i) > 3 Then ir = ir - 1
                cogb = rand(ir)
                Select Case ir
                    Case Is = 1
                        If ta(i) = 1 Then gb(i, team) = gb(i, team) + 1
                        If ta(i) = 2 Then rs(i, team) = rs(i, team) + 1
                        If ta(i) = 3 Then wt(i, team) = wt(i, team) + 1
                        If ta(i) = 4 Then eb(i, team) = eb(i, team) + 1
                        If ta(i) = 5 Then fa(i, team) = fa(i, team) + 1
                        If ta(i) = 6 Then fa(i, team) = fa(i, team) + 1
                End Select
            Next i

            injuryChance = rand(6)
            Select Case injuryChance
                Case Is = 1
                    injuries = 0
                    For j = 1 To 18
                        If iWeeks(j) > 0 Then injuries = injuries + 1
                    Next j
                    If injuries >= 3 Then GoTo 3000
                    Do
                        injuredPlayer = rand(18)
                    Loop Until iWeeks(injuredPlayer) = 0
                    iWeeks(injuredPlayer) = rand(5)

                    Color 11, 0
                    Cls
                    Locate 2, 5
                    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year
                    Locate 8, 5
                    Print "FOR YOUR INFORMATION:"
                    Color 3, 0
                    Locate 10, 5
                    Print player$(injuredPlayer, team); " has picked up an injury and will be out for "; iWeeks(injuredPlayer); " weeks."
                    Do
                    Loop Until InKey$ = Chr$(13)
            3000 End Select

            internationals = 0
            For i = 1 To 18
                If international(i, team) = 1 Then internationals = 1
            Next i
            If internationals = 0 Then GoTo 3300
            Select Case week
                Case Is = 5
                    Color 11, 0
                    Cls
                    Locate 2, 5
                    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year
                    Locate 8, 5
                    Print "FOR YOUR INFORMATION:"
                    Color 3, 0
                    Locate 12, 5
                    Print "The following player(s) are from now on international duty and are"
                    Locate 13, 5
                    Print "unavailable for selection:"
                    internationalTotal = 0
                    For i = 1 To 18
                        If international(i, team) = 1 Then internationalTotal = internationalTotal + 1
                        Locate 14 + internationalTotal, 5
                        If international(i, team) = 1 Then Print player$(i, team)
                        If international(i, team) = 1 Then duty(i) = 1
                    Next i
                    Do
                    Loop Until InKey$ = Chr$(13)

                Case Is = 12
                    Color 11, 0
                    Cls
                    Locate 2, 5
                    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year
                    Locate 8, 5
                    Print "FOR YOUR INFORMATION:"
                    Color 3, 0
                    Locate 12, 5
                    Print "The following player(s) have returned from international duty and are"
                    Locate 13, 5
                    Print "now available for selection:"
                    internationalTotal = 0
                    For i = 1 To 18
                        If international(i, team) = 1 Then internationalTotal = internationalTotal + 1
                        Locate 14 + internationalTotal, 5
                        If international(i, team) = 1 Then Print player$(i, team)
                        If international(i, team) = 1 Then duty(i) = 0
                    Next i
                    Do
                    Loop Until InKey$ = Chr$(13)
            End Select
    3300 End Select

    If week = 53 Then year = year + 1
    If week = 53 Then week = 1

    totalMorale = 0
    For i = 1 To 18
        totalMorale = totalMorale + morale(i)
    Next i
    directorsRating = (fansRating / 2)
    Select Case totalMorale
        Case Is >= 1250
            directorsRating = directorsRating + 25
        Case 1200 TO 1249
            directorsRating = directorsRating + 15
        Case 1150 TO 1199
            directorsRating = directorsRating + 5
    End Select

    Select Case money
        Case Is >= 18000
            directorsRating = directorsRating + 25
        Case 16000 TO 17999
            directorsRating = directorsRating + 20
        Case 14000 TO 15999
            directorsRating = directorsRating + 15
        Case 12000 TO 13999
            directorsRating = directorsRating + 10
        Case 10000 TO 11999
            directorsRating = directorsRating + 5
    End Select


    If fansRating > 100 Then fansRating = 100
    If directorsRating > 100 Then directorsRating = 100
    If fansRating < 5 Then fansRating = 5
    If directorsRating < 5 Then directorsRating = 5

    Color 11, 0
    Cls
    Locate 2, 5
    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year

    Color shirt1(team), 0
    For i = 8 To 17
        For j = 44 To 52
            Locate i, j
            Print Chr$(219)
        Next j
    Next i
    Color shirt2(team), 0
    Locate 12, 46
    Print Chr$(219); Chr$(219); Chr$(219); Chr$(219); Chr$(219)
    Locate 8, 48
    Print Chr$(219)
    For i = 8 To 14
        For j = 42 To 43
            Locate i, j
            Print Chr$(219)
        Next j
        For j = 53 To 54
            Locate i, j
            Print Chr$(219)
        Next j
    Next i

    Color trousers1(team), 0
    For i = 18 To 28
        For j = 44 To 52
            If i > 20 And j > 47 And j < 49 Then GoTo 70
            Locate i, j
            Print Chr$(219)
        70 Next j
    Next i

    Select Case cs(team)
        Case Is = 1
            Color trousers2(team), trousers1(team)
            For i = 18 To 28
                Locate i, 44
                Print Chr$(221)
                Locate i, 52
                Print Chr$(222)
            Next i
        Case Is = 2
            Color trousers1(team), trousers2(team)
            For i = 18 To 28
                Locate i, 44
                Print Chr$(222)
                Locate i, 52
                Print Chr$(221)
            Next i
    End Select

    40 Locate 8, 5
    If os = 1 Then Color 0, 3 Else Color 3, 0
    Print "Team Sheet"
    Locate 10, 5
    If os = 2 Then Color 0, 3 Else Color 3, 0
    Print "Training"
    Locate 12, 5
    If os = 3 Then Color 0, 3 Else Color 3, 0
    Print "Finance"
    Locate 14, 5
    If os = 4 Then Color 0, 3 Else Color 3, 0
    Print "Fixtures"
    Locate 16, 5
    If os = 5 Then Color 0, 3 Else Color 3, 0
    Print "League Tables"
    Locate 18, 5
    If os = 6 Then Color 0, 3 Else Color 3, 0
    Print "Statistics"
    Locate 20, 5
    If os = 7 Then Color 0, 3 Else Color 3, 0
    Print "Manager Info"
    Locate 22, 5
    If os = 8 Then Color 0, 3 Else Color 3, 0
    Print "Save Game"
    Locate 24, 5
    If os = 9 Then Color 0, 3 Else Color 3, 0
    Print "GO TO MATCHDAY"

    30 Select Case InKey$
        Case Is = u$
            os = os - 1
            If os < 1 Then os = 9
            GoTo 40
        Case Is = d$
            os = os + 1
            If os > 9 Then os = 1
            GoTo 40
        Case Is = Chr$(13)
        Case Else
            GoTo 30
    End Select

    Select Case os
        Case Is = 1
            Call teamSheet
        Case Is = 2
            Call training
        Case Is = 3
            Call finance
        Case Is = 4
            Call fixtures
        Case Is = 5
            Call groupTables
        Case Is = 6
            Call statistics
        Case Is = 7
            Call managerInfo
        Case Is = 8
            Call saveGame
        Case Is = 9
            injuryTeam = 0
            For i = 1 To 11
                If iWeeks(i) > 0 Then injuryTeam = 1
                If duty(i) > 0 Then injuryTeam = 1
            Next i
            Select Case injuryTeam
                Case Is = 0
                    Call matchDay
                Case Is = 1
                    Color 3, 0
                    Locate 40, 5
                    Print "You cannot play a match, as you do not have 11 valid players in your team."
                    GoTo 30
            End Select
        Case Else
    End Select
Loop

Sub batOrder
    ps = tWickets(batSide) + 3
    22 Color 11, 0
    Cls
    Locate 2, 5
    Print team$(batSide); " - CHANGE BATTING ORDER"

    For i = 1 To 11
        Locate i * 2 + 6, 5
        If in(i, batSide) = 1 Then Color 11, 0 Else Color 3, 0
        Print player$(i, batSide)
        Locate i * 2 + 6, 3
        If i = ps Then Print Chr$(16) Else Print " "
    Next i

    Color 11, 0
    Locate 40, 5
    Print "Move the cursor to the player you want to swap, then press RETURN."

    21 Select Case InKey$
        Case Is = u$
            ps = ps - 1
            If ps - tWickets(batSide) < 3 Then ps = 11
            GoTo 22
        Case Is = d$
            ps = ps + 1
            If ps > 11 Then ps = tWickets(batSide) + 3
            GoTo 22
        Case Is = Chr$(13)
        Case Else
            GoTo 21
    End Select

    ps2 = tWickets(batSide) + 3
    24 Color 11, 0
    Cls
    Locate 2, 5
    Print team$(batSide); " - CHANGE BATTING ORDER"

    For i = 1 To 11
        Locate i * 2 + 6, 5
        If in(i, batSide) = 1 Then Color 11, 0 Else Color 3, 0
        Print player$(i, batSide)
        Color 3, 0
        Locate i * 2 + 6, 3
        If i = ps Then Print Chr$(16)
        Color 9, 0
        Locate i * 2 + 6, 3
        If i = ps2 Then Print Chr$(16)
        Locate i * 2 + 6, 3
        If i <> ps And i <> ps2 Then Print " "
    Next i

    Color 11, 0
    Locate 40, 5
    Print "Move the cursor to the player you want to swap, then press RETURN."

    23 Select Case InKey$
        Case Is = u$
            ps2 = ps2 - 1
            If ps2 - tWickets(batSide) < 3 Then ps2 = 11
            GoTo 24
        Case Is = d$
            ps2 = ps2 + 1
            If ps2 > 11 Then ps2 = tWickets(batSide) + 3
            GoTo 24
        Case Is = Chr$(13)
        Case Else
            GoTo 23
    End Select

    player2$ = player$(ps2, team)
    gb2 = gb(ps2, team)
    rs2 = rs(ps2, team)
    eb2 = eb(ps2, team)
    wt2 = wt(ps2, team)
    ba2 = ba(ps2, team)
    fa2 = fa(ps2, team)
    bats2 = bat(ps2, team)
    bowl2 = bowl(ps2, team)
    wicketKeeper2 = wicketKeeper(ps2, team)
    international2 = international(ps2, team)
    salary2 = salary(ps2, team)
    peak2 = peak(ps2, team)
    sm2 = sm(ps2)
    sInnings2 = sInnings(ps2)
    sRuns2 = sRuns(ps2)
    sOuts2 = sOuts(ps2)
    hs2 = hs(ps2)
    sBalls2 = sBalls(ps2)
    sWickets2 = sWickets(ps2)
    bbw2 = bbw(ps2)
    bbr2 = bbr(ps2)
    sOvers2 = sOvers(ps2)
    sConceded2 = sConceded(ps2)
    morale2 = morale(ps2)
    iWeeks2 = iWeeks(ps2)
    duty2 = duty(ps2)
    o2 = o(ps2, team)
    b2 = b(ps2, team)
    m2 = m(ps2, team)
    r2 = r(ps2, team)
    w2 = w(ps2, team)

    player$(ps2, team) = player$(ps, team)
    player$(ps2, team) = player$(ps, team)
    gb(ps2, team) = gb(ps, team)
    rs(ps2, team) = rs(ps, team)
    eb(ps2, team) = eb(ps, team)
    wt(ps2, team) = wt(ps, team)
    ba(ps2, team) = ba(ps, team)
    fa(ps2, team) = fa(ps, team)
    bat(ps2, team) = bat(ps, team)
    bowl(ps2, team) = bowl(ps, team)
    wicketKeeper(ps2, team) = wicketKeeper(ps, team)
    international(ps2, team) = international(ps, team)
    salary(ps2, team) = salary(ps, team)
    peak(ps2, team) = peak(ps, team)
    sm(ps2) = sm(ps)
    sInnings(ps2) = sInnings(ps)
    sRuns(ps2) = sRuns(ps)
    sOuts(ps2) = sOuts(ps)
    hs(ps2) = hs(ps)
    sBalls(ps2) = sBalls(ps)
    sWickets(ps2) = sWickets(ps)
    bbw(ps2) = bbw(ps)
    bbr(ps2) = bbr(ps)
    sOvers(ps2) = sOvers(ps)
    sConceded(ps2) = sConceded(ps)
    morale(ps2) = morale(ps)
    iWeeks(ps2) = iWeeks(ps)
    duty(ps2) = duty(ps)
    o(ps2, team) = o(ps, team)
    b(ps2, team) = b(ps, team)
    m(ps2, team) = m(ps, team)
    r(ps2, team) = r(ps, team)
    w(ps2, team) = w(ps, team)

    player$(ps, team) = player2$
    gb(ps, team) = gb2
    rs(ps, team) = rs2
    eb(ps, team) = eb2
    wt(ps, team) = wt2
    ba(ps, team) = ba2
    fa(ps, team) = fa2
    bat(ps, team) = bats2
    bowl(ps, team) = bowl2
    wicketKeeper(ps, team) = wicketKeeper2
    international(ps, team) = international2
    salary(ps, team) = salary2
    peak(ps, team) = peak2
    sm(ps) = sm2
    sInnings(ps) = sInnings2
    sRuns(ps) = sRuns2
    sOuts(ps) = sOuts2
    hs(ps) = hs2
    sBalls(ps) = sBalls2
    sWickets(ps) = sWickets2
    bbw(ps) = bbw2
    bbr(ps) = bbr2
    sOvers(ps) = sOvers2
    sConceded(ps) = sConceded2
    morale(ps) = morale2
    iWeeks(ps) = iWeeks2
    duty(ps) = duty2
    o(ps, team) = o2
    b(ps, team) = b2
    m(ps, team) = m2
    r(ps, team) = r2
    w(ps, team) = w2

    Select Case wk(team)
        Case Is = ps
            If ps2 < 12 Then wk(team) = ps2
        Case Is = ps2
            If ps < 12 Then wk(team) = ps
    End Select
    Select Case cp(team)
        Case Is = ps
            If ps2 < 12 Then cp(team) = ps2
        Case Is = ps2
            If ps < 12 Then cp(team) = ps
    End Select
    Select Case ob1(team)
        Case Is = ps
            If ps2 < 12 Then ob1(team) = ps2
        Case Is = ps2
            If ps < 12 Then ob1(team) = ps
    End Select
    Select Case ob2(team)
        Case Is = ps
            If ps2 < 12 Then ob2(team) = ps2
        Case Is = ps2
            If ps < 12 Then ob2(team) = ps
    End Select
    For i = 1 To 10
        Select Case bowlChange(i, team)
            Case Is = ps
                bowlChange(i, team) = ps2
            Case Is = ps2
                bowlChange(i, team) = ps
        End Select
    Next i
    25 Color 3, 0
    Cls
End Sub

Sub changeBowler
    choose = 1
    260 Color 11, 0
    Cls
    Do
        Locate 2, 5
        Print team$(bowlSide); " - CHANGE BOWLER"
        Locate 6, 5
        Print "PLAYER"
        Locate 6, 26
        Print "BOWL"
        Locate 6, 33
        Print "O"
        Locate 6, 36
        Print "M"
        Locate 6, 39
        Print "R"
        Locate 6, 43
        Print "W"
        Locate 6, 50
        Print "FATIGUE"

        For i = 1 To 11
            If i = 1 Or i = 3 Or i = 5 Or i = 7 Or i = 9 Or i = 11 Then Color 3, 0 Else Color 11, 0
            Locate 6 + (i * 2), 5
            Print player$(i, bowlSide)
            Locate 6 + (i * 2), 26
            Print bowl$(bowl(i, bowlSide))
            Locate 6 + (i * 2), 32
            Print o(i, bowlSide)
            Locate 6 + (i * 2), 35
            Print m(i, bowlSide)
            Locate 6 + (i * 2), 38
            Print r(i, bowlSide)
            Locate 6 + (i * 2), 42
            Print w(i, bowlSide)
            For j = 1 To 10
                Locate 6 + (i * 2), 49 + j
                If fatigue(i, bowlSide) > j Then Print Chr$(219)
            Next j
        Next i

        Color 11, 0
        Locate 6 + (choose * 2), 3
        Print Chr$(16)

        250 Select Case InKey$
            Case Is = u$
                choose = choose - 1
                If choose < 1 Then choose = 11
                GoTo 260
            Case Is = d$
                choose = choose + 1
                If choose > 11 Then choose = 1
                GoTo 260
            Case Is = Chr$(13)
            Case Else
                GoTo 250
        End Select

        Color 11, 0
        Locate 38, 5
        If bowl(choose, bowlSide) = 13 Then Print player$(choose, bowlSide); " does not bowl."
        Locate 40, 5
        If o(choose, bowlSide) >= 10 Then Print player$(choose, bowlSide); " has bowled his maximum 10 overs."
        Locate 42, 5
        If choose = lbowler Then Print player$(choose, bowlSide); " bowled the last over."
    Loop Until o(choose, bowlSide) < 9 And bowl(choose, bowlSide) < 13 And choose <> lbowler
    bowler = choose
    Color 3, 0
    Cls
    pr = r(bowler, bowlSide)
End Sub

Sub endOfSeason
    Color 11, 0
    Cls
    Locate 2, 5
    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year

    For i = 1 To 19
        rank(i) = (15 - i) / 100
    Next i
    For k = 1 To 2
        If k = 1 Then t = 9 Else t = 10
        For i = 1 To t
            position(groupTeam(i, k)) = 11
            For j = 1 To t
                If points(groupTeam(i, k)) + rank(groupTeam(i, k)) >= points(groupTeam(j, k)) + rank(groupTeam(j, k)) Then position(groupTeam(i, k)) = position(groupTeam(i, k)) - 1
            Next j
        Next i
    Next k
    Color 11, 0
    Cls
    Locate 2, 3
    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year
    Locate 6, 3
    Print "END OF SEASON - NATIONAL LEAGUE TABLES"
    Locate 9, 3
    Print "DIVISION 1"
    Locate 11, 3
    Print "TEAM"
    Locate 11, 21
    Print "P"
    Locate 11, 25
    Print "W"
    Locate 11, 29
    Print "L"
    Locate 11, 33
    Print "T"
    Locate 11, 38
    Print "PTS"

    For i = 1 To 9
        If position(groupTeam(i, 1)) > 7 Then Color 1, 0 Else Color 3, 0
        If groupTeam(i, 1) = team Then Color 11, 0
        Locate position(groupTeam(i, 1)) + 11, 3
        Print team$(groupTeam(i, 1))
        Locate position(groupTeam(i, 1)) + 11, 20
        Print played(groupTeam(i, 1))
        Locate position(groupTeam(i, 1)) + 11, 24
        Print wins(groupTeam(i, 1))
        Locate position(groupTeam(i, 1)) + 11, 28
        Print losses(groupTeam(i, 1))
        Locate position(groupTeam(i, 1)) + 11, 32
        Print ties(groupTeam(i, 1))
        Locate position(groupTeam(i, 1)) + 11, 37
        Print points(groupTeam(i, 1))
    Next i

    Color 11, 0
    Locate 29, 3
    Print "DIVISION 2"
    Locate 31, 3
    Print "TEAM"
    Locate 31, 21
    Print "P"
    Locate 31, 25
    Print "W"
    Locate 31, 29
    Print "L"
    Locate 31, 33
    Print "T"
    Locate 31, 38
    Print "PTS"

    For i = 1 To 10
        If position(groupTeam(i, 2)) > 3 Then Color 1, 0 Else Color 3, 0
        If groupTeam(i, 2) = team Then Color 11, 0
        Locate position(groupTeam(i, 2)) + 31, 3
        Print team$(groupTeam(i, 2))
        Locate position(groupTeam(i, 2)) + 31, 20
        Print played(groupTeam(i, 2))
        Locate position(groupTeam(i, 2)) + 31, 24
        Print wins(groupTeam(i, 2))
        Locate position(groupTeam(i, 2)) + 31, 28
        Print losses(groupTeam(i, 2))
        Locate position(groupTeam(i, 2)) + 31, 32
        Print ties(groupTeam(i, 2))
        Locate position(groupTeam(i, 2)) + 31, 37
        Print points(groupTeam(i, 2))
    Next i

    Do
    Loop Until InKey$ = Chr$(13)
    End
End Sub

Sub figures
    o((bowlChange(i, bowlSide)), bowlSide) = 10
    Color 11, 0
    Cls
    Locate 2, 4
    Print team$(bowlSide)
    Locate 5, 27
    Print "O"
    Locate 5, 35
    Print "M"
    Locate 5, 43
    Print "R"
    Locate 5, 51
    Print "W"

    Color 3, 0
    For i = 1 To bowlers(bowlSide)
        Locate 5 + (i * 2), 4
        Print player$((bowlChange(i, bowlSide)), bowlSide)
        If o((bowlChange(i, bowlSide)), bowlSide) >= 10 Then Locate 5 + (i * 2), 23 Else Locate 5 + (i * 2), 24
        Print o((bowlChange(i, bowlSide)), bowlSide); "."; b((bowlChange(i, bowlSide)), bowlSide)
        Locate 5 + (i * 2), 34
        Print m((bowlChange(i, bowlSide)), bowlSide)
        Locate 5 + (i * 2), 42
        Print r((bowlChange(i, bowlSide)), bowlSide)
        Locate 5 + (i * 2), 50
        Print w((bowlChange(i, bowlSide)), bowlSide)
    Next i

    Color 11, 0
    Locate 16 + (i * 2), 4
    Print "FOW:"
    Color 3, 0
    Locate 16 + (i * 2), 10
    If tWickets(batSide) = 0 Then Print "-"
    For j = 1 To 5
        Locate 16 + (i * 2), (12 * j)
        If tWickets(batSide) >= j Then Print j; " - "; fow(j, batSide)
    Next j
    For j = 1 To 5
        Locate 17 + (i * 2), (12 * j)
        If tWickets(batSide) >= (j + 5) Then Print j + 5; " - "; fow(j + 5, batSide)
    Next j

    Locate 48, 27
    Color 3, 0
    Print "       MAIN MENU       "
    Locate 48, 4
    Color 3, 0
    Print "   BATTING SCORECARD   "
    Locate 48, 50
    Color 0, 3
    Print "    BOWLING FIGURES    "
    Locate 46, 37
    Print Chr$(17); " "; Chr$(16)

    220 Select Case InKey$
        Case Is = l$
        Case Else
            GoTo 220
    End Select
End Sub

Sub figures2
    o((bowlChange(i, bowlingSide)), bowlingSide) = 10
    Color 11, 0
    Cls
    Locate 2, 4
    Print team$(bowlingSide)
    Locate 5, 27
    Print "O"
    Locate 5, 35
    Print "M"
    Locate 5, 43
    Print "R"
    Locate 5, 51
    Print "W"

    Color 3, 0
    For i = 1 To bowlers(bowlingSide)
        Locate 5 + (i * 2), 4
        Print player$((bowlChange(i, bowlingSide)), bowlingSide)
        If o((bowlChange(i, bowlingSide)), bowlingSide) >= 10 Then Locate 5 + (i * 2), 23 Else Locate 5 + (i * 2), 24
        Print o((bowlChange(i, bowlingSide)), bowlingSide); "."; b((bowlChange(i, bowlingSide)), bowlingSide)
        Locate 5 + (i * 2), 34
        Print m((bowlChange(i, bowlingSide)), bowlingSide)
        Locate 5 + (i * 2), 42
        Print r((bowlChange(i, bowlingSide)), bowlingSide)
        Locate 5 + (i * 2), 50
        Print w((bowlChange(i, bowlingSide)), bowlingSide)
    Next i

    Color 11, 0
    Locate 16 + (i * 2), 4
    Print "FOW:"
    Color 3, 0
    Locate 16 + (i * 2), 10
    If tWickets(battingSide) = 0 Then Print "-"
    For j = 1 To 5
        Locate 16 + (i * 2), (12 * j)
        If tWickets(battingSide) >= j Then Print j; " - "; fow(j, battingSide)
    Next j
    For j = 1 To 5
        Locate 17 + (i * 2), (12 * j)
        If tWickets(battingSide) >= (j + 5) Then Print j + 5; " - "; fow(j + 5, battingSide)
    Next j

    Do
    Loop Until InKey$ = Chr$(13)
End Sub

Sub finance
    2110 cfo = 1
    2100 Color 11, 0
    Cls
    Locate 2, 5
    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year
    Locate 6, 5
    Print "FINANCE"
    Locate 8, 5
    If cfo = 1 Then Color 0, 3 Else Color 3, 0
    Print "Finance Information"
    Locate 10, 5
    If cfo = 2 Then Color 0, 3 Else Color 3, 0
    Print "Player Salaries"
    Locate 12, 5
    If cfo = 3 Then Color 0, 3 Else Color 3, 0
    Print "Back to the Main Menu"

    2000 Select Case InKey$
        Case Is = u$
            cfo = cfo - 1
            If cfo < 1 Then cfo = 3
            GoTo 2100
        Case Is = d$
            cfo = cfo + 1
            If cfo > 3 Then cfo = 1
            GoTo 2100
        Case Is = Chr$(13)
        Case Else
            GoTo 2000
    End Select

    Select Case cfo
        Case Is = 2
            Call playerSalary
            GoTo 2110
        Case Is = 3
            GoTo 2200
    End Select

    Color 11, 0
    Cls
    Locate 2, 5
    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year
    Locate 6, 5
    Print "FINANCE INFORMATION"
    Color 3, 0
    Locate 12, 5
    Print "WEEKLY INCOME                    : "; weekIn; "pounds"
    Color 9, 0
    Locate 14, 5
    Print "WEEKLY OUTGOINGS                 : "; weekOut; "pounds"
    Color 3, 0
    Locate 16, 5
    Print "________________________________________________________"
    Color 3, 0
    Locate 18, 5
    Print "TOTAL FINANCE AT START OF SEASON :  20000 pounds"
    Color 9, 0
    Locate 20, 5
    Print "TOTAL CURRENT FINANCE            : "; money; "pounds"
    Do
    Loop Until InKey$ = Chr$(13)
    GoTo 2110
2200 End Sub

Sub fixtures
    If week = 19 Then GoTo 18
    Color 11, 0
    Cls
    Locate 2, 5
    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year
    Locate 6, 5
    Print "THIS WEEK'S NATIONAL LEAGUE FIXTURES:"
    Locate 10, 5
    Print "DIVISION 1:"
    For i = 6 To 9
        Color 3, 0
        Locate (i * 2), 5
        Print team$(fixture(1, i, week))
        Locate (i * 2), 23
        Print "V"
        Locate (i * 2), 27
        Print team$(fixture(2, i, week))
    Next i

    Color 11, 0
    Locate 22, 5
    Print "DIVISION 2:"
    For i = 1 To 5
        Color 3, 0
        Locate (i * 2) + 22, 5
        Print team$(fixture(1, i, week))
        Locate (i * 2) + 22, 23
        Print "V"
        Locate (i * 2) + 22, 27
        Print team$(fixture(2, i, week))
    Next i

    Do
    Loop Until InKey$ = Chr$(13)
18 End Sub

Sub getInfo
    f$(1) = "der.txt"
    f$(2) = "dur.txt"
    f$(3) = "ess.txt"
    f$(4) = "gla.txt"
    f$(5) = "glo.txt"
    f$(6) = "ham.txt"
    f$(7) = "kent.txt"
    f$(8) = "lan.txt"
    f$(9) = "lei.txt"
    f$(10) = "mid.txt"
    f$(11) = "nor.txt"
    f$(12) = "not.txt"
    f$(13) = "sco.txt"
    f$(14) = "som.txt"
    f$(15) = "sur.txt"
    f$(16) = "sus.txt"
    f$(17) = "war.txt"
    f$(18) = "wor.txt"
    f$(19) = "yor.txt"

    For i = 1 To 19
        Open f$(i) For Input As #1
        Input #1, team$(i)
        Input #1, rating(i)
        Input #1, shirt1(i)
        Input #1, shirt2(i)
        Input #1, trousers1(i)
        Input #1, trousers2(i)
        Input #1, cs(i)
        Input #1, wk(i)
        Input #1, cp(i)
        Input #1, ob1(i)
        Input #1, ob2(i)
        Input #1, overSeas1(i)
        Input #1, overSeas2(i)
        For j = 1 To 18
            Input #1, player$(j, i)
            Input #1, gb(j, i)
            Input #1, rs(j, i)
            Input #1, wt(j, i)
            Input #1, eb(j, i)
            Input #1, ba(j, i)
            Input #1, fa(j, i)
            Input #1, bat(j, i)
            Input #1, bowl(j, i)
            Input #1, wicketKeeper(j, i)
            Input #1, peak(j, i)
            Input #1, international(j, i)
            Input #1, salary(j, i)
        Next j
        Close
    Next i

    Open "fix.txt" For Input As #1
    For i = 1 To 18
        For j = 1 To 9
            Input #1, fixture(1, j, i)
            Input #1, fixture(2, j, i)
        Next j
    Next i

    bat$(1) = "RHB"
    bat$(2) = "LHB"
    bowl$(1) = "OS"
    bowl$(2) = "LS"
    bowl$(3) = "RM"
    bowl$(4) = "RMF"
    bowl$(5) = "RFM"
    bowl$(6) = "RF"
    bowl$(7) = "LO"
    bowl$(8) = "LC"
    bowl$(9) = "LM"
    bowl$(10) = "LMF"
    bowl$(11) = "LFM"
    bowl$(12) = "LF"
    bowl$(13) = "-"
    attribute$(1) = "General Batting "
    attribute$(2) = "Run Scoring     "
    attribute$(3) = "Wicket Taking   "
    attribute$(4) = "Economic Bowling"
    attribute$(5) = "Fielding        "
    attribute$(6) = "Morale          "
    tAttribute$(1) = "General Batting "
    tAttribute$(2) = "Run Scoring     "
    tAttribute$(3) = "Wicket Taking   "
    tAttribute$(4) = "Economic Bowling"
    tAttribute$(5) = "Fielding        "
    tAttribute$(6) = "Fitness         "

    pitch$(1) = "HARD"
    pitch$(2) = "NORMAL"
    pitch$(3) = "DUSTY"
    pitch$(4) = "GREEN"
    pitch$(5) = "DAMP"
    pr(1) = 1
    pr(2) = 0
    pr(3) = -1
    pr(4) = -1
    pr(5) = 0

    Open "groups.txt" For Input As #2
    For i = 1 To 9
        Input #2, groupTeam(i, 1)
    Next i
    For i = 1 To 10
        Input #2, groupTeam(i, 2)
    Next i
    Close

    field$(1) = "Set Attacking Field"
    field$(2) = "Set Open Field"
    field$(3) = "Set Defensive Field"

    career$(1) = "Beginning of Career"
    career$(2) = "Nearly at Peak"
    career$(3) = "Currently at Peak"
    career$(4) = "Just After Peak"
    career$(5) = "Toward End of Career"

    For i = 1 To 18
        ta(i) = 6
        ti(i) = 3
    Next i
    money = 20000
End Sub

Sub groupTables
    For i = 1 To 19
        rank(i) = (15 - i) / 100
    Next i

    For k = 1 To 2
        If k = 1 Then t = 9 Else t = 10
        For i = 1 To t
            position(groupTeam(i, k)) = 11
            For j = 1 To t
                If points(groupTeam(i, k)) + rank(groupTeam(i, k)) >= points(groupTeam(j, k)) + rank(groupTeam(j, k)) Then position(groupTeam(i, k)) = position(groupTeam(i, k)) - 1
            Next j
        Next i
    Next k


    Color 11, 0
    Cls
    Locate 2, 3
    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year
    Locate 6, 3
    Print "NATIONAL LEAGUE TABLES"
    Locate 9, 3
    Print "DIVISION 1"
    Locate 11, 3
    Print "TEAM"
    Locate 11, 21
    Print "P"
    Locate 11, 25
    Print "W"
    Locate 11, 29
    Print "L"
    Locate 11, 33
    Print "T"
    Locate 11, 38
    Print "PTS"

    For i = 1 To 9
        If position(groupTeam(i, 1)) > 7 Then Color 1, 0 Else Color 3, 0
        Locate position(groupTeam(i, 1)) + 11, 3
        Print team$(groupTeam(i, 1))
        Locate position(groupTeam(i, 1)) + 11, 20
        Print played(groupTeam(i, 1))
        Locate position(groupTeam(i, 1)) + 11, 24
        Print wins(groupTeam(i, 1))
        Locate position(groupTeam(i, 1)) + 11, 28
        Print losses(groupTeam(i, 1))
        Locate position(groupTeam(i, 1)) + 11, 32
        Print ties(groupTeam(i, 1))
        Locate position(groupTeam(i, 1)) + 11, 37
        Print points(groupTeam(i, 1))
    Next i

    Color 11, 0
    Locate 29, 3
    Print "DIVISION 2"
    Locate 31, 3
    Print "TEAM"
    Locate 31, 21
    Print "P"
    Locate 31, 25
    Print "W"
    Locate 31, 29
    Print "L"
    Locate 31, 33
    Print "T"
    Locate 31, 38
    Print "PTS"

    For i = 1 To 10
        If position(groupTeam(i, 2)) > 3 Then Color 1, 0 Else Color 3, 0
        Locate position(groupTeam(i, 2)) + 31, 3
        Print team$(groupTeam(i, 2))
        Locate position(groupTeam(i, 2)) + 31, 20
        Print played(groupTeam(i, 2))
        Locate position(groupTeam(i, 2)) + 31, 24
        Print wins(groupTeam(i, 2))
        Locate position(groupTeam(i, 2)) + 31, 28
        Print losses(groupTeam(i, 2))
        Locate position(groupTeam(i, 2)) + 31, 32
        Print ties(groupTeam(i, 2))
        Locate position(groupTeam(i, 2)) + 31, 37
        Print points(groupTeam(i, 2))
    Next i

    Do
    Loop Until InKey$ = Chr$(13)
End Sub

Sub loadGame
    12 Color 11, 0
    Cls
    Locate 2, 5
    Print "LOAD GAME"
    oss = 1

    1060 For i = 1 To 5
        If oss = i Then Color 0, 3 Else Color 3, 0
        Locate (i * 2 + 6), 5
        Print "LOAD GAME FROM FILE "; i
    Next i

    1050 Select Case InKey$
        Case Is = u$
            oss = oss - 1
            If oss < 1 Then oss = 5
            GoTo 1060
        Case Is = d$
            oss = oss + 1
            If oss > 5 Then oss = 1
            GoTo 1060
        Case Is = Chr$(13)
        Case Else
            GoTo 1050
    End Select

    Select Case oss
        Case Is = 6
        Case Else
            If oss = 1 Then fi$ = "file1.txt"
            If oss = 2 Then fi$ = "file2.txt"
            If oss = 3 Then fi$ = "file3.txt"
            If oss = 4 Then fi$ = "file4.txt"
            If oss = 5 Then fi$ = "file5.txt"

            gls = 0
            Open fi$ For Input As #1
            Input #1, team
            If team = 20 Then GoTo 11
            Input #1, name$
            Input #1, week
            Input #1, year
            Input #1, fansRating
            Input #1, directorsRating
            For i = 1 To 18
                Input #1, sm(i)
                Input #1, sInnings(i)
                Input #1, sRuns(i)
                Input #1, sOuts(i)
                Input #1, hs(i)
                Input #1, sBalls(i)
                Input #1, sOvers(i)
                Input #1, sWickets(i)
                Input #1, sConceded(i)
                Input #1, bbw(i)
                Input #1, bbr(i)
                Input #1, iWeeks(i)
                Input #1, duty(i)
                Input #1, morale(i)
            Next i
            For i = 1 To 19
                Input #1, team$(i)
                Input #1, rating(i)
                Input #1, shirt1(i)
                Input #1, shirt2(i)
                Input #1, trousers1(i)
                Input #1, trousers2(i)
                Input #1, cs(i)
                Input #1, wk(i)
                Input #1, cp(i)
                Input #1, ob1(i)
                Input #1, ob2(i)
                Input #1, overSeas1(i)
                Input #1, overSeas2(i)
                For j = 1 To 18
                    Input #1, player$(j, i)
                    Input #1, gb(j, i)
                    Input #1, rs(j, i)
                    Input #1, wt(j, i)
                    Input #1, eb(j, i)
                    Input #1, ba(j, i)
                    Input #1, fa(j, i)
                    Input #1, bat(j, i)
                    Input #1, bowl(j, i)
                    Input #1, wicketKeeper(j, i)
                    Input #1, peak(j, i)
                    Input #1, international(j, i)
                    Input #1, salary(j, i)
                Next j
                Input #1, points(i)
                Input #1, wins(i)
                Input #1, ties(i)
                Input #1, losses(i)
                Input #1, played(i)
            Next i
            Close
            gls = 1
            11 Select Case gls
                Case Is = 1
                    Color 11, 0
                    Cls
                    Locate 20, 20
                    Print "GAME LOADED SUCCESFULLY FROM FILE "; oss
                    Do
                    Loop Until InKey$ = Chr$(13)
                Case Else
                    Close
                    Color 11, 0
                    Cls
                    Locate 20, 20
                    Print "NO SAVED GAME IN FILE "; oss
                    Do
                    Loop Until InKey$ = Chr$(13)
                    GoTo 12
            End Select
    End Select
End Sub

Sub managerInfo
    Color 11, 0
    Cls
    Locate 2, 5
    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year

    Color 3, 0
    Locate 8, 5
    Print "MANAGER'S NAME    :  "; name$
    Locate 10, 5
    Print "CLUB MANAGED      :  "; team$(team)
    Locate 12, 5
    Print "WEEK'S AT CLUB    : "; week
    Locate 16, 5
    Print "DIRECTOR'S RATING :"
    Locate 18, 5
    Print "FANS RATING       :"

    For i = 1 To 50
        Select Case directorsRating
            Case Is > (i * 2 - 1)
                Color 1, 0
                Locate 16, i + 25
                Print Chr$(219)
            Case Is = (i * 2 - 1)
                Color 1, 0
                Locate 16, i + 25
                Print Chr$(221)
            Case Else
                Color 3, 0
                Locate 16, i + 25
                Print Chr$(196)
        End Select
    Next i

    For i = 1 To 50
        Select Case fansRating
            Case Is > (i * 2 - 1)
                Color 1, 0
                Locate 18, i + 25
                Print Chr$(219)
            Case Is = (i * 2 - 1)
                Color 1, 0
                Locate 18, i + 25
                Print Chr$(219)
            Case Else
                Color 3, 0
                Locate 18, i + 25
                Print Chr$(196)
        End Select
    Next i


    Do
    Loop Until InKey$ = Chr$(13)
End Sub

Sub manhattan
    Color 11, 0
    Cls
    Locate 2, 3
    Print team$(battingSide); " INNINGS MANHATTAN GRAPH"
    For i = 1 To 50
        mgcc = mgcc + 1
        If mgcc = 3 Then mgcc = 1
        For j = 1 To 30
            Color 11, 0
            Locate (41 - j), 3
            If j = 2 Or j = 4 Or j = 6 Or j = 8 Or j = 10 Or j = 12 Or j = 14 Or j = 16 Or j = 18 Or j = 20 Then Print j
            If mgcc = 1 Then Color 11, 0 Else Color 3, 0
            Locate (41 - j), i + 6
            If rpo(i, battingSide) >= j Then Print Chr$(219)
        Next j
    Next i
    Do
    Loop Until InKey$ = Chr$(13)
End Sub

Sub matchDay
    If week = 19 Then Call endOfSeason
    Select Case gt
        Case Is = 1
            gt = 0
            GoTo 170
    End Select

    For i = 1 To 9
        If fixture(1, i, week) = team Or fixture(2, i, week) = team Then match = i
    Next i

    If match > 0 Then GoTo 410
    Color 11, 0
    Cls
    Locate 1, 3
    Print "MATCHDAY:"
    Color 3, 0
    Locate 16, 3
    Print team$(team); " DO NOT HAVE A FIXTURE FOR TODAY..."
    Do
    Loop Until InKey$ = Chr$(13)
    GoTo 420

    410 Color 11, 0
    Cls
    Locate 1, 22
    Print "MATCHDAY:"

    Color shirt1(fixture(1, match, week)), 0
    For i = 8 To 17
        For j = 24 To 32
            Locate i, j
            Print Chr$(219)
        Next j
    Next i
    Color shirt2(fixture(1, match, week)), 6
    Locate 12, 26
    Print Chr$(219); Chr$(219); Chr$(219); Chr$(219); Chr$(219)
    Locate 8, 28
    Print Chr$(219)
    For i = 8 To 14
        For j = 22 To 23
            Locate i, j
            Print Chr$(219)
        Next j
        For j = 33 To 34
            Locate i, j
            Print Chr$(219)
        Next j
    Next i

    Color trousers1(fixture(1, match, week)), 0
    For i = 18 To 28
        For j = 24 To 32
            If i > 20 And j > 27 And j < 29 Then GoTo 80
            Locate i, j
            Print Chr$(219)
        80 Next j
    Next i

    Select Case cs(fixture(1, match, week))
        Case Is = 1
            Color trousers2(fixture(1, match, week)), trousers1(fixture(1, match, week))
            For i = 18 To 28
                Locate i, 24
                Print Chr$(221)
                Locate i, 32
                Print Chr$(222)
            Next i
        Case Is = 2
            Color trousers1(fixture(1, match, week)), trousers2(fixture(1, match, week))
            For i = 18 To 28
                Locate i, 24
                Print Chr$(222)
                Locate i, 32
                Print Chr$(221)
            Next i
    End Select

    Color 11, 0
    Locate 14, 38
    Print "V"

    Color shirt1(fixture(2, match, week)), 0
    For i = 8 To 17
        For j = 44 To 52
            Locate i, j
            Print Chr$(219)
        Next j
    Next i
    Color shirt2(fixture(2, match, week)), 0
    Locate 12, 46
    Print Chr$(219); Chr$(219); Chr$(219); Chr$(219); Chr$(219)
    Locate 8, 48
    Print Chr$(219)
    For i = 8 To 14
        For j = 42 To 43
            Locate i, j
            Print Chr$(219)
        Next j
        For j = 53 To 54
            Locate i, j
            Print Chr$(219)
        Next j
    Next i

    Color trousers1(fixture(2, match, week)), 0
    For i = 18 To 28
        For j = 44 To 52
            If i > 20 And j > 47 And j < 49 Then GoTo 90
            Locate i, j
            Print Chr$(219)
        90 Next j
    Next i

    Select Case cs(fixture(2, match, week))
        Case Is = 1
            Color trousers2(fixture(2, match, week)), trousers1(fixture(2, match, week))
            For i = 18 To 28
                Locate i, 44
                Print Chr$(221)
                Locate i, 52
                Print Chr$(222)
            Next i
        Case Is = 2
            Color trousers1(fixture(2, match, week)), trousers2(fixture(2, match, week))
            For i = 18 To 28
                Locate i, 44
                Print Chr$(222)
                Locate i, 52
                Print Chr$(221)
            Next i
    End Select

    pitch = rand(5)
    Color 3, 0
    Locate 36, 22
    Print team$(fixture(1, match, week)); "  V  "; team$(fixture(2, match, week))
    Locate 38, 22
    Print "PITCH TYPE: "; pitch$(pitch)
    Locate 40, 22
    Print "Press RETURN to go to the match..."
    Do
    Loop Until InKey$ = Chr$(13)

    Color 11, 0
    Cls
    Locate 3, 22
    Print "MATCHDAY:"
    Locate 12, 22
    Print "COIN TOSS: "; team$(team); " TO CALL"
    tc = 1

    110 Locate 14, 22
    If tc = 1 Then Color 0, 3 Else Color 3, 0
    Print "HEADS"
    Locate 16, 22
    If tc = 2 Then Color 0, 3 Else Color 3, 0
    Print "TAILS"

    100 Select Case InKey$
        Case Is = u$
            tc = tc - 1
            If tc < 1 Then tc = 2
            GoTo 110
        Case Is = d$
            tc = tc + 1
            If tc > 2 Then tc = 1
            GoTo 110
        Case Is = Chr$(13)
        Case Else
            GoTo 100
    End Select

    If coinCheat = 1 Then result = 2 Else result = rand(2)
    Select Case result
        Case Is = 1
            Select Case pitch
                Case Is = 1
                    cc = 2
                Case Is = 2
                    cc = rand(2)
                Case Is = 3
                    cc = 1
                Case Is = 4
                    cc = 1
                Case Is = 5
                    cc = rand(2)
            End Select
            Color 11, 0
            Locate 20, 22
            If cc = 1 Then Print "YOU HAVE LOST THE COIN TOSS - YOU WILL BAT FIRST"
            If cc = 2 Then Print "YOU HAVE LOST THE COIN TOSS - YOU WILL FIELD FIRST"
            Do
            Loop Until InKey$ = Chr$(13)
        Case Else

            Locate 22, 22
            Color 11, 0
            Print "YOU HAVE WON THE TOSS"
            Color 3, 0
            tc = 1

            130 Locate 24, 22
            If tc = 1 Then Color 0, 3 Else Color 3, 0
            Print "BAT FIRST"
            Locate 26, 22
            If tc = 2 Then Color 0, 3 Else Color 3, 0
            Print "FIELD FIRST"

            120 Select Case InKey$
                Case Is = u$
                    tc = tc - 1
                    If tc < 1 Then tc = 2
                    GoTo 130
                Case Is = d$
                    tc = tc + 1
                    If tc > 2 Then tc = 1
                    GoTo 130
                Case Is = Chr$(13)
                Case Else
                    GoTo 120
            End Select
            cc = tc
    End Select

    If fixture(1, match, week) = team Then opponents = fixture(2, match, week)
    If fixture(2, match, week) = team Then opponents = fixture(1, match, week)

    For i = 1 To 50
        rpo(i, 1) = 0
        rpo(i, 2) = 0
    Next i

    ft = 1
    truns(team) = 0
    tWickets(team) = 0
    tovers(team) = 0
    tBalls(team) = 0
    bowlers(team) = 0
    For i = 1 To 10
        bowlChange(i, team) = 0
    Next i
    For j = 1 To 11
        If j = 1 Or j = 2 Then in(j, team) = 1 Else in(j, team) = 2
        runs(j, team) = 0
        balls(j, team) = 0
        howOut1$(j, team) = ""
        howOut2$(j, team) = ""
        howOut3$(j, team) = ""
        howOut4$(j, team) = ""
        o(j, team) = 0
        b(j, team) = 0
        m(j, team) = 0
        w(j, team) = 0
        r(j, team) = 0
        fatigue(j, team) = 10
    Next j
    extras(team) = 0
    wides(team) = 0
    noBalls(team) = 0
    legByes(team) = 0
    byes(team) = 0

    truns(opponents) = 0
    tWickets(opponents) = 0
    tovers(opponents) = 0
    tBalls(opponents) = 0
    bowlers(opponents) = 0
    For i = 1 To 10
        bowlChange(i, opponents) = 0
    Next i
    For j = 1 To 11
        If j = 1 Or j = 2 Then in(j, opponents) = 1 Else in(j, opponents) = 2
        runs(j, opponents) = 0
        balls(j, opponents) = 0
        howOut1$(j, opponents) = ""
        howOut2$(j, opponents) = ""
        howOut3$(j, opponents) = ""
        howOut4$(j, opponents) = ""
        o(j, opponents) = 0
        m(j, opponents) = 0
        w(j, opponents) = 0
        r(j, opponents) = 0
        fatigue(j, opponents) = 10
    Next j
    extras(opponents) = 0
    wides(opponents) = 0
    noBalls(opponents) = 0
    legByes(opponents) = 0
    byes(opponents) = 0

    For innings = 1 To 2
        retain = 3
        mindset = 2
        Select Case innings
            Case Is = 1
                If cc = 1 Then batSide = team Else batSide = opponents
                If cc = 1 Then bowlSide = opponents Else bowlSide = team
            Case Is = 2
                neitherSide = batSide
                batSide = bowlSide
                bowlSide = neitherSide
        End Select

        finish = 0
        bat1 = 1
        bat2 = 2
        bowler = ob1(bowlSide)
        lbowler = ob2(bowlSide)
        strike = 1
        menu = 1

        overBalls = 0
        If innings = 1 Then hours = 11 Else hours = 14
        If innings = 1 Then minutes = 0 Else minutes = 20
        For j = 1 To 11
        Next j
        For j = 1 To 8
            ball$(j) = ""
        Next j

        Do
            170 Color 11, 0
            Cls
            Select Case tBalls(batSide)
                Case Is = 6
                    If innings = 1 Then rpo(tovers(batSide), 1) = truns(batSide) - rbo
                    If innings = 2 Then rpo(tovers(batSide), 2) = truns(batSide) - rbo
                    rbo = truns(batSide)
                    fatigue(bowler, bowlSide) = fatigue(bowler, bowlSide) - 2
                    fatigue(lbowler, bowlSide) = fatigue(lbowler, bowlSide) - 1
                    For E = 1 To 11
                        fatigue(E, bowlSide) = fatigue(E, bowlSide) + 1
                        If fatigue(E, bowlSide) < 2 Then fatigue(E, bowlSide) = 2
                        If fatigue(E, bowlSide) > 10 Then fatigue(E, bowlSide) = 10
                    Next E
                    overBouncers = 0
                    tovers(batSide) = tovers(batSide) + 1
                    tBalls(batSide) = 0
                    strike = strike + 1
                    If strike = 3 Then strike = 1
                    overExtras = 0
                    If r(bowler, bowlSide) = pr Then m(bowler, bowlSide) = m(bowler, bowlSide) + 1
                    o(bowler, bowlSide) = o(bowler, bowlSide) + 1
                    b(bowler, bowlSide) = 0

                    Select Case bowlSide
                        Case Is = team
                            cbowler = bowler
                            bowler = lbowler
                            lbowler = cbowler


                        Case Is = opponents
                            change = 0
                            If rand(4) = 1 Then change = 1
                            If tovers(batSide) < 9 Then change = 0
                            If o(lbowler, bowlSide) >= 9 Then change = 1
                            If fatigue(lbowler, bowlSide) < 4 Then change = 1

                            Select Case change
                                Case Is = 0
                                    cbowler = bowler
                                    bowler = lbowler
                                    lbowler = cbowler

                                Case Else
                                    cb(1, bowlSide) = ba(1, bowlSide)
                                    cb(2, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide)
                                    cb(3, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide)
                                    cb(4, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide)
                                    cb(5, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide) + ba(5, bowlSide)
                                    cb(6, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide) + ba(5, bowlSide) + ba(6, bowlSide)
                                    cb(7, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide) + ba(5, bowlSide) + ba(6, bowlSide) + ba(7, bowlSide)
                                    cb(8, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide) + ba(5, bowlSide) + ba(6, bowlSide) + ba(7, bowlSide) + ba(8, bowlSide)
                                    cb(9, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide) + ba(5, bowlSide) + ba(6, bowlSide) + ba(7, bowlSide) + ba(8, bowlSide) + ba(9, bowlSide)
                                    cb(10, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide) + ba(5, bowlSide) + ba(6, bowlSide) + ba(7, bowlSide) + ba(8, bowlSide) + ba(9, bowlSide) + ba(10, bowlSide)
                                    cb(11, bowlSide) = ba(1, bowlSide) + ba(2, bowlSide) + ba(3, bowlSide) + ba(4, bowlSide) + ba(5, bowlSide) + ba(6, bowlSide) + ba(7, bowlSide) + ba(8, bowlSide) + ba(9, bowlSide) + ba(10, bowlSide) + ba(11, bowlSide)

                                    tcb = 0
                                    For k = 1 To 11
                                        tcb = tcb + ba(k, bowlSide)
                                    Next k

                                    lbowler = bowler
                                    240 rtcb = rand(tcb)

                                    Select Case rtcb
                                        Case 0 TO cb(1, bowlSide)
                                            bowler = 1
                                        Case cb(1, bowlSide) TO cb(2, bowlSide)
                                            bowler = 2
                                        Case cb(2, bowlSide) TO cb(3, bowlSide)
                                            bowler = 3
                                        Case cb(3, bowlSide) TO cb(4, bowlSide)
                                            bowler = 4
                                        Case cb(4, bowlSide) TO cb(5, bowlSide)
                                            bowler = 5
                                        Case cb(5, bowlSide) TO cb(6, bowlSide)
                                            bowler = 6
                                        Case cb(6, bowlSide) TO cb(7, bowlSide)
                                            bowler = 7
                                        Case cb(7, bowlSide) TO cb(8, bowlSide)
                                            bowler = 8
                                        Case cb(8, bowlSide) TO cb(9, bowlSide)
                                            bowler = 9
                                        Case cb(9, bowlSide) TO cb(10, bowlSide)
                                            bowler = 10
                                        Case cb(10, bowlSide) TO cb(11, bowlSide)
                                            bowler = 11
                                    End Select
                                    If o(bowler, bowlSide) >= 9 Then GoTo 240
                                    If bowler = lbowler Then GoTo 240
                            End Select
                    End Select

                    pr = r(bowler, bowlSide)
            End Select

            270 Color 11, 0
            Locate 2, 4
            Print team$(batSide)
            Locate 3, 3
            Print truns(batSide); "-"; tWickets(batSide); " ("; tovers(batSide); "."; tBalls(batSide); ")"
            Color 3, 0
            Locate 5, 4
            Print player$(bat1, batSide)
            Locate 5, 20
            Print runs(bat1, batSide)
            Locate 5, 25
            Print "("; balls(bat1, batSide); ")"
            Locate 7, 4
            Print player$(bat2, batSide)
            Locate 7, 20
            Print runs(bat2, batSide)
            Locate 7, 25
            Print "("; balls(bat2, batSide); ")"
            If strike = 1 Then Locate 5, 2 Else Locate 7, 2
            Print "*"
            Color 3, 0
            Locate 10, 4
            Print "Extras: "; extras(batSide); " (w"; wides(batSide); ", nb"; noBalls(batSide); ", b"; byes(batSide); ", lb"; legByes(batSide); ")"
            Locate 10, 55
            Print "Last Delivery:"
            Color 0, 3
            Locate 10, 70
            If overBalls = 0 And tovers(batSide) = 0 Then Print "      mph" Else Print speed(overBalls); "mph"

            Color 3, 0
            For j = 1 To 9
                Locate j, 39
                Print Chr$(179)
            Next j
            For j = 12 To 28
                Locate j, 26
                Print Chr$(179)
            Next j

            For j = 1 To 80
                Locate 9, j
                Print Chr$(196)
                Locate 11, j
                Print Chr$(196)
                Locate 29, j
                Print Chr$(196)
                Locate 44, j
                Print Chr$(196)
            Next j

            Color 11, 0
            Locate 2, 43
            Print team$(bowlSide)
            Color 3, 0
            Locate 5, 41
            Print "*"
            Locate 5, 43
            Print player$(bowler, bowlSide)
            Locate 5, 59
            Print o(bowler, bowlSide); "."; b(bowler, bowlSide); "-"; m(bowler, bowlSide); "-"; r(bowler, bowlSide); "-"; w(bowler, bowlSide)
            Locate 7, 43
            Print player$(lbowler, bowlSide)
            Locate 7, 59
            Print o(lbowler, bowlSide); "."; b(lbowler, bowlSide); "-"; m(lbowler, bowlSide); "-"; r(lbowler, bowlSide); "-"; w(lbowler, bowlSide)

            For i = 1 To 8
                If overBalls < i Then GoTo 140
                Locate 11 + (i * 2), 4
                Color 7, 4
                Print i
                Locate 11 + (i * 2), 10
                Color 3, 0
                Print ball$(i)
            140 Next i

            tb = (tovers(batSide) * 6) + tBalls(batSide)
            If truns(batSide) = 0 Or tb = 0 Then GoTo 230
            runRate = truns(batSide) / tb
            runRate = runRate * 6
            runRate = Int(runRate * 100)
            runRate = runRate / 100

            230 Locate 14, 29
            Print team$(fixture(1, match, week)); "    V    "; team$(fixture(2, match, week))
            Locate 16, 29
            Print "PITCH TYPE: "; pitch$(pitch)
            Locate 18, 29
            Select Case innings
                Case Is = 1
                    Print team$(batSide); " LEAD BY "; truns(batSide); " RUNS"
                Case Else
                    Print team$(batSide); " REQUIRE "; (truns(bowlSide) + 1) - truns(batSide); " MORE RUNS TO WIN"
            End Select

            Locate 20, 29
            Print "CURRENT RUN RATE: "; runRate
            Locate 23, 29
            Select Case strike
                Case Is = 1
                    Print player$(bowler, bowlSide); " ("; bowl$(bowl(bowler, bowlSide)); ") "; Chr$(16); "  "; player$(bat1, batSide); " ("; bat$(bat(bat1, batSide)); ")"
                Case Is = 2
                    Print player$(bowler, bowlSide); " ("; bowl$(bowl(bowler, bowlSide)); ") "; Chr$(16); "  "; player$(bat2, batSide); " ("; bat$(bat(bat2, batSide)); ")"
            End Select
            Locate 25, 29
            Select Case minutes
                Case Is = 0
                    Print "TIME: "; hours; ": 00"
                Case Is = 1
                    Print "TIME: "; hours; ": 01"
                Case Is = 2
                    Print "TIME: "; hours; ": 02"
                Case Is = 3
                    Print "TIME: "; hours; ": 03"
                Case Is = 4
                    Print "TIME: "; hours; ": 04"
                Case Is = 5
                    Print "TIME: "; hours; ": 05"
                Case Is = 6
                    Print "TIME: "; hours; ": 06"
                Case Is = 7
                    Print "TIME: "; hours; ": 07"
                Case Is = 8
                    Print "TIME: "; hours; ": 08"
                Case Is = 9
                    Print "TIME: "; hours; ": 09"
                Case Else
                    Print "TIME: "; hours; ":"; minutes
            End Select

            330 Select Case team
                Case Is = bowlSide
                    Color 11, 0
                    Locate 31, 5
                    Print "Bowler:   "; player$(bowler, bowlSide); " ("; bowl$(bowl(bowler, bowlSide)); ")"
                    Locate 31, 50
                    Color 3, 0
                    Print "Fatigue:"
                    For i = 1 To 10
                        Locate 31, 58 + i
                        If fatigue(bowler, bowlSide) >= i Then Print Chr$(219)
                    Next i
                    Color 11, 0
                    Locate 42, 5
                    Print "Press "; Chr$(34); "C"; Chr$(34); " at the end of any over to change bowler."

                    For i = 1 To 3
                        If i = 3 And tovers(batSide) < 15 Then Color 8, 0 Else Color 3, 0
                        Locate (i * 2 + 32), 5
                        Print field$(i)
                        Locate (i * 2 + 32), 3
                        If ft = i Then Print Chr$(16) Else Print " "
                    Next i

                    Select Case tovers(batSide)
                        Case 0 TO 5
                            If tWickets(batSide) = 0 Then mindset = 2 Else mindset = 1
                        Case 6 TO 10
                            If tWickets(batSide) < 2 Then mindset = 3
                            If tWickets(batSide) = 2 Then mindset = 2
                            If tWickets(batSide) > 2 Then mindset = 1
                        Case 11 TO 16
                            If tWickets(batSide) < 4 Then mindset = 3 Else mindset = 2
                        Case 17 TO 25
                            If tWickets(batSide) < 6 Then mindset = 3 Else mindset = 2
                            If tWickets(batSide) < 3 Then mindset = 4
                            If tWickets(batSide) < 2 Then mindset = 5
                        Case 26 TO 30
                            If tWickets(batSide) < 7 Then mindset = 3 Else mindset = 2
                            If tWickets(batSide) < 4 Then mindset = 4
                            If tWickets(batSide) < 3 Then mindset = 5
                        Case 31 TO 37
                            If tWickets(batSide) < 6 Then mindset = 5 Else mindset = 4
                        Case 38 TO 45
                            mindset = 5
                    End Select

                Case Else
                    Color 11, 0
                    Locate 31, 5
                    Print "Batsmen:   "; player$(bat1, batSide); " ("; bat$(bat(bat1, batSide)); ")   &   "; player$(bat2, batSide); " ("; bat$(bat(bat2, batSide)); ")"
                    Color 3, 0
                    Locate 34, 5
                    Print "Very Defensive"
                    Locate 36, 5
                    Print "Defensive"
                    Locate 38, 5
                    Print "Moderate"
                    Locate 40, 5
                    Print "Aggressive"
                    Locate 42, 5
                    Print "Very Aggressive"
                    For i = 1 To 5
                        Locate 32 + (i * 2), 3
                        If mindset <> i Then Print " " Else Print Chr$(16)
                    Next i
                    Locate 42, 30
                    Color 11, 0
                    Print "Press "; Chr$(34); "C"; Chr$(34); " at any time to change batting order."
            End Select

            Locate 48, 27
            Color 0, 3
            Print "       MAIN MENU       "
            Locate 48, 4
            Color 3, 0
            Print "   BATTING SCORECARD   "
            Locate 48, 50
            Color 3, 0
            Print "    BOWLING FIGURES    "
            Color 0, 3
            Locate 46, 37
            Print Chr$(17); " "; Chr$(16)

            If tovers(batSide) = 45 Then finish = 1
            If tWickets(batSide) = 10 Then finish = 2
            If truns(batSide) > truns(bowlSide) And innings = 2 Then finish = 3
            If finish = 0 Then GoTo 310

            Color 11, 0
            Locate 50, 2
            Select Case innings
                Case Is = 1
                    Print team$(bowlSide); " REQUIRE "; truns(batSide) + 1; " RUNS TO WIN. PRESS SPACE TO GO THE NEXT INNINGS."
                Case Is = 2
                    If truns(batSide) > truns(bowlSide) Then Print team$(batSide); " BEAT "; team$(bowlSide); " BY "; 10 - tWickets(batSide); " WICKETS. PRESS SPACE TO CONTINUE."
                    If truns(batSide) < truns(bowlSide) Then Print team$(bowlSide); " BEAT "; team$(batSide); " BY "; truns(bowlSide) - truns(batSide); " RUNS. PRESS SPACE TO CONTINUE."
                    If truns(batSide) = truns(bowlSide) Then Print team$(batSide); " TIED WITH "; team$(bowlSide); ". PRESS SPACE TO CONTINUE."
            End Select

            310 lastSub = 1
            160 Select Case InKey$
                Case Is = u$
                    If finish > 0 Then GoTo 310
                    If batSide = team Then mindset = mindset - 1 Else ft = ft - 1
                    If tovers(batSide) < 15 And ft < 1 Then ft = 2
                    If tovers(batSide) >= 15 And ft < 1 Then ft = 3
                    If mindset < 1 Then mindset = 5
                    GoTo 330
                Case Is = d$
                    If finish > 0 Then GoTo 310
                    If batSide = team Then mindset = mindset + 1 Else ft = ft + 1
                    If ft = 3 And tovers(batSide) < 15 Then ft = 1
                    If ft > 3 Then ft = 1
                    If mindset > 5 Then mindset = 1
                    GoTo 330
                Case Is = l$
                    Call scorecard
                    GoTo 170
                Case Is = r$
                    Call figures
                    GoTo 170
                Case Is = "C"
                    If finish > 0 Then GoTo 160
                    If bowlSide = team And tBalls(batSide) = 0 And overBalls <> 1 And overBalls <> 2 Then Call changeBowler
                    If batSide = team Then Call batOrder
                    GoTo 270
                Case Is = "c"
                    If finish > 0 Then GoTo 160
                    If bowlSide = team And tBalls(batSide) = 0 And overBalls <> 1 And overBalls <> 2 Then Call changeBowler
                    If batSide = team Then Call batOrder
                    GoTo 270
                Case Is = Chr$(13)
                    If finish > 0 Then GoTo 160
                    If tovers(batSide) >= 50 Then GoTo 290
                    If team = bowlSide And o(bowler, bowlSide) >= 9 Then GoTo 160
                    290
                Case Is = Chr$(32)
                    If finish = 0 Then GoTo 160
                Case Else
                    GoTo 160
            End Select

            If finish > 0 Then GoTo 300
            Rem _________________________________________________________________________

            If tBalls(batSide) <> 0 Then GoTo 200
            If overBalls <= 5 Then GoTo 200
            overBalls = 0
            For j = 1 To 8
                ball$(j) = ""
            Next j
            For j = 1 To 8
                speed(j) = 0
            Next j

            200 totals = 0
            total1 = 100 - eb(bowler, bowlSide)
            If strike = 1 Then total2 = rs(bat1, batSide)
            If strike = 2 Then total2 = rs(bat2, batSide)
            totals = total1 + total2
            totals = Int(totals / 10)

            If strike = 1 Then wtotal1 = 100 - (gb(bat1, batSide))
            If strike = 2 Then wtotal1 = 100 - (gb(bat2, batSide))
            wtotal2 = wt(bowler, bowlSide)
            wtotals = wtotal1 + wtotal2
            chance = Int(83 - (wtotals / 2.5))
            If bowl(bowler, bowlSide) = 1 Or bowl(bowler, bowlSide) = 2 Or bowl(bowler, bowlSide) = 7 Or bowl(bowler, bowlSide) = 8 Then spinner = 1

            If tovers(batSide) < 10 And spinner = 1 Then chance = chance + 2
            Select Case mindset
                Case Is = 1
                    chance = Int(chance * 1.3)
                    totals = totals - 3
                Case Is = 2
                    chance = Int(chance * 1.15)
                    totals = totals - 1
                Case Is = 4
                    chance = Int(chance * .85)
                    totals = totals + 1
                Case Is = 5
                    chance = Int(chance * .7)
                    totals = totals + 3
            End Select

            If fatigue(bowler, bowlSide) < 5 Then chance = chance + (7 - fatigue(bowler, bowlSide))
            aa = 5
            bb = 6
            cc = 7
            dd = 20 + totals
            ee = 22 + totals + totals
            tt = rand(100)

            Select Case rand(chance)
                Case Is = 1
                    tBalls(batSide) = tBalls(batSide) + 1
                    b(bowler, bowlSide) = b(bowler, bowlSide) + 1
                    If strike = 1 Then balls(bat1, batSide) = balls(bat1, batSide) + 1 Else balls(bat2, batSide) = balls(bat2, batSide) + 1
                    tWickets(batSide) = tWickets(batSide) + 1
                    fow(tWickets(batSide), batSide) = truns(batSide)

                    If bowl(bowler, bowlSide) = 1 Or bowl(bowler, bowlSide) = 2 Or bowl(bowler, bowlSide) = 7 Or bowl(bowler, bowlSide) = 8 Then howOut = rand(22) Else howOut = rand(20)
                    Select Case howOut
                        Case Is <= 11
                            If strike = 1 Then howOut1$(bat1, batSide) = "c" Else howOut1$(bat2, batSide) = "c"
                            catch = rand(11)
                            If catch = bowler Then catch = wk(bowlSide)
                            If strike = 1 Then howOut2$(bat1, batSide) = player$(catch, bowlSide) Else howOut2$(bat2, batSide) = player$(catch, bowlSide)
                            If strike = 1 Then howOut3$(bat1, batSide) = "b" Else howOut3$(bat2, batSide) = "b"
                            If strike = 1 Then howOut4$(bat1, batSide) = player$(bowler, bowlSide) Else howOut4$(bat2, batSide) = player$(bowler, bowlSide)
                            ball$(overBalls + 1) = "WICKET - CAUGHT"
                            w(bowler, bowlSide) = w(bowler, bowlSide) + 1
                        Case 12 TO 16
                            If strike = 1 Then howOut3$(bat1, batSide) = "b" Else howOut3$(bat2, batSide) = "b"
                            If strike = 1 Then howOut4$(bat1, batSide) = player$(bowler, bowlSide) Else howOut4$(bat2, batSide) = player$(bowler, bowlSide)
                            ball$(overBalls + 1) = "WICKET - BOWLED"
                            w(bowler, bowlSide) = w(bowler, bowlSide) + 1
                        Case 17 TO 19
                            If strike = 1 Then howOut1$(bat1, batSide) = "lbw" Else howOut1$(bat2, batSide) = "lbw"
                            If strike = 1 Then howOut3$(bat1, batSide) = "b" Else howOut3$(bat2, batSide) = "b"
                            If strike = 1 Then howOut4$(bat1, batSide) = player$(bowler, bowlSide) Else howOut4$(bat2, batSide) = player$(bowler, bowlSide)
                            ball$(overBalls + 1) = "WICKET - LBW"
                            w(bowler, bowlSide) = w(bowler, bowlSide) + 1
                        Case Is = 20
                            If strike = 1 Then howOut1$(bat1, batSide) = "run out" Else howOut1$(bat2, batSide) = "run out"
                            ball$(overBalls + 1) = "WICKET - RUN OUT"
                        Case Else
                            If strike = 1 Then howOut1$(bat1, batSide) = "st" Else howOut1$(bat2, batSide) = "st"
                            If strike = 1 Then howOut2$(bat1, batSide) = player$(wk(bowlSide), bowlSide) Else howOut2$(bat2, batSide) = player$(wk(bowlSide), bowlSide)
                            If strike = 1 Then howOut3$(bat1, batSide) = "b" Else howOut3$(bat2, batSide) = "b"
                            If strike = 1 Then howOut4$(bat1, batSide) = player$(bowler, bowlSide) Else howOut4$(bat2, batSide) = player$(bowler, bowlSide)
                            ball$(overBalls + 1) = "WICKET - STUMPED"
                            w(bowler, bowlSide) = w(bowler, bowlSide) + 1
                    End Select
                    If strike = 1 Then in(bat1, batSide) = 0
                    If strike = 2 Then in(bat2, batSide) = 0
                    If tWickets(batSide) = 10 Then GoTo 320
                    If strike = 1 Then bat1 = tWickets(batSide) + 2 Else bat2 = tWickets(batSide) + 2
                    If strike = 1 And tWickets(batSide) < 10 Then in(bat1, batSide) = 1
                    If strike = 2 And tWickets(batSide) < 10 Then in(bat2, batSide) = 1
                    320 GoTo 150
            End Select

            If overExtras = 2 Then GoTo 190
            extraChance = rand(130)
            Select Case extraChance
                Case Is = 1
                    truns(batSide) = truns(batSide) + 1
                    tBalls(batSide) = tBalls(batSide) + 1
                    b(bowler, bowlSide) = b(bowler, bowlSide) + 1
                    r(bowler, bowlSide) = r(bowler, bowlSide) + 1
                    ball$(overBalls + 1) = "ONE LEG-BYE"
                    If strike = 1 Then balls(bat1, batSide) = balls(bat1, batSide) + 1 Else balls(bat2, batSide) = balls(bat2, batSide) + 1
                    If strike = 1 Then strike = 2 Else strike = 1
                    extras(batSide) = extras(batSide) + 1
                    legByes(batSide) = legByes(batSide) + 1
                Case Is = 2
                    truns(batSide) = truns(batSide) + 1
                    tBalls(batSide) = tBalls(batSide) + 1
                    b(bowler, bowlSide) = b(bowler, bowlSide) + 1
                    ball$(overBalls + 1) = "ONE BYE"
                    If strike = 1 Then balls(bat1, batSide) = balls(bat1, batSide) + 1 Else balls(bat2, batSide) = balls(bat2, batSide) + 1
                    If strike = 1 Then strike = 2 Else strike = 1
                    extras(batSide) = extras(batSide) + 1
                    byes(batSide) = byes(batSide) + 1
                Case Is = 3
                    truns(batSide) = truns(batSide) + 1
                    r(bowler, bowlSide) = r(bowler, bowlSide) + 1
                    ball$(overBalls + 1) = "ONE NO-BALL"
                    If strike = 1 Then balls(bat1, batSide) = balls(bat1, batSide) + 1 Else balls(bat2, batSide) = balls(bat2, batSide) + 1
                    extras(batSide) = extras(batSide) + 1
                    noBalls(batSide) = noBalls(batSide) + 1
                Case Is = 4
                    truns(batSide) = truns(batSide) + 1
                    r(bowler, bowlSide) = r(bowler, bowlSide) + 1
                    ball$(overBalls + 1) = "ONE WIDE"
                    extras(batSide) = extras(batSide) + 1
                    wides(batSide) = wides(batSide) + 1
                Case Is = 5
                    truns(batSide) = truns(batSide) + 1
                    r(bowler, bowlSide) = r(bowler, bowlSide) + 1
                    ball$(overBalls + 1) = "ONE WIDE"
                    extras(batSide) = extras(batSide) + 1
                    wides(batSide) = wides(batSide) + 1
                Case Is = 6
                    truns(batSide) = truns(batSide) + 1
                    r(bowler, bowlSide) = r(bowler, bowlSide) + 1
                    ball$(overBalls + 1) = "ONE WIDE"
                    extras(batSide) = extras(batSide) + 1
                    wides(batSide) = wides(batSide) + 1
            End Select
            If extraChance < 7 Then overExtras = overExtras + 1
            If extraChance < 7 Then GoTo 150

            190 Select Case tt
                Case Is <= aa
                    truns(batSide) = truns(batSide) + 2
                    tBalls(batSide) = tBalls(batSide) + 1
                    b(bowler, bowlSide) = b(bowler, bowlSide) + 1
                    r(bowler, bowlSide) = r(bowler, bowlSide) + 2
                    ball$(overBalls + 1) = "TWO RUNS"
                    If strike = 1 Then runs(bat1, batSide) = runs(bat1, batSide) + 2 Else runs(bat2, batSide) = runs(bat2, batSide) + 2
                    If strike = 1 Then balls(bat1, batSide) = balls(bat1, batSide) + 1 Else balls(bat2, batSide) = balls(bat2, batSide) + 1

                Case Is = bb
                    truns(batSide) = truns(batSide) + 3
                    tBalls(batSide) = tBalls(batSide) + 1
                    b(bowler, bowlSide) = b(bowler, bowlSide) + 1
                    r(bowler, bowlSide) = r(bowler, bowlSide) + 3
                    ball$(overBalls + 1) = "THREE RUNS"
                    If strike = 1 Then runs(bat1, batSide) = runs(bat1, batSide) + 3 Else runs(bat2, batSide) = runs(bat2, batSide) + 3
                    If strike = 1 Then balls(bat1, batSide) = balls(bat1, batSide) + 1 Else balls(bat2, batSide) = balls(bat2, batSide) + 1
                    If strike = 1 Then strike = 2 Else strike = 1

                Case Is = cc
                    truns(batSide) = truns(batSide) + 6
                    tBalls(batSide) = tBalls(batSide) + 1
                    b(bowler, bowlSide) = b(bowler, bowlSide) + 1
                    r(bowler, bowlSide) = r(bowler, bowlSide) + 6
                    ball$(overBalls + 1) = "SIX RUNS"
                    If strike = 1 Then runs(bat1, batSide) = runs(bat1, batSide) + 6 Else runs(bat2, batSide) = runs(bat2, batSide) + 6
                    If strike = 1 Then balls(bat1, batSide) = balls(bat1, batSide) + 1 Else balls(bat2, batSide) = balls(bat2, batSide) + 1

                Case cc + 1 TO dd
                    truns(batSide) = truns(batSide) + 1
                    tBalls(batSide) = tBalls(batSide) + 1
                    b(bowler, bowlSide) = b(bowler, bowlSide) + 1
                    r(bowler, bowlSide) = r(bowler, bowlSide) + 1
                    ball$(overBalls + 1) = "ONE RUN"
                    If strike = 1 Then runs(bat1, batSide) = runs(bat1, batSide) + 1 Else runs(bat2, batSide) = runs(bat2, batSide) + 1
                    If strike = 1 Then balls(bat1, batSide) = balls(bat1, batSide) + 1 Else balls(bat2, batSide) = balls(bat2, batSide) + 1
                    If strike = 1 Then strike = 2 Else strike = 1

                Case dd + 1 TO ee
                    truns(batSide) = truns(batSide) + 4
                    tBalls(batSide) = tBalls(batSide) + 1
                    b(bowler, bowlSide) = b(bowler, bowlSide) + 1
                    r(bowler, bowlSide) = r(bowler, bowlSide) + 4
                    ball$(overBalls + 1) = "FOUR RUNS"
                    If strike = 1 Then runs(bat1, batSide) = runs(bat1, batSide) + 4 Else runs(bat2, batSide) = runs(bat2, batSide) + 4
                    If strike = 1 Then balls(bat1, batSide) = balls(bat1, batSide) + 1 Else balls(bat2, batSide) = balls(bat2, batSide) + 1

                Case Else
                    tBalls(batSide) = tBalls(batSide) + 1
                    b(bowler, bowlSide) = b(bowler, bowlSide) + 1
                    ball$(overBalls + 1) = "NO RUN"
                    If strike = 1 Then balls(bat1, batSide) = balls(bat1, batSide) + 1 Else balls(bat2, batSide) = balls(bat2, batSide) + 1
            End Select

            150 Select Case bowl(bowler, bowlSide)
                Case Is = 1
                    speed(overBalls + 1) = (rand(61) + 479) / 10
                Case Is = 2
                    speed(overBalls + 1) = (rand(61) + 479) / 10
                Case Is = 7
                    speed(overBalls + 1) = (rand(61) + 479) / 10
                Case Is = 8
                    speed(overBalls + 1) = (rand(61) + 479) / 10
                Case Is = 3
                    speed(overBalls + 1) = (rand(61) + 719) / 10
                Case Is = 9
                    speed(overBalls + 1) = (rand(61) + 719) / 10
                Case Is = 4
                    speed(overBalls + 1) = (rand(61) + 769) / 10
                Case Is = 10
                    speed(overBalls + 1) = (rand(61) + 769) / 10
                Case Is = 5
                    speed(overBalls + 1) = (rand(61) + 819) / 10
                Case Is = 11
                    speed(overBalls + 1) = (rand(61) + 819) / 10
                Case Is = 6
                    speed(overBalls + 1) = (rand(61) + 869) / 10
                Case Is = 12
                    speed(overBalls + 1) = (rand(61) + 869) / 10
            End Select

            If o(bowler, bowlSide) = 0 And overBalls = 0 Then bowlers(bowlSide) = bowlers(bowlSide) + 1
            If o(bowler, bowlSide) = 0 And overBalls = 0 Then bowlChange(bowlers(bowlSide), bowlSide) = bowler
            overBalls = overBalls + 1
            delivery = 1
            seconds = seconds + (rand(3) + 32)
            Select Case seconds
                Case Is >= 60
                    minutes = minutes + 1
                    seconds = seconds - 60
            End Select
            Select Case minutes
                Case Is = 60
                    minutes = 0
                    hours = hours + 1
            End Select
        300 Loop Until finish > 0
    Next innings

    momDone = 0
    eomc = 1
    390 Color 11, 0
    Cls
    If momDone = 1 Then GoTo 370
    For i = 1 To 11
        rc = 0
        For j = 1 To 11
            If runs(i, bowlSide) >= runs(j, bowlSide) Then rc = rc + 1
        Next j
        If rc = 11 Then hrs = i
    Next i
    If in(hrs, bowlSide) = 1 Then asterisk$ = "*"

    For i = 1 To 11
        rc = 0
        For j = 1 To 11
            If runs(i, batSide) >= runs(j, batSide) Then rc = rc + 1
        Next j
        If rc = 11 Then hrs2 = i
    Next i
    If in(hrs2, batSide) = 1 Then asterisk2$ = "*"

    If tWickets(bowlSide) = 0 Then GoTo 360
    For i = 1 To 11
        wc = 0
        For j = 1 To 11
            Select Case w(i, batSide)
                Case Is > w(j, batSide)
                    wc = wc + 1
                Case Is = w(j, batSide)
                    If r(i, batSide) <= r(j, batSide) Then wc = wc + 1
            End Select
        Next j
        If wc = 11 Then bbf = i
    Next i


    360 If tWickets(batSide) = 0 Then GoTo 370
    For i = 1 To 11
        wc = 0
        For j = 1 To 11
            Select Case w(i, bowlSide)
                Case Is > w(j, bowlSide)
                    wc = wc + 1
                Case Is = w(j, bowlSide)
                    If r(i, bowlSide) <= r(j, bowlSide) Then wc = wc + 1
            End Select
        Next j
        If wc = 11 Then bbf2 = i
    Next i
    370 momDone = 1


    Color 11, 0
    Locate 5, 3
    Print team$(bowlSide)
    Locate 5, 17
    Print " "
    Locate 5, 18
    If tWickets(bowlSide) = 10 Then Print truns(bowlSide) Else Print truns(bowlSide); "-"; tWickets(bowlSide)
    Color 3, 0
    Locate 5, 36
    Print player$(hrs, bowlSide); runs(hrs, bowlSide); asterisk$
    Locate 5, 58
    If bbf = 0 Then Print "" Else Print player$(bbf, batSide); w(bbf, batSide); "-"; r(bbf, batSide)

    Color 11, 0
    Locate 7, 3
    Print team$(batSide)
    Locate 7, 17
    Print " "
    Locate 7, 18
    If tWickets(batSide) = 10 Then Print truns(batSide) Else Print truns(batSide); "-"; tWickets(batSide)
    Color 3, 0
    Locate 7, 36
    Print player$(hrs2, batSide); runs(hrs2, batSide); asterisk2$
    Locate 7, 58
    If bbf2 = 0 Then Print "" Else Print player$(bbf2, bowlSide); w(bbf2, bowlSide); "-"; r(bbf2, bowlSide)

    Color 11, 0
    Locate 10, 3
    Select Case truns(batSide)
        Case Is > truns(bowlSide)
            If tWickets(batSide) = 9 Then Print team$(batSide); " BEAT "; team$(bowlSide); " BY 1 WICKET" Else Print team$(batSide); " BEAT "; team$(bowlSide); " BY "; 10 - tWickets(batSide); " WICKETS"
            winners = 1
        Case Is = truns(bowlSide)
            Print team$(batSide); " TIED WITH "; team$(bowlSide)
            winners = 1
        Case Is < truns(bowlSide)
            Print team$(bowlSide); " BEAT "; team$(batSide); " BY "; truns(bowlSide) - truns(batSide); " RUNS"
            winners = 2
    End Select

    Locate 26, 3
    If eomc = 1 Then Color 0, 3 Else Color 3, 0
    Print "VIEW "; team$(bowlSide); " BATTING SCORECARD"
    Locate 28, 3
    If eomc = 2 Then Color 0, 3 Else Color 3, 0
    Print "VIEW "; team$(batSide); " BOWLING FIGURES"
    Locate 30, 3
    If eomc = 3 Then Color 0, 3 Else Color 3, 0
    Print "VIEW "; team$(bowlSide); " MANHATTAN GRAPH"
    Locate 34, 3
    If eomc = 4 Then Color 0, 3 Else Color 3, 0
    Print "VIEW "; team$(batSide); " BATTING SCORECARD"
    Locate 36, 3
    If eomc = 5 Then Color 0, 3 Else Color 3, 0
    Print "VIEW "; team$(bowlSide); " BOWLING FIGURES"
    Locate 38, 3
    If eomc = 6 Then Color 0, 3 Else Color 3, 0
    Print "VIEW "; team$(batSide); " MANHATTAN GRAPH"
    Locate 42, 3
    If eomc = 7 Then Color 0, 3 Else Color 3, 0
    Print "VIEW ALL NATIONAL LEAGUE RESULTS"

    380 Select Case InKey$
        Case Is = u$
            eomc = eomc - 1
            If eomc < 1 Then eomc = 7
            GoTo 390
        Case Is = d$
            eomc = eomc + 1
            If eomc > 7 Then eomc = 1
            GoTo 390
        Case Is = Chr$(13)
        Case Else
            GoTo 380
    End Select
    Select Case eomc
        Case Is = 1
            battingSide = bowlSide
            Call scorecard2
            GoTo 390
        Case Is = 2
            bowlingSide = batSide
            battingSide = bowlSide
            Call figures2
            GoTo 390
        Case Is = 3
            battingSide = 1
            Call manhattan
            GoTo 390
        Case Is = 4
            battingSide = batSide
            Call scorecard2
            GoTo 390
        Case Is = 5
            bowlingSide = bowlSide
            battingSide = batSide
            Call figures2
            GoTo 390
        Case Is = 6
            battingSide = 2
            Call manhattan
            GoTo 390
        Case Else
    End Select

    For i = 1 To 11
        sm(i) = sm(i) + 1
        sRuns(i) = sRuns(i) + runs(i, team)
        If in(i, team) < 2 Then sInnings(i) = sInnings(i) + 1
        If in(i, team) = 0 Then sOuts(i) = sOuts(i) + 1
        If runs(i, team) > hs(i) Then hs(i) = runs(i, team)
        sBalls(i) = sBalls(i) + balls(i, team)

        If b(i, team) = 0 Then sOvers(i) = sOvers(i) + o(i, team) Else sOvers(i) = sOvers(i) + (o(i, team) + 1)
        sWickets(i) = sWickets(i) + w(i, team)
        sConceded(i) = sConceded(i) + r(i, team)
        Select Case w(i, team)
            Case Is > bbw(i)
                bbw(i) = w(i, team)
                bbr(i) = r(i, team)
            Case Is = bbw(i)
                If runs(i, team) < bbr(i) Then bbw(i) = w(i, team)
                If runs(i, team) < bbr(i) Then bbr(i) = r(i, team)
        End Select
    Next i

    Select Case truns(team)
        Case Is > truns(opponents)
            fansRating = fansRating + 8
            directorsRating = directorsRating + 4
        Case Is = truns(opponents)
            fansRating = fansRating + 5
            directorsRating = directorsRating + 1
        Case Else
            fansRating = fansRating - 8
            directorsRating = directorsRating - 4
    End Select

    420 Call matchSimulator
End Sub

Sub matchSimulator
    Color 11, 0
    Cls
    Locate 2, 3
    Print "WEEK "; week; " NATIONAL LEAGUE RESULTS"
    For mn = 1 To 9
        Color 3, 0
        myTeam = 0
        If fixture(1, mn, week) = team Or fixture(2, mn, week) = team Then myTeam = 1
        Select Case myTeam
            Case Is = 1
                Color 11, 0
                Locate (mn * 2 + 8), 3
                If truns(batSide) > truns(bowlSide) Then Print team$(batSide); " BEAT "; team$(bowlSide); " BY "; 10 - tWickets(batSide); " WICKETS"
                If truns(batSide) = truns(bowlSide) Then Print team$(batSide); " TIED WITH "; team$(bowlSide)
                If truns(bowlSide) > truns(batSide) Then Print team$(bowlSide); " BEAT "; team$(batSide); " BY "; truns(bowlSide) - truns(batSide); " RUNS"

                played(batSide) = played(batSide) + 1
                played(bowlSide) = played(bowlSide) + 1
                Select Case truns(batSide)
                    Case Is > truns(bowlSide)
                        points(batSide) = points(batSide) + 4
                        wins(batSide) = wins(batSide) + 1
                        losses(bowlSide) = losses(bowlSide) + 1
                    Case Is = truns(bowlSide)
                        points(batSide) = points(batSide) + 2
                        points(bowlSide) = points(bowlSide) + 2
                        ties(batSide) = ties(batSide) + 1
                        ties(bowlSide) = ties(bowlSide) + 1
                    Case Else
                        points(bowlSide) = points(bowlSide) + 4
                        wins(bowlSide) = wins(bowlSide) + 1
                        losses(batSide) = losses(batSide) + 1
                End Select
                GoTo 430
        End Select

        team2 = fixture(1, mn, week)
        opponents2 = fixture(2, mn, week)

        totalRating = rating(team2) + rating(opponents2)
        rtr = rand(totalRating)
        Select Case rtr
            Case Is <= rating(team2)
                winners = team2
                losers = opponents2
            Case Else
                winners = opponents2
                losers = team2
        End Select

        fb = rand(2)
        Select Case fb
            Case Is = 1
                margain = rand(10)
                Locate (mn * 2 + 8), 3
                If margain = 1 Then Print team$(winners); " BEAT "; team$(losers); " BY 1 WICKET" Else Print team$(winners); " BEAT "; team$(losers); " BY "; margain; " WICKETS"
            Case Is = 2
                margain = rand(100) + 1
                Locate (mn * 2 + 8), 3
                Print team$(winners); " BEAT "; team$(losers); " BY "; margain; " RUNS"
        End Select

        wins(winners) = wins(winners) + 1
        losses(losers) = losses(losers) + 1
        played(winners) = played(winners) + 1
        played(losers) = played(losers) + 1
        points(winners) = points(winners) + 4
    430 Next mn
    Do
    Loop Until InKey$ = Chr$(13)
End Sub

Sub playerSalary
    2900 pco = 1
    2400 Color 11, 0
    Cls
    Locate 2, 5
    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year
    Locate 6, 5
    Print "FINANCE - PLAYER SALARIES"

    For i = 1 To 18
        If pco = i Then Color 0, 3 Else Color 3, 0
        Locate (i * 2 + 8), 5
        Print player$(i, team)
    Next i
    If pco = 19 Then Color 0, 3 Else Color 3, 0
    Locate 46, 5
    Print "Go Back to Finance Menu"

    2300 Select Case InKey$
        Case Is = u$
            pco = pco - 1
            If pco < 1 Then pco = 19
            GoTo 2400
        Case Is = d$
            pco = pco + 1
            If pco > 19 Then pco = 1
            GoTo 2400
        Case Is = Chr$(13)
        Case Else
            GoTo 2300
    End Select
    If pco = 19 Then GoTo 2500

    2700 Color 11, 0
    Cls
    Locate 2, 5
    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year
    Locate 6, 5
    Print "FINANCE - PLAYER SALARIES"
    Locate 10, 5
    Print player$(pco, team)
    Locate 12, 5
    Print "Weekly wage: "; salary(pco, team); " pounds "; Chr$(17); " "; Chr$(16)
    Locate 20, 5
    Print "Press RETURN to go back to the Player Salaries Menu"

    2600 Select Case InKey$
        Case Is = r$
            salary(pco, team) = salary(pco, team) + 100
            If salary(pco, team) <= 6000 Then morale(pco) = morale(pco) + rand(2)
            If salary(pco, team) > 6000 Then salary(pco, team) = 6000
            GoTo 2700
        Case Is = l$
            salary(pco, team) = salary(pco, team) - 100
            If salary(pco, team) >= 1000 Then morale(pco) = morale(pco) - rand(2)
            If salary(pco, team) < 1000 Then salary(pco, team) = 1000
            GoTo 2700
        Case Is = Chr$(13)
            GoTo 2800
        Case Else
            GoTo 2600
    End Select
    2800 GoTo 2900
2500 End Sub

Function rand (c)
    Randomize Timer
    rand = Int(c * Rnd(1)) + 1
End Function

Sub saveGame
    Color 11, 0
    Cls
    Locate 2, 5
    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year
    oss = 1

    960 For i = 1 To 5
        If oss = i Then Color 0, 3 Else Color 3, 0
        Locate (i * 2 + 6), 5
        Print "SAVE GAME TO FILE "; i
    Next i
    If oss = 6 Then Color 0, 3 Else Color 3, 0
    Locate 18, 5
    Print "GO BACK TO OPTIONS"

    950 Select Case InKey$
        Case Is = u$
            oss = oss - 1
            If oss < 1 Then oss = 6
            GoTo 960
        Case Is = d$
            oss = oss + 1
            If oss > 6 Then oss = 1
            GoTo 960
        Case Is = Chr$(13)
        Case Else
            GoTo 950
    End Select

    Select Case oss
        Case Is = 6
        Case Else
            If oss = 1 Then fi$ = "file1.txt"
            If oss = 2 Then fi$ = "file2.txt"
            If oss = 3 Then fi$ = "file3.txt"
            If oss = 4 Then fi$ = "file4.txt"
            If oss = 5 Then fi$ = "file5.txt"

            Open fi$ For Output As #1
            Print #1, team
            Print #1, name$
            Print #1, week
            Print #1, year
            Print #1, fansRating
            Print #1, directorsRating
            For i = 1 To 18
                Print #1, sm(i)
                Print #1, sInnings(i)
                Print #1, sRuns(i)
                Print #1, sOuts(i)
                Print #1, hs(i)
                Print #1, sBalls(i)
                Print #1, sOvers(i)
                Print #1, sWickets(i)
                Print #1, sConceded(i)
                Print #1, bbw(i)
                Print #1, bbr(i)
                Print #1, iWeeks(i)
                Print #1, duty(i)
                Print #1, morale(i)
            Next i
            For i = 1 To 19
                Print #1, team$(i)
                Print #1, rating(i)
                Print #1, shirt1(i)
                Print #1, shirt2(i)
                Print #1, trousers1(i)
                Print #1, trousers2(i)
                Print #1, cs(i)
                Print #1, wk(i)
                Print #1, cp(i)
                Print #1, ob1(i)
                Print #1, ob2(i)
                Print #1, overSeas1(i)
                Print #1, overSeas2(i)
                For j = 1 To 18
                    Print #1, player$(j, i)
                    Print #1, gb(j, i)
                    Print #1, rs(j, i)
                    Print #1, wt(j, i)
                    Print #1, eb(j, i)
                    Print #1, ba(j, i)
                    Print #1, fa(j, i)
                    Print #1, bat(j, i)
                    Print #1, bowl(j, i)
                    Print #1, wicketKeeper(j, i)
                    Print #1, peak(j, i)
                    Print #1, international(j, i)
                    Print #1, salary(j, i)
                Next j
                Print #1, points(i)
                Print #1, wins(i)
                Print #1, ties(i)
                Print #1, losses(i)
                Print #1, played(i)
            Next i
            Close
            Color 11, 0
            Cls
            Locate 20, 20
            Print "GAME SAVED SUCCESFULLY TO FILE "; oss
            Do
            Loop Until InKey$ = Chr$(13)
    End Select
End Sub

Sub scorecard
    Color 11, 0
    Cls
    Locate 2, 4
    Print team$(batSide)

    For i = 1 To 11
        Select Case in(i, batSide)
            Case Is = 1
                howOut1$(i, batSide) = "not out"
                Color 11, 0
            Case Else
                If howOut1$(i, batSide) = "not out" Then howOut1$(i, batSide) = ""
                Color 3, 0
        End Select

        Locate 2 + (i * 2), 4
        Print player$(i, batSide)
        Locate 2 + (i * 2), 23
        Print howOut1$(i, batSide)
        Locate 2 + (i * 2), 26
        Print howOut2$(i, batSide)
        Locate 2 + (i * 2), 44
        Print howOut3$(i, batSide)
        Locate 2 + (i * 2), 47
        Print howOut4$(i, batSide)
        Locate 2 + (i * 2), 67
        Print runs(i, batSide)
        Locate 2 + (i * 2), 72
        Print "("; balls(i, batSide); ")"
    Next i

    Color 11, 0
    Locate 27, 4
    Print "Extras: "; extras(batSide); " (w"; wides(batSide); ", nb"; noBalls(batSide); ", b"; byes(batSide); ", lb"; legByes(batSide); ")"
    Locate 30, 4
    Print "Total, after "; tovers(batSide); "."; tBalls(batSide); " overs,"
    Locate 30, 67
    Print truns(batSide); "-"; tWickets(batSide)

    Locate 48, 27
    Color 3, 0
    Print "       MAIN MENU       "
    Locate 48, 4
    Color 0, 3
    Print "   BATTING SCORECARD   "
    Locate 48, 50
    Color 3, 0
    Print "    BOWLING FIGURES    "
    Color 0, 3
    Locate 46, 37
    Print Chr$(17); " "; Chr$(16)

    180 Select Case InKey$
        Case Is = r$
        Case Else
            GoTo 180
    End Select
End Sub

Sub scorecard2
    Color 11, 0
    Cls
    Locate 2, 4
    Print team$(battingSide)

    For i = 1 To 11
        Select Case in(i, battingSide)
            Case Is = 1
                howOut1$(i, battingSide) = "not out"
                Color 11, 0
            Case Else
                If howOut1$(i, battingSide) = "not out" Then howOut1$(i, battingSide) = ""
                Color 3, 0
        End Select

        Locate 2 + (i * 2), 4
        Print player$(i, battingSide)
        Locate 2 + (i * 2), 23
        Print howOut1$(i, battingSide)
        Locate 2 + (i * 2), 26
        Print howOut2$(i, battingSide)
        Locate 2 + (i * 2), 44
        Print howOut3$(i, battingSide)
        Locate 2 + (i * 2), 47
        Print howOut4$(i, battingSide)
        Locate 2 + (i * 2), 67
        Print runs(i, battingSide)
        Locate 2 + (i * 2), 72
        Print "("; balls(i, battingSide); ")"
    Next i

    Color 11, 0
    Locate 27, 4
    Print "Extras: "; extras(battingSide); " (w"; wides(battingSide); ", nb"; noBalls(battingSide); ", b"; byes(battingSide); ", lb"; legByes(battingSide); ")"
    Locate 30, 4
    Print "Total, after "; tovers(battingSide); "."; tBalls(battingSide); " overs,"
    Locate 30, 67
    Print truns(battingSide); "-"; tWickets(battingSide)

    Do
    Loop Until InKey$ = Chr$(13)
End Sub

Sub statistics
    Color 11, 0
    Cls
    Locate 2, 5
    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year

    For i = 1 To 18
        batAve(i) = 0
        bowlAve(i) = 0
        strRte(i) = 0
        ecnRte(i) = 0
        If sRuns(i) = 0 Or sOuts(i) = 0 Then GoTo 700
        batAve(i) = Int(sRuns(i) / sOuts(i) * 10) / 10
        700 If sConceded(i) = 0 Or sWickets(i) = 0 Then GoTo 710
        bowlAve(i) = Int(sConceded(i) / sWickets(i) * 10) / 10
        710 If sRuns(i) = 0 Or sBalls(i) = 0 Then GoTo 720
        strRte(i) = Int(sRuns(i) / sBalls(i) * 1000) / 10
        720 If sConceded(i) = 0 Or sOvers(i) = 0 Then GoTo 730
        ecnRte(i) = Int(sConceded(i) / sOvers(i) * 10) / 10
    730 Next i

    Color 11, 0
    Locate 8, 5
    Print "Name"
    Locate 8, 23
    Print " Mtc"
    Locate 8, 28
    Print "Inn"
    Locate 8, 32
    Print "Run"
    Locate 8, 36
    Print "HSc"
    Locate 8, 40
    Print "StrRt"
    Locate 8, 47
    Print "BatAv"
    Locate 8, 54
    Print "Wkt"
    Locate 8, 58
    Print "BBF"
    Locate 8, 66
    Print "EcnRt"
    Locate 8, 73
    Print "BwlAv"

    For i = 1 To 18
        If i = 1 Or i = 3 Or i = 5 Or i = 7 Or i = 9 Or i = 11 Or i = 13 Or i = 15 Or i = 17 Then Color 3, 0 Else Color 9, 0
        Locate (i * 2 + 8), 5
        Print player$(i, team)
        Locate (i * 2 + 8), 23
        Print sm(i)
        Locate (i * 2 + 8), 27
        Print sInnings(i)
        Locate (i * 2 + 8), 31
        Print sRuns(i)
        Locate (i * 2 + 8), 35
        Print hs(i)
        Locate (i * 2 + 8), 39
        Print strRte(i)
        Locate (i * 2 + 8), 46
        Print batAve(i)
        Locate (i * 2 + 8), 53
        Print sWickets(i)
        Locate (i * 2 + 8), 57
        Print bbw(i)
        Locate (i * 2 + 8), 60
        Print "-"
        Locate (i * 2 + 8), 61
        Print bbr(i)
        Locate (i * 2 + 8), 65
        Print ecnRte(i)
        Locate (i * 2 + 8), 72
        Print bowlAve(i)
    Next i

    Do
    Loop Until InKey$ = Chr$(13)
End Sub

Sub teamSheet
    480 dd = 0
    ps = 1
    ac = 1
    so = 1

    tos = 1
    50 Color 11, 0
    Cls
    350 Color 11, 0
    If dd = 0 Then GoTo 10000
    For i = 1 To 18
        Locate i + 12, 1
        If i <> ps Then Print " " Else Print Chr$(16)
    Next i

    10000 Locate 2, 3
    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year
    Color 11, 0
    Locate 10, 3
    Print "NO"
    Locate 10, 6
    Print "NAME"
    Locate 10, 22
    Print "RLE"
    Locate 10, 27
    Print "BAT"
    Locate 10, 32
    Print "BWL"
    Locate 10, 36
    Print "ABILITY"
    Locate 7, 3
    Print Chr$(29); " ABILITY ATTRIBUTE: "; attribute$(ac); " "; Chr$(17); " "; Chr$(16)

    For i = 1 To 18
        Select Case ac
            Case Is = 1
                attribute = gb(i, team)
            Case Is = 2
                attribute = rs(i, team)
            Case Is = 3
                attribute = wt(i, team)
            Case Is = 4
                attribute = eb(i, team)
            Case Is = 5
                attribute = fa(i, team)
            Case Is = 6
                attribute = morale(i)
        End Select

        Color 7, 4
        Locate i + 12, 3
        If duty(i) > 0 Then Print "I"
        If duty(i) > 0 Then GoTo 5000
        Color 4, 7
        Locate i + 12, 3
        If iWeeks(i) > 0 Then Print "+"
        5000 If i = 1 Or i = 3 Or i = 5 Or i = 7 Or i = 9 Or i = 11 Then Color 3, 0
        If i = 2 Or i = 4 Or i = 6 Or i = 8 Or i = 10 Then Color 9, 0
        If i = 12 Or i = 14 Or i = 16 Or i = 18 Then Color 10, 0
        If i = 13 Or i = 15 Or i = 17 Then Color 2, 0
        If iWeeks(i) > 0 Then GoTo 3100
        If duty(i) > 0 Then GoTo 3100
        Locate i + 12, 2
        If i < 12 Then Print i
        Locate i + 12, 3
        If i > 11 Then Print "R"
        3100 Locate i + 12, 6
        Print player$(i, team)
        If ob1(team) = i Or ob2(team) = i Or wk(team) = i Then Locate i + 12, 24 Else Locate i + 12, 23
        Color 7, 1
        If cp(team) = i Then Print "C"
        Locate i + 12, 23
        Color 7, 4
        If ob1(team) = i Then Print "1"
        If ob2(team) = i Then Print "2"
        Color 7, 6
        If wk(team) = i Then Print "W"
        If i = 1 Or i = 3 Or i = 5 Or i = 7 Or i = 9 Or i = 11 Then Color 3, 0
        If i = 2 Or i = 4 Or i = 6 Or i = 8 Or i = 10 Then Color 9, 0
        If i = 12 Or i = 14 Or i = 16 Or i = 18 Then Color 10, 0
        If i = 13 Or i = 15 Or i = 17 Then Color 2, 0
        Locate i + 12, 27
        Print bat$(bat(i, team))
        Locate i + 12, 32
        Print bowl$(bowl(i, team))

        Locate i + 12, 36
        Print Chr$(219)
        l = 36
        u = 0
        For j = 10 To 95
            u = u + 1
            If u = 3 Then u = 1
            If u = 1 Then l = l + 1
            Locate i + 12, l
            Select Case u
                Case Is = 1
                    If attribute >= j Then Print Chr$(221) Else Print " "
                Case Is = 2
                    If attribute >= j Then Print Chr$(219) Else Print " "
            End Select
        Next j
    Next i

    Locate 34, 3
    If tos = 1 Then Color 0, 3 Else Color 3, 0
    Print "Swap Players"
    Locate 36, 3
    If tos = 2 Then Color 0, 3 Else Color 3, 0
    Print "Change Captain"
    Locate 38, 3
    If tos = 3 Then Color 0, 3 Else Color 3, 0
    Print "Change Wicketkeeper"
    Locate 40, 3
    If tos = 4 Then Color 0, 3 Else Color 3, 0
    Print "Change Opening Bowler 1"
    Locate 42, 3
    If tos = 5 Then Color 0, 3 Else Color 3, 0
    Print "Change Opening Bowler 2"
    Locate 44, 3
    If tos = 6 Then Color 0, 3 Else Color 3, 0
    Print "Back to Main Menu"

    60 Select Case InKey$
        Case Is = r$
            ac = ac + 1
            If ac > 6 Then ac = 1
            GoTo 350
        Case Is = l$
            ac = ac - 1
            If ac < 1 Then ac = 6
            GoTo 350
        Case Is = u$
            If dd = 0 Then tos = tos - 1 Else ps = ps - 1
            If tos < 1 Then tos = 6
            If ps < 1 Then ps = 18
            GoTo 350
        Case Is = d$
            If dd = 0 Then tos = tos + 1 Else ps = ps + 1
            If tos > 6 Then tos = 1
            If ps > 18 Then ps = 1
            GoTo 350
        Case Is = Chr$(13)
            Select Case dd
                Case Is = 0
                    dd = 1
                    If tos = 6 Then GoTo 450
                    GoTo 50
                Case Is = 1
                    If tos = 1 Then GoTo 2070
                    If tos = 1 Then dd = 0
                    If tos = 2 And ps < 12 Then cp(team) = ps
                    If tos = 2 And ps < 12 Then dd = 0
                    If tos = 3 And ps < 12 And ob1(team) <> ps And ob2(team) <> ps Then wk(team) = ps
                    If tos = 3 And ps < 12 And ob1(team) <> ps And ob2(team) <> ps Then dd = 0
                    If tos = 4 And ps < 12 And ob2(team) <> ps And wk(team) <> ps And bowl(ps, team) <> 13 Then ob1(team) = ps
                    If tos = 4 And ps < 12 And ob2(team) <> ps And wk(team) <> ps And bowl(ps, team) <> 13 Then dd = 0
                    If tos = 5 And ps < 12 And wk(team) <> ps And ob1(team) <> ps And bowl(ps, team) <> 13 Then ob2(team) = ps
                    If tos = 5 And ps < 12 And wk(team) <> ps And ob1(team) <> ps And bowl(ps, team) <> 13 Then dd = 0
                    If dd = 0 Then ps = 1
                    GoTo 50
            End Select
        Case Else
            GoTo 60
    End Select

    2070 ps2 = 1
    dd = 1
    Color 3, 0
    Cls
    2050 For i = 1 To 18
        Color 3, 0
        Locate i + 12, 1
        If i = ps2 Then Print Chr$(16)
        Color 11, 0
        Locate i + 12, 1
        If i = ps Then Print Chr$(16)
        Locate i + 12, 1
        If i <> ps And i <> ps2 Then Print " "
    Next i

    Locate 2, 3
    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year
    Color 11, 0
    Locate 10, 3
    Print "NO"
    Locate 10, 6
    Print "NAME"
    Locate 10, 22
    Print "RLE"
    Locate 10, 27
    Print "BAT"
    Locate 10, 32
    Print "BWL"
    Locate 10, 36
    Print "ABILITY"
    Locate 7, 3
    Print Chr$(29); " ABILITY ATTRIBUTE: "; attribute$(ac); " "; Chr$(17); " "; Chr$(16)

    For i = 1 To 18
        Select Case ac
            Case Is = 1
                attribute = gb(i, team)
            Case Is = 2
                attribute = rs(i, team)
            Case Is = 3
                attribute = wt(i, team)
            Case Is = 4
                attribute = eb(i, team)
            Case Is = 5
                attribute = fa(i, team)
            Case Is = 6
                attribute = morale(i)
        End Select

        Color 7, 4
        Locate i + 12, 3
        If duty(i) > 0 Then Print "I"
        If duty(i) > 0 Then GoTo 5100
        Color 4, 7
        Locate i + 12, 3
        If iWeeks(i) > 0 Then Print "+"
        5100 If i = 1 Or i = 3 Or i = 5 Or i = 7 Or i = 9 Or i = 11 Then Color 3, 0
        If i = 2 Or i = 4 Or i = 6 Or i = 8 Or i = 10 Then Color 9, 0
        If i = 12 Or i = 14 Or i = 16 Or i = 18 Then Color 10, 0
        If i = 13 Or i = 15 Or i = 17 Then Color 2, 0
        If iWeeks(i) > 0 Then GoTo 3200
        If duty(i) > 0 Then GoTo 3200
        Locate i + 12, 2
        If i < 12 Then Print i
        Locate i + 12, 3
        If i > 11 Then Print "R"
        3200 Locate i + 12, 6
        Print player$(i, team)
        If ob1(team) = i Or ob2(team) = i Or wk(team) = i Then Locate i + 12, 24 Else Locate i + 12, 23
        Color 7, 1
        If cp(team) = i Then Print "C"
        Locate i + 12, 23
        Color 7, 4
        If ob1(team) = i Then Print "1"
        If ob2(team) = i Then Print "2"
        Color 7, 6
        If wk(team) = i Then Print "W"
        If i = 1 Or i = 3 Or i = 5 Or i = 7 Or i = 9 Or i = 11 Then Color 3, 0
        If i = 2 Or i = 4 Or i = 6 Or i = 8 Or i = 10 Then Color 9, 0
        If i = 12 Or i = 14 Or i = 16 Or i = 18 Then Color 10, 0
        If i = 13 Or i = 15 Or i = 17 Then Color 2, 0
        Locate i + 12, 27
        Print bat$(bat(i, team))
        Locate i + 12, 32
        Print bowl$(bowl(i, team))

        Locate i + 12, 36
        Print Chr$(219)
        l = 36
        u = 0
        For j = 10 To 95
            u = u + 1
            If u = 3 Then u = 1
            If u = 1 Then l = l + 1
            Locate i + 12, l
            Select Case u
                Case Is = 1
                    If attribute >= j Then Print Chr$(221) Else Print " "
                Case Is = 2
                    If attribute >= j Then Print Chr$(219) Else Print " "
            End Select
        Next j
    Next i

    Locate 34, 3
    If tos = 1 Then Color 0, 3 Else Color 3, 0
    Print "Swap Players"
    Locate 36, 3
    If tos = 2 Then Color 0, 3 Else Color 3, 0
    Print "Change Captain"
    Locate 38, 3
    If tos = 3 Then Color 0, 3 Else Color 3, 0
    Print "Change Wicketkeeper"
    Locate 40, 3
    If tos = 4 Then Color 0, 3 Else Color 3, 0
    Print "Change Opening Bowler 1"
    Locate 42, 3
    If tos = 5 Then Color 0, 3 Else Color 3, 0
    Print "Change Opening Bowler 2"
    Locate 44, 3
    If tos = 6 Then Color 0, 3 Else Color 3, 0
    Print "Back to Main Menu"

    2060 dd = 1
    Select Case InKey$
        Case Is = r$
            ac = ac + 1
            If ac > 6 Then ac = 1
            GoTo 2050
        Case Is = l$
            ac = ac - 1
            If ac < 1 Then ac = 6
            GoTo 2050
        Case Is = u$
            If dd = 0 Then tos = tos - 1 Else ps2 = ps2 - 1
            If tos < 1 Then tos = 6
            If ps2 < 1 Then ps2 = 18
            GoTo 2050
        Case Is = d$
            If dd = 0 Then tos = tos + 1 Else ps2 = ps2 + 1
            If tos > 6 Then tos = 1
            If ps2 > 18 Then ps2 = 1
            GoTo 2050
        Case Is = Chr$(13)
            Select Case dd
                Case Is = 0
                    dd = 1
                    GoTo 2050
                Case Is = 1
                    If tos = 1 Then GoTo 4600
                    If tos = 1 Then dd = 0
                    If tos = 2 And ps2 < 12 Then cp(team) = ps2
                    If tos = 2 And ps2 < 12 Then dd = 0
                    If tos = 3 And ps2 < 12 And ob1(team) <> ps2 And ob2(team) <> ps2 Then wk(team) = ps2
                    If tos = 3 And ps2 < 12 And ob1(team) <> ps2 And ob2(team) <> ps2 Then dd = 0
                    If tos = 4 And ps2 < 12 And ob2(team) <> ps2 And wk(team) <> ps2 Then ob1(team) = ps2
                    If tos = 4 And ps2 < 12 And ob2(team) <> ps2 And wk(team) <> ps2 Then dd = 0
                    If tos = 5 And ps2 < 12 And wk(team) <> ps2 And ob1(team) <> ps2 Then ob2(team) = ps2
                    If tos = 5 And ps2 < 12 And wk(team) <> ps2 And ob1(team) <> ps2 Then dd = 0
                    If dd = 0 Then ps2 = 1
                    GoTo 2050
            End Select
        Case Else
            GoTo 2060
    End Select


    4600 player2$ = player$(ps2, team)
    gb2 = gb(ps2, team)
    rs2 = rs(ps2, team)
    eb2 = eb(ps2, team)
    wt2 = wt(ps2, team)
    ba2 = ba(ps2, team)
    fa2 = fa(ps2, team)
    bat2 = bat(ps2, team)
    bowl2 = bowl(ps2, team)
    wicketKeeper2 = wicketKeeper(ps2, team)
    international2 = international(ps2, team)
    salary2 = salary(ps2, team)
    peak2 = peak(ps2, team)
    sm2 = sm(ps2)
    sInnings2 = sInnings(ps2)
    sRuns2 = sRuns(ps2)
    sOuts2 = sOuts(ps2)
    hs2 = hs(ps2)
    sBalls2 = sBalls(ps2)
    sWickets2 = sWickets(ps2)
    bbw2 = bbw(ps2)
    bbr2 = bbr(ps2)
    sOvers2 = sOvers(ps2)
    sConceded2 = sConceded(ps2)
    morale2 = morale(ps2)
    iWeeks2 = iWeeks(ps2)
    duty2 = duty(ps2)

    player$(ps2, team) = player$(ps, team)
    gb(ps2, team) = gb(ps, team)
    rs(ps2, team) = rs(ps, team)
    eb(ps2, team) = eb(ps, team)
    wt(ps2, team) = wt(ps, team)
    ba(ps2, team) = ba(ps, team)
    fa(ps2, team) = fa(ps, team)
    bat(ps2, team) = bat(ps, team)
    bowl(ps2, team) = bowl(ps, team)
    wicketKeeper(ps2, team) = wicketKeeper(ps, team)
    international(ps2, team) = international(ps, team)
    salary(ps2, team) = salary(ps, team)
    peak(ps2, team) = peak(ps, team)
    sm(ps2) = sm(ps)
    sInnings(ps2) = sInnings(ps)
    sRuns(ps2) = sRuns(ps)
    sOuts(ps2) = sOuts(ps)
    hs(ps2) = hs(ps)
    sBalls(ps2) = sBalls(ps)
    sWickets(ps2) = sWickets(ps)
    bbw(ps2) = bbw(ps)
    bbr(ps2) = bbr(ps)
    sOvers(ps2) = sOvers(ps)
    sConceded(ps2) = sConceded(ps)
    morale(ps2) = morale(ps)
    iWeeks(ps2) = iWeeks(ps)
    duty(ps2) = duty(ps)

    player$(ps, team) = player2$
    gb(ps, team) = gb2
    rs(ps, team) = rs2
    eb(ps, team) = eb2
    wt(ps, team) = wt2
    ba(ps, team) = ba2
    fa(ps, team) = fa2
    bat(ps, team) = bat2
    bowl(ps, team) = bowl2
    wicketKeeper(ps, team) = wicketKeeper2
    international(ps, team) = international2
    salary(ps, team) = salary2
    peak(ps, team) = peak2
    sm(ps) = sm2
    sInnings(ps) = sInnings2
    sRuns(ps) = sRuns2
    sOuts(ps) = sOuts2
    hs(ps) = hs2
    sBalls(ps) = sBalls2
    sWickets(ps) = sWickets2
    bbw(ps) = bbw2
    bbr(ps) = bbr2
    sOvers(ps) = sOvers2
    sConceded(ps) = sConceded2
    morale(ps) = morale2
    iWeeks(ps) = iWeeks2
    duty(ps) = duty2

    Select Case overSeas1(team)
        Case Is = ps
            overSeas1(team) = ps2
        Case Is = ps2
            overSeas1(team) = ps
    End Select
    Select Case overSeas2(team)
        Case Is = ps
            overSeas2(team) = ps2
        Case Is = ps2
            overSeas2(team) = ps
    End Select

    Select Case wk(team)
        Case Is = ps
            If ps2 < 12 Then wk(team) = ps2
        Case Is = ps2
            If ps < 12 Then wk(team) = ps
    End Select
    Select Case cp(team)
        Case Is = ps
            If ps2 < 12 Then cp(team) = ps2
        Case Is = ps2
            If ps < 12 Then cp(team) = ps
    End Select
    Select Case ob1(team)
        Case Is = ps
            If ps2 < 12 Then ob1(team) = ps2
        Case Is = ps2
            If ps < 12 Then ob1(team) = ps
    End Select
    Select Case ob2(team)
        Case Is = ps
            If ps2 < 12 Then ob2(team) = ps2
        Case Is = ps2
            If ps < 12 Then ob2(team) = ps
    End Select
    cob1 = 0
    If ob1(team) = wk(team) Then cob1 = 1
    If bowl(ob1(team), team) = 13 Then cob1 = 1
    If ob1(team) = ob2(team) Then cob1 = 1
    Select Case cob1
        Case Is = 1
            Do
                ob1(team) = rand(11)
            Loop Until wk(team) <> ob1(team) And bowl(ob1(team), team) <> 13 And ob1(team) <> ob2(team)
    End Select

    cob2 = 0
    If ob2(team) = wk(team) Then cob2 = 1
    If bowl(ob2(team), team) = 13 Then cob2 = 1
    If ob2(team) = ob1(team) Then cob2 = 1
    Select Case cob2
        Case Is = 1
            Do
                ob2(team) = rand(11)
            Loop Until wk(team) <> ob2(team) And bowl(ob2(team), team) <> 13 And ob2(team) <> ob1(team)
    End Select
    GoTo 480
450 End Sub

Sub training
    1131 cto = 1
    dd = 0
    1130 ops = 1
    1110 Color 11, 0
    Cls
    Locate 2, 5
    Print name$; "    "; team$(team); "    Week "; week; "  Year "; year
    Locate 6, 5
    Print "TRAINING"
    For i = 1 To 18
        If i = 1 Or i = 3 Or i = 5 Or i = 7 Or i = 9 Or i = 11 Or i = 13 Or i = 15 Or i = 17 Then Color 3, 0 Else Color 9, 0
        Locate (i + 8), 5
        Print player$(i, team)
    Next i

    If dd = 0 Then GoTo 1132
    For i = 1 To 18
        Locate (i + 8), 3
        If ops = i Then Print Chr$(16) Else Print " "
    Next i

    1132 Locate 32, 5
    If cto = 1 Then Color 0, 3 Else Color 3, 0
    Print "Train Player"
    Locate 34, 5
    If cto = 2 Then Color 0, 3 Else Color 3, 0
    Print "Back to Main Menu"

    1100 Select Case InKey$
        Case Is = u$
            If dd = 0 Then cto = cto - 1 Else ops = ops - 1
            If ops < 1 Then ops = 18
            If cto < 1 Then cto = 2
            GoTo 1110
        Case Is = d$
            If dd = 0 Then cto = cto + 1 Else ops = ops + 1
            If cto > 2 Then cto = 1
            If ops > 18 Then ops = 1
            GoTo 1110
        Case Is = Chr$(13)
            Select Case dd
                Case Is = 0
                    dd = 1
                    If cto = 2 Then GoTo 1120
                    GoTo 1110
                Case Is = 1
                    GoTo 4000
            End Select
        Case Else
            GoTo 1100
    End Select

    4000 z = 0
    Do
        Color 11, 0
        Cls
        Locate 2, 5
        Print name$; "    "; team$(team); "    Week "; week; "  Year "; year
        Locate 6, 5
        Print "TRAINING  -  "; player$(ops, team)
        Locate 10, 5
        Print "CAREER PERIOD: "; career$(peak(ops, team))
        Color 3, 0
        Locate 14, 5
        Print "CURRENT TRAINING FOCUS:"
        Locate 14, 30
        Print tAttribute$(ta(ops)); " "; Chr$(17); " "; Chr$(16)

        Color 9, 0
        Locate 18, 5
        Print "Very Low Intensity Training"
        Color 3, 0
        Locate 20, 5
        Print "Low Intensity Training"
        Color 9, 0
        Locate 22, 5
        Print "Medium Intensity Training"
        Color 3, 0
        Locate 24, 5
        Print "High Intensity Training"
        Color 9, 0
        Locate 26, 5
        Print "Very High Intensity Training"
        Locate (ti(ops) * 2 + 16), 3
        Print Chr$(16)
        Color 11, 0
        Locate 40, 5
        Print "Press RETURN to go back"
        1140 Select Case InKey$
            Case Is = u$
                ti(ops) = ti(ops) - 1
                If ti(ops) < 1 Then ti(ops) = 5
            Case Is = d$
                ti(ops) = ti(ops) + 1
                If ti(ops) > 5 Then ti(ops) = 1
            Case Is = l$
                ta(ops) = ta(ops) - 1
                If ta(ops) < 1 Then ta(ops) = 6
            Case Is = r$
                ta(ops) = ta(ops) + 1
                If ta(ops) > 6 Then ta(ops) = 1
            Case Is = Chr$(13)
                z = 1
            Case Else
                GoTo 1140
        End Select
    Loop Until z = 1
    GoTo 1131
1120 End Sub

