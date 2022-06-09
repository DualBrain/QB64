'================
'PIPES.BAS v1.0
'================
'Connect the pipes puzzle game
'Coded by Dav for QB64-GL 1.5 in SEP/2021

'NOTE: Formally called MazeConnect Prototype on the forum.

'============
'HOW TO PLAY:
'============

'Click on pipes to rotate them and connect them as one.
'Object is to make all pipes on board connected to leader.
'Top left pipe is always on, the leader, so start from it.
'When pipes are all connected, you advance to next level.
'There are currently 20 levels.  ESC key exits game.

'SPACE  = restarts level
'RIGHT ARROW = goto next level
'LEFT ARROW = go back a level
'ESC = Quits game

'         VVVVVVV     blus fixed next line to work from his downloaded zip
    $ExeIcon:'.\icon.ico'
    _Icon


    Randomize Timer

    Dim Shared GridSize, Level, MaxLevel, LD$, LU$, RD$, RU$, HZ$, VT$, BM$

    Level = 1: MaxLevel = 13

    GridSize = 3 'default starting GridSize is 3x3 (its level 1)
    MaxGridSize = 15 'The last GridSize level so far (13 levels right now)

    'Declare image names: angle characters, right up, left up, etc
    LD$ = "ld": LU$ = "lu"
    RD$ = "rd": RU$ = "ru"
    HZ$ = "hz": VT$ = "vt"
    BM$ = "bm"

    'Sound files
    new& = _SndOpen("sfx_magic.ogg")
    move& = _SndOpen("sfx_click1.mp3"):
    click& = _SndOpen("sfx_click2.mp3"):
    clap& = _SndOpen("sfx_clap.ogg")

    'image file
    Dim Shared Solved&
    Solved& = _LoadImage("solved.png", 32) '<  thank bplus for this

    'For game state saving...to be added later
    loaded = 0: fil$ = "pipe.dat"
    If _FileExists(fil$) Then
        loaded = 1
    End If

    '=======
    newlevel:
    '=======

    Screen _NewImage(640, 640, 32)
    'Do: Loop Until _ScreenExists ' <<<<<<<<<< sorry Dav this aint working on my system
    _Delay .25 ' <<<<<<<<<<<<<<<<<<<<<<<<<<<<< does this work for you?
    '            No? increase delay time really nice to have centered on screen
    _ScreenMove _Middle ' <  thank bplus for this , ahhhh that's better
    Cls ', _RGB(32, 32, 77)

    If Level = 1 Then
        back& = _LoadImage("hz-grn.png")
        _PutImage (0, 0)-(640, 640), back&
        _FreeImage back&
        title& = _LoadImage("title.png")
        _PutImage (84, 140), title&
        _FreeImage title&
        w$ = Input$(1)
        For a = 0 To 64
            Line (0, 0)-(640, 640), _RGBA(0, 0, 0, a), BF
            _Delay .02
        Next
    End If

    PPRINT 100, 300, 30, _RGB(200, 200, 200), 0, "Level:" + Str$(Level) + " of" + Str$(MaxLevel)
    _Delay 2

    _SndPlay new&

    Title$ = "Pipes: Level " + Str$(Level) + " of" + Str$(MaxLevel)
    _Title Title$

    'Make space for variables
    ReDim Shared TileVal$(GridSize * GridSize)
    ReDim Shared TileX(GridSize * GridSize), TileY(GridSize * GridSize)
    ReDim Shared TileClr(GridSize * GridSize), TileClr2(GridSize * GridSize)

    TileSize = Int(640 / GridSize) 'The width/height of tiles, in pixels

    'set tile values, and generate x/y values...
    bb = 1
    For r = 1 To GridSize
        For c = 1 To GridSize
            x = (r * TileSize): y = (c * TileSize)
            If Rnd(GridSize * 2) = GridSize Then br = 0
            TileX(bb) = x - TileSize: TileY(bb) = y - TileSize
            TileVal$(bb) = RD$
            TileClr(bb) = 0
            TileClr2(bb) = 0
            bb = bb + 1
        Next c
    Next r

    TileClr(1) = 1 'turn on top left leader tile
    TileClr2(1) = 1 'make a copy

    setmaze 'Load level maze data, it's already scrambled up

    firstdraw = 1
    GoSub updatebuttons

    Do

        _Limit 300

        'wait until mouse button up to continue
        While _MouseButton(1) <> 0: n = _MouseInput: Wend

        trap = _MouseInput
        If _MouseButton(1) Then
            mx = _MouseX: my = _MouseY

            For b = 1 To (GridSize * GridSize)

                tx = TileX(b): tx2 = TileX(b) + TileSize
                ty = TileY(b): ty2 = TileY(b) + TileSize

                If mx >= tx And mx <= tx2 Then
                    If my >= ty And my <= ty2 Then
                        'skip any black blocks clicked on
                        If TileVal$(b) = BM$ Then GoTo skip

                        _SndPlay move&

                        bv2$ = TileVal$(b) 'see what tile it is

                        'rotate right angle tiles
                        If bv2$ = RD$ Then TileVal$(b) = LD$
                        If bv2$ = LD$ Then TileVal$(b) = LU$
                        If bv2$ = LU$ Then TileVal$(b) = RU$
                        If bv2$ = RU$ Then TileVal$(b) = RD$

                        'rotate horiz/vert lines
                        If bv2$ = HZ$ Then TileVal$(b) = VT$
                        If bv2$ = VT$ Then TileVal$(b) = HZ$

                        'show tile
                        If TileClr(b) = 1 Then
                            tag$ = "-grn.png"
                        Else
                            tag$ = "-wht.png"
                        End If

                        SHOW TileVal$(b) + tag$, TileX(b), TileY(b), TileX(b) + TileSize, TileY(b) + TileSize

                        GoSub updatebuttons
                        GoSub checkforwin

                    End If
                End If
            Next b
        End If
        skip:

        ink$ = UCase$(InKey$)

        If ink$ = Chr$(32) Then GoTo newlevel

        'Right arrows advance to next level
        If ink$ = Chr$(0) + Chr$(77) Then
            GridSize = GridSize + 1
            Level = Level + 1
            If Level > MaxLevel Then Level = 1
            If GridSize > MaxGridSize Then
                GridSize = 3 'MaxGridSize  'restart
            End If
            GoTo newlevel
        End If

        'Left Arrows go back a level
        If ink$ = Chr$(0) + Chr$(75) Then
            GridSize = GridSize - 1
            If GridSize < 3 Then GridSize = MaxGridSize
            Level = Level - 1
            If Level < 1 Then Level = MaxLevel
            GoTo newlevel
        End If

    Loop Until ink$ = Chr$(27)

    System

    '============
    updatebuttons:
    '============

    'first tile always on, draw it green
    SHOW TileVal$(1) + "-grn.png", TileX(1), TileY(1), TileX(1) + TileSize, TileY(1) + TileSize


    'turn all off tile colors first, except 1st
    For g = 2 To GridSize * GridSize
        TileClr(g) = 0
    Next g


    'set leader tile flow direction
    If TileVal$(1) = HZ$ Then direction = 1 'going right
    If TileVal$(1) = VT$ Then direction = 2 'going down

    cur = 1 'start with 1st tile always

    'do until can't flow anymore (direction blocked)
    Do

        If direction = 1 Then 'heading right
            'see if already on the right edge of board
            'if so, it can't go right anymore, so end flow...
            For j = (GridSize * GridSize) - GridSize + 1 To GridSize * GridSize
                If cur = j Then GoTo flowdone
            Next j
            'now see if one to the right can connect with it.
            'if not connectable, end flow here.
            con = 0 'default is not connectable
            nv$ = TileVal$(cur + GridSize)
            If nv$ = HZ$ Then con = 1
            If nv$ = LU$ Then con = 1
            If nv$ = LD$ Then con = 1
            'if not, end flow here
            If con = 0 Then GoTo flowdone
            'looks like it is connectable, so turn it on
            TileClr(cur + GridSize) = 1 'turn piece to the right on.
            'Make new pieve the new current flow position
            tc = (cur + GridSize): cur = tc
            'find/set new direction based on that character
            If nv$ = HZ$ Then direction = 1 'right
            If nv$ = LU$ Then direction = 4 'up
            If nv$ = LD$ Then direction = 2 'down
        End If

        If direction = 2 Then 'heading down
            'see if this one is on the bottom edge
            For j = GridSize To (GridSize * GridSize) Step GridSize
                If cur = j Then GoTo flowdone
            Next j
            'now see if new one can connect with this one.
            'if not, end flow here.
            con = 0 'default is not connectable
            nv$ = TileVal$(cur + 1)
            If nv$ = VT$ Then con = 1
            If nv$ = LU$ Then con = 1
            If nv$ = RU$ Then con = 1
            'if not, end flow here
            If con = 0 Then GoTo flowdone
            'looks like it must be connectable
            TileClr(cur + 1) = 1 'turn the next piece on too
            'Make it the new current char position
            tc = (cur + 1): cur = tc
            'find/set new direction based on character
            If nv$ = LU$ Then direction = 3 'left
            If nv$ = RU$ Then direction = 1 'right
            If nv$ = VT$ Then direction = 2 'down
        End If

        If direction = 3 Then 'heading left
            'see if this one is on the bottom edge
            For j = 1 To GridSize
                If cur = j Then GoTo flowdone
            Next j

            'now see if new one can connect with this one.
            'if not, end flow here.
            con = 0 'default is not connectable
            nv$ = TileVal$(cur - GridSize)
            If nv$ = HZ$ Then con = 1
            If nv$ = RU$ Then con = 1
            If nv$ = RD$ Then con = 1
            'if not, end flow here
            If con = 0 Then GoTo flowdone
            'looks like it must be connectable
            TileClr(cur - GridSize) = 1 'turn the next piece on too
            'Make it the new current char position
            tc = (cur - GridSize): cur = tc
            'find/set new direction based on character
            If nv$ = HZ$ Then direction = 3 'left
            If nv$ = RU$ Then direction = 4 'up
            If nv$ = RD$ Then direction = 2 'down
        End If

        If direction = 4 Then 'going up
            'see if this one is on the edge of board
            'if so, it can't go up, so end flow...
            For j = 1 To (GridSize * GridSize) Step GridSize
                If cur = j Then GoTo flowdone
            Next j
            'now see if new one can connect with this one.
            'if not, end flow here.
            con = 0 'default is not connectable
            nv$ = TileVal$(cur - 1)
            If nv$ = VT$ Then con = 1
            If nv$ = LD$ Then con = 1
            If nv$ = RD$ Then con = 1
            'if not, end flow here
            If con = 0 Then GoTo flowdone
            'looks like it must be connectable
            TileClr(cur - 1) = 1 'turn the next piece on too
            'Make it the new current char position
            tc = (cur - 1): cur = tc
            'find/set new direction based on character
            If nv$ = VT$ Then direction = 4 'up
            If nv$ = LD$ Then direction = 3 'left
            If nv$ = RD$ Then direction = 1 'right
        End If

    Loop

    flowdone:

    If firstdraw = 0 Then

        'draw/colorize board
        For t = 2 To (GridSize * GridSize)
            If TileClr(t) = 1 And TileClr2(t) = 0 Then
                'show green...
                SHOW TileVal$(t) + "-grn.png", TileX(t), TileY(t), TileX(t) + TileSize, TileY(t) + TileSize
            End If
            If TileClr(t) = 0 And TileClr2(t) = 1 Then
                'show white...
                SHOW TileVal$(t) + "-wht.png", TileX(t), TileY(t), TileX(t) + TileSize, TileY(t) + TileSize
            End If
        Next t

    Else

        'draw/colorize board
        For t = 2 To (GridSize * GridSize)
            If TileClr(t) = 1 Then
                tag$ = "-grn.png"
            Else
                tag$ = "-wht.png"
            End If
            SHOW TileVal$(t) + tag$, TileX(t), TileY(t), TileX(t) + TileSize, TileY(t) + TileSize
        Next t

        firstdraw = 0

    End If


    'copy current color values
    For t = 1 To GridSize * GridSize
        TileClr2(t) = TileClr(t)
    Next t


    '===========
    checkforwin:
    '===========

    all = 0
    For w = 1 To (GridSize * GridSize)
        If TileClr(w) = 1 Then all = all + 1
        If TileVal$(w) = BM$ Then all = all + 1 'add any blocks
    Next w

    If all = (GridSize * GridSize) Then

        ' bplus rewrote this section to fade in the You did it! sign over the gameboard =======================
        ' Solved& has already been loaded after sounds at start of program
        _SndPlay clap&
        snap& = _NewImage(_Width, _Height, 32)
        _PutImage , 0, snap&
        For alph = 0 To 255
            Cls
            _PutImage , snap&, 0 'background
            _SetAlpha alph, , Solved&
            _PutImage (166, 258), Solved&
            _Limit 40 ' 255 frames in 2 secs
            _Display ' damn blinking!!! without this
        Next
        _AutoDisplay '<<<<<< back to not needing _display
        _FreeImage snap&
        ' end of bplus meddling ================================================================================

        Level = Level + 1

        GridSize = GridSize + 1

        If Level > MaxLevel Then Level = 1

        If GridSize > MaxGridSize Then
            GridSize = 3 'MaxGridSize  'restart
        End If

        GoTo newlevel

    End If

    Return


    Sub setmaze ()

        If Level = 1 Then
            GridSize = 3
            a$ = "" '3x3 MazeConnect GridSize
            a$ = a$ + "hzrdru"
            a$ = a$ + "hzhzhz"
            a$ = a$ + "ldluld"
        End If

        If Level = 2 Then
            GridSize = 4
            a$ = "" '4x4 MazeConnect GridSize
            a$ = a$ + "vtvtruru"
            a$ = a$ + "rdvtluhz"
            a$ = a$ + "hzrdruhz"
            a$ = a$ + "ldluldlu"
        End If

        If Level = 3 Then
            GridSize = 5
            a$ = "" '5x5 MazeConnect GridSize
            a$ = a$ + "hzrdvtvtld"
            a$ = a$ + "hzhzrdrdhz"
            a$ = a$ + "hzhzldhzhz"
            a$ = a$ + "hzldvtluhz"
            a$ = a$ + "ldvtvtvtlu"
        End If

        If Level = 4 Then
            GridSize = 6
            a$ = "" '6x6 MazeConnect GridSize
            a$ = a$ + "hzrdrurdvtru"
            a$ = a$ + "hzhzhzhzrdlu"
            a$ = a$ + "ldluhzhzldru"
            a$ = a$ + "rdvtluhzbmhz"
            a$ = a$ + "hzrdruldruhz"
            a$ = a$ + "ldluldvtlulu"
        End If

        If Level = 5 Then
            GridSize = 7
            a$ = "" '7x7 MazeConnect GridSize
            a$ = "vtruvtvtrurdru"
            a$ = a$ + "rdlurdruldluhz"
            a$ = a$ + "ldvtluldrurdlu"
            a$ = a$ + "rdvtrurdluldru"
            a$ = a$ + "ldruldlurdvtlu"
            a$ = a$ + "rdlurdruldvtru"
            a$ = a$ + "ldvtluldvtvtlu"
        End If

        If Level = 6 Then
            GridSize = 8
            a$ = "" '8x8 MazeConnect GridSize
            a$ = a$ + "hzvtrurdrurdrubm"
            a$ = a$ + "hzbmldluhzhzldru"
            a$ = a$ + "ldvtrurdluhzrdlu"
            a$ = a$ + "rdvtluldvtluldru"
            a$ = a$ + "ldrurdvtrurdvtlu"
            a$ = a$ + "bmhzhzbmldlurdru"
            a$ = a$ + "rdluldvtvtvtluhz"
            a$ = a$ + "ldvtvtvtvtvtvtlu"
        End If

        If Level = 7 Then
            GridSize = 9
            a$ = "" '9x9 MazeConnect GridSize
            a$ = a$ + "hzrdvtvtrurdrurdru"
            a$ = a$ + "hzldvtruldluldluhz"
            a$ = a$ + "ldvtruldrubmrdvtlu"
            a$ = a$ + "rdruldruldruldrubm"
            a$ = a$ + "hzldruldruldruldru"
            a$ = a$ + "ldruhzbmldruhzbmhz"
            a$ = a$ + "rdluldvtvtluldruhz"
            a$ = a$ + "hzrdrurdvtrurdluhz"
            a$ = a$ + "ldluldlubmldluvtlu"
        End If

        If Level = 8 Then
            GridSize = 10
            a$ = "" '10x10 MazeConnect GridSize
            a$ = a$ + "vtvtvtrurdrurdvtrubm"
            a$ = a$ + "hzrdvtluhzhzldruldru"
            a$ = a$ + "hzldvtvtluldruhzrdlu"
            a$ = a$ + "hzbmrdvtvtruldluldru"
            a$ = a$ + "hzrdlurdruhzrdvtvtlu"
            a$ = a$ + "hzhzrdluhzldlurdrubm"
            a$ = a$ + "hzhzhzbmldrubmhzldru"
            a$ = a$ + "hzldlurdruldvtlurdlu"
            a$ = a$ + "hzrdruhzldrurdruldru"
            a$ = a$ + "ldluldlubmldluldvtlu"
        End If

        If Level = 9 Then
            GridSize = 11
            a$ = "" '11x11 MazeConnect GridSize
            a$ = a$ + "hzvtrubmrdvtrubmrdvtru"
            a$ = a$ + "ldruldruldruldruldruhz"
            a$ = a$ + "bmldruldruldruldruhzhz"
            a$ = a$ + "rdruldruldruldruldluhz"
            a$ = a$ + "hzldruldruldruldrurdlu"
            a$ = a$ + "ldruldruldruldruhzldru"
            a$ = a$ + "bmldruldruldruldlurdlu"
            a$ = a$ + "rdruldruldruldrurdlubm"
            a$ = a$ + "hzldruldruldvtluldvtru"
            a$ = a$ + "ldruldvtlurdrurdrurdlu"
            a$ = a$ + "bmldvtvtvtluldluldlubm"
        End If

        If Level = 10 Then
            GridSize = 12
            a$ = "" '12x12 MazeConnect GridSize
            a$ = a$ + "vtvtrubmbmrdrurdrurdvtru"
            a$ = a$ + "bmbmhzbmrdluldluhzhzrdlu"
            a$ = a$ + "bmrdlurdlurdrurdluhzldru"
            a$ = a$ + "rdlurdlurdluhzhzrdlurdlu"
            a$ = a$ + "ldruldvtlurdluhzhzbmldru"
            a$ = a$ + "bmldvtvtruhzbmldlurdvtlu"
            a$ = a$ + "rdvtvtvtluhzrdvtvtlurdru"
            a$ = a$ + "ldrurdvtvtluhzrdvtvtluhz"
            a$ = a$ + "rdluhzbmbmbmldlurdrurdlu"
            a$ = a$ + "hzrdlurdrurdrubmhzhzhzbm"
            a$ = a$ + "ldlurdluhzhzhzrdluhzldru"
            a$ = a$ + "vtvtlubmldluldlubmldvtlu"
        End If

        If Level = 11 Then
            GridSize = 13
            a$ = "" '13x13 MazeConnect GridSize
            a$ = a$ + "hzvtvtvtvtvtrurdrurdrurdru"
            a$ = a$ + "hzrdrurdvtruldluhzhzldluhz"
            a$ = a$ + "hzhzhzhzspldvtruhzhzrdruhz"
            a$ = a$ + "hzhzhzldrubmrdluldluhzhzhz"
            a$ = a$ + "hzhzldvtlurdlurdvtvtluldlu"
            a$ = a$ + "hzldrubmrdlubmldvtvtrurdru"
            a$ = a$ + "ldruldruhzbmbmbmrdruhzhzhz"
            a$ = a$ + "rdlurdluldrubmrdluhzldluhz"
            a$ = a$ + "hzrdlurdruldvtlurdlubmrdlu"
            a$ = a$ + "hzldruhzldrurdvtlurdruldru"
            a$ = a$ + "hzrdluhzbmldlurdvtluhzrdlu"
            a$ = a$ + "hzhzrdlurdvtruhzrdvtluldru"
            a$ = a$ + "ldluldvtlubmldluldvtvtvtlu"
        End If

        If Level = 12 Then
            GridSize = 14
            a$ = "" '14x14 MazeConnect GridSize
            a$ = a$ + "hzrdrurdvtvtrurdrurdvtvtrubm"
            a$ = a$ + "hzhzhzldvtruhzhzhzhzrdruhzbm"
            a$ = a$ + "ldluhzrdruhzldluldluhzhzhzbm"
            a$ = a$ + "rdruhzhzhzldvtvtvtruhzldlubm"
            a$ = a$ + "hzhzhzhzhzrdrurdruhzldvtrubm"
            a$ = a$ + "hzhzhzhzhzhzhzhzhzhzrdruldru"
            a$ = a$ + "hzhzldluhzhzhzhzhzhzhzldvtlu"
            a$ = a$ + "hzldvtruhzhzhzhzhzhzldrurdru"
            a$ = a$ + "hzrdruhzldluhzhzhzhzbmldluhz"
            a$ = a$ + "ldluhzldvtruhzhzhzhzrdrurdlu"
            a$ = a$ + "rdruhzrdvtluhzhzldluhzhzhzbm"
            a$ = a$ + "hzldluldvtvtluhzrdvtluhzhzbm"
            a$ = a$ + "hzvtvtvtvtvtvtluldrurdluhzbm"
            a$ = a$ + "ldvtvtvtvtvtvtvtvtluldvtlubm"
        End If

        If Level = 13 Then
            GridSize = 15
            a$ = "" '15x15 MazeConnect GridSize
            a$ = a$ + "vtvtrurdrurdrurdrubmrdvtvtvtru"
            a$ = a$ + "vtruldluhzhzldluldvtlurdvtruhz"
            a$ = a$ + "rdlubmbmhzldvtvtrurdvtlubmldlu"
            a$ = a$ + "ldrurdruhzbmrdruhzldrurdvtvtru"
            a$ = a$ + "bmhzhzldlurdluhzldruldlurdvtlu"
            a$ = a$ + "rdluldrurdlubmhzrdlurdruldrubm"
            a$ = a$ + "ldrubmldlurdruldlubmhzhzbmldru"
            a$ = a$ + "rdlurdvtvtluldrurdruhzhzrdvtlu"
            a$ = a$ + "ldvtlurdvtvtvtluhzldluhzldvtru"
            a$ = a$ + "rdvtvtlurdvtvtruldrurdlurdruhz"
            a$ = a$ + "ldvtrurdlubmrdlurdluhzrdluldlu"
            a$ = a$ + "rdvtluldrurdlurdlurdluhzbmrdru"
            a$ = a$ + "ldvtrurdluhzbmldruldruldvtluhz"
            a$ = a$ + "rdvtluldruhzrdruldruldvtrurdlu"
            a$ = a$ + "ldvtvtvtluldluldvtlubmbmldlubm"
        End If

        dd = 1
        For s = 1 To Len(a$) Step 2
            b$ = Mid$(a$, s, 2)
            If b$ = "vt" Then rotate dd, 1
            If b$ = "hz" Then rotate dd, 1
            If b$ = "ld" Then rotate dd, 2
            If b$ = "lu" Then rotate dd, 2
            If b$ = "rd" Then rotate dd, 2
            If b$ = "ru" Then rotate dd, 2
            If b$ = "bm" Then TileVal$(dd) = BM$

            dd = dd + 1
        Next s

    End Sub

    Sub rotate (num, typ)

        'there are only two types of rotating characters,
        'straight lines, or right angles...

        'randomly rotate straight character
        If typ = 1 Then
            If Int(Rnd * 2) = 0 Then
                TileVal$(num) = VT$
            Else
                TileVal$(num) = HZ$
            End If
        End If

        'randomly rotate right angles...
        If typ = 2 Then
            rn = Int(Rnd * 4) + 1
            If rn = 1 Then TileVal$(num) = LD$
            If rn = 2 Then TileVal$(num) = LU$
            If rn = 3 Then TileVal$(num) = RD$
            If rn = 4 Then TileVal$(num) = RU$
        End If

    End Sub

    Sub SHOW (i$, x1, y1, x2, y2)
        'Just a little sub to load & put an image at x1/y1
        ttmp = _LoadImage(i$)
        _PutImage (x1, y1)-(x2, y2), ttmp
        _FreeImage ttmp
    End Sub

    Sub PPRINT (x, y, size, clr&, trans&, text$)
        'This sub outputs to the current _DEST set
        'It makes trans& the transparent color

        'x/y is where to print text
        'size is the font size to use
        'clr& is the color of your text
        'trans& is the background transparent color
        'text$ is the string to print

        '=== get users current write screen
        orig& = _Dest

        '=== if you are using an 8 or 32 bit screen
        bit = 32: If _PixelSize(0) = 1 Then bit = 256

        '=== step through your text
        For t = 0 To Len(text$) - 1
            '=== make a temp screen to use
            pprintimg& = _NewImage(16, 16, bit)
            _Dest pprintimg&
            '=== set colors and print text
            Cls , trans&: Color clr&
            Print Mid$(text$, t + 1, 1);
            '== make background color the transprent one
            _ClearColor _RGB(0, 0, 0), pprintimg&
            '=== go back to original screen  to output
            _Dest orig&
            '=== set it and forget it
            x1 = x + (t * size): x2 = x1 + size
            y1 = y: y2 = y + size
            _PutImage (x1 - (size / 2), y1)-(x2, y2 + (size / 3)), pprintimg&
            _FreeImage pprintimg&
        Next
    End Sub




