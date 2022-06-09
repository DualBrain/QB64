'Assault v2.1
'By Glenn Powell
'( powell98@pacbell.net )
'(c) 1999
' Fixed for QB64 by Samuel Gomes
$NoPrefix
$Resize:Smooth
Title "Assault"

'Type Definitions
Type gametype
    cfgfile As String * 12
    keyfile As String * 12
    fntfile As String * 12
    sprfile As String * 12
End Type

Type packtype
    ammo As Integer
    set As Integer
End Type

Type bullettype
    class As Integer
    xi As Integer
    yi As Integer
    x As Integer
    y As Integer
    a As Double
    dir As Integer
    p As Integer
    tim As Double
    set As Integer
End Type

Type teamtype
    nam As String * 11
    act As Integer
    clr As Integer
End Type

Type playertype
    nam As String * 10
    tnum As Integer
    xi As Integer
    yi As Integer
    x As Integer
    y As Integer
    a As Double
    bul As Integer
    dir As Integer
    health As Integer
    dam As Integer
    jump As Integer
    aj As Single
    pj As Integer
    tim As Double
    glued As Double
End Type

Type leveltype
    nam As String * 10
    turn As Integer
    wind As Integer
    jag As Integer
    rise As Single
    grav As Single
    sndb As String * 12
    nofly As Integer
    fire As Integer
    tim As Double
    quit As Integer
End Type

Type paltype
    r As Integer
    g As Integer
    B As Integer
End Type

Type polartype
    r As Single
    a As Single
End Type

Type configtype
    snd As Integer
    sndb As Integer
    ammodrop As Single
End Type

Type sndMgrType
    act As Byte
    nam As String
    hnd As Long
End Type

'Global Variable Definitions
Const FALSE%% = 0, TRUE%% = Not FALSE%%
Const bulletspd% = 2, maxpower% = 150, maxplayers% = 8
Const menuclr% = 17, maxweapons% = 7, maxsparks% = 60, maxbullets% = 10
Const playerstep% = 4, playeraim! = .1, playeraimsize% = 20, gunlen% = 3

ReDim Shared sndMgr(0 To 0) As sndMgrType
Dim Shared player(maxplayers%) As playertype, level As leveltype, bullet(1 To maxbullets%) As bullettype
Dim Shared turfbuf(32001) As Integer, backbuf(32001) As Integer, playerspr(7 + 8 * 7) As Integer
Dim Shared ammospr(0 To maxweapons%, 7 + 8 * 7) As Integer, team(maxplayers%) As teamtype
Dim Shared config As configtype, playpack(maxplayers%, 1 To maxweapons%) As packtype, spark(1 To maxsparks%) As polartype
Dim Shared smallnum(9, 2 + 3 * 4) As Integer, barbuf(2561) As Integer, pal(1 To 3) As paltype
Dim Shared keycode(1 To 11 + maxweapons%) As String, keyact(1 To 11 + maxweapons%) As String
Dim Shared fontbuf(0) As String * 10368, menuitem(10) As String, game As gametype
Dim Shared gamepal(0 To 255) As paltype, defpal(0 To 255) As paltype

' Initialize the sound manager
sndMgr(0).act = FALSE

'Set Game Data Files
game.cfgfile = "assault.cfg"
game.keyfile = "assault.key"
game.fntfile = "assault.fnt"
game.sprfile = "assault.spr"

'Initialize Game
InitGame
InitScr
DoTitle

mainmenu:
pal(1).r = 10
pal(1).g = 10
pal(1).B = 10
DefaultPal
SetBlastPal
FadePal 0, 0, 0, 100, 200, 220
FadePal 0, 0, 0, 0, 0, 31
menuitem(0) = "ASSAULT"
menuitem(1) = "Play"
menuitem(2) = "Play Custom"
menuitem(3) = "Configure"
menuitem(4) = "Quit"
mnum% = 4
Menu mnum%
Select Case mnum%
    Case 1
        menuitem(0) = "ENVIRONMENT"
        menuitem(1) = "Jungle"
        menuitem(2) = "Arctic"
        menuitem(3) = "Plains"
        menuitem(4) = "Volcano"
        menuitem(5) = "Moon"
        mnum% = 5
        Menu mnum%
        Select Case mnum%
            Case -1
                GoTo mainmenu
            Case 1
                level.nam = "Jungle"
                pal(1).r = 20
                pal(1).g = 10
                pal(1).B = 0
                pal(2).r = 10
                pal(2).g = 25
                pal(2).B = 0
                pal(3).r = 20
                pal(3).g = 10
                pal(3).B = 0
                level.jag = 4
                level.rise = .8
                level.grav = 1
                level.sndb = "jungle.wav"
            Case 2
                level.nam = "Arctic"
                pal(1).r = 20
                pal(1).g = 10
                pal(1).B = 20
                pal(2).r = 50
                pal(2).g = 50
                pal(2).B = 60
                pal(3).r = 15
                pal(3).g = 10
                pal(3).B = 0
                level.jag = 5
                level.rise = .5
                level.grav = 1
                level.sndb = "arctic.wav"
            Case 3
                level.nam = "Plains"
                pal(1).r = 20
                pal(1).g = 20
                pal(1).B = 20
                pal(2).r = 0
                pal(2).g = 30
                pal(2).B = 0
                pal(3).r = 50
                pal(3).g = 50
                pal(3).B = 40
                level.jag = 5
                level.rise = .15
                level.grav = 1
                level.sndb = "plains.wav"
            Case 4
                level.nam = "Volcano"
                pal(1).r = 30
                pal(1).g = 10
                pal(1).B = 0
                pal(2).r = 40
                pal(2).g = 10
                pal(2).B = 0
                pal(3).r = 5
                pal(3).g = 0
                pal(3).B = 0
                level.jag = 5
                level.rise = .8
                level.grav = 1
                level.sndb = "volcano.wav"
            Case 5
                level.nam = "Moon"
                pal(1).r = 0
                pal(1).g = 0
                pal(1).B = 0
                pal(2).r = 30
                pal(2).g = 30
                pal(2).B = 30
                pal(3).r = 10
                pal(3).g = 10
                pal(3).B = 10
                level.jag = 3
                level.rise = .3
                level.grav = .3
                level.sndb = "moon.wav"
        End Select
        FadePal 0, 0, 0, 0, 0, 255
        InitGamePal
        Def Seg = VarSeg(backbuf(0))
        BLoad "backgrnd\" + RTrim$(level.nam) + ".bck", 0
        Def Seg
        BuildLevel
        Main
        GoTo mainmenu
    Case 2
        Line (0, 30)-(319, 199), 0, BF
        DrawFont "Custom Level", 160 - (Len("Custom Level") / 2) * 8, 50, 1, 1, 2, menuclr% + 5
        DrawFont "(Enter Cancels)", 160 - (Len("(Enter Cancels)") / 2) * 8, 65, 1, 1, 2, menuclr% + 5
        For c% = 0 To 100
            FadePal 0, 0, 0, c%, 0, 31
        Next c%
        Locate 11, 15
        Input "", l$
        If l$ = "" Then GoTo mainmenu
        pal(1).r = 10
        pal(1).g = 10
        pal(1).B = 10
        FadePal 0, 0, 0, 0, 0, 255
        InitGamePal
        LoadLevel l$ + ".lvl"
        Main
        GoTo mainmenu
    Case 3
        Configure
        GoTo mainmenu
    Case 4
        System 0
    Case Else
        GoTo mainmenu
End Select

'Various Game Data
teaminfo:
Data "None",0
Data "Red Team",4
Data "White Team",15
Data "Blue Team",1
Data "Yellow Team",14
Data "Green Team",2
Data "Brown Team",6
Data "Purple Team",5
Data "Black Team",16

'Small Number Data
smallnums:
Data 0,1,0
Data 1,0,1
Data 1,0,1
Data 1,0,1
Data 0,1,0

Data 0,0,1
Data 0,1,1
Data 0,0,1
Data 0,0,1
Data 0,0,1

Data 0,1,0
Data 1,0,1
Data 0,0,1
Data 0,1,0
Data 1,1,1

Data 1,1,0
Data 0,0,1
Data 0,1,0
Data 0,0,1
Data 1,1,0

Data 1,0,1
Data 1,0,1
Data 1,1,1
Data 0,0,1
Data 0,0,1

Data 1,1,1
Data 1,0,0
Data 1,1,0
Data 0,0,1
Data 1,1,0

Data 0,1,1
Data 1,0,0
Data 1,1,0
Data 1,0,1
Data 0,1,1

Data 1,1,1
Data 0,0,1
Data 0,1,0
Data 0,1,0
Data 0,1,0

Data 0,1,0
Data 1,0,1
Data 0,1,0
Data 1,0,1
Data 0,1,0

Data 0,1,1
Data 1,0,1
Data 1,1,1
Data 0,0,1
Data 0,0,1

Function BPoint% (tx%, ty%, pn%)
    'Returns the pixel that should be displayed as background behind any
    'sprite at any time in the game. (241 represents a pixel of the background image)
    'tx% and ty% are the coordinates.
    'pn% is the number of player who is being "looked behind" (1-4) or
    '0 if it is a bullet sprite and you want to be able to "see" all the players.
    'You can also use -1 to not see any players.

    pp% = 241
    If tx% >= 0 And tx% <= 319 Then
        If ty% >= 0 And ty% <= 15 Then
            Def Seg = VarSeg(barbuf(0))
            pp% = Peek(tx% + 320& * ty% + 4)
            Def Seg
        ElseIf ty% >= 16 And ty% <= 199 Then
            Def Seg = VarSeg(turfbuf(0))
            pp% = Peek(tx% + 320& * ty% + 4)
            Def Seg
        End If
        For i% = 1 To maxplayers%
            If player(i%).health > 0 And pn% <> i% Then
                If tx% >= player(i%).x And tx% <= player(i%).x + 7 And ty% >= player(i%).y And ty% <= player(i%).y + 7 Then
                    pp% = playerspr((player(i%).dir - 1) * -3.5 + player(i%).dir * (tx% - player(i%).x) + 8 * (ty% - player(i%).y))
                    If pp% = -1 Then
                        pp% = team(player(i%).tnum).clr
                    ElseIf pp% = -10 Then
                        If player(i%).dir = 1 Then
                            pp% = 25 - Int((tx% - player(i%).x) / 2)
                        Else
                            pp% = 25 - Int((7 - (tx% - player(i%).x)) / 2)
                        End If
                    End If
                    If pp% > 0 Then
                        If player(i%).glued > 0 Then pp% = 92
                    Else
                        pp% = 241
                    End If
                    For ii% = 0 To gunlen%
                        x% = player(i%).x + 3 + (1 - player(i%).dir) / 2 + Cos(player(i%).a) * ii% * player(i%).dir
                        y% = player(i%).y + 4 + Sin(player(i%).a) * ii%
                        If tx% = x% And ty% = y% Then pp% = 25
                    Next ii%
                End If
            End If
        Next i%
        If ty% >= 0 And ty% <= 199 Then
            If pp% = 241 Then
                Def Seg = VarSeg(backbuf(0))
                pp% = Peek(tx% + 320& * ty%)
                Def Seg
            End If
        End If
    End If
    BPoint% = pp%
End Function

Sub BuildLevel
    'Builds the level's turf map.
    'It uses the LEVEL variable's data to create the map according to the
    'environment chosen. (level.jag and level.rise)

    'This is for the environment sprites
    Dim backspr(1 To 2, 29 + 30 * 29) As Integer

    'Loads the environment sprites
    Def Seg = &HA000
    BLoad "backgrnd\" + RTrim$(level.nam) + ".spr", 0
    Def Seg
    For y% = 0 To 29
        For x% = 0 To 29
            p% = Point(x%, y%)
            backspr(1, x% + 30 * y%) = p%
        Next x%
    Next y%
    For y% = 0 To 29
        For x% = 30 To 59
            p% = Point(x%, y%)
            backspr(2, x% - 30 + 30 * y%) = p%
        Next x%
    Next y%

    'Draws the terrain outline
    Cls
    Line (0, 0)-(319, 199), 240, BF
    x1% = 0
    y1% = Rnd * 100 + 30
    a# = Rnd * 2 - 1
    buildloop:
    x2% = x1%
    y2% = y1%
    x1% = x2% + Cos(a#) * level.jag
    y1% = y2% + Sin(a#) * level.jag
    Line (x1%, y1%)-(x2%, y2%), 231
    If y1% <= 30 Then
        a# = Rnd * 1
    ElseIf y1% >= 190 Then
        a# = Rnd * -1
    Else
        a# = a# + Rnd * (level.rise * 2) - level.rise
        If a# > 3 * Pi / 4 Then a# = 3 * Pi / 4
        If a# < 3 * -Pi / 4 Then a# = 3 * -Pi / 4
    End If
    If x1% >= 319 Then GoTo paintbuild
    GoTo buildloop

    'Paints in the terrain outline
    paintbuild:
    Paint (0, 0), 241, 231
    For x% = 0 To 319
        For y% = 0 To 199
            p% = Point(x%, y%)
            If p% = 240 Then
                p% = Point(x%, y% - 1) + Rnd * 3 - 1
                If p% < 231 Then p% = 231
                If p% > 240 Then p% = 240
                PSet (x%, y%), p%
            End If
        Next y%
    Next x%

    'Places environment sprites
    For i% = 1 To 5
        If Rnd < .8 Then
            x% = Rnd * 280 + 20
            ly% = 0
            For y% = 0 To 199
                For xx% = x% - 15 To x% + 15
                    p% = Point(xx%, y%)
                    If p% = 241 Then
                        If y% > ly% Then ly% = y%
                    End If
                Next xx%
            Next y%
            x% = x% - 15
            y% = ly% - 29
            s% = Rnd + 1
            d% = CInt(Rnd) * 2 - 1
            For xx% = x% To x% + 29
                For yy% = y% To y% + 29
                    p% = backspr(s%, (d% + 1) / 2 * 29 + -d% * (xx% - x%) + 30 * (yy% - y%))
                    bp% = Point(xx%, yy%)
                    If bp% = 241 And p% > 0 Then PSet (xx%, yy%), p%
                Next yy%
            Next xx%
        End If
    Next i%

    'Stores in Turf Buffer
    Get (0, 0)-(319, 199), turfbuf()
End Sub

Sub BulletMove
    'Moves any and all bullets that are in action on the playfield.

    For i% = 1 To maxbullets%

        'Explosion
        '==========
        'bullet variables:
        'x = x xoordinate
        'y = y xoordinate
        'a = current flame size (set to 0 at initialization)
        'dir = size of final explosion (set this at initialization)
        'p = direction of flame growth (set to 1 at initialization)
        'set = sparks setting (set at initialization)
        '                     0 = no sparks
        '                     1 = sparks
        '                     2 = sparks and nuclear flash
        'tim = flash timer (set to 0 at initialization)
        If bullet(i%).class = -1 Then
            level.nofly = 0
            x% = bullet(i%).x
            y% = bullet(i%).y
            If bullet(i%).p = 1 And bullet(i%).a = 0 Then
                For pn% = 1 To maxplayers%
                    If player(pn%).health > 0 Then
                        pd% = Sqr((player(pn%).x - x%) ^ 2 + (player(pn%).y - y%) ^ 2)
                        If pd% < bullet(i%).dir + 3 Then
                            ph% = bullet(i%).dir * 2 * (1 - pd% / (bullet(i%).dir + 3))
                            Damage pn%, ph%
                        End If
                        If pd% < bullet(i%).dir + 13 Then
                            ErasePlayer pn%
                            player(pn%).jump = 1
                            player(pn%).xi = player(pn%).x
                            player(pn%).yi = player(pn%).y
                            If player(pn%).x - x% <> 0 Then
                                pa# = Atn((player(pn%).y - y%) / Abs(player(pn%).x - x%))
                            Else
                                pa# = 40
                            End If
                            player(pn%).aj = pa#
                            pp% = 40 * (1 - pd% / (bullet(i%).dir + 13))
                            player(pn%).pj = pp%
                            If player(pn%).x > x% Then
                                player(pn%).dir = 1
                            Else
                                player(pn%).dir = -1
                            End If
                            player(pn%).tim = Timer - .1
                            t# = (Timer - player(pn%).tim) * bulletspd%
                            player(pn%).x = player(pn%).xi + t# * Cos(player(pn%).aj) * player(pn%).pj * player(pn%).dir
                            player(pn%).y = player(pn%).yi + t# * Sin(player(pn%).aj) * player(pn%).pj + 16 * t# ^ 2
                            DrawPlayer pn%
                        End If
                    End If
                Next pn%
            End If
            For r! = 0 To Pi * 2 Step .05 / (bullet(i%).dir / 10)
                c% = 220 - (bullet(i%).a / bullet(i%).dir) * 20 + Rnd * 4 - 2
                If c% < 200 Then c% = 200
                If c% > 220 Then c% = 220
                If bullet(i%).p = -1 Then c% = 241
                TPset x% + Cos(r!) * bullet(i%).a + 3, y% + Sin(r!) * bullet(i%).a + 3, 241
                bp% = c%
                If c% = 241 Then
                    bp% = BPoint%(x% + Cos(r!) * bullet(i%).a + 3, y% + Sin(r!) * bullet(i%).a + 3, 0)
                End If
                PSet (x% + Cos(r!) * bullet(i%).a + 3, y% + Sin(r!) * bullet(i%).a + 3), bp%
            Next r!
            bullet(i%).a = bullet(i%).a + .5 * bullet(i%).p
            If bullet(i%).p = 1 And bullet(i%).a >= bullet(i%).dir Then
                bullet(i%).p = -1
            End If
            If bullet(i%).set = 2 Then
                cc% = -1
                If bullet(i%).p = 1 And bullet(i%).a < 10 Then cc% = 1
                bullet(i%).tim = bullet(i%).tim + cc%
                If bullet(i%).tim < 0 Then bullet(i%).tim = 0
                If bullet(i%).tim > 20 Then bullet(i%).tim = 20
                ci% = 100 - (bullet(i%).tim * 3)
                If ci% < 0 Then ci% = 0
                If ci% > 100 Then ci% = 100
                FadePal gamepal(bullet(i%).tim + 200).r, gamepal(bullet(i%).tim + 200).g, gamepal(bullet(i%).tim + 200).B, ci%, 0, 255
            End If
            If bullet(i%).set >= 1 Then
                For ii% = 1 To maxsparks%
                    sx% = bullet(i%).x + 3 + spark(ii%).r * Cos(spark(ii%).a)
                    sy% = bullet(i%).y + 3 + .3 * (spark(ii%).r * Sin(spark(ii%).a))
                    PSet (sx%, sy%), BPoint%(sx%, sy%, 0)
                    spark(ii%).r = spark(ii%).r + 2
                    sx% = bullet(i%).x + 3 + spark(ii%).r * Cos(spark(ii%).a)
                    sy% = bullet(i%).y + 3 + .3 * (spark(ii%).r * Sin(spark(ii%).a))
                    c% = 220 - spark(ii%).r / 3
                    If c% < 200 Then c% = 200
                    If bullet(i%).p = -1 And bullet(i%).a < 0 Then c% = BPoint%(sx%, sy%, 0)
                    PSet (sx%, sy%), c%
                Next ii%
            End If
            If bullet(i%).p = -1 And bullet(i%).a < 0 Then
                bullet(i%).class = 0
                GoTo nextbul
            End If
            x% = (bullet(i%).dir / 10 - 1) * 3000 + 1000
            EarthQuake x%
        End If

        'Ammo crate on the ground
        '==========
        'bullet variables:
        'x = x xoordinate
        'y = y xoordinate
        'a = null
        'dir = ammo amount
        'p = null
        'set = ammo class
        'tim = null
        If bullet(i%).class = 100 Then
            x% = bullet(i%).x
            y% = bullet(i%).y
            For ii% = 1 To maxplayers%
                pd% = Sqr((player(ii%).x - x%) ^ 2 + (player(ii%).y - y%) ^ 2)
                If pd% <= 7 Then
                    EraseSpr x%, y%, 0
                    bullet(i%).class = 0
                    playpack(ii%, bullet(i%).set).ammo = playpack(ii%, bullet(i%).set).ammo + bullet(i%).dir
                    InitBullet 101, x%, y%, 0, bullet(i%).dir, 0, bullet(i%).set
                    If config.snd Then
                        WAVPlay "bounce.wav"
                    End If
                    GoTo nextbul
                End If
            Next ii%
            For ii% = 1 To maxbullets%
                If i% <> ii% And bullet(ii%).class = -1 Then
                    pd% = Sqr((bullet(ii%).x - x%) ^ 2 + (bullet(ii%).y - y%) ^ 2)
                    If pd% <= bullet(ii%).a Then
                        bullet(i%).class = -1
                        bullet(i%).a = 0
                        bullet(i%).dir = 15
                        bullet(i%).p = 1
                        bullet(i%).set = 0
                        If config.snd Then
                            WAVPlay "explode.wav"
                        End If
                        GoTo nextbul
                    End If
                End If
            Next ii%
            DrawSpr x%, y%, 0
        End If

        'Ammo crate falling from sky
        '==========
        'bullet variables:
        'x = x xoordinate
        'y = y xoordinate (should be 0 at initializtion)
        'a = null
        'dir = ammo amount
        'p = null
        'set = ammo class
        'tim = fall timer (set to TIMER at initializtion)
        If bullet(i%).class = -100 Then
            level.nofly = 0
            x% = bullet(i%).x
            y% = bullet(i%).y
            t# = (level.tim - bullet(i%).tim) * bulletspd%
            EraseSpr x%, y%, 0
            y% = bullet(i%).yi + 16 * t# ^ 2 * level.grav
            If x% < -7 Or x% > 326 Or y% > 206 Then
                bullet(i%).class = 0
                GoTo nextbul
            End If
            bullet(i%).y = y%
            If TurfHit%(0, x%, y%) Then
                bullet(i%).class = 100
                If config.snd Then
                    WAVPlay "crash.wav"
                End If
                GoTo nextbul
            End If
            DrawSpr x%, y%, 0
        End If

        'Ammo displayed from ammo crate
        '==========
        'bullet variables:
        'xi = initial x xoordinate
        'yi = initial y xoordinate
        'x = current x xoordinate
        'y = current y xoordinate
        'a = null
        'dir = ammo amount
        'p = null
        'set = ammo class
        'tim = timer (set to 0 at initialization)
        If bullet(i%).class = 101 Then
            level.nofly = 0
            For ii% = 1 To bullet(i%).dir
                If bullet(i%).dir = 1 Then
                    xc% = 0
                ElseIf bullet(i%).dir = 2 Then
                    xc% = -1
                    If ii% = 2 Then xc% = 1
                ElseIf bullet(i%).dir = 2 Then
                    xc% = -1
                    If ii% = 2 Then xc% = 0
                    If ii% = 3 Then xc% = 1
                End If
                x% = bullet(i%).xi + xc% * bullet(i%).a
                y% = bullet(i%).yi - bullet(i%).a
                EraseSpr x%, y%, bullet(i%).set
            Next ii%
            If level.tim - bullet(i%).tim >= 1 Then
                bullet(i%).class = 0
                GoTo nextbul
            End If
            bullet(i%).a = bullet(i%).a + .03
            For ii% = 1 To bullet(i%).dir
                If bullet(i%).dir = 1 Then
                    xc% = 0
                ElseIf bullet(i%).dir = 2 Then
                    xc% = -1
                    If ii% = 2 Then xc% = 1
                ElseIf bullet(i%).dir = 2 Then
                    xc% = -1
                    If ii% = 2 Then xc% = 0
                    If ii% = 3 Then xc% = 1
                End If
                x% = bullet(i%).xi + xc% * bullet(i%).a
                y% = bullet(i%).yi - bullet(i%).a
                DrawSpr x%, y%, bullet(i%).set
            Next ii%
        End If

        'Basic cannon ball
        '==========
        'bullet variables:
        'xi = initial x xoordinate
        'yi = initial y xoordinate
        'x = current x xoordinate
        'y = current y xoordinate
        'a = launch angle
        'dir = launch direction
        'p = launch power
        'set = multiple bullets
        'tim = fly timer (set to TIMER at initialization)
        If bullet(i%).class = 1 Then
            level.nofly = 0
            x% = bullet(i%).x
            y% = bullet(i%).y
            a# = bullet(i%).a
            p% = bullet(i%).p
            d% = bullet(i%).dir
            t# = (level.tim - bullet(i%).tim) * bulletspd%
            EraseSpr x%, y%, 1
            x% = bullet(i%).xi + t# * Cos(a#) * p% * d% + level.wind * t#
            y% = bullet(i%).yi + t# * Sin(a#) * p% + 16 * t# ^ 2 * level.grav
            If x% < -7 Or x% > 326 Or y% > 206 Then
                bullet(i%).class = 0
                GoTo nextbul
            End If
            bullet(i%).x = x%
            bullet(i%).y = y%
            If TurfHit%(1, x%, y%) Then
                bullet(i%).class = -1
                bullet(i%).a = 0
                bullet(i%).dir = (4 - bullet(i%).set) * 3 + 7
                bullet(i%).p = 1
                bullet(i%).set = 0
                If config.snd Then
                    WAVPlay "blast.wav"
                End If
                GoTo nextbul
            End If
            DrawSpr x%, y%, 1
        End If

        'Grenade
        '==========
        'bullet variables:
        'xi = initial x xoordinate
        'yi = initial y xoordinate
        'x = current x xoordinate
        'y = current y xoordinate
        'a = launch angle
        'dir = launch direction
        'p = launch power
        'set = explosion timer
        'tim = fly timer (set to TIMER at initialization)
        If bullet(i%).class = 2 Then
            level.nofly = 0
            x% = bullet(i%).x
            y% = bullet(i%).y
            a# = bullet(i%).a
            p% = bullet(i%).p
            d% = bullet(i%).dir
            t# = (level.tim - bullet(i%).tim) * bulletspd%
            EraseSpr x%, y%, 2
            x% = bullet(i%).xi + t# * Cos(a#) * p% * d% + level.wind * t#
            y% = bullet(i%).yi + t# * Sin(a#) * p% + 16 * t# ^ 2 * level.grav
            If x% < -7 Or x% > 326 Or y% > 206 Then
                bullet(i%).class = 0
                GoTo nextbul
            End If
            bump$ = TurfBump$(x%, y%, level.turn)
            Select Case bump$

                Case "00000000"

                Case "11111111"
                    x% = bullet(i%).x
                    y% = bullet(i%).y
                    bullet(i%).xi = bullet(i%).x
                    bullet(i%).yi = bullet(i%).y
                    bullet(i%).tim = Timer

                Case "11100011", "11000001", "10000000", "00000010", "00000001", "00000011", "10000011", "00000111", "10000111", "11001111", "10001111", "11000111", "10000001", "11001111", "11101111", "11000001", "11000011"
                    If bullet(i%).dir = -1 Then
                        xc% = t# * Cos(a#) * p% * -d% + level.wind * t#
                        bullet(i%).xi = x% - xc%
                        bullet(i%).dir = 1
                        If config.snd Then
                            WAVPlay "bounce.wav"
                        End If
                    End If

                Case "11110001", "11100000", "01000000", "00100000", "00010000", "00110000", "01110000", "00111000", "01111000", "11111100", "01111100", "11111000", "01100000", "11111100", "11111110", "11100000", "11110000"
                    If bullet(i%).dir = 1 Then
                        xc% = t# * Cos(a#) * p% * -d% + level.wind * t#
                        bullet(i%).xi = x% - xc%
                        bullet(i%).dir = -1
                        If config.snd Then
                            WAVPlay "bounce.wav"
                        End If
                    End If

                Case "00000110", "00001111", "10011111"
                    If y% > bullet(i%).y Then
                        bullet(i%).xi = x%
                        bullet(i%).yi = y%
                        bullet(i%).p = p% / 1.5
                        bullet(i%).dir = 1
                        bullet(i%).tim = Timer - .1
                        If config.snd Then
                            WAVPlay "bounce.wav"
                        End If
                    End If

                Case "00011000", "00111100", "01111110"
                    If y% > bullet(i%).y Then
                        bullet(i%).xi = x%
                        bullet(i%).yi = y%
                        bullet(i%).p = p% / 1.5
                        bullet(i%).dir = -1
                        bullet(i%).tim = Timer - .1
                        If config.snd Then
                            WAVPlay "bounce.wav"
                        End If
                    End If

                Case Else
                    If y% > bullet(i%).y Then
                        bullet(i%).xi = x%
                        bullet(i%).yi = y%
                        bullet(i%).p = p% / 1.5
                        bullet(i%).tim = Timer - .1
                        If config.snd Then
                            WAVPlay "bounce.wav"
                        End If
                    End If

            End Select
            bullet(i%).x = x%
            bullet(i%).y = y%
            If bullet(i%).set <= 0 Then
                bullet(i%).class = -1
                bullet(i%).a = 0
                bullet(i%).dir = 20
                bullet(i%).p = 1
                bullet(i%).set = 0
                If config.snd Then
                    WAVPlay "blast.wav"
                End If
                GoTo nextbul
            End If
            DrawSpr x%, y%, 2
            bullet(i%).set = bullet(i%).set - 15
        End If

        'Mine
        '==========
        'bullet variables:
        'x = current x xoordinate
        'y = current y xoordinate
        'a = null
        'dir = null
        'p = null
        'set = trip distance setting
        'tim = null
        If bullet(i%).class = 3 Then
            If level.tim - bullet(i%).tim < 4 Then level.nofly = 0
            If level.tim - bullet(i%).tim > 3 Then
                x% = bullet(i%).x
                y% = bullet(i%).y
                For ii% = 1 To maxplayers%
                    pd% = Sqr((player(ii%).x - x%) ^ 2 + (player(ii%).y - y%) ^ 2)
                    If pd% <= 5 * bullet(i%).set Then
                        bullet(i%).class = -1
                        bullet(i%).a = 0
                        bullet(i%).dir = 15
                        bullet(i%).p = 1
                        bullet(i%).y = bullet(i%).y + 3
                        bullet(i%).set = 0
                        If ii% = level.turn Then level.fire = 1
                        If config.snd Then
                            WAVPlay "explode.wav"
                        End If
                        GoTo nextbul
                    End If
                Next ii%
                For ii% = 1 To maxbullets%
                    If i% <> ii% And bullet(ii%).class = -1 Then
                        pd% = Sqr((bullet(ii%).x - x%) ^ 2 + (bullet(ii%).y - y%) ^ 2)
                        If pd% <= bullet(ii%).a Then
                            bullet(i%).class = -1
                            bullet(i%).a = 0
                            bullet(i%).dir = 15
                            bullet(i%).p = 1
                            bullet(i%).set = 0
                            If config.snd Then
                                WAVPlay "explode.wav"
                            End If
                            GoTo nextbul
                        End If
                    End If
                Next ii%
            End If
            DrawSpr bullet(i%).x, bullet(i%).y, 3
        End If

        'Gluer
        '==========
        'bullet variables:
        'xi = initial x xoordinate
        'yi = initial y xoordinate
        'x = current x xoordinate
        'y = current y xoordinate
        'a = launch angle
        'dir = launch direction
        'p = launch power
        'set = multiple bullets
        'tim = fly timer (set to TIMER at initialization)
        If bullet(i%).class = 4 Then
            level.nofly = 0
            x% = bullet(i%).x
            y% = bullet(i%).y
            a# = bullet(i%).a
            p% = bullet(i%).p
            d% = bullet(i%).dir
            t# = (level.tim - bullet(i%).tim) * bulletspd%
            EraseSpr x%, y%, 4
            x% = bullet(i%).xi + t# * Cos(a#) * p% * d% + level.wind * t#
            y% = bullet(i%).yi + t# * Sin(a#) * p% + 16 * t# ^ 2 * level.grav
            If x% < -7 Or x% > 326 Or y% > 206 Then
                bullet(i%).class = 0
                GoTo nextbul
            End If
            bullet(i%).x = x%
            bullet(i%).y = y%
            If TurfHit%(1, x%, y%) Then
                bullet(i%).class = -4
                bullet(i%).a = 1
                bullet(i%).dir = (5 - bullet(i%).set) * 5
                bullet(i%).p = 1
                bullet(i%).tim = 0
                If config.snd Then
                    WAVPlay "glue.wav"
                End If
                GoTo nextbul
            End If
            DrawSpr x%, y%, 4
        End If

        'Gluer Explosion
        '==========
        'bullet variables:
        'x = x xoordinate
        'y = y xoordinate
        'a = current blob size (set to 1 at initialization)
        'dir = size of final blob (set this at initialization)
        'p = direction of blob growth (set to 1 at initialization)
        'set = null
        'tim = blob timer (set to 0 at initialization)
        If bullet(i%).class = -4 Then
            level.nofly = 0
            x% = bullet(i%).x
            y% = bullet(i%).y
            a# = bullet(i%).a
            d% = bullet(i%).dir
            For pn% = 1 To maxplayers%
                If player(pn%).health > 0 Then
                    pd% = Sqr((player(pn%).x - x%) ^ 2 + (player(pn%).y - y%) ^ 2)
                    If pd% < a# Then
                        player(pn%).glued = 4 - bullet(i%).set
                    End If
                End If
            Next pn%
            For ap# = .05 To Pi * 2 Step .05
                xp% = x% + 3 + (a# - bullet(i%).p) * Cos(ap#)
                yp% = y% + 3 + (a# - bullet(i%).p) * Sin(ap#)
                PSet (xp%, yp%), BPoint%(xp%, yp%, 0)
                xp% = x% + 3 + a# * Cos(ap#)
                yp% = y% + 3 + a# * Sin(ap#)
                c% = 92
                PSet (xp%, yp%), c%
            Next ap#
            If a# = 0 Then
                bullet(i%).p = 1
                bullet(i%).tim = bullet(i%).tim + 1
                If bullet(i%).tim = 5 Then
                    bullet(i%).class = 0
                    PSet (x% + 3, y% + 3), BPoint%(x%, y%, 0)
                    GoTo nextbul
                End If
            End If
            If a# = (5 - bullet(i%).set) * 5 Then
                bullet(i%).p = -1
            End If
            bullet(i%).a = bullet(i%).a + bullet(i%).p
        End If

        'Cluster bomb
        '==========
        'bullet variables:
        'xi = initial x xoordinate
        'yi = initial y xoordinate
        'x = current x xoordinate
        'y = current y xoordinate
        'a = launch angle
        'dir = launch direction
        'p = launch power
        'set = # of bombs
        'tim = fly timer (set to TIMER at initialization)
        If bullet(i%).class = 7 Then
            level.nofly = 0
            x% = bullet(i%).x
            y% = bullet(i%).y
            a# = bullet(i%).a
            p% = bullet(i%).p
            d% = bullet(i%).dir
            t# = (level.tim - bullet(i%).tim) * bulletspd%
            EraseSpr x%, y%, 7
            x% = bullet(i%).xi + t# * Cos(a#) * p% * d% + level.wind * t#
            y% = bullet(i%).yi + t# * Sin(a#) * p% + 16 * t# ^ 2 * level.grav
            If x% < -7 Or x% > 326 Or y% > 206 Then
                bullet(i%).class = 0
                GoTo nextbul
            End If
            bullet(i%).x = x%
            bullet(i%).y = y%
            If TurfHit%(7, x%, y%) Or t# >= 2 Then
                bullet(i%).class = -1
                bullet(i%).a = 0
                bullet(i%).dir = (4 - bullet(i%).set) * 10
                bullet(i%).p = 1
                If bullet(i%).set = 1 Then
                    InitBullet 1, x%, y%, 1.6, -1, 50, bullet(i%).set
                ElseIf bullet(i%).set = 2 Then
                    InitBullet 1, x%, y%, .5, -1, 50, bullet(i%).set
                    InitBullet 1, x%, y%, .5, 1, 50, bullet(i%).set
                ElseIf bullet(i%).set = 3 Then
                    InitBullet 1, x%, y%, .5, -1, 50, bullet(i%).set
                    InitBullet 1, x%, y%, 1.6, -1, 50, bullet(i%).set
                    InitBullet 1, x%, y%, .5, 1, 50, bullet(i%).set
                End If
                bullet(i%).set = 2
                bullet(i%).tim = 0
                For ii% = 1 To maxsparks%
                    spark(ii%).r = 0
                    spark(ii%).a = ((2 * Pi) / maxsparks%) * ii%
                Next ii%
                If config.snd Then
                    WAVPlay "explode.wav"
                End If
                GoTo nextbul
            End If
            DrawSpr x%, y%, 7
        End If

        nextbul:
    Next i%
End Sub

Sub Configure
    'The Configuration SUB.

    startcfg:
    menuitem(0) = "CONFIGURE"
    menuitem(1) = "Players"
    menuitem(2) = "Starting Pack"
    menuitem(3) = "Keyboard"
    menuitem(4) = "Options"
    menuitem(5) = "Save"
    mnum% = 5
    Menu mnum%
    Select Case mnum%
        Case -1
            Exit Sub
        Case 1
            GoTo players
        Case 2
            GoTo startpack
        Case 3
            GoTo keyboard
        Case 4
            GoTo options
        Case 5
            GoTo savecfg
    End Select

    players:
    menuitem(0) = "PLAYERS"
    menuitem(1) = "Health:" + Str$(player(0).health)
    For i% = 1 To maxplayers%
        menuitem(i% + 1) = player(i%).nam + ": " + team(player(i%).tnum).nam
    Next i%
    mnum% = maxplayers% + 1
    Menu mnum%
    Select Case mnum%
        Case -1
            GoTo startcfg
        Case 1
            Line (0, 30)-(319, 199), 0, BF
            DrawFont menuitem(mnum%), 160 - (Len(menuitem(mnum%)) / 2) * 8, 50, 1, 1, 2, menuclr% + 5
            For c% = 0 To 100
                FadePal 0, 0, 0, c%, 0, 31
            Next c%
            Locate 10, 20
            Input "", i%
            If i% < 1 Then i% = 1
            If i% > 100 Then i% = 100
            player(0).health = i%
            For c% = 100 To 0 Step -1
                FadePal 0, 0, 0, c%, 0, 31
            Next c%
            GoTo players
        Case 2 TO maxplayers% + 1
            Line (0, 30)-(319, 199), 0, BF
            DrawFont menuitem(mnum%), 160 - (Len(menuitem(mnum%)) / 2) * 8, 50, 1, 1, 2, menuclr% + 5
            DrawFont "New Name", 160 - (Len("New Name") / 2) * 8, 65, 1, 1, 2, menuclr% + 5
            DrawFont "(Enter Makes No Change)", 160 - (Len("(Enter Makes No Change)") / 2) * 8, 90, 1, 1, 2, menuclr% + 5
            For c% = 0 To 100
                FadePal 0, 0, 0, c%, 0, 31
            Next c%
            Locate 11, 15
            Input "", l$
            i% = mnum% - 1
            If l$ <> "" Then
                player(i%).nam = l$
            End If
            For c% = 100 To 0 Step -1
                FadePal 0, 0, 0, c%, 0, 31
            Next c%

            menuitem(0) = "TEAM SELECT"
            menuitem(1) = team(0).nam
            For ii% = 1 To maxplayers%
                menuitem(ii% + 1) = team(ii%).nam
            Next ii%
            mnum% = maxplayers% + 1
            Menu mnum%
            Select Case mnum%
                Case -1
                    GoTo startcfg
                Case 1
                    player(i%).tnum = 0
                Case 2 TO maxplayers% + 1
                    player(i%).tnum = mnum% - 1
            End Select
            GoTo players
    End Select

    startpack:
    menuitem(0) = "STARTING PACK"
    menuitem(1) = "Cannons:" + Str$(playpack(0, 1).ammo)
    menuitem(2) = "Grenades:" + Str$(playpack(0, 2).ammo)
    menuitem(3) = "Mines:" + Str$(playpack(0, 3).ammo)
    menuitem(4) = "Gluers:" + Str$(playpack(0, 4).ammo)
    menuitem(5) = "Flamers:" + Str$(playpack(0, 5).ammo)
    menuitem(6) = "Boosters:" + Str$(playpack(0, 6).ammo)
    menuitem(7) = "Clusters:" + Str$(playpack(0, 7).ammo)
    mnum% = 7
    Menu mnum%
    Select Case mnum%
        Case -1
            GoTo startcfg
        Case 1, 2, 3, 4, 5, 6, 7
            Line (0, 30)-(319, 199), 0, BF
            DrawFont menuitem(mnum%), 160 - (Len(menuitem(mnum%)) / 2) * 8, 50, 1, 1, 2, menuclr% + 5
            For c% = 0 To 100
                FadePal 0, 0, 0, c%, 0, 31
            Next c%
            Locate 10, 20
            Input "", i%
            If mnum% = 1 Then
                If i% < 0 Then i% = 0
                If i% > 99 Then i% = 99
                playpack(0, 1).ammo = i%
            End If
            If mnum% = 2 Then
                If i% < 0 Then i% = 0
                If i% > 99 Then i% = 99
                playpack(0, 2).ammo = i%
            End If
            If mnum% = 3 Then
                If i% < 0 Then i% = 0
                If i% > 99 Then i% = 99
                playpack(0, 3).ammo = i%
            End If
            If mnum% = 4 Then
                If i% < 0 Then i% = 0
                If i% > 99 Then i% = 99
                playpack(0, 4).ammo = i%
            End If
            If mnum% = 5 Then
                If i% < 0 Then i% = 0
                If i% > 99 Then i% = 99
                playpack(0, 5).ammo = i%
            End If
            If mnum% = 6 Then
                If i% < 0 Then i% = 0
                If i% > 99 Then i% = 99
                playpack(0, 6).ammo = i%
            End If
            If mnum% = 7 Then
                If i% < 0 Then i% = 0
                If i% > 99 Then i% = 99
                playpack(0, 7).ammo = i%
            End If
            For c% = 100 To 0 Step -1
                FadePal 0, 0, 0, c%, 0, 31
            Next c%
            GoTo startpack
    End Select

    keyboard:
    menuitem(0) = "KEYBOARD"
    menuitem(1) = keyact(1) + Space$(10 - Len(keyact(1))) + ": " + KeyName$(keycode(1))
    menuitem(2) = keyact(2) + Space$(10 - Len(keyact(2))) + ": " + KeyName$(keycode(2))
    menuitem(3) = keyact(3) + Space$(10 - Len(keyact(3))) + ": " + KeyName$(keycode(3))
    menuitem(4) = keyact(4) + Space$(10 - Len(keyact(4))) + ": " + KeyName$(keycode(4))
    menuitem(5) = keyact(5) + Space$(10 - Len(keyact(5))) + ": " + KeyName$(keycode(5))
    menuitem(6) = keyact(6) + Space$(10 - Len(keyact(6))) + ": " + KeyName$(keycode(6))
    mnum% = 6
    Menu mnum%
    Select Case mnum%
        Case -1
            GoTo startcfg
        Case 1, 2, 3, 4, 5, 6
            Line (0, 30)-(319, 199), 0, BF
            DrawFont menuitem(mnum%), 160 - (Len(menuitem(mnum%)) / 2) * 8, 50, 1, 1, 2, menuclr% + 5
            DrawFont "Press new key", 160 - (Len("Press new key") / 2) * 8, 70, 1, 1, 2, menuclr% + 5
            For c% = 0 To 100
                FadePal 0, 0, 0, c%, 0, 31
            Next c%
            Do
                key$ = InKey$
            Loop Until key$ = ""
            Do
                key$ = InKey$
            Loop Until key$ <> ""
            keycheck% = 1
            For i% = 1 To 10 + maxweapons%
                If i% <> mnum% And key$ = keycode(i%) Then keycheck% = 0
            Next i%
            If keycheck% Then
                keycode(mnum%) = key$
            Else
                DrawFont "Key already assigned", 160 - (Len("Key already assigned") / 2) * 8, 90, 1, 1, 2, menuclr% + 5
                If config.snd Then
                    WAVPlay "buzzer.wav"
                End If
            End If
            For c% = 100 To 0 Step -1
                FadePal 0, 0, 0, c%, 0, 31
            Next c%
            GoTo keyboard
    End Select

    options:
    menuitem(0) = "OPTIONS"
    If config.ammodrop = 0 Then ad$ = "Never"
    If config.ammodrop = .1 Then ad$ = "Low"
    If config.ammodrop = .2 Then ad$ = "Medium"
    If config.ammodrop = .3 Then ad$ = "High"
    menuitem(1) = "Ammo Drops: " + ad$
    If config.snd = 0 Then ad$ = "Off"
    If config.snd = 1 Then ad$ = "On"
    menuitem(2) = "Sound: " + ad$
    If config.sndb = 0 Then ad$ = "Off"
    If config.sndb = 1 Then ad$ = "On"
    menuitem(3) = "Background Sound: " + ad$
    mnum% = 3
    Menu mnum%
    Select Case mnum%
        Case -1
            GoTo startcfg
        Case 1
            menuitem(0) = "AMMO DROPS"
            menuitem(1) = "Never"
            menuitem(2) = "Low"
            menuitem(3) = "Medium"
            menuitem(4) = "High"
            mnum% = 4
            Menu mnum%
            config.ammodrop = (mnum% - 1) * .1
            GoTo options
        Case 2
            menuitem(0) = "SOUND"
            menuitem(1) = "On"
            menuitem(2) = "Off"
            mnum% = 2
            Menu mnum%
            If mnum% = 1 Then
                config.snd = 1
            Else
                config.snd = 0
            End If
            GoTo options
        Case 3
            menuitem(0) = "BACKGROUND SOUND"
            menuitem(1) = "On"
            menuitem(2) = "Off"
            mnum% = 2
            Menu mnum%
            If mnum% = 1 Then
                config.sndb = 1
            Else
                config.sndb = 0
            End If
            GoTo options
    End Select

    savecfg:
    Kill game.cfgfile
    Open game.cfgfile For Output As #1
    l$ = ""
    For i% = 1 To maxplayers%
        Print #1, "player" + Str$(i%) + " " + player(i%).nam
        l$ = l$ + " " + LTrim$(Str$(player(i%).tnum))
    Next i%
    Print #1, "teams" + l$
    Print #1, "health" + Str$(player(0).health)
    Print #1, "pack.cannon" + Str$(playpack(0, 1).ammo)
    Print #1, "pack.grenade" + Str$(playpack(0, 2).ammo)
    Print #1, "pack.mine" + Str$(playpack(0, 3).ammo)
    Print #1, "pack.gluer" + Str$(playpack(0, 4).ammo)
    Print #1, "pack.flamer" + Str$(playpack(0, 5).ammo)
    Print #1, "pack.booster" + Str$(playpack(0, 6).ammo)
    Print #1, "pack.cluster" + Str$(playpack(0, 7).ammo)
    Print #1, "ammo.drops" + Str$(config.ammodrop)
    Print #1, "sound.volume" + Str$(config.snd)
    Print #1, "sound.back" + Str$(config.sndb)
    Print #1, "/end"
    Close #1

    Kill game.keyfile
    Open game.keyfile For Random As #1
    For i% = 1 To 6
        Put #1, i%, keycode(i%)
    Next i%
    Close #1
End Sub

Sub Damage (pn%, dam%)
    'Applies damage to players.
    'pn% = player number
    'dam% = damage amount

    ErasePlayer pn%
    player(pn%).health = player(pn%).health - dam%
    If player(pn%).health <= 0 Then player(pn%).health = 0
    DrawPlayer pn%
    player(pn%).dam = 1
End Sub

Sub DefaultPal
    'Sets the default palette.

    For c% = 0 To 255
        gamepal(c%).r = defpal(c%).r
        gamepal(c%).g = defpal(c%).g
        gamepal(c%).B = defpal(c%).B
    Next c%
End Sub


Sub DoneTurn
    'This SUB occurs at the end of every players turn.
    'Displays the turns damage and checks if player is dead.

    For i% = 1 To maxplayers%
        If level.turn = i% And player(i%).glued > 0 Then player(i%).glued = player(i%).glued - 1
        If player(i%).dam Then
            DrawPlayer i%
        End If
    Next i%
    For ii% = 1 To 5
        For c% = 0 To 20
            For i% = 1 To maxplayers%
                If player(i%).dam = 1 Then
                    Out &H3C8, 220 + i%
                    Out &H3C9, c% * 3
                    Out &H3C9, c% * 2
                    Out &H3C9, 0
                    For z% = -32000 To 32000
                    Next z%
                End If
            Next i%
        Next c%
        For c% = 20 To 0 Step -1
            For i% = 1 To maxplayers%
                If player(i%).dam = 1 Then
                    Out &H3C8, 220 + i%
                    Out &H3C9, c% * 3
                    Out &H3C9, c% * 2
                    Out &H3C9, 0
                    For z% = -32000 To 32000
                    Next z%
                End If
            Next i%
        Next c%
    Next ii%
    FadePal 0, 0, 0, 100, 221, 230
    For i% = 1 To maxplayers%
        If player(i%).dam Then
            player(i%).dam = 0
            If player(i%).health = 0 Then
                ErasePlayer i%
                If config.snd Then
                    WAVPlay "death.wav"
                End If
                For r! = 0 To 15 Step .5
                    For x% = 0 To 7
                        For y% = 0 To 7
                            p% = playerspr(x% + 8 * y%)
                            If p% <> 0 Then
                                If x% <= 3 Then
                                    xc% = x% - 4
                                Else
                                    xc% = x% - 3
                                End If
                                If y% <= 3 Then
                                    yc% = y% - 4
                                Else
                                    yc% = y% - 3
                                End If
                                For ii% = 0 To 5
                                    nr! = (r! - ii%)
                                    If nr! < 0 Then nr! = 0
                                    If nr! <= 10 Then
                                        px% = player(i%).x + x% + xc% * nr!
                                        py% = player(i%).y + y% + (yc% - 3) * nr! + 16 * (nr! / 10) ^ 2
                                        If p% = -1 Then
                                            p% = team(player(i%).tnum).clr
                                        ElseIf p% = -10 Then
                                            If player(i%).dir = 1 Then
                                                p% = 25 - Int(x% / 2)
                                            Else
                                                p% = 25 - Int((7 - x%) / 2)
                                            End If
                                        End If
                                        If ii% > 0 Then p% = 220 - ii% * 3
                                        If ii% = 5 Then p% = BPoint%(px%, py%, 0)
                                        PSet (px%, py%), p%
                                    End If
                                Next ii%
                                For z% = 0 To 32000
                                Next z%
                            End If
                        Next y%
                    Next x%
                Next r!
            End If
        End If
    Next i%
End Sub

Sub DrawBar
    'Redraws the Infobar for each turn.

    For y% = 0 To 15
        For x% = 0 To 319
            p% = TPoint%(x%, y%, 0)
            If p% = 241 Then
                Def Seg = VarSeg(backbuf(0))
                p% = Peek(x% + 320 * y%)
                Def Seg
            End If
            PSet (x%, y%), p%
        Next x%
    Next y%
    DrawFont player(level.turn).nam, 8, 4, 1, 1, 3, 24
    Line (109, 3)-(211, 12), team(player(level.turn).tnum).clr, B
    For i% = 4 To 11
        Line (110, i%)-(210, i%), i% + 12
    Next i%
    For i% = 4 To 11
        Line (110, i%)-(110 + player(level.turn).health, i%), 28 - i% + 4
    Next i%
    Line (219, 4)-(281, 7), team(player(level.turn).tnum).clr, B
    DrawFont LTrim$(Str$(playpack(level.turn, player(level.turn).bul).ammo)), 288, 4, 1, 1, 3, 24
    DrawSpr 308, 1, player(level.turn).bul
    DrawSmallNum 311, 10, playpack(level.turn, player(level.turn).bul).set, 15
    If level.wind = 0 Then
        Circle (250, 11), 2, 78
    ElseIf level.wind > 0 Then
        Line (250 - level.wind / 2, 11)-(250 + level.wind / 2, 11), 78
        Line (250 + level.wind / 2, 11)-(248 + level.wind / 2, 9), 78
        Line (250 + level.wind / 2, 11)-(248 + level.wind / 2, 13), 78
    ElseIf level.wind < 0 Then
        Line (250 - level.wind / 2, 11)-(250 + level.wind / 2, 11), 78
        Line (250 + level.wind / 2, 11)-(252 + level.wind / 2, 9), 78
        Line (250 + level.wind / 2, 11)-(252 + level.wind / 2, 13), 78
    End If
    Line (0, 0)-(319, 15), team(player(level.turn).tnum).clr, B
    Get (0, 0)-(319, 15), barbuf()
End Sub

Sub DrawHealth (pn%, c%)
    'Displays a players health.
    'pn% = player number
    'c% = display color

    n% = player(pn%).health
    nn$ = LTrim$(RTrim$(Str$(n%)))
    x% = player(pn%).x + 3 - Len(LTrim$(RTrim$(Str$(player(pn%).health)))) * 2
    y% = player(pn%).y - 6
    For i% = 1 To Len(nn$)
        d$ = Mid$(nn$, i%, 1)
        For yy% = 0 To 4
            For xx% = 0 To 2
                p% = smallnum(Val(d$), xx% + 3 * yy%)
                If p% = 1 Then
                    If c% = -1 Then
                        p% = BPoint%(x% + xx% + (i% - 1) * 4, y% + yy%, pn%)
                    Else
                        p% = c%
                    End If
                    PSet (x% + xx% + (i% - 1) * 4, y% + yy%), p%
                End If
            Next xx%
        Next yy%
    Next i%
End Sub

Sub DrawPlayer (pn%)
    'Draws the player's sprite.

    x% = player(pn%).x
    y% = player(pn%).y
    For yy% = 0 To 7
        For xx% = 0 To 7
            p% = playerspr(xx% + 8 * yy%)
            If p% = -1 Then
                p% = team(player(pn%).tnum).clr
            ElseIf p% = -10 Then
                If player(pn%).dir = 1 Then
                    p% = 25 - Int(xx% / 2)
                Else
                    p% = 25 - Int((7 - xx%) / 2)
                End If
            End If
            If p% > 0 Then
                If player(pn%).glued > 0 Then p% = 92
                PSet (x% + (player(pn%).dir - 1) * -3.5 + player(pn%).dir * xx%, y% + yy%), p%
            End If
        Next xx%
    Next yy%

    DrawHealth pn%, pn% + 220
    For i% = 0 To gunlen%
        x% = player(pn%).x + 3 + (1 - player(pn%).dir) / 2 + Cos(player(pn%).a) * i% * player(pn%).dir
        y% = player(pn%).y + 4 + Sin(player(pn%).a) * i%
        PSet (x%, y%), 25
    Next i%
    If level.turn = pn% Then
        PSet (player(pn%).x + 3 + Cos(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + Sin(player(pn%).a) * playeraimsize%), 8
        PSet (player(pn%).x + 1 + Cos(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + Sin(player(pn%).a) * playeraimsize%), 7
        PSet (player(pn%).x + 5 + Cos(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + Sin(player(pn%).a) * playeraimsize%), 7
        PSet (player(pn%).x + 3 + Cos(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 1 + Sin(player(pn%).a) * playeraimsize%), 7
        PSet (player(pn%).x + 3 + Cos(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 5 + Sin(player(pn%).a) * playeraimsize%), 7
    End If
End Sub

Sub DrawSmallNum (x%, y%, n%, c%)
    'Draws a small number.

    nn$ = LTrim$(RTrim$(Str$(n%)))
    For i% = 1 To Len(nn$)
        d$ = Mid$(nn$, i%, 1)
        For yy% = 0 To 4
            For xx% = 0 To 2
                p% = smallnum(Val(d$), xx% + 3 * yy%)
                If p% = 1 Then
                    PSet (x% + xx% + (i% - 1) * 4, y% + yy%), c%
                End If
            Next xx%
        Next yy%
    Next i%
End Sub

Sub DrawSpr (x%, y%, sn%)
    'Draws a sprite such as a bullet.
    'x% and y% are coordinates.
    'sn% is the sprite number to be drawn.

    For yy% = 0 To 7
        For xx% = 0 To 7
            p% = ammospr(sn%, xx% + 8 * yy%)
            If p% > 0 Then
                PSet (x% + xx%, y% + yy%), p%
            End If
        Next xx%
    Next yy%
End Sub


Sub EarthQuake (x%)
    'Makes the screen shake.

    For i% = 1 To x%
        Out &H3D4, 8
        Out &H3D5, i%
    Next i%
    Out &H3D4, 8
    Out &H3D5, 0
End Sub

Sub ErasePlayer (pn%)
    'Erases the player's sprite.

    x% = player(pn%).x
    y% = player(pn%).y
    For yy% = 0 To 7
        For xx% = 0 To 7
            p% = playerspr(xx% + 8 * yy%)
            If p% <> 0 Then
                p% = BPoint%(x% + (player(pn%).dir - 1) * -3.5 + player(pn%).dir * xx%, y% + yy%, pn%)
                PSet (x% + (player(pn%).dir - 1) * -3.5 + player(pn%).dir * xx%, y% + yy%), p%
            End If
        Next xx%
    Next yy%

    DrawHealth pn%, -1
    For i% = 0 To gunlen%
        x% = player(pn%).x + 3 + (1 - player(pn%).dir) / 2 + Cos(player(pn%).a) * i% * player(pn%).dir
        y% = player(pn%).y + 4 + Sin(player(pn%).a) * i%
        p% = BPoint%(x%, y%, pn%)
        PSet (x%, y%), p%
    Next i%
PSET (player(pn%).x + 3 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + SIN(player(pn%).a) * playeraimsize%), BPoint%(player(pn%).x + 3 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + SIN( _
player(pn%).a) * playeraimsize%, pn%)
PSET (player(pn%).x + 1 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + SIN(player(pn%).a) * playeraimsize%), BPoint%(player(pn%).x + 1 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + SIN( _
player(pn%).a) * playeraimsize%, pn%)
PSET (player(pn%).x + 5 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + SIN(player(pn%).a) * playeraimsize%), BPoint%(player(pn%).x + 5 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 3 + SIN( _
player(pn%).a) * playeraimsize%, pn%)
PSET (player(pn%).x + 3 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 1 + SIN(player(pn%).a) * playeraimsize%), BPoint%(player(pn%).x + 3 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 1 + SIN( _
player(pn%).a) * playeraimsize%, pn%)
PSET (player(pn%).x + 3 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 5 + SIN(player(pn%).a) * playeraimsize%), BPoint%(player(pn%).x + 3 + COS(player(pn%).a) * playeraimsize% * player(pn%).dir, player(pn%).y + 5 + SIN( _
player(pn%).a) * playeraimsize%, pn%)
End Sub

Sub EraseSpr (x%, y%, sn%)
    'Erases a sprite from the screen.

    For yy% = 0 To 7
        For xx% = 0 To 7
            p% = ammospr(sn%, xx% + 8 * yy%)
            If p% > 0 Then
                p% = BPoint%(x% + xx%, y% + yy%, 0)
                PSet (x% + xx%, y% + yy%), p%
            End If
        Next xx%
    Next yy%
End Sub

Sub FadePal (fr%, fg%, fb%, i%, c1%, c2%)
    'Create the screen's palette as a blend between the current Game Palette
    'and a given color.
    'fr%, fg%, and fb% are the values for the color to blend with.
    'i% is a number from 0 to 100 that sets the amount of true
    'Game Palette (so 0 would be 100% blend color and 100 would be 100% Game Palette).
    'c1% and c2% set the range of colors to be affected by the blend.

    For c% = c1% To c2%
        r% = (gamepal(c%).r / 100) * i% + (fr% / 100) * (100 - i%)
        g% = (gamepal(c%).g / 100) * i% + (fg% / 100) * (100 - i%)
        B% = (gamepal(c%).B / 100) * i% + (fb% / 100) * (100 - i%)
        Out &H3C8, c%
        Out &H3C9, r%
        Out &H3C9, g%
        Out &H3C9, B%
    Next c%
End Sub

Sub DrawFont (text$, xstart%, ystart%, xscale!, yscale!, style%, tclr%)
    'Draws font to the screen.
    'The styles can be seen below, more can be added easily.

    Def Seg = VarSeg(fontbuf(0))
    For h% = 1 To Len(text$)
        fptr% = 81 * (Asc(Mid$(text$, h%, 1)) - 1)
        For y% = 0 To 8
            For x% = 0 To 8
                col% = Peek(VarPtr(fontbuf(0)) + fptr% + x% + 9 * y%)
                If col% Then
                    px% = xstart% + x% * xscale! + (h% - 1) * 8 * xscale!
                    py% = ystart% + y% * yscale!
                    Select Case style%

                        Case 1
                            Line (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), (py% - ystart%) / yscale! + tclr%, BF

                        Case 2
                            Line (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), (py% - ystart%) / yscale! + tclr%, BF
                            x2% = x% + 1
                            y2% = y% + 1
                            col2% = Peek(VarPtr(fontbuf(0)) + fptr% + x2% + 9 * y2%)
                            If x2% < 0 Or x2% > 8 Or y2% < 0 Or y2% > 8 Then col2% = 0
                            If col2% = 0 Then
                                px% = xstart% + x2% * xscale! + (h% - 1) * 8 * xscale!
                                py% = ystart% + y2% * yscale!
                                Line (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), (py% - ystart%) / yscale! + tclr% - 4, BF
                            End If
                            x2% = x% + 2
                            y2% = y% + 2
                            col2% = Peek(VarPtr(fontbuf(0)) + fptr% + x2% + 9 * y2%)
                            If x2% < 0 Or x2% > 8 Or y2% < 0 Or y2% > 8 Then col2% = 0
                            If col2% = 0 Then
                                px% = xstart% + x2% * xscale! + (h% - 1) * 8 * xscale!
                                py% = ystart% + y2% * yscale!
                                Line (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), (py% - ystart%) / yscale! + tclr% - 8, BF
                            End If

                        Case 3
                            Line (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), (py% - ystart%) / yscale! + tclr%, BF
                            For yc% = -1 To 1
                                For xc% = -1 To 1
                                    x2% = x% + xc%
                                    y2% = y% + yc%
                                    col2% = Peek(VarPtr(fontbuf(0)) + fptr% + x2% + 9 * y2%)
                                    If x2% < 0 Or x2% > 8 Or y2% < 0 Or y2% > 8 Then col2% = 0
                                    If col2% = 0 Then
                                        px% = xstart% + x2% * xscale! + (h% - 1) * 8 * xscale!
                                        py% = ystart% + y2% * yscale!
                                        Line (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), (py% - ystart%) / yscale! + tclr% - 6, BF
                                    End If
                                Next xc%
                            Next yc%

                        Case 4
                            Line (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), (py% - ystart%) / yscale! + tclr% - 6, BF
                            For yc% = -1 To 1
                                For xc% = -1 To 1
                                    x2% = x% + xc%
                                    y2% = y% + yc%
                                    col2% = Peek(VarPtr(fontbuf(0)) + fptr% + x2% + 9 * y2%)
                                    If x2% < 0 Or x2% > 8 Or y2% < 0 Or y2% > 8 Then col2% = 0
                                    If col2% = 0 Then
                                        px% = xstart% + x2% * xscale! + (h% - 1) * 8 * xscale!
                                        py% = ystart% + y2% * yscale!
                                        Line (px%, py%)-(px% + xscale! - 1, py% + yscale! - 1), 7 - 2 * yscale! - (py% - ystart%) / yscale! + tclr%, BF
                                    End If
                                Next xc%
                            Next yc%

                    End Select
                End If
                py! = py! + yscale!
            Next
            px! = px! + xscale!
            py! = ystart%
        Next
    Next h%
    Def Seg
End Sub

Sub InitBullet (c%, x%, y%, a#, d%, p%, s%)
    'Inititializes a bullet object.
    'c% = bullet class
    'x% and y% are coordinates
    'a# = angle
    'd% = direction
    'p% = power
    's% = setting

    For i% = 1 To maxbullets%
        If bullet(i%).class = 0 Then
            bullet(i%).class = c%
            bullet(i%).xi = x%
            bullet(i%).yi = y%
            bullet(i%).x = x%
            bullet(i%).y = y%
            bullet(i%).a = a#
            bullet(i%).dir = d%
            bullet(i%).p = p%
            bullet(i%).tim = Timer - .1
            bullet(i%).set = s%
            Exit For
        End If
    Next i%
End Sub

Sub InitGame
    'Initializes the game.

    Randomize Timer
    LoadCfg game.cfgfile
    LoadKey game.keyfile
    Restore teaminfo
    For i% = 0 To maxplayers%
        Read l$
        team(i%).nam = l$
        Read x%
        team(i%).clr = x%
    Next i%
End Sub

Sub InitGamePal
    'Initializes the Game Palette.

    For c% = 221 To 230
        gamepal(c%).r = 62
        gamepal(c%).g = 62
        gamepal(c%).B = 62
    Next c%
    For c% = 231 To 240
        gamepal(c%).r = pal(2).r + (c% - 231) * (pal(3).r - pal(2).r) / 10
        gamepal(c%).g = pal(2).g + (c% - 231) * (pal(3).g - pal(2).g) / 10
        gamepal(c%).B = pal(2).B + (c% - 231) * (pal(3).B - pal(2).B) / 10
    Next c%
    gamepal(241).B = pal(1).r
    gamepal(241).B = pal(1).g
    gamepal(241).B = pal(1).B
    SetBlastPal
End Sub

Sub InitPlayers
    'Initializes the players.

    Dim playeract(1 To maxplayers%) As Integer

    player(0).aj = -1.2
    player(0).pj = 30
    mnum% = 0
    For i% = 1 To maxplayers%
        playeract(i%) = 0
        player(i%).health = 0
        If player(i%).tnum > 0 Then
            mnum% = mnum% + 1
            playeract(mnum%) = i%
        End If
    Next i%
    For i% = 1 To mnum%
        If player(playeract(i%)).tnum > 0 Then
            x% = 320 / (mnum% + 1) * i%
            player(playeract(i%)).x = x%
            For y% = 0 To 200
                For xx% = x% To x% + 7
                    If TPoint%(xx%, y% + 7, i%) <> 241 Then
                        GoTo playerland
                    End If
                Next xx%
            Next y%
            playerland:
            player(playeract(i%)).y = y%
            player(playeract(i%)).a = 0
            player(playeract(i%)).bul = 1
            player(playeract(i%)).dir = 1
            player(playeract(i%)).health = player(0).health
            player(playeract(i%)).dam = 0
            player(playeract(i%)).jump = 0
            For ii% = 1 To maxweapons%
                playpack(playeract(i%), ii%).ammo = playpack(0, ii%).ammo
                playpack(playeract(i%), ii%).set = playpack(0, ii%).set
            Next ii%
        End If
    Next i%
End Sub

Sub InitScr
    'Initializes the screen.

    Screen 13
    FullScreen SquarePixels , Smooth

    Color 28
    For c% = 0 To 255
        Out &H3C7, c%
        defpal(c%).r = Inp(&H3C9)
        defpal(c%).g = Inp(&H3C9)
        defpal(c%).B = Inp(&H3C9)
    Next c%
    FadePal 0, 0, 0, 0, 0, 255
    LoadSprites game.sprfile
    LoadGameFont game.fntfile
End Sub

Function KeyMark% (k$)
    'Returns the code for the key pressed.

    ii% = 0
    For i% = 1 To 11 + maxweapons%
        If k$ = keycode(i%) Then
            ii% = i%
            Exit For
        End If
    Next i%
    KeyMark% = ii%
End Function

Function KeyName$ (k$)
    'Returns the common name for the keycode.

    Dim kn As String * 10

    Select Case UCase$(k$)
        Case Chr$(0) + "H"
            kn = "Up"
        Case Chr$(0) + "P"
            kn = "Down"
        Case Chr$(0) + "K"
            kn = "Left"
        Case Chr$(0) + "M"
            kn = "Right"
        Case Chr$(13)
            kn = "Enter"
        Case Chr$(27)
            kn = "Esc"
        Case Chr$(32)
            kn = "Space"
        Case Chr$(0) + Chr$(59)
            kn = "F1"
        Case Chr$(0) + Chr$(60)
            kn = "F2"
        Case Chr$(0) + Chr$(61)
            kn = "F3"
        Case Chr$(0) + Chr$(62)
            kn = "F4"
        Case Chr$(0) + Chr$(63)
            kn = "F5"
        Case Chr$(0) + Chr$(64)
            kn = "F6"
        Case Chr$(0) + Chr$(65)
            kn = "F7"
        Case Chr$(0) + Chr$(66)
            kn = "F8"
        Case Else
            kn = UCase$(k$)

    End Select
    KeyName$ = kn
End Function

Sub LoadCfg (file$)
    'Loads the Configuration file.

    Open file$ For Input As #1
    Cls
    nextline:
    Line Input #1, l$
    If LCase$(l$) = "/end" Then GoTo lastline
    s1% = InStr(l$, " ")
    c1$ = Left$(l$, s1% - 1)
    Select Case LCase$(c1$)

        Case "player"
            c2$ = Mid$(l$, s1% + 1, 1)
            c3$ = Right$(l$, Len(l$) - s1% - 2)
            player(Val(c2$)).nam = c3$

        Case "teams"
            c2$ = Right$(l$, Len(l$) - s1%)
            player(1).tnum = Val(Mid$(c2$, 1, 1))
            player(2).tnum = Val(Mid$(c2$, 3, 1))
            player(3).tnum = Val(Mid$(c2$, 5, 1))
            player(4).tnum = Val(Mid$(c2$, 7, 1))
            player(5).tnum = Val(Mid$(c2$, 9, 1))
            player(6).tnum = Val(Mid$(c2$, 11, 1))
            player(7).tnum = Val(Mid$(c2$, 13, 1))
            player(8).tnum = Val(Mid$(c2$, 15, 1))

        Case "health"
            c2$ = Right$(l$, Len(l$) - s1%)
            player(0).health = Val(c2$)

        Case "pack.cannon"
            c2$ = Right$(l$, Len(l$) - s1%)
            playpack(0, 1).ammo = Val(c2$)
            playpack(0, 1).set = 1

        Case "pack.grenade"
            c2$ = Right$(l$, Len(l$) - s1%)
            playpack(0, 2).ammo = Val(c2$)
            playpack(0, 2).set = 2

        Case "pack.mine"
            c2$ = Right$(l$, Len(l$) - s1%)
            playpack(0, 3).ammo = Val(c2$)
            playpack(0, 3).set = 1

        Case "pack.gluer"
            c2$ = Right$(l$, Len(l$) - s1%)
            playpack(0, 4).ammo = Val(c2$)
            playpack(0, 4).set = 1

        Case "pack.flamer"
            c2$ = Right$(l$, Len(l$) - s1%)
            playpack(0, 5).ammo = Val(c2$)
            playpack(0, 5).set = 1

        Case "pack.booster"
            c2$ = Right$(l$, Len(l$) - s1%)
            playpack(0, 6).ammo = Val(c2$)
            playpack(0, 6).set = 1

        Case "pack.cluster"
            c2$ = Right$(l$, Len(l$) - s1%)
            playpack(0, 7).ammo = Val(c2$)
            playpack(0, 7).set = 3

        Case "ammo.drops"
            c2$ = Right$(l$, Len(l$) - s1%)
            config.ammodrop = Val(c2$)

        Case "sound.volume"
            c2$ = Right$(l$, 1)
            config.snd = Val(c2$)

        Case "sound.back"
            c2$ = Right$(l$, 1)
            config.sndb = Val(c2$)

    End Select
    GoTo nextline:
    lastline:
    Close #1
End Sub

Sub LoadGameFont (file$)
    'Loads the Font file.

    Open file$ For Binary As #1
    If LOF(1) < 2 Then
        NoFile% = 1
    End If
    If NoFile% <> 1 Then Get #1, , fontbuf(0)
    Close #1
    If NoFile% Then
        Kill file$
        Cls
        Print "The font data file couldn't be found!"
        Print
        Print "Would you like to create one? (Y/N)"
        Input "> ", Choice$
        If UCase$(Choice$) = "N" Then
            Print "The program cannot run without this file!"
            System
        Else
            Print "Hit a key to make the file."
            Print "You will hear a beep if it is working."
            Pause

            Open file$ For Binary As #1
            Color 16
            For ascii% = 1 To 128
                Cls
                Print Chr$(ascii%)
                For x = 0 To 8
                    For y = 0 To 8
                        pnt$ = Chr$(Point(x, y))
                        Put #1, , pnt$
                        pnt$ = ""
                    Next
                Next
            Next
            Close #1
            Open file$ For Binary As #1
            Get #1, , fontbuf(0)
            Close #1
        End If
    End If
End Sub

Sub LoadKey (file$)
    'Loads the Key file.

    Open file$ For Random As #1
    For i% = 1 To 6
        Get #1, i%, k$
        keycode(i%) = k$
    Next i%
    keyact(1) = "Walk Left"
    keyact(2) = "Walk Right"
    keyact(3) = "Aim Up"
    keyact(4) = "Aim Down"
    keyact(5) = "Fire"
    keyact(6) = "Jump"

    keyact(7) = "Set 1"
    keycode(7) = "1"
    keyact(8) = "Set 2"
    keycode(8) = "2"
    keyact(9) = "Set 3"
    keycode(9) = "3"
    keyact(10) = "Quit"
    keycode(10) = Chr$(27)
    keyact(11) = "Skip Turn"
    keycode(11) = Chr$(8)

    keyact(12) = "Cannon"
    keycode(12) = Chr$(0) + Chr$(&H3B)
    keyact(13) = "Grenade"
    keycode(13) = Chr$(0) + Chr$(&H3C)
    keyact(14) = "Mine"
    keycode(14) = Chr$(0) + Chr$(&H3D)
    keyact(15) = "Gluer"
    keycode(15) = Chr$(0) + Chr$(&H3E)
    keyact(16) = "Flamer"
    keycode(16) = Chr$(0) + Chr$(&H3F)
    keyact(17) = "Booster"
    keycode(17) = Chr$(0) + Chr$(&H40)
    keyact(18) = "Cluster"
    keycode(18) = Chr$(0) + Chr$(&H41)
    Close #1
End Sub

Sub LoadLevel (file$)
    'Loads a Level file.

    Open file$ For Input As #1
    Line Input #1, l$
    level.nam = l$
    Line Input #1, l$
    turffile$ = l$
    Line Input #1, l$
    backfile$ = l$
    Line Input #1, l$
    level.grav = Val(l$)
    Line Input #1, l$
    level.sndb = l$
    Close #1
    Def Seg = &HA000
    BLoad turffile$, 0
    Def Seg
    Get (0, 0)-(319, 199), turfbuf()
    Def Seg = VarSeg(backbuf(0))
    BLoad "backgrnd\" + backfile$, 0
    Def Seg
End Sub

Sub LoadSprites (file$)
    'Loads the Sprite file.

    Open file$ For Input As #1
    nextsprite:
    Input #1, n%
    If n% = -1 Then GoTo endsprite
    For y% = 0 To 7
        For x% = 0 To 7
            Input #1, p%
            If n% = 0 Then
                playerspr(x% + 8 * y%) = p%
            ElseIf n% = 100 Then
                ammospr(0, x% + 8 * y%) = p%
            Else
                ammospr(n%, x% + 8 * y%) = p%
            End If
        Next x%
    Next y%
    GoTo nextsprite
    endsprite:
    Close #1

    Restore smallnums
    For i% = 0 To 9
        For y% = 0 To 4
            For x% = 0 To 2
                Read p%
                smallnum(i%, x% + 3 * y%) = p%
            Next x%
        Next y%
    Next i%
End Sub

Sub Main
    'Main game procedure.

    For y% = 0 To 199
        For x% = 0 To 319
            Def Seg = VarSeg(turfbuf(0))
            p% = Peek(x% + 320& * y% + 4)
            Def Seg
            If p% = 241 Then
                Def Seg = VarSeg(backbuf(0))
                p% = Peek(x% + 320& * y%)
                Def Seg
            End If
            PSet (x%, y%), p%
        Next x%
    Next y%

    InitPlayers
    For i% = 1 To maxbullets%
        bullet(i%).class = 0
    Next i%
    For c% = 0 To 100
        FadePal 0, 0, 0, c%, 0, 255
    Next c%

    level.turn = 0
    level.wind = Rnd * 40 - 20
    level.quit = 0

    newloop:
    nextcheck:
    level.turn = level.turn + 1
    If level.turn > maxplayers% Then
        level.turn = 1
        level.wind = Rnd * 40 - 20
    End If
    If player(level.turn).health = 0 Then GoTo nextcheck

    level.fire = 0
    For i% = 1 To maxplayers%
        If player(i%).health > 0 Then
            DrawPlayer i%
        End If
    Next i%
    DrawBar
    If Rnd < config.ammodrop Then
        x% = Rnd * 300 + 10
        i% = CInt(Rnd * (maxweapons% - 1)) + 1
        ii% = Rnd * 2 + 1
        If config.snd Then
            WAVPlay "jet.wav"
        End If
        InitBullet -100, x%, 0, 0, ii%, 0, i%
    End If
    For i% = 1 To 4
        key$ = InKey$
    Next i%

    startloop:
    If config.snd And config.sndb Then
        WAVPlay level.sndb
    End If

    level.nofly = 1
    PlayerKey
    level.tim = Timer
    PlayerFall
    BulletMove

    If level.quit = 1 Then
        Exit Sub
    End If
    If level.nofly And (level.fire Or player(level.turn).health = 0) Then GoTo nextplayer

    GoTo startloop

    nextplayer:
    DoneTurn
    y% = 0
    For i% = 1 To maxplayers%
        team(i%).act = 0
        For ii% = 1 To maxplayers%
            If player(ii%).tnum = i% And player(ii%).health > 0 Then
                team(i%).act = 1
                y% = i%
            End If
        Next ii%
    Next i%
    x% = 0
    For i% = 1 To maxplayers%
        x% = x% + team(i%).act
    Next i%
    If x% = 1 Then
        Win y%
        Exit Sub
    ElseIf x% = 0 Then
        Win 0
        Exit Sub
    End If

    ErasePlayer level.turn
    GoTo newloop
End Sub


Sub Menu (mnum%)
    'Creates a menu.
    'The menuitem variables (1 up to 10) are strings which are the menu items.
    'menuitem(0) is the menu title.
    'When Menu is called, mnum% should be the largest number of menuitem that
    'is used for that menu.  It will return mnum% as the menu item chosen.

    moff% = 0
    Cls
    DrawFont menuitem(0), 160 - (Len(menuitem(0)) / 2) * 16, 10, 2, 2, 3, menuclr% + 8
    mmax% = mnum%
    If mmax% > 7 Then mmax% = 7
    For i% = 0 To 5
        Line (i%, 45 + i%)-(319 - i%, mmax% * 20 + 63 - i%), menuclr% + i%, B
    Next i%

    i% = 1
    For c% = 0 To 100
        FadePal 0, 0, 0, c%, 0, 31
    Next c%
    drawmenu:
    Line (6, 51)-(313, mmax% * 20 + 57), 0, BF
    For ii% = moff% + 1 To moff% + mmax%
        c% = menuclr%
        If ii% = i% Then c% = menuclr% + 5
        DrawFont menuitem(ii%), 160 - (Len(menuitem(ii%)) / 2) * 8, (ii% - moff%) * 20 + 40, 1, 1, 1, c%
    Next ii%
    If moff% > 0 Then
        For ii% = 0 To 5
            Line (300 - (5 - ii%), 60 - ii%)-(300 + (5 - ii%), 60 - ii%), 18 + ii% * 2
        Next ii%
    End If
    If moff% + mmax% < mnum% Then
        For ii% = 0 To 5
            Line (300 - (5 - ii%), ii% + 190)-(300 + (5 - ii%), ii% + 190), 18 + ii% * 2
        Next ii%
    End If
    Do
        key$ = InKey$
        Select Case key$
            Case Chr$(27)
                If config.snd Then
                    WAVPlay "menua.wav"
                End If
                i% = -1
                Exit Do

            Case Chr$(0) + "H"
                i% = i% - 1
                If i% = 0 Then i% = mnum%
                moff% = i% - 4
                If moff% + 7 > mnum% Then moff% = mnum% - 7
                If moff% < 0 Then moff% = 0
                If config.snd Then
                    WAVPlay "menub.wav"
                End If
                GoTo drawmenu

            Case Chr$(0) + "P"
                i% = i% + 1
                If i% = mnum% + 1 Then i% = 1
                moff% = i% - 4
                If moff% + 7 > mnum% Then moff% = mnum% - 7
                If moff% < 0 Then moff% = 0
                If config.snd Then
                    WAVPlay "menub.wav"
                End If
                GoTo drawmenu

            Case Chr$(13)
                If config.snd Then
                    WAVPlay "menua.wav"
                End If
                Exit Do

        End Select
        If Rnd < .00005 Then
            x% = Rnd * 250 + 60
            y% = Rnd * 40
            d% = Rnd * 10 + 10
            If Rnd < .1 Then
                s% = 1
                For ii% = 1 To maxsparks%
                    spark(ii%).r = 0
                    spark(ii%).a = ((2 * Pi) / maxsparks%) * ii%
                Next ii%
            Else
                s% = 0
            End If
            For ii% = 1 To maxbullets%
                If bullet(ii%).class = 0 Then
                    bullet(ii%).class = -1
                    bullet(ii%).x = x%
                    bullet(ii%).y = y%
                    bullet(ii%).a = 0
                    bullet(ii%).dir = d%
                    bullet(ii%).p = 1
                    bullet(ii%).set = s%
                    If config.snd Then
                        If Rnd < .5 Then
                            WAVPlay "explode.wav"
                        Else
                            WAVPlay "blast.wav"
                        End If
                    End If
                    Exit For
                End If
            Next ii%
        End If
        For B% = 1 To maxbullets%
            If bullet(B%).class = -1 Then
                level.nofly = 0
                x% = bullet(B%).x
                y% = bullet(B%).y
                c% = 220 - (bullet(B%).a / bullet(B%).dir) * 20
                If bullet(B%).p = -1 Then c% = 0
                For r! = 0 To Pi * 2 Step .05
                    p% = Point(x% + Cos(r!) * bullet(B%).a + 3, y% + Sin(r!) * bullet(B%).a + 3)
                    If p% = 0 Or p% >= 200 Then
                        PSet (x% + Cos(r!) * bullet(B%).a + 3, y% + Sin(r!) * bullet(B%).a + 3), c%
                    End If
                Next r!
                bullet(B%).a = bullet(B%).a + .5 * bullet(B%).p
                If bullet(B%).p = 1 And bullet(B%).a >= bullet(B%).dir Then
                    bullet(B%).p = -1
                End If
                If bullet(B%).set = 1 Then
                    For ii% = 1 To maxsparks%
                        sx% = bullet(B%).x + 3 + spark(ii%).r * Cos(spark(ii%).a)
                        sy% = bullet(B%).y + 3 + .3 * (spark(ii%).r * Sin(spark(ii%).a))
                        p% = Point(sx%, sy%)
                        If p% >= 200 Then
                            PSet (sx%, sy%), 0
                        End If
                        spark(ii%).r = spark(ii%).r + 2
                        sx% = bullet(B%).x + 3 + spark(ii%).r * Cos(spark(ii%).a)
                        sy% = bullet(B%).y + 3 + .3 * (spark(ii%).r * Sin(spark(ii%).a))
                        c% = 220 - spark(ii%).r / 3
                        If c% < 200 Then c% = 200
                        If bullet(B%).p = -1 And bullet(B%).a < 0 Then c% = 0
                        p% = Point(sx%, sy%)
                        If p% = 0 Then
                            PSet (sx%, sy%), c%
                        End If
                    Next ii%
                End If
                If bullet(B%).p = -1 And bullet(B%).a < 0 Then
                    bullet(B%).class = 0
                End If
            End If
        Next B%

        Limit 60
    Loop
    mnum% = i%
    For c% = 100 To 0 Step -1
        FadePal 0, 0, 0, c%, 0, 31
    Next c%
End Sub

Sub Pause
    'Pauses the game until enter is pressed.

    Do
        key$ = InKey$
    Loop Until key$ = ""
    Do
        key$ = InKey$
    Loop Until key$ = Chr$(13)
    Do
        key$ = InKey$
    Loop Until key$ = ""
End Sub

Sub PlayerFall
    'Makes a player fall if necessary.

    For pn% = 1 To maxplayers%
        If player(pn%).health > 0 Or player(pn%).dam Then
            t# = (level.tim - player(pn%).tim) * bulletspd%
            x% = player(pn%).x
            y% = player(pn%).y
            If player(pn%).jump > 0 Then
                level.nofly = 0
                ErasePlayer pn%
                player(pn%).x = player(pn%).xi + t# * Cos(player(pn%).aj) * player(pn%).pj * player(pn%).dir
                player(pn%).y = player(pn%).yi + t# * Sin(player(pn%).aj) * player(pn%).pj + 16 * t# ^ 2 * level.grav
                DrawPlayer pn%
                If player(pn%).jump = 2 Then
                    c% = 220 - t# * 20
                    Line (player(pn%).x + 1, player(pn%).y + 7)-(player(pn%).x + 6, player(pn%).y + 7), c%
                    If t# >= 1 Then player(pn%).jump = 1
                End If
            End If
            If player(pn%).x < -7 Or player(pn%).x > 320 Or player(pn%).y > 205 Then
                If config.snd Then
                    WAVPlay "fall.wav"
                End If
                player(pn%).dam = 0
                player(pn%).health = 0
            End If

            bump$ = TurfBump$(x%, y%, -1)
            'Uncomment this to help you see where the player is colliding with turf
            'IF pn% = level.turn THEN
            '  LINE (10, 180)-(14, 180), 18
            '  IF MID$(bump$, 1, 1) = "1" THEN LINE (10, 180)-(14, 180), 15
            '  LINE (16, 180)-(20, 180), 18
            '  IF MID$(bump$, 2, 1) = "1" THEN LINE (16, 180)-(20, 180), 15
            '  LINE (21, 181)-(21, 184), 18
            '  IF MID$(bump$, 3, 1) = "1" THEN LINE (21, 181)-(21, 184), 15
            '  LINE (21, 186)-(21, 189), 18
            '  IF MID$(bump$, 4, 1) = "1" THEN LINE (21, 186)-(21, 189), 15
            '  LINE (16, 190)-(20, 190), 18
            '  IF MID$(bump$, 5, 1) = "1" THEN LINE (16, 190)-(20, 190), 15
            '  LINE (10, 190)-(14, 190), 18
            '  IF MID$(bump$, 6, 1) = "1" THEN LINE (10, 190)-(14, 190), 15
            '  LINE (9, 186)-(9, 189), 18
            '  IF MID$(bump$, 7, 1) = "1" THEN LINE (9, 186)-(9, 189), 15
            '  LINE (9, 181)-(9, 184), 18
            '  IF MID$(bump$, 8, 1) = "1" THEN LINE (9, 181)-(9, 184), 15
            'END IF

            Select Case bump$
                Case "00000000"
                    If player(pn%).jump = 0 Then
                        player(pn%).tim = level.tim - .2
                        player(pn%).jump = 1
                        player(pn%).xi = x%
                        player(pn%).yi = y%
                        player(pn%).pj = 0
                        t# = (level.tim - player(pn%).tim) * bulletspd%
                    End If

                Case "11100011", "11000001", "10000000", "00000010", "00000001", "00000011", "10000011", "00000111", "10000111", "11001111", "10001111", "11000111", "10000001", "11001111", "11101111", "11000001", "11000011"
                    If player(pn%).jump > 0 And player(pn%).dir = -1 Then
                        xc% = t# * Cos(player(pn%).aj) * player(pn%).pj * -player(pn%).dir
                        player(pn%).xi = x% - xc%
                        ErasePlayer pn%
                        player(pn%).dir = 1
                        DrawPlayer pn%
                        If config.snd Then
                            WAVPlay "bounce.wav"
                        End If
                    End If

                Case "11110001", "11100000", "01000000", "00100000", "00010000", "00110000", "01110000", "00111000", "01111000", "11111100", "01111100", "11111000", "01100000", "11111100", "11111110", "11100000", "11110000"
                    If player(pn%).jump > 0 And player(pn%).dir = 1 Then
                        xc% = t# * Cos(player(pn%).aj) * player(pn%).pj * -player(pn%).dir
                        player(pn%).xi = x% - xc%
                        ErasePlayer pn%
                        player(pn%).dir = -1
                        DrawPlayer pn%
                        If config.snd Then
                            WAVPlay "bounce.wav"
                        End If
                    End If

                Case "11000000", "11100001", "11110011"
                    ' IF player(pn%).jump > 0 THEN
                    '  nt# = 2 * p% * SIN(player(pn%).aj) / (2 * (16 * level.grav))
                    '  xc% = t# * COS(player(pn%).aj) * player(pn%).pj * player(pn%).dir
                    '  player(pn%).xi = x% - xc%
                    '  IF config.snd THEN
                    '   wavplay "bounce.wav", 11000
                    '  END IF
                    ' END IF

                    'CASE "11111111", "01111111", "10111111", "00000100", "00000010", "00000110", "00001110", "00011100", "00011110", "00111111", "00011111", "00111110", "00001111", "10011111", "00011000", "00111100", "01111110", "11011111", "11111110"
                Case Else
                    If player(pn%).jump > 0 Then
                        player(pn%).jump = 0
                        If 16 * t# ^ 2 * level.grav > 140 Then
                            Damage pn%, (16 * t# ^ 2 * level.grav - 140) / 2
                            If pn% = level.turn Then level.fire = 1
                            If config.snd Then
                                WAVPlay "crash.wav"
                            End If
                        ElseIf 16 * t# ^ 2 * level.grav > 10 Then
                            If config.snd Then
                                WAVPlay "land.wav"
                            End If
                        End If
                    End If
            End Select
        End If
    Next pn%
End Sub

Sub PlayerKey
    'Gets the key that was pressed and processes it.

    key$ = InKey$
    k% = KeyMark%(key$)
    Select Case k%
        Case 1
            If player(level.turn).glued = 0 Then
                If player(level.turn).jump Then
                    If player(level.turn).dir = 1 Then
                        ErasePlayer level.turn
                        player(level.turn).xi = player(level.turn).xi + 2 * (player(level.turn).x - player(level.turn).xi)
                        player(level.turn).dir = -1
                        DrawPlayer level.turn
                    End If
                Else
                    For y% = 0 To playerstep%
                        If TPoint%(player(level.turn).x - 1, player(level.turn).y + 7 - y%, level.turn) = 241 Then Exit For
                    Next y%
                    If y% <= playerstep% Then
                        If config.snd Then
                            If config.sndb = 0 Then
                                WAVPlay "crawl.wav"
                            End If
                        End If
                        ErasePlayer level.turn
                        player(level.turn).x = player(level.turn).x - 1
                        player(level.turn).y = player(level.turn).y - y%
                        player(level.turn).dir = -1
                        DrawPlayer level.turn
                    End If
                End If
            End If

        Case 2
            If player(level.turn).glued = 0 Then
                If player(level.turn).jump Then
                    If player(level.turn).dir = -1 Then
                        ErasePlayer level.turn
                        player(level.turn).xi = player(level.turn).xi + 2 * (player(level.turn).x - player(level.turn).xi)
                        player(level.turn).dir = 1
                        DrawPlayer level.turn
                    End If
                Else
                    For y% = 0 To playerstep%
                        If TPoint%(player(level.turn).x + 8, player(level.turn).y + 7 - y%, level.turn) = 241 Then Exit For
                    Next y%
                    If y% <= playerstep% Then
                        If config.snd Then
                            If config.sndb = 0 Then
                                WAVPlay "crawl.wav"
                            End If
                        End If
                        ErasePlayer level.turn
                        player(level.turn).x = player(level.turn).x + 1
                        player(level.turn).y = player(level.turn).y - y%
                        player(level.turn).dir = 1
                        DrawPlayer level.turn
                    End If
                End If
            End If

        Case 3
            If config.snd Then
                If config.sndb = 0 Then
                    WAVPlay "aim.wav"
                End If
            End If
            ErasePlayer level.turn
            player(level.turn).a = player(level.turn).a - playeraim!
            If player(level.turn).a < -Pi / 2 Then player(level.turn).a = -Pi / 2
            DrawPlayer level.turn

        Case 4
            If config.snd Then
                If config.sndb = 0 Then
                    WAVPlay "aim.wav"
                End If
            End If
            ErasePlayer level.turn
            player(level.turn).a = player(level.turn).a + playeraim!
            If player(level.turn).a > Pi / 2 Then player(level.turn).a = Pi / 2
            DrawPlayer level.turn

        Case 5
            If level.fire = 0 And player(level.turn).jump = 0 Then
                If player(level.turn).bul = 1 Then
                    If playpack(level.turn, 1).ammo >= playpack(level.turn, 1).set Then
                        playpack(level.turn, 1).ammo = playpack(level.turn, 1).ammo - playpack(level.turn, 1).set
                        power% = 0
                        If config.snd Then
                            WAVPlay "power.wav"
                        End If
                        Do
                            key$ = InKey$
                            If KeyMark%(key$) = 5 Then Exit Do
                            Line (220 + power%, 5)-(220 + power%, 6), 200 + power% / 3
                            power% = power% + 1
                            For z& = -32000 To 32000
                            Next z&
                            If power% = 60 Then Exit Do
                        Loop
                        Line (220, 5)-(280, 6), 0, BF
                        power% = maxpower% * (power% / 60)
                        For i% = 1 To playpack(level.turn, 1).set
                            InitBullet 1, player(level.turn).x, player(level.turn).y, player(level.turn).a - ((1 / playpack(level.turn, 1).set - 1) * .05) + ((i% - 1) * .1), player(level.turn).dir, power%, playpack(level.turn, 1).set
                            DrawSpr player(level.turn).x, player(level.turn).y, 1
                        Next i%
                        If config.snd Then
                            WAVPlay "launch.wav"
                        End If
                        level.fire = 1
                    Else
                        If config.snd Then
                            WAVPlay "buzzer.wav"
                        End If
                    End If
                End If

                If player(level.turn).bul = 2 Then
                    If playpack(level.turn, 2).ammo > 0 Then
                        playpack(level.turn, 2).ammo = playpack(level.turn, 2).ammo - 1
                        power% = 0
                        If config.snd Then
                            WAVPlay "power.wav"
                        End If
                        Do
                            key$ = InKey$
                            If KeyMark%(key$) = 5 Then Exit Do
                            Line (220 + power%, 5)-(220 + power%, 6), 200 + power% / 3
                            power% = power% + 1
                            For z& = -32000 To 32000
                            Next z&
                            If power% = 60 Then Exit Do
                        Loop
                        Line (220, 5)-(280, 6), 0, BF
                        power% = maxpower% * (power% / 60)
                        InitBullet 2, player(level.turn).x, player(level.turn).y, player(level.turn).a, player(level.turn).dir, power%, playpack(level.turn, 2).set * 2500
                        DrawSpr player(level.turn).x, player(level.turn).y, 2
                        If config.snd Then
                            WAVPlay "launch.wav"
                        End If
                        level.fire = 1
                    Else
                        If config.snd Then
                            WAVPlay "buzzer.wav"
                        End If
                    End If
                End If

                If player(level.turn).bul = 3 Then
                    If playpack(level.turn, 3).ammo > 0 Then
                        playpack(level.turn, 3).ammo = playpack(level.turn, 3).ammo - 1
                        InitBullet 3, player(level.turn).x, player(level.turn).y, 0, 0, 0, playpack(level.turn, 3).set
                        DrawSpr player(level.turn).x, player(level.turn).y, 3
                        If config.snd Then
                            WAVPlay "mine.wav"
                        End If
                        level.fire = 1
                    Else
                        If config.snd Then
                            WAVPlay "buzzer.wav"
                        End If
                    End If
                End If

                If player(level.turn).bul = 4 Then
                    If playpack(level.turn, 4).ammo >= playpack(level.turn, 4).set Then
                        playpack(level.turn, 4).ammo = playpack(level.turn, 4).ammo - playpack(level.turn, 4).set
                        power% = 0
                        If config.snd Then
                            WAVPlay "power.wav"
                        End If
                        Do
                            key$ = InKey$
                            If KeyMark%(key$) = 5 Then Exit Do
                            Line (220 + power%, 5)-(220 + power%, 6), 200 + power% / 3
                            power% = power% + 1
                            For z& = -32000 To 32000
                            Next z&
                            If power% = 60 Then Exit Do
                        Loop
                        Line (220, 5)-(280, 6), 0, BF
                        power% = maxpower% * (power% / 60)
                        For i% = 1 To playpack(level.turn, 4).set
                            InitBullet 4, player(level.turn).x, player(level.turn).y, player(level.turn).a - ((1 / playpack(level.turn, 4).set - 1) * .05) + ((i% - 1) * .1), player(level.turn).dir, power%, playpack(level.turn, 4).set
                            DrawSpr player(level.turn).x, player(level.turn).y, 4
                        Next i%
                        If config.snd Then
                            WAVPlay "launch.wav"
                        End If
                        level.fire = 1
                    Else
                        If config.snd Then
                            WAVPlay "buzzer.wav"
                        End If
                    End If
                End If

                If player(level.turn).bul = 5 Then
                    If playpack(level.turn, 5).ammo > 0 Then
                        playpack(level.turn, 5).ammo = playpack(level.turn, 5).ammo - 1
                        If config.snd Then
                            WAVPlay "flamer.wav"
                        End If
                        For i% = 1 To 20
                            For a# = -.5 * (4 - playpack(level.turn, 5).set) To .5 * (4 - playpack(level.turn, 5).set) Step .05
                                For r! = 0 To 1 Step .01 * (4 - playpack(level.turn, 5).set)
                                    rr! = r! * 15 * playpack(level.turn, 5).set * (1 - Abs(a# / (.5 * (4 - playpack(level.turn, 5).set))))
                                    c% = (1 - r! / 1) * 16 + 202 + Rnd * 4 - 2
                                    If i% = 20 Then c% = 241
                                    fx% = player(level.turn).x - 1 + 4 * (player(level.turn).dir + 1) + Cos(a#) * rr! * player(level.turn).dir
                                    fy% = player(level.turn).y + 4 + Sin(a#) * rr!
                                    TPset fx%, fy%, 241
                                    If c% = 241 Then
                                        c% = BPoint%(fx%, fy%, 0)
                                    End If
                                    PSet (fx%, fy%), c%
                                Next r!
                            Next a#
                        Next i%
                        For pn% = 1 To maxplayers%
                            If player(pn%).health > 0 And pn% <> level.turn Then
                                If Abs(player(pn%).y - player(level.turn).y) <= 7 Then
                                    If player(level.turn).dir * (player(pn%).x - player(level.turn).x) > 0 And player(level.turn).dir * (player(pn%).x - player(level.turn).x) <= playpack(level.turn, 5).set * 15 Then
                                        ph% = 5000 * (1 / (player(level.turn).dir * (player(pn%).x - player(level.turn).x)) ^ 2)
                                        If ph% > 50 Then ph% = 50
                                        Damage pn%, ph%
                                    End If
                                End If
                            End If
                        Next pn%
                        level.fire = 1
                        level.nofly = 0
                    Else
                        If config.snd Then
                            WAVPlay "buzzer.wav"
                        End If
                    End If
                End If

                If player(level.turn).bul = 7 Then
                    If playpack(level.turn, 7).ammo > 0 Then
                        playpack(level.turn, 7).ammo = playpack(level.turn, 7).ammo - 1
                        power% = 0
                        If config.snd Then
                            WAVPlay "power.wav"
                        End If
                        Do
                            key$ = InKey$
                            If KeyMark%(key$) = 5 Then Exit Do
                            Line (220 + power%, 5)-(220 + power%, 6), 200 + power% / 3
                            power% = power% + 1
                            For z& = -32000 To 32000
                            Next z&
                            If power% = 60 Then Exit Do
                        Loop
                        Line (220, 5)-(280, 6), 0, BF
                        power% = maxpower% * (power% / 60)
                        InitBullet 7, player(level.turn).x, player(level.turn).y, player(level.turn).a, player(level.turn).dir, power%, playpack(level.turn, 7).set
                        DrawSpr player(level.turn).x, player(level.turn).y, 7
                        If config.snd Then
                            WAVPlay "launch.wav"
                        End If
                        level.fire = 1
                    Else
                        If config.snd Then
                            WAVPlay "buzzer.wav"
                        End If
                    End If
                End If

                DrawBar
            End If

        Case 6
            If player(level.turn).glued = 0 Then
                If player(level.turn).jump > 0 Then
                    If player(level.turn).bul = 6 Then
                        If playpack(level.turn, 6).ammo > 0 Then
                            player(level.turn).jump = 2
                            playpack(level.turn, 6).ammo = playpack(level.turn, 6).ammo - 1
                            If config.snd Then
                                WAVPlay "booster.wav"
                            End If
                            DrawBar
                        Else
                            If config.snd Then
                                WAVPlay "buzzer.wav"
                            End If
                            GoTo nojump
                        End If
                    Else
                        GoTo nojump
                    End If
                Else
                    player(level.turn).jump = 1
                    If config.snd Then
                        WAVPlay "jump.wav"
                    End If
                End If
                player(level.turn).xi = player(level.turn).x
                player(level.turn).yi = player(level.turn).y
                player(level.turn).aj = player(0).aj
                player(level.turn).pj = player(0).pj
                player(level.turn).tim = Timer - .1
                t# = (Timer - player(level.turn).tim) * bulletspd%
                ErasePlayer level.turn
                player(level.turn).x = player(level.turn).xi + t# * Cos(player(level.turn).aj) * player(level.turn).pj * player(level.turn).dir
                player(level.turn).y = player(level.turn).yi + t# * Sin(player(level.turn).aj) * player(level.turn).pj + 16 * t# ^ 2
                DrawPlayer level.turn
                nojump:
            End If

        Case 7, 8, 9
            playpack(level.turn, player(level.turn).bul).set = k% - 6
            DrawBar
            If config.snd Then
                WAVPlay "menua.wav"
            End If

        Case 10
            level.quit = 1

        Case 11
            level.fire = 1

        Case 12 TO 11 + maxweapons%
            player(level.turn).bul = k% - 11
            DrawBar
            If config.snd Then
                WAVPlay "menub.wav"
            End If

    End Select
End Sub

Sub SetBlastPal
    'Sets the fire palette.

    For c% = 200 To 220
        s% = (210 - c%) / 10 * pal(1).r
        If s% < 0 Then s% = 0
        rr% = (c% - 200) * 124 / 20 + s%
        If rr% < 0 Then rr% = 0
        If rr% > 62 Then rr% = 62
        gamepal(c%).r = rr%
        s% = (210 - c%) / 10 * pal(1).g
        If s% < 0 Then s% = 0
        gg% = (c% - 200) * 60 / 20 + s%
        If gg% < 0 Then gg% = 0
        If gg% > 62 Then gg% = 62
        gamepal(c%).g = gg%
        s% = (210 - c%) / 10 * pal(1).B
        If s% < 0 Then s% = 0
        bb% = -40 + (c% - 200) * 80 / 20 + s%
        If bb% < 0 Then bb% = 0
        If bb% > 62 Then bb% = 62
        gamepal(c%).B = bb%
    Next c%
End Sub


Sub DoTitle
    'Displays the title screen.

    Dim s As String * 1

    Open "title.pal" For Binary As #1
    For i% = 0 To 255
        Get #1, , s
        r% = Asc(s)
        Get #1, , s
        g% = Asc(s)
        Get #1, , s
        B% = Asc(s)
        gamepal(i%).r = r%
        gamepal(i%).g = g%
        gamepal(i%).B = B%
    Next i%
    Close #1
    Palette 0, 0

    If config.snd > 0 Then
        WAVPlay "title1.wav"
    End If
    Def Seg = &HA000
    BLoad "title.img", 0
    Def Seg
    For i% = 0 To 100
        key$ = InKey$
        If key$ = Chr$(13) Then GoTo donetitle1
        FadePal 0, 0, 0, i%, 0, 255
        Delay 0.05
    Next i%
    donetitle1:
    If config.snd > 0 Then
        WAVPlay "title2.wav"
    End If
    For i% = 0 To 100
        key$ = InKey$
        If key$ = Chr$(13) Then GoTo donetitle2
        c% = Rnd * 100
        FadePal 40, 50, 60, c%, 0, 255
    Next i%
    FadePal 0, 0, 0, 100, 0, 255
    Pause
    donetitle2:
End Sub

Function TPoint% (tx%, ty%, pn%)
    'Returns the pixel on the turf map to see if a collision occured.
    '(241 represents a pixel of sky)
    'tx% and ty% are the coordinates.
    'pn% is the number of player who is being "looked behind" (1-4) or
    '0 if it is a bullet sprite and you want to be able to "see" all the players.
    'You can also use -1 to not see any players.

    pp% = 241
    If tx% >= 0 And tx% <= 319 And ty% >= 0 And ty% <= 199 Then
        Def Seg = VarSeg(turfbuf(0))
        pp% = Peek(tx% + 320& * ty% + 4)
        Def Seg
        For i% = 1 To maxplayers%
            If player(i%).health > 0 And pn% <> i% And pn% <> -1 Then
                If tx% >= player(i%).x And tx% <= player(i%).x + 7 And ty% >= player(i%).y And ty% <= player(i%).y + 7 Then
                    pp% = playerspr((player(i%).dir - 1) * -3.5 + player(i%).dir * (tx% - player(i%).x) + 8 * (ty% - player(i%).y))
                    If pp% = -1 Then
                        pp% = team(player(i%).tnum).clr
                    ElseIf pp% = -10 Then
                        If player(i%).dir = 1 Then
                            pp% = 25 - Int((tx% - player(i%).x) / 2)
                        Else
                            pp% = 25 - Int((7 - (tx% - player(i%).x)) / 2)
                        End If
                    End If
                    If pp% > 0 Then
                        If player(i%).glued > 0 Then pp% = 92
                    Else
                        pp% = 241
                    End If
                    For ii% = 0 To gunlen%
                        x% = player(i%).x + 3 + (1 - player(i%).dir) / 2 + Cos(player(i%).a) * ii% * player(i%).dir
                        y% = player(i%).y + 4 + Sin(player(i%).a) * ii%
                        If tx% = x% And ty% = y% Then pp% = 25
                    Next ii%
                End If
            End If
        Next i%
    End If
    TPoint% = pp%
End Function

Sub TPset (tx%, ty%, tp%)
    'PSETs to the turf map.

    If tx% >= 0 And tx% <= 319 And ty% >= 0 And ty% <= 199 Then
        Def Seg = VarSeg(turfbuf(0))
        Poke tx% + 320& * ty% + 4, tp%
        Def Seg
    End If
End Sub

Function TurfBump$ (tx%, ty%, pn%)
    'Checks collision with turf map and bounces the sprite accordingly.
    'tx% and ty% are the coordinates of the sprite.
    'pn% is the number of player who is being "looked behind" (1-4) or
    '0 if it is a bullet sprite and you want to be able to "see" all the players.
    'You can also use -1 to not see any players.

    bstr$ = "00000000"
    For cy% = ty% + 1 To ty% + 3
        If TPoint%(tx%, cy%, pn%) <> 241 Then
            Mid$(bstr$, 8) = "1"
        End If
    Next cy%
    For cy% = ty% + 4 To ty% + 6
        If TPoint%(tx%, cy%, pn%) <> 241 Then
            Mid$(bstr$, 7) = "1"
        End If
    Next cy%
    For cy% = ty% + 1 To ty% + 3
        If TPoint%(tx% + 7, cy%, pn%) <> 241 Then
            Mid$(bstr$, 3) = "1"
        End If
    Next cy%
    For cy% = ty% + 4 To ty% + 6
        If TPoint%(tx% + 7, cy%, pn%) <> 241 Then
            Mid$(bstr$, 4) = "1"
        End If
    Next cy%
    For cx% = tx% To tx% + 3
        If TPoint%(cx%, ty%, pn%) <> 241 Then
            Mid$(bstr$, 1) = "1"
        End If
    Next cx%
    For cx% = tx% + 4 To tx% + 7
        If TPoint%(cx%, ty%, pn%) <> 241 Then
            Mid$(bstr$, 2) = "1"
        End If
    Next cx%
    For cx% = tx% To tx% + 3
        If TPoint%(cx%, ty% + 7, pn%) <> 241 Then
            Mid$(bstr$, 6) = "1"
        End If
    Next cx%
    For cx% = tx% + 4 To tx% + 7
        If TPoint%(cx%, ty% + 7, pn%) <> 241 Then
            Mid$(bstr$, 5) = "1"
        End If
    Next cx%

    TurfBump$ = bstr$
End Function

Function TurfHit% (tb%, tx%, ty%)
    'Checks collision with turf map of a sprite.
    'tb% is the sprite number.
    'tx% and ty% are the coordinates of the sprite.

    hit% = 0
    For cx% = tx% To tx% + 7
        For cy% = ty% To ty% + 7
            cp% = ammospr(tb%, cx% - tx% + 8 * (cy% - ty%))
            If cp% <> 0 Then
                If TPoint%(cx%, cy%, level.turn) <> 241 Then
                    hit% = 1
                    GoTo donehit
                End If
            End If
        Next cy%
    Next cx%
    donehit:
    TurfHit% = hit%
End Function


Sub Win (pnum%)
    'Displays winning screen.
    'pnum% = team number that won. (Can be 0 if everyone died)

    If pnum% = 0 Then
        l$ = "Nobody wins!"
        If config.snd Then
            WAVPlay "lose.wav"
        End If
        c% = 23
    Else
        l$ = RTrim$(team(pnum%).nam) + " wins!"
        If config.snd Then
            WAVPlay "win.wav"
        End If
        c% = team(pnum%).clr
    End If
    Line (30, 90)-(290, 110), c%, B
    DrawFont l$, 160 - Len(l$) * 4, 95, 1, 1, 3, 24
    Pause
    For c% = 100 To 0 Step -1
        FadePal 0, 0, 0, c%, 0, 255
    Next c%
End Sub


' a740g: This single function takes care of caching & playing all sample based audio
Sub WAVPlay (filename As String)
    Dim As Long i, l, u

    l = LBound(sndMgr)
    u = UBound(sndMgr)

    ' Check if file is there in the sound manager array
    For i = l To u
        ' Check if filename is found
        If sndMgr(i).act And sndMgr(i).nam = filename Then
            ' Play the sound if it is not playing
            If Not SndPlaying(sndMgr(i).hnd) Then
                ' Replay the sound
                SndPlay sndMgr(i).hnd
            End If
            ' Exit
            Exit Sub
        End If
    Next

    ' So file is not there. We need to resize the sound manager array and load the sound
    ' Check if the last slot is used
    If sndMgr(u).act Then
        ' Expand the array preserving the contents
        u = u + 1
        ReDim Preserve sndMgr(l To u) As sndMgrType
    End If
    i = u

    ' Save sound file details
    sndMgr(i).act = TRUE
    sndMgr(i).nam = filename
    ' Open the sound file and save the handle
    sndMgr(i).hnd = SndOpen("sound\" + filename)

    ' Play the file
    SndPlay sndMgr(i).hnd
End Sub

