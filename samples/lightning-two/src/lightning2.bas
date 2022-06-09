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
'| === Lightning2.bas ===                                            |
'|                                                                   |
'| == The filnal result of joint efforts by bplus, TylerDarko and    |
'| == myself. (http://www.qb64.net/forum/index.php?topic=14532.0)    |
'|                                                                   |
'+-------------------------------------------------------------------+
'| Done by RhoSigma, R.Heyder, provided AS IS, use at your own risk. |
'| Find me in the QB64 Forum or mail to support@rhosigma-cw.net for  |
'| any questions or suggestions. Thanx for your interest in my work. |
'+-------------------------------------------------------------------+

Dim Shared scrX%, scrY%
di& = _ScreenImage
scrX% = _Width(di&)
scrY% = _Height(di&)
_FreeImage di&
si& = _NewImage(scrX%, scrY%, 32)
Screen si&
_Delay 0.2: _ScreenMove _Middle
_Delay 0.2: _FullScreen

Const FORKINESS = 15 '1 to 20

Dim Shared scrX2%, scrX10%, scrXE%
Dim Shared scrY4%, scrY6%, scrYE%
scrX2% = scrX% \ 2: scrX10% = scrX% \ 10: scrXE% = scrX% - 1
scrY4% = scrY% \ 4: scrY6% = scrY% \ 6: scrYE% = scrY% - 1

Randomize Timer
flash& = _NewImage(scrX%, scrY%, 32)
land& = _NewImage(scrX%, scrY%, 32)
_Dest land&
DrawLandscape 6
_Dest 0

_MouseHide
While InKey$ = "" And mx% = 0 And my% = 0
    _PutImage , land&
    _Dest flash&
    Cls , _RGBA32(0, 0, 0, 0)
    Select Case RangeRand%(0, 180)
        Case 0 To 35
            DrawLightning scrXE%, RangeRand%(25, scrY6%), 50, 2.748893571, 1
        Case 36 To 71
            DrawLightning RangeRand%(scrX2% + scrX10%, scrXE%), 0, 50, 1.963495408, 1
        Case 72 To 107
            DrawLightning RangeRand%(scrX2% - scrX10%, scrX2% + scrX10%), 0, 50, 1.570796326, 1
        Case 108 To 144
            DrawLightning RangeRand%(0, scrX2% - scrX10%), 0, 50, 1.178097245, 1
        Case 145 To 180
            DrawLightning 0, RangeRand%(25, scrY6%), 50, 0.392699081, 1
    End Select
    _Dest 0
    _PutImage , flash&
    _Display
    _Delay 0.05
    pulse% = RangeRand%(0, 3)
    For fade% = 1 To 24
        Line (0, 0)-(_Width, _Height), _RGBA32(0, 0, 0, 25), BF
        If fade% > 4 And fade% < 8 And pulse% > 0 And RangeRand%(1, 100) > 50 Then
            _PutImage , land&
            _PutImage , flash&
            pulse% = pulse% - 1
            fade% = 0
        End If
        _Display
        _Limit 80
    Next fade%
    _PutImage , land&
    For fade% = 1 To 24
        Line (0, 0)-(_Width, _Height), _RGBA32(0, 0, 0, 25), BF
    Next fade%
    _Display

    _Delay RangeRand%(50, 2000) / 1000 '<< milliseconds to next lightning

    Do While _MouseInput
        mx% = mx% + _MouseMovementX
        my% = my% + _MouseMovementY
    Loop
Wend

_FullScreen _Off
_Delay 0.2: Screen 0
_Delay 0.2: _FreeImage si&
System

'======================================================================
Sub DrawLandscape (hills%)
    '--- sky ---
    For i% = 0 To scrY%
        Line (0, i%)-(scrX%, i%), _RGB32(128 * (i% / scrY%), 128 * (i% / scrY%), 128 * (i% / scrY%))
    Next i%
    '--- land ---
    startH# = scrY% - scrY4%
    rr% = 70: gg% = 70: bb% = 90
    For hill% = 1 To hills%
        Xright# = 0
        y# = startH#
        While Xright# < scrX%
            'upDown# = local up / down over range, change along Y
            'range#  = how far up / down, along X
            upDown# = ((Rnd(1) * 0.8) - 0.35) * (hill% * 0.5)
            range# = Xright# + RangeRand%(15, 25) * (2.5 / hill%)
            lastX# = Xright# - 1
            For x# = Xright# To range#
                y# = y# + upDown#
                Line (lastX#, y#)-(x#, scrY%), _RGB32(rr%, gg%, bb%), BF 'just lines weren't filling right
                lastX# = x#
            Next x#
            Xright# = range#
        Wend
        rr% = RangeRand%(rr% - 15, rr%): If rr% < 0 Then rr% = 0
        gg% = RangeRand%(gg% - 15, gg%): If gg% < 0 Then gg% = 0
        bb% = RangeRand%(bb% - 25, bb%): If bb% < 0 Then bb% = 0
        startH# = startH# + RangeRand%(5, 20)
    Next hill%
End Sub

'======================================================================
Sub DrawLightning (X&, Y&, Segments&, Dir#, Fork&)
    Sign# = 0.392699081
    xSeg# = scrX% / (15.0 * Fork&)
    ySeg# = scrY% / (15.0 * Fork&)
    Do
        Angle& = RangeRand%(0, 100)
        DeltaAngle# = Sign# * Angle& / 100.0
        Dir# = Dir# + DeltaAngle#
        Sign# = Sign# * -1.0

        nX& = X& + (Cos(Dir#) * xSeg#)
        nY& = Y& + (Sin(Dir#) * ySeg#)
    DrawLine X&, Y&, nX&, nY&, _RGBA32(RangeRand%(160, 180), _
                                       RangeRand%(117, 137), _
                                       RangeRand%(235, 255), _
                                       75 + (180 \ Fork&))
        X& = nX&
        Y& = nY&

        If ((Fork& < 3) And (RangeRand%(0, 50) < (FORKINESS \ Fork&))) Then
            DrawLightning (X&), (Y&), 5 + RangeRand%(1, 10), Dir# - (2.0 * DeltaAngle#), Fork& + 1
        End If
        Segments& = Segments& - 1
    Loop While Segments& > 0 And Y& < scrY% - RangeRand%(75, scrY4% - 50)
End Sub

'======================================================================
Sub DrawLine (x1%, y1%, x2%, y2%, col&)
    If x1% < 0 Then
        If x2% < 0 Then Exit Sub
        x1% = 0
    ElseIf x1% >= scrX% Then
        If x2% >= scrX% Then Exit Sub
        x1% = scrXE%
    End If
    If y1% < 0 Then
        If y2% < 0 Then Exit Sub
        y1% = 0
    ElseIf y1% >= scrY% Then
        If y2% >= scrY% Then Exit Sub
        y1% = scrYE%
    End If

    If x2% < 0 Then
        x2% = 0
    ElseIf x2% >= scrX% Then
        x2% = scrXE%
    End If
    If y2% < 0 Then
        y2% = 0
    ElseIf y2% >= scrY% Then
        y2% = scrYE%
    End If

    Line (x1%, y1%)-(x2%, y2%), col&
End Sub

'======================================================================
Function RangeRand% (low%, high%)
    RangeRand% = Int(Rnd(1) * (high% - low% + 1)) + low%
End Function

