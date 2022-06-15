'CHDIR ".\samples\pete\booger"

Rem
Rem
Rem             REALiTY Software
Rem
Rem         BOOGER and the Martians
Rem
Rem
Rem             Coded By M.Ware
Rem
Rem
Rem SWFX & GIF Routines used (Thanks dudes !!)
Rem
Rem   All other coding by REALiTY Software
Rem
Rem
Rem
Rem This is the 1st game from REALiTY Software
Rem soon to be one of many ,i already have another BOOGER
Rem game in the pipeline and have began work on it
Rem hopefully it wont be too long coming.
Rem
Rem BOOGER and the Martians was written in QB4.5 on a 133Mhz
Rem Pentium but should run on anything Pentium even 486 im not
Rem sure about 386's etc maybe you could EMAIL me about how
Rem it works on another machine ?
Rem
Rem Anyone out there who knows how to program music ,mail me please
Rem i havent dabbled in it yet but someone who knows can save a
Rem lot of time !.
Rem
Rem Hope you enjoy the GAME sorry there are not many REMARKS but hey
Rem thats one of the joys of programming !.
Rem
Rem Best of luck ..........................
Rem
Rem P.S Maybe someone would like to join forces and make a really
Rem     really really good game ???
Rem
Rem EMail me on : Matthew.Ware@virgin.net
Rem
Rem As Booger would say L8rs DUDES !!!







Rem     -Set Up Those Variables-

DefInt A-Z
Randomize Timer

Dim Shared c$(8) 'FM register information for 9 channels
c$(0) = "&hB0&h20&h23&h40&h43&h60&h63&h80&h83&hA0&HBD&HC0&HE0&HE3&hB0"
c$(1) = "&hB1&h21&h24&h41&h44&h61&h64&h81&h84&hA1&HBD&HC1&HE1&HE4&hB1"
c$(2) = "&hB2&h22&h25&h42&h45&h62&h65&h82&h85&hA2&HBD&HC2&HE2&HE5&hB2"
c$(3) = "&hB3&h28&h2B&h48&h4B&h68&h6B&h88&h8B&hA3&HBD&HC3&HE8&HEB&hB3"
c$(4) = "&hB4&h29&h2C&h49&h4C&h69&h6C&h89&h8C&hA4&HBD&HC4&HE9&HEC&hB4"
c$(5) = "&hB5&h2A&h2D&h4A&h4D&h6A&h6D&h8A&h8D&hA5&HBD&HC5&HEA&HED&hB5"
c$(6) = "&hB6&h30&h33&h50&h53&h70&h73&h90&h93&hA6&HBD&HC6&HF0&HF3&hB6"
c$(7) = "&hB7&h31&h34&h51&h54&h71&h74&h91&h94&hA7&HBD&HC7&HF1&HF4&hB7"
c$(8) = "&hB8&h32&h35&h52&h55&h72&h75&h92&h95&hA8&HBD&HC8&HF2&HF5&hB8"
Dim sfx$(25)
Open ".\data\noise.set" For Input As #1
For fxnum% = 0 To 25
    Input #1, sfx$(fxnum%)
Next
Close #1


Dim Prefix(4095), Suffix(4095), OutStack(4095), shiftout%(8)
Dim Ybase As Long, powersof2(11) As Long, WorkCode As Long

graphics = 39
Dim grid(10, 10)
Dim sprite(74, 40)
Dim spriteback(74, 40)
Dim spritemask(74, 40)
Dim default(74): frame = 0

Dim greenback(74)
Dim greenmask(74)
Dim greensprite(74)
aliens = 50
Dim alienx!(aliens): Dim alieny!(aliens)
Dim alienmove(aliens): Dim aliengrap(aliens)
Dim alienspeed!(aliens)
Dim floor(8)
Dim scroller(1000)
Dim comment$(10)
Dim word$(32)


comment$(1) = "Wake up dude!"
comment$(2) = "Are You Asleep Again!"
comment$(3) = "Were sposed to save the world!"
comment$(4) = "I need a LEAK !!"
comment$(5) = "G E T  A  M O V E  O N"
comment$(6) = "I'm the one in danger !!!!"
comment$(7) = "Stop thinking and play !"
comment$(8) = "The Bikes Overheating !!!"
comment$(9) = "PHHURRRP oops ,sorry!"
comment$(10) = "Fffarrt ,slipped out!"
word$(1) = "Easy Street Dude !!!"
leveltoo = 1
sndon = 1
size = 74
level = 1
Screen 13: Cls: GoSub grabsprites




Rem         -Main Prog Starts Here !!!-

mainstart:
jpdet = 9
look1 = 0
lives = 3

Screen 13: Cls

GoSub titlescreen

Cls

restart:

Cls
GoSub loadlevel ' Gets level data from disc

Palette: Cls



Rem                   -Draw Level Contents-

For ground = 200 To 40 Step -50
    For layer = 1 To 8
        Line (1, ground - layer)-(319, ground - layer), floor(9 - layer)
    Next layer
Next ground
moving! = 0: movingy! = 0
counter = 0: movgot = 0: movgot1 = 3

For howmany = 1 To 50
    If alienx!(howmany) <> 0 And alienmove(howmany) = 0 Then Put (alienx!(howmany), alieny!(howmany)), sprite(size, aliengrap(howmany)), PSet
Next howmany




Rem     -Okey Here Goes the main Routine !!!(HELP)-

gx! = 4: gy! = 32: anim = 0: jump = 0
   
Get (gx!, gy!)-(gx! + 10, gy! + 10), greenback()
Rem snd = 19: GOSUB snd


mainloop:

counter = counter + 1: If counter = 50 Then counter = 0

Wait &H3DA, 8

Put (gx!, gy!), greenback(), PSet
gx! = gx! + moving!
gy! = gy! + movingy!
   
If Point(gx! + 10, gy! + 10 + movingy!) = 0 And Point(gx!, gy! + 10 + movingy!) = 0 Then movingy! = movingy! + .125
If Point(gx! + 9, gy! + 9 + movingy!) = land And Point(gx!, gy! + 9 + movingy!) = land Then movingy! = 0: jump = 0
If Point(gx! - 3, gy! + 4) = land Then jpdet = 9: GoSub missit
   
If passd <> 0 Then GoTo missit

If Point(gx! - 3, gy! + 4) <> 0 Or Point(gx! - movgot1, gy! + 9) <> 0 Then GoSub dead
If Point(gx! + 11, gy! + 4) <> 0 Or Point(gx! + movgot, gy! + jpdet) <> 0 Then GoSub dead
If Point(gx! + 4, gy! + 9) <> 0 Then GoSub dead

missit:
   
If Point(gx! + 5, gy! - 2) <> 0 Then a$ = "DEFAULT": GoSub dead
If gx! > 305 And gy! > 162 Then GoTo leveldone
If gx! > 305 Then gx! = 4: gy! = gy! + 50
Get (gx!, gy!)-(gx! + 10, gy! + 10), greenback()
Put (gx!, gy!), greenmask(), And
Put (gx!, gy!), sprite(size, anim), Or

If counter > 25 Then frame = 1 Else frame = 0

GoSub alienmove


a$ = InKey$
a$ = LCase$(a$)
If a$ = "x" And moving! < 2 Then moving! = moving! + .5
If a$ = "z" And moving! > 0 Then moving! = moving! - .25
If a$ = " " And jump <> 1 Then jump = 1: jpdet = 4: movingy! = -1.8
   
If a$ = "q" Then End
If a$ = "s" Then sndon = sndon + 1: If sndon > 1 Then sndon = 0

If moving! <> 0 Then If anim1 = Int(5 / moving!) Then anim = anim + 1: If anim > 1 Then anim = 0
If moving! <> 0 Then movgot1 = -3: movgot = 0: look1 = 0: anim1 = anim1 + 1: If anim1 > Int(5 / moving!) Then anim1 = 0: snd = 5: GoSub snd
If jump = 1 Then jpdet = 4: anim = 11
If jump = 0 Then jpdet = 9
If moving! = 0 And look1 = 0 Then anim = 0: look1 = 1
If moving! = 0 And jump = 1 Then anim = 0
If moving! = 0 Then tick = tick + 1: If tick = 35 Then tick = 0: snd = 5: GoSub snd
If moving! = 0 And look = 950 Then anim = 10: snd = 7: GoSub snd: Color 15: t$ = comment$(Int(Rnd(1) * 9) + 1): v = 1: GoSub centre
If moving! = 0 Then movgot1 = 4: movgot = 12
If look = 1290 Then look1 = 0: anim = 0: v = 1: t$ = "                               ": look = 0: GoSub centre
look = look + 1: If look = 1300 Then look = 0


GoTo mainloop


Rem     -Routine for alien movement-

alienmove:
  
For howmany = 1 To 50

    Get (0, 0)-(10, 9), default()

    If alienmove(howmany) = 0 Then GoTo skip

    Put (alienx!(howmany), alieny!(howmany)), default(), PSet

    If alienmove(howmany) = 1 Then GoTo vert

    If alienx!(howmany) < 10 Or alienx!(howmany) > 300 Then alienspeed!(howmany) = -alienspeed!(howmany)
    If Point(alienx!(howmany) - 2, alieny!(howmany) + 4) <> 0 Or Point(alienx!(howmany) + 12, alieny!(howmany) + 4) <> 0 Then alienspeed!(howmany) = -alienspeed!(howmany): GoTo turned

    If Point(alienx!(howmany) - 2, alieny!(howmany) + 9) <> 0 Or Point(alienx!(howmany) + 12, alieny!(howmany) + 9) <> 0 Then alienspeed!(howmany) = -alienspeed!(howmany)

    turned:

    alienx!(howmany) = alienx!(howmany) + alienspeed!(howmany)
    GoTo placealien

    vert:

    alieny!(howmany) = alieny!(howmany) - alienspeed!(howmany)
    If Point(alienx!(howmany) + 4, alieny!(howmany) - 1) <> 0 Or Point(alienx!(howmany) + 4, alieny!(howmany) + 10) <> 0 Then alienspeed!(howmany) = -alienspeed!(howmany)

    placealien:

    Put (alienx!(howmany), alieny!(howmany)), spritemask(size, aliengrap(howmany)), And
    Put (alienx!(howmany), alieny!(howmany)), sprite(size, aliengrap(howmany) + frame), Or


    skip:
Next howmany
Return





dead:

Put (gx!, gy!), sprite(size, 21)
snd = 4
GoSub snd
GoSub delay
GoSub delay
   
If lives = 0 Then GoSub completedead
   
pic$ = ".\data\crashed1.bgr"
If lives > 1 Then pic$ = ".\data\crashed.bgr"
   
GoSub picture
GoSub keypress
lives = lives - 1: If lives > -1 Then GoTo restart

completedead:


pic$ = ".\data\totalled.bgr"
GoSub picture
GoSub keypress

GoTo mainstart


gamecomplete:

Cls
pic$ = ".\data\COMPLETE.bgr"
GoSub picture
GoSub keypress
level = 1
GoSub mainstart



titlescreen:

pic$ = ".\data\title.bgr": GoSub picture
GoSub delay
pic$ = ".\data\title1.bgr": GoSub picture
snd = 24
GoSub snd
GoSub keypress
pic$ = ".\data\title2.bgr": GoSub picture
GoSub keypress
pic$ = ".\data\title3.bgr": GoSub picture
GoSub keypress
pic$ = ".\data\title4.bgr": GoSub picture
snd = 25: GoSub snd


x$ = "    Right ,now dude ,this is the idea ,i've got this plan !!! .....     Firstly il'e get the Harley out of the garage ,won't go anywhere quick "
x$ = x$ + "on a pair of legs !! ,then what ,well lets get to the mothership i thinks and sort the main geezer out ,that bit you can leave to me but i need"
x$ = x$ + " your elp getting there !,basically we start at the top and the idea is to get to the bottom and onto the next street but just in case we meet"
x$ = x$ + " any Alien dudes i guess we ortta dodge em if poss i don't want to total my bike !, and we don't know what else to expect ,so only one way to find out"
x$ = x$ + " and thats to GO FOR IT !!! , OK,OK just in case i thinks the Harley will be alright for a couple of smashes ,maybe 4 i think ,but best none eh ,just hope"
x$ = x$ + " it's enuff to get us through the 30 streets !! ,and also finally"
x$ = x$ + " THE DUDE (almighty) said that the 'S' key will turn the sound on and off and 'Q' during the game will Quit and most finally if you want to get into the game"
x$ = x$ + " quick and the delays between screens and when we crash etc are toooo looonnnggg just hit the SPACEBAR !!  L8rs Dude !                  "

scroll = Len(x$)

Do

    Color 37: v = 23: t$ = word$(level): GoSub centre

    For r = 1 To scroll

        Color 9: Locate 19, 37: Print Mid$(x$, r, 1)
        If Mid$(x$, r, 1) <> " " Then snd = 18: GoSub snd

        For left = 1 To 8


            Get (80, 144)-(300, 152), scroller()
            Put (79, 144), scroller(), PSet
            Wait &H3DA, 8

            a$ = InKey$
            a$ = LCase$(a$)

            If a$ = "x" And word$(level + 1) <> "" Then level = level + 1: v = 23: t$ = "                                     ": GoSub centre
            If a$ = "z" And level > 1 Then level = level - 1: v = 23: t$ = "                                      ": GoSub centre

            If a$ = "z" Or a$ = "x" Then v = 23: t$ = word$(level): GoSub centre
            If a$ = " " Then GoTo doit
            If a$ = "q" Then End


        Next left
    Next r
Loop

doit:
snd = 25
GoSub snd
Palette
Return


leveldone:

pic$ = ".\data\doneit.bgr": GoSub picture
GoSub delay
GoSub delay
level = level + 1
GoTo restart

keypress:
a$ = InKey$
If a$ = " " Then Return
GoTo keypress
   
delay:
    
For r = 1 To 300
    For rr = 1 To 20000
    Next rr
Next r
Return

centre:

place = Int(40 - Len(t$)) / 2
place = place
Locate v, place: Print t$
Return




Rem     -Sound Routine (Thanks DUDE!)

snd:

If sndon = 0 Then Return
sfxnum% = snd
chan% = Val(Mid$(sfx$(sfxnum%), 61, 4))
For in = 1 To 60 Step 4
    reg$ = Mid$(c$(chan%), in, 4): reg% = Val(reg$)
    dat$ = Mid$(sfx$(sfxnum%), in, 4): dat% = Val(dat$)
    Out &H388, reg%: For d% = 1 To 6: b% = Inp(&H388): Next
    Out &H389, dat%: For d% = 1 To 35: b% = Inp(&H388): Next
Next

Return






Rem     -Level Loader-

loadlevel:


If level = 31 Then GoSub gamecomplete
pic$ = ".\data\loading.bgr": GoSub picture

GoSub delay

lev$ = Str$(level) + ".lev": lev$ = Right$(lev$, Len(lev$) - 1)
Open ".\levels\" + lev$ For Input As #1
Input #1, levelname$
t$ = levelname$: word$(level) = t$: v = 5: Color 155: GoSub centre
GoSub delay: GoSub delay

For r = 1 To aliens
    Input #1, alienx!(r)
    Input #1, alieny!(r)
    Input #1, alienmove(r)
    Input #1, aliengrap(r)
    Input #1, alienspeed!(r)
    If alienmove(r) = 1 Then alieny!(r) = alieny!(r) - 2
    If alienmove(r) <> 1 Then alieny!(r) = alieny!(r) - 1
    aliengrap(r) = aliengrap(r) - 1
Next r
For r = 1 To 8
    Input #1, floor(r)
Next r
Close #1
land = floor(1)

Return

Rem     -Routine to load and grab all sprite/mask etc data-

grabsprites:
For howmany = 1 To graphics
    fa$ = Str$(howmany) + ".spr"
    fb$ = Right$(fa$, Len(fa$) - 1)
    f$ = ".\data\" + fb$
    Open f$ For Input As #1
    For x = 1 To 10
        For Y = 1 To 10
            Input #1, grid(x, Y): PSet (x, Y), grid(x, Y)
        Next Y
    Next x
    Close #1
    Get (1, 1)-(10, 10), sprite(size, spriteno)
    If howmany = 1 Then Get (1, 1)-(10, 10), greensprite()
    For x = 1 To 10
        For Y = 1 To 10
            If Point(x, Y) = 0 Then PSet (x, Y), 255
        Next Y
    Next x
    Get (1, 1)-(10, 10), spritemask(size, spriteno)
    If howmany = 1 Then Get (1, 1)-(10, 10), greenmask()
    spriteno = spriteno + 1
Next howmany
Cls
Return

Rem     -Routine to load pics (Thanks DUDE !)

picture:

For a% = 0 To 7: shiftout%(8 - a%) = 2 ^ a%: Next a%
For a% = 0 To 11: powersof2(a%) = 2 ^ a%: Next a%
Open pic$ For Binary As #1
pic$ = "      ": Get #1, , pic$
Get #1, , TotalX: Get #1, , TotalY: GoSub GetByte
NumColors = 2 ^ ((a% And 7) + 1): nopalette = (a% And 128) = 0
GoSub GetByte: Background = a%
GoSub GetByte: If a% <> 0 Then Print "Bad screen descriptor.": End
If nopalette = 0 Then p$ = Space$(NumColors * 3): Get #1, , p$
Do
    GoSub GetByte
    If a% = 44 Then
        Exit Do
    ElseIf a% <> 33 Then
        Print "Unknown extension type.": End
    End If
    GoSub GetByte
    Do: GoSub GetByte: pic$ = Space$(a%): Get #1, , pic$: Loop Until a% = 0
Loop
Get #1, , XStart: Get #1, , YStart: Get #1, , XLength: Get #1, , YLength
XEnd = XStart + XLength: YEnd = YStart + YLength: GoSub GetByte
If a% And 128 Then Print "Can't handle local colormaps.": End
Interlaced = a% And 64: PassNumber = 0: PassStep = 8
GoSub GetByte
ClearCode = 2 ^ a%
EOSCode = ClearCode + 1
FirstCode = ClearCode + 2: NextCode = FirstCode
StartCodeSize = a% + 1: CodeSize = StartCodeSize
StartMaxCode = 2 ^ (a% + 1) - 1: MaxCode = StartMaxCode

BitsIn = 0: BlockSize = 0: BlockPointer = 1
x% = XStart: Y% = YStart: Ybase = Y% * 320&

Screen 13: Def Seg = &HA000
If nopalette = 0 Then
    Out &H3C7, 0: Out &H3C8, 0
    For a% = 1 To NumColors * 3: Out &H3C9, Asc(Mid$(p$, a%, 1)) \ 4: Next a%
End If
Line (0, 0)-(319, 199), Background, BF
Do
    GoSub GetCode
    If Code <> EOSCode Then
        If Code = ClearCode Then
            NextCode = FirstCode
            CodeSize = StartCodeSize
            MaxCode = StartMaxCode
            GoSub GetCode
            CurCode = Code: LastCode = Code: LastPixel = Code
            If x% < 320 Then Poke x% + Ybase, LastPixel
            x% = x% + 1: If x% = XEnd Then GoSub NextScanLine
        Else
            CurCode = Code: StackPointer = 0
            If Code > NextCode Then Exit Do
            If Code = NextCode Then
                CurCode = LastCode
                OutStack(StackPointer) = LastPixel
                StackPointer = StackPointer + 1
            End If

            Do While CurCode >= FirstCode
                OutStack(StackPointer) = Suffix(CurCode)
                StackPointer = StackPointer + 1
                CurCode = Prefix(CurCode)
            Loop

            LastPixel = CurCode
            If x% < 320 Then Poke x% + Ybase, LastPixel
            x% = x% + 1: If x% = XEnd Then GoSub NextScanLine

            For a% = StackPointer - 1 To 0 Step -1
                If x% < 320 Then Poke x% + Ybase, OutStack(a%)
                x% = x% + 1: If x% = XEnd Then GoSub NextScanLine
            Next a%

            If NextCode < 4096 Then
                Prefix(NextCode) = LastCode
                Suffix(NextCode) = LastPixel
                NextCode = NextCode + 1
                If NextCode > MaxCode And CodeSize < 12 Then
                    CodeSize = CodeSize + 1
                    MaxCode = MaxCode * 2 + 1
                End If
            End If
            LastCode = Code
        End If
    End If
Loop Until doneflag Or Code = EOSCode



Close #1
doneflag = 0
Return


GetByte: pic$ = " ": Get #1, , pic$: a% = Asc(pic$): Return

NextScanLine:
If Interlaced Then
    Y% = Y% + PassStep
    If Y% >= YEnd Then
        PassNumber = PassNumber + 1
        Select Case PassNumber
            Case 1: Y% = 4: PassStep = 8
            Case 2: Y% = 2: PassStep = 4
            Case 3: Y% = 1: PassStep = 2
        End Select
    End If
Else
    Y% = Y% + 1
End If
x% = XStart: Ybase = Y% * 320&: doneflag = Y% > 199
Return
GetCode:
If BitsIn = 0 Then GoSub ReadBufferedByte: LastChar = a%: BitsIn = 8
WorkCode = LastChar \ shiftout%(BitsIn)
Do While CodeSize > BitsIn
    GoSub ReadBufferedByte: LastChar = a%
    WorkCode = WorkCode Or LastChar * powersof2(BitsIn)
    BitsIn = BitsIn + 8
Loop
BitsIn = BitsIn - CodeSize
Code = WorkCode And MaxCode
Return
ReadBufferedByte:
If BlockPointer > BlockSize Then
    GoSub GetByte: BlockSize = a%
    pic$ = Space$(BlockSize): Get #1, , pic$
    BlockPointer = 1
End If
a% = Asc(Mid$(pic$, BlockPointer, 1)): BlockPointer = BlockPointer + 1
Return


Rem         - I Guess this is the end (FOR NOW!)



Sub playsfx (sfx$)

    chan = Val(Mid$(sfx$, 61, 4))
    For in = 1 To 60 Step 4
        reg$ = Mid$(c$(chan), in, 4): reg = Val(reg$)
        dat$ = Mid$(sfx$, in, 4): dat = Val(dat$)
        Out &H388, reg: For i1 = 1 To 6: p = Inp(&H388): Next
        Out &H389, dat: For i1 = 1 To 35: p = Inp(&H388): Next
    Next

End Sub

