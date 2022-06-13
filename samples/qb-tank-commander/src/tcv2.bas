'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
'
'        ±±    ±± ±±±±±± ±±±±±± ±± ±±±±±  ±±±±±± ±±±   ±± ±±±±±±
'        ±±    ±± ±±  ±± ±±  ±± ±±    ±±  ±±  ±± ±± ±± ±± ±±
'        ±±±±±±±± ±±  ±± ±±±±±± ±±   ±±   ±±  ±± ±±  ±±±±  ±±±±
'        ±±    ±± ±±  ±± ±± ±±  ±±  ±±    ±±  ±± ±±   ±±±     ±±
'        ±±    ±± ±±±±±± ±±  ±± ±± ±±±±±± ±±±±±± ±±    ±± ±±±±±
'
'     I N T E R A C T I V E    E N T E R T A I N M E N T  -  1 9 9 9
'
'
'               Game Name:  Qbasic TANK COMMANDER version 2
'                   Programmer:  Matthew River Knight
'                     Completed:  August 15, 1999
'
'
'This game is a remake of the last TANK COMMANDER, having been improved and
'modified a great deal. The sprites now move very fluidly and without any
'flicker on 286 PCs and up. The code is also alot smaller than the last
'version and has been made as readable and easy to edit as possible.
'
'                               * * * *
'
'This is a two player game in which you and a friend drive about the arena
'in tanks trying to blow eachother up. You both have very powerfull tanks
'capable of driving through anything in your path. Even the most secure of
'fortresses stands no chance against these armoured beasts. Each of the tanks
'is equipt with powerfull bomb launchers, capable of blowing up the other
'tank beyond repair, with a single strike.
'
'The keys for the game are pretty standard, and have been designed to allow
'both players to play at the same keyboard without getting in eachothers way.
'You MUST ensure that NUMLOCK is ON before running the game !!! The keys
'are as follows:
'
'BLUE TANK  - up:  8
'             down:  2
'             left:  4
'             right:  6
'             brakes:  5
'             shoot:  0
'
'GREEN TANK - up:  Q
'             down:  A
'             left:  O
'             right:  P
'             brakes:  S
'             shoot:  SPACE BAR
'
'                               * * * *
'
'The graphics for this game have been BSAVEd, and thus have to be loaded
'directly into memory to be drawn. This presents quite a problem because
'Qbasic often has quite a bit of trouble locating files that need to be
'BLOADed. This problem may be corrected by reffering to line 122 where there
'is a CHDIR. All you have to do is type the directory in which this game
'resides into the "" marks.
'
'Another potential problem with this game is the delay loop, which controls
'how fast the program runs. This game was designed on a computer using a
'CYRIX MII300 CPU, a 4MB graphics accelerator card and 512K cache - your
'computer may be faster or slower, and thus, for example, if you have a
'PENTIUM III, clocked at 500MHZ, this game will run so fast that it will be
'unplayable.
'
'This problem could have been eliminated by adding a CPU independant delay
'into the code by testing how fast your CPU is, however this presents us with
'another problem: different versions of Qbasic tend to give different results
'for these kinds of tests, and thus the game would have run inconsistantly
'on different platforms, even if they were being run on exactly the same
'kind of system. Since I wanted this game to be playable on any version of
'Qbasic, I chose to let everybody set the delay loop themselves.
'
'The delay loop variable is on line 125, under the name of Speed. All you
'have to do is change what it is = to. The default setting is 550 which is
'perfect for my system when running the game under WINDOWS 95 and on a Qbasic
'4.5 platform. Just experiment with the setting until the game runs at a
'speed with which you are satisfied. Just remember that the lower the number
'Speed is = to, the faster the game is going to run!
'
'                               * * * *
'
'This game has been programmed from scratch by Matthew River Knight. All the
'code here is my own, with the exception of the FADE IN/OUT code which was
'kindly provided by Manny Najera of FLASH GAMES, on his web site. Any code
'that you find usefull in this game may be taken. The graphics files used
'in this game may not be taken, however. Please give this game to anybody,
'and everybody, though if you do, please DO NOT give them a modified version,
'and DO NOT remove this text! I spent ages making the code the way it is and
'personally I am very proud of it. Please leave it as it is!
'
'File list for Qbasic TANK COMMANDER v2:
'
'*  TCV2.BAS....................Game code file.
'*  ARENA.BSV...................BSAVEd graphics file for game arena.
'*  SPRITES.BSV.................BSAVEd graphics file for sprites.
'
'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

$NoPrefix
'$Static
$Resize:Smooth

'Define variables A-Z as integers.
DefInt A-Z

'Define the data TYPE, PaletteType.
Type PaletteType
    r As Integer
    g As Integer
    b As Integer
End Type

'SHAREing of certain variables.
Dim Shared Pal As PaletteType
Dim Shared pData(0 To 255, 1 To 3)

'Change the default directory to the one being used for TANK COMMANDER. When
'setting this, remember to uncomment it.
'CHDIR ""

'Initial values of various variables.
D1 = 2: D2 = 4: T1H = 6: T1V = 87: T2H = 300: T2V = 102: Speed = 550

'Customise the VGA color palette for the introductory text.
Screen 13
FullScreen SquarePixels , Smooth

C = 16: For A = 16 To 61 Step 3: Palette C, (256 ^ 2 * A) + (256 * 0) + 0: C = C + 1: Next
C = 32: For A = 16 To 61 Step 3: Palette C, (256 ^ 2 * 0) + (256 * A) + 0: C = C + 1: Next
C = 48: For A = 16 To 61 Step 3: Palette C, (256 ^ 2 * 0) + (256 * 0) + A: C = C + 1: Next
C = 64: For A = 16 To 61 Step 3: Palette C, (256 ^ 2 * A) + (256 * A) + 0: C = C + 1: Next
C = 80: For A = 16 To 61 Step 3: Palette C, (256 ^ 2 * A) + (256 * 0) + A: C = C + 1: Next
C = 96: For A = 16 To 61 Step 3: Palette C, (256 ^ 2 * 0) + (256 * A) + A: C = C + 1: Next
C = 112: B = 0: For A = 16 To 61 Step 3: Palette C, (256 ^ 2 * A) + (256 * B) + 0: B = B + 3: C = C + 1: Next
C = 128: B = 0: For A = 16 To 61 Step 3: Palette C, (256 ^ 2 * B) + (256 * 0) + A: B = B + 3: C = C + 1: Next
C = 144: B = 0: For A = 16 To 61 Step 3: Palette C, (256 ^ 2 * B) + (256 * A) + 0: B = B + 3: C = C + 1: Next
C = 160: B = 0: For A = 16 To 61 Step 3: Palette C, (256 ^ 2 * B) + (256 * A) + A: B = B + 3: C = C + 1: Next
C = 176: B = 0: For A = 16 To 61 Step 3: Palette C, (256 ^ 2 * A) + (256 * A) + A: C = C + 1: Next
C = 192: B = 12: AA = 0: For A = 30 To 62 Step 2: Palette C, (256 ^ 2 * B) + (256 * AA) + A: B = B + 2: C = C + 1: Next
C = 208: B = 12: AA = 0: For A = 30 To 62 Step 2: Palette C, (256 ^ 2 * B) + (256 * B) + A: B = B + 2: C = C + 1: Next
C = 224: B = 12: AA = 0: For A = 30 To 62 Step 2: Palette C, (256 ^ 2 * AA) + (256 * B) + A: B = B + 2: C = C + 1: Next

'Do presentation text.
Palette.FadeOut
Color 1
Locate 9, 16: Print "  HORIZONS Interactive Entertainment"
Locate 13, 13: Print "P R E S E N T S"

'Color in company name with various shades of green.
Y = 72: C = 32
Do
    For X = 1 To 300
        If Point(X, Y) > 0 Then PSet (X, Y), C + Rnd * 15
    Next
    Y = Y + 1
Loop Until Y = 79

'Color in "PRESENTS" with various shades of red. Once this has been done,
'fade in the screen, melt it, and then fade out.
Y = 96: C = 49
Do
    For X = 1 To 300
        If Point(X, Y) > 0 Then PSet (X, Y), C + Rnd * 14
    Next
    Y = Y + 1
Loop Until Y = 103
Palette.FadeIn
NOW! = Timer: While (Timer - 1) < NOW!: Wend
Dim Melt%(1500)
For R = 1 To 1500
    Randomize Timer
    X = Int(Rnd * 271)
    Randomize Timer
    Y = Int(Rnd * 150)
    Get (X, Y)-(X + 48, Y + 18), Melt%()
    Put (X, Y + 1), Melt%(), PSet
    If InKey$ = Chr$(27) Then Exit For
    Limit 480
Next
Palette.FadeOut
Cls: Palette: Palette.FadeOut

'GET the sprite data.
Def Seg = 40960: BLoad "sprites.bsv"
Dim Tank1(150): Get (1, 1)-(15, 10), Tank1()
Dim Tank2(150): Get (1, 14)-(15, 23), Tank2()
Dim Tank3(150): Get (1, 27)-(15, 36), Tank3()
Dim Tank4(150): Get (1, 40)-(15, 49), Tank4()
Dim Tank5(150): Get (20, 1)-(34, 10), Tank5()
Dim Tank6(150): Get (20, 14)-(34, 23), Tank6()
Dim Tank7(150): Get (20, 27)-(34, 36), Tank7()
Dim Tank8(150): Get (20, 40)-(34, 49), Tank8()

'Load the file ARENA.BSV, which is the graphics data for the arena, into the
'video memory segment (segment 40960).
BLoad "arena.bsv"

'Place both tanks in their initial positions and fade in the completed arena.
Put (T1H, T1V), Tank1(), PSet
Put (T2H, T2V), Tank6(), PSet
Palette.FadeIn

'Main program loop.
Do

    'IF Count < Speed THEN Count = Count + 1 ELSE Count = 0
    Limit 60

    If Go1 = 1 And Count = 0 Then
        If D1 = 1 And T1V > 26 Then T1V = T1V - 1: Put (T1H, T1V), Tank3(), PSet
        If D1 = 2 And T1H < 305 Then T1H = T1H + 1: Put (T1H, T1V), Tank1(), PSet
        If D1 = 3 And T1V < 190 Then T1V = T1V + 1: Put (T1H, T1V), Tank4(), PSet
        If D1 = 4 And T1H > 0 Then T1H = T1H - 1: Put (T1H, T1V), Tank2(), PSet
    End If
    If Go2 = 1 And Count = 0 Then
        If D2 = 1 And T2V > 26 Then T2V = T2V - 1: Put (T2H, T2V), Tank7(), PSet
        If D2 = 2 And T2H < 305 Then T2H = T2H + 1: Put (T2H, T2V), Tank5(), PSet
        If D2 = 3 And T2V < 190 Then T2V = T2V + 1: Put (T2H, T2V), Tank8(), PSet
        If D2 = 4 And T2H > 0 Then T2H = T2H - 1: Put (T2H, T2V), Tank6(), PSet
    End If
    If St1 = 30 Then St1 = 0: Fire1 = 0: PSet (B1H, B1V), Col
    If St2 = 30 Then St2 = 0: Fire2 = 0: PSet (B2H, B2V), Col2
    If Fire1 = 1 And St1 < 30 And Count = 0 Then
        PSet (B1H, B1V), Col
        If BD1 = 1 Then B1V = B1V - 2
        If BD1 = 2 Then B1H = B1H + 2
        If BD1 = 3 Then B1V = B1V + 2
        If BD1 = 4 Then B1H = B1H - 2
        Col = Point(B1H, B1V)
        PSet (B1H, B1V), 14
        St1 = St1 + 1
        GoSub CheckBullet1
    End If
    If Fire2 = 1 And St2 < 30 And Count = 0 Then
        PSet (B2H, B2V), Col2
        If BD2 = 1 Then B2V = B2V - 2
        If BD2 = 2 Then B2H = B2H + 2
        If BD2 = 3 Then B2V = B2V + 2
        If BD2 = 4 Then B2H = B2H - 2
        Col2 = Point(B2H, B2V)
        PSet (B2H, B2V), 14
        St2 = St2 + 1
        GoSub CheckBullet2
    End If
    Key$ = InKey$
    If Key$ = Chr$(27) Then Palette.FadeOut: GoTo Results
    If Key$ = "4" Then Go1 = 1: D1 = 4
    If Key$ = "6" Then Go1 = 1: D1 = 2
    If Key$ = "8" Then Go1 = 1: D1 = 1
    If Key$ = "2" Then Go1 = 1: D1 = 3
    If Key$ = "0" Then If Fire1 = 0 Then GoSub Shoot1
    If Key$ = "5" Then Go1 = 0
    If Key$ = "O" Or Key$ = "o" Then Go2 = 1: D2 = 4
    If Key$ = "P" Or Key$ = "p" Then Go2 = 1: D2 = 2
    If Key$ = "Q" Or Key$ = "q" Then Go2 = 1: D2 = 1
    If Key$ = "A" Or Key$ = "a" Then Go2 = 1: D2 = 3
    If Key$ = "S" Or Key$ = "s" Then Go2 = 0
    If Key$ = Chr$(32) Then If Fire2 = 0 Then GoSub Shoot2
Loop

Shoot1: 'Initiates the shooting from Tank 1.
BD1 = D1
If BD1 = 0 Then Return
If BD1 = 1 Then B1H = (T1H + 7): B1V = (T1V - 1)
If BD1 = 2 Then B1H = (T1H + 14): B1V = (T1V + 5)
If BD1 = 3 Then B1H = (T1H + 7): B1V = (T1V + 11)
If BD1 = 4 Then B1H = (T1H - 1): B1V = (T1V + 5)
St1 = 1: Fire1 = 1: Col = Point(B1H, B1V)
Return

Shoot2: 'Initiates the shooting from Tank 2.
BD2 = D2
If BD2 = 0 Then Return
If BD2 = 1 Then B2H = (T2H + 7): B2V = (T2V - 1)
If BD2 = 2 Then B2H = (T2H + 14): B2V = (T2V + 5)
If BD2 = 3 Then B2H = (T2H + 7): B2V = (T2V + 11)
If BD2 = 4 Then B2H = (T2H - 1): B2V = (T2V + 5)
St2 = 1: Fire2 = 1: Col2 = Point(B2H, B2V)
Return

CheckBullet1: 'Hit detection from Tank 1 bullet.
T2V = T2V + 2: T2H = T2H + 3
For ScanTank2 = 1 To 7
    For Scan = 1 To 9
        If B1H = T2H And B1V = T2V Then Crash = 2: GoTo Explode
        T2H = T2H + 1
    Next
    T2H = T2H - 9: T2V = T2V + 1
Next
T2V = T2V - 9: T2H = T2H - 3
Return

CheckBullet2: 'Hit detection from Tank 2 bullet.
T1V = T1V + 2: T1H = T1H + 3
For ScanTank1 = 1 To 7
    For Scan = 1 To 9
        If B2H = T1H And B2V = T1V Then Crash = 1: GoTo Explode
        T1H = T1H + 1
    Next
    T1H = T1H - 9: T1V = T1V + 1
Next
T1V = T1V - 9: T1H = T1H - 3
Return

Explode: 'Create very cheap graphic explosion.
If Crash = 1 Then ExplodeH = T1H: ExplodeV = T1V: T2Wins = 1
If Crash = 2 Then ExplodeH = T2H: ExplodeV = T2V: T1Wins = 1
For Explode = 1 To 9
    If Explode = 1 Then Col = 14
    If Explode = 5 Then Col = 12
    If Explode = 7 Then Col = 4
    Circle (ExplodeH, ExplodeV), Explode, Col
    NOW! = Timer: While (Timer - .01) < NOW!: Wend
Next
NOW! = Timer: While (Timer - 1) < NOW!: Wend
Palette.FadeOut

Results: 'Announce the winning tank and display credits.
Screen 0: Width 80, 25
Color 12, 4
Print " G A M E    R E S U L T S "
Print
Color 4, 0
Print "Blue tank wins:"
Color 2
Locate 3, 17: Print T1Wins
Color 4
Print "Green tank wins:"
Color 2
Locate 4, 18: Print T2Wins
Print
Color 12, 4
Print " C R E D I T S "
Print
Color 4, 0
Print "Concept:"
Print "Programming:"
Print "Game art:"
Print "Fade effect:"
Print "Testing:"
Print "Debugging:"
Color 2
Locate 8, 11: Print "About a million other un-origional programmers ;)"
Locate 9, 15: Print "Matthew Knight"
Locate 10, 12: Print "Matthew Knight"
Locate 11, 15: Print "Manny Najera"
Locate 12, 11: Print "Matthew Knight"
Locate 13, 13: Print "Matthew Knight"
Print
Color 9
Print "All code in this game was programmed from scratch by Matthew Knight, with"
Print "exception of the fade effect which was kindly supplied by Manny Najera."
Print "No code was taken from any other games. Any similarity to another game is"
Print "purely coincidental."
Print
Color 4
Print "Thank you for trying Qbasic TANK COMMANDER v2 !!!"
Print "Hope you liked it :)"
Color 7

Sub Palette.FadeIn
    Dim tT(1 To 3)
    For I = 1 To 64
        Limit 60
        For O = 0 To 255
            Palette.Get O, Pal
            tT(1) = Pal.r
            tT(2) = Pal.g
            tT(3) = Pal.b
            If tT(1) < pData(O, 1) Then tT(1) = tT(1) + 1
            If tT(2) < pData(O, 2) Then tT(2) = tT(2) + 1
            If tT(3) < pData(O, 3) Then tT(3) = tT(3) + 1
            Pal.r = tT(1)
            Pal.g = tT(2)
            Pal.b = tT(3)
            Palette.Set O, Pal
        Next
    Next
End Sub

Sub Palette.FadeOut
    Dim tT(1 To 3)
    For I = 0 To 255
        Palette.Get I, Pal
        pData(I, 1) = Pal.r
        pData(I, 2) = Pal.g
        pData(I, 3) = Pal.b
    Next
    For I = 1 To 64
        Limit 60
        For O = 0 To 255
            Palette.Get O, Pal
            tT(1) = Pal.r
            tT(2) = Pal.g
            tT(3) = Pal.b
            If tT(1) > 0 Then tT(1) = tT(1) - 1
            If tT(2) > 0 Then tT(2) = tT(2) - 1
            If tT(3) > 0 Then tT(3) = tT(3) - 1
            Pal.r = tT(1)
            Pal.g = tT(2)
            Pal.b = tT(3)
            Palette.Set O, Pal
        Next
    Next
End Sub

Sub Palette.Get (nColor%, pInfo As PaletteType)
    Out &H3C6, &HFF
    Out &H3C7, nColor%
    pInfo.r = Inp(&H3C9)
    pInfo.g = Inp(&H3C9)
    pInfo.b = Inp(&H3C9)
End Sub

Sub Palette.Set (nColor%, pInfo As PaletteType)
    Out &H3C6, &HFF
    Out &H3C8, nColor%
    Out &H3C9, pInfo.r
    Out &H3C9, pInfo.g
    Out &H3C9, pInfo.b
End Sub

