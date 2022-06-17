'CHDIR ".\samples\pete\simpire"

' ²±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±²
' ² Simpire Beta                    ²
' ²±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±²
' By Pyrus, Polarris@worldnet.att.net
' E-mail me with comments or suggestions.
'
' A strategy-type game in QuickBasic.
'
' You may will out of string space or memory in Qbasic 1.1,
' but this does work in Quickbasic 4.5. I would compile it, but
' it gets alot of errors...
'
' Some of the unfinished features in the beta are that
' you cannot battle another city, you cannot load a custom
' map yet, and sound has not been added. Also, the gold mine
' needs it's options programmed. You must go down to the CHDIR
' command and change it to the directory the program is in.
' I also need to make the small map update it's self.
'
' To gain citizens, build houses and Townhalls. To gain gold,
' you cut down trees and trade them for gold or by assassinating
' another city leader. To get more soldiers, you trade gold
' for them. Use the arror keys to scroll, and S to select menu
' items.

' For speed
DefInt A-Z
' Declare subroutines and functions
DECLARE SUB printFX (text AS STRING)
DECLARE SUB menu ()
DECLARE FUNCTION CheckForVillage! ()
DECLARE SUB talkwin (text$, text2$, text3$, text4$, text5$, text6$, text7$, text8$, more%)
DECLARE SUB viewspr (filename$)
DECLARE SUB loadpal ()
DECLARE SUB changeanim ()
DECLARE SUB InitVars ()
DECLARE SUB LoadTiles ()
DECLARE SUB LoadWorld ()
DECLARE SUB ShowMap ()
DECLARE SUB MoveDown ()
DECLARE SUB MoveLeft ()
DECLARE SUB MoveRight ()
DECLARE SUB MoveUp ()
DECLARE SUB PutPlayerPic ()
DECLARE SUB PutTile (Ico, Jco, mapno)
DECLARE SUB LoadTile (Array())
DECLARE SUB jfont (a$, C, XCoordinate, YCoordinate, size)
DECLARE SUB PutCursorPic (cursor%)
DECLARE SUB Delay (seconds!)
DefInt A-Z

' Some TYPES
Type WorldDataType
    Rows As Integer
    Cols As Integer
    TopRow As Integer
    TopCol As Integer
    Action As Integer
    AnimCycle As Integer
    Direc As Integer
    PlayerY As Integer
End Type

Type MapType
    tile As Integer
    WalkOn As Integer
End Type

Type HUES
    Red As Integer
    grn As Integer
    blu As Integer
End Type


' Define some Constants
Const North = 1, South = 2, East = 3, West = 4
Const true = -1, false = 0

' DIM Some Varibles
' "640K Ought to be enough for anyone" -Bill Gates'
Dim Shared charset(128, 8, 6) 'array for storing font information
Dim Shared WorldData As WorldDataType
Dim Shared map(-7 To 70, -7 To 62) As MapType
Dim ColPal As String * 768
Dim ColPal2 As String * 768
Dim NewPal As String * 768
Dim Shared fontcolor$
Dim Shared gold%
Dim Shared wood%


' DIM the tile set
DIM SHARED ruble(205), stump(205), grass(205), water(205), Tree(205), stone(205), blank(205), ushore(205), dshore(205), lshore(205), rshore(205), tlshore(205), trshore(205), blshore(205), brshore(205), itlshore(205), itrshore(205), iblshore(205),  _
ibrshore(205), cpath(205)
Dim Shared farm.topleft(205), farm.topright(205), castle.topleft(205), castle.topright(205), townhall.topleft(205), townhall.topright(205), civil.topleft(205), civil.topright(205)
Dim Shared farm.bottomleft(205), farm.bottomright(205), castle.bottomleft(205), castle.bottomright(205), townhall.bottomleft(205), townhall.bottomright(205), civil.bottomleft(205), civil.bottomright(205)
Dim Shared goldiconmask(205), goldicon(205)
Dim Shared woodiconmask(205), woodicon(205)
Dim Shared mine.topleft(205), mine.topright(205), mine.bottomleft(205), mine.bottomright(205)
Dim Shared enemy.knight(205), path(205)

'DIM the cursor
Dim Shared cursor(205), cursor02(205), cursormask(205), cursor02mask(205)
Dim Shared woodtext(1050), bricktext(1050), cursor2(205), cursor2mask(205), cursor3mask(305), cursor3(305)

' DIM a few other graphics
Dim Shared smallmap(9000), woodtextmini(205)
Dim Shared person.consultor(805), person.ninja(805), person.other(805), person.snow(805), person.mean(805)

' Define some keys
upkey$ = Chr$(0) + "H"
downkey$ = Chr$(0) + "P"
RightKey$ = Chr$(0) + Chr$(77)
LeftKey$ = Chr$(0) + Chr$(75)
F1$ = Chr$(0) + Chr$(59)
F2$ = Chr$(0) + Chr$(60)
F3$ = Chr$(0) + Chr$(61)
F4$ = Chr$(0) + Chr$(62)
F5$ = Chr$(0) + Chr$(63)
F6$ = Chr$(0) + Chr$(64)
F7$ = Chr$(0) + Chr$(65)
F8$ = Chr$(0) + Chr$(66)
F9$ = Chr$(0) + Chr$(67)
F10$ = Chr$(0) + Chr$(68)
F11$ = Chr$(0) + Chr$(69)
CtrlRight$ = Chr$(0) + Chr$(116)
CtrlLeft$ = Chr$(0) + Chr$(115)
enter$ = Chr$(13)

' 320x200 with 256 color Resolution
Screen 13
printFX "By Pyrus"
Play "T160O0L32EF"
Do
    x$ = InKey$
Loop Until x$ = " " Or x$ = Chr$(13)

' Load Custom Palette
loadpal

' Load Custom Font
Open "fontdata.dat" For Input As #1
For a = 1 To 126
    For x = 1 To 8
        For y = 1 To 6
            Input #1, B
            charset(a, x, y) = B
        Next y
    Next x
Next a
Close

' Loads graphic tile set
Call LoadTiles
Dim title(5000)
Dim titlemask(5000)
viewspr ("title.spr")
Get (1, 1)-(119, 39), title()
Get (1, 40)-(119, 79), titlemask()
Cls

' intro and title screen
For y = 0 To 180 Step 20
    For x = 0 To 300 Step 20
        Put (x, y), bricktext(), PSet
    Next
Next

Put (95, 15), titlemask(), And
Put (95, 15), title(), Or
Call jfont("v1.0", 15, 220, 30, 1)


Line (95, 50)-(215, 140), 0, BF
Line (95, 50)-(215, 140), 112, B
Call jfont("Begin Simpire", 2, 117, 65, 1)
Call jfont("Load Custom Map", 15, 111, 75, 1)
Call jfont("Options", 15, 135, 85, 1)
Call jfont("Help", 15, 144, 95, 1)
Call jfont("About", 15, 142, 105, 1)
Call jfont("Quit to Dos", 15, 124, 115, 1)
sel = 1
Dim tempimg(8200)

menu:

Do
    x$ = InKey$

Loop Until x$ = upkey$ Or x$ = downkey$ Or x$ = Chr$(13)

If x$ = Chr$(13) Then

    If sel = 6 Then
        For T = 1 To 84 Step 4
            Delay .0009
            Line (0, 0)-(T, 200), 0, BF
            Line (80, 0)-(80 + T, 200), 0, BF
            Line (160, 0)-(160 + T, 200), 0, BF
            Line (240, 0)-(240 + T, 200), 0, BF
        Next
        Cls
        End
    End If


    If sel = 1 Then GoTo start

    If sel = 2 Then
        Get (30, 50)-(291, 111), tempimg()
        Line (30, 50)-(291, 111), 0, BF
        Line (30, 50)-(291, 111), 112, B
        For x = 1 To 260 Step 20
            Put (30 + x, 51), woodtextmini(), PSet
            Put (30 + x, 71), woodtextmini(), PSet
            Put (30 + x, 91), woodtextmini(), PSet
        Next
        Line (40, 60)-(81, 99), 0, BF
        Put (41, 60), person.snow(), PSet
        Line (40, 60)-(81, 99), 112, B
        Line (90, 60)-(278, 100), 0, BF
        Line (90, 60)-(278, 100), 112, B
        Call jfont("This feature is not ready yet.", 15, 95, 61, 1)
        Call jfont("", 2, 95, 71, 1)
        Call jfont("", 2, 95, 81, 1)
        Call jfont("Press Enter", 15, 95, 91, 1)
        Do
            x$ = InKey$
        Loop Until x$ = Chr$(13)
        Put (30, 50), tempimg(), PSet
        Erase tempimg
    End If

    If sel = 3 Then
        Get (30, 50)-(291, 111), tempimg()
        Line (30, 50)-(291, 111), 0, BF
        Line (30, 50)-(291, 111), 112, B
        For x = 1 To 260 Step 20
            Put (30 + x, 51), woodtextmini(), PSet
            Put (30 + x, 71), woodtextmini(), PSet
            Put (30 + x, 91), woodtextmini(), PSet
        Next
        Line (40, 60)-(81, 99), 0, BF
        Put (41, 60), person.ninja(), PSet
        Line (40, 60)-(81, 99), 112, B
        Line (90, 60)-(278, 100), 0, BF
        Line (90, 60)-(278, 100), 112, B
        Call jfont("What kind of sound do you want?", 15, 95, 61, 1)
        Call jfont("I want Adlib Compable.", 2, 95, 71, 1)
        Call jfont("I want PC Speaker.", 15, 95, 81, 1)
        Call jfont("Press Enter when done", 15, 95, 91, 1)
        sel = 1
        options:
        Do
            x$ = InKey$
        Loop Until x$ = Chr$(13) Or x$ = upkey$ Or x$ = downkey$

        If x$ = downkey$ Then sel = sel + 1
        If x$ = upkey$ Then sel = sel + 1

        If sel = 3 Then sel = 1
        If sel = 0 Then sel = 2

        Call jfont("I want Adlib Compable.", 15, 95, 71, 1)
        Call jfont("I want PC Speaker.", 15, 95, 81, 1)

        If sel = 1 Then Call jfont("I want Adlib Compable.", 2, 95, 71, 1)
        If sel = 2 Then Call jfont("I want PC Speaker.", 2, 95, 81, 1)

        If x$ = Chr$(13) Then

            If sel = 1 Then
                Call talkwin("This feature has not been added yet.", "", "", "", "", "", "", "", 2)
            End If

            If sel = 2 Then
                Call talkwin("This feature has not been added yet.", "", "", "", "", "", "", "", 2)
            End If

            Put (30, 50), tempimg(), PSet
            Erase tempimg
            sel = 3
            GoTo donesound
        End If

        GoTo options

        donesound:
    End If

    If sel = 4 Then
        Get (30, 50)-(291, 111), tempimg()
        Line (30, 50)-(291, 111), 0, BF
        Line (30, 50)-(291, 111), 112, B
        For x = 1 To 260 Step 20
            Put (30 + x, 51), woodtextmini(), PSet
            Put (30 + x, 71), woodtextmini(), PSet
            Put (30 + x, 91), woodtextmini(), PSet
        Next
        Line (40, 60)-(81, 99), 0, BF
        Put (41, 60), person.mean(), PSet
        Line (40, 60)-(81, 99), 112, B
        Line (90, 60)-(278, 100), 0, BF
        Line (90, 60)-(278, 100), 112, B
        Call jfont("How to play.", 15, 95, 61, 1)
        Call jfont("Arror keys control scrolling.", 2, 95, 71, 1)
        Call jfont("S controls the menu.", 2, 95, 81, 1)
        Call jfont("Press Enter", 15, 95, 91, 1)
        sel = 1
        Do
            x$ = InKey$
        Loop Until x$ = Chr$(13)
        Put (30, 50), tempimg(), PSet
        Erase tempimg
        sel = 4
    End If

    If sel = 5 Then
        Get (30, 50)-(291, 111), tempimg()
        Line (30, 50)-(291, 111), 0, BF
        Line (30, 50)-(291, 111), 112, B
        For x = 1 To 260 Step 20
            Put (30 + x, 51), woodtextmini(), PSet
            Put (30 + x, 71), woodtextmini(), PSet
            Put (30 + x, 91), woodtextmini(), PSet
        Next
        Line (40, 60)-(81, 99), 0, BF
        Put (41, 60), person.other(), PSet
        Line (40, 60)-(81, 99), 112, B
        Line (90, 60)-(278, 100), 0, BF
        Line (90, 60)-(278, 100), 112, B
        Call jfont("Simpire v1.0", 15, 95, 61, 1)
        Call jfont("By Pyrus of WinterScape", 2, 95, 71, 1)
        Call jfont("Polarris@worldnet.att.net", 2, 95, 81, 1)
        Call jfont("Press Enter", 15, 95, 91, 1)
        Do
            x$ = InKey$
        Loop Until x$ = Chr$(13)
        Put (30, 50), tempimg(), PSet
        Erase tempimg
    End If



End If




If x$ = downkey$ Then sel = sel + 1
If x$ = upkey$ Then sel = sel - 1

If sel = 0 Then sel = 6
If sel = 7 Then sel = 1
Call jfont("Begin Simpire", 15, 117, 65, 1)
Call jfont("Load Custom Map", 15, 111, 75, 1)
Call jfont("Options", 15, 135, 85, 1)
Call jfont("Help", 15, 144, 95, 1)
Call jfont("About", 15, 142, 105, 1)
Call jfont("Quit to Dos", 15, 124, 115, 1)

If sel = 1 Then Call jfont("Begin Simpire", 2, 117, 65, 1)
If sel = 2 Then Call jfont("Load Custom Map", 2, 111, 75, 1)
If sel = 3 Then Call jfont("Options", 2, 135, 85, 1)
If sel = 4 Then Call jfont("Help", 2, 144, 95, 1)
If sel = 5 Then Call jfont("About", 2, 142, 105, 1)
If sel = 6 Then Call jfont("Quit to Dos", 2, 124, 115, 1)

GoTo menu

start:
' Start Up Subs
Call InitVars
Call LoadWorld
Call menu

' A few other im[porrtant varibles
selct% = 1: menutitle% = 1:
abletotrade% = 1: gold% = 20: wood% = 20


' Makes the begining main menu
Line (5, 60)-(56, 152), 0, BF
Line (5, 60)-(56, 152), 112, B
Line (5, 72)-(56, 72), 112
Call jfont("Menu:", 15, 7, 62, 1)
Call jfont("Build", 2, 7, 75, 1)
Call jfont("Destroy", 15, 7, 85, 1)
Call jfont("Attack", 15, 7, 95, 1)
Call jfont("Trade", 15, 7, 105, 1)
Call jfont("Status", 15, 7, 115, 1)
Call jfont("Quit", 15, 7, 125, 1)

' Prints how much gold and wood you have
Color 15
Locate 21, 4: Print gold%
Locate 23, 4: Print wood%

' Show the map
Call ShowMap
Call PutCursorPic(1)
                                            
' Startup Message
startup:
Call talkwin("Welcome to this demo of Simpire. Feel free to", "build a city. If you can achieve a population", "of 100 citizens, you will win.", "", "", "", "", "", 2)

' Starts the main loop
again:

' Checks if you have reached your goal
If poplation% >= 100 Then
    Call talkwin("You achieved a population of 100 citizens.", "Very good job.", "", "", "", "", "", "", 2)
    Cls
    End
End If

' Prints how much gold and wood you have
Locate 21, 4: Print gold%
Locate 23, 4: Print wood%

' Starts a loop that waits for keys
Do
    x$ = InKey$
Loop Until x$ = "d" Or x$ = "D" Or x$ = "p" Or x$ = "P" Or x$ = "q" Or x$ = "Q" Or x$ = enter$ Or x$ = "s" Or x$ = "S" Or x$ = Chr$(27) Or x$ = Chr$(0) + "H" Or x$ = Chr$(0) + "P" Or x$ = Chr$(0) + "K" Or x$ = Chr$(0) + "M"


' Determines what key you pressed

If x$ = "d" Or x$ = "D" Then

    If destroy% = 0 Then GoTo nokill

    If destroy% = 1 Then

        If map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 41 Then
            map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 2
            destroy% = 0:
            GoTo donedes
        End If


        If map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 4 Then
            map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 3
            destroy% = 0: wood% = wood% + 1
            If wood% >= 99 Then wood% = 99
            GoTo donedes
        End If

        If map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 5 Then
            map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 2:
            destroy% = 0
        End If

        If map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 18 Or map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 20 Or map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 23 Or map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 25 Then
            map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 1
            map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile = 1
            map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile = 1
            map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile = 1
            destroy% = 0
        End If

        If map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 19 Or map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 21 Or map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 24 Or map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 26 Then
            map(WorldData.TopCol + 7, WorldData.TopRow + 5).tile = 1
            map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 1
            map(WorldData.TopCol + 7, WorldData.TopRow + 6).tile = 1
            map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile = 1
            destroy% = 0
        End If

        If map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 27 Or map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 29 Or map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 32 Or map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 34 Then
            map(WorldData.TopCol + 8, WorldData.TopRow + 4).tile = 1
            map(WorldData.TopCol + 9, WorldData.TopRow + 4).tile = 1
            map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 1
            map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile = 1
            destroy% = 0
        End If

        If map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 28 Or map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 30 Or map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 33 Or map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 35 Then
            map(WorldData.TopCol + 7, WorldData.TopRow + 4).tile = 1
            map(WorldData.TopCol + 8, WorldData.TopRow + 4).tile = 1
            map(WorldData.TopCol + 7, WorldData.TopRow + 5).tile = 1
            map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 1
            destroy% = 0
        End If

    End If

    donedes:
    Call ShowMap

    nokill:

End If

If x$ = "p" Or x$ = "P" Then

    If wantbuild% = 0 Then GoTo noplace
    If buildtoplace% = 0 Then GoTo noplace

    If canbuild% = 1 Then

        If gold% >= 5 And wood% >= 5 Then
            If buildtoplace% = 1 Then
                map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 18
                map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile = 19
                map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile = 27
                map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile = 28
                Call ShowMap
                typ% = 1: Call PutCursorPic(typ%)
                farms% = farms% + 1
                poplation% = poplation% + 1
                wantbuild% = 0
                gold% = gold% - 5
                wood% = wood% - 5
            End If
        End If

        If gold% >= 15 And wood% >= 15 Then
            If buildtoplace% = 2 Then
                map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 20
                map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile = 21
                map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile = 29
                map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile = 30
                Call ShowMap
                typ% = 1: Call PutCursorPic(typ%)
                wantbuild% = 0
                gold% = gold% - 15
                wood% = wood% - 15
                castle% = castle% + 1
                soldiers% = soldiers% + 5
            End If
        End If

        If gold% >= 15 And wood% >= 15 Then
            If buildtoplace% = 3 Then
                map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 23
                map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile = 24
                map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile = 32
                map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile = 33
                Call ShowMap
                typ% = 1: Call PutCursorPic(typ%)
                wantbuild% = 0
                gold% = gold% - 15
                wood% = wood% - 15
                townhall% = townhall% + 1
                poplation% = poplation% + 10
            End If
        End If

        If gold% >= 5 And wood% >= 5 Then
            If buildtoplace% = 4 Then
                map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 25
                map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile = 26
                map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile = 34
                map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile = 35
                Call ShowMap
                typ% = 1: Call PutCursorPic(typ%)
                wantbuild% = 0
                gold% = gold% - 5
                wood% = wood% - 5
                house% = house% + 1
                poplation% = poplation% + 3
            End If

        End If

        If gold% >= 1 And wood% >= 1 Then
            If buildtoplace% = 5 Then
                map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 41
                Call ShowMap
                typ% = 1: Call PutCursorPic(typ%)
                wantbuild% = 0
                gold% = gold% - 1
                wood% = wood% - 1
                numofspac% = 0
            End If
        End If

        If gold% >= 1 And wood% >= 1 Then
            If buildtoplace% = 6 Then
                map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 4
                Call ShowMap
                typ% = 1: Call PutCursorPic(typ%)
                wantbuild% = 0
                gold% = gold% - 1
                wood% = wood% - 1
                numofspac% = 0
            End If
        End If




    End If

    noplace:
End If

If x$ = "q" Or x$ = "Q" Then
    End
End If
  
If x$ = Chr$(0) + "H" Then
    Call MoveUp
End If

If x$ = Chr$(0) + "P" Then
    Call MoveDown
End If

If x$ = Chr$(0) + "K" Then
    Call MoveLeft
End If

If x$ = Chr$(0) + "M" Then
    Call MoveRight
End If

If x$ = "s" Or x$ = "S" Then
    selct% = selct% + 1

    selectmenu:
    If menutitle% = 1 Then
        If selct% = 7 Then selct% = 1
        Call jfont("Menu:", 15, 7, 62, 1)
        Call jfont("Build", 15, 7, 75, 1)
        Call jfont("Destroy", 15, 7, 85, 1)
        Call jfont("Attack", 15, 7, 95, 1)
        Call jfont("Trade", 15, 7, 105, 1)
        Call jfont("Status", 15, 7, 115, 1)
        Call jfont("Quit", 15, 7, 125, 1)

        If selct% = 1 Then Call jfont("Build", 2, 7, 75, 1)
        If selct% = 2 Then Call jfont("Destroy", 2, 7, 85, 1)
        If selct% = 3 Then Call jfont("Attack", 2, 7, 95, 1)
        If selct% = 4 Then Call jfont("Trade", 2, 7, 105, 1)
        If selct% = 5 Then Call jfont("Status", 2, 7, 115, 1)
        If selct% = 6 Then Call jfont("Quit", 2, 7, 125, 1)

    End If

    If menutitle% = 2 Then
        If selct% = 8 Then selct% = 1
        Call jfont("Build:", 15, 7, 62, 1)
        Call jfont("Farm", 15, 7, 75, 1)
        Call jfont("Castle", 15, 7, 85, 1)
        Call jfont("Townhall", 15, 7, 95, 1)
        Call jfont("House", 15, 7, 105, 1)
        Call jfont("Path", 15, 7, 115, 1)
        Call jfont("Tree", 15, 7, 125, 1)
        Call jfont("Exit", 15, 7, 135, 1)

        If selct% = 1 Then Call jfont("Farm", 2, 7, 75, 1)
        If selct% = 2 Then Call jfont("Castle", 2, 7, 85, 1)
        If selct% = 3 Then Call jfont("Townhall", 2, 7, 95, 1)
        If selct% = 4 Then Call jfont("House", 2, 7, 105, 1)
        If selct% = 5 Then Call jfont("Path", 2, 7, 115, 1)
        If selct% = 6 Then Call jfont("Tree", 2, 7, 125, 1)
        If selct% = 7 Then Call jfont("Exit", 2, 7, 135, 1)

    End If
End If

If x$ = enter$ Then

    If menutitle% = 1 And selct% = 1 Then
        selct% = 0
        menutitle% = 2
        Line (5, 60)-(56, 152), 0, BF
        Line (5, 60)-(56, 152), 112, B
        Line (5, 72)-(56, 72), 112
        GoTo selectmenu:
    End If

    If menutitle% = 1 And selct% = 6 Then
        Call talkwin("Thanks for Playing.", "", "", "", "", "", "", "", 2)
        For T = 1 To 84 Step 4
            Delay .0009
            Line (0, 0)-(T, 200), 0, BF
            Line (80, 0)-(80 + T, 200), 0, BF
            Line (160, 0)-(160 + T, 200), 0, BF
            Line (240, 0)-(240 + T, 200), 0, BF
        Next
        Cls
        System
    End If


    If menutitle% = 1 And selct% = 2 Then
        Call talkwin("Please select what you want to destory. Then", "press D.", "", "", "", "", "", "", 2)
        destroy% = 1
    End If

    If menutitle% = 1 And selct% = 5 Then
        Call talkwin("Welcome to the status menu.", "", "", "", "", "", "", "", 2)
        Line (80, 50)-(301, 111), 0, BF
        Line (80, 50)-(301, 111), 112, B
        For x = 1 To 220 Step 20
            Put (80 + x, 51), bricktext(), PSet
            Put (80 + x, 71), bricktext(), PSet
            Put (80 + x, 91), bricktext(), PSet
        Next
        Line (90, 55)-(131, 95), 0, BF
        Line (90, 55)-(131, 96), 112, B
        Put (91, 56), person.mean(), PSet

        Line (140, 55)-(290, 95), 0, BF
        Line (140, 55)-(290, 95), 112, B
        even% = Rnd * 9 + 1

        If even% = 1 And abletotrade% = 1 Then
            event1$ = "Snow Fall Blocks Trade."
            event2$ = ""
            Line (90, 55)-(131, 95), 0, BF
            Line (90, 55)-(131, 96), 112, B
            Put (91, 56), person.snow(), PSet
            abletotrade% = 0
        End If

        If even% = 2 Then
            event1$ = "Forigners cut down"
            event2$ = "many trees."
            p% = Rnd * 40
            For I = p% To p% + 10
                For J = p% To p% + 10
                    If map(J, I).tile = 4 Then map(J, I).tile = 3
                Next
            Next
        End If

        If even% = 3 Then
            event1$ = "You recive 5 gold!"
            event2$ = ""
            gold% = gold% + 5
            If gold% >= 99 Then gold% = 99
        End If

        If even% = 4 And abletotrade% = 0 Then
            event1$ = "The snowing stops."
            event2$ = ""
            abletotrade% = 1
            GoTo eventss
        End If

        If even% = 4 And abletotrade% = 1 Then
            event1$ = "3 new soldiers join"
            event2$ = "your army."
            soldiers% = soldiers% + 3
            If soldiers% >= 999 Then soldiers% = 999
        End If

        If even% >= 5 And even% <= 10 Then
            event1$ = "No new Events."
            event2$ = ""
        End If

        eventss:
        Call jfont("Important Events:", 15, 145, 56, 1)
        Call jfont(event1$, 2, 145, 66, 1)
        Call jfont(event2$, 2, 145, 76, 1)
        Call jfont("Press Enter", 15, 145, 86, 1)
        sel = 1

        statusmenu:

        Do
            x$ = InKey$
        Loop Until x$ = Chr$(13)

        If x$ = Chr$(13) Then
            Locate 21, 4: Print gold%
            Locate 23, 4: Print wood%

            Line (140, 55)-(290, 95), 0, BF
            Line (140, 55)-(290, 95), 112, B

            Call jfont("Population, Soldiers", 15, 145, 56, 1)
            Locate 10, 19: Print poplation%; ", "; soldiers%
            Call jfont("Press Enter to Exit", 15, 145, 86, 1)
            Do
                x$ = InKey$
            Loop Until x$ = Chr$(13)

        End If

    End If



    If menutitle% = 1 And selct% = 3 Then
        Call talkwin("Welcome to the attack menu.", "", "", "", "", "", "", "", 2)
        Line (80, 50)-(301, 111), 0, BF
        Line (80, 50)-(301, 111), 112, B
        attmenu:
        For x = 1 To 220 Step 20
            Put (80 + x, 51), bricktext(), PSet
            Put (80 + x, 71), bricktext(), PSet
            Put (80 + x, 91), bricktext(), PSet
        Next
        Line (90, 55)-(131, 95), 0, BF
        Put (91, 56), person.other(), PSet
        Line (90, 55)-(131, 95), 112, B


        Line (140, 55)-(290, 95), 0, BF
        Line (140, 55)-(290, 95), 112, B

        Call jfont("How you want to attack?", 15, 145, 56, 1)
        Call jfont("Battle a city.", 2, 145, 66, 1)
        Call jfont("Kill a city leader.", 15, 145, 76, 1)
        Call jfont("Exit attack", 15, 145, 86, 1)
        sel = 1

        attackmenu:

        Do
            x$ = InKey$
        Loop Until x$ = upkey$ Or x$ = downkey$ Or x$ = Chr$(13) Or x$ = "s" Or x$ = "S"

        If x$ = Chr$(13) Then
            If sel = 1 Then
                Call talkwin("This feature has not been added yet.", "", "", "", "", "", "", "", 2)
            End If
            If sel = 3 Then GoTo exitattack
            If sel = 2 Then GoTo assattack

        End If

        If x$ = upkey$ Then sel = sel - 1
        If x$ = downkey$ Then sel = sel + 1
        If x$ = "s" Or x$ = "S" Then sel = sel + 1
        If sel = 0 Then sel = 4
        If sel = 4 Then sel = 1
        Call jfont("How you want to attack?", 15, 145, 56, 1)
        Call jfont("Battle a city.", 15, 145, 66, 1)
        Call jfont("Kill a city leader.", 15, 145, 76, 1)
        Call jfont("Exit attack", 15, 145, 86, 1)

        If sel = 1 Then Call jfont("Battle a city.", 2, 145, 66, 1)
        If sel = 2 Then Call jfont("Kill a city leader.", 2, 145, 76, 1)
        If sel = 3 Then Call jfont("Exit attack", 2, 145, 86, 1)
        GoTo attackmenu

        assattack:
        Line (80, 50)-(301, 111), 0, BF
        Line (80, 50)-(301, 111), 112, B

        For x = 1 To 220 Step 20
            Put (80 + x, 51), bricktext(), PSet
            Put (80 + x, 71), bricktext(), PSet
            Put (80 + x, 91), bricktext(), PSet
        Next
        Line (90, 55)-(131, 95), 0, BF
        Line (90, 55)-(131, 96), 112, B
        Put (91, 56), person.ninja(), PSet

        Line (140, 55)-(290, 95), 0, BF
        Line (140, 55)-(290, 95), 112, B

        Call jfont("Are you sure?", 15, 145, 56, 1)
        Call jfont("Yes.", 2, 145, 66, 1)
        Call jfont("Exit kill menu", 15, 145, 86, 1)
        sel = 1

        assmenu:
        Locate 21, 4: Print gold%
        Locate 23, 4: Print wood%

        Do
            x$ = InKey$
        Loop Until x$ = upkey$ Or x$ = downkey$ Or x$ = Chr$(13) Or x$ = "s" Or x$ = "S"

        If x$ = Chr$(13) Then
            If sel = 1 Then
                kil% = Rnd * 9 + 1

                If kil% <= 4 Then
                    Call talkwin("You sucsessfully assassinated a city leader.", "You gain 10 gold, 10 wood, and 5 soldires.", "", "", "", "", "", "", 2)
                    gold% = gold% + 10
                    wood% = wood% + 10
                    If gold% >= 99 Then gold% = 99
                    If wood% >= 99 Then wood% = 99
                    soldiers% = soldiers% + 5
                End If

                If kil% >= 5 Then
                    Call talkwin("The assassination was not sucessful. The city", "demands at least 20 gold.", "", "", "", "", "", "", 2)
                    gold% = gold% - 20
                    If gold% <= 0 Then gold% = 0
                End If


            End If


            If sel = 2 Then GoTo attmenu
        End If

        If x$ = upkey$ Then sel = sel - 1
        If x$ = downkey$ Then sel = sel + 1
        If x$ = "s" Or x$ = "S" Then sel = sel + 1
        If sel = 0 Then sel = 2
        If sel = 3 Then sel = 1
        Call jfont("Are you sure?", 15, 145, 56, 1)
        Call jfont("Yes.", 15, 145, 66, 1)
        Call jfont("Exit kill menu", 15, 145, 86, 1)

        If sel = 1 Then Call jfont("Yes.", 2, 145, 66, 1)
        If sel = 2 Then Call jfont("Exit kill menu", 2, 145, 86, 1)
        GoTo assmenu






        exitattack:
    End If

    If menutitle% = 1 And selct% = 4 And abletotrade% = 0 Then
        Call talkwin("Snowfall blocks trade.", "", "", "", "", "", "", "", 2)
    End If


    If menutitle% = 1 And selct% = 4 And abletotrade% = 1 Then
        Call talkwin("Welcome to the trade menu.", "", "", "", "", "", "", "", 2)
        Line (80, 50)-(301, 111), 0, BF
        Line (80, 50)-(301, 111), 112, B

        For x = 1 To 220 Step 20
            Put (80 + x, 51), bricktext(), PSet
            Put (80 + x, 71), bricktext(), PSet
            Put (80 + x, 91), bricktext(), PSet
        Next
        Line (90, 55)-(131, 95), 0, BF
        Line (90, 55)-(131, 95), 112, B
        Put (91, 55), person.consultor(), PSet

        Line (140, 55)-(290, 95), 0, BF
        Line (140, 55)-(290, 95), 112, B

        Call jfont("What you want to trade?", 15, 145, 56, 1)
        Call jfont("10 wood for 5 gold.", 2, 145, 66, 1)
        Call jfont("5 gold for a soldiers.", 15, 145, 76, 1)
        Call jfont("Exit Trade", 15, 145, 86, 1)
        sel = 1

        trademenu:
        Locate 21, 4: Print gold%
        Locate 23, 4: Print wood%


        Do
            x$ = InKey$
        Loop Until x$ = upkey$ Or x$ = downkey$ Or x$ = Chr$(13) Or x$ = "s" Or x$ = "S"

        If x$ = Chr$(13) Then

            If sel = 3 Then GoTo exittrade

            If sel = 1 Then

                If wood% >= 10 Then
                    wood% = wood% - 10
                    gold% = gold% + 5
                    If gold% >= 99 Then gold% = 99
                    Call talkwin("You traded.", "", "", "", "", "", "", "", 2)
                    GoTo donesel2
                End If

                If wood% <= 9 Then
                    Call talkwin("You dont have enough wood.", "", "", "", "", "", "", "", 2)
                End If
                donesel2:
            End If

            If sel = 2 Then

                If gold% >= 5 Then
                    gold% = gold% - 5
                    soldiers% = soldiers% + 1
                    Call talkwin("You traded.", "", "", "", "", "", "", "", 2)
                    GoTo donesel1
                End If

                If gold% <= 4 Then
                    Call talkwin("You dont have enough gold.", "", "", "", "", "", "", "", 2)
                End If

            End If

            donesel1:

        End If

        If x$ = upkey$ Then sel = sel - 1
        If x$ = downkey$ Then sel = sel + 1
        If x$ = "s" Or x$ = "S" Then sel = sel + 1
        If sel = 0 Then sel = 4
        If sel = 4 Then sel = 1
        Call jfont("What you want to trade?", 15, 145, 56, 1)
        Call jfont("10 wood for 5 gold.", 15, 145, 66, 1)
        Call jfont("5 gold for a soldiers.", 15, 145, 76, 1)
        Call jfont("Exit Trade", 15, 145, 86, 1)

        If sel = 1 Then Call jfont("10 wood for 5 gold.", 2, 145, 66, 1)
        If sel = 2 Then Call jfont("5 gold for a soldiers.", 2, 145, 76, 1)
        If sel = 3 Then Call jfont("Exit Trade", 2, 145, 86, 1)
        GoTo trademenu

        exittrade:
    End If


    If menutitle% = 2 Then

        If selct% = 1 Then
            If gold% >= 5 And wood% >= 5 Then Call talkwin("Please select where you want to build a farm.", "Then press P.", "", "", "", "", "", "", 2): buildtoplace% = 1: typ% = 3: Call PutCursorPic(typ%): wantbuild% = 1
            If gold% <= 4 Or wood% <= 4 Then Call talkwin("You do not have enough gold or wood.", "", "", "", "", "", "", "", 2): wantbuild% = 0
        End If

        If selct% = 2 Then
            If gold% >= 15 And wood% >= 15 Then Call talkwin("Please select where you want to build a", "castle. Then press P.", "", "", "", "", "", "", 2): buildtoplace% = 2: typ% = 3: Call PutCursorPic(typ%): wantbuild% = 1
            If gold% <= 14 Or wood% <= 14 Then Call talkwin("You do not have enough gold or wood.", "", "", "", "", "", "", "", 2): wantbuild% = 0

        End If

        If selct% = 3 Then
            If gold% >= 15 And wood% >= 15 Then Call talkwin("Please select where you want to build a town", "hall. Then press P.", "", "", "", "", "", "", 2): buildtoplace% = 3: typ% = 3: Call PutCursorPic(typ%): wantbuild% = 1
            If gold% <= 14 Or wood% <= 14 Then Call talkwin("You do not have enough gold or wood.", "", "", "", "", "", "", "", 2): wantbuild% = 0
        End If

        If selct% = 4 Then
            If gold% >= 5 And wood% >= 5 Then Call talkwin("Please select where you want to build a house.", "Then press P.", "", "", "", "", "", "", 2): buildtoplace% = 4: typ% = 3: Call PutCursorPic(typ%): wantbuild% = 1
            If gold% <= 4 Or wood% <= 4 Then Call talkwin("You do not have enough gold or wood.", "", "", "", "", "", "", "", 2): wantbuild% = 0
        End If

        If selct% = 5 Then
            If gold% >= 1 And wood% >= 1 Then Call talkwin("Please select where you want to build a path", "segement. Then press P.", "", "", "", "", "", "", 2): buildtoplace% = 5: typ% = 3: Call PutCursorPic(typ%): wantbuild% = 1: numofspac% = 1
            If gold% <= 0 Or wood% <= 0 Then Call talkwin("You do not have enough gold or wood.", "", "", "", "", "", "", "", 2): wantbuild% = 0
        End If

        If selct% = 6 Then
            If gold% >= 1 And wood% >= 1 Then Call talkwin("Please select where you want to plant a Tree.", "Then press P.", "", "", "", "", "", "", 2): buildtoplace% = 6: typ% = 3: Call PutCursorPic(typ%): wantbuild% = 1: numofspac% = 1
            If gold% <= 0 Or wood% <= 0 Then Call talkwin("You do not have enough gold or wood.", "", "", "", "", "", "", "", 2): wantbuild% = 0
        End If

        If selct% = 7 Then
            menutitle% = 1
            selct% = 0
            Line (5, 60)-(56, 152), 0, BF
            Line (5, 60)-(56, 152), 112, B
            Line (5, 72)-(56, 72), 112
            Call jfont("Menu:", 15, 7, 62, 1)
            Call jfont("Build", 15, 7, 75, 1)
            Call jfont("Destroy", 15, 7, 85, 1)
            Call jfont("Attack", 15, 7, 95, 1)
            Call jfont("Trade", 15, 7, 105, 1)
            Call jfont("Status", 15, 7, 115, 1)
            Call jfont("Quit", 15, 7, 125, 1)
        End If




        okok:
    End If
End If

If x$ = Chr$(27) Then
    If wantbuild% = 1 Then wantbuild% = 0: GoTo noesx
    If destroy% = 1 Then destroy% = 0: GoTo noesx

    menutitle% = 1
    selct% = 0
    Line (5, 60)-(56, 152), 0, BF
    Line (5, 60)-(56, 152), 112, B
    Line (5, 72)-(56, 72), 112
    Call jfont("Menu:", 15, 7, 62, 1)
    Call jfont("Build", 15, 7, 75, 1)
    Call jfont("Destroy", 15, 7, 85, 1)
    Call jfont("Attack", 15, 7, 95, 1)
    Call jfont("Trade", 15, 7, 105, 1)
    Call jfont("Status", 15, 7, 115, 1)
    Call jfont("Quit", 15, 7, 125, 1)


    noesx:
End If

Call ShowMap

' Places an appropiate cursor

If destroy% = 1 Then

IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 3 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 2 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 1 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 37 OR map( _
WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 38 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 39 OR map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 40 THEN
        Call PutCursorPic(2)
        GoTo donecursor
    End If


    If map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile > 2 Or map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile < 1 Then
        Call PutCursorPic(3)
        GoTo donecursor
    End If

End If

If wantbuild% = 1 Then



    If numofspac% = 1 Then

        If map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile <= 3 Then
            Call PutCursorPic(3)
            canbuild% = 1
            GoTo donecursor
        End If

        If map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile >= 4 Then
            Call PutCursorPic(2)
            canbuild% = 2
            GoTo donecursor
        End If


    End If



    If map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile >= 4 Or map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile >= 4 Or map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile >= 4 Or map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile >= 4 Then
        Call PutCursorPic(2)
        canbuild% = 2
        GoTo donecursor
    End If

IF map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile <= 2 AND map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile <= 2 AND map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile <= 2 AND map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile <= 2 OR _
 map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile <= 3 OR map(WorldData.TopCol + 9, WorldData.TopRow + 5).tile <= 3 OR map(WorldData.TopCol + 8, WorldData.TopRow + 6).tile <= 3 OR map(WorldData.TopCol + 9, WorldData.TopRow + 6).tile <= 3 THEN
        Call PutCursorPic(3)
        canbuild% = 1
        GoTo donecursor
    End If

End If

If destroy% = 0 And wantbuild% = 0 Then Call PutCursorPic(1)


donecursor:
' Go to the top of the loop
GoTo again

Sub changeanim

    ' Simple. If they are on animation tile 1, make it 2, or vice versa.

    If WorldData.AnimCycle = 1 Then WorldData.AnimCycle = 2 Else If WorldData.AnimCycle = 2 Then WorldData.AnimCycle = 1

End Sub

DefSng A-Z
Function CheckForVillage
    If map(WorldData.TopCol + 8, WorldData.TopRow + 5).tile = 1 Then
        CheckForVillage = true
    End If

End Function

Sub Delay (seconds!)
    Def Seg = 0
    D& = Fix(seconds! * 18.20444444#)
    For T& = 0 To D&
        D% = Peek(&H46C) And 255
        Do While D% = (Peek(&H46C) And 255)
        Loop
    Next T&
End Sub

DefInt A-Z
Sub InitVars

    ' Initalize some variables
    WorldData.TopRow = 5
    WorldData.TopCol = 5
    WorldData.Direc = West
    WorldData.AnimCycle = 1
    WorldData.PlayerY = 94
End Sub

Sub jfont (a$, C, XCoordinate, YCoordinate, size)

    size = Int(size) 'No decimals allowed!
    If size > 10 Then size = 10 'Check and fix invalid size calls
    If size < 1 Then size = 1 'likewise for <.

    YCoordinate = Int(YCoordinate / size) 'Prevent ballooning of YCoordinates
    'that is a result of using
    'size values larger than 1 for size


    'Enter 999 as XCoordinate for centered text...
    If XCoordinate = 999 Then XCoordinate = 160 - (Len(a$) * 3 * size)

    startx = XCoordinate 'set Starting X-Val for character drawing

    For E = 1 To Len(a$)

        B$ = Mid$(a$, E, 1) ' read each character of the string
        a = Asc(B$) ' get ASCII values of each character

        For x = 1 To 8

            For y = 1 To 6

                Select Case charset(a, x, y) 'use ASCII value (a) to point
                    'to the correct element in
                    'the array

                    Case 0: col = 0 ' Don't draw pixel

                    Case 1: col = C ' Draw pixel
              
                    Case Else ' Error!
                        Cls
                        Screen 9
                        Beep
                        Color 4
                        Print "Error in FONTDATA.DAT"
                        Print "Program will now continue, but may exhibit erratic behavior..."
                        Do: Loop Until InKey$ <> ""
                        Screen 13

                End Select

                If col <> 0 Then 'Draw a pixel!
                    Line (startx + pixelsright, (x + YCoordinate) * size)-(startx + pixelsright + (size - 1), ((x + YCoordinate) * size) + (size - 1)), col, BF
                End If

                startx = startx + size 'Set starting X-value for next pixel
       
            Next y
      
            startx = XCoordinate 'reset startx for next line of pixels
    
        Next x
        pixelsright = pixelsright + (6 * size) ' add pixels for next character

    Next E

End Sub

Sub loadpal
    Dim Pal(255) As HUES 'dim array for palette
    Def Seg = VarSeg(Pal(0)) 'point to it
    BLoad "default.pal", 0 'load the goods
    Out &H3C8, 0 'inform vga
    For atrib = 0 To 255 'entire palette
        Out &H3C9, Pal(atrib).Red 'send red component
        Out &H3C9, Pal(atrib).grn 'send grn component
        Out &H3C9, Pal(atrib).blu 'send blu component
    Next atrib 'next attribute
End Sub

Sub LoadTiles
    Get (0, 0)-(19, 19), blank()

    viewspr ("tiles.spr")
    Get (0, 0)-(19, 19), grass()
    Get (20, 0)-(39, 19), stone()
    Get (40, 0)-(59, 19), water()
    Get (60, 0)-(79, 19), Tree()
    Get (80, 0)-(99, 19), stump()
    Get (100, 0)-(119, 19), ruble()
    Get (0, 40)-(19, 59), path()



    Get (0, 20)-(19, 39), ushore()
    Get (20, 20)-(39, 39), dshore()
    Get (40, 20)-(59, 39), lshore()
    Get (60, 20)-(79, 39), rshore()
    Get (80, 20)-(99, 39), tlshore()
    Get (100, 20)-(119, 39), trshore()
    Get (120, 20)-(139, 39), blshore()
    Get (140, 20)-(159, 39), brshore()
    Get (160, 20)-(179, 39), itlshore()
    Get (180, 20)-(199, 39), itrshore()
    Get (200, 20)-(219, 39), iblshore()
    Get (220, 20)-(239, 39), ibrshore()

    Get (0, 40)-(19, 59), cpath()

    Get (0, 60)-(19, 79), farm.topleft()
    Get (20, 60)-(39, 79), farm.topright()
    Get (40, 60)-(59, 79), castle.topleft()
    Get (60, 60)-(79, 79), castle.topright()
    Get (100, 60)-(119, 79), townhall.topleft()
    Get (120, 60)-(139, 79), townhall.topright()
    Get (140, 60)-(159, 79), civil.topleft()
    Get (160, 60)-(179, 79), civil.topright()
    Get (0, 100)-(19, 119), mine.topleft()
    Get (20, 100)-(39, 119), mine.topright()

    Get (0, 80)-(19, 99), farm.bottomleft()
    Get (20, 80)-(39, 99), farm.bottomright()
    Get (40, 80)-(59, 99), castle.bottomleft()
    Get (60, 80)-(79, 99), castle.bottomright()
    Get (100, 80)-(119, 99), townhall.bottomleft()
    Get (120, 80)-(139, 99), townhall.bottomright()
    Get (140, 80)-(159, 99), civil.bottomleft()
    Get (160, 80)-(179, 99), civil.bottomright()
    Get (0, 120)-(19, 139), mine.bottomleft()
    Get (20, 120)-(39, 139), mine.bottomright()
    Get (0, 140)-(19, 159), enemy.knight()


    Cls

    viewspr ("buttons.spr")
    Get (0, 0)-(19, 19), cursor()
    Get (20, 0)-(39, 19), cursor02()
    Get (40, 0)-(59, 19), cursormask()
    Get (60, 0)-(79, 19), cursor02mask()
    Get (0, 20)-(19, 39), cursor2()
    Get (60, 20)-(79, 39), cursor2mask()
    Get (0, 40)-(19, 59), cursor3()
    Get (60, 40)-(79, 59), cursor3mask()

    Get (80, 0)-(99, 19), goldicon()
    Get (100, 0)-(119, 19), goldiconmask()
    Get (80, 20)-(99, 39), woodicon()
    Get (100, 20)-(119, 39), woodiconmask()

    Get (0, 60)-(39, 99), woodtext()
    Get (0, 60)-(19, 79), woodtextmini()

    Get (40, 60)-(59, 79), bricktext()


    Get (0, 100)-(39, 139), person.consultor()
    Get (40, 100)-(79, 139), person.ninja()
    Get (80, 100)-(119, 139), person.other()
    Get (120, 100)-(159, 139), person.snow()
    Get (160, 100)-(199, 139), person.mean()







    Cls
End Sub

Sub LoadWorld

    WorldData.Rows = 50
    WorldData.Cols = 50 ' Get the rows and cols to read.
    Randomize Timer

    For I = 1 To WorldData.Rows ' Go through a for loop to
        For J = 1 To WorldData.Cols ' load the world map data.

            tempnum% = Rnd * 10


            If tempnum% >= 1 Then map(J, I).tile = 2
            If tempnum% <= 1 Then map(J, I).tile = 4

            If tempnum% = 10 Then
                f% = Rnd * 5
                If f% = 5 Or f% = 4 Then map(J, I).tile = 5
            End If

            If map(J, I).tile = 0 Then map(J, I).WalkOn = false
            If map(J, I).tile <> 0 Then map(J, I).WalkOn = true

            If map(J, I).tile = 2 Then PSet (J, I), 70
            If map(J, I).tile = 4 Then PSet (J, I), 65
            If map(J, I).tile = 36 Then PSet (J, I), 1
            If map(J, I).tile <> 2 And map(J, I).tile <> 4 And map(J, I).tile <> 36 Then PSet (J, I), 70

        Next J
    Next I


    ' randomly places mine
    a = Rnd * 49
    B = Rnd * 49

    map(a, B).tile = 37
    map(a + 1, B).tile = 38
    map(a, B + 1).tile = 39
    map(a + 1, B + 1).tile = 40
    PSet (a, B), 14


    Get (1, 1)-(49, 50), smallmap()


End Sub

Sub menu
    Put (0, 0), woodtext(), PSet
    Put (39, 0), woodtext(), PSet
    Put (0, 40), woodtext(), PSet
    Put (39, 40), woodtext(), PSet
    Put (0, 80), woodtext(), PSet
    Put (39, 80), woodtext(), PSet
    Put (0, 120), woodtext(), PSet
    Put (39, 120), woodtext(), PSet
    Put (0, 160), woodtext(), PSet
    Put (39, 160), woodtext(), PSet
    Line (0, 0)-(60, 199), 112, B
    Line (5, 5)-(55, 56), 0, BF
    Line (5, 5)-(55, 56), 112, B
    Line (24, 155)-(55, 195), 0, BF
    Line (23, 154)-(56, 196), 112, B

    Put (1, 155), goldiconmask(), And
    Put (1, 155), goldicon(), Or
    Put (1, 175), woodiconmask(), And
    Put (1, 175), woodicon(), Or
    Put (6, 6), smallmap(), PSet

End Sub

Sub MoveDown

    WorldData.Direc = South ' Change players direc to south.
    Call changeanim ' Change player animation state.

    If map(WorldData.TopCol + 8, WorldData.TopRow + 5 + 1).WalkOn = true Then
        WorldData.TopRow = WorldData.TopRow + 1 ' If the tile below them
    End If '  (WD.TopRow + 5 + 1) is
    ' walkable, move there.
End Sub

Sub MoveLeft

    WorldData.Direc = West ' Refer to SUB MoveDown.
    Call changeanim

    If map(WorldData.TopCol + 8 - 1, WorldData.TopRow + 5).WalkOn = true Then
        WorldData.TopCol = WorldData.TopCol - 1
    End If

End Sub

Sub MoveRight

    WorldData.Direc = East ' Refer to SUB MoveDown.
    Call changeanim

    If map(WorldData.TopCol + 8 + 1, WorldData.TopRow + 5).WalkOn = true Then
        WorldData.TopCol = WorldData.TopCol + 1
    End If

End Sub

Sub MoveUp

    WorldData.Direc = North ' Refer to SUB MoveDown.
    Call changeanim

    If map(WorldData.TopCol + 8, WorldData.TopRow + 5 - 1).WalkOn = true Then
        WorldData.TopRow = WorldData.TopRow - 1
    End If
End Sub

Sub printFX (text As String)
    Dim x As Integer, y As Integer
    Dim zoom As Single, I As Integer, clock As Single
    Dim xOff As Integer, yOff As Integer
    Dim textLen As Integer, banner As Integer
    limX = 319: limY = 199
    tileSize = 17: pSize = 170
    midX = limX \ 2 - tileSize \ 2: midY = limY \ 2 - tileSize \ 2

    If Left$(text, 1) = ">" Then
        text = Right$(text, Len(text) - 1)
        banner = 40
    End If
    Palette 1, 0
    Color 1
    Locate 1, 1
    Print text
    textLen = Len(text) * 8 - 3
    Dim pic(textLen, 7) As Integer

    For x = 0 To textLen
        For y = 0 To 7
            If Point(x, y) = 1 Then pic(x, y) = true
        Next
    Next
    Cls

    For I = 0 To 35
        Out 968, I + palMax + 1
        Out 969, I + 15
        Out 969, I + 15
        Out 969, I + 15
    Next
    If banner > 0 Then
        For I = 0 To 35
            Out 968, I + banner + 1
            Out 969, I + 15
            Out 969, (I + 1) \ 4
            Out 969, (I + 1) \ 4
        Next
    End If

    For zoom = .2 To 3.3 Step .2
        xOff = midX - (textLen * zoom) \ 2 + zoom
        yOff = midY - (7 * zoom) \ 2 + zoom
        colr = palMax + 1 + zoom * 9 + zoom
        bancol = (banner + 1 + zoom * 9 + zoom) * Sgn(banner)
        For x = 0 To textLen
            For y = 0 To 7
                If pic(x, y) Then
                    Line (xOff + x * zoom, yOff + y * zoom)-Step(zoom, zoom), 8, BF
                Else
                    Line (xOff + x * zoom, yOff + y * zoom)-Step(zoom, zoom), bancol, BF
                End If
            Next
        Next
        clock = Timer
        Do Until clock + .001 - Timer <= 0
        Loop
    Next



End Sub

Sub PutCursorPic (cursor%)

    If cursor% = 1 Then
        If WorldData.AnimCycle = 1 Then
            Put (160, WorldData.PlayerY + 6), cursormask(), And
            Put (160, WorldData.PlayerY + 6), cursor(), Or
        End If

        If WorldData.AnimCycle <> 1 Then
            Put (160, WorldData.PlayerY + 6), cursor02mask(), And
            Put (160, WorldData.PlayerY + 6), cursor02(), Or
        End If
    End If

    If cursor% = 2 Then
        Put (160, WorldData.PlayerY + 6), cursor2mask(), And
        Put (160, WorldData.PlayerY + 6), cursor2(), Or
    End If

    If cursor% = 3 Then
        Put (160, WorldData.PlayerY + 6), cursor3mask(), And
        Put (160, WorldData.PlayerY + 6), cursor3(), Or
    End If




End Sub

Sub PutTile (Ico, Jco, mapno)

    Select Case mapno
        Case 0
            Put (Ico * 20, Jco * 20), blank(), PSet
        Case 1
            Put (Ico * 20, Jco * 20), ruble(), PSet
        Case 5
            Put (Ico * 20, Jco * 20), stone(), PSet
        Case 2
            Put (Ico * 20, Jco * 20), grass(), PSet
        Case 3
            Put (Ico * 20, Jco * 20), stump(), PSet
        Case 4
            Put (Ico * 20, Jco * 20), Tree(), PSet
        Case 6
            Put (Ico * 20, Jco * 20), ushore(), PSet
        Case 7
            Put (Ico * 20, Jco * 20), dshore(), PSet
        Case 8
            Put (Ico * 20, Jco * 20), lshore(), PSet
        Case 9
            Put (Ico * 20, Jco * 20), rshore(), PSet
        Case 10
            Put (Ico * 20, Jco * 20), tlshore(), PSet
        Case 11
            Put (Ico * 20, Jco * 20), trshore(), PSet
        Case 12
            Put (Ico * 20, Jco * 20), blshore(), PSet
        Case 13
            Put (Ico * 20, Jco * 20), brshore(), PSet
        Case 14
            Put (Ico * 20, Jco * 20), itlshore(), PSet
        Case 15
            Put (Ico * 20, Jco * 20), itrshore(), PSet
        Case 16
            Put (Ico * 20, Jco * 20), iblshore(), PSet
        Case 17
            Put (Ico * 20, Jco * 20), cpath(), PSet
        Case 18
            Put (Ico * 20, Jco * 20), farm.topleft(), PSet
        Case 19
            Put (Ico * 20, Jco * 20), farm.topright(), PSet
        Case 20
            Put (Ico * 20, Jco * 20), castle.topleft(), PSet
        Case 21
            Put (Ico * 20, Jco * 20), castle.topright(), PSet
        Case 23
            Put (Ico * 20, Jco * 20), townhall.topleft(), PSet
        Case 24
            Put (Ico * 20, Jco * 20), townhall.topright(), PSet
        Case 25
            Put (Ico * 20, Jco * 20), civil.topleft(), PSet
        Case 26
            Put (Ico * 20, Jco * 20), civil.topright(), PSet
        Case 27
            Put (Ico * 20, Jco * 20), farm.bottomleft(), PSet
        Case 28
            Put (Ico * 20, Jco * 20), farm.bottomright(), PSet
        Case 29
            Put (Ico * 20, Jco * 20), castle.bottomleft(), PSet
        Case 30
            Put (Ico * 20, Jco * 20), castle.bottomright(), PSet
        Case 32
            Put (Ico * 20, Jco * 20), townhall.bottomleft(), PSet
        Case 33
            Put (Ico * 20, Jco * 20), townhall.bottomright(), PSet
        Case 34
            Put (Ico * 20, Jco * 20), civil.bottomleft(), PSet
        Case 35
            Put (Ico * 20, Jco * 20), civil.bottomright(), PSet
        Case 36
            Put (Ico * 20, Jco * 20), water(), PSet
        Case 37
            Put (Ico * 20, Jco * 20), mine.topleft(), PSet
        Case 38
            Put (Ico * 20, Jco * 20), mine.topright(), PSet
        Case 39
            Put (Ico * 20, Jco * 20), mine.bottomleft(), PSet
        Case 40
            Put (Ico * 20, Jco * 20), mine.bottomright(), PSet
        Case 41
            Put (Ico * 20, Jco * 20), path(), PSet


    End Select

End Sub

Sub ShowMap

    For I = 3 To 15
        For J = 0 To 9
            PutTile I, J, map(I + WorldData.TopCol, J + WorldData.TopRow).tile
        Next J
    Next I
                                           
End Sub

Sub talkwin (text$, text2$, text3$, text4$, text5$, text6$, text7$, text8$, more%)
    Dim talkw(9000)
    Get (7, 7)-(284, 54), talkw()
    Line (10, 10)-(280, 50), 0, BF
    Line (9, 9)-(281, 51), 8, B
    Line (8, 8)-(282, 52), 7, B
    Line (7, 7)-(283, 53), 15, B
    Call jfont(text$, 15, 12, 12, 1)
    Call jfont(text2$, 15, 12, 20, 1)
    Call jfont(text3$, 15, 12, 28, 1)
    Call jfont(text4$, 15, 12, 38, 1)

    Do
        x$ = InKey$
    Loop Until x$ = Chr$(13)
    If more% = 1 Then
        Line (10, 10)-(280, 50), 0, BF
        Line (9, 9)-(281, 51), 8, B
        Line (8, 8)-(282, 52), 7, B
        Line (7, 7)-(283, 53), 15, B
        Call jfont(text5$, 15, 12, 12, 1)
        Call jfont(text6$, 15, 12, 20, 1)
        Call jfont(text7$, 15, 12, 28, 1)
        Call jfont(text8$, 15, 12, 38, 1)

        Do
            x$ = InKey$
        Loop Until x$ = Chr$(13)
    End If
    Put (7, 7), talkw(), PSet
End Sub

Sub viewspr (filename$)

    Open filename$ For Binary As #1
    filesize& = LOF(1)
    Close #1


    Bytes = (filesize& - 7) \ 2 - 1 'BSAVE & BLOAD use 7 bytes
    ReDim sprites(Bytes) 'redim the sprite array
    Def Seg = VarSeg(sprites(0)) 'point to it
    BLoad filename$, 0 'load the sprite file
    spritewidth = sprites(0) \ 8 'get sprite width
    spriteheight = sprites(1) 'get sprite height


    xsprites = 319 \ (spritewidth + 1) 'calc number of sprites across
    xend = spritewidth * (xsprites - 1) + xsprites 'last one
    ElmPerSprite = ((spritewidth * spriteheight) \ 2) + 3 'elements per image


    'clear the screen

    x = 0: y = 0 'first sprite location
    offset = 0 'point to sprite


    Do
        Put (x, y), sprites(offset), PSet 'PUT image
        x = x + spritewidth 'next column
        If x > xend Then 'end of row?
            x = 0 'restart
            y = y + spriteheight 'next row
        End If
        offset = offset + ElmPerSprite 'point to next sprite
    Loop While offset < Bytes 'do all the images

End Sub

