'chdir ".\samples\pete\hgm30e"

'HEGEMONY 3.0.e
'Copyright: Akos Ivanyi (21.07.2003)


'-----=====GENERAL GAMEFLOW=====-----

'     variables:
'         |
'      opening:
'         |
'   choosecontrol:<----O
'      /      \        |
'    human:   ai:      |
'      \      /        |
'      nextturn:------>O

'      (gosubs)


'-----=====THE GAME=====-----

variables:
'------------------------------------------------
DECLARE FUNCTION fixcolor (col AS INTEGER)
Dim rca As String * 1

'$DYNAMIC
Dim pic(32000) As Integer
'$STATIC

Dim control$(9)
Dim c$(9)
Dim name$(9)
Dim land%(9)
Dim sea(9)
Dim navy%(9)
Dim seaarmy%(9)
Dim seamoved%(9)
Dim money&(9)
Dim population&(9)
Dim tax(9)
Dim morale(9)
Dim trust(9)
Dim science(6, 9)
Dim sciencename$(6)
Dim sciencemoney&(6)
Dim ownercolor%(9)
Dim peasant&(9)
Dim fisher&(9)
Dim worker&(9)
Dim merchant&(9)
Dim soldier&(9)
Dim unemployed&(9)
Dim fo%(9)
Dim chu%(9)
Dim uni%(9)
Dim mil%(9)
Dim allfood&(9)
Dim spy%(9)
Dim spycost%(9)
Dim landtrade(9)
Dim value(9)
Dim lostvalue(9)
Dim diplinterest(9)
Dim hate(9)
Dim fear(9)
Dim diplplan(9)
Dim property&(9)
Dim level(9)
Dim bestname$(9)
Dim bestturn(9)
Dim bestcontrol$(9)
Dim bestdate$(9)

Dim dipl%(9, 9)
Dim diplaction%(9, 9)
Dim border%(9, 9)

Dim owner%(15, 15)
Dim original%(15, 15)
Dim terrain%(15, 15)
Dim fort%(15, 15)
Dim church%(15, 15)
Dim university%(15, 15)
Dim mill%(15, 15)
Dim army%(15, 15)
Dim moved%(16, 16)
Dim localmorale(15, 15)
Dim threat(16, 16)
Dim ed%(15, 15)

Dim tername$(9)
Dim foodpot(9)
Dim prodpot(9)
Dim terdefense(9)
Dim tercolor(9)
Dim size%(7)

Dim i As Integer
Dim j As Integer
Dim x As Integer
Dim y As Integer

ownercolor%(0) = 0
ownercolor%(1) = 2
ownercolor%(2) = 4
ownercolor%(3) = 1
ownercolor%(4) = 14
ownercolor%(5) = 8
ownercolor%(6) = 15
ownercolor%(7) = 11
ownercolor%(8) = 13
ownercolor%(9) = 12

sciencename$(1) = "agriculture"
sciencename$(2) = "industry"
sciencename$(3) = "trade"
sciencename$(4) = "sailing"
sciencename$(5) = "military"
sciencename$(6) = "medicine"

size%(1) = 1
size%(2) = 2
size%(3) = 5
size%(4) = 10
size%(5) = 20
size%(6) = 50
size%(7) = 100

tername$(0) = "sea"
tercolor(0) = 1
x = 8
y = 8
BF = 700: mf = 30: sf = 70
bc = 100: mc = 3: sc = 10
bu = 500: mu = 25: su = 250
bm = 200: mm = -20: sm = 180
bn = 200: mn = 20: sn = 180
ba = 150: ma = 30: sa = 75
message$ = "Welcome, Majesty."


opening:
'------------------------------------------------
save% = 1
code% = 1
Screen 12
Cls

Locate 1, 1
Open "motto.txt" For Input As #1
While Not EOF(1)
    Line Input #1, text$
    Print text$
Wend
Close
GoSub press

Cls
Open "hgm.bmp" For Binary As #1
Seek #1, 119
For i = 299 To 0 Step -1
    For j = 0 To 399 Step 2
        Get #1, , rca
        PSet (j + 120, i + 90), fixcolor(Fix(Asc(rca) / 16))
        PSet (j + 121, i + 90), fixcolor(Asc(rca) - Fix(Asc(rca) / 16) * 16)
    Next j
Next i
Close #1
Line (0, 0)-(639, 479), 2, B
rca = Input$(1)

Randomize Timer
Cls
GoSub title
Locate 7, 1: Print "(Press 'ENTER' for default.)"
Locate 6, 1
scen$ = "default.scn"
Input "Which scenario do you wish to play"; scen$
If scen$ = "" Then scen$ = "default.scn"
Locate 9, 1
Print "Opening file..."
Open scen$ For Input As #1
Input #1, players%
Input #1, player%
Input #1, turn%
For i = 1 To 6
    Input #1, sciencemoney&(i)
Next i
For i = 1 To players%
    Line Input #1, name$(i)
    Input #1, control$(i)
    Input #1, population&(i)
    Input #1, money&(i)
    Input #1, navy%(i)
    Input #1, seaarmy%(i)
    Input #1, seamoved%(i)
    Input #1, tax(i)
    Input #1, trust(i)
    For j = 1 To 6
        Input #1, science(j, i)
    Next j
    For j = 1 To players%
        Input #1, dipl%(i, j)
    Next j
    For j = 1 To players%
        Input #1, diplaction%(i, j)
    Next j
Next i
For k = 1 To 9
    For i = 1 To 15
        For j = 1 To 15
            Select Case k
                Case 1
                    Input #1, owner%(i, j)
                Case 2
                    Input #1, original%(i, j)
                Case 3
                    Input #1, terrain%(i, j)
                Case 4
                    Input #1, fort%(i, j)
                Case 5
                    Input #1, church%(i, j)
                Case 6
                    Input #1, university%(i, j)
                Case 7
                    Input #1, mill%(i, j)
                Case 8
                    Input #1, army%(i, j)
                Case 9
                    Input #1, moved%(i, j)
            End Select
        Next j
    Next i
Next k
Close
Open "terrain.typ" For Input As #1
For i = 1 To 9
    Line Input #1, tername$(i)
    Input #1, foodpot(i)
    Input #1, prodpot(i)
    Input #1, terdefense(i)
    Input #1, tercolor(i)
Next i
Close
Print
GoSub spy
GoSub chooseplayer
GoSub enemydistance


choosecontrol:
'------------------------------------------------
GoSub countproperties:
active% = 0
human% = 0
For i = 1 To players%
    If land%(i) > 0 Then active% = active% + 1
    If control$(i) = "human" Then human% = human% + 1
Next i
If human% = 0 Then GoTo aicombat
If active% = 1 Then GoTo victory
If land%(player%) = 0 Then
    While land%(player%) = 0
        If player% < players% Then
            player% = player% + 1
        Else
            player% = 1
            turn% = turn% + 1
            revoltnation = Int(Rnd * players%) + 1
            revoltlevel = Rnd * Rnd * 10
        End If
        For i = 1 To players%
            diplaction%(player%, i) = 0
        Next i
    Wend
End If
GoSub spy
If control$(player%) = "human" Then
    Beep
    If human% > 1 Then
        Cls
        Color ownercolor%(player%)
        Locate player% * 3, player% * 6
        Print name$(player%); "'s turn!"
        Beep
        GoSub press
        Cls
    End If
    GoSub countproperties
    GoTo human
Else
    GoTo ai
End If


human:
'------------------------------------------------
Locate 1, 1
GoSub title
GoSub see
GoSub morale
GoSub drawmap
Line (450, 100)-(640, 360), 0, BF
Line (129 + x * 20, 79 + y * 20)-(151 + x * 20, 101 + y * 20), 0, B
Restore eye
For i = 1 To 7
    For j = 1 To 12
        Read pixel%
        If pixel% < 16 Then PSet (134 + x * 20 + j, 83 + y * 20 + i), pixel%
    Next j
Next i
Line (455, 380)-(639, 404), 7, B
Locate 5, 29
Color ownercolor%(player%)
Print name$(player%); "'s turn:"; turn%
Color 7
Locate 5, 1
Print "Empires"
Print "-------"
Print "i = Information"
Print "t = Treasury"
Print "s = Science"
Print "d = Diplomacy"
Print
Print "Territories"
Print "-----------"
Print "Examine: numbers"
Print "Move army: arrows"
Print "Build:"
Print " f = Fort"
Print " c = Church"
Print " u = University"
Print " m = Mills, Mines"
Print "      Mints..."
Print " a = Army"
Print " n = Navy"
Print "Sell/Destroy:"
Print " F, C, U, M, A, N"
Print
Print "Military unit size:         + = increase,  - = decrease"
Print "E = End turn,   g = save Game,   h = Help,   Q = Quit";
Color 14
Print "     Gold:"; money&(player%); "  "
Color 7
Locate 5, 59
Print "Territory info"
Locate 6, 59
Print "--------------"
Locate 7, 59
Print "Location:"; x; y; "    "
Color ownercolor%(owner%(y, x))
If terrain%(y, x) <> 0 Then
    Locate 8, 59
    Print "Province of..."
    Locate 9, 61
    Print name$(owner%(y, x))
    Locate 10, 59
    Color ownercolor%(original%(y, x))
    Print "Original owner:"
    Locate 11, 61
    Print name$(original%(y, x))
End If
Locate 12, 59
Color tercolor(terrain%(y, x))
Print "Terrain: "; tername$(terrain%(y, x))
If terrain%(y, x) <> 0 Then
    Locate 13, 61
    Print "food:"; foodpot(terrain%(y, x))
    Locate 14, 61
    Print "resources:"; prodpot(terrain%(y, x))
    Locate 15, 61
    Print "defence bonus:"; terdefense(terrain%(y, x)) * 100; "%"
    Locate 16, 59
    Color ownercolor%(owner%(y, x))
    Print "Forts:";
    If see% = 1 Then Print fort%(y, x)
    Locate 17, 59
    Print "Churches:";
    If see% = 1 Then Print church%(y, x)
    Locate 18, 59
    Print "Universities:";
    If see% = 1 Then Print university%(y, x)
    Locate 19, 59
    Print "Mills, etc.:";
    If see% = 1 Then Print mill%(y, x)
End If
Locate 20, 59
If owner%(y, x) <> 0 Then
    Print "Army:";
    If see% = 1 Then Print army%(y, x)
Else
    Color ownercolor%(player%)
    Print "Army:"; seaarmy%(player%)
End If
Locate 21, 59
Print "Morale:";
If see% = 1 Then Print Int(localmorale(y, x) * 100 + .5); "%   "
Locate 22, 59
Color ownercolor%(player%)
If owner%(y, x) = player% Then
    Print "Reinforcement:"; moved%(y, x)
ElseIf owner%(y, x) <> 0 Then
    Print "Attackers:"; moved%(y, x)
Else
    Print "Just embarked:"; seamoved%(player%)
End If
Locate 23, 59
If terrain%(y, x) = 0 Then
    Print "Navy:"; navy%(player%); "   "
Else
    Print "                   "
End If
Color 7
Locate 25, 59
Print message$
Locate 27, 20
If code% > 1 Then Color ownercolor%(player%)
Print size%(code%); " "
Color 7

k$ = ""
While k$ = ""
    k$ = InKey$
Wend
message$ = "                    "
Select Case k$
    Case "q"
        message$ = "'Q' instead of 'q'. "
    Case "Q"
        GoTo bye
    Case "1" TO "9"
        If Val(k$) < 4 Then
            If y < 15 Then y = y + 1
        End If
        If k$ = "1" Or k$ = "4" Or k$ = "7" Then
            If x > 1 Then x = x - 1
        End If
        If k$ = "3" Or k$ = "6" Or k$ = "9" Then
            If x < 15 Then x = x + 1
        End If
        If Val(k$) > 6 Then
            If y > 1 Then y = y - 1
        End If
    Case Chr$(0) + "H"
        If y > 1 Then
            If owner%(y, x) = player% And army%(y, x) >= size%(code%) Then
                If terrain%(y - 1, x) <> 0 Then
                    moved%(y - 1, x) = moved%(y - 1, x) + size%(code%)
                    army%(y, x) = army%(y, x) - size%(code%)
                Else
                    If seamoved%(player%) + seaarmy%(player%) + size%(code%) <= navy%(player%) Then
                        seamoved%(player%) = seamoved%(player%) + size%(code%)
                        army%(y, x) = army%(y, x) - size%(code%)
                    Else
                        message$ = "Not enough ships.   "
                    End If
                End If
            ElseIf terrain%(y, x) = 0 And terrain%(y - 1, x) <> 0 And seaarmy%(player%) >= size%(code%) Then
                seaarmy%(player%) = seaarmy%(player%) - size%(code%)
                moved%(y - 1, x) = moved%(y - 1, x) + size%(code%)
            End If
        End If
    Case Chr$(0) + "P"
        If y < 15 Then
            If owner%(y, x) = player% And army%(y, x) >= size%(code%) Then
                If terrain%(y + 1, x) <> 0 Then
                    moved%(y + 1, x) = moved%(y + 1, x) + size%(code%)
                    army%(y, x) = army%(y, x) - size%(code%)
                Else
                    If seamoved%(player%) + seaarmy%(player%) + size%(code%) <= navy%(player%) Then
                        seamoved%(player%) = seamoved%(player%) + size%(code%)
                        army%(y, x) = army%(y, x) - size%(code%)
                    Else
                        message$ = "Not enough ships.   "
                    End If
                End If
            ElseIf terrain%(y, x) = 0 And terrain%(y + 1, x) <> 0 And seaarmy%(player%) >= size%(code%) Then
                seaarmy%(player%) = seaarmy%(player%) - size%(code%)
                moved%(y + 1, x) = moved%(y + 1, x) + size%(code%)
            End If
        End If
    Case Chr$(0) + "K"
        If x > 1 Then
            If owner%(y, x) = player% And army%(y, x) >= size%(code%) Then
                If terrain%(y, x - 1) <> 0 Then
                    moved%(y, x - 1) = moved%(y, x - 1) + size%(code%)
                    army%(y, x) = army%(y, x) - size%(code%)
                Else
                    If seamoved%(player%) + seaarmy%(player%) + size%(code%) <= navy%(player%) Then
                        seamoved%(player%) = seamoved%(player%) + size%(code%)
                        army%(y, x) = army%(y, x) - size%(code%)
                    Else
                        message$ = "Not enough ships.   "
                    End If
                End If
            ElseIf terrain%(y, x) = 0 And terrain%(y, x - 1) <> 0 And seaarmy%(player%) >= size%(code%) Then
                seaarmy%(player%) = seaarmy%(player%) - size%(code%)
                moved%(y, x - 1) = moved%(y, x - 1) + size%(code%)
            End If
        End If
    Case Chr$(0) + "M"
        If x < 15 Then
            If owner%(y, x) = player% And army%(y, x) >= size%(code%) Then
                If terrain%(y, x + 1) <> 0 Then
                    moved%(y, x + 1) = moved%(y, x + 1) + size%(code%)
                    army%(y, x) = army%(y, x) - size%(code%)
                Else
                    If seamoved%(player%) + seaarmy%(player%) + size%(code%) <= navy%(player%) Then
                        seamoved%(player%) = seamoved%(player%) + size%(code%)
                        army%(y, x) = army%(y, x) - size%(code%)
                    Else
                        message$ = "Not enough ships.   "
                    End If
                End If
            ElseIf terrain%(y, x) = 0 And terrain%(y, x + 1) <> 0 And seaarmy%(player%) >= size%(code%) Then
                seaarmy%(player%) = seaarmy%(player%) - size%(code%)
                moved%(y, x + 1) = moved%(y, x + 1) + size%(code%)
            End If
        End If
    Case "f"
        If owner%(y, x) = player% Then
            fort%(y, x) = fort%(y, x) + 1
            money&(player%) = money&(player%) - BF
            message$ = "Cost:" + Str$(BF) + "            "
        End If
    Case "c"
        If owner%(y, x) = player% Then
            church%(y, x) = church%(y, x) + 1
            money&(player%) = money&(player%) - bc
            message$ = "Cost:" + Str$(bc) + "            "
        End If
    Case "u"
        If owner%(y, x) = player% Then
            university%(y, x) = university%(y, x) + 1
            money&(player%) = money&(player%) - bu
            message$ = "Cost:" + Str$(bu) + "            "
        End If
    Case "m"
        If owner%(y, x) = player% And prodpot(terrain%(y, x)) > mill%(y, x) Then
            mill%(y, x) = mill%(y, x) + 1
            money&(player%) = money&(player%) - bm
            message$ = "Cost:" + Str$(bm) + "            "
        ElseIf owner%(y, x) = player% Then
            message$ = "No more resources.  "
        End If
    Case "n"
        If owner%(y, x) = 0 Then
            navy%(player%) = navy%(player%) + size%(code%)
            money&(player%) = money&(player%) - bn * size%(code%)
            message$ = "Cost:" + Str$(bn * size%(code%)) + "     "
        End If
    Case "a"
        If owner%(y, x) = player% Then
            GoSub countproperties
            If soldier&(player%) >= population&(player%) Then
                message$ = "No more people!     "
            Else
                moved%(y, x) = moved%(y, x) + size%(code%)
                money&(player%) = money&(player%) - ba * size%(code%)
                message$ = "Cost:" + Str$(ba * size%(code%)) + "     "
            End If
        End If
    Case "F"
        If owner%(y, x) = player% And fort%(y, x) > 0 Then
            fort%(y, x) = fort%(y, x) - 1
            money&(player%) = money&(player%) + sf
            message$ = "Income:" + Str$(sf) + "          "
        End If
    Case "C"
        If owner%(y, x) = player% And church%(y, x) > 0 Then
            church%(y, x) = church%(y, x) - 1
            money&(player%) = money&(player%) + sc
            message$ = "Income:" + Str$(sc) + "          "
        End If
    Case "U"
        If owner%(y, x) = player% And university%(y, x) > 0 Then
            university%(y, x) = university%(y, x) - 1
            money&(player%) = money&(player%) + su
            message$ = "Income:" + Str$(su) + "          "
        End If
    Case "M"
        If owner%(y, x) = player% And mill%(y, x) > 0 Then
            mill%(y, x) = mill%(y, x) - 1
            money&(player%) = money&(player%) + sm
            message$ = "Income:" + Str$(sm) + "          "
        End If
    Case "N"
        If owner%(y, x) = 0 And navy%(player%) > 0 Then
            If seamoved%(player%) + seaarmy%(player%) < navy%(player%) Then
                navy%(player%) = navy%(player%) - 1
                money&(player%) = money&(player%) + sn
                message$ = "Income:" + Str$(sn) + "          "
            Else
                message$ = "Disembark first.    "
            End If
        End If
    Case "A"
        If owner%(y, x) = player% And army%(y, x) > 0 Then
            army%(y, x) = army%(y, x) - 1
            money&(player%) = money&(player%) + sa
            message$ = "Income:" + Str$(sa) + "          "
        End If
    Case "i"
        GoSub info
    Case "s"
        GoSub science
    Case "t"
        GoSub treasury
    Case "d"
        GoSub diplomacy
    Case "E"
        GoTo nextturn
    Case "e"
        message$ = "'E' instead of 'e'. "
    Case "g"
        GoSub savegame
    Case "h"
        GoSub help
    Case "+"
        If code% < 7 Then code% = code% + 1
    Case "-"
        If code% > 1 Then code% = code% - 1
End Select
GoTo human


ai:
'------------------------------------------------
If human% > 0 Then Print name$(player%); "'s turn..."
'-- ai load variables --
Open control$(player%) For Input As #1
Input #1, foodweight
Input #1, prodweight
Input #1, hateweight
Input #1, diplweight
Input #1, friendliness
Input #1, chance
Input #1, trustweight
Input #1, remoteweight
Input #1, mintrust
Input #1, aitrade
Input #1, aifriend
Input #1, aially
Input #1, minmorale
Input #1, mintax
For i = 1 To 5
    Input #1, feardipl(i)
Next i
Input #1, warmilitary
Input #1, peacemilitary
Input #1, aibuilding
Input #1, aichurch
Input #1, aimill
Input #1, ainavy
Input #1, aiuni
For i = 1 To 6
    Input #1, aiscience(i)
Next i
Input #1, landorsea
Input #1, planning
Input #1, myfactor
Input #1, avgfactor
Close

'-- ai tax --
GoSub countproperties
GoSub professions
limit = minmorale * (1 - unemployed&(player%) / (population&(player%) + .001))
besttax = 0
For try = 1 To 25
    tax(player%) = try / 100
    GoSub morale
    If morale(player%) > limit Then besttax = try / 100
Next try
If besttax < mintax Then besttax = mintax
tax(player%) = besttax
GoSub morale

'-- ai diplomacy --
For i = 1 To players%
    value(i) = 0
    lostvalue(i) = 0
    diplaction%(player%, i) = 0
Next i
origvalue = 0
For i = 1 To 15
    For j = 1 To 15
        value(owner%(i, j)) = value(owner%(i, j)) + foodpot(terrain%(i, j)) * foodweight + prodpot(terrain%(i, j)) * prodweight
        If original%(i, j) = player% Then
            origvalue = origvalue + foodpot(terrain%(i, j)) * foodweight + prodpot(terrain%(i, j)) * prodweight
            If owner%(i, j) <> player% Then lostvalue(owner%(i, j)) = lostvalue(owner%(i, j)) + foodpot(terrain%(i, j)) * foodweight + prodpot(terrain%(i, j)) * prodweight
        End If
    Next j
Next i

maxvalue = 0
maxcountry = 0
For i = 1 To players%
    If value(i) > maxvalue Then
        maxvalue = value(i)
        maxcountry = i
    End If
    diplinterest(i) = 0
    hate(i) = 0
    modifyme = 0
    modifytarget = 0
    allvalue = 0
    enemyvalue = 0
    tradevalue = value(player%)
    friendvalue = value(player%)
    allyvalue = 0
    For j = 1 To players%
        If j <> player% And j <> i Then diplinterest(i) = diplinterest(i) + (dipl%(player%, j) - 3) * (dipl%(j, i) - 3) / 2 + 3
        If dipl%(player%, j) = 5 Then modifyme = modifyme + value(j)
        If dipl%(player%, j) = 1 Then modifyme = modifyme - value(j)
        If dipl%(i, j) = 5 Then modifytarget = modifytarget + value(j)
        If dipl%(i, j) = 1 Then modifytarget = modifytarget - value(j)
        allvalue = allvalue + value(j)
        If dipl%(player%, j) = 1 Then enemyvalue = enemyvalue + value(j)
        If dipl%(player%, j) = 3 Then tradevalue = tradevalue + value(j)
        If dipl%(player%, j) = 4 Then friendvalue = friendvalue + value(j)
        If dipl%(player%, j) = 5 Then allyvalue = allyvalue + value(j)
    Next j
    diplinterest(i) = diplinterest(i) / (players% - 2)
    If active% < 3 Then diplinterest(i) = 2
    hate(i) = lostvalue(i) / origvalue
    If dipl%(player%, i) = 4 Then hate(i) = -lostvalue(i) / origvalue
    fear(i) = (value(i) + modifytarget) / (value(player%) + modifyme)
Next i
avgvalue = allvalue / players%
target% = 0
min = 999
For i = 1 To players%
    diplplan(i) = fear(i) * (1 - hate(i) * hateweight) * (1 + (diplinterest(i) - dipl%(player%, i)) / 10 * diplweight) * (1 - (1 - trust(i)) * trustweight)
    If diplplan(i) < 0 Then diplplan(i) = 0
    If border%(player%, i) = 0 And navy%(player%) < soldier&(player%) Then diplplan(i) = diplplan(i) * soldier&(player%) / (navy%(player%) + .001)
    If border%(player%, i) = 0 Then diplplan(i) = diplplan(i) * (1 + remoteweight)
    diplplan(i) = diplplan(i) * (1 + friendliness) * (1 - chance + Rnd * 2 * chance) - 1
    If diplplan(i) < min And i <> player% And land%(i) > 0 Then
        min = diplplan(i)
        target% = i
    End If
Next i

overlimit = 0
If maxvalue > value(player%) * myfactor And maxvalue > avgvalue * avgfactor Then
    overlimit = 1
    If dipl%(player%, maxcountry) > 2 Or allyvalue > maxvalue / 2 Then target% = maxcountry
End If

If trust(player%) > mintrust Then diplaction%(player%, target%) = -1

For i = 1 To players%
    If (min > 0 Or money&(player%) < 0 Or enemyvalue > allyvalue) And (overlimit = 0 Or target% <> i) Then diplaction%(player%, i) = 1
    If overlimit = 1 And i <> maxcountry Then diplaction%(player%, i) = 1
    If dipl%(player%, i) = 2 And diplaction%(player%, i) > -1 And diplplan(i) > 0 And aitrade * (1 - (1 - trust(i)) * trustweight) / (value(player%) / avgvalue) / (tradevalue / avgvalue) * (1 + friendliness) > Rnd Then diplaction%(player%, i) = 1
    If dipl%(player%, i) = 3 And diplaction%(player%, i) > -1 And diplplan(i) > 0 And aifriend * (1 - (1 - trust(i)) * trustweight) / (value(player%) / avgvalue) / (friendvalue / avgvalue) * (1 + friendliness) > Rnd Then diplaction%(player%, i) = 1
    If dipl%(player%, i) = 4 And diplaction%(player%, i) > -1 And diplplan(i) > 0 And aially * (1 - (1 - trust(i)) * trustweight) / (value(player%) / avgvalue) / (allyvalue / avgvalue) * (1 + friendliness) > Rnd Then diplaction%(player%, i) = 1
    If overlimit = 1 And i = maxcountry And diplaction%(player%, i) > -1 Then diplaction%(player%, i) = 0
Next i

'-- ai movements --
'- analysing -
seafear = 0
For i = 1 To players%
    a = soldier&(player%) / land%(player%) ^ 2 * land%(i) * feardipl(dipl%(player%, i)) * (1 - sea(player%))
    If a > seafear Then seafear = a
Next i
ownmill% = 1
maxrnd = 0
unii = 0
unij = 0
max2rnd = 0
disi = 0
disj = 0
For i = 1 To 15
    For j = 1 To 15
        If owner%(i, j) = player% And original%(i, j) = player% And prodpot(terrain%(i, j)) > mill%(i, j) Then ownmill% = 0
        threat(i, j) = 0
        coast = 0
        a = 1
        If owner%(i, j) = player% Then
            If i > 1 And i < 15 And j > 1 And j < 15 Then a = (dipl%(player%, owner%(i - 1, j)) - 1) * (dipl%(player%, owner%(i + 1, j)) - 1) * (dipl%(player%, owner%(i, j - 1)) - 1) * (dipl%(player%, owner%(i, j + 1)) - 1)
            If original%(i, j) <> player% Then
                threat(i, j) = (population&(player%) / (allfood&(player%) + .001) * foodpot(terrain%(i, j)) / 40) * (1 - morale(player%) ^ 2)
                If threat(i, j) < foodpot(terrain%(i, j)) Then threat(i, j) = foodpot(terrain%(i, j))
                If threat(i, j) < 1 Then threat(i, j) = 1
            End If
            threat(i, j) = threat(i, j) - army%(i, j) * (1 + terdefense(terrain%(i, j)) + fort%(i, j) * .3)
            currentrnd = Rnd
            If original%(i, j) = player% And currentrnd > maxrnd Then
                maxrnd = currentrnd
                unii = i
                unij = j
            End If
            If i > 1 Then
                If owner%(i - 1, j) = 0 Then
                    coast = 1
                ElseIf owner%(i - 1, j) <> player% Then
                    threat(i, j) = threat(i, j) + army%(i - 1, j) * feardipl(dipl%(player%, owner%(i - 1, j)))
                End If
            End If
            If i < 15 Then
                If owner%(i + 1, j) = 0 Then
                    coast = 1
                ElseIf owner%(i + 1, j) <> player% Then
                    threat(i, j) = threat(i, j) + army%(i + 1, j) * feardipl(dipl%(player%, owner%(i + 1, j)))
                End If
            End If
            If j > 1 Then
                If owner%(i, j - 1) = 0 Then
                    coast = 1
                ElseIf owner%(i, j - 1) <> player% Then
                    threat(i, j) = threat(i, j) + army%(i, j - 1) * feardipl(dipl%(player%, owner%(i, j - 1)))
                End If
            End If
            If j < 15 Then
                If owner%(i, j + 1) = 0 Then
                    coast = 1
                ElseIf owner%(i, j + 1) <> player% Then
                    threat(i, j) = threat(i, j) + army%(i, j + 1) * feardipl(dipl%(player%, owner%(i, j + 1)))
                End If
            End If
            If coast = 1 Then threat(i, j) = threat(i, j) + seafear
        ElseIf dipl%(owner%(i, j), player%) = 1 Then
            If i > 1 Then
                current2rnd = Rnd
                If owner%(i - 1, j) = 0 And current2rnd > max2rnd Then
                    max2rnd = current2rnd
                    disi = i
                    disj = j
                End If
            End If
            If i < 15 Then
                current2rnd = Rnd
                If owner%(i + 1, j) = 0 And current2rnd > max2rnd Then
                    max2rnd = current2rnd
                    disi = i
                    disj = j
                End If
            End If
            If j > 1 Then
                current2rnd = Rnd
                If owner%(i, j - 1) = 0 And current2rnd > max2rnd Then
                    maxrnd = current2rnd
                    disi = i
                    disj = j
                End If
            End If
            If j < 15 Then
                current2rnd = Rnd
                If owner%(i, j + 1) = 0 And current2rnd > maxrnd Then
                    max2rnd = current2rnd
                    disi = i
                    disj = j
                End If
            End If
        End If
    Next j
Next i
'- reinforcing and attacking -
maxthreat = 0
threati = 0
threatj = 0
For i = 1 To 15
    For j = 1 To 15
        If owner%(i, j) = player% Then
            If threat(i, j) > maxthreat Then
                maxthreat = threat(i, j)
                threati = i
                threatj = j
            End If
        End If
        max = 1
        coast = 0
        a = 0: ' help neighbouring zone
        minforce = 9999
        minarmy = 9999
        B = 0: ' attack enemy
        c = 0: ' concentrate forces next to enemy
        excess = Int(-threat(i, j) / (1 + terdefense(terrain%(i, j)) + fort%(i, j) * .3)) - 1
        If excess > army%(i, j) Then excess = army%(i, j)
        If excess >= 1 Then
            If i > 1 Then
                If threat(i - 1, j) > max Then
                    max = threat(i - 1, j)
                    a = 1
                End If
                force = army%(i - 1, j) * (1 + terdefense(terrain%(i - 1, j)) + fort%(i - 1, j) * .3)
                If dipl%(player%, owner%(i - 1, j)) = 1 And force < minforce Then
                    minforce = force
                    minarmy = army%(i - 1, j)
                    B = 1
                End If
                If ed%(i - 1, j) < ed%(i, j) And owner%(i - 1, j) = player% Then c = 1
                If owner%(i - 1, j) = 0 Then coast = 1
            End If
            If i < 15 Then
                If threat(i + 1, j) > max Then
                    max = threat(i + 1, j)
                    a = 2
                End If
                force = army%(i + 1, j) * (1 + terdefense(terrain%(i + 1, j)) + fort%(i + 1, j) * .3)
                If dipl%(player%, owner%(i + 1, j)) = 1 And force < minforce Then
                    minforce = force
                    minarmy = army%(i + 1, j)
                    B = 2
                End If
                If ed%(i + 1, j) < ed%(i, j) And owner%(i + 1, j) = player% Then c = 2
                If owner%(i + 1, j) = 0 Then coast = 1
            End If
            If j > 1 Then
                If threat(i, j - 1) > max Then
                    max = threat(i, j - 1)
                    a = 3
                End If
                force = army%(i, j - 1) * (1 + terdefense(terrain%(i, j - 1)) + fort%(i, j - 1) * .3)
                If dipl%(player%, owner%(i, j - 1)) = 1 And force < minforce Then
                    minforce = force
                    minarmy = army%(i, j - 1)
                    B = 3
                End If
                If ed%(i, j - 1) < ed%(i, j) And owner%(i, j - 1) = player% Then c = 3
                If owner%(i, j - 1) = 0 Then coast = 1
            End If
            If j < 15 Then
                If threat(i, j + 1) > max Then
                    max = threat(i, j + 1)
                    a = 4
                End If
                force = army%(i, j + 1) * (1 + terdefense(terrain%(i, j + 1)) + fort%(i, j + 1) * .3)
                If dipl%(player%, owner%(i, j + 1)) = 1 And force < minforce Then
                    minforce = force
                    minarmy = army%(i, j + 1)
                    B = 4
                End If
                If ed%(i, j + 1) < ed%(i, j) And owner%(i, j + 1) = player% Then c = 4
                If owner%(i, j + 1) = 0 Then coast = 1
            End If
        End If
        'first round to help neighbours
        d = a
        If max > excess Then send = excess Else send = Int(max)
        excess = excess - send
        round = 1
        movements:
        If send < 1 Then d = 0
        Select Case d
            Case 0
                'embark if you don't know where to go
                If round = 2 And send > 0 And coast = 1 Then
                    emb = navy%(player%) - seaarmy%(player%) - seamoved%(player%)
                    If emb > send Then emb = send
                    army%(i, j) = army%(i, j) - emb
                    seamoved%(player%) = seamoved%(player%) + emb
                End If
            Case 1
                moved%(i - 1, j) = moved%(i - 1, j) + send
                army%(i, j) = army%(i, j) - send
            Case 2
                moved%(i + 1, j) = moved%(i + 1, j) + send
                army%(i, j) = army%(i, j) - send
            Case 3
                moved%(i, j - 1) = moved%(i, j - 1) + send
                army%(i, j) = army%(i, j) - send
            Case 4
                moved%(i, j + 1) = moved%(i, j + 1) + send
                army%(i, j) = army%(i, j) - send
        End Select
        'second round to attack enemy or concentrate forces
        round = round + 1
        send = excess
        d = 0
        If c > 0 Then d = c
        If B > 0 And minforce < excess Then
            d = B
            send = send + Int(minarmy / (1 + terdefense(terrain%(i, j)) + fort%(i, j) * .3))
        End If
        If send >= 1 And round = 2 Then GoTo movements
    Next j
Next i
'- embarking -
landenemy% = 0
seaenemy% = 0
enemyvalue = 0
For i = 1 To players%
    If dipl%(player%, i) = 1 Then
        If border%(player%, i) > 0 Then landenemy% = landenemy% + 1
        If border%(i, 0) > 0 And border%(player%, 0) > 0 Then seaenemy% = seaenemy% + 1
        enemyvalue = enemyvalue + value(i)
    End If
Next i
If allyvalue / (enemyvalue + .01) > Rnd And landenemy% = 0 And seaenemy% > 0 And sea(player%) * active% > Rnd Then
    For i = 1 To 15
        For j = 1 To 15
            emb = 0
            If i > 1 Then
                If owner%(i - 1, j) = 0 Then emb = 1
            End If
            If i < 15 Then
                If owner%(i + 1, j) = 0 Then emb = 1
            End If
            If j > 1 Then
                If owner%(i, j - 1) = 0 Then emb = 1
            End If
            If j < 15 Then
                If owner%(i, j + 1) = 0 Then emb = 1
            End If
            If owner%(i, j) = player% And emb = 1 Then
                emb = navy%(player%) - seaarmy%(player%) - seamoved%(player%)
            Else
                emb = 0
            End If
            If army%(i, j) - 5 < emb Then emb = army%(i, j) - 5
            If emb > 0 Then
                army%(i, j) = army%(i, j) - emb
                seamoved%(player%) = seamoved%(player%) + emb
            End If
        Next j
    Next i
End If
'- disembarking -
If disi > 0 And disj > 0 And seaarmy%(player%) > 5 And seaarmy%(player%) > soldier&(player%) / land%(player%) * 2 Then
    moved%(disi, disj) = seaarmy%(player%)
    seaarmy%(player%) = 0
    If human% > 0 Then
        Color ownercolor%(player%)
        Print name$(player%);
        Color 7
        Print " disembarks on"; disj; disi
        GoSub press
    End If
End If

'-- ai money spending --
If money&(player%) < -population&(player%) / 3 Then GoSub debt
If money&(player%) > 0 Then
    If enemyvalue > 0 Then
        spend& = Int(money&(player%) * warmilitary)
    Else
        spend& = Int(money&(player%) * peacemilitary)
    End If
    GoSub military
End If
If money&(player%) > 0 Then
    If aibuilding > Rnd Or morale(player%) < Rnd Then
        GoSub building
    Else
        GoSub developscience
    End If
End If


nextturn:
'------------------------------------------------
GoSub countproperties
GoSub morale
If human% > 0 Then Cls

'-- science --
For i = 1 To 6
    aa& = Int(science(i, player%) ^ 3 * 1000)
    If sciencemoney&(i) > aa& Then sciencemoney&(i) = aa&
    If uni%(player%) / 100 > Rnd And population&(player%) > 0 Then sciencemoney&(i) = sciencemoney&(i) + Rnd * 1000 * (1 + (uni%(player%) / population&(player%) * 50))
    If population&(player%) < 100 Then
        plus = 0
    Else
        plus = sciencemoney&(i) / 10000 / science(i, player%) ^ 3 * (1 + uni%(player%) / population&(player%) * 50)
    End If
    If plus > .3 Then plus = .3
    science(i, player%) = science(i, player%) + plus
    If control$(player%) = "human" And plus > 0 Then
        Print "Your level of "; sciencename$(i); " has increased by:";
        Print Using "##.###"; plus
        GoSub press
    End If
Next i

'-- war --
For i = 1 To 15
    For j = 1 To 15
        If owner%(i, j) <> 0 Then
            attack = 0
            defend = 0
            If owner%(i, j) = player% Then
                army%(i, j) = army%(i, j) + moved%(i, j)
                moved%(i, j) = 0
            End If
            rebels% = Int(population&(owner%(i, j)) / (allfood&(owner%(i, j)) + .001) * foodpot(terrain%(i, j)) / 20 * Rnd * morale(original%(i, j)) ^ 2)
            If owner%(i, j) <> player% And moved%(i, j) > 0 Then
                attack = attack + moved%(i, j) * science(5, player%) * (.9 + Rnd / 5)
                If human% > 0 Then
                    Print
                    Print "Location:"; j; i
                    Color ownercolor%(player%)
                    Print name$(player%);
                    Color 7
                    Print " starts an attack against ";
                    Color ownercolor%(owner%(i, j))
                    Print name$(owner%(i, j));
                    Color 7
                    Print " with"; moved%(i, j); "soldiers."
                End If
                If dipl%(player%, owner%(i, j)) > 1 Then
                    If diplaction%(player%, owner%(i, j)) = -1 And dipl%(player%, owner%(i, j)) = 2 Then
                        If human% > 0 Then Print "...shortly after a declaration of war."
                    Else
                        If human% > 0 Then Print "...WITHOUT A DECLARATION OF WAR!    (Diplomatic trust: ";
                        penalty = -2 * ((dipl%(player%, owner%(i, j)) - 1) ^ 2) - 5
                        trust(player%) = trust(player%) + penalty / 100 + .05
                        diplaction%(player%, owner%(i, j)) = -1
                        dipl%(player%, owner%(i, j)) = 2
                        dipl%(owner%(i, j), player%) = 2
                        If human% > 0 Then Print Int(penalty + .5); "%)"
                    End If
                End If
                If human% > 0 Then
                    Print name$(owner%(i, j)); " defends the territory with"; army%(i, j); "soldiers."
                    Print "Defence bonuses:"; Int(terdefense(terrain%(i, j)) * 100 + .5); "% for terrain,"; fort%(i, j) * 30; "% for forts."
                End If
            End If
            GoSub revolt
            If owner%(i, j) <> original%(i, j) And Rnd < (revoltbonus / 5 / players%) And Int(rebels% * (1 - morale(owner%(i, j)) ^ 2)) > 0 And attack = 0 Then
                attack = rebels% * science(5, original%(i, j)) * revoltbonus * (1 - morale(owner%(i, j)) ^ 2) * (.9 + Rnd / 5)
                If human% > 0 Then
                    Print
                    Print "Location:"; j; i; "  ";
                    Color ownercolor%(owner%(i, j))
                    Print name$(owner%(i, j));
                    Color 7
                    Print "  (Original owner: ";
                    Color ownercolor%(original%(i, j))
                    Print name$(original%(i, j));
                    Color 7
                    Print ")"
                    Print "A rebellion breakes out in the occupied territory:"; Int(attack + .5); "rebels!"
                    Print name$(owner%(i, j)); " defends with"; army%(i, j); "soldiers."
                    Print "Defence bonuses:"; Int(terdefense(terrain%(i, j)) * 100 + .5); "% for terrain,"; fort%(i, j) * 30; "% for forts."
                End If
            End If
            If attack > 0 Then
                defend = army%(i, j) * science(5, owner%(i, j)) * (1 + terdefense(terrain%(i, j)) + fort%(i, j) * .3) * (.9 + Rnd / 5) + .001
                If owner%(i, j) = original%(i, j) Then
                    defend = defend + rebels%
                    army%(i, j) = army%(i, j) + rebels%
                    If human% > 0 And rebels% > 0 Then Print "The defender army is reinforced by"; rebels%; "volunteers."
                End If
                If attack > defend Then
                    If moved%(i, j) = 0 Then
                        If allfood&(player%) < 1 Then allfood&(player%) = foodpot(terrain%(i, j)) * 2
                        pop% = Int(population&(player%) * foodpot(terrain%(i, j)) / (allfood&(player%) + .001))
                        If human% > 0 Then
                            Print name$(owner%(i, j)); " loses the fight against the rebels.";
                            Color ownercolor%(original%(i, j))
                            Print " The territory is liberated."
                            Color 7
                            Print "Lost population:"; pop%
                            GoSub press
                        End If
                        owner%(i, j) = original%(i, j)
                        population&(player%) = population&(player%) - pop%
                        population&(owner%(i, j)) = population&(owner%(i, j)) + pop%
                        army%(i, j) = Int(attack - defend)
                    Else
                        If allfood&(owner%(i, j)) < 1 Then allfood&(owner%(i, j)) = foodpot(terrain%(i, j)) * 2
                        pop% = Int(population&(owner%(i, j)) * foodpot(terrain%(i, j)) / (allfood&(owner%(i, j)) + .001))
                        If human% > 0 Then
                            Color ownercolor%(player%)
                            Print name$(player%);
                            Color 7
                            Print " wins the battle, and conqueres the territory."
                            Print "Gained population:"; pop%
                            GoSub press
                        End If
                        population&(owner%(i, j)) = population&(owner%(i, j)) - pop%
                        population&(player%) = population&(player%) + pop%
                        army%(i, j) = Int(moved%(i, j) * (1 - defend / attack))
                        moved%(i, j) = 0
                        owner%(i, j) = player%
                    End If
                Else
                    If moved%(i, j) = 0 Then
                        If human% > 0 Then
                            Print "The guarding forces manage to supress the rebellion."
                            GoSub press
                        End If
                        army%(i, j) = Int(army%(i, j) * (1 - attack / defend))
                    Else
                        If human% > 0 Then
                            Print "The attacking forces lose the battle."
                            GoSub press
                        End If
                        army%(i, j) = Int(army%(i, j) * (1 - attack / defend))
                        moved%(i, j) = 0
                    End If
                End If
                If defend > 1 And attack > defend / 4 Then
                    a = Int(fort%(i, j) / 2 * Rnd + .5)
                    fort%(i, j) = fort%(i, j) - a
                    If human% > 0 And a > 0 Then
                        Print a; "forts are destroyed in the battle."
                        GoSub press
                    End If
                End If
            End If
        End If
    Next j
Next i
' sea battles
For i = 1 To players%
    If Rnd > .9 And dipl%(player%, i) = 1 And navy%(i) > 0 And navy%(player%) > 0 Then
        attack = navy%(player%) * science(5, player%) * science(4, player%) * (.9 + Rnd / 5)
        defend = navy%(i) * science(5, i) * science(4, i) * (.9 + Rnd / 5)
        If attack > defend Then
            navy%(player%) = Int(navy%(player%) * (1 - (defend / attack) ^ 2 / 3))
            navy%(i) = Int(navy%(i) * (1 - 1 / 3))
            If human% > 0 Then
                Color ownercolor%(player%)
                Print
                Print name$(player%);
                Color 7
                Print " wins a naval battle against "; name$(i); "."
                If control$(player%) = "human" Then Print "Losses:"; Int(100 * (defend / attack) ^ 2 / 3); "%"
                GoSub press
            End If
        Else
            navy%(i) = Int(navy%(i) * (1 - (attack / defend) ^ 2 / 3))
            navy%(player%) = Int(navy%(player%) * (1 - 1 / 3))
            If human% > 0 Then
                Print
                Print name$(player%); " loses a third of her fleet in a naval battle against ";
                Color ownercolor%(i)
                Print name$(i); "."
                Color 7
                GoSub press
            End If
        End If
        If seamoved%(player%) + seaarmy%(player%) > navy%(player%) Then
            seamoved%(player%) = 0
            seaarmy%(player%) = navy%(player%)
        End If
        If seamoved%(i) + seaarmy%(i) > navy%(i) Then
            seamoved%(i) = 0
            seaarmy%(i) = navy%(i)
        End If
    End If
    seaarmy%(i) = seaarmy%(i) + seamoved%(i)
    seamoved%(i) = 0
    If seaarmy%(i) > navy%(i) Then seaarmy%(i) = navy%(i)
Next i

'-- diplomacy --
For i = 1 To players%
    dipl%(i, i) = 5
    If land%(i) = 0 Then
        For j = 1 To players%
            dipl%(i, j) = 2
            dipl%(j, i) = 2
            dipl%(i, i) = 5
        Next j
    End If
    If diplaction%(player%, i) = -1 And dipl%(player%, i) > 1 And i <> player% Then
        dipl%(player%, i) = dipl%(player%, i) - 1
        dipl%(i, player%) = dipl%(player%, i)
        diplaction%(player%, i) = 0
        diplaction%(i, player%) = 0
        trust(player%) = trust(player%) - .05
        If human% > 0 Then
            Print
            Print name$(player%); " spoils her relationship with "; name$(i); " to: ";
            Select Case dipl%(player%, i)
                Case 1
                    Print "war!"
                Case 2
                    Print "neutrality."
                Case 3
                    Print "trade."
                Case 4
                    Print "friendship."
            End Select
            GoSub press
        End If
        If trust(player%) < 0 Then trust(player%) = 0
        If dipl%(player%, i) = 1 Then
            For j = 1 To players%
                If dipl%(i, j) = 5 And j <> i And dipl%(player%, j) > 1 Then
                    If human% > 0 Then
                        Print name$(j); ", as an ally of "; name$(i); ", declares war to "; name$(player%); "."
                        GoSub press
                    End If
                    dipl%(player%, j) = 1
                    dipl%(j, player%) = 1
                End If
                If dipl%(player%, j) = 5 And j <> player% And dipl%(i, j) > 1 Then
                    If human% > 0 Then
                        Print name$(j); ", as an ally of "; name$(player%); ", declares war to "; name$(i); "."
                        GoSub press
                    End If
                    dipl%(i, j) = 1
                    dipl%(j, i) = 1
                End If
            Next j
        End If
    End If
    prevent = 0
    For j = 1 To players%
        If dipl%(player%, j) = 1 And dipl%(i, j) = 5 Then prevent = 1
        If dipl%(player%, j) = 5 And dipl%(i, j) = 1 Then prevent = 1
    Next j
    If diplaction%(player%, i) = 1 And diplaction%(i, player%) = 1 And prevent = 0 And dipl%(player%, i) < 5 Then
        dipl%(player%, i) = dipl%(player%, i) + 1
        dipl%(i, player%) = dipl%(player%, i)
        diplaction%(player%, i) = 0
        diplaction%(i, player%) = 0
        If human% > 0 Then
            Print
            Print name$(player%); " and "; name$(i); " improve their relationship to: ";
            Select Case dipl%(player%, i)
                Case 2
                    Print "neutrality."
                Case 3
                    Print "trade."
                Case 4
                    Print "friendship."
                Case 5
                    Print "alliance!"
            End Select
            GoSub press
        End If
        If dipl%(player%, i) = 5 Then
            For j = 1 To players%
                If dipl%(i, j) = 1 And player% <> i And dipl%(player%, j) > 1 Then
                    If human% > 0 Then
                        Print name$(player%); ", as an ally of "; name$(i); ", declares war to "; name$(j); "."
                        GoSub press
                    End If
                    dipl%(player%, j) = 1
                    dipl%(j, player%) = 1
                End If
                If dipl%(player%, j) = 1 And i <> player% And dipl%(i, j) > 1 Then
                    If human% > 0 Then
                        Print name$(i); ", as an ally of "; name$(player%); ", declares war to "; name$(j); "."
                        GoSub press
                    End If
                    dipl%(i, j) = 1
                    dipl%(j, i) = 1
                End If
            Next j
        End If
    End If
    If dipl%(player%, i) = 1 Then
        For j = 1 To players%
            If dipl%(player%, j) = 5 And dipl%(i, j) > 1 And j <> player% Then
                If human% > 0 Then
                    Print
                    Print name$(j); ", as an ally of "; name$(player%); ", declares war to "; name$(i); "."
                    GoSub press
                End If
                dipl%(i, j) = 1
                dipl%(j, i) = 1
            End If
            If dipl%(i, j) = 5 And dipl%(player%, j) > 1 And j <> i Then
                If human% > 0 Then
                    Print
                    Print name$(j); ", as an ally of "; name$(i); ", declares war to "; name$(player%); "."
                    GoSub press
                End If
                dipl%(player%, j) = 1
                dipl%(j, player%) = 1
            End If
        Next j
    End If
Next i

For i = 1 To 15
    For j = 1 To 15
        If dipl%(owner%(i, j), original%(i, j)) = 5 And owner%(i, j) <> original%(i, j) Then
            If allfood&(owner%(i, j)) < 1 Then allfood&(owner%(i, j)) = foodpot(terrain%(i, j)) * 2
            pop% = Int(population&(owner%(i, j)) * foodpot(terrain%(i, j)) / allfood&(owner%(i, j)))
            population&(owner%(i, j)) = population&(owner%(i, j)) - pop%
            population&(original%(i, j)) = population&(original%(i, j)) + pop%
            popmoney% = Int(pop% * Rnd * 3)
            money&(owner%(i, j)) = money&(owner%(i, j)) + popmoney%
            If human% > 0 Then
                Print
                Print "Location:"; j; i
                Print name$(owner%(i, j)); " liberates a territory of her ally, ";
                Color ownercolor%(original%(i, j))
                Print name$(original%(i, j)); "!"
                Color 7
                Print "The grateful population sends "; popmoney%; "golds to "; name$(owner%(i, j)); "."
                GoSub press
            End If
            owner%(i, j) = original%(i, j)
        End If
    Next j
Next i


'-- other variables --
If trust(player%) <= .99 Then trust(player%) = trust(player%) + .01
GoSub countproperties
If control$(player%) = "human" And landtrade(player%) > land%(player%) Then
    Print
    Print "Thanks to your diplomatic relations with other empires, you can trade on"
    Print Int(landtrade(player%) / land%(player%) * 100); "% of the area of your own country."
    GoSub press
End If
For i = 1 To players%
    If dipl%(player%, i) > 2 And player% <> i Then
        For j = 1 To 6
            If (Rnd < ((dipl%(player%, i) - 2) ^ 2) * science(3, player%) / 100) And science(j, player%) < science(j, i) Then
                a = (science(j, i) - science(j, player%)) / 10
                science(j, player%) = science(j, player%) + a
                If control$(player%) = "human" Then
                    Print
                    Print "By copying an invention from "; name$(i); " your "; sciencename$(j); " develops by:";
                    Print Using "##.###"; a
                    GoSub press
                End If
            End If
        Next j
    End If
Next i
GoSub morale
GoSub professions
i = player%
GoSub finances
money&(player%) = money&(player%) + total&
If control$(player%) = "human" And human% > 0 Then
    Print
    Print "Change in your treasury:"; total&; "gold"
    Print
    GoSub press
End If

'-- reproduction --
allfood&(player%) = Int(allfood&(player%) * science(1, player%) + border%(player%, 0) * (1 + sea(player%)) * science(4, player%))
a = allfood&(player%) * 50 / (population&(player%) + .001)
If a > 2 Then a = 2
population&(player%) = Int(population&(player%) * (.9 + (a / 10)))
If control$(player%) = "human" Then
    If a > 1 Then
        Print "Your empire produced enough food for the population to grow by"; Int((a - 1) * 10); "%."
    Else
        Print "There is not enough food in your empire."; Int((1 - a) * 10); "% fell victim of starvation!"
    End If
End If
If morale(player%) < 1 Then
    population&(player%) = Int(population&(player%) * (1 - (1 - morale(player%)) ^ 2))
    If control$(player%) = "human" Then
        Print Int(((1 - morale(player%)) ^ 2) * 100); "% of the population leaves your land because of discontent."
    End If
End If
epidemic = 0
If land%(player%) > 0 Then epidemic = (Rnd / 10) * (population&(player%) / 250 / land%(player%)) / science(6, player%)
population&(player%) = Int(population&(player%) * (1 - epidemic))
If control$(player%) = "human" Then
    Print "Epidemics have"; Int(epidemic * 100); "% death toll in the country."
    GoSub press
End If
If population&(player%) < 0 Then population&(player%) = 0
If population&(player%) = 0 Then
    peasant&(player%) = 0
    fisher&(player%) = 0
    worker&(player%) = 0
    merchant&(player%) = 0
    soldier&(player%) = 0
    unemployed&(player%) = 0
    money&(player%) = 0
End If

'-- human player eliminated --
If control$(player%) = "human" Then
    If land%(player%) = 0 Then
        Cls
        Print "The last remains of your empire are conquered by the enemy,"
        Print "so the struggle for hegemony continues without you."
        control$(player%) = "default.ai"
        GoSub death
        GoSub press
    ElseIf population&(player%) <= 0 Then
        Cls
        Print "You have run out of population."
        Print "Hmmm, a rather funny way of political suicide..."
        control$(player%) = "default.ai"
        population&(player%) = 0
        GoSub death
        GoSub press
    ElseIf morale(player%) < .33 Then
        Cls
        Print "The discontent masses don't endure your tyranny any more."
        Print "A great revolution breaks out and sweeps your evil regime away."
        Print "The new leader begins with a neutral relationship to all empires."
        control$(player%) = "default.ai"
        GoSub neutral
        GoSub death
        GoSub press
    End If
Else
    If morale(player%) < .33 Then
        Color ownercolor%(player%)
        If human% > 0 Then
            Print
            Print "There is a revolution in "; name$(player%); "!"
            Color 7
            Print "The new leader begins with a neutral relationship to all empires."
            GoSub beethoven
            GoSub press
        End If
        GoSub neutral
    End If
End If
human% = 0
For i = 1 To players%
    If control$(i) = "human" Then human% = human% + 1
Next i

For i = 1 To players%
    If land%(i) = 0 Then
        navy%(i) = 0
        money&(i) = 0
        population&(i) = 0
        peasant&(i) = 0
        fisher&(i) = 0
        worker&(i) = 0
        merchant&(i) = 0
        soldier&(i) = 0
        seaarmy%(i) = 0
        unemployed&(i) = 0
    Else
        If population&(i) <= 0 Then population&(i) = allfood&(i) * 50
        If population&(i) <= 0 Then population&(i) = 1
        If soldier&(i) > population&(i) Then soldier&(i) = population&(i)
    End If
Next i

For i = 1 To 6
    sciencemoney&(i) = 0
Next i
message$ = "Welcome, Majesty."
If player% < players% Then
    player% = player% + 1
Else
    player% = 1
    turn% = turn% + 1
    revoltnation = Int(Rnd * players%) + 1
    revoltlevel = Rnd * Rnd * 10
End If
For i = 1 To players%
    diplaction%(player%, i) = 0
Next i
GoSub spy
If human% > 0 Then Cls
GoSub enemydistance
GoTo choosecontrol


'-----=====GOSUBS=====-----


chooseplayer:
For i = 1 To players%
    c$(i) = control$(i)
Next i
cprefresh:
Locate 12, 1
Print "Choose control for the empires."
Print: Print "     Empire   / Control             Best results      Turns          Date"
Line (0, 222)-(640, 222), 7
Open "bestturn.txt" For Input As #1
For i = 1 To players%
    Print i; "- "; name$(i); Spc(8 - Len(name$(i)));
    If c$(i) = "human" Then Color 15
    Print " / "; c$(i); "          "
    Color 7
    Input #1, bestname$(i)
    Input #1, bestturn(i)
    Input #1, bestcontrol$(i)
    Input #1, bestdate$(i)
    Locate (14 + i), 37
    Print bestcontrol$(i)
    Locate (14 + i), 55
    Print bestturn(i)
    Locate (14 + i), 67
    Print bestdate$(i)
Next i
Close
Print: Print " 0 - Let the game begin!"
Print: Print "Press a number."
k$ = ""
While k$ = ""
    k$ = InKey$
Wend
k = Val(k$)
If k <= players% Then
    If c$(k) = "human" Then
        c$(k) = control$(k)
        If c$(k) = "human" Then c$(k) = "default.ai"
    Else
        c$(k) = "human"
    End If
End If
If k$ <> "0" Then GoTo cprefresh
human% = 0
For i = 1 To players%
    If c$(i) = "human" Then human% = human% + 1
    control$(i) = c$(i)
Next i
Cls
Return


title:
Color 4
Print "HEGEMONY 3.0.e                             Copyright: Akos Ivanyi (21.07.2003)"
Color 15
Print "==============                                        ivanyiakos@hotmail.com"
Color 2
Print "The Game of the Middle Ages                           www.angelfire.com/ego/akos"
Color 7
Line (0, 50)-(640, 50), 7
For i = 1 To 15
    For j = 1 To 15
        Line (280 + j * 3, i * 3)-(281 + j * 3, 1 + i * 3), ownercolor%(owner%(i, j)), BF
    Next j
Next i
Return


countproperties:
allsea% = 0
allship% = 0
For i = 0 To players%
    land%(i) = 0
    fo%(i) = 0
    chu%(i) = 0
    uni%(i) = 0
    mil%(i) = 0
    allfood&(i) = 0
    soldier&(i) = 0
    sea(i) = 0
    For j = 0 To players%
        border%(i, j) = 0
    Next j
    allship% = allship% + navy%(i)
Next i

For i = 1 To 15
    For j = 1 To 15
        If owner%(i, j) = 0 Then allsea% = allsea% + 1
        land%(owner%(i, j)) = land%(owner%(i, j)) + 1
        fo%(owner%(i, j)) = fo%(owner%(i, j)) + fort%(i, j)
        chu%(owner%(i, j)) = chu%(owner%(i, j)) + church%(i, j)
        uni%(owner%(i, j)) = uni%(owner%(i, j)) + university%(i, j)
        mil%(owner%(i, j)) = mil%(owner%(i, j)) + mill%(i, j)
        allfood&(owner%(i, j)) = allfood&(owner%(i, j)) + foodpot(terrain%(i, j))
        soldier&(owner%(i, j)) = soldier&(owner%(i, j)) + army%(i, j)
        soldier&(player%) = soldier&(player%) + moved%(i, j)
        For k = 0 To players%
            a = 0
            If i > 1 Then
                If owner%(i - 1, j) = k Then a = a + 1
            End If
            If i < 15 Then
                If owner%(i + 1, j) = k Then a = a + 1
            End If
            If j > 1 Then
                If owner%(i, j - 1) = k Then a = a + 1
            End If
            If j < 15 Then
                If owner%(i, j + 1) = k Then a = a + 1
            End If
            border%(owner%(i, j), k) = border%(owner%(i, j), k) + a
        Next k
    Next j
Next i
For i = 1 To players%
    If allsea% = 0 Or allship% = 0 Then
        sea(i) = 0
    Else
        sea(i) = navy%(i) / allship%
    End If
    soldier&(i) = soldier&(i) + seaarmy%(i) + seamoved%(i)
    If land%(i) = 0 Then navy%(i) = 0
Next i

For i = 1 To players%
    landtrade(i) = 0
    For j = 1 To players%
        If dipl%(i, j) > 2 Then
            If border%(i, j) > 0 Then
                landtrade(i) = landtrade(i) + land%(j)
            Else
                landtrade(i) = landtrade(i) + land%(j) * sea(i)
            End If
        End If
    Next j
Next i
Return


professions:
For i = 1 To players%
    If land%(i) > 0 Then
        merchant&(i) = Int(population&(i) / 50 * science(3, i) * landtrade(i) / land%(i))
        If merchant&(i) > population&(i) / 5 Then merchant&(i) = Int(population&(i) / 5)
        worker&(i) = Int(population&(i) / 10 * science(2, i))
        If worker&(i) > population&(i) * .5 Then worker&(i) = Int(population&(i) * .5)
        peasant&(i) = Int((population&(i) - soldier&(i) - merchant&(i) - worker&(i)) / (allfood&(i) * science(1, i) + border%(i, 0) * (1 + sea(i)) * science(4, i) + .0001) * allfood&(i) * science(1, i))
        If peasant&(i) > allfood&(i) * science(1, i) * 80 Then peasant&(i) = Int(allfood&(i) * science(1, i) * 80)
        fisher&(i) = Int(population&(i) - soldier&(i) - merchant&(i) - worker&(i) - peasant&(i))
        If fisher&(i) > border%(i, 0) * (1 + sea(i)) * science(4, i) * 25 Then fisher&(i) = Int(border%(i, 0) * (1 + sea(i)) * science(4, i) * 25)
        unemployed&(i) = population&(i) - soldier&(i) - merchant&(i) - worker&(i) - peasant&(i) - fisher&(i)
        If unemployed&(i) < 0 Then unemployed&(i) = 0
    End If
Next i
Return


morale:
For i = 1 To players%
    morale(i) = 0
Next i
For i = 1 To 15
    For j = 1 To 15
        If owner%(i, j) <> 0 Then
            pop% = Int(population&(owner%(i, j)) * foodpot(terrain%(i, j)) / (allfood&(owner%(i, j)) + .001))
            bonus = church%(i, j) * 20 / (pop% + .001)
            If bonus > 1 Then bonus = 1
            localmorale(i, j) = (1 - tax(owner%(i, j)) * 2) * (1 - unemployed&(owner%(i, j)) / (population&(owner%(i, j)) + .001)) * (1 + bonus) * (.5 + trust(owner%(i, j)) / 2)
            If money&(owner%(i, j)) < 0 Then localmorale(i, j) = localmorale(i, j) + money&(owner%(i, j)) / 10 / (population&(owner%(i, j)) + .001)
            If localmorale(i, j) > 1 Then localmorale(i, j) = 1
            If original%(i, j) <> owner%(i, j) Then localmorale(i, j) = localmorale(i, j) - .1
            If localmorale(i, j) < 0 Then localmorale(i, j) = 0
            morale(owner%(i, j)) = morale(owner%(i, j)) + localmorale(i, j)
        End If
    Next j
Next i
For i = 1 To players%
    If land%(i) = 0 Then morale(i) = 1 Else morale(i) = morale(i) / land%(i)
Next i
Return


science:
sciencerefresh:
Cls
GoSub title
Locate 7, 1
Print "Agricult"
Print "Industry"
Print "Trade"
Print "Sailing"
Print "Military"
Print "Medicine"
For i = 1 To players%
    Color ownercolor%(i)
    a = 1 + i * 8
    Locate 5, a
    Print name$(i)
    If spy%(i) > 0 Then
        For j = 1 To 6
            Locate (6 + j), a
            Print Int(science(j, i) * 1000) / 1000;
        Next j
    End If
Next i
Locate 14, 1
Color 14
Print "Your money:"; money&(player%); "       "
Color 7
Print
For i = 1 To 6
    aa& = Int(science(i, player%) ^ 3 * 1000)
    If sciencemoney&(i) < aa& Then Color 7 Else Color 4
    Print "Spent on "; sciencename$(i); ":"; sciencemoney&(i); "    ";
    Locate 15 + i, 30
    Print i; "= spend 100;  "; Chr$(96 + i); " = spend 1000  (max:"; aa&; ")    "
Next i
Locate 28, 1
Color 7
Print "    Agriculture   Industry      Trade       Sailing     Military    Medicine"
max = 0
For i = 1 To players%
    For j = 1 To 6
        If science(j, i) > max Then max = science(j, i)
    Next j
Next i
For i = 1 To players%
    If spy%(i) > 0 Then
        For j = 1 To 6
            Line (-50 + j * 100 + i * 5, 430)-(-50 + j * 100 + i * 5, 430 - science(j, i) / max * 90), ownercolor%(i)
        Next j
    End If
Next i
k$ = ""
While k$ = ""
    k$ = InKey$
Wend
Select Case k$
    Case "1" TO "6"
        sciencemoney&(Val(k$)) = sciencemoney&(Val(k$)) + 100
        money&(player%) = money&(player%) - 100
    Case "a" TO "f"
        sciencemoney&(Asc(k$) - 96) = sciencemoney&(Asc(k$) - 96) + 1000
        money&(player%) = money&(player%) - 1000
    Case Else
        Cls
        Return
End Select
GoTo sciencerefresh


treasury:
treasuryrefresh:
Cls
GoSub countproperties
GoSub professions
GoSub morale
GoSub title
Locate 5, 1
Print "FLOW OF"
Print "COINS:"
Print
Print "Peasants"
Print "Fishers"
Print "Workers"
Print "Merchant"
Print "Mills..."
Print
Print "Interest"
Print
Print "Forts"
Print "Churches"
Print "Univers."
Print "Navy"
Print "Army"
Print
Print "Total"
Print
Print
Print "TREASURY"
Print
Print
Color ownercolor%(player%)
Print "Tax rate:"; Int(tax(player%) * 100 + .5); "%      Morale:"; Int(morale(player%) * 100 + .5); "%      ";
Color 7
Print "t = reduce tax      T = raise tax"
For i = 1 To players%
    GoSub finances
    Color ownercolor%(i)
    a = 1 + i * 8
    Locate 5, a
    Print name$(i)
    If spy%(i) > 0 Then
        Locate 8, a
        Print peas&
        Locate 9, a
        Print fish&
        Locate 10, a
        Print work&
        Locate 11, a
        Print merc&
        Locate 12, a
        Print mmil&
        Locate 14, a
        Print interest&
        Locate 16, a
        Print mfor&
        Locate 17, a
        Print mchu&
        Locate 18, a
        Print muni&
        Locate 19, a
        Print mnav&
        Locate 20, a
        Print marm&
        Locate 22, a
        Print total&
        Locate 25, a
        Print money&(i)
    End If
Next i
Color 7
k$ = ""
While k$ = ""
    k$ = InKey$
Wend
Select Case k$
    Case "t"
        tax(player%) = tax(player%) - .01
        If tax(player%) < 0 Then tax(player%) = 0
    Case "T"
        tax(player%) = tax(player%) + .01
        If tax(player%) > 1 Then tax(player%) = 1
    Case Else
        Cls
        Return
End Select
GoTo treasuryrefresh


finances:
peas& = Int(peasant&(i) * tax(i) * morale(i) * science(1, i) * 4)
fish& = Int(fisher&(i) * tax(i) * morale(i) * science(4, i) * 4)
work& = Int(worker&(i) * tax(i) * morale(i) * science(2, i) * 8)
merc& = Int(merchant&(i) * tax(i) * morale(i) * science(3, i) * 16)
mmil& = -Int(mil%(i) * science(2, i) * mm)
If money&(i) > 0 Then
    interest& = Int(money&(i) * .04)
Else
    interest& = Int(money&(i) * .12)
End If
mfor& = -Int(fo%(i) * mf)
mchu& = -Int(chu%(i) * mc)
muni& = -Int(uni%(i) * mu)
mnav& = -Int(navy%(i) * mn)
marm& = -Int(soldier&(i) * ma)
total& = peas& + fish& + work& + merc& + mmil& + interest& + mfor& + mchu& + muni& + mnav& + marm&
Return


diplomacy:
change% = 1
diplomacyrefresh:
Cls
GoSub title
GoSub countproperties
GoSub spycost
Locate 5, 1
Print "Diplomatic relations"
Print "--------------------"
Locate 10, 1
For i = 1 To players%
    Color ownercolor%(i)
    Print name$(i)
Next i
Color ownercolor%(player%)
Print
Print "Your"
Print "attitude"
Print
Print "Your"
Print "Info"
For i = 1 To players%
    Color ownercolor%(i)
    a = 1 + i * 8
    Locate 7, a
    Print "("; i; ")"
    Locate 8, a
    Print name$(i)
    For j = 1 To players%
        Locate (9 + j), a
        Select Case dipl%(i, j)
            Case 1
                Print "war"
            Case 2
                Print "neutr."
            Case 3
                Print "trade"
            Case 4
                Print "friend"
            Case 5
                Print "ally"
        End Select
        Locate 21, (a + 2)
        If diplaction%(player%, i) = -1 Then Print "-";
        If diplaction%(player%, i) = 0 Then Print "0";
        If diplaction%(player%, i) = 1 Then Print "+";
        Locate 24, a
        If spy%(i) = 0 Then Print "none"
        If spy%(i) = 1 Then Print "general"
        If spy%(i) = 2 Then Print "full"
    Next j
Next i
Color 7
Locate 26, 1
Print "1-9 = choose target country (currently: ";
Color ownercolor%(change%)
Print name$(change%);
Color 7
Print ")"
Print "Change attitude:   + = positive,   - = negative,   0 = neutral"
Print "Spying:  g = general info ";
Select Case spy%(change%)
    Case 0
        Print "("; Int(spycost%(change%) / 2); " gold)";
    Case Else
        Print "(you already have)";
End Select
Print "   f = full info ";
Select Case spy%(change%)
    Case 0
        Print "("; spycost%(change%); " gold)"
    Case 1
        Print "("; Int(spycost%(change%) / 2); " gold)"
    Case Else
        Print "(you already have)"
End Select

k$ = ""
While k$ = ""
    k$ = InKey$
Wend
Select Case k$
    Case "1" TO "9"
        change% = Val(k$)
    Case "+"
        diplaction%(player%, change%) = 1
    Case "0"
        diplaction%(player%, change%) = 0
    Case "-"
        diplaction%(player%, change%) = -1
    Case "g"
        If spy%(change%) = 0 Then
            money&(player%) = money&(player%) - spycost%(change%) / 2
            spy%(change%) = 1
        End If
    Case "f"
        If spy%(change%) = 0 Then
            money&(player%) = money&(player%) - spycost%(change%)
        ElseIf spy%(change%) = 1 Then
            money&(player%) = money&(player%) - spycost%(change%) / 2
        End If
        spy%(change%) = 2
    Case Else
        Cls
        Return
End Select
GoTo diplomacyrefresh


spycost:
For i = 1 To players%
    spycost%(i) = Int((5 - dipl%(i, player%)) ^ 2 * 10 * land%(i))
Next i
Return


spy:
For i = 1 To players%
    Select Case dipl%(player%, i)
        Case 1 TO 2
            spy%(i) = 0
        Case 3 TO 4
            spy%(i) = 1
        Case 5
            spy%(i) = 2
    End Select
Next i
Return


see:
see% = 0
If spy%(owner%(y, x)) = 2 Then see% = 1
If y > 1 Then
    If owner%(y - 1, x) = player% Then see% = 1
End If
If y < 15 Then
    If owner%(y + 1, x) = player% Then see% = 1
End If
If x > 1 Then
    If owner%(y, x - 1) = player% Then see% = 1
End If
If x < 15 Then
    If owner%(y, x + 1) = player% Then see% = 1
End If
If owner%(y, x) = 0 Then see% = 0
Return


press:
While InKey$ = "": Wend
Return


savegame:
save$ = "save" + Right$(Str$(save%), Len(Str$(save%)) - 1) + ".scn"
Open save$ For Output As #1
Print #1, players%
Print #1, player%
Print #1, turn%
For i = 1 To 6
    Print #1, sciencemoney&(i)
Next i
For i = 1 To players%
    Print #1, name$(i)
    Print #1, control$(i)
    Print #1, population&(i)
    Print #1, money&(i)
    Print #1, navy%(i)
    Print #1, seaarmy%(i)
    Print #1, seamoved%(i)
    Print #1, tax(i)
    Print #1, trust(i)
    For j = 1 To 6
        Print #1, science(j, i)
    Next j
    For j = 1 To players%
        Print #1, dipl%(i, j)
    Next j
    For j = 1 To players%
        Print #1, diplaction%(i, j)
    Next j
Next i
For k = 1 To 9
    For i = 1 To 15
        For j = 1 To 15
            Select Case k
                Case 1
                    Print #1, owner%(i, j);
                Case 2
                    Print #1, original%(i, j);
                Case 3
                    Print #1, terrain%(i, j);
                Case 4
                    Print #1, fort%(i, j);
                Case 5
                    Print #1, church%(i, j);
                Case 6
                    Print #1, university%(i, j);
                Case 7
                    Print #1, mill%(i, j);
                Case 8
                    Print #1, army%(i, j);
                Case 9
                    Print #1, moved%(i, j);
            End Select
        Next j
        Print #1,
    Next i
Next k
Close
message$ = "Saved as: " + save$
save% = save% + 1
Return


help:
helprefresh:
Cls
GoSub title
Locate 6, 1
Print "HELP"
Print "----"
Print "1 - About the game"
Print "2 - How to play?"
Print "3 - Money matters (income, costs, investments)"
Print "4 - Professions"
Print "5 - Science and development"
Print "6 - Diplomacy"
Print "7 - Military and war"
Print "8 - Other things to know..."
Print "9 - Back to the game"
k = 0
While k = 0
    k = Val(InKey$)
Wend
Cls
Select Case k
    Case 1
        help$ = "about.hlp"
    Case 2
        help$ = "how.hlp"
    Case 3
        help$ = "money.hlp"
    Case 4
        help$ = "jobs.hlp"
    Case 5
        help$ = "science.hlp"
    Case 6
        help$ = "dipl.hlp"
    Case 7
        help$ = "military.hlp"
    Case 8
        help$ = "other.hlp"
    Case 9
        Cls
        Return
End Select

If k <> 9 Then
    linesmax = 0
    Open help$ For Input As #1
    Do Until EOF(1)
        Line Input #1, memo$
        linesmax = linesmax + 1
    Loop
    Close
    memo$ = ""
    upper = 1: lower = 25

    hscroll:
    lines = 0
    Cls
    Locate 1, 1
    Open help$ For Input As #1
    Do Until EOF(1)
        lines = lines + 1
        Line Input #1, text$
        If lines >= upper And lines <= lower Then Print text$
        If lines > lower Then Exit Do
    Loop
    Close
    Locate 28, 1
    Print "Possible keys:  Page up, Page down, Arrow up, Arrow down, Escape..."
    Line (0, 420)-(640, 420), ownercolor%(player%)
 
    waitforkey:
    nothing = 0
    k$ = InKey$
    If k$ = (Chr$(0) + "H") Then
        If upper > 1 Then
            upper = upper - 1
            lower = lower - 1
            GoTo hscroll
        End If
    ElseIf k$ = (Chr$(0) + "P") Then
        If lower < linesmax Then
            upper = upper + 1
            lower = lower + 1
            GoTo hscroll
        End If
    ElseIf k$ = (Chr$(0) + Chr$(73)) Then
        upper = upper - 24
        lower = lower - 24
        If upper < 1 Then upper = 1
        If lower < 25 Then lower = 25
    ElseIf k$ = (Chr$(0) + Chr$(81)) Then
        upper = upper + 24
        lower = lower + 24
        If upper > linesmax - 24 Then upper = linesmax - 24
        If lower > linesmax Then lower = linesmax
    Else
        nothing = 1
    End If
    If k$ = Chr$(27) Then
        GoTo helprefresh
    ElseIf nothing = 1 Then
        GoTo waitforkey
    Else
        GoTo hscroll
    End If
End If
GoTo helprefresh


info:
Cls
GoSub countproperties
GoSub professions
GoSub morale
GoSub title
Locate 7, 1
Print "Land"
Print "Sea"
Print "Popul."
Print "Money"
Print: Print "Tax"
Print "Morale"
Print "Trust"
Print: Print "Forts"
Print "Church"
Print "Univer."
Print "Mills"
Print "Ships"
Print: Print "Peasant"
Print "Fisher"
Print "Worker"
Print "Merchant"
Print "Soldier"
Color 8
Print "Embarked"
Color 7
Print "Unempl."
For i = 1 To players%
    Color ownercolor%(i)
    a = 1 + i * 8
    Locate 5, a
    Print name$(i)
    Locate 7, a
    Print land%(i)
    If spy%(i) > 0 Then
        Locate 8, a
        Print Int(sea(i) * 100 + .5); "%"
        Locate 9, a
        Print population&(i)
        Locate 10, a
        Print money&(i)
        Locate 12, a
        Print Int(tax(i) * 100 + .5); "%"
        Locate 13, a
        Print Int(morale(i) * 100 + .5); "%"
    End If
    Locate 14, a
    Print Int(trust(i) * 100 + .5); "%"
    If spy%(i) > 0 Then
        Locate 16, a
        Print fo%(i)
        Locate 17, a
        Print chu%(i)
        Locate 18, a
        Print uni%(i)
        Locate 19, a
        Print mil%(i)
        Locate 20, a
        Print navy%(i)
        Locate 22, a
        Print peasant&(i)
        Locate 23, a
        Print fisher&(i)
        Locate 24, a
        Print worker&(i)
        Locate 25, a
        Print merchant&(i)
        Locate 26, a
        Print soldier&(i)
        Locate 27, a
        Print seaarmy%(i) + seamoved%(i)
        Locate 28, a
        Print unemployed&(i)
    End If
Next i
GoSub press
Cls
Return


bye:
Cls
Locate 14, 24
Print "Would you like to play a new game?"
k$ = InKey$
While k$ <> "y" And k$ <> "n"
    k$ = InKey$
Wend
If k$ = "y" Then GoTo opening:
Cls
Color (Rnd * 14 + 1)
Locate Rnd * 28 + 1, Rnd * 74 + 1
Print "BYE!"
GoSub dragnet
Sleep 1
System
End


aicombat:
If active% = 1 Then GoTo victory
If land%(player%) = 0 Then
    While land%(player%) = 0
        If player% < players% Then
            player% = player% + 1
        Else
            player% = 1
            turn% = turn% + 1
        End If
    Wend
End If
Line (30, 400)-(110, 100), 0, BF
Line (510, 400)-(590, 100), 0, BF
Locate 1, 1
GoSub title
GoSub drawmap
Locate 5, 35
Print "AI COMBAT"
Locate 6, 25
Print "Turn:"; turn%
Locate 6, 45
Color ownercolor%(player%)
Print name$(player%); "    "
Color 7
maxprop& = 0
maxsc = 0
For i = 1 To players%
    property&(i) = fo%(i) * BF + chu%(i) * bc + uni%(i) * bu + mil%(i) * bm + navy%(i) * bn + soldier&(i) * ba + money&(i)
    level(i) = 0
    For j = 1 To 6
        level(i) = level(i) + science(j, i)
    Next j
    level(i) = level(i) / 6
    If property&(i) > maxprop& Then maxprop& = property&(i)
    If level(i) > maxsc Then maxsc = level(i)
Next i
For i = 1 To players%
    Line (20 + i * 10, 400)-(20 + i * 10, 400 - property&(i) / maxprop& * 300), ownercolor%(i)
    Line (500 + i * 10, 400)-(500 + i * 10, 400 - level(i) / maxsc * 300), ownercolor%(i)
Next i
Locate 27, 1
Print "Value of properties                                        Average science level"
Locate 27, 35
Print save$
Locate 6, 1
Print " max ="; maxprop&; "gold  "
Locate 6, 63
Print " max ="; Int(maxsc * 1000) / 1000; "   "
Locate 28, 21
Print "n = next player      N = next turn"
Locate 29, 21
Print "s = save             q = quit";
If turn% < nextturn Then GoTo ai
k$ = InKey$
While k$ <> "n" And k$ <> "N" And k$ <> "s" And k$ <> "q"
    k$ = InKey$
Wend
nextturn = 0
If k$ = "N" Then nextturn = turn% + 1
If k$ = "n" Or k$ = "N" Then GoTo ai
If k$ = "s" Then GoSub savegame
If k$ = "q" Then GoTo bye
GoTo aicombat


victory:
For i = 1 To players%
    If land%(i) > 0 Then winner% = i
Next i
Cls
GoSub title
GoSub drawmap
Locate 14, 4
Print "HEGEMONY!!!"
Print "   -----------"
Locate 14, 61
Print "HEGEMONY!!!"
Locate 15, 61
Print "-----------"
Locate 5, 1
Color 15
Print "        Eternal glory to the victorious leader of "; name$(winner%); ", the most"
Print "    magnificent emperor in history, who brought us unity, peace and wealth!"
Locate 26, 1
Color 8
Print "   (The vicious oppressor shall burn in the flames of hell forever, for all"
Print "                    the sorrow and misery he caused us!)"
GoSub organ
GoSub press
Open "bestturn.txt" For Input As #1
For i = 1 To players%
    Input #1, bestname$(i)
    Input #1, bestturn(i)
    Input #1, bestcontrol$(i)
    Input #1, bestdate$(i)
Next i
Close
If bestturn(winner%) >= turn% Then
    bestname$(winner%) = name$(winner%)
    bestturn(winner%) = turn%
    bestcontrol$(winner%) = control$(winner%)
    bestdate$(winner%) = Date$
    Open "bestturn.txt" For Output As #1
    For i = 1 To players%
        Write #1, bestname$(i), bestturn(i), bestcontrol$(i), bestdate$(i)
    Next i
    Close
End If
GoTo bye


debt:
For i = 1 To players%
    diplaction%(player%, i) = 1
Next i
money&(player%) = money&(player%) + sn * navy%(player%)
navy%(player%) = 0
If money&(player%) < 0 Then
    For i = 1 To 15
        For j = 1 To 15
            If owner%(i, j) = player% And threat(i, j) = (-1) * army%(i, j) * (1 + terdefense(terrain%(i, j)) + fort%(i, j) * .3) Then
                money&(player%) = money&(player%) + sf * fort%(i, j)
                fort%(i, j) = 0
            End If
            If owner%(i, j) = player% And army%(i, j) > 1 Then
                a = Int(army%(i, j) / 10)
                If enemyvalue = 0 Then a = a * 3
                If a = 0 And army%(i, j) > 1 Then a = 1
                army%(i, j) = army%(i, j) - a
                money&(player%) = money&(player%) + sa * a
            End If
            If owner%(i, j) = player% And university%(i, j) > 0 Then
                If original%(i, j) <> player% Or Rnd < .5 Then
                    university%(i, j) = university%(i, j) - 1
                    money&(player%) = money&(player%) + su
                End If
            End If
        Next j
    Next i
End If
Return


military:
i = player%
GoSub finances
If total& < 0 Then Return
If Rnd > landorsea And sea(player%) < .6 And (navy%(player%) < (10 * (1 - landorsea) * soldier&(player%)) Or sea(player%) < (1 / active%)) And landenemy% = 0 Then
    'sea forces
    'effects of a 10000 gold invention: a=navy, b=sailing, c=military
    a = 10000 / (bn + planning * mn) * science(4, player%) * science(5, player%)
    B = (1 + uni%(player%) / (population&(player%) + .001) * 50) / (science(4, player%) ^ 3) * navy%(player%) * science(5, player%)
    c = (1 + uni%(player%) / (population&(player%) + .001) * 50) / (science(5, player%) ^ 3) * navy%(player%) * science(4, player%)
    If a > B And a > c Then
        d = Int(spend& / bn)
        navy%(player%) = navy%(player%) + d
        money&(player%) = money&(player%) - d * bn
    ElseIf B > a And B > c Then
        d = Int(science(4, player%) ^ 3 * 1000)
        If spend& < d Then d = spend&
        sciencemoney&(4) = d
        money&(player%) = money&(player%) - d
    Else
        d = Int(science(5, player%) ^ 3 * 1000)
        If spend& < d Then d = spend&
        sciencemoney&(5) = d
        money&(player%) = money&(player%) - d
    End If
Else
    'land forces
    'effects of a 10000 gold invention: a=forts, b=soldiers, c=military
    a = 10000 / (BF + planning * mf) * .3 * soldier&(player%) * science(5, player%)
    B = 10000 / (ba + planning * ma) * (1 + fo%(player%) * .3) * science(5, player%)
    c = (1 + uni%(player%) / (population&(player%) + .001) * 50) / (science(5, player%) ^ 3) * (1 + fo%(player%) * .3) * soldier&(player%)
    If c > a And c > B Then
        'develop military
        d = Int(science(5, player%) ^ 3 * 1000)
        If spend& < d Then d = spend&
        sciencemoney&(5) = d
        money&(player%) = money&(player%) - d
    Else
        'build forts
        For i = 1 To 15
            For j = 1 To 15
                a = 10000 / (BF + planning * mf) * .3 * army%(i, j)
                B = 10000 / (ba + planning * ma) * (1 + fort%(i, j) * .3)
                If a > B And owner%(i, j) = player% And threat(i, j) > 0 And spend& >= BF Then
                    fort%(i, j) = fort%(i, j) + 1
                    money&(player%) = money&(player%) - BF
                    spend& = spend& - BF
                End If
            Next j
        Next i
        'build army
        If maxthreat > 0 And spend& >= ba Then
            If maxthreat > (spend& / ba) Then d = Int(spend& / ba) Else d = Int(maxthreat)
            e& = population&(player%) - soldier&(player%)
            If e& < d Then d = e&
            army%(threati, threatj) = army%(threati, threatj) + d
            money&(player%) = money&(player%) - d * ba
            spend& = spend& - d * ba
        End If
        For i = 1 To 15
            For j = 1 To 15
                If owner%(i, j) = player% And threat(i, j) > 0 And spend& >= ba Then
                    If maxthreat > spend& / ba Then d = Int(spend& / ba) Else d = Int(maxthreat)
                    army%(i, j) = army%(i, j) + d
                    money&(player%) = money&(player%) - d * ba
                    spend& = spend& - d * ba
                End If
            Next j
        Next i
        For i = 1 To 15
            For j = 1 To 15
                If owner%(i, j) = player% And spend& >= ba Then
                    d = Int(spend& / ba / land%(player%)) + 1
                    army%(i, j) = army%(i, j) + d
                    money&(player%) = money&(player%) - d * ba
                    spend& = spend& - d * ba
                End If
            Next j
        Next i
    End If
End If
Return


building:
spendchurch& = money&(player%) * aichurch
spendmill& = money&(player%) * aimill
spendnavy& = money&(player%) * ainavy
round = 0
buildmore:
For i = 1 To 15
    For j = 1 To 15
        If owner%(i, j) = player% Then
            If (ownmill% = 0 And original%(i, j) = player%) Or ownmill% = 1 Then
                If mill%(i, j) < prodpot(terrain%(i, j)) And spendmill& >= bm Then
                    mill%(i, j) = mill%(i, j) + 1
                    spendmill& = spendmill& - bm
                    money&(player%) = money&(player%) - bm
                End If
            End If
            maxmor = .5 + trust(player%) / 2
            If money&(player%) < 0 Then maxmor = maxmor + money&(player%) / 10 / population&(player%)
            If original%(i, j) <> player% Then maxmor = maxmor - .1
            If maxmor < 0 Then maxmor = 0
            a = (1 - localmorale(i, j)) * 2
            If original%(i, j) <> player% Then
                If localmorale(i, j) + .005 < maxmor Then
                    a = 1
                Else
                    a = 0
                End If
            End If
            If Rnd < a Then
                If spendchurch& >= bc Then
                    church%(i, j) = church%(i, j) + 1
                    spendchurch& = spendchurch& - bc
                    money&(player%) = money&(player%) - bc
                End If
            End If
        End If
    Next j
Next i
round = round + 1
If (spendmill& > bm Or spendchurch& > bc) And round < 5 Then GoTo buildmore
i = player%
GoSub finances
If sea(player%) < .6 And (navy%(player%) < (10 * (1 - landorsea) * soldier&(player%)) Or sea(player%) < (1 / active%)) And total& > 0 Then
    a = Int(spendnavy& / bn)
    navy%(player%) = navy%(player%) + a
    money&(player%) = money&(player%) - a * bn
End If
Return


developscience:
If aiuni > Rnd Then
    If unii > 0 And unij > 0 Then
        a = Int(money&(player%) / bu)
        university%(unii, unij) = university%(unii, unij) + a
        money&(player%) = money&(player%) - a * bu
    End If
Else
    For i = 1 To 6
        aa& = Int(science(i, player%) ^ 3 * 1000) - sciencemoney&(i)
        bb& = Int(money&(player%) * aiscience(i))
        If unemployed&(player%) > 6 And i = 6 Then bb& = 0
        If bb& > aa& Then
            sciencemoney&(i) = sciencemoney&(i) + aa&
            money&(player%) = money&(player%) - aa&
        Else
            sciencemoney&(i) = sciencemoney&(i) + bb&
            money&(player%) = money&(player%) - bb&
        End If
    Next i
End If
Return


drawmap:
For i = 1 To 15
    For j = 1 To 15
        Line (130 + j * 20, 80 + i * 20)-(150 + j * 20, 100 + i * 20), 0, B
        Line (131 + j * 20, 81 + i * 20)-(149 + j * 20, 99 + i * 20), tercolor(terrain%(i, j)), BF
        If owner%(i, j) <> 0 Then Line (145 + j * 20, 95 + i * 20)-(150 + j * 20, 100 + i * 20), 0, B
        If owner%(i, j) <> 0 Then Line (146 + j * 20, 96 + i * 20)-(150 + j * 20, 100 + i * 20), ownercolor%(owner%(i, j)), BF
    Next j
Next i
Return


neutral:
For i = 1 To players%
    If i <> player% Then
        dipl%(player%, i) = 2
        dipl%(i, player%) = 2
    End If
Next i
If money&(player%) < 0 Then
    money&(player%) = money&(player%) + sn * navy%(player%)
    navy%(player%) = 0
End If
If money&(player%) < 0 Then
    For i = 1 To 15
        For j = 1 To 15
            If owner%(i, j) = player% Then
                army%(i, j) = Int(army%(i, j) / 2)
                money&(player%) = money&(player%) + sa * army%(i, j)
                university%(i, j) = Int(university%(i, j) / 2)
                money&(player%) = money&(player%) + su * university%(i, j)
                fort%(i, j) = Int(fort%(i, j) / 2)
                money&(player%) = money&(player%) + sf * fort%(i, j)
                If church%(i, j) > 5 Then church%(i, j) = church%(i, j) - 1
                money&(player%) = money&(player%) + sc
            End If
        Next j
    Next i
End If
If money&(player%) < 0 Then money&(player%) = Int(Rnd * 1000)
GoSub countproperties
population&(player%) = allfood&(player%) * 50
Return


revolt:
revoltbonus = 1
a = original%(i, j)
If i > 1 Then
    B = owner%(i - 1, j)
    c = original%(i - 1, j)
    If a = c And B = c Then revoltbonus = revoltbonus + 1
End If
If i < 15 Then
    B = owner%(i + 1, j)
    c = original%(i + 1, j)
    If a = c And B = c Then revoltbonus = revoltbonus + 1
End If
If j > 1 Then
    B = owner%(i, j - 1)
    c = original%(i, j - 1)
    If a = c And B = c Then revoltbonus = revoltbonus + 1
End If
If j < 15 Then
    B = owner%(i, j + 1)
    c = original%(i, j + 1)
    If a = c And B = c Then revoltbonus = revoltbonus + 1
End If
If revoltnation = original%(i, j) Then revoltbonus = revoltbonus + revoltlevel
Return


enemydistance:
For i = 1 To 15
    For j = 1 To 15
        If owner%(i, j) = 0 Then ed%(i, j) = 0 Else ed%(i, j) = 99
        If i > 1 Then
            If owner%(i - 1, j) = 0 And ed%(i, j) > 1 Then ed%(i, j) = 1
            If ed%(i, j) > dipl%(owner%(i - 1, j), owner%(i, j)) - 1 And owner%(i - 1, j) <> 0 And owner%(i, j) <> 0 Then ed%(i, j) = dipl%(owner%(i - 1, j), owner%(i, j)) - 1
        End If
        If i < 15 Then
            If owner%(i + 1, j) = 0 And ed%(i, j) > 1 Then ed%(i, j) = 1
            If ed%(i, j) > dipl%(owner%(i + 1, j), owner%(i, j)) - 1 And owner%(i + 1, j) <> 0 And owner%(i, j) <> 0 Then ed%(i, j) = dipl%(owner%(i + 1, j), owner%(i, j)) - 1
        End If
        If j > 1 Then
            If owner%(i, j - 1) = 0 And ed%(i, j) > 1 Then ed%(i, j) = 1
            If ed%(i, j) > dipl%(owner%(i, j - 1), owner%(i, j)) - 1 And owner%(i, j - 1) <> 0 And owner%(i, j) <> 0 Then ed%(i, j) = dipl%(owner%(i, j - 1), owner%(i, j)) - 1
        End If
        If j < 15 Then
            If owner%(i, j + 1) = 0 And ed%(i, j) > 1 Then ed%(i, j) = 1
            If ed%(i, j) > dipl%(owner%(i, j + 1), owner%(i, j)) - 1 And owner%(i, j + 1) <> 0 And owner%(i, j) <> 0 Then ed%(i, j) = dipl%(owner%(i, j + 1), owner%(i, j)) - 1
        End If
    Next j
Next i
For k = 1 To 9
    For i = 1 To 15
        For j = 1 To 15
            If i > 1 Then
                If ed%(i - 1, j) + 1 < ed%(i, j) Then ed%(i, j) = ed%(i - 1, j) + 1
            End If
            If i < 15 Then
                If ed%(i + 1, j) + 1 < ed%(i, j) Then ed%(i, j) = ed%(i + 1, j) + 1
            End If
            If j > 1 Then
                If ed%(i, j - 1) + 1 < ed%(i, j) Then ed%(i, j) = ed%(i, j - 1) + 1
            End If
            If j < 15 Then
                If ed%(i, j + 1) + 1 < ed%(i, j) Then ed%(i, j) = ed%(i, j + 1) + 1
            End If
        Next j
    Next i
Next k
Return


beethoven:
'Beethoven's Fifth
Play "T180 o2 P2 P8 L8 GGG L2 E-"
Play "P24 P8 L8 FFF L2 D"
Return


death:
'Dead March from Saul
Play "l8t200mlo1c..p16c.p32cp32c.p8e..dp32d.cp32c.o0bo1c..mn"
Return


dragnet:
'Dragnet
Play "t255o2l2cl8dd#p8cp8l2f#"
Return


organ:
Play "T110ML"
Play "O2e-16c16e-16g16O3c16e-16d16c16O2b16g16b16O3d16g16f16e-16d16"
If InKey$ <> "" Then Return
Play "O3e-16c16e-16g16O4c16e-16d16c16d16c16O3b16a16g16f16e-16d16"
If InKey$ <> "" Then Return
Play "O3e-16c16e-16g16O4c16e-16d16c16O3b16g16b16O4d16g16f16e-16d16"
If InKey$ <> "" Then Return
Play "O4e-16c16e-16g16O5c16e-16d16c16d16c16O4b16a16g16f16e-16d16"
If InKey$ <> "" Then Return
Play "O4e-16c16O3g16e-16c16O5c16O4g16e-16a-16O2f16a16O3c16f16a-16"
Play "O4c16e-16"
If InKey$ <> "" Then Return
Play "O4d16O3b-16f16d16O2b-16O4b-16f16d16g16O2e-16g16b-16O3e-16g16b-16"
Play "O4d16"
If InKey$ <> "" Then Return
Play "O4c16O3a16g+16a16O4c16O3a16g+16a16O4e-16c16O3g16a16O4e-16c16O3"
Play "g16a16"
If InKey$ <> "" Then Return
Play "O4d16c16O3f+16a16O4a16c16O3f+16a16O4f+16c16O3d16a16O4c16O3a16"
Play "f+16d16"
If InKey$ <> "" Then Return
Play "O3b-16O1g16b-16O2d16g16b-16a16g16f+16d16f+16a16O3d16c16O2b-16a16"
If InKey$ <> "" Then Return
Play "O2b-16g16b-16O3d16g16b-16a16g16a16g16f+16e16d16c16O2b-16a16"
If InKey$ <> "" Then Return
Play "O2b-16g16b-16O3d16g16b-16a16g16f+16d16f+16a16O4d16c16O3b-16a16"
If InKey$ <> "" Then Return
Play "O3b-16g16b-16O4d16g16b-16a16g16a16g16f+16e16d16c16O3b-16a16"
If InKey$ <> "" Then Return
Play "O3b-16g16b-16O4d16g16d16O3b-16g16O2f16O4g16d16O3b16g16b16O4d16g16"
If InKey$ <> "" Then Return
Play "o4c16o3g16o4g16o3g16o4c16o3g16o4g16o3g16b16g16o4f16o3g16b16g16"
If InKey$ <> "" Then Return
Play "o4f16o3g16"
Play "o4e-16c16e-16g16o5c16o4g16e-16c16o2b-16o5c16o4g16e16c16e16g16"
If InKey$ <> "" Then Return
Play "o5c16"
Play "o4f16c16o5c16o4c16f16c16o5c16o4c16e16c16b-16c16e16c16b-16c16"
If InKey$ <> "" Then Return
Play "o2a-16f16a-16o3c16f16a-16g16f16g16f16e16d16c16o2b-16a-16g16"
If InKey$ <> "" Then Return
Play "o3a-16f16a-16o4c16f16a-16g16f16g16f16e16d16c16o3b-16a-16g16"
If InKey$ <> "" Then Return
Play "o3a-16o4f16c16o3a-16f16o4c16o3a-16f16c16a-16f16c16o2a-16o3f16"
Play "c16o2a-16"
If InKey$ <> "" Then Return
Play "o2d-2o4a-16f16e16f16g16f16e16f16"
Play "o1b2o5d16o4f16g16a-16g16f16e-16d16"
If InKey$ <> "" Then Return
Play "o4e-16g16o5c16o4g16b-16a-16g16f16e-4d4"
If InKey$ <> "" Then Return
Play "o4c16o3g16o4g16o3g16o4c16o3g16o4g16o3g16b16g16o4f16o3g16b16g16"
Play "o4g16o3g16"
If InKey$ <> "" Then Return
Play "o3b-16g16o4e16o3g16b-16g16o4e16o3g16a16o4e-16o5c16o4e-16o3a16"
Play "o4e-16o5c16o4e-16"
If InKey$ <> "" Then Return
Play "o3a-16f16o4d16o3f16a-16f16o4d16o3f16g16o4d-16b-16d-16o3g16o4d-16"
Play "b-16d-16"
If InKey$ <> "" Then Return
Play "o3f+16e-16o4c16o3e-16f+16e-16o4c16o3e-16e-16o4c16o5c16o4c16o3e-16"
If InKey$ <> "" Then Return
Play "o3e-16o4c16e-16g16o5c16g16e-16c16g16e-16c16o3g16o4f16d16o3b16f16"
If InKey$ <> "" Then Return
Play "o3e-16c16e-16g16o4c16e-16d16c16d16c16o3b16a16g16f16e-16d16"
If InKey$ <> "" Then Return
Play "o4e-16c16e-16g16o5c16e-16d16o4b16o5c16o4g16e-16d16c16o3g16e-16d16"
Play "o3c16.p4"
Return


eye:
Data 16,16,16,16,00,00,00,00,16,16,16,16
Data 16,16,00,00,00,15,15,00,00,00,16,16
Data 16,00,00,15,15,06,06,15,15,00,00,16
Data 00,00,15,15,06,06,06,06,15,15,00,00
Data 16,00,00,15,06,06,06,06,15,00,00,16
Data 16,16,00,00,00,06,06,00,00,00,16,16
Data 16,16,16,16,00,00,00,00,16,16,16,16


'-----=====END OF GAME=====-----

Function fixcolor (col As Integer)
    Select Case col
        Case 1
            fixcolor = 4
        Case 3
            fixcolor = 6
        Case 4
            fixcolor = 1
        Case 6
            fixcolor = 3
        Case 9
            fixcolor = 12
        Case 11
            fixcolor = 14
        Case 12
            fixcolor = 9
        Case 14
            fixcolor = 11
        Case Else
            fixcolor = col
    End Select
End Function

