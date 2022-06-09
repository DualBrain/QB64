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
'| === Mystify.bas ===                                               |
'|                                                                   |
'| == The QB64 remake of the widely known Mystify screen blanker.    |
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

nc% = 128
Restore ColorTab
For k% = 0 To (nc% - 1)
    Read r%, g%, b%
    _PaletteColor k%, (r% * 65536) + (g% * 256) + b%
Next k%

Dim Shared x11(4), y11(4), x21(4), y21(4), x31(4), y31(4), x41(4), y41(4)
Dim Shared x12(4), y12(4), x22(4), y22(4), x32(4), y32(4), x42(4), y42(4)
Dim Shared xSpeed1%(3), xSpeed2%(3), ySpeed1%(3), ySpeed2%(3)

For x% = 0 To 3
    xSpeed1%(x%) = 5
    xSpeed2%(x%) = 5
    ySpeed1%(x%) = 5
    ySpeed2%(x%) = 5
Next x%

Randomize Timer
f1% = RangeRand%(32, 96)
f2% = RangeRand%(32, 96)
x11(4) = RangeRand%(0, scrX% - 1)
x21(4) = RangeRand%(0, scrX% - 1)
x31(4) = RangeRand%(0, scrX% - 1)
x41(4) = RangeRand%(0, scrX% - 1)

x12(4) = RangeRand%(0, scrX% - 1)
x22(4) = RangeRand%(0, scrX% - 1)
x32(4) = RangeRand%(0, scrX% - 1)
x42(4) = RangeRand%(0, scrX% - 1)

y11(4) = RangeRand%(0, scrY% - 1)
y21(4) = RangeRand%(0, scrY% - 1)
y31(4) = RangeRand%(0, scrY% - 1)
y41(4) = RangeRand%(0, scrY% - 1)

y12(4) = RangeRand%(0, scrY% - 1)
y22(4) = RangeRand%(0, scrY% - 1)
y32(4) = RangeRand%(0, scrY% - 1)
y42(4) = RangeRand%(0, scrY% - 1)

_MouseHide
While InKey$ = "" And mx% = 0 And my% = 0
    For x% = 0 To 3
        x11(x%) = x11(x% + 1)
        x21(x%) = x21(x% + 1)
        x31(x%) = x31(x% + 1)
        x41(x%) = x41(x% + 1)

        x12(x%) = x12(x% + 1)
        x22(x%) = x22(x% + 1)
        x32(x%) = x32(x% + 1)
        x42(x%) = x42(x% + 1)

        y11(x%) = y11(x% + 1)
        y21(x%) = y21(x% + 1)
        y31(x%) = y31(x% + 1)
        y41(x%) = y41(x% + 1)

        y12(x%) = y12(x% + 1)
        y22(x%) = y22(x% + 1)
        y32(x%) = y32(x% + 1)
        y42(x%) = y42(x% + 1)
    Next x%

    x11(4) = x11(4) + xSpeed1%(0)
    x21(4) = x21(4) + xSpeed1%(1)
    x31(4) = x31(4) + xSpeed1%(2)
    x41(4) = x41(4) + xSpeed1%(3)

    x12(4) = x12(4) + xSpeed2%(0)
    x22(4) = x22(4) + xSpeed2%(1)
    x32(4) = x32(4) + xSpeed2%(2)
    x42(4) = x42(4) + xSpeed2%(3)

    y11(4) = y11(4) + ySpeed1%(0)
    y21(4) = y21(4) + ySpeed1%(1)
    y31(4) = y31(4) + ySpeed1%(2)
    y41(4) = y41(4) + ySpeed1%(3)

    y12(4) = y12(4) + ySpeed2%(0)
    y22(4) = y22(4) + ySpeed2%(1)
    y32(4) = y32(4) + ySpeed2%(2)
    y42(4) = y42(4) + ySpeed2%(3)

    If x11(4) > (scrX% - 1) Or x11(4) < 0 Then
        f1% = RangeRand%(32, 96)
        xSpeed1%(0) = RangeRand%(5, 7) * Sgn(xSpeed1%(0))
        xSpeed1%(0) = -xSpeed1%(0)
        x11(4) = x11(4) + xSpeed1%(0)
    End If
    If x21(4) > (scrX% - 1) Or x21(4) < 0 Then
        xSpeed1%(1) = RangeRand%(5, 7) * Sgn(xSpeed1%(1))
        xSpeed1%(1) = -xSpeed1%(1)
        x21(4) = x21(4) + xSpeed1%(1)
    End If
    If x31(4) > (scrX% - 1) Or x31(4) < 0 Then
        xSpeed1%(2) = RangeRand%(5, 7) * Sgn(xSpeed1%(2))
        xSpeed1%(2) = -xSpeed1%(2)
        x31(4) = x31(4) + xSpeed1%(2)
    End If
    If x41(4) > (scrX% - 1) Or x41(4) < 0 Then
        xSpeed1%(3) = RangeRand%(5, 7) * Sgn(xSpeed1%(3))
        xSpeed1%(3) = -xSpeed1%(3)
        x41(4) = x41(4) + xSpeed1%(3)
    End If

    If x12(4) > (scrX% - 1) Or x12(4) < 0 Then
        f2% = RangeRand%(32, 96)
        xSpeed2%(0) = RangeRand%(5, 7) * Sgn(xSpeed2%(0))
        xSpeed2%(0) = -xSpeed2%(0)
        x12(4) = x12(4) + xSpeed2%(0)
    End If
    If x22(4) > (scrX% - 1) Or x22(4) < 0 Then
        xSpeed2%(1) = RangeRand%(5, 7) * Sgn(xSpeed2%(1))
        xSpeed2%(1) = -xSpeed2%(1)
        x22(4) = x22(4) + xSpeed2%(1)
    End If
    If x32(4) > (scrX% - 1) Or x32(4) < 0 Then
        xSpeed2%(2) = RangeRand%(5, 7) * Sgn(xSpeed2%(2))
        xSpeed2%(2) = -xSpeed2%(2)
        x32(4) = x32(4) + xSpeed2%(2)
    End If
    If x42(4) > (scrX% - 1) Or x42(4) < 0 Then
        xSpeed2%(3) = RangeRand%(5, 7) * Sgn(xSpeed2%(3))
        xSpeed2%(3) = -xSpeed2%(3)
        x42(4) = x42(4) + xSpeed2%(3)
    End If

    If y11(4) > (scrY% - 1) Or y11(4) < 0 Then
        f1% = RangeRand%(32, 96)
        ySpeed1%(0) = RangeRand%(5, 7) * Sgn(ySpeed1%(0))
        ySpeed1%(0) = -ySpeed1%(0)
        y11(4) = y11(4) + ySpeed1%(0)
    End If
    If y21(4) > (scrY% - 1) Or y21(4) < 0 Then
        ySpeed1%(1) = RangeRand%(5, 7) * Sgn(ySpeed1%(1))
        ySpeed1%(1) = -ySpeed1%(1)
        y21(4) = y21(4) + ySpeed1%(1)
    End If
    If y31(4) > (scrY% - 1) Or y31(4) < 0 Then
        ySpeed1%(2) = RangeRand%(5, 7) * Sgn(ySpeed1%(2))
        ySpeed1%(2) = -ySpeed1%(2)
        y31(4) = y31(4) + ySpeed1%(2)
    End If
    If y41(4) > (scrY% - 1) Or y41(4) < 0 Then
        ySpeed1%(3) = RangeRand%(5, 7) * Sgn(ySpeed1%(3))
        ySpeed1%(3) = -ySpeed1%(3)
        y41(4) = y41(4) + ySpeed1%(3)
    End If

    If y12(4) > (scrY% - 1) Or y12(4) < 0 Then
        f2% = RangeRand%(32, 96)
        ySpeed2%(0) = RangeRand%(5, 7) * Sgn(ySpeed2%(0))
        ySpeed2%(0) = -ySpeed2%(0)
        y12(4) = y12(4) + ySpeed2%(0)
    End If
    If y22(4) > (scrY% - 1) Or y22(4) < 0 Then
        ySpeed2%(1) = RangeRand%(5, 7) * Sgn(ySpeed2%(1))
        ySpeed2%(1) = -ySpeed2%(1)
        y22(4) = y22(4) + ySpeed2%(1)
    End If
    If y32(4) > (scrY% - 1) Or y32(4) < 0 Then
        ySpeed2%(2) = RangeRand%(5, 7) * Sgn(ySpeed2%(2))
        ySpeed2%(2) = -ySpeed2%(2)
        y32(4) = y32(4) + ySpeed2%(2)
    End If
    If y42(4) > (scrY% - 1) Or y42(4) < 0 Then
        ySpeed2%(3) = RangeRand%(5, 7) * Sgn(ySpeed2%(3))
        ySpeed2%(3) = -ySpeed2%(3)
        y42(4) = y42(4) + ySpeed2%(3)
    End If

    Line (x11(4), y11(4))-(x21(4), y21(4)), f1%
    Line (x21(4), y21(4))-(x31(4), y31(4)), f1%
    Line (x31(4), y31(4))-(x41(4), y41(4)), f1%
    Line (x41(4), y41(4))-(x11(4), y11(4)), f1%
    Line (x12(4), y12(4))-(x22(4), y22(4)), f2%
    Line (x22(4), y22(4))-(x32(4), y32(4)), f2%
    Line (x32(4), y32(4))-(x42(4), y42(4)), f2%
    Line (x42(4), y42(4))-(x12(4), y12(4)), f2%

    Line (x11(0), y11(0))-(x21(0), y21(0)), 0
    Line (x21(0), y21(0))-(x31(0), y31(0)), 0
    Line (x31(0), y31(0))-(x41(0), y41(0)), 0
    Line (x41(0), y41(0))-(x11(0), y11(0)), 0
    Line (x12(0), y12(0))-(x22(0), y22(0)), 0
    Line (x22(0), y22(0))-(x32(0), y32(0)), 0
    Line (x32(0), y32(0))-(x42(0), y42(0)), 0
    Line (x42(0), y42(0))-(x12(0), y12(0)), 0

    _Limit 60
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

