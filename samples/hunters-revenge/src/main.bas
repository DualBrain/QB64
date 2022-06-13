'################################################################
'      H U N T E R ' S    R E V E N G E    2 0 1 7 - 1 8
'                  By Ashish Kushwaha
'         **** Hit F5 and Enjoy the Game!! ****
'Note :-
'The executable should be inside Hunter-Revenge folder
'If you are facing any problem, report it at Qb64.org Forum
'
'*** Tell Me You You Think About This Game On Twitter with @KingOfCoders ***
'
'################################################################

'$CONSOLE
'_CONSOLETITLE "Hunter's Revenge [DEBUG_OUTPUT]"

If Command$(1) = "--reset" Then
    Dim dummy As String
    Input "Are you sure that you want to reset the game? (Y/N) ", dummy
    If UCase$(dummy) = "Y" Then Kill "Save_Game/save.dat": createConfig: System
End If

'App icon
$ExeIcon:'./Images/game.ico'
Dim tmp_icon As Long
tmp_icon& = _LoadImage("Images/cursor.png", 32)
_ClearColor _RGB(255, 255, 255), tmp_icon&
_Icon tmp_icon&
_FreeImage tmp_icon&

Do: Loop Until _ScreenExists
Randomize Timer
'$include:'Vendor/spritetop.bi'
_Delay 1
_MouseHide

_Title "Hunter's Revenge"

Screen _NewImage(800, 600, 32)
Do: Loop Until _ScreenExists

' ON ERROR GOTO 404

_DisplayOrder _Software , _Hardware , _GLRender , _Hardware1

'Notification Section
Dim Shared NEvent, NFPSCount%, NImage&, NText$, NShow As _Byte

'Frame Rate Section
Dim Shared FPSEvent, FPSEvt, FPSCurrent%, FPSRate%, FPSBg&

'Loader Section
Dim Shared Loader&, LoaderX%, LoaderY%, LoaderCF%, LoaderEvt!
LoaderX% = 730: LoaderY% = 500

'Game Types
Type GameMenu
    click As _Byte
    hover As _Byte
    y As Integer
    img As Long
    img2 As Long 'software image
End Type

Type Mousetype
    x As Integer
    y As Integer
    lclick As _Byte
    rclick As _Byte
    mclick As _Byte
    cursor As Long
    cursor2 As Long
    hovering As _Byte
End Type

Type fonttype
    smaller As Long
    normal As Long
    bigger As Long
    biggest As Long
End Type
'game objects

Type explosiontype
    x As Integer
    y As Integer
    img As Integer
    active As _Byte
    currentFrame As Integer
    totalFrames As Integer
    f As Integer
    n As Integer
End Type

Type guntype
    name As String * 32
    damage As Integer
    id As Integer
    img As Long
End Type

Type Enemies
    x As Integer ' x position
    y As Integer ' y position
    typ As String * 16 'type of enemie
    life As Integer 'life of the enemie
    life2 As Integer 'backup of life
    damage As Integer 'useless
    ending As _Byte 'enemie is dead or not
    img As Integer 'sprite handle
    active As _Byte 'enemie is active or not
    u As Long 'delay (in milliseconds) after which enemie will show up in his scene in gameplay
    n As Integer 'delay between change of frame of animation
    f As Integer 'increment varible, if greater than above 'n', then frame is change
    m As Double 'movement speed
    points As Integer 'holds point
    scene As Integer 'hold scene
    snd As Long 'hold sound handle
    sndPaused As _Byte ' = true when sound is paused.
End Type

Type Levels
    enemies As Integer 'total enemies in a level
    scenes As Integer 'total scenes in a level
    currentScene As Integer 'current scene of the gameplay
    completed As _Byte 'level has been completed or not
    u As Long 'current frame of the gameplay (always increases during gameplay)
    over As _Byte ' level has been over or not
    background As String * 64 'background image path of the level
    bg As Long 'background image handle of the level
    mode As Integer 'MODs of the game. Can be either THUNDERMODE, STORMMODE, FOGMODE, THUNDERMODE+FOGMODE, THUNDERMODE+STORMMODE
    cancel As _Byte 'level has been cancel or not
    time As _Unsigned Integer 'number of seconds a level has to be completed in (in seconds).
End Type

Type fog
    x As Integer
    move As Integer
    handle As Long
End Type

Type drops
    x As Integer
    y As Integer
    z As Integer
    len As Double
    yspeed As Double
    gravity As Double
End Type

Type Settings
    fullscreen As _Byte
    music As _Byte
    sfx As _Byte
    musicV As Double
    sfxV As Double
    SE As _Byte
    fps As Integer
    done As _Byte
End Type

'score flasher
Type scoreFlasher
    x As Single
    y As Single
    img As Long
    active As _Byte
    sclX As Single
    sclY As Single
    __ops As Single
End Type

' TYPE Vector_Particles_Text_Type
' x AS SINGLE 'x position
' y AS SINGLE 'y position
' vx AS SINGLE 'visual x
' vy AS SINGLE 'visual y
' delX AS SINGLE 'delta velocity
' delY AS SINGLE 'delta velocity
' dist AS SINGLE 'distance
' distX AS SINGLE ' distance x
' distY AS SINGLE 'distance y
' k AS SINGLE
' END TYPE

'$DYNAMIC

Randomize Timer
Dim Shared W As Settings
readConfig

'DIM SHARED Paused AS _BYTE

'REDIM SHARED Text_Particles(1) AS Vector_Particles_Text_Type

'DIM SHARED Text_Particles_Status, Text_Particles_Color AS _UNSIGNED LONG

Dim Shared randomLevels As _Byte 'Computer chooses level! ^_*

Dim Shared Menubg&, GlobalEvent As Single, TimerEvent, GameRenderingEvent, Minutes%, Seconds%

Dim Shared Mouse As Mousetype

Dim Shared Fonts As fonttype

Dim Shared GameMenus(19) As GameMenu

Dim Shared MenuBlood%, MenuChoice

Dim Shared ShotScore(5) As scoreFlasher

Dim Shared explosions(20) As explosiontype, Gun As guntype, Bloods(50) As explosiontype

Dim Shared Level As Levels

Dim Shared HighScore%, LevelStage%, LevelStage2%, CurrentScore%

Dim Shared ScoreBoard&, GunImg&(1), OldScore%, OldSeconds%

Dim Shared Musics&(2)

Randomize Timer
'Rains
Dim Shared Drop(700) As drops
Dim Shared Rainx8&, Rainx16&, RainLight&, RainSound&, RainVol#, ThunderCount, ThunderEvent



'max level
Const MAX_LEVEL = 14
'storm
Dim Shared StormImg&, StormX%

'Sparks
Dim Shared ExplosionsZ(1) As explosiontype

'MODS
Const FOGMODE = 1
Const THUNDERMODE = 3
Const STORMMODE = 5
Dim Shared Fogs As fog

'SFXs
Dim Shared Eagle&
Dim Shared Bird&
Dim Shared Crow&
Dim Shared Expos&
Dim Shared Jet&
Dim Shared Gun1&
Dim Shared Gun2&

'Enemies scores image
Dim Shared scoresImage(5) As Long

ReDim Shared Enemie(0) As Enemies

Dim Shared Jet1_Sheet%
Dim Shared Jet2_Sheet%
Dim Shared Jet3_Sheet%
Dim Shared Bird_Sheet%
Dim Shared Crow_Sheet%
Dim Shared eagle_Sheet%
Dim Shared blood_Sheet%
Dim Shared explosion_Sheet%
Dim Shared spark_Sheet%
Dim Shared lifeBars(99) As Long

FPSEvent = _FreeTimer 'Event for showing current FPS (Frame Per Second)
FPSEvt = _FreeTimer 'Event for calculating current FPS (Frame Per Second)
GlobalEvent = _FreeTimer 'Event for game main menu
TimerEvent = _FreeTimer 'Event of timer which is displayed during gameplay
GameRenderingEvent = _FreeTimer 'Event in which level objects are rendered.
NEvent = _FreeTimer ' Global Event for notification

'Splash Screen

Splash


LoaderStart

loadComponents
'cursors
Mouse.cursor = _LoadImage("Images/cursor.png", 33)
Mouse.cursor2 = _LoadImage("Images/cursor2.png", 33)

'fonts
Fonts.biggest = _LoadFont("Font/ARDESTINE.ttf", 68)
Fonts.bigger = _LoadFont("Font/ARDESTINE.ttf", 40)
Fonts.smaller = _LoadFont("Font/arial.ttf", 12, "dontblend")
Fonts.normal = _LoadFont("Font/ARDESTINE.ttf", 24)

'scores image

scoresImage(0) = _LoadImage("Images/10.png", 33)
scoresImage(1) = _LoadImage("Images/20.png", 33)
scoresImage(2) = _LoadImage("Images/35.png", 33)
scoresImage(3) = _LoadImage("Images/50.png", 33)
scoresImage(4) = _LoadImage("Images/75.png", 33)
scoresImage(5) = _LoadImage("Images/100.png", 33)

'fogs
Fogs.x = 0
Fogs.move = 1
Fogs.handle = _LoadImage("Images/fogs_.png", 33)

'rains
Rainx8& = _LoadImage("Images/rainx8.png", 33)
Rainx16& = _LoadImage("Images/rainx16.png", 33)


'storm
StormImg& = _LoadImage("Images\storm.png", 33) 'we're using hardware image

'LifeBars
Dim i As Integer, r As Integer, g As Integer
For i = 0 To 99
    lifeBars(i) = _NewImage(100, 6, 32)
    _Dest lifeBars(i)
    r = p5map(i + 1, 1, 100, 255, 0)
    g = p5map(i + 1, 1, 100, 0, 255)
    Line (0, 0)-(100, 6), _RGB(0, 0, 0), BF
    Line (0, 0)-(i + 1, 6), _RGB(r, g, 0), BF
    Line (0, 0)-(99, 5), _RGB(255, 255, 255), B
    _Dest 0
Next

Dim tmp&
For i = 0 To 99
    tmp& = _CopyImage(lifeBars(i))
    _FreeImage lifeBars(i)
    lifeBars(i) = _CopyImage(tmp&, 33)
    _FreeImage tmp&
Next

Gun.damage = 3
Gun.id = 1
Gun.name = "Shot Gun"

Menubg& = _LoadImage("Images\farm1.jpg")
GunImg&(0) = _LoadImage("Images\gun_shot.png")
GunImg&(1) = _LoadImage("Images\Gun_ak-47.png")
ScoreBoard& = _LoadImage("Images\score_board.png")

blood_Sheet% = SPRITESHEETLOAD("Images\blood.png", 64, 62, _RGB(0, 0, 0))
Jet1_Sheet% = SPRITESHEETLOAD("Images\Jet.png", 120, 122, _RGB(0, 0, 0))
Jet2_Sheet% = SPRITESHEETLOAD("Images\Jet_2.png", 120, 122, _RGB(0, 0, 0))
Jet3_Sheet% = SPRITESHEETLOAD("Images\Jet_3.png", 150, 122, _RGB(0, 0, 0))
eagle_Sheet% = SPRITESHEETLOAD("Images\eagle.png", 40, 40, _RGB(0, 0, 0))
Crow_Sheet% = SPRITESHEETLOAD("Images\crow.png", 97, 120, _RGB(0, 0, 0))
Bird_Sheet% = SPRITESHEETLOAD("Images\bird.png", 180, 170, _RGB(0, 0, 0))

explosion_Sheet% = SPRITESHEETLOAD("Images\explosion.png", 100, 100, _RGB(0, 0, 0))

For i = 0 To 1
    ExplosionsZ(i).img = SPRITENEW(explosion_Sheet%, 1, SAVE)
    SPRITEANIMATESET ExplosionsZ(i).img, 1, 81
    ExplosionsZ(i).y = 300
Next

ExplosionsZ(0).x = 100: ExplosionsZ(1).x = 700

For i = 0 To 20
    Bloods(i).img = SPRITENEW(blood_Sheet%, 1, SAVE)
    SPRITEANIMATESET Bloods(i).img, 1, 6
    explosions(i).img = SPRITENEW(explosion_Sheet%, 1, SAVE)
    SPRITEANIMATESET explosions(i).img, 1, 81
    Bloods(i).totalFrames = 6
    Bloods(i).n = 5
    explosions(i).totalFrames = 81
    explosions(i).n = 4
Next
MenuBlood% = SPRITENEW(blood_Sheet%, 1, SAVE)
SPRITEANIMATESET MenuBlood%, 1, 6



'Setup Notificaton stuff
On Timer(NEvent, .013) Notify
Timer(NEvent) On

_Font Fonts.bigger

tmp& = _NewImage(400, 60, 32)
_Dest tmp&
_Font Fonts.bigger
Color , _RGBA(0, 0, 0, 0)
_PrintString (CenterPrintX("Play"), 0), "Play"
_Dest 0
GameMenus(0).img = _CopyImage(tmp&, 33)
GameMenus(0).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(0).y = 150

tmp& = _NewImage(400, 60, 32)
_Dest tmp&
_Font Fonts.bigger
Color , _RGBA(0, 0, 0, 0)
_PrintString (CenterPrintX("Options"), 0), "Options"
_Dest 0
GameMenus(1).img = _CopyImage(tmp&, 33)
GameMenus(1).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(1).y = GameMenus(0).y + 60

tmp& = _NewImage(400, 60, 32)
_Dest tmp&
_Font Fonts.bigger
Color , _RGBA(0, 0, 0, 0)
_PrintString (CenterPrintX("Help"), 0), "Help"
_Dest 0
GameMenus(2).img = _CopyImage(tmp&, 33)
GameMenus(2).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(2).y = GameMenus(1).y + 60

tmp& = _NewImage(400, 60, 32)
_Dest tmp&
_Font Fonts.bigger
Color , _RGBA(0, 0, 0, 0)
_PrintString (CenterPrintX("Credits"), 0), "Credits"
_Dest 0
GameMenus(3).img = _CopyImage(tmp&, 33)
GameMenus(3).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(3).y = GameMenus(2).y + 60

tmp& = _NewImage(400, 60, 32)
_Dest tmp&
_Font Fonts.bigger
Color , _RGBA(0, 0, 0, 0)
_PrintString (CenterPrintX("Exit"), 0), "Exit"
_Dest 0
GameMenus(4).img = _CopyImage(tmp&, 33)
GameMenus(4).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(4).y = GameMenus(3).y + 60


tmp& = _NewImage(400, 30, 32)
_Dest tmp&
Color , _RGBA(0, 0, 0, 0)
_Font Fonts.normal
_PrintString (20, 0), "Fullscreen"
_Dest 0
GameMenus(5).img = _CopyImage(tmp&, 33)
GameMenus(5).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(5).y = 113

tmp& = _NewImage(400, 30, 32)
_Dest tmp&
Color , _RGBA(0, 0, 0, 0)
_Font Fonts.normal
_PrintString (20, 0), "Fullscreen Method "
_Dest 0
GameMenus(6).img = _CopyImage(tmp&, 33)
GameMenus(6).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(6).y = GameMenus(5).y + 34

tmp& = _NewImage(400, 30, 32)
_Dest tmp&
Color , _RGBA(0, 0, 0, 0)
_Font Fonts.normal
_PrintString (20, 0), "Music "
_Dest 0
GameMenus(7).img = _CopyImage(tmp&, 33)
GameMenus(7).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(7).y = GameMenus(6).y + 34

tmp& = _NewImage(400, 30, 32)
_Dest tmp&
Color , _RGBA(0, 0, 0, 0)
_Font Fonts.normal
_PrintString (20, 0), "SFX "
_Dest 0
GameMenus(8).img = _CopyImage(tmp&, 33)
GameMenus(8).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(8).y = GameMenus(7).y + 34

tmp& = _NewImage(400, 30, 32)
_Dest tmp&
Color , _RGBA(0, 0, 0, 0)
_Font Fonts.normal
_PrintString (20, 0), "Music Volume "
_Dest 0
GameMenus(9).img = _CopyImage(tmp&, 33)
GameMenus(9).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(9).y = GameMenus(8).y + 34

tmp& = _NewImage(400, 30, 32)
_Dest tmp&
Color , _RGBA(0, 0, 0, 0)
_Font Fonts.normal
_PrintString (20, 0), "SFX Volume"
_Dest 0
GameMenus(10).img = _CopyImage(tmp&, 33)
GameMenus(10).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(10).y = GameMenus(9).y + 34

tmp& = _NewImage(400, 30, 32)
_Dest tmp&
Color , _RGBA(0, 0, 0, 0)
_Font Fonts.normal
_PrintString (20, 0), "3D Sound Effect"
_Dest 0
GameMenus(11).img = _CopyImage(tmp&, 33)
GameMenus(11).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(11).y = GameMenus(10).y + 34

tmp& = _NewImage(400, 30, 32)
_Dest tmp&
Color , _RGBA(0, 0, 0, 0)
_Font Fonts.normal
_PrintString (20, 0), "Frame Rate "
_Dest 0
GameMenus(12).img = _CopyImage(tmp&, 33)
GameMenus(12).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(12).y = GameMenus(11).y + 34

tmp& = _NewImage(500, 30, 32)
_Dest tmp&
Color , _RGBA(0, 0, 0, 0)
_Font Fonts.normal
_PrintString (CenterPrintX("Default Settings"), 0), "Default Settings"
_Dest 0
GameMenus(13).img = _CopyImage(tmp&, 33)
GameMenus(13).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(13).y = GameMenus(12).y + 34

tmp& = _NewImage(500, 200, 32)
_Dest tmp&
Color , _RGBA(0, 0, 0, 0)
_Font Fonts.normal
_PrintString (CenterPrintX("Apply Settings"), 0), "Apply Settings"
_Dest 0
GameMenus(14).img = _CopyImage(tmp&, 33)
GameMenus(14).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(14).y = GameMenus(13).y + 34

tmp& = _NewImage(500, 200, 32)
_Dest tmp&
Color , _RGBA(0, 0, 0, 0)
_Font Fonts.normal
_PrintString (CenterPrintX("Go Back To Main Menu"), 0), "Go Back To Main Menu"
_Dest 0
GameMenus(15).img = _CopyImage(tmp&, 33)
GameMenus(15).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(15).y = GameMenus(14).y + 34

tmp& = _NewImage(500, 200, 32)
_Dest tmp&
Color , _RGBA(0, 0, 0, 0)
_Font Fonts.normal
_PrintString (20, 0), "Fullscreen"
_Dest 0
GameMenus(16).img = _CopyImage(tmp&, 33)
GameMenus(16).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(16).y = 232

tmp& = _NewImage(500, 200, 32)
_Dest tmp&
Color , _RGBA(0, 0, 0, 0)
_Font Fonts.normal
_PrintString (20, 0), "Music Volume"
_Dest 0
GameMenus(17).img = _CopyImage(tmp&, 33)
GameMenus(17).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(17).y = GameMenus(16).y + 34

tmp& = _NewImage(500, 200, 32)
_Dest tmp&
Color , _RGBA(0, 0, 0, 0)
_Font Fonts.normal
_PrintString (20, 0), "SFX Volume"
_Dest 0
GameMenus(18).img = _CopyImage(tmp&, 33)
GameMenus(18).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(18).y = GameMenus(17).y + 34

tmp& = _NewImage(500, 200, 32)
_Dest tmp&
Color , _RGBA(0, 0, 0, 0)
_Font Fonts.normal
_PrintString (CenterPrintX("Exit to Main Menu"), 0), "Exit to Main Menu"
_Dest 0
GameMenus(19).img = _CopyImage(tmp&, 33)
GameMenus(19).img2 = _CopyImage(tmp&, 32)
_FreeImage tmp&
GameMenus(19).y = GameMenus(18).y + 34






LoaderEnd

start:

Color _RGB(255, 255, 255), _RGBA(0, 0, 0, 0)

' echo COMMAND$(1)
' echo COMMAND$(2)
' IF COMMAND$(1) = "-loadlevel" AND VAL(COMMAND$(2)) > 0 THEN
' LevelStage% = VAL(COMMAND$(2))
' LevelStage2% = LevelStage%
' GOTO newgame
' END IF

GameMenu




If MenuChoice = 1 Then MenuChoice = 0: GoTo newgame
If MenuChoice = 2 Then
    MenuChoice = 0

    'save current settings in dummy variable :P
    Dim preConfig As Settings
    preConfig = W ' W is a global variable which stored all game settings

    Dim on_switch&, off_switch&, bd&, cj&, gfx&, ac& 'images surface
    on_switch& = _LoadImage("Images/on.png", 33)
    off_switch& = _LoadImage("Images/off.png", 33)
    For i = 0 To 4
        _PutImage (200, GameMenus(i).y), GameMenus(i).img2
    Next

    bd& = _CopyImage(0)
    cj& = _CopyImage(bd&)

    BLURIMAGE cj&, 5
    gfx& = _NewImage(500, 340, 32)
    _Dest gfx&
    Cls , 0 'make it transparent
    Line (0, 0)-Step(_Width, _Height), _RGBA(0, 0, 0, 150), BF
    For i = 5 To 14
        _PutImage (0, GameMenus(i).y - 103), GameMenus(i).img2
    Next

    _Dest 0

    For i = 0 To 255 Step 10
        _SetAlpha i, , cj&
        _PutImage , bd&
        _PutImage , cj&
        Line (0, 0)-(_Width, _Height), _RGBA(0, 0, 0, i / 3), BF
        _PutImage (150, 103), gfx&, 0, (0, 0)-(500, p5map(i, 0, 255, 0, 340))
        _Display
    Next
    ac& = _CopyImage(cj&)
    _Dest ac&
    Line (0, 0)-(_Width, _Height), _RGBA(0, 0, 0, 85), BF
    _Dest 0
    Do
        While _MouseInput: Wend
        Mouse.x = _MouseX: Mouse.y = _MouseY
        Mouse.lclick = 0
        Mouse.rclick = 0
        If _MouseButton(1) Then
            While _MouseButton(1): While _MouseInput: Wend: Wend
            Mouse.lclick = -1
        End If
        If _MouseButton(2) Then
            While _MouseButton(2): While _MouseInput: Wend: Wend
            Mouse.rclick = -1
        End If
        _PutImage , ac&
        Line (150, 103)-Step(500, 374), _RGBA(0, 0, 0, 150), BF
        For i = 5 To 15
            If Mouse.x > 150 And Mouse.x < 650 And Mouse.y > GameMenus(i).y - 10 And Mouse.y < GameMenus(i).y + 24 Then
                Line (150, GameMenus(i).y - 10)-(650, GameMenus(i).y + 24), _RGBA(255, 100, 0, 100), BF
                If Mouse.lclick Then
                    Select Case i
                        Case 5
                            If W.fullscreen > 0 Then W.fullscreen = 0 Else W.fullscreen = 1
                        Case 6
                            W.fullscreen = W.fullscreen + 1
                            If W.fullscreen > 2 Then W.fullscreen = 1
                        Case 7
                            If W.music Then W.music = 0 Else W.music = -1
                        Case 8
                            If W.sfx Then W.sfx = 0 Else W.sfx = -1
                        Case 9
                            W.musicV = W.musicV + .1
                            If W.musicV > 1.0 Then W.musicV = .1
                        Case 10
                            W.sfxV = W.sfxV + .1
                            If W.sfxV > 1 Then W.sfxV = 0.1
                        Case 11
                            If W.SE Then W.SE = 0 Else W.SE = -1
                        Case 12
                            W.fps = W.fps + 30
                            If W.fps > 240 Then W.fps = 30
                        Case 13
                            W.fullscreen = 0
                            W.music = -1
                            W.sfx = -1
                            W.musicV = 1
                            W.sfxV = 1
                            W.SE = -1
                            W.fps = 30
                        Case 14
                            writeConfig
                            loadComponents
                            showNotification "Settings have been applied."
                        Case 15
                            Exit Do
                    End Select
                End If
            End If
            _PutImage (150, GameMenus(i).y), GameMenus(i).img
            Select Case i
                Case 5
                    If W.fullscreen > 0 Then _PutImage (580, GameMenus(i).y - 3), on_switch& Else _PutImage (580, GameMenus(i).y - 3), off_switch&
                Case 6
                    _Font Fonts.normal
                    Select Case W.fullscreen
                        Case 1
                            _PrintString (630 - txtWidth("Stretch"), GameMenus(i).y), "Stretch"
                        Case 2
                            _PrintString (630 - txtWidth("Square Pixels"), GameMenus(i).y), "Square Pixels"
                        Case Else
                            _PrintString (630 - txtWidth("Disable"), GameMenus(i).y), "Disable"
                    End Select
                Case 7
                    If W.music Then _PutImage (580, GameMenus(i).y - 3), on_switch& Else _PutImage (580, GameMenus(i).y - 3), off_switch&
                Case 8
                    If W.sfx Then _PutImage (580, GameMenus(i).y - 3), on_switch& Else _PutImage (580, GameMenus(i).y - 3), off_switch&
                Case 9
                    _Font Fonts.normal
                    If W.musicV > .9 Then
                        _PrintString (630 - txtWidth(" 10"), GameMenus(i).y), " 10 "
                    Else
                        _PrintString (630 - txtWidth(Str$(Int(W.musicV * 10))), GameMenus(i).y), Str$(Int(W.musicV * 10))
                    End If
                Case 10
                    _Font Fonts.normal
                    If W.sfxV > .9 Then
                        _PrintString (630 - txtWidth(" 10"), GameMenus(i).y), " 10 "
                    Else
                        _PrintString (630 - txtWidth(Str$(Int(W.sfxV * 10))), GameMenus(i).y), Str$(Int(W.sfxV * 10))
                    End If
                Case 11
                    If W.SE Then _PutImage (580, GameMenus(i).y - 3), on_switch& Else _PutImage (580, GameMenus(i).y - 3), off_switch&
                Case 12
                    _Font Fonts.normal
                    _PrintString (630 - txtWidth(Str$(W.fps)), GameMenus(i).y), Str$(W.fps)
            End Select
        Next
        _Limit W.fps
        If Mouse.hovering Then
            _PutImage (Mouse.x - 16, Mouse.y - 16), Mouse.cursor2
            _Display
        Else
            _PutImage (Mouse.x - 16, Mouse.y - 16), Mouse.cursor
            _Display
        End If

    Loop
    For i = 255 To 0 Step -10
        _SetAlpha i, , cj&
        _PutImage , bd&
        _PutImage , cj&
        Line (0, 0)-(_Width, _Height), _RGBA(0, 0, 0, i / 3), BF
        _PutImage (150, 103), gfx&, 0, (0, 0)-(500, p5map(i, 0, 255, 0, 340))
        _Display
    Next
    _FreeImage bd&
    _FreeImage cj&
    _FreeImage ac&
    _FreeImage gfx&
    _FreeImage on_switch&
    _FreeImage off_switch&
    GoTo start
End If
If MenuChoice = 3 Then
    MenuChoice = 0
    For i = 0 To 4
        _PutImage (200, GameMenus(i).y), GameMenus(i).img2
    Next
    bd& = _CopyImage(0)
    cj& = _CopyImage(bd&)

    BLURIMAGE cj&, 5
    Dim k&
    k& = _LoadImage("Images\help.png")

    For i = 0 To 255 Step 10
        _SetAlpha i, , cj&
        _PutImage , bd&
        _PutImage , cj&
        _SetAlpha i / 1.25, , k&
        Line (0, 0)-(_Width, _Height), _RGBA(0, 0, 0, i / 5), BF
        centerImage k&
        _Display
    Next

    Do
        'mouse input
        While _MouseInput: Wend
        Mouse.x = _MouseX: Mouse.y = _MouseY

        If _MouseButton(1) Then
            While _MouseButton(1): While _MouseInput: Wend: Wend
            Mouse.lclick = -1
        Else
            Mouse.lclick = 0
        End If

        If _MouseButton(2) Then
            While _MouseButton(2): While _MouseInput: Wend: Wend
            Mouse.rclick = -1
        Else
            Mouse.rclick = 0
        End If

        _Limit W.fps

        _Display

        If Mouse.lclick Or Mouse.rclick Or _KeyHit = 27 Then Exit Do
    Loop

    For i = 255 To 0 Step -10
        _SetAlpha i, , cj&
        _PutImage , bd&
        _PutImage , cj&
        _SetAlpha i / 1.25, , k&
        Line (0, 0)-(_Width, _Height), _RGBA(0, 0, 0, i / 5), BF
        centerImage k&
        _Display
    Next

    _PutImage , bd&
    _FreeImage bd&
    _FreeImage cj&
    _FreeImage k&
    GoTo start

End If

If MenuChoice = 4 Then
    For i = 0 To 4
        _PutImage (200, GameMenus(i).y), GameMenus(i).img2
    Next

    bd& = _CopyImage(0)

    For i = 0 To 255 Step 5
        _PutImage , bd&
        Line (0, 0)-(_Width, _Height), _RGBA(0, 0, 0, i), BF
        _Display
    Next

    showCredits

    For i = 255 To 0 Step -5
        _PutImage , bd&
        Line (0, 0)-(_Width, _Height), _RGBA(0, 0, 0, i), BF
        _Display
    Next

    _FreeImage bd&
    MenuChoice = 0
    GoTo start

End If

If MenuChoice = 5 Then System 1
MenuChoice = 0
End
newgame:


Cls

LoaderStart
SetupRain
If Command$(1) = "-loadlevel" Then
    LoadLevel
Else
    If getCurrentLevel > MAX_LEVEL Then randomLevels = -1 Else randomLevels = 0: LoadLevel
End If


_Font Fonts.bigger

'################### Random Levels ################################
Dim F As Integer
If randomLevels Then
    Level.completed = 0
    Level.over = 0
    LevelStage% = p5random(1, MAX_LEVEL)
    F = FreeFile
    'LevelStage% = VAL(COMMAND$(2))
    Open "stages/stage" + RTrim$(LTrim$(Str$(LevelStage%))) + ".dat" For Input As #F
    Input #F, Level.enemies
    Input #F, Level.scenes
    Input #F, Seconds%
    Input #F, Level.mode
    Input #F, Level.background
    Close #F
    Level.bg = _LoadImage("Images\" + RTrim$(Level.background))
    OldSeconds% = Seconds%
End If

If randomLevels Then _PrintString (CenterPrintX("Random Levels"), 300), "Random Levels" Else _PrintString (CenterPrintX("Stage " + LTrim$(RTrim$(Str$(LevelStage%)))), 300), "Stage " + LTrim$(RTrim$(Str$(LevelStage%)))

_Delay Rnd * 3

' if randomLevels then LoaderEnd : goto game_rendering_begin
' _DELAY 0.5


'############################# Custom Levels #############################

Erase Enemie 'clear all previous enemie data

ReDim Shared Enemie(Level.enemies) As Enemies

'Enemie Configuirations

F = FreeFile
Level.completed = 0
Level.over = 0
Level.cancel = 0
CurrentScore% = 0
Level.u = 0
Level.currentScene = 1

Open "Stages\Stage" + LTrim$(RTrim$(Str$(LevelStage%))) + ".lvl" For Input As #F

For i = 1 To Level.enemies
    Input #F, Enemie(i).typ

    Select Case RTrim$(Enemie(i).typ)

        Case "bird"
            Enemie(i).img = SPRITENEW(Bird_Sheet%, 1, SAVE)
            SPRITEANIMATESET Enemie(i).img, 1, 14
            SPRITEZOOM Enemie(i).img, 50
            Enemie(i).n = 6
            Enemie(i).points = 10
            Enemie(i).life = 4
            Enemie(i).life2 = Enemie(i).life
            Enemie(i).snd = _SndCopy(Bird&)
        Case "crow"
            Enemie(i).img = SPRITENEW(Crow_Sheet%, 1, SAVE)
            SPRITEANIMATESET Enemie(i).img, 1, 4
            SPRITEZOOM Enemie(i).img, 70
            Enemie(i).n = 12
            Enemie(i).points = 20
            Enemie(i).life = 7
            Enemie(i).life2 = Enemie(i).life
            Enemie(i).snd = _SndCopy(Crow&)
        Case "eagle"
            Enemie(i).img = SPRITENEW(eagle_Sheet%, 7, SAVE)
            SPRITEANIMATESET Enemie(i).img, 7, 9
            Enemie(i).n = 12
            Enemie(i).points = 35
            Enemie(i).life = 14
            Enemie(i).life2 = Enemie(i).life
            Enemie(i).snd = _SndCopy(Eagle&)
        Case "jet1"
            Enemie(i).img = SPRITENEW(Jet1_Sheet%, 1, SAVE)
            SPRITEANIMATESET Enemie(i).img, 1, 3
            SPRITEZOOM Enemie(i).img, 70
            Enemie(i).n = 10
            Enemie(i).points = 50
            Enemie(i).life = 30
            Enemie(i).life2 = Enemie(i).life
            Enemie(i).snd = _SndCopy(Jet&)
        Case "jet2"
            Enemie(i).img = SPRITENEW(Jet2_Sheet%, 1, SAVE)
            SPRITEANIMATESET Enemie(i).img, 1, 3
            SPRITEZOOM Enemie(i).img, 70
            Enemie(i).n = 10
            Enemie(i).points = 75
            Enemie(i).life = 45
            Enemie(i).life2 = Enemie(i).life
            Enemie(i).snd = _SndCopy(Jet&)
        Case "jet3"
            Enemie(i).img = SPRITENEW(Jet3_Sheet%, 1, SAVE)
            SPRITEANIMATESET Enemie(i).img, 1, 3
            SPRITEZOOM Enemie(i).img, 70
            Enemie(i).n = 10
            Enemie(i).points = 100
            Enemie(i).life = 70
            Enemie(i).life2 = Enemie(i).life
            Enemie(i).snd = _SndCopy(Jet&)
    End Select
    Input #F, Enemie(i).u
    Input #F, Enemie(i).y
    Input #F, Enemie(i).m
    If Enemie(i).m < 0 Then Enemie(i).x = _Width: SPRITEFLIP Enemie(i).img, HORIZONTAL Else Enemie(i).x = 0

    Input #F, Enemie(i).scene
Next

Close #F

LoaderEnd

game_rendering_begin:::

_PutImage (0, 0)-(_Width, _Height), Level.bg
_PutImage (0, 520), ScoreBoard&
_PutImage (50, 550)-(170, 590), GunImg&(Gun.id - 1)
_Font Fonts.smaller
_PrintString (40, 580), RTrim$(Gun.name)
_Font Fonts.normal

If randomLevels Then _PrintString (CenterPrintX("Random Levels"), 560), "Random Levels" Else _PrintString (CenterPrintX("Stage " + Str$(LevelStage%)), 560), "Stage " + Str$(LevelStage%)
_Font Fonts.smaller

Minutes% = (Seconds% - (Seconds% Mod 60)) / 60
Dim t As Integer
t = Seconds% Mod 60

_PrintString (600, 560), "Score - " + Str$(CurrentScore%)
_PrintString (600, 580), "Time Left -" + Str$(Minutes%) + ":" + Str$(t)
StartLevel

For i = 1 To Level.enemies 'free all the sound buffer stream (sound stream will reload again when next gameplay starts.
    _SndClose Enemie(i).snd
Next

Color _RGB(255, 255, 255), _RGBA(0, 0, 0, 0)
'checking if the level has benn canceled by the user.
If Level.cancel Then
    'free the level background image
    _FreeImage Level.bg
    Level.cancel = 0
    GoTo start
End If

'checking if game is completed

If Level.completed Then
    ' IF COMMAND$(1) = "-loadlevel" THEN
    ' echo "Level : " + STR$(LevelStage%)
    ' echo "Time taken to complete : " + STR$(Level.time - Seconds%)
    ' END IF

    _PutImage (0, 0)-(_Width, _Height), Level.bg

    'crosfading start here -
    Dim blured&

    blured& = _CopyImage(Level.bg)
    BLURIMAGE blured&, 5
    For i = 1 To 255 Step 20
        _SetAlpha i, , blured&
        _PutImage , Level.bg
        _PutImage , blured&
        _Display
    Next

    _FreeImage blured&

    Line (200, 200)-(_Width - 200, _Height - 200), _RGBA(0, 0, 0, 180), BF
    _Font Fonts.normal
    _PrintString (CenterPrintX("Stage " + Str$(LevelStage%) + "Completed!"), 210), "Stage " + Str$(LevelStage%) + " Completed"
    _Font Fonts.smaller
    Dim a$
    a$ = "Congratulations!! You created new high score!"

    If CurrentScore% > HighScore% Then _PrintString (CenterPrintX(a$), 250), a$

    _PrintString (CenterPrintX("Score - " + Str$(CurrentScore%)), 300), "Score - " + Str$(CurrentScore%)
    _PrintString (CenterPrintX("Bonus Score - " + Str$(Seconds% * 2)), 320), "Bonus Score - " + Str$(Seconds% * 2)
    _PrintString (CenterPrintX("Total Score - " + Str$(Seconds% * 2 + CurrentScore%)), 340), "Total Score - " + Str$(Seconds% * 2 + CurrentScore%)

    If LevelStage% = MAX_LEVEL Then a$ = "Game Completed" Else a$ = "Be ready for next stage. Wait a moment..."
    _PrintString (CenterPrintX(a$), 380), a$

    Do
        If F = 1 Then SPRITESHOW ExplosionsZ(0).img: SPRITESHOW ExplosionsZ(1).img
        For i = 0 To 1
            SPRITENEXT ExplosionsZ(i).img
            SPRITEPUT ExplosionsZ(i).x, ExplosionsZ(i).y, ExplosionsZ(i).img
        Next
        _Limit W.fps
        _Display
        F = F + 1
    Loop Until F > 180
    SPRITEHIDE ExplosionsZ(0).img
    SPRITEHIDE ExplosionsZ(1).img
    
    F = 0
    If Command$(1) = "-loadlevel" Then System
    SaveGame

    If LevelStage% > MAX_LEVEL Then
        bd& = _CopyImage(0)
        For i = 0 To 255 Step 5
            _PutImage , bd&
            Line (0, 0)-(_Width, _Height), _RGBA(0, 0, 0, i), BF
            _Display
        Next
        showCredits

        GoTo start
    End If
    'free the level background image
    _FreeImage Level.bg

    GoTo newgame
End If
If Level.over Then
    Color _RGB(255, 0, 0)
    ' IF COMMAND$(1) = "-loadlevel" THEN
    ' echo "Level failed to compete"
    ' END IF

    _PutImage (0, 0)-(_Width, _Height), Level.bg
    'crosfading start here -
    blured& = _CopyImage(Level.bg)
    BLURIMAGE blured&, 5
    For i = 1 To 255 Step 20
        _SetAlpha i, , blured&
        _PutImage , Level.bg
        _PutImage , blured&
        _Display
    Next

    _FreeImage blured&
    Line (200, 250)-(_Width - 200, _Height - 250), _RGBA(0, 0, 0, 180), BF
    _Font Fonts.bigger
    _PrintString (CenterPrintX("Game Over"), 260), "Game Over"
    _Font Fonts.smaller
    _PrintString (CenterPrintX("Click To Continue..."), _Height - 280), "Click to Continue..."
    _Display

    Do
        While _MouseInput: Wend
        If _MouseButton(1) Then
            While _MouseButton(1): While _MouseInput: Wend: Wend
            Exit Do
        End If
        _Limit 30
    Loop
    GoTo start
    'free the level background image
    _FreeImage Level.bg

End If

404
_MouseShow
_Font 16
Cls
Color _RGB(255, 255, 255)
Circle (_Width / 2, 200), 100
Circle (_Width / 2 - 50, 150), 5
Circle (_Width / 2 + 50, 150), 5
Circle (_Width / 2, 250), 50, , 0, _Pi

centerPrint "An Error has ocurred!", 350
centerPrint "Error Code - " + Str$(Err), 366
If _InclErrorFile$ <> "" Then
    centerPrint "Error File - " + _InclErrorFile$, 382
    centerPrint "Error Line - " + Str$(_InclErrorLine), 398
Else
    centerPrint "Error File - Main_File", 382
    centerPrint "Error Line - " + Str$(_ErrorLine), 398
End If
End







Sub echo (m$) 'always write to console
    Dim preDest As Long
    preDest = _Dest
    _Dest _Console
    Print m$
    _Dest preDest
End Sub

Sub showNotification (message$)
    NText$ = message$
    NShow = -1
End Sub

Sub Notify ()
    Static imgy
    If NShow = -1 Then
        If NFPSCount% = 0 Then
            _Font 16
            Dim __w As Integer, h As Integer, tmp&, preDest As Long
            __w = Len(NText$) * 8 + 40
            h = 36

            tmp& = _NewImage(__w, h, 32)

            preDest = _Dest
            _Dest tmp&

            Color _RGB(10, 10, 10), _RGB(355, 245, 245)
            Cls , _RGB(255, 245, 245)
            _PrintString (20, 10), NText$

            _Dest preDest
            NImage& = _CopyImage(tmp&, 33)
            _FreeImage tmp&

            imgy = -40
        End If
        If NFPSCount% > 0 And NFPSCount% < 40 Then
            imgy = imgy + 1
            _PutImage (_Width / 2 - _Width(NImage&) / 2, imgy), NImage&
        End If
        If NFPSCount% > 40 And NFPSCount% < 160 Then
            _PutImage (_Width / 2 - _Width(NImage&) / 2, imgy), NImage&
        End If
        If NFPSCount% > 160 And NFPSCount% < 200 Then
            _PutImage (_Width / 2 - _Width(NImage&) / 2, imgy), NImage&
            imgy = imgy - 1
        End If
        NFPSCount% = NFPSCount% + 1
        If NFPSCount% > 200 Then
            _FreeImage NImage&
            NFPSCount% = 0
            NShow = 0
        End If
    End If
End Sub


Sub readConfig ()
    Dim F As Integer

    If Not _FileExists("Settings/settings.dat") Then writeConfig
    F = FreeFile
    Open "Settings/settings.dat" For Input As #F
    Input #F, W.fullscreen
    Input #F, W.music
    Input #F, W.sfx
    Input #F, W.musicV
    Input #F, W.sfxV
    Input #F, W.SE
    Input #F, W.fps
    Close #F
End Sub

Sub writeConfig ()
    Dim f As Integer

    f = FreeFile
    Open "Settings/settings.dat" For Output As #f
    Print #f, W.fullscreen
    Print #f, W.music
    Print #f, W.sfx
    Print #f, W.musicV
    Print #f, W.sfxV
    Print #f, W.SE
    Print #f, W.fps
    Close #f
End Sub

Sub createConfig ()
    W.fullscreen = 0
    W.music = -1
    W.sfx = -1
    W.musicV = 1
    W.sfxV = 1
    W.SE = -1
    W.fps = 90
    writeConfig
End Sub

Sub loadComponents ()
    If W.fullscreen = 0 Then
        If _FullScreen <> 0 Then _FullScreen _Off
    ElseIf W.fullscreen = 1 Then
        If _FullScreen <> 1 Then _FullScreen _Stretch , _Smooth
    ElseIf W.fullscreen = 2 Then
        If _FullScreen <> 2 Then _FullScreen _SquarePixels , _Smooth
    End If

    'SFXs
    ' screen_conf:
    If Gun1& = 0 Then Gun1& = _SndOpen("SFX/Gun1.ogg", "sync,vol,pause")
    If Gun2& = 0 Then Gun2& = _SndOpen("SFX/Gun2.ogg", "sync,vol,pause")
    If Bird& = 0 Then Bird& = _SndOpen("SFX/bird.ogg", "sync,vol,pause")
    If Crow& = 0 Then Crow& = _SndOpen("SFX/Crow.ogg", "sync,vol,pause")
    If Eagle& = 0 Then Eagle& = _SndOpen("SFX/Eagle.ogg", "sync,vol,pause")
    If Expos& = 0 Then Expos& = _SndOpen("SFX/Explosion.mp3", "sync,vol,pause")
    If Jet& = 0 Then Jet& = _SndOpen("SFX/Jet.ogg", "sync,vol,pause")
    If RainSound& = 0 Then RainSound& = _SndOpen("SFX/Rain.mp3", "vol,sync,pause")

    If Musics&(0) = 0 Then Musics&(0) = _SndOpen("Musics/Hunter's_Revenge-Against_Evil.mp3", "sync,vol,pause")
    If Musics&(1) = 0 Then Musics&(1) = _SndOpen("Musics/Hunter's_Revenge-End_Of_Game.mp3", "sync,vol,pause")
    If Musics&(2) = 0 Then Musics&(2) = _SndOpen("Musics/Hunter's_Revenge-Who's_Next.mp3", "sync,vol,pause")

    setMusicVol W.musicV
    If Not W.music Then 'if menu background music disable, then stop the musics, regardless of whether the are being played or not.
        _SndStop Musics&(0)
        _SndStop Musics&(1)
        _SndStop Musics&(2)
    End If

    W.done = -1
End Sub

Sub Splash ()

    Cls

    Dim stars&, x As Integer, y As Integer, F As Integer

    stars& = _NewImage(_Width * 2, _Height, 32)
    _Dest stars&
    Do
        x = Int(Rnd * _Width(stars&))
        y = Int(Rnd * _Height)
        PSet (x, y), _RGB(255, 255, 255)
        F = F + 1
    Loop Until F > 700

    Dim spT&, sp&, eft1&, p As Integer, a As Integer, xx As Integer

    _Dest 0
    spT& = _LoadImage("Images\splash.png")
    _ClearColor _RGB(0, 0, 0), spT&
    sp& = _CopyImage(spT&, 33)
    F = 0
    eft1& = _NewImage(_Width, _Height, 32)
    _Dest eft1&
    Line (0, 0)-(_Width, _Height), _RGB(0, 0, 50), BF
    _Dest 0

    p = 6
    FPSStart
    Do
        _SetAlpha a, , eft1&: _PutImage , eft1&
        _PutImage (xx, 0), stars&
        _PutImage , sp&
        xx = xx - 1
        If xx < -_Width - 2 Then xx = 0
        _Limit 60
        a = a + p
        If a > 250 Then p = -p
        If a < 6 Then p = 6
        _Display
        F% = F% + 1
        FPSCurrent% = FPSCurrent% + 1
    Loop Until F% > 360

    FPSEnd
    Cls

    _FreeImage sp&
    _FreeImage spT&
    _FreeImage eft1&
    _FreeImage stars&
End Sub

Sub FPSStart ()
    On Timer(FPSEvent, 1) FPS
    On Timer(FPSEvt, 0.01) FPSShow
    Timer(FPSEvent) On
    Timer(FPSEvt) On
End Sub

Sub FPS ()
    FPSRate% = FPSCurrent%
    FPSCurrent% = 0
End Sub

Sub FPSShow ()
    Color _RGB(255, 255, 255)
    _PrintString (720, 0), Str$(FPSRate%) + " FPS"
End Sub

Sub FPSEnd ()
    Timer(FPSEvent) Off
    Timer(FPSEvt) Off
End Sub

Sub LoaderStart ()
    Loader& = _LoadImage("Images\loader.gif", 33)
    LoaderEvt! = _FreeTimer
    On Timer(LoaderEvt!, 0.1) ShowLoader
    Timer(LoaderEvt!) On
End Sub

Sub LoaderEnd ()
    Timer(LoaderEvt!) Off
    _FreeImage Loader&
End Sub

Sub ShowLoader ()
    If LoaderCF% = 0 Then LoaderCF% = 1
    _PutImage (LoaderX%, LoaderY%), Loader&, 0, (LoaderCF% * 48 - 48, 0)-(LoaderCF% * 48 - 1, 48)
    LoaderCF% = LoaderCF% + 1
    If LoaderCF% > 8 Then LoaderCF% = 1
    _Display
End Sub

' SUB PlayMovie (m$)
' LoaderStart

' DIM f AS INTEGER, n AS LONG, i AS LONG, k AS INTEGER

' f = FREEFILE
' OPEN "Movies\" + m$ + "\" + m$ + ".txt" FOR INPUT AS #f
' INPUT #f, n
' CLOSE #f
' DIM Temps_Buffers&(n)
' FOR i = 1 TO n
' Temps_Buffers&(i) = _LOADIMAGE("Movies\" + m$ + "\produce" + LTRIM$(RTRIM$(STR$(i))) + ".jpg", 33)
' NEXT
' LoaderEnd
' FOR i = 1 TO n
' FOR k = 1 TO 3
' _PUTIMAGE , Temps_Buffers&(i)
' _DISPLAY
' NEXT
' _DELAY .05
' _FREEIMAGE Temps_Buffers&(i)
' NEXT
' ERASE Temps_Buffers&
' END SUB

Sub GameMenu ()
    _PutImage , Menubg&
    Dim n%
    'Menu background music
    If W.music Then
        n% = p5random(0, 2)
        If Not (_SndPlaying(Musics&(0)) Or _SndPlaying(Musics&(1)) Or _SndPlaying(Musics&(2))) Then _SndPlay Musics&(n%)
    End If

    On Timer(GlobalEvent, 0.01) GameMenu2
    Timer(GlobalEvent) On
    Do
        While _MouseInput: Wend
        Mouse.x = _MouseX: Mouse.y = _MouseY
        Mouse.lclick = _MouseButton(1)
        _Limit W.fps
        If MenuChoice > 0 Then Exit Do
    Loop
    Timer(GlobalEvent) Off
End Sub

Sub GameMenu2 ()
    If _ScreenIcon Then Exit Sub

    _PutImage , Menubg&
    Line (200, 130)-(_Width - 200, 450), _RGBA(0, 0, 0, 150), BF

    Dim i As Integer

    For i = 0 To 4
        Color _RGB(255, 255, 255), _RGBA(0, 0, 0, 0)
        If Mouse.x > 200 And Mouse.x < 600 And Mouse.y > GameMenus(i).y - 20 And Mouse.y < GameMenus(i).y + _FontHeight(Fonts.bigger) Then
            Line (200, GameMenus(i).y - 20)-(600, GameMenus(i).y + _FontHeight(Fonts.bigger)), _RGBA(255, 100, 0, 100), BF
            SPRITEPUT 150, GameMenus(i).y + 20, MenuBlood%
            SPRITENEXT MenuBlood%
            '       _PRINTSTRING (GameMenus(i).x, GameMenus(i).y), RTRIM$(GameMenus(i).text)
            _PutImage (200, GameMenus(i).y), GameMenus(i).img
            If Mouse.lclick Then
                Timer(GlobalEvent!) Off
                Select Case i
                    Case 0
                        MenuChoice = 1
                    Case 1
                        MenuChoice = 2
                    Case 2
                        MenuChoice = 3
                    Case 3
                        MenuChoice = 4
                    Case 4
                        MenuChoice = 5

                End Select
            End If
        Else
            '      _PRINTSTRING (GameMenus(i).x, GameMenus(i).y), RTRIM$(GameMenus(i).text)
            _PutImage (200, GameMenus(i).y), GameMenus(i).img
        End If
    Next
    If Mouse.hovering Then
        _PutImage (Mouse.x - 16, Mouse.y - 16), Mouse.cursor2
        _Display
    Else
        _PutImage (Mouse.x - 16, Mouse.y - 16), Mouse.cursor
        _Display
    End If

End Sub


Function CenterPrintX (m$)
    Dim i As Integer, a As Integer
    For i = 1 To Len(m$)
        a = a + _PrintWidth(Mid$(m$, i, 1))
    Next
    CenterPrintX = (_Width / 2) - (a / 2)
End Function

Function getCurrentLevel% ()
    If Not _FileExists("Save_Game/save.dat") Then getCurrentLevel% = 1: Exit Function
    Dim F As Integer, tmp As Integer
    F = FreeFile
    Open "Save_Game\save.dat" For Binary As #F
    Seek F, 3
    Get #F, , tmp
    getCurrentLevel% = tmp
    Close #F
End Function

Sub LoadLevel ()
    Level.completed = 0
    Level.over = 0
    Dim F As Integer
    F = FreeFile
    ' IF COMMAND$(1) = "-loadlevel" THEN
    ' GOTO skip_game_save_info
    ' END IF
    If Not _FileExists("Save_Game\save.dat") Then
        Open "Save_Game\save.dat" For Binary As #F
        LevelStage% = 1
        HighScore% = 0
        Put #F, , HighScore%
        Put #F, , LevelStage%
        Close #F
    Else
        Open "Save_Game\save.dat" For Binary As #F
        Get #F, , HighScore%
        Get #F, , LevelStage%
        Close #F
    End If
    skip_game_save_info:::
    ' echo "loading level/stage : " + STR$(LevelStage%)
    Open "Stages\Stage" + RTrim$(LTrim$(Str$(LevelStage%))) + ".dat" For Input As #F
    Input #F, Level.enemies
    Input #F, Level.scenes
    Input #F, Level.time
    Input #F, Level.mode
    Input #F, Level.background
    Close #F
    LevelStage2% = LevelStage%
    Level.bg = _LoadImage("Images\" + RTrim$(Level.background))
    Seconds% = Level.time
    OldSeconds% = Seconds%
    'LevelStage% = clevel%
End Sub

Sub StartLevel ()

    'Stop music during gameplay
    Dim i As Integer, k&, onn&, offf&, bd&, bd2&, ac&, gfx&
    If W.music Then
        For i = 0 To 2
            _SndStop Musics&(i)
        Next 'stops all musics
    End If
    If W.sfx Then updateSfxVolume

    On Timer(GameRenderingEvent, 1 / W.fps) UpdateStatus
    On Timer(TimerEvent, 1) UpdateTime
    Timer(GameRenderingEvent) On
    Timer(TimerEvent) On
    Mouse.lclick = 0
    Mouse.rclick = 0
    Mouse.mclick = 0
    Do
        While _MouseInput: Wend

        Mouse.x = _MouseX: Mouse.y = _MouseY
        If _MouseButton(1) Then
            While _MouseButton(1): While _MouseInput: Wend: Wend
            Mouse.lclick = -1
        End If
        If _MouseButton(2) Then
            While _MouseButton(2): While _MouseInput: Wend: Wend
            Mouse.rclick = -1
        End If
        If _MouseButton(3) Then
            While _MouseButton(3): While _MouseInput: Wend: Wend
            Mouse.mclick = -1
        Else Mouse.mclick = 0
        End If

        k& = _KeyHit
        If k& = 27 Or Mouse.mclick Then
            Timer(GameRenderingEvent) Off
            Timer(TimerEvent) Off
            If W.sfx Then PauseSound 'Pause the sounds

            onn& = _LoadImage("Images/on.png", 33)
            offf& = _LoadImage("Images/off.png", 33)

            bd& = _CopyImage(0)
            bd2& = _CopyImage(0)

            BLURIMAGE bd2&, 5
            gfx& = _NewImage(500, 156, 32)
            _Dest gfx&
            Cls , 0 'make it transparent
            Line (0, 0)-Step(_Width, _Height), _RGBA(0, 0, 0, 150), BF
            For i = 16 To 19
                _PutImage (0, GameMenus(i).y - 222), GameMenus(i).img2
            Next
            _Dest 0

            For i = 0 To 255 Step 10
                _SetAlpha i, , bd2&
                _PutImage , bd&
                _PutImage , bd2&
                Line (0, 0)-(_Width, _Height), _RGBA(0, 0, 0, i / 3), BF
                _PutImage (150, 222), gfx&, 0, (0, 0)-(500, p5map(i, 0, 255, 0, 136))
                _Display
            Next
            ac& = _CopyImage(0)
            Do
                While _MouseInput: Wend
                Mouse.x = _MouseX: Mouse.y = _MouseY
                Mouse.lclick = 0
                Mouse.rclick = 0
                If _MouseButton(1) Then
                    While _MouseButton(1): While _MouseInput: Wend: Wend
                    Mouse.lclick = -1
                End If
                If _MouseButton(2) Then
                    While _MouseButton(2): While _MouseInput: Wend: Wend
                    Mouse.rclick = -1
                End If

                _PutImage , ac&
                Line (150, 222)-Step(500, 136), _RGBA(0, 0, 0, 50), BF
                For i = 16 To 19
                    If Mouse.x > 150 And Mouse.x < 650 And Mouse.y > GameMenus(i).y - 10 And Mouse.y < GameMenus(i).y + 24 Then
                        If Mouse.lclick Then
                            Select Case i
                                Case 16
                                    If W.fullscreen > 0 Then W.fullscreen = 0 Else W.fullscreen = 1
                                Case 17
                                    W.musicV = W.musicV + .1
                                    If W.musicV > 1 Then W.musicV = .1
                                Case 18
                                    W.sfxV = W.sfxV + .1
                                    If W.sfxV > 1 Then W.sfxV = .1
                                Case 19
                                    Level.cancel = -1
                                    Exit Do
                            End Select
                        End If
                        Line (150, GameMenus(i).y - 10)-(650, GameMenus(i).y + 24), _RGBA(255, 100, 0, 100), BF
                    End If
                    _PutImage (150, GameMenus(i).y), GameMenus(i).img
                    Select Case i
                        Case 16
                            If W.fullscreen > 0 Then _PutImage (580, GameMenus(i).y - 3), onn& Else _PutImage (580, GameMenus(i).y - 3), offf&
                        Case 17
                            _Font Fonts.normal
                            If W.musicV > .9 Then
                                _PrintString (630 - txtWidth(" 10"), GameMenus(i).y), " 10 "
                            Else
                                _PrintString (630 - txtWidth(Str$(Int(W.musicV * 10))), GameMenus(i).y), Str$(Int(W.musicV * 10))
                            End If
                        Case 18
                            _Font Fonts.normal
                            If W.sfxV > .9 Then
                                _PrintString (630 - txtWidth(" 10"), GameMenus(i).y), " 10 "
                            Else
                                _PrintString (630 - txtWidth(Str$(Int(W.sfxV * 10))), GameMenus(i).y), Str$(Int(W.sfxV * 10))
                            End If
                    End Select
                Next
                If _KeyHit = 27 Or _MouseButton(3) Then Exit Do
                _Limit W.fps
                _PutImage (Mouse.x - 8, Mouse.y - 8), Mouse.cursor
                _Display
            Loop
            For i = 255 To 0 Step -10
                _SetAlpha i, , bd2&
                _PutImage , bd&
                _PutImage , bd2&
                Line (0, 0)-(_Width, _Height), _RGBA(0, 0, 0, i / 3), BF
                _PutImage (150, 222), gfx&, 0, (0, 0)-(500, p5map(i, 0, 255, 0, 222))
                _Display
            Next

            _PutImage , bd& 'Erase that menu line
            _FreeImage bd&
            _FreeImage bd2&
            _FreeImage ac&
            _FreeImage gfx&
            _FreeImage onn&
            _FreeImage offf&
            loadComponents

            If W.sfx Then 'update the sfx volume and play the paused sound.
                updateSfxVolume
                If Not Level.cancel Then PlayPausedSound
            End If

            Timer(GameRenderingEvent) On
            Timer(TimerEvent) On

            If Level.cancel Then Exit Do
        End If
        _Limit W.fps
    Loop Until Level.completed Or Level.over
    Timer(GameRenderingEvent) Off
    CloseTime
    For i = 0 To 20
        If Bloods(i).active Then
            Bloods(i).active = 0
            SPRITEHIDE Bloods(i).img
        End If
        If explosions(i).active Then
            explosions(i).active = 0
            SPRITEHIDE explosions(i).img
        End If
    Next
    For i = 0 To UBound(ShotScore)
        ShotScore(i).active = 0
    Next
End Sub

Sub UpdateStatus ()
    ' $checking:off
    Static thunder_f_count, thunder_ha_count, thunder_ha_count_limit
    Dim i As Integer, t As Integer, tmp&, tmp2&

    If Seconds% < OldSeconds% Or OldScore% < CurrentScore% Then _PutImage (0, 0)-(_Width, _Height), Level.bg

    If _ScreenIcon Then Exit Sub
    For i = 1 To Level.enemies
        If Enemie(i).u = Level.u And Enemie(i).active = 0 And Enemie(i).scene = Level.currentScene Then
            Enemie(i).active = -1
            PlayEnemieMusic i
            'echo "[New Enemie] (Scene " + STR$(Level.currentScene) + ")"
            'echo "Type : " + Enemie(i).typ
            'echo "u : " + STR$(Enemie(i).u)
            'echo "Current u : " + STR$(Enemie(i).u)
            'echo " Enemie Scene : " + STR$(Enemie(i).scene)
            'echo "Enemie Movement : " + STR$(Enemie(i).m)
        End If
    Next
    For i = 1 To Level.enemies
        If Enemie(i).active And Enemie(i).scene = Level.currentScene Then
            'IF Enemie(i).u = Level.u THEN
            '    echo "Rendered"
            '    echo "********************************************************************************"
            'END IF
            If Enemie(i).f > Enemie(i).n Then SPRITENEXT Enemie(i).img: Enemie(i).f = 0

            SPRITEPUT Enemie(i).x, Enemie(i).y, Enemie(i).img

            Enemie(i).x = Enemie(i).x + Enemie(i).m
            Enemie(i).f = Enemie(i).f + 1

            If W.SE Then _SndBal Enemie(i).snd, p5map(Enemie(i).x, 0, _Width, -1, 1), p5map(Enemie(i).y, 0, _Height, 1, -1), , 2

            If Enemie(i).x > _Width + SPRITECURRENTWIDTH(Enemie(i).img) Then Enemie(i).m = -Enemie(i).m: SPRITEFLIP Enemie(i).img, HORIZONTAL: PlayEnemieMusic i
            If Enemie(i).x < -SPRITECURRENTWIDTH(Enemie(i).img) Then Enemie(i).m = -Enemie(i).m: SPRITEFLIP Enemie(i).img, NONE: PlayEnemieMusic i

            If Mouse.x > SPRITEX1(Enemie(i).img) And Mouse.x < SPRITEX2(Enemie(i).img) And Mouse.y > SPRITEY1(Enemie(i).img) And Mouse.y < SPRITEY2(Enemie(i).img) Then
                Mouse.hovering = -1

                If Mouse.lclick Then Enemie(i).life = Enemie(i).life - Gun.damage
                If Enemie(i).life < 0 Then Enemie(i).life = 0

                'Showing Enemie current life with life bar
                If Enemie(i).life = 0 Then
                    _PutImage (Enemie(i).x - SPRITECURRENTWIDTH(Enemie(i).img) / 2, Enemie(i).y - 30), lifeBars(0)
                Else
                    _PutImage (Enemie(i).x - SPRITECURRENTWIDTH(Enemie(i).img) / 2, Enemie(i).y - 30), lifeBars(Int(Enemie(i).life / Enemie(i).life2 * 100) - 1) 'shows life bar :)
                End If
            End If
            'checking if any enemie is dead :D
            If Enemie(i).life = 0 Then
                SPRITEHIDE Enemie(i).img
                Enemie(i).ending = -1
                Enemie(i).active = 0
                StopEnemieMusic i
                'echo "[Enemie Dead]"
                'echo "Type : " + Enemie(i).typ
                'echo "Enemie Scene" + STR$(Enemie(i).scene)
                'echo "--------------------------------------------------------------------------------------"
                'You will get more score with ShotGun :P

                If Gun.id = 1 Then CurrentScore% = CurrentScore% + Int(Enemie(i).points * 1.4)

                MakeScoreFlash Enemie(i).x, Enemie(i).y, Enemie(i).points
                CurrentScore% = CurrentScore% + Enemie(i).points
                MakeBloods Enemie(i).x, Enemie(i).y, Enemie(i).typ
            End If
        End If
    Next

    If Mouse.rclick Then
        If Gun.id = 1 Then Gun.id = 2: Gun.name = "Ak-47": Gun.damage = 6 Else Gun.id = 1: Gun.name = "Shot Gun": Gun.damage = 3
        Mouse.rclick = 0
    End If
    For i = 0 To 20
        If Bloods(i).active Then
            If Bloods(i).f > Bloods(i).n Then SPRITENEXT Bloods(i).img: Bloods(i).f = 0: Bloods(i).currentFrame = Bloods(i).currentFrame + 1
            Bloods(i).f = Bloods(i).f + 1
            SPRITEPUT Bloods(i).x, Bloods(i).y, Bloods(i).img
            If Bloods(i).currentFrame > Bloods(i).totalFrames * 2 Then Bloods(i).active = 0: SPRITEHIDE Bloods(i).img
        End If
    Next
    For i = 0 To 20
        If explosions(i).active Then
            If explosions(i).f > explosions(i).n Then SPRITENEXT explosions(i).img: explosions(i).f = 0: explosions(i).currentFrame = explosions(i).currentFrame + 1
            explosions(i).f = explosions(i).f + 1
            SPRITEPUT explosions(i).x, explosions(i).y, explosions(i).img
            If explosions(i).currentFrame > explosions(i).totalFrames Then explosions(i).active = 0: SPRITEHIDE explosions(i).img
        End If
    Next

    If Seconds% < OldSeconds% Or OldScore% < CurrentScore% Then
        If Seconds% < 1 Then Level.over = -1
        OldSeconds% = Seconds%
        OldScore% = CurrentScore%
        If Seconds% < 11 Then Color _RGB(255, 0, 0) Else Color _RGB(255, 255, 255)
        'redraw scoreboard
        _PutImage (0, 520), ScoreBoard&
        _PutImage (50, 550)-(170, 590), GunImg&(Gun.id - 1)
        _Font Fonts.smaller
        _PrintString (40, 580), RTrim$(Gun.name)
        _PrintString (600, 560), "Score - " + Str$(CurrentScore%)
        If Seconds% >= 60 Then t = Seconds% Mod 60 Else t = Seconds%
        _PrintString (600, 580), "Time left - " + Str$(Minutes%) + ":" + Str$(t)
        _Font Fonts.normal
        If randomLevels Then _PrintString (CenterPrintX("Random Levels"), 560), "Random Levels" Else _PrintString (CenterPrintX("Stage " + Str$(LevelStage%)), 560), "Stage " + Str$(LevelStage%)

    End If

    Level.u = Level.u + 1
    'creating new game scene
    If SceneEnd(Level.currentScene) Then
        Level.currentScene = Level.currentScene + 1
        Level.u = 0
        'echo "Current Scene : " + STR$(Level.currentScene)
        If Level.currentScene > Level.scenes Then Level.completed = -1
    End If

    'game MODS
    Select Case Level.mode
        Case FOGMODE
            Fogs.x = Fogs.x - Fogs.move
            If Fogs.x < -1600 Or Fogs.x > 0 Then Fogs.move = -Fogs.move
            _PutImage (Fogs.x, 0), Fogs.handle

        Case THUNDERMODE
            FallDrops
            DrawDrops

        Case STORMMODE
            _PutImage (StormX%, 0), StormImg&
            StormX% = StormX% - 1
            If StormX% < -2300 Then StormX% = 0

        Case FOGMODE + THUNDERMODE
            Fogs.x = Fogs.x - Fogs.move
            If Fogs.x < -1600 Or Fogs.x > 0 Then Fogs.move = -Fogs.move
            _PutImage (Fogs.x, 0), Fogs.handle

            FallDrops
            DrawDrops

        Case FOGMODE + THUNDERMODE + 7
            Fogs.x = Fogs.x - Fogs.move
            If Fogs.x < -1600 Or Fogs.x > 0 Then Fogs.move = -Fogs.move
            _PutImage (Fogs.x, 0), Fogs.handle

            FallDrops
            DrawDrops
        Case STORMMODE + THUNDERMODE
            _PutImage (StormX%, 0), StormImg&
            StormX% = StormX% - 1
            If StormX% < -2300 Then StormX% = 0

            FallDrops
            DrawDrops

        Case STORMMODE + FOGMODE + THUNDERMODE
            Fogs.x = Fogs.x - Fogs.move
            If Fogs.x < -1600 Or Fogs.x > 0 Then Fogs.move = -Fogs.move
            _PutImage (Fogs.x, 0), Fogs.handle

            _PutImage (StormX%, 0), StormImg&
            StormX% = StormX% - 1
            If StormX% < -2300 Then StormX% = 0

            FallDrops
            DrawDrops

    End Select

    'scores effect
    For i = 0 To UBound(ShotScore)
        If ShotScore(i).active = -1 Then
            ShotScore(i).sclX = Sin(ShotScore(i).__ops) * .5 + .5
            _PutImage (ShotScore(i).x - (ShotScore(i).sclX * _Width(ShotScore(i).img) / 2), ShotScore(i).y - (ShotScore(i).sclX * _Height(ShotScore(i).img)) / 2)-(ShotScore(i).x + (ShotScore(i).sclX * _Width(ShotScore(i).img)) / 2, ShotScore(i).y + (ShotScore(i).sclX * _Height(ShotScore(i).img)) / 2), ShotScore(i).img
            ShotScore(i).__ops = ShotScore(i).__ops + .1
            If ShotScore(i).__ops > _Pi(1.5) Then
                ShotScore(i).active = 0
            End If
        End If
    Next

    'countdown when game time is less or equal to 10s
    If Seconds% < 11 Then
        Color _RGB(255, 0, 0)
        _Font Fonts.biggest
        _PrintString (CenterPrintX(RTrim$(LTrim$(Str$(Seconds%)))), _Height / 2 - _FontHeight / 2), RTrim$(LTrim$(Str$(Seconds%)))
    End If

    'cursors
    If Mouse.lclick Then
        Mouse.lclick = 0
        If W.sfx Then
            If Gun.id = 1 Then _SndPlayCopy Gun1& Else _SndPlayCopy Gun2&
        End If
    End If
    If Mouse.hovering Then
        Mouse.hovering = 0
        _PutImage (Mouse.x - 16, Mouse.y - 16), Mouse.cursor2
    Else
        _PutImage (Mouse.x - 16, Mouse.y - 16), Mouse.cursor
    End If

    If Level.mode = THUNDERMODE Or Level.mode = THUNDERMODE + FOGMODE + 7 Then
        If thunder_ha_count_limit = 0 Then thunder_ha_count_limit = p5random(1, 4)
        If ThunderEvent = 0 Then ThunderEvent = p5random(30, 340)
        ThunderCount = ThunderCount + 1
        If ThunderCount > ThunderEvent Then
            thunder_f_count = thunder_f_count + 1
            tmp& = _CopyImage(0)
            tmp2& = _CopyImage(0)
            MakeThunderImage tmp&
            _PutImage , tmp&
            _Display
            _PutImage , tmp2&
            _FreeImage tmp&
            _FreeImage tmp2&
            If thunder_f_count > 3 Then
                If thunder_ha_count < thunder_ha_count_limit Then
                    ' ThunderCount = 0
                    thunder_f_count = 0
                    ThunderEvent = ThunderEvent + p5random(4, 25) + 3
                    thunder_ha_count = thunder_ha_count + 1
                Else
                    thunder_ha_count = 0
                    thunder_f_count = 0
                    ThunderEvent = 0
                    ThunderCount = 0
                    thunder_ha_count_limit = p5random(1, 4)
                End If
            End If
        Else
            _Display
        End If
    Else
        _Display
    End If
    ' $checking:on
End Sub

Sub MakeBloods (x, y, typ As String * 16)
    Select Case RTrim$(typ)
        Case "jet1", "jet2", "jet3"
            MakeExplosions x, y
            Exit Sub
    End Select
    Dim i As Integer
    For i = 0 To 20
        If Bloods(i).active = 0 Then
            Bloods(i).active = -1
            Bloods(i).x = x
            Bloods(i).y = y
            Bloods(i).currentFrame = 1
            SPRITESHOW Bloods(i).img
            Exit Sub
        End If
    Next
End Sub

Sub MakeExplosions (x, y)
    Dim i As Integer
    For i = 0 To 20
        If explosions(i).active = 0 Then
            explosions(i).active = -1
            explosions(i).x = x
            explosions(i).y = y
            explosions(i).currentFrame = 1
            SPRITESHOW explosions(i).img
            If W.sfx Then _SndPlay Expos&
            Exit Sub
        End If
    Next
End Sub

Sub MakeScoreFlash (x, y, s)
    Dim i As Integer
    For i = 0 To UBound(ShotScore)
        If ShotScore(i).active = 0 Then
            ShotScore(i).active = -1
            ShotScore(i).x = x
            ShotScore(i).y = y
            ShotScore(i).__ops = -_Pi(.5)
            Select Case s
                Case 10
                    ShotScore(i).img = scoresImage(0)
                Case 20
                    ShotScore(i).img = scoresImage(1)
                Case 35
                    ShotScore(i).img = scoresImage(2)
                Case 50
                    ShotScore(i).img = scoresImage(3)
                Case 75
                    ShotScore(i).img = scoresImage(4)
                Case 100
                    ShotScore(i).img = scoresImage(5)
            End Select
        End If
    Next
End Sub

Sub UpdateTime ()
    Seconds% = Seconds% - 1
    Minutes% = (Seconds% - (Seconds% Mod 60)) / 60
End Sub

Sub CloseTime
    Timer(TimerEvent) Off
End Sub

Sub PlayEnemieMusic (which&)
    If W.sfx = 0 Then Exit Sub

    _SndPlay Enemie(which&).snd
End Sub

Sub StopEnemieMusic (which&)
    _SndStop Enemie(which&).snd
    Enemie(which&).sndPaused = 2 '2 for stop and 1 for paused
End Sub

Sub updateSfxVolume ()
    If Not W.sfx Then Exit Sub

    Dim i As Integer
    For i = 1 To Level.enemies
        _SndVol Enemie(i).snd, W.sfxV
    Next
    _SndVol RainSound&, W.sfxV
End Sub

Sub setMusicVol (v!)
    If Not W.music Then Exit Sub
    _SndVol Musics&(0), v!
    _SndVol Musics&(1), v!
    _SndVol Musics&(2), v!
End Sub

Sub PlayPausedSound ()
    Dim i As Integer
    For i = 1 To Level.enemies
        If Enemie(i).sndPaused = 1 Then Enemie(i).sndPaused = 0: _SndPlay Enemie(i).snd
    Next
    If Level.mode = THUNDERMODE Or Level.mode = FOGMODE + THUNDERMODE Then
        If Not _SndPlaying(RainSound&) Then _SndPlay RainSound&
    End If
End Sub

Sub PauseSound ()

    Dim i As Integer
    For i = 1 To Level.enemies
        If Enemie(i).sndPaused = 0 Then _SndStop Enemie(i).snd: Enemie(i).sndPaused = 1
    Next

    If _SndPlaying(RainSound&) Then _SndStop RainSound&

End Sub

Function SceneEnd (which%)
    Dim i As Integer, d As _Byte

    For i = 1 To Level.enemies
        If Enemie(i).ending = 0 And Enemie(i).scene = which% Then d = -1: Exit For
    Next
    If d = 0 Then SceneEnd = -1 Else SceneEnd = 0
End Function

Sub SaveGame ()
    Dim a$, F As Integer
    a$ = "Save_Game\save.dat"
    Kill a$
    F = FreeFile
    LevelStage% = LevelStage% + 1
    Open a$ For Binary As #F
    If HighScore% < CurrentScore% Then Put #F, , CurrentScore% Else Put #F, , HighScore%
    Put #F, , LevelStage%
    Close #F
End Sub

Sub SetupRain ()
    Dim i As Integer
    For i = 0 To UBound(Drop)
        Drop(i).x = Rnd * _Width
        Drop(i).y = -(Rnd * (_Height * 3))
        Drop(i).z = Int(Rnd * 1)
        Drop(i).yspeed = Map(Drop(i).z, 0, 1, 1, 2)
        Drop(i).len = Map(Drop(i).z, 0, 1, 8, 16)
        Drop(i).gravity = Map(Drop(i).z, 0, 1, 0.1, 0.3)
    Next
    RainVol# = -1.0
End Sub

Sub FallDrops ()
    Dim i As Integer
    For i = 0 To UBound(Drop)
        Drop(i).y = Drop(i).y + Drop(i).yspeed
        Drop(i).yspeed = Drop(i).yspeed + Drop(i).gravity
        If Drop(i).y > _Height Then Drop(i).y = Rnd * -400: Drop(i).yspeed = Map(Drop(i).z, 0, 1, 1, 2)
    Next
End Sub

Sub DrawDrops ()
    Dim i As Integer
    If W.sfx Then
        ' IF RainVol# < .98 THEN RainVol# = RainVol# + 0.01: _SNDBAL RainSound&, 0, 0, RainVol#
        If Not _SndPlaying(RainSound&) Then _SndPlay RainSound&
    End If
    For i = 0 To UBound(Drop)
        If Drop(i).z = 0 Then _PutImage (Drop(i).x, Drop(i).y), Rainx8& Else _PutImage (Drop(i).x, Drop(i).y), Rainx16&
    Next

End Sub


Function Map (value, r1, r2, e1, e2)
    If value = r1 Then Map = e1
    If value = r2 Then Map = e2
End Function

Sub MakeThunderImage (original_img&)
    If original_img& = -1 Then Exit Sub

    $Checking:Off
    Dim buffer As _MEM, o As _Offset, o2 As _Offset
    Dim b As _Unsigned _Byte, n As _Byte
    n = p5random(30, 120)

    buffer = _MemImage(original_img&)
    o = buffer.OFFSET
    o2 = o + _Width(original_img&) * _Height(original_img&) * 4
    Do
        ' echo str$(o)
        b = _MemGet(buffer, o, _Unsigned _Byte)
        If b + n < 256 Then b = b + n Else b = 255
        _MemPut buffer, o, b As _UNSIGNED _BYTE
        b = _MemGet(buffer, o + 1, _Unsigned _Byte)
        If b + n < 256 Then b = b + n Else b = 255
        _MemPut buffer, o + 1, b As _UNSIGNED _BYTE
        b = _MemGet(buffer, o + 2, _Unsigned _Byte)
        If b + n < 256 Then b = b + n Else b = 255
        _MemPut buffer, o + 2, b As _UNSIGNED _BYTE
        o = o + 4
    Loop Until o = o2
    _MemFree buffer
    $Checking:On
End Sub

Sub centerImage (img&)
    _PutImage ((_Width / 2) - (_Width(img&) / 2), (_Height / 2) - (_Height(img&) / 2))-Step(_Width(img&), _Height(img&)), img&
End Sub

Sub showCredits ()
    Dim k&, f&, i As Integer, f2&, yy As Integer

    k& = _LoadImage("Images/credits.png", 33)
    f& = _NewImage(_Width(k&), _Height(k&), 32)
    _Dest f&
    For i = 0 To 255
        Line (0, (_Height - 255) + i)-(_Width, (_Height - 255) + i), _RGBA(0, 0, 0, i)
        Line (0, 255 - i)-(_Width, 255 - i), _RGBA(0, 0, 0, i)
    Next
    _Dest 0
    f2& = _CopyImage(f&, 33)
    Swap f&, f2&
    _FreeImage f2&
    yy = _Height + 50
    Do

        _PutImage (50, yy), k&
        _PutImage , f&
        yy = yy - 1

        _Display
        _Limit W.fps
    Loop Until yy < -_Height(k&)
    _FreeImage f&
    _FreeImage k&
End Sub

' SUB showCredits2 ()
' CLS
' _FONT Fonts.bigger
' _PRINTSTRING (CenterPrintX("Super Hunters 2017-18"), 250), "Super Hunters 2017-18"
' _FONT Fonts.normal
' _PRINTSTRING (CenterPrintX("By Ashish Kushwaha"), 290), "By Ashish Kushwaha"
' initTextParticles _RGB(255, 255, 255)
' CLS
' DO
' CLS
' moveTextParticles
' _LIMIT W.fps
' _DISPLAY
' LOOP UNTIL Text_Particles_Status = 1
' _DELAY 1
' fallTextParticles "fall"
' CLS
' _FONT Fonts.bigger
' _PRINTSTRING (CenterPrintX("Programmer"), 250), "Programmer"
' _FONT Fonts.normal
' _PRINTSTRING (CenterPrintX("Ashish Kushwaha"), 290), "Ashish Kushwaha"
' initTextParticles _RGB(255, 255, 255)
' ' _DISPLAY: SLEEP
' CLS
' DO
' CLS
' moveTextParticles
' _LIMIT W.fps
' _DISPLAY
' LOOP UNTIL Text_Particles_Status = 1
' _DELAY 1
' fallTextParticles "lessgravity"
' CLS
' _FONT Fonts.bigger
' _PRINTSTRING (CenterPrintX("Graphic Designer"), 250), "Graphic Designer"
' _FONT Fonts.normal
' _PRINTSTRING (CenterPrintX("Google Images & Ashish Kushwaha"), 290), "Google Images & Ashish Kushwaha"
' initTextParticles _RGB(255, 255, 255)
' CLS
' DO
' CLS
' moveTextParticles
' _LIMIT W.fps
' _DISPLAY
' LOOP UNTIL Text_Particles_Status = 1
' _DELAY 1
' fallTextParticles "explode"
' CLS
' _FONT Fonts.bigger
' _PRINTSTRING (CenterPrintX("Level Designer"), 250), "Level Designer"
' _FONT Fonts.normal
' _PRINTSTRING (CenterPrintX("Ashish Kushwaha"), 290), "Ashish Kushwaha"
' initTextParticles _RGB(255, 255, 255)
' CLS
' DO
' CLS
' moveTextParticles
' _LIMIT W.fps
' _DISPLAY
' LOOP UNTIL Text_Particles_Status = 1
' _DELAY 1
' fallTextParticles "horizontal"
' CLS
' _FONT Fonts.bigger
' _PRINTSTRING (CenterPrintX("Special Thanks -"), 230), "Special Thanks -"
' _FONT Fonts.normal
' _PRINTSTRING (CenterPrintX("Terry Ritchie for sprite library"), 270), "Terry Ritchie for sprite library"
' _PRINTSTRING (CenterPrintX("Unseenmachine & Waltersmind for BlurImage"), 320), "Unseenmachine & Waltersmind for BlurImage"
' _PRINTSTRING (CenterPrintX("and player of this game!"), 345), "and player of this game!"
' initTextParticles _RGB(255, 255, 255)
' CLS
' DO
' CLS
' moveTextParticles
' _LIMIT W.fps
' _DISPLAY
' LOOP UNTIL Text_Particles_Status = 1
' _DELAY 1
' fallTextParticles "boom"

' END SUB

' SUB initTextParticles (which~&)
' SHARED Text_Particles() AS Vector_Particles_Text_Type
' FOR y = 0 TO _HEIGHT - 1
' FOR x = 0 TO _WIDTH - 1
' col~& = POINT(x, y)
' IF col~& = which~& THEN n = n + 1
' NEXT x, y

' REDIM Text_Particles(n) AS Vector_Particles_Text_Type
' n = 0
' Text_Particles_Color = which~&
' FOR x = 0 TO _WIDTH - 1
' FOR y = 0 TO _HEIGHT - 1
' col~& = POINT(x, y)
' IF col~& = which~& THEN
' Text_Particles(n).x = x
' Text_Particles(n).y = y
' Text_Particles(n).vx = p5random(0, _WIDTH)
' Text_Particles(n).vy = p5random(0, _HEIGHT)
' Text_Particles(n).dist = dist(Text_Particles(n).vx, Text_Particles(n).vy, Text_Particles(n).x, Text_Particles(n).y)
' Text_Particles(n).distX = ABS(Text_Particles(n).x - Text_Particles(n).vx)
' Text_Particles(n).distY = ABS(Text_Particles(n).y - Text_Particles(n).vy)
' n = n + 1
' END IF
' NEXT y, x
' END SUB

' SUB moveTextParticles ()
' SHARED Text_Particles() AS Vector_Particles_Text_Type
' FOR i = 0 TO UBOUND(Text_Particles)
' IF Text_Particles(i).k < Text_Particles(i).dist THEN
' PSET (Text_Particles(i).vx + Text_Particles(i).delX, Text_Particles(i).vy + Text_Particles(i).delY), Text_Particles_Color
' IF Text_Particles(i).vx > Text_Particles(i).x THEN Text_Particles(i).delX = Text_Particles(i).delX - Text_Particles(i).distX / Text_Particles(i).dist ELSE Text_Particles(i).delX = Text_Particles(i).delX + Text_Particles(i).distX / Text_Particles(i).dist
' IF Text_Particles(i).vy > Text_Particles(i).y THEN Text_Particles(i).delY = Text_Particles(i).delY - Text_Particles(i).distY / Text_Particles(i).dist ELSE Text_Particles(i).delY = Text_Particles(i).delY + Text_Particles(i).distY / Text_Particles(i).dist
' Text_Particles(i).k = Text_Particles(i).k + 1
' ELSE
' PSET (Text_Particles(i).x, Text_Particles(i).y), Text_Particles_Color
' check = check + 1
' END IF
' NEXT
' IF check >= UBOUND(text_particles) THEN Text_Particles_Status = 1: EXIT SUB ELSE Text_Particles_Status = 0

' END SUB

' SUB fallTextParticles (typ$)
' SHARED Text_Particles() AS Vector_Particles_Text_Type
' typ$ = LCASE$(typ$)
' SELECT CASE typ$
' CASE "explode"
' FOR i = 0 TO UBOUND(Text_Particles)
' Text_Particles(i).vx = 0
' Text_Particles(i).vy = 0
' Text_Particles(i).delX = p5random(-0.1, 0.1)
' Text_Particles(i).delY = p5random(-0.1, 0.1)
' NEXT
' DO
' CLS
' z = 0
' FOR i = 0 TO UBOUND(Text_Particles)

' PSET (Text_Particles(i).x, Text_Particles(i).y), Text_Particles_Color
' IF i < array_len THEN
' Text_Particles(i).x = Text_Particles(i).x + Text_Particles(i).vx
' Text_Particles(i).y = Text_Particles(i).y + Text_Particles(i).vy
' Text_Particles(i).vx = Text_Particles(i).vx + Text_Particles(i).delX
' Text_Particles(i).vy = Text_Particles(i).vy + Text_Particles(i).delY
' END IF
' IF Text_Particles(i).x > _WIDTH OR Text_Particles(i).x < 0 OR Text_Particles(i).y > _HEIGHT OR Text_Particles(i).y < 0 THEN z = z + 1
' NEXT
' IF array_len < UBOUND(Text_Particles) THEN array_len = array_len + steps
' _DISPLAY
' _LIMIT W.fps
' steps = steps + 1
' IF z > UBOUND(Text_Particles) THEN EXIT DO
' LOOP UNTIL INKEY$ <> ""
' EXIT SUB
' CASE "fall"
' FOR i = 0 TO UBOUND(text_particles)
' Text_Particles(i).vx = 0
' Text_Particles(i).vy = 0
' Text_Particles(i).delX = p5random(-.02, .02)
' Text_Particles(i).delY = p5random(0.1, 0.2)
' NEXT
' DO
' CLS
' z = 0
' FOR i = 0 TO UBOUND(text_particles)
' PSET (Text_Particles(i).x, Text_Particles(i).y), Text_Particles_Color
' IF i < array_len THEN
' Text_Particles(i).x = Text_Particles(i).x + Text_Particles(i).vx
' Text_Particles(i).y = Text_Particles(i).y + Text_Particles(i).vy
' Text_Particles(i).vx = Text_Particles(i).vx + Text_Particles(i).delX
' Text_Particles(i).vy = Text_Particles(i).vy + Text_Particles(i).delY
' END IF
' IF Text_Particles(i).x > _WIDTH OR Text_Particles(i).x < 0 OR Text_Particles(i).y > _HEIGHT OR Text_Particles(i).y < 0 THEN z = z + 1
' NEXT
' IF array_len < UBOUND(text_particles) THEN array_len = array_len + steps
' _DISPLAY
' _LIMIT W.fps
' steps = steps + 1
' IF z = UBOUND(text_particles) THEN EXIT DO
' LOOP
' EXIT SUB

' CASE "lessgravity"
' FOR i = 0 TO UBOUND(Text_Particles)
' Text_Particles(i).vx = 0
' Text_Particles(i).vy = 0
' Text_Particles(i).delX = p5random(-.02, .02)
' Text_Particles(i).delY = p5random(-0.1, -0.2)
' NEXT
' DO
' CLS
' z = 0
' FOR i = 0 TO UBOUND(Text_Particles)
' PSET (Text_Particles(i).x, Text_Particles(i).y), Text_Particles_Color
' IF i < array_len THEN
' Text_Particles(i).x = Text_Particles(i).x + Text_Particles(i).vx
' Text_Particles(i).y = Text_Particles(i).y + Text_Particles(i).vy
' Text_Particles(i).vx = Text_Particles(i).vx + Text_Particles(i).delX
' Text_Particles(i).vy = Text_Particles(i).vy + Text_Particles(i).delY
' END IF
' IF Text_Particles(i).x > _WIDTH OR Text_Particles(i).x < 0 OR Text_Particles(i).y > _HEIGHT OR Text_Particles(i).y < 0 THEN z = z + 1
' NEXT
' IF array_len < UBOUND(Text_Particles) THEN array_len = array_len + steps
' _DISPLAY
' _LIMIT W.fps
' steps = steps + 1
' LOOP UNTIL INKEY$ <> "" OR z >= UBOUND(text_particles)
' EXIT SUB
' CASE "horizontal"
' FOR i = 0 TO UBOUND(Text_Particles)
' Text_Particles(i).vx = 0
' Text_Particles(i).vy = 0
' Text_Particles(i).delX = p5random(-.2, .2)
' Text_Particles(i).delY = 0
' NEXT
' DO
' CLS
' z = 0
' FOR i = 0 TO UBOUND(Text_Particles)
' PSET (Text_Particles(i).x, Text_Particles(i).y), Text_Particles_Color
' Text_Particles(i).x = Text_Particles(i).x + Text_Particles(i).vx
' Text_Particles(i).y = Text_Particles(i).y + Text_Particles(i).vy
' Text_Particles(i).vx = Text_Particles(i).vx + Text_Particles(i).delX
' Text_Particles(i).vy = Text_Particles(i).vy + Text_Particles(i).delY
' IF Text_Particles(i).x > _WIDTH OR Text_Particles(i).x < 0 OR Text_Particles(i).y > _HEIGHT OR Text_Particles(i).y < 0 THEN z = z + 1
' NEXT
' _DISPLAY
' _LIMIT W.fps
' LOOP UNTIL INKEY$ <> "" OR z >= UBOUND(text_particles)
' EXIT SUB
' CASE "vertical"
' FOR i = 0 TO UBOUND(Text_Particles)
' Text_Particles(i).vx = 0
' Text_Particles(i).vy = 0
' Text_Particles(i).delX = 0
' Text_Particles(i).delY = p5random(-0.2, 0.2)
' NEXT
' DO
' CLS
' z = 0
' FOR i = 0 TO UBOUND(Text_Particles)
' PSET (Text_Particles(i).x, Text_Particles(i).y), Text_Particles_Color

' Text_Particles(i).x = Text_Particles(i).x + Text_Particles(i).vx
' Text_Particles(i).y = Text_Particles(i).y + Text_Particles(i).vy
' Text_Particles(i).vx = Text_Particles(i).vx + Text_Particles(i).delX
' Text_Particles(i).vy = Text_Particles(i).vy + Text_Particles(i).delY

' IF Text_Particles(i).x > _WIDTH OR Text_Particles(i).x < 0 OR Text_Particles(i).y > _HEIGHT OR Text_Particles(i).y < 0 THEN z = z + 1
' NEXT
' _DISPLAY
' _LIMIT W.fps
' LOOP UNTIL INKEY$ <> "" OR z >= UBOUND(text_particles)
' EXIT SUB

' CASE "boom"
' FOR i = 0 TO UBOUND(Text_Particles)
' Text_Particles(i).vx = 0
' Text_Particles(i).vy = 0
' Text_Particles(i).delX = p5random(-.1, .1)
' Text_Particles(i).delY = p5random(-0.1, 0.1)
' NEXT
' DO
' CLS
' steps = 0
' FOR i = 0 TO UBOUND(Text_Particles)
' PSET (Text_Particles(i).x, Text_Particles(i).y), Text_Particles_Color
' Text_Particles(i).x = Text_Particles(i).x + Text_Particles(i).vx
' Text_Particles(i).y = Text_Particles(i).y + Text_Particles(i).vy
' Text_Particles(i).vx = Text_Particles(i).vx + Text_Particles(i).delX
' Text_Particles(i).vy = Text_Particles(i).vy + Text_Particles(i).delY
' IF Text_Particles(i).x > _WIDTH OR Text_Particles(i).x < 0 OR Text_Particles(i).y > _HEIGHT OR Text_Particles(i).y < 0 THEN steps = steps + 1
' NEXT
' _DISPLAY
' _LIMIT W.fps
' IF steps > UBOUND(Text_Particles) THEN EXIT DO
' LOOP UNTIL INKEY$ <> "" OR steps > UBOUND(text_particles)
' EXIT SUB
' END SELECT
' END SUB

Sub centerPrint (a$, b)
    Dim i As Integer, v As Integer
    For i = 1 To Len(a$)
        v = v + _PrintWidth(Mid$(a$, i, 1))
    Next
    _PrintString (_Width / 2 - v / 2, b), a$
End Sub

Function txtWidth (a$)
    Dim i As Integer, v As Integer, g As Integer
    For i = 1 To Len(a$)
        g = _PrintWidth(Mid$(a$, i, 1))
        v = v + g
    Next
    txtWidth = v
End Function
'these p5random(), p5map! (original map!) and dist() functions are taken from p5js.bas
Function p5random! (mn!, mx!)
    Dim tmp!

    If mn! > mx! Then
        tmp! = mn!
        mn! = mx!
        mx! = tmp!
    End If
    p5random! = Rnd * (mx! - mn!) + mn!
End Function

Function dist! (x1!, y1!, x2!, y2!)
    dist! = Sqr((x2! - x1!) ^ 2 + (y2! - y1!) ^ 2)
End Function

Function p5map! (value!, minRange!, maxRange!, newMinRange!, newMaxRange!)
    p5map! = ((value! - minRange!) / (maxRange! - minRange!)) * (newMaxRange! - newMinRange!) + newMinRange!
End Function


'By UnseenMachine & Waltersmind
'http://www.qb64.net/forum/index.php?topic=12658
Sub BLURIMAGE (Image As Long, Blurs As _Unsigned Integer)

    Dim ImageMemory As _MEM
    Dim ImageOffsetCurrent As _Offset
    Dim ImageOffsetStart As _Offset
    Dim ImageOffsetEnd As _Offset

    Dim TopOffset As _Offset
    Dim LeftOffset As _Offset
    Dim RightOffset As _Offset
    Dim BottomOffset As _Offset

    Dim Red1 As _Unsigned _Byte
    Dim Green1 As _Unsigned _Byte
    Dim Blue1 As _Unsigned _Byte
    Dim Alpha1 As _Unsigned _Byte

    Dim Red2 As _Unsigned _Byte
    Dim Green2 As _Unsigned _Byte
    Dim Blue2 As _Unsigned _Byte
    Dim Alpha2 As _Unsigned _Byte

    Dim Red3 As _Unsigned _Byte
    Dim Green3 As _Unsigned _Byte
    Dim Blue3 As _Unsigned _Byte
    Dim Alpha3 As _Unsigned _Byte

    Dim Red4 As _Unsigned _Byte
    Dim Green4 As _Unsigned _Byte
    Dim Blue4 As _Unsigned _Byte
    Dim Alpha4 As _Unsigned _Byte

    ImageMemory = _MemImage(Image)

    $Checking:Off

    Dim iterations%

    For iterations% = 0 To Blurs - 1

        ImageOffsetStart = ImageMemory.OFFSET
        ImageOffsetCurrent = ImageOffsetStart
        ImageOffsetEnd = ImageOffsetStart + _Width(Image) * _Height(Image) * 4

        Do
            TopOffset = ImageOffsetCurrent - _Width(Image) * 4
            LeftOffset = ImageOffsetCurrent - 4
            RightOffset = ImageOffsetCurrent + 4
            BottomOffset = ImageOffsetCurrent + _Width(Image) * 4

            ' *** Let's go ahead and set the color values to zero, and only change them when required.
            Red1 = 0: Green1 = 0: Blue1 = 0: Alpha1 = 0
            Red2 = 0: Green2 = 0: Blue2 = 0: Alpha2 = 0
            Red3 = 0: Green3 = 0: Blue3 = 0: Alpha3 = 0
            Red4 = 0: Green4 = 0: Blue4 = 0: Alpha4 = 0

            ' *** Get the color values from the pixel above the current pixel, if it is with the image.
            If TopOffset >= ImageOffsetStart Then
                Red1 = _MemGet(ImageMemory, TopOffset + 2, _Unsigned _Byte)
                Green1 = _MemGet(ImageMemory, TopOffset + 1, _Unsigned _Byte)
                Blue1 = _MemGet(ImageMemory, TopOffset, _Unsigned _Byte)
                Alpha1 = _MemGet(ImageMemory, TopOffset + 3, _Unsigned _Byte)
            End If

            ' *** Get the color values from the pixel to the left of the current pixel, if it is with the image.
            If ((((LeftOffset - ImageOffsetStart) / 4) Mod _Width(Image)) < (((ImageOffsetCurrent - ImageOffsetStart) / 4) Mod _Width(Image))) Then
                Red2 = _MemGet(ImageMemory, LeftOffset + 2, _Unsigned _Byte)
                Green2 = _MemGet(ImageMemory, LeftOffset + 1, _Unsigned _Byte)
                Blue2 = _MemGet(ImageMemory, LeftOffset, _Unsigned _Byte)
                Alpha2 = _MemGet(ImageMemory, LeftOffset + 3, _Unsigned _Byte)
            End If

            ' *** Get the color values from the pixel to the right of the current pixel, if it is with the image.
            If ((((RightOffset - ImageOffsetStart) / 4) Mod _Width(Image)) > (((ImageOffsetCurrent - ImageOffsetStart) / 4) Mod _Width(Image))) Then
                Red3 = _MemGet(ImageMemory, RightOffset + 2, _Unsigned _Byte)
                Green3 = _MemGet(ImageMemory, RightOffset + 1, _Unsigned _Byte)
                Blue3 = _MemGet(ImageMemory, RightOffset, _Unsigned _Byte)
                Alpha3 = _MemGet(ImageMemory, RightOffset + 3, _Unsigned _Byte)
            End If

            ' *** Get the color values from the pixel below the current pixel, if it is with the image.
            If BottomOffset < ImageOffsetEnd Then
                Red4 = _MemGet(ImageMemory, BottomOffset + 2, _Unsigned _Byte)
                Green4 = _MemGet(ImageMemory, BottomOffset + 1, _Unsigned _Byte)
                Blue4 = _MemGet(ImageMemory, BottomOffset, _Unsigned _Byte)
                Alpha4 = _MemGet(ImageMemory, BottomOffset + 3, _Unsigned _Byte)
            End If

            ' *** draw the current pixel with a newly defined _RGBA color value.
            _MemPut ImageMemory, ImageOffsetCurrent, _RGBA((Red1 + Red2 + Red3 + Red4) / 4, (Green1 + Green2 + Green3 + Green4) / 4, (Blue1 + Blue2 + Blue3 + Blue4) / 4, (Alpha1 + Alpha2 + Alpha3 + Alpha4) / 4) As _UNSIGNED LONG

            '' *** These are here for fun nd testing purposes.
            '_MEMPUT ImageMemory, ImageOffsetCurrent, _RGBA((Red1 + Red2 + Red3 + Red4) / 4, (Green1 + Green2 + Green3 + Green4) / 4, (Blue1 + Blue2 + Blue3 + Blue4) / 4, 255) AS _UNSIGNED LONG
            '_MEMPUT ImageMemory, ImageOffsetCurrent, _RGBA(0, 0, (Blue1 + Blue2 + Blue3 + Blue4) / 4, 255) AS _UNSIGNED LONG
            '_MEMPUT ImageMemory, ImageOffsetCurrent, _RGBA(0, (Green1 + Green2 + Green3 + Green4) / 4, 0, 255) AS _UNSIGNED LONG
            '_MEMPUT ImageMemory, ImageOffsetCurrent, _RGBA((Red1 + Red2 + Red3 + Red4) / 4, 0, 0, 255) AS _UNSIGNED LONG

            ImageOffsetCurrent = ImageOffsetCurrent + 4

        Loop Until ImageOffsetCurrent = ImageOffsetEnd

    Next

    $Checking:On
    _MemFree ImageMemory

End Sub
'$include:'Vendor\sprite.bi'

'End of Code ! :)

