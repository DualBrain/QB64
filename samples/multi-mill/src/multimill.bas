'+---------------+---------------------------------------------------+
'| ###### ###### |     .--. .         .-.                            |
'| ##  ## ##   # |     |   )|        (   ) o                         |
'| ##  ##  ##    |     |--' |--. .-.  `-.  .  .-...--.--. .-.        |
'| ######   ##   |     |  \ |  |(   )(   ) | (   ||  |  |(   )       |
'| ##      ##    |     '   `'  `-`-'  `-'-' `-`-`|'  '  `-`-'`-      |
'| ##     ##   # |                            ._.'                   |
'| ##     ###### |  Sources & Documents placed in the Public Domain. |
'+---------------+---------------------------------------------------+
'|                                                                   |
'| === MultiMill.bas ===                                             |
'|                                                                   |
'| == Draws many spinning elements with color cycling effect.        |
'|                                                                   |
'+-------------------------------------------------------------------+
'| Done by RhoSigma, R.Heyder, provided AS IS, use at your own risk. |
'| Find me in the QB64 Forum or mail to support@rhosigma-cw.net for  |
'| any questions or suggestions. Thanx for your interest in my work. |
'+-------------------------------------------------------------------+

di& = _ScreenImage
scrX% = _Width(di&)
scrY% = _Height(di&)
_FreeImage di&
si& = _NewImage(scrX%, scrY%, 256)
Screen si&
_Delay 0.2: _ScreenMove _Middle
_Delay 0.2: _FullScreen

fa% = 128
Restore ColorTab
For l% = 0 To (fa% - 1)
    Read r&, g&, b&
    _PaletteColor l%, (r& * 65536) + (g& * 256) + b&
Next l%
_PaletteColor (fa% + 2), &H000000
_PaletteColor (fa% + 3), &HFFFFFF
Color (fa% + 3), (fa% + 2)
Cls

Randomize Timer
rad! = 3.141592653589793 / 180

f% = 0
x1% = RangeRand%(0, scrX% - 1)
y1% = RangeRand%(0, scrY% - 1)
dx1% = 1
dy1% = 1
v1% = RangeRand%(2, 5)
w1% = 0
w2% = 45

bx11! = Cos(rad! * w1%)
bx12! = Cos(rad! * (w1% + 90))
bx13! = Cos(rad! * (w1% + 180))
bx14! = Cos(rad! * (w1% + 270))
by11! = Sin(rad! * w1%)
by12! = Sin(rad! * (w1% + 90))
by13! = Sin(rad! * (w1% + 180))
by14! = Sin(rad! * (w1% + 270))

bx21! = Cos(rad! * w2%)
bx22! = Cos(rad! * (w2% + 90))
bx23! = Cos(rad! * (w2% + 180))
bx24! = Cos(rad! * (w2% + 270))
by21! = Sin(rad! * w2%)
by22! = Sin(rad! * (w2% + 90))
by23! = Sin(rad! * (w2% + 180))
by24! = Sin(rad! * (w2% + 270))

ex11% = x1% + 60 * bx11!
ex12% = x1% + 60 * bx12!
ex13% = x1% + 60 * bx13!
ex14% = x1% + 60 * bx14!
ey11% = y1% + 60 * by11!
ey12% = y1% + 60 * by12!
ey13% = y1% + 60 * by13!
ey14% = y1% + 60 * by14!

_MouseHide
While InKey$ = "" And mx% = 0 And my% = 0
    Circle (x1%, y1%), 38, (fa% + 2)
    Line (x1% + 95 * bx21!, y1% + 95 * by21!)-(x1% + 120 * bx21!, y1% + 120 * by21!), (fa% + 2)
    Line (x1% + 95 * bx22!, y1% + 95 * by22!)-(x1% + 120 * bx22!, y1% + 120 * by22!), (fa% + 2)
    Line (x1% + 95 * bx23!, y1% + 95 * by23!)-(x1% + 120 * bx23!, y1% + 120 * by23!), (fa% + 2)
    Line (x1% + 95 * bx24!, y1% + 95 * by24!)-(x1% + 120 * bx24!, y1% + 120 * by24!), (fa% + 2)
    Line (x1% + 95 * bx11!, y1% + 95 * by11!)-(x1% + 120 * bx11!, y1% + 120 * by11!), (fa% + 2)
    Line (x1% + 95 * bx12!, y1% + 95 * by12!)-(x1% + 120 * bx12!, y1% + 120 * by12!), (fa% + 2)
    Line (x1% + 95 * bx13!, y1% + 95 * by13!)-(x1% + 120 * bx13!, y1% + 120 * by13!), (fa% + 2)
    Line (x1% + 95 * bx14!, y1% + 95 * by14!)-(x1% + 120 * bx14!, y1% + 120 * by14!), (fa% + 2)

    Line (ex11%, ey11%)-(ex12%, ey12%), (fa% + 2)
    Line (ex12%, ey12%)-(ex13%, ey13%), (fa% + 2)
    Line (ex13%, ey13%)-(ex14%, ey14%), (fa% + 2)
    Line (ex14%, ey14%)-(ex11%, ey11%), (fa% + 2)

    Line (ex11% + 20 * bx21!, ey11% + 20 * by21!)-(ex11% + 20 * bx23!, ey11% + 20 * by23!), (fa% + 2)
    Line (ex11% + 20 * bx22!, ey11% + 20 * by22!)-(ex11% + 20 * bx24!, ey11% + 20 * by24!), (fa% + 2)
    Circle (ex11% + 20 * bx21!, ey11% + 20 * by21!), 5, (fa% + 2)
    Circle (ex11% + 20 * bx23!, ey11% + 20 * by23!), 5, (fa% + 2)
    Circle (ex11% + 20 * bx22!, ey11% + 20 * by22!), 5, (fa% + 2)
    Circle (ex11% + 20 * bx24!, ey11% + 20 * by24!), 5, (fa% + 2)

    Line (ex12% + 20 * bx21!, ey12% + 20 * by21!)-(ex12% + 20 * bx23!, ey12% + 20 * by23!), (fa% + 2)
    Line (ex12% + 20 * bx22!, ey12% + 20 * by22!)-(ex12% + 20 * bx24!, ey12% + 20 * by24!), (fa% + 2)
    Circle (ex12% + 20 * bx21!, ey12% + 20 * by21!), 5, (fa% + 2)
    Circle (ex12% + 20 * bx23!, ey12% + 20 * by23!), 5, (fa% + 2)
    Circle (ex12% + 20 * bx22!, ey12% + 20 * by22!), 5, (fa% + 2)
    Circle (ex12% + 20 * bx24!, ey12% + 20 * by24!), 5, (fa% + 2)

    Line (ex13% + 20 * bx21!, ey13% + 20 * by21!)-(ex13% + 20 * bx23!, ey13% + 20 * by23!), (fa% + 2)
    Line (ex13% + 20 * bx22!, ey13% + 20 * by22!)-(ex13% + 20 * bx24!, ey13% + 20 * by24!), (fa% + 2)
    Circle (ex13% + 20 * bx21!, ey13% + 20 * by21!), 5, (fa% + 2)
    Circle (ex13% + 20 * bx23!, ey13% + 20 * by23!), 5, (fa% + 2)
    Circle (ex13% + 20 * bx22!, ey13% + 20 * by22!), 5, (fa% + 2)
    Circle (ex13% + 20 * bx24!, ey13% + 20 * by24!), 5, (fa% + 2)

    Line (ex14% + 20 * bx21!, ey14% + 20 * by21!)-(ex14% + 20 * bx23!, ey14% + 20 * by23!), (fa% + 2)
    Line (ex14% + 20 * bx22!, ey14% + 20 * by22!)-(ex14% + 20 * bx24!, ey14% + 20 * by24!), (fa% + 2)
    Circle (ex14% + 20 * bx21!, ey14% + 20 * by21!), 5, (fa% + 2)
    Circle (ex14% + 20 * bx23!, ey14% + 20 * by23!), 5, (fa% + 2)
    Circle (ex14% + 20 * bx22!, ey14% + 20 * by22!), 5, (fa% + 2)
    Circle (ex14% + 20 * bx24!, ey14% + 20 * by24!), 5, (fa% + 2)

    Line (x1% + 20 * bx21!, y1% + 20 * by21!)-(x1% + 20 * bx22!, y1% + 20 * by22!), (fa% + 2), B
    Line (x1% + 20 * bx22!, y1% + 20 * by22!)-(x1% + 20 * bx23!, y1% + 20 * by23!), (fa% + 2), B
    Line (x1% + 20 * bx23!, y1% + 20 * by23!)-(x1% + 20 * bx24!, y1% + 20 * by24!), (fa% + 2), B
    Line (x1% + 20 * bx24!, y1% + 20 * by24!)-(x1% + 20 * bx21!, y1% + 20 * by21!), (fa% + 2), B

    x1% = x1% + (v1% * dx1%)
    If x1% < 0 Or x1% > (scrX% - 1) Then
        x1% = x1% - (2 * (v1% * dx1%))
        dx1% = -dx1%
        v1% = RangeRand%(2, 5)
    End If
    y1% = y1% + (v1% * dy1%)
    If y1% < 0 Or y1% > (scrY% - 1) Then
        y1% = y1% - (2 * (v1% * dy1%))
        dy1% = -dy1%
        v1% = RangeRand%(2, 5)
    End If
    w1% = w1% + 5
    If w1% > 360 Then w1% = w1% - 360
    w2% = w2% - 5
    If w2% < 0 Then w2% = w2% + 360

    bx11! = Cos(rad! * w1%)
    bx12! = Cos(rad! * (w1% + 90))
    bx13! = Cos(rad! * (w1% + 180))
    bx14! = Cos(rad! * (w1% + 270))
    by11! = Sin(rad! * w1%)
    by12! = Sin(rad! * (w1% + 90))
    by13! = Sin(rad! * (w1% + 180))
    by14! = Sin(rad! * (w1% + 270))

    bx21! = Cos(rad! * w2%)
    bx22! = Cos(rad! * (w2% + 90))
    bx23! = Cos(rad! * (w2% + 180))
    bx24! = Cos(rad! * (w2% + 270))
    by21! = Sin(rad! * w2%)
    by22! = Sin(rad! * (w2% + 90))
    by23! = Sin(rad! * (w2% + 180))
    by24! = Sin(rad! * (w2% + 270))

    ex11% = x1% + 60 * bx11!
    ex12% = x1% + 60 * bx12!
    ex13% = x1% + 60 * bx13!
    ex14% = x1% + 60 * bx14!
    ey11% = y1% + 60 * by11!
    ey12% = y1% + 60 * by12!
    ey13% = y1% + 60 * by13!
    ey14% = y1% + 60 * by14!

    Circle (x1%, y1%), 38, f%
    Line (x1% + 95 * bx21!, y1% + 95 * by21!)-(x1% + 120 * bx21!, y1% + 120 * by21!), f% + 1
    Line (x1% + 95 * bx22!, y1% + 95 * by22!)-(x1% + 120 * bx22!, y1% + 120 * by22!), f% + 2
    Line (x1% + 95 * bx23!, y1% + 95 * by23!)-(x1% + 120 * bx23!, y1% + 120 * by23!), f% + 3
    Line (x1% + 95 * bx24!, y1% + 95 * by24!)-(x1% + 120 * bx24!, y1% + 120 * by24!), f% + 4
    Line (x1% + 95 * bx11!, y1% + 95 * by11!)-(x1% + 120 * bx11!, y1% + 120 * by11!), f% + 5
    Line (x1% + 95 * bx12!, y1% + 95 * by12!)-(x1% + 120 * bx12!, y1% + 120 * by12!), f% + 6
    Line (x1% + 95 * bx13!, y1% + 95 * by13!)-(x1% + 120 * bx13!, y1% + 120 * by13!), f% + 7
    Line (x1% + 95 * bx14!, y1% + 95 * by14!)-(x1% + 120 * bx14!, y1% + 120 * by14!), f% + 8

    Line (ex11%, ey11%)-(ex12%, ey12%), f% + 9
    Line (ex12%, ey12%)-(ex13%, ey13%), f% + 10
    Line (ex13%, ey13%)-(ex14%, ey14%), f% + 11
    Line (ex14%, ey14%)-(ex11%, ey11%), f% + 12

    Line (ex11% + 20 * bx21!, ey11% + 20 * by21!)-(ex11% + 20 * bx23!, ey11% + 20 * by23!), f% + 13
    Line (ex11% + 20 * bx22!, ey11% + 20 * by22!)-(ex11% + 20 * bx24!, ey11% + 20 * by24!), f% + 14
    Circle (ex11% + 20 * bx21!, ey11% + 20 * by21!), 5, f% + 15
    Circle (ex11% + 20 * bx23!, ey11% + 20 * by23!), 5, f% + 16
    Circle (ex11% + 20 * bx22!, ey11% + 20 * by22!), 5, f% + 17
    Circle (ex11% + 20 * bx24!, ey11% + 20 * by24!), 5, f% + 18

    Line (ex12% + 20 * bx21!, ey12% + 20 * by21!)-(ex12% + 20 * bx23!, ey12% + 20 * by23!), f% + 19
    Line (ex12% + 20 * bx22!, ey12% + 20 * by22!)-(ex12% + 20 * bx24!, ey12% + 20 * by24!), f% + 20
    Circle (ex12% + 20 * bx21!, ey12% + 20 * by21!), 5, f% + 21
    Circle (ex12% + 20 * bx23!, ey12% + 20 * by23!), 5, f% + 22
    Circle (ex12% + 20 * bx22!, ey12% + 20 * by22!), 5, f% + 23
    Circle (ex12% + 20 * bx24!, ey12% + 20 * by24!), 5, f% + 24

    Line (ex13% + 20 * bx21!, ey13% + 20 * by21!)-(ex13% + 20 * bx23!, ey13% + 20 * by23!), f% + 25
    Line (ex13% + 20 * bx22!, ey13% + 20 * by22!)-(ex13% + 20 * bx24!, ey13% + 20 * by24!), f% + 26
    Circle (ex13% + 20 * bx21!, ey13% + 20 * by21!), 5, f% + 27
    Circle (ex13% + 20 * bx23!, ey13% + 20 * by23!), 5, f% + 28
    Circle (ex13% + 20 * bx22!, ey13% + 20 * by22!), 5, f% + 29
    Circle (ex13% + 20 * bx24!, ey13% + 20 * by24!), 5, f% + 30

    Line (ex14% + 20 * bx21!, ey14% + 20 * by21!)-(ex14% + 20 * bx23!, ey14% + 20 * by23!), f% + 31
    Line (ex14% + 20 * bx22!, ey14% + 20 * by22!)-(ex14% + 20 * bx24!, ey14% + 20 * by24!), f% + 32
    Circle (ex14% + 20 * bx21!, ey14% + 20 * by21!), 5, f% + 33
    Circle (ex14% + 20 * bx23!, ey14% + 20 * by23!), 5, f% + 34
    Circle (ex14% + 20 * bx22!, ey14% + 20 * by22!), 5, f% + 35
    Circle (ex14% + 20 * bx24!, ey14% + 20 * by24!), 5, f% + 36

    Line (x1% + 20 * bx21!, y1% + 20 * by21!)-(x1% + 20 * bx22!, y1% + 20 * by22!), f%, B
    Line (x1% + 20 * bx22!, y1% + 20 * by22!)-(x1% + 20 * bx23!, y1% + 20 * by23!), f%, B
    Line (x1% + 20 * bx23!, y1% + 20 * by23!)-(x1% + 20 * bx24!, y1% + 20 * by24!), f%, B
    Line (x1% + 20 * bx24!, y1% + 20 * by24!)-(x1% + 20 * bx21!, y1% + 20 * by21!), f%, B

    f% = f% + 1
    If f% = fa% - 36 Then f% = 0
    _Limit 30
    _Display
    Do While _MouseInput
        mx% = mx% + _MouseMovementX
        my% = my% + _MouseMovementY
    Loop
Wend

_FullScreen _Off
_Delay 0.2: Screen 0
_Delay 0.2: _FreeImage si&
System

ColorTab:
Data &H00,&H00,&H00
Data &H08,&H00,&H10
Data &H10,&H00,&H20
Data &H18,&H00,&H30
Data &H20,&H00,&H40
Data &H28,&H00,&H50
Data &H30,&H00,&H60
Data &H38,&H00,&H70
Data &H40,&H00,&H80
Data &H48,&H00,&H90
Data &H50,&H00,&HA0
Data &H58,&H00,&HB0
Data &H60,&H00,&HC0
Data &H68,&H00,&HD0
Data &H70,&H00,&HE0
Data &H78,&H00,&HF0
Data &H80,&H00,&HFF
Data &H78,&H00,&HFF
Data &H70,&H00,&HFF
Data &H68,&H00,&HFF
Data &H60,&H00,&HFF
Data &H58,&H00,&HFF
Data &H50,&H00,&HFF
Data &H48,&H00,&HFF
Data &H40,&H00,&HFF
Data &H38,&H00,&HFF
Data &H30,&H00,&HFF
Data &H28,&H00,&HFF
Data &H20,&H00,&HFF
Data &H18,&H00,&HFF
Data &H10,&H00,&HFF
Data &H08,&H00,&HFF
Data &H00,&H00,&HFF
Data &H00,&H10,&HFF
Data &H00,&H20,&HFF
Data &H00,&H30,&HFF
Data &H00,&H40,&HFF
Data &H00,&H50,&HFF
Data &H00,&H60,&HFF
Data &H00,&H70,&HFF
Data &H00,&H80,&HFF
Data &H00,&H90,&HFF
Data &H00,&HA0,&HFF
Data &H00,&HB0,&HFF
Data &H00,&HC0,&HFF
Data &H00,&HD0,&HFF
Data &H00,&HE0,&HFF
Data &H00,&HF0,&HFF
Data &H00,&HFF,&HFF
Data &H00,&HFF,&HF0
Data &H00,&HFF,&HE0
Data &H00,&HFF,&HD0
Data &H00,&HFF,&HC0
Data &H00,&HFF,&HB0
Data &H00,&HFF,&HA0
Data &H00,&HFF,&H90
Data &H00,&HFF,&H80
Data &H00,&HFF,&H70
Data &H00,&HFF,&H60
Data &H00,&HFF,&H50
Data &H00,&HFF,&H40
Data &H00,&HFF,&H30
Data &H00,&HFF,&H20
Data &H00,&HFF,&H10
Data &H00,&HFF,&H00
Data &H10,&HFF,&H00
Data &H20,&HFF,&H00
Data &H30,&HFF,&H00
Data &H40,&HFF,&H00
Data &H50,&HFF,&H00
Data &H60,&HFF,&H00
Data &H70,&HFF,&H00
Data &H80,&HFF,&H00
Data &H90,&HFF,&H00
Data &HA0,&HFF,&H00
Data &HB0,&HFF,&H00
Data &HC0,&HFF,&H00
Data &HD0,&HFF,&H00
Data &HE0,&HFF,&H00
Data &HF0,&HFF,&H00
Data &HFF,&HFF,&H00
Data &HFF,&HF0,&H00
Data &HFF,&HE0,&H00
Data &HFF,&HD0,&H00
Data &HFF,&HC0,&H00
Data &HFF,&HB0,&H00
Data &HFF,&HA0,&H00
Data &HFF,&H90,&H00
Data &HFF,&H80,&H00
Data &HFF,&H70,&H00
Data &HFF,&H60,&H00
Data &HFF,&H50,&H00
Data &HFF,&H40,&H00
Data &HFF,&H30,&H00
Data &HFF,&H20,&H00
Data &HFF,&H10,&H00
Data &HFF,&H00,&H00
Data &HFF,&H00,&H08
Data &HFF,&H00,&H10
Data &HFF,&H00,&H18
Data &HFF,&H00,&H20
Data &HFF,&H00,&H28
Data &HFF,&H00,&H30
Data &HFF,&H00,&H38
Data &HFF,&H00,&H40
Data &HFF,&H00,&H48
Data &HFF,&H00,&H50
Data &HFF,&H00,&H58
Data &HFF,&H00,&H60
Data &HFF,&H00,&H68
Data &HFF,&H00,&H70
Data &HFF,&H00,&H78
Data &HFF,&H00,&H80
Data &HF0,&H00,&H78
Data &HE0,&H00,&H70
Data &HD0,&H00,&H68
Data &HC0,&H00,&H60
Data &HB0,&H00,&H58
Data &HA0,&H00,&H50
Data &H90,&H00,&H48
Data &H80,&H00,&H40
Data &H70,&H00,&H38
Data &H60,&H00,&H30
Data &H50,&H00,&H28
Data &H40,&H00,&H20
Data &H30,&H00,&H18
Data &H20,&H00,&H10
Data &H10,&H00,&H08

'======================================================================
Function RangeRand% (low%, high%)
    RangeRand% = Int(Rnd(1) * (high% - low% + 1)) + low%
End Function

