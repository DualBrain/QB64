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
'| === Splines.bas ===                                               |
'|                                                                   |
'| == Similar to the Mystify screen blanker, but adds Splines.       |
'|                                                                   |
'+-------------------------------------------------------------------+
'| Done by RhoSigma, R.Heyder, provided AS IS, use at your own risk. |
'| Find me in the QB64 Forum or mail to support@rhosigma-cw.net for  |
'| any questions or suggestions. Thanx for your interest in my work. |
'+-------------------------------------------------------------------+

Dim Shared scrw%, scrh%
di& = _ScreenImage
scrw% = _Width(di&)
scrh% = _Height(di&)
_FreeImage di&
si& = _NewImage(scrw%, scrh%, 256)
Screen si&
_Delay 0.2: _ScreenMove _Middle
_Delay 0.2: _FullScreen

Const MAX_LINES = 30 'at least 1 !!!
Const MAX_POINTS = 20 'at least 16 !!!
Const ANIM_INTERVAL = 15 'change anim type every n seconds

Dim Shared storex%(MAX_LINES - 1, MAX_POINTS - 1)
Dim Shared storey%(MAX_LINES - 1, MAX_POINTS - 1)
Dim Shared ptr%, eptr%
Dim Shared numLines%, mdelta%, maxLines%
mdelta% = -1: maxLines% = MAX_LINES \ 2
Dim Shared maxPoints%
Dim Shared dx%(MAX_POINTS - 1), dy%(MAX_POINTS - 1)
Dim Shared ox%(MAX_POINTS - 1), oy%(MAX_POINTS - 1)
Dim Shared nx%(MAX_POINTS - 1), ny%(MAX_POINTS - 1)
Dim Shared dr%, dg%, db%
Dim Shared nr%, ng%, nb%
Dim Shared animTimeout%
Dim Shared closed%
Dim Shared nextlegal$(9)
nextlegal$(0) = "01458": nextlegal$(1) = "236": nextlegal$(2) = "01458"
nextlegal$(3) = "236": nextlegal$(4) = "01458": nextlegal$(5) = "23"
nextlegal$(6) = "01458": nextlegal$(7) = "": nextlegal$(8) = "0145"
nextlegal$(9) = ""
Dim Shared advval%(9)
advval%(0) = 3: advval%(1) = 2: advval%(2) = 3: advval%(3) = 2: advval%(4) = 1
advval%(5) = 0: advval%(6) = 1: advval%(7) = 0: advval%(8) = 1: advval%(9) = 0
Dim Shared realfunc%(13)

Dim Shared sp&
sp& = 1000
Dim Shared stack&(sp& - 1)
Dim Shared oldx&, oldy&

Randomize Timer
animTimeout% = 0
Color 1
MakeFunc
StartLines
Colors
_MouseHide
On Timer(1) GoSub raiseTimeout
Timer On
While InKey$ = "" And mx% = 0 And my% = 0

    AdvanceLines
    DrawNew
    Colors

    If animTimeout% >= ANIM_INTERVAL Then
        Randomize Timer
        animTimeout% = 0
        MakeFunc
        Cls
        StartLines
    End If

    _Limit 60
    _Display
    Do While _MouseInput
        mx% = mx% + _MouseMovementX
        my% = my% + _MouseMovementY
    Loop
Wend
Timer Off

_FullScreen _Off
_Delay 0.2: Screen 0
_Delay 0.2: _FreeImage si&
System

raiseTimeout:
animTimeout% = animTimeout% + 1
Return

'======================================================================
Sub StartLines
    ptr% = 0
    eptr% = 0
    numLines% = 0
    If dx%(0) = 0 Then
        For i% = 0 To MAX_POINTS - 1
            ox%(i%) = RangeRand%(0, scrw% - 1)
            oy%(i%) = RangeRand%(0, scrh% - 1)
            dx%(i%) = RangeRand%(4, 7)
            dy%(i%) = RangeRand%(4, 7)
        Next i%
    End If

    nr% = 53
    ng% = 33
    nb% = 35
    dr% = -3
    dg% = 5
    db% = 7
    _PaletteColor 1, _RGB32(nr%, ng%, nb%)

    For i% = 0 To maxLines% - 1
        AdvanceLines
        DrawNew
    Next i%
End Sub

'======================================================================
Sub AdvanceLines
    For i% = 0 To maxPoints% - 1
        Adv ox%(i%), dx%(i%), nx%(i%), scrw%
        Adv oy%(i%), dy%(i%), ny%(i%), scrh%
    Next i%
End Sub

'======================================================================
Sub DrawNew
    While numLines% >= maxLines%
        Color 0
        bptr% = eptr%
        DrawFunc bptr%
        Color 1
        numLines% = numLines% - 1
        bptr% = bptr% + 1
        If bptr% = MAX_LINES Then bptr% = 0
        eptr% = bptr%
    Wend

    bptr% = ptr%
    For i% = 0 To maxPoints% - 1
        ox%(i%) = nx%(i%)
        storex%(bptr%, i%) = ox%(i%)
        oy%(i%) = ny%(i%)
        storey%(bptr%, i%) = oy%(i%)
    Next i%

    DrawFunc bptr%
    numLines% = numLines% + 1
    bptr% = bptr% + 1
    If bptr% = MAX_LINES Then
        bptr% = 0
        If mdelta% = 1 Then
            maxLines% = maxLines% + 1
            If maxLines% >= MAX_LINES - 1 Then mdelta% = -1
        Else
            maxLines% = maxLines% - 1
            If maxLines% <= 2 Then mdelta% = 1
        End If
    End If
    ptr% = bptr%
End Sub

'======================================================================
Sub MakeFunc
    closed% = RangeRand%(0, 3)
    Select Case closed%
        Case 3: closed% = 2: goallen% = RangeRand%(3, 6)
        Case 2: goallen% = RangeRand%(3, 6)
        Case 1: goallen% = RangeRand%(4, 10)
        Case 0: goallen% = RangeRand%(2, 9)
    End Select

    Do
        If closed% = 0 Then nextpossib$ = "0145": Else nextpossib$ = "0123456"

        sofar% = 0: p% = 0
        While sofar% < goallen%
            i% = Asc(Mid$(nextpossib$, RangeRand%(1, Len(nextpossib$)), 1)) - 48
            realfunc%(p%) = i%
            p% = p% + 1
            nextpossib$ = nextlegal$(i%)
            sofar% = sofar% + advval%(i%)
        Wend

        If sofar% = goallen% Then
            If closed% = 0 Then
                If Left$(nextpossib$, 1) = "0" Then Exit Do
            Else
                If (Left$(nextpossib$, 1) = "0") Or (realfunc%(0) < 4) Or (realfunc%(p% - 1) < 4) Then
                    If ((Left$(nextpossib$, 1) = "0") And ((realfunc%(0) And 2) <> 0)) Or ((Left$(nextpossib$, 1) <> "0") And ((realfunc%(0) And 2) = 0)) Then
                        If realfunc%(0) <> 5 Then
                            realfunc%(0) = realfunc%(0) ^ 2
                            Exit Do
                        End If
                    Else
                        Exit Do
                    End If
                End If
            End If
        End If
    Loop

    realfunc%(p%) = 100
    maxPoints% = goallen%
    Select Case closed%
        Case 2
            For i% = 0 To p% - 1
                realfunc%(p% + i%) = realfunc%(i%)
            Next i%
            realfunc%(p% + i%) = 100
        Case 0
            maxPoints% = maxPoints% + 1
    End Select
End Sub

'======================================================================
Sub DrawFunc (bptr%)
    Select Case closed%
        Case 2
            For i% = 0 To maxPoints% - 1
                storex%(bptr%, maxPoints% + i%) = scrw% - 1 - storex%(bptr%, i%)
                storey%(bptr%, maxPoints% + i%) = scrh% - 1 - storey%(bptr%, i%)
            Next i%
            GoSub setup
        Case 1
            i% = 0
            GoSub setup
    End Select

    p% = 0: i% = 0
    While realfunc%(p%) < 10
        Select Case realfunc%(p%)
            Case 0: DrawSF bptr%, i%
            Case 1: DrawS_F bptr%, i%
            Case 2: Draw_SF bptr%, i%
            Case 3: Draw_S_F bptr%, i%
            Case 4: DrawLF bptr%, i%
            Case 5: DrawL_F bptr%, i%
            Case 6: Draw_LF bptr%, i%
        End Select
        i% = i% + advval%(realfunc%(p%))
        p% = p% + 1
    Wend
    If p% = 0 Then animTimeout% = ANIM_INTERVAL 'skip null random loop
    Exit Sub
    setup:
    storex%(bptr%, maxPoints% + i%) = storex%(bptr%, 0)
    storey%(bptr%, maxPoints% + i%) = storey%(bptr%, 0)
    storex%(bptr%, maxPoints% + i% + 1) = storex%(bptr%, 1)
    storey%(bptr%, maxPoints% + i% + 1) = storey%(bptr%, 1)
    Return
End Sub

'======================================================================
Sub DrawSF (l%, p%)
    oldx& = storex%(l%, p% + 0)
    oldy& = storey%(l%, p% + 0)
DrawSpline storex%(l%, p%+0) * 128, storey%(l%, p%+0) * 128,_
           storex%(l%, p%+1) * 128, storey%(l%, p%+1) * 128,_
           storex%(l%, p%+2) * 128, storey%(l%, p%+2) * 128,_
           storex%(l%, p%+3) * 128, storey%(l%, p%+3) * 128
End Sub

'======================================================================
Sub DrawS_F (l%, p%)
    oldx& = storex%(l%, p% + 0)
    oldy& = storey%(l%, p% + 0)
DrawSpline storex%(l%, p%+0) * 128, storey%(l%, p%+0) * 128,_
           storex%(l%, p%+1) * 128, storey%(l%, p%+1) * 128,_
           storex%(l%, p%+2) * 128, storey%(l%, p%+2) * 128,_
           ((storex%(l%, p%+2) + storex%(l%, p%+3)) \ 2) * 128,_
           ((storey%(l%, p%+2) + storey%(l%, p%+3)) \ 2) * 128
End Sub

'======================================================================
Sub Draw_SF (l%, p%)
    oldx& = (storex%(l%, p% + 0) + storex%(l%, p% + 1)) \ 2
    oldy& = (storey%(l%, p% + 0) + storey%(l%, p% + 1)) \ 2
DrawSpline oldx& * 128, oldy& * 128,_
           storex%(l%, p%+1) * 128, storey%(l%, p%+1) * 128,_
           storex%(l%, p%+2) * 128, storey%(l%, p%+2) * 128,_
           storex%(l%, p%+3) * 128, storey%(l%, p%+3) * 128
End Sub

'======================================================================
Sub Draw_S_F (l%, p%)
    oldx& = (storex%(l%, p% + 0) + storex%(l%, p% + 1)) \ 2
    oldy& = (storey%(l%, p% + 0) + storey%(l%, p% + 1)) \ 2
DrawSpline oldx& * 128, oldy& * 128,_
           storex%(l%, p%+1) * 128, storey%(l%, p%+1) * 128,_
           storex%(l%, p%+2) * 128, storey%(l%, p%+2) * 128,_
           ((storex%(l%, p%+2) + storex%(l%, p%+3)) \ 2) * 128,_
           ((storey%(l%, p%+2) + storey%(l%, p%+3)) \ 2) * 128
End Sub

'======================================================================
Sub DrawLF (l%, p%)
    PSet (storex%(l%, p% + 0), storey%(l%, p% + 0))
    Line -(storex%(l%, p% + 1), storey%(l%, p% + 1))
End Sub

'======================================================================
Sub DrawL_F (l%, p%)
    PSet (storex%(l%, p% + 0), storey%(l%, p% + 0))
LINE -((storex%(l%, p%+0) + storex%(l%, p%+1)) \ 2,_
       (storey%(l%, p%+0) + storey%(l%, p%+1)) \ 2)
End Sub

'======================================================================
Sub Draw_LF (l%, p%)
PSET ((storex%(l%, p%+0) + storex%(l%, p%+1)) \ 2,_
      (storey%(l%, p%+0) + storey%(l%, p%+1)) \ 2)
    Line -(storex%(l%, p% + 1), storey%(l%, p% + 1))
End Sub

'======================================================================
Sub Colors
    ar% = nr%
    ag% = ng%
    ab% = nb%
    Adv ar%, dr%, nr%, 240
    Adv ag%, dg%, ng%, 240
    Adv ab%, db%, nb%, 240
    _PaletteColor 1, _RGB32(nr%, ng%, nb%)
End Sub

'======================================================================
Sub Adv (a%, d%, n%, w%)
    n% = a% + d%
    If n% < 0 Then
        n% = 0
        d% = RangeRand%(1, 6)
    ElseIf n% >= w% Then
        n% = w% - 1
        d% = RangeRand%(-6, -1)
    End If
End Sub

'======================================================================
Sub DrawSpline (x1&, y1&, x2&, y2&, x3&, y3&, x4&, y4&)

    PSet (oldx&, oldy&) 'move to start point
    GoSub rspline
    Exit Sub

    'line by line convert from Motorola 68k assembler
    'a0-a7 -> 32 bits long address registers (a7 = sp)
    'd0-d7 -> 32 bits long data registers
    'Inputs:
    'a0 AS LONG x1, a1 AS LONG y1
    'a2 AS LONG x2, a3 AS LONG y2
    'a5 AS LONG x3, a6 AS LONG y3
    'd6 AS LONG x4, d7 AS LONG y4
    rspline:
    d0& = x1& '                                              move.l  a0,d0
    d0& = d0& - x4& '                                        sub.l   d6,d0
    d3& = d0& '                                              move.l  d0,d3
    If d0& >= 0 GoTo save1 '                                 bpl.s   save1
    d0& = -d0& '                                             neg.l   d0
    save1:
    d1& = y1& '                                              move.l  a1,d1
    d1& = d1& - y4& '                                        sub.l   d7,d1
    d4& = d1& '                                              move.l  d1,d4
    If d1& >= 0 GoTo save2 '                                 bpl.s   save2
    d1& = -d1& '                                             neg.l   d1
    save2:
    d2& = d0& '                                              move.l  d0,d2
    tmp& = d1& - d0& '                                       cmp.l   d0,d1
    If tmp& < 0 GoTo save3 '                                 bmi.s   save3
    d2& = (d2& \ 8) And &H1FFFFFFF~& '                       lsr.l   #3,d2
    GoTo save9 '                                             bra.s   save9
    save3:
    d1& = (d1& \ 8) And &H1FFFFFFF~& '                       lsr.l   #3,d1
    save9:
    d2& = d2& + d1& '                                        add.l   d1,d2
    d2& = d2& \ 8 '                                          asr.l   #3,d2
    If d2& = 0 GoTo check2 '                                 beq.s   check2
    d3& = d3& \ 32 '                                         asr.l   #5,d3
    d4& = d4& \ 32 '                                         asr.l   #5,d4
    d0& = x2& '                                              move.l  a2,d0
    d0& = d0& - x1& '                                        sub.l   a0,d0
    d1& = y2& '                                              move.l  a3,d1
    d1& = d1& - y1& '                                        sub.l   a1,d1
    d0& = d0& \ 32 '                                         asr.l   #5,d0
    d1& = d1& \ 32 '                                         asr.l   #5,d1
    d0& = (d0& And &HFFFF~&) * (d4& And &HFFFF~&) '          muls.w  d4,d0
    d1& = (d1& And &HFFFF~&) * (d3& And &HFFFF~&) '          muls.w  d3,d1
    d0& = d0& - d1& '                                        sub.l   d1,d0
    If d0& >= 0 GoTo save4 '                                 bpl.s   save4
    d0& = -d0& '                                             neg.l   d0
    save4:
    tmp& = d2& - d0& '                                       cmp.l   d0,d2
    If tmp& <= 0 GoTo pushem '                               ble.s   pushem
    d0& = x3& '                                              move.l  a5,d0
    d0& = d0& - x1& '                                        sub.l   a0,d0
    d1& = y3& '                                              move.l  a6,d1
    d1& = d1& - y1& '                                        sub.l   a1,d1
    d0& = d0& \ 32 '                                         asr.l   #5,d0
    d1& = d1& \ 32 '                                         asr.l   #5,d1
    d0& = (d0& And &HFFFF~&) * (d4& And &HFFFF~&) '          muls.w  d4,d0
    d1& = (d1& And &HFFFF~&) * (d3& And &HFFFF~&) '          muls.w  d3,d1
    d0& = d0& - d1& '                                        sub.l   d1,d0
    If d0& >= 0 GoTo save5 '                                 bpl.s   save5
    d0& = -d0& '                                             neg.l   d0
    save5:
    tmp& = d2& - d0& '                                       cmp.l   d0,d2
    If tmp& <= 0 GoTo pushem '                               ble.s   pushem
    makeline:
    y4& = (y4& \ 128) And &H01FFFFFF~& '                     lsr.l   #7,d7
    d1& = y4& '                                              move.l  d7,d1
    x4& = (x4& \ 128) And &H01FFFFFF~& '                     lsr.l   #7,d6
    d0& = x4& '                                              move.l  d6,d0
    oldx& = d0& '                                            move.l  d0,_oldx
    oldy& = d1& '                                            move.l  d1,_oldy
    Line -(d0&, d1&) '                                       jsr     _LVODraw
    Return '                                                 rts

    check2:
    d0& = x1& '                                              move.l  a0,d0
    d0& = d0& - x2& '                                        sub.l   a2,d0
    If d0& >= 0 GoTo ch1 '                                   bpl.s   ch1
    d0& = -d0& '                                             neg.l   d0
    ch1:
    d1& = y1& '                                              move.l  a1,d1
    d1& = d1& - y2& '                                        sub.l   a3,d1
    If d1& >= 0 GoTo ch2 '                                   bpl.s   ch2
    d1& = -d1& '                                             neg.l   d1
    ch2:
    d1& = d1& + d0& '                                        add.l   d0,d1
    d1& = d1& \ 8 '                                          asr.l   #3,d1
    If d1& <> 0 GoTo pushem '                                bne.s   pushem
    d0& = x1& '                                              move.l  a0,d0
    d0& = d0& - x3& '                                        sub.l   a5,d0
    If d0& >= 0 GoTo ch3 '                                   bpl.s   ch3
    d0& = -d0& '                                             neg.l   d0
    ch3:
    d1& = y1& '                                              move.l  a1,d1
    d1& = d1& - y3& '                                        sub.l   a6,d1
    If d1& >= 0 GoTo ch4 '                                   bpl.s   ch4
    d1& = -d1& '                                             neg.l   d1
    ch4:
    d1& = d1& + d0& '                                        add.l   d0,d1
    d1& = d1& \ 8 '                                          asr.l   #3,d1
    If d1& = 0 GoTo makeline '                               beq.s   makeline
    pushem:
    sp& = sp& - 2: stack&(sp&) = x4&: stack&(sp& + 1) = y4& 'movem.l d6/d7,-(sp)
    d0& = x3& '                                              move.l  a5,d0
    d0& = d0& + x4& '                                        add.l   d6,d0
    d0& = d0& \ 2 '                                          asr.l   #1,d0
    d1& = y3& '                                              move.l  a6,d1
    d1& = d1& + y4& '                                        add.l   d7,d1
    d1& = d1& \ 2 '                                          asr.l   #1,d1
    sp& = sp& - 2: stack&(sp&) = d0&: stack&(sp& + 1) = d1& 'movem.l d0/d1,-(sp)
    d2& = x2& '                                              move.l  a2,d2
    d2& = d2& + x3& '                                        add.l   a5,d2
    d2& = d2& \ 2 '                                          asr.l   #1,d2
    d3& = y2& '                                              move.l  a3,d3
    d3& = d3& + y3& '                                        add.l   a6,d3
    d3& = d3& \ 2 '                                          asr.l   #1,d3
    d4& = d0& '                                              move.l  d0,d4
    d4& = d4& + d2& '                                        add.l   d2,d4
    d4& = d4& \ 2 '                                          asr.l   #1,d4
    d5& = d1& '                                              move.l  d1,d5
    d5& = d5& + d3& '                                        add.l   d3,d5
    d5& = d5& \ 2 '                                          asr.l   #1,d5
    sp& = sp& - 2: stack&(sp&) = d4&: stack&(sp& + 1) = d5& 'movem.l d4/d5,-(sp)
    x4& = x1& '                                              move.l  a0,d6
    x4& = x4& + x2& '                                        add.l   a2,d6
    x4& = x4& \ 2 '                                          asr.l   #1,d6
    y4& = y1& '                                              move.l  a1,d7
    y4& = y4& + y2& '                                        add.l   a3,d7
    y4& = y4& \ 2 '                                          asr.l   #1,d7
    d0& = d2& '                                              move.l  d2,d0
    d0& = d0& + x4& '                                        add.l   d6,d0
    d0& = d0& \ 2 '                                          asr.l   #1,d0
    d1& = d3& '                                              move.l  d3,d1
    d1& = d1& + y4& '                                        add.l   d7,d1
    d1& = d1& \ 2 '                                          asr.l   #1,d1
    x2& = x4& '                                              move.l  d6,a2
    y2& = y4& '                                              move.l  d7,a3
    x4& = d0& '                                              move.l  d0,d6
    x4& = x4& + d4& '                                        add.l   d4,d6
    x4& = x4& \ 2 '                                          asr.l   #1,d6
    y4& = d1& '                                              move.l  d1,d7
    y4& = y4& + d5& '                                        add.l   d5,d7
    y4& = y4& \ 2 '                                          asr.l   #1,d7
    sp& = sp& - 2: stack&(sp&) = x4&: stack&(sp& + 1) = y4& 'movem.l d6/d7,-(sp)
    x3& = d0& '                                              move.l  d0,a5
    y3& = d1& '                                              move.l  d1,a6
    GoSub rspline '                                          bsr rspline
    x1& = stack&(sp&): y1& = stack&(sp& + 1): sp& = sp& + 2 'movem.l (sp)+,a0/a1
    x2& = stack&(sp&): y2& = stack&(sp& + 1): sp& = sp& + 2 'movem.l (sp)+,a2/a3
    x3& = stack&(sp&): y3& = stack&(sp& + 1): sp& = sp& + 2 'movem.l (sp)+,a5/a6
    x4& = stack&(sp&): y4& = stack&(sp& + 1): sp& = sp& + 2 'movem.l (sp)+,d6/d7
    GoTo rspline '                                           bra rspline

End Sub

'======================================================================
Function RangeRand% (low%, high%)
    RangeRand% = Int(Rnd(1) * (high% - low% + 1)) + low%
End Function

