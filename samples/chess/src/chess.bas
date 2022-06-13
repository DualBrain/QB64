' CHESS aka Dodo Zero aka Deep Color aka Dim Blue
' Author: rfrost@mail.com
' Last update: Feb 28, 2022 - 6880 active lines

' - compile with QB64 Windows or Linux version 1.3 or better, 64 or 32 bit version
' - not necessary to compile minimax unless one wishes to use it
' - not tested by author in MacOS
' - critical bits of code ugly due to branchless programming for speed

' NOTE:
' The method for moving pieces WAS, by default, unique.  Hover the mouse
' cursor over a piece for 2 seconds and it will be selected.  Hover the
' mouse cursor over the destination square for 2 seconds and it will be
' selected.  This is a nice mode for using a trackpad, however, the
' downside is that one must remember to move the cursor elsewhere after
' moving so the piece is not autoselected on the next move.  Hover may
' be activated in the Setup menu.

' todo: UCI/Winboard interface
'       connectivity to play online
'       Increment/Bronstein/Simple delay for clocks
'       better screenhide during initializations
'       alpha/beta pruning
'       playback from black side
'       allow mix/match from sets
'       convert castle$ to numeric

' COMMAND$ options:
' n       - plies (2 stupid, 4 default, 5+ too slow)
' /       - computer plays itself (for screensaver)
' init    - ignore configuration file (reads chessb.dat)
' nim     - no intro music (loads faster)
' match   - play Minimax endlessly
' server  - be a waitress (local)
' server2 - be a waitress & fire up client (local)
' client  - connect to server (local)

' Tiny numbers at top are:
' 1) left   - points ahead/behind (in normal print with other display)
'    perpetual:draw (game stops at 3 for perpetual, 50 for draw)
' 2) middle - current time (currently disabled)
' 3) right:
'    a) total seconds delayed this session (CPU overheat fix)
'    b) current moves per second
'    c) best moves per second this session
'    d) total moves computed this session

' Undocumented keys/mouse:
' `   - cycle thru 12 schemes of colors/clock/pieces
' 0   - plasma toggle
' D   - deep (only for top 2 or 3 moves, but really slows it down)
' G   - MPS scale top/seen
' I   - identify players (name input)
' j   - examine FEN positions/replies
' J   - add FEN/reply
' k   - minimal info (way faster)
' L   - endless loop in Playback (to memorize classic games)
' m   - Dodo vs Minimax, one game (at main menu)
' M   - magnify mouse position
' q   - quit (unless promoting)
' R   - developer mode toggle (debugging, extra info, extra features)
' x   - sound test if sound on (intro music)
' X   - disable takeback for current game
' z   - show all sets
' Z   - show pieces for funny set
' \   - scores on board
' +/- - resize pieces (not saved)
' PgUp/PgDn - volume

' In menu, but quicker:
' 1   - color white squares
' 2   - color black squares
' 3   - color clock & text highlight
' 4   - color background
' 5   - background pattern toggle
' B   - square border style
' c   - clock type: font,7 segment, Nixie
' C   - cursor type
' f   - slide speed
' F   - file playback
' g   - plasma restart
' H   - hover mode
' l   - legend
' m   - markers
' N   - notation algebraic/descriptive
' S   - change chess set
' t   - same as c (time)

Option _Explicit
DefLng A-Z '                     faster than integer, makes no sense to me but is
$Checking:Off
$Resize:On

Const true = 1, false = 0

Common Shared minty, dircmd$, delcmd$, rencmd$, editcmd$
$If WIN Then
    $ExeIcon:'.\chessdat\chess.ico'
    Const slash = "\"
    Declare Library "./mem" ' S McNeill CPU load tracking, Linux uses sensors
        Function GetCPULoad#
    End Declare
    dircmd$ = "dir "
    delcmd$ = "del "
    rencmd$ = "ren "
    editcmd$ = "notepad "
$Else
        $ExeIcon:'./chessdat/chess.ico'
        Const slash = "/" '
        minty = true
        dircmd$ = "ls -lt "
        delcmd$ = "rm " '            remove file (delete)
        rencmd$ = "mv " '            rename file
        editcmd$ = "xed " '          all versions of Linux have this editor, I hope
$End If

Const alphaz$ = "abcdefgh" '     a is for apple
Const tbmax = 128 '              takeback history
Const mult = 32 '                piece value multiplier

Const intro = 1, click1 = 2, click2 = 3, movedone = 4, takeback = 5 '          sounds
Const checkn = 6, won = 7, stalemate = 8, promotion = 9, illegal = 10, resign = 11

Const Rook = 1, Knight = 2, Bishop = 3, Queen = 4, King = 5, Pawn = 6 '        the usual suspects

Type mtype '                     move
    fc As _Byte '                from column
    fr As _Byte '                from row
    tc As _Byte '                to column
    tr As _Byte '                to row
    'os As Integer '              original score
    sc As Integer '              score
    'mi As _byte '               move index
End Type

Common Shared As _Byte abort '            stop thinking & move now
Common Shared As _Byte alfred, alfredon ' Alfred E. Nueman
Common Shared As _Byte allsetsloaded
Common Shared As _Byte altbg '            0hexagon 1Sierpinski 2Shaded 3Off 4Cheetos 5Fruit Loops
Common Shared As _Byte asci '             ASCII of INKEY$
Common Shared As _Byte autopause '        Leeloo multipass
Common Shared As _Byte b1, b2 '           mouse button left and right
Common Shared As _Byte backok '           take back move (turn off with X)
Common Shared As _Byte bgc '              background color index
Common Shared bgi '                       background image
Common Shared As _Byte bgmax '            5 normal, 7 me
Common Shared boltx1, boltx2, bolty1, bolty2
Common Shared As _Byte bri '              brightness
'Common Shared btoggle
Common Shared As _Unsigned _Byte captions 'for funny pix
Common Shared As _Byte cflag '            castling
Common Shared As _Byte check, incheck '   God Save the King
Common Shared As _Byte click '            mouse noise
Common Shared As _Byte barebones '        turn off captured, log, and clock
Common Shared As _Byte chimp
Common Shared As _Byte cmatch '           Dodo vs Minimax
Common Shared As _Byte cmate '            Coffeemate, an edible oil product
Common Shared As _Byte cmode '            clock mode (laudry countdown timer)
Common Shared As _Byte colori1 '          index to white square color
Common Shared As _Byte colori2 '          index to black square color
Common Shared As _Byte colori3 '          index to clock color
Common Shared As _Byte cursortype '       crosshair, link, normal, etc
Common Shared As _Byte deep '             experimental, look deeper for top 2 or 3 moves
Common Shared As _Byte dev '              development mode
Common Shared As _Byte defaultfontsize '  14 for now
Common Shared As _Byte clocktype '        0 font, 1 7-segment, 2 Nixie
Common Shared As _Byte cycle '            a bicycle built for 3
Common Shared As _Byte drawcount '        0 - 50
Common Shared As _Byte dosmallboard '     inactive, too slow
Common Shared As _Byte endgame '          flag
Common Shared As _Byte Enter10 '          shift-Enter skips 10 moves in playback
Common Shared explosion '                 exit amusement
Common Shared As _Byte fast '             speed of sliding for pieces
Common Shared As _Byte fc, fr '           from row, from column
Common Shared As _Byte fullscreenflag '   blueberry waffle
Common Shared As _Byte getwbflag '        asking, ignore most keys except W or B
Common Shared As _Byte giveup
Common Shared As _Byte graphics '         plasma: 0 off, 1 w sq, 2 b sq, 3 all sq
Common Shared As _Byte gscale '           MPS scale top/seen
Common Shared As _Byte hinit '            human cursor initializion flag
Common Shared As _Byte hover '            move by hovering
Common Shared As _Byte human, humanc '    0 auto, 1 human vs computer, 2 humans
Common Shared As _Byte iflag '            invert board, autoflipping for 2 human players
Common Shared As _Byte ingetfile '        flag
Common Shared As _Byte ingetnames '       flag
Common Shared As _Byte inhelp '           showing help
Common Shared As _Byte inpause '          prevent reentry to SUB Pause
Common Shared As _Byte insettings '       prevent reentry to Setup
Common Shared As _Byte insetup '          flag
Common Shared As _Byte inshow '           sets or funny images
Common Shared As _Byte invert '           black player at bottom
Common Shared As _Byte ipfile '           needed for tf.bas (included)
Common Shared As _Byte lasth '            last human
Common Shared As _Byte lastc '            last color
Common Shared As _Byte lasthsav '         stack for above
Common Shared As _Byte lastcsav
Common Shared As _Byte lcb '              Liquor Control Board
Common Shared As _Byte legend '           flag for a-h at bottom, 1-8 on left
Common Shared As _Byte li '               length of INKEY$
Common Shared As _Byte loadsetsinbackground
Common Shared As _Byte logging '          of game to disk
Common Shared As _Byte lostfocus '        user doing something else, add delays
Common Shared As _Byte lpoints '          last (previous) points
Common Shared As _Byte makenoise '        pressure waves in air
Common Shared As _Byte markers '          highlight last move
Common Shared As _Byte markerfc '         from column
Common Shared As _Byte markerfr '         from row
Common Shared As _Byte markertc '         to column
Common Shared As _Byte markertr '         to row
Common Shared As _Byte masterlevel '      usually 4
Common Shared As _Byte masterm1 '         master minus one (plies)
Common Shared As _Byte match '            playing MiniMax
Common Shared mdelay!, tdelay! '          overheat fix
Common Shared midway '                    x of middle of Style button
Common Shared mig '                       moves in game (playback)
Common Shared As _Byte minactive '        MiniMax
Common Shared As _Byte mloop '            speed waiting for input (no performance effect)
Common Shared move '                      counter
Common Shared mps '                       moves per second
Common Shared mscreen, mscreenr '         main screen, rotated
Common Shared As _Byte names
Common Shared As Integer mx, my '         adjusted mouse position
Common Shared As Integer ux, uy '         actual mouse position
Common Shared As _Byte nbox '             clickable buttons on screen
Common Shared ndelay '                    how many delays
Common Shared As _Byte newinfo '          flag
Common Shared As _Byte no_intro_music '   flag
Common Shared As _Byte noresign '         force continuation
Common Shared As _Byte nosend '           flag for match
Common Shared As _Byte descriptive '      0 algebraic  1 descriptive
Common Shared As _Byte nvalid '           count of valid moves
Common Shared As _Byte onplayback '       viewing stored game
Common Shared As _Byte oply '             old ply
Common Shared As _Byte p '                piece, usually
Common Shared As _Byte pawndir '          W = 1, B = -1
Common Shared As _Byte perpetual '        counter, game ends in draw at 3
Common Shared As _Byte piece_style '      0 funny,1 ugly,2 best,3 alternate,4 fancy
Common Shared As _Byte binvert '          0screen, 1board (human vs human)
Common Shared As _Byte plasma_init '      flag
Common Shared As _Byte plasmaint '        plasma intensity
Common Shared As _Byte points '           ahead/behind
Common Shared As _Byte pregame '          flag
Common Shared As _Byte promoting '        waiting for user to select piece, ignore many keys
Common Shared As _Byte psize '            piece size
Common Shared ptaken, ptcc As Single, ptakent As Double
Common Shared As _Byte redoflag '         time machine
Common Shared As _Byte readonly '         after playback or setup
Common Shared As _Byte rickfile '         logging stuff for me
Common Shared As _Byte rflag '            in recursion, computer thinking
Common Shared As _Byte rotate '           0none, 1 -90, 2 180, 3 90
Common Shared rto '                       return to origin
Common Shared As _Byte SaveWorB '         because I monkey with WorB
Common Shared As _Byte scheme '           1-12 predefined color/set/clock
Common Shared As _Byte screensaver '      fully automatic
Common Shared As _Byte sfast '            save fast (playback/Enter10)
Common Shared sfx1, sfx2, sfy1
Common Shared shia '                      start history at
Common Shared As _Byte showright '        0 history,1 small boards,3 thinkin
Common Shared As _Byte showthinkingf '    flag
Common Shared As _Byte showmousepos '     magnifying lens
Common Shared smoves0, smovest
Common Shared As _Byte smode, smode0 '    screen mode
Common Shared As _Byte sob '              scores on board
Common Shared As _Byte soundloaded '      flag
Common Shared As _Byte squaretrim '       four styles - off, single thick, two
Common Shared As _Byte smallclock '       elapsed time this move
Common Shared As _Byte takebackflag '     cheater!
'Common Shared tel! '                     subroutine time tracker
Common Shared As _Byte testing '          flag
Common Shared top_mps '                   moves per second
'Common Shared As _Byte ttflag '          time tracking
Common Shared As _Byte usd '              upsidedown
Common Shared As _Byte wasFEN '           FEN move
Common Shared As _Byte wasplayback
Common Shared As _Byte wasreadonly
Common Shared As _Byte WorB '             whose move it is, 0 black 1 white
Common Shared xmas, xmasc, xmast As _Float
Common Shared As _Byte xq, yq, hxq, hyq '                       square size, half size
Common Shared xc, yc, xm, ym '                                  center, max
Common Shared tlx, trx, blx, brx, tly, try, bly, bry '          top left, bottom rught, etc

Common Shared As _Byte bkc, bkr, wkc, wkr '                     King locations
Common Shared As _Byte bpc, bpr, wpc, wpr '                     pawn locations
Common Shared As _Byte hfc, hfr, htc, htr '                     human from column/row, to column/row
Common Shared As _Byte lfc, lfr, ltc, ltr '                     human from column/row, to column/row

Common Shared FEN, FENcount, FENmax, FENpcount
Common Shared FEN$, FENm$, FENmess$, FENold$, FENreply$, FENreplyold$, FENpartial$
Dim Shared FEN$(1000), FENreply$(1000), FENperp$(511)

Common Shared boardwhite As _Unsigned Long '           white squares
Common Shared boardblack As _Unsigned Long '           black squares
Common Shared black As _Unsigned Long '                Johnny Cash
Common Shared blue As _Unsigned Long '                 a Joni Mitchell album
Common Shared clockc As _Unsigned Long '               clock AND any non-board text/markers
Common Shared gray As _Unsigned Long '                 Confederate soldiers
Common Shared green As _Unsigned Long '                Patty Gurdy song
Common Shared red As _Unsigned Long '                  Communists!
Common Shared white As _Unsigned Long '                Vanna White
Common Shared yellow As _Unsigned Long '               coward
Common Shared zip As _Unsigned Long '                  Saran Wrap
Common Shared menubg As _Unsigned Long '               dim background for main menu at bottom
Common Shared As _Unsigned Long c1, c2 '                general purpose colors

Dim Shared tcount As _Unsigned _Integer64 '            total count moves computed
Dim Shared ocount As _Unsigned _Integer64 '            previous (old) count of above

Common Shared castle$ '                                status, 4 chars BQ BK WQ WK
Common Shared ConfigFile$ '                            settings
Common Shared datapath$ '                              .\chessdat\
Common Shared debug$ '                                 crap I print at top left for debugging
Common Shared desc$
Common Shared Enter$, Esc$ '                           keyboard
Common Shared epsq$ '                                  target square for en passant
Common Shared gamepath$ '                              .\chessdat\games
Common Shared logfile$, logfiled$ '                    saved moves
Common Shared m$ '                                     algebraic move
Common Shared ComputerName$ '                          hostname
Common Shared draw$ '                                  "draw" or half/half
Common Shared f$ '                                     filename, usually
Common Shared fd$ '                                    file date
Common Shared i$ '                                     INKEY$
Common Shared istuff$ '                                feeding mouse box contents to inkey SUB
Common Shared lct$ '                                   last centered text
Common Shared msg$ '                                   abort, usually
Common Shared NameEntered$ '                           better be Chuck Norris
Common Shared pf$ '                                    playback file
Common Shared q$ '                                     quote, chr$(34)
Common Shared promote$ '                               what a piece was promoted to
Common Shared s$ '                                     invisible space, chr$(255)
Common Shared TempMess$ '                              messages to Shirley Temple

Common Shared ClockTime As Double '                    same as Miller Time
Common Shared cursoron As Double '                     cursor turns off to help concentration
Common Shared drawblink As Double
Common Shared NoChangeUntil As Double
Common Shared start As Double
Common Shared waituntil As Double
Common Shared keypressedat As Double
Common Shared lastclick As Double
Common Shared mousemovedat As Double

'Dim Shared ant(10)
'Dim Shared As _Byte active(200) '                     SUB time tracking
Dim Shared alphal$(8) '                                a b d e f g h
Dim Shared alphap$(8) '                                for smallboards
'Dim Shared attackc(10)
Dim Shared As _Byte b(8, 8) '                          main board
Dim Shared As _Byte b2(8, 8) '                         board to display
'Dim Shared best(6)
Dim Shared bolt(1)
Dim Shared cc(1) As _Unsigned Long
Dim Shared As _Byte ca1(2, 5), ca2(2, 5) '             castling data
Dim Shared As _Byte CanMove(5) '                       for endgame strategy
Dim Shared caption$(500) '                             id funny pix
Dim Shared castle$(tbmax) '                            takeback stack
Dim Shared cenbuff(22000) '                            quick bottom of screen menu replot
Dim Shared ColorDesc$(32)
Dim Shared cp(32) As _Unsigned Long '                  colors
Dim Shared As _Byte du(6, 7), dd(6, 7), dl(6, 7), dr(6, 7) '    piece up/down/left/right
Dim Shared etime(1, 1) As Double '                     elapsed
Dim Shared myfont(32) '                                not your font
Dim Shared FunnyPix$(500) '                            unusual pieces
Dim Shared As _Byte ksv(8, 8) '                        king square value (endgame, favor center for safety)
Dim Shared lmove(tbmax) As mtype '                     log for takeback
Dim Shared mcount(8) As _Unsigned _Integer64 '         move counts
Dim Shared mfx1(99), mfx2(99), mfy1(99), mfy2(99), mft$(99) ' boundaries of clickable
Dim Shared move(8, 511) As mtype '                     generated and scored
Dim Shared As _Byte Moves(8) '                         by level
Dim Shared mlog$(511, 3) '                             move: black alg, white alg, black desc, white desc
'Dim Shared name$(200) '                               SUB timing tracking
'Dim Shared time_used(200) As Single '                 SUB timing tracking
'Dim Shared mi(10)
Dim Shared As _Byte o(8, 8) '                          original board
Dim Shared As _Byte onboard(14) '                      we must count the coconuts
Dim Shared pcount(1, 6), points(1) '                   what's left on the board, value totalled
Dim Shared As _Byte tb(8, 8, tbmax) '                  takeback move stack
Dim Shared pix(10, 14) '                               sets of pieces
Dim Shared pixh(10, 14) '                              hardware version of pieces
Dim Shared As _Byte myr(32), myg(32), myb(32) '        rgb for each color, 63 max
Dim Shared piecef$(14) '                               funny set filename
Dim Shared As _Byte piecefn(14) '                      funny set number (x of y choices)
Dim Shared PlayerName$(3), pdate$ '                    who's playing and when
'Dim Shared as _byte protc(10)
Dim Shared psa(10, 1) '                                piece size adjustments
Dim Shared sfile(14), svol(14) As Single '             sound files and volume
Dim Shared As _Byte sloaded(10) '                      set loaded flags
Dim Shared ssb(500) '                                  save small board
Dim Shared thinkv(500) As Integer '                    optional show thinking
Dim Shared think$(500) '                               optional show thinking
Dim Shared value(14) As Integer '                      for capture

Dim Shared As _Byte s1(8, 8), s2(8, 8), s3(8, 8), s4(8, 8), s5(8, 8), s6(8, 8), s7(8, 8), s8(8, 8)
Dim Shared m(10) As _MEM

Dim mi '                                               move index
Dim As _Byte i, tc, tr, WorBs, isdraw, tpoints, wsb '        more main loop vars

'activated for debugging
'Console
'_Console On

InitSystem '                                                         one time initializations

' ------------------------------------------------------------------ THE BIG ENCHILADA (MAIN LOOP) -------------------------------------------------------
begin:
WorBs = 0
InitGame '                                                           initializations for each game

mainloop:
usd = -((human = 2) And (WorB = 0) And (binvert = 0)) '              upsidedown
If onplayback Then wasplayback = true
If msg$ = "Checkmate" Then
    AddSymbol "+"
    If onplayback Then
        Erase etime
        start = ExtendedTimer
    End If
    onplayback = false
    GoTo popcornstand
End If
FENold$ = FEN$
FENreplyold$ = FENreply$
FENmake
If perpetual > 2 Then
    msg$ = "Perpetual"
    GoTo popcornstand
End If
SaveWorB = WorB '                                                    white (1) or black (0)

redo:
_MemCopy m(0), m(0).OFFSET, m(0).SIZE To m(10), m(10).OFFSET '       copy working b() to display board b2()
Reset_To_Zero '                                                      does a level 0 & level 1 check
i = onplayback Xor 1 '                                               playback issues checks, stop repeating
Fking i '                                                            find Kings (did you suspect otherwise?)
'TakeBest 0, 0
If Len(FENmess$) Then TempMess$ = FENmess$: FENmess$ = ""
PlotScreen false
If onplayback Then Erase etime: start = ExtendedTimer
onplayback = false
isdraw = false
tpoints = points(0) + points(1)
If tpoints = 0 Then isdraw = true '                                  only Kings on board
If (points(1) < 4) And (points(0) < 4) And ((pcount(0, 6) + pcount(1, 6)) = 0) Then isdraw = true '  must be just a knight or bishop each
If drawcount > 49 Then isdraw = true
If isdraw Then msg$ = "Draw": GoTo popcornstand
i = incheck '                                                        save for a few lines down
RemoveIllegal 0 '                                                    there's a new Sheriff in town
BoardStats

If Moves(0) = 0 Then '                                               no legal moves
    If i Then '                                                      incheck, saved from 2 lines up
        msg$ = "Checkmate"
        AddSymbol "+" '                                              throw another log on the fire
        PlaySound won
    Else
        msg$ = "Stalemate"
        AddSymbol "draw"
        PlaySound stalemate
    End If
    GoTo popcornstand
End If

ocount = 0
oply = -1
nosend = false
If cmode = 0 Then
    start = ExtendedTimer
    etime(1, WorB) = 0
End If

If (human And (humanc = WorB)) Or (human = 2) Then '                 2 is two humans
    If human = 2 Then invert = (WorB = 0)
    Do
        If match = 3 Then
            ToFrom 1, m$, match '                                    get move from Minimax
            hfc = InStr(alphaz$, Left$(m$, 1)) '                     from column
            hfr = Val(Mid$(m$, 2, 1)) '                              from row
            htc = InStr(alphaz$, Mid$(m$, 3, 1)) '                   to column
            htr = Val(Mid$(m$, 4, 1)) '                              to row
            GoTo woof
        Else
            HumanMove
        End If
        If human = 0 Then GoTo redo '                                pressed A for automatic (computer play)
        If Len(msg$) Then GoTo popcornstand '                        quit or resign
        If onplayback Then GoTo mainloop
        If redoflag Then redoflag = false: GoTo redo '               was in setup
        If takebackflag Then
            If dev = 0 Then PlaySound takeback '                     so your mom knows you're cheating  :)
            GoTo takebackmove '                                      take back move (or tunnel boring machine)
        End If
        woof:
        fc = hfc: fr = hfr: tc = htc: tr = htr
        p = b(fc, fr) And 7
        If (p = King) And (fc = 5) And (tc = 7) Then fc = -fc '      kingside castle
        If (p = King) And (fc = 5) And (tc = 3) Then fr = -fr '      queenside castle
        For mi = 1 To Moves(0) '                                      check against legal list
            If (fc = move(0, mi).fc) And (fr = move(0, mi).fr) And (tc = move(0, mi).tc) And (tr = move(0, mi).tr) Then Exit Do
        Next mi
        If makenoise Then PlaySound illegal
        TempMess$ = "Not  legal"
    Loop
    If (match > 0) And (fc > 0) And (fr > 0) Then PieceSlide fc, fr, tc, tr
    markerfc = 0 '                                                   markers
    smoves0 = 0
ElseIf (match = 1) Or (match = 2) Then
    Do: _Limit mloop
        ToFrom 1, m$, match '                                        get move from remote player
        PlotScreen true
        KeyScan
    Loop Until Len(m$)
    If InStr("en ng", m$) Then msg$ = "Resign": GoTo popcornstand ' end or new game
    nosend = true
    fc = InStr(alphaz$, Left$(m$, 1)) '                              from column
    fr = Val(Mid$(m$, 2, 1)) '                                       from row
    tc = InStr(alphaz$, Mid$(m$, 3, 1)) '                            to column
    tr = Val(Mid$(m$, 4, 1)) '                                       to row
Else
    If giveup > 0 Then
        giveup = false
        GoTo hack
    End If

    FENcheck
    If Len(FENm$) = 0 Then
        wasFEN = false
    Else
        TempMess$ = "FEN move"
        fc = InStr("abcdefgh", Mid$(FENm$, 1, 1))
        fr = Val(Mid$(FENm$, 2, 1))
        tc = InStr("abcdefgh", Mid$(FENm$, 3, 1))
        tr = Val(Mid$(FENm$, 4, 1))
        FENm$ = ""
        GoTo gotmove
    End If

    abort = false '                                                  initialize, spacebar will set this true
    rflag = true '                                                   flag in recursion to stop displaying board
    Center 0, "", true, false '                                      instructions at bottom
    plasma_init = false

    'TimeTrack "Recurse", 1
    'For mi = 1 To Moves(0)
    '    move(0, mi).mi = i
    'Next mi
    wsb = dosmallboard
    If cycle Then dosmallboard = true
    ClockTime = ExtendedTimer
    Recurse 1
    If cycle Then dosmallboard = wsb
    'TimeTrack "Recurse", 0

    oply = -1
    smoves0 = Moves(0)
    If abort Then
        abort = false
        msg$ = ""
        WorB = SaveWorB
    End If
    TakeBest 0, true

    ShowTaken false '                                                          do not display, tally up points
    WorB = SaveWorB

    giveup = false

    If (points(WorB) = 0) And (move(0, 1).sc < 32) Then '                      no captures
        If onboard(Rook - (WorB = 0) * 8) Then giveup = 1 '                    king vs king+rook
        If points(WorB Xor 1) > 6 Then giveup = 2 '                            king vs lots
    End If
    If move(0, 1).sc < -600 Then giveup = 3 '                                  mate next move

    'If masterlevel = 4 Then
    '    j = true
    '    For i = 1 To smoves0
    '        If Right$(think$(i), 4) <> "777" Then j = false
    '    Next i
    '    If j Then giveup = 4 '                                                mate in two
    'End If

    If (giveup > 0) And (noresign = false) Then
        If minactive Then ToFrom 0, "re", match '                              signal Minimax new game
        msg$ = Mid$("BlackWhite", WorB * 5 + 1, 5) + "  resigns"
        'If rickfile Then msg$ = msg$ + Str$(giveup) + Str$(points(0)) + Str$(points(1)) + Str$(move(0, 1).sc)
        rflag = 0
        PlotScreen true '                                                      to show the "res" in history
        PlaySound resign
        newinfo = true
        GoTo popcornstand
    End If

    ' highly optional block, looks deeper for top 2 or 3 moves, very slow, activated with D
    'If (deep = 0) Or (Moves(0) < 2) Then GoTo not_today
    'z$ = ToAlg(0, 1)
    'Line (tlx, 2)-(trx, tly - 1), bg0, BF
    'sm = masterlevel
    'Moves(0) = deep + 1 '                                            re-evaluate 1 or 2 moves
    'masterlevel = 4 + deep '                                         5 or 6 (if running default 4 plies)
    'Recurse 1 '
    'TakeBest 0, true
    'masterlevel = sm
    'If dev And (z$ <> ToAlg(0, 1)) Then Sound 555, 1
    'TempMess$ = z$ + " " + ToAlg(0, 1)
    'not_today:

    hack:
    fc = move(0, 1).fc: fr = move(0, 1).fr: tc = move(0, 1).tc: tr = move(0, 1).tr

    PlaySound movedone
    rflag = 0 '                                                      recursion flag off
    keypressedat = ExtendedTimer
    mousemovedat = ExtendedTimer
    newinfo = true
    If sob Then HistoryX: ScoresOnBoard
End If

gotmove:
shia = 0
If Len(msg$) Then WorBs = WorB + 1: GoTo popcornstand
WorB = SaveWorB
If match Or Not ((human = 1) And (WorB = humanc)) Then MarkerSave fc, fr, tc, tr
MoveItReal fc, fr, tc, tr
m$ = alphal$(Abs(fc)) + CHRN$(Abs(fr)) + alphal$(Abs(tc)) + CHRN$(tr)
If fc < 0 Then m$ = "O-O" '                                          kingside castle
If fr < 0 Then m$ = "O-O-O" '                                        queenside castle
AddLog '                                                             log, written on program exit
FENreply$ = m$
WorB = SaveWorB Xor 1 '                                              toggle white/black
PlotScreen true
If perpetual > 2 Then msg$ = "Perpetual": GoTo popcornstand
If drawcount > 49 Then msg$ = "Draw": GoTo popcornstand

If (match > 0) And (nosend = false) Then
    m$ = alphal$(Abs(fc)) + CHRN$(Abs(fr)) + alphal$(Abs(tc)) + CHRN$(tr)
    ToFrom 0, m$, match '                                            sending move
    nosend = false
End If

If move < 501 Then GoTo mainloop '                                   end of main loop
msg$ = "Over 500 moves..."

popcornstand: '                                                      end of a game
If rickfile Then Print #rickfile, "" '                               mps.txt, long term averaging
If (msg$ = "Over 500 moves...") Or (msg$ = "Draw") Or (msg$ = "Perpetual") Then AddSymbol "draw"
If InStr(LCase$(msg$), "res") Then AddSymbol "res"
WriteLog false
PlotScreen true
Playagain '                                                           white/black/humans/computer
abort = false '                                                      flag reset
msg$ = "" '                                                          nothing to see here people, move along

If (human = 0) Or (i$ = "n") Then GoTo begin

i = move - 1 - (move = 0)
If i$ = "b" Then GoTo takebackmove

If WorBs Then '                                                      must be r for resume
    WorB = WorBs - 1: WorBs = 0 '                                    resume with same color
    WorB = WorB Xor 1
End If
GoTo redo

takebackmove:
move = move + (InStr(mlog$(move, 1), "draw") > 0)
move = move - 1
If move < 0 Then move = 0
If WorB = 0 Then
    mlog$(move, 0) = "" ' black alg
    mlog$(move, 2) = "" ' black desc
End If
mlog$(move + 1, 1) = "" ' white alg
mlog$(move + 1, 0) = "" ' black alg
mlog$(move + 1, 3) = "" ' white desc
mlog$(move + 1, 2) = "" ' black desc

TakeBackPop
takebackflag = false
_MemCopy m(0), m(0).OFFSET, m(0).SIZE To m(10), m(10).OFFSET '       copy working b() to display board b2()
PlotScreen false
SaveWorB = WorB '                                                    white (1) or black (0)
oply = false
GoTo redo

Sub AboveBoardInfo ()
    Static onscreen$, mtime As Double
    Dim As _Byte i
    Dim As Integer tx, ci, ai

    Buttons 0, 0

    If barebones Or inhelp Then Exit Sub
    'TimeTrack "AboveBoard", 1

    If Len(TempMess$) Then '                                         new message
        onscreen$ = TempMess$
        TempMess$ = ""
        mtime = ExtendedTimer + 3
    End If

    If Len(LTrim$(onscreen$)) = 0 Then
        If loadsetsinbackground And (allsetsloaded = false) Then
            If dev Then
                For i = 0 To 9 '                                     show progress of loading sets
                    tx = xc + (i - 4.5) * 8
                    If sloaded(i) Then c1 = _RGB32(0, 200, 0) Else c1 = _RGB32(200, 0, 0)
                    Circle (tx, 28), 2, c1
                    Paint (tx, 28), c1, c1
                Next i
            End If

            c1 = ExtendedTimer - keypressedat
            c2 = ExtendedTimer - mousemovedat
            If (keypressedat > 0) And (c1 > 2) And (c2 > 2) Then
                allsetsloaded = true
                For i = 0 To 9
                    If sloaded(i) = false Then
                        allsetsloaded = false
                        LoadPieces (i)
                        keypressedat = ExtendedTimer
                        mousemovedat = ExtendedTimer
                        Exit For
                    End If
                Next i
            End If
        End If
    Else
        _PutImage (tlx, 0)-(trx, try - 1), bgi, 0, (tlx, 0)-(trx, try - 1)
        For tx = tlx To trx '                                        shaded background
            ci = 170 - Abs((tlx + trx) \ 2 - tx) '                   color intensity
            If ci < 0 Then ci = 0
            ai = (ci + 80) \ 2 '                                     alpha intensity
            If ai > 255 Then ai = 255
            Select Case bgc
                Case 0: c1 = _RGBA(ci, 0, 0, ai) '                   red
                Case 1: c1 = _RGBA(0, ci, 0, ai) '                   green
                Case 2: c1 = _RGBA(0, 0, ci, ai) '                   blue
                Case 3: c1 = _RGBA(0, ci, ci, ai) '                  cyan
                Case 4: c1 = _RGBA(ci, ci, 0, ai) '                  yellow
                Case 5: c1 = _RGBA(ci, ci, ci, ai) '                 white
            End Select
            Line (tx, 0)-(tx, try - 1), c1
        Next tx

        SetFont defaultfontsize
        ShadowPrint xc - _PrintWidth(onscreen$) \ 2, 17, onscreen$, white

        If Left$(onscreen$, 9) = "Genevieve" Then '                  Bujold, accent over last "e"
            Line (xc - 50, 16)-Step(2, 1), black
            Line (xc - 50, 15)-Step(2, 1), white
        End If
    End If

    If (mtime > 0) And (ExtendedTimer > mtime) Then '                time up, erase message
        onscreen$ = ""
        mtime = 0
    End If

    If (pregame = 0) And (ingetfile = 0) Then
        ShowPoints '                                                 ahead/behind, plus perpetual:draw
        'If Len(onscreen$) = 0 Then R_T_C '                          ordinary clock
        If piece_style > 0 Then DispStats '                          don't want this data obscuring piece descriptions
    End If

    'TimeTrack "AboveBoard", 0
End Sub

Sub AddMove (level As _Byte, score, fc As _Byte, fr As _Byte, tc As _Byte, tr As _Byte)
    mcount(level) = mcount(level) + 1 '                              for fun, tracking moves evaluated per second
    Moves(level) = Moves(level) + 1 '                                count, baron, viceroy, pick one
    move(level, Moves(level)).fc = fc '                              from column
    move(level, Moves(level)).fr = fr '                              from row
    move(level, Moves(level)).tc = tc '                              to column
    move(level, Moves(level)).tr = tr '                              to row
    'move(level, Moves(level)).os = score '                           original score
    move(level, Moves(level)).sc = score '                           hey man, can I score a lid?
    'move(level, Moves(level)).mi = mi(level) '                      move index
End Sub

Sub AddLog '                                                         put another log on the fi-ire...
    Dim tm$
    tm$ = m$ '                                                       temporary copy to modify

    If Len(promote$) Then '                                          Q, usually
        tm$ = tm$ + promote$
        desc$ = desc$ + "(" + promote$ + ")"
        promote$ = "" '                                              discard after use
    End If

    move = move + WorB '                                             increment on White
    mlog$(move, WorB) = tm$ '                                        algebraic notation
    mlog$(move, 2 + WorB) = desc$ '                                  descriptive notation
    WriteLog false
End Sub

Sub AddSymbol (sym$) '                                               play log

    If sym$ = "res" Then '                                           resign
        If WorB Then '                                               white
            move = move + 1 + (InStr(mlog$(move, 1), "res") > 0)
            mlog$(move, 1) = "res" '                                 white alg
            mlog$(move, 3) = "res" '                                 white desc
        Else '                                                       black
            mlog$(move, 0) = "res" '                                 black alg
            mlog$(move, 2) = "res" '                                 black desc
        End If
    ElseIf sym$ = "draw" Then '                                      draw
        If WorB Then '                                               white
            move = move + 1 + (InStr(mlog$(move, 1), draw$) > 0)
            mlog$(move, 1) = draw$ '                                 white alg
            mlog$(move, 3) = draw$ '                                 white desc
        Else '                                                       black
            mlog$(move, 0) = draw$ '                                 black alg
            mlog$(move, 2) = draw$ '                                 black desc
        End If
    Else '                                                           check, checkmate, stalemate
        If Len(LTrim$(mlog$(move, 1 - WorB))) > 0 Then
            If Right$(mlog$(move, 1 - WorB), 1) <> sym$ Then mlog$(move, 1 - WorB) = mlog$(move, 1 - WorB) + sym$
            If Right$(mlog$(move, 3 - WorB), 1) <> sym$ Then mlog$(move, 3 - WorB) = mlog$(move, 3 - WorB) + sym$
        End If
        If InStr(LCase$(msg$), "checkmate") And (Right$(mlog$(move, 1 - WorB), 2) <> "++") Then
            mlog$(move, 1 - WorB) = mlog$(move, 1 - WorB) + "+"
            mlog$(move, 3 - WorB) = mlog$(move, 3 - WorB) + "+"
        End If
    End If
    oply = false
    PlotScreen false
    WriteLog false
End Sub

Sub Alarms Static '                                                  personal use sub, an alarm clock since I'm playing/testing so much
    Dim As _Byte alarminit, i, d, m, dow, z1, z2, z3, weekend, alarmfor
    Dim f, y

    If alarminit = false Then
        Dim dow$(10), alarm$(10)
        dow$(1) = "wd": alarm$(1) = "07:30" '                        weekdays breakfast
        dow$(2) = "we": alarm$(2) = "10:30" '                        weekends brunch
        dow$(3) = "wd": alarm$(3) = "11:45" '                        weekdays lunch
        dow$(4) = "all": alarm$(4) = "14:10" '                       all days afternoon snack
        dow$(5) = "all": alarm$(5) = "17:15" '                       all days dinner
        dow$(6) = "all": alarm$(6) = "20:10" '                       all days late snack

        d = Val(Mid$(Date$, 4, 2)) '                                 month
        m = Val(Mid$(Date$, 1, 2)) '                                 month
        y = Val(Mid$(Date$, 7, 4)) '                                 year
        f = y * 365 + 31 * (m - 1) + d
        If m < 3 Then
            f = f + (y - 1) \ 4 - (.75 * (y - 1) \ 100 + 1)
        Else
            f = f - Int(.4 * m + 2.3) + (y \ 4) - (.75 * (y - 1) \ 100 + 1)
        End If
        f = f - (y > 2000)
        dow = f Mod 7 '                                              0sat,1sun,2mon,3tue,4wed,5thu,6fri
        If dow < 2 Then weekend = true
        alarminit = true

        dow$(0) = "all" '                                            for testing
        i = Val(Mid$(Time$, 4, 2)) + 1
        alarm$(0) = Left$(Time$, 3) + Right$("0" + LTrim$(Str$(i)), 2)
    End If

    If (alarmfor = 0) And (Val(Mid$(Time$, 7, 2)) = 1) Then
        For i = 1 To 6 '                                             make 0 to 6 for testing
            z1 = (dow$(i) = "all")
            z2 = (dow$(i) = "we") And (weekend = true)
            z3 = (dow$(i) = "wd") And (weekend = false)
            If (Left$(Time$, 5) = alarm$(i)) And (z1 Or z2 Or z3) Then alarmfor = 10
        Next i
    End If

    If alarmfor Then
        alarmfor = alarmfor - 1
        Sound 7777, 1
    End If
End Sub

Sub AnyKey '                                                         Yes Virginia, there is a Santa Claus
    Dim x, tscreen, t$
    t$ = "Any key or mouse click to return to the game"
    x = _Width \ 2 - _PrintWidth(t$) \ 2 + 8
    ShadowPrint x, _Height - 20, t$, white
    DisplayMaster true
    tscreen = _CopyImage(0)
    nbox = 4
    Do: _Limit 10
        _PutImage , tscreen, 0
        t$ = InKey$
        MouseIn
    Loop Until (Len(t$) > 0) Or b1 Or b2
    If dev And (t$ = "q") Then Quit
    _FreeImage tscreen
    ClearBuffers
End Sub

Sub Background
    Dim i, k, y, z

    If bgi < -1 Then
        _PutImage , bgi, 0
    Else
        Cls , black
        If altbg < 4 Then
            k = 177
            For i = 1 To _Height \ 2
                y = _Height - 1 - i * 2
                z = 200 - i
                z = z * bri / 4
                Select Case bgc
                    Case Is = 0: c1 = _RGBA(z, 0, 0, k) '            red
                    Case Is = 1: c1 = _RGBA(0, z, 0, k) '            green
                    Case Is = 2: c1 = _RGBA(0, 0, z, k) '            blue
                    Case Is = 3: c1 = _RGBA(0, z, z, k) '            cyan
                    Case Is = 4: c1 = _RGBA(z, z, 0, k) '            yellow
                    Case Is = 5: c1 = _RGBA(z, z, z, k) '            white
                End Select
                Line (0, y)-(_Width - 1, y - 1), c1, BF
            Next i
        End If
        Select Case altbg
            Case 0: bg2 '                                            hexagons
            Case 1: bg3 '                                            rotated squares
            Case 2: Serp '                                           Sierpinski curve
                ' 3 plain shaded
                ' 4 none (black)
            Case 5 '                                                 Cheetos
                c1 = _LoadImage(datapath$ + "bg_ch.jpg")
                If c1 < -1 Then
                    _PutImage , c1, 0
                    _FreeImage c1
                End If
            Case 6 '                                                 Fruit Loops
                c1 = _LoadImage(datapath$ + "bg_fl.jpg")
                If c1 < -1 Then
                    _PutImage , c1, 0
                    _FreeImage c1
                End If
        End Select
        If bgi < -1 Then _FreeImage bgi
        bgi = _CopyImage(0)
        If ssb(1) < -1 Then _FreeImage ssb(1): ssb(1) = 0
        oply = -1
        lpoints = -1
    End If
End Sub

Sub bg2 '                                                            hexagon background
    Dim xc, yc, xb, xo, z1, z2, a, x, y, i, s, tr, tg, tb

    c1 = Point(1, _Height - 40)
    tr = _Red32(c1)
    tg = _Green32(c1)
    tb = _Blue32(c1)
    For yc = 44 To 560 Step 9
        xb = xb Xor 1
        xo = xb * 16 '                                               offset
        c1 = yc / 560 * 100 '                                        alpha
        c2 = 100 - c1 '                                              a different alpha
        For xc = 8 To 790 Step 32
            For z1 = -1 To 0 '                                       joggle x origin
                For z2 = -1 To 0 '                                   joggle y origin
                    For s = 0 To 1 '                                 size (radius)
                        For i = 0 To 6 '                             sides
                            a = (i + 3) * 60 '                       angle
                            x = xc + (10 - s + z1) * Cos(_D2R(a)) + xo
                            y = yc + (10 - s + z2) * Sin(_D2R(a))
                            If s = 0 Then '                          draw all sides at this size
                                If i = 0 Then PSet (x + z1, y + z2), _RGBA(0, 0, 0, c2)
                                Line -(x + z1, y + z2), _RGBA(0, 0, 0, c2)
                            End If
                            If s = 1 And i < 3 Then '                two sides of inner hexagon
                                If i = 0 Then PSet (x + z1, y + z2), _RGBA(tr, tg, tb, c1)
                                Line -(x + z1, y + z2), _RGBA(tr, tg, tb, c1)
                            End If
                        Next i
                    Next s
                Next z2
            Next z1
        Next xc
    Next yc
End Sub

Sub bg3
    Dim i, d, x, y, z, xc, yc, ang1, ang2, tr, tg, tb, x(100), y(100), rad!
    Static rd

    rd = rd Xor 1
    c1 = Point(1, _Height - 40)
    tr = _Red32(c1)
    tg = _Green32(c1)
    tb = _Blue32(c1)

    d = 28
    For ang1 = 0 To 100 Step 10
        d = d - 2
        For ang2 = 0 To 4
            rad! = _D2R(ang1 + ang2 * 90 - 45)
            i = i + 1
            x(i) = d * Sin(rad!)
            y(i) = d * Cos(rad!)
        Next ang2
    Next ang1

    For yc = 54 To 560 Step 38
        z = Sgn(((yc \ 38) Mod 2) - .5)
        For xc = 19 To 780 Step 38
            i = 0
            For ang1 = 0 To 100 Step 10
                For ang2 = 0 To 4
                    i = i + 1
                    x = xc + x(i) * z
                    y = yc + y(i)
                    c2 = _RGB32(tr, tg, tb, yc \ 2.4)
                    If ang2 = 0 Then PSet (x, y), c2 Else Line -(x, y), c2
                Next ang2
            Next ang1
            If rd Then z = -z
        Next xc
    Next yc
End Sub

Sub BoardStats '                                                     sets canmove array, for strategy
    Dim As _Byte i, k
    Dim mi, seen$(32)

    For i = 0 To 1 '                                                 0 current player, 1 next move
        CanMove(i) = 0
        If Moves(i) Then
            For mi = 1 To Moves(i)
                k = move(i, mi).fc
                If (k > 0) And (move(i, mi).fr > 0) Then
                    m$ = alphal$(k) + CHRN$(move(i, mi).fr)
                    For k = 1 To CanMove(i)
                        If m$ = seen$(k) Then GoTo ni
                    Next k
                    CanMove(i) = CanMove(i) + 1
                    seen$(CanMove(i)) = m$
                End If
                ni: '                                                we are the knights who say ni
            Next mi
        End If
    Next i
End Sub

Sub BrightnessAdjust (set As _Byte, piece As _Byte)
    Dim i, r, g, b, xs, ys, tx, ty, tscreen, itemp, tr, tg, tb, tbright As Single

    tscreen = _CopyImage(0)
    Cls , zip
    xs = xq - 1
    ys = yq - 1
    _PutImage (0, 0)-(xs, ys), pix(set, piece), 0

    If (set = 7) And (piece = 2) Then '                              fix black knight of set 8
        c1 = _RGB32(1, 1, 1)
        Circle (26, 27), 5, c1
        Paint (26, 27), c1, c1
        Line (10, 26)-Step(12, 6), c1, BF
    End If

    If (set = 0) And (InStr(f$, "bishop13") > 0) Then '              invert white bishop of set 0
        itemp = _NewImage(xq, yq, 32)
        Screen itemp
        _PutImage , pix(0, piece), 0
        _FreeImage pix(0, piece)
        For ty = 0 To ys
            For tx = 0 To xs
                c1 = Point(tx, ty)
                tr = 255 - _Red32(c1)
                tg = 255 - _Green32(c1)
                tb = 255 - _Blue32(c1)
                PSet (tx, ty), _RGB32(tr, tg, tb)
            Next tx
        Next ty
        pix(0, piece) = _CopyImage(0)
        Screen mscreen
        _PutImage (0, 0)-(xs, ys), pix(0, piece), 0
        _FreeImage itemp
    End If

    tbright = bri * .25

    For ty = 0 To ys
        For tx = 0 To xs
            c1 = Point(tx, ty)
            If c1 <> zip Then
                r = tbright * _Red32(c1)
                g = tbright * _Green32(c1)
                b = tbright * _Blue32(c1)
                PSet (tx, ty), _RGBA(r, g, b, 255)
            End If
        Next tx
    Next ty

    If set = 0 Then '                                                funny set, make borders
        If piece < 7 Then c1 = black Else c1 = _RGBA(tbright * 255, tbright * 255, tbright * 255, 255)
        For i = 0 To 5
            Line (i, i)-(xs - i, ys - i), c1, B
        Next i
    End If
    _PutImage , 0, pix(set, piece), (0, 0)-(xs, ys)
    If pixh(set, piece) < -1 Then _FreeImage pixh(set, piece)
    pixh(set, piece) = _CopyImage(pix(set, piece), 33)

    _PutImage , tscreen, 0
    _FreeImage tscreen
End Sub

Sub Buttons (ptc As _Unsigned Long, se As _Byte)
    Dim As _Byte i, xi, xs
    Dim x0, x1, x2, y1, tc As _Unsigned Long

    'TimeTrack "Buttons", 1

    If rotate And (inhelp = false) Then x0 = trx + 8 Else x0 = _Width
    x0 = x0 - 86 + (inshow = 2) * 35
    tc = ptc
    xs = 10
    xi = 20
    x1 = x0
    y1 = 21

    If fullscreenflag Then

        If (tc = 0) Or inhelp Then tc = _RGB32(80, 80, 80)

        If inhelp Or insetup Then
            If (ptc <> 0) And (se > 0) Then tc = white Else tc = gray
        End If

        If (se = 0) Or (se = 1) Then '                               help
            Color tc, zip
            SetFont 16
            If inhelp = false Then _PrintString (x1 + 1, y1 - 12), "?"
        End If

        x1 = x1 + xi: x2 = x1 + xs
        If (se = 0) Or (se = 2) Then
            Line (x1, 20)-(x2, 20), tc '                             minimize
        End If

        x1 = x1 + xi: x2 = x1 + xs
        If (se = 0) Or (se = 3) Then
            Line (x1, y1)-(x2, y1 - 10), tc, B '                     fullscreen
            Line (x1 + 2, y1 - 2)-(x2 + 2, y1 - 12), tc, B
        End If

        x1 = x1 + xi: x2 = x1 + xs
        If (se = 0) Or (se = 4) Then
            Line (x1, y1)-(x2, y1 - 10), tc '                        exit
            Line (x2, y1)-(x1, y1 - 10), tc
        End If

        For i = 1 To 4 '                                             store locations for mouse clicking
            mfx1(i) = x0 + (i - 1) * xi - 2
            mfy1(i) = 8
            mfx2(i) = mfx1(i) + xs + 5
            mfy2(i) = mfy1(i) + 17
        Next i
    End If

    If (promoting + inhelp + pregame + insettings + insetup + ingetfile + inshow - (se > 0)) Then GoTo flopdoodle

    nbox = 5
    mft$(5) = "k" '                                                  bare bones toggle
    mfx1(5) = boltx1
    mfy1(5) = bolty1
    mfx2(5) = boltx2
    mfy2(5) = bolty2
    If barebones Then chimp = 5: GoTo flopdoodle
    ' ---------------------------------------------------------------------------------------------------------
    tc = _SHL(bri, 4)
    tc = _RGB32(tc, tc, tc)
    SetFont defaultfontsize

    If (move > 0) And (dosmallboard = 0) And (showthinkingf = 0) Then
        nbox = nbox + 1
        mft$(nbox) = "Alg" '                                             algebraic
        mfx1(nbox) = trx + 10
        mfx2(nbox) = mfx1(nbox) + 15
        mfy1(nbox) = try + 2
        mfy2(nbox) = mfy1(nbox) + 16
        Line (mfx1(nbox), mfy1(nbox))-(mfx2(nbox), mfy2(nbox)), tc, BF
        ShadowBox mfx1(nbox), mfy1(nbox), mfx2(nbox), mfy2(nbox)
        ShadowPrint mfx1(nbox) + 4, mfy1(nbox) + 4, "A", gray

        nbox = nbox + 1
        mft$(nbox) = "Des" '                                             descriptive
        mfx1(nbox) = trx + 10
        mfx2(nbox) = mfx1(nbox) + 15
        mfy1(nbox) = mfy2(nbox - 1) + 4
        mfy2(nbox) = mfy1(nbox) + 16
        Line (mfx1(nbox), mfy1(nbox))-(mfx2(nbox), mfy2(nbox)), tc, BF
        ShadowBox mfx1(nbox), mfy1(nbox), mfx2(nbox), mfy2(nbox)
        ShadowPrint mfx1(nbox) + 4, mfy1(nbox) + 4, "D", gray
        ' ------------------------------------------------------------------------------------------------------
        If move > 49 Then '                                              up/down buttons only appear when needed

            nbox = nbox + 1
            mft$(nbox) = "hup" '                                         history up
            mfx1(nbox) = trx + 10
            mfx2(nbox) = mfx1(nbox) + 15
            mfy1(nbox) = try + 58
            mfy2(nbox) = mfy1(nbox) + 16

            nbox = nbox + 1
            mft$(nbox) = "hup" '                                         history up
            mfx1(nbox) = trx + 10
            mfx2(nbox) = mfx1(nbox) + 15
            mfy1(nbox) = _Height - 64
            mfy2(nbox) = mfy1(nbox) + 16

            nbox = nbox + 1
            mft$(nbox) = "hdo" '                                         history down
            mfx1(nbox) = trx + 10
            mfx2(nbox) = mfx1(nbox) + 15
            mfy1(nbox) = mfy2(nbox - 2) + 4
            mfy2(nbox) = mfy1(nbox) + 16

            nbox = nbox + 1
            mft$(nbox) = "hdo" '                                         history down
            mfx1(nbox) = trx + 10
            mfx2(nbox) = mfx1(nbox) + 15
            mfy1(nbox) = mfy2(nbox - 2) + 4
            mfy2(nbox) = mfy1(nbox) + 16

            For i = nbox - 3 To nbox
                Line (mfx1(i), mfy1(i))-(mfx2(i), mfy2(i)), tc, BF
                ShadowBox mfx1(i), mfy1(i), mfx2(i), mfy2(i)
                ShadowPrint mfx1(i) + 2, mfy1(i) + 3, Chr$(31 + (i < (nbox - 1))), gray
            Next i
        End If
    End If

    nbox = nbox + 1
    mft$(nbox) = "l"
    mfx1(nbox) = tlx - 12 '                                      legend on left
    mfx2(nbox) = tlx - 1
    mfy1(nbox) = tly
    mfy2(nbox) = bly

    nbox = nbox + 1
    mft$(nbox) = "l"
    mfx1(nbox) = blx '                                           legend at bottom
    mfx2(nbox) = brx
    mfy1(nbox) = bly + 1
    mfy2(nbox) = bly + 16

    If (pregame = false) And (onplayback = false) Then
        nbox = nbox + 1
        mft$(nbox) = "t" '                                           clock type toggle by clicking on clock area
        mfx1(nbox) = blx
        mfx2(nbox) = brx
        mfy1(nbox) = bly + 37
        mfy2(nbox) = _Height - 21

        nbox = nbox + 1
        mft$(nbox) = "I" '                                           identify (player names)
        mfx1(nbox) = blx
        mfx2(nbox) = brx
        mfy1(nbox) = bly + 17
        mfy2(nbox) = bly + 36
    End If

    'If rickfile And dev Then '                                       SUB timings
    '    nbox = nbox + 1
    '    mft$(nbox) = "T" '                                           T is for turtle
    '    mfx1(nbox) = 0
    '    mfx2(nbox) = tlx - 22
    '    mfy1(nbox) = 0
    '    mfy2(nbox) = _Height - 20
    'End If

    If rickfile And dev Then '                                       graph scaling
        nbox = nbox + 1
        mft$(nbox) = "Graph"
        mfx1(nbox) = 24
        mfx2(nbox) = tlx - 20
        mfy1(nbox) = bly
        mfy2(nbox) = _Height - 21
    End If

    flopdoodle:
    If nbox > chimp Then chimp = nbox
    'TimeTrack "Buttons", 0
End Sub

Sub Center (tr As _Byte, t$, highlight As _Byte, tflag As _Byte) '   instructions for various modes, and creates mouse clickable boxes
    Dim As _Byte i, j, tok
    Dim x, y, c$, e$, z$

    If chimp > 0 Then nbox = chimp Else nbox = 5
    If insetup Then nbox = 4
    If barebones Or insettings Or inhelp Then Exit Sub

    If (t$ = "") And ((pregame + inhelp + endgame) = 0) Then
        If match Then
            t$ = " Noise   Invert   Pause "
        ElseIf getwbflag Then
            t$ = " you  are  White  or  Black? "
        ElseIf onplayback Then
            t$ = " Enter:move     Stop     Non-stop     Loop "
        ElseIf human Then
            t$ = " Auto   Back   Noise   Pause   Resign   Invert   Setup "
            If fullscreenflag = 0 Then t$ = t$ + "  F1" + s$ + "info "
        Else
            t$ = " White   Black   Noise   Pause   Invert   Setup "
            If fullscreenflag = 0 Then t$ = t$ + "  F1" + s$ + "info "
        End If
        highlight = true
    End If

    If (tr = 0) And (rflag = 0) And (t$ = lct$) And (pregame = 0) And (onplayback = 0) Then '   bottom instructions
        Put (0, _Height - 20), cenbuff(), PSet
        nbox = lcb
        RainbowButton
        Exit Sub
    End If

    If pregame And (t$ <> " @ Enter ") Then x = 14 Else x = 12 '     bigger font for startup Wh Bl Hu Co menu
    SetFont x
    x = xc - _PrintWidth(t$) \ 2

    If tr = 0 Then '                                                 bottom
        If pregame = 0 Then Line (0, _Height - 19)-(_Width - 1, _Height - 1), menubg, BF
        y = _Height - 13
    Else '                                                           probably screen center
        y = tr / (_Height / 16) * _Height - 6 * tflag + 4
    End If

    e$ = "@?/*: -" + s$ '                                            exempt from highlighting

    For i = 1 To Len(t$)
        c1 = gray
        c$ = Mid$(t$, i, 1)
        If (insetup = false) And (c$ = "B") And (backok = 0) And (InStr(t$, "Back") > 0) Then tok = 0 Else tok = 1
        If tok And highlight And (c$ = UCase$(c$)) And (InStr(e$, c$) = 0) Then
            If clockc = black Then c1 = white Else c1 = clockc
            nbox = nbox + 1 '                                        make item available to mouse
            If nbox > 99 Then QuitWithError "nbox", Str$(nbox) '     this should not happen!
            mft$(nbox) = LCase$(c$) '                                character when box is clicked on
            If InStr(t$, "Rename") Then mft$(nbox) = mft$(nbox) + Mid$(t$, i + 1, 1) ' make "re" because "r" is resign
            If (c$ = "F") And (Mid$(t$, i + 1, 1) = "1") And (onplayback = false) And (insetup = false) Then mft$(nbox) = "help" ' F1
            z$ = Mid$(t$, i, InStr(i + 1, t$, " ") - i) '            find where to end box
            mfx1(nbox) = x - 2
            mfy1(nbox) = y - 6 + (tr = 16)
            mfx2(nbox) = x + _PrintWidth(z$) + 2
            mfy2(nbox) = y + _FontHeight - 1
            If mfy2(nbox) >= _Height Then mfy2(nbox) = _Height - 1
        End If
        If t$ = "Deleting..." Then c1 = white
        ShadowPrint x, y - 2, c$, c1
        x = x + _PrintWidth(c$)
    Next i

    If (barebones + pregame + ingetfile + insetup + ingetnames) = 0 Then

        SetFont 10
        ShadowPrint 24, _Height - 14, "Slide:", white

        RoundButtonInfo:
        Data 64,OFF,sp0
        Data 102,Slow,sp1
        Data 144,Fast,sp2
        Data 591,Log,sr0
        Data 629,Boards,sr1
        Data 683,Thinking,sr2
        Data 748,Style,`

        Restore RoundButtonInfo
        For i = 0 To 6
            Read x, e$, c$
            j = ((i < 3) And (i = fast)) Or ((Left$(c$, 2) = "sr") And ((i - 3) = showright))
            Round_Button x, _Height - 14, e$, c$, j, true
        Next i
    End If

    If tr = 0 Then
        lcb = nbox
        lct$ = t$
        Get (0, _Height - 20)-(_Width - 1, _Height - 1), cenbuff()
    End If
End Sub

Sub RainbowButton
    Round_Button 748, _Height - 14, "Style", "'", false, false
End Sub

Sub Round_Button (x, y, wut$, whenmousemashed$, highlight As _Byte, addbutton As _Byte)
    Static rainbowindex, rainbowtime As Double
    Dim As _Byte i, j, lw, pw, rainbowflag
    Dim z

    If barebones Or pregame Or inhelp Or insettings Or insetup Or ingetfile Then Exit Sub

    rainbowflag = (wut$ = "Style") '                                 make this word stand out

    SetFont 11
    lw = Len(wut$)
    pw = _PrintWidth(wut$)
    z = x + pw + (lw > 3) * 2 + (lw > 4) * 2 + (wut$ = "Slow") * 2 + (wut$ = "Log") - (wut$ = "Style")
    If rainbowflag Then c1 = black Else c1 = gray '                  special background for Style
    For c2 = x To z
        Circle (c2, y + 4), 7, c1
    Next c2

    If rainbowflag Then '                                            multi-color for Style
        j = 0
        If ExtendedTimer > rainbowtime Then
            rainbowindex = rainbowindex + 1
            rainbowtime = ExtendedTimer + .1
        End If
        For i = 1 To 5
            rainbowindex = (rainbowindex + 1) Mod 5
            If rainbowindex = 0 Then c1 = red
            If rainbowindex = 1 Then c1 = green
            If rainbowindex = 2 Then c1 = blue
            If rainbowindex = 3 Then c1 = yellow
            If rainbowindex = 4 Then c1 = _RGB32(120, 0, 160) '      purple
            Color c1, zip
            _PrintString (x + j, y), Mid$(wut$, i, 1)
            j = j + _PrintWidth(Mid$(wut$, i, 1))
        Next i
    ElseIf highlight Then
        ShadowPrint x, y, wut$, white
    Else
        Color black, zip
        _PrintString (x, y), wut$
    End If

    If addbutton Then
        nbox = nbox + 1
        mft$(nbox) = whenmousemashed$
        mfx1(nbox) = x - 8
        mfy1(nbox) = y - 4
        mfx2(nbox) = x + _PrintWidth(wut$) + 7
        mfy2(nbox) = _Height - 1
        If mft$(nbox) = "`" Then midway = (mfx1(nbox) + mfx2(nbox)) \ 2
    End If
End Sub

Sub CheckBoard (level As _Byte)
    Dim mi '                                                         move index
    Dim As _Byte mp, cq, ck, cz, lm, rn, rn2, tp, castle, nr, pr, ne, co, cn, cs, p, op

    points = points(0) - points(1) '                                 ahead/behind in points
    points = points - WorB * points * 2 '                            branchless version of IF WorB THEN ab = -ab

    Moves(level) = 0 '                                               moves this level
    pawndir = WorB + (WorB = 0) '                                    direction pawn moves, 1W, -1B
    rto = (move < 16) * 200 '                                        -200 for early return to origin

    fr = 0 '                                                         from row
    Do
        fr = fr + 1 '                                                from row
        fc = 0 '                                                     from column
        Do '                                                         scooby-doobie-doo
            fc = fc + 1
            mp = b(fc, fr) '                                         move piece
            If WorB = Sgn(mp And 8) Then
                Select Case mp And 7
                    Case Is = Pawn: MovePawn level
                    Case Is = Rook: MoveRook level
                    Case Is = Knight: MoveKnight level
                    Case Is = Bishop: MoveBishop level
                    Case Is = Queen: MoveQueen level
                    Case Is = King: MoveKing level
                End Select
            End If
        Loop Until fc = 8
    Loop Until fr = 8

    If level > 1 Then Exit Sub ' only check for castling first 2 plys, for speed

    cq = true: ck = true '                                           castling
    rn = WorB - (WorB = 0) * 8 '                                     faster
    rn2 = WorB * 2 - (WorB = 0) * 7

    tp = b(5, rn) And 7
    If tp <> King Then cq = false: ck = false: Exit Sub '            no King here
    incheck = false
    If level = 0 Then lm = 1 Else lm = level - 1
    For mi = 1 To Moves(lm) '                                        can any opponent piece move there?
        If (move(lm, mi).tc = 5) And (rn = move(lm, mi).tr) Then
            cq = false '                                             castle queenside
            ck = false '                                             castle kingside
            incheck = true
            Exit Sub
        End If
    Next mi

    ' WHITE                      BLACK
    ' 8 R N B Q K B N R          1 R N B K Q B N R
    ' 7 P P P P P P P P          2 P P P P P P P P
    ' 6                          3
    ' 5                          4
    ' 4                          5
    ' 3                          6
    ' 2 P P P P P P P P          7 P P P P P P P P
    ' 1 R N B Q K B N R          8 R N B K Q B N R
    '   a b c d e f g h            h g f e d c b a

    For castle = 1 To 2 '                                            queenside, then kingside
        nr = false '   no rook
        pr = false '   prior condition
        ne = false '   not empty
        co = false '   controlled space
        c2 = false '   controlled space by PAWN (I'm not so sure about this, despite what Stockfish says)

        '                 bbww
        ' castle$ format "qkQK" * if ok, X if nulled by King or Rook move
        If Mid$(castle$, WorB * 2 + castle, 1) <> "*" Then pr = true: GoTo nocando '  prior condition (moved King or rook)

        If castle = 1 Then cn = 1 Else cn = 8 '                      column number
        p = b(cn, rn) And 7
        If p <> Rook Then nr = true: GoTo nocando '                  no rook

        If castle = 1 Then cz = 4 Else cz = 5
        op = 14 - WorB * 8
        For cs = 1 To cz
            cn = ca1(castle, cs)
            If b(cn, rn2) = op Then c2 = true: GoTo nocando '        control by pawn
        Next cs

        If castle = 1 Then cz = 3 Else cz = 2
        For cs = 1 To cz '                                           look at spaces between king and rook
            cn = ca2(castle, cs)
            If b(cn, rn) > 0 Then ne = true: GoTo nocando '          not empty

            If Not ((cs = 1) And (castle = 1)) Then '                queenside knight
                If level Then lm = 0 Else lm = 1
                For mi = 1 To Moves(lm) '                            see what can move here
                    If (cn = move(lm, mi).tc) And (rn = move(lm, mi).tr) Then
                        co = true '                                  yes, something can
                        GoTo nocando
                    End If
                Next mi
            End If
        Next cs

        nocando:
        If (nr + pr + ne + co + c2) > 0 Then '                       some test failed
            If castle = 1 Then cq = false Else ck = false
        End If
    Next castle

    ' note that kingside has negative from column, queenside negative from row
    If WorB Then
        If ck Then AddMove level, 15, -5, 1, 7, 1 '                  what's it worth?  keep adjusting!
        If cq Then AddMove level, 16, 5, -1, 3, 1
    Else
        If ck Then AddMove level, 15, -5, 8, 7, 8 '                  what's it worth?  keep adjusting!
        If cq Then AddMove level, 16, 5, -8, 3, 8
    End If
End Sub

Function CHRN$ (n)
    CHRN$ = Chr$(48 + n)
End Function

Sub ClearBuffers
    While _Resize
        _Delay .1
    Wend
    'While Len(InKey$): Wend
    i$ = "" '                                                        inkey variable
    istuff$ = "" '                                                   mouse generated inkey override
    While _MouseInput: Wend
    b1 = false '                                                     mouse button left
    b2 = false '                                                     mouse button right
End Sub

Sub ClearTemp '                                                      invalidate saved screens
    Dim i
    For i = 0 To 500 '                                               small board images
        If ssb(i) < -1 Then _FreeImage ssb(i): ssb(i) = 0
    Next i
    lpoints = -1
    oply = -1 '                                                      force replot of captured pieces
End Sub

Sub Clocks '                                                         total used per player, this move
    Static clockinit, segment(7, 4) As _Byte, segleg$(9)
    Dim As _Byte i, j, k, who, s, m, n, z, zz, az, p1, qq, sn, sxq, syq
    Dim As _Unsigned _Byte ra, ga, ba
    Dim h, x0, x1, x2, x3, y0, y1, y2, tx
    Dim te As Double, t As Double, z!, s$, m$, h$, t$, z$

    cdata:
    Data a,0,-2,1,-2,b,1,-2,1,-1,c,1,-1,1,0,d,0,0,1,0,e,0,-1,0,0,f,0,-2,0,-1,g,0,-1,1,-1
    Data 0,abcdef,1,bc,2,abedg,3,abcdg,4,fbcg,5,acdfg,6,acdefg,7,abc,8,abcdefg,9,abcdfg

    If barebones Then Exit Sub

    'TimeTrack "Clocks", 1

    If pregame Then
        etime(0, 0) = 12 * 3600 + 34 * 60 + 56 '                     show time of 12:34:56 on big clocks
        etime(0, 1) = etime(0, 0)
        etime(1, 0) = 0 '                                            time this move (tiny clocks)
        etime(1, 1) = 0
        start = ExtendedTimer
    End If

    If clockinit = false Then
        Restore cdata '                                              where to plot segments of 7 digit display
        For i = 1 To 7
            Read t$ '                                                garbage
            For j = 1 To 4
                Read segment(i, j)
            Next j
        Next i
        For i = 0 To 9
            Read t$, segleg$(i)
        Next i
        clockinit = true
    End If

    who = SaveWorB
    te = ExtendedTimer - start
    If inpause Or onplayback Or getwbflag Then te = 0
    If endgame And (cmode = 0) Then te = 0
    start = ExtendedTimer
    If cmode = 0 Then '                                              normal user mode
        etime(0, who) = etime(0, who) + te '                         total elapsed
        etime(1, who) = etime(1, who) + te '                         elapsed this move

    Else '                                                           30/60m countdown timer for author
        etime(0, 1) = etime(0, 1) + te '                             white timer shows current time
        etime(0, 0) = etime(0, 0) - te '                             black timer shows countdown timer
        If Int(etime(0, 0)) <= 0 Then '                              time up!
            etime(0, 0) = 0 '                                        in case it was negative
            Sound 7777, 1 '                                          audible alarm
            cmode = 0 '                                              special clock mode off
        End If
    End If

    z = pregame * -20 '                                              pregame offset, to fit music credits
    y0 = 566 + z

    For i = 0 To 1
        t = etime(0, i)
        s = t Mod 60 '                                               seconds
        m = (t \ 60) Mod 60 '                                        minutes
        h = t \ 3600 '                                               hours
        If h > 99 Then h = 0: m = 0: s = 0
        h$ = Right$("0" + LTrim$(Str$(h)), 2)
        m$ = Right$("0" + LTrim$(Str$(m)), 2)
        s$ = Right$("0" + LTrim$(Str$(s)), 2)

        If clocktype = 0 Then '                                      big font clock
            SetFont 32
            t$ = h$ + ":" + m$ + ":" + s$
            x1 = blx - (i = 0) * xq * 4 + 28
            y1 = 532 + z
            For j = 1 To 8 '                                         print one character at a time to move the colon up
                x2 = x1 + _PrintWidth(Left$(t$, j - 1))
                z$ = Mid$(t$, j, 1)
                ShadowPrint x2, y1 + (z$ = ":") * 2, z$, clockc
            Next j
            x2 = x1 + 130
            y2 = y1 + 26
            _PutImage (x1 - 12, y1 - 12)-(x2 + 12, y2 + 12), 0, 0, (x1, y1)-(x2, y2)
        Else
            t$ = h$ + m$ + s$ '                                      time used this side
            For j = 1 To 6 '                                         hh mm ss
                n = Val(Mid$(t$, j, 1))
                If clocktype = 2 Then
                    NixieTubeClock i, j, n
                    _Continue
                End If
                sxq = 14: syq = 20: qq = 3 '                         big digits
                If j > 4 Then sxq = 7: syq = 10: qq = 1 '            small digits for seconds
                For k = 1 To 8
                    p1 = InStr(segleg$(n), Mid$("abcdefg", k, 1))
                    If p1 Then
                        z$ = Mid$(segleg$(n), p1, 1)
                        sn = Asc(z$) - 96

                        x0 = blx - (i = 0) * xq * 4 + j * 26 + 6
                        x0 = x0 + (j = 6) * 10 '                     seconds
                        x0 = x0 + (j < 3) * 10 '                     hour
                        x0 = x0 - (j > 4) * 4 '                      seconds

                        x1 = x0 + segment(sn, 1) * sxq
                        x2 = x0 + segment(sn, 3) * sxq
                        y1 = y0 + segment(sn, 2) * syq
                        y2 = y0 + segment(sn, 4) * syq
                        If InStr("agd", z$) Then '                   horizontal
                            x1 = x1 + 1: x2 = x2 - 1
                            For zz = -qq To qq
                                GoSub mcolor
                                Line (x1 + az, y1 + zz)-(x2 - az, y2 + zz), c1
                            Next zz
                        Else '                                       vertical
                            y1 = y1 + 1: y2 = y2 - 1
                            For zz = -qq To qq
                                GoSub mcolor
                                Line (x1 + zz, y1 + az)-(x2 + zz, y2 - az), c1
                            Next zz
                        End If
                    End If
                Next k
            Next j

            If clocktype = 2 Then _Continue '                        Nixie

            x0 = blx + xq * 1.5 - (i = 0) * xq * 4 + 3 '             must be clocktype 1 (7 segments)
            Line (x0, 539 + z)-Step(2, 2), clockc, BF '              colons
            Line (x0, 549 + z)-Step(2, 2), clockc, BF
        End If
        x1 = blx + i * xq * 4 + 4
        If cmode = 0 Then '                                          cmode > 0 means countdown timer
            SetFont 8 + i * 3
            x2 = x1 + i * 2
            ShadowPrint x2, 538 + z, Mid$("WB", i + 1, 1), clockc '  identify clocks (W & B)
        End If
    Next i

    If smallclock And (clocktype <> 2) And (cmode = 0) Then '        elapsed time per move
        If colori3 = 3 Then c1 = black Else c1 = clockc
        For i = 0 To 1
            t = etime(1, i)
            s = t Mod 60 '                                           seconds
            m = (t \ 60) Mod 60 '                                    minutes
            h = t \ 3600 '                                           hours
            If h > 99 Then h = 0: m = 0: s = 0
            s$ = Right$("0" + LTrim$(Str$(s)), 2)
            m$ = Right$("0" + LTrim$(Str$(m)), 2)
            h$ = Right$("0" + LTrim$(Str$(h)), 2)
            t$ = h$ + ":" + m$ + ":" + s$
            tx = blx - (i = 0) * xq * 4 + 132
            j = -(clocktype = 0)
            TinyFont t$, tx - j * 2, 526 - j * 10 + z, c1
        Next i
    End If

    SetFont 10 '                                                     player names
    For i = 0 To 1
        If i Then x3 = xc - 2 * xq Else x3 = xc + 2 * xq
        t$ = LTrim$(RTrim$(PlayerName$(i)))
        tx = x3 - _PrintWidth(t$) \ 2
        If (colori3 = 5) Or (colori3 = 3) Then c1 = white Else c1 = clockc 'black or blue to white
        If pregame = 0 Then ShadowPrint tx, y0 - 60, t$, c1
    Next i

    'TimeTrack "Clocks", 0
    Exit Sub

    mcolor:
    az = Abs(zz)
    z! = 255 - az * 60
    z! = z! * (bri + 1 + (bri = 4)) * .25
    ra = z! * Sgn(_Red32(clockc))
    ga = z! * Sgn(_Green32(clockc))
    ba = z! * Sgn(_Blue32(clockc))
    c1 = _RGB32(ra, ga, ba)
    If clockc = black Then c1 = black
    Return
End Sub

Sub ColorSet
    Dim i, tr, tg, tb

    lpoints = -1 '                                                   force replot of pieces taken
    oply = -1
    If bgi < -1 Then _FreeImage bgi: bgi = 0

    For i = 0 To 31
        cp(i) = _RGB32(myr(i) * bri, myg(i) * bri, myb(i) * bri)
    Next i

    black = _RGB32(2, 2, 2)
    blue = cp(12)
    gray = cp(8)
    green = cp(23)
    red = cp(30)
    white = cp(7)
    yellow = cp(18)
    zip = _RGBA(1, 1, 1, 0)

    tr = myr(colori1 + 10)
    tg = myg(colori1 + 10)
    tb = myb(colori1 + 10)
    boardwhite = _RGB32(tr * bri, tg * bri, tb * bri)

    tr = myr(colori2 + 10)
    tg = myg(colori2 + 10)
    tb = myb(colori2 + 10)
    boardblack = _RGB32(tr * bri, tg * bri, tb * bri)

    If colori3 = 0 Then clockc = red
    If colori3 = 1 Then clockc = green
    If colori3 = 2 Then clockc = yellow
    If colori3 = 3 Then clockc = blue
    If colori3 = 4 Then clockc = white
    If colori3 = 5 Then clockc = black

    If colori3 = 5 Or colori3 = 3 Then '                             override if black or blue (too dim)
        menubg = _RGB32(50)
    Else
        tr = _Red(clockc) \ 4
        tg = _Green(clockc) \ 4
        tb = _Blue(clockc) \ 4
        menubg = _RGB32(tr, tg, tb)
    End If

End Sub

Sub ConfigRead
    Dim i, j, k, tf, g, g$

    f$ = ConfigFile$
    If (InStr(Command$, "init") > 0) Or (_FileExists(f$) = 0) Then f$ = datapath$ + "chessb.dat"
    FileCheck
    tf = FreeFile
    Open f$ For Input As #tf
    Input #tf, g$, bgc '             1
    Input #tf, g$, bri '             2
    Input #tf, g$, click '           3
    Input #tf, g$, colori1 '         4
    Input #tf, g$, colori2 '         5
    Input #tf, g$, colori3 '         6
    Input #tf, g$, clocktype '       7
    Input #tf, g$, cursortype '      8
    Input #tf, g$, fast '            9
    Input #tf, g$, fullscreenflag ' 10
    Input #tf, g$, graphics '       11
    Input #tf, g$, altbg '          12
    Input #tf, g$, binvert '        13
    Input #tf, g$, legend '         14
    Input #tf, g$, logging '        15
    Input #tf, g$, descriptive '    16
    Input #tf, g$, makenoise '      17
    Input #tf, g$, piece_style '    18
    Input #tf, g$, smallclock '     19
    Input #tf, g$, smode0 '         20
    Input #tf, g$, squaretrim '     21
    Input #tf, g$, hover '          22
    Input #tf, g$, markers '        23

    If (piece_style < 0) Or (piece_style > 9) Then piece_style = 9
    For i = 0 To 1 '                                                 black then white
        For j = 1 To 6 '                                             piece
            k = i * 8 + j '                                          1 2 3 4 5 6 9 10 11 12 13 14
            piecef$(k) = RTrim$(Mid$("rook  knightbishopqueen king  pawn  ", (j - 1) * 6 + 1, 6))
            Input #tf, g$, piecefn(k)
            If piecefn(k) < 1 Then piecefn(k) = 1
            f$ = datapath$ + "sfunny" + slash + piecef$(k) + LTrim$(Str$(piecefn(k))) + ".jpg"
            FileCheck
        Next j
    Next i

    Input #tf, g$, PlayerName$(1)
    Input #tf, g$, PlayerName$(0)
    Input #tf, g$, lasth
    Input #tf, g$, lastc
    Close #tf

    Restore rgb
    For i = 0 To 31
        Read g, myr(i), myg(i), myb(i), ColorDesc$(i)
    Next i

    rgb:
    Data 0,1,1,1,Black
    Data 1,50,50,50,Board white
    Data 2,30,30,30,Board black
    Data 3,60,60,60,White piece
    Data 4,12,12,30,White highlight
    Data 5,0,0,0,Black piece
    Data 6,50,12,12,Black highlight
    Data 7,63,63,63,Bright white
    Data 8,30,30,30,Gray
    Data 9,0,0,0,Black
    Data 10,43,43,63,Gunmetal
    Data 11,11,29,52,Sky Blue
    Data 12,0,0,50,Blue
    Data 13,30,19,40,Lt Purple
    Data 14,25,13,26,Dk Purple
    Data 15,35,5,35,Purple
    Data 16,60,50,4,Gold
    Data 17,63,30,0,Flame
    Data 18,60,60,0,Yellow
    Data 19,63,55,30,Lt Brown
    Data 20,40,20,0,Brown
    Data 21,0,63,22,Mint
    Data 22,20,55,10,Lt Green
    Data 23,0,40,0,Green
    Data 24,38,38,38,Gray
    Data 25,18,18,18,Dk Gray
    Data 26,63,63,63,White
    Data 27,63,35,35,Pink
    Data 28,61,23,24,Flesh
    Data 29,55,13,25,Cherry
    Data 30,50,0,0,Red
    Data 31,41,37,18,Khaki

End Sub

Sub ConfigWrite
    Dim i, j, k, tf, t$
    If match > 0 Then Exit Sub

    tf = FreeFile
    Open ConfigFile$ For Output As #tf
    Print #tf, " 1 Background,"; bgc
    Print #tf, " 2 Brightness,"; bri
    Print #tf, " 3 Click,"; click
    Print #tf, " 4 Color W sq,"; colori1
    Print #tf, " 5 Color B sq,"; colori2
    Print #tf, " 6 Clock color,"; colori3
    Print #tf, " 7 Clock type,"; clocktype
    Print #tf, " 8 Cursor type,"; cursortype
    Print #tf, " 9 Piece slide,"; fast
    Print #tf, "10 Fullscreen,"; _FullScreen
    Print #tf, "11 Graphics,"; graphics
    Print #tf, "12 BG type,"; altbg
    Print #tf, "13 Invert,"; binvert
    Print #tf, "14 Legend,"; legend
    Print #tf, "15 Logging,"; logging
    Print #tf, "16 Notation,"; descriptive
    Print #tf, "17 Sound,"; makenoise
    Print #tf, "18 Set,"; piece_style
    Print #tf, "19 Timer,"; smallclock
    Print #tf, "20 Screen,"; smode
    Print #tf, "21 Trim,"; squaretrim
    Print #tf, "22 Hover,"; hover
    Print #tf, "23 Markers,"; markers

    ' save funny piece selection (may have changed)
    For i = 0 To 1 '                                                 black then white
        For j = 1 To 6 '                                             piece
            k = i * 8 + j '                                          1 2 3 4 5 6 9 10 11 12 13 14
            t$ = RTrim$(Mid$("rook  knightbishopqueen king  pawn  ", (j - 1) * 6 + 1, 6))
            Print #tf, q$; Mid$("BW", i + 1, 1); " "; t$; q$; ","; piecefn(k)
        Next j
    Next i

    Print #tf, "White,"; q$; PlayerName$(1); q$
    Print #tf, "Black,"; q$; PlayerName$(0); q$
    Print #tf, "lasth,"; lasth
    Print #tf, "lastc,"; lastc
    Close #tf
End Sub

Sub Cursor (column As _Byte, row As _Byte, to_flag As _Byte) '       highlight edge of square with green (to move) or red (destination)
    Dim As _Byte i, c, r
    Dim x, y

    c = column
    r = 9 - row
    If invert Then r = 9 - r: c = 9 - c
    x = tlx + (c - 1) * xq
    y = tly + (8 - r) * yq
    If to_flag Then c1 = _RGB32(240, 10, 10) Else c1 = _RGB32(20, 240, 20)
    For i = 0 To 3
        Line (x + i, y + i)-(x + xq - i, y + yq - i), c1, B
    Next i
End Sub

Function cx (t$)
    cx = (tlx + trx) \ 2 - _PrintWidth(t$) \ 2
End Function

Sub DescriptiveNotation (tlevel As _Byte, tfc As _Byte, tfr As _Byte, ttc As _Byte, ttr As _Byte)
    Dim mi
    Dim As _Byte rcount, fc, fr, tc, tr, pm, pass, id1, id2
    Dim t$, tm$, ff$, tf$, fr$, tr$, qkf$, qkt$, z1$, z2$, z3$

    'TimeTrack "DNot", 1
    If tfc < 0 Then desc$ = "O-O": Exit Sub
    If tfr < 0 Then desc$ = "O-O-O": Exit Sub

    pm = b(tfc, tfr) '                                               piece moving

    GoSub mmove
    desc$ = t$
    Do '                                                             loops until move is uniquely identified
        rcount = 0
        For mi = 1 To Moves(tlevel)
            fc = move(tlevel, mi).fc '                               from column
            fr = move(tlevel, mi).fr '                               from row
            If (fc < 1) Or (fr < 1) Then _Continue '                 castling
            If pm <> b(fc, fr) Then _Continue '                      move other than moving piece
            tc = move(tlevel, mi).tc '                               to column
            tr = move(tlevel, mi).tr '                               to row
            GoSub trans
            If t$ = tm$ Then
                rcount = rcount + 1
                If rcount > 1 Then
                    Select Case pass
                        Case 0: id1 = 0: id2 = 0 '  RxP
                        Case 1: id1 = 0: id2 = 1 '  RxBP
                        Case 2: id1 = 0: id2 = 2 '  RxKBP
                        Case 3: id1 = 0: id2 = 3 '  RxP(B4)
                        Case 4: id1 = 0: id2 = 4 '  RxP(KB4)
                        Case 5: id1 = 1: id2 = 0 '  R(B4)xP
                        Case 6: id1 = 2: id2 = 0 '  R(KB4)xP
                        Case 7: id1 = 2: id2 = 1 '  R(KB4)xNP
                        Case 8: id1 = 2: id2 = 2 '  R(KB4)xKNP
                        Case 9: id1 = 2: id2 = 3 '  R(KB4)xP(N3)
                        Case 10: id1 = 2: id2 = 4 ' R(KB4)xP(KN3)
                        Case Else: QuitWithError "DESC > 10", t$
                    End Select
                End If
            End If
        Next mi
        GoSub mmove
        pass = pass + 1
    Loop Until rcount = 1

    If ((pm And 7) = Pawn) And (b(ttc, ttr) = 0) And (tfc <> ttc) Then t$ = t$ + "ep" ' en passant

    desc$ = t$
    'TimeTrack "DNot", 0
    Exit Sub

    mmove:
    fc = Abs(tfc)
    fr = Abs(tfr)
    tc = ttc
    tr = ttr
    GoSub trans
    tm$ = t$
    Return

    trans:
    t$ = "": ff$ = "": tf$ = "": qkf$ = "": qkt$ = "": z1$ = "": z2$ = "": z3$ = ""

    ff$ = Mid$("RNBQKBNR", fc, 1) '                                  from file
    tf$ = Mid$("RNBQKBNR", tc, 1) '                                  to file
    If WorB Then fr$ = CHRN$(fr) Else fr$ = CHRN$(9 - fr) '          from row
    If WorB Then tr$ = CHRN$(tr) Else tr$ = CHRN$(9 - tr) '          to row

    If fc < 4 Then qkf$ = "Q" '                                      from queenside
    If fc > 5 Then qkf$ = "K" '                                      from kingside
    If tc < 4 Then qkt$ = "Q" '                                      to queenside
    If tc > 5 Then qkt$ = "K" '                                      to kingside

    If id1 = 1 Then z3$ = "(" + ff$ + fr$ + ")" '                    left side, (R5)
    If id1 = 2 Then z3$ = "(" + qkf$ + ff$ + fr$ + ")" '             left side, (KR8)
    t$ = Mid$("RNBQKP", pm And 7, 1) + z3$

    If b(tc, tr) = 0 Then '                                          move with no capture
        z1$ = ""
        If id2 = 2 Then z1$ = qkt$ '                                 K or Q
        t$ = t$ + "-" + z1$ + tf$ + tr$ '                            KR or QR
    Else '                                                           move with capture
        z1$ = "": z2$ = "": z3$ = ""
        If id2 = 2 Then z1$ = qkt$ '                                 K or Q
        If (id2 = 1) Or (id2 = 2) Then z2$ = tf$ '                   1-8
        If id2 = 3 Then z3$ = "(" + tf$ + tr$ + ")" '                (R8)
        If id2 = 4 Then z3$ = "(" + qkt$ + tf$ + tr$ + ")" '         (KR8)
        t$ = t$ + "x" + z1$ + z2$ + Mid$("RNBQKP", b(tc, tr) And 7, 1) + z3$
    End If
    Return
End Sub

Sub DispStats
    Dim ns, tx, t$

    If (human <> 2) And (insettings = false) Then '                  2 humans playing
        If inpause Or insettings Then mps = 0
        ns = tdelay!
        If ns Then t$ = Str$(ns) '                                   seconds delayed (CPU overheat)
        t$ = t$ + "  " + fnum$(mps) + "  " + fnum$(top_mps) + "  " + fnum$(tcount)
        tx = trx - Len(t$) * 4 - 4
        If (colori3 = 3) Or (colori3 = 5) Then c1 = white Else c1 = clockc
        TinyFont t$, tx, 27, c1 '                                    delay in seconds, moves per second, best moves per second, total moves
    End If
End Sub

Function ExtendedTimer# '                                            this function @SMcNeill
    Dim As _Byte i, l, l1, m
    Dim d, y, d$, s As _Unsigned Long

    d$ = Date$
    l = InStr(d$, "-")
    l1 = InStr(l + 1, d$, "-")
    m = Val(Left$(d$, l))
    d = Val(Mid$(d$, l + 1))
    y = Abs(Val(Mid$(d$, l1 + 1)) - 2020)
    For i = 1 To m
        Select Case i '                                              add the number of days for each previous month passed
            Case 1: d = d '                                          January doesn't have any carry over days
            Case 2, 4, 6, 8, 9, 11: d = d + 31
            Case 3: d = d + 28
            Case 5, 7, 10, 12: d = d + 30
        End Select
    Next
    For i = 1 To y
        d = d + 365
    Next
    For i = 2 To y Step 4
        If m > 2 Then d = d + 1 '                                    add an extra day for leap year every 4 years, starting in 1970
    Next
    d = d - 1 '                                                      for year 2000
    s = CDbl(d) * 24 * 60 * 60 '                                     seconds are days * 24 hours * 60 minutes * 60 seconds
    ExtendedTimer# = s + Timer
End Function

Function f6$ (t$)
    f6$ = Left$(t$ + Space$(6), 6)
End Function

Function f12$ (t$)
    f12$ = Left$(t$ + Space$(12), 12)
End Function

Sub FENcheck '                                                       canned response for saved positions represented by FEN strings
    Dim i, p, t$, c1$, c2$

    'If dev Then _Dest _Console
    p = InStr(FEN$, " ")
    c1$ = Left$(FEN$, p + 1)
    'If dev Then Print c1$
    For i = 1 To FENcount
        c2$ = FEN$(i)
        p = InStr(c2$, " ")
        c2$ = Left$(c2$, p + 1)
        'If dev Then Print c2$
        If c1$ = c2$ Then
            t$ = FENreply$(i)
            If (Len(t$) > 0) And (t$ = UCase$(t$)) Then
                wasFEN = i
                FENm$ = LCase$(t$)
                'If dev Then Print FENm$
                Exit For
            End If
        End If
    Next i
    'If dev Then _Dest 0
End Sub

Sub FENmake '                                                        create FEN string of current board
    Dim As _Byte b, r, c
    Dim t$

    FEN$ = ""
    For r = 1 To 8
        For c = 1 To 8
            p = b(c, 9 - r)
            If p > 0 Then
                GoSub blanks
                FEN$ = FEN$ + Mid$("rnbqkp  RNBQKP", p, 1)
            Else
                b = b + 1
            End If
        Next c
        GoSub blanks
        If r < 8 Then FEN$ = FEN$ + "/"
    Next r

    FEN$ = FEN$ + " " + Mid$("bw", WorB + 1, 1) '                    (b) or (w)hite to move

    ' castle$ is **** (qkQK), want KQkq
    t$ = "" '                                                        castling availability
    For r = 1 To 4
        If Mid$(castle$, 5 - r, 1) = "*" Then t$ = t$ + Mid$("KQkq", r, 1)
    Next r
    If t$ = "" Then t$ = "-"
    FEN$ = FEN$ + " " + t$

    FEN$ = FEN$ + " " + epsq$ '                                      en passant square (even if an en passant is not available!)
    FENpartial$ = FEN$ '                                             used to check for perpetual
    FEN$ = FEN$ + " " + LTrim$(Str$(drawcount)) '                    halfmoves since pawn move or capture
    FEN$ = FEN$ + " " + LTrim$(Str$(move)) '

    Exit Sub

    blanks:
    If b Then FEN$ = FEN$ + CHRN$(b)
    b = 0
    Return
End Sub

Sub FENread '                                                        load from file
    Dim tf, f$, t1$, t2$

    FENcount = 0
    f$ = datapath$ + "fen.dat"
    If _FileExists(f$) = 0 Then Exit Sub
    tf = FreeFile
    Open f$ For Input As #tf
    While Not (EOF(tf))
        Input #tf, t1$
        If Not (EOF(tf)) Then Input #tf, t2$
        If t2$ = UCase$(t2$) Then
            FENcount = FENcount + 1 + (FENcount = FENmax)
            FEN$(FENcount) = t1$
            FENreply$(FENcount) = t2$
        End If
    Wend
    Close #tf
End Sub

Sub FENshow '                                                        show boards of all FEN strings with reply, start with most recent
    Static FENindex
    Dim As _Byte i, r, c, n
    Dim t$, c$

    FENindex = FENindex - 1
    If FENindex < 1 Then FENindex = FENcount
    t$ = FEN$(FENindex)
    FENmess$ = FENreply$(FENindex)
    i = 1
    r = 1
    c = 1
    For i = 1 To Len(t$)
        c$ = Mid$(t$, i, 1)
        If c$ = "/" Then
            c = 1
            r = r + 1
        ElseIf InStr("123456789", c$) Then
            n = Val(c$)
            While n > 0
                b(c, 9 - r) = 0
                c = c + 1
                n = n - 1
            Wend
        Else
            If (c > 8) Or (r > 8) Then
                WorB = InStr("bw", Mid$(t$, i, 1))
                SaveWorB = WorB
                humanc = WorB
                If WorB = 0 Then invert = true
                redoflag = true
                Exit For
            End If
            b(c, 9 - r) = InStr("rnbqkp  RNBQKP", c$)
            c = c + 1
        End If
    Next i
End Sub

Sub FENwrite '                                                       save FEN strings to disk
    Dim i, tf, t$
    If FENcount = 0 Then Exit Sub
    tf = FreeFile
    Open datapath$ + "fen.dat" For Output As #tf
    For i = 0 To FENcount
        t$ = FENreply$(i)
        If Len(t$) > 0 Then
            If t$ = UCase$(t$) Then
                Print #tf, FEN$(i); ","; FENreply$(i)
            End If
        End If
    Next i
    Close #tf
End Sub

Sub FileCheck
    If _FileExists(f$) = false Then QuitWithError "File", f$
End Sub

Sub Fking (notify As _Byte) '                                        find kings, tally up score, count pieces
    Dim mi
    Dim As _Byte i, p, z, c, r, bking, wking, bpawn, wpawn

    Erase pcount, points

    bking = King: wking = bking Or 8
    bpawn = Pawn: wpawn = bpawn Or 8

    bpc = 0: bpr = 0: wpc = 0: wpr = 0 '                             pawn location

    For r = 1 To 8
        For c = 1 To 8
            z = b(c, r) '                                            1-12
            p = z And 7 '                                            1-6
            i = Sgn(z And 8) '                                       0 black, 1 white
            pcount(i, p) = pcount(i, p) + 1
            If p <> King Then points(i) = points(i) + value(p) \ mult
            If z = bking Then bkr = r: bkc = c '                     save row and column
            If z = wking Then wkr = r: wkc = c
            If (z = bpawn) And (Rnd > .5) Then bpr = r: bpc = c
            If (z = wpawn) And (Rnd > .5) Then wpr = r: wpc = c
        Next c
    Next r
    points = points(0) - points(1) '                                 to discourage pawn moves when sufficient power to mate
    If WorB Then points = -points

    check = false: incheck = false
    If WorB Then
        c = wkc: r = wkr '                                           location of white King
    Else
        c = bkc: r = bkr '                                           location of black King
    End If
    For mi = 1 To Moves(1) '                                         can any opponent piece move there?
        If (c = move(1, mi).tc) And (r = move(1, mi).tr) Then
            incheck = true
            Exit For
        End If
    Next mi

    If incheck And notify Then
        check = true
        TempMess$ = "Check!"
        PlaySound checkn
        AddSymbol "+"
    End If
End Sub

Sub ForRick '                                                        statistics
    Dim As _Byte c, r, i, p, tf
    Dim tt, t$

    If rickfile = 0 Then Exit Sub

    tf = FreeFile
    If _FileExists("top.txt") Then
        Open "top.txt" For Input As #tf
        Input #tf, tt
        Close #tf
        If top_mps < tt Then Exit Sub '                              not larger, abort saving
    End If

    Open "top.txt" For Output As #tf
    Print #tf, LTrim$(Str$(top_mps))
    Print #tf, Date$; " "; Time$
    For i = 0 To 1 '                                                 what pieces were on the board, black then white
        If i Then Print #tf, "White"; Else Print #tf, "Black";
        For p = 1 To 6
            If p = 5 Then _Continue '                                skip King
            t$ = Str$(pcount(i, p)) + Mid$("RNBQKP", p, 1)
            If pcount(i, p) = 0 Then t$ = "   "
            Print #tf, t$;
        Next p
        Print #tf, ""
    Next i
    Print #tf, ""
    If WorB Then t$ = "White" Else t$ = "Black"
    If invert Then t$ = "Inverted, " + t$
    Print #tf, t$; " to move"
    Print #tf, ""

    For r = 8 To 1 Step -1 '                                         board
        For c = 1 To 8
            If invert Then p = b(9 - c, 9 - r) Else p = b(c, r)
            p = p + (p > 6) * 2 + 1
            Print #tf, Mid$(".rnbqkpRNBQKP", p, 1); " ";
        Next c
        Print #tf, ""
    Next r
    Print #tf, ""
    Print #tf, logfiled$; " @move"; move
    Close #tf
End Sub

Function fnum$ (n As _Unsigned _Integer64) '                         format number for display with commas
    Dim As _Byte i, zz
    Dim n$, z$

    n$ = LTrim$(Str$(n))
    For i = Len(n$) To 1 Step -1
        z$ = Mid$(n$, i, 1) + z$
        zz = zz + 1
        If ((zz Mod 3) = 0) And (i > 1) Then z$ = "," + z$
    Next i
    fnum$ = z$
End Function

Function GetField$ (p$, y, chars As _Byte, sflag As _Byte, z$)
    Dim As _Byte a, i, p, pw
    Dim x, tx, tscreen, t$, c$

    t$ = Left$(z$ + Space$(chars), chars)
    p = 1
    tscreen = _CopyImage(0)

    Do: _Limit mloop
        _PutImage , tscreen, 0

        SetFont defaultfontsize
        If InStr(p$, "Black") Then
            c$ = "White: " + PlayerName$(1)
            x = xc - _PrintWidth(c$) \ 2
            ShadowPrint x, 520, c$, white
        End If

        GraphLoad
        SetFont defaultfontsize
        x = xc - _PrintWidth(p$ + RTrim$(LTrim$(t$))) \ 2
        ShadowPrint x, y, p$, white
        tx = x + _PrintWidth(p$)
        For i = 1 To chars
            c$ = Mid$(t$, i, 1)
            pw = _PrintWidth(c$)
            ShadowPrint tx, y, c$, white
            If i = p Then
                Line (tx, y + 14)-Step(pw, 0), _RGB32(200, 200, 200) '  cursor
                Line (tx + 1, y + 15)-Step(pw, 0), black '              cursor shadow
            End If
            tx = tx + pw
        Next i

        If sflag Then chimp = 0: Center 0, " @ Enter ", true, false '    row, what, highlight, y offset
        i$ = InKey$
        MouseIn

        If (i$ = " ") And ingetfile Then i$ = q$
        If istuff$ = "e" Then i$ = Enter$: istuff$ = ""

        Select Case Len(i$)
            Case Is = 1
                If i$ = Esc$ Then Quit
                If i$ = Enter$ Then
                    GetField$ = LTrim$(RTrim$(t$))
                    _PutImage (x, y + 14)-(xm - 1, y + 15), bgi, 0, (x, y + 14)-(xm - 1, y + 15) ' erase cursor
                    i$ = "": asci = 0
                    _PutImage , tscreen, 0
                    _FreeImage tscreen
                    Exit Function
                End If
                If i$ = Chr$(8) Then p = p - 1 - (p = 1): _Continue '                       backspace
                If (LCase$(i$) <> UCase$(i$)) Or (InStr(" 0123456789_", i$) > 0) Then '     valid characters
                    Mid$(t$, p, 1) = i$
                    p = p + 1
                    If p > chars Then p = chars: Sound 4444, 1
                Else '                                                                      error beep for invalid character
                    Sound 222, 1
                End If
            Case Is = 2
                a = Asc(i$, 2)
                If a = 83 Then '                                                            del
                    t$ = Left$(t$, p - 1) + Right$(t$, chars - p) + " "
                    _Continue
                End If
                p = p + (a = 75) - (a = 77) '                                               left or right arrow
                If p < 1 Then p = 1
                If p > chars Then p = chars
        End Select
    Loop
End Function


Sub GetFileForPlayback
    Static f$(10000), d$(10000), t$(10000), header$(10) '    file, date, time, who/when/result

    Dim se, i, j, k, cp, fc, fo, kk, lc, n, p, tf, ud, x1, x2, y1, y2, np, tx, ty, tscreen, tscreen2
    Dim bx1, bx2, by1, by2, y0, yt, yb, ic, nlines, effectflg, sbi
    Dim o$, t$, x$, c$, d$, m$, y$, nf$, tf$, waslegend, fmax, zorba
    Dim As _Unsigned Long tbg, bright

    fmax = 10000
    GoSub gfinit

    Do
        woof:
        _PutImage , tscreen, 0
        SetFont defaultfontsize
        For i = 1 To np
            j = i + fo
            If j > n Then Exit For
            yt = y1 + (i - 1) * 17 + 5

            t$ = f$(j)
            While _PrintWidth(t$) > 140
                t$ = Left$(t$, Len(t$) - 1)
            Wend
            c1 = gray
            If j = se Then '                                         selected item, highlight
                Line (x1 + 4, yt - 3)-(bx1 - 4, yt + 14), gray, BF
                cp = i
                c1 = white
            End If
            ShadowPrint x1 + 10, yt, t$, c1 '                        filename
            ShadowPrint x1 + 196, yt, d$(j), c1 '                    date
            ShadowPrint x1 + 268, yt, t$(j), c1 '                    time
        Next i

        If f$(se) <> "-deleted" Then GoSub file_info

        Line (x1 - 1, y1)-(x2, y2), white, B '                       box around file get area
        Line (bx1, by1)-(bx2, by2), tbg, BF '                        erase scroll bar area
        Line (bx1, by1)-(bx2, by2), white, B '                       box around scroll bar area

        y0 = by1 + (se - 1) / (n - 1) * (by2 - by1 - 20) + 10 '      scroll bar
        yt = y0 - 10: If yt < (by1 + 1) Then yt = by1 + 1
        yb = y0 + 10: If yb > (by2 - 1) Then yb = by2 - 1
        Line (bx1 + 1, yt)-(bx2 - 1, yb), gray, BF
        Line (bx1 + 1, yt)-(bx2 - 1, yb), tbg, B

        tscreen2 = _CopyImage(0)

        Do: _Limit mloop
            If effectflg = false Then '                              effect on entry, not replots
                _PutImage , tscreen, 0
                WindowEffect 3, tscreen2, x1, y1, x2, y2 '           0zoom 1unfold 2random 3fade
                effectflg = true
            End If
            _PutImage , tscreen2, 0
            GraphLoad
            TempMess$ = "Option select via mouse" '                  mouse because letters are for searching
            nbox = zorba
            chimp = 0
            AboveBoardInfo

            t$ = Str$(se) + ":" + LTrim$(Str$(n)) '                  selected of selections, optional
            TinyFont t$, tlx + 14, tly - 6, white '                  show at top left

            GraphLoad '                                              always monitor CPU
            lct$ = ""
            Center 0, " Play     Rename     Delete     Edit     Wipe     Back ", 1, 0 '   playback menu

            GoSub elstupido '                                        highlight scroll button

            KeyScan

            If Len(istuff$) Then i$ = istuff$: istuff$ = ""
            If Len(i$) > 0 Then
                i$ = UCase$(i$)
                If i$ = Enter$ Then i$ = "PL" '                      equate Enter key as Play
                If (i$ = Esc$) Or (i$ = "BA") Then Exit Do
                If (f$(se) = "-deleted") Then
                    If (LCase$(i$) = UCase$(i$)) Or (i$ = "SCROLL") Or (i$ = "FILENAME") Then Exit Do
                    _Continue
                End If
            End If
        Loop Until Len(i$)

        _FreeImage tscreen2
        lc = se '                                                    save last selected because clicking on an item twice selects it
        If (i$ = Esc$) Or (i$ = "BA") Then f$ = "": Exit Do

        'debug$ = "*" + i$ + "*   "
        Select Case i$
            Case Is = "WI"
                Sound 222, 2
                _PutImage (blx, bly + 1)-(brx, _Height - 20), bgi, 0, (blx, bly + 1)-(brx, _Height - 20)
                Center 33, "Delete  all  ch*.*  files", 0, 0
                Center 0, " confirm  wipe   Y / N ", true, false
                Do: _Limit 10
                    KeyScan
                    If asci = 27 Then Exit Do
                    If i$ = "" Then i$ = " "
                Loop Until InStr("yn", LCase$(i$))
                If i$ = "y" Then
                    Center 0, "Deleting...", 0, 0
                    DisplayMaster true
                    _Delay 1
                    Shell _Hide delcmd$ + gamepath$ + "ch0*.*"
                    GoSub gfinit
                    GoTo woof
                End If
            Case Is = "ED" '                                         edit
                Do: _Limit mloop
                    Center 0, " Algebraic  or  Descriptive? ", true, false
                    KeyScan
                    If asci = 27 Then Exit Do
                    If i$ = "" Then i$ = " "
                Loop Until InStr("ad", i$)
                If asci <> 27 Then
                    If i$ = "a" Then t$ = ".alg" Else t$ = ".des"
                    t$ = gamepath$ + f$(se) + t$
                    If _FileExists(t$) Then Shell _DontWait editcmd$ + t$
                End If
            Case Is = "FILENAME" '                                   filename (clicked on)
                se = fo + Int((my - y1) / (y2 - y1) * np) + 1
                If se < 1 Then se = 1
                If se > n Then se = n
                If se > (fo + np) Then
                    se = fo + np
                    If se > n Then se = n
                End If
                If se = lc Then
                    f$ = f$(se)
                    fd$ = d$(se)
                    readonly = -(Len(header$(7)) > 0) '              if game had an end, disable file writes
                    Exit Do
                End If
            Case Is = "PL" '                                         play
                f$ = f$(se)
                fd$ = d$(se)
                Exit Do
            Case Is = "RE" '                                         rename
                GoSub clearbottom
                nf$ = GetField$("New filename: ", 520, 14, 0, "")
                If Len(nf$) = 0 Then _Continue
                For i = 1 To n
                    If nf$ = f$(i) Then
                        If makenoise Then PlaySound illegal Else Sound 7777, 1
                        t$ = "Filename in use!"
                        _Font 14
                        ShadowPrint (tlx + trx) \ 2 - _PrintWidth(t$) \ 2, 520, t$, white
                        DisplayMaster true
                        Sleep 2
                        GoTo woof
                    End If
                Next i

                If minty Then '                                  Linux
                    c$ = rencmd$ + gamepath$ + f$(se) + ".alg " + gamepath$ + nf$ + ".alg"
                    Shell _Hide c$
                    c$ = rencmd$ + gamepath$ + f$(se) + ".des " + gamepath$ + nf$ + ".des"
                    Shell _Hide c$
                Else '                                           above method not working in XP - too long?
                    tf = FreeFile
                    c$ = _CWD$
                    Open "temp.bat" For Output As #tf
                    Print #tf, "cd "; gamepath$
                    Print #tf, "ren "; f$(se); ".alg "; nf$; ".alg"
                    Print #tf, "ren "; f$(se); ".des "; nf$; ".des"
                    Print #tf, c$
                    Close #tf
                    Shell _Hide "temp"
                End If

                If logfiled$ = (f$(se) + ".alg") Then
                    logfiled$ = nf$ + ".alg"
                    logfile$ = gamepath$ + logfiled$
                End If
                f$(se) = nf$
            Case Is = "SCROLL" '                                     mouse scroll area
                ty = my
                If ty < (by1 + 10) Then ty = ty - 10
                If ty > (by2 - 10) Then ty = ty + 10
                se = Int((ty - by1) / (by2 - by1) * n)
                GoSub to_middle
            Case Is = "DE" '                                         delete
                Do: _Limit mloop
                    Center 0, " confirm delete Y / N ", true, false
                    KeyScan
                    If i$ = "" Then i$ = " "
                Loop Until InStr("yn", i$)
                If i$ = "y" Then

                    tf$ = gamepath$ + f$(se) + ".des" '              descriptive
                    c$ = delcmd$ + tf$
                    Shell _Hide _DontWait c$

                    tf$ = gamepath$ + f$(se) + ".alg" '              algrebraic
                    c$ = delcmd$ + tf$
                    Shell _Hide _DontWait c$

                    f$(se) = "-deleted"
                    GoSub clearbottom
                End If
            Case Else '                                              search for first letter
                For i = 1 To n
                    j = se + i
                    If j > n Then j = j - n
                    If LCase$(i$) = LCase$(Left$(f$(j), 1)) Then
                        se = j
                        GoSub to_middle
                        Exit For
                    End If
                Next i
        End Select

        If Len(i$) = 2 Then '                                        extended key, most likely up or down
            kk = Asc(i$, 2)
            If kk = 71 Then '                                        Home, jump to top of list
                se = 1
                fo = 0
            End If
            If kk = 79 Then '                                        End, jump to end of list
                se = n
                fo = n - 25: If fo < 0 Then fo = 0
            End If
            ud = (kk = 72) - (kk = 80) - (kk = 81) * 10 + (kk = 73) * 10 '  up/down/PgUp/PgDn
            For i = 1 To Abs(ud)
                se = se + Sgn(ud)
                fc = 0
                If (ud < 0) And (cp < 2) Then fc = -1
                If (ud > 0) And (cp > (np - 1)) Then fc = 1
                fo = fo + fc
                If fo < 0 Then fo = 0
                If se < 1 Then se = 1: fo = 0
                If se > n Then se = n: fo = fo - 1
                If fc = 0 Then cp = cp + Sgn(ud)
            Next i
            If n < np Then fo = 0
        End If
    Loop

    TempMess$ = " "
    ingetfile = false
    legend = waslegend
    PlotScreen false
    oply = false
    chimp = 0
    Exit Sub
    ' ---------------------------------------------------------------------------------------------
    elstupido:
    sbi = (sbi + 1) Mod 100
    For i = 1 To 6
        If (i + sbi) Mod 2 Then c1 = white Else c1 = black
        Line (bx1 + i, yt + i)-(bx2 - i, yb - i), c1, B
    Next i
    Return
    ' ---------------------------------------------------------------------------------------------
    to_middle:
    If se < 1 Then se = 1
    If se > n Then se = n
    If (se > np) Or (se < (n - np)) Then
        fo = se - 14
        If fo < 0 Then fo = 0
        If fo > (n - np) Then fo = n - np
    End If
    Return
    ' ---------------------------------------------------------------------------------------------
    clearbottom:
    _PutImage (blx, bly + 1)-(brx, _Height - 20), bgi, 0, (blx, bly + 1)-(brx, _Height - 20)
    Return
    ' ---------------------------------------------------------------------------------------------
    gfinit:
    tbg = _RGBA(0, 0, 0, 230) '                                      temporary background
    n = 0
    lct$ = ""
    giveup = false
    nbox = 4
    waslegend = legend '                                             save because I turn it off for a nicer look
    legend = false
    TempMess$ = "Looking for files..."
    PlotScreen true
    c$ = dircmd$ + gamepath$ + "*.alg /o-d >temp.dir" '              does Linux understand /o-d?  check...
    Shell _Hide c$
    tf = FreeFile
    Open "temp.dir" For Input As #tf
    While Not (EOF(tf)) And (n < fmax)
        Line Input #tf, o$
        o$ = LCase$(o$)
        p = InStr(o$, ".alg")
        If p Then
            i = p
            While InStr(" /", Mid$(o$, i, 1)) = 0
                i = i - 1
            Wend
            t$ = LTrim$(Mid$(o$, i + 1, p - i - 1))
            p = InStr(t$, " "): If p > 0 Then t$ = Right$(t$, Len(t$) - p)
            n = n + 1
            f$(n) = t$

            If minty Then '                                                                            Linux Mint
                m$ = Mid$(o$, 29, 3)
                p = InStr("   janfebmaraprmayjunjulaugsepoctnovdec", m$) \ 3 '                         convert month to numeric
                m$ = Right$("0" + LTrim$(Str$(p)), 2) '                                                alphanumeric

                d$ = Mid$(o$, 33, 2) '                                                                 day
                If Left$(d$, 1) = " " Then Mid$(d$, 1, 1) = "0" '                                      prefix 0 if d < 10

                If Mid$(o$, 38, 1) = ":" Then '                                                        is time
                    t$ = Mid$(o$, 36, 5)
                    kk = Val(Left$(t$, 2))
                    t$ = Mid$("ampm", 3 + (kk < 12) * 2, 2)
                    If kk > 12 Then kk = kk - 12
                    t$(n) = Right$("0" + LTrim$(Str$(kk)), 2) + Mid$(o$, 38, 3) + " " + t$
                    y$ = Mid$(Date$, 7, 4)
                Else
                    t$(n) = "24:00 am"
                    y$ = Mid$(o$, 37, 4)
                End If
                t$(n) = " " + t$(n)
                d$(n) = y$ + "." + m$ + "." + d$ '                                                      yyyy.mm.dd
            Else
                t$ = Mid$(o$, 4, 1)
                If LCase$(t$) <> UCase$(t$) Then '                                                     date format must be dd MMM yyyy
                    t$ = LCase$(Mid$(o$, 4, 3)) '                                                      isolate month
                    p = InStr("   janfebmaraprmayjunjulaugsepoctnovdec", t$) \ 3 '                     convert month to numeric
                    d$(n) = "20" + Mid$(o$, 8, 2) + "." + Right$("0" + LTrim$(Str$(p)), 2) + "." + Left$(o$, 2) ' convert to yyyy.mm.dd
                    t$(n) = Mid$(o$, 12, 9) '                                                          time
                Else
                    t$ = Left$(o$, 10) '                                                               date format is mm/dd/yy
                    If Right$(t$, 2) = "  " Then
                        d$(n) = "20" + Right$(t$, 2) + "." + Left$(t$, 2) + "." + Mid$(t$, 4, 2)
                    Else
                        d$(n) = Right$(t$, 4) + "." + Left$(t$, 2) + "." + Mid$(t$, 4, 2)
                    End If
                    t$(n) = Mid$(o$, 12, 9) '                                                          time
                End If
            End If
        End If
    Wend
    Close #tf
    TempMess$ = " "

    If n = 0 Then
        TempMess$ = "No saved files!"
        PlotScreen true
        _Delay 1
    End If

    If n = 1 Then f$ = f$(1)
    If n < 2 Then oply = false: ingetfile = false: Exit Sub

    ingetfile = true
    PlotScreen false
    _PutImage (blx, bly)-(brx, _Height - 1), bgi, 0, (blx, bly)-(brx, _Height - 1)
    Center 0, " Play   Rename   Delete   Edit   Back ", true, false

    SetFont defaultfontsize
    bright = _RGB32(250, 250, 250)
    np = 25
    If se = 0 Then se = 1
    xc = (tlx + trx) \ 2
    x1 = xc - 176
    x2 = xc + 176
    y1 = 44
    y2 = y1 + np * 17 + 4

    nbox = 4
    nbox = nbox + 1
    mft$(nbox) = Chr$(0) + Chr$(72) '                                arrow up
    mfx1(nbox) = x2 - 19
    mfx2(nbox) = x2
    mfy1(nbox) = y1 + 1
    mfy2(nbox) = y1 + 18

    nbox = nbox + 1
    mft$(nbox) = Chr$(0) + Chr$(80) '                                arrow down
    mfx1(nbox) = x2 - 19
    mfx2(nbox) = x2
    mfy1(nbox) = y2 - 19
    mfy2(nbox) = y2

    bx1 = x2 - 19
    bx2 = x2
    by1 = y1 + 19
    by2 = y2 - 19

    nbox = nbox + 1
    sbi = nbox
    mft$(nbox) = "SCROLL"
    mfx1(nbox) = bx1 '                                               scroll area
    mfx2(nbox) = bx2
    mfy1(nbox) = by1
    mfy2(nbox) = by2

    nbox = nbox + 1
    mft$(nbox) = "FILENAME"
    mfx1(nbox) = x1 '                                                filename area
    mfx2(nbox) = x2 - 20
    mfy1(nbox) = y1
    mfy2(nbox) = y2

    zorba = nbox
    chimp = nbox

    SetFont 16
    For i = 5 To 6 '                                                 fill in up/down
        Line (bx1, mfy1(i))-(bx2, mfy2(i)), gray, BF
        tx = bx1 + 2
        ty = mfy1(i) + 1 - (i = 6) * 2
        ShadowPrint tx, ty, Chr$(30 - (i = 6)), white
        Line (bx1, mfy1(i))-(bx2, mfy2(i)), white, B
    Next i

    For i = 1 To 4
        Line (x1 - i - 1, y1 - i)-(bx2 + i, y2 + i), tbg, B
    Next i
    Line (x1 - 1 - 5, y1 - 5)-(bx2 + 5, y2 + 5), gray, B
    Line (x1 - 1, y1)-(mfx2(8), y2), tbg, BF '                       erase file get area
    Line (tlx, 0)-(trx, tly - 1), black, BF
    If tscreen < -1 Then _FreeImage tscreen
    tscreen = _CopyImage(0)
    Return
    ' --------------------------------------------------------------------------------
    file_info:
    tf = FreeFile
    f$ = gamepath$ + f$(se) + ".alg"

    If _FileExists(f$) = 0 Then Return
    Open f$ For Input As #tf
    nlines = 0
    For i = 1 To 10
        header$(i) = ""
    Next i
    While Not (EOF(tf))
        nlines = nlines + 1
        Line Input #tf, t$
        If (nlines < 8) And (InStr(t$ + " ", "[") > 0) Then
            t$ = Mid$(t$, 2, Len(t$) - 2)
            header$(nlines) = t$
        End If
    Wend
    Close #tf
    mig = nlines - 7
    header$(1) = "Moves" + Str$(mig)

    SetFont defaultfontsize
    GoSub clearbottom
    For i = 1 To 5
        j = Val(Mid$("56317", i, 1))
        x$ = header$(j)
        t$ = ""
        ic = Val(Mid$("66567", i, 1))
        For k = 1 To Len(x$)
            c$ = Mid$(x$, k, 1)
            If k = ic Then t$ = t$ + ":"
            If c$ <> q$ Then t$ = t$ + c$
        Next k
        j = InStr(t$, ":")
        x$ = Left$(t$, j)
        t$ = Right$(t$, Len(t$) - j)
        If t$ = " " Then t$ = "Unknown"
        ShadowPrint xc - _PrintWidth(x$) - 6, bly - 4 + i * 16, x$, gray
        ShadowPrint xc, bly - 4 + i * 16, t$, white
    Next i
    Return
End Sub

Sub ReadLinuxTemperatures
    Static xtemp
    Dim As _Byte tf, p1, p2, newinfo
    Dim t1, t2, t$

    'TimeTrack "ReadTemp", 1

    If ExtendedTimer < newinfo Then
        c1 = xtemp
    Else
        Shell _Hide "sensors > temp.dat" '                           kosher with all flavors of Linux I hope
        c1 = 0 '                                                     return value default
        If _FileExists("temp.dat") = 0 Then Exit Sub '               in case sensors was invalid
        tf = FreeFile
        Open "temp.dat" For Input As #tf
        While Not (EOF(tf))
            Line Input #tf, t$
            If Left$(t$, 4) = "Core" Then '                          core 0 to whatever
                p1 = InStr(t$, "+") + 1 '                            location of core temperature
                p2 = InStr(p1 + 1, t$, "+") + 1 '                    location of critical temperature
                t1 = Val(Mid$(t$, p1, 3)) '                          core temperature
                t2 = Val(Mid$(t$, p2, 3)) '                          critical temperature
                c2 = t1 * 100 / t2 '                                 %
                If c2 < 0 Then c2 = 0
                If c2 > 127 Then c2 = 127
                If c2 > c1 Then c1 = c2 '                            take highest %
            End If
        Wend
        Close #tf
        xtemp = c1
        newinfo = ExtendedTimer + .2
    End If
    'TimeTrack "ReadTemp", 0
End Sub

Sub GetWB '                                                          white or black [after file playback or setup]
    ClearBuffers
    getwbflag = true
    Do: _Limit mloop
        If msg$ = "Checkmate" Then TempMess$ = msg$
        nbox = 4
        chimp = 0
        PlotScreen false
        KeyScan
        If Len(i$) = 0 Then i$ = "*"
        p = InStr("bw", i$)
    Loop Until p
    nbox = chimp
    TempMess$ = " "
    getwbflag = false
    human = true
    humanc = p - 1
    invert = humanc Xor 1
    abort = true
    _Delay .2
    ClearBuffers
End Sub

Sub GraphLoad Static
    Dim As _Unsigned _Byte gsinit, i, n, cpuavg, sa
    Dim na, np, x1, y1, x2, y2, p1, p2, spx, spy, zz, z1, z2, ospx, ospy, tx, mmax
    Dim As _Unsigned Long tred, tgreen, tyellow, tc(3)
    Dim inf$(4), inc(4) As _Unsigned Long, inf(4), inx(4) As _Byte
    Dim gp(152) As gpoints
    Dim As _MEM m0, m1
    m0 = _Mem(gp(0)): m1 = _Mem(gp(1))
    Dim tf, t$
    $If WIN Then
        Dim lt, ltc As Double
    $Else
            Dim lfreq, ltemp, nline, tcpu As Single
    $End If

    Type gpoints
        tem As _Byte
        loa As _Byte
        mps As Long
        avl As _Byte
        avm As Long
    End Type

    If barebones Then Exit Sub

    If gsinit = false Then
        tred = _RGB32(220, 20, 20) '                                 colors a bit off from any background so they stand out
        tgreen = _RGB32(20, 220, 20)
        tyellow = _RGB32(230, 230, 0)

        tc(1) = tgreen
        tc(2) = tyellow
        tc(3) = tred

        x1 = 24
        x2 = tlx - 20
        y1 = bly
        y2 = _Height - 21

        np = x2 - x1 '                                               number of points
        na = 4 '                                                     number to average
        p1 = np + 1: p2 = na + 1 '                                   pointers

        $If WIN Then
            tf = FreeFile
            Open "temp2.bat" For Output As #tf
            Print #tf, "@echo off"
            Print #tf, "for /f " + q$ + "skip=1 tokens=2 delims==" + q$ + " %%A in ('wmic /namespace:\\root\wmi PATH MSAcpi_ThermalZoneTemperature get CurrentTemperature /value') do set /a " + q$ + "HunDegCel=(%%~A*10)-27315" + q$
            Print #tf, "echo %HunDegCel:~0,-2%.%HunDegCel:~-2% Degrees Celsius"
            Close #tf
        $End If

        SetFont 9
        inf(1) = -1: inc(1) = tred
        inf(2) = -1: inc(2) = tyellow: inf$(2) = "LOAD": inx(2) = _PrintWidth(inf$(2))
        inf(3) = -1: inc(3) = tgreen: inf$(3) = "MPS": inx(3) = _PrintWidth(inf$(3))
        inf(4) = -1: inc(4) = _RGB32(222, 222, 222)

        gsinit = true
    End If

    _MemCopy m1, m1.OFFSET, m1.SIZE To m0, m0.OFFSET
    p1 = p1 - 1 - (p1 = 1) '                                         decrement pointer if >1
    p2 = p2 - 1 - (p2 = 1) '                                         pointers into array

    If (rflag = 0) Or insettings Then mps = 0
    gp(np).mps = mps

    $If WIN Then
        gp(np).loa = GetCPULoad * 100

        If ExtendedTimer > ltc Then '                                limited to once every 5 seconds
            Shell _Hide "temp2.bat > temp2.dat" '                    get temperature from wmic.exe
            If _FileExists("temp2.dat") Then
                tf = FreeFile
                Open "temp2.dat" For Input As #tf
                If Not (EOF(tf)) Then Line Input #tf, t$ '           ya never know! (checking off, be cautious)
                lt = Val(t$)
                If lt < 0 Then lt = 0 '                              should not happen - read error?
                If lt > 127 Then lt = 127 '                          cover all bases
                gp(np).tem = lt
                Close #tf
            End If
            ltc = ExtendedTimer + 5
        Else
            gp(np).tem = lt '                                        use last temperature read
        End If
    $Else
            lfreq = (lfreq + 1) Mod 5
            If lfreq = 1 Then

            ReadLinuxTemperatures '                                  uses sensors command
            ltemp = c1
            If ltemp < 0 Then ltemp = 0
            If ltemp > 127 Then ltemp = 127

            tcpu = 0 '                                               CPU load
            nline = 0
            Shell _Hide "top -b -i -n 1 > temp.dat"
            If _FileExists("temp.dat") Then
            tf = FreeFile
            Open "temp.dat" For Input As #tf
            While Not (EOF(tf))
            Line Input #tf, t$
            nline = nline + 1
            If nline > 7 Then tcpu = tcpu + Val(Mid$(t$, 48, 5))
            Wend
            Close #tf
            End If
            If tcpu < 0 Then tcpu = 0
            If tcpu > 100 Then tcpu = 100
            End If
            gp(np).tem = ltemp
            gp(np).loa = tcpu
    $End If

    z1 = 0: z2 = 0
    For i = na To p2 Step -1 '                                       smooth numbers
        z1 = z1 + gp(np - i + 1).loa
        z2 = z2 + gp(np - i + 1).mps
    Next i
    gp(np).avl = z1 \ (na - p2 + 1) '                                average load
    If mps = top_mps Then '                                          cancel averaging for this point to let graph hit top
        gp(np).avm = mps
    Else
        gp(np).avm = z2 \ (na - p2 + 1)
    End If

    If minty Then cpuavg = gp(np).tem Else cpuavg = gp(np).loa '     for Linux, use actual temperature: for Windows, CPU load

    If cpuavg > 98 Then '                                            throttle performance
        If ((ndelay Mod 10) = 0) And (mloop > 1) Then mloop = mloop - 1
        ndelay = ndelay + 1 '                                        track how many delays
        If mdelay! = 0 Then mdelay! = .1
        _Delay mdelay! '                                             prevent CPU overheating
        tdelay! = tdelay! + mdelay!
    End If

    If (cpuavg < 70) And (mloop < 10) Then mloop = mloop + 1 '       restore performance

    If pregame Then Exit Sub '                                       don't show graph on main menu

    _PutImage (x1, y1 - 12)-(x2, y2), bgi, 0, (x1, y1 - 12)-(x2, y2) ' clear graph area

    If (bgc = 0) Or (bgc = 2) Then c1 = gray Else c1 = black '       red & blue
    For zz = y1 To y2 Step (y2 - y1) / 11
        Line (x1, zz)-(x2, zz), c1, , &H8080
    Next zz

    If gscale Then
        mmax = top_mps '                                             set max to top seen this session
    Else
        mmax = 0 '                                                   set max to top IN VIEW
        For i = 0 To np
            If gp(i).mps > mmax Then mmax = gp(i).mps
        Next i
    End If

    z1 = y2 - y1 '                                                   save a little computation in next loop
    z2 = z1 - 10 '                                                   ditto
    sa = 1 - (mmax = 0) '                                            skip plotting mps if 0

    For n = sa To 3
        For i = p1 To np - 1
            spx = x1 + i
            Select Case n
                Case 1 '                                             moves per second
                    spy = y2 - z2 * gp(i).avm \ mmax
                Case 2 '                                             CPU load
                    spy = y2 - z1 * gp(i).avl \ 110
                Case 3 '                                             temperature
                    spy = y2 - z1 * gp(i).tem \ 110
            End Select
            If spy <= (y1 + 1) Then spy = y1 + 1
            If spy > (y2 - 1) Then spy = y2 - 1
            If i > p1 Then
                Line (ospx + 1, ospy + 1)-(spx + 1, spy + 1), black ' helps lines stand out against background
                Line (ospx, ospy)-(spx, spy), tc(n) '                plot graph
            End If
            ospx = spx: ospy = spy '
        Next i
    Next n

    SetFont 9

    If gp(np).tem <> inf(1) Then
        inf$(1) = LTrim$(Str$(gp(np).tem)) + Chr$(248) + "C"
        inf(1) = gp(np).tem
        inx(1) = _PrintWidth(inf$(1))
    End If

    If mloop <> inf(4) Then
        inf$(4) = "FPS" + Str$(mloop)
        inf(4) = mloop
        inx(4) = _PrintWidth(inf$(4))
    End If

    tx = x1
    For i = 1 To 4
        ShadowPrint tx, bly - 10, inf$(i), inc(i)
        tx = tx + inx(i) + 10
    Next i
    ShadowPrint tx - 8, bly - 10, "/10", inc(4)
End Sub

Sub Help
    Dim p, lp, tf, np, xp, yp, xmin, xmax, ls, pw, sp, tscreen, sbri, mybit
    Dim birdie, t$, w$, xtimer As Double

    If inhelp Then Exit Sub
    inhelp = true

    sbri = bri '                                                     save user selected brightness
    bri = 3 '                                                        brightness
    ColorSet
    Cls , black

    If fullscreenflag > 0 Then Buttons 0, 0 '                        ?,  min, resize, exit

    boardwhite = _RGB32(200, 200, 200)
    SetFont 18
    xmin = 20: xmax = _Width - xmin '                                set left and right margin
    yp = 40

    xp = xmin '                                                      left margin
    ls = _FontHeight + 1 '                                           line spacing
    sp = _PrintWidth(" ") - 1 '                                      space size

    Color boardwhite
    f$ = datapath$ + "help.txt" '                                    .\chessdat\help.txt
    If _FileExists(f$) = 0 Then Exit Sub

    t$ = datapath$ + "dodo.png" '                                    optional dodo picture
    If _FileExists(t$) Then birdie = _LoadImage(t$)
    If birdie < -1 Then GoSub DumbBird

    tf = FreeFile
    Open f$ For Input As #tf
    While Not (EOF(tf))
        Line Input #tf, t$
        lp = 1 '                                                     last position of a blank
        Do
            p = InStr(lp, t$ + " ", " ") '                           find next space
            If p < 3 Then Exit Do '                                  done with this line
            w$ = LTrim$(RTrim$(Mid$(t$, lp, p - lp + 1))) '          grab a word
            lp = p + 1 '                                             update last chr$(32)
            If Len(w$) = 0 Then _Continue '                          takes care of any double space
            np = (Right$(w$, 2) = "/p") '                            detect new paragraph
            If np Then
                w$ = Left$(w$, Len(w$) - 2) '                        remove command
                If rotate = 0 Then DisplayMaster true
            End If
            pw = _PrintWidth(w$)
            If (xp + pw) > xmax Then xp = xmin: yp = yp + ls '       new line
            'ShadowPrint xp, yp, w$, boardwhite '                    slow, ineffective with a dark background
            _PrintString (xp, yp), w$
            xp = xp + pw + sp
            If np Then xp = xmin: yp = yp + ls * 1.5 '               new paragraph
        Loop
    Wend
    Close #tf

    ClearBuffers '                                                   inkey and buttons
    xtimer = ExtendedTimer - 1
    tscreen = _CopyImage(0) '                                        base image
    nbox = 3
    Do: _Limit mloop
        _PutImage , tscreen, 0 '                                     the text on a blank screen
        Buttons 0, 0 '                                               min/resize/close
        If birdie < -1 Then GoSub DumbBird
        KeyScan '                                                    check input
        If ExtendedTimer > xtimer Then
            plasma_init = false
            xtimer = ExtendedTimer + 5 '                             change background plasma in 5 seconds
            mybit = mybit Xor 1 '                                    bird orientation (facing left or right)
        End If
        If dev And (i$ = "q") Then Quit
    Loop Until (asci = 27) Or b1 Or b2 '                             Esc or mouse button

    _FreeImage birdie
    _FreeImage tscreen '                                             free up memory
    b1 = false
    b2 = false
    bri = sbri
    ColorSet
    inhelp = false
    PlotScreen true
    Exit Sub

    DumbBird:
    If mybit Then
        _PutImage (xmax, 40)-(xmax - 110, 150), birdie, 0 ' facing right
    Else
        _PutImage (xmax - 110, 40)-(xmax, 150), birdie, 0 ' facing left
    End If
    Return
End Sub

Sub InfoOnRight
    Static ply, iscreen

    If barebones Then Exit Sub

    If (rotate = 1) Or (rotate = 3) Then Exit Sub
    If (human = 2) And (showthinkingf Or dosmallboard) Then Exit Sub
    'TimeTrack "IOR", 1

    If rflag And showthinkingf Then oply = -1
    ply = move * 2 + WorB
    If ply = oply Then
        _PutImage (trx + 1, try)-(_Width - 1, _Height - 20), iscreen, 0, (trx + 1, try)-(_Width - 1, _Height - 20)
        GoTo es
    End If
    oply = ply

    If dosmallboard Then
        If ssb(1) < -1 Then _PutImage (trx + 1, try)-(_Width - 1, _Height - 20), ssb(1), 0, (trx + 1, try)-(_Width - 1, _Height - 20)
        GoTo ss
    End If
    If showthinkingf Then ShowThinking Else HistoryX

    ss:
    If iscreen < -1 Then _FreeImage iscreen
    iscreen = _CopyImage(0)

    es:
    'TimeTrack "IOR", 0
End Sub

Sub HistoryX
    Dim mi, j, sa, sx, sy, dx, dy, ox, oy, c$, t$, lc$

    'If dev Then Sound 9999, 1
    sx = trx + 35
    sy = tly + 3
    dx = sx
    dy = sy '                                                        set writing to top line
    SetFont 9
    sa = shia + move - 48
    If sa < 1 Then sa = 1

    For mi = sa To sa + 48
        t$ = ""
        If mi <= move Then
            If descriptive Then
                t$ = f12$(mlog$(mi, 3)) + " " + f12$(mlog$(mi, 2))
            Else
                t$ = f12$(mlog$(mi, 1)) + " " + f12$(mlog$(mi, 0))
            End If
            If Len(t$) Then t$ = Rjust$(mi, 4) + " " + t$ '          prefix the move number
            GoSub xprint
        End If
    Next mi

    Exit Sub
    ' -----------------------------------------------------------------------------------------
    xprint: '                                                        similar to X-files

    t$ = RTrim$(t$) '                                                else "w" in draw gets cut off

    If (dy \ (_FontHeight + 2)) Mod 2 Then '                         alternate blank/shaded like old printer paper
        j = _SHL(bri, 4) '                                           j = bri * 8
        Line (dx, dy - 1)-Step(185, _FontHeight), _RGB32(j, j, j), BF
    End If
    Color white, zip

    For j = 1 To Len(t$) '                                           print one character at a time to get nice spacing (kerning)
        c$ = Mid$(t$, j, 1) '                                        the character
        If c$ <> " " Then
            ox = 0 '                                                 offset x
            If c$ = "?" Then ox = 2
            If c$ = "(" Then ox = 2

            If c$ = "-" Then
                If lc$ <> ")" Then ox = 2
                If lc$ = ")" Then ox = 1
                If lc$ = "P" Then ox = 1
            End If

            If c$ = "+" Then
                If lc$ <> "O" Then ox = 1
                If lc$ = ")" Then ox = 0
                If lc$ = "R" Then ox = 2
                If lc$ = "+" Then ox = 2
                If lc$ = "Q" Then ox = 2
            End If

            If (c$ = "P") And (lc$ <> " ") Then ox = 1

            If lc$ = "x" Then ox = 1
            If (c$ = "x") And (lc$ = ")") Then ox = -1

            If InStr("bdg", c$) Then ox = -1

            If (j > 4) And descriptive And (InStr("e12345678)", c$) > 0) Then ox = 1
            oy = (c$ = "-") + (c$ = "g") '                           offset y
            ShadowPrint dx + (j - 1) * 6 + ox, dy + oy, c$, white
        End If
        lc$ = c$ '                                                   save last char
    Next j
    dy = dy + _FontHeight + 2
    Return
End Sub

Sub HumanMove Static
    Static As _Byte cc, rr
    Static As Long dx, dy, smx, smy
    Dim As _Byte i, z, cd, rd, mp, onboard, pc, tp
    Dim x, y

    If hinit = false Then '                                          initialize (cursor on king pawn)
        mx = 999 '                                                   old Mexican
        cc = 5 '                                                     column
        rr = 7 '                                                     row
        dx = tlx + cc * xq - hxq
        dy = tly + rr * yq - hyq
        hinit = true
    End If

    mp = 0 '                                                         moving piece
    pc = 0 '                                                         plot cursor

    redo:
    _MemCopy m(0), m(0).OFFSET, m(0).SIZE To m(10), m(10).OFFSET '   copy working b() to display board b2()

    For i = 0 To 1

        cursoron = ExtendedTimer + 2

        Do: _Limit mloop
            If i = 0 Then mp = 0
            PlotScreen false
            If onboard And (piece_style = 0) Then ID_or_ChangePiece cc, rr ' funny pictures - Mel Brooks, Trump, SpongeBob, etc.
            If (mp > 0) And (mx > tlx) And (mx < trx) And (my > try) And (my < bly) Then
                z = PieceSize(mp)
                _PutImage (dx - hxq + z, dy - hyq + z)-(dx - hxq + xq - z, dy - hyq + yq - z), pix(piece_style, mp), 0
            End If

            If (cursoron < ExtendedTimer) And hover And onboard Then
                tp = b(cc, 9 - rr)
                If i Then
                    If (tp = 0) Or (WorB <> Sgn(tp And 8)) Then istuff$ = Enter$
                Else
                    If (tp > 0) And (WorB = Sgn(tp And 8)) And (nvalid > 0) Then istuff$ = Enter$
                End If
                If (istuff$ = Enter$) And click Then
                    If i Then PlaySound click2 Else PlaySound click1
                End If
            End If
            If pc And ((istuff$ = Enter$) Or (cursoron > ExtendedTimer)) Then
                If i Then
                    ShowValid hfc, hfr
                Else
                    ShowValid cc, 9 - rr
                End If
                Cursor cc, rr, i
                'debug$ = Str$(cc) + Str$(rr) + Str$(mx) + Str$(my)
            End If

            smx = mx
            smy = my
            KeyScan
            If asci = 27 Then GoTo redo '                            pressed Esc
            If (human = false) Or (abort = 2) Or redoflag Or onplayback Or takebackflag Then Exit Sub
            If Len(i$) Then GoTo ik

            If (mx <> smx) Or (my <> smy) Then
                x = (mx - tlx + hxq - 1) / xq
                y = (my - tly + hyq - 1) / yq
                If (x < 1) Or (x > 8) Or (y < 1) Or (y > 8) Then
                    onboard = false
                    pc = false
                    GoTo redo
                Else
                    onboard = true
                    pc = true
                    cc = x
                    rr = y
                    If invert Or usd Then
                        cc = 9 - cc
                        rr = 9 - rr
                    End If
                    dx = mx
                    dy = my
                    If (mx <> smx) Or (my <> smy) Then cursoron = ExtendedTimer + 2
                End If
            End If

            If b1 Or b2 Then '                                   button pressed
                b1 = false
                b2 = false
                If onboard = false Then
                    PlaySound illegal
                    GoTo redo
                End If
                asci = 13 '                                      simulate pressing Enter
                ClearBuffers
                _Delay .2 '                                      cuts down problem of 2 mouse clicks
            Else
                _Continue
            End If

            ik:
            onboard = true
            If asci = 13 Then '                                      Enter
                i$ = "": asci = 0
                z = b2(cc, 9 - rr) '                                 what piece is at this square
                If i = 0 Then
                    If (WorB = -(z > 6)) And (z > false) Then
                        mp = z
                        b2(cc, 9 - rr) = false
                        hfc = cc
                        hfr = 9 - rr
                        Exit Do
                    End If
                Else
                    If ((cc = hfc) And (rr = (9 - hfr))) = false And ((z = false) Or (WorB <> -(z > 6))) Then
                        b2(cc, 9 - rr) = mp
                        htc = cc
                        htr = 9 - rr
                        Exit Do
                    End If
                End If
            End If

            If li = 2 Then '                                         possibly arrow keys
                cd = (asci = 75) - (asci = 77) '                     left right
                rd = (asci = 72) - (asci = 80) '                     up down
                If invert Then cd = -cd: rd = -rd
                If cd Or rd Then
                    cc = cc + cd '                                   left right
                    rr = rr + rd '                                   up down
                    If cc < 1 Then cc = 1
                    If cc > 8 Then cc = 8
                    If rr < 1 Then rr = 1
                    If rr > 8 Then rr = 8
                    pc = true

                    If invert Then
                        dx = tlx + (9 - cc) * xq - hxq
                        dy = tly + (9 - rr) * yq - hyq
                    Else
                        dx = tlx + cc * xq - hxq
                        dy = tly + rr * yq - hyq
                    End If
                    cursoron = ExtendedTimer + 2
                End If
            End If
        Loop
    Next i
End Sub

Sub ID_or_ChangePiece (tc As _Byte, tr As _Byte) '                   various pictures for pieces (change: cursor on piece, spacebar)
    Dim As _Byte i, tp
    Dim z$, z2$, zc, what$

    tp = b(tc, 9 - tr) '                                             temporary piece = from board

    If asci = 32 Then '                                              spacebar, change piece
        zeropiece:
        piecefn(tp) = piecefn(tp) + 1
        f$ = datapath$ + "sfunny" + slash + piecef$(tp) + LTrim$(Str$(piecefn(tp))) + ".jpg"
        If _FileExists(f$) Then
            If pix(0, tp) < -1 Then _FreeImage pix(0, tp)
            pix(0, tp) = _LoadImage(f$)
            If pix(0, tp) = -1 Then QuitWithError "Image file", z$ ' corrupt file?
            BrightnessAdjust 0, tp
            lpoints = -1
        Else '                                                       non-existent, loop back and start over
            piecefn(tp) = 0
            GoTo zeropiece
        End If
    Else '                                                           not spacebar, just identify piece
        If tp = 0 Then
            TempMess$ = " "
        Else
            zc = Sgn(tp And 8)
            z$ = "(" + Mid$("blackwhite", zc * 5 + 1, 5)
            what$ = z$ + " " + LCase$(piecef$(tp)) + ")"
            z2$ = LCase$(piecef$(tp) + LTrim$(Str$(piecefn(tp))) + ".jpg")
            TempMess$ = what$
            For i = 1 To captions
                z$ = LCase$(FunnyPix$(i) + ".jpg")
                If InStr(z2$, z$) Then
                    If Len(caption$(i)) < 25 Then
                        TempMess$ = caption$(i) + " " + what$
                    Else
                        TempMess$ = caption$(i)
                    End If
                End If
            Next i
        End If
    End If
End Sub

Sub InitSystem
    Dim i, c, r, p, t, m, d, c$, p$, t$, udlr$, title$

    pregame = true '                                                 suppress clock during color selection

    Do Until _ScreenExists: Loop
    _ScreenMove _Middle
    t$ = "Loading..."
    Locate 12, 40 - Len(t$) \ 2
    Print t$

    'loadsetsinbackground = true '                                    good idea?  maybe...

    m(0) = _Mem(b(0, 0)): m(10) = _Mem(b2(0, 0)) '                                               working board, display board
    m(1) = _Mem(s1(0, 0)): m(2) = _Mem(s2(0, 0)): m(3) = _Mem(s3(0, 0)): m(4) = _Mem(s4(0, 0)) ' saving states for recursion
    m(5) = _Mem(s5(0, 0)): m(6) = _Mem(s6(0, 0)): m(7) = _Mem(s7(0, 0)): m(8) = _Mem(s8(0, 0))

    dev = Abs(_FileExists("rick.txt")) '                             easy way to detect myself

    t$ = LCase$(Command$) + Space$(20)

    If InStr(t$, "wonka") Then dev = false
    If InStr(t$, "dev") Then dev = true
    If (dev = true) Or (InStr(t$, "nim") > 0) Then no_intro_music = true
    If InStr(t$, "xmas") Then xmas = true

    If InStr(t$, "server") Then match = 1
    If InStr(t$, "client") Then match = 2
    If InStr(t$, "match") Then cmatch = true

    If InStr(_OS$, "64") Then
        title$ = " Dodo Zero x64"
    Else
        title$ = " Dodo Zero x32"
    End If

    If match = 2 Then title$ = title$ + "  Client"
    If match = 1 Then
        title$ = title$ + " Server"
        If InStr(t$, "server2") Then Shell _DontWait "chess client"
    End If
    _Title title$

    masterlevel = Val(t$) '                                          2 fast but stupid, 4 default, 6 too slow

    t$ = LTrim$(Str$(masterlevel))
    If InStr("023456", t$) = 0 Then
        Print "Invalid parameters"
        Sleep
        System
    End If
    If masterlevel < 2 Then masterlevel = 4
    masterm1 = masterlevel - 1

    InitPath
    ConfigRead

    If _FileExists("rick.txt") Then '                                for long term averaging of moves per second
        rickfile = FreeFile
        If _FileExists("mps.txt") Then
            Open "mps.txt" For Append As #rickfile
        Else
            Open "mps.txt" For Output As #rickfile
        End If
    End If

    If rickfile Then bgmax = 6 Else bgmax = 4 '                      extra Cheetos & Fruit Loops backgrounds for me

    If Len(NameEntered$) Then
        ComputerName$ = NameEntered$
    Else
        t = FreeFile
        Shell _Hide "CMD /c hostname > temp.dat"
        If _FileExists("temp.dat") Then
            Open "temp.dat" For Input As #t
            If Not (EOF(t)) Then Input #t, t$
            Close #t
        End If
        For i = 1 To Len(t$)
            c$ = Mid$(t$, i, 1)
            If LCase$(c$) = UCase$(c$) Then
                Exit For
            Else
                If i = 1 Then c$ = UCase$(c$)
                ComputerName$ = ComputerName$ + c$
            End If
        Next i
        If Len(ComputerName$) > 25 Then ComputerName$ = Left$(ComputerName$, 25)

        ' I get tired of typing in my name.
        If ComputerName$ = "DESKTOP" Then ComputerName$ = "Frost"
        If ComputerName$ = "WinXPIE" Then ComputerName$ = "Frost"
    End If

    Randomize Timer '                                                seed generator

    cursoron = false
    'draw$ = Chr$(171) + "-" + Chr$(171) '                           symbol for 1/2
    draw$ = "draw" '                                                 simpler/nicer?
    Enter$ = Chr$(13) '                                              to order a pizza
    Esc$ = Chr$(27) '                                                to quit program
    FENmax = 1000 '                                                  canned responses
    human = 1 '                                                      assume human playing white
    iflag = true '                                                   automatic board reversal if 2 human players selected
    mloop = 8 '                                                      loop speed while waiting for input (no performance effect)
    plasmaint = 1 '                                                  plasma intensity. ` to change
    q$ = Chr$(34) '                                                  quote
    s$ = Chr$(255) '                                                 invisible space

    m = Val(Left$(Date$, 2)) '                                       month
    d = Val(Mid$(Date$, 4, 2)) '                                     day
    If (dev = 0) And (m = 12) And (d > 24) Then xmas = true '        Christmas, do something nutty with colors (red & green)

    screensaver = _FileExists("auto.") Or InStr(Command$, "/") '     yeah, slash anything or nothing, because I can never remember

    yq = 56 '                                                        size of squares, a compromise to fit most resolutions
    xq = 46

    hxq = xq \ 2
    hyq = yq \ 2

    For i = 1 To 8 '                                                 lookup tables improve speed
        alphal$(i) = Mid$(alphaz$, i, 1)
        alphap$(i) = Mid$("RNBQKPxx", i, 1)
    Next i

    Restore Legal '                                                  value of pieces and how they move
    For i = 1 To 6
        '                    RNBQKP
        value(i) = Val(Mid$("533901", i, 1)) * mult '                point value for captures
        If i = Bishop Then value(i) = value(i) + 4 '                 make bishop worth a bit more than knight
        If i = King Then value(i) = 777
        value(i + 8) = value(i) '                                    copy for white pieces

        Read p$ '                                                    piece, not saved
        For t = 0 To 7 '                                             8 each
            Read udlr$
            du(i, t) = Val(Mid$(udlr$, 1, 1)) '                      direction up
            dd(i, t) = Val(Mid$(udlr$, 2, 1)) '                      direction down
            dl(i, t) = Val(Mid$(udlr$, 3, 1)) '                      direction left
            dr(i, t) = Val(Mid$(udlr$, 4, 1)) '                      direction right
        Next t
    Next i

    Restore KingSquares '                                            when favoring moving King towards center
    For r = 1 To 8 '                                                 row
        For c = 1 To 8 '                                             column
            Read ksv(c, r) '                                         King square value
        Next c
    Next r

    Restore captions '                                               blurb identifying each funny pix
    i = 0
    Do
        i = i + 1
        Read FunnyPix$(i), caption$(i)
    Loop Until caption$(i) = "end"
    captions = i - 1

    Cls
    ScreenInit
    $If WIN Then
        _Icon
    $End If
    t$ = "Loading..."
    Color _RGB32(255, 0, 0)
    _PrintString (_Width \ 2 - _PrintWidth(t$) \ 2, 250), t$
    _Display
    _AllowFullScreen , _Smooth
    ColorSet
    LoadFont '                                                       liberati.ttf
    LoadPieces piece_style '                                         starting set

    t$ = LCase$(Command$ + "   ") '                                  T is for turtle
    p = InStr(t$, "s") '                                             override settings with this scheme
    If p Then
        i = Val(Mid$(t$, p + 1, 2)) - 1
        If (i >= 0) And (i < 12) Then scheme = i: SetScheme
    End If

    _MouseShow RTrim$(Mid$("LINK     CROSSHAIRTEXT     DEFAULT  ", cursortype * 9 + 1, 9))

    xc = _Width \ 2 - 20 '                                           x center
    yc = 258 '                                                       y center
    tlx = xc - 4 * xq: tly = yc - 4 * yq '                           top left x, top left y
    trx = xc + 4 * xq: try = yc - 4 * yq '                           top right x, top right y
    blx = xc - 4 * xq: bly = yc + 4 * yq '                           bottom left x, bottom left y
    brx = xc + 4 * xq: bry = yc + 4 * yq '                           bottom right x, bottom right y

    alfred = _LoadImage(datapath$ + "alfred.jpg") '                  Alfred E. Neuman
    'explosion = _LoadImage(datapath$ + "exp2.png") '                 takes 2 seconds to load

    ca1(1, 1) = 2: ca1(1, 2) = 3: ca1(1, 3) = 4: ca1(1, 4) = 5 '     castling
    ca1(2, 1) = 4: ca1(2, 2) = 5: ca1(2, 3) = 6: ca1(2, 4) = 7: ca1(2, 5) = 8
    ca2(1, 1) = 2: ca2(1, 2) = 3: ca2(1, 3) = 4
    ca2(2, 1) = 6: ca2(2, 2) = 7

    ScreenInit

    For i = 0 To 9 '                                                 piece size adjustments
        '                      1 2 3 4 5 6 7 8 9 0
        psa(i, 0) = Val(Mid$(" 1 3 1-1 010 0 1 1 3", i * 2 + 1, 2))
        psa(i, 1) = Val(Mid$(" 1 2 3 3 012 6 5 5 5", i * 2 + 1, 2))
    Next i

    Legal: '                                                         moves defined
    '      udlr,udlr,udlr,udlr,udlr,udlr,udlr,udlr
    Data R,1000,0001,0100,0010,0000,0000,0000,0000
    Data N,2010,2001,1002,0102,0201,0210,0120,1020
    Data B,1001,0101,0110,1010,0000,0000,0000,0000
    Data Q,1000,1001,0001,0101,0100,0110,0010,1010
    Data K,1000,1001,0001,0101,0100,0110,0010,1010
    Data P,1000,1001,1010,0000,0000,0000,0000,0000

    KingSquares:
    Data 1,2,3,4,4,3,2,1
    Data 2,5,6,7,7,6,5,2
    Data 3,6,8,8,8,8,6,3
    Data 4,7,8,9,9,8,7,4
    Data 4,7,8,9,9,8,7,4
    Data 3,6,8,8,8,8,6,3
    Data 2,5,6,7,7,6,5,2
    Data 1,2,3,4,4,3,2,1

    captions:
    Data bishop1,"Bishop from Aliens"
    Data bishop2,"Orson Welles"
    Data bishop3,"Pope Zelensky"
    Data bishop4,"Chuck Norris"

    Data king1,"Donald Trump"
    Data king2,"It's good to be the King! - Mel Brooks"
    Data king3,"Henry VIII"
    Data king4,"Napoleon"
    Data king5,"Napoleon"
    Data king6,"Napoleon"
    Data king7,"Frenchie"
    Data king8,"Chuck Norris"
    Data king9,"Louis XVI"
    Data king10,"Blue King"
    Data king13,"Stephen King"
    Data king18,"Emperor Palpatine"
    Data king19,"Emperor Palpatine"
    Data king20,"Emperor Palpatine"
    Data king21,"Darth Vader"
    Data king22,"Darth Vader"
    Data king23,"Darth Vader"
    Data king24,"Jabba the Hutt"
    Data king25,"Eric Cartman"
    Data king26,"Sean Connery"
    Data king27,"random geek"
    Data king28,"Dictator Trump"
    Data king29,"Bobby Fischer (R.I.P.)"
    Data king30,"Bobby Fischer (R.I.P.)"
    Data king31,"Garry Kasparov"
    Data king33,"$DEBUG is your friend!"

    Data knight1,"Monty Python Black Knight"
    Data knight2,"Roger Moore/Simon Templar"
    Data knight3,"Sean Connery"
    Data knight12,"Monty Python Black Knight"
    Data knight13,"Monty Python Black Knight"
    Data knight14,"Luke Skywalker"
    Data knight15,"Luke Skywalker"
    Data knight16,"Luke Skywalker"
    Data knight17,"Luke Skywalker"
    Data knight19,"Han Solo"
    Data knight20,"Inigo Montoya"
    Data knight21,"Jaws"
    Data knight23,"Don't worry - got API!"

    Data pawn1,"Star Trek red t-shirt guy"
    Data pawn2,"shrimp"
    Data pawn3,"Rick Moranis"
    Data pawn4,"Gomer Pyle"
    Data pawn5,"Gomer Pyle"
    Data pawn6,"I'm a SOMEBODY! -Steve Martin"
    Data pawn7,"Homer Simpson"
    Data pawn8,"Adam Sandler"
    Data pawn11,"Pigpen (Peanuts)"
    Data pawn14,"Charlie Brown"
    Data pawn15,"Lee Harvey Oswald"
    Data pawn16,"Lee Harvey Oswald"
    Data pawn18,"Kenny from South Park"
    Data pawn19,"Kenny from South Park"
    Data pawn20,"Kenny from South Park"

    Data queen1,"Queen Elizabeth II"
    Data queen3,"Anjelica Huston/Addams Family"
    Data queen4,"Evil Queen from Snow White"
    Data queen5,"Cate Blanchett"
    Data queen6,"Cleopatra"
    Data queen7,"Cleopatra"
    Data queen8,"Queen Elizabeth I"
    Data queen9,"Queen Elizabeth I"
    Data queen10,"Queen Elizabeth II"
    Data queen11,"Queen Victoria"
    Data queen13,"Anya Taylor-Joy"
    Data queen14,"Anya Taylor-Joy"
    Data queen15,"Anya Taylor-Joy"
    Data queen16,"Anya Taylor-Joy"
    Data queen17,"Ayn Rand"
    Data queen18,"Lucy van Pelt"
    Data queen19,"Princess Leia"
    Data queen20,"Princess Bride"
    Data queen21,"Judit Polgar"
    Data queen23,"Genevieve Bujold"
    Data queen24,"CIA spy"

    Data rook1,"Spongebob Squarepants"
    Data rook2,"Disneyland"
    Data rook3,"Galata Tower"
    Data rook4,"Galata Tower"
    Data end,end
End Sub

Sub InitPath
    Dim cwd$

    cwd$ = _CWD$ '                                                      current working directory
    If Right$(cwd$, 1) = slash Then cwd$ = Left$(cwd$, Len(cwd$) - 1) ' root (maybe USB stick?), take off slash
    datapath$ = cwd$ + slash + "chessdat" + slash '                     being Linux friendly
    gamepath$ = datapath$ + "games" + slash$
    ConfigFile$ = datapath$ + "chess.dat"
End Sub

Sub InitGame
    Dim x1, x2, y1, y2, q, z, zz, t$, ti$, cat As Double

    pregame = true '                                                 suppress clock during color selection
    WorB = 1 '                                                       white or black
    SetupBoard
    TempMess$ = " "
    _MemCopy m(0), m(0).OFFSET, m(0).SIZE To m(10), m(10).OFFSET '   working to display

    If human = 0 Then GoTo isauto
    If (match = 1) Or (match = 2) Then
        human = 1
        humanc = -(match = 1)
        GoTo isauto
    End If

    If minactive Then ToFrom 0, "ng", match '                        signal Minimax new game
    If match = 3 Then match = false

    lct$ = ""
    barebones = false
    onplayback = false
    cat = ExtendedTimer + 300 '                                      not a dog (scheme change at)

    keypressedat = ExtendedTimer '                                   to detect inactivity, load a set
    mousemovedat = ExtendedTimer

    Do: _Limit mloop '                                               main menu

        If rickfile And (ExtendedTimer > cat) Then '                 others probably wouldn't like this
            scheme = (scheme + 1) Mod 12 '                           scheme=color,set,background,clock type
            SetScheme
            cat = ExtendedTimer + 5 '                                change at
        End If

        PlotScreen false '                                           plot but do not display

        If cmatch = false Then '                                     not playing Minimax, do the menu
            zz = xq * 3 + 4
            x1 = xc - zz
            y1 = yc - 50
            x2 = xc + zz
            y2 = yc + 50
            Line (x1, y1 + 20)-(x2 + 2, y2 - 20), _RGBA(1, 1, 1, 200), BF
            For q = 2 To 18 Step 4 '                                 overlapping rectangles
                For z = 0 To 1
                    Line (x1 - q + z, y1 + q + z)-(x2 + q + z, y2 - q + z), black, B
                Next z
            Next q
        End If

        If makenoise And (soundloaded = false) Then
            If no_intro_music = false Then
                Center 16, "Loading sound...", false, true
                DisplayMaster true
            End If
            LoadSounds
            cat = ExtendedTimer + 10
            NoChangeUntil = ExtendedTimer + 2
            _Continue
        End If

        If makenoise And (no_intro_music = false) Then
            PlaySound intro
            Color red, zip
            t$ = " Music: Anomaly by Carl Finlay "
            SetFont 12
            If sfile(1) Then ShadowPrint xc - _PrintWidth(t$) \ 2, _Height - 30, t$, red
        End If

        If cmatch = false Then Center 16, " White   Black   Humans   Computer ", true, true

        i$ = InKey$ '                                                speak to me, human
        If (i$ = "q") Or (i$ = Esc$) Then Quit
        If (i$ = Enter$) Or (Len(i$) = 0) Then '                     Enter same as mouse click
            MouseIn
            If Len(istuff$) Then
                i$ = LCase$(istuff$)
                istuff$ = ""
            End If
        End If
        If (human = 0) Or screensaver Then i$ = "c" '                in autoplay or there's a / in COMMAND$
        ti$ = i$
        If i$ = "" Then i$ = " " '                                   instr doesn't handle nulls
        p = InStr("bwhc", LCase$(i$))

        'If (p = 0) And (Len(ti$) > 0) Then cat = ExtendedTimer - 1

        If (i$ = "m") Or cmatch Then
            match = 3
            If minty Then
                If _FileExists("minimax") = 0 Then QuitWithError "minimax", "does not exist"
            Else
                If _FileExists("minimax.exe") = 0 Then QuitWithError "minimax.exe", "does not exist"
            End If
            If minactive = false Then
                If fullscreenflag Then
                    fullscreenflag = false
                    ScreenInit
                End If
                zz = _DesktopWidth - _Width - 20
                _ScreenMove zz, 50
                minactive = true
                If minty Then
                    Shell _DontWait "./minimax" + Str$(p)
                Else
                    Shell _DontWait "minimax" + Str$(p)
                End If
                _Delay 2
            End If
            PlayerName$(0) = "Minimax"
            PlayerName$(1) = "Dodo Zero"
            p = 1
            Exit Do
        End If
        KeepAlive
    Loop Until p

    keypressedat = ExtendedTimer
    mousemovedat = ExtendedTimer

    'ColorSet

    If minactive And (match = false) Then
        ToFrom 0, "en", match '                                      signal Minimax to terminate
        PlayerName$(0) = ""
        PlayerName$(1) = ""
        lasth = -1
        lastc = -1
        minactive = false
    End If

    invert = 0
    Select Case p
        Case 1: human = 1: humanc = 0: invert = true '               player is black
        Case 2: human = 1: humanc = 1 '                              player is white
        Case 3: human = 2 '                                          human vs. human
        Case 4 '                                                     computer vs. computer, just watch
            human = 0
            humanc = 1 '                                             white still goes first
            invert = -(Rnd < .5) '                                   random board orientation
    End Select
    If match = 3 Then invert = false
    If match = false Then
        lct$ = ""
        PlotScreen false
        NameAssign
        ClearBuffers
    End If

    isauto:
    'ColorSet
    If match Then backok = false Else backok = true

    castle$ = "****" '                                               flags QKQK (B then W)
    epsq$ = "-" '                                                    for FENmake
    FENpcount = 0
    giveup = false
    hinit = false '                                                  human initialize, putting the cursor at e2
    logfile$ = "" '                                                  so WriteLog will create a new one
    logfiled$ = ""
    lpoints = -1
    markerfc = 0 '                                                   no last move
    mps = 0 '                                                        moves per second
    noresign = false
    ocount = 0
    oply = -1 '                                                      old ply, controls replot of pieces taken
    perpetual = 0
    pf$ = "" '                                                       playback file
    Erase points
    pregame = false '                                                clock suppresion during color selection
    readonly = false '                                               activated on playback to prevent duplicate logs
    shia = 0
    smoves0 = 0
    tcount = 0 '                                                     total move computed count

    Erase Moves, mcount, lmove, mlog$
    If _SndLen(sfile(1)) Then _SndStop sfile(1)
    WorB = 0
    FENread
    FENmake
    TakeBackPush
    WorB = 1 '                                                       white=1, black=0
    ShowTaken false
    lct$ = ""

    If cmode = 0 Then
        start = ExtendedTimer
        Erase etime
    End If

End Sub

Sub KeepAlive '                                                      Dodo/Minimax interface timeout prevention
    Static katime! '                                                 keep alive
    If minactive And ((katime! = 0) Or (Timer > katime!)) Then
        ToFrom 0, "*", match
        katime! = Timer + 1
    End If
End Sub

Sub KeyScan
    Dim As _Byte i, ud, h, m, s, wasbri
    Dim k, tscreen, t$

    'TimeTrack "KeyScan", 1

    If insettings = false Then RainbowButton
    MouseIn '                                                        may put something in istuff$

    asci = 0 '                                                       ASCII value of inkey
    li = 0 '                                                         length of inkey

    If istuff$ = "help" Then Help: istuff$ = "" '                    special case

    If Len(istuff$) Then '                                           MouseIn simulating a key
        i$ = istuff$
        asci = Asc(Right$(i$, 1))
        li = 1
        istuff$ = ""
        GoTo stuffed
    End If

    ' a feature I find handy, but most would detest - fullscreen toggle with right shift
    If (dev = true) And (_KeyDown(100303) = -1) Then
        fullscreenflag = Sgn(fullscreenflag) Xor 1
        ScreenInit
        GoTo kend
    End If

    i$ = InKey$
    stuffed: '                                                       MouseIn may simulate a key
    li = Len(i$)
    If li Then
        nbox = false
        oply = false
        asci = Asc(Right$(i$, 1))
        cursoron = ExtendedTimer + 2
        lct$ = ""
        keypressedat = ExtendedTimer
    Else
        asci = false
        GoTo kend
    End If

    If inhelp Then GoTo kend
    If ingetfile Then GoTo fkeys
    If insetup And (InStr("fsqre" + Esc$, i$) = 0) Then GoTo try2

    If (_KeyDown(100303) Or _KeyDown(100304)) And (asci = 13) And onplayback Then '   shift-Enter, jump 10 moves in playback
        sfast = fast '                                               piece slide speed
        fast = 0
        Enter10 = 20 '                                               20 plys = 10 moves
        GoTo kend
    End If

    If li = 1 Then '                                                 ordinary keypress

        If promoting And (InStr("rnbq", i$) > 0) Then GoTo kend

        If i$ = "t" Then i$ = "c" '                                  t or c for clock/time

        k = InStr("GTv#M)/\Dq-+=jJ|", i$) '                          special features
        If (dev = 0) And (k > 0) Then
            TempMess$ = "Dev feature"
            If makenoise Then
                PlaySound illegal
            Else '                                                   sound off, so bink screen instead
                tscreen = _CopyImage(0)
                For i = 0 To 4
                    If i Mod 2 Then
                        Cls , red
                    Else
                        _PutImage , tscreen, 0
                    End If
                    DisplayMaster true
                    _Delay .1
                Next i
                _PutImage , tscreen, 0
                _FreeImage tscreen
            End If
            GoTo kend
        End If

        If i$ = "?" Then AddSymbol "?" '                             mark move questionable
        If i$ = "!" Then AddSymbol "!" '                             mark move wow

        If i$ = "/" Then '                                           play position from testing.txt
            legend = true
            markers = true
            testing = testing Xor 1
            TempMess$ = "Testing " + OnOff$(testing)
            SetupBoard
            i$ = "|"
        End If

        Select Case i$
            Case " " '                                               space, the final frontier
                If rflag Then '                                      early move requested
                    msg$ = "abort"
                    abort = true
                    TempMess$ = "Abort"
                    'TimeTrack "KeyScan", 0
                    GoTo kend
                End If
            Case "`"
                If (mx > midway) Or (my < (_Height - 20)) Then
                    scheme = (scheme + 1) Mod 12
                Else
                    scheme = scheme - 1
                    If scheme < 0 Then scheme = 11
                End If
                SetScheme
                ClearTemp
                TempMess$ = "Style" + Str$(scheme + 1) + " of 12"
            Case "=" '                                               30/60 minute countdown timer for me (laundry wash/dry!)
                If rickfile = 0 Then GoTo kend
                If cmode = 0 Then
                    PlayerNamePush
                    PlayerName$(1) = "Current"
                    PlayerName$(0) = "Countdown"
                End If
                cmode = (cmode + 1) Mod 3
                If cmode = 0 Then PlayerNamePop
                t$ = Time$
                Do: _Limit 100
                Loop Until t$ <> Time$
                h = Val(Mid$(Time$, 1, 2))
                m = Val(Mid$(Time$, 4, 2))
                s = Val(Mid$(Time$, 7, 2))
                etime(0, 1) = h * 3600 + m * 60 + s
                start = ExtendedTimer
                Select Case cmode
                    Case 0
                        Erase etime
                        start = ExtendedTimer
                    Case 1
                        etime(0, 0) = 1800 '                         30 minutes
                    Case 2
                        etime(0, 0) = 3600 '                         60 minutes
                End Select
            Case "<" '                                               master _LIMIT (doesn't seem to make much differnece)
                mloop = mloop - 1 - (mloop = 1)
                TempMess$ = "Speed" + Str$(mloop)
            Case ">"
                mloop = mloop + 1 + (mloop = 500)
                TempMess$ = "Speed" + Str$(mloop)
            Case "+" '                                               change piece size (not saved between sessions)
                psize = psize - 1
                TempMess$ = "Piece size" + Str$(psize)
            Case "-" '                                               change piece size (not saved between sessions)
                psize = psize + 1
                TempMess$ = "Piece size" + Str$(psize)
            Case "0" '                                               plasma toggle
                plasmaint = (plasmaint + 1) Mod 2
                TempMess$ = "Plasma " + OnOff$(plasmaint)
            Case "\" '                                               show scores on board
                sob = (sob + 1) Mod 3
                If sob = 0 Then TempMess$ = "Debug mode OFF"
                If sob = 1 Then TempMess$ = "Debug with pause"
                If sob = 2 Then TempMess$ = "Debug with delay"
                graphics = Sgn(sob) Xor 1
                WorB = 1
                SaveWorB = 1
                PlotScreen true
            Case "|" '                                               better setup for seeing onboard scores or diagnostics
                altbg = 4 '                                          no background (black)
                bgc = 5 '                                            white bg
                bri = 1 '                                            lowest brightness
                colori1 = 14 '                                       light gray
                colori2 = 15 '                                       dark gray
                colori3 = 4 '                                        white clock
                fast = false '                                       sliding quick
                graphics = false '                                   kill plasma
                legend = 0
                markers = 0 '                                        markers off
                redoflag = true
                squaretrim = 0 '                                     no trim
                ColorSet
                PlotScreen true
            Case "1" '                                               white square color
                colori1 = (colori1 + 1) Mod 22
                ColorSet
            Case "2" '                                               black square color
                colori2 = (colori2 + 1) Mod 22
                ColorSet
            Case "3" '                                               clock color: red, green, yellow, blue, white
                colori3 = (colori3 + 1) Mod 6
                ColorSet
            Case "4" ''                                              background color
                bgc = (bgc + 1) Mod 6
                ColorSet
            Case "5" ''                                              background type
                altbg = (altbg + 1) Mod (bgmax + 1)
                ColorSet
            Case "~" '                                               what info to show at right
                showright = (showright + 1) Mod 3
                dosmallboard = -(showright = 1)
                showthinkingf = (showright = 2)
            Case "a" '                                               switch to/from automatic (computer playing itself)
                If human = false Then
                    human = true
                    humanc = WorB
                Else
                    human = false
                End If
                TempMess$ = "Automatic " + OnOff$(human Xor 1)
            Case "b" '                                               back (take back move)
                If (human > 0) And (onplayback = 0) And (getwbflag = 0) And (endgame = false) Then
                    If backok Then
                        If (WorB = 1) And (move > 0) Then takebackflag = true
                        If (WorB = 0) And (move > 1) Then takebackflag = true
                    Else
                        TempMess$ = "Takeback is off"
                    End If
                End If
            Case "B" '                                               style of trim around squares
                If piece_style Then '                                exclude funny set (0)
                    squaretrim = (squaretrim + 1) Mod 4
                    TempMess$ = CHRN$(squaretrim + 1) + " of 4"
                Else
                    TempMess$ = "Not this set"
                End If
            Case "c" '                                               c for clock, 0 font, 1 7-segment, 2 Nixie
                clocktype = (clocktype + 1) Mod 3
                If clocktype = 2 Then TempMess$ = "NIXIE TUBES!"
                _Delay .2
                ClearBuffers
            Case "C" '                                               cursor
                cursortype = (cursortype + 1) Mod 4
                _MouseShow RTrim$(Mid$("LINK     CROSSHAIRTEXT     DEFAULT  ", cursortype * 9 + 1, 9))
                _MouseMove 1, 1
                _MouseMove mx, my
                'Case "D" '                                               Dolly Parton (deeper for top 2 or 3 moves)
                '    deep = (deep + 1) Mod 3
                '    TempMess$ = "Depth" + Str$(deep)
            Case "e" '                                               current elapsed time
                smallclock = smallclock Xor 1
            Case "f" '                                               piece slide 0off 1slow 2fast
                If endgame = false Then
                    fast = (fast + 1) Mod 3
                    If rotate <> 0 Then TempMess$ = "Slide " + Mid$("OFF SLOWFAST", fast * 4 + 1, 4)
                End If
            Case "F" '                                               play previous game (chNNNNNN.alg)
                If (rflag = false) And (endgame = false) Then PlayFile
            Case "g" '                                               restart plasma
                plasma_init = false
            Case "G" '                                               temperature/load/MPS graph scaling
                gscale = gscale Xor 1
                TempMess$ = "Scale MPS " + Mid$("currenttop    ", gscale * 7 + 1, 7)
            Case "h" '                                               display some shortcuts
                TempMess$ = "F2 Set-  F3 Set+  F4 Bri-  F5 Bri+"
            Case "H" '                                               easier way to move pieces
                hover = hover Xor 1
                TempMess$ = "Hover " + OnOff$(hover)
            Case "i" '                                               flip board around
                If insetup Then Exit Sub
                If human = 2 Then '                                  2 players, disable autoflip
                    'iflag = iflag Xor 1
                    'TempMess$ = "Auto flip " + OnOff$(iflag)
                Else
                    If onplayback = 0 Then
                        invert = invert Xor 1
                        PlotScreen true
                    End If
                End If
            Case "I" '                                               identify players (correct typos!)
                NameAssign
            Case "j" '                                               examine stored FEN/reply
                FENshow
            Case "J" '                                               add FEN string & reply to repository
                If Len(FENreplyold$) Then
                    FENcount = FENcount + 1 + (FENcount = 1000)
                    FEN$(FENcount) = FENold$
                    FENreply$(FENcount) = UCase$(FENreplyold$)
                    FENwrite
                End If
                t$ = datapath$ + " fen.dat"
                Shell _DontWait editcmd$ + t$
            Case "k" '                                               superspeed toggle (no showtaken, clock, info)
                barebones = barebones Xor 1
                ocount = 0
                Buttons 0, 0
            Case "l" '                                               legend toggle: a-h at bottom, 1-8 along left
                If onplayback Or insetup Then Exit Sub
                legend = legend Xor 1
                PlotScreen true
            Case "m" '                                               markers, little boxes indicating last move
                markers = markers Xor 1
                TempMess$ = "Markers " + OnOff$(markers)
            Case "M" '                                               magnify whatever's at mouse position
                showmousepos = showmousepos Xor 1
                'If showmousepos = 0 Then debug$ = ""
            Case "n" '                                               noise toggle
                If (endgame + onplayback + ingetfile) = 0 Then
                    makenoise = makenoise Xor 1
                    LoadSounds
                    TempMess$ = "Sound " + OnOff$(makenoise)
                End If
                If (makenoise = 0) And (_SndLen(sfile(1)) > 0) Then _SndStop sfile(1)
            Case "N" '                                               algebraic/descriptive toggle
                descriptive = descriptive Xor 1
            Case "p" '                                               pause (stops clocks)
                Pause
            Case "P"
                autopause = autopause Xor 1
                TempMess$ = "Autopause " + OnOff$(autopause)
            Case "q" '                                               off in non-Dev mode lest user accidentally quit when promoting to Queen
                If ingetfile = 0 Then Quit
            Case "r" '                                               resign
                If (insetup = false) And (human <> 0) And (endgame = 0) Then abort = 2: msg$ = "Resign"
            Case "R" '                                               development mode (R for Richard)
                dev = dev Xor 1
                TempMess$ = "Dev mode " + OnOff$(dev)
                ColorSet
            Case "s" '                                               settings: colors, styles, sets, clocks, etc.
                If insetup Then Exit Sub
                If match Then
                    TempMess$ = "Unavailable in match"
                    Exit Sub
                End If
                If onplayback = false Then Settings
            Case "S" '                                               change set (10 available)
                piece_style = (piece_style + 1) Mod 10
                TempMess$ = LTrim$(Str$(piece_style + 1)) + " of 10"
                LoadPieces piece_style
                lpoints = -1
                'Case "T" '                                               time track (debugging)
                '    ttflag = ttflag Xor 1
                '    Erase time_used
                '    tel! = 0
            Case "&"
                cycle = cycle Xor 1
                TempMess$ = "Cycle info " + OnOff$(cycle)
            Case Is = "v" '                                          some silliness, Alfred E. Neuman
                If alfred < -1 Then
                    alfredon = alfredon Xor 1
                    TempMess$ = "Alfred " + OnOff$(alfredon)
                End If
            Case "W" '                                               enable writing to a R/O playback file
                readonly = false
                WriteLog false
            Case "x" '                                               play intro music
                If rickfile Then Sound 7777, 1
                PlaySound intro
            Case "X" '                                               disable move takeback
                backok = false
                TempMess$ = "Takeback " + OnOff$(backok)
            Case "z" '                                               sample of all 10 piece sets
                If rotate = 0 Then ShowSets
            Case "Z" '                                               show all 112 pictures that can be used as pieces
                If rotate = 0 Then ShowFunny
        End Select
    End If

    try2:
    If human = 0 Then '                                              maybe switch out of automatic play
        If i$ = "w" Then human = 1: humanc = 1: invert = 0: TempMess$ = "You are White"
        If i$ = "b" Then human = 1: humanc = 0: invert = 1: TempMess$ = "You are Black"
        If human Then screensaver = 0
        NameAssign
    End If

    fkeys:
    If li = 2 Then '                                                 extended key
        k = Asc(i$, 2)
        If k = 59 Then Help '                                        F1

        If (ingetfile = 0) And (k = 60) Or (k = 61) Then
            If k = 60 Then '                                         F2 next set
                piece_style = piece_style - 1
                If piece_style < 0 Then piece_style = 9
            End If

            If k = 61 Then '                                         F3 previous set
                piece_style = piece_style + 1
                If piece_style > 9 Then piece_style = 0
            End If

            TempMess$ = LTrim$(Str$(piece_style + 1)) + " of 10"
            AboveBoardInfo
            DisplayMaster true
            LoadPieces piece_style
            lpoints = -1
        End If

        If (k = 62) Or (k = 63) Then
            wasbri = bri
            bri = bri + (k = 62) - (bri = 1) '                       F4 brightness down
            bri = bri - (k = 63) + (bri = 4) '                       F5 brightness up
            TempMess$ = "Brightness:" + Str$(bri) + " of 4"
            If bri <> wasbri Then
                ColorSet
                Erase sloaded
                allsetsloaded = false
                LoadPieces piece_style
                lpoints = -1
            End If
        End If

        If k = 133 Then rotate = rotate - 1 - (rotate = 0) * 4 '     F11, rotate left
        If k = 134 Then rotate = (rotate + 1) Mod 4 '                F12, rotate right

        ud = (k = 81) - (k = 73) '                                   PgUp/PgDn to up/down
        If ud Then '                                                 -1 or 1
            For i = 1 To 10
                svol(i) = Int(svol(i)) + ud '                        0.1, 1 to 10
                If svol(i) < 1 Then svol(i) = .1 '                   barely audible
                If svol(i) > 10 Then svol(i) = 10
            Next i
            PlaySound sfile(1) '                                     play something to demonstrate volume change
            TempMess$ = "Volume" + Str$(svol(10)) + " of 10" '       show new volume
        End If
    End If

    kend:
    'TimeTrack "KeyScan", 0
End Sub

Function Left5$ (t$)
    Left5$ = Left$(t$ + Space$(5), 5)
End Function

Function Left6$ (t$)
    Left6$ = Left$(t$ + Space$(6), 6)
End Function

Sub LoadFont '                                                       currently only Liberati
    Dim fsize, tsize, fs2, flf

    f$ = datapath$ + "fonts" + slash + "liberati.ttf"
    FileCheck
    Restore fontflags
    For fsize = 8 To 21
        Read fs2, flf
        If fs2 <> fsize Then QuitWithError "loadfont", Str$(fsize)
        If flf = 0 Then _Continue
        If fsize = 21 Then tsize = 32 Else tsize = fsize
        myfont(tsize) = _LoadFont(f$, tsize)
        If myfont(tsize) < 1 Then QuitWithError f$, Str$(tsize)
    Next fsize
    defaultfontsize = 12

    fontflags:
    Data 8,1
    Data 9,1
    Data 10,1
    Data 11,1
    Data 12,1
    Data 13,0
    Data 14,1
    Data 15,0
    Data 16,1
    Data 17,0
    Data 18,1
    Data 19,0
    Data 20,0
    Data 21,1

End Sub

Sub LoadPieces (set As _Byte)
    Dim As _Byte c, i, j, k, p
    Dim x, y, tscreen, tpath$, f$, t$

    If sloaded(set) Then Exit Sub
    tscreen = _CopyImage(0)

    Select Case set
        Case 0 '                                                     funny set - Mel Brooks, Chuck Norris, etc.
            For i = 1 To 12
                j = (i - 1) + (i > 6) * 6
                k = i - (i > 6) * 2
                piecef$(k) = RTrim$(Mid$("rook  knightbishopqueen king  pawn  ", j * 6 + 1, 6))
                f$ = datapath$ + "sfunny" + slash + piecef$(k) + LTrim$(Str$(piecefn(k))) + ".jpg"
                If pix(0, k) < -1 Then _FreeImage (pix(0, k))
                pix(0, k) = _LoadImage(f$)
                BrightnessAdjust 0, k
            Next i
        Case 1
            For c = 0 To 1
                Restore PiecePatterns '                              first set I used - ugly IMO
                For p = 1 To 6 '                                     piece, RNBQKP
                    Cls , zip
                    For y = 1 To 43 '                                43 rows
                        Read t$
                        For x = 1 To 48
                            If Mid$(t$, x, 1) <> " " Then PSet (x, y + 3), cp(7 - Val(Mid$(t$, x, 1)) - c * 2)
                        Next x
                    Next y
                    i = p + c * 8
                    If pix(1, i) < -1 Then _FreeImage (pix(1, i))
                    pix(1, i) = _NewImage(48, 48, 32)
                    _PutImage , 0, pix(1, i), (0, 0)-(49, 49)
                    BrightnessAdjust set, i
                Next p
            Next c
        Case Else '                                                  sets I found on GitHub
            tpath$ = datapath$ + "s" + CHRN$(set) + slash
            For i = 1 To 12
                If i < 7 Then t$ = "_b" Else t$ = "_w"
                t$ = Mid$("rnbqkprnbqkp", i, 1) + t$
                f$ = tpath$ + t$ + ".png"
                j = i - (i > 6) * 2
                If pix(set, j) < -1 Then _FreeImage (pix(set, j))
                pix(set, j) = _LoadImage(f$)
                If pix(set, j) >= -1 Then QuitWithError "File", f$
                BrightnessAdjust set, j
            Next i
    End Select

    _PutImage , tscreen, 0
    _FreeImage tscreen
    'NoChangeUntil = ExtendedTimer + 2
    sloaded(set) = true

    PiecePatterns: '                                                 original set I used - ugly
    '              1         2         3         4
    '     123456789012345678901234567890123456789012345678
    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "        22111122221111222211112222111122        "
    Data "        22111122221111222211112222111122        "
    Data "        22111122221111222211112222111122        "
    Data "        22111122221111222211112222111122        "
    Data "        22111122221111222211112222111122        "
    Data "        22111122221111222211112222111122        "
    Data "        22111122221111222211112222111122        "
    Data "        22111122221111222211111222211112        "
    Data "        22111122221111222211112222111122        "
    Data "        22211122221111222211112222111222        "
    Data "           22112221111222211112221122           "
    Data "           21122221111222211112222112           "
    Data "            222222222222222222222222            "
    Data "            222222222222222222222222            "
    Data "         221111111111111111111111111122         "
    Data "         221111111111111111111111111122         "
    Data "         221111122222222222222221111122         "
    Data "            221122222222222222221122            "
    Data "            221122222222222222221122            "
    Data "            221122222222222222221122            "
    Data "            221122222222222222221122            "
    Data "            221122222222222222221122            "
    Data "            221122222222222222221122            "
    Data "           22211222222222222222211222           "
    Data "          2211111111111111111111111122          "
    Data "          2211111111111111111111111122          "
    Data "          2211112222222222222222111122          "
    Data "         222111122222222222222221111222         "
    Data "        22111111111111111111111111111122        "
    Data "       2221111111111111111111111111111222       "
    Data "      221111222222222222222222222222111122      "
    Data "      221111222222222222222222222222111122      "
    Data "      221111111111111111111111111111111122      "
    Data "      221111111111111111111111111111111122      "
    Data "      222222222222222222222222222222222222      "
    Data "      222222222222222222222222222222222222      "

    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                       2222222                  "
    Data "                      22222222                  "
    Data "                    222211221122                "
    Data "                   22222112211222               "
    Data "                  221111221122112222            "
    Data "                 22211112211221122222           "
    Data "                2211221122221122111122          "
    Data "               222112211222211221111222         "
    Data "              22112222222211221122111122        "
    Data "              22112222222211221122111122        "
    Data "             22211222111112222221122111122      "
    Data "            222211221111122222221122111122      "
    Data "           2111122222111221122222211221122      "
    Data "          22111122222112221122222211221122      "
    Data "        221122222222222222112222221122111122    "
    Data "       2221122222222222222112222221122111122    "
    Data "      22112222222222221122111122221122111122    "
    Data "      22112222222222221122111122221122111122    "
    Data "      22112222111122222211221122221122111122    "
    Data "      22112222111122222211221122221122111122    "
    Data "       2221111222222221111221122221122111122    "
    Data "        221111222222221111221122221122111122    "
    Data "          2222111122111122112222221122111122    "
    Data "          2222111122111122112222221122111122    "
    Data "                22111122221122221122221122      "
    Data "                22111122221122221122221122      "
    Data "              22111122221122221122221122        "
    Data "              22111122221122221122221122        "
    Data "            2222222222222222222222222222        "
    Data "            2222222222222222222222222222        "
    Data "          22111111111111111111111111111122      "
    Data "         2221111111111111111111111111111222     "
    Data "        221111111111111111111111111111111122    "
    Data "        221111111111111111111111111111111122    "
    Data "         2222222222222222222222222222222222     "
    Data "          22222222222222222222222222222222      "

    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                        22                      "
    Data "                        22                      "
    Data "                      211222                    "
    Data "                      121122                    "
    Data "                    1222211221                  "
    Data "                  21122222112221                "
    Data "                122211222221122221              "
    Data "               11222211222221122221             "
    Data "              1211222211222221122221            "
    Data "              1221122221122222112221            "
    Data "              1222112222112222211221            "
    Data "              1222211222211222221121            "
    Data "              1222221122221122221121            "
    Data "               12222211222211222221             "
    Data "                112222112222112221              "
    Data "                211222211222211221              "
    Data "              2222112222112222112222            "
    Data "             222222112222112222112222           "
    Data "           2211111111111111111111111122         "
    Data "           2211111111111111111111111122         "
    Data "           2222222222222112222222222222         "
    Data "             222222222221122222222222           "
    Data "                222222221122222222              "
    Data "                222222221122222222              "
    Data "              2211222222112222221122            "
    Data "              2211222222112222221122            "
    Data "              2211222222112222221122            "
    Data "             221122222221122222221122           "
    Data "            22112211111111111111221122          "
    Data "           2211222111111111111112221122         "
    Data "          221122222222221122222222221122        "
    Data "          221122222222221122222222221122        "
    Data "          221122222222221122222222221122        "
    Data "          221122222222221122222222221122        "
    Data "          221111111111111111111111111122        "
    Data "          221111111111111111111111111122        "
    Data "            22222222222222222222222222          "
    Data "            22222222222222222222222222          "

    Data "                        22                      "
    Data "                      221122                    "
    Data "                      221122                    "
    Data "          221111111122112211221111111122        "
    Data "         22211111111221122112211111111222       "
    Data "        2211221122221122222211112211221122      "
    Data "       222112211222211222222111122112211222     "
    Data "      22112211221111222211222222112211221122    "
    Data "      22112211221111222211222222112211221122    "
    Data "      22112222112222221122112222221122221122    "
    Data "      22112222112222221122112222221122221122    "
    Data "      22112222221122112222221122112222221122    "
    Data "      22112222221122112222221122112222221122    "
    Data "      22112222222211222222222211222222221122    "
    Data "      22112222222211222222222211222222221122    "
    Data "       221122222222222222222222222222221222     "
    Data "        22112222222222222222222222222211222     "
    Data "         222112222222222222222222222112222      "
    Data "          2211222222222222222222222211222       "
    Data "          221111111111111111111111111122        "
    Data "          221111111111111111111111111122        "
    Data "            22222222222222222222222222          "
    Data "            22222222222222222222222222          "
    Data "        2211111111111111111111111111111122      "
    Data "        2211111111111111111111111111111122      "
    Data "            22221122222222222222112222          "
    Data "            22221122222222222222112222          "
    Data "              2211221122222211221122            "
    Data "              2211221122222211221122            "
    Data "            22112222112222221122221122          "
    Data "            22112222112222221122221122          "
    Data "            22112222112222221122221122          "
    Data "            22112222112222221122221122          "
    Data "          222222222222222222222222222222        "
    Data "         22222222222222222222222222222222       "
    Data "        2211111111111111111111111111111122      "
    Data "       222111111111111111111111111111111222     "
    Data "      22211122221122221122221122221122111222    "
    Data "      22211122221122221122221122221122111222    "
    Data "      22211111111111111111111111111111111222    "
    Data "      22211111111111111111111111111111111222    "
    Data "       222222222222222222222222222222222222     "
    Data "        2222222222222222222222222222222222      "

    Data "                      2222                      "
    Data "                  222211112222                  "
    Data "                 22222111122222                 "
    Data "              22221122111122112222              "
    Data "             2222222221111122222222             "
    Data "           22211221111111111112211222           "
    Data "          2211212211111111111122211222          "
    Data "        22211222221122111122112222211222        "
    Data "       2221122222211221111221122222211222       "
    Data "      221122222222222211112222222222211222      "
    Data "     22211222222222222111122222222222211222     "
    Data "    2211222222222111111111111112222222221122    "
    Data "   221122222222211111111111111112222222211222   "
    Data "  22211222222211222222111122222211222222221122  "
    Data " 2221122222221122222221111222222211222222211222 "
    Data "222112222222112222222211112222222112222222211222"
    Data "222122222222112222222211112222222111222222211222"
    Data "221122222222112222222211112222222211222222221122"
    Data "221122222222112222222211112222222211222222221122"
    Data "221122222222112222222211112222222211222222221122"
    Data "221122222222112222222211112222222211222222221122"
    Data "221122222222111122222222222222221111222222221122"
    Data "221122222222211122222222222222221112222222221122"
    Data " 2221122222222111122222222222211112222222211222 "
    Data "  22112222222211112222222222221111222222221122  "
    Data "  22111122222221111222222222211112222222111122  "
    Data "  22111122222222111122222222111122222222111122  "
    Data "   222111122222222111111111111222222221111222   "
    Data "    2221111222222211111111111122222221111222    "
    Data "     22211111111221111111111112211111111222     "
    Data "      222111111122111111111111221111111222      "
    Data "      222222222222222222222222222222222222      "
    Data "      222222222222222222222222222222222222      "
    Data "    2211111111111111111111111111111111111122    "
    Data "    2211111111111111111111111111111111111122    "
    Data "  22111222222222222222222222222222222222211122  "
    Data "  22111222222222222222222222222222222222211122  "
    Data "  22111222222222222222222222222222222222211122  "
    Data "  22111222222222222222222222222222222222211122  "
    Data "   222111111111111111111111111111111111111222   "
    Data "    2211111111111111111111111111111111111122    "
    Data "     22222222222222222222222222222222222222     "
    Data "      222222222222222222222222222222222222      "

    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                                                "
    Data "                    22222222                    "
    Data "                   2222222222                   "
    Data "                  221111111122                  "
    Data "                 22211111111222                 "
    Data "                2211222222221122                "
    Data "                2211222222221122                "
    Data "                2211222222221122                "
    Data "                2211222222221122                "
    Data "                  221111111122                  "
    Data "                  221111111122                  "
    Data "                2222222222222222                "
    Data "               222222222222222222               "
    Data "              22111111111111111122              "
    Data "              22111111111111111122              "
    Data "               222222222222222222               "
    Data "                2222222222222222                "
    Data "                  221122221122                  "
    Data "                  221122221122                  "
    Data "                  221122221122                  "
    Data "                  221122221122                  "
    Data "                  221122221122                  "
    Data "                  221122221122                  "
    Data "                2211222222221122                "
    Data "               221122222222221122               "
    Data "              22112222222222221122              "
    Data "             2211222222222222221122             "
    Data "            221122222222222222221122            "
    Data "            221122222222222222221122            "
    Data "            221122222222222222221122            "
    Data "            221122222222222222221122            "
    Data "            211111111111111111111112            "
    Data "            211111111111111111111112            "
    Data "            222222222222222222222222            "
    Data "            222222222222222222222222            "
    Data "                                                "
    Data "                                                "
End Sub

Sub LoadSounds
    Dim i, g$, sf$

    sound_data: '                                                        desc,volume,file
    Data " 1 intro     ",2,"cf.mp3"
    Data " 2 click1    ",2,"pegup.wav"
    Data " 3 click2    ",2,"pegdown.wav"
    Data " 4 mdone     ",3,"blow.wav"
    Data " 5 take back ",7,"airhorn.wav"
    Data " 6 check     ",3,"chord.wav"
    Data " 7 checkmate ",3,"tada.wav"
    Data " 8 stalemate ",3,"ce.wav"
    Data " 9 promotion ",3,"notif.mp3"
    Data "10 error     ",3,"bad.wav"
    Data "11 resign    ",3,"ce.wav"

    If soundloaded Then Exit Sub Else soundloaded = true

    If pregame = 0 Then
        TempMess$ = "Loading sound..."
        AboveBoardInfo
        _Display
    End If

    Restore sound_data
    For i = 1 To 11 '                                                       intro music, mouse clicks, checkmate, etc.
        Read g$, svol(i), sf$ '                                             garbage, volume, filename
        If (i = 1) And (no_intro_music = true) Then sf$ = ""
        If Len(sf$) Then '                                                  null means I decided to use no sound for this item
            f$ = datapath$ + "sounds" + slash$ + sf$ '                      sound file, datapath$ = _CWD$ + slash + "chessdat" + slash
            FileCheck
            sfile(i) = _SndOpen(f$)
            If sfile(i) <= 0 Then QuitWithError "Sound file", f$
        End If
    Next i
    'NoChangeUntil = ExtendedTimer + 1
End Sub

Sub Magnify '                                                        magnifying glass top left, fo verifying shadows (debugging)
    Dim x, y, x0, x2, y2, t$

    x0 = ((rotate = 1) Or (rotate = 3)) * -300
    For y = 0 To 40
        For x = 0 To 40
            x2 = mx + x - 20
            y2 = my + y - 20
            If (x2 > -1) And (y2 > -1) And (x2 < _Width) And (y2 < _Height) Then
                c1 = Point(x2, y2)
                Line (x0 + x * 4 + 1, y * 4 + 1)-Step(3, 3), c1, BF
            End If
        Next x
    Next y
    SetFont 16
    ShadowPrint x0 + 4, 4, Str$(ux) + Str$(uy) + Str$(mx) + Str$(my), white
    c1 = Point(mx, my)
    t$ = Str$(_Red32(c1)) + Str$(_Green32(c1)) + Str$(_Blue32(c1)) + Str$(_Alpha32(c1))
    ShadowPrint x0 + 4, 24, t$, white
End Sub

Sub MarkerSave (fc As _Byte, fr As _Byte, tc As _Byte, tr As _Byte)
    markerfc = Abs(fc)
    markerfr = Abs(fr)
    markertc = tc
    markertr = tr
End Sub

Sub MouseIn
    Static lx, ly
    Dim As _Byte i, sa, zz
    Dim tx1, tx2, ty1, ty2, t$
    Dim cb As _Unsigned Long

    'TimeTrack "MouseIn", 1
    If nbox > 50 Then QuitWithError "MouseIn", "nbox > 50"
    If rickfile Then Alarms '                                        personal feature

    If _Resize Then
        fullscreenflag = fullscreenflag Xor 1
        ScreenInit
        cursoron = ExtendedTimer + 2
        lostfocus = true
    End If

    If _Exit <> 0 Then Quit

    While _WindowHasFocus = 0
        _Delay .25
        lostfocus = true
        'TimeTrack "MouseIn", 0
        DisplayMaster false
        Exit Sub
    Wend

    If lostfocus Then
        ClearBuffers
        lostfocus = false
    End If

    If _MouseInput Then
        If (_MouseButton(1) = b1) Or (_MouseButton(2) = b2) Then
            Do While _MouseInput
                If _MouseButton(1) <> b1 Then Exit Do
                If _MouseButton(2) <> b2 Then Exit Do
            Loop
        End If
        b1 = _MouseButton(1)
        b2 = _MouseButton(2)
        ux = _MouseX
        uy = _MouseY
        If usd Then ux = _Width - ux: uy = _Height - uy
    End If

    Select Case rotate
        Case 0
            mx = ux
            my = uy
        Case 1
            mx = tlx + uy / _Height * (trx - tlx)
            If _FullScreen Then my = 700 - ux Else my = 600 - ux / 1.33
        Case 2
            mx = _Width - ux
            my = _Height - uy
        Case 3
            mx = trx - uy / _Height * (trx - tlx)
            If _FullScreen Then my = ux - 100 Else my = ux / 1.33
    End Select

    If click And (b1 Or b2) Then
        If (ExtendedTimer - lastclick) < .2 Then b1 = 0: b2 = 0: Exit Sub
        PlaySound click1
        lastclick = ExtendedTimer
    End If
    If pregame And i$ = Enter$ Then b1 = true

    If b1 Or b2 Or (Abs(mx - lx) > 2) Or (my <> ly) Then
        mousemovedat = ExtendedTimer
    End If
    lx = mx
    ly = my

    If fullscreenflag Then sa = 1 Else sa = 5 '                      help/min/max/exit not onscreen

    For i = sa To nbox '                                             start at to number boxes

        If promoting And (InStr("It", mft$(i)) > 0) Then _Continue

        tx1 = mfx1(i)
        tx2 = mfx2(i)
        ty1 = mfy1(i) + (mfy1(i) = 247) * 24
        ty2 = mfy2(i) - (mfy1(i) = 247) * 16

        cb = 0
        If (mx >= tx1) And (mx <= tx2) And (my >= ty1) And (my <= ty2) Then

            If mft$(i) = "k" Then
                TempMess$ = "Bare bones"
                ShowBolt
            End If

            If promoting And (InStr("rnbq", LCase$(mft$(i))) > 0) Then Line (tx1, ty1)-(tx2, ty2), white, B

            'If rickfile Then
            '    Line (tx1, ty1)-(tx2, ty2), yellow, B
            '    Color yellow
            '    SetFont 12
            '    _PrintString (tx1, ty1 - 12), "*" + mft$(i) + "*" + Str$(i)
            '    _Display
            'End If

            If mft$(i) = "`" Then '                                  style
                SetFont 9
                t$ = RTrim$(Mid$("PreviousNext    ", 1 - (mx > midway) * 8, 8))
                ShadowPrint midway - _PrintWidth(t$) / 2, _Height - 30, t$, white
            End If

            If i < 5 Then cb = _RGB32(255, 255, 255) '               higlight help/min/resize/quit

            If (insettings = 0) And (mfy1(i) = 247) Then '           main menu
                If clockc = black Then c1 = white Else c1 = clockc
                Line (tx1, mfy2(i))-(tx2, mfy2(i)), c1 '             underline where mouse is
            End If

            If b1 Or b2 Then '                                       left or right mouse button
                i$ = ""
                b1 = false '                                         reset left
                b2 = false '                                         reset right
                Select Case i
                    Case 1 '                                         play a Beatles song
                        Help
                    Case 2 '                                         minimize
                        _ScreenIcon '                                invoke a movie star like Audrey Hepburn
                        Do
                            _Delay 1
                        Loop Until _ScreenIcon = false
                        _ScreenShow
                        lostfocus = true
                        _ScreenClick _DesktopWidth \ 2, _DesktopHeight \ 2
                    Case 3 '                                                     maximize
                        fullscreenflag = Sgn(fullscreenflag) Xor 1
                        ScreenInit
                    Case 4 '                                                     local X for exit
                        Quit
                    Case Else '                                                  some word selected
                        If mft$(i) = "Alg" Then oply = false: descriptive = false
                        If mft$(i) = "Des" Then oply = false: descriptive = true
                        If mft$(i) = "hup" Then '                                history up
                            For zz = 1 To 10
                                If (shia + move - 48) > 0 Then shia = shia - 1: oply = false
                            Next zz
                        End If
                        If mft$(i) = "hdo" Then shia = shia + 10: oply = false 'history down
                        If shia > 0 Then shia = 0
                        istuff$ = mft$(i)

                        If LCase$(Left$(istuff$, 2)) = "sp" Then '               slide speed
                            fast = Val(Mid$(istuff$, 3, 1))
                        End If

                        If LCase$(Left$(istuff$, 2)) = "sr" Then '               show on right
                            showright = Val(Mid$(istuff$, 3, 1))
                            dosmallboard = -(showright = 1)
                            showthinkingf = (showright = 2)
                            oply = -1
                        End If

                        If istuff$ = "e" Then
                            If ingetnames Then
                            ElseIf onplayback Then
                                istuff$ = Enter$
                            Else
                                istuff$ = Esc$
                            End If
                        End If

                        If usd Then Exit Sub

                        If istuff$ = "k" Then
                            _Source bolt(barebones)
                            For ty1 = 0 To 30
                                For tx1 = 0 To 30
                                    c1 = Point(tx1, ty1)
                                    'If (_Green32(c1) < 255) And (c1 <> cc(barebones)) Then ' inverts only bolt
                                    If c1 <> cc(barebones) Then
                                        c1 = _RGB32(255 - _Red32(c1), 255 - _Green32(c1), 255 - _Blue32(c1))
                                        PSet (boltx1 + tx1, bolty1 + ty1), c1
                                    End If
                                Next tx1
                            Next ty1
                            _Source 0
                            DisplayMaster true
                            _Delay .2
                            Exit Sub
                        End If

                        t$ = istuff$ + " "
                        If (rotate = 0) And ((istuff$ = Enter$) Or (istuff$ = "`") Or (t$ <> UCase$(t$))) Then
                            For zz = 0 To 1
                                For ty1 = mfy1(i) To mfy2(i)
                                    For tx1 = mfx1(i) To mfx2(i)
                                        c1 = Point(tx1, ty1)
                                        c2 = _RGB32(255 - _Red32(c1), 255 - _Green32(c1), 255 - _Blue32(c1))
                                        If mft$(i) = "`" Then
                                            If c1 <> menubg Then PSet (tx1, ty1), c2
                                        Else
                                            If (c1 <> menubg) Or (Len(mft$(i)) = 1) Then PSet (tx1, ty1), c2
                                        End If
                                    Next tx1
                                Next ty1
                                DisplayMaster true
                                If zz = 0 Then _Delay .2
                            Next zz
                        End If
                        If istuff$ = "Graph" Then istuff$ = "G"
                End Select
            End If
        End If

        If i < 5 Then Buttons cb, i
    Next i

    DisplayMaster true
    'TimeTrack "MouseIn", 0
End Sub

Sub MoveIt (zfc As _Byte, zfr As _Byte, ztc As _Byte, ztr As _Byte)
    Dim As _Byte pm, fc, fr, tc, tr

    fc = Abs(zfc) '                                                  from column, negative means castle kingside
    fr = Abs(zfr) '                                                  from row, negative means castle queenside
    tc = ztc
    tr = ztr
    pm = b(fc, fr) '                                                 piece at board location (1-12)
    p = pm And 7 '                                                   type of piece (1-6)

    If (p = Pawn) And (b(tc, tr) = 0) And (fc <> tc) Then b(tc, fr) = 0 ' en passant

    b(fc, fr) = 0 '                                                  blank old array spot
    b(tc, tr) = pm '                                                 move piece in array

    If zfc < 0 Then '                                                castle kingside
        If WorB = 1 Then '                                           white
            fc = 8: fr = 1: tc = 6: tr = 1 '                         rook move
        Else '                                                       black
            fc = 8: fr = 8: tc = 6: tr = 8 '                         rook move
        End If
        b(tc, tr) = Rook + WorB * 8 '                                move piece in array
        b(fc, fr) = 0 '                                              blank old array spot
    End If

    If zfr < 0 Then '                                                castle queenside
        If WorB = 1 Then '                                           white
            fc = 1: fr = 1: tc = 4: tr = 1 '                         rook move
        Else '                                                       black
            fc = 1: fr = 8: tc = 4: tr = 8 '                         rook move
        End If
        b(tc, tr) = Rook + WorB * 8 '                                move piece in array
        b(fc, fr) = 0 '                                              blank old array spot
    End If

    If (p = Pawn) And ((tr = 1) Or (tr = 8)) Then '                  pawn, row 1 or 8
        If (human = 0) Or ((human = 1) And (WorB <> humanc)) Then '  computer side always promote to Queen
            b(tc, tr) = Queen + WorB * 8
        End If
    End If
End Sub

Sub MoveItReal (zfc As _Byte, zfr As _Byte, ztc As _Byte, ztr As _Byte)
    Dim mi, x, y
    Dim As _Byte i, pm, xs, ys, npass, pass, selected, fc, fr, tc, tr, cap

    fc = Abs(zfc) '                                                  from column, negative means castle kingside
    fr = Abs(zfr) '                                                  from row, negative means castle queenside
    tc = ztc '                                                       to column
    tr = ztr '                                                       to row
    pm = b(fc, fr) '                                                 piece at board location (1-12)
    p = pm And 7 '                                                   type of piece (1-6)
    cap = b(tc, tr) '                                                piece being captured, if any
    If cap > 0 Then ptaken = -cap: ptakent = ExtendedTimer + 12: ptcc = 0
    DescriptiveNotation 0, zfc, zfr, ztc, ztr
    If (cap And 7) = King Then QuitWithError "ERROR", "King capture"
    If (p = Pawn) And (b(tc, tr) = 0) And (fc <> tc) Then '          en passant
        If onplayback = 0 Then PlotPiece fc, fr, tc, tr
        b(fc, fr) = 0 '                                              clear from square
        ptaken = -b(tc, fr): ptakent = ExtendedTimer + 12: ptcc = 0
        b(tc, fr) = 0 '                                              clear captured pawn
        b(tc, tr) = Pawn + WorB * 8 '                                place pawn at new location
        GoTo wrapitup
    End If

    npass = 1 '                                                      normal move
    cflag = 0 '                                                      flag off
    If p = King Then '                                               castling?
        If (zfc < 0) Then npass = 2: cflag = 1 '                     yes, kingside
        If (zfr < 0) Then npass = 2: cflag = 2 '                     yes, queenside
    End If

    For pass = 1 To npass

        If cflag = -1 Then '                                         castle kingside
            If WorB = 1 Then '                                       white
                fc = 8: fr = 1: tc = 6: tr = 1 '                     rook move
            Else '                                                   black
                fc = 8: fr = 8: tc = 6: tr = 8 '                     rook move
            End If
        End If
        If cflag = -2 Then '                                         castle queenside
            If WorB = 1 Then '                                       white
                fc = 1: fr = 1: tc = 4: tr = 1 '                     rook move
            Else '                                                   black
                fc = 1: fr = 8: tc = 4: tr = 8 '                     rook move
            End If
        End If
        If pass = 2 Then pm = Rook + WorB * 8

        If onplayback = 0 Then
            If (p = Pawn) And ((tr = 1) Or (tr = 8)) Then '          pawn, row 1 or 8
                If match Or (human = 0) Or ((human = 1) And (WorB <> humanc)) Or screensaver Then ' computer side always promote to Queen
                    pm = Queen + WorB * 8
                    promote$ = "Q"
                Else '                                               ask human
                    PlaySound promotion
                    promoting = true
                    b(tc, tr) = pm '                                 move piece in array
                    b(fc, fr) = 0 '                                  blank old array spot
                    _MemCopy m(0), m(0).OFFSET, m(0).SIZE To m(10), m(10).OFFSET ' copy working b() to display board b2()

                    Do: _Limit mloop
                        TempMess$ = "Choose piece"
                        PlotScreen false
                        nbox = 4
                        chimp = 0
                        Center 0, " promote to  Q  R  B  N ", true, false
                        GoSub piece_menu
                        KeyScan
                        If Len(i$) = 1 Then selected = InStr("rnbq", LCase$(i$))
                    Loop Until selected > 0
                    promoting = false
                    pm = selected + WorB * 8
                End If
                promote$ = Mid$("RNBQ", pm And 7, 1)
            End If

            If p = King Then Mid$(castle$, WorB * 2 + 1, 2) = "XX" ' no more castling for this side
            If p = Rook Then
                If WorB Then
                    If (fc = 1) And (fr = 1) Then Mid$(castle$, 3, 1) = "X" '  white queenside
                    If (fc = 8) And (fr = 1) Then Mid$(castle$, 4, 1) = "X" '  white kingside
                Else
                    If (fc = 1) And (fr = 8) Then Mid$(castle$, 1, 1) = "X" '  black queenside
                    If (fc = 8) And (fr = 8) Then Mid$(castle$, 2, 1) = "X" '  black kingside
                End If
            End If
            If (pass = 1) And ((human And (humanc = WorB)) Or (human = 2)) Then ' 2 is two humans
            Else
                PlotPiece fc, fr, tc, tr
            End If
        End If

        b(tc, tr) = pm '                                             move piece in array
        b(fc, fr) = 0 '                                              blank old array spot
        cflag = -cflag
        _MemCopy m(0), m(0).OFFSET, m(0).SIZE To m(10), m(10).OFFSET ' working b() to display board b2()
    Next pass

    wrapitup:
    lfc = fc: lfr = fr: ltc = tc: ltr = tr '                         save last move for en passant
    If (cap > 0) Or (p = Pawn) Then drawcount = 0 Else drawcount = drawcount + WorB
    _MemCopy m(0), m(0).OFFSET, m(0).SIZE To m(10), m(10).OFFSET '   working b() to display board b2()
    epsq$ = "-" '                                                    for FENmake
    If (p = Pawn) And (fc <> tc) And (Abs(fr - tr) > 1) Then epsq$ = alphal$(fc) + CHRN$(fr + Sgn(tr - fr))
    FENmake
    TakeBackPush '                                                   save board & castle state

    perpetual = 0 '                                                  check for perpetual
    For mi = 1 To FENpcount - 1
        perpetual = perpetual - (FENpartial$ = FENperp$(mi))
    Next mi
    Exit Sub

    piece_menu:
    xs = 64: ys = xs '                                               size of pieces shown here
    For i = 1 To 4 '                                                 QRBN
        p = Val(Mid$("4132", i, 1)) + WorB * 8
        x = xc + (i - 3) * (xs + 2)
        y = bly + 30
        _PutImage (x, y)-(x + xs, y + ys), pix(piece_style, p), 0 '  show piece
        nbox = nbox + 1
        mft$(nbox) = Mid$("qrbn", i, 1)
        mfx1(nbox) = x '                                             save location so mouse can find it
        mfx2(nbox) = x + xs '
        mfy1(nbox) = y '
        mfy2(nbox) = y + ys '
    Next i
    Return
End Sub

Sub MoveBishop (level As _Byte)
    Dim As _Byte capture, n, square, tc, tr, tp
    Dim score, startscore, tts

    'TimeTrack "MoveBishop", 1

    If move < 10 Then startscore = -18 * (b(fc, fr) = o(fc, fr)) '   priority to getting a piece first moved

    Do
        tc = fc '                                                    to column
        tr = fr '                                                    to row
        square = 1
        Do
            capture = 0 '                                            what piece captured
            score = startscore
            tc = tc - dl(Bishop, n) + dr(Bishop, n) '                column=column-left+right
            If (tc < 1) Or (tc > 8) Then Exit Do '                   off board
            tr = tr - du(Bishop, n) + dd(Bishop, n) '                row=row-up+down
            If (tr < 1) Or (tr > 8) Then Exit Do '                   off board
            tp = b(tc, tr)
            If tp = 0 Then '                                         empty square
                score = score - (o(tc, tr) = tp) * rto '             return to origin usually bad
            ElseIf WorB = Sgn(tp And 8) Then '                       beer buddies
                'protc(level) = protc(level) + value(tp)
                Exit Do '                                            can't move to or past own piece
            Else '                                                   opponent piece, possible capture
                capture = tp '                                       capture piece
                score = value(capture) '                             bishops worth a bit more than knights
                'attackc(level) = attackc(level) + score
                If score = 32 Then '                                 pawn value according to rank
                    If (tr = 1) Or (tr = 8) Then
                        score = value(Queen)
                    Else
                        tts = (9 - tr) * WorB - tr * (WorB = 0)
                        score = tts * tts
                    End If
                End If
            End If

            If score <> 777 Then '                                             don't mess with checkmate score

                score = score - (points < -2) * (capture > 0) * 10 '           more than 2 points behind, discount trades
                score = score - Sgn((fr - tr) * pawndir) * (move < 12) '      bonus for moving ahead at beginning
                score = score - rto * (b(fc, fr) = o(tc, tr)) '                moving back to original square usually bad

                ' moving towards other king
                't1 = (ABS(fc - bkc) + ABS(fr - bkr)) * WorB - (ABS(fc - wkc) + ABS(fr - wkr)) * (WorB = 0)
                't2 = (ABS(tc - bkc) + ABS(tr - bkr)) * WorB - (ABS(tc - wkc) + ABS(tr - wkr)) * (WorB = 0)
                'score = score + (t1 - t2) * 2

            End If

            AddMove level, score, fc, fr, tc, tr

            If capture Then Exit Do
            square = square + 1
        Loop Until square > 7
        n = n + 1
    Loop Until n = 4
    'TimeTrack "MoveBishop", 0
End Sub

Sub MoveKing (level As _Byte)
    Dim As _Byte t1, t2, t3, t4, n, tc, tr, dis_to_k, dis_to_p, tp
    Dim score, tts

    'TimeTrack "MoveKing", 1

    n = -1
    Do
        score = (move < 15) * 20
        n = n + 1
        tc = fc - dl(King, n) + dr(King, n) '                                column=column-left+right
        If (tc < 1) Or (tc > 8) Then _Continue '                             off board
        tr = fr - du(King, n) + dd(King, n) '                                row=row-up+down
        If (tr < 1) Or (tr > 8) Then _Continue '                             off board
        If (WorB = 1) And (Abs(tr - bkr) < 2) And (Abs(tc - bkc) < 2) Then _Continue '  moving too close to opponent king
        If (WorB = 0) And (Abs(tr - wkr) < 2) And (Abs(tc - wkc) < 2) Then _Continue '  moving too close to opponent king
        tp = b(tc, tr)
        If tp = 0 Then '                                                     blank square, will be added
            score = score + (move < 16) * 24 '                               discourage early King moves
        ElseIf WorB = Sgn(tp And 8) Then '                                   beer buddy
            'protc(level) = protc(level) + value(tp)
            _Continue
        Else '                                                               opponent piece, possible capture
            'attackc(level) = attackc(level) + value(tp)
            score = score + value(tp) '                                      bishops worth a bit more than knights
            If value(tp) = 32 Then '                                         pawn value according to rank
                If (tr = 1) Or (tr = 8) Then
                    score = value(Queen)
                Else
                    tts = (9 - tr) * WorB - tr * (WorB = 0)
                    score = tts * tts '                                      yes, squared
                End If
            End If
        End If

        score = score - ksv(tc, tr) * ((level = 1) And (CanMove(1) = 1))

        If level = 0 Then
            If (CanMove(0) + CanMove(1) < 4) Then
                If WorB Then '                                               white
                    t1 = Abs(fc - bkc) + Abs(fr - bkr) '                     (from column - King column) + (from row - King row)
                    t2 = Abs(tc - bkc) + Abs(tr - bkr) '                     (  to column - King column) + (  to row - King row)
                    t3 = Abs(fc - bpc) + Abs(fr - bpr) '                                  - black pawn
                    t4 = Abs(tc - bpc) + Abs(tr - bpr)
                Else '                                                       black
                    t1 = Abs(fc - wkc) + Abs(fr - wkr)
                    t2 = Abs(tc - wkc) + Abs(tr - wkr)
                    t3 = Abs(fc - wpc) + Abs(fr - wpr)
                    t4 = Abs(tc - wpc) + Abs(tr - wpr)
                End If
                dis_to_k = t1 - t2
                dis_to_p = t3 - t4
                If (WorB = 0) And (wpc > 0) Then '                           black with white pawn
                    score = score + dis_to_p * 20
                ElseIf (WorB = 1) And (bpc > 0) Then '                       white with black pawn
                    score = score + dis_to_p * 20
                Else '                                                       chase other king often
                    score = score - dis_to_k * ((CanMove(1) = 2) And (Rnd > .3))
                End If
            End If
        End If

        AddMove level, score, fc, fr, tc, tr
    Loop Until n = 7
    'TimeTrack "MoveKing", 0
End Sub

Sub MoveKnight (level As _Byte)
    Dim As _Byte capture, n, tc, tr, tp, t1, t2
    Dim score, startscore, tts

    'TimeTrack "MoveKnight", 1

    If move < 10 Then startscore = -18 * (b(fc, fr) = o(fc, fr)) '   priority to getting a piece first moved

    n = -1
    Do
        n = n + 1
        capture = 0 '                                                what piece captured
        score = startscore
        tc = fc - dl(Knight, n) + dr(Knight, n) '                    column=column-left+right
        If (tc < 1) Or (tc > 8) Then _Continue '                     off board
        tr = fr - du(Knight, n) + dd(Knight, n) '                    row=row-up+down
        If (tr < 1) Or (tr > 8) Then _Continue '                     off board
        tp = b(tc, tr)
        If tp = 0 Then '                                             empty square
            score = score - (o(tc, tr) = tp) * rto '                 return to origin is likely bad
            score = score + ((move < 10) And (Abs(fc - tc) = 2)) * 500
        ElseIf WorB = Sgn(tp And 8) Then '                           beer buddies
            'protc(level) = protc(level) + value(tp)
            _Continue '                                              can't move to or past own piece
        Else '                                                       opponent piece, possible capture
            capture = tp '                                           capture piece
            score = value(capture) '                                 bishops worth a bit more than knights
            'attackc(level) = attackc(level) + value(tp)
            If score = 32 Then '                                     pawn value according to rank
                If (tr = 1) Or (tr = 8) Then
                    score = value(Queen)
                Else
                    tts = (9 - tr) * WorB - tr * (WorB = 0)
                    score = tts * tts
                End If
            End If
        End If

        If score <> 777 Then '                                       don't mess with checkmate score
            score = score - (points < -2) * (capture > 0) * 10 '     more than 2 points behind, discount trades
            score = score - Sgn((fr - tr) * pawndir) * (move < 12) ' bonus for moving ahead at beginning
            score = score - rto * (b(fc, fr) = o(tc, tr)) '          moving back to original square usually bad

            ' moving towards other king
            t1 = (Abs(fc - bkc) + Abs(fr - bkr)) * WorB - (Abs(fc - wkc) + Abs(fr - wkr)) * (WorB = 0)
            t2 = (Abs(tc - bkc) + Abs(tr - bkr)) * WorB - (Abs(tc - wkc) + Abs(tr - wkr)) * (WorB = 0)
            score = score + (t1 - t2) * 4
        End If
        AddMove level, score, fc, fr, tc, tr
    Loop Until n = 7
    'TimeTrack "MoveKnight", 0
End Sub

Sub MovePawn (level As _Byte)
    Dim As _Byte t1, t2, n, op, square, trysquare, z, tc, tr, tp
    Dim score, tts

    'TimeTrack "MovePawn", 1

    trysquare = 1 - (fr = 2) * WorB + (fr = 7) * (WorB = 0) '                    regular or gambit for black

    Do
        For square = 1 To trysquare '                                            following one path of one move
            score = -16
            tc = fc - (n = 1) + (n = 2) '                                        column
            If (tc < 1) Or (tc > 8) Then Exit For '                              off board
            tr = fr + pawndir * square '                                         row
            If (tr < 1) Or (tr > 8) Then Exit For '                              off board
            tp = b(tc, tr)
            If tp = 0 Then '                                                     blank square
                If n > 0 Then Exit For '                                         disallow pawn diagnonal when no capture
                score = score - 14 * ((tc = 5) And (move < 4) And (Rnd > .3)) '  favor king pawn
                score = score - 12 * ((tc = 4) And (move < 4) And (Rnd > .5)) '  favor queen pawn

                If (tr = 1) Or (tr = 8) Then
                    score = score + value(Queen) * 3 '                           promotion is a good thing
                Else
                    tts = tr * WorB - (9 - tr) * (WorB = 0)
                    score = score + tts * tts '                      4, 9, 16, 25, 36
                    score = score - (move - 19) * (move > 20) '      encourage pushing pawns in mid or end game
                End If
            ElseIf WorB = Sgn(tp And 8) Then '                       beer buddies
                'protc(level) = protc(level) - (n > 0) * value(tp)
                Exit For '                                           skip checking further
            Else '                                                   opponent piece, possible capture
                If n = 0 Then Exit For '                             not diagonal, no capture
                score = value(tp) '                                  bishops a bit more than knights
                'attackc(level) = attackc(level) + 1
                If score = 32 Then '                                 pawn value according to rank
                    tts = (9 - tr) * WorB - tr * (WorB = 0)
                    score = tts * tts
                End If
                If ((tr = 1) Or (tr = 8)) And (score <> 777) Then score = score + value(Queen)
            End If

            AddMove level, score, fc, fr, tc, tr
        Next square
        trysquare = 1 '                                              first pass might have been 2
        n = n + 1
    Loop Until n > 2

    If level < 2 Then '                                              cover en passant
        'ant(level) = ant(level) + 1
        op = 14 - WorB * 8 '                                         opponent pawn
        t1 = 4 + WorB '                                              rank 4 for black, 5 for white
        t2 = 2 + WorB * 5 '                                          rank 2 for black, 7 for white
        If fr = t1 Then '                                            from row =
            For z = -1 To 1 Step 2 '                                 look each side
                tc = fc + z '                                        to column
                If (tc > 0) And (tc < 9) Then '                      in bounds of board
                    If b(tc, fr) = op Then '                         opposing pawn

                        If (tc = lfc) And (t2 = lfr) And (tc = ltc) And (t1 = ltr) Then
                            AddMove level, 17, fc, fr, tc, fr + pawndir
                            'ant(level) = ant(level) + 1
                        End If
                    End If
                End If
            Next z
        End If
    End If
    'TimeTrack "MovePawn", 0
End Sub

Sub MoveQueen (level As _Byte)
    Dim As _Byte capture, n, square, tc, tr, tp, rp, rookc1, rookc2, rookr1, rookr2, ts, ok
    Dim score, tts

    'TimeTrack "MoveQueen", 1

    If CanMove(WorB) > 3 Then
        rp = Rook + WorB * 8
        rookc1 = 0: rookr1 = 0
        rookc2 = 0: rookr2 = 0
        For tr = 1 To 8
            For tc = 1 To 8
                If b(tc, tr) = rp Then
                    If Not ((tr = fr) And (tc = fc)) Then
                        If rookc1 = 0 Then
                            rookc1 = tc
                            rookr1 = tr
                        Else
                            rookc2 = tc
                            rookr2 = tr
                        End If
                    End If
                End If
            Next tc
        Next tr
        If WorB Then
            If rookr1 = 1 Then rookr1 = 0: rookc1 = 0
            If rookr2 = 1 Then rookr2 = 0: rookc2 = 0
        Else
            If rookr1 = 8 Then rookr1 = 0: rookc1 = 0
            If rookr2 = 8 Then rookr2 = 0: rookc2 = 0
        End If
    End If

    Do
        tc = fc '                                                    to column
        tr = fr '                                                    to row
        square = 1
        Do
            capture = 0 '                                            what piece captured
            score = 0
            tc = tc - dl(Queen, n) + dr(Queen, n) '                  column=column-left+right
            If (tc < 1) Or (tc > 8) Then Exit Do '                   off board
            tr = tr - du(Queen, n) + dd(Queen, n) '                  row=row-up+down
            If (tr < 1) Or (tr > 8) Then Exit Do '                   off board
            tp = b(tc, tr)
            If tp = 0 Then '                                         empty square
            ElseIf WorB = Sgn(tp And 8) Then '                       beer buddies
                'protc(level) = protc(level) + value(tp)
                Exit Do '                                            can't move to or past own piece
            Else '                                                   opponent piece, possible capture
                capture = tp '                                       capture piece
                'attackc(level) = attackc(level) + value(tp)
                score = value(capture) '                             bishops worth a bit more than knights
                If score = 32 Then '                                 pawn value according to rank
                    If (tr = 1) Or (tr = 8) Then
                        score = value(Queen)
                    Else
                        tts = (9 - tr) * WorB - tr * (WorB = 0)
                        score = tts * tts
                    End If
                End If
            End If

            If score <> 777 Then '                                              don't mess with checkmate score

                score = score - (points < -2) * (capture > 0) * 10 '            more than 2 points behind, discount trades
                'score = score - SGN((fr - tr) * pawndir) * (move < 12) '       bonus for moving ahead at beginning
                score = score - rto * (b(fc, fr) = o(tc, tr)) '                 moving back to original square usually bad

                ' moving towards other king
                't1 = (ABS(fc - bkc) + ABS(fr - bkr)) * WorB - (ABS(fc - wkc) + ABS(fr - wkr)) * (WorB = 0)
                't2 = (ABS(tc - bkc) + ABS(tr - bkr)) * WorB - (ABS(tc - wkc) + ABS(tr - wkr)) * (WorB = 0)
                'score = score + (t1 - t2) * 2

                ' bonus for being on the same rank or column as rook
                If CanMove(WorB) > 3 Then
                    ok = false
                    If tc = rookc1 Then
                        ok = true
                        For ts = tr To rookr1 Step Sgn(rookr1 - tr)
                            If (b(tc, ts) <> 0) And (b(tc, ts) <> rp) Then ok = false
                        Next ts
                    End If
                    If tc = rookc2 Then
                        ok = true
                        For ts = tr To rookr2 Step Sgn(rookr2 - tr)
                            If (b(tc, ts) <> 0) And (b(tc, ts) <> rp) Then ok = false
                        Next ts
                    End If
                    If tr = rookr1 Then
                        ok = true
                        For ts = tc To rookc1 Step Sgn(rookc1 - tc)
                            If (b(ts, tr) <> 0) And (b(ts, tr) <> rp) Then ok = false
                        Next ts
                    End If
                    If tr = rookr2 Then
                        ok = true
                        For ts = tc To rookc2 Step Sgn(rookc2 - tc)
                            If (b(ts, tr) <> 0) And (b(ts, tr) <> rp) Then ok = false
                        Next ts
                    End If
                    If ok And (b(tc, tr) = 0) Then
                        'debug$ = debug$ + "q" + alphal$(tc) + CHRN$(tr) + " "
                        score = score + 10
                    End If
                End If
            End If

            AddMove level, score, fc, fr, tc, tr

            If capture Then Exit Do
            square = square + 1
        Loop Until square > 7
        n = n + 1
    Loop Until n = 8
    'TimeTrack "MoveQueen", 0
End Sub

Sub MoveRook (level As _Byte)
    Dim As _Byte capture, n, square, tc, tr, rspecial, tp, rp, qp, rookc, rookr, queenc, queenr, ts, ok
    Dim score, tts

    'TimeTrack "MoveRook", 1

    If CanMove(WorB) > 3 Then
        rp = Rook + WorB * 8
        qp = Queen + WorB * 8
        rookc = 0: rookr = 0
        queenc = 0: queenr = 0
        For tr = 1 To 8
            For tc = 1 To 8
                If b(tc, tr) = rp Then
                    If Not ((tr = fr) And (tc = fc)) Then
                        rookc = tc
                        rookr = tr
                    End If
                End If
                If b(tc, tr) = qp Then
                    queenc = tc
                    queenr = tr
                End If
            Next tc
        Next tr
        If WorB Then
            If rookr = 1 Then rookr = 0
            If queenr = 1 Then queenr = 0
        Else
            If rookr = 8 Then rookr = 0
            If queenr = 8 Then queenr = 0
        End If
    End If

    rspecial = (b(fc, fr) = o(fc, fr)) And (move < 16)

    Do
        tc = fc '                                                    to column
        tr = fr '                                                    to row
        square = 1
        Do
            capture = 0 '                                            what piece captured
            score = 0
            tc = tc - dl(Rook, n) + dr(Rook, n) '                    column=column-left+right
            If (tc < 1) Or (tc > 8) Then Exit Do '                   off board
            tr = tr - du(Rook, n) + dd(Rook, n) '                    row=row-up+down
            If (tr < 1) Or (tr > 8) Then Exit Do '                   off board
            tp = b(tc, tr)
            If tp = 0 Then '                                         empty square
            ElseIf WorB = Sgn(tp And 8) Then '                       beer buddies
                'protc(level) = protc(level) + value(tp)
                Exit Do '                                            can't move to or past own piece
            Else '                                                   opponent piece, possible capture
                capture = tp '                                       capture piece
                'attackc(level) = attackc(level) + value(tp)
                score = value(capture) '                             bishops worth a bit more than knights
                If score = 32 Then '                                 pawn value according to rank
                    If (tr = 1) Or (tr = 8) Then
                        score = value(Queen)
                    Else
                        tts = (9 - tr) * WorB - tr * (WorB = 0)
                        score = tts * tts
                    End If
                End If
            End If

            If score <> 777 Then '                                              don't mess with checkmate score

                score = score - (points < -2) * (capture > 0) * 10 '            more than 2 points behind, discount trades
                'score = score - SGN((fr - tr) * pawndir) * (move < 12) '       bonus for moving ahead at beginning
                score = score - rto * (b(fc, fr) = o(tc, tr)) '                 moving back to original square usually bad

                ' encourage moving towards opponent King
                't1 = (ABS(fc - bkc) + ABS(fr - bkr)) * WorB - (ABS(fc - wkc) + ABS(fr - wkr)) * (WorB = 0)
                't2 = (ABS(tc - bkc) + ABS(tr - bkr)) * WorB - (ABS(tc - wkc) + ABS(tr - wkr)) * (WorB = 0)
                'score = score + (t1 - t2) * 2

                ' moving rook 1&2 up or 1 sideways early in game rarely good
                If rspecial Then score = score + (tr < 4) * 32 * WorB - (tr > 5) * 32 * (WorB = 0) + (Abs(fc - tc) = 1) * 32

                ' bonus for rook being on the same rank or column as queen or other rook
                If CanMove(WorB) > 3 Then
                    ok = false
                    If tc = rookc Then
                        ok = true
                        For ts = tr To rookr Step Sgn(rookr - tr)
                            If (b(tc, ts) <> 0) And (b(tc, ts) <> rp) Then ok = false
                        Next ts
                    End If
                    If tr = rookr Then
                        ok = true
                        For ts = tc To rookc Step Sgn(rookc - tc)
                            If (b(ts, tr) <> 0) And (b(ts, tr) <> rp) Then ok = false
                        Next ts
                    End If
                    If tc = queenc Then
                        ok = true
                        For ts = tr To queenr Step Sgn(queenr - tr)
                            If (b(tc, ts) <> 0) And (b(tc, ts) <> qp) Then ok = false
                        Next ts
                    End If
                    If tr = queenr Then
                        ok = true
                        For ts = tc To queenc Step Sgn(queenc - tc)
                            If (b(ts, tr) <> 0) And (b(ts, tr) <> qp) Then ok = false
                        Next ts
                    End If
                    If ok And (b(tc, tr) = 0) Then
                        'debug$ = debug$ + "r" + alphal$(tc) + CHRN$(tr) + " "
                        score = score + 10
                    End If
                End If
            End If

            AddMove level, score, fc, fr, tc, tr

            If capture Then Exit Do
            square = square + 1
        Loop Until square > 7
        n = n + 1
    Loop Until n = 4
    'TimeTrack "MoveRook", 0
End Sub

Sub NameAssign
    Dim As _Byte i
    Dim x1, x2, y1, y2, t$, inputprompt$, fieldcontents$

    ingetnames = true
    PlotScreen false

    If wasplayback Then
        PlayerNamePop
        lasth = lasthsav
        lastc = lastcsav
        wasplayback = false
    End If

    If (human = lasth) And (humanc = lastc) Then GoTo gotnames
    If (human = 1) And (lasth = 1) And (humanc <> lastc) Then
        Swap PlayerName$(0), PlayerName$(1)
        lastc = humanc
        GoTo gotnames
    End If

    lasth = human
    lastc = humanc

    Select Case human
        Case Is = 0
            PlayerName$(0) = "Dodo Zero"
            PlayerName$(1) = "Dodo Zero"
        Case Is = 1
            If humanc Then
                If Len(ComputerName$) Then PlayerName$(1) = ComputerName$ Else PlayerName$(1) = "Human"
                PlayerName$(0) = "Dodo Zero"
            Else
                If Len(ComputerName$) Then PlayerName$(0) = ComputerName$ Else PlayerName$(0) = "Human"
                PlayerName$(1) = "Dodo Zero"
            End If
        Case Is = 2
            If humanc Then
                If Len(ComputerName$) Then PlayerName$(1) = ComputerName$ Else PlayerName$(1) = "Human"
                PlayerName$(0) = "Human"
            Else
                If Len(ComputerName$) Then PlayerName$(0) = ComputerName$ Else PlayerName$(0) = "Human"
                PlayerName$(1) = "Human"
            End If
    End Select

    gotnames:
    If human > 0 Then
        x1 = blx
        x2 = brx
        y1 = bly + 18
        y2 = _Height - 20

        For i = 0 To 1
            inputprompt$ = Mid$("WhiteBlack", i * 5 + 1, 5) + " name" + ": "
            fieldcontents$ = PlayerName$(1 - i)
            nbox = 5
            _PutImage (x1, y1)-(x2, y2), bgi, 0, (x1, y1)-(x2, y2) '     erase clock area
            'Line (x1, y1)-(x2, y2), blue, BF
            t$ = GetField$(inputprompt$, 520 + i * 22, 30, 1, fieldcontents$)
            PlayerName$(1 - i) = t$
        Next i
    End If

    WriteLog true
    ingetnames = false
End Sub

Sub NixieTubeClock (i As _Byte, j As _Byte, nn As _Byte)
    Static initflag, img, fx, fy, tx, xq, yq

    If initflag = false Then '                                       one time initialization
        img = _LoadImage(datapath$ + "nixie.jpg") '                  750 * 600
        xq = 148
        yq = 299
        initflag = true
    End If

    fx = (nn Mod 5) * xq + 2 '                                       from x (source image)
    fy = Int(nn / 5) * yq
    tx = 8 + blx + (j - 1) * 28 + (1 - i) * 184 '                    to x (screen)
    _PutImage (tx, 518 - pregame * 20)-Step(28, 54), img, 0, (fx, fy)-(fx + xq, fy + yq)
End Sub

Function OnOff$ (v As _Byte)
    OnOff$ = RTrim$(Mid$("OFFON ", v * 3 + 1, 3))
End Function

Sub Pause
    If inpause Or inhelp Then Exit Sub
    inpause = true
    Do: _Limit mloop
        TempMess$ = "PAUSED"
        PlotScreen false
        KeyScan
        KeepAlive '                                                  signal Minimax, if active, to prevent timeout
    Loop Until (i$ = "p") Or b1 Or b2
    TempMess$ = " "
    ClearBuffers
    inpause = false
End Sub

Function PieceSize (tp) '                                            size adjustments for sets
    PieceSize = psize + psa(piece_style, -((tp And 7) = Pawn))
End Function

Sub PieceSlide (tfc As _Byte, tfr As _Byte, ttc As _Byte, ttr As _Byte)
    Static isactive As _Byte
    Dim As _Byte lp, zz
    Dim x1, x2, y1, y2, tx, ty, z1, tscreen
    Dim As Single qq, qx, qy, tdelay

    If isactive Then Exit Sub '                                      prevent circular calls

    If invert Then
        lp = b2(9 - tfc, 9 - tfr)
        b2(9 - tfc, 9 - tfr) = 0
    Else
        lp = b2(tfc, tfr)
        b2(tfc, tfr) = 0
    End If
    isactive = true '                                                plotscreen calls this, and this calls plotscreen

    x1 = tlx + (tfc - 1) * xq
    y1 = bly - tfr * yq
    x2 = tlx + (ttc - 1) * xq
    y2 = bly - ttr * yq
    If Abs(x1 - x2) > Abs(y1 - y2) Then qq = Abs(x2 - x1) Else qq = Abs(y2 - y1)
    If rotate = 0 Then
        If fast = 1 Then qq = qq / 2 Else qq = qq / 8
    Else
        If fast = 1 Then qq = qq / 8 Else qq = qq / 16
    End If
    If fast = 1 Then tdelay = .02 Else tdelay = .01

    qx = (x2 - x1) / qq
    qy = (y2 - y1) / qq

    zz = PieceSize(lp)

    If fast > 0 Then '                                               blink & slide for slow or fast, not off
        PlotScreen false
        If rotate = 0 Then DisplayMaster false
        tscreen = _CopyImage(0)

        c1 = 0
        If onplayback And (Left$(m$, 1) = "O") And ((lp And 7) = Rook) Then c1 = 1
        If (((lp And 7) = Rook) And (fc < 0) Or (fr < 0)) Then c1 = 2
        If c1 = 0 Then
            For z1 = 1 To 9 '                                        blink
                _PutImage , tscreen, 0
                If z1 Mod 2 Then _PutImage (x1 + zz, y1 + zz)-(x1 + xq - zz, y1 + yq - zz), pix(piece_style, lp) ' pixh are hardware images
                'RainbowButton
                If rotate = 0 Then _Display Else DisplayMaster true
                _Delay .15
            Next z1
        End If

        For z1 = 1 To Int(qq) '                                      slide
            tx = x1 + z1 * qx
            ty = y1 + z1 * qy
            'z2 = zz - Sin(_D2R(z1 / qq * 180)) * 8 '                "hop"
            _PutImage , tscreen, 0
            If rotate = 0 Then
                _PutImage (tx + zz, ty + zz)-(tx + xq - zz, ty + yq - zz), pixh(piece_style, lp) ' pixh are hardware images
                _Display
                _Delay tdelay
            Else
                _PutImage (tx + zz, ty + zz)-(tx + xq - zz, ty + yq - zz), pix(piece_style, lp)
                DisplayMaster true
            End If
        Next z1

        _FreeImage tscreen
    End If
    If invert Then b2(9 - ttc, 9 - ttr) = lp Else b2(ttc, ttr) = lp
    isactive = false
End Sub

Sub Plasma (x1, y1, x2, y2, sp As _Byte) Static
    Dim As _Byte i, m, m1, n, rf(12)
    Dim xxyy, x, y, z
    Dim As Single kk, dd, dx, dy, r, g, b, f1, f2, f3, f(5)
    Dim As _Unsigned Long c(360)
    Dim p(5) As xy
    Dim sm As _MEM
    Dim so As _Offset

    Type xy
        x As Single
        y As Single
        dx As Single
        dy As Single
    End Type

    If plasmaint = 0 Then Exit Sub

    'TimeTrack "Plasma", 1

    If plasma_init = false Then
        xxyy = 16 * xq
        For n = 1 To 12
            rf(n) = Rnd * 20 + 20
        Next n
        z = 0
        r = Rnd: g = Rnd: b = Rnd
        For n = 1 To 5
            For i = 1 To 4
                For m = 0 To 17
                    m1 = 17 - m
                    Select Case i
                        Case 1: f1 = (m * r) / rf(1): f2 = (m * g) / rf(2): f3 = (m * b) / rf(3)
                        Case 2: f1 = (m + m1 * r) / rf(4): f2 = (m + m1 * g) / rf(5): f3 = (m + m1 * b) / rf(6)
                        Case 3: f1 = (m1 + m * r) / rf(7): f2 = (m1 + m * g) / rf(8): f3 = (m1 + m * b) / rf(9)
                        Case 4: f1 = (m1 * r) / rf(10): f2 = (m1 * g) / rf(11): f3 = (m1 * b) / rf(12)
                    End Select
                    c(z) = _RGB32(f1 * 255, f2 * 255, f3 * 255)
                    z = z + 1
                Next m
            Next i
        Next n

        For n = 0 To 5
            p(n).x = Rnd * xm
            p(n).y = Rnd * ym
            p(n).dx = Rnd
            p(n).dy = Rnd
            If Rnd > .5 Then p(n).dx = -p(n).dx
            If Rnd > .5 Then p(n).dy = -p(n).dy
            f(n) = Rnd * .08
        Next
        plasma_init = true
    End If

    For n = 0 To 5
        p(n).x = p(n).x + p(n).dx
        If p(n).x > xxyy Or p(n).x < 0 Then p(n).dx = -p(n).dx
        p(n).y = p(n).y + p(n).dy
        If p(n).y > xxyy Or p(n).y < 0 Then p(n).dy = -p(n).dy
    Next

    sm = _MemImage
    For y = y1 To y2 Step 2 + inhelp '                               dimmer in Help to not obscure text
        so = sm.OFFSET + y * _Width * 4 + x1 * 4
        For x = x1 To x2 Step 2
            'c1 = Point(x, y)
            _MemGet sm, so, c1
            If sp Then '                                             help screen
                c1 = (c1 <> boardwhite)
            Else '                                                   the board
                c1 = ((c1 = boardwhite) * (graphics <> 2) + (c1 = boardblack) * (graphics > 1))
            End If
            If c1 Then
                dd = 0
                For n = 0 To 5
                    dx = x - p(n).x
                    dy = y - p(n).y
                    kk = Sqr(dx * dx + dy * dy)
                    dd = dd + (Sin(kk * f(n)) / 4 + 1) * 64
                Next
                _MemPut sm, so, c(dd Mod 360)
                'PSet (x, y), c(dd Mod 360)
            End If
            so = so + 8
        Next x
    Next y
    _MemFree sm

    'TimeTrack "Plasma", 0
End Sub

Sub Playagain ()
    Dim k, t$, validkeys$, waituntil As Double

    onplayback = false
    readonly = true '                                                allows replay (takeback a move or more) without changing "official" game
    endgame = true
    waituntil = ExtendedTimer + 60 - (rickfile * 50) '               10 second delay for Frostosaurus, 60 for others

    Do: _Limit mloop
        KeepAlive
        TempMess$ = msg$
        If match Or (human = 0) Then TempMess$ = TempMess$ + Str$(Int(waituntil - ExtendedTimer))
        PlotScreen false

        If InStr(LCase$(msg$), "res") Then
            t$ = " Resume     New" + s$ + "game     Invert "
            validkeys$ = "rn"
        Else
            t$ = " New" + s$ + "game     Back     Invert "
            If backok Then validkeys$ = "bn" Else validkeys$ = "n"
        End If
        t$ = t$ + "    File" + s$ + "menu "
        Center 0, t$, true, false

        validkeys$ = validkeys$ + "f"
        KeyScan
        If i$ = "" Then i$ = " "

        If asci = 72 Then
            For k = 1 To 10
                If (shia + move - 48) > 0 Then shia = shia - 1: oply = false
            Next k
        End If

        If asci = 80 Then
            shia = shia + 10
            oply = false
        End If
        If shia > 0 Then shia = 0

        If dev And (i$ = "q") Then Quit
        If (i$ = "r") And (InStr(validkeys$, "r") > 0) Then
            move = move + (SaveWorB = 1) '                           decrement move if Black
            noresign = true '                                        disable resign (to practice checkmate?)
        End If
        k = InStr(validkeys$, i$) '                                  Special K, a crappy cereal

    Loop Until k Or ((match Or (human = 0)) And (ExtendedTimer > waituntil))

    msg$ = ""
    If k = 0 Then i$ = "n": ClearTemp '                              new game, clear temporary images (capture, small boards)
    endgame = false
    If i$ = "f" Then PlayFile
End Sub

Sub PlayerNamePush
    PlayerName$(2) = PlayerName$(0)
    PlayerName$(3) = PlayerName$(1)
End Sub

Sub PlayerNamePop
    PlayerName$(0) = PlayerName$(2)
    PlayerName$(1) = PlayerName$(3)
End Sub

Sub PlayFile
    Dim v$(2), i, j, tf, lt, w, zz, gotline, fc, fr, tc, tr, mp, mc, pt, eloop, nonstop, tscreen
    Dim hcount, q1, q2, sfc, sfr, stc, str, fc2, fr2, tc2, tr2, c$, t$, t2$, pbf$
    Dim header$(20), guts$(20), wu As Double

    pgnheader:
    Data Event,Site,Date,Round,White,Black,Result

    If onplayback Then Exit Sub '                                    could lead to impossible move
    PlayerNamePush
    lasthsav = lasth: lastcsav = lastc

    f$ = ""
    GetFileForPlayback
    If Len(f$) = 0 Then Exit Sub

    onplayback = true
    eloop = false

    pf$ = f$
    pbf$ = f$

    wakka: '                                                         three cheers for Fozzy Bear
    f$ = gamepath$ + pbf$ + ".alg"
    FileCheck
    pf$ = pbf$
    ClearTemp
    WorB = 1
    move = 0
    Erase Moves, mcount, etime, mlog$

    castle$ = "****" '                                               flags qkQK (B then W)
    cmate = 0
    drawcount = 0
    FENpcount = 0
    hcount = 0
    human = true
    noresign = false
    perpetual = 0

    pdate$ = ""
    PlayerName$(0) = ""
    PlayerName$(1) = ""

    tf = FreeFile
    Open f$ For Input As #tf
    readheader:
    Line Input #tf, t$
    If InStr(t$, "[") Then '                                         header(s)
        hcount = hcount + 1
        If hcount < 21 Then
            header$(hcount) = t$
            q1 = InStr(t$, q$)
            q2 = 0
            If q1 Then q2 = InStr(q1 + 1, t$, q$)
            If (q1 > 0) And (q2 > 0) Then guts$(hcount) = Mid$(t$, q1 + 1, q2 - q1 - 1)
        End If
        If Not (EOF(tf)) Then GoTo readheader
    Else
        gotline = 1
    End If

    Restore pgnheader
    For i = 1 To 7
        Read t2$
        For j = 1 To hcount
            If InStr(UCase$(header$(j)), UCase$(t2$)) Then
                If t2$ = "Date" Then pdate$ = guts$(j)
                If t2$ = "White" Then PlayerName$(1) = guts$(j)
                If t2$ = "Black" Then PlayerName$(0) = guts$(j)
            End If
        Next j
    Next i

    If pdate$ = "" Then pdate$ = fd$ '                               use file date when no stored date

    Enter10 = false '                                                shift-Enter skips 10 moves
    invert = false
    FENpcount = 0
    msg$ = ""
    TempMess$ = ""
    nonstop = false
    wasreadonly = readonly

    SetupBoard
    PlotScreen false

    While Not (EOF(tf))
        If gotline = 0 Then Line Input #tf, t$
        gotline = 0
        If InStr(t$, "[") Then _Continue '                           ignore lines with [
        t$ = LTrim$(t$) + " "
        lt = Len(t$)
        If lt = 0 Then _Continue
        t$ = t$ + " "
        v$(0) = "": v$(1) = "": v$(2) = ""
        w = 0
        ReDim givecheck(2), promotec(2)

        i = InStr(t$, "ep")
        If i > 0 Then Mid$(t$, i, 2) = "  "

        For i = 1 To lt
            lookagain:
            c$ = Mid$(t$, i, 1)
            pt = InStr("RNBQ", c$)
            If pt Then '                                             promotion
                promotec(w) = pt
            Else
                Select Case c$
                    Case "+" '                                       check or checkmate
                        If givecheck(w) Then '                       seen a + before, must be checkmate
                            cmate = w
                            Exit For
                        End If
                        givecheck(w) = true
                    Case "$" '                                       stalemate
                    Case " " '                                       space between move/number, or move/move
                        w = w - (Len(v$(w)) > 0)
                        If w > 2 Then Exit For
                    Case Else
                        v$(w) = v$(w) + c$
                End Select
            End If
        Next i
        For zz = 1 To 2
            m$ = v$(zz) '                                            grab move out of 2 move input buffer
            If m$ = "" Then readonly = false: GoTo pbdone
            If (m$ = "res") Or (m$ = "1-0") Or (m$ = "0-1") Or (m$ = draw$) Or (m$ = "draw") Then
                readonly = true
                If m$ = "res" Then AddSymbol "res"
                If (m$ = draw$) Or (m$ = "draw") Then AddSymbol "draw"
                GoTo pbdone
            End If
            fc = InStr(alphaz$, Left$(m$, 1)) '                      from column
            fr = Val(Mid$(m$, 2, 1)) '                               from row
            tc = InStr(alphaz$, Mid$(m$, 3, 1))
            tr = Val(Mid$(m$, 4, 1))
            mp = b(fc, fr) '                                         moving piece
            mc = Sgn(mp And 8) '                                     moving color 0 black 1 white
            mp = mp And 7 '                                          strip color from piece
            If Left$(m$, 3) = "O-O" Then '                           might end with ? (comment questionable)
                fc = -5: tc = 7: fc2 = 8: tc2 = 6 '                  negative "from column" is how I identify kingside castle
                If WorB = 1 Then fr = 1: tr = 1: fr2 = 1: tr2 = 1
                If WorB = 0 Then fr = 8: tr = 8:: fr2 = 8: tr2 = 8
            End If
            If Left$(m$, 5) = "O-O-O" Then '                         might end with ? (comment questionable)
                fc = 5: tc = 3: fc2 = 1: tc2 = 4
                If WorB = 1 Then fr = -1: tr = 1: fr2 = 1: tr2 = 1 ' negative "from row" is how I identify queenside castle
                If WorB = 0 Then fr = -8: tr = 8: fr2 = 8: tr2 = 8
            End If
            _MemCopy m(0), m(0).OFFSET, m(0).SIZE To m(10), m(10).OFFSET ' copy working b() to display board b2()
            sfc = fc: sfr = fr: stc = tc: str = tr
            PieceSlide Abs(fc), Abs(fr), tc, tr

            If Left$(m$, 1) = "O" Then '                             rook part of castling
                PieceSlide fc2, fr2, tc2, tr2
                fc = sfc: fr = sfr: tc = stc: tr = str
            End If

            AddMove 0, 0, fc, fr, tc, tr '                           level score position
            Reset_To_Zero
            MoveItReal fc, fr, tc, tr
            If promotec(zz) > 0 Then
                b(tc, tr) = promotec(zz) + WorB * 8
                promote$ = Mid$("RNBQ", promotec(zz), 1) '           for addlog
            End If
            AddLog
            Fking false
            WorB = WorB Xor 1
            If givecheck(zz) Then
                TempMess$ = "Check!"
                AddSymbol "+"
            End If
            If Right$(m$, 1) = "?" Then AddSymbol "?"
            If Right$(m$, 1) = "!" Then AddSymbol "!"
            _MemCopy m(0), m(0).OFFSET, m(0).SIZE To m(10), m(10).OFFSET '       copy working b() to display board b2()
            MarkerSave fc, fr, tc, tr
            If cmate = zz Then
                TempMess$ = "Checkmate"
                msg$ = "Checkmate"
                AddSymbol "+"
                readonly = true
                GoTo pbdone
            End If
            Do: _Limit mloop
                PlotScreen false
                KeyScan
                Select Case i$
                    Case " "
                        i$ = Enter$: asci = 13
                    Case "l"
                        eloop = eloop Xor 1
                        TempMess$ = "Loop " + OnOff$(eloop)
                        If eloop Then PlotScreen true
                    Case "n"
                        nonstop = nonstop Xor 1
                        TempMess$ = "Nonstop " + OnOff$(nonstop)
                        If nonstop = false Then eloop = false
                        If nonstop Then PlotScreen true
                    Case "s"
                        nonstop = false
                        eloop = false
                        readonly = true
                        GoTo pbdone
                End Select
                If Enter10 > 0 Then
                    asci = 13
                    Enter10 = Enter10 - 1
                    If Enter10 = 0 Then fast = sfast
                End If
            Loop Until nonstop Or (asci = 13) Or eloop
            i$ = "": asci = 0
        Next zz
        If (perpetual > 2) Or (drawcount > 49) Then GoTo pbdone
    Wend
    readonly = false

    pbdone:
    check = false
    incheck = false
    Close #tf
    PlotScreen true
    If eloop Then
        wu = ExtendedTimer + 5
        PlotScreen false
        tscreen = _CopyImage(0)
        Do: _Limit mloop
            If rotate Then _PutImage , tscreen, 0 Else PlotScreen true
            KeyScan
        Loop Until (ExtendedTimer > wu) Or (Len(i$) > 0)
        _FreeImage tscreen
        _Delay .1
        If i$ <> "s" Then GoTo wakka
    End If
    GetWB
    If InStr(mlog$(move, 1), "res") Then move = move - 1
    SaveWorB = WorB
    promote$ = ""
    If wasreadonly Then readonly = true
    logfiled$ = LCase$(pf$) + ".alg"
    logfile$ = gamepath$ + logfiled$
End Sub

Sub PlaySound (sf As _Byte)
    If pregame And (sf > 1) Then Exit Sub
    If makenoise = 0 Then Exit Sub '                                            sound turned off or file does not exist
    If soundloaded = 0 Then LoadSounds
    If sfile(sf) = 0 Then Exit Sub '                                            sound turned off or file does not exist
    If (sf > 1) And (_SndPlaying(sfile(1)) <> 0) Then _SndStop sfile(1) '       stop intro music for any other sound
    _SndVol sfile(sf), svol(sf) / 10 '                                          volume is 0.1 and 1-10
    If (sf > 1) Or (_SndPlaying(sfile(1)) = 0) Then _SndPlay sfile(sf) '        let intro music play without restart for volume adjustments
End Sub

Sub PlotBoard
    Dim As _Byte zc, zr
    Dim sfx, sfy, stx, sty

    For zr = 1 To 8
        For zc = 1 To 8
            PlotPiece zc, zr, zc, zr
        Next zc
    Next zr

    ' last opponent move, little green box in from square, red box in to square
    If markers And (pregame = 0) And (insetup = 0) And (markerfc > 0) Then
        If invert Then
            sfx = tlx + (8 - markerfc) * xq + 4: sfy = bly - (9 - markerfr) * yq + 4
            stx = tlx + (8 - markertc) * xq + 4: sty = bly - (9 - markertr) * yq + 4
        Else
            sfx = tlx + (markerfc - 1) * xq + 4: sfy = bly - markerfr * yq + 4
            stx = tlx + (markertc - 1) * xq + 4: sty = bly - markertr * yq + 4
        End If
        Line (sfx, sfy)-Step(4, 4), green, BF
        Line (stx, sty)-Step(4, 4), red, BF
        Line (sfx, sfy)-Step(4, 4), black, B
        Line (stx, sty)-Step(4, 4), black, B
    End If
End Sub

Sub PlotPiece (fc As _Byte, fr As _Byte, tc As _Byte, tr As _Byte)
    Dim As _Byte lp, tfc, tfr, ttc, ttr, z
    Dim tx, ty, ty2

    tfc = Abs(fc)
    tfr = Abs(fr)
    ttc = tc
    ttr = tr

    lp = b2(tfc, tfr)

    If invert Then '                                                from black's perspective
        tfc = 9 - tfc
        tfr = 9 - tfr
        ttc = 9 - ttc
        ttr = 9 - ttr
    End If

    If (cflag < 0) Or ((human <> 2) And (((human = 0) Or (WorB <> humanc)) And ((tfc <> ttc) Or (tfr <> ttr)))) Then
        PieceSlide tfc, tfr, ttc, ttr
    End If

    tx = tlx + (tfc - 1) * xq
    ty = bly - tfr * yq

    If ((tfc + tfr) Mod 2) Then c1 = boardwhite Else c1 = boardblack
    Line (tx, ty)-(tx + xq, ty + yq), c1, BF

    If lp Then
        z = PieceSize(lp)
        ty2 = ty - (piece_style = 6) * 2
        If ((tfc + tfr) Mod 2) And (piece_style <> 9) And (piece_style > 1) Then
            _PutImage (tx + xq - z, ty2 + z)-(tx + z, ty2 + yq - z), pix(piece_style, lp), 0
        Else
            _PutImage (tx + z, ty2 + z)-(tx + xq - z, ty2 + yq - z), pix(piece_style, lp), 0
        End If
        If alfredon And (Rnd > .98) Then _PutImage (tx, ty2)-(tx + xq, ty2 + yq), alfred, 0
    End If

    If squaretrim And (piece_style > 0) Then
        For z = 0 To squaretrim - 1
            Line (tx + z, ty + z)-(tx + xq - z, ty + yq - z), black, B
        Next z
        If squaretrim = 3 Then Line (tx + 1, ty + 1)-(tx + xq - 1, ty + yq - 1), c1, B
    End If
End Sub

Sub PlotScreen (disp As _Byte)
    Dim As _Byte i, j, k
    Dim t$, x1, x2, y1, y2
    'dim  h, m, s
    'Dim As _Byte sorted '                                           TimeTrack

    'TimeTrack "PlotScreen", 1

    nbox = 0
    chimp = 0
    fullscreenflag = Sgn(_FullScreen)

    'If rickfile And (bri > 2) And (btoggle = false) Then '           autodim for me 2200
    '    h = Val(Mid$(Time$, 1, 2))
    '    m = Val(Mid$(Time$, 4, 2))
    '    s = Val(Mid$(Time$, 7, 2))
    '    If (h = 22) And (m = 0) And (s < 5) Then
    '        bri = 2
    '        ColorSet
    '        btoggle = true
    '    End If
    'End If

    If insetup Then
        'TimeTrack "PlotScreen", 0
        Exit Sub
    End If

    If xmas Then '                                                   alternatng red/green squares
        graphics = 3 '                                               plasma for all squares
        If (xmast = 0) Or (xmast < ExtendedTimer) Then
            xmasc = xmasc Xor 1
            boardwhite = _RGB32(200, 0, 0) '                         red
            boardblack = _RGB32(0, 200, 0) '                         green
            If xmasc Then Swap boardwhite, boardblack '              swap
            xmast = ExtendedTimer + .5 '                             change colors again in 5 seconds
        End If
    End If

    Background
    AboveBoardInfo '                                                 score, status, time limited messages, stats, Windows buttons

    If pregame Then
        j = 0
        For i = 1 To 18 * pregame '                                      cookie!
            k = Val(Mid$("002032023222300032", i, 1)) '                  ..-.,  -.-, ---, ..., -
            Line (tlx + j + 2, tly - 2)-Step(k, 0), red * -(k < 3)
            j = j + k + 3
        Next i
    End If

    PlotBoard '                                                      squares, pieces, markers
    If legend And (pregame = 0) Then ShowLegend '                    a-h at bottom, 1-8 at left

    If onplayback And (Len(pf$) > 0) Then '                          show info on current file
        x1 = blx
        x2 = brx
        y1 = bly + 20
        y2 = _Height - 20
        _PutImage (x1, y1)-(x2, y2), bgi, 0, (x1, y1)-(x2, y2)
        SetFont defaultfontsize
        t$ = PlayerName$(1) + " / " + PlayerName$(0)
        If Len(t$) = 3 Then t$ = "PLAYBACK"
        ShadowPrint xc - _PrintWidth(t$) \ 2, 512, t$, white
        ShadowPrint xc - _PrintWidth(pdate$) \ 2, 530, pdate$, white
        t$ = "Moves:" + Str$(mig)
        ShadowPrint xc - _PrintWidth(t$) \ 2, 550, t$, white
    Else
        If (ingetfile + ingetnames + promoting) = 0 Then Clocks '    big move clocks
    End If

    If (pregame = 0) And (ingetfile = 0) Then
        ShowTaken true
        ShowBolt
        InfoOnRight
    End If
    ptaken = Abs(ptaken)
    GraphLoad
    Center 0, "", true, false '                                      instructions at bottom

    'If ttflag And (tel! > 0) Then '                                  SUB time tracking
    '
    '    sort:
    '    sorted = 1
    '    For i = 1 To names - 1
    '        If time_used(i) < time_used(i + 1) Then
    '            Swap name$(i), name$(i + 1)
    '            Swap time_used(i), time_used(i + 1)
    '            Swap active(i), active(i + 1)
    '            sorted = 0
    '        End If
    '    Next i
    '    If sorted = 0 Then GoTo sort
    '
    '    _PutImage (0, 0)-(tlx - 1, bly - 12), bgi, 0, (0, 0)-(tlx - 1, bly - 12)
    '    _Font 14
    '    Color gray, zip
    '    For i = 1 To names
    '        Locate i + 3, 2: Print name$(i);
    '        Locate i + 3, 16: Print Using "####.####"; (time_used(i) / tel!) * 100;
    '    Next i
    'End If

    RainbowButton

    If showmousepos Then Magnify

    'i = ant(0) + ant(1) + ant(2) + ant(3) + ant(4) + ant(5)
    'If i > 0 Then
    '    debug$ = ""
    '    For i = 0 To 5
    '        debug$ = debug$ + Str$(ant(i)) + " "
    '    Next i
    'End If

    If Len(debug$) Then
        SetFont defaultfontsize
        Color _RGB32(200, 200, 200), zip
        _PrintString (tlx, 10), debug$
    End If

    If disp Then DisplayMaster disp

    'TimeTrack "PlotScreen", 0
End Sub

Sub DisplayMaster (dflag As _Byte)
    Static wrotate, trotate

    trotate = rotate

    If fullscreenflag <> 0 Then
        If rotate = 0 Then
            If (_DesktopWidth = 1366) And (_FullScreen <> 2) Then
                fullscreenflag = 2
                ScreenInit
            End If
        Else
            If _FullScreen <> 1 Then
                fullscreenflag = 1
                ScreenInit
            End If
        End If
    End If

    If usd Then
        RotateBoard 2
        trotate = 2
    ElseIf rotate <> 0 Then
        If rotate <> wrotate Then wrotate = rotate: ScreenInit
        RotateBoard rotate
    End If

    If graphics And (ingetfile = 0) And (inshow = 0) Then
        If inhelp Then
            Plasma 0, 0, _Width - 1, _Height - 1, 1
        Else
            Select Case trotate
                Case 0
                    Plasma tlx, tly, trx, bly, 0
                Case 1
                    If _FullScreen Then
                        Plasma 218, 0, 664, _Height - 1, 0
                    Else
                        Plasma 158, 0, 753, _Height - 1, 0
                    End If
                Case 2
                    Plasma 236, 118, 602, 564, 0
                Case 3
                    If _FullScreen Then
                        Plasma 134, 0, 584, _Height - 1, 0
                    Else
                        Plasma 48, 0, 642, _Height - 1, 0
                    End If
            End Select
        End If
    End If
    If dflag <> 0 Then _Display
End Sub

Sub Quit
    Dim i, x1, x2, y1, y2
    ConfigWrite
    WriteLog false
    If match > 0 Then
        ToFrom 0, "en", match '                                      signal Minimax to terminate
        _Delay 1
    End If
    Close

    If explosion < -1 Then '                                         if image loaded
        _MouseHide
        _MouseMove (mx + 1) Mod _Width, my
        x1 = _Width \ 2 - 250: y1 = _Height \ 2 - 250
        x2 = _Width \ 2 + 250: y2 = _Height \ 2 + 250
        For i = 0 To 48
            Cls
            _PutImage (x1, y1)-(x2, y2), explosion, 0, (_SHL(i Mod 8, 8), _SHL(i \ 8, 8))-Step(255, 255)
            _Display
            _Delay .03
        Next i
    End If

    System
End Sub

Sub QuitWithError (desc$, tfile$)
    _Dest 0
    Sound 222, 2
    Color _RGB32(200, 200, 200), black
    _Font 16
    Cls
    _PrintString (20, 20), desc$ + ": " + tfile$
    _Display
    Sleep
    System
End Sub

Sub ReadBoard ()
    Dim r, c, p, c$, tf
    'dim tf$

    SetupBoard:
    Data r,n,b,q,k,b,n,r
    Data p,p,p,p,p,p,p,p
    Data 0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0
    Data P,P,P,P,P,P,P,P
    Data R,N,B,Q,K,B,N,R

    testing:
    Data 0,K,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0
    Data 0,0,0,Q,0,0,0,0
    Data 0,0,0,0,0,0,0,0
    Data 0,0,0,B,0,N,0,0
    Data 0,0,0,0,0,0,0,0
    Data 0,0,0,0,0,0,0,0
    Data 0,k,0,0,0,0,0,0

    If testing Then
        'tf$ = "testing.txt"
        'IF _FILEEXISTS(tf$) = 0 THEN QuitWithError tf$, "does not exist"
        'tf = FREEFILE
        'OPEN "testing.txt" FOR INPUT AS #tf
        noresign = true
        Restore testing
    Else
        Restore SetupBoard '                                         initial board position
    End If

    For r = 8 To 1 Step -1 '                                         board setup
        For c = 1 To 8
            'IF testing THEN INPUT #tf, c$ ELSE READ c$
            Read c$
            p = InStr("rnbqkp", LCase$(c$)) '                        blank or piece
            If p Then p = p - (c$ = UCase$(c$)) * 8 '                add 8 if uppercase (white)
            b(c, r) = p '                                            put piece on board
            If testing = 0 Then o(c, r) = p '                        original setup
        Next
    Next
    If testing Then Close #tf
End Sub

Sub Recurse (level As _Byte) '                                       heart of program
    Dim mi, tmps
    Dim As _Byte j, lm, s1, s2
    Dim atime As Double

    If (abort > 0) Or (level = masterlevel) Then Exit Sub

    lm = level - 1
    'best(level) = -9999
    For mi = 1 To Moves(lm)
        'mi(level) = move(lm, mi).mi
        j = lm Mod 2
        WorB = SaveWorB * j - (SaveWorB Xor 1) * (j = 0)
        _MemCopy m(0), m(0).OFFSET, m(0).SIZE To m(level), m(level).OFFSET '         store board
        MoveIt move(lm, mi).fc, move(lm, mi).fr, move(lm, mi).tc, move(lm, mi).tr
        CheckBoard level '                                                           evaluate all possible moves
        Recurse level + 1
        TakeBest level, false
        _MemCopy m(level), m(level).OFFSET, m(level).SIZE To m(0), m(0).OFFSET '     restore board
        move(lm, mi).sc = move(lm, mi).sc + move(level, 1).sc * (move(lm, mi).sc <> 777)
        If level = 1 Then

            atime = ExtendedTimer - ClockTime '                      time elapsed
            tcount = mcount(0) + mcount(1) + mcount(2) + mcount(3) + mcount(4) + mcount(5)
            If ocount > 0 Then tmps = (tcount - ocount) / atime
            If tmps > 0 Then mps = tmps
            'If rickfile And (mps > 0) Then Print #rickfile, mps '   mps.txt, long term averaging
            If mps > top_mps Then top_mps = mps: ForRick '           log best mps
            ocount = tcount

            'If (SaveWorB = 1) And (Abs(move(lm, mi).sc) <> 777) Then
            '    move(lm, mi).sc = move(lm, mi).sc + move(lm, mi).os \ 10
            'End If

            WorB = SaveWorB
            MoveIt move(0, mi).fc, move(0, mi).fr, move(0, mi).tc, move(0, mi).tr
            WorB = WorB Xor 1
            MoveIt move(1, 1).fc, move(1, 1).fr, move(1, 1).tc, move(1, 1).tr
            WorB = WorB Xor 1
            CheckBoard 2
            TakeBest 2, false
            MoveIt move(2, 1).fc, move(2, 1).fr, move(2, 1).tc, move(2, 1).tr
            WorB = WorB Xor 1
            CheckBoard 3
            TakeBest 3, false

            'If masterlevel > 4 Then
            '    MoveIt move(3, 1).fc, move(3, 1).fr, move(3, 1).tc, move(3, 1).tr
            '    WorB = WorB Xor 1
            '    CheckBoard 4
            '    TakeBest 4, false
            'End If

            'If masterlevel > 5 Then
            '    MoveIt move(4, 1).fc, move(4, 1).fr, move(4, 1).tc, move(4, 1).tr
            '    WorB = WorB Xor 1
            '    CheckBoard 5
            '    TakeBest 5, false
            'End If

            _MemCopy m(1), m(1).OFFSET, m(1).SIZE To m(0), m(0).OFFSET

            'If SaveWorB = 0 Then move(lm, mi).sc = move(lm, mi).os - move(1, 1).os + move(2, 1).os - move(3, 1).os

            'If SaveWorB = 999 Then
            '    rspecial = (protc(2) - protc(1) + attackc(2) - attackc(1)) \ 1000
            '    move(0, mi).sc = move(0, mi).sc + rspecial
            '    For j = 0 To 3
            '        protc(j) = 0
            '         attackc(j) = 0
            '    Next j
            'End If

            smovest = mi
            thinkv(mi) = move(0, mi).sc
            think$(mi) = " " + Left5$(ToAlg$(0, mi)) + Left5$(ToAlg$(1, 1)) + Left5$(ToAlg$(2, 1)) + Left5$(ToAlg$(3, 1)) + Rjust$(move(0, mi).sc, 4) + Rjust$(move(1, 1).sc, 4) + Rjust$(move(2, 1).sc, 4) + Rjust$(move(3, 1).sc, 4)

            PlotScreen false

            If markers And showthinkingf Then

                s1 = WorB
                s2 = human
                WorB = WorB Xor 1
                human = 1
                ShowValid Abs(move(0, mi).fc), Abs(move(0, mi).fr)
                WorB = s1
                human = s2

                Cursor Abs(move(0, mi).fc), 9 - Abs(move(0, mi).fr), 0
                Cursor Abs(move(0, mi).tc), 9 - Abs(move(0, mi).tr), 1
            End If

            If dosmallboard Then SmallBoard mi

            c1 = Moves(0) - (Moves(0) = 0) '                          prevent /0 next line
            c1 = brx - mi / c1 * (brx - blx)
            If lostfocus Then c2 = black Else c2 = _RGB32(255, 255, 255)
            Line (blx + 2, ym - 22)-(c1, ym - 22), c2
            KeyScan
            If abort Then Exit For
            ClockTime = ExtendedTimer
        End If
    Next mi
End Sub

Sub RemoveIllegal (level As _Byte)
    Dim mi, mj
    Dim As _Byte k, count

    If Moves(level) = 0 Then Exit Sub

    For mi = 1 To Moves(level) '                                      first pass, mark bad
        _MemCopy m(0), m(0).OFFSET, m(0).SIZE To m(8), m(8).OFFSET
        MoveIt move(level, mi).fc, move(level, mi).fr, move(level, mi).tc, move(level, mi).tr

        WorB = WorB Xor 1
        CheckBoard 8
        TakeBest 8, false '                                          level 1, take first of best, repeats ok
        WorB = WorB Xor 1
        If Moves(8) > 0 Then
            If Abs(move(8, 1).sc) = 777 Then move(level, mi).fc = 99
            For mj = 1 To Moves(8) '                                 don't rely on the above line, check ALL moves
                k = b(move(8, mj).tc, move(8, mj).tr) And 7
                If k = King Then move(level, mi).fc = 99
            Next mj
        End If
        _MemCopy m(8), m(8).OFFSET, m(8).SIZE To m(0), m(0).OFFSET
    Next mi

    mi = 0: count = 0 '                                              second pass, collapse array onto bad ones
    Do
        mi = mi + 1
        If (mi + count) > Moves(level) Then Exit Do
        woof:
        If move(level, mi).fc = 99 Then
            For mj = mi To Moves(level)
                move(level, mj) = move(level, mj + 1)
                If level = 0 Then
                    If ssb(mj) < -1 Then
                        _FreeImage ssb(mj)
                        ssb(mj) = 0
                        If ssb(mj + 1) < -1 Then
                            ssb(mj) = _CopyImage(ssb(mj + 1))
                            _FreeImage ssb(mj + 1)
                        End If
                        ssb(mj + 1) = 0
                    End If
                End If
            Next mj
            count = count + 1
            GoTo woof
        End If
    Loop
    Moves(level) = Moves(level) - count '                            fix count
End Sub

Sub Reset_To_Zero
    Fking false '                                                    find kings (did you suspect otherwise?)
    WorB = WorB Xor 1 '                                              reverse who's moving
    CheckBoard 1 '                                                   need to know what opponent can do to ensure legal castling
    TakeBest 1, false '                                              move 777 (King capture) to top of list, if it's there
    WorB = WorB Xor 1 '                                              restore playing color
    CheckBoard 0 '                                                   determine legal moves
    TempMess$ = " "
End Sub

Function Rjust$ (t, n As _Byte)
    If Abs(t) = 777 Then
        Rjust$ = "  ++"
    Else
        Rjust$ = Right$(Space$(n) + Str$(t), n)
    End If
End Function

Sub RotateBoard (rot As _Byte)
    Dim As _Byte i
    Dim w, h, x2, y2, sinr!, cosr!, px(3), py(3)

    If rot = 2 Then '                                                upsidedown
        _PutImage (_Width - 1, _Height - 1)-(0, 0), 0, 0, (0, 0)-(_Width - 1, _Height - 1)
        Exit Sub
    End If

    If inhelp Then
        _PutImage , mscreen, mscreenr
    Else
        _PutImage , mscreen, mscreenr, (tlx - 1, 0)-(brx + 1, _Height - 1)
    End If

    w = _Width(mscreenr)
    h = _Height(mscreenr) - 1
    px(0) = -w \ 2: py(0) = -h \ 2
    px(1) = -w \ 2: py(1) = h \ 2
    px(2) = w \ 2: py(2) = h \ 2
    px(3) = w \ 2: py(3) = -h \ 2
    sinr! = Sin(_D2R(-rot * 90)): cosr! = Cos(_D2R(-rot * 90))
    For i = 0 To 3
        x2 = (px(i) * cosr! + sinr! * py(i)) + _Width \ 2
        y2 = (py(i) * cosr! - px(i) * sinr!) + _Height \ 2
        px(i) = x2: py(i) = y2
    Next

    Cls
    _MapTriangle (0, 0)-(0, h - 1)-(w - 1, h - 1), mscreenr To(px(0), py(0))-(px(1), py(1))-(px(2), py(2))
    _MapTriangle (0, 0)-(w - 1, 0)-(w - 1, h - 1), mscreenr To(px(0), py(0))-(px(3), py(3))-(px(2), py(2))
End Sub

'Sub R_T_C '                                                         Dallas 1307 Real Time Clock
'    Dim hh, t$
'
'    t$ = Left$(Time$, 2)
'    hh = Val(t$)
'    If hh > 12 Then t$ = Right$("0" + LTrim$(Str$(hh - 12)), 2)
'    t$ = t$ + Right$(Time$, 6)
'    Line (xc - 18, tly - 1)-(xc + 18, tly - 8), zip, BF
'    TinyFont t$, xc - 16, 27, clockc
'End Sub

Sub ScoresOnBoard Static '                                           nifty-neato diagnostics invoked with \
    Dim mi, p, z, i, j, r, c, x, y, k(6) As _Unsigned Long, waituntil As Double, nu(8, 8)

    k(1) = _RGB32(170, 170, 0) '                                     rook
    k(2) = _RGB32(0, 110, 0) '                                       knight
    k(3) = _RGB32(0, 0, 255) '                                       bishop
    k(4) = _RGB32(255, 255, 255) '                                   queen
    k(5) = _RGB32(80, 0, 80) '                                       king
    k(6) = _RGB32(22, 22, 22) '                                      pawn

    begin:
    Erase nu '                                                       counter for each square, determines "print" row
    For p = 1 To 6
        z = Val(Mid$("412356", p, 1)) '                              the order *I* want, queen/rook/knight/bishop/king/pawn
        For mi = 1 To Moves(0)
            c = Abs(move(0, mi).fc) '                                 column
            r = Abs(move(0, mi).fr) '                                 row
            If z <> (b(c, r) And 7) Then _Continue
            If mi = 1 Then '                                          put red box around piece about to move
                If invert = 1 Then c = 9 - c: r = 9 - r
                x = tlx + (c - 1) * xq
                y = bly - r * yq
                For j = 1 To 4
                    Line (x + j, y + j)-(x + xq - j, y + yq - j), green, B
                Next j
            End If
            c = Abs(move(0, mi).tc) '                                 column
            r = Abs(move(0, mi).tr) '                                 row
            If invert Then c = 9 - c: r = 9 - r
            x = tlx + (c - 1) * xq + 2
            y = bly - r * yq + 2 + nu(c, r) * 11
            If mi = 1 Then '                                          red, make it stand out
                Color _RGB32(200, 20, 20), zip
            Else
                Color k(z), _RGBA(0, 0, 0, 20)
                If mi < 4 Then
                    SetFont 10
                    _PrintString (x + xq - 10, y), CHRN$(i)
                End If
            End If
            SetFont 12
            _PrintString (x, y), Mid$("RNBQKP", z, 1) + LTrim$(Str$(move(0, mi).sc - move(0, Moves(0)).sc * 0))
            _PrintString (x, y + 20), Str$(ksv(c, r))
            nu(c, r) = nu(c, r) + 1
        Next mi
    Next p
    waituntil = ExtendedTimer + 5

    SetFont defaultfontsize
    If dev Then _PrintString (tlx, 10), LTrim$(Str$(CanMove(0))) + Str$(CanMove(1))

    Do: _Limit 10
        KeyScan
        If i$ = Enter$ Then Exit Do
        If Len(i$) Then GoTo begin
    Loop Until (sob = 0) Or ((sob = 2) And (ExtendedTimer > waituntil))
End Sub

Sub ScreenInit
    Dim i, scx, scy

    ' Worldwide desktop stats
    ' 1920x1080 21.04
    ' 1366x768  20.48
    ' 1536x864  10.05
    ' 1440x900   6.17
    ' 1280x720   5.79
    ' 1600x900   3.68

    If (NoChangeUntil > 0) And (ExtendedTimer < NoChangeUntil) Then Exit Sub

    xm = 480
    ym = 600
    scx = 800
    scy = 600

    If mscreen < -1 Then
        Screen 0
        _FreeImage mscreen
    End If
    mscreen = _NewImage(scx, scy, 32)
    Screen mscreen
    Do: _Limit 10: Loop Until _ScreenExists

    Do
        If fullscreenflag > 0 Then
            If fullscreenflag = 2 Then
                _FullScreen _SquarePixels , _Smooth
            Else
                _FullScreen _Stretch , _Smooth
            End If
        Else
            _FullScreen _Off
        End If
        _Delay .2
    Loop Until fullscreenflag = _FullScreen

    While _Resize
        _Delay .1
    Wend

    If fullscreenflag = 0 Then
        For i = 0 To 4
            _ScreenMove (_DesktopWidth - _Width) \ 2, 25
            _Delay .1
        Next i
    End If

    If tlx > 0 Then
        If mscreenr < -1 Then _FreeImage mscreenr
        If _FullScreen Then i = _Height Else i = _Height * 1.33
        mscreenr = _NewImage((trx - tlx) * 1.64, i)
    End If

    If pregame = false Then PlotScreen false
    NoChangeUntil = ExtendedTimer + 2
End Sub

DefSng A-Z
Sub Serp
    Dim i, xinit, ho, tx, ty, a, b, h, sp, ps, tp, x, y, tb
    Dim tc As _Unsigned Long, st(10)
    GoSub 100
    Exit Sub

    100: ho = 598: sp = 0: h = ho / 4: x = 2 * h: y = 3 * h: i = 0
    110: i = i + 1: x = x - h: h = h / 2: y = y + h: If i < 6 Then GoTo 110
    ps = i: GoSub 600
    GoSub 200: a = h: b = -h: GoSub 800
    GoSub 300: a = -h: b = -h: GoSub 800
    GoSub 400: a = -h: b = h: GoSub 800
    GoSub 500: a = h: b = h: GoSub 800
    GoSub 700
    Return
    200: If tp <= 0 Then Return
    ps = tp - 1: GoSub 600
    GoSub 200: a = h: b = -h: GoSub 800
    GoSub 300: a = 2 * h: b = 0: GoSub 800
    GoSub 500: a = h: b = h: GoSub 800
    GoSub 200: GoSub 700
    Return
    300: If tp <= 0 Then Return
    ps = tp - 1: GoSub 600
    GoSub 300: a = -h: b = -h: GoSub 800
    GoSub 400: a = 0: b = -2 * h: GoSub 800
    GoSub 200: a = h: b = -h: GoSub 800
    GoSub 300: GoSub 700
    Return
    400: If tp <= 0 Then Return
    ps = tp - 1: GoSub 600
    GoSub 400: a = -h: b = h: GoSub 800
    GoSub 500: a = -2 * h: b = 0: GoSub 800
    GoSub 300: a = -h: b = -h: GoSub 800
    GoSub 400: GoSub 700
    Return
    500: If tp <= 0 Then Return
    ps = tp - 1: GoSub 600
    GoSub 500: a = h: b = h: GoSub 800
    GoSub 200: a = 0: b = 2 * h: GoSub 800
    GoSub 400: a = -h: b = h: GoSub 800
    GoSub 500: GoSub 700
    Return
    600: sp = sp + 1: st(sp) = ps: tp = ps
    Return
    700: sp = sp - 1: tp = st(sp)
    Return
    800:
    tx = 10 + (x + a) * 1.3
    ty = 34 + y + b
    tb = 220 * Cos(_D2R(ty / _Height * 90))
    tc = Point(1, 500)
    tc = _RGBA(_Red32(tc) \ 2, _Green32(tc) \ 2, _Blue32(tc) \ 1, tb)
    If xinit = 0 Then PSet (tx, ty), tc: xinit = 1
    Line -(tx, ty), tc
    x = x + a: y = y + b
    Return
End Sub

DefLng A-Z
Sub SetFont (fontsize As _Byte)
    If myfont(fontsize) < 1 Then QuitWithError "Font", Str$(fontsize)
    _Font myfont(fontsize)
End Sub

Sub SetScheme
    Dim a, c1, c2, c3, ct, ps, g, st, was

    was = piece_style
    st = 1 '                                                                       single line box for most schemes

    Select Case scheme
        Case 0: a = 0: bgc = 2: c1 = 24: c2 = 25: c3 = 5: ct = 1: ps = 9: g = 2 '         gray/dark gray on blue, black font clock, plasma bl sq
        Case 1: a = 1: bgc = 2: c1 = 26: c2 = 13: c3 = 4: ct = 1: ps = 8: g = 3: st = 3 ' white/purple on blue, white 7 seg clock, plasma ALL sq
        Case 2: a = 2: bgc = 5: c1 = 19: c2 = 20: c3 = 5: ct = 1: ps = 7: g = 3: st = 2 ' cream/brown on white,  black 7 seg clock, plasma ALL sq
        Case 3: a = 3: bgc = 0: c1 = 26: c2 = 25: c3 = 5: ct = 1: ps = 9: g = 2 '         white/dark gray on red, black 7 segment clock, plasma bl sq
        Case 4: a = 0: bgc = 4: c1 = 17: c2 = 20: c3 = 2: ct = 2: ps = 6: g = 3: st = 0 ' yellow/brown with Nixie, plasma all squares, plasma ALL sq
        Case 5: a = 1: bgc = 5: c1 = 24: c2 = 30: c3 = 0: ct = 0: ps = 2: g = 0 '         gray/white on white, red font clock, plasma off
        Case 6: a = 2: bgc = 4: c1 = 17: c2 = 25: c3 = 4: ct = 0: ps = 4: g = 3 '         flame/dk gray on yellow, white font clock, plasma ALL sq
        Case 7: a = 3: bgc = 2: c1 = 10: c2 = 11: c3 = 3: ct = 0: ps = 3: g = 3 '         gunmetal/sky blue on blue, blue font clock, plasma ALL sq
        Case 8: a = 0: bgc = 3: c1 = 10: c2 = 14: c3 = 4: ct = 1: ps = 6: g = 1 '         gunmetal/dark purple on cyan, black font clock, plasma wh sq
        Case 9: a = 1: bgc = 1: c1 = 26: c2 = 23: c3 = 0: ct = 0: ps = 8: g = 3: st = 3 ' white/green on green, red font clock, plasma ALL sq
        Case 10: a = 2: bgc = 0: c1 = 13: c2 = 25: c3 = 5: ct = 1: ps = 8: g = 3: st = 3 'lt pur/dk gray on red,black 7 seg clock, plasma ALL sq
        Case 11: a = 3: bgc = 0: c1 = 27: c2 = 25: c3 = 4: ct = 0: ps = 0: g = 3 '        pink/dk gray on red, white font clock, plasma ALL sq
    End Select

    colori1 = c1 - 10
    colori2 = c2 - 10
    colori3 = c3
    clocktype = ct
    piece_style = ps
    graphics = g
    squaretrim = st
    altbg = a

    ColorSet
    If piece_style <> was Then LoadPieces piece_style
End Sub

Sub Settings Static
    Dim i, j, se, wasse, xw, x1, x2, y1, y2, yw, xx0, xx1, yy1, kk, t$, arrows$, shortcut$, mi$(30), se$(30)
    Dim z1, z2, mz1, smx, smy, obri, exitn, tscreen, tscreen2, sfontsize, xbox, freeze
    Dim As _Unsigned Long twhite, tgray

    If xmas Then '                                                   enough of the red/green blinking squares already!
        xmas = false
        graphics = true
        ColorSet
    End If

    If inhelp Or insettings Then Exit Sub

    insettings = true

    istuff$ = " "
    tgray = _RGB32(80, 80, 80)
    twhite = _RGB32(200, 200, 200)

    exitn = 23 '
    sfontsize = 9 '                                              larger and the pieces on the home row are obscured
    SetFont sfontsize
    xw = 16 * _PrintWidth("z") '                                 x width
    z2 = _FontHeight + _FontHeight \ 3 '                         line spacing
    yw = z2 / 2 * (exitn + 2) '                                  y width

    x1 = xc - xw '                                               box left
    x2 = xc + xw '                                               box right

    y1 = _Height \ 2 - yw - 40 '                                 box top
    y2 = _Height \ 2 + yw - 40 '                                 box bottom

    z1 = y1 '                                                    1st line y
    arrows$ = Chr$(17) + Chr$(16) '                              left and right arrow
    mz1 = x2 - 4 - _PrintWidth(arrows$)

    mi$(Val("01")) = "White squares:"
    mi$(Val("02")) = "Black squares:"
    mi$(Val("03")) = "  Clock color:"
    mi$(Val("04")) = "   Background:"
    mi$(Val("05")) = "     BG Color:"
    mi$(Val("06")) = "   Clock type:"
    mi$(Val("07")) = "     Graphics:"
    mi$(Val("08")) = "   Brightness:"
    mi$(Val("09")) = "    Chess set:"
    mi$(Val("10")) = "  Square trim:"
    mi$(Val("11")) = "       Invert:"
    mi$(Val("12")) = " Mouse cursor:"
    mi$(Val("13")) = "       Legend:"
    mi$(Val("14")) = "      Logging:"
    mi$(Val("15")) = "      Markers:"
    mi$(Val("16")) = "   Move clock:"
    mi$(Val("17")) = "       Sounds:"
    mi$(Val("18")) = "  Mouse click:"
    mi$(Val("19")) = "   Hover move:"
    mi$(Val("20")) = "     Rotation:"
    mi$(Val("21")) = "  Board setup:"
    mi$(Val("22")) = "File playback:"
    mi$(Val("23")) = "Exit"

    For se = 1 To exitn
        GoSub curset
    Next se
    se = 0

    startover:

    PlotScreen false
    Line (x1, y1)-(x2, y2), _RGBA(0, 0, 0, 230), BF '            dim area for menu
    'Line (0, _Height - 19)-(_Width - 1, _Height - 1), black, BF
    If _FullScreen Then nbox = 4 Else nbox = 0

    For i = 1 To exitn
        SetFont sfontsize
        xx0 = xc + 8 '                                           just left of the colon
        If i < exitn Then
            xx1 = xx0 - _PrintWidth(mi$(i)) - 6 '                where description goes
            yy1 = z1 + i * z2
        Else '                                                   exit
            xx1 = xc - _PrintWidth("Exit") / 2 '                 centered
            yy1 = y2 - 20 '                                      lower than general items
        End If

        For j = 1 To 2
            nbox = nbox + 1
            mfx1(nbox) = mz1 + (j - 1) * 10 + 1
            mfx2(nbox) = mfx1(nbox) + 10
            mfy1(nbox) = yy1
            mfy2(nbox) = yy1 + 12
            mft$(nbox) = Chr$(0) + Chr$(77 + (j = 1) * 2) '      left or right arrow
        Next j
        xbox = nbox
        chimp = nbox

        Color tgray, zip
        _PrintString (xx1, yy1), mi$(i) '                        description
        Color twhite, zip
        _PrintString (xx0, yy1), se$(i) '                        setting
        Color tgray, zip
        _PrintString (mz1, yy1), arrows$ '                       arrows
    Next i

    If tscreen < -1 Then _FreeImage (tscreen)
    tscreen = _CopyImage(0)
    If se = 0 Then
        PlotScreen false
        WindowEffect 0, tscreen, x1, y1, x2, y2 '                0zoom 1unfold 2random 3fade
        se = 1
    End If

    _PutImage , tscreen, 0

    shortcut$ = " "
    If se = 6 Then '                                             clock type
        shortcut$ = "Shortcut :  c or t"
    ElseIf se = 8 Then '                                         brightness
        shortcut$ = "Shortcut :  F4-  F5+"
    ElseIf se = 9 Then '                                         set (10 to choose from)
        If piece_style Then
            shortcut$ = "z to see all sets"
        Else
            shortcut$ = "Z to see all pictures"
        End If
    ElseIf (se = 10) And (piece_style = 0) Then '                square trim (4 choices)
        shortcut$ = "Inactive for funny set"
    ElseIf se = 11 Then '                                        invert board or pieces for human vs human
        shortcut$ = "for Human vs Human play"
    ElseIf se = 20 Then '                                        rotation
        shortcut$ = "Shortcut :  F11-  F12+"
    ElseIf se < exitn Then '                                     mention short key, if any
        '          123456789012345678901
        t$ = Mid$("12354c   B Cl men H  F ", se, 1)
        If t$ <> " " Then shortcut$ = "Shortcut :  " + t$
    End If

    SetFont sfontsize
    If se < exitn Then
        xx1 = xx0 - _PrintWidth(mi$(se)) - 6 '                   where description goes
        yy1 = z1 + se * z2
    Else '                                                       exit
        xx1 = xc - _PrintWidth("Exit") / 2 '                     centered
        yy1 = y2 - 20 '                                          lower than general items
    End If
    Line (x1 + 4, yy1 - 3)-(x2 - 4, yy1 + _FontHeight), tgray, BF
    ShadowPrint xx1, yy1, mi$(se), twhite '                      description
    ShadowPrint xx0, yy1, se$(se), twhite '                      setting
    ShadowPrint mz1, yy1, arrows$, twhite '                      arrows

    _PutImage (blx, bly + 20)-(brx, _Height - 20), bgi, 0, (blx, bly + 20)-(brx, _Height - 20)
    If tscreen2 < -1 Then _FreeImage (tscreen2)
    tscreen2 = _CopyImage(0)

    Do: _Limit mloop
        _PutImage , tscreen2, 0
        i$ = InKey$
        If dev And (i$ = "q") Then Quit
        If i$ = "z" Then ShowSets: Exit Do
        If i$ = "Z" Then ShowFunny: Exit Do
        smx = mx: smy = my

        TempMess$ = shortcut$ + s$
        AboveBoardInfo
        GraphLoad
        Clocks
        nbox = chimp
        MouseIn
        If Len(istuff$) Then i$ = istuff$: istuff$ = ""
        If (b1 Or b2) And (mx > x1) And (mx < x2) And (my > y1) And (my < y2) Then i$ = Enter$

        If freeze Then
            freeze = false
            smx = mx
            smy = my
        End If

        If (mx <> smx) Or (my <> smy) Then
            wasse = se
            If (mx > x1) And (mx < x2) And (my > y1) And (my < y2) Then ' mouse in box?
                se = (my - z1) \ z2
                If se < 1 Then se = 1
                If se > exitn Then se = exitn '                  select exit
                If se <> wasse Then Exit Do
            End If
        End If
    Loop Until Len(i$)

    If (i$ = "e") Or (i$ = Esc$) Then GoTo done
    If i$ = Enter$ Then
        If se = exitn Then GoTo done '                           Enter on Exit
        i$ = Chr$(0) + Chr$(77) '                                xlate Enter to right arrow
    End If

    If Len(i$) = 2 Then
        kk = Asc(i$, 2)
        se = se + (kk = 72) - (kk = 80) '                        up and down arrow move between menu items
        If se < 1 Then se = exitn '                              wraparound
        If se > exitn Then se = 1
        If (kk = 72) Or (kk = 80) Then GoTo startover
        kk = (kk = 75) - (kk = 77) '                             left and right change highlighted item
        If kk <> 0 Then
            Select Case se
                Case 1 '                                         white squares
                    colori1 = colori1 + kk
                    If colori1 < 0 Then colori1 = 21
                    If colori1 > 21 Then colori1 = 0
                    ColorSet
                Case 2 '                                         black squares
                    colori2 = colori2 + kk
                    If colori2 < 0 Then colori2 = 21
                    If colori2 > 21 Then colori2 = 0
                    ColorSet
                Case 3 '                                         clock color
                    colori3 = colori3 + kk
                    If colori3 < 0 Then colori3 = 5
                    If colori3 > 5 Then colori3 = 0
                    ColorSet
                Case 4 '                                         background type
                    altbg = altbg + kk
                    If altbg < 0 Then altbg = bgmax
                    If altbg > bgmax Then altbg = 0
                    ColorSet
                Case 5 '                                         background color
                    bgc = bgc + kk
                    If bgc < 0 Then bgc = 5
                    If bgc > 5 Then bgc = 0
                    ColorSet
                Case 6
                    clocktype = clocktype + kk
                    If clocktype < 0 Then clocktype = 2
                    If clocktype > 2 Then clocktype = 0
                Case 7 '                                         plasma effect
                    graphics = graphics + kk '                   0 off, 1 white, 2 black, 3 all squares
                    If graphics < 0 Then graphics = 3
                    If graphics > 3 Then graphics = 0
                    plasma_init = false '                        generate new parameters
                Case 8 '
                    obri = bri
                    bri = bri + kk
                    If bri < 1 Then bri = 1
                    If bri > 4 Then bri = 4
                    If bri <> obri Then
                        ColorSet
                        Erase sloaded
                        allsetsloaded = false
                        LoadPieces piece_style
                    End If
                Case 9
                    piece_style = piece_style + kk
                    If piece_style < 0 Then piece_style = 9
                    If piece_style > 9 Then piece_style = 0
                    LoadPieces piece_style
                    lpoints = -1
                Case 10 '                                        square borders
                    If piece_style Then '                        inactive for set 0 (funny)
                        squaretrim = squaretrim + kk * Sgn(piece_style)
                        If squaretrim < 0 Then squaretrim = 3
                        If squaretrim > 3 Then squaretrim = 0
                    End If
                Case 11 '                                        invert type
                    binvert = binvert Xor 1
                Case 12
                    cursortype = cursortype + kk
                    If cursortype < 0 Then cursortype = 3
                    If cursortype > 3 Then cursortype = 0
                    _MouseShow RTrim$(Mid$("LINK     CROSSHAIRTEXT     DEFAULT  ", cursortype * 9 + 1, 9))
                    _MouseMove 1, 1
                    _MouseMove mx, my
                Case 13 '                                        1-8 on left, a-h at bottom
                    legend = legend Xor 1
                Case 14 '     true                               flag for saving game to disk
                    logging = logging Xor 1
                Case 15 '                                        highlight last move
                    markers = markers Xor 1
                Case 16 '                                        time of current move
                    smallclock = smallclock Xor 1
                Case 17 '                                        sounds
                    makenoise = makenoise Xor 1
                    LoadSounds
                    If makenoise Then
                        PlaySound sfile(1) '                     play intro music
                    Else
                        click = false
                        If _SndPlaying(sfile(1)) < 0 Then _SndStop sfile(1) '       stop intro music
                    End If
                Case 18 '     =                                  move click
                    click = click Xor 1
                    If (makenoise = 0) And (click = 1) Then
                        makenoise = true
                        PlaySound sfile(1) '                     play intro music
                    End If
                Case 19 '                                        move by hovering over square
                    hover = hover Xor 1
                Case 20 '                                        rotation
                    rotate = rotate + kk
                    If rotate < 0 Then rotate = 3
                    If rotate > 3 Then rotate = 0
                    freeze = true
                Case 21 '                                        testing, doing a problem, cheating, whatever
                    If rflag Then '                              disallow board setup while computer moving
                        TempMess$ = "Thinking!"
                        AboveBoardInfo
                        DisplayMaster true
                        _Delay .5
                    Else
                        insettings = false
                        Setup
                        redoflag = 1
                        GoTo done
                    End If
                Case 22 '                                        replay of stored game
                    If rflag Then '                              disallow while computer moving
                        TempMess$ = "Thinking!"
                        AboveBoardInfo
                        DisplayMaster true
                        _Delay .5
                    Else
                        insettings = false
                        PlotScreen false
                        PlayFile
                        ClearBuffers
                        GoTo done
                    End If
                Case 23 '                                        exit
                    GoTo done
            End Select
        End If
    End If
    GoSub curset
    GoTo startover

    done:
    oply = false
    chimp = 0
    nbox = 0
    TempMess$ = " "
    ClearBuffers
    insettings = false
    PlotScreen true
    Exit Sub

    curset:
    Select Case se
        Case 1: t$ = ColorDesc$(colori1 + 10) '                                                 white squares color
        Case 2: t$ = ColorDesc$(colori2 + 10) '                                                 black squares color
        Case 3: t$ = Mid$("Red    Green  Yellow Blue   White  Black  ", colori3 * 7 + 1, 7) '   clock color
        Case 4: t$ = Mid$("HexagonSquaresSierp  Shaded Off    CheetosF-loops", altbg * 7 + 1, 7) '     background type
        Case 5: t$ = Mid$("Red   Green Blue  Cyan  YellowWhite ", bgc * 6 + 1, 6) '             background color
        Case 6: t$ = RTrim$(Mid$("Font      7 segment Nixie tube", clocktype * 10 + 1, 10)) '   clock type: 0 font 1 7-seg 2 Nixie
        Case 7: t$ = Mid$("OFF   W Sq  B Sq  All sq", graphics * 6 + 1, 6) '                    plasma graphics off/white sq/black sq/both
        Case 8: t$ = LTrim$(Str$(bri)) + " of 4" '                                              brightness
        Case 9: t$ = LTrim$(Str$(piece_style + 1)) + " of 10" '                                 set selection 1funny 2ugly 3 best...
        Case 10: t$ = Mid$("OFF   SingleDoubleFancy ", squaretrim * 6 + 1, 6) '                  square trim style
        Case 11: t$ = LTrim$(Mid$("ScreenBoard ", binvert * 6 + 1, 6)) '                        invert board or pieces for human vs human
        Case 12: t$ = RTrim$(Mid$("Link  Cross Text  Arrow ", cursortype * 6 + 1, 6)) '         cursor type
        Case 13: t$ = OnOff(legend) '                                                           a-h at bottom, 1-8 along left side
        Case 14: t$ = OnOff(logging) '                                                          save game to disk file chNNNNNN.alg
        Case 15: t$ = OnOff(markers) '                                                          highlight last move
        Case 16: t$ = OnOff(smallclock) '                                                       elapsed time current move
        Case 17: t$ = OnOff(makenoise) '                                                        sound in general
        Case 18: t$ = OnOff(click) '                                                            mouse button noise
        Case 19: t$ = OnOff(hover) '                                                            move by hovering over square
        Case 20: t$ = Mid$("OFF-9018090 ", rotate * 3 + 1, 3) '                                 vacuum cleaner
        Case 21: t$ = "SET" '                                                                   create board position
        Case 22: t$ = "FILE" '                                                                  file playback
        Case 23: t$ = "" '                                                                      toodaloo
    End Select
    se$(se) = t$
    Return
End Sub

Sub Setup
    Dim i, j, ps, p, kc, x, y, z, xs, ys, tx, xx, yy, t$, mx1(14), mx2(14), my1(14), my2(14), ic(1) '

    invert = 0
    xs = 32: ys = xs '                                                         size of pieces shown here
    insetup = true '                                                           flag for other SUBs
    Do: _Limit 10
        _PutImage , bgi, 0
        GraphLoad
        For i = 0 To 1
            WorB = i
            Reset_To_Zero
            Fking false '                                                      counts up the pieces
            ic(i) = incheck
        Next i
        WorB = 1
        _MemCopy m(0), m(0).OFFSET, m(0).SIZE To m(10), m(10).OFFSET '         working b() to display board b2()
        PlotBoard '                                                            squares & contents
        If graphics Then Plasma tlx, tly, trx, bly, 0 '                        marble effect on board
        GoSub piece_menu '                                                     6 black on top, 6 white on bottom

        Color gray, black
        SetFont 12
        t$ = "Place: Click piece then square    Clear: Click square"
        tx = xc - _PrintWidth(t$) \ 2
        ShadowPrint tx, _Height - _FontHeight * 4, t$, white
        kc = -(pcount(0, King) = 1) - (pcount(1, King) = 1) '                  enforce one King per side
        t$ = " Clear    Full" + s$ + "set    Random    Esc" + s$ + "to" + s$ + "exit "
        Center 0, t$, true, false
        GoSub selectpiece '                                                    selecting a square clears it
        If ps > 0 Then GoSub showmoving '                                      piece selected, show at mouse cursor
        KeyScan

        If b1 Or b2 Then '                                                     mouse button left or right
            xx = (mx - tlx + hxq - 1) / xq
            yy = (my - tly + hyq - 1) / yq
            If (xx > 0) And (xx < 9) And (yy > 0) And (yy < 9) Then '          on the board
                b(xx, 9 - yy) = ps '                                           put piece on board
                _Delay .25 '                                                   try to prevent immediately clearing the square
            End If
            ps = 0 '                                                           clear piece selected
        End If
        If i$ = "" Then i$ = "*" '                                             unwise to use instr with null
        If InStr("eE", i$) Then i$ = Esc$ '                                    says (E)sc on screen, translate to Esc
        If i$ = "c" Then Erase b
        If i$ = "f" Then ReadBoard
        If i$ = "r" Then GoSub RandomPosition
        If i$ = Esc$ Then '                                                    wants to leave
            If kc <> 2 Then '                                                  doesn't have 1 King per side
                Line (0, bly + xs + 3)-(_Width - 1, _Height - 20), black, BF
                t$ = "One King per side"
                _PrintString (cx(t$), _Height - _FontHeight * 4), t$
                PlaySound illegal
                DisplayMaster true
                _Delay 2
            ElseIf (ic(0) = true) And (ic(1) = true) Then '                    both Kings in check
                Line (0, bly + xs + 3)-(_Width - 1, _Height - 20), black, BF
                t$ = "Both Kings in check"
                _PrintString (cx(t$), _Height - _FontHeight * 4), t$
                PlaySound illegal
                DisplayMaster true
                _Delay 2
                kc = 0 '                                                       King count
            End If
        End If
    Loop Until (i$ = Esc$) And (kc = 2)

    insetup = false
    _Delay .2 '                                                                try to prevent user selecting W/B by accident

    castle$ = "****"
    check = 0
    incheck = 0
    drawcount = 0
    perpetual = 0
    readonly = true
    noresign = true
    move = 0
    Erase mlog$
    start = ExtendedTimer
    Erase etime

    GetWB
    WorB = humanc '                                                  assume it's my move
    If (humanc = 0) And ic(1) Then WorB = 1 '                        want black, white in check, must be white's move
    If (humanc = 1) And ic(0) Then WorB = 0 '                        want white, black in check, must be black's move

    SaveWorB = WorB
    If WorB = 0 Then '                                               black to move, put a spacer in the log for white
        WorB = 1
        m$ = " "
        AddLog
        WorB = 0
    End If
    nbox = chimp
    Exit Sub

    RandomPosition:
    Do
        Erase b
        For i = 0 To 1
            z = i * 8
            For j = 10 To 1 Step -1
                p = Rnd * 5 + 1 + z
                If ((p And 7) = King) Or (Rnd > .4) Then p = 0
                If Rnd > .7 Then p = Pawn + z
                If j = 1 Then p = King + z
                nr:
                xx = Rnd * 7 + 1
                yy = Rnd * 7 + 1
                If b(xx, 9 - yy) Then GoTo nr
                If (p = Pawn + 0) And (yy > 7) Then p = 0 '                    black pawn on rank 8
                If (p = Pawn + 0) And (yy < 2) Then p = 0 '                    black pawn on rank 1
                If (p = Pawn + 8) And (yy < 2) Then p = 0 '                    white pawn on rank 1
                If (p = Pawn + 8) And (yy > 7) Then p = 0 '                    white pawn on rank 8
                b(xx, 9 - yy) = p
            Next j
        Next i
        Fking false
        kc = -(pcount(0, King) = 1) - (pcount(1, King) = 1)
        If (Abs(wkr - bkr) < 2) And (Abs(wkc - bkc) < 2) Then kc = 0
    Loop Until kc = 2
    Return

    showmoving:
    z = PieceSize(ps) '                                                        piece size adjustments
    _PutImage (mx - hxq + z, my - hyq + z)-(mx + hxq - z, my + hyq - z), pix(piece_style, ps), 0
    Return

    selectpiece:
    For i = 0 To 1 '                                                           black (top), white (bottom)
        For j = 1 To 6 '                                                       RNBQKP
            p = i * 8 + j '                                                    add 8 for white
            If (mx > mx1(p)) And (mx < mx2(p)) And (my > my1(p)) And (my < my2(p)) Then ' mouse on this piece?
                Line (mx1(p), my1(p))-(mx2(p), my2(p)), white, B '             box around piece where mouse is
                If b1 Or b2 Then _Delay .25: ps = p '                          piece selected by mouse button
            End If
        Next j
    Next i
    Return

    piece_menu:
    For i = tlx + 1 To trx - 1
        j = 200 - Abs((tlx + trx) \ 2 - i)
        If j < 0 Then j = 0
        If pcount(0, King) = 1 Then c1 = _RGB32(0, j, 0) Else c1 = _RGB32(j, 0, 0) ' green for ok, red for not
        Line (i, 0)-(i, try - 1), c1
        If pcount(1, King) = 1 Then c1 = _RGB32(0, j, 0) Else c1 = _RGB32(j, 0, 0) '
        Line (i, bly + 1)-(i, bly + xs + 2), c1
    Next i
    If _FullScreen Then Buttons 0, 0
    For i = 0 To 1 '                                                           black, white
        If i Then '                                                            white
            y = bly + 2 '                                                      below board
            j = points(1) - points(0)
        Else '                                                                 black
            y = 1 '                                                            above board
            j = points(0) - points(1)
        End If
        If pcount(i, King) = 1 Then c1 = green Else c1 = red
        Color c1, zip
        t$ = LTrim$(Str$(j))
        If ic(i) Then t$ = t$ + ", in check"

        SetFont 10
        ShadowPrint tlx + 8, y + 11, t$, white

        For j = 1 To 6 '                                                       RNBQKP
            p = i * 8 + j '
            x = xc + (j - 4) * (xs + 2)
            _PutImage (x, y)-(x + xs, y + ys), pix(piece_style, p), 0 '        show piece
            mx1(p) = x '                                                       save location so mouse can find it
            mx2(p) = x + xs '
            my1(p) = y '
            my2(p) = y + ys '
        Next j
    Next i
    Return
End Sub

Sub SetupBoard
    ReadBoard
    drawcount = 0
    If testing Then move = 20 Else move = 0
    perpetual = 0
End Sub

Sub ShowBolt ()
    Static binit, i
    Dim tempimg, f$

    If insettings Then Exit Sub

    If barebones And (promoting = false) Then
        If onplayback Then
            boltx1 = blx + 10
        Else
            boltx1 = xc - 15
        End If
        bolty1 = bly + 30
    Else
        boltx1 = tlx - 60
        bolty1 = bly - 102
    End If
    boltx2 = boltx1 + 30
    bolty2 = bolty1 + 30

    If binit = false Then
        For i = 0 To 1
            f$ = datapath$ + "lb\lb" + Chr$(48 + i) + ".png"
            If _FileExists(f$) = 0 Then QuitWithError "bolt", "fnf " + f$
            tempimg = _LoadImage(f$)
            If tempimg >= -1 Then QuitWithError "bolt", "load image"
            bolt(i) = _NewImage(31, 31, 32)
            _PutImage , tempimg, bolt(i)
            _Source bolt(i)
            cc(i) = Point(0, 0)
            _Source 0
            _FreeImage tempimg
        Next i
        binit = true
    End If

    _ClearColor cc(barebones), bolt(barebones)
    _PutImage (boltx1, bolty1)-(boltx2, bolty2), bolt(barebones), 0
End Sub

Sub ShadowBox (x1, y1, x2, y2)
    Line (x2 + 1, y1)-(x2 + 1, y2 + 1), black '                  right side
    Line (x1 + 1, y2 + 1)-(x2 + 1, y2 + 1), black '              underneath
End Sub

Sub ShadowPrint (x, y, t$, tcm As _Unsigned Long)
    'TimeTrack "ShadowPrint", 1
    If tcm <> black Then
        Color black, zip
        _PrintString (x + 1, y + 1), t$
        _PrintString (x + 2, y + 1), t$
    End If
    Color tcm, zip
    _PrintString (x, y), t$
    'TimeTrack "ShadowPrint", 0
End Sub

Sub ShowFunny
    Dim i, n, ti, xs, xq, yq, x, y, sf, tscreen, p$, t$

    Cls
    _Display
    sf = fullscreenflag
    inshow = 2
    xm = 1280: ym = 768 '                                            room for 112 pictures

    tscreen = _NewImage(xm, ym, 32)
    Screen tscreen
    Do: _Limit 10: Loop Until _ScreenExists
    For i = 0 To 4
        _FullScreen _Stretch , _Smooth
    Next i
    x = (_DesktopWidth - _Width) \ 2
    y = (_DesktopHeight - _Height) \ 2
    For i = 0 To 4
        _ScreenMove x, y
    Next i
    Cls
    Buttons 0, 0

    xs = 40: x = xs: y = 30: xq = 85: yq = 76
    SetFont 10
    For i = 1 To 6
        p$ = RTrim$(Mid$("rook  knightbishopqueen king  pawn  ", (i - 1) * 6 + 1, 6))
        n = 0
        Do
            n = n + 1
            f$ = UCase$(datapath$ + "sfunny" + slash + p$ + LTrim$(Str$(n)) + ".jpg")
            If _FileExists(f$) = 0 Then Exit Do
            fload:
            ti = _LoadImage(f$)
            If ti >= -1 Then _Delay .1: GoTo fload '                 load fail
            _PutImage (x, y)-(x + xq, y + yq), ti, 0
            DisplayMaster true
            If i = 2 Then t$ = "N" Else t$ = p$ '                    change K to N for knight
            t$ = UCase$(Left$(t$, 1)) + Str$(n)
            Color _RGBA(0, 0, 0, 255), zip
            _PrintString (x, y), t$ '                                print in black at top left
            Color _RGBA(255, 255, 255, 255), zip
            _PrintString (x + xq - _PrintWidth(t$), y), t$ '         print in white at top right
            x = x + xq
            If (x + xq) > xm Then
                x = xs
                y = y + yq
                If (y + yq) > ym Then GoTo done
            End If
        Loop
    Next i
    done:

    SetFont 18
    Color white, black
    t$ = "Cycle images in play with spacebar"
    SetFont 14
    x = _Width \ 2 - _PrintWidth(t$) \ 2 + 8
    _PrintString (x, _Height - 36), t$
    AnyKey

    Cls
    _Display
    Screen 0
    _FreeImage tscreen
    inshow = false
    fullscreenflag = sf
    ScreenInit
End Sub

Sub ShowLegend '                                                     a-h, 1-8 along sides
    Dim i, x, z

    SetFont 9
    For i = 1 To 8
        If invert Then z = i Else z = 9 - i '                        board inverted (black at bottom)
        If (rotate = 1) Or (rotate = 3) Then x = tlx + 3 Else x = tlx - 8
        ShadowPrint x, tly + i * yq - 30, CHRN$(z), boardwhite '               1 - 8
        ShadowPrint brx - (i - 1) * xq - 25, bly + 4, alphal$(z), boardwhite ' a - h
    Next i
End Sub

Sub ShowPoints '                                                     ahead or behind points shown top left
    Dim k, drawblinkf

    If pregame Or promoting Then Exit Sub
    If (colori3 = 3) Or (colori3 = 5) Then c1 = white Else c1 = clockc

    k = points(1) - points(0)
    If k <> 0 Then
        If (human = 0) And (invert = 1) Then k = -k '                computer vs computer
        If (human = 1) And (humanc = 0) Then k = -k '                computer vs human
        If (human = 2) And (WorB = 0) Then k = -k '                  human vs human
        TinyFont LTrim$(Str$(k)), tlx + 2, 27, c1
    End If

    If (perpetual > 0) Or (drawcount > 39) Then
        If (drawblink = 0) Or (ExtendedTimer > drawblink) Then
            drawblink = ExtendedTimer + .25
            drawblinkf = drawblinkf Xor 1
        End If
    Else
        drawblinkf = 1
    End If
    If drawblinkf And (insettings = false) Then TinyFont Str$(perpetual) + ":" + LTrim$(Str$(drawcount)), tlx + 30, 27, c1
End Sub

Sub ShowSets
    Dim i, j, k, p, x, y, z, sx1, sx2, sy, tscreen, t$, was_style

    If inshow Then Exit Sub
    inshow = true
    was_style = piece_style
    sx1 = 80
    sx2 = 430
    sy = 12
    Cls
    nbox = 4
    Buttons 0, 0
    SetFont defaultfontsize

    For piece_style = 0 To 9
        If sloaded(piece_style) = false Then
            tscreen = _CopyImage(0)
            LoadPieces piece_style
            Cls
            _PutImage , tscreen, 0
            _FreeImage tscreen
        End If
        For i = 0 To 1
            t$ = Str$(piece_style + 1) + " " + Mid$("WB", i + 1, 1)
            z = 38 - (piece_style > 8) * 10
            If piece_style < 5 Then
                x = sx1 - z
                y = sy + (piece_style * 2 + i) * yq + yq \ 2 - 4
            Else
                x = sx2 - z
                y = sy + ((piece_style - 5) * 2 + i) * yq + yq \ 2 - 4
            End If
            ShadowPrint x + 4, y, t$, white
            For j = 1 To 6
                k = Val(Mid$("541236", j, 1))
                If piece_style < 5 Then
                    x = sx1 + (j - 1) * xq
                    y = sy + (piece_style * 2 + i) * yq
                Else
                    x = sx2 + (j - 1) * xq
                    y = sy + ((piece_style - 5) * 2 + i) * yq
                End If
                p = k + (1 - i) * 8
                If piece_style Mod 2 Then c1 = boardblack Else c1 = boardwhite
                Line (x, y)-(x + xq, y + yq), c1, BF
                z = PieceSize(j)
                _PutImage (x + z, y + z)-(x + xq - z, y + yq - z), pix(piece_style, p), 0
                If rotate = 0 Then _Display
            Next j
            If dev Then '                                            show size adjustments
                'TinyFont Str$(PieceSize(King)), x + xq + 2, y + 20, red
                'TinyFont Str$(PieceSize(Pawn)), x + xq + 2, y + 27, red
                Color red
                SetFont 12
                _PrintString (x + xq + 6, y + 20), Str$(PieceSize(King))
                _PrintString (x + xq + 6, y + 32), Str$(PieceSize(Pawn))
            End If
        Next i
    Next piece_style

    AnyKey

    piece_style = was_style
    inshow = false
End Sub

Sub ShowTaken (showit As _Byte)
    Static lscreen, tpoints(1), tt
    Dim As _Byte np, s, c, i, j, k, p, pob, tc, tr
    Dim x, y, z, zx, zy, sx, sy, t, yint, t$, u$, side$, td!, tbri!

    If barebones Or (rotate = 1) Or (rotate = 3) Then Exit Sub

    'TimeTrack "ShowTaken", 1

    pob = points(0) + points(1) '                                    points on board
    If ptaken > 0 Then lpoints = -1 '                                highlighting last piece moved
    If (pob = 78) And (lpoints <> -1) Then GoTo sexit '              no pieces taken

    If pob = lpoints Then
        _PutImage (10, tly)-(tlx - 20, 358), lscreen, 0, (10, tly)-(tlx - 20, 358)
        GoTo sexit
    End If
    lpoints = pob

    tbri! = bri * .25
    zx = 34 '                                                        spacing
    zy = 36
    sx = tlx - 60 '                                                  start position master
    sy = try + 2
    y = sy

    tpoints(0) = 0: tpoints(1) = 0 '                                 SHOULD become same as points()

    For j = 1 To 5
        k = Val(Mid$("41326", j, 1)) '                               QRBNP
        x = sx
        For i = 0 To 1 '                                             black, white
            p = k + i * 8 '                                          piece
            c = 0 '                                                  count of piece type
            For tc = 1 To 8 '                                        column
                For tr = 1 To 8 '                                    row
                    c = c - (b(tc, tr) = p) '
                Next tr
            Next tc
            onboard(p) = c

            c = Val(Mid$("12228", j, 1)) - c '                       should be - what is
            s = c
            t = t + c '                                              total pieces taken
            tpoints(i) = tpoints(i) + value(k) * c \ mult '          to show equal/up/down
            If showit = false Then c = 0
            np = 0

            While c > 0 '                                            how many of this piece taken

                If ExtendedTimer > ptakent Then ptakent = 0: ptaken = 0

                For z = 1 To 18 '                                    shaded circle background
                    c1 = (20 - z) * 10
                    If (c = 1) And (p = ptaken) And (ptcc < c1) Then c2 = ptcc Else c2 = c1
                    c1 = c1 * tbri!
                    c2 = c2 * tbri!
                    c1 = _RGB32(c1, c2, c2)
                    Circle (x + zx \ 2 + 0, y + zy \ 2), z, c1
                    Circle (x + zx \ 2 + 1, y + zy \ 2), z, c1
                Next z

                If (c = 1) And (p = ptaken) Then '                   on highlighted piece
                    ptcc = ptcc + 2 + onplayback * 2 '               diminish red, twice as fast in playback
                    If ptcc > 255 Then ptcc = 255
                End If

                z = PieceSize(p)
                _PutImage (x + z, y + z)-(x + zx - z, y + zy - z), pix(piece_style, p), 0
                If (piece_style = 0) And (i = 0) Then Line (x, y)-Step(zx, zy), gray, B
                x = x - zx - 4
                If k = Pawn Then
                    np = np + 1
                    If (np = 4) And (c > 1) Then x = sx: y = y + zy + 4
                End If
                c = c - 1 '                                          counter
            Wend
            If (k = Pawn) And (s > 0) Then x = sx: y = y + zy + 4
        Next i
        y = y + zy + 4
    Next j

    tt = t
    If lscreen < -1 Then _FreeImage lscreen
    lscreen = _CopyImage(0)
    sexit:

    If showit = false Then GoTo soe

    i = 1
    If (human = 0) And invert Then i = i Xor 1
    If (human = 1) Or match Then i = humanc '                        human vs computer
    If (human = 2) Then i = WorB '                                   human vs human
    If match Or onplayback Then i = 1

    If tt = 0 Then '                                                 no pieces have been taken
        t$ = "No captures"
    Else '                                                           pieces have been taken
        side$ = Mid$("BlackWhite", i * 5 + 1, 5)
        k = tpoints(1) - tpoints(0)
        If i = 0 Then k = -k
        If k = 0 Then t$ = "Equal points"
        If k < 0 Then t$ = side$ + " up" + Str$(Abs(k)) + " point"
        If k > 0 Then t$ = side$ + " down" + Str$(k) + " point"
        If Abs(k) > 1 Then t$ = t$ + "s" '
    End If

    SetFont 9 '                                                      size 10 lowercase g cut off!
    yint = 13
    x = 24
    y = bry - 9 * yint

    ShadowPrint x, y, t$, white

    t$ = LTrim$(Str$(perpetual)) + " of 3 to perpetual"
    If perpetual > 0 Then c1 = red Else c1 = white
    ShadowPrint x, y + yint, t$, c1

    t$ = LTrim$(Str$(drawcount)) + " of 50 to draw"
    If drawcount > 39 Then c1 = red Else c1 = white
    ShadowPrint x, y + yint * 2, t$, c1

    td! = Int(tdelay! * 10) / 10
    t$ = LTrim$(Str$(td!)) + "s delay"
    ShadowPrint x, y + yint * 3, t$, white

    ShadowPrint x, y + yint * 4, fnum$(top_mps) + " top MPS", white

    u$ = ""
    t = mps
    If t > 1000 Then t = t / 1000: u$ = "T"
    If t > 1000 Then t = t / 1000: u$ = "M"
    ShadowPrint x, y + yint * 5, fnum$(t) + u$ + " moves per second", white

    u$ = ""
    t = tcount
    If t > 1000 Then t = t / 1000: u$ = "T"
    If t > 1000 Then t = t / 1000: u$ = "M"
    If t > 1000 Then t = t / 1000: u$ = "B"
    ShadowPrint x, y + yint * 6, fnum$(t) + u$ + " moves computed", white

    t$ = LCase$(logfiled$)
    If onplayback And (Len(pf$) > 0) Then t$ = LCase$(pf$) + "  (R/O)"
    If Len(t$) = 0 Then t$ = "TBA"
    If logging = 0 Then t$ = "OFF"
    p = InStr(t$, ".")
    If p Then t$ = Left$(t$, p - 1)
    t$ = "File: " + t$
    If readonly And (InStr(t$, "R/O") = 0) Then t$ = t$ + "  (R/O)"
    ShadowPrint x, y + yint * 7, t$, white

    soe:
    'TimeTrack "ShowTaken", 0
End Sub

Sub ShowThinking
    Dim sorted, mi, j, z, c$, t$, x1, y1, ox, oy

    If wasFEN > 0 Then '                                             no list to show for a FEN response
        SetFont defaultfontsize
        Color red, black
        _PrintString (580, 240), "Not computed"
        _PrintString (580, 260), "FEN entry" + Str$(wasFEN)
        Exit Sub
    End If

    If (rflag = 0) And (smoves0 > 0) Then '                          done thinking and list not sorted
        sort:
        sorted = true
        For mi = 2 To smoves0 '                                      sort list (bubble)
            If thinkv(mi - 1) < thinkv(mi) Then
                Swap thinkv(mi - 1), thinkv(mi)
                Swap think$(mi - 1), think$(mi)
                sorted = false
            End If
        Next mi
        If sorted = false Then GoTo sort
        smoves0 = -smoves0 '                                         method to indicate list is sorted
    End If

    SetFont 9 '                                                      small so it'll fit
    If rflag Then z = smovest Else z = Abs(smoves0) '                if thinking, show to current "known", else show entire sorted list
    For mi = 1 To z
        t$ = think$(mi)

        y1 = try + (mi - 1) * 11 + 2
        If mi Mod 2 Then
            c1 = _SHL(bri, 4)
            Line (trx + 3, y1 - 1)-(_Width - 12, y1 + 9), _RGB32(c1, c1, c1), BF
        End If
        For j = 1 To Len(t$)
            x1 = trx + (j - 1) * 6
            c$ = Mid$(t$, j, 1)
            ox = 0: oy = 0
            If c$ = "-" Then ox = 2: oy = -1
            If y1 < (_Height - 30) Then ShadowPrint x1 + ox, y1 + oy, c$, white
        Next j
    Next mi

    If dev And rflag Then
        y1 = try + Moves(0) * 11
        Line (trx + 3, y1)-(_Width - 12, y1), red
    End If
End Sub

Sub ShowValid (tcc As _Byte, trr As _Byte) '                         highlight legal squares to move to
    Dim mi, zx, zy
    Dim As _Byte z, zc, zr

    nvalid = 0
    If (human = 0) Or (-(b(tcc, trr) > 6) <> WorB) Then Exit Sub

    For mi = 1 To Moves(0)
        If (tcc = Abs(move(0, mi).fc)) And (trr = Abs(move(0, mi).fr)) Then
            nvalid = nvalid + 1
            If markers Then
                zc = move(0, mi).tc
                zr = move(0, mi).tr
                If invert Then zc = 9 - zc: zr = 9 - zr
                zx = tlx + (zc - 1) * xq
                zy = tly + (8 - zr) * yq
                For z = 2 To 4
                    Line (zx + z, zy + z)-(zx + xq - z, zy + yq - z), black, B
                Next z
                'If dev Then
                '    SetFont 12
                '    Color white
                '    _PrintString (zx + 4, zy + 7), Str$(mi)
                '    cursoron = ExtendedTimer + 60
                'End If
            End If
        End If
    Next mi
End Sub

Sub SmallBoard (sa)
    Dim As _Byte i, z, p, pp, zc, zr, st, zc1, zr1
    Dim tsa, tx, zx, zy, ty, c$, t$

    If onplayback Then Exit Sub

    'TimeTrack "SmallBoard", 1
    st = 90 '                                                        seperation distance between boards
    zx = trx + 10

    _PutImage (trx + 1, try)-(_Width - 1, _Height - 20), bgi, 0, (trx + 1, try)-(_Width - 1, _Height - 20)
    _MemCopy m(0), m(0).OFFSET, m(0).SIZE To m(10), m(10).OFFSET '   store board
    WorB = SaveWorB
    For z = 0 To masterlevel - 1

        If z > Moves(z) Then Exit For
        If z = 0 Then tsa = sa Else tsa = 1

        zc1 = move(z, tsa).fc
        zr1 = move(z, tsa).fr
        If b(Abs(zc1), Abs(zr1)) = 0 Then Exit For

        If descriptive Then DescriptiveNotation z, move(z, tsa).fc, move(z, tsa).fr, move(z, tsa).tc, move(z, tsa).tr
        MoveIt move(z, tsa).fc, move(z, tsa).fr, move(z, tsa).tc, move(z, tsa).tr

        WorB = WorB Xor 1
        zy = try + z * st + 2
        SetFont 10 '                                                 pieces
        For zc = 1 To 8 '                                            column
            For zr = 1 To 8 '                                        row
                If invert Then p = b(9 - zc, 9 - zr) Else p = b(zc, zr)
                pp = p And 7 '
                tx = zx + zc * 10
                ty = zy + (8 - zr) * 10
                c1 = 20 + ((zc + zr) Mod 2) * 20 '                   intensity
                c1 = _RGB32(c1, c1, c1) '                            make shade of gray
                Line (tx, ty)-Step(9, 9), c1, BF '                   square color
                If Sgn(p And 8) Then c1 = white Else c1 = red '      piece color
                If pp Then ShadowPrint tx + 1, ty, alphap$(pp), c1 ' skip blank squares
            Next zr
        Next zc
        If (SaveWorB + z) Mod 2 Then c1 = white Else c1 = red
        tx = trx + 110
        SetFont 12
        If descriptive Then
            ShadowPrint tx, zy + 12, desc$, c1
        Else '                                                       algebraic
            t$ = ToAlg$(z, tsa)
            For i = 1 To Len(t$) '                                   one character at a time to increase the spacing
                c$ = Mid$(t$, i, 1)
                ShadowPrint tx, zy + 12, c$, c1
                tx = tx + _PrintWidth(c$) + 1
            Next i
        End If
        ShadowBox zx + 10, zy, zx + 88, zy + 79
    Next z
    _MemCopy m(10), m(10).OFFSET, m(10).SIZE To m(0), m(0).OFFSET '  restore board

    If ssb(sa) < -1 Then _FreeImage ssb(sa)
    ssb(sa) = _CopyImage(0) '                                        a single sideband radio in South Africa

    'TimeTrack "SmallBoard", 0
    If autopause Then Pause
End Sub

Sub TakeBackPop
    Dim mi '                                                         move index
    Dim As _Byte c, r, ply

    For ply = 1 To 2
        For r = 1 To 8
            For c = 1 To 8
                b(c, r) = tb(c, r, 1)
                If ((b(c, r) And 7) = Pawn) And ((r = 1) Or (r = 8)) Then b(c, r) = Queen - 8 * (b(c, r) > 8)
            Next c
        Next r
        castle$ = castle$(1)
        lfc = lmove(1).fc
        lfr = lmove(1).fr
        ltc = lmove(1).tc
        ltr = lmove(1).tr

        For mi = 0 To tbmax - 1
            castle$(mi) = castle$(mi + 1)
            lmove(mi) = lmove(mi + 1)
            For r = 1 To 8
                For c = 1 To 8
                    tb(c, r, mi) = tb(c, r, mi + 1)
                Next c
            Next r
        Next mi
    Next ply

    check = 0
    incheck = 0
    markerfc = 0

    FENpcount = FENpcount - 2
    If FENpcount < 0 Then FENpcount = 0
    drawcount = drawcount + (drawcount > 0) '                        - 1, if > 0
    perpetual = perpetual + (perpetual > 0) '                        - 1, if > 0
End Sub

Sub TakeBackPush
    Dim mi '                                                         move index
    Dim As _Byte r, c

    FENpcount = FENpcount + 1
    FENperp$(FENpcount) = FENpartial$

    For mi = tbmax To 1 Step -1
        castle$(mi) = castle$(mi - 1) '                              castling status, 4 chars, BQS BKS  WQS WKS
        lmove(mi) = lmove(mi - 1)
        For r = 1 To 8 '                                             board
            For c = 1 To 8
                tb(c, r, mi) = tb(c, r, mi - 1)
            Next c
        Next r
    Next mi

    castle$(0) = castle$
    lmove(0).fc = lfc '                                              from column
    lmove(0).fr = lfr '                                              from row
    lmove(0).tc = ltc '                                              to column
    lmove(0).tr = ltr '                                              to row
    For r = 1 To 8 '                                                 row
        For c = 1 To 8 '                                             column
            tb(c, r, 0) = b(c, r) '                                  set takeback array
        Next c
    Next r
End Sub

Sub TakeBest (tlevel As _Byte, final As _Byte)
    Dim mi
    Dim As _Byte passes, lookback, sflag

    If Moves(tlevel) < 2 Then Exit Sub
    passes = 0
    ReSort:

    Do
        sflag = true
        For mi = 2 To Moves(tlevel)
            If (move(tlevel, mi - 1).sc < move(tlevel, mi).sc) Then
                Swap move(tlevel, mi - 1), move(tlevel, mi)
                If rflag And (tlevel = 0) Then Swap ssb(mi - 1), ssb(mi)
                sflag = false
            End If
        Next mi
    Loop Until sflag

    If final Then '                                                  level 0 wrapup
        mi = 0 '                                                     randomly pick a move among those of equal value
        Do '                                                         count same scores
            mi = mi + 1
        Loop Until (move(tlevel, 1).sc <> move(tlevel, mi + 1).sc) Or (mi = Moves(tlevel))

        mi = Rnd * (mi - 1) + 1 '                                    pick one of the same scores
        If mi <> 1 Then Swap move(tlevel, 1), move(tlevel, mi) '     if not in first position

        If (Moves(0) > 1) And (passes < 5) And (move > 9) Then

            'inhibit pawn moves when sufficient power to checkmate
            'p = Limit6(b(ABS(move(0, 1).fc), ABS(move(0, 1).fr)))
            'IF (p = Pawn) AND (ahead > 4) AND (CanMove(0) > 2) AND (RND > .8) THEN
            '    SWAP move(0, 1), move(0, 2)
            'END IF

            If points < 0 Then Exit Sub '                            allow repeat if losing (go for perpetual)

            '  try to stop repeats
            For lookback = 3 To 7 Step 2
                If (move(0, 1).fc = lmove(lookback).fc) And (move(0, 1).fr = lmove(lookback).fr) And (move(0, 1).tc = lmove(lookback).tc) And (move(0, 1).tr = lmove(lookback).tr) Then
                    move(0, 1).sc = move(0, 2).sc - 1
                    passes = passes + 1
                    GoTo ReSort
                End If
            Next lookback
        End If

        ' 30% of time, if scores close, take 2nd best move to add variety
        'IF (Moves(0) > 1) AND ((move(0, 2).sc - move(0, 1).sc) < 10) AND (RND > .7) THEN
        '    'IF rickfile THEN SOUND 200, 1
        '    'debug$ = LTRIM$(STR$(move + 1)) + " " + STR$(move(0, 1).sc) + " " + STR$(move(0, 2).sc)
        '    SWAP move(0, 1), move(0, 2)
        'END IF
    End If

End Sub

'Sub TimeTrack (sub_name$, onofff As _Byte) Static
'    Dim As _Byte i
'    Dim active$, ztime!, e!
'
'    If ttflag = 0 Then ztime! = Timer: Exit Sub
'
'    If ztime! = 0 Then ztime! = Timer
'    e! = Timer - ztime!
'    tel! = tel! + e!
'    For i = 1 To names
'        If active(i) Then time_used(i) = time_used(i) + e!
'    Next i
'
'    ztime! = Timer
'
'    'If sub_name$ = active$ Then Exit Sub
'    active$ = sub_name$
'
'    For i = 1 To names
'        If active$ = name$(i) Then active(i) = onofff: Exit Sub
'    Next i
'
'    names = names + 1
'    If names > 100 Then QuitWithError "TimeTrack", "names > 100"
'    name$(names) = active$
'    active(names) = true
'End Sub

Sub TinyFont (n$, tx, ty, tk As _Unsigned Long) '                    3 * 5 numbers
    Static fontinit As _Byte, sp(14, 4)
    Dim d, i, j, n, z, zz, x2, z$

    tinyfontd:
    Data "0",7,5,5,5,7
    Data "1",2,6,2,2,7
    Data "2",7,1,7,4,7
    Data "3",7,1,7,1,7
    Data "4",5,5,7,1,1
    Data "5",7,4,7,1,7
    Data "6",7,4,7,5,7
    Data "7",7,1,1,1,1
    Data "8",7,5,7,5,7
    Data "9",7,5,7,1,7
    Data ",",0,0,0,1,2
    Data ".",0,0,0,0,2
    Data "-",0,0,3,0,0
    Data ":",0,2,0,2,0
    Data " ",0,0,0,0,0

    If fontinit = false Then '                                       initialize - load dont
        Restore tinyfontd
        For n = 0 To 14
            Read z$
            For i = 0 To 4
                Read z
                sp(n, i) = z * 4096
            Next i
        Next n
        fontinit = true
    End If

    For z = 1 To Len(n$)
        z$ = Mid$(n$, z, 1)
        zz = InStr(",.-: ", z$)
        If zz Then d = zz + 9 Else d = Val(z$)
        For i = 0 To 4 '                                             5 rows
            x2 = tx + (z - 1) * 4
            Line (x2, ty + i)-(x2 + 3, ty + i), tk, , sp(d, i)
            If tk = black Then _Continue '                           skip shadow if color black
            For j = 3 To 0 Step -1 '                                 shadow, find edges
                c2 = Point(x2 + j, ty + i)
                If c2 = tk Then
                    PSet (x2 + j + 1, ty + i + 0), _RGB32(8, 8, 8) ' dot on the right
                    PSet (x2 + j + 1, ty + i + 1), _RGB32(8, 8, 8) ' dot to the right and down
                    PSet (x2 + j + 0, ty + i + 1), _RGB32(8, 8, 8) ' dot one down
                    Exit For
                End If
            Next j
        Next i
    Next z
End Sub

Function ToAlg$ (level As _Byte, i)
    If (rflag = 0) And (move(level, i).fc < 0) Then
        ToAlg = "O-O"
    ElseIf (rflag = 0) And (move(level, i).fr < 0) Then
        ToAlg = "O-O-O"
    Else
        ToAlg = alphal$(Abs(move(level, i).fc)) + CHRN$(Abs(move(level, i).fr)) + alphal$(move(level, i).tc) + CHRN$(move(level, i).tr)
    End If
End Function

Sub WindowEffect (effect As _Byte, img, x1, y1, x2, y2)
    Dim teffect, zx, zy, tr, tg, tb, p!, loopspeed
    'dim q,i2

    If rotate <> 0 Then Exit Sub
    If effect = -1 Then teffect = (teffect + 1) Mod 4 Else teffect = effect
    loopspeed = 30

    Select Case teffect
        Case 0 '                                                     zoom
            zx = xc - x1
            zy = yc - y1
            For p! = .1 To 1 Step .1
                _PutImage (xc - zx * p!, yc - zy * p!)-(xc + zx * p!, yc + zy * p!), img, 0, (x1, y1)-(x2, y2)
                DisplayMaster true
                _Limit loopspeed
            Next p!
            'Case 1 '                                                     unfold from left
            'For i2 = x1 To x2 Step 16
            '    _PutImage (x1, y1)-(i2, y2), img, 0, (x1, y1)-(i2, y2)
            '    DisplayMaster true
            '    _Limit loopspeed
            'Next i2
            'Case 2 '                                                     random blocks
            '    q = 30
            '    For i2 = 0 To 150
            '        zx = x1 + Rnd * (x2 - x1 - q)
            '        zy = y1 + Rnd * (y2 - y1 - q)
            '        _PutImage (zx, zy)-(zx + q, zy + q), img, 0, (zx, zy)-(zx + q, zy + q)
            '        DisplayMaster true
            '        _Limit loopspeed
            '    Next i2
        Case 3 '                                                     fade in
            _Source img
            For p! = .1 To .7 Step .03
                For zy = y1 To y2
                    For zx = x1 To x2
                        c1 = Point(zx, zy)
                        tr = _Red32(c1) * p!
                        tg = _Green32(c1) * p!
                        tb = _Blue32(c1) * p!
                        PSet (zx, zy), _RGB32(tr, tg, tb)
                    Next zx
                Next zy
                DisplayMaster true
                _Limit loopspeed
            Next p!
            _Source 0
    End Select
End Sub

Sub WriteLog (override)
    Dim f, i, t$, y$, m$, d$, f$

    'if dev then debug$ = Str$(readonly) + Str$(logging) + Str$(move)
    i = readonly: If override Then i = false
    If testing Or onplayback Or (i = true) Or (logging = false) Or (move < 3) Then Exit Sub

    If Len(logfiled$) = 0 Then
        f = 0
        newf: '                                                      Newfoundland and Labrador
        f = f + 1 '                                                  find first unused slot
        logfiled$ = "ch" + Right$("000000" + LTrim$(Str$(f)), 6) + ".alg"
        logfile$ = gamepath$ + logfiled$
        If _FileExists(logfile$) Then GoTo newf
    End If

    f = FreeFile
    Open logfile$ For Output As #f
    GoSub pheader
    For i = 1 To move '                                              algebraic
        Print #f, Rjust$(i, 4); " "; f6$(mlog$(i, 1)); " "; f6$(mlog$(i, 0))
    Next i
    Close #f

    If dev = 0 Then
        f$ = gamepath$ + Left$(logfiled$, Len(logfiled$) - 4) + ".des" ' save game in descriptive notation
        f = FreeFile
        Open f$ For Output As #f
        GoSub pheader
        For i = 1 To move '                                          descriptive
            Print #f, Rjust$(i, 4); " "; f12$(mlog$(i, 3)); " "; f12$(mlog$(i, 2))
        Next i
        Close #f
    End If
    Exit Sub

    pheader:
    ' Event,Site,Date,Round,White,Black,Result (such is the PGN standard)
    Restore pgnheader
    For i = 1 To 7
        Read t$
        Select Case i
            Case 1
                t$ = "[" + t$ + " " + q$ + "L" + LTrim$(Str$(masterlevel)) + " D" + LTrim$(Str$(deep)) + q$ + "]"
            Case 3 '                                                 Date
                y$ = Mid$(Date$, 7, 4)
                m$ = Mid$(Date$, 1, 2)
                d$ = Mid$(Date$, 4, 2)
                d$ = y$ + "." + m$ + "." + d$
                t$ = "[" + t$ + " " + q$ + d$ + q$ + "]"
            Case 5 '                                                 White
                t$ = "[" + t$ + " " + q$ + PlayerName$(1) + q$ + "]"
            Case 6 '                                                 Black
                t$ = "[" + t$ + " " + q$ + PlayerName$(0) + q$ + "]"
            Case 7 '                                                 Result
                If (msg$ = "Checkmate") Or (InStr(LCase$(msg$), "res") > 0) Then
                    If WorB Then
                        t$ = "[" + t$ + " " + q$ + "0-1" + q$ + "]"
                    Else
                        t$ = "[" + t$ + " " + q$ + "1-0" + q$ + "]"
                    End If
                ElseIf (msg$ = "Draw") Or (msg$ = "Stalemate") Or (msg$ = "Perpetual") Then
                    t$ = "[" + t$ + " " + q$ + "1/2-1/2" + q$ + "]"
                Else
                    t$ = "[" + t$ + " " + q$ + "" + q$ + "]"
                End If
            Case Else
                t$ = "[" + t$ + " " + q$ + q$ + "]"
        End Select
        Print #f, t$
    Next i
    Return
End Sub

'$include: 'tf.bas'
