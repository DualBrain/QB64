[Home](https://qb64.com) • [News](../../news.md) • [GitHub](../../github.md) • [Wiki](../../wiki.md) • [Samples](../../samples.md) • [Media](../../media.md) • [Community](../../community.md) • [Rolodex](../../rolodex.md) • [More...](../../more.md)

## SAMPLE: BEZIER

![screenshot.png](img/screenshot.png)

### Author

[🐝 Rho Sigma](../rho-sigma.md) 

### Description

```text
'+---------------+---------------------------------------------------+
'|_######_######_|_____.--._._________.-.____________________________|
'|_##__##_##___#_|_____|___)|________(___)_o_________________________|
'|_##__##__##____|_____|--'_|--._.-.__`-.__.__.-...--.--._.-.________|
'|_######___##___|_____|__\_|__|(___)(___)_|_(___||__|__|(___)_______|
'|_##______##____|_____'___`'__`-`-'__`-'-'_`-`-`|'__'__`-`-'`-______|
'|_##_____##___#_|____________________________._.'___________________|
'|_##_____######_|__Sources_&_Documents_placed_in_the_Public_Domain._|
'+---------------+---------------------------------------------------+
'|                                                                   |
'| === ScreenBlankers-Info.html ===                                  |
'|                                                                   |
'| == Some simple screen blankers I wrote using QB64.                |
'|                                                                   |
'+-------------------------------------------------------------------+
'| Done by RhoSigma, R.Heyder, provided AS IS, use at your own risk. |
'| Find me in the QB64 Forum or mail to support@rhosigma-cw.net for  |
'| any questions or suggestions. Thanx for your interest in my work. |
'+-------------------------------------------------------------------+
Screen Blankers
This is a small collection of some simple screen blanker modules. Most of them are written by myself, others were just graphic sample programs from other QB64 Forum members, which I've altered into a blanker module. Just read the header notes in each module for more information.

To install one of it (on a Windows system), simply rename the created .exe file with the new extension .scr, confirm the possible warning about changing the file extension with Yes. After that you can simply right click on the renamed file and choose Install.

Sorry, I've no idea how to do it on MacOS or Linux, any info about it from people who using these systems would be nice.
```

### Code

#### worms.bas

```vb

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
'| === Worms.bas ===                                                 |
'|                                                                   |
'| == A lot of very hungry worms are eating your delicious Desktop   |
'| == and will only leave some dark slimy traces.                    |
'|                                                                   |
'+-------------------------------------------------------------------+
'| Done by RhoSigma, R.Heyder, provided AS IS, use at your own risk. |
'| Find me in the QB64 Forum or mail to support@rhosigma-cw.net for  |
'| any questions or suggestions. Thanx for your interest in my work. |
'+-------------------------------------------------------------------+

di& = _ScreenImage
scrX% = _Width(di&)
scrY% = _Height(di&)
Screen di&
_Delay 0.2: _ScreenMove _Middle
_Delay 0.2: _FullScreen

Const MAX_WORMS = 25
Const MAX_TAIL = 30
Const WORM_RAD = 4

Type Worm
    cx As Integer
    cy As Integer
    cc As Long
    cd As Integer
End Type
Dim Worms(MAX_WORMS - 1) As Worm
Dim ox%(MAX_WORMS - 1, MAX_TAIL - 1)
Dim oy%(MAX_WORMS - 1, MAX_TAIL - 1)
l% = MAX_TAIL

Randomize Timer
For i% = 0 To MAX_WORMS - 1
    Worms(i%).cx = scrX% \ 2
    Worms(i%).cy = scrY% \ 2
    Worms(i%).cc = HSBA32~&((RangeRand%(0, 360) And &HFFF0~&), 85, 90, 96)
    Worms(i%).cd = (RangeRand%(90, 420) \ 30) * 30
Next i%

_MouseHide
While InKey$ = "" And mx% = 0 And my% = 0
    For i% = 0 To MAX_WORMS - 1
        If l% = 0 Then Line (ox%(i%, 0) - WORM_RAD, oy%(i%, 0) - WORM_RAD)-(ox%(i%, 0) + WORM_RAD, oy%(i%, 0) + WORM_RAD), &HE0000000~&, BF
        Line (Worms(i%).cx - WORM_RAD, Worms(i%).cy - WORM_RAD)-(Worms(i%).cx + WORM_RAD, Worms(i%).cy + WORM_RAD), Worms(i%).cc, BF
        Line (Worms(i%).cx - WORM_RAD, Worms(i%).cy - WORM_RAD)-(Worms(i%).cx + WORM_RAD, Worms(i%).cy + WORM_RAD), &H60000000~&, B
        ox%(i%, MAX_TAIL - 1) = Worms(i%).cx
        oy%(i%, MAX_TAIL - 1) = Worms(i%).cy
        If RangeRand%(1, 100) And 1 Then
            od% = Worms(i%).cd
            Do
                nd% = (RangeRand%(90, 420) \ 30) * 30
            Loop While nd% < (od% - 30) Or nd% > (od% + 30)
            Worms(i%).cd = nd%
        End If
        Worms(i%).cx = Worms(i%).cx + PolToCartX%(Worms(i%).cd, WORM_RAD + (WORM_RAD \ 5))
        Worms(i%).cy = Worms(i%).cy + PolToCartY%(Worms(i%).cd, WORM_RAD + (WORM_RAD \ 5))
        If Worms(i%).cx < 0 Then Worms(i%).cx = scrX%
        If Worms(i%).cx > scrX% Then Worms(i%).cx = 0
        If Worms(i%).cy < 0 Then Worms(i%).cy = scrY%
        If Worms(i%).cy > scrY% Then Worms(i%).cy = 0
    Next i%
    If l% > 0 Then l% = l% - 1
    For i% = 0 To MAX_WORMS - 1
        For j% = 1 To MAX_TAIL - 1
            ox%(i%, j% - 1) = ox%(i%, j%)
            oy%(i%, j% - 1) = oy%(i%, j%)
        Next j%
    Next i%

    _Limit 30
    _Display
    Do While _MouseInput
        mx% = mx% + _MouseMovementX
        my% = my% + _MouseMovementY
    Loop
Wend

_FullScreen _Off
_Delay 0.2: Screen 0
_Delay 0.2: _FreeImage di&
System

'=== RS:COPYFROM:converthelper.bm/PolToCartX% (original) =============
Function PolToCartX% (ang!, rad!)
    PolToCartX% = CInt(rad! * Cos(ang! * 0.017453292519943))
End Function

'=== RS:COPYFROM:converthelper.bm/PolToCartY% (original) =============
Function PolToCartY% (ang!, rad!)
    PolToCartY% = CInt(rad! * Sin(ang! * 0.017453292519943))
End Function

'=== RS:COPYFROM:converthelper.bm/HSB32~& (--OPT_EX) =================
Function HSB32~& (hue!, sat!, bri!)
    If hue! < 0 Then hue! = 0: Else If hue! > 360 Then hue! = 360
    If sat! < 0 Then sat! = 0: Else If sat! > 100 Then sat! = 100
    If bri! < 0 Then bri! = 0: Else If bri! > 100 Then bri! = 100
    HSBtoRGB CLng(hue! * 182.041666666666666#), CLng(sat! * 655.35#), CLng(bri! * 655.35#), red~&, gre~&, blu~&
    HSB32~& = _RGB32(red~& \ 256, gre~& \ 256, blu~& \ 256)
End Function

'=== RS:COPYFROM:converthelper.bm/HSBA32~& (--OPT_EX) ================
Function HSBA32~& (hue!, sat!, bri!, alp%)
    If hue! < 0 Then hue! = 0: Else If hue! > 360 Then hue! = 360
    If sat! < 0 Then sat! = 0: Else If sat! > 100 Then sat! = 100
    If bri! < 0 Then bri! = 0: Else If bri! > 100 Then bri! = 100
    HSBtoRGB CLng(hue! * 182.041666666666666#), CLng(sat! * 655.35#), CLng(bri! * 655.35#), red~&, gre~&, blu~&
    HSBA32~& = _RGBA32(red~& \ 256, gre~& \ 256, blu~& \ 256, alp%)
End Function

'=== RS:COPYFROM:converthelper.bm/HSBtoRGB (--OPT_EX) ================
Sub HSBtoRGB (hue~&, sat~&, bri~&, red~&, gre~&, blu~&)
    If sat~& = 0 Then
        red~& = bri~&: gre~& = bri~&: blu~& = bri~&
    Else
        v~& = bri~&
        i~& = hue~& \ 10923 '(65535 \ 6) + 1
        f~& = (hue~& Mod 10923) * 6 '(65535 \ 6) + 1
        f~& = f~& + (f~& \ 16384) '(65536 \ 4)

        p~& = bri~& * (65535 - sat~&) \ 65536
        q~& = bri~& * (65535 - ((sat~& * f~&) \ 65536)) \ 65536
        t~& = bri~& * (65535 - ((sat~& * (65535 - f~&)) \ 65536)) \ 65536

        Select Case i~&
            Case 0: red~& = v~&: gre~& = t~&: blu~& = p~&
            Case 1: red~& = q~&: gre~& = v~&: blu~& = p~&
            Case 2: red~& = p~&: gre~& = v~&: blu~& = t~&
            Case 3: red~& = p~&: gre~& = q~&: blu~& = v~&
            Case 4: red~& = t~&: gre~& = p~&: blu~& = v~&
            Case 5: red~& = v~&: gre~& = p~&: blu~& = q~&
        End Select
    End If
End Sub

'=====================================================================
Function RangeRand% (low%, high%)
    RangeRand% = Int(Rnd(1) * (high% - low% + 1)) + low%
End Function

```

### File(s)

* [worms.bas](src/worms.bas)

🔗 [screenblanker](../screenblanker.md)
