DECLARE SUB copper ()
DECLARE SUB fadefromcolor (a%, c%, t%, r%, g%, B%)
DECLARE SUB fadetocolor (a%, c%, t%, r%, g%, B%)
DECLARE SUB getpal ()
DECLARE SUB setpal (c1%, c2%, r1%, g1%, b1%, r2%, g2%, b2%)

DECLARE SUB keyaction ()

DECLARE SUB crosfade (r1%(), r2%(), g1%(), g2%(), b1%(), b2%())
DECLARE SUB setcrosfadepal (r1%(), r2%(), g1%(), g2%(), b1%(), b2%())
DECLARE SUB initcrosfadepics (a%, B%)

DECLARE SUB clearscreen (c%)

DECLARE SUB spheremaplasma ()
DECLARE SUB zoomdistort ()
DECLARE SUB loadqbinside ()
DECLARE SUB rgblights ()
DECLARE SUB cycleblobs ()
DECLARE SUB plasmablobs ()

DECLARE SUB actions3d ()

DECLARE SUB loadobject (a$)
DECLARE SUB createobject (a%)

DECLARE SUB animatewavelet (k%)

DECLARE SUB mov3dpos (xp, yp, zp)
DECLARE SUB rotate3d (xr, yr, zr)
DECLARE SUB translate3d ()
DECLARE SUB output3d ()

DECLARE SUB load3drecord ()



DECLARE SUB loadrecord ()
DECLARE SUB precalculations ()
DECLARE SUB getmap (a$)

DECLARE SUB Intersections ()
DECLARE SUB Actions ()
DECLARE SUB saverecord ()

DECLARE SUB Output0 ()

DECLARE SUB deedlinesax (c%)
DECLARE SUB prehistoricode ()
DECLARE SUB sucking ()
DECLARE SUB delay (t%)

DECLARE SUB ffix
'ffix


Randomize Timer

If Command$ = "-COPPER" Then copper: End

Screen 13
deedlinesax 15
delay 140
deedlinesax 0
Cls

prehistoricode
sucking
delay 140



xit% = 0

'$DYNAMIC
Dim Shared r%(0 To 255), g%(0 To 255), B%(0 To 255)
Dim Shared r1%(0 To 255), g1%(0 To 255), b1%(0 To 255)
Dim Shared fpos%(0 To 255)
fp% = 256 * 86: Dim Shared fonts%(0 To fp%)
'$STATIC

'DIM SHARED fsin1%(-48 TO 826), fsin2%(-640 TO 602), fsin3%(-640 TO 715)
Dim Shared fsin4%(-319 To 602)

Dim Shared fsin1%(-48 To 1083)
Dim Shared fsin2%(-640 To 957)
Dim Shared fsin3%(-640 To 871)

Dim Shared mod256128%(-168 To 168)
Dim Shared sp%(16384)

Dim Shared dt%(-192 To 180)
Dim Shared dt100%(-180 To 180)


Dim Shared cd%(0 To 1792)


Dim Shared dsx%(10), dsy%(10), psx%(10), psy%(10), xp1%(10), yp1%(10), yy%(10)
Dim Shared epi6%(0 To 5), epi36%(0 To 5)

Dim Shared cy%(-100 To 300)



Dim Shared dis%(320), sla%(320), slb%(320), slc%(320), sc%(320)
Dim Shared div2%(255), div4%(320), mul32%(32), mul128%(128)
Dim Shared fs%(0 To 199)
'DIM SHARED map%(1024)
Dim Shared kon%(127)
Dim Shared ka%(4)



setcrosfadepal r%(), r1%(), g%(), g1%(), B%(), b1%()
getpal
fadetocolor 0, 255, 1, 0, 0, 0

a$ = "fonts16.fnt"
c$ = " "

Open a$ For Binary As #1


For i% = 0 To 255
    Get #1, , c$: fpos%(i%) = Asc(c$)
Next i%


For i% = 0 To 85

    For y% = 0 To 15
        For x% = 0 To 15
            Get #1, , c$
            fonts%(i% * 256 + y% * 16 + x%) = Asc(c$)
        Next x%
    Next y%

Next i%

Close #1

'$DYNAMIC
Dim Shared text$(3, 11)
'$STATIC

text$(0, 0) = "   Ok! Let's get    "
text$(0, 1) = "  serious now :)    "
text$(0, 2) = "                    "
text$(0, 3) = " Hopefully you will "
text$(0, 4) = "see a nice demo from"
text$(0, 5) = "my side and not old "
text$(0, 6) = "  prehistoric line  "
text$(0, 7) = " drawing and lame   "
text$(0, 8) = "oldstyle qbasic code"
text$(0, 9) = "                    "
text$(0, 10) = " But let's crosfade "
text$(0, 11) = " some more text now!"

text$(1, 0) = "  Optimus presents  "
text$(1, 1) = "  a demo done in a  "
text$(1, 2) = " hurry by connecting"
text$(1, 3) = "  various older or  "
text$(1, 4) = " newer sources into "
text$(1, 5) = " the main programm. "
text$(1, 6) = "                    "
text$(1, 7) = " All coded in pure  "
text$(1, 8) = "  Quickbasic 4.5    "
text$(1, 9) = "  Use ffix.com for  "
text$(1, 10) = "  maximum pleasure  "
text$(1, 11) = "                    "


text$(2, 0) = "  Featuring effects "
text$(2, 1) = "like Sphere mapping "
text$(2, 2) = "circle blobs,rgb8bpp"
text$(2, 3) = "lights, zoom distort"
text$(2, 4) = "plasma inside blob, "
text$(2, 5) = "hardware raster fx  "
text$(2, 6) = "3d dots and a simple"
text$(2, 7) = "raycaster engine.   "
text$(2, 8) = "    Some are not so "
text$(2, 9) = "optimized as I could"
text$(2, 10) = "and few have several"
text$(2, 11) = "bugs too..          "


text$(3, 0) = "They still run at   "
text$(3, 1) = "full frame rate in  "
text$(3, 2) = "my AMDK6-2/500Mhz,  "
text$(3, 3) = "though I had thought"
text$(3, 4) = "ways to optimize    "
text$(3, 5) = "them even more.     "
text$(3, 6) = "           Anyways.."
text$(3, 7) = "lean back and enjoy!"
text$(3, 8) = "                    "
text$(3, 9) = " Optimus/Dirty Minds"
text$(3, 10) = " Thessaloniki/Greece"
text$(3, 11) = " Saturday 25/05/2002"

Cls
dl% = 840

initcrosfadepics 0, 1
fadefromcolor 0, 255, 256, 0, 0, 0

delay dl%
If xit% = 1 Then xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GoTo endfadetext


crosfade r%(), r1%(), g%(), g1%(), B%(), b1%()
If xit% = 1 Then xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GoTo endfadetext

initcrosfadepics 1, 1
setcrosfadepal r%(), r1%(), g%(), g1%(), B%(), b1%()
initcrosfadepics 1, 2
delay dl%
If xit% = 1 Then xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GoTo endfadetext

crosfade r%(), r1%(), g%(), g1%(), B%(), b1%()
If xit% = 1 Then xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GoTo endfadetext


delay dl%
If xit% = 1 Then xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GoTo endfadetext

initcrosfadepics 2, 2
setcrosfadepal r%(), r1%(), g%(), g1%(), B%(), b1%()
initcrosfadepics 2, 3
crosfade r%(), r1%(), g%(), g1%(), B%(), b1%()
If xit% = 1 Then xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GoTo endfadetext


delay dl%
If xit% = 1 Then xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GoTo endfadetext

getpal
fadetocolor 0, 255, 256, 63, 63, 63
If xit% = 1 Then xit% = 2: getpal: fadetocolor 0, 255, 64, 0, 0, 0: GoTo endfadetext


endfadetext:
xit% = 0

Line (0, 0)-(320, 200), 255, BF


spheremaplasma
xit% = 0
zoomdistort
xit% = 0
getpal
fadetocolor 0, 255, 31, 0, 0, 0
Cls


' ------------- RGB Lights ---------------

rgblights
xit% = 0







' ------------- 3D Dots ---------------

'$DYNAMIC
Dim Shared x(4096), y(4096), z(4096)
Dim Shared xo%(4096), yo%(4096), zo%(4096)
Dim Shared xs%(4096, 1), ys%(4096, 1)
'DIM SHARED pl%(8192, 2), ln%(8192, 1)
Dim Shared ypk&(-100 To 99)
Dim Shared zpo%(8)
'$STATIC


Cls

' ------ Precalculations for Wavelet -----


For i% = 0 To 826
    fsin1%(i%) = Sin(i% / 50) * 48
Next i%


' ------ Precalculations for Poke ------


For i& = -100 To 99
    ypk&(i&) = (i& + 100) * 320
Next i&

' ---------------------------------------


actions3d

xit% = 0
' -------- Cycleblobs ------------

Erase fsin2%, fsin3%
cycleblobs
xit% = 0

Cls
plasmablobs
xit% = 0
Line (0, 0)-(320, 200), 255, BF




'dm% = 16384
'DIM SHARED mapout%(dm%)



setpal 0, 255, 0, 0, 0, 63, 63, 63

getmap "wolfmap0.wad"
precalculations


k$ = " "

a$ = "3rdrec.rec"
gi$ = " ": gg$ = " "
g% = 0: gi% = 0

Open a$ For Binary As #2
Get #2, , gi$: gi% = Asc(gi$): Get #2, , gg$: gg% = Asc(gg$)


While InKey$ <> "": Wend

' ----------------- Some important data -----------------

ph% = 32: px% = 64 + 32: py% = 64 + 32: pa% = 90: ps% = 3
fv% = 60: ra = fv% / 320: dpp% = 160 / Tan((fv% \ 2) / 57.3)
map% = 0

k% = 0
fps% = 0
filei% = 0

Do While InKey$ = ""
    fps% = fps% + 1
    If fps% = 558 Then map% = 1
    If fps% = 2148 Then map% = 0
    If fps% = 3500 Then map% = 1
    If fps% = 4760 Then map% = 0

    keyaction
    loadrecord
    Actions
    sp%(mul128%(py% \ 16) + px% \ 16) = 64

    Intersections
    Wait &H3DA, 8: Wait &H3DA, 8, 8
    Output0


    If filei% = 194 Then GoTo telos

Loop

telos:
Close #2

xit% = 0
getpal
fadetocolor 0, 255, 255, 0, 0, 0

Sub Actions

    Shared kb%, px%, py%, pa%, ps%, map%

    While kon%(75) = 1
        pa% = pa% + 1
        If pa% > 360 Then pa% = 0 + (pa% - 360)
        GoTo 101
    Wend

    101
    While kon%(77) = 1
        pa% = pa% - 1
        If pa% < 0 Then pa% = 360 + pa%
        GoTo 102
    Wend

    102
    While kon%(72) = 1
        pxd% = Cos(pa% / 57.3) * ps%
        pyd% = Sin(pa% / 57.3) * ps%
        px% = px% + pxd%
        If cd%(mul32%(py% \ 64) + px% \ 64) = 1 Then px% = px% - pxd%
        py% = py% - pyd%
        If cd%(mul32%(py% \ 64) + px% \ 64) = 1 Then py% = py% + pyd%
        GoTo 103
    Wend

    103
    While kon%(80) = 1
        pxd% = Cos(pa% / 57.3) * ps%
        pyd% = Sin(pa% / 57.3) * ps%
        px% = px% - pxd%
        If cd%(mul32%(py% \ 64) + px% \ 64) = 1 Then px% = px% + pxd%
        py% = py% + pyd%
        If cd%(mul32%(py% \ 64) + px% \ 64) = 1 Then py% = py% - pyd%
        GoTo 104
    Wend

    104
    While kon%(15) = 1
        If map% = 0 Then map% = 1 Else map% = 0
        GoTo 105
    Wend

    105
    While kon%(1) = 1
        End
    Wend

    While InKey$ <> "": Wend

End Sub

Sub actions3d

    Shared xit%

    Shared ndts%, ndtso%
    Shared xc, yc, zc, rxc, ryc, rzc
    Shared xp, yp, zp
    Shared gi$, gg$
    Shared k%, obj%
    Shared ftype%, filei%
    Shared mtr


    Const pi = 3.1415926#
    mtr = pi / 180
    k% = 0

    gi$ = " "
    gg$ = " "
    xp = 0: yp = 0: zp = 800

    'kyvos 100
    'sphere 200
    'torus 600
    'wavelet 800
    'teapot,cow 300

    zpo%(1) = 100
    zpo%(2) = 200
    zpo%(3) = 600
    zpo%(4) = 800
    zpo%(5) = 300
    zpo%(6) = 300




    Screen 13
    Color 255



    Def Seg = &HA000
    xc = 0: yc = 0: zc = 0
    rxc = 0: ryc = 0: rzc = 0


    f$ = "3drec.001"
    Open f$ For Binary As #2

    k% = 0
    Do
        B$ = InKey$: If B$ = "x" Then End
        load3drecord
        If Asc(gg$) = 0 Then a$ = "" Else a$ = gg$


        While a$ = "s" Or a$ = "S"
            setpal 0, 255, 0, 0, 0, 63, 63, 63
            obj% = 1
            'zp = zpo%(obj%)
            createobject obj%
            ndtso% = 64: ndts% = ndtso%
            a$ = ""
        Wend

        While a$ = "d" Or a$ = "D"
            setpal 0, 255, 0, 0, 0, 63, 47, 15
            obj% = 2
            'zp = zpo%(obj%)
            createobject obj%
            ndtso% = 256: ndts% = ndtso%
            a$ = ""
        Wend

        While a$ = "f" Or a$ = "F"
            setpal 0, 255, 0, 0, 0, 31, 63, 47
            obj% = 3
            'zp = zpo%(obj%)
            createobject obj%
            ndtso% = 512: ndts% = ndtso%
            a$ = ""
        Wend

        While a$ = "g" Or a$ = "G"
            setpal 0, 255, 0, 0, 0, 15, 31, 63
            obj% = 4
            'zp = zpo%(obj%)
            createobject obj%
            ndtso% = 64: ndts% = 0
            a$ = ""
        Wend

        While a$ = "h" Or a$ = "H"
            setpal 0, 255, 0, 0, 0, 0, 63, 63
            obj% = 5
            'zp = zpo%(obj%)
            loadobject "hiteapot.3do"
            ndtso% = 0
            a$ = ""
        Wend

        While a$ = "j" Or a$ = "J"
            setpal 0, 255, 0, 0, 0, 63, 31, 47
            obj% = 6
            'zp = zpo%(obj%)
            loadobject "cow.3do"
            ndtso% = 0
            a$ = ""
        Wend


        While a$ = "," Or a$ = "<"

            clearscreen 0
            If ndts% - ndtso% > 0 Then ndts% = ndts% - ndtso%
            a$ = ""
        Wend

        While a$ = "." Or a$ = ">"
            'clearscreen 0
            If ndts% + ndtso% < 4096 Then ndts% = ndts% + ndtso%
            a$ = ""
        Wend


        While a$ = "k" Or a$ = "K"
            'clearscreen 0
            xp = -zpo%(obj%) * 1.5: yp = 0: zp = zpo%(obj%)
            xc = 0: yc = 0: zc = 0
            a$ = ""
        Wend

        While a$ = "l" Or a$ = "L"
            'clearscreen 0
            xp = zpo%(obj%) * 1.5: yp = 0: zp = zpo%(obj%)
            xc = 0: yc = 0: zc = 0
            a$ = ""
        Wend


        While a$ = "u" Or a$ = "U"
            'clearscreen 0
            xp = 0: yp = zpo%(obj%) * 1.5: zp = zpo%(obj%)
            xc = 0: yc = 0: zc = 0
            a$ = ""
        Wend

        While a$ = "y" Or a$ = "Y"
            'clearscreen 0
            xp = 0: yp = -zpo%(obj%) * 1.5: zp = zpo%(obj%)
            xc = 0: yc = 0: zc = 0
            a$ = ""
        Wend

        While a$ = "m" Or a$ = "M"
            'clearscreen 0
            xp = 0: yp = 0: zp = -zpo%(obj%) \ 2
            xc = 0: yc = 0: zc = 0
            a$ = ""
        Wend






        While a$ = "a" Or a$ = "A"
            yc = yc + .1
            a$ = ""
        Wend

        While a$ = "Q" Or a$ = "q"
            yc = yc - .1
            a$ = ""
        Wend

        While a$ = "o" Or a$ = "O"
            xc = xc - .1
            a$ = ""
        Wend

        While a$ = "p" Or a$ = "P"
            xc = xc + .1
            a$ = ""
        Wend

        While a$ = "-"
            zc = zc + .25
            a$ = ""
        Wend

        While a$ = "=" Or a$ = "+"
            zc = zc - .25
            a$ = ""
        Wend

        While a$ = "z" Or a$ = "Z"
            xr = 0: yr = 0: zr = 0
            rxc = 0: ryc = 0: rzc = 0
            a$ = ""
        Wend



        While a$ = "x" Or a$ = "X"
            End
        Wend

        While a$ = "4"
            ryc = ryc - .005
            a$ = ""
        Wend

        While a$ = "6"
            ryc = ryc + .005
            a$ = ""
        Wend

        While a$ = "8"
            rxc = rxc - .005
            a$ = ""
        Wend

        While a$ = "2"
            rxc = rxc + .005
            a$ = ""
        Wend

        While a$ = "7"
            rzc = rzc - .005
            a$ = ""
        Wend

        While a$ = "9"
            rzc = rzc + .005
            a$ = ""
        Wend


        While a$ = "w" Or a$ = "W"
            clearscreen 1
            ftype% = 0
            a$ = ""
        Wend

        While a$ = "e" Or a$ = "E"
            ftype% = 1
            a$ = ""
        Wend

        While a$ = "r" Or a$ = "R"
            ftype% = 2
            a$ = ""
        Wend


        xp = xp + xc: yp = yp + yc: zp = zp + zc
        xr = xr + rxc: yr = yr + ryc: zr = zr + rzc


        If obj% = 4 Then animatewavelet k%: k% = k% + 1: If k% = 314 Then k% = 0

        rotate3d xr, yr, zr
        mov3dpos xp, yp, zp
        translate3d
        output3d

        If filei% = 4446 Then GoTo telos2

        If xit% = 0 Then keyaction
        If xit% = 1 Then GoTo telos2


    Loop


    telos2:
    filei% = 0

    Close #2

End Sub

Sub animatewavelet (k%)


    l% = 0
    For z% = 0 To 511 Step 8
        For x% = 0 To 511 Step 8

            xo%(l%) = x% - 256: zo%(l%) = z% - 256
            yo%(l%) = fsin1%(x% + k%) + fsin1%(z% + k%)


            l% = l% + 1
        Next x%
    Next z%

End Sub

Sub clearscreen (c%)


    For y% = 0 To 199
        Def Seg = &HA000 + y% * 20

        For x% = 0 To 319
            Poke x%, c%
        Next x%

    Next y%

    Def Seg = &HA000


End Sub

Sub copper

    Cls

    'WHILE INKEY$ <> "": WEND
    'SCREEN 0

    Locate 2, 32: Print "Congratulations!"
    Locate 4, 2: Print "You have just found the secret part of the demo, even if I guess it was quite"
    Locate 5, 2: Print "easy, since I use to give away the source of every quickbasic demo of mine ;)"
    Print
    Print "   These are supposed to be hardware fx inspired by Amiga, C64, CPC or any other"
    Print "raster display computer that happens to exist. Quite unstable if you are running"
    Print "them under windows, so I suggest to boot up in pure DOS and retry there.."
    Print
    Print "   What you are just watching are called raster or copper bars. Originally 1st"
    Print "seen in Amiga demos, giving to the machine the opportunity to display more than"
    Print "the theoritical maximum number of colors (This is text mode!) in the screen (But"
    Print "mostly used as horizontal colorfull lines and not per pixel. Do you remember"
    Print "Shadow of the Beast or Agony, which used to have extra colors upon a colorfull"
    Print "sky in the background?)"
    Print "   They are so simple fx, just changing the RGB values of just one color several"
    Print "times in a frame, synced with the raster beam of the CRT (You can use the &HDA "
    Print "port address you know from Vsync to use for horizontal syncing too, by checking"
    Print " the 1st bit, in the similar way you did that for the 4th bit for Vsync!)"

    Print
    Print "It seems that I have 2 go, unfortunatelly haven't explained you about the next"
    Print "effects you are gonna see if you press any key.."
    Print "                                                     Optimus"



    Dim c%(1 To 32)
    Dim xb%(0 To 319)
    Dim ds%(1 To 32), ps%(1 To 32)
    Dim xp%(32)
    Dim rgb%(15, 15)
    'DIM b01%(-1024 TO 1024)
    'DIM b02%(-1024 TO 1024)
    Dim b01%(-640 To 640)
    Dim b02%(-640 To 640)

    Dim y2%(0 To 399)
    Dim lc%(0 To 399)


    Dim l%(3)
    Dim br%(-200 To 500)

    k% = 0
    For i% = 168 To 200
        If k% > 63 Then k% = 63
        br%(i%) = k%
        k% = k% + 2
    Next i%

    For i% = 201 To 232
        k% = k% - 2
        If k% < 0 Then k% = 0
        br%(i%) = k%
    Next i%


    k% = 0
    Do While InKey$ = ""

        k% = k% + 1

        Wait &H3DA, 8
        Wait &H3DA, 8, 8

        l%(1) = Sin(k% / 25) * 120
        l%(2) = Sin(k% / 45) * 110
        l%(3) = Sin(k% / 35) * 100


        For i% = 0 To 380

            Wait &H3DA, 1, 1: Wait &H3DA, 1

            Out &H3C8, 0
            Out &H3C9, br%(i% + l%(1))
            Out &H3C9, br%(i% + l%(2))
            Out &H3C9, br%(i% + l%(3))

        Next i%



    Loop




    Screen 13

    Out &H3D4, &H13
    Out &H3D5, 0

    For i% = 1 To 16
        Out &H3C8, i%
        Out &H3C9, (i% - 1) * 4
        Out &H3C9, 0
        Out &H3C9, 0
    Next i%

    For i% = 17 To 32
        Out &H3C8, i%
        Out &H3C9, 0
        Out &H3C9, (i% - 17) * 4
        Out &H3C9, 0
    Next i%

    For i% = 33 To 48
        Out &H3C8, i%
        Out &H3C9, 0
        Out &H3C9, 0
        Out &H3C9, (i% - 33) * 4
    Next i%

    For i% = 49 To 64
        Out &H3C8, i%
        Out &H3C9, (i% - 49) * 4
        Out &H3C9, (i% - 49) * 4
        Out &H3C9, 0
    Next i%

    For i% = 65 To 80
        Out &H3C8, i%
        Out &H3C9, (i% - 65) * 4
        Out &H3C9, 0
        Out &H3C9, (i% - 65) * 4
    Next i%

    For i% = 81 To 96
        Out &H3C8, i%
        Out &H3C9, 0
        Out &H3C9, (i% - 81) * 4
        Out &H3C9, (i% - 81) * 4
    Next i%

    For i% = 97 To 112
        Out &H3C8, i%
        Out &H3C9, (i% - 97) * 4
        Out &H3C9, (i% - 97) * 2
        Out &H3C9, 0
    Next i%

    For i% = 113 To 128
        Out &H3C8, i%
        Out &H3C9, 0
        Out &H3C9, (i% - 113) * 2
        Out &H3C9, (i% - 113) * 4
    Next i%






    For i% = 1 To 16: c%(i%) = i%: Next i%
    For i% = 17 To 32: c%(i%) = 33 - i%: Next i%



    For i% = 1 To 32
        ds%(i%) = Int(Rnd * 63 + 32)
        ps%(i%) = Int(Rnd * 127)
    Next i%


    Def Seg = &HA000

    k% = 0
    Do While InKey$ = ""


        k% = k% + 1

        For i% = 1 To 8
            xp%(i%) = Sin(k% / ds%(i%)) * ps%(i%) + ps%(i%) + (280 - 2 * ps%(i%)) \ 2
        Next i%

        For ii% = 1 To 8
            For i% = 1 To 32
                xb%(i% + xp%(ii%)) = c%(i%) + 16 * (ii% - 1)
            Next i%
        Next ii%


        Wait &H3DA, 8
        For i% = 0 To 319
            Poke i%, xb%(i%)
            Poke i% + 80, xb%(i%)
        Next i%
        Wait &H3DA, 8, 8




        l%(1) = Sin(k% / 25) * 120
        l%(2) = Sin(k% / 45) * 110
        l%(3) = Sin(k% / 35) * 100


        For i% = 0 To 380


            Wait &H3DA, 1, 1: Wait &H3DA, 1

            Out &H3C8, 0
            Out &H3C9, br%(i% + l%(1))
            Out &H3C9, br%(i% + l%(2))
            Out &H3C9, br%(i% + l%(3))

        Next i%

        For i% = 0 To 319: xb%(i%) = 0: Next i%


    Loop





    ' --------- Translucent copper bars -----------



    c% = 0
    Out &H3C8, 0

    For a% = 0 To 15
        For B% = 0 To 15

            Out &H3C9, a% * 2 + 33
            Out &H3C9, 0
            Out &H3C9, B% * 2 + 33

            rgb%(a%, B%) = c%
            c% = c% + 1

        Next B%
    Next a%


    Out &H3D4, &H13
    Out &H3D5, 0

    'DIM fsin1%(0 TO 1083)
    'DIM fsin2%(0 TO 957)
    'DIM fsin3%(-471 TO 871)

    For i% = 0 To 1083: fsin1%(i%) = Sin(i% / 45) * 63 + 92: Next i%
    For i% = 0 To 957: fsin2%(i%) = Sin(i% / 25) * 31 + 31: Next i%
    For i% = -471 To 871: fsin3%(i%) = Sin(i% / 75) * 91 + 127: Next i%

    Dim p16%(0 To 15)
    For i% = 0 To 15
        p16%(i%) = i% * 16
    Next i%


    Dim c1%(0 To 7), c2%(0 To 7), c3%(0 To 7)

    For i% = 0 To 5: c1%(i%) = i% + 1: c2%(i%) = i% + 7: c3%(i%) = i% + 13: Next i%

    For i% = 0 To 399: y2%(i%) = i% * 2: Next i%


    For i% = 0 To 399: lc%(i%) = i% / 6.4: Next i%



    y1% = 0
    fps% = 0
    Do While InKey$ = ""
        k% = k% + 3: If k% >= 283 Then k% = 0
        l% = l% + 2: If l% >= 157 Then l% = 0
        m% = m% + 1: If m% >= 471 Then m% = 0
        fps% = fps% + 1

        If fps% < 400 And y1% < 395 Then y1% = y1% + 1
        If fps% > 1200 And y1% <> 0 Then y1% = y1% - 1
        If y1% = 0 Then GoTo out1


        Wait &H3DA, 8: Wait &H3DA, 8, 8


        'GOTO 17
        Out &H3C8, 0
        Out &H3C9, 0
        Out &H3C9, 0
        Out &H3C9, 0
        17

        Def Seg = &HA000

        For y% = 0 To y1%

            Wait &H3DA, 1, 1: Wait &H3DA, 1




            f1% = fsin2%(y2%(y%) + l%) + fsin3%(y% - m%)
            f2% = fsin2%(y% + l%) + fsin1%(y2%(y%) + k%)


            For i% = 1 To 15

                b01%(f1% + i%) = i%
                b02%(f2% + i%) = p16%(i%)

                Poke f1% + i%, i% Or b02%(f1% + i%)
                Poke f2% + i%, p16%(i%) Or b01%(f2% + i%)
            Next i%


            Out &H3C8, 0
            Out &H3C9, (63 - lc%(y%))
            Out &H3C9, (63 - lc%(y%)) / 2
            Out &H3C9, lc%(y%)


        Next y%


        For i% = 0 To 319: Poke i%, 0: Next i%
        For i% = 0 To 319: b01%(i%) = 0: b02%(i%) = 0: Next i%

    Loop

    out1:







    ' --------- RGB copper bars -----------



    Cls

    For i% = 0 To 7
        Out &H3C8, i%
        Out &H3C9, i% * 5 + 28
        Out &H3C9, 0
        Out &H3C9, 0
    Next i%


    For i% = 8 To 15
        Out &H3C8, i%
        Out &H3C9, 0
        Out &H3C9, (i% - 8) * 5 + 28
        Out &H3C9, 0
    Next i%

    For i% = 16 To 23
        Out &H3C8, i%
        Out &H3C9, 0
        Out &H3C9, 0
        Out &H3C9, (i% - 16) * 5 + 28
    Next i%


    Out &H3D4, &H13
    Out &H3D5, 0

    For i% = 0 To 7: c1%(i%) = i%: c2%(i%) = i% + 8: c3%(i%) = i% + 16: Next i%: c1%(0) = 1





    k% = 0
    l% = 0
    m% = 0
    fps% = 0
    y1% = 0
    Do While InKey$ = ""
        k% = k% + 3: If k% >= 283 Then k% = 0
        l% = l% + 2: If l% >= 157 Then l% = 0
        m% = m% + 1: If m% >= 471 Then m% = 0

        fps% = fps% + 1

        If fps% < 400 And y1% < 395 Then y1% = y1% + 1
        If fps% > 1200 And y1% <> 0 Then y1% = y1% - 1
        If y1% = 0 Then GoTo out2


        Wait &H3DA, 8: Wait &H3DA, 8, 8

        Def Seg = &HA000

        For y% = 0 To y1%

            Wait &H3DA, 1

            For i% = 0 To 7
                Poke fsin2%(y2%(y%) + l%) + fsin3%(y% - m%) + i%, c1%(i%)
                Poke fsin2%(y% + l%) + fsin1%(y2%(y%) + k%) + i%, c2%(i%)
                Poke fsin1%(y% + k%) + fsin2%(y% + l%) + fsin3%(y% + m%) + i% - 99, c3%(i%)
            Next i%

            Out &H3C8, 0
            Out &H3C9, lc%(y%)
            Out &H3C9, 63 - lc%(y%)
            Out &H3C9, 63 - lc%(y%)

            Wait &H3DA, 1, 1

        Next y%


        For i% = 0 To 319: Poke i%, 0: Next i%

    Loop

    out2:


    Out &H3D4, &H28
    Out &H3D5, &H13

    Screen 13
    Screen 1

    Out &H3D4, &H28
    Out &H3D5, &H13

End Sub

Sub createobject (a%)


    Const pi = 3.1415926#
    rtm = 180 / pi


    clearscreen 0

    Select Case a%


        Case 1

            ' ========== Creating object 1 - Cube ==========


            For i% = 0 To 4

                xo%(i%) = 2 * i% - 5: yo%(i%) = 5: zo%(i%) = 5
                xo%(i% + 5) = 2 * i% - 5: yo%(i% + 5) = 5: zo%(i% + 5) = -5
                xo%(i% + 10) = 2 * i% - 5: yo%(i% + 10) = -5: zo%(i% + 10) = 5
                xo%(i% + 15) = 2 * i% - 5: yo%(i% + 15) = -5: zo%(i% + 15) = -5
                xo%(i% + 20) = -5: yo%(i% + 20) = 5: zo%(i% + 20) = 2 * i% - 5
                xo%(i% + 25) = 5: yo%(i% + 25) = 5: zo%(i% + 25) = 2 * i% - 5
                xo%(i% + 30) = -5: yo%(i% + 30) = -5: zo%(i% + 30) = 2 * i% - 5
                xo%(i% + 35) = 5: yo%(i% + 35) = -5: zo%(i% + 35) = 2 * i% - 5
                xo%(i% + 40) = 5: yo%(i% + 40) = 2 * i% - 5: zo%(i% + 40) = 5
                xo%(i% + 45) = 5: yo%(i% + 45) = 2 * i% - 5: zo%(i% + 45) = -5
                xo%(i% + 50) = -5: yo%(i% + 50) = 2 * i% - 5: zo%(i% + 50) = 5
                xo%(i% + 55) = -5: yo%(i% + 55) = 2 * i% - 5: zo%(i% + 55) = -5

            Next i%

            xo%(60) = 5: yo%(60) = 5: zo%(60) = 5
            xo%(61) = 5: yo%(61) = 5: zo%(61) = 5
            xo%(62) = 5: yo%(62) = 5: zo%(62) = 5
            xo%(63) = 5: yo%(63) = 5: zo%(63) = 5



            ' ========== Random copier for object 1 ==========

            For j% = 1 To 63
                metx% = Int(Rnd * 64 - 32)
                mety% = Int(Rnd * 64 - 32)
                metz% = Int(Rnd * 64 - 32)

                For i% = 0 To 63
                    xo%(i% + j% * 64) = xo%(i%) + metx%
                    yo%(i% + j% * 64) = yo%(i%) + mety%
                    zo%(i% + j% * 64) = zo%(i%) + metz%
                Next i%

            Next j%

            ' =================================



        Case 2


            ' ========== Creating object 2 - Sphere ==========


            j% = 0
            For i% = 90 To 270 Step 11.25
                c = i% / rtm
                xo%(j%) = Cos(c) * 63: yo%(j%) = Sin(c) * 63: zo%(j%) = 0
                j% = j% + 1
            Next i%



            yr = 0
            For i% = 1 To 15

                yr = yr + 22.5

                c = yr / rtm

                cosyr = Cos(c)
                sinyr = Sin(c)

                For j% = 0 To 15
                    xo%(j% + i% * 16) = cosyr * xo%(j%) - sinyr * zo%(j%)
                    zo%(j% + i% * 16) = sinyr * xo%(j%) + cosyr * zo%(j%)
                    yo%(j% + i% * 16) = yo%(j%)
                Next j%

            Next i%



            ' ========== Random copier for object 2 ==========

            For j% = 1 To 15
                metx% = Int(Rnd * 512 - 256)
                mety% = Int(Rnd * 512 - 256)
                metz% = Int(Rnd * 512 - 256)

                For i% = 0 To 255
                    xo%(i% + j% * 256) = xo%(i%) + metx%
                    yo%(i% + j% * 256) = yo%(i%) + mety%
                    zo%(i% + j% * 256) = zo%(i%) + metz%
                Next i%

            Next j%


        Case 3

            ' ========== Creating object 3 - Torus ==========

            j% = 0
            For i% = 0 To 359 Step 22.5
                c = i% / rtm
                xo%(j%) = Cos(c) * 64: yo%(j%) = Sin(c) * 64: zo%(j%) = 0
                j% = j% + 1
            Next i%


            i% = 90
            c = i% / rtm
            cosyr = Cos(c)
            sinyr = Sin(c)

            For i% = 0 To 15
                xp = xo%(i%)
                xo%(i%) = cosyr * xp - sinyr * zo%(i%)
                zo%(i%) = sinyr * xp + cosyr * zo%(i%)
                yo%(i%) = yo%(i%) - 192
            Next i%


            zr = 0

            For j% = 1 To 31
                zr = zr + 11.25
                c = zr / rtm

                coszr = Cos(c)
                sinzr = Sin(c)

                For i% = 0 To 15
                    xo%(i% + j% * 16) = coszr * xo%(i%) - sinzr * yo%(i%)
                    yo%(i% + j% * 16) = sinzr * xo%(i%) + coszr * yo%(i%)
                    zo%(i% + j% * 16) = zo%(i%)
                Next i%

            Next j%



            ' ========== Random copier for object 3 ==========

            For j% = 1 To 7

                xr = (Int(Rnd * 180) - 90) / rtm
                yr = (Int(Rnd * 180) - 90) / rtm
                zr = (Int(Rnd * 180) - 90) / rtm
                cosxr = Cos(xr)
                cosyr = Cos(yr)
                coszr = Cos(zr)
                sinxr = Sin(xr)
                sinyr = Sin(yr)
                sinzr = Sin(zr)

                metx% = Int(Rnd * 1024 - 512)
                mety% = Int(Rnd * 1024 - 512)
                metz% = Int(Rnd * 1024 - 512)


                For i% = 0 To 511

                    x(i%) = cosyr * xo%(i%) - sinyr * zo%(i%)
                    z(i%) = sinyr * xo%(i%) + cosyr * zo%(i%)

                    y(i%) = cosxr * yo%(i%) - sinxr * z(i%)
                    z(i%) = sinxr * yo%(i%) + cosxr * z(i%)

                    nx = x(i%)
                    x(i%) = coszr * nx - sinzr * y(i%)
                    y(i%) = sinzr * nx + coszr * y(i%)

                    xo%(i% + j% * 512) = x(i%) + metx%
                    yo%(i% + j% * 512) = y(i%) + mety%
                    zo%(i% + j% * 512) = z(i%) + metz%
                Next i%
            Next j%

        Case Else


    End Select


End Sub

Sub crosfade (r1%(), r2%(), g1%(), g2%(), b1%(), b2%())

    Shared xit%

    For k% = 0 To 63
        Wait &H3DA, 8: Wait &H3DA, 8, 8
        If xit% = 0 Then keyaction
        If xit% = 1 Then GoTo endcrosfade


        Out &H3C8, 0
        For c% = 0 To 255
            If r1%(c%) < r2%(c%) Then r1%(c%) = r1%(c%) + 1 Else If r1%(c%) > r2%(c%) Then r1%(c%) = r1%(c%) - 1
            If g1%(c%) < g2%(c%) Then g1%(c%) = g1%(c%) + 1 Else If g1%(c%) > g2%(c%) Then g1%(c%) = g1%(c%) - 1
            If b1%(c%) < b2%(c%) Then b1%(c%) = b1%(c%) + 1 Else If b1%(c%) > b2%(c%) Then b1%(c%) = b1%(c%) - 1
            Out &H3C9, r1%(c%)
            Out &H3C9, g1%(c%)
            Out &H3C9, b1%(c%)
        Next c%
    Next k%

    endcrosfade:
End Sub

Sub cycleblobs

    Shared xit%

    n% = 7

    For i% = 0 To 127
        Out &H3C8, i%
        Out &H3C9, 0
        Out &H3C9, 0
        Out &H3C9, 0
    Next i%


    For y% = 0 To 99
        For x% = 0 To 159
            sp%(p%) = 16384 \ Sqr((160 - x%) ^ 2 + (100 - y%) ^ 2) ^ 1.5
            If sp%(p%) > 255 Then sp%(p%) = 255
            p% = p% + 1
        Next x%
    Next y%

    For i% = 0 To 319
        If i% < 160 Then fsin2%(i%) = i% Else fsin2%(i%) = 319 - i%
    Next i%

    For i% = 0 To 199
        If i% > 99 Then fsin3%(i%) = (199 - i%) * 160 Else fsin3%(i%) = i% * 160
    Next i%

    For i% = 0 To 1792
        If i% > 255 Then cd%(i%) = 255 Else cd%(i%) = i%
    Next i%

    For i% = 1 To n%
        dsx%(i%) = Int(Rnd * 35 + 25)
        dsy%(i%) = Int(Rnd * 35 + 25)
        psx%(i%) = Int(Rnd * 64 + 64)
        psy%(i%) = Int(Rnd * 50 + 50)
    Next i%

    m% = 0: q% = 32: r%(1) = 1: g%(1) = 1: B%(1) = 1

    fps% = 0
    Do
        fps% = fps% + 1
        k% = k% + 1
        m% = m% + 1
        If fps% < 1600 And m% = q% Then m% = 0: q% = Int(Rnd * 255 + 5): r%(1) = r%(2): g%(1) = g%(2): B%(1) = B%(2): r%(2) = Int(Rnd * 63) + 1: g%(2) = Int(Rnd * 63) + 1: B%(2) = Int(Rnd * 63) + 1
        If fps% > 1600 And fps% < 1855 And m% = q% Then sq% = 1: m% = 0: q% = 255: r%(1) = r%(2): g%(1) = g%(2): B%(1) = B%(2): r%(2) = 0: g%(2) = 0: B%(2) = 0
        If fps% > 1856 And sq% = 1 And m% >= q% Then GoTo gout4
        If fps% > 2100 Then GoTo gout4
        r% = r%(1) + (r%(2) - r%(1)) / q% * m%
        g% = g%(1) + (g%(2) - g%(1)) / q% * m%
        B% = B%(1) + (B%(2) - B%(1)) / q% * m%
        If r% = 0 Then r% = 1
        If g% = 0 Then g% = 1
        If B% = 0 Then B% = 1

        For c% = 128 To 255
            Out &H3C8, c%
            If c% < 192 Then Out &H3C9, (c% - 128) / (63 / r%): Out &H3C9, (c% - 128) / (63 / g%): Out &H3C9, (c% - 128) / (63 / B%) Else Out &H3C9, (255 - c%) / (63 / r%): Out &H3C9, (255 - c%) / (63 / g%): Out &H3C9, (255 - c%) / (63 / B%)
        Next c%

        For i% = 1 To n%
            xp1%(i%) = Sin(k% / dsx%(i%)) * psx%(i%)
            yp1%(i%) = Sin(k% / dsy%(i%)) * psy%(i%)
        Next i%

        yp% = 0
        For y% = 0 To 199
            Def Seg = &HA000 + yp%
            yp% = yp% + 20

            yy%(1) = fsin3%(y% - yp1%(1))
            yy%(2) = fsin3%(y% - yp1%(2))
            yy%(3) = fsin3%(y% - yp1%(3))
            yy%(4) = fsin3%(y% - yp1%(4))
            yy%(5) = fsin3%(y% - yp1%(5))
            yy%(6) = fsin3%(y% - yp1%(6))
            yy%(7) = fsin3%(y% - yp1%(7))

            For x% = 24 To 295
dn% = sp%(yy%(1) + fsin2%(x% - xp1%(1))) + sp%(yy%(2) + fsin2%(x% - xp1%(2))) + sp%(yy%(3) + fsin2%(x% - xp1%(3))) + sp%(yy%(4) + fsin2%(x% - xp1%(4))) + sp%(yy%(5) + fsin2%(x% - xp1%(5))) + sp%(yy%(6) + fsin2%(x% - xp1%(6))) + sp%(yy%(7) + fsin2%( _
x% - xp1%(7)))
                Poke x%, cd%(dn%)

            Next x%
        Next y%

        Wait &H3DA, 8: Wait &H3DA, 8, 8
        If xit% = 0 Then keyaction
        If xit% = 1 Then GoTo gout4

    Loop
    gout4:

End Sub

Sub deedlinesax (c%)

    Shared xit%

    Line (20, 20)-(25, 80), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (25, 80)-(60, 70), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (60, 70)-(55, 30), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (55, 30)-(20, 20), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    Line (25, 25)-(30, 60), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (30, 60)-(50, 65), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (50, 65)-(25, 25), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    If c% = 15 Then f% = Int(Rnd * 255) Else f% = 0
    Paint (23, 23), f%, c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    Line (65, 20)-(100, 24), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (100, 24)-(70, 34), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (70, 34)-(85, 44), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (85, 44)-(75, 54), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (75, 54)-(75, 64), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (75, 64)-(85, 64), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (85, 64)-(70, 70), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (70, 70)-(65, 20), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    If c% = 15 Then f% = Int(Rnd * 255) Else f% = 0
    Paint (66, 21), f%, c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    Line (110, 30)-(130, 30), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (130, 30)-(110, 40), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (110, 40)-(110, 50), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (110, 50)-(125, 50), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (125, 50)-(125, 55), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (125, 55)-(110, 55), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (110, 55)-(110, 65), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (110, 65)-(120, 65), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (120, 65)-(120, 70), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (120, 70)-(100, 70), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (100, 70)-(110, 30), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    If c% = 15 Then f% = Int(Rnd * 255) Else f% = 0
    Paint (111, 31), f%, c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    Line (150, 40)-(130, 20), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (130, 20)-(140, 70), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (140, 70)-(150, 40), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    Line (135, 30)-(140, 60), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (140, 60)-(145, 40), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (145, 40)-(135, 30), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    If c% = 15 Then f% = Int(Rnd * 255) Else f% = 0
    Paint (133, 25), f%, c%: delay 10


    Line (160, 30)-(165, 70), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (165, 70)-(190, 70), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (190, 70)-(175, 65), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (175, 65)-(160, 30), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    If c% = 15 Then f% = Int(Rnd * 255) Else f% = 0
    Paint (164, 40), f%, c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    Line (180, 20)-(190, 60), c%, BF: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    Line (195, 20)-(195, 70), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (195, 70)-(200, 40), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (200, 40)-(220, 65), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (220, 65)-(220, 35), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (220, 35)-(215, 55), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (215, 55)-(195, 20), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    If c% = 15 Then f% = Int(Rnd * 255) Else f% = 0
    Paint (196, 30), f%, c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax


    Line (245, 20)-(225, 20), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (225, 20)-(225, 60), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (225, 60)-(250, 60), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (250, 60)-(250, 50), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (250, 50)-(230, 50), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (230, 50)-(230, 40), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (230, 40)-(240, 40), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (240, 40)-(240, 35), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (240, 35)-(228, 35), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (228, 35)-(230, 25), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (230, 25)-(245, 20), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    If c% = 15 Then f% = Int(Rnd * 255) Else f% = 0
    Paint (227, 24), f%, c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    Line (300, 5)-(260, 8), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (260, 8)-(290, 58), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (290, 58)-(250, 68), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (250, 68)-(305, 64), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (305, 64)-(270, 18), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax
    Line (270, 18)-(300, 5), c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax

    If c% = 15 Then f% = Int(Rnd * 255) Else f% = 0
    Paint (265, 10), f%, c%: delay 10: If xit% = 1 Then GoTo enddeedlinesax


    Color c% \ 15
    Locate 1, 1: Print "SAX!"
    delay 70: If xit% = 1 Then GoTo enddeedlinesax

    For y% = 0 To 63
        For x% = 0 To 255
            a% = Point(x% \ 8, y% \ 8) * (Sin(y% / 45) * c% + Cos(x% / 45) * c% + 2 * c%)
            PSet (x% + 40, y% + 100), a%
        Next x%
    Next y%
    delay 140: If xit% = 1 Then GoTo enddeedlinesax

    Color c%
    Locate 22, 10: Print "Not so serious side :)": Print "Just for fun or boredom to draw anything"

    enddeedlinesax:

End Sub

Sub delay (t%)

    Shared xit%

    For i% = 1 To t%
        Wait &H3DA, 8: Wait &H3DA, 8, 8
        keyaction
        If xit% = 1 Then GoTo endelay
    Next i%

    endelay:
End Sub

Sub fadefromcolor (a%, c%, t%, r%, g%, B%)

    Shared xit%

    For s% = 1 To t%

        Out &H3C8, a%
        For k% = a% To c%
            Out &H3C9, r% + s% * ((r%(k%) - r%) / t%)
            Out &H3C9, g% + s% * ((g%(k%) - g%) / t%)
            Out &H3C9, B% + s% * ((B%(k%) - B%) / t%)
        Next k%

        Wait &H3DA, 8: Wait &H3DA, 8, 8
        If xit% = 0 Then keyaction
        If xit% = 1 Then GoTo endfadefromcolor
    Next s%


    endfadefromcolor:
End Sub

Sub fadetocolor (a%, c%, t%, r%, g%, B%)

    Shared xit%

    For s% = 1 To t%

        Out &H3C8, a%
        For k% = a% To c%
            Out &H3C9, r%(k%) + s% * ((r% - r%(k%)) / t%)
            Out &H3C9, g%(k%) + s% * ((g% - g%(k%)) / t%)
            Out &H3C9, B%(k%) + s% * ((B% - B%(k%)) / t%)
        Next k%

        Wait &H3DA, 8: Wait &H3DA, 8, 8
        If xit% = 0 Then keyaction
        If xit% = 1 Then GoTo endfadetocolor

    Next s%

    endfadetocolor:
End Sub

Sub getmap (a$)

    ' ------------------ Get Map --------------------

    Open a$ For Binary As #1

    Get #1, 1, a$
    xg% = Asc(a$)
    Get #1, 2, a$
    yg% = Asc(a$)

    k% = 2
    For y% = 0 To yg% - 1
        For x% = 0 To xg% - 1

            k% = k% + 1
            Get #1, k%, a$
            cd%(y% * 32 + x%) = Asc(a$)

        Next x%
    Next y%
    Close

End Sub

Sub getpal

    Out &H3C7, 0
    For k% = 0 To 255
        r%(k%) = Inp(&H3C9)
        g%(k%) = Inp(&H3C9)
        B%(k%) = Inp(&H3C9)
    Next k%

End Sub

Sub initcrosfadepics (a%, B%)

    For l% = 0 To 11

        For g% = 0 To 19
            c$ = Mid$(text$(a%, l%), g% + 1, 1)
            d$ = Mid$(text$(B%, l%), g% + 1, 1)

            yp% = 0
            For y% = 0 To 15
                Def Seg = &HA000 + yp% + l% * 320
                yp% = yp% + 20

                For x% = 0 To 15
                    Poke x% + g% * 16, fonts%(fpos%(Asc(c$)) * 256 + y% * 16 + x%) Or (fonts%(fpos%(Asc(d$)) * 256 + y% * 16 + x%)) * 16
                Next x%
            Next y%

        Next g%

    Next l%

End Sub

Sub Intersections

    Shared px%, py%, pa%, ps%
    Shared va%, ra, dpp%


    va = pa% + 32.2
    If va > 360 Then va = 32.2 - (360 - pa%)

    For sl% = 0 To 319
        va = va - ra
        If va < 0 Then va = 358.8
        va% = va

        If va% = 0 Or va% = 180 Or va% = 360 Then GoTo 112


        ' ---------- Horizontal intersection ----------------

        If va% > 0 And va% < 180 Then ay% = (py% \ 64) * 64 - 1 Else If va% > 180 And va% < 360 Then ay% = (py% \ 64) * 64 + 64
        ax% = px% + (py% - ay%) / Tan(va / 57.3)

        bx% = ax% \ 64
        by% = ay% \ 64
        If bx% < 0 Then bx% = 0
        If bx% > 31 Then bx% = 31
        If by% < 0 Then by% = 0
        If by% > 31 Then by% = 31

        If cd%(mul32%(by%) + bx%) = 1 Then cx% = ax%: cy% = ay%: GoTo 112

        If va% > 0 And va% < 180 Then yd% = -64 Else If va% > 180 And va% < 360 Then yd% = 64

        xd% = (-yd%) / Tan(va / 57.3)
        If xd% > 2048 Then xd% = 2048
        If xd% < -2048 Then xd% = -2048
        cx% = ax%: cy% = ay%

        Do
            cx% = cx% + xd%: If cx% > 2048 Or cx% < -2048 Then GoTo 112
            cy% = cy% + yd%: If cy% > 2048 Or cy% < -2048 Then GoTo 112
            bx% = cx% \ 64: by% = cy% \ 64
            If bx% < 0 Then bx% = 0
            If bx% > 31 Then bx% = 31
            If by% < 0 Then by% = 0
            If by% > 31 Then by% = 31

        Loop Until cd%(mul32%(by%) + bx%) = 1 Or bx% = 31 Or by% = 31


        112
        cxa% = cx%: cya% = cy%

        If va% = 90 Or va% = 270 Then GoTo 113


        ' ---------- Vertical intersection ----------------

        If va% > 270 Or va% < 90 Then ax% = (px% \ 64) * 64 + 64 Else If va% > 90 Or va% < 270 Then ax% = (px% \ 64) * 64 - 1
        ay% = py% - (ax% - px%) * Tan(va / 57.3)

        bx% = ax% \ 64
        by% = ay% \ 64
        If bx% < 0 Then bx% = 0
        If bx% > 31 Then bx% = 31
        If by% < 0 Then by% = 0
        If by% > 31 Then by% = 31

        If cd%(mul32%(by%) + bx%) = 1 Then cx% = ax%: cy% = ay%: GoTo 113

        If va% > 270 Or va% < 90 Then xd% = 64 Else If va% > 90 Or va% < 270 Then xd% = -64

        yd% = (-xd%) * Tan(va / 57.3)
        cx% = ax%: cy% = ay%


        Do
            cx% = cx% + xd%: cy% = cy% + yd%
            bx% = cx% \ 64: by% = cy% \ 64
            If bx% < 0 Or bx% > 31 Then bx% = 31
            If by% < 0 Or by% > 31 Then by% = 31

        Loop Until cd%(mul32%(by%) + bx%) = 1 Or bx% = 31 Or by% = 31

        113



        cxb% = cx%: cyb% = cy%

        wdisa% = Sqr((px% - cxa%) ^ 2 + (py% - cya%) ^ 2)
        wdisb% = Sqr((px% - cxb%) ^ 2 + (py% - cyb%) ^ 2)

        If wdisa% < wdisb% Then wdis% = wdisa% Else wdis% = wdisb%

        dis%(sl%) = wdis% * Cos((pa% - va) / 57.3)
        slc%(sl%) = 64 * (dpp% / dis%(sl%))
        If slc%(sl%) > 200 Then slc%(sl%) = 200
        sc%(sl%) = 254 - dis%(sl%) \ 2: If sc%(sl%) < 0 Then sc%(sl%) = 0


        sla%(sl%) = (200 - slc%(sl%)) \ 2: slb%(sl%) = sla%(sl%) + slc%(sl%)



    Next sl%

    117

End Sub

Sub keyaction

    Shared xit%

    kb% = Inp(&H60)
    If kb% = 1 Then xit% = 1
End Sub

Sub load3drecord

    Shared gi$, gg$, ggi%, gi%, filei%, gg%

    If ggi% < gi% Then ggi% = ggi% + 1 Else Get #2, , gi$: gi% = Asc(gi$): Get #2, , gg$: gg% = Asc(gg$): ggi% = 1: filei% = filei% + 2


End Sub

Sub loadobject (a$)

    Shared ndts%, nlns%, npls%

    clearscreen 0

    Open a$ For Binary As #1

    Get #1, , ndts%
    Get #1, , nlns%
    Get #1, , npls%

    a$ = " "

    For i% = 0 To ndts% - 1
        Get #1, , a$: xo%(i%) = Asc(a$) - 128
        Get #1, , a$: yo%(i%) = Asc(a$) - 128
        Get #1, , a$: zo%(i%) = Asc(a$) - 128
    Next i%

    For i% = 0 To nlns% - 1
        'GET #1, , ln%(i%, 0)
        'GET #1, , ln%(i%, 1)
    Next i%

    For i% = 0 To npls% - 1
        'GET #1, , pl%(i%, 0)
        'GET #1, , pl%(i%, 1)
        'GET #1, , pl%(i%, 2)
    Next i%

    Close #1

End Sub

Sub loadqbinside

    ' ------------ Load Quickbasic inside Big --------------

    a$ = "qbrules.spr"
    c$ = " "
    Open a$ For Binary As #1

    Out &H3C8, 128
    For i% = 0 To 383
        Get #1, , c$: Out &H3C9, Asc(c$)
    Next i%


    xg% = 100
    yg% = 100

    i% = 0
    For y% = 1 To yg%
        For x% = 1 To xg%
            Get #1, , c$: sp%(i%) = Asc(c$)
            i% = i% + 1
        Next x%
    Next y%
    Close #1


End Sub

Sub loadrecord

    Shared k$, gi$, gg$, ggi%, gi%, filei%, gg%

    If ggi% < gi% Then ggi% = ggi% + 1 Else Get #2, , gi$: gi% = Asc(gi$): Get #2, , gg$: gg% = Asc(gg$): ggi% = 1: filei% = filei% + 2
    pushgg% = gg%
    For i% = 4 To 1 Step -1
        If gg% - 2 ^ (i% - 1) >= 0 Then gg% = gg% - 2 ^ (i% - 1): ka%(i%) = 1 Else ka%(i%) = 0
    Next i%
    gg% = pushgg%

    kon%(75) = ka%(1)
    kon%(77) = ka%(2)
    kon%(72) = ka%(3)
    kon%(80) = ka%(4)

End Sub

Sub mov3dpos (xp, yp, zp)

    Shared ndts%

    For i% = 0 To ndts% - 1
        x(i%) = x(i%) + xp
        y(i%) = y(i%) + yp
        z(i%) = z(i%) + zp
    Next i%

End Sub

Sub Output0

    Shared map%, px%, py%

    ' -------------- Output ------------------

    cx% = px% \ 64
    cy% = py% \ 64

    Select Case map%

        Case 0

            yp% = 0
            For y% = 0 To 199
                Def Seg = &HA000 + yp%
                yp% = yp% + 20

                For x% = 0 To 319

                    If y% > sla%(x%) And y% < slb%(x%) Then Poke x%, sc%(x%) Else Poke x%, fs%(y%)

                Next x%
            Next y%

            sp%(mul128%(py% \ 16) + px% \ 16) = 24


        Case 1

            yp% = 0
            For y% = 0 To 199
                Def Seg = &HA000 + yp%
                yp% = yp% + 20

                For x% = 0 To 319

                    If y% > sla%(x%) And y% < slb%(x%) Then c% = sc%(x%) Else c% = fs%(y%)
                    If x% > 127 Or y% > 127 Then Poke x%, c% Else Poke x%, div2%(c%) + sp%(mul128%(y%) + x%)

                Next x%
            Next y%

            sp%(mul128%(py% \ 16) + px% \ 16) = 24


        Case Else
    End Select


End Sub

Sub output3d

    Shared ftype%, ndts%, nlns%, obj%
    Shared filei%

    zp% = zpo%(obj%)
    Select Case ftype%

        Case Is = 0

            For i% = 0 To ndts% - 1

                xak% = xs%(i%, 1) + 160
                If xak% > -1 And xak% < 320 And ys%(i%, 1) > -101 And ys%(i%, 1) < 100 Then Poke ypk&(ys%(i%, 1)) + xak%, 0

                xsk% = xs%(i%, 0) + 160
                c% = 256 - z(i%) * (80 / zp%): If c% < 80 Then c% = 80
                If xsk% > -1 And xsk% < 320 And ys%(i%, 0) > -101 And ys%(i%, 0) < 100 Then Poke ypk&(ys%(i%, 0)) + xsk%, c%


            Next i%


            Select Case filei%

                Case 0 TO 10, 780 TO 936, 1320 TO 1440, 2162 TO 2400, 3520 TO 3640, 4180 TO 4230

                Case Else
                    Wait &H3DA, 8: Wait &H3DA, 8, 8
            End Select


        Case Else

            'FOR i% = 0 TO nlns% - 1
            'LINE (xs%(ln%(i%, 0), 1) + 160, ys%(ln%(i%, 0), 1) + 100)-(xs%(ln%(i%, 1), 1) + 160, ys%(ln%(i%, 1), 1) + 100), 1
            'NEXT i%
            clearscreen 1

            Out &H3C8, 0
            Out &H3C9, 0
            Out &H3C9, 0
            Out &H3C9, 0

            Wait &H3DA, 8: Wait &H3DA, 8, 8

            Out &H3C8, 0
            Out &H3C9, 63
            Out &H3C9, 0
            Out &H3C9, 0


            For i% = 0 To nlns% - 1
                'LINE (xs%(ln%(i%, 0), 0) + 160, ys%(ln%(i%, 0), 0) + 100)-(xs%(ln%(i%, 1), 0) + 160, ys%(ln%(i%, 1), 0) + 100), 15
            Next i%

    End Select


End Sub

Sub plasmablobs

    Shared xit%

    meg = 1.3
    n% = 3



    Out &H3C8, 0
    For i% = 0 To 127
        Out &H3C9, 0
        Out &H3C9, 0
        Out &H3C9, 0
    Next i%

    For i% = 128 To 159
        Out &H3C9, 0
        Out &H3C9, (i% - 128) * 2
        Out &H3C9, 0
    Next i%

    For i% = 160 To 191
        Out &H3C9, 0
        Out &H3C9, (191 - i%) * 2
        Out &H3C9, 0
    Next i%

    For i% = 192 To 255
        Out &H3C9, i% - 192
        Out &H3C9, i% - 192
        Out &H3C9, i% - 192
    Next i%

    getpal

    Out &H3C8, 0
    For i% = 0 To 255
        Out &H3C9, 0
        Out &H3C9, 0
        Out &H3C9, 0
    Next i%


    For i% = -157 To 518
        If i% > -1 And i% < 519 Then fsin1%(i%) = Sin(i% / 45) * 63: fsin2%(i%) = Sin(i% / 35) * 127
        If i% > -158 And i% < 476 Then fsin3%(i%) = Sin(i% / 25) * 31
    Next i%


    rc% = -1

    For i% = -1 To -156 Step -1
        dt100%(i%) = 63 - (i% - ((i% - 63) \ 64) * 64)
        If rc% = 1 Then dt100%(i%) = 63 - dt100%(i%)
        If dt100%(i%) = 0 And rc% = 1 Then rc% = -1
        If dt100%(i%) = 63 And rc% = -1 Then rc% = 1
    Next i%

    rc% = 1

    For i% = 0 To 156
        dt100%(i%) = i% - ((i%) \ 64) * 64
        If rc% = -1 Then dt100%(i%) = 63 - dt100%(i%)
        If dt100%(i%) = 63 And rc% = 1 Then rc% = -1
        If dt100%(i%) = 0 And rc% = -1 Then rc% = 1
    Next i%




    Dim cf%(0 To 4095)

    l% = 0
    For i% = 0 To 63
        For k% = 0 To 63
            cf%(l%) = i% * (k% / 63)
            l% = l% + 1
        Next k%
    Next i%


    i% = 0
    For y% = 0 To 99
        For x% = 0 To 159
            If x% = 159 And y% = 99 Then sp%(i%) = 255 Else sp%(i%) = 16384 \ Sqr((159 - x%) ^ 2 + (99 - y%) ^ 2) ^ meg
            If sp%(i%) > 255 Then sp%(i%) = 255
            i% = i% + 1
        Next x%
    Next y%



    For i% = -160 To 479
        If i% < 0 Or i% > 319 Then fsin4%(i%) = 0 Else If i% < 160 Then fsin4%(i%) = i% Else fsin4%(i%) = 319 - i%
    Next i%

    For i% = -100 To 300
        If i% < 0 Or i% > 199 Then cy%(i%) = 0 Else If i% > 99 Then cy%(i%) = 199 - i% Else cy%(i%) = i%
        cy%(i%) = cy%(i%) * 160
    Next i%

    For i% = 0 To 767
        If i% > 255 Then cd%(i%) = 255 Else cd%(i%) = i%
    Next i%

    For i% = -192 To 63
        dt%(i%) = i% * 64
    Next i%




    For i% = 1 To n%
        dsx%(i%) = Int(Rnd * 45 + 45)
        dsy%(i%) = Int(Rnd * 30 + 30)
        psx%(i%) = Int(Rnd * 80 + 80)
        psy%(i%) = Int(Rnd * 50 + 50)
    Next i%

    k% = 0
    l% = 0


    ax = Timer


    s% = 0: t% = 256
    s1% = 0: t1% = 256
    k0% = 128: k1% = 191
    l0% = 128: l1% = 191
    r1% = 0: g1% = 0: b1% = 0
    fps% = 0
    Do
        fps% = fps% + 1
        k% = k% + 2
        If k% > 156 Then k% = 0

        l% = l% + 1
        For i% = 1 To n%
            xp1%(i%) = Sin(l% / dsx%(i%)) * psx%(i%)
            yp1%(i%) = Sin(l% / dsy%(i%)) * psy%(i%)
        Next i%

        If fps% = 512 Then k0% = 192: k1% = 255: s% = 0
        If fps% = 1512 Then fadeout% = 1
        If fps% = 2500 Then getpal: s1% = 0: l0% = 0: l1% = 255: r1% = 63: g1% = 63: b1% = 63
        If fps% = 2800 Then GoTo gout7

        If s% < t% Then s% = s% + 1 Else GoTo endfadepal1

        For kk% = k0% To k1%
            Out &H3C8, kk%
            Out &H3C9, 0 + s% * ((r%(kk%) - 0) / t%)
            Out &H3C9, 0 + s% * ((g%(kk%) - 0) / t%)
            Out &H3C9, 0 + s% * ((B%(kk%) - 0) / t%)
        Next kk%

        endfadepal1:


        If fadeout% = 0 Then GoTo nofadeout1
        If s1% < t1% Then s1% = s1% + 1

        For kk% = l0% To l1%
            Out &H3C8, kk%
            Out &H3C9, r%(kk%) + s1% * ((r1% - r%(kk%)) / t1%)
            Out &H3C9, g%(kk%) + s1% * ((g1% - g%(kk%)) / t1%)
            Out &H3C9, B%(kk%) + s1% * ((b1% - B%(kk%)) / t1%)
        Next kk%


        nofadeout1:




        yp% = 0

        For y% = 0 To 199
            Def Seg = &HA000 + yp%
            yp% = yp% + 20

            yy%(1) = cy%(y% - yp1%(1))
            yy%(2) = cy%(y% - yp1%(2))
            yy%(3) = cy%(y% - yp1%(3))

            For x% = 0 To 319

                dyn% = cd%(sp%(yy%(1) + fsin4%(x% - xp1%(1))) + sp%(yy%(2) + fsin4%(x% - xp1%(2))) + sp%(yy%(3) + fsin4%(x% - xp1%(3))))
                If dyn% < 192 Then Poke x%, dyn% Else pls% = dt100%(fsin3%(x% + k%) + fsin3%(y%) + fsin1%(x% + y%) + fsin3%(fsin3%(y% - k%) + fsin2%(x%) + k%)): Poke x%, cf%(dt%(dyn% - 192) + pls%) + 192

            Next x%
        Next y%


        Wait &H3DA, 8: Wait &H3DA, 8, 8
        If xit% = 0 Then keyaction
        If xit% = 1 Then GoTo gout7



    Loop

    gout7:

End Sub

Sub precalculations



    Rem --------- Div2 -----------

    For i% = 0 To 255
        div2%(i%) = i% \ 2
    Next i%


    Rem --------- Div4 -----------

    For i% = 0 To 320
        div4%(i%) = i% \ 4
    Next i%

    Rem ----------- Mul32 -------------
    For i% = 0 To 32
        mul32%(i%) = i% * 32
    Next i%

    Rem ----------- Nul128 ------------
    For i% = 0 To 127
        mul128%(i%) = i% * 128
    Next i%


    Rem --------- Map Output buffer precalc ---------


    i% = 0
    For y% = 0 To 127
        For x% = 0 To 127
            sp%(i%) = cd%((y% \ 4) * 32 + x% \ 4) * 128

            i% = i% + 1
        Next x%
    Next y%


    Rem ----------- Floor&Ceiling Shades -------------

    ast = 32 / 100
    ang = 0

    For i% = 0 To 99

        If ang = 0 Then ang = .01
        dist = 24 / Sin(ang / 57.3)
        fs = (255 - dist)
        If fs < 0 Then fs%(99 - i%) = 0 Else fs%(99 - i%) = fs
        fs%(i% + 100) = fs%(99 - i%)

        ang = ang + ast
    Next i%


End Sub

Sub prehistoricode

    Shared xit%

    l% = 15
    Screen 12

    1
    keyaction
    If xit% = 1 Then GoTo prehistoricodend
    Color 15: Locate 15, 18: Print "Press the" + Chr$(34) + "any key" + Chr$(34) + " button to continue.. ;-)"


    c% = Int(Rnd * 63 + 1)
    For i% = 1 To 640 Step 15
        Line (i%, 480)-(640, 480 - i%), i% / c%
    Next i%
    cc% = cc% + 1
    Circle (cx%, cy%), cc%, l%
    If cc% = 30 Then cc% = 0: l% = 0: k% = 1: GoTo 1
    If k% = 1 And cc% = 29 Then cc% = 0: l% = 15: cx% = Int(Rnd * 640): cy% = Int(Rnd * 480): k% = 0
    a$ = InKey$

    While a$ = ""
        GoTo 1
        a$ = "z"
    Wend

    For z% = 1 To 480
        keyaction
        If xit% = 1 Then GoTo prehistoricodend
        t% = 31 - z% / 16
        Circle (320, 240), z%, t%
        For i& = 0 To 16383: Next i&
    Next z%
    For z% = 1 To 640
        keyaction
        If xit% = 1 Then GoTo prehistoricodend
        Circle (320, 240), z%, 0
        For i& = 0 To 16383: Next i&
    Next z%


    prehistoricodend:

End Sub

Sub rgblights

    Shared xit%

    meg = 2.2
    n% = 3


    For i% = 0 To 127
        Out &H3C8, i%
        Out &H3C9, 0
        Out &H3C9, 0
        Out &H3C9, 0
    Next i%



    i% = 0
    Out &H3C8, 0

    For a% = 0 To 5
        For B% = 0 To 5
            For c% = 0 To 5

                Out &H3C9, a% * 12.6
                Out &H3C9, B% * 12.6
                Out &H3C9, c% * 12.6

                r1%(i%) = i%
                i% = i% + 1

            Next c%
        Next B%
    Next a%


    For i% = 0 To 5
        epi6%(i%) = i% * 6
        epi36%(i%) = i% * 36
    Next i%


    i% = 0
    For y% = 0 To 99
        For x% = 0 To 159
            If x% = 159 And y% = 99 Then sp%(i%) = 255 Else sp%(i%) = 16384 \ Sqr((159 - x%) ^ 2 + (99 - y%) ^ 2) ^ meg
            If sp%(i%) > 255 Then sp%(i%) = 255
            i% = i% + 1
        Next x%
    Next y%



    For i% = -320 To 639
        If i% < 0 Or i% > 319 Then fsin3%(i%) = 0 Else If i% < 160 Then fsin3%(i%) = i% Else fsin3%(i%) = 319 - i%
    Next i%

    For i% = -300 To 500
        If i% < 0 Or i% > 199 Then fsin4%(i%) = 0 Else If i% > 99 Then fsin4%(i%) = 199 - i% Else fsin4%(i%) = i%
        fsin4%(i%) = fsin4%(i%) * 160
    Next i%

    For i% = 0 To 1792
        If i% > 5 Then cd%(i%) = 5 Else cd%(i%) = i%
    Next i%




    For i% = 1 To n%
        dsx%(i%) = Int(Rnd * 35 + 15)
        dsy%(i%) = Int(Rnd * 35 + 15)
        psx%(i%) = Int(Rnd * 80 + 80)
        psy%(i%) = Int(Rnd * 50 + 50)
    Next i%

    k% = 40
    plx = 8: ply = 8
    ax = Timer
    Do
        k% = k% + 1
        If plx > 1 And k% < 1024 Then plx = plx - .025
        If ply > 1 And k% < 1024 Then ply = ply - .025
        If k% > 1024 Then plx = plx + .01: ply = ply + .01
        If k% = 1220 Then GoTo gout3


        For i% = 1 To n%
            psx% = psx%(i%) * plx
            psy% = psy%(i%) * ply
            If psx% > 320 Then psx% = 320
            If psy% > 300 Then psy% = 300
            xp1%(i%) = Sin(k% / dsx%(i%)) * psx%
            yp1%(i%) = Sin(k% / dsy%(i%)) * psy%
        Next i%


        yp% = 0

        For y% = 0 To 199
            Def Seg = &HA000 + yp%
            yp% = yp% + 20

            yy%(1) = fsin4%(y% - yp1%(1))
            yy%(2) = fsin4%(y% - yp1%(2))
            yy%(3) = fsin4%(y% - yp1%(3))

            For x% = 0 To 319

                ca% = cd%(sp%(yy%(1) + fsin3%(x% - xp1%(1))))
                cb% = cd%(sp%(yy%(2) + fsin3%(x% - xp1%(2))))
                cc% = cd%(sp%(yy%(3) + fsin3%(x% - xp1%(3))))

                Poke x%, r1%(ca% + epi6%(cb%) + epi36%(cc%))
            Next x%
        Next y%

        Wait &H3DA, 8: Wait &H3DA, 8, 8
        If xit% = 0 Then keyaction
        If xit% = 1 Then GoTo gout3

    Loop

    gout3:


End Sub

Sub rotate3d (xr, yr, zr)

    Shared ndts%

    cosxr = Cos(xr)
    cosyr = Cos(yr)
    coszr = Cos(zr)
    sinxr = Sin(xr)
    sinyr = Sin(yr)
    sinzr = Sin(zr)

    For i% = 0 To ndts% - 1

        x(i%) = cosyr * xo%(i%) - sinyr * zo%(i%)
        z(i%) = sinyr * xo%(i%) + cosyr * zo%(i%)

        y(i%) = cosxr * yo%(i%) - sinxr * z(i%)
        z(i%) = sinxr * yo%(i%) + cosxr * z(i%)

        nx = x(i%)
        x(i%) = coszr * nx - sinzr * y(i%)
        y(i%) = sinzr * nx + coszr * y(i%)

    Next i%


End Sub

Sub saverecord

    Shared k$

    k$ = Chr$(kon%(75)): Put #2, , k$
    k$ = Chr$(kon%(77)): Put #2, , k$
    k$ = Chr$(kon%(72)): Put #2, , k$
    k$ = Chr$(kon%(80)): Put #2, , k$

End Sub

Sub setcrosfadepal (r1%(), r2%(), g1%(), g2%(), b1%(), b2%())

    Out &H3C8, 0

    For j% = 0 To 15
        For i% = 0 To 15
            Out &H3C9, i% * 4: r1%(j% * 16 + i%) = i% * 4
            Out &H3C9, i% * 4: g1%(j% * 16 + i%) = i% * 4
            Out &H3C9, i% * 4: b1%(j% * 16 + i%) = i% * 4
        Next i%
    Next j%

    For i% = 0 To 255
        r2%(i%) = (i% \ 16) * 4
        g2%(i%) = (i% \ 16) * 4
        b2%(i%) = (i% \ 16) * 4
    Next i%

End Sub

Sub setpal (c1%, c2%, r1%, g1%, b1%, r2%, g2%, b2%)

    dc% = c2% - c1%
    r = r1%: g = g1%: B = b1%


    Out &H3C8, c1%

    For i% = c1% To c2%

        Out &H3C9, r
        Out &H3C9, g
        Out &H3C9, B

        r = r + (r2% - r1%) / dc%
        g = g + (g2% - g1%) / dc%
        B = B + (b2% - b1%) / dc%

    Next i%


End Sub

Sub spheremaplasma

    Shared xit%

    ' ------------- Sphere mapped plasma ------------



    setpal 0, 31, 0, 0, 0, 63, 0, 0
    setpal 32, 63, 63, 0, 0, 63, 0, 63
    setpal 64, 95, 63, 0, 63, 0, 63, 63
    setpal 96, 127, 0, 63, 63, 0, 0, 0

    setpal 128, 159, 0, 0, 31, 31, 0, 31
    setpal 160, 191, 31, 0, 31, 31, 0, 63
    setpal 192, 223, 31, 0, 63, 0, 47, 63
    setpal 224, 254, 0, 47, 63, 0, 0, 31

    getpal
    r%(255) = 0: g%(255) = 0: B%(255) = 31

    setpal 0, 255, 63, 63, 63, 63, 63, 63

    delay 210



    a$ = "sphrprec.dat"

    fp& = -1
    Open a$ For Binary As #1

    For i% = 0 To 16383

        fp& = fp& + 2
        Get #1, fp&, a$
        xp% = Asc(a$)
        Get #1, fp& + 1, a$
        yp% = Asc(a$)

        sp%(i%) = yp% * 128 + xp%
        If i% = 64 * 128 + 64 Then sp%(i%) = sp%(i%) + 1

    Next i%

    Close



    dg% = 99

    For i% = -180 To -1
        dt%(i%) = i% - ((i% - dg% + 1) \ dg%) * dg%
        dt100%(i%) = (i% - ((i% - dg% + 1) \ dg%) * dg%) * 100
    Next i%

    For i% = 0 To 180
        dt%(i%) = i% - ((i% - 1) \ dg%) * dg%
        dt100%(i%) = (i% - ((i% - 1) \ dg%) * dg%) * 100
    Next i%



    For i% = -640 To 518
        fsin2%(i%) = Sin(i% / 16) * 31
    Next i%

    For i% = -640 To 715
        fsin3%(i%) = Sin(i% / 63) * 75
    Next i%


    For i% = -168 To 168
        mod256128%(i%) = ((i% + 512) Mod 256) \ 2
    Next i%







    xs = 91: vxs = 1: ys = -96: vys = 0: fs = 0
    yys% = 134


    While InKey$ <> "": Wend

    s% = 0: t% = 256
    s1% = 0: t1% = 256
    fps% = 0


    k% = 0: l% = 0
    Do
        fps% = fps% + 1
        k% = k% + 1: l% = l% + 1
        If k% = 101 Then k% = 0
        If l% = 396 Then l% = 0
        m% = -1

        If fps% = 256 Then fs = .02
        If fps% = 256 + 768 Then yys% = 654
        If fps% = 256 + 1024 Then fadeout% = 1


        If s% < t% Then s% = s% + 1 Else GoTo endfadepal

        Out &H3C8, 0
        For n% = 0 To 255
            Out &H3C9, 63 + s% * ((r%(n%) - 63) / t%)
            Out &H3C9, 63 + s% * ((g%(n%) - 63) / t%)
            Out &H3C9, 63 + s% * ((B%(n%) - 63) / t%)
        Next n%

        endfadepal:


        If fadeout% = 0 Then GoTo nofadeout
        If s1% < t1% Then s1% = s1% + 1 Else GoTo gout

        Out &H3C8, 0
        For n% = 0 To 255
            Out &H3C9, r%(n%) + s1% * ((0 - r%(n%)) / t1%)
            Out &H3C9, g%(n%) + s1% * ((0 - g%(n%)) / t1%)
            Out &H3C9, B%(n%) + s1% * ((0 - B%(n%)) / t1%)
        Next n%


        nofadeout:


        xs = xs + vxs: If xs > 254 Or xs < 65 Then vxs = -vxs
        vys = vys + fs
        ys = ys + vys
        If ys > yys% Then ys = ys - vys: vys = -vys * .8

        xs% = xs: ys% = ys
        sy% = ys% - 63
        sx% = xs% - 63
        If sy% < 0 And sy% > -128 Then m% = sy% * (-128) - 1

        yw1% = -1 + sy%: yw2% = 128 + sy%
        xw1% = -1 + sx%: xw2% = 128 + sx%

        For y% = 0 To 199
            Def Seg = &HA000 + y% * 20


            If y% > yw1% And y% < yw2% Then GoTo 111

            For x% = 0 To 319
                c% = fsin2%(x%) + fsin3%(y% + l%) + fsin2%(x% + y%) + fsin2%(fsin3%(x% + l%) - fsin2%(x% - y% - k%))
                Poke x%, mod256128%(c%)
            Next x%

            GoTo 1121

            111
            For x% = 0 To 319
                If x% > xw1% And x% < xw2% Then m% = m% + 1: yn% = sp%(m%) \ 128: xn% = sp%(m%) - yn% * 128 + sx%: yn% = yn% + sy%: spp% = 128 Else xn% = x%: yn% = y%
                If xn% = x% And yn% = y% Then spp% = 0

                c% = fsin2%(xn%) + fsin3%(yn% + l%) + fsin2%(xn% + yn%) + fsin2%(fsin3%(xn% + l%) - fsin2%(xn% - yn% - k%))
                Poke x%, mod256128%(c%) + spp%
            Next x%

            1121

        Next y%

        'OUT &H3C8, 0
        'OUT &H3C9, 0
        'OUT &H3C9, 0
        'OUT &H3C9, 0

        Wait &H3DA, 8: Wait &H3DA, 8, 8
        If xit% = 0 Then keyaction
        If xit% = 1 Then GoTo gout

        'OUT &H3C8, 0
        'OUT &H3C9, 63
        'OUT &H3C9, 0
        'OUT &H3C9, 0

    Loop

    gout:



End Sub

Sub sucking

    Shared xit%

    Screen 13
    Color 15

    Locate 1, 1: Print "Still Sucking?"


    For y% = 7 To 0 Step -1
        For x% = 14 * 8 - 1 To 0 Step -1

            c% = Point(x%, y%) * (y% + 1) * Sin((x% + y%) / 45)
            Line (x% * 2.8, y% * 16 + 32)-((x% + 1) * 2.8, (y% + 1) * 16 + 32), c%, BF

        Next x%
    Next y%

End Sub

Sub translate3d

    Shared ndts%, obj%

    If obj% = 1 Then zpr% = 1
    If obj% = 2 Or obj% = 3 Then zpr% = 4
    If obj% = 4 Then zpr% = 16
    If obj% > 4 Then zpr% = 8

    For i% = 0 To ndts% - 1

        xs%(i%, 1) = xs%(i%, 0)
        ys%(i%, 1) = ys%(i%, 0)

        If z(i%) <= zpr% Then GoTo 10

        xs%(i%, 0) = (x(i%) * 256) / z(i%)
        ys%(i%, 0) = (y(i%) * 256) / z(i%)

        10

    Next i%

End Sub

Sub zoomdistort

    Shared xit%

    While InKey$ <> "": Wend

    Cls



    For i% = -640 To 518
        fsin2%(i%) = Sin(i% / 16) * 31
    Next i%

    For i% = -640 To 715
        fsin3%(i%) = Sin(i% / 63) * 75
    Next i%

    For i% = -48 To 539
        fsin1%(i%) = Sin(i% / 35) * 24
    Next i%

    For i% = -319 To 602
        fsin4%(i%) = Sin(i% / 45) * 24
    Next i%

    '$DYNAMIC
    Dim dr%(-160 To 160, -48 To 48)
    '$STATIC

    For ii% = -48 To 48
        For i% = -160 To 160
            dva = ii% / 64 + 2
            If dva <> 0 Then dr%(i%, ii%) = i% / dva Else dr%(i%, ii%) = i%
        Next i%
    Next ii%


    ' ------------ Load Quickbasic inside --------------

    a$ = "qbinside.spr"
    c$ = " "
    Open a$ For Binary As #1

    Out &H3C8, 128
    For i% = 0 To 383
        Get #1, , c$: Out &H3C9, Asc(c$)
    Next i%


    xg% = 100
    yg% = 100

    i% = 0
    For y% = 1 To yg%
        For x% = 1 To xg%
            Get #1, , c$: sp%(i%) = Asc(c$)
            i% = i% + 1
        Next x%
    Next y%
    Close #1



    setpal 0, 31, 0, 0, 0, 0, 31, 63
    setpal 32, 63, 0, 31, 63, 31, 0, 63
    setpal 64, 95, 31, 0, 63, 0, 63, 0
    setpal 96, 127, 0, 63, 0, 0, 0, 0



    For l% = 15 To 305
        Line (14, 6)-(l%, 7), 27, B
        Line (13, 5)-(l% + 1, 8), 31, B
        Line (12, 4)-(l% + 2, 9), 27, B
        Wait &H3DA, 8: Wait &H3DA, 8, 8
        If xit% = 0 Then keyaction
        If xit% = 1 Then GoTo gout2
    Next l%

    For n% = 7 To 193
        If n% > 7 And n% < 194 Then Line (15, n% - 1)-(304, n% - 1), 0, B
        Line (14, 6)-(305, n%), 27, B
        Line (13, 5)-(306, n% + 1), 31, B
        Line (12, 4)-(307, n% + 2), 27, B
        Wait &H3DA, 8: Wait &H3DA, 8, 8
        If xit% = 0 Then keyaction
        If xit% = 1 Then GoTo gout2
    Next n%


    ' ----------- Quickbasic Inside ------------


    k0% = k%
    l0% = l%
    k% = 0
    l% = 0

    kxy0% = 0

    fps% = 0
    Do
        fps% = fps% + 1
        If fps% > 1400 And kxy0% > -100 Then kxy0% = kxy0% - 100 Else If fps% <= 1000 And kxy0% < 10000 Then kxy0% = kxy0% + 100
        If kxy0% = -100 Then GoTo gout2

        k% = k% + 1: If k% = 220 Then k% = 0
        l% = l% + 1: If l% = 283 Then l% = 0

        k0% = k0% + 1: If k0% = 101 Then k0% = 0
        l0% = l0% + 1: If l0% = 396 Then l0% = 0


        xp% = Sin(k% / 35) * 48
        yp% = Sin(l% / 45) * 64


        ypp% = 160
        For y% = 8 To 191
            Def Seg = &HA000 + ypp%
            ypp% = ypp% + 20
            sx% = fsin4%(y% + l%) + fsin1%(fsin1%(y%) + fsin4%(y% + l%))

            For x% = 16 To 303

                sy% = fsin1%(x% + k%) + fsin4%(y% - x%)

                kxy% = dt100%(dr%(y% - 100, sy%) + yp%) + dt%(dr%(x% - 160, sx%) + xp%)
                If kxy% > kxy0% Then c% = 0 Else If sp%(kxy%) = 129 Then c% = mod256128%(fsin3%(x%) + fsin2%(x% + k0%) + fsin2%(y%)) Else c% = sp%(kxy%)

                Poke x%, c%

            Next x%
        Next y%

        'OUT &H3C8, 0
        'OUT &H3C9, 0
        'OUT &H3C9, 0
        'OUT &H3C9, 0

        Wait &H3DA, 8: Wait &H3DA, 8, 8
        If xit% = 0 Then keyaction
        If xit% = 1 Then GoTo gout2

        'OUT &H3C8, 0
        'OUT &H3C9, 63
        'OUT &H3C9, 0
        'OUT &H3C9, 0

    Loop

    gout2:

End Sub

