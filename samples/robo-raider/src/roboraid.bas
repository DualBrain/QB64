'****************************** ROBORAIDER *********************************
'********************************** by *************************************
'***************************** x.t.r.GRAPHICS (TM) *************************

'**************************** PRESS <F5> TO PLAY!! *************************

'############### Copyright 2004 by Kevin ################

$NoPrefix
$Resize:Smooth

Call Intro

Sub Bonus
    Cls
    Screen 13
    Color 10
    Print " RoboRaiders: >>BONUS>>"
    Locate 20, 3: Print "Press 'Enter' to select"
    Locate 22, 2: Print "Press 'F1' for Help, Press 'Esc' to Exit"
    C = 1
    Do
        press$ = InKey$
        If C = 1 Then Locate 10, 15: Color 10: Print ">>GAME-TRAILER>>": Locate 11, 15: Color 15: Print ">>ROBO-PICS<<": Locate 13, 15: Color 15: Print ">>MENU<<"
        If C = 2 Then Locate 10, 15: Color 15: Print ">>GAME-TRAILER<<": Locate 11, 15: Color 9: Print ">>ROBO-PICS>>": Locate 13, 15: Color 15: Print ">>MENU<<"
        If C = 3 Then Locate 10, 15: Color 15: Print ">>GAME-TRAILER<<": Locate 11, 15: Color 15: Print ">>ROBO-PICS<<": Locate 13, 15: Color 14: Print ">>MENU>>"
        If C = 2 Then If press$ = Chr$(0) + Chr$(80) Then C = 3: Play "D16"
        If C = 1 Then If press$ = Chr$(0) + Chr$(80) Then C = 2: Play "D16"
        If C = 2 Then If press$ = Chr$(0) + Chr$(72) Then C = 1: Play "D16"
        If C = 3 Then If press$ = Chr$(0) + Chr$(72) Then C = 2: Play "D16"
        If C = 2 Then If press$ = "2" Then C = 3: Play "D16"
        If C = 1 Then If press$ = "2" Then C = 2: Play "D16"
        If C = 2 Then If press$ = "8" Then C = 1: Play "D16"
        If C = 3 Then If press$ = "8" Then C = 2: Play "D16"
        If C = 1 Then If press$ = Chr$(13) Then Play "B16": Call Trailer
        If C = 2 Then If press$ = Chr$(13) Then Play "B16": Call Robopic
        If C = 3 Then If press$ = Chr$(13) Then Play "B16": Call Menu
        If press$ = Chr$(0) + ";" Then Call Help
    Loop Until press$ = Chr$(27)
    End
End Sub

Sub Credits
    Play "MB O4"
    Cls
    Screen 13
    Locate 22, 1
    '######## Robo Theme #######
    Play "E16 G E16 C2 C G E E3 G E C3 E16 G E16 C2 C16 C G3 E16 E E16 G F E G C3 E16 G E16 C2"
    Color 10
    Print "            Credits"
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print "     Main Programer   Kevin"
    Sleep (1)
    Print
    Sleep (1)
    Print "           Graphics   Kevin"
    Sleep (1)
    Print
    Sleep (1)
    Print "           Debuging   Kevin"
    Sleep (1)
    Print
    Sleep (1)
    Print
    Color 9
    Sleep (1)
    Print
    Sleep (1)
    Print "        Special Thanks"
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print "     Anyone who plays my games :)"
    Sleep (1)
    Print
    Sleep (1)
    Print "   Vic's Qbasic Programing Tutorials"
    Sleep (1)
    Print
    Sleep (1)
    Print "    Mallard's 'Basic Basic' Tutorials"
    Sleep (1)
    Print
    Sleep (1)
    Print "   Qbasic By Exaple (by Greg Perry)"
    Sleep (1)
    Print
    Color 14
    Sleep (1)
    Print
    Sleep (1)
    Print "          Cool sites "
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print "       www.qbasic.com"
    Sleep (1)
    Print
    Sleep (1)
    Print "     www.qbasicnews.com"
    Sleep (1)
    Print
    Sleep (1)
    Print "   Those 2 sites link to more"
    Sleep (1)
    Print
    Sleep (1)
    Print "   Look out for RoboRaider II"
    Sleep (1)
    Print
    Sleep (1)
    Print "   Play all levels for Bonus Levelcode!"
    Sleep (1)
    Print
    Sleep (1)
    Print
    Color 7
    Sleep (1)
    Print " This is the Classic style of Robo-"
    Sleep (1)
    Print " Raider, I hope to have a Hi-Def "
    Sleep (1)
    Print " version of this one and the second"
    Sleep (1)
    Print " one next year."
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print
    Sleep (1)
    Print

    Call Menu
End Sub

Sub Creep
    Cls
    Screen 13
    Line (10, 37)-(20, 45), 8, BF
    Line (20, 35)-(160, 50), 10, BF
    Line (22, 36)-(158, 36), 8
    Line (22, 60)-(158, 60), 8
    Circle (22, 48), 15, 7
    Paint (22, 48), 7
    PSet (22, 48), 0
    Circle (158, 48), 15, 7
    Paint (158, 48), 7
    PSet (158, 48), 0
    Locate 10, 1: Print " Creeper: Mission 3:"
    Locate 12, 1: Print "  Did someone step on it? Nope this"
    Locate 13, 1: Print "  Bot is made for tight places. Like"
    Locate 14, 1: Print "  low hanging ceilings."
    Color 10
    Locate 17, 1: Print " Press SPACEBAR to continue..."
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Call Missionb

End Sub

Sub Dril
    Cls
    Screen 13
    Line (60, 20)-(160, 50), 9, BF
    Line (60, 20)-(20, 35), 8
    Line (20, 35)-(60, 50), 8
    Line (60, 50)-(60, 20), 8
    Paint (55, 35), 8
    Line (70, 36)-(158, 36), 8
    Line (70, 60)-(158, 60), 8
    Circle (70, 48), 15, 7
    Paint (70, 48), 7
    PSet (70, 48), 0
    Circle (158, 48), 15, 7
    Paint (158, 48), 7
    PSet (158, 48), 0
    Locate 10, 1: Print " Trainer-Bot: Test 1-2:"
    Locate 12, 1: Print "  A simple desinged robot for easy"
    Locate 13, 1: Print "  repairs. Used for the first two"
    Locate 14, 1: Print "  test in case of a crash."
    Color 10
    Locate 17, 1: Print " Press SPACEBAR to continue..."
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Call Missionb2

    End
End Sub

Sub Drop
    Cls
    Screen 13
    Line (10, 32)-(20, 45), 8, BF
    Line (20, 30)-(160, 50), 12, BF
    Line (22, 36)-(158, 36), 8
    Line (22, 60)-(158, 60), 8
    '** SPIKE **
    Line (130, 29)-(110, 29), 7
    Line (130, 29)-(120, 10), 7: Line (110, 29)-(120, 10), 7
    Paint (120, 20), 7
    Line (120, 10)-(120, 29), 8
    '** WHEELS **
    Circle (22, 48), 15, 7
    Paint (22, 48), 7
    PSet (22, 48), 0
    Circle (158, 48), 15, 7
    Paint (158, 48), 7
    PSet (158, 48), 0
    Locate 10, 1: Print " Drop-Bot: Mission 4:"
    Locate 12, 1: Print "  This Bot has a harpoon to raise "
    Locate 13, 1: Print "  and lower itself to different "
    Locate 14, 1: Print "  levels of terrain."
    Color 10
    Locate 17, 1: Print " Press SPACEBAR to continue..."
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Call Missionb2

End Sub

Sub Ending
    Screen 13
    Color 15
    Cls
    Print " Dr Robo's Notes:"
    Print
    Print "      I inserted all the gems into the"
    Print " disk. It began to glow, and then "
    Print " another slot melted into the center. "
    Print " There is another gem!! I must research,"
    Print " but until then then, my pilot needs a "
    Print " break...."
    Print "      I'll give him a vacation while I "
    Print " dig up the location of the last gem."
    Print " Hopefuly the mystery will be solved,"
    Print " and we can find out what this does..."
    Print
    Print
    Print
    Print
    Color 10
    Print " Press SPACEBAR to continue..."
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Call Bonus
End Sub

Sub Help
    Cls
    Print " Help File:"
    Print
    Print "     First thing first: to highlight"
    Print " other menu commands, use the arrow- "
    Print " keys. Press 'Enter' to select"
    Print " Robots move with the arrowkeys. The"
    Print " grip on the collecter bots operate"
    Print " automaticaly when a item is in their"
    Print " reach. You can press 'Esc' almost"
    Print " anywhere in the game to exit."
    Print " For any more help, open the README.TXT"
    Print " located with this game."
    Print
    Color 10
    Print " Press any key to return"
    Do
    Loop While InKey$ = ""
    Call Menu
End Sub

Sub Intro
    Play "MB <"
    Cls
    Screen 13
    FullScreen SquarePixels , Smooth
    '######## Robo Theme #######
    Play "E16 G E16 C2 C G E E3 G E C3 E16 G E16 C2 C16 C G3 E16 E E16 G F E G C3 E16 G E16 C2"
    '######## Intro #######
    Locate 10, 15: Color 44: Print "xt": Locate 10, 17: Color 43: Print "GRAP": Locate 10, 21: Color 42: Print "HICS(TM)": Color 15
    Sleep (3)
    Cls
    Locate 10, 13: Color 42: Print ">>>": Locate 10, 16: Color 43: Print "PRE": Locate 10, 19: Color 44: Print "SE": Locate 10, 21: Color 43: Print "NTS": Locate 10, 23: Color 42: Print ">>>": Color 15
    Sleep (3)
    Cls
    Locate 10, 14: Color 7: Print "RoboRaider": Color 15
    Sleep (3)
    Cls
    Print " Dr. Robo's Notes:"
    Print
    Print "      Note to self: My last Robo-Raider,"
    Print " while exploring a cave, carelessly "
    Print " hit a trip wire destoring one of my "
    Print " finest robots. For this run on with "
    Print " a rolling rock, I myself, slightly "
    Print " inraged, carelessly fired him. Gee, "
    Print " that leaves me with without a robot "
    Print " pilot!"
    Print "      Note to self: Run ad in paper for "
    Print " new pilot."
    Color 10: Locate 23, 1: Print " Press SPACEBAR to continue...."
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Color 15

    Print " NewsPaper AD:"
    Print ""
    Print "      Dear R/C car fans, do you want to "
    Print " be well paid for your piloting skills?"
    Print " If so contact me at (###) ###-ROBO."
    Print " Callers will have an appoitment setup "
    Print " to take my tests. If you pass all three"
    Print " tests completely, you will be hired on "
    Print " the spot. "
    Print
    Print
    Print
    Print
    Print
    Print
    Print
    Print
    Print
    Print
    Print
    Print
    Print
    Print
    Color 10: Locate 23, 1: Print " Press SPACEBAR to continue...."
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Call Menu
End Sub

Sub Levelcode
    Cls
    Screen 13
    Color 9
    Print " Turn on CAPS LOCK to type Levelcode."
    Print " Press 'Enter' to check code."
    Print "  Levelcodes take you to levels you "
    Print "  last left off...."
    Print
    Print
    Input " Insert Levelcode:", lcode$
    Print "  Checking Levelcode>>"; lcode$
    Sleep (4)

    If lcode$ = "TEST001" Then GoTo swtch
    If lcode$ = "TEST002" Then GoTo swtch
    If lcode$ = "TEST003" Then GoTo swtch
    If lcode$ = "POINTY" Then GoTo swtch
    If lcode$ = "INDEEP" Then GoTo swtch
    If lcode$ = "SUBRUINS" Then GoTo swtch
    If lcode$ = "TOWER" Then GoTo swtch
    If lcode$ = "WALLDRILL" Then GoTo swtch
    If lcode$ = "AMAZEME" Then GoTo swtch
    If lcode$ = "ROBOBONUS" Then GoTo swtch
    If lcode$ <> "" Then GoTo err1
    If lcode$ = "" Then GoTo err1

    swtch: Color 10
    Print
    Print " "; lcode$; " is valid!"
    Print " Enjoy this level!"
    Sleep (6)
    If lcode$ = "TEST001" Then Call Menu
    If lcode$ = "TEST002" Then Call Menu2
    If lcode$ = "TEST003" Then Call Menu3
    If lcode$ = "POINTY" Then Call Menu4
    If lcode$ = "INDEEP" Then Call Menu5
    If lcode$ = "SUBRUINS" Then Call Menu6
    If lcode$ = "TOWER" Then Call Menu7
    If lcode$ = "WALLDRILL" Then Call Menu8
    If lcode$ = "AMAZEME" Then Call Menu9
    If lcode$ = "ROBOBONUS" Then Call Bonus

    err1: Color 12
    Print
    Print " "; lcode$; " does not compute."
    Print " To get a level's code, defeat"
    Print " the level before it..."
    Sleep (8)
    Call Menu
End Sub

Sub Mbrief01
    Cls
    Screen 13
    Color 15
    Print " Mission Briefing:"
    Print
    Print "      In your last mission, you  "
    Print " collected a round disk. This I  "
    Print " looked over carefuly, and I found"
    Print " something... Your first Item, that"
    Print " was found in the pyramid, the gem,"
    Print " fits perfecly in one of the slots."
    Print " There are four more slots to fill."
    Print " I've looked, and found what I think"
    Print " are the rest. One of them I hope to"
    Print " collect myself. Any way, I think "
    Print " this might be important, lets get "
    Print " the other gems and find out!"
    Print
    Print
    Color 10
    Print " Press SPACEBAR to continue..."
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Call Mission03
End Sub

Sub Menu
    Cls
    Screen 13
    Color 10
    Print " RoboRaiders: >>Test1>>"
    Locate 20, 3: Print "Press 'Enter' to select"
    Locate 22, 2: Print "Press 'F1' for Help, Press 'Esc' to Exit"
    C = 1
    Do
        press$ = InKey$
        If C = 1 Then Locate 10, 15: Color 10: Print ">>START>>": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 2 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 9: Print ">>LEVELCODE>>": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 3 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 14: Print ">>CREDITS>>"
        If C = 2 Then If press$ = Chr$(0) + Chr$(80) Then C = 3: Play "D16"
        If C = 1 Then If press$ = Chr$(0) + Chr$(80) Then C = 2: Play "D16"
        If C = 2 Then If press$ = Chr$(0) + Chr$(72) Then C = 1: Play "D16"
        If C = 3 Then If press$ = Chr$(0) + Chr$(72) Then C = 2: Play "D16"
        If C = 2 Then If press$ = "2" Then C = 3: Play "D16"
        If C = 1 Then If press$ = "2" Then C = 2: Play "D16"
        If C = 2 Then If press$ = "8" Then C = 1: Play "D16"
        If C = 3 Then If press$ = "8" Then C = 2: Play "D16"
        If C = 1 Then If press$ = Chr$(13) Then Play "B16": Call Test001
        If C = 2 Then If press$ = Chr$(13) Then Play "B16": Call Levelcode
        If C = 3 Then If press$ = Chr$(13) Then Play "B16": Call Credits
        If press$ = Chr$(0) + ";" Then Call Help
    Loop Until press$ = Chr$(27)
    End
End Sub

Sub Menu2
    Cls
    Screen 13
    Color 10
    Print " RoboRaiders: >>Test2>>"
    Locate 20, 3: Print "Press 'Enter' to select"
    Locate 22, 2: Print "Press 'F1' for Help, Press 'Esc' to Exit"
    C = 1
    Do
        press$ = InKey$
        If C = 1 Then Locate 10, 15: Color 10: Print ">>START>>": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 2 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 9: Print ">>LEVELCODE>>": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 3 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 14: Print ">>CREDITS>>"
        If C = 2 Then If press$ = Chr$(0) + Chr$(80) Then C = 3: Play "D16"
        If C = 1 Then If press$ = Chr$(0) + Chr$(80) Then C = 2: Play "D16"
        If C = 2 Then If press$ = Chr$(0) + Chr$(72) Then C = 1: Play "D16"
        If C = 3 Then If press$ = Chr$(0) + Chr$(72) Then C = 2: Play "D16"
        If C = 2 Then If press$ = "2" Then C = 3: Play "D16"
        If C = 1 Then If press$ = "2" Then C = 2: Play "D16"
        If C = 2 Then If press$ = "8" Then C = 1: Play "D16"
        If C = 3 Then If press$ = "8" Then C = 2: Play "D16"
        If C = 1 Then If press$ = Chr$(13) Then Play "B16": Call Test002
        If C = 2 Then If press$ = Chr$(13) Then Play "B16": Call Levelcode
        If C = 3 Then If press$ = Chr$(13) Then Play "B16": Call Credits
        If press$ = Chr$(0) + ";" Then Call Help
    Loop Until press$ = Chr$(27)
    End

End Sub

Sub Menu3
    Cls
    Screen 13
    Color 10
    Print " RoboRaiders: >>Test3>>"
    Locate 20, 3: Print "Press 'Enter' to select"
    Locate 22, 2: Print "Press 'F1' for Help, Press 'Esc' to Exit"
    C = 1
    Do
        press$ = InKey$
        If C = 1 Then Locate 10, 15: Color 10: Print ">>START>>": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 2 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 9: Print ">>LEVELCODE>>": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 3 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 14: Print ">>CREDITS>>"
        If C = 2 Then If press$ = Chr$(0) + Chr$(80) Then C = 3: Play "D16"
        If C = 1 Then If press$ = Chr$(0) + Chr$(80) Then C = 2: Play "D16"
        If C = 2 Then If press$ = Chr$(0) + Chr$(72) Then C = 1: Play "D16"
        If C = 3 Then If press$ = Chr$(0) + Chr$(72) Then C = 2: Play "D16"
        If C = 2 Then If press$ = "2" Then C = 3: Play "D16"
        If C = 1 Then If press$ = "2" Then C = 2: Play "D16"
        If C = 2 Then If press$ = "8" Then C = 1: Play "D16"
        If C = 3 Then If press$ = "8" Then C = 2: Play "D16"
        If C = 1 Then If press$ = Chr$(13) Then Play "B16": Call Test003
        If C = 2 Then If press$ = Chr$(13) Then Play "B16": Call Levelcode
        If C = 3 Then If press$ = Chr$(13) Then Play "B16": Call Credits
        If press$ = Chr$(0) + ";" Then Call Help
    Loop Until press$ = Chr$(27)
    End

End Sub

Sub Menu4
    Cls
    Screen 13
    Color 10
    Print " RoboRaiders: >>Mission1>>"
    Locate 20, 3: Print "Press 'Enter' to select"
    Locate 22, 2: Print "Press 'F1' for Help, Press 'Esc' to Exit"
    C = 1
    Do
        press$ = InKey$
        If C = 1 Then Locate 10, 15: Color 10: Print ">>START>>": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 2 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 9: Print ">>LEVELCODE>>": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 3 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 14: Print ">>CREDITS>>"
        If C = 2 Then If press$ = Chr$(0) + Chr$(80) Then C = 3: Play "D16"
        If C = 1 Then If press$ = Chr$(0) + Chr$(80) Then C = 2: Play "D16"
        If C = 2 Then If press$ = Chr$(0) + Chr$(72) Then C = 1: Play "D16"
        If C = 3 Then If press$ = Chr$(0) + Chr$(72) Then C = 2: Play "D16"
        If C = 2 Then If press$ = "2" Then C = 3: Play "D16"
        If C = 1 Then If press$ = "2" Then C = 2: Play "D16"
        If C = 2 Then If press$ = "8" Then C = 1: Play "D16"
        If C = 3 Then If press$ = "8" Then C = 2: Play "D16"
        If C = 1 Then If press$ = Chr$(13) Then Play "B16": Call Mission01
        If C = 2 Then If press$ = Chr$(13) Then Play "B16": Call Levelcode
        If C = 3 Then If press$ = Chr$(13) Then Play "B16": Call Credits
        If press$ = Chr$(0) + ";" Then Call Help
    Loop Until press$ = Chr$(27)
    End

End Sub

Sub Menu5
    Cls
    Screen 13
    Color 10
    Print " RoboRaiders: >>Mission2>>"
    Locate 20, 3: Print "Press 'Enter' to select"
    Locate 22, 2: Print "Press 'F1' for Help, Press 'Esc' to Exit"
    C = 1
    Do
        press$ = InKey$
        If C = 1 Then Locate 10, 15: Color 10: Print ">>START>>": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 2 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 9: Print ">>LEVELCODE>>": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 3 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 14: Print ">>CREDITS>>"
        If C = 2 Then If press$ = Chr$(0) + Chr$(80) Then C = 3: Play "D16"
        If C = 1 Then If press$ = Chr$(0) + Chr$(80) Then C = 2: Play "D16"
        If C = 2 Then If press$ = Chr$(0) + Chr$(72) Then C = 1: Play "D16"
        If C = 3 Then If press$ = Chr$(0) + Chr$(72) Then C = 2: Play "D16"
        If C = 2 Then If press$ = "2" Then C = 3: Play "D16"
        If C = 1 Then If press$ = "2" Then C = 2: Play "D16"
        If C = 2 Then If press$ = "8" Then C = 1: Play "D16"
        If C = 3 Then If press$ = "8" Then C = 2: Play "D16"
        If C = 1 Then If press$ = Chr$(13) Then Play "B16": Call Mission02
        If C = 2 Then If press$ = Chr$(13) Then Play "B16": Call Levelcode
        If C = 3 Then If press$ = Chr$(13) Then Play "B16": Call Credits
        If press$ = Chr$(0) + ";" Then Call Help
    Loop Until press$ = Chr$(27)
    End

End Sub

Sub Menu6
    Cls
    Screen 13
    Color 10
    Print " RoboRaiders: >>Mission3>>"
    Locate 20, 3: Print "Press 'Enter' to select"
    Locate 22, 2: Print "Press 'F1' for Help, Press 'Esc' to Exit"
    C = 1
    Do
        press$ = InKey$
        If C = 1 Then Locate 10, 15: Color 10: Print ">>START>>": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 2 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 9: Print ">>LEVELCODE>>": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 3 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 14: Print ">>CREDITS>>"
        If C = 2 Then If press$ = Chr$(0) + Chr$(80) Then C = 3: Play "D16"
        If C = 1 Then If press$ = Chr$(0) + Chr$(80) Then C = 2: Play "D16"
        If C = 2 Then If press$ = Chr$(0) + Chr$(72) Then C = 1: Play "D16"
        If C = 3 Then If press$ = Chr$(0) + Chr$(72) Then C = 2: Play "D16"
        If C = 2 Then If press$ = "2" Then C = 3: Play "D16"
        If C = 1 Then If press$ = "2" Then C = 2: Play "D16"
        If C = 2 Then If press$ = "8" Then C = 1: Play "D16"
        If C = 3 Then If press$ = "8" Then C = 2: Play "D16"
        If C = 1 Then If press$ = Chr$(13) Then Play "B16": Call Mbrief01
        If C = 2 Then If press$ = Chr$(13) Then Play "B16": Call Levelcode
        If C = 3 Then If press$ = Chr$(13) Then Play "B16": Call Credits
        If press$ = Chr$(0) + ";" Then Call Help
    Loop Until press$ = Chr$(27)
    End

End Sub

Sub Menu7
    Cls
    Screen 13
    Color 10
    Print " RoboRaiders: >>Mission4>>"
    Locate 20, 3: Print "Press 'Enter' to select"
    Locate 22, 2: Print "Press 'F1' for Help, Press 'Esc' to Exit"
    C = 1
    Do
        press$ = InKey$
        If C = 1 Then Locate 10, 15: Color 10: Print ">>START>>": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 2 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 9: Print ">>LEVELCODE>>": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 3 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 14: Print ">>CREDITS>>"
        If C = 2 Then If press$ = Chr$(0) + Chr$(80) Then C = 3: Play "D16"
        If C = 1 Then If press$ = Chr$(0) + Chr$(80) Then C = 2: Play "D16"
        If C = 2 Then If press$ = Chr$(0) + Chr$(72) Then C = 1: Play "D16"
        If C = 3 Then If press$ = Chr$(0) + Chr$(72) Then C = 2: Play "D16"
        If C = 2 Then If press$ = "2" Then C = 3: Play "D16"
        If C = 1 Then If press$ = "2" Then C = 2: Play "D16"
        If C = 2 Then If press$ = "8" Then C = 1: Play "D16"
        If C = 3 Then If press$ = "8" Then C = 2: Play "D16"
        If C = 1 Then If press$ = Chr$(13) Then Play "B16": Call Mission04
        If C = 2 Then If press$ = Chr$(13) Then Play "B16": Call Levelcode
        If C = 3 Then If press$ = Chr$(13) Then Play "B16": Call Credits
        If press$ = Chr$(0) + ";" Then Call Help
    Loop Until press$ = Chr$(27)
    End


End Sub

Sub Menu8
    Cls
    Screen 13
    Color 10
    Print " RoboRaiders: >>Mission5>>"
    Locate 20, 3: Print "Press 'Enter' to select"
    Locate 22, 2: Print "Press 'F1' for Help, Press 'Esc' to Exit"
    C = 1
    Do
        press$ = InKey$
        If C = 1 Then Locate 10, 15: Color 10: Print ">>START>>": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 2 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 9: Print ">>LEVELCODE>>": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 3 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 14: Print ">>CREDITS>>"
        If C = 2 Then If press$ = Chr$(0) + Chr$(80) Then C = 3: Play "D16"
        If C = 1 Then If press$ = Chr$(0) + Chr$(80) Then C = 2: Play "D16"
        If C = 2 Then If press$ = Chr$(0) + Chr$(72) Then C = 1: Play "D16"
        If C = 3 Then If press$ = Chr$(0) + Chr$(72) Then C = 2: Play "D16"
        If C = 2 Then If press$ = "2" Then C = 3: Play "D16"
        If C = 1 Then If press$ = "2" Then C = 2: Play "D16"
        If C = 2 Then If press$ = "8" Then C = 1: Play "D16"
        If C = 3 Then If press$ = "8" Then C = 2: Play "D16"
        If C = 1 Then If press$ = Chr$(13) Then Play "B16": Call Mission05
        If C = 2 Then If press$ = Chr$(13) Then Play "B16": Call Levelcode
        If C = 3 Then If press$ = Chr$(13) Then Play "B16": Call Credits
        If press$ = Chr$(0) + ";" Then Call Help
    Loop Until press$ = Chr$(27)
    End

End Sub

Sub Menu9
    Cls
    Screen 13
    Color 10
    Print " RoboRaiders: >>Mission6>>"
    Locate 20, 3: Print "Press 'Enter' to select"
    Locate 22, 2: Print "Press 'F1' for Help, Press 'Esc' to Exit"
    C = 1
    Do
        press$ = InKey$
        If C = 1 Then Locate 10, 15: Color 10: Print ">>START>>": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 2 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 9: Print ">>LEVELCODE>>": Locate 13, 15: Color 15: Print ">>CREDITS<<"
        If C = 3 Then Locate 10, 15: Color 15: Print ">>START<<": Locate 11, 15: Color 15: Print ">>LEVELCODE<<": Locate 13, 15: Color 14: Print ">>CREDITS>>"
        If C = 2 Then If press$ = Chr$(0) + Chr$(80) Then C = 3: Play "D16"
        If C = 1 Then If press$ = Chr$(0) + Chr$(80) Then C = 2: Play "D16"
        If C = 2 Then If press$ = Chr$(0) + Chr$(72) Then C = 1: Play "D16"
        If C = 3 Then If press$ = Chr$(0) + Chr$(72) Then C = 2: Play "D16"
        If C = 2 Then If press$ = "2" Then C = 3: Play "D16"
        If C = 1 Then If press$ = "2" Then C = 2: Play "D16"
        If C = 2 Then If press$ = "8" Then C = 1: Play "D16"
        If C = 3 Then If press$ = "8" Then C = 2: Play "D16"
        If C = 1 Then If press$ = Chr$(13) Then Play "B16": Call Mission06
        If C = 2 Then If press$ = Chr$(13) Then Play "B16": Call Levelcode
        If C = 3 Then If press$ = Chr$(13) Then Play "B16": Call Credits
        If press$ = Chr$(0) + ";" Then Call Help
    Loop Until press$ = Chr$(27)
    End

End Sub

Sub Mission01
    Cls
    Screen 7, 0, 1, 0
    Dim sch1(100), sch2(100), scv1(100), scv2(100), mask(100)
    Play "MB L64 <<<"
    Color 15
    Print " Mission Status:"
    Print
    Print "      Mission 1: There has been"
    Print " a recent discovery in a pyramid"
    Print " over in Egypt of a small passage."
    Print " It's to small for humans, but one"
    Print " of my finest robots 'Scorpian' "
    Print " can make the trip. My scans show"
    Print " a object at the end of the shaft,"
    Print " and something else beyond it. "
    Print " What ever that is you must find "
    Print " out, good luck."
    Print
    Print
    Print
    Color 10
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "

    Cls
    '############# ROBOT ##########
    Line (1, 1)-(2, 10), 8, BF
    Line (10, 1)-(9, 10), 8, BF
    Line (3, 2)-(8, 9), 14, BF
    Line (5, 1)-(6, 7), 12, BF
    Line (5, 5)-(6, 8), 4, BF
    PCopy 1, 0
    Get (1, 1)-(10, 10), sch1()
    Cls
    Line (1, 1)-(2, 10), 8, BF
    Line (10, 1)-(9, 10), 8, BF
    Line (3, 2)-(8, 9), 14, BF
    Line (5, 3)-(6, 10), 12, BF
    Line (5, 7)-(6, 10), 4, BF
    PCopy 1, 0
    Get (1, 1)-(10, 10), sch2()
    Cls
    Line (1, 1)-(10, 2), 8, BF
    Line (1, 10)-(10, 9), 8, BF
    Line (2, 3)-(9, 8), 14, BF
    Line (1, 5)-(7, 6), 12, BF
    Line (5, 5)-(8, 6), 4, BF
    Get (1, 1)-(10, 10), scv1()
    PCopy 1, 0
    Cls
    Line (1, 1)-(10, 2), 8, BF
    Line (1, 10)-(10, 9), 8, BF
    Line (2, 3)-(9, 8), 14, BF
    Line (3, 5)-(10, 6), 12, BF
    Line (7, 5)-(10, 6), 4, BF
    Get (1, 1)-(10, 10), scv2()
    PCopy 1, 0
    Cls
    Get (1, 1)-(10, 10), mask()
    '######## LEVEL ########
    Line (150, 200)-(150, 50), 12
    Line (170, 200)-(170, 50), 12
    Line (150, 50)-(170, 50), 12
    Circle (160, 60), 2, 9: Paint (160, 60), 9
    PCopy 1, 0
    '######## Level INTRO ####
    x = 155: y = 180
    stat$ = "Hmm, Scorpian's video feed shows a      smaller shaft than my scans did. Never   mind that, get that item."
    Put (x, y), sch1(), PSet
    Do
        press$ = InKey$
        Locate 1, 1: Print stat$
        PCopy 1, 0
    Loop While press$ = ""
    Cls
    stat$ = "Collect Item:"
    '######## LEVEL ########
    Line (150, 200)-(150, 50), 12
    Line (170, 200)-(170, 50), 12
    Line (150, 50)-(170, 50), 12
    PCopy 1, 0
    d = 1
    Do
        press$ = InKey$
        Locate 1, 1: Print stat$
        '######## Item Code #######
        If i = 0 Then Circle (160, 60), 2, 9: Paint (160, 60), 9 Else Circle (160, 60), 2, 0: Paint (160, 60), 0
        If i = 1 Then Line (120, 50)-(200, 10), 12, B: Put (155, 46), mask(), PSet: Circle (160, 23), 10, 1: Paint (160, 23), 1: Circle (160, 23), 10, 7: stat$ = "Do not enter, there's a trip line on the door!"
        If y = 62 Then If x = 155 Or x = 156 Then i = 1
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '####### Wall codes #######
        If x = 150 Then GoTo mcrash1
        If x = 161 Then GoTo mcrash1
        If y = 50 Then GoTo mcrash1
        If i = 0 And y = 188 Then y = 187: stat$ = "Finish The Mission First!"
        If i = 0 And y < 187 Then stat$ = "Collect Item:                     "
        If i = 1 And y = 188 Then GoTo mfinish1
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    mfinish1: Cls
    Color 10
    Print " You completed your first mission!"
    Print
    Print " Now for the next one!"
    Print
    Color 9
    Print
    Print " This level's code is: POINTY"
    Print " Next level's code is: INDEEP"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu5

    mcrash1: Cls
    Color 12
    Print " You Crashed My Robot!"
    Print
    Print " Sorry, You are fired!"
    Print
    Color 9
    Print
    Print " This level's code is: POINTY"
    Print " Next level's code is: >>did not pass<<"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu

End Sub

Sub Mission02
    Screen 7, 0, 1, 0
    Dim sch1(100), sch2(100), scv1(100), scv2(100), mask(100)
    Play "MB L64 <<<"
    Color 15
    Print " Mission Status:"
    Print
    Print "      Mission 2: Your next mission"
    Print " takes you to a cave with, you "
    Print " guessed, a entrance to small for"
    Print " humans. My scans show a maze of "
    Print " paths leading to a object. You "
    Print " will be using Scorpian again, it's"
    Print " more tactical than the others."
    Print " You must watch your battery life,"
    Print " my bot has one of 30 minutes. But"
    Print " be careful, I have towing bots,"
    Print " made just for pulling back a "
    Print " stranded robot. Just don't crash!"
    Color 9
    Print "  NOTE: If the robot stops, its a "
    Print "        dead end, try a new direction"
    Print
    Print
    Color 10
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    '############# ROBOT ##########
    Line (1, 1)-(2, 10), 8, BF
    Line (10, 1)-(9, 10), 8, BF
    Line (3, 2)-(8, 9), 14, BF
    Line (5, 1)-(6, 7), 12, BF
    Line (5, 5)-(6, 8), 4, BF
    PCopy 1, 0
    Get (1, 1)-(10, 10), sch1()
    Cls
    Line (1, 1)-(2, 10), 8, BF
    Line (10, 1)-(9, 10), 8, BF
    Line (3, 2)-(8, 9), 14, BF
    Line (5, 3)-(6, 10), 12, BF
    Line (5, 7)-(6, 10), 4, BF
    PCopy 1, 0
    Get (1, 1)-(10, 10), sch2()
    Cls
    Line (1, 1)-(10, 2), 8, BF
    Line (1, 10)-(10, 9), 8, BF
    Line (2, 3)-(9, 8), 14, BF
    Line (1, 5)-(7, 6), 12, BF
    Line (5, 5)-(8, 6), 4, BF
    Get (1, 1)-(10, 10), scv1()
    PCopy 1, 0
    Cls
    Line (1, 1)-(10, 2), 8, BF
    Line (1, 10)-(10, 9), 8, BF
    Line (2, 3)-(9, 8), 14, BF
    Line (3, 5)-(10, 6), 12, BF
    Line (7, 5)-(10, 6), 4, BF
    Get (1, 1)-(10, 10), scv2()
    PCopy 1, 0
    Cls
    Get (1, 1)-(10, 10), mask()

    m2seg1: Cls '                  >>>SEGMENT #01<<<<
    '######### LEVEL ########
    Line (150, 200)-(150, 100), 2
    Line (170, 200)-(170, 100), 2
    Line (0, 100)-(150, 100), 2
    Line (320, 100)-(170, 100), 2
    Line (0, 80)-(320, 80), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 155: y = 180: d = 1
    If segm = 1 Then x = 299: d = 2
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y > 90 Then GoTo mcrash2
        If x > 160 And y > 90 Then GoTo mcrash2
        If y = 80 Then GoTo mcrash2
        If x = 10 Then x = 11
        '########## DOOR CODES ###########
        If i = 0 Then If y < 189 Then stat$ = "Collect Item:"
        If i = 0 Then If y = 190 Then y = 189: stat$ = "Not Finished "
        If i = 1 Then If y = 190 Then GoTo mfinish2
        If x = 305 Then segm = 0: GoTo m2seg2
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m2seg2: Cls '                     >>>SEGMENT #02<<<
    '######### LEVEL ########
    Line (150, 0)-(150, 80), 2
    Line (170, 0)-(170, 80), 2
    Line (0, 80)-(150, 80), 2
    Line (320, 80)-(170, 80), 2
    Line (0, 100)-(320, 100), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 10: d = 4
    If segm = 1 Then y = 10: d = 3
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y < 81 Then GoTo mcrash2
        If x > 160 And y < 81 Then GoTo mcrash2
        If y = 91 Then GoTo mcrash2
        If x = 300 Then x = 299
        '########## DOOR CODES ########
        If x = 5 Then segm = 1: GoTo m2seg1
        If y = 5 Then segm = 0: GoTo m2seg3
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m2seg3: Cls '                     >>>SEGMENT #03<<<
    '######### LEVEL ########
    Line (150, 0)-(150, 80), 2
    Line (170, 0)-(170, 80), 2
    Line (0, 80)-(150, 80), 2
    Line (320, 80)-(170, 80), 2
    Line (150, 200)-(150, 100), 2
    Line (170, 200)-(170, 100), 2
    Line (0, 100)-(150, 100), 2
    Line (320, 100)-(170, 100), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 180: d = 1
    If segm = 1 Then x = 299: d = 2
    If segm = 2 Then y = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y < 81 Then GoTo mcrash2
        If x > 160 And y < 81 Then GoTo mcrash2
        If x < 151 And y > 90 Then GoTo mcrash2
        If x > 160 And y > 90 Then GoTo mcrash2
        If x = 10 Then x = 11
        '########## DOOR CODES ##########
        If y = 185 Then segm = 1: GoTo m2seg2
        If x = 305 Then segm = 0: GoTo m2seg4
        If y = 5 Then segm = 0: GoTo m2seg15
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m2seg4: Cls '                   >>> SEGMENT04 <<<
    '######### LEVEL #############
    Line (0, 80)-(320, 80), 2
    Line (0, 100)-(320, 100), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 10: d = 4
    If segm = 1 Then x = 299: d = 2
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If y = 80 Or y = 91 Then GoTo mcrash2
        '########## DOOR CODES #######
        If x = 5 Then segm = 1: GoTo m2seg3
        If x = 305 Then segm = 0: GoTo m2seg5
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m2seg5: Cls '                   >>> SEGMENT #05 <<<
    '######### LEVEL ########
    Line (150, 0)-(150, 80), 2
    Line (170, 0)-(170, 80), 2
    Line (0, 80)-(150, 80), 2
    Line (320, 80)-(170, 80), 2
    Line (150, 200)-(150, 100), 2
    Line (170, 200)-(170, 100), 2
    Line (0, 100)-(150, 100), 2
    Line (320, 100)-(170, 100), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 10
    If segm = 1 Then y = 10
    If segm = 2 Then y = 180
    If segm = 3 Then x = 300
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y < 81 Then GoTo mcrash2
        If x > 160 And y < 81 Then GoTo mcrash2
        If x < 151 And y > 90 Then GoTo mcrash2
        If x > 160 And y > 90 Then GoTo mcrash2
        '########## DOOR CODES ##########
        If x = 5 Then segm = 1: GoTo m2seg4
        If y = 5 Then segm = 0: GoTo m2seg17
        If x = 305 Then segm = 1: GoTo m2seg14
        If y = 185 Then segm = 0: GoTo m2seg6
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m2seg6: Cls '                   >>> SEGMENT #06 <<<
    '######### LEVEL ########
    Line (150, 0)-(150, 80), 2
    Line (170, 0)-(170, 80), 2
    Line (0, 80)-(150, 80), 2
    Line (320, 80)-(170, 80), 2
    Line (150, 200)-(150, 100), 2
    Line (170, 200)-(170, 100), 2
    Line (0, 100)-(150, 100), 2
    Line (320, 100)-(170, 100), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 10
    If segm = 1 Then x = 10
    If segm = 2 Then x = 300
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y < 81 Then GoTo mcrash2
        If x > 160 And y < 81 Then GoTo mcrash2
        If x < 151 And y > 90 Then GoTo mcrash2
        If x > 160 And y > 90 Then GoTo mcrash2
        '########## DOOR CODES ##########
        If x = 5 Then segm = 0: GoTo m2seg16
        If y = 5 Then segm = 2: GoTo m2seg5
        If x = 305 Then segm = 0: GoTo m2seg7
        If y = 185 Then y = 184
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m2seg7: Cls '                   >>> SEGMENT #07 <<<
    '######### LEVEL #############
    Line (0, 80)-(320, 80), 2
    Line (0, 100)-(320, 100), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 10: d = 4
    If segm = 1 Then x = 299: d = 2
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If y = 80 Or y = 91 Then GoTo mcrash2
        '########## DOOR CODES #######
        If x = 5 Then segm = 2: GoTo m2seg6
        If x = 305 Then segm = 0: GoTo m2seg8
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m2seg8: Cls '                   >>> SEGMENT #08 <<<
    '######## LEVEL #########
    Line (0, 80)-(150, 80), 2
    Line (150, 80)-(150, 0), 2
    Line (0, 100)-(170, 100), 2
    Line (170, 100)-(170, 0), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 10
    If segm = 1 Then y = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y < 81 Then GoTo mcrash2
        If x = 161 Or y = 91 Then GoTo mcrash2
        '########## DOOR CODES #########
        If x = 5 Then segm = 1: GoTo m2seg7
        If y = 5 Then segm = 0: GoTo m2seg9
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m2seg9: Cls '                   >>> SEGMENT #09 <<<
    '######## LEVEL #########
    Line (150, 200)-(150, 80), 2
    Line (150, 80)-(320, 80), 2
    Line (170, 200)-(170, 100), 2
    Line (170, 100)-(320, 100), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 180
    If segm = 1 Then x = 300
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 150 Or y = 80 Then GoTo mcrash2
        If x > 160 And y > 90 Then GoTo mcrash2
        '########## DOOR CODES #########
        If x = 305 Then segm = 0: GoTo m2seg10
        If y = 185 Then segm = 1: GoTo m2seg8
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m2seg10: Cls '                  >>> SEGMENT #10 <<<
    '######## LEVEL #########
    Line (0, 80)-(150, 80), 2
    Line (150, 80)-(150, 0), 2
    Line (0, 100)-(170, 100), 2
    Line (170, 100)-(170, 0), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 10
    If segm = 1 Then y = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y < 81 Then GoTo mcrash2
        If x = 161 Or y = 91 Then GoTo mcrash2
        '########## DOOR CODES #########
        If x = 5 Then segm = 1: GoTo m2seg9
        If y = 5 Then segm = 0: GoTo m2seg11
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m2seg11: Cls '                  >>> SEGMENT #11 <<<
    '########## LEVEL #########
    Line (150, 200)-(150, 100), 2
    Line (170, 200)-(170, 80), 2
    Line (150, 100)-(0, 100), 2
    Line (170, 80)-(0, 80), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 180
    If segm = 1 Then x = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y > 90 Then GoTo mcrash2
        If x = 161 Or y = 80 Then GoTo mcrash2
        '########## DOOR CODES ##########
        If y = 185 Then segm = 1: GoTo m2seg10
        If x = 5 Then segm = 0: GoTo m2seg12
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m2seg12: Cls '                  >>> SEGMENT #12 <<<
    '######### LEVEL #############
    Line (0, 80)-(320, 80), 2
    Line (0, 100)-(320, 100), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 300
    If segm = 1 Then x = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If y = 80 Or y = 91 Then GoTo mcrash2
        '########## DOOR CODES #######
        If x = 5 Then segm = 0: GoTo m2seg13
        If x = 305 Then segm = 1: GoTo m2seg11
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m2seg13: Cls '                  >>> SEGMENT #13 <<<
    '######## LEVEL #########
    Line (150, 200)-(150, 80), 2
    Line (150, 80)-(320, 80), 2
    Line (170, 200)-(170, 100), 2
    Line (170, 100)-(320, 100), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 1 Then y = 180
    If segm = 0 Then x = 300
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 150 Or y = 80 Then GoTo mcrash2
        If x > 160 And y > 90 Then GoTo mcrash2
        '########## DOOR CODES #########
        If x = 305 Then segm = 1: GoTo m2seg12
        If y = 185 Then segm = 0: GoTo m2seg14
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End


    m2seg14: Cls '                  >>> SEGMENT #14 <<<
    '######## LEVEL #########
    Line (0, 80)-(150, 80), 2
    Line (150, 80)-(150, 0), 2
    Line (0, 100)-(170, 100), 2
    Line (170, 100)-(170, 0), 2
    Line (151, 70)-(169, 60), 1, BF
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 10
    If segm = 1 Then x = 10
    If i = 0 Then stat$ = "Passage Blocked:"
    If segm = 0 Then stat$ = "There it is!!"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## ITEM CODE ######
        If i = 0 Then Circle (160, 40), 3, 6: Paint (160, 40), 6 Else Circle (160, 40), 3, 0: Paint (160, 40), 0
        If x > 152 And x < 159 Then If y = 29 Or y = 42 Then i = 1: stat$ = "Exit Cave:Got Item"
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y < 81 Then GoTo mcrash2
        If x = 161 Or y = 91 Then GoTo mcrash2
        If y = 51 Or y = 70 Then GoTo mcrash2
        '########## DOOR CODES #########
        If x = 5 Then segm = 3: GoTo m2seg5
        If y = 5 Then segm = 1: GoTo m2seg13
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m2seg15: Cls '                  >>> SEGMENT #15 <<<
    '######## LEVEL #########
    Line (150, 200)-(150, 80), 2
    Line (150, 80)-(320, 80), 2
    Line (170, 200)-(170, 100), 2
    Line (170, 100)-(320, 100), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 180: d = 1
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 150 Or y = 80 Then GoTo mcrash2
        If x > 160 And y > 90 Then GoTo mcrash2
        If x = 305 Then x = 304
        '########## DOOR CODES #########
        If y = 185 Then segm = 2: GoTo m2seg3
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m2seg16: Cls '                  >>> SEGMENT #16 <<<
    '######## LEVEL #########
    Line (320, 100)-(150, 100), 2
    Line (320, 80)-(170, 80), 2
    Line (150, 100)-(150, 0), 2
    Line (170, 80)-(170, 0), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 300
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x > 160 And y < 81 Then GoTo mcrash2
        If x = 150 Or y = 90 Then GoTo mcrash2
        If y = 10 Then y = 11
        '########## DOOR CODES ##########
        If x = 305 Then segm = 1: GoTo m2seg6
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m2seg17: Cls '                  >>> SEGMENT #17 <<<
    '######## LEVEL #########
    Line (150, 200)-(150, 80), 2
    Line (150, 80)-(320, 80), 2
    Line (170, 200)-(170, 100), 2
    Line (170, 100)-(320, 100), 2
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 180: d = 1
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 150 Or y = 80 Then GoTo mcrash2
        If x > 160 And y > 90 Then GoTo mcrash2
        If x = 305 Then x = 304
        '########## DOOR CODES #########
        If y = 185 Then segm = 1: GoTo m2seg5
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    mfinish2: Cls
    Color 10
    Print " You completed the mission!"
    Print
    Print " Now for the next one!"
    Print
    Color 9
    Print
    Print " This level's code is: INDEEP"
    Print " Next level's code is: SUBRUINS"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu6

    dbtt: Cls
    Color 14
    Print " Your battery ran out!"
    Print
    Print " Esc. = Exit| Try again?"
    Print
    Color 9
    Print
    Print " This level's code is: INDEEP"
    Print " Next level's code is: >>did not pass<<"
    Print
    Print " Press SPACEBAR to Retry..."
    PCopy 1, 0
    btt = 0
    Do
        press$ = InKey$
        If press$ = Chr$(27) Then End
    Loop Until press$ = " "
    segm = 0
    GoTo m2seg1

    End

    mcrash2: Cls
    Color 12
    Print " You Crashed My Robot!"
    Print
    Print " Sorry, You are fired!"
    Print
    Color 9
    Print
    Print " This level's code is: INDEEP"
    Print " Next level's code is: >>did not pass<<"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu

End Sub

Sub Mission03
    Screen 7, 0, 1, 0
    Dim crh1(100), crh2(100), crv1(100), crv2(100), mask(100)
    Play "MB L64 <<<"
    Color 15
    Print " Mission Status:"
    Print
    Print "      Mission 3: In this mission, you"
    Print " will be exploring a collapsed ruin. "
    Print " My scans show me that my flat robot,"
    Print " 'Creeper' designed for getting under"
    Print " things, should be able to retreive  "
    Print " the gem located there. It also has a"
    Print " 30 minute battery life, this is     "
    Print " plenty of time to clear this level. "
    Print " Take your time, and be careful. I   "
    Print " made a flat towing bot for any dead "
    Print " batteries. Just don't crash!"
    Print
    Color 9
    Print "  NOTE: If the robot stops, its a "
    Print "        dead end, try a new direction"
    Print
    Print
    Color 10
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls

    '######### ROBOT ##########
    Line (1, 1)-(2, 10), 8, BF
    Line (10, 1)-(9, 10), 8, BF
    Line (3, 2)-(8, 9), 9, BF
    PSet (4, 1), 7: PSet (7, 1), 7
    PCopy 1, 0
    Get (1, 1)-(10, 10), crh1()
    Cls
    Line (1, 1)-(2, 10), 8, BF
    Line (10, 1)-(9, 10), 8, BF
    Line (3, 2)-(8, 9), 9, BF
    PSet (4, 10), 7: PSet (7, 10), 7
    PCopy 1, 0
    Get (1, 1)-(10, 10), crh2()
    Cls
    Line (1, 1)-(10, 2), 8, BF
    Line (1, 10)-(10, 9), 8, BF
    Line (2, 3)-(9, 8), 9, BF
    PSet (1, 4), 7: PSet (1, 7), 7
    Get (1, 1)-(10, 10), crv1()
    PCopy 1, 0
    Cls
    Line (1, 1)-(10, 2), 8, BF
    Line (1, 10)-(10, 9), 8, BF
    Line (2, 3)-(9, 8), 9, BF
    PSet (10, 4), 7: PSet (10, 7), 7
    Get (1, 1)-(10, 10), crv2()
    PCopy 1, 0
    Cls
    Get (1, 1)-(10, 10), mask()
 
    m3seg1: Cls '                    >>> SEGMENT #01 <<<
    '######### LEVEL ########
    Line (150, 200)-(150, 0), 6
    Line (170, 200)-(170, 0), 6
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 155: y = 180: d = 1
    If segm = 1 Then y = 10
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Ruin: Got Gem"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If y < 184 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 161 Then GoTo mcrash3
        If x = 150 Then GoTo mcrash3
        '########## DOOR CODES ##########
        If i = 0 And y = 185 Then y = 184: stat$ = "Not Finished " ' ELSE GOTO mfinish3
        If i = 0 And y < 184 Then stat$ = "Collect Item:"
        If y = 5 Then segm = 0: GoTo m3seg2
        If i = 1 And y = 185 Then GoTo mfinish3
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m3seg2: Cls '                    >>> SEGMENT #02 <<<
    '######## LEVEL #########
    Line (150, 0)-(150, 80), 6
    Line (170, 0)-(170, 80), 6
    Line (0, 80)-(150, 80), 6
    Line (320, 80)-(170, 80), 6
    Line (150, 200)-(150, 100), 6
    Line (170, 200)-(170, 100), 6
    Line (0, 100)-(150, 100), 6
    Line (320, 100)-(170, 100), 6
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 180
    If segm = 1 Then x = 10
    If segm = 2 Then x = 300
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Ruin: Got Gem"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If y < 184 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y < 81 Then GoTo mcrash3
        If x > 160 And y < 81 Then GoTo mcrash3
        If x < 151 And y > 90 Then GoTo mcrash3
        If x > 160 And y > 90 Then GoTo mcrash3
        If y = 5 Then y = 6
        '########## DOOR CODES ##########
        If x = 5 Then segm = 0: GoTo m3seg13
        If x = 305 Then segm = 0: GoTo m3seg3
        If y = 185 Then segm = 1: GoTo m3seg1
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m3seg3: Cls '                    >>> SEGMENT #03 <<<
    '######### LEVEL ########
    Line (150, 0)-(150, 80), 6
    Line (170, 0)-(170, 80), 6
    Line (0, 80)-(150, 80), 6
    Line (320, 80)-(170, 80), 6
    Line (0, 100)-(320, 100), 6
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 10
    If segm = 1 Then y = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Ruin: Got Gem"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y < 81 Then GoTo mcrash3
        If x > 160 And y < 81 Then GoTo mcrash3
        If y = 91 Then GoTo mcrash3
        If x = 300 Then x = 299
        '########## DOOR CODES ########
        If x = 5 Then segm = 2: GoTo m3seg2
        If y = 5 Then segm = 0: GoTo m3seg4
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m3seg4: Cls '                    >>> SEGMENT #04 <<<
    '######### LEVEL ########
    Line (150, 200)-(150, 100), 6
    Line (170, 200)-(170, 100), 6
    Line (0, 100)-(150, 100), 6
    Line (320, 100)-(170, 100), 6
    Line (0, 80)-(320, 80), 6
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 180
    If segm = 1 Then x = 300
    If segm = 2 Then x = 10
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Ruin: Got Gem"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y > 90 Then GoTo mcrash3
        If x > 160 And y > 90 Then GoTo mcrash3
        If y = 80 Then GoTo mcrash3
        '########## DOOR CODES ###########
        If y = 185 Then segm = 1: GoTo m3seg3
        If x = 5 Then segm = 1: GoTo m3seg15
        If x = 305 Then segm = 0: GoTo m3seg5
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m3seg5: Cls '                    >>> SEGMENT #05 <<<
    '########## LEVEL ########
    Line (0, 80)-(150, 80), 6
    Line (0, 100)-(150, 100), 6
    Line (150, 0)-(150, 80), 6
    Line (150, 100)-(150, 200), 6
    Line (170, 0)-(170, 200), 6
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 10
    If segm = 1 Then y = 10
    If segm = 2 Then y = 180
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Ruin: Got Gem"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y < 81 Then GoTo mcrash3
        If x < 151 And y > 90 Then GoTo mcrash3
        If x = 161 Then GoTo mcrash3
        '########## DOOR CODES ##########
        If x = 5 Then segm = 1: GoTo m3seg4
        If y = 5 Then segm = 0: GoTo m3seg6
        If y = 185 Then segm = 0: GoTo m3seg16
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m3seg6: Cls '                    >>> SEGMENT #06 <<<
    '########## LEVEL #########
    Line (150, 200)-(150, 100), 6
    Line (170, 200)-(170, 80), 6
    Line (150, 100)-(0, 100), 6
    Line (170, 80)-(0, 80), 6
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 180
    If segm = 1 Then x = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Ruin: Got Gem"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y > 90 Then GoTo mcrash3
        If x = 161 Or y = 80 Then GoTo mcrash3
        '########## DOOR CODES ##########
        If y = 185 Then segm = 1: GoTo m3seg5
        If x = 5 Then segm = 1: GoTo m3seg7
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m3seg7: Cls '                    >>> SEGMENT #07 <<<
    '######### LEVEL #############
    Line (0, 80)-(320, 80), 6
    Line (0, 100)-(320, 100), 6
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 10
    If segm = 1 Then x = 300
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Ruin: Got Gem"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If y = 80 Or y = 91 Then GoTo mcrash3
        '########## DOOR CODES #######
        If x = 5 Then segm = 1: GoTo m3seg8
        If x = 305 Then segm = 1: GoTo m3seg6
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m3seg8: Cls '                    >>> SEGMENT #08 <<<
    '######### LEVEL #############
    Line (0, 80)-(320, 80), 6
    Line (0, 100)-(320, 100), 6
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 10
    If segm = 1 Then x = 300
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Ruin: Got Gem"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If y = 80 Or y = 91 Then GoTo mcrash3
        '########## DOOR CODES #######
        If x = 5 Then segm = 1: GoTo m3seg9
        If x = 305 Then segm = 0: GoTo m3seg7
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m3seg9: Cls '                    >>> SEGMENT #09 <<<
    '######### LEVEL ########
    Line (150, 200)-(150, 100), 6
    Line (170, 200)-(170, 100), 6
    Line (0, 100)-(150, 100), 6
    Line (320, 100)-(170, 100), 6
    Line (0, 80)-(320, 80), 6
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 180
    If segm = 1 Then x = 300
    If segm = 2 Then x = 10
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Ruin: Got Gem"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y > 90 Then GoTo mcrash3
        If x > 160 And y > 90 Then GoTo mcrash3
        If y = 80 Then GoTo mcrash3
        '########## DOOR CODES ###########
        If y = 185 Then segm = 0: GoTo m3seg14
        If x = 5 Then segm = 0: GoTo m3seg10
        If x = 305 Then segm = 0: GoTo m3seg8
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m3seg10: Cls '                   >>> SEGMENT #10 <<<
    '######## LEVEL #########
    Line (150, 200)-(150, 80), 6
    Line (150, 80)-(320, 80), 6
    Line (170, 200)-(170, 100), 6
    Line (170, 100)-(320, 100), 6
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 300
    If segm = 1 Then y = 180
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Ruin: Got Gem"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 150 Or y = 80 Then GoTo mcrash3
        If x > 160 And y > 90 Then GoTo mcrash3
        '########## DOOR CODES #########
        If y = 185 Then segm = 1: GoTo m3seg11
        If x = 305 Then segm = 2: GoTo m3seg9
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m3seg11: Cls '                    >>> SEGMENT #11 <<<
    '######### LEVEL ########
    Line (150, 200)-(150, 0), 6
    Line (170, 200)-(170, 0), 6
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 180
    If segm = 1 Then y = 10
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Ruin: Got Gem"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If y < 184 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 161 Then GoTo mcrash3
        If x = 150 Then GoTo mcrash3
        '########## DOOR CODES ##########
        If y = 5 Then segm = 1: GoTo m3seg10
        If y = 185 Then segm = 1: GoTo m3seg12
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m3seg12: Cls '                   >>> SEGMENT #12 <<<
    '######## LEVEL #########
    Line (320, 100)-(150, 100), 6
    Line (320, 80)-(170, 80), 6
    Line (150, 100)-(150, 0), 6
    Line (170, 80)-(170, 0), 6
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 300
    If segm = 1 Then y = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Ruin: Got Gem"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If y < 184 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x > 160 And y < 81 Then GoTo mcrash3
        If x = 150 Or y = 91 Then GoTo mcrash3
        '########## DOOR CODES ##########
        If x = 305 Then segm = 1: GoTo m3seg13
        If y = 5 Then segm = 0: GoTo m3seg11
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End


    m3seg13: Cls '                   >>> SEGMENT #13 <<<
    '######### LEVEL #############
    Line (0, 80)-(320, 80), 6
    Line (0, 100)-(320, 100), 6
    Line (140, 50)-(180, 150), 6, BF
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 300
    If segm = 1 Then x = 10
    If i = 0 Then stat$ = "Collect Item:"
    If segm = 0 Then stat$ = "Passage Blocked:"
    If i = 1 Then stat$ = "Exit Ruin:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## ITEM CODE ###########
        If i = 0 Then Circle (90, 90), 2, 10: Paint (90, 90), 10 Else Circle (90, 90), 2, 0: Paint (90, 90), 0
        If i = 0 Then If x = 79 Or x = 92 Then If y > 84 And y < 87 Then i = 1: stat$ = "Exit Ruin:Got Item"
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If y = 80 Or y = 91 Then GoTo mcrash3
        If x = 180 Or x = 131 Then GoTo mcrash3
        '########## DOOR CODES #######
        If x = 305 Then segm = 1: GoTo m3seg2
        If x = 5 Then segm = 0: GoTo m3seg12
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m3seg14: Cls '                    >>> SEGMENT #14 <<<
    '######### LEVEL ########
    Line (150, 0)-(150, 80), 6
    Line (170, 0)-(170, 80), 6
    Line (0, 80)-(150, 80), 6
    Line (320, 80)-(170, 80), 6
    Line (0, 100)-(320, 100), 6
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 10
    If segm = 1 Then x = 300
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Ruin: Got Gem"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y < 81 Then GoTo mcrash3
        If x > 160 And y < 81 Then GoTo mcrash3
        If y = 91 Then GoTo mcrash3
        If x = 10 Then x = 11
        '########## DOOR CODES ########
        If x = 305 Then segm = 0: GoTo m3seg15
        If y = 5 Then segm = 0: GoTo m3seg9
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m3seg15: Cls '                    >>> SEGMENT #15 <<<
    '######### LEVEL #############
    Line (0, 80)-(320, 80), 6
    Line (0, 100)-(320, 100), 6
    Line (140, 50)-(180, 150), 6, BF
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 10: d = 4
    If segm = 1 Then x = 299: d = 2
    If i = 0 Then stat$ = "Passage Blocked:"
    If i = 1 Then stat$ = "Exit Ruin: Got Gem"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If y = 80 Or y = 91 Then GoTo mcrash3
        If x = 180 Or x = 131 Then GoTo mcrash3
        '########## DOOR CODES #######
        If x = 5 Then segm = 1: GoTo m3seg14
        If x = 305 Then segm = 2: GoTo m3seg4
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m3seg16: Cls '               >>> SEGMENT #16 <<<
    '######## LEVEL #########
    Line (0, 80)-(150, 80), 6
    Line (150, 80)-(150, 0), 6
    Line (0, 100)-(170, 100), 6
    Line (170, 100)-(170, 0), 6
    Line (0, 50)-(35, 150), 6, BF
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 10
    If i = 0 Then stat$ = "Passage Blocked:"
    If i = 1 Then stat$ = "Exit Ruin: Got Gem"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), crh1(), PSet
        If d = 2 Then Put (x, y), crv1(), PSet
        If d = 3 Then Put (x, y), crh2(), PSet
        If d = 4 Then Put (x, y), crv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt3
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x < 151 And y < 81 Then GoTo mcrash3
        If x = 161 Or y = 91 Then GoTo mcrash3
        If x = 35 Then GoTo mcrash3
        '########## DOOR CODES #########
        If y = 5 Then segm = 2: GoTo m3seg5
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    mfinish3: Cls
    Color 10
    Print " You completed the mission!"
    Print
    Print " Now for the next one!"
    Print
    Color 9
    Print
    Print " This level's code is: SUBRUINS"
    Print " Next level's code is: TOWER"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu7

    dbtt3: Cls
    Color 14
    Print " Your battery ran out!"
    Print
    Print " Esc. = Exit| Try again?"
    Print
    Color 9
    Print
    Print " This level's code is: SUBRUINS"
    Print " Next level's code is: >>did not pass<<"
    Print
    Print " Press SPACEBAR to Retry..."
    PCopy 1, 0
    btt = 0
    Do
        press$ = InKey$
        If press$ = Chr$(27) Then End
    Loop Until press$ = " "
    segm = 0
    GoTo m3seg1

    mcrash3: Cls
    Color 12
    Print " You Crashed My Robot!"
    Print
    Print " Sorry, You are fired!"
    Print
    Color 9
    Print
    Print " This level's code is: SUBRUINS"
    Print " Next level's code is: >>did not pass<<"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu

End Sub

Sub Mission04
    Screen 7, 0, 1, 0
    Dim drh1(100), drh2(100), drv1(100), drv2(100), mask(100)
    Play "MB L64 <<<"
    Color 15
    Print " Mission Status:"
    Print
    Print "      Mission 4: I was successful in"
    Print " retreaving the third gem. But I was "
    Print " ambushed, and the gem stolen. It did"
    Print " not go far. It was taken by the     "
    Print " Peditron Science Lab. Never fear,   "
    Print " you're getting it back with the help"
    Print " of 'Drop Bot'. He can take on the   "
    Print " air-ducks to the lab where the gem  "
    Print " is being held. Get in and out fast, "
    Print " I don't want my tecnology in their  "
    Print " hands. Good luck!"
    Print
    Color 9
    Print "  NOTE: You have Three Minutes to get"
    Print "        in and out undetected!"
    Print
    Print
    Color 10
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    '######### ROBOT ##########
    Line (1, 1)-(2, 10), 8, BF
    Line (10, 1)-(9, 10), 8, BF
    Line (3, 2)-(8, 9), 12, BF
    Line (5, 5)-(6, 6), 7, BF
    PSet (4, 1), 7: PSet (7, 1), 7
    PCopy 1, 0
    Get (1, 1)-(10, 10), drh1()
    Cls
    Line (1, 1)-(2, 10), 8, BF
    Line (10, 1)-(9, 10), 8, BF
    Line (3, 2)-(8, 9), 12, BF
    Line (5, 5)-(6, 4), 7, BF
    PSet (4, 10), 7: PSet (7, 10), 7
    PCopy 1, 0
    Get (1, 1)-(10, 10), drh2()
    Cls
    Line (1, 1)-(10, 2), 8, BF
    Line (1, 10)-(10, 9), 8, BF
    Line (2, 3)-(9, 8), 12, BF
    Line (5, 5)-(6, 6), 7, BF
    PSet (1, 4), 7: PSet (1, 7), 7
    Get (1, 1)-(10, 10), drv1()
    PCopy 1, 0
    Cls
    Line (1, 1)-(10, 2), 8, BF
    Line (1, 10)-(10, 9), 8, BF
    Line (2, 3)-(9, 8), 12, BF
    Line (5, 5)-(4, 6), 7, BF
    PSet (10, 4), 7: PSet (10, 7), 7
    Get (1, 1)-(10, 10), drv2()
    PCopy 1, 0
    Cls
    Get (1, 1)-(10, 10), mask()
    m4seg1: Cls '                  >>> SEGMENT #01 <<<
    '######## LEVEL ########
    Line (2, 20)-(310, 190), 7, B
    Line (20, 30)-(40, 50), 7, B
    Line (20, 30)-(25, 35), 7: Line (40, 30)-(35, 35), 7
    Line (25, 35)-(35, 35), 7
    Line (25, 35)-(25, 50), 7: Line (35, 35)-(35, 50), 7
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 290: y = 180: d = 1
    If segm = 1 Then x = 26: y = 60: d = 3
    btt$ = "Time: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Press SPACEBAR to pick up bot:"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), drh1(), PSet
        If d = 2 Then Put (x, y), drv1(), PSet
        If d = 3 Then Put (x, y), drh2(), PSet
        If d = 4 Then Put (x, y), drv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        If i = 1 Then If press$ = " " Then GoTo mfinish4
        '########### THREE MIN CODE ############
        btt = btt + 1
        If (btt / 100) > 180 Then GoTo dbtt4
        If y < 184 And (btt / 100) Then btt$ = "Time: [||||||||||]"
        If (btt / 100) > 18 Then btt$ = "Time: [||||||||| ]": C = 10
        If (btt / 100) > 36 Then btt$ = "Time: [||||||||  ]": C = 10
        If (btt / 100) > 54 Then btt$ = "Time: [|||||||   ]": C = 10
        If (btt / 100) > 72 Then btt$ = "Time: [||||||    ]": C = 14
        If (btt / 100) > 90 Then btt$ = "Time: [|||||     ]": C = 14
        If (btt / 100) > 108 Then btt$ = "Time: [||||      ]": C = 14
        If (btt / 100) > 125 Then btt$ = "Time: [|||       ]": C = 12
        If (btt / 100) > 144 Then btt$ = "Time: [||        ]": C = 12
        If (btt / 100) > 162 Then btt$ = "Time: [|         ]": C = 12
        '########## BARRIER CODES #######
        If y = 181 Or y = 20 Then GoTo mcrash4
        If x = 301 Or x = 2 Then GoTo mcrash4
        '########## DOOR CODES ##########
        If x > 10 And x < 41 Then If y = 21 Or y = 50 Then segm = 0: GoTo m4seg2
        If x = 40 Or x = 11 Then If y > 21 And y < 51 Then segm = 0: GoTo m4seg2
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m4seg2: Cls '                  >>> SEGMENT #02 <<<
    '######## LEVEL ########
    Line (2, 20)-(2, 190), 7
    Line (22, 20)-(22, 50), 7
    Line (2, 20)-(22, 20), 7
    Line (22, 70)-(22, 170), 7
    Line (22, 70)-(280, 70), 7
    Line (280, 70)-(280, 170), 7
    Line (2, 190)-(300, 190), 7
    Line (300, 190)-(300, 50), 7
    Line (300, 50)-(22, 50), 7
    Line (22, 170)-(150, 170), 7
    Line (280, 170)-(170, 170), 7
    Line (150, 170)-(150, 100), 7
    Line (170, 170)-(170, 100), 7
    Line (150, 100)-(170, 100), 7
    '**DOOR**
    Line (150, 100)-(155, 105), 7
    Line (170, 100)-(165, 105), 7
    Line (150, 120)-(170, 120), 7
    Line (150, 120)-(155, 115), 7
    Line (170, 120)-(165, 115), 7
    Line (155, 105)-(165, 115), 7, B
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 8: y = 35: d = 3
    If segm = 1 Then x = 155: y = 125: d = 3
    btt$ = "Time: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Get Out Quick:"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), drh1(), PSet
        If d = 2 Then Put (x, y), drv1(), PSet
        If d = 3 Then Put (x, y), drh2(), PSet
        If d = 4 Then Put (x, y), drv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### THREE MIN CODE ############
        btt = btt + 1
        If (btt / 100) > 180 Then GoTo dbtt4
        If (btt / 100) > 18 Then btt$ = "Time: [||||||||| ]": C = 10
        If (btt / 100) > 36 Then btt$ = "Time: [||||||||  ]": C = 10
        If (btt / 100) > 54 Then btt$ = "Time: [|||||||   ]": C = 10
        If (btt / 100) > 72 Then btt$ = "Time: [||||||    ]": C = 14
        If (btt / 100) > 90 Then btt$ = "Time: [|||||     ]": C = 14
        If (btt / 100) > 108 Then btt$ = "Time: [||||      ]": C = 14
        If (btt / 100) > 125 Then btt$ = "Time: [|||       ]": C = 12
        If (btt / 100) > 144 Then btt$ = "Time: [||        ]": C = 12
        If (btt / 100) > 162 Then btt$ = "Time: [|         ]": C = 12
        '########## BARRIER CODES #######
        If y = 181 Or y = 20 Then GoTo mcrash4
        If x = 301 Or x = 2 Then GoTo mcrash4
        If x = 13 Then If y > 20 And y < 51 Then GoTo mcrash4
        If y = 50 Then If x > 12 And x < 300 Then GoTo mcrash4
        If y = 61 Then If x > 12 And x < 280 Then GoTo mcrash4
        If x = 13 Then If y > 60 And y < 171 Then GoTo mcrash4
        If x = 280 Then If y > 60 And y < 171 Then GoTo mcrash4
        If y = 170 Then If x > 160 And x < 281 Then GoTo mcrash4
        If y = 170 Then If x > 12 And x < 151 Then GoTo mcrash4
        If x = 150 Then If y > 100 And y < 171 Then GoTo mcrash4
        If x = 161 Then If y > 100 And y < 171 Then GoTo mcrash4
        '########## DOOR CODES ##########
        If y = 25 Then segm = 1: GoTo m4seg1
        If y = 120 Then If x > 150 And x < 161 Then segm = 0: GoTo m4seg3
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m4seg3: Cls '                       >>> SEGMENT #03 <<<
    '######## LEVEL ########
    Line (130, 100)-(190, 190), 6, B
    Line (3, 100)-(53, 190), 6, B
    Line (299, 100)-(249, 190), 6, B
    Line (2, 20)-(300, 190), 7, B
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 155: y = 120: d = 3
    btt$ = "Time: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Get Out Quick:"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## ITEM CODE ########
        If i = 0 Then Circle (160, 180), 2, 14: Paint (160, 180), 14 Else Circle (160, 180), 2, 0: Paint (160, 180), 0
        If i = 0 Then If x > 154 And x < 157 And y = 169 Then i = 1: stat$ = "Get Out Quick:"
        If i = 0 Then If y > 174 And y < 177 Then If x = 162 Or x = 149 Then i = 1: stat$ = "Get Out Quick:"
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), drh1(), PSet
        If d = 2 Then Put (x, y), drv1(), PSet
        If d = 3 Then Put (x, y), drh2(), PSet
        If d = 4 Then Put (x, y), drv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### THREE MIN CODE ############
        btt = btt + 1
        If (btt / 100) > 180 Then GoTo dbtt4
        If (btt / 100) > 18 Then btt$ = "Time: [||||||||| ]": C = 10
        If (btt / 100) > 36 Then btt$ = "Time: [||||||||  ]": C = 10
        If (btt / 100) > 54 Then btt$ = "Time: [|||||||   ]": C = 10
        If (btt / 100) > 72 Then btt$ = "Time: [||||||    ]": C = 14
        If (btt / 100) > 90 Then btt$ = "Time: [|||||     ]": C = 14
        If (btt / 100) > 108 Then btt$ = "Time: [||||      ]": C = 14
        If (btt / 100) > 125 Then btt$ = "Time: [|||       ]": C = 12
        If (btt / 100) > 144 Then btt$ = "Time: [||        ]": C = 12
        If (btt / 100) > 162 Then btt$ = "Time: [|         ]": C = 12
        '########## BARRIER CODES #######
        If y = 181 Or y = 20 Then GoTo mcrash4
        If x = 130 Or x = 181 Then GoTo mcrash4
        '########## DOOR CODES ##########
        If y = 105 Then segm = 1: GoTo m4seg2
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    mfinish4: Cls
    Color 10
    Print " You completed the mission!"
    Print
    Print " Now for the next one!"
    Print
    Color 9
    Print
    Print " This level's code is: TOWER"
    Print " Next level's code is: WALLDRILL"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu8


    dbtt4: Cls
    Color 12
    Print " You Lost My Robot!"
    Print
    Print " Sorry, You are fired!"
    Print
    Color 9
    Print
    Print " This level's code is: TOWER"
    Print " Next level's code is: >>did not pass<<"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu

    End

    mcrash4: Cls
    Color 12
    Print " You Crashed My Robot!"
    Print
    Print " Sorry, You are fired!"
    Print
    Color 9
    Print
    Print " This level's code is: TOWER"
    Print " Next level's code is: >>did not pass<<"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu

End Sub

Sub Mission05
    Screen 7, 0, 1, 0
    Dim dbh1(100), dbh2(100), dbv1(100), dbv2(100), mask(100)
    Play "MB L64 <<<"
    Color 15
    Print " Mission Status:"
    Print
    Print "      Mission 5: You're next mission "
    Print " takes you back to a pyramid, but    "
    Print " this time a 1-inch thick wall is    "
    Print " keeping you from our goal. Have no  "
    Print " fear, I have designed a drilling bot"
    Print " just right for the job. 'Drill-Bot' "
    Print " is its model name. You activate the "
    Print " drill by pressing the PageUp. But"
    Print " be careful, the drill burns the     "
    Print " battery faster. So turn it on only  "
    Print " when you're going to drill the wall."
    Print
    Color 9
    Print " PS: Pressing PageDown turns off the "
    Print "     Drill"
    Print
    Print
    Color 10
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    '######### ROBOT ##########
    Line (1, 4)-(2, 10), 8, BF
    Line (10, 4)-(9, 10), 8, BF
    Line (3, 4)-(8, 9), 9, BF
    Line (2, 3)-(9, 3), 7: Line (2, 3)-(5, 1), 7: Line (9, 3)-(7, 1), 7
    PSet (6, 1), 7
    Paint (5, 2), 7
    PCopy 1, 0
    Get (1, 1)-(10, 10), dbh1()
    Cls
    Line (1, 1)-(2, 7), 8, BF
    Line (10, 1)-(9, 7), 8, BF
    Line (3, 2)-(8, 7), 9, BF
    Line (2, 8)-(9, 8), 7: Line (2, 8)-(5, 10), 7: Line (9, 8)-(7, 10), 7
    PSet (6, 10), 7: Paint (5, 9), 7
    PCopy 1, 0
    Get (1, 1)-(10, 10), dbh2()
    Cls
    Line (4, 1)-(10, 2), 8, BF
    Line (4, 10)-(10, 9), 8, BF
    Line (4, 3)-(9, 8), 9, BF
    Line (3, 2)-(3, 9), 7: Line (3, 2)-(1, 5), 7: Line (3, 9)-(1, 6), 7
    Paint (2, 5), 7
    Get (1, 1)-(10, 10), dbv1()
    PCopy 1, 0
    Cls
    Line (1, 1)-(7, 2), 8, BF
    Line (1, 10)-(7, 9), 8, BF
    Line (2, 3)-(7, 8), 9, BF
    Line (8, 2)-(8, 9), 7: Line (8, 2)-(10, 5), 7: Line (8, 9)-(10, 7), 7
    PSet (10, 6), 7: Paint (9, 5), 7
    Get (1, 1)-(10, 10), dbv2()
    PCopy 1, 0
    Cls
    Get (1, 1)-(10, 10), mask()
    m5seg1: Cls
    '######## LEVEL ######
    Line (150, 10)-(150, 200), 12
    Line (170, 10)-(170, 200), 12
    Line (150, 10)-(170, 10), 12
    Line (150, 100)-(170, 100), 12
    PCopy 1, 0
    '######### PROGRAM ######
    x = 155: y = 180: d = 1
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Pyramid:"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## ITEM CODE ###########
        If i = 0 Then Circle (160, 16), 2, 13: Paint (160, 16), 13 Else Circle (160, 16), 2, 0: Paint (160, 16), 0
        If x > 153 And x < 159 And y = 18 Then i = 1: stat$ = "Exit Pyramid:"
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), dbh1(), PSet
        If d = 2 Then Put (x, y), dbv1(), PSet
        If d = 3 Then Put (x, y), dbh2(), PSet
        If d = 4 Then Put (x, y), dbv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        If press$ = Chr$(0) + "I" Then dr = 1
        If press$ = Chr$(0) + "Q" Then dr = 0
        '########### DRILL CODE ##############
        If dr = 1 Then btt = btt + 100
        If y = 101 And dr = 1 Then w = 1
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt5
        If y < 184 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 161 Then GoTo mcrash5
        If x = 150 Then GoTo mcrash5
        If y = 10 Then GoTo mcrash5
        If w = 0 And y = 100 Then GoTo mcrash5
        '########## DOOR CODES ##########
        If i = 0 And y = 185 Then y = 184: stat$ = "Not Finished " ' ELSE GOTO mfinish3
        If i = 0 And y < 184 Then stat$ = "Collect Item:"
        If i = 0 And dr = 1 Then stat$ = "  Drill On!!!"
        If i = 1 And y = 185 Then GoTo mfinish5
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    mfinish5: Cls
    Color 10
    Print " You completed the mission!"
    Print
    Print " Now for the last one!"
    Print
    Color 9
    Print
    Print " This level's code is: WALLDRILL"
    Print " Next level's code is: AMAZEME"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu9

    End

    dbtt5: Cls
    Color 14
    Print " Your battery ran out!"
    Print
    Print " Esc. = Exit| Try again?"
    Print
    Color 9
    Print
    Print " This level's code is: WALLDRILL"
    Print " Next level's code is: >>did not pass<<"
    Print
    Print " Press SPACEBAR to Retry..."
    PCopy 1, 0
    btt = 0
    Do
        press$ = InKey$
        If press$ = Chr$(27) Then End
    Loop Until press$ = " "
    segm = 0: dr = 0
    GoTo m5seg1
    End

    mcrash5: Cls
    Color 12
    Print " You Crashed My Robot!"
    Print
    Print " Sorry, You are fired!"
    Print
    Color 9
    Print
    Print " This level's code is: WALLDRILL"
    Print " Next level's code is: >>did not pass<<"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu


    End
End Sub

Sub Mission06
    Cls
    Screen 7, 0, 1, 0
    Play "MB L64 <<<"
    Dim sch1(100), sch2(100), scv1(100), scv2(100), mask(100)
    Play "MB L64 <<<"
    Color 15
    Print " Mission Status:"
    Print
    Print "      Mission 6: I have the location"
    Print " of the last gem. It has shown up in"
    Print " a cave which seems to be a maze of "
    Print " rooms. You're piloting Scorpian again"
    Print " to collect the gem. Keep in mind the"
    Print " the 30 minute battery life. Also keep"
    Print " mind that this maze of rooms are quite"
    Print " complex. So keep up with where you are"
    Print " going. Good luck!"
    Print
    Print
    Print
    Print
    Color 10
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "

    Cls
    '############# ROBOT ##########
    Line (1, 1)-(2, 10), 8, BF
    Line (10, 1)-(9, 10), 8, BF
    Line (3, 2)-(8, 9), 14, BF
    Line (5, 1)-(6, 7), 12, BF
    Line (5, 5)-(6, 8), 4, BF
    PCopy 1, 0
    Get (1, 1)-(10, 10), sch1()
    Cls
    Line (1, 1)-(2, 10), 8, BF
    Line (10, 1)-(9, 10), 8, BF
    Line (3, 2)-(8, 9), 14, BF
    Line (5, 3)-(6, 10), 12, BF
    Line (5, 7)-(6, 10), 4, BF
    PCopy 1, 0
    Get (1, 1)-(10, 10), sch2()
    Cls
    Line (1, 1)-(10, 2), 8, BF
    Line (1, 10)-(10, 9), 8, BF
    Line (2, 3)-(9, 8), 14, BF
    Line (1, 5)-(7, 6), 12, BF
    Line (5, 5)-(8, 6), 4, BF
    Get (1, 1)-(10, 10), scv1()
    PCopy 1, 0
    Cls
    Line (1, 1)-(10, 2), 8, BF
    Line (1, 10)-(10, 9), 8, BF
    Line (2, 3)-(9, 8), 14, BF
    Line (3, 5)-(10, 6), 12, BF
    Line (7, 5)-(10, 6), 4, BF
    Get (1, 1)-(10, 10), scv2()
    PCopy 1, 0
    Cls
    Get (1, 1)-(10, 10), mask()
    PCopy 1, 0

    m6seg1: Cls '                  >>> SEGMENT #01 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (5, 30)-(5, 60), 0: Line (310, 30)-(310, 60), 0
    Line (140, 190)-(170, 190), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 150: y = 175: d = 1
    If segm = 1 Then x = 290
    If segm = 2 Then x = 10
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If i = 1 And x > 139 And x < 170 Then If y = 180 Then GoTo mfinish6
        If i = 0 And x > 139 And x < 170 Then If y = 180 Then y = 179: stat$ = "Not Finished!"
        If i = 0 And y < 178 Then stat$ = "Collect Item:"
        If y > 29 And y < 51 Then If x = 300 Then segm = 0: GoTo m6seg2
        If y > 29 And y < 51 Then If x = 6 Then segm = 0: GoTo m6seg13
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m6seg2: Cls '                 >>> SEGMENT #02 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (5, 30)-(5, 60), 0
    Line (140, 20)-(170, 20), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 10
    If segm = 1 Then y = 22
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If x > 139 And x < 170 Then If y = 21 Then segm = 0: GoTo m6seg3
        If y > 29 And y < 51 Then If x = 6 Then segm = 1: GoTo m6seg1
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m6seg3: Cls '                  >>> SEGMENT #03 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (5, 30)-(5, 60), 0
    Line (140, 190)-(170, 190), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 170
    If segm = 1 Then x = 7
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If x > 139 And x < 170 Then If y = 180 Then segm = 1: GoTo m6seg2
        If y > 29 And y < 51 Then If x = 6 Then segm = 0: GoTo m6seg4
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m6seg4: Cls '                 >>> SEGMENT #04 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (310, 30)-(310, 60), 0
    Line (140, 20)-(170, 20), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 290
    If segm = 1 Then y = 22
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If x > 139 And x < 170 Then If y = 21 Then segm = 0: GoTo m6seg5
        If y > 29 And y < 51 Then If x = 299 Then segm = 1: GoTo m6seg3
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m6seg5: Cls '                 >>> SEGMENT #05 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (310, 30)-(310, 60), 0
    Line (140, 190)-(170, 190), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 175
    If segm = 1 Then x = 290
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If x > 139 And x < 170 Then If y = 180 Then segm = 1: GoTo m6seg4
        If y > 29 And y < 51 Then If x = 300 Then segm = 0: GoTo m6seg6
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m6seg6: Cls '                 >>> SEGMENT #06 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (5, 30)-(5, 60), 0
    Line (310, 30)-(310, 60), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 10
    If segm = 1 Then x = 290
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If y > 29 And y < 51 Then If x = 300 Then segm = 0: GoTo m6seg7
        If y > 29 And y < 51 Then If x = 6 Then segm = 1: GoTo m6seg5
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m6seg7: Cls '                 >>> SEGMENT #07 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (5, 30)-(5, 60), 0
    Line (140, 190)-(170, 190), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 7
    If segm = 1 Then y = 175
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If x > 139 And x < 170 Then If y = 180 Then segm = 0: GoTo m6seg8
        If y > 29 And y < 51 Then If x = 6 Then segm = 1: GoTo m6seg6
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m6seg8: Cls '                 >>> SEGMENT #08 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (310, 30)-(310, 60), 0
    Line (140, 190)-(170, 190), 0: Line (140, 20)-(170, 20), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 22
    If segm = 1 Then x = 290
    If segm = 2 Then y = 175
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If x > 139 And x < 170 Then If y = 21 Then segm = 1: GoTo m6seg7
        If y > 29 And y < 51 Then If x = 300 Then segm = 0: GoTo m6seg9
        If x > 139 And x < 170 Then If y = 180 Then segm = 0: GoTo m6seg15
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m6seg9: Cls '                 >>> SEGMENT #09 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (5, 30)-(5, 60), 0
    Line (140, 190)-(170, 190), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 7
    If segm = 1 Then y = 175
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If y > 29 And y < 51 Then If x = 6 Then segm = 1: GoTo m6seg8
        If x > 139 And x < 170 Then If y = 180 Then segm = 0: GoTo m6seg10
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m6seg10: Cls '                >>> SEGMENT #10 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (310, 30)-(310, 60), 0
    Line (140, 190)-(170, 190), 0: Line (140, 20)-(170, 20), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 22
    If segm = 1 Then x = 290
    If segm = 2 Then y = 175
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If x > 139 And x < 170 Then If y = 21 Then segm = 1: GoTo m6seg9
        If y > 29 And y < 51 Then If x = 300 Then segm = 0: GoTo m6seg11
        If x > 139 And x < 170 Then If y = 180 Then segm = 0: GoTo m6seg18
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m6seg11: Cls '                >>> SEGMENT #11 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (5, 30)-(5, 60), 0
    Line (140, 190)-(170, 190), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 7
    If segm = 1 Then y = 175
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If y > 29 And y < 51 Then If x = 6 Then segm = 1: GoTo m6seg10
        If x > 139 And x < 170 Then If y = 180 Then segm = 0: GoTo m6seg12
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m6seg12: Cls '                >>> SEGMENT #12 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (140, 20)-(170, 20), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 22
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## ITEM CODE ###########
        If i = 0 Then Circle (160, 187), 2, 15: Paint (160, 187), 15 Else Circle (160, 187), 2, 0: Paint (160, 187), 0
        If x > 154 And x < 157 And y = 176 Then i = 1: stat$ = "Exit Cave:Got Item"
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If x > 139 And x < 170 Then If y = 21 Then segm = 1: GoTo m6seg11
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End


    m6seg13: Cls '                >>> SEGMENT #13 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (310, 30)-(310, 60), 0
    Line (140, 20)-(170, 20), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 290
    If segm = 1 Then y = 23
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If y > 29 And y < 51 Then If x = 300 Then segm = 2: GoTo m6seg1
        If x > 139 And x < 170 Then If y = 21 Then segm = 0: GoTo m6seg14
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m6seg14: Cls '                  >>> SEGMENT #14 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (140, 190)-(170, 190), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 170
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If x > 139 And x < 170 Then If y = 180 Then segm = 1: GoTo m6seg13
        PCopy 1, 0
    Loop Until press$ = Chr$(27)

    m6seg15: Cls '                 >>> SEGMENT #15 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (140, 190)-(170, 190), 0: Line (140, 20)-(170, 20), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 22
    If segm = 1 Then y = 175
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If x > 139 And x < 170 Then If y = 21 Then segm = 2: GoTo m6seg8
        If x > 139 And x < 170 Then If y = 180 Then segm = 0: GoTo m6seg16
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m6seg16: Cls '                 >>> SEGMENT #16 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (5, 30)-(5, 60), 0
    Line (140, 20)-(170, 20), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 22
    If segm = 1 Then x = 7
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If x > 139 And x < 170 Then If y = 21 Then segm = 1: GoTo m6seg15
        If y > 29 And y < 51 Then If x = 6 Then segm = 0: GoTo m6seg17
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m6seg17: Cls ' >>> SEGMENT #17 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (310, 30)-(310, 60), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then x = 290
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If y > 29 And y < 51 Then If x = 300 Then segm = 1: GoTo m6seg16
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    m6seg18: Cls '               >>> SEGMENT #18 <<<
    '######### LEVEL ###########
    Line (5, 20)-(5, 190), 14
    Line (5, 190)-(310, 190), 14
    Line (310, 190)-(310, 20), 14
    Line (5, 20)-(310, 20), 14
    Line (140, 20)-(170, 20), 0
    PCopy 1, 0
    '######### PROGRAM ######
    If segm = 0 Then y = 22
    btt$ = "Batt: [||||||||||]": C = 10
    If i = 0 Then stat$ = "Collect Item:"
    If i = 1 Then stat$ = "Exit Cave:Got Item"
    Do
        press$ = InKey$
        Locate 1, 1: Color C: Print btt$
        Locate 2, 1: Color 9: Print stat$
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), sch1(), PSet
        If d = 2 Then Put (x, y), scv1(), PSet
        If d = 3 Then Put (x, y), sch2(), PSet
        If d = 4 Then Put (x, y), scv2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '########### BATTERY CODE ############
        btt = btt + 1
        If (btt / 100) > 1800 Then GoTo dbtt6
        If y < 189 And (btt / 100) Then btt$ = "Batt: [||||||||||]"
        If (btt / 100) > 180 Then btt$ = "Batt: [||||||||| ]": C = 10
        If (btt / 100) > 360 Then btt$ = "Batt: [||||||||  ]": C = 10
        If (btt / 100) > 540 Then btt$ = "Batt: [|||||||   ]": C = 10
        If (btt / 100) > 720 Then btt$ = "Batt: [||||||    ]": C = 14
        If (btt / 100) > 900 Then btt$ = "Batt: [|||||     ]": C = 14
        If (btt / 100) > 1080 Then btt$ = "Batt: [||||      ]": C = 14
        If (btt / 100) > 1260 Then btt$ = "Batt: [|||       ]": C = 12
        If (btt / 100) > 1440 Then btt$ = "Batt: [||        ]": C = 12
        If (btt / 100) > 1620 Then btt$ = "Batt: [|         ]": C = 12
        '########## BARRIER CODES #######
        If x = 5 Or x = 301 Then GoTo mcrash6
        If y = 20 Or y = 181 Then GoTo mcrash6
        '########## DOOR CODES ###########
        If x > 139 And x < 170 Then If y = 21 Then segm = 2: GoTo m6seg10
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End


    mfinish6: Cls
    Color 10
    Print " You completed the mission!"
    Print
    Print " You completed the game!"
    Print
    Color 9
    Print
    Print " This level's code is: AMAZEME"
    Print " Bonus Menu code is: ROBOBONUS"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Ending

    End

    dbtt6: Cls
    Color 14
    Print " Your battery ran out!"
    Print
    Print " Esc. = Exit| Try again?"
    Print
    Color 9
    Print
    Print " This level's code is: AMAZEME"
    Print " Next level's code is: >>did not pass<<"
    Print
    Print " Press SPACEBAR to Retry..."
    PCopy 1, 0
    btt = 0
    Do
        press$ = InKey$
        If press$ = Chr$(27) Then End
    Loop Until press$ = " "
    segm = 0: dr = 0
    GoTo m6seg1
    End

    mcrash6: Cls
    Color 12
    Print " You Crashed My Robot!"
    Print
    Print " Sorry, You are fired!"
    Print
    Color 9
    Print
    Print " This level's code is: AMAZEME"
    Print " Next level's code is: >>did not pass<<"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu

    End
End Sub

Sub Missionb
    Cls
    Screen 13
    Color 10
    Print " RoboRaiders: >>Mission-Bots>>"
    Locate 20, 3: Print "Press 'Enter' to select"
    Locate 22, 2: Print "Press 'F1' for Help, Press 'Esc' to Exit"
    C = 1
    Do
        press$ = InKey$
        If C = 1 Then Locate 10, 15: Color 10: Print ">>SCORPIAN>>": Locate 11, 15: Color 15: Print ">>CREEPER<<": Locate 13, 15: Color 15: Print ">>PAGE-2<<"
        If C = 2 Then Locate 10, 15: Color 15: Print ">>SCORPIAN<<": Locate 11, 15: Color 9: Print ">>CREEPER>>": Locate 13, 15: Color 15: Print ">>PAGE-2<<"
        If C = 3 Then Locate 10, 15: Color 15: Print ">>SCORPIAN<<": Locate 11, 15: Color 15: Print ">>CREEPER<<": Locate 13, 15: Color 14: Print ">>PAGE-2>>"
        If C = 2 Then If press$ = Chr$(0) + Chr$(80) Then C = 3: Play "D16"
        If C = 1 Then If press$ = Chr$(0) + Chr$(80) Then C = 2: Play "D16"
        If C = 2 Then If press$ = Chr$(0) + Chr$(72) Then C = 1: Play "D16"
        If C = 3 Then If press$ = Chr$(0) + Chr$(72) Then C = 2: Play "D16"
        If C = 2 Then If press$ = "2" Then C = 3: Play "D16"
        If C = 1 Then If press$ = "2" Then C = 2: Play "D16"
        If C = 2 Then If press$ = "8" Then C = 1: Play "D16"
        If C = 3 Then If press$ = "8" Then C = 2: Play "D16"
        If C = 1 Then If press$ = Chr$(13) Then Play "B16": Call Scorp
        If C = 2 Then If press$ = Chr$(13) Then Play "B16": Call Creep
        If C = 3 Then If press$ = Chr$(13) Then Play "B16": Call Missionb2
        If press$ = Chr$(0) + ";" Then Call Help
    Loop Until press$ = Chr$(27)
    End

End Sub

Sub Missionb2
    Cls
    Screen 13
    Color 10
    Print " RoboRaiders: >>Mission-Bots>>"
    Locate 20, 3: Print "Press 'Enter' to select"
    Locate 22, 2: Print "Press 'F1' for Help, Press 'Esc' to Exit"
    C = 1
    Do
        press$ = InKey$
        If C = 1 Then Locate 10, 15: Color 10: Print ">>DRILL-BOT>>": Locate 11, 15: Color 15: Print ">>DROP-BOT<<": Locate 13, 15: Color 15: Print ">>BONUS-MENU<<"
        If C = 2 Then Locate 10, 15: Color 15: Print ">>DRILL-BOT<<": Locate 11, 15: Color 9: Print ">>DROP-BOT>>": Locate 13, 15: Color 15: Print ">>BONUS-MENU<<"
        If C = 3 Then Locate 10, 15: Color 15: Print ">>DRILL-BOT<<": Locate 11, 15: Color 15: Print ">>DROP-BOT<<": Locate 13, 15: Color 14: Print ">>BONUS-MENU>>"
        If C = 2 Then If press$ = Chr$(0) + Chr$(80) Then C = 3: Play "D16"
        If C = 1 Then If press$ = Chr$(0) + Chr$(80) Then C = 2: Play "D16"
        If C = 2 Then If press$ = Chr$(0) + Chr$(72) Then C = 1: Play "D16"
        If C = 3 Then If press$ = Chr$(0) + Chr$(72) Then C = 2: Play "D16"
        If C = 2 Then If press$ = "2" Then C = 3: Play "D16"
        If C = 1 Then If press$ = "2" Then C = 2: Play "D16"
        If C = 2 Then If press$ = "8" Then C = 1: Play "D16"
        If C = 3 Then If press$ = "8" Then C = 2: Play "D16"
        If C = 1 Then If press$ = Chr$(13) Then Play "B16": Call Dril
        If C = 2 Then If press$ = Chr$(13) Then Play "B16": Call Drop
        If C = 3 Then If press$ = Chr$(13) Then Play "B16": Call Bonus
        If press$ = Chr$(0) + ";" Then Call Help
    Loop Until press$ = Chr$(27)
    End

End Sub

Sub Robopic
    Cls
    Screen 13
    Color 10
    Print " RoboRaiders: >>Robo-Pics>>"
    Locate 20, 3: Print "Press 'Enter' to select"
    Locate 22, 2: Print "Press 'F1' for Help, Press 'Esc' to Exit"
    C = 1
    Do
        press$ = InKey$
        If C = 1 Then Locate 10, 15: Color 10: Print ">>TRAINER-BOTS>>": Locate 11, 15: Color 15: Print ">>MISSION-BOTS<<": Locate 13, 15: Color 15: Print ">>BONUS-MENU<<"
        If C = 2 Then Locate 10, 15: Color 15: Print ">>TRAINER-BOTS<<": Locate 11, 15: Color 9: Print ">>MISSION-BOTS>>": Locate 13, 15: Color 15: Print ">>BONUS-MENU<<"
        If C = 3 Then Locate 10, 15: Color 15: Print ">>TRAINER-BOTS<<": Locate 11, 15: Color 15: Print ">>MISSION-BOTS<<": Locate 13, 15: Color 14: Print ">>BONUS-MENU>>"
        If C = 2 Then If press$ = Chr$(0) + Chr$(80) Then C = 3: Play "D16"
        If C = 1 Then If press$ = Chr$(0) + Chr$(80) Then C = 2: Play "D16"
        If C = 2 Then If press$ = Chr$(0) + Chr$(72) Then C = 1: Play "D16"
        If C = 3 Then If press$ = Chr$(0) + Chr$(72) Then C = 2: Play "D16"
        If C = 2 Then If press$ = "2" Then C = 3: Play "D16"
        If C = 1 Then If press$ = "2" Then C = 2: Play "D16"
        If C = 2 Then If press$ = "8" Then C = 1: Play "D16"
        If C = 3 Then If press$ = "8" Then C = 2: Play "D16"
        If C = 1 Then If press$ = Chr$(13) Then Play "B16": Call Trainerb
        If C = 2 Then If press$ = Chr$(13) Then Play "B16": Call Missionb
        If C = 3 Then If press$ = Chr$(13) Then Play "B16": Call Bonus
        If press$ = Chr$(0) + ";" Then Call Help
    Loop Until press$ = Chr$(27)
    End

End Sub

Sub Scorp
    Cls
    Screen 13
    Line (20, 30)-(160, 50), 14, BF
    Line (22, 36)-(158, 36), 8
    Line (22, 60)-(158, 60), 8
    '*** ARM ***
    Line (150, 29)-(60, 5), 12
    Line (130, 29)-(60, 10), 12
    Line (60, 5)-(10, 20), 12
    Line (60, 10)-(14, 24), 12
    Line (150, 29)-(130, 29), 12
    Line (10, 20)-(14, 24), 12
    Paint (60, 7), 12
    '*** GRIP ***
    Line (15, 18)-(0, 24), 7
    Line (19, 22)-(4, 28), 7
    Line (15, 18)-(19, 22), 7
    Line (0, 24)-(4, 28), 7
    Paint (4, 26), 7
    '*** WHEELS ***
    Circle (22, 48), 15, 7
    Paint (22, 48), 7
    PSet (22, 48), 0
    Circle (158, 48), 15, 7
    Paint (158, 48), 7
    PSet (158, 48), 0
    '**TEXT**
    Locate 10, 1: Print " Scorpian: Mission 1-2 & 6:"
    Locate 12, 1: Print "  This robot has a grip mounted on a"
    Locate 13, 1: Print "  boom which gives it the appearance"
    Locate 14, 1: Print "  of a scorpian. Its design allows it"
    Locate 15, 1: Print "  to pick up larger items and move   "
    Locate 16, 1: Print "  over rough terrain."
    Color 10
    Locate 20, 1: Print " Press SPACEBAR to continue..."
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Call Missionb

End Sub

Sub Tbot1
    Cls
    Screen 13
    Line (20, 20)-(160, 50), 10, BF
    Line (22, 36)-(158, 36), 8
    Line (22, 60)-(158, 60), 8
    Circle (22, 48), 15, 7
    Paint (22, 48), 7
    PSet (22, 48), 0
    Circle (158, 48), 15, 7
    Paint (158, 48), 7
    PSet (158, 48), 0
    Locate 10, 1: Print " Trainer-Bot: Test 1-2:"
    Locate 12, 1: Print "  A simple desinged robot for easy"
    Locate 13, 1: Print "  repairs. Used for the first two"
    Locate 14, 1: Print "  test in case of a crash."
    Color 10
    Locate 17, 1: Print " Press SPACEBAR to continue..."
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Call Trainerb
End Sub

Sub Tbot2
    Cls
    Screen 13
    Line (10, 25)-(20, 45), 8, BF
    Line (20, 20)-(160, 50), 10, BF
    Line (22, 36)-(158, 36), 8
    Line (22, 60)-(158, 60), 8
    Circle (22, 48), 15, 7
    Paint (22, 48), 7
    PSet (22, 48), 0
    Circle (158, 48), 15, 7
    Paint (158, 48), 7
    PSet (158, 48), 0
    Locate 10, 1: Print " Trainer-Bot: Test 3:"
    Locate 12, 1: Print "  A simple desinged robot for easy"
    Locate 13, 1: Print "  repairs. Has small grip on front"
    Locate 14, 1: Print "  for picking up small items."
    Color 10
    Locate 17, 1: Print " Press SPACEBAR to continue..."
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Call Trainerb

End Sub

Sub Test001
    Dim hor(100), vert(100), mask(100)
    Play "MB L64 <<<"
    Cls
    Screen 7, 0, 1, 0
    Color 15
    Print " Test Status:"
    Print
    Print "      This test is for Navigation."
    Print " My fine robots are powered by none"
    Print " than very two powerful 550-Can R/C"
    Print " car motors. This can leave a great"
    Print " deal of damage to them or whatever"
    Print " they hit. So to pass this test, "
    Print " make it to the other side of the "
    Print " maze unharmed."
    Print
    Print
    Print
    Color 10
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "

    test1: Cls
    '############# ROBOT ##########
    Line (1, 1)-(2, 10), 8, BF
    Line (10, 1)-(9, 10), 8, BF
    Line (3, 2)-(8, 9), 10, BF
    PCopy 1, 0
    Get (1, 1)-(10, 10), hor()
    Cls
    Line (1, 1)-(10, 2), 8, BF
    Line (1, 10)-(10, 9), 8, BF
    Line (2, 3)-(9, 8), 10, BF
    Get (1, 1)-(10, 10), vert()
    PCopy 1, 0
    Cls
    Get (1, 1)-(10, 10), mask()
    '############# LEVEL ##########
    'vertseg1
    Line (150, 200)-(150, 150), 9
    Line (170, 200)-(170, 170), 9
    'horseg1
    Line (170, 170)-(250, 170), 9
    Line (150, 150)-(230, 150), 9
    'vertseg2
    Line (250, 170)-(250, 100), 9
    Line (230, 150)-(230, 120), 9
    'horseg2
    Line (250, 100)-(100, 100), 9
    Line (230, 120)-(80, 120), 9
    'vertseg3
    Line (100, 100)-(100, 80), 9
    Line (80, 120)-(80, 60), 9
    'horseg3
    Line (100, 80)-(170, 80), 9
    Line (80, 60)-(150, 60), 9
    'vertseg4
    Line (170, 80)-(170, 0), 9
    Line (150, 60)-(150, 0), 9
    PCopy 1, 0
    '######## PROGRAM #######
    d = 1
    x = 155: y = 180
    oldx = x: oldy = y
    seg1:
    Do
        press$ = InKey$
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), hor(), PSet
        If d = 2 Then Put (x, y), vert(), PSet
        '####### Arrowkeys #########
        If d = 1 Then If press$ = Chr$(0) + "K" Then d = 2
        If d = 2 Then If press$ = Chr$(0) + "H" Then d = 1
        If d = 1 Then If press$ = Chr$(0) + "M" Then d = 2
        If d = 2 Then If press$ = Chr$(0) + "P" Then d = 1
        If press$ = Chr$(0) + "H" Then y = y - 1: Play "A"
        If press$ = Chr$(0) + "P" Then y = y + 1: Play "A"
        If press$ = Chr$(0) + "K" Then x = x - 1: Play "A"
        If press$ = Chr$(0) + "M" Then x = x + 1: Play "A"
        If y > 160 And x = 150 Then GoTo tcrash1
        If y > 160 And x = 161 Then GoTo tcrash1
        If y > 160 And y = 190 Then GoTo tcrash1
        If x < 230 And y < 160 And y >= 150 And y = 150 Then GoTo tcrash1
        If x < 230 And y < 160 And y >= 150 And x = 150 Then GoTo tcrash1
        If x > 160 And x < 230 And y = 150 Then GoTo tcrash1
        If x > 160 And x < 230 And y = 161 Then GoTo tcrash1
        If x = 241 Then GoTo tcrash1
        If x > 230 And x < 240 And y = 161 Then GoTo tcrash1
        If y > 111 And y < 150 And x = 230 Then GoTo tcrash1
        If x < 230 And x > 81 And y = 111 Then GoTo tcrash1
        If x = 80 Then GoTo tcrash1
        If x < 240 And x > 91 And y = 100 Then GoTo tcrash1
        If y < 100 And y > 71 And x = 91 Then GoTo tcrash1
        If x < 160 And x > 91 And y = 71 Then GoTo tcrash1
        If x < 150 And x > 81 And y = 60 Then GoTo tcrash1
        If y < 70 And x = 161 Then GoTo tcrash1
        If y < 60 And x = 150 Then GoTo tcrash1
        If y = 2 Then GoTo tfinish1
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    tfinish1: Cls
    Color 10
    Print " You Passed!"
    Print
    Print " You can take Test2"
    Print
    Color 9
    Print
    Print " This level's code is: TEST001"
    Print " Next level's code is: TEST002"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu2

    tcrash1: Cls
    Color 12
    Print " You Crashed!"
    Print
    Print " Sorry, You do not pass."
    Print
    Color 9
    Print
    Print " This level's code is: TEST001"
    Print " Next level's code is: >>did not pass<<"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu
End Sub

Sub Test002
    Dim hor(100), vert(100), mask(100)
    Play "MB L64 <<<"
    Cls
    Screen 7, 0, 1, 0
    Color 15
    Print " Test Status:"
    Print
    Print "      This test is for Balance."
    Print " In order to work your way though"
    Print " the many dangers of a robot, you"
    Print " must be well balanced and on gaurd."
    Print " This level includes two water pools "
    Print " that can destoy robots in a blink"
    Print " of an eye. To pass, Don't hit the  "
    Print " walls, or water."
    Print
    Print
    Print
    Color 10
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "

    test2: Cls
    '############# ROBOT ##########
    Line (1, 1)-(2, 10), 8, BF
    Line (10, 1)-(9, 10), 8, BF
    Line (3, 2)-(8, 9), 10, BF
    PCopy 1, 0
    Get (1, 1)-(10, 10), hor()
    Cls
    Line (1, 1)-(10, 2), 8, BF
    Line (1, 10)-(10, 9), 8, BF
    Line (2, 3)-(9, 8), 10, BF
    Get (1, 1)-(10, 10), vert()
    PCopy 1, 0
    Cls
    Get (1, 1)-(10, 10), mask()
    '############# LEVEL ##########
    'vertseg1
    Line (150, 200)-(150, 150), 9
    Line (170, 200)-(170, 170), 9
    'horseg1
    Line (170, 170)-(250, 170), 9
    Line (150, 150)-(230, 150), 9
    'vertseg2
    Line (250, 170)-(250, 100), 9
    Line (230, 150)-(230, 120), 9
    'horseg2
    Line (250, 100)-(100, 100), 9
    Line (230, 120)-(80, 120), 9
    'vertseg3
    Line (100, 100)-(100, 80), 9
    Line (80, 120)-(80, 60), 9
    'horseg3
    Line (100, 80)-(170, 80), 9
    Line (80, 60)-(150, 60), 9
    'vertseg4
    Line (170, 80)-(170, 0), 9
    Line (150, 60)-(150, 0), 9
    'pools
    Line (150, 150)-(230, 120), 1, BF
    Line (170, 80)-(100, 100), 1, BF
    PCopy 1, 0
    '######## PROGRAM #######
    d = 1
    x = 155: y = 180
    oldx = x: oldy = y
    Do
        press$ = InKey$
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), hor(), PSet
        If d = 2 Then Put (x, y), vert(), PSet
        '######## ARROWKEYS ######
        If d = 1 Then If press$ = Chr$(0) + "K" Then d = 2
        If d = 2 Then If press$ = Chr$(0) + "H" Then d = 1
        If d = 1 Then If press$ = Chr$(0) + "M" Then d = 2
        If d = 2 Then If press$ = Chr$(0) + "P" Then d = 1
        If press$ = Chr$(0) + "H" Then y = y - 1: Play "A"
        If press$ = Chr$(0) + "P" Then y = y + 1: Play "A"
        If press$ = Chr$(0) + "K" Then x = x - 1: Play "A"
        If press$ = Chr$(0) + "M" Then x = x + 1: Play "A"
        If y > 160 And x = 150 Then GoTo tcrash2
        If y > 160 And x = 161 Then GoTo tcrash2
        If y > 160 And y = 190 Then GoTo tcrash2
        If x < 230 And y < 160 And y >= 150 And y = 150 Then GoTo tcrash2
        If x < 230 And y < 160 And y >= 150 And x = 150 Then GoTo tcrash2
        If x > 160 And x < 230 And y = 150 Then GoTo tcrash2
        If x > 160 And x < 230 And y = 161 Then GoTo tcrash2
        If x = 241 Then GoTo tcrash2
        If x > 230 And x < 240 And y = 161 Then GoTo tcrash2
        If y > 111 And y < 150 And x = 230 Then GoTo tcrash2
        If x < 230 And x > 81 And y = 111 Then GoTo tcrash2
        If x = 80 Then GoTo tcrash2
        If x < 240 And x > 91 And y = 100 Then GoTo tcrash2
        If y < 100 And y > 71 And x = 91 Then GoTo tcrash2
        If x < 160 And x > 91 And y = 71 Then GoTo tcrash2
        If x < 150 And x > 81 And y = 60 Then GoTo tcrash2
        If y < 70 And x = 161 Then GoTo tcrash2
        If y < 60 And x = 150 Then GoTo tcrash2
        If y = 2 Then GoTo tfinish2
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    tfinish2: Cls
    Color 10
    Print " You Passed!"
    Print
    Print " You can take Test3"
    Print
    Color 9
    Print
    Print " This level's code is: TEST002"
    Print " Next level's code is: TEST003"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu3

    tcrash2: Cls
    Color 12
    Print " You Crashed!"
    Print
    Print " Sorry, You do not pass."
    Print
    Color 9
    Print
    Print " This level's code is: TEST002"
    Print " Next level's code is: >>did not pass<<"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu

End Sub

Sub Test003
    Dim hor1(100), hor2(100), vert1(100), vert2(100), mask(100)
    Play "MB L64 <<<"
    Cls
    Screen 7, 0, 1, 0
    Color 15
    Print " Test Status:"
    Print
    Print "      This test is for Collecting."
    Print " One of the main jobs of a Robo-"
    Print " Raider is collecting objects from"
    Print " ruins. This is the same level you"
    Print " last piloted, but with objets to"
    Print " pick up.(this Robot picks up an"
    Print " item automaticly, just by bump "
    Print " into it) To pass, collect all "
    Print " items (HINT: Get the items to"
    Print " hit center of the grip)"
    Print
    Print
    Print
    Color 10
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "

    test3: Cls
    '############# ROBOT ##########
    Line (1, 1)-(2, 10), 8, BF
    Line (10, 1)-(9, 10), 8, BF
    Line (3, 2)-(8, 9), 10, BF
    PSet (4, 1), 7: PSet (7, 1), 7
    PCopy 1, 0
    Get (1, 1)-(10, 10), hor1()
    Cls
    Line (1, 1)-(2, 10), 8, BF
    Line (10, 1)-(9, 10), 8, BF
    Line (3, 2)-(8, 9), 10, BF
    PSet (4, 10), 7: PSet (7, 10), 7
    PCopy 1, 0
    Get (1, 1)-(10, 10), hor2()
    Cls
    Line (1, 1)-(10, 2), 8, BF
    Line (1, 10)-(10, 9), 8, BF
    Line (2, 3)-(9, 8), 10, BF
    PSet (1, 4), 7: PSet (1, 7), 7
    Get (1, 1)-(10, 10), vert1()
    PCopy 1, 0
    Cls
    Line (1, 1)-(10, 2), 8, BF
    Line (1, 10)-(10, 9), 8, BF
    Line (2, 3)-(9, 8), 10, BF
    PSet (10, 4), 7: PSet (10, 7), 7
    Get (1, 1)-(10, 10), vert2()
    PCopy 1, 0
    Cls

    Get (1, 1)-(10, 10), mask()
    '############# LEVEL ##########
    'vertseg1
    Line (150, 200)-(150, 150), 9
    Line (170, 200)-(170, 170), 9
    'horseg1
    Line (170, 170)-(250, 170), 9
    Line (150, 150)-(230, 150), 9
    'vertseg2
    Line (250, 170)-(250, 100), 9
    Line (230, 150)-(230, 120), 9
    'horseg2
    Line (250, 100)-(100, 100), 9
    Line (230, 120)-(80, 120), 9
    'vertseg3
    Line (100, 100)-(100, 80), 9
    Line (80, 120)-(80, 60), 9
    'horseg3
    Line (100, 80)-(170, 80), 9
    Line (80, 60)-(150, 60), 9
    'vertseg4
    Line (170, 80)-(170, 0), 9
    Line (150, 60)-(150, 0), 9
    'pools
    Line (150, 150)-(230, 120), 1, BF
    Line (170, 80)-(100, 100), 1, BF
    PCopy 1, 0
    '######## PROGRAM #######
    d = 1
    x = 155: y = 180
    oldx = x: oldy = y
    Do
        press$ = InKey$
        Locate 1, 1: Print "Items:"; i
        '######## Items Code ######
        If i1 = 0 Then Circle (160, 153), 1, 12 Else Circle (160, 153), 1, 0
        If i2 = 0 Then Circle (236, 165), 1, 12 Else Circle (236, 165), 1, 0
        If i3 = 0 Then Circle (240, 120), 1, 12 Else Circle (240, 120), 1, 0
        If i4 = 0 Then Circle (90, 100), 1, 12 Else Circle (90, 100), 1, 0
        If i5 = 0 Then Circle (130, 69), 1, 12 Else Circle (130, 69), 1, 0
        If i6 = 0 Then Circle (159, 50), 1, 12 Else Circle (159, 50), 1, 0

        If i1 = 0 Then If x = 155 Or x = 156 Then If y = 154 Then i1 = 1: i = i + 1
        If i2 = 0 Then If x = 225 Or x = 237 Then If y = 160 Then i2 = 1: i = i + 1
        If i2 = 0 Then If x = 231 Or x = 232 Then If y = 155 Then i2 = 1: i = i + 1
        If i3 = 0 Then If x = 235 Or x = 236 Then If y = 121 Or y = 110 Then i3 = 1: i = i + 1
        If i4 = 0 Then If x = 85 Or x = 86 Then If y = 101 Or y = 90 Then i4 = 1: i = i + 1
        If i5 = 0 Then If y = 65 Or y = 64 Then If x = 120 Or x = 131 Then i5 = 1: i = i + 1
        If i6 = 0 Then If x = 154 Or x = 155 Then If y = 51 Or y = 40 Then i6 = 1: i = i + 1
        '######## Graphics Code #######
        Put (oldx, oldy), mask(), PSet
        oldx = x: oldy = y
        If d = 1 Then Put (x, y), hor1(), PSet
        If d = 2 Then Put (x, y), vert1(), PSet
        If d = 3 Then Put (x, y), hor2(), PSet
        If d = 4 Then Put (x, y), vert2(), PSet
        If press$ = Chr$(0) + Chr$(75) Then d = 2
        If press$ = Chr$(0) + Chr$(72) Then d = 1
        If press$ = Chr$(0) + Chr$(77) Then d = 4
        If press$ = Chr$(0) + Chr$(80) Then d = 3
        If press$ = Chr$(0) + Chr$(72) Then y = y - 1: Play "A"
        If press$ = Chr$(0) + Chr$(80) Then y = y + 1: Play "A"
        If press$ = Chr$(0) + Chr$(75) Then x = x - 1: Play "A"
        If press$ = Chr$(0) + Chr$(77) Then x = x + 1: Play "A"
        If press$ = "4" Then d = 2
        If press$ = "8" Then d = 1
        If press$ = "2" Then d = 3
        If press$ = "6" Then d = 4
        If press$ = "8" Then y = y - 1: Play "A"
        If press$ = "2" Then y = y + 1: Play "A"
        If press$ = "4" Then x = x - 1: Play "A"
        If press$ = "6" Then x = x + 1: Play "A"
        '######## Barrier Code #######
        If y > 160 And x = 150 Then GoTo tcrash3
        If y > 160 And x = 161 Then GoTo tcrash3
        If y > 160 And y = 190 Then GoTo tcrash3
        If x < 230 And y < 160 And y >= 150 And y = 150 Then GoTo tcrash3
        If x < 230 And y < 160 And y >= 150 And x = 150 Then GoTo tcrash3
        If x > 160 And x < 230 And y = 150 Then GoTo tcrash3
        If x > 160 And x < 230 And y = 161 Then GoTo tcrash3
        If x = 241 Then GoTo tcrash3
        If x > 230 And x < 240 And y = 161 Then GoTo tcrash3
        If y > 111 And y < 150 And x = 230 Then GoTo tcrash3
        If x < 230 And x > 81 And y = 111 Then GoTo tcrash3
        If x = 80 Then GoTo tcrash3
        If x < 240 And x > 91 And y = 100 Then GoTo tcrash3
        If y < 100 And y > 71 And x = 91 Then GoTo tcrash3
        If x < 160 And x > 91 And y = 71 Then GoTo tcrash3
        If x < 150 And x > 81 And y = 60 Then GoTo tcrash3
        If y < 70 And x = 161 Then GoTo tcrash3
        If y < 60 And x = 150 Then GoTo tcrash3
        If i < 6 And y = 2 Then GoTo tfail3
        If i = 6 And y = 2 Then GoTo tfinish3
        PCopy 1, 0
    Loop Until press$ = Chr$(27)
    End

    tfinish3: Cls
    Color 10
    Print " You Passed!"
    Print
    Print " You are hired!"
    Print
    Color 9
    Print
    Print " This level's code is: TEST003"
    Print " Next level's code is: POINTY"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu4

    tcrash3: Cls
    Color 12
    Print " You Crashed!"
    Print
    Print " Sorry, You do not pass."
    Print
    Color 9
    Print
    Print " This level's code is: TEST003"
    Print " Next level's code is: >>did not pass<<"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu

    tfail3: Cls
    Color 12
    Print " You did not get all six items!"
    Print
    Print " Sorry, You do not pass."
    Print
    Color 9
    Print
    Print " This level's code is: TEST003"
    Print " Next level's code is: >>did not pass<<"
    Print
    Print " Press SPACEBAR to continue..."
    PCopy 1, 0
    Do
        press$ = InKey$
    Loop Until press$ = " "
    Cls
    Screen 13
    Call Menu

End Sub

Sub Trailer
    Screen 9
    Cls
    Locate 11, 20: Print "xtrGRAPHICS (TM)"
    Sleep (2)
    Cls
    Locate 11, 25: Print "xtrGRAPHICS Presents....."
    Sleep (4)
    Cls
    Locate 11, 30: Print "In a game where the need for speed is always great"
    Sleep (3)
    Screen 7, 0, 1, 0
    For i = 1 To 100
        x = Int(Rnd * 320) + 1
        y = Int(Rnd * 200) + 1
        PSet (x, y)
    Next
    Circle (100, 100), 40, 14
    Paint (100, 100), 14
    Circle (130, 150), 30, 12
    Paint (130, 150), 12
    Circle (320, 200), 60, 9
    Paint (319, 198), 9
    PCopy 1, 0
    For i = 1 To 50000: Next

    Cls
    For i = 1 To 100
        x = Int(Rnd * 320) + 1
        y = Int(Rnd * 200) + 1
        PSet (x, y)
    Next
    Circle (0, 100), 160, 12
    Paint (0, 100), 12

    x1 = 160: y1 = 100
    Do
        press$ = InKey$
        Cls
        For i = 1 To 100
            x = Int(Rnd * 320) + 1
            y = Int(Rnd * 200) + 1
            PSet (x, y)
        Next
        Circle (0, 100), 160, 12
        Paint (0, 100), 12
        PSet (x1, y1), 9
        x1 = x1 + 1
        PCopy 1, 0
        If press$ <> "" Then Call Bonus
        For i = 1 To 1000: Next
    Loop Until x1 >= 300

    Screen 9
    Locate 11, 20: Print "Where you travel faster than the speed  of light."
    Sleep (3)
    Cls
    Screen 9
    Locate 11, 20: Print "And planet travel is all you know."
    Sleep (3)

    Screen 7, 0, 1, 0
    x1 = 160: y1 = 190:
    Do
        press$ = InKey$
        Cls
        For i = 1 To 100
            x = Int(Rnd * 320) + 1
            y = Int(Rnd * 200) + 1
            PSet (x, y)
        Next
        PSet (x1, y1), 9
        y1 = y1 - 1
        If y1 <= 100 Then GoTo iwarp
        PCopy 1, 0
        If press$ <> "" Then Call Bonus
        For i = 1 To 1000: Next
    Loop
    iwarp: cr = 1:
    Do
        press$ = InKey$
        Cls
        For i = 1 To 100
            x = Int(Rnd * 320) + 1
            y = Int(Rnd * 200) + 1
            PSet (x, y)
        Next
        Circle (160, 100), cr, 10
        Line (160, 100)-(160, y1), 9
        y1 = y1 - 5
        cr = cr + 1
        PCopy 1, 0
        If press$ <> "" Then Call Bonus
        For i = 1 To 500: Next
    Loop Until cr = 20

    Screen 9
    Locate 11, 20: Print "Hold on thight for this one...."
    Sleep (3)

    Screen 7, 0, 1, 0
    x1 = 1: y1 = 100
    Do
        press$ = InKey$
        Cls
        For i = 1 To 100
            x = Int(Rnd * 320) + 1
            y = Int(Rnd * 200) + 1
            PSet (x, y)
        Next
        Circle (320, 100), 160, 10
        Paint (300, 100), 10
        PSet (x1, y1), 9
        x1 = x1 + 1
        PCopy 1, 0
        If press$ <> "" Then Call Bonus
        For i = 1 To 1000: Next
    Loop Until x1 >= 160

    Screen 9
    Locate 11, 20: Print "There are more planets than you think..."
    Sleep (3)

    Screen 7, 0, 1, 0
    x1 = 1: y1 = 30
    Do
        press$ = InKey$
        Cls
        press$ = InKey$
        Line (0, 0)-(320, 200), 1, BF
        Line (0, 175)-(320, 200), 8, BF
        Line (1, 100)-(40, 200), 7, BF
        Line (42, 50)-(90, 200), 7, BF
        Line (92, 70)-(140, 200), 7, BF
        Line (142, 90)-(190, 200), 7, BF
        Line (192, 110)-(260, 200), 7, BF
        Line (262, 20)-(320, 200), 7, BF
        PSet (x1, y1), 9
        x1 = x1 + 1
        PCopy 1, 0
        If press$ <> "" Then Call Bonus
        For i = 1 To 1000: Next
    Loop Until x1 >= 262

    Cls
    Dim ship(1000)
    Line (1, 1)-(20, 35), 7, BF
    Line (10, 1)-(1, 10), 9
    Line (10, 1)-(20, 10), 9
    Line (1, 10)-(1, 30), 9
    Line (20, 10)-(20, 30), 9
    Line (1, 30)-(20, 30), 9
    Paint (10, 10), 9
    Line (10, 30)-(10, 35), 7
    Line (1, 30)-(1, 35), 7
    Line (20, 30)-(20, 35), 7
    Circle (10, 10), 5, 8
    Paint (10, 10), 8
    PCopy 1, 0
    Get (1, 1)-(20, 35), ship()
    y1 = 160
    Do
        press$ = InKey$
        Cls
        Line (0, 0)-(320, 200), 7, BF
        Put (160, y1), ship(), PSet
        y1 = y1 - 1
        PCopy 1, 0
        If press$ <> "" Then Call Bonus
    Loop Until y1 = 50

    Cls
    Screen 7, 0, 1, 0

    For i = 1 To 100
        x = Int(Rnd * 320) + 1
        y = Int(Rnd * 200) + 1
        PSet (x, y)
    Next
    Circle (100, 100), 40, 14
    Paint (100, 100), 14
    Circle (130, 150), 30, 12
    Paint (130, 150), 12
    Circle (320, 200), 60, 9
    Paint (319, 198), 9


    Line (60, 40)-(30, 60), 9
    Line (30, 60)-(60, 60), 9
    Line (60, 60)-(30, 80), 9

    Line (63, 50)-(63, 80), 9
    Line (63, 50)-(73, 55), 9
    Line (73, 55)-(63, 65), 9

    Circle (83, 50), 6, 9
    Line (88, 45)-(89, 55), 9

    Line (93, 48)-(100, 40), 9
    Line (93, 48)-(105, 50), 9

    Line (107, 45)-(117, 40), 9
    Line (107, 45)-(110, 35), 9
    Line (110, 35)-(117, 40), 9
    Line (107, 45)-(117, 45), 9

    Line (25, 85)-(147, 37), 9

    '*************************

    Line (70, 90)-(75, 110), 9
    Line (75, 110)-(80, 88), 9
    Line (80, 88)-(85, 109), 9
    Line (85, 109)-(90, 86), 9

    Circle (100, 95), 6, 9
    Line (107, 98)-(102, 88), 9

    Line (109, 87)-(111, 98), 9
    Line (109, 87)-(116, 84), 9

    Line (119, 83)-(119, 101), 9
    Line (119, 83)-(129, 88), 9
    Line (129, 88)-(119, 92), 9

    Line (50, 121)-(140, 100), 9

    PCopy 1, 0
    Sleep (4)
    Cls
    Screen 13
    Call Bonus
End Sub

Sub Trainerb
    Cls
    Screen 13
    Color 10
    Print " RoboRaiders: >>Trainer-Bots>>"
    Locate 20, 3: Print "Press 'Enter' to select"
    Locate 22, 2: Print "Press 'F1' for Help, Press 'Esc' to Exit"
    C = 1
    Do
        press$ = InKey$
        If C = 1 Then Locate 10, 15: Color 10: Print ">>TEST 1-2>>": Locate 11, 15: Color 15: Print ">>TEST 3<<": Locate 13, 15: Color 15: Print ">>BONUS-MENU<<"
        If C = 2 Then Locate 10, 15: Color 15: Print ">>TEST 1-2<<": Locate 11, 15: Color 9: Print ">>TEST 3>>": Locate 13, 15: Color 15: Print ">>BONUS-MENU<<"
        If C = 3 Then Locate 10, 15: Color 15: Print ">>TEST 1-2<<": Locate 11, 15: Color 15: Print ">>TEST 3<<": Locate 13, 15: Color 14: Print ">>BONUS-MENU>>"
        If C = 2 Then If press$ = Chr$(0) + Chr$(80) Then C = 3: Play "D16"
        If C = 1 Then If press$ = Chr$(0) + Chr$(80) Then C = 2: Play "D16"
        If C = 2 Then If press$ = Chr$(0) + Chr$(72) Then C = 1: Play "D16"
        If C = 3 Then If press$ = Chr$(0) + Chr$(72) Then C = 2: Play "D16"
        If C = 2 Then If press$ = "2" Then C = 3: Play "D16"
        If C = 1 Then If press$ = "2" Then C = 2: Play "D16"
        If C = 2 Then If press$ = "8" Then C = 1: Play "D16"
        If C = 3 Then If press$ = "8" Then C = 2: Play "D16"
        If C = 1 Then If press$ = Chr$(13) Then Play "B16": Call Tbot1
        If C = 2 Then If press$ = Chr$(13) Then Play "B16": Call Tbot2
        If C = 3 Then If press$ = Chr$(13) Then Play "B16": Call Bonus
        If press$ = Chr$(0) + ";" Then Call Help
    Loop Until press$ = Chr$(27)
    End

End Sub

