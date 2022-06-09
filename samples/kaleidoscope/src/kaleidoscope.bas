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
'| === Kaleidoscope.bas ===                                          |
'|                                                                   |
'| == Draws Kaleidoscope tubes with color cycling effect.            |
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
Dim r&(fa%), g&(fa%), b&(fa%)
Restore ColorTab
For l% = 0 To (fa% - 1)
    Read r&(l%), g&(l%), b&(l%)
Next l%
_PaletteColor (fa% + 2), &H000000
_PaletteColor (fa% + 3), &HFFFFFF
Color (fa% + 3), (fa% + 2)
Cls

Dim ox%(3), oy%(3)
x% = 0
y% = 0
dx% = 6
dy% = 6
d% = 1
f% = 0

_MouseHide
While InKey$ = "" And mx% = 0 And my% = 0
    _PaletteColor 0, (r&(0) * 65536) + (g&(0) * 256) + b&(0)
    Swap r&(0), r&(fa%)
    Swap g&(0), g&(fa%)
    Swap b&(0), b&(fa%)
    For l% = 1 To fa%
        If l% < fa% Then _PaletteColor l%, (r&(l%) * 65536) + (g&(l%) * 256) + b&(l%)
        Swap r&(l%), r&(l% - 1)
        Swap g&(l%), g&(l% - 1)
        Swap b&(l%), b&(l% - 1)
    Next l%

    Line (x% - d%, y% - d%)-(x% + d%, y% + d%), f%, B
    Line (ox%(0), oy%(0))-(x% - d%, y% - d%), (fa% + 3)
    Line (ox%(1), oy%(1))-(x% + d%, y% - d%), (fa% + 3)
    Line (ox%(2), oy%(2))-(x% + d%, y% + d%), (fa% + 3)
    Line (ox%(3), oy%(3))-(x% - d%, y% + d%), (fa% + 3)
    ox%(0) = x% - d%: oy%(0) = y% - d%
    ox%(1) = x% + d%: oy%(1) = y% - d%
    ox%(2) = x% + d%: oy%(2) = y% + d%
    ox%(3) = x% - d%: oy%(3) = y% + d%
    xAgain:
    x% = x% + dx%
    If x% < 0 Or x% > (scrX% - 1) Then
        dx% = -dx%
        GoTo xAgain
    End If
    yAgain:
    y% = y% + dy%
    If y% < 0 Or y% > (scrY% - 1) Then
        dy% = -dy%
        GoTo yAgain
    End If
    d% = d% + 1
    dAgain:
    If x% - d% < 0 Or x% + d% > (scrX% - 1) Or y% - d% < 0 Or y% + d% > (scrY% - 1) Then
        d% = d% - 1
        GoTo dAgain
    End If
    f% = f% + 1
    If f% = fa% Then f% = 0

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

