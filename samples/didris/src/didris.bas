'                        This is the unbelievable
'        ‹‹‹   ‹‹         ‹‹‹            ‹‹
'       €   € ﬂ‹‹ﬂ       €   €          ﬂ‹‹ﬂ                         ‹  ‹
'       €   €  ‹‹        €   €  ‹‹‹ ‹‹   ‹‹    ‹‹‹‹                ‹ﬂ ‹ﬂ  ‹
'  ‹ﬂﬂﬂﬂ    € €  €  ‹ﬂﬂﬂﬂ    € €   ﬂ  € €  € ‹ﬂ    ﬂ‹          ‹‹ ‹‹    ‹ﬂ
' €         € €  € €         € €   ‹ﬂﬂ  €  € ﬂ‹  ﬂ‹‹ﬂ         €‹ €‹ €
' €         € €  € €         € €  €     €  € ‹ﬂﬂ‹  ﬂ‹  ‹ﬂﬂﬂﬂﬂﬂ    ﬂﬂ
' ﬂ‹        € €  € ﬂ‹        € €  €     €  € ﬂ‹    ‹ﬂ  €              ‹ﬂﬂ‹
'   ﬂﬂﬂﬂﬂﬂﬂﬂ   ﬂﬂ    ﬂﬂﬂﬂﬂﬂﬂﬂ   ﬂﬂ       ﬂﬂ    ﬂﬂﬂﬂ     ﬂﬂﬂﬂﬂ€      ‹   ‹ﬂ
'                                      ver 2.2               ﬂ‹‹‹‹‹ﬂ  ‹  €
'                                  by Dietmar Moritz         €         ﬂﬂ
'                                                            ﬂ‹‹‹‹‹‹
'
' I started this program in summer '97 and finished November '98.
'
' I've done this with Quick Basic 4.5, but you can also run it under QBasic!
' I still have some good ideas for this game, but I wanted to write a game
' which I can compile in only one EXE-File, so I shortened the source code.
' Maybe I will write a new, much more bigger DIDRIS for Quick Basic 4.5 only!
' ---------------------------------------------------------------------------
' Please do NOT run this program under Windows!!!
' It's not as fast as in good old DOS!!!
' I also recommend Quick Basic 4.5!!!
' ---------------------------------------------------------------------------
' Please read the READ ME!!!
' ---------------------------------------------------------------------------
' If you want to e-mail me: didi@forfree.at
'                       or: didi_op@hotmail.com
' ---------------------------------------------------------------------------
' Have fun!!! :-)

' a740g: QB64 changes
'   - Replaced Play(x) on/off with Timer(2) on/off (seems to work mostly). There are some sideeffects. :(
'   - Added delays wherever animations are too fast
'   - Using QB64 defined _pi

$Resize:Smooth
_FullScreen _SquarePixels , _Smooth

Dim Shared bst(1 To 41, 1 To 10, 1 To 10)
Dim Shared buch(1 To 5, 1 To 19, 1 To 19) As Integer

Dim Shared bomb As Integer
Dim Shared nextbomb As Integer

Dim Shared hf1(1 To 14, 2 To 14) As Integer
Dim Shared hf2(1 To 14, 2 To 14) As Integer
Dim Shared helion As Integer
Dim Shared blowheli As Integer
Dim Shared helix As Integer
Dim Shared heliy As Integer
Dim Shared helilt
Dim Shared rotor As Integer

Dim Shared leiter(1 To 14, 1 To 14) As Integer

Dim Shared tropfen(1 To 14, 1 To 14) As Integer

Dim Shared boom(1 To 14, 1 To 14) As Integer

Dim Shared para(1 To 14, 1 To 14) As Integer
Dim Shared paraon

Dim Shared maxfeld(1 To 14, 1 To 28) As Integer
Dim Shared bc As Integer
Dim Shared maxframe As Integer
Dim Shared maxstill As Integer

Const linienpunkte = 15

Const maxacid = 100
Const acidplus = 4
Dim Shared acid As Integer
Dim Shared showallacid As Integer

Const belegt% = 1
Const Frei% = 0
Const maxlinie = 4

Const fb = 12
Const fh = 23
Const bg = 14

Dim Shared maxposx As Integer
Dim Shared maxposy As Integer
Dim Shared maxlt

Dim Shared feld%(-1 To fb + 3, -1 To fh + 2)
Dim Shared farb%(-1 To fb + 3, -1 To fh + 2)
Dim Shared blockx%(4)
Dim Shared blocky%(4)

Const Musikanzahl = 3
Dim Shared Musiklaenge(Musikanzahl) As Integer
Dim Shared Musik$(50, Musikanzahl)
Dim Shared Musikstueck%
Dim Shared musi%
Dim Shared nomusik

Dim Shared punkte As Integer
Dim Shared Linienweg As Integer
Dim Shared Level As Integer

Dim Shared nstr%

Dim Shared endeundaus

Dim Shared hoho%(4)

Dim Shared already As Integer

Dim Shared yn(1 To 4) As Integer
For I = 1 To 4
    yn(I) = 1
Next I

getsprites

init
init.ffont


Randomize Timer

Do

    Screen 12

    Cls
    If already = 0 Then
        Intro
        Cls
        Titel
        Cls
    End If

    menu
    main

    Palette
    Color
    clear.var
    already = 1
Loop

keine:
h = 1
Resume Next



hinter:
If musi% < Musiklaenge(Musikstueck%) Then
    musi% = musi% + 1
Else
    musi% = 1:
    m% = Musikstueck%
    Do
        Musikstueck% = Int(Rnd * (Musikanzahl)) + 1
    Loop Until Musikstueck% <> m%
    Play "mb p1"
End If
Play "mb" + Musik$(musi%, Musikstueck%)
Return

'Fallschirm
Data ,,,,2,2,1,1,2,2,,,,
Data ,,2,2,1,2,2,2,2,1,2,2,,
Data 1,2,2,2,2,1,2,2,1,2,2,2,2,1
Data 2,1,2,2,,,,,,2,2,2,1,2
Data 2,2,1,7,,,,,,,7,1,2,2
Data 7,,,7,,,,,,,7,,,7
Data ,7,,,7,,,,,7,,,7,
Data ,7,,,7,,,,,7,,,7,
Data ,,7,,,7,,,7,,,7,,
Data ,,7,,,7,,,7,,,7,,
Data ,,,7,,7,,,7,,7,,,
Data ,,,7,,,7,7,,,7,,,
Data ,,,,7,,7,7,,7,,,,
Data ,,,,7,,7,7,,7,,,,

'Explosion
Data 4,,,,,,4,4,,,,,4,4
Data 4,4,,,,4,4,4,4,,,4,4,4
Data 4,4,4,,,4,12,12,4,4,4,4,4,4
Data 4,4,4,4,4,4,12,12,12,12,12,12,4,
Data ,4,4,12,12,12,12,12,14,14,12,12,4,
Data ,,4,12,14,14,14,14,14,14,14,12,4,4
Data ,4,4,12,12,14,14,14,14,12,12,12,12,4
Data ,4,12,12,14,14,14,14,14,14,12,12,4,4
Data 4,4,12,12,12,14,14,14,14,14,12,4,4,
Data 4,12,12,12,14,14,12,12,14,14,12,4,,
Data 4,4,4,12,12,12,12,12,12,12,12,4,,
Data ,,4,12,12,4,4,4,4,12,12,4,4,
Data ,4,4,12,4,4,,,4,4,4,4,4,4
Data ,4,4,4,4,,,,,4,,,4,4

'Tropfen
Data ,,,,,,1,,,,,,,
Data ,,,,,,1,1,,,,,,
Data ,,,,,,1,1,1,,,,,
Data ,,,,,,1,2,1,,,,,
Data ,,,,,1,1,2,1,1,,,,
Data ,,,,,1,2,2,2,1,,,,
Data ,,,,1,1,2,10,2,1,1,,,
Data ,,,1,1,2,2,10,2,2,1,,,
Data ,,1,1,2,2,3,10,10,2,1,1,,
Data ,,1,2,2,3,10,10,10,2,2,1,,
Data ,,1,2,2,10,10,10,10,2,2,1,,
Data ,,1,1,2,2,10,10,2,2,1,,,
Data ,,,1,1,2,2,2,2,1,1,,,
Data ,,,,1,1,1,1,1,1,,,,

'Leiter
Data ,6,,,,,,,,,,6,,
Data ,6,,,,,,,,,6,6,,
Data 6,7,6,6,6,6,6,6,6,6,7,,,
Data 6,6,,,,,,,,,6,6,,
Data ,6,,,,,,,,,,6,,
Data ,7,6,6,6,6,6,6,6,6,6,7,,
Data ,6,,,,,,,,,,6,,
Data ,6,,,,,,,,,,6,,
Data ,6,,,,,,,,,,6,,
Data 6,7,6,6,6,6,6,6,6,6,6,7,,
Data 6,,,,,,,,,,6,,,
Data 6,,,,,,,,,,6,,,
Data 6,7,6,6,6,6,6,6,6,6,7,6,,
Data ,6,,,,,,,,,,6,,

'max
Data ,,,,,8,8,8,8,,,,,
Data ,,,,8,8,8,8,8,8,,,,
Data ,,,,,12,9,9,12,,,,,
Data ,,,,,12,12,12,12,,,,,
Data ,,,,,,12,12,,,,,,
Data ,,,,2,2,2,8,7,2,,,,
Data ,,,8,2,8,2,2,2,2,7,,,
Data ,,2,7,,7,8,2,2,,8,2,,
Data ,,13,,,2,2,7,8,,,13,,
Data ,,,,,8,2,2,2,,,,,
Data ,,,,,7,2,8,2,,,,,
Data ,,,,8,2,,,7,2,,,,
Data ,,,,7,2,,,2,8,,,,
Data ,,,6,6,6,,,6,6,6,,,

Data ,,,,,8,8,8,8,,,,,
Data ,,,,8,8,8,8,8,8,,,,
Data ,,,,,12,9,9,12,,,,,
Data ,,13,,,12,12,12,12,,,13,,
Data ,,2,7,,,12,12,,,8,2,,
Data ,,,8,2,2,2,8,7,2,7,,,
Data ,,,8,2,8,2,2,2,2,,,,
Data ,,,,,7,8,2,2,,,,,
Data ,,,,,2,2,7,8,,,,,
Data ,,,,,8,2,2,2,,,,,
Data ,,,,,7,2,8,2,,,,,
Data ,,,,8,2,,,7,2,,,,
Data ,,,,7,2,,,2,8,,,,
Data ,,,6,6,6,,,6,6,6,,,

'heli
Data ,,,,,,,,,,,,,,,15,15,,,,,,,,,,,
Data ,,,,,,,,,,,,,,4,4,4,4,4,4,4,4,,,,,,
Data 2,4,,,,,,,,,,,4,4,4,4,4,4,4,4,4,4,1,1,,,,
Data 4,4,7,,,,,,,,,,4,4,4,4,4,,,,4,4,1,1,1,,,
Data 4,7,7,7,,,,,,,,4,4,4,4,4,4,,,,4,4,4,1,1,1,,
Data 7,7,8,7,7,,,,,,,4,4,4,4,4,4,,,,4,4,4,1,1,1,,
Data 4,7,7,7,4,4,4,4,4,4,4,4,4,4,4,4,4,,,,,4,4,4,1,1,,
Data 4,4,7,4,4,4,4,4,4,4,4,4,4,4,4,4,4,,,,,4,4,4,4,4,,
Data ,,,,,,,,,,,4,4,4,4,4,4,,,,,4,4,8,8,8,8,8
Data ,,,,,,,,,,,,4,4,4,4,4,4,4,4,4,4,4,4,4,4,,
Data ,,,,,,,,,,,,,4,4,4,4,4,4,4,4,4,4,4,4,,,
Data ,,,,,,,,,,,,,,,4,,,,,,,4,,,,8,
Data ,,,,,,,,,,,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,

'Font
Data 1,1,1,1,,,1,,,1,,1,1,1,,,1,,,1,1,1,1,1,,,1,1,1,,1,,,,,1,,,,,1,,,,1,,1,1,1,
Data 1,1,1,1,,,1,,,1,,1,,,1,,1,,,1,1,1,1,1,,1,1,1,1,1,1,,,,,1,1,1,1,,1,,,,,1,1,1,1,1
Data 1,,,,1,1,1,,,1,1,,1,,1,1,,,1,1,1,,,,1,,1,1,1,,1,,,,1,1,,,,1,1,,,,1,,1,1,1,
Data 1,1,1,1,,1,,,,1,1,1,1,1,,1,,,,,1,,,,,,1,1,1,,1,,,,1,1,,1,,1,1,,,1,1,,1,1,1,1
Data 1,1,1,1,,1,,,,1,1,1,1,1,,1,,,1,,1,,,,1,,1,1,1,1,1,,,,,,1,1,1,,,,,,1,1,1,1,1,
Data 1,1,1,1,1,,,1,,,,,1,,,,,1,,,,,1,,,1,,,,1,1,,,,1,1,,,,1,1,,,,1,,1,1,1,
Data 1,,,,1,,1,,1,,,,1,,,,,1,,,,,1,,,,1,1,1,,1,,,1,1,1,,1,,1,1,1,,,1,,1,1,1,
Data ,,1,,,,1,1,,,,,1,,,,,1,,,,1,1,1,,,1,1,1,,1,,,,1,,,1,1,,,1,,,,1,1,1,1,1
Data 1,1,1,1,,,,,,1,,1,1,1,,,,,,1,1,1,1,1,,,,,1,,,,1,1,,,1,,1,,1,1,1,1,1,,,,1,
Data 1,1,1,1,,1,,,,,1,1,1,1,,,,,,1,1,1,1,1,,,1,1,1,,1,,,,,1,1,1,1,,1,,,,1,,1,1,1,
Data 1,1,1,1,1,,,,,1,,,,1,,,,1,,,,,1,,,,1,1,1,,1,,,,1,,1,1,1,,1,,,,1,,1,1,1,
Data ,1,1,1,,1,,,,1,,1,1,1,1,,,,,1,,1,1,1,,,,,,,,1,,,,,,,,,,1,,,,,,,,
Data ,,,,,,,,,,1,1,1,1,,,,,,,,,,,

'READY
Data 7,3,13,,3,,12,,3,,12,,3,,11,,5,,10,,5,,10,,5,,9,,7,,9,5,2,,x,,2,,7,6,3,,6,,9,,6,,9,,6,,9,,5,,11,,4,,11,,4,,11,,4,,11,,2,2,13,2,2,10,6,,10,2,4,,12,,3,,13,,2,
Data 13,,2,,x,,,,x,,,,x,,,,x,,,,x,,,,x,,,,x,,,,x,,,,13,2,,,13,,2,,12,,3,,10,2,4,,9,,5,,11,5,3,12,4,,12,,3,,2,10,4,,,,x,,,,x,,,,x,,,,x,,,,x,,2,8
Data 6,,10,,5,,2,8,6,,,,x,,,,x,,,,x,,,,x,,,,x,,2,10,4,,12,,,2,x,,3,7,9,,7,2,7,,9,,6,,10,,5,,10,,5,,10,,5,,10,,5,,9,,6,,7,2,7,,4,3,9,,3,,12,,3,,12,,4,,11,,5,
Data 10,,6,,9,,7,,8,,8,,7,,9,,4,2,11,4,3,,9,,5,,,,7,,,,4,,2,,5,,2,,5,,,,5,,,,6,,2,,3,,2,,7,,,,3,,,,8,,2,,,,2,,9,,2,,2,,11,,3,,13,,,,x,,,,x,,,,x,,,,x,,,,x,,,,x,,,,x,,,,x,,,,7,7,3,7

Data "T240l8n38n39n40l4n48l8n40l4n48l8n40l4n48p64p64l8n48n50"
Data "l8n51n52n48n50l4n52l8n47l4n50l3n48l8n38n39"
Data "l8n40l4n48l8n40l4n48l8n40l4n48p64p64l8n45n43n42l8n45"
Data "l8n48l4n52l8n50l8n48l8n45l3n50l8n38n39n40l4n48"
Data "l8n40l4n48l8n40l4n48p64p64l8n48n50n51n52n48n50"
Data "l4n52l8n47l4n50n48p64l8n48n50n52n48n50l4n52"
Data "l8n48n50n48n52n48l8n50l4n52l8n48n50n48"
Data "l8n52n48n50l4n52l8n47l4n50l4n48p64l8n40l8n41l8n42"
Data "l4n43l8n45l4n43l8n40l8n41l8n42l4n43l8n45l4n43l8n52"
Data "l8n48l8n43l8n45l8n47l8n48l8n50l8n52l8n50l8n48l8n50"
Data "l4n43p64l8n43l8n40l8n41l4n43l8n45l4n43l8n40l8n41l8n42"
Data "l4n43l8n45l8n43p64l8n43l8n45l8n46l8n47l8n47p64l4n47l8n45"
Data "l8n42l8n38l4n43"
Data "MUSIKENDE"

Data "T110l6n35l16n36l3n38l16n35l8n33l16n35l2n31l6n35l16n35"
Data "l6n33l16n31l3n28l16n28l6n35l16n35l2n33l6n35l16n36l3n38"
Data "l16n35l8n33l16n35l2n31l6n35l16n35l6n33l16n31l3n28l16n28"
Data "l6n35l16n35l2n33l6n35l16n36l3n38l16n35l8n33l16n35l2n31"
Data "l6n35l16n35l6n33l16n31l3n28l16n28l6n35l16n35l2n33l6n35"
Data "l16n36l3n38l16n35l8n33l16n35l2n31l6n35l16n35l6n33l16n31"
Data "l3n28l16n28l6n35l16n35l2n33p64p64l5n38l5n38l5n38l6n38l16n40"
Data "l6n33l16n33l6n33l16n33l2n33l6n33l16n33l6n33l16n33l2n33"
Data "l6n31l16n31l6n31l16n31l2n31l5n38l5n38l5n38l6n38l16n40"
Data "l6n33l16n33l6n33l16n33l2n33l6n33l16n33l6n33l16n33l2n33"
Data "l6n31l16n31l6n31l16n31l2n31"
Data "MUSIKENDE"

Data "T220MSl3n40l8n40l4n43l4n47l4n46n46l2n42l4n33l4n33"
Data "l4n33n33n35n35l2n35l3n40l8n40l4n43l4n47l4n49"
Data "l4n49n46n49n51n48n43n45l2n47l8n47n45"
Data "l8n43n42l2n40l4n31l7n43l8n47l4n52n52n51n54"
Data "l2n52l4n31l8n43l8n47l4n52l4n52n51n54l2n52l8n47"
Data "l8n45n43n42l3n40l8n40l4n43n47n46n46l2n42"
Data "l4n33n33n33n33n35n35l2n35l3n40l8n40l4n43"
Data "l4n47n49n49n46n49n51n48n43n45l2n47l8n47n45n43n42l2n40"
Data "l4n31l7n43l8n47l4n52n52n51n54l2n52l4n31l8n43"
Data "l8n47l4n52n52n51n54l2n52l8n47n45n43n42"
Data "MUSIKENDE"

Sub acidrain
    maxar = fb
    Dim ar(maxar) As Integer
    Dim armax(maxar) As Integer
    For x% = 1 To fb
        For y% = 1 To fh - 1
            If feld%(x%, y%) = belegt% Then Exit For
        Next y%
        armax(x%) = y%
        If feld%(x%, y%) = belegt% Then
            feld%(x%, y%) = Frei%
            farb%(x%, y%) = 0
        End If
    Next x%
    For I% = 1 To maxar
        ar(I%) = Int(Rnd * (3)) - 3
    Next I%
    Do
        For I% = 1 To maxar
            If ar(I%) < armax(I%) Then
                ar(I%) = ar(I%) + 1
                kastl I%, ar(I%), 33
            End If
        Next I%
        t = Timer
        Do
        Loop Until Timer >= t + .15
        For I% = 1 To maxar
            kastl I%, ar(I%), 0
        Next I%
        chk = 0
        For I% = 1 To maxar
            If ar(I%) >= armax(I%) Then chk = chk + 1
        Next I%
        If chk = maxar Then Exit Do
    Loop
    nichtganzalles
    If yn(4) = 1 Then
        acid = 0
        show.acidometer
    End If
End Sub

Sub alles

    For x% = -480 To 640 Step 20
        For I% = 0 To 2
            Line (x% + I%, 0)-(x% + 480 + I%, 480), 8
            Line (x% - I%, 0)-(x% + 480 - I%, 480), 7
            Line (x% - I% + 480, 0)-(x% - I%, 480), 7
            Line (x% + 480 + I%, 0)-(x% + I%, 480), 8
        Next I%
    Next x%

    Line (320 + 1 - fb * bg / 2, 240 + 1 - fh * bg / 2 + bg)-(321 - 1 + fb * bg / 2, 240 - 1 + fh * bg / 2 + 1 + bg), 0, BF

    x1% = ((320 - fb * bg / 2) + ((-4) * bg) + 1)
    y1% = ((240 - fh * bg / 2) + ((1) * bg) + 1)
    x2% = ((320 - fb * bg / 2 - 1) + ((-1) * bg) + 1)
    y2% = ((240 - fh * bg / 2) + (5) * bg)
    Line (x1%, y1%)-(x2%, y2%), 0, BF
    Line (x1% - 1, y1% - 1)-(x2% + 1, y2% + 1), 2, B

    Color 8
    u = 10

    Draw "c1 bm190,70 u40 r 20 F30 d10 l30 u10 r13 h17 l3 d27 l13"
    Paint (191, 68), 2, 1
    Draw "c1 bm250,70 u40 r13 d40 l13"
    Paint (253, 68), 2, 1
    Draw "c1 bm275,70 u40 r 20 F30 d10 l30 u10 r13 h17 l3 d27 l13"
    Paint (277, 68), 2, 1
    Draw "c1 bm335,70 u40 r22"
    Line -Step(20, 15), 1
    Line -Step(-16, 10), 1
    Draw "f15 l13 h12 u7"
    Line -Step(9, -6), 1
    Line -Step(-8, -5), 1
    Draw "l4 d30 l12"
    Paint (337, 68), 2, 1
    Draw "c1 bm385,70 u40 r13 d40 l13"
    Paint (387, 68), 2, 1
    Draw "c1 bm410,70 u10 r23 e5 l27 u15 e10 r30 d10 l23 g5 r27 d15 g10 l30"
    Paint (413, 68), 2, 1

    Tasten
    Punktezahl
    nichtganzalles

    If yn(4) = 1 Then
        Color 11
        Locate 26, 10: Print "Acid-O-Meter"
        showallacid = 1
        show.acidometer
        showallacid = 0
    End If

    If yn(3) = 1 Then
        Line (220, 440)-(420, 470), 0, BF
        Line (220, 440)-(420, 470), 15, B
        show.font2 "BODY-COUNT:", 2, 0, 1, 235, 448
        show.bodycount
    End If
 
End Sub

Sub ausis
    'TODO
    Timer Off
    If Play(1) <> 0 Then Beep

    showpoints
    showhiscore

    endeundaus = 1
End Sub

Sub ausss
    show.verynicegraphic

    Screen 0
    Color 1, 4
    Print "Freeware                                                      by Dietmar Moritz"
    Print
    Color 2, 0
    Print "Thanks for playing"
    Color 15, 0
    Print
    Print "         /±±±±±      /±±    /±±±±±      /±±±±±±     /±±     /±±±±±"
    Print "        ≥ ±±_/±±    ≥ ±±   ≥ ±±_/±±    ≥ ±±__/±±   ≥ ±±    /±±__/±±"
    Print "        ≥ ±±≥//±±   ≥ ±±   ≥ ±±≥//±±   ≥ ±±±±±±/   ≥ ±±   ≥/_/±±/_/"
    Print "        ≥ ±± ≥ ±±   ≥ ±±   ≥ ±± ≥ ±±   ≥ ±±/±±/    ≥ ±±     ≥//±±"
    Print "        ≥ ±± /±±/   ≥ ±±   ≥ ±± /±±/   ≥ ±±//±±    ≥ ±±    /±±/_/±±"
    Print "        ≥ ±±±±±/    ≥ ±±   ≥ ±±±±±/    ≥ ±±≥//±±   ≥ ±±   ≥//±±±±±/"
    Print "        ≥/___/      ≥/_/   ≥/____/     ≥/_/ ≥/_/   ≥/_/    ≥/____/  ";
    Color 3
    Print " v2.2"
    Print Spc(67); "(22.11.98)"
    Color 8, 0
    For y% = 2 To 25
        For x% = 1 To 80
            If Screen(y%, x%) = 179 Then Locate y%, x%: Print "≥"
            If Screen(y%, x%) = Asc("/") Then Locate y%, x%: Print "/"
            If Screen(y%, x%) = Asc("_") Then Locate y%, x%: Print "_"
        Next x%
    Next y%
    End
End Sub

Sub clear.var

    bomb = 0
    nextbomb = 0

    helion = 0
    blowheli = 0
    helix = 0
    heliy = 0
    helilt = 0
    rotor = 0
    bc = 0
    maxframe = 0
    maxstill = 0

    acid = 0
    showallacid = 0

    maxposx = 0
    maxposy = 0
    maxlt = 0

    For x% = -1 To fb + 3
        For y% = -1 To fh + 2
            feld%(x%, y%) = 0
            farb%(x%, y%) = 0
        Next y%
    Next x%

    punkte = 0
    Linienweg = 0
    Level = 0

    nstr% = 0

    endeundaus = 0
End Sub

Sub drehen (struktur%)
    Select Case struktur%
        Case 1
            If (blockx%(2) + 1 = blockx%(1)) And (feld%(blockx%(1) + 1, blocky%(1)) <> belegt%) Then
                blockx%(3) = blockx%(3) - 1: blocky%(3) = blocky%(2)
                blockx%(2) = blockx%(4): blocky%(2) = blocky%(4)
                blockx%(4) = blockx%(1) + 1: blocky%(4) = blocky%(1)
                HE = 1
            End If
            If (blockx%(4) + 1 = blockx%(1)) And (feld%(blockx%(1), blocky%(1) - 1) <> belegt%) Then
                blockx%(3) = blockx%(2): blocky%(3) = blocky%(2)
                blockx%(2) = blockx%(4): blocky%(2) = blocky%(4)
                blockx%(4) = blockx%(1): blocky%(4) = blocky%(1) - 1
            End If
            If (blockx%(1) + 1 = blockx%(2)) And (feld%(blockx%(1) - 1, blocky%(1)) <> belegt%) Then
                blockx%(3) = blockx%(2): blocky%(3) = blocky%(2)
                blockx%(2) = blockx%(4): blocky%(2) = blocky%(4)
                blockx%(4) = blockx%(1) - 1: blocky%(4) = blocky%(1)
            End If
            If (HE <> 1) And (blockx%(3) + 1 = blockx%(1)) And (feld%(blockx%(1), blocky%(1) + 1) <> belegt%) Then
                blockx%(3) = blockx%(2): blocky%(3) = blocky%(2)
                blockx%(2) = blockx%(4): blocky%(2) = blocky%(4)
                blockx%(4) = blockx%(1): blocky%(4) = blocky%(1) + 1
            End If
        Case 3
            If (blocky%(3) + 1 = blocky%(1)) And (feld%(blockx%(1), blocky%(4)) <> belegt%) And (feld%(blockx%(1) - 1, blocky%(4)) <> belegt%) Then
                blockx%(4) = blockx%(1)
                blockx%(3) = blockx%(1) - 1: blocky%(3) = blocky%(4)
                HE = 1
            End If
            If (HE <> 1) And (blocky%(3) - 1 = blocky%(1)) And (feld%(blockx%(1), blocky%(2) - 1) <> belegt%) And (feld%(blockx%(2), blocky%(4)) <> belegt%) Then
                blockx%(4) = blockx%(2)
                blockx%(3) = blockx%(1): blocky%(3) = blocky%(1) - 1
            End If
        Case 4
            If (blocky%(3) + 1 = blocky%(1)) And (feld%(blockx%(2), blocky%(4)) <> belegt%) And (feld%(blockx%(2) + 1, blocky%(4)) <> belegt%) Then
                blockx%(4) = blockx%(2)
                blockx%(3) = blockx%(2) + 1: blocky%(3) = blocky%(4)
                HE = 1
            End If
            If (HE <> 1) And (blocky%(3) - 1 = blocky%(1)) And (feld%(blockx%(2), blocky%(2) - 1) <> belegt%) And (feld%(blockx%(1), blocky%(4)) <> belegt%) Then
                blockx%(4) = blockx%(1)
                blockx%(3) = blockx%(2): blocky%(3) = blocky%(1) - 1
            End If
        Case 5
            If (blocky%(2) + 1 = blocky%(1)) And (feld%(blockx%(3), blocky%(1)) <> belegt%) And (feld%(blockx%(3), blocky%(1) + 1) <> belegt%) And (feld%(blockx%(1) - 1, blocky%(1)) <> belegt%) Then
                blockx%(2) = blockx%(3): blocky%(2) = blocky%(1)
                blocky%(3) = blocky%(4)
                blockx%(4) = blockx%(4) - 1: blocky%(4) = blocky%(1)
                HE = 1
            End If
            If (HE <> 1) And (blockx%(2) - 1 = blockx%(1)) And (feld%(blockx%(1), blocky%(3)) <> belegt%) And (feld%(blockx%(4), blocky%(3)) <> belegt%) And (feld%(blockx%(1), blocky%(1) - 1) <> belegt%) Then
                blockx%(2) = blockx%(1): blocky%(2) = blocky%(3)
                blockx%(3) = blockx%(4)
                blockx%(4) = blockx%(1): blocky%(4) = blocky%(1) - 1
                HE = 1
            End If
            If (HE <> 1) And (blocky%(2) - 1 = blocky%(1)) And (feld%(blockx%(3), blocky%(1)) <> belegt%) And (feld%(blockx%(2) + 1, blocky%(1)) <> belegt%) And (feld%(blockx%(3), blocky%(4)) <> belegt%) Then
                blockx%(2) = blockx%(3): blocky%(2) = blocky%(1)
                blocky%(3) = blocky%(4)
                blockx%(4) = blockx%(4) + 1: blocky%(4) = blocky%(1)
                HE = 1
            End If
            If (HE <> 1) And (blockx%(2) + 1 = blockx%(1)) And (feld%(blockx%(1), blocky%(3)) <> belegt%) And (feld%(blockx%(4), blocky%(3)) <> belegt%) And (feld%(blockx%(1), blocky%(1) + 1) <> belegt%) Then
                blockx%(2) = blockx%(1): blocky%(2) = blocky%(3)
                blockx%(3) = blockx%(4)
                blockx%(4) = blockx%(1): blocky%(4) = blocky%(1) + 1
                HE = 1
            End If
        Case 6
            If (blocky%(2) + 1 = blocky%(1)) And (feld%(blockx%(3), blocky%(1)) <> belegt%) And (feld%(blockx%(3), blocky%(4)) <> belegt%) And (feld%(blockx%(1) + 1, blocky%(1)) <> belegt%) Then
                blockx%(2) = blockx%(3) + 2: blocky%(2) = blocky%(1)
                blockx%(3) = blockx%(2)
                blockx%(4) = blockx%(4) - 1: blocky%(4) = blocky%(1)
                HE = 1
            End If
            If (HE <> 1) And (blockx%(2) - 1 = blockx%(1)) And (feld%(blockx%(1), blocky%(3)) <> belegt%) And (feld%(blockx%(3), blocky%(2) + 1) <> belegt%) And (feld%(blockx%(1), blocky%(1) + 1) <> belegt%) Then
                blockx%(2) = blockx%(1): blocky%(2) = blocky%(1) + 1
                blocky%(3) = blocky%(2)
                blockx%(4) = blockx%(1): blocky%(4) = blocky%(1) - 1
                HE = 1
            End If
            If (HE <> 1) And (blocky%(2) - 1 = blocky%(1)) And (feld%(blockx%(3), blocky%(1)) <> belegt%) And (feld%(blockx%(2) - 1, blocky%(1)) <> belegt%) And (feld%(blockx%(2) - 1, blocky%(2)) <> belegt%) Then
                blockx%(2) = blockx%(2) - 1: blocky%(2) = blocky%(1)
                blockx%(3) = blockx%(2)
                blockx%(4) = blockx%(4) + 1: blocky%(4) = blocky%(1)
                HE = 1
            End If
            If (HE <> 1) And (blockx%(2) + 1 = blockx%(1)) And (feld%(blockx%(1), blocky%(3)) <> belegt%) And (feld%(blockx%(2), blocky%(2) - 1) <> belegt%) And (feld%(blockx%(1), blocky%(1) - 1) <> belegt%) Then
                blockx%(2) = blockx%(1): blocky%(2) = blocky%(2) - 1
                blocky%(3) = blocky%(2)
                blockx%(4) = blockx%(1): blocky%(4) = blocky%(1) + 1
                HE = 1
            End If
        Case 7
            If (blocky%(2) + 1 = blocky%(1)) And (feld%(blockx%(1) - 1, blocky%(1)) <> belegt%) And (feld%(blockx%(1) + 1, blocky%(1)) <> belegt%) And (feld%(blockx%(1) + 2, blocky%(1)) <> belegt%) Then
                For I% = 2 To 4
                    blocky%(I%) = blocky%(1)
                Next I%
                blockx%(2) = blockx%(1) - 1
                blockx%(3) = blockx%(1) + 1
                blockx%(4) = blockx%(1) + 2
                HE = 1
            End If
            If (HE <> 1) And (blockx%(2) + 1 = blockx%(1)) And (feld%(blockx%(1), blocky%(1) - 1) <> belegt%) And (feld%(blockx%(1), blocky%(1) + 1) <> belegt%) And (feld%(blockx%(1), blocky%(1) + 2) <> belegt%) Then
                For I% = 2 To 4
                    blockx%(I%) = blockx%(1)
                Next I%
                blocky%(2) = blocky%(1) - 1
                blocky%(3) = blocky%(1) + 1
                blocky%(4) = blocky%(1) + 2
            End If
    End Select
End Sub

Function fax (x, z, zx, zz)
    fax = (zx * z - zz * x) / (z - zz)
End Function

Function fay (y, z, zy, zz)
    fay = (zy * z - zz * y) / (z - zz)
End Function

Sub fire (x%, y%)
    Do
        If InKey$ <> "" Then Exit Do
        ax% = x%
        ay% = y%
        select.case oldi%, ax%, ay%
        If Point(ax%, ay%) <> 10 Then
            For I% = 1 To 9
                ax% = x%
                ay% = y%
                select.case I%, ax%, ay%
                If I% = 9 Then Exit Do
                If Point(ax%, ay%) = 10 Then Exit For
            Next I%
        Else
            I% = oldi%
        End If

        oldi% = I%
        x% = ax%
        y% = ay%
        PSet (x%, y%), 4
        For w = 0 To 2 * _Pi Step .8
            For I% = 1 To 4
                If Point(x% + Sin(w) * I%, y% + Cos(w) * I%) = 0 Then
                    PSet (x% + Sin(w) * I%, y% + Cos(w) * I%), 4
                End If
            Next I%
        Next w
        Select Case Int(Rnd * (1))
            Case 0: Color 0
        End Select
        If InKey$ <> "" Then Exit Do
        PSet (x%, y%)
        For w = 0 To 2 * _Pi Step .8
            For I% = 1 To 4
                If Point(x% + Sin(w) * I%, y% + Cos(w) * I%) = 4 Then
                    PSet (x% + Sin(w) * I%, y% + Cos(w) * I%), 0
                End If
            Next I%
        Next w
        _Limit 60
    Loop
    Line (265, 200)-Step(120, 50), 0, BF
End Sub

Sub getsprites
    For I% = 1 To 6
        For y% = 1 To 14
            For x% = 1 To 14
                Read a
                Select Case I%
                    Case 1: If a = 2 Then a = 15
                        para(x%, y%) = a
                    Case 2: boom(x%, y%) = a
                    Case 3: tropfen(x%, y%) = a
                    Case 4: leiter(x%, y%) = a
                    Case 5: If a = 2 Then a = 10
                        maxfeld(x%, y%) = a
                    Case 6: If a = 2 Then a = 10
                        maxfeld(x%, y% + 14) = a
                End Select
            Next x%
        Next y%
    Next I%

    For y% = 2 To 14
        For x% = 1 To 28
            Read a
            If a = 4 Then a = Int(Rnd * (2)) * 8 + 2
            If x% < 15 Then
                hf1(x%, y%) = a
            Else
                hf2(x% - 14, y%) = a
            End If
        Next x%
    Next y%
End Sub

Sub gettaste (z$, posit%, max)
    Do
        z$ = InKey$
    Loop Until z$ <> ""
    Select Case Right$(z$, 1)
        Case "8", "H": If posit% > 1 Then posit% = posit% - 1
        Case "2", "P": If posit% < max Then posit% = posit% + 1
    End Select
End Sub

Sub grey
    setgrey 1, 4
    setgrey 2, 24
    setgrey 3, 28
    setgrey 4, 12
    setgrey 5, 17
    setgrey 6, 24
    setgrey 7, 41
    setgrey 8, 20
    setgrey 9, 25
    setgrey 10, 45
    setgrey 11, 49
    setgrey 12, 33
    setgrey 13, 37
    setgrey 14, 57
    setgrey 15, 62
End Sub

Sub heli
    show.heli 0

    I% = Int(Rnd * (9)) - 1
    ii% = Int(Rnd * (9)) - 1

    If I% >= 2 Then
        If maxposx <= helix Then
            I% = -1
        Else
            I% = 1
        End If
        If maxposx = helix + 1 Then I% = 0
    End If

    If ii% >= 2 Then
        If maxposy > heliy Then
            ii% = 1
        Else
            ii% = -1
        End If
        If maxposy = heliy - 1 Then ii% = 0
    End If


    chk1% = 1
    chk2% = 1

    For u% = 1 To 4
        If blockx%(u%) = helix + I% And blocky%(u%) = heliy Then chk1% = 0
        If blockx%(u%) = helix + I% + 1 And blocky%(u%) = heliy Then chk1% = 0
        If blockx%(u%) = helix And blocky%(u%) = heliy + ii% Then chk2% = 0
        If blockx%(u%) = helix + 1 And blocky%(u%) = heliy + ii% Then chk2% = 0
    Next u%

    If feld%(helix + I%, heliy) = Frei% And chk1% And feld%(helix + I% + 1, heliy) = Frei% Then
        helix = helix + I%
    End If

    If feld%(helix, heliy + ii%) = Frei% And chk2% And feld%(helix + 1, heliy + ii%) = Frei% Then
        heliy = heliy + ii%
    End If


    If helix = 0 Then maxposx = 2
    If helix + 1 >= fb + 1 Then helix = fb - 1

    If heliy = 0 Then heliy = 1
    If heliy = fh Then heliy = fh - 1
 
    helilt = Timer
    show.heli 1

    If helix + 1 = maxposx And heliy + 1 = maxposy Then heligetsmax
End Sub

Sub heligetsmax
    x1% = ((320 - fb * bg / 2) + ((helix) * bg) + 1)
    y1% = ((240 - fh * bg / 2) + ((heliy + 1) * bg) + 1)

    For u% = 1 To 4
        kastl blockx%(u%), blocky%(u%), 0
    Next u%

    kastl maxposx, maxposy, 0
    maxframe = 2
    kastl maxposx, maxposy, 55
 
    For y% = 1 To 14
        For x% = 1 To 14
            If leiter(x%, y%) > 0 Then PSet (x% + x1% - 1, y% + y1% - 1), leiter(x%, y%)
        Next x%
    Next y%

    t = Timer
    Do
    Loop Until Timer >= t + 2

    kastl helix + 1, heliy + 1, 0
    For y% = 1 To 14
        For x% = 1 To 14
            If leiter(x%, y%) > 0 Then PSet (x% + x1% - 1, y% + y1% - 1), leiter(x%, y%)
        Next x%
    Next y%

    t = Timer
    Do
    Loop Until Timer >= t + 1

    kastl maxposx, maxposy, 0

    Do

        t = Timer
        Do
        Loop Until Timer >= t + .2

        show.heli 0
        heliy = heliy - 1
        If heliy = 0 Then helion = 0: bc = bc - 1: nichtganzalles: killmax: Exit Do
        show.heli 1
 
    Loop

    punkte = punkte - 100
    If punkte < 0 Then punkte = 0
    Punktezahl
End Sub

Sub init

    For I% = 2 To 5
        GoSub ini
    Next I%

    For I% = 14 To 21
        GoSub ini
    Next I%

    I% = 25
    GoSub ini

    For I% = 30 To 41
        GoSub ini
    Next I%

    Exit Sub

    ini:

    For y% = 1 To 5
        For x% = 1 To 5
            Read a
            bst(I%, x%, y%) = a
        Next x%
    Next y%
    Return

End Sub

Sub init.ffont
    I% = 1
    x% = 1
    y% = 1
    u% = 1
    a = 1

    Do
        Read aa$

        If aa$ = "x" Then aa$ = "14"
        If aa$ = "" Then aa$ = "1"

        If a Then
            a = 0
        Else
            a = 1
        End If

        num = Val(aa$)

        For k = u% To (u% + num - 1)
            x% = x% + 1
            If x% = 19 Then x% = 2: y% = y% + 1
            If y% = 20 Then y% = 1: I% = I% + 1: x% = 2

            buch(I%, x%, y%) = a
 
        Next k

        u% = k

        If k >= 1616 Then Exit Do

    Loop


    For I% = 1 To 5
        buch(I%, 19, 19) = 1
        buch(I%, 1, 19) = 1
    Next I%

End Sub

Sub Intro
    If InKey$ = Chr$(27) Then Exit Sub
    Sleep 1
    Dim d(5) As String
    Dim I(5) As String
    Dim dx(1) As Single
    Dim dy(1) As Single
    Dim ix(1) As Single
    Dim iy(1) As Single
    dx(0) = 1
    dy(0) = 1
    dx(1) = 80 - 6
    dy(1) = 1
    ix(0) = 1
    iy(0) = 23
    ix(1) = 80 - 4
    iy(1) = 23
    d(0) = "DDDDDD"
    d(1) = "DD   DD"
    d(2) = "DD   DD"
    d(3) = "DD   DD"
    d(4) = "DD   DD"
    d(5) = "DDDDDD"
    I(0) = "IIII"
    I(1) = " II"
    I(2) = " II"
    I(3) = " II"
    I(4) = " II"
    I(5) = "IIII"
    Do
        Color 0
        For u% = 0 To 5
            Locate Int(dy(0)) + u%, Int(dx(0)): Print d(u%)
            Locate Int(dy(1)) + u%, Int(dx(1)): Print d(u%)
            Locate Int(iy(0)) + u%, Int(ix(0)): Print I(u%)
            Locate Int(iy(1)) + u%, Int(ix(1)): Print I(u%)
        Next u%
        If dy(0) < 12 Then dy(0) = dy(0) + 1: dx(0) = dx(0) + 2
        If iy(0) > 12 Then iy(0) = iy(0) - 1: ix(0) = ix(0) + 3
        If dy(1) < 12 Then dy(1) = dy(1) + 1: dx(1) = dx(1) - 2.75
        If iy(1) > 12 Then iy(1) = iy(1) - 1: ix(1) = ix(1) - 2
        Color 15
        For u% = 0 To 5
            Locate Int(dy(0)) + u%, Int(dx(0)): Print d(u%)
            Locate Int(dy(1)) + u%, Int(dx(1)): Print d(u%)
            Locate Int(iy(0)) + u%, Int(ix(0)): Print I(u%)
            Locate Int(iy(1)) + u%, Int(ix(1)): Print I(u%)
        Next u%
        t = Timer
        Do
            If InKey$ = Chr$(27) Then Exit Sub
        Loop Until Timer >= t + .08
    Loop Until iy(1) = 12
    setpal 14, 0, 0, 0
    Color 14

    Line (171, 172)-Step(43, 0)
    Line (171, 172)-Step(0, 100)
    Line -Step(43, 0)
    r = 20
    Circle (214, 192), 20, , 0, _Pi / 2
    Circle (214, 252), 20, , _Pi * 3 / 2, 0
    Line (234, 192)-Step(0, 60)

    Line (193, 192)-Step(12, 0)
    Line (193, 192)-Step(0, 61)
    Line -Step(12, 0)
    Circle (205, 200), 8, , 0, _Pi / 2
    Circle (205, 245), 8, , _Pi * 3 / 2.1, 0
    Line (213, 200)-Step(0, 45)

    If InKey$ = Chr$(27) Then Exit Sub

    Line (331, 172)-Step(43, 0)
    Line (331, 172)-Step(0, 100)
    Line -Step(43, 0)
    Circle (374, 192), 20, , 0, _Pi / 2
    Circle (374, 252), 20, , _Pi * 3 / 2, 0
    Line (394, 192)-Step(0, 60)

    Line (353, 192)-Step(12, 0)
    Line (353, 192)-Step(0, 61)
    Line -Step(12, 0)
    Circle (365, 200), 8, , 0, _Pi / 2
    Circle (365, 245), 8, , _Pi * 3 / 2.1, 0
    Line (373, 200)-Step(0, 45)

    If InKey$ = Chr$(27) Then Exit Sub

    Line (261, 172)-Step(37, 0)
    Line (261, 172)-Step(0, 19)
    Line (298, 172)-Step(0, 19)
    Line (261, 191)-Step(7, 0)
    Line (298, 191)-Step(-7, 0)
    Line (268, 191)-Step(0, 62)
    Line (291, 191)-Step(0, 62)
    Line (268, 253)-Step(-7, 0)
    Line (291, 253)-Step(7, 0)
    Line (261, 253)-Step(0, 19)
    Line (298, 253)-Step(0, 19)
    Line -Step(-37, 0)

    If InKey$ = Chr$(27) Then Exit Sub

    Line (421, 172)-Step(37, 0)
    Line (421, 172)-Step(0, 19)
    Line (458, 172)-Step(0, 19)
    Line (421, 191)-Step(7, 0)
    Line (458, 191)-Step(-7, 0)
    Line (428, 191)-Step(0, 62)
    Line (451, 191)-Step(0, 62)
    Line (428, 253)-Step(-7, 0)
    Line (451, 253)-Step(7, 0)
    Line (421, 253)-Step(0, 19)
    Line (458, 253)-Step(0, 19)
    Line -Step(-37, 0)

    t = Timer
    Do
        If InKey$ = Chr$(27) Then Exit Sub
    Loop Until Timer >= t + 2

    For w = 0 To _Pi / 2 Step .05
        setpal 14, Abs(Sin(w) * 63), Abs(Sin(w) * 63), 0
        Wait &H3DA, 8
        If InKey$ = Chr$(27) Then Exit Sub
    Next w

    t = Timer
    Do
        If InKey$ = Chr$(27) Then Exit Sub
    Loop Until Timer >= t + 1

    For w = 0 To _Pi / 2 Step .1
        If InKey$ = Chr$(27) Then Exit Sub
        setpal 0, Abs(Sin(w) * 63), Abs(Sin(w) * 63), Abs(Sin(w) * 63)
        Wait &H3DA, 8
    Next w

    t = Timer
    Do
        If InKey$ = Chr$(27) Then Exit Sub
    Loop Until Timer >= t + .3

    setpal 2, 0, 63 / 2, 0
    Paint (173, 173), 2, 14
    Paint (333, 173), 2, 14
    Paint (263, 173), 2, 14
    Paint (423, 173), 2, 14
    setpal 0, 0, 0, 0

    t = Timer
    Do
        If InKey$ = Chr$(27) Then Exit Sub
    Loop Until Timer >= t + 1
    setpal 1, 0, 0, 0

    Color 0
    Locate 23, 36: Print "PRESENTS"

    Color 1

    show.font "PRESENTS", 4, 0, 1, 220, 360

    w = 1.0472
    h = 0
    t = Timer
    Do
        w = w + .04
        setpal 14, Abs(Sin(w) * 63), Abs(Sin(w) * 63), 0
        setpal 2, 0, Abs(Cos(w) * 63), 0
        Wait &H3DA, 8
        If w > 8 And h < 50 Then
            If h Mod 5 = 0 Then Print
            h = h + 1
        End If
        If w >= _Pi * 2 * 2 Then
            setpal 1, 0, 0, Abs(Sin(w / 3) * 50) + 13
        Else
            setpal 5, 0, 0, Abs(Sin(w / 3) * 50) + 13
        End If
        _Limit 60
    Loop Until InKey$ <> "" Or Timer >= t + 15

    For ii% = 0 To 20
        For y% = 50 To 400 Step 20
            For x% = 170 To 500 Step 20
                Line (x% + ii%, y%)-(x%, y% + ii%), 0
                Line (x% - ii% + 20, y% + 20)-(x% + 20, y% - ii% + 20), 0
            Next x%
        Next y%
        Wait &H3DA, 8
    Next ii%

End Sub

Sub kastl (kastlx%, kastly%, farbe%)

    If farbe% = 7 Then farbe% = 8
    If farbe% >= 9 And farbe% <= 15 Then farbe% = farbe% - 8

    farbe2% = farbe% + 8
    If farbe% = 8 Then: farbe2% = 7

    If farbe% > 0 And farbe% <> 55 Then
        If maxposx = kastlx% And maxposy = kastly% Then
            killmax
        End If
    End If

    If helion And farbe% > 0 Then
        If (helix = kastlx% And heliy = kastly%) Or (helix + 1 = kastlx% And heliy = kastly%) Then
            killheli
        End If
    End If

    If kastly% > 0 Then
        x1% = ((320 - fb * bg / 2) + ((kastlx% - 1) * bg) + 1)
        y1% = ((240 - fh * bg / 2) + ((kastly%) * bg) + 1)

        x2% = ((320 - fb * bg / 2 - 1) + ((kastlx%) * bg) + 1)
        y2% = ((240 - fh * bg / 2) + (kastly% + 1) * bg)

        If farbe% = 0 Then

            Line (x1%, y1%)-(x2%, y2%), farbe%, BF
        Else

            If farbe% = 20 Then
                Circle (x1% + bg / 2 - .5, y2% - bg / 3), bg / 3, 8, _Pi, 0
                Line (x1% + bg / 6, y2% - bg / 3)-Step(0, -bg / 3), 8
                Line (x2% - bg / 6 + 1, y2% - bg / 3)-Step(0, -bg / 3), 8
                Line -Step(-bg * 2 / 3, 0), 8
                Line (x1% + bg / 2 - .5, y1%)-Step(0, bg / 5), 8
                Line (x1% + bg / 6, y1%)-(x2% - bg / 6 + 1, y1%), 8
                Paint (x1% + bg / 2, y1% + bg / 2), 4, 8
                Circle (x1% + bg / 2 - .5, y2% - bg / 3), bg / 3.5, 12, 3 * _Pi / 2 + .3, 2 * _Pi
            Else

                If farbe% = 44 Then
                    For y% = 1 To 14
                        For x% = 1 To 14
                            If boom(x%, y%) > 0 Then PSet (x% + x1% - 1, y% + y1% - 1), boom(x%, y%)
                        Next x%
                    Next y%

                Else

                    If farbe% = 33 Then
                        For y% = 1 To 14
                            For x% = 1 To 14
                                PSet (x% + x1% - 1, y% + y1% - 1), tropfen(x%, y%)
                            Next x%
                        Next y%

                    Else

                        If farbe% = 55 Then

                            If maxframe = 1 Then
                                For y% = 1 To 14
                                    For x% = 1 To 14
                                        If maxfeld(x%, y%) > 0 Then PSet (x% + x1% - 1, y% + y1% - 1), maxfeld(x%, y%)
                                    Next x%
                                Next y%

                            Else

                                For y% = 1 To 14
                                    For x% = 1 To 14
                                        If maxfeld(x%, y% + 14) > 0 Then PSet (x% + x1% - 1, y% + y1% - 1), maxfeld(x%, y% + 14)
                                    Next x%
                                Next y%

                                If paraon And feld%(maxposx, maxposy - 1) = Frei% And maxposy > 1 Then
                                    For y% = 1 To 14
                                        For x% = 1 To 14
                                            If para(x%, y%) > 0 Then PSet (x% + x1% - 1, y% + y1% - 15), para(x%, y%)
                                        Next x%
                                    Next y%
                                End If


                            End If

                        Else

                            in% = bg / 5

                            Line (x1%, y1%)-(x2%, y2%), farbe%, BF
                            Line (x1% + in%, y1% + in%)-(x2% - in%, y2% - in%), farbe2%, BF
                            Line (x1%, y1%)-(x1% + in%, y1% + in%), farbe2%
                            Line (x2%, y2%)-(x2% - in%, y2% - in%), farbe2%
                            Line (x2%, y1%)-(x2% - in%, y1% + in%), farbe2%
                            Line (x1%, y2%)-(x1% + in%, y2% - in%), farbe2%
                        End If
                    End If
                End If
            End If
        End If
    End If

End Sub

Sub killheli

    helion = 0
    kastl helix, heliy, 44
    kastl helix + 1, heliy, 44

    blowheli = 1
End Sub

Sub killmax
    kastl maxposx, maxposy, 0
    If paraon Then kastl maxposx, maxposy - 1, 0

    If maxposx >= fb / 2 Then
        maxposx = maxposx - 5
    Else
        maxposx = maxposx + 5
    End If

    maxposy = 1

    bc = bc + 1
    punkte = punkte + 2
    show.bodycount
    Punktezahl
    paraon = 1
End Sub

Sub main
    Screen 12
    Palette
    Color

    If yn(1) = 2 Then
        nomusik = 1
    Else
        nomusik = 0
    End If

    If yn(3) = 1 Then
        maxposx = Int(fb / 2)
        maxposy = fh
        maxlt = Timer
    Else
        maxposx = 0
        maxposy = 0
    End If



    verzug = .35
    verzugplus = .025

    'Level = 1


    Def Seg = 64
    Poke 23, 32
    Def Seg

    For I% = 0 To fh + 1
        feld%(0, I%) = belegt%
        feld%(fb + 1, I%) = belegt%
    Next I%

    For I% = 0 To fb
        feld%(I%, fh + 1) = belegt%
    Next I%


    alles

    nstr% = Int(Rnd * (7)) + 1

    show.ffont "DCABE", 10, 273, 220
    z$ = Input$(1)
    fire 273, 220 + 19

    Musikladen

    ' a740g: 2 seconds seems to be working ok
    On Timer(2) GoSub hinter
    Timer On

    nextbomb = Int(Rnd * (30)) + 8

    helix = Int(fb / 2)

    Do

        If yn(2) = 1 Then nextbomb = nextbomb - 1

        struktur% = nstr%
        nstr% = Int(Rnd * (7)) + 1
        If nextbomb = 0 Then nstr% = 99: nextbomb = Int(Rnd * (30)) + 8
        strukturstart nstr%
        If endeundaus = 1 Then Exit Sub
        nextes

        If struktur% = 99 Then bomb = 1
        strukturstart struktur%
        If endeundaus = 1 Then Exit Sub
        farbe% = Int(Rnd * (15)) + 1
        If bomb Then farbe% = 20


        Do
            show.stone farbe%
            t = Timer
            Do

                a$ = InKey$


                If a$ <> "" Then
                    show.stone 0
                    If a$ <> "" Then woswasi = 0
                    Select Case a$
                        Case Chr$(0) + "K", "4"
                            k% = 0
                            For i1% = 1 To 4
                                If feld%(blockx%(i1%) - 1, blocky%(i1%)) <> belegt% Then k% = k% + 1
                            Next i1%
                            If k% = 4 Then
                                For i2% = 1 To 4
                                    blockx%(i2%) = blockx%(i2%) - 1
                                Next i2%
                            End If
                        Case Chr$(0) + "M", "6"
                            k% = 0
                            For i3% = 1 To 4
                                If feld%(blockx%(i3%) + 1, blocky%(i3%)) <> belegt% Then k% = k% + 1
                            Next i3%
                            If k% = 4 Then
                                For i4% = 1 To 4
                                    blockx%(i4%) = blockx%(i4%) + 1
                                Next i4%
                            End If
                        Case Chr$(0) + "P", "5": t = t - 1
                        Case Chr$(0) + "D": Screen 0
                            ' TODO
                            Timer Off
                            Print "C:\DOS>"
                            Do
                                Locate 1, 8, 1
                            Loop While InKey$ = ""
                            Screen 12
                            alles
                            'PLAY ON
                        Case Chr$(0) + Chr$(133): Screen 0
                            ' TODO
                            Timer Off
                            Shell
                            Screen 12
                            alles
                            'PLAY ON
                        Case "s", "S"
                            Timer Off
                        Case "m", "M"
                            Timer On
                        Case Chr$(13), Chr$(0) + "H", "8", "+": drehen struktur%
                        Case Chr$(27): ausis: If endeundaus = 1 Then Exit Sub
                        Case "P", "p": grey: a$ = Input$(1): Palette
                        Case Chr$(0) + Chr$(59)
                            ' TODO
                            Timer Off
                            show.helpscreen
                            alles
                        Case "1", "2", "3", "4", "5", "6", "7", "8", "9"
                            If Val(a$) <= Musikanzahl Then
                                musi% = 0
                                Musikstueck% = Val(a$)
                            End If
                        Case "0": woswasi = verzug - .01
                        Case " ": If acid >= maxacid Then acidrain
                        Case "t": End
                    End Select

                    show.stone farbe%
                End If
                meanwhile


            Loop Until Timer >= t + verzug - woswasi

            check% = 0
            For m% = 1 To 4
                If feld%(blockx%(m%), blocky%(m%) + 1) = belegt% Then check% = 1: Exit For
            Next m%

            If check% = 1 Then Exit Do

            show.stone 0
            For i6% = 1 To 4
                blocky%(i6%) = blocky%(i6%) + 1
            Next i6%

        Loop

        woswasi = 0

        If yn(4) = 1 Then
            If acid <= maxacid Then acid = acid + acidplus
            show.acidometer
            punkte = punkte + 1
            Punktezahl
        End If

        check% = 0
        For i7% = 1 To 4
            farb%(blockx%(i7%), blocky%(i7%)) = farbe%
            feld%(blockx%(i7%), blocky%(i7%)) = belegt%
        Next i7%

        reichweite = Int(Rnd * (3)) + 1 'Bombe knallt auf

        If bomb Then
            bomb = 0
            For y% = -reichweite + blocky%(1) To reichweite + blocky%(1)
                For x% = -reichweite + blockx%(1) To reichweite + blockx%(1)
                    If x% > 0 And x% <= fb And y% <= fh Then
                        feld%(x%, y%) = Frei%
                        farb%(x%, y%) = 0
                        kastl x%, y%, 44
                    End If
                Next x%
            Next y%

            t = Timer
            Do
            Loop Until Timer >= t + .3

            For y% = -reichweite + blocky%(1) To reichweite + blocky%(1)
                For x% = -reichweite + blockx%(1) To reichweite + blockx%(1)
                    If x% > 0 And x% <= fb And y% <= fh Then
                        kastl x%, y%, 0
                    End If
                Next x%
            Next y%

        End If

        For I% = 1 To 4
            hoho%(I%) = 0
        Next I%
        j% = 0

        For y% = 1 To fh
            For x% = 1 To fb
                If feld%(x%, y%) = Frei% Then Exit For
                If x% = fb Then

                    For I% = 1 To fb
                        kastl I%, y%, 0
                    Next I%
                    j% = j% + 1
                    hoho%(j%) = y%
                End If
            Next x%
        Next y%

        If j% > 0 Then
            tim = Timer: Do: Loop Until Timer >= tim + .1

            For l% = 1 To j%
                For I% = 1 To fb
                    kastl I%, hoho%(l%), 15
                Next I%
            Next l%

            tim = Timer: Do: Loop Until Timer >= tim + .5



            For l% = 1 To j%
                For iy% = hoho%(l%) To 2 Step -1
                    For ix% = 1 To fb
                        feld%(ix%, iy%) = feld%(ix%, iy% - 1)
                        farb%(ix%, iy%) = farb%(ix%, iy% - 1)
                    Next ix%
                Next iy%
            Next l%

            check% = j%
            Linienweg = Linienweg + j%

            punkte = punkte + linienpunkte * j%


            If Int(Linienweg / 10) <> Int((Linienweg - j%) / 10) Then
                Level = Level + 1
                verzug = verzug - verzugplus
            End If

            nichtganzalles

        End If


        If check% > 0 Then
            punkte = punkte + (check% - 1) * (linienpunkte / 4 * 3)
            Punktezahl
        End If

        _Limit 60
    Loop

End Sub

Sub meanwhile

    If Timer >= helilt + .2 And yn(3) = 1 Then

        If helion Then
            heli
        Else
            If Int(Rnd * (40)) = 5 And blowheli = 0 Then
                helion = 1
                heliy = 1
                If heliy <= 1 Then heliy = 1
                show.heli 1

                helilt = Timer
            Else
                helilt = Timer

            End If
        End If

    End If

    If Timer >= maxlt + .1 And yn(3) = 1 Then

        If paraon Then kastl maxposx, maxposy - 1, farb%(maxposx, maxposy - 1)
        kastl maxposx, maxposy, farb%(maxposx, maxposy)

        I% = Int(Rnd * (3)) - 1
        If I% = 0 Then m = maxstill

        chk1% = 1
        chk2% = 1
        chk3% = 1

        For u% = 1 To 4
            If blockx%(u%) = maxposx And blocky%(u%) = maxposy + 1 Then chk1% = 0
            If blockx%(u%) = maxposx + I% And blocky%(u%) = maxposy Then chk2% = 0
            If blockx%(u%) = maxposx + I% And blocky%(u%) = maxposy - 1 Then chk3% = 0
        Next u%

        If feld%(maxposx, maxposy + 1) = Frei% And chk1% Then
            maxposy = maxposy + 1
            maxframe = 2
            maxstill = 0
            If feld%(maxposx, maxposy + 1) = Frei% And feld%(maxposx, maxposy + 2) = Frei% And maxposy < fh Then paraon = 1
        Else
   
            paraon = 0
            maxframe = 1

            If feld%(maxposx + I%, maxposy) = Frei% And chk2% Then
                maxposx = maxposx + I%
                maxstill = 0
            Else
                If feld%(maxposx + I%, maxposy - 1) = Frei% And chk3% Then
                    maxposx = maxposx + I%
                    maxposy = maxposy - 1
                    maxstill = 0
                Else
                    maxstill = maxstill + 1
                End If
            End If

        End If

        If maxposx = 0 Then maxposx = 2
        If maxposx = fb + 1 Then maxposx = fb - 1

        If maxstill > 15 Then
            If maxframe = 1 Then
                maxframe = 2
            Else
                maxframe = 1
            End If
            maxstill = 15
        End If

        If I% = 0 Then maxstill = m

        kastl maxposx, maxposy, 55
        maxlt = Timer
    End If

    If blowheli > 0 Then
        kastl helix, heliy, 44
        kastl helix + 1, heliy, 44
        blowheli = blowheli + 1
    End If

    If blowheli = 200 Then
        blowheli = 0
        chk1% = 1
        chk2% = 1

        If chk1% Then kastl helix, heliy, farb%(helix, heliy)
        If chk2% Then kastl helix + 1, heliy, farb%(helix + 1, heliy)

        helix = Int(Rnd * (fb - 1)) + 1
        If helix >= (fb / 2) Then
            helix = 1
        Else
            helix = fb - 1
        End If
    End If
End Sub

Sub menu
    Dim s$(5)

    posit% = 1

    show.menu

    s$(1) = "   START   "
    s$(2) = "   SETUP   "
    s$(3) = "  READ ME  "
    s$(4) = " HIGHSCORE "
    s$(5) = "    END    "

    Do
        Color 5, 0
        For I% = 1 To 5
            Locate 16 + I%, 33: Print " "; s$(I%); " "
        Next I%

        Color 11, 9

        Locate 16 + posit%, 33: Print "["; s$(posit%); "]"

        gettaste z$, posit%, 5
        Select Case z$
            Case Chr$(13), " ", "5"
                Select Case posit%
                    Case 1: Exit Sub
                    Case 2: setup
                    Case 3: show.helpscreen: show.menu
                    Case 4: score = 0: Screen 12: showhiscore: show.menu
                    Case 5: ausss
                End Select
            Case Chr$(27): ausss
        End Select
    Loop
End Sub


Sub Musikladen
    If already = 0 Then
        For I% = 1 To Musikanzahl

            x% = 0
            Do
                x% = x% + 1
                Read a$
                Musik$(x%, I%) = a$
                If Musik$(x%, I%) = "MUSIKENDE" Then Exit Do
            Loop
            Musiklaenge(I%) = x% - 1
        Next I%
    End If

    Musikstueck% = Int(Rnd * (Musikanzahl)) + 1
    musi% = 1
    If nomusik = 0 Then Play "mb" + Musik$(musi%, Musikstueck%)
End Sub


Sub nextes
    For y% = 1 To 4
        For x% = 0 To 2
            kastl x% - 3, y%, 0
            kastl x% - 3, y%, 9
        Next x%
    Next y%

    If nstr% = 99 Then
        kastl blockx%(1) - fb / 2 - 3, 2, 20
    Else

        For I% = 1 To 4
            kastl blockx%(I%) - fb / 2 - 3, blocky%(I%), 10
        Next I%

    End If
End Sub

Sub nichtganzalles
    For I% = 0 To maxlinie - 1
        Line (320 - I% - fb * bg / 2, 240 - I% - fh * bg / 2 + bg)-(321 + I% + fb * bg / 2, 240 + I% + fh * bg / 2 + 1 + bg), Int(Rnd * (15)) + 1, B
    Next I%

    For x% = 1 To fb
        For y% = 1 To fh
            kastl x%, y%, farb%(x%, y%)
        Next y%
    Next x%

    If yn(4) = 1 Then
        show.acidometer
    End If
End Sub

Sub Punktezahl
    Locate 10, 10: Color 2: Print "Points..";
    Color 9: Print Str$(punkte)
    Locate 12, 10: Color 14: Print "Lines...";
    Color 11: Print Linienweg
    Locate 14, 10: Color 4: Print "LEVEL...";
    Color 8: Print Level
End Sub

Sub select.case (I%, ax%, ay%)
    Select Case I%
        Case 1: ax% = ax% + 1
        Case 2: ax% = ax% - 1
        Case 3: ay% = ay% + 1
        Case 4: ay% = ay% - 1
        Case 5: ax% = ax% - 1: ay% = ay% + 1
        Case 6: ax% = ax% + 1: ay% = ay% - 1
        Case 7: ax% = ax% - 1: ay% = ay% - 1
        Case 8: ax% = ax% + 1: ay% = ay% + 1
    End Select
End Sub

Sub setgrey (nr, value)
    setpal nr, value, value, value
End Sub

Sub setpal (nr, r, g, B)
    Out &H3C8, nr
    Out &H3C9, r
    Out &H3C9, g
    Out &H3C9, B
End Sub

Sub setup

    Color 5, 0
    For I% = 1 To 5
        Locate 16 + I%, 33: Print "             "
    Next I%

    max = 4

    Dim p(1 To max, 2) As String

    p(1, 0) = " MUSIC    "
    p(2, 0) = " BOMBS    "
    p(3, 0) = " ARMY     "
    p(4, 0) = " ACIDRAIN "

    p(1, 1) = "YES"
    p(2, 1) = " OF COURSE"
    p(3, 1) = " WAY COOL"
    p(4, 1) = " YEP"

    p(1, 2) = " NO"
    p(2, 2) = "BETTER NOT"
    p(3, 2) = "NO CHANCE"
    p(4, 2) = "NOPE"

    positi% = 1

    Do

        For I% = 1 To max
            Color 5, 0
            Locate 16 + I%, 29: Print " "; p(I%, 0); " "
            If yn(I%) = 1 Then Color 2, 0 Else Color 4, 0
            Locate 16 + I%, 51 - Len(p(I%, yn(I%))): Print " "; p(I%, yn(I%)); " "
        Next I%

        Color 5, 0
        Locate 18 + max, 37: Print "  BACK  "

        Color 11, 9
        If positi% = max + 1 Then
            Locate 18 + max, 37: Print "[ BACK ]"
        Else
            Locate 16 + positi%, 29: Print "["; p(positi%, 0); "]"
        End If

        gettaste z$, positi%, max + 1
        Select Case z$
            Case Chr$(13), " ", "5"
                If positi% = max + 1 Then
                    Exit Do
                Else
                    yn(positi%) = yn(positi%) + 1
                    If yn(positi%) = 3 Then yn(positi%) = 1
                End If
            Case Chr$(27): Exit Do
        End Select
    Loop

    For I% = 1 To max
        Color 0, 0
        Locate 16 + I%, 29: Print " "; p(I%, 0); " "
        Locate 16 + I%, 51 - Len(p(I%, yn(I%))): Print " "; p(I%, yn(I%)); " "
    Next I%

    Locate 18 + max, 37: Print "  BACK  "
End Sub

Sub show.acidometer
    x1% = ((320 - fb * bg / 2) + ((-3) * bg) + 1)
    x2% = ((320 - fb * bg / 2 - 1) + ((-1) * bg) + 1)
    y2% = ((240 - fh * bg / 2) + (fh + 1) * bg)
    y1% = y2% - maxacid


    If acid <= maxacid Or showallacid Then

        Line (x1% - 1, y1% - 1)-(x2% + 1, y2% + 1), 4, B
        Line (x1% - 2, y1% - 2)-(x2% + 2, y2% + 2), 4, B

        If acid = 0 Or showallacid Then Line (x1%, y1%)-(x2%, y2%), 0, BF
        If acid > 0 And acid <= maxacid Then
            Line (x1%, y2% - acid + 1)-(x2%, y2% - acid + 1 + acidplus), 1, BF
        End If

        If showallacid Then
            If acid < maxacid Then
                Line (x1%, y2%)-(x2%, y2% - acid + 1), 1, BF
            Else
                Line (x1%, y2%)-(x2%, y1%), 1, BF
            End If
        End If

        If acid = maxacid Or (acid > maxacid And showallacid) Then
            Line (x1% - 1, y1% - 1)-(x2% + 1, y2% + 1), 2, B
            Line (x1% - 2, y1% - 2)-(x2% + 2, y2% + 2), 2, B
        End If

    End If



End Sub

Sub show.bodycount
    show.font2 Str$(bc), 2, 0, 2, 360, 448
End Sub

Sub show.ffont (word$, fa, ax, ay)

    For I% = 1 To Len(word$)
        a$ = Mid$(word$, I%, 1)
        nr% = Asc(a$) - 64

        If nr% > 0 And nr% < 27 Then
            For y% = 1 To 19
                For x% = 1 To 19
                    If buch(nr%, x%, y%) = 1 Then
                        PSet (x% + ax + (I% - 1) * 19, y% + ay), fa
                    End If
                Next x%
            Next y%
        End If

    Next I%

End Sub

Sub show.font (word$, scale, bgc, fgc, xa, ya)
    For I% = 1 To Len(word$)
        nr = Asc(UCase$(Mid$(word$, I%, 1))) - 64
        If nr >= 1 And nr <= 26 Then

            For y% = 1 To 5
                For x% = 1 To 5
    
                    ax = ((I% - 1) * scale * 6 + (x% - 1) * scale + xa)
                    ay = ((y% - 1) * scale * 3 / 2 + ya)

                    If bst(nr, x%, y%) Then
                        col = fgc
                    Else
                        col = bgc
                    End If
                    Line (ax, ay)-Step(scale / 4, scale * 3 / 8), col, BF
                Next x%
            Next y%

        End If
    Next I%
End Sub

Sub show.font2 (word$, scale, bgc, fgc, xa, ya)

    For I% = 1 To Len(word$)
        nr = Asc(UCase$(Mid$(word$, I%, 1))) - 64

        If Val((Mid$(word$, I%, 1))) > 0 Then
            nr = Val((Mid$(word$, I%, 1))) + 30
        End If

        If Mid$(word$, I%, 1) = "0" Then nr = 30
        If Mid$(word$, I%, 1) = ":" Then nr = 40
        If Mid$(word$, I%, 1) = "-" Then nr = 41

        If nr >= 1 And nr <= 41 Then
            For y% = 1 To 5
                For x% = 1 To 5
   
                    ax = ((I% - 1) * scale * 6 + (x% - 1) * scale + xa)
                    ay = ((y% - 1) * scale * 3 / 2 + ya)

                    If bst(nr, x%, y%) Then
                        col = fgc
                    Else
                        col = bgc
                    End If
                    Line (ax, ay)-Step(scale * 2 / 3, scale), col, BF
                Next x%
            Next y%
 
        End If
    Next I%
End Sub

Sub show.heli (farbe%)
    If farbe% Then
        x1% = ((320 - fb * bg / 2) + ((helix - 1) * bg) + 1)
        y1% = ((240 - fh * bg / 2) + ((heliy) * bg) + 1)

        For y% = 2 To 14
            For x% = 1 To 14
                If hf1(x%, y%) > 0 Then
                    PSet (x% + x1% - 1, y% + y1% - 1), hf1(x%, y%)
                End If
                If hf2(x%, y%) > 0 Then
                    PSet (x% + x1% + 13, y% + y1% - 1), hf2(x%, y%)
                End If
            Next x%
        Next y%

        If rotor Then
            Line (x1% + 3, y1%)-Step(12, 0), 8
            Line -Step(12, 0), 7
            rotor = 0
        Else
            Line (x1% + 3, y1%)-Step(12, 0), 7
            Line -Step(12, 0), 8
            rotor = 1
        End If


    Else
        kastl helix, heliy, farb%(helix, heliy)
        kastl helix + 1, heliy, farb%(helix + 1, heliy)
    End If
End Sub

Sub show.helpscreen
    Screen 13

    Color 1
    For I = 1 To 255
        setpal I, 0, 0, 0
    Next I

    Locate 3, 1
    Print "Try to catch the soldier who's jumping"
    Print
    Print " around before the AH-64D Apache gets "
    Print
    Print Space$(14) + "him!!!!!!!"
    Locate 11, 2
    Print "If the ACID-O-METER is full press the"
    Print
    Print "   SPACE BAR to activate an acidrain"
    Print
    Print " which will eat away the highest stones."
    Locate 19, 1
    Print "Sometimes you can control a falling bomb"
    Print
    Print " with which you can destroy some stones."
    Locate 24, 1

    GoSub action

    setpal 1, 0, 0, 0
    Color 1

    u$ = ""
    For I% = 1 To 9
        u$ = u$ + " " + Chr$(1) + " " + Chr$(2)
    Next I%
    u$ = u$ + " " + Chr$(1)

    Print
    Print u$
    Print
    Print " If you think that this program is not"
    Print
    Print "   so bad, then please please please"
    Print
    Print "  write a postcard or a letter to me!!"
    Print
    Print "       I would be very happy! :-)"
    Print
    Print u$
    Print: Print
    Print "       …ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª"
    Print "       ∫   Dietmar MORITZ       ∫"
    Print "       ∫   Ungargasse 43        ∫"
    Print "       ∫   7350 Oberpullendorf  ∫"
    Print "       ∫     A U S T R I A      ∫"
    Print "       ∫      E U R O P E       ∫"
    Print "       »ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº"

    GoSub action
    Screen 12
    Exit Sub

    action:
    For y% = 0 To 200
        For x% = 0 To 320
            If Point(x%, y%) <> 0 Then
                c = Sqr((x% - 160) ^ 2 + (y% - 100) ^ 2)
                PSet (x%, y%), c
            End If
        Next x%
    Next y%

    Do
        w = w + .01
        For u = 1 To 255
            I = u / 35
            r = Abs(Sin(w + I + 4 * _Pi / 3) ^ 2 * 63)
            g = Abs(Sin(w + I + 2 * _Pi / 3) ^ 2 * 63)
            B = Abs(Sin(w + I) ^ 2 * 63)
            setpal u, r, g, B
        Next u
        _Limit 60
    Loop Until InKey$ <> ""
    Return

    Screen 12
End Sub

Sub show.menu
    Screen 0
    Cls

    Locate 3, 13
    Color 1
    Print "⁄ƒ         t h e     u n b e l i e v a b l e         ƒø"

    Print

    Color 2, 0

    Locate 5, 15: Print "       ‹‹‹   ‹‹         ‹‹‹            ‹‹          "
    Locate 6, 15: Print "      €   € ﬂ‹‹ﬂ       €   €          ﬂ‹‹ﬂ         "
    Locate 7, 15: Print "      €   €  ‹‹        €   €  ‹‹‹ ‹‹   ‹‹    ‹‹‹‹  "
    Locate 8, 15: Print " ‹ﬂﬂﬂﬂ    € €  €  ‹ﬂﬂﬂﬂ    € €   ﬂ  € €  € ‹ﬂ    ﬂ‹"
    Color 2, 0
    Locate 9, 15: Print "€         € €  € €         € €   ‹ﬂﬂ  €  € ﬂ‹  ﬂ‹‹ﬂ"
    Locate 10, 15: Print "€         € €  € €         € €  €     €  € ‹ﬂﬂ‹  ﬂ‹"
    Locate 11, 15: Print "ﬂ‹        € €  € ﬂ‹        € €  €     €  € ﬂ‹    ‹ﬂ"
    Locate 12, 15: Print "  ﬂﬂﬂﬂﬂﬂﬂﬂ   ﬂﬂ    ﬂﬂﬂﬂﬂﬂﬂﬂ   ﬂﬂ       ﬂﬂ    ﬂﬂﬂﬂ  "
    Print: Color 1, 0
    Print Spc(12); "¿ƒ                                                   ƒŸ"

End Sub

Sub show.stone (farbe%)
    For I% = 1 To 4
        kastl blockx%(I%), blocky%(I%), farbe%
        farb%(blockx%(I%), blocky%(I%)) = farbe%
    Next I%
End Sub

Sub show.verynicegraphic

    Screen 13

    fa = 14
    ast = 5
    smooth = 70
    v = .01

    Dim w As Double
    w = 1
    For u = 0 To 255
        I = u / 81
        r = Abs(Sin(w + I + 4 * _Pi / 3) * 63)
        g = Abs(Sin(w + I + 2 * _Pi / 3) * 63)
        B = Abs(Sin(w + I) * 63)

        setpal u, r, g, B

    Next u
    Color 1
    Locate 15, 8: Print "Programming:"
    Locate 16, 20: Print "Dietmar Moritz"
    Locate 18, 8: Print "Testing:"
    Locate 19, 20: Print "Dietmar Moritz"
    Locate 21, 8: Print "Graphics:"
    Locate 22, 20: Print "Dietmar Moritz"

    Draw "c251"
    Color 251

    Draw "bm20,80 u40 r 20 F30 d10 l30 u10 r13 h17 l3 d27 l13"
    Paint (23, 78), 252, 251

    Draw "c251 bm80,80 u40 r13 d40 l13"
    Paint (83, 78), 252, 251

    Draw "c251 bm105,80 u40 r 20 F30 d10 l30 u10 r13 h17 l3 d27 l13"
    Paint (108, 78), 252, 251

    Draw "c251 bm165,80 u40 r22"
    Line -Step(20, 15), 251
    Line -Step(-16, 10), 251
    Draw "f15 l13 h12 u7"
    Line -Step(9, -6), 251
    Line -Step(-8, -5), 251
    Draw "l4 d30 l12"
    Paint (167, 78), 252, 251

    Draw "c251 bm215,80 u40 r13 d40 l13"
    Paint (220, 78), 252, 251

    Draw "c251 bm240,80 u10 r23 e5 l27 u15 e10 r30 d10 l23 g5 r27 d15 g10 l30"
    Paint (243, 78), 252, 251


    For y% = 0 To 200
        For x% = 0 To 160
            a = Sqr(((x% - 160)) ^ 2 + (y% - 100) ^ 2)

            If x% <> 160 Then
                w = Atn((y% - 100) / (x% - 160))
            Else
                w = Atn((y% - 100) / (.1))
            End If

            c = Sin(a / fa) ^ 2 * smooth + (w * ast) * 81.5
            c = c Mod 256

            If InKey$ = Chr$(27) Then Screen 12: Exit Sub

            Select Case Point(x%, y%)
                Case 251: PSet (x%, y%), c + 128
                Case 252: PSet (x%, y%), c + 80
                Case 1: PSet (x%, y%), c + 50
                Case Else: PSet (x%, y%), c
            End Select

            If x% < 160 Then
                Select Case Point(320 - x%, 200 - y%)
                    Case 251: PSet (320 - x%, 200 - y%), c + 128
                    Case 252: PSet (320 - x%, 200 - y%), c + 80
                    Case 1: PSet (320 - x%, 200 - y%), c + 50
                    Case Else: PSet (320 - x%, 200 - y%), c
                End Select
            End If

        Next x%
    Next y%

    w = 1
    Do
        w = w + v
        For u = 0 To 255
            I = u / 81
            r = Abs(Sin(w + I + 4 * _Pi / 3) * 63)
            g = Abs(Sin(w + I + 2 * _Pi / 3) * 63)
            B = Abs(Sin(w + I) * 63)
            setpal u, r, g, B
        Next u
        _Limit 60
    Loop Until InKey$ <> ""

    Screen 12
End Sub

Sub showhiscore
    Palette
    Dim n$(10)
    Dim s(10)
    Cls

    score = punkte

    On Error GoTo keine

    Open "I", #1, "didris.hsc"

    If h = 0 Then

        For I% = 1 To 10
            If EOF(1) Then GoTo weiter
            Input #1, n$(I%)
            Input #1, s(I%)
        Next I%
    End If

    weiter:
    Close #1

    Color 6
    setpal 6, 10, 43, 63
    For I% = 1 To 10
        If score > s(I%) Then
            Locate 10, 30: Input "Name: ", name$
            If Len(name$) > 12 Then name$ = Left$(name$, 12)
            If name$ = "" Then name$ = "anonymous"
            For u% = 9 To I% Step -1
                n$(u% + 1) = n$(u%)
                s(u% + 1) = s(u%)
            Next u%
            n$(I%) = name$
            s(I%) = score
            position% = I%
            Exit For
        End If
    Next I%

    Cls

    For I = 0 To 15
        setpal I, 0, 0, 0
    Next I

    For x% = 0 To 82
        For y% = 0 To 82
            c = Int(Rnd * (5)) + 1
            PSet (x%, y%), c
        Next y%
    Next x%

    For x% = 0 To 80
        For y% = 0 To 80
            c = Point(x%, y%) + Point(x% + 1, y%) + Point(x%, y% + 1) + Point(x% - 1, y%) + Point(x%, y% - 1)
            PSet (x%, y%), c / 5
        Next y%
    Next x%

    Dim hh(2000) As Integer
    Get (1, 1)-(80, 80), hh()

    For y% = 0 To 480 Step 80
        For x% = 0 To 640 Step 80
            Put (x%, y%), hh(), PSet
        Next x%
    Next y%

    ax = 177
    ay = 50
    bx = 390 + Int(Len(Str$(s(1))) / 2) * 9 * 2
    by = 430

    Line (ax, ay)-(bx, by), 0, BF
    Line (ax, ay)-(bx, by), 7, B

    setpal 0, 20, 20, 20
    setpal 1, 0, 0, 20
    setpal 2, 0, 0, 31
    setpal 3, 0, 0, 42
    setpal 4, 0, 0, 53
    setpal 5, 0, 0, 63
    setpal 7, 20, 20, 20
    setpal 8, 22, 22, 22
    setpal 9, 18, 18, 18
    setpal 10, 16, 16, 16
    setpal 11, 24, 24, 24
    setpal 12, 10, 10, 10
    setpal 13, 5, 5, 5
    setpal 15, 0, 0, 0

    Color 7

    Line (171, 44)-(bx + 6, 44)
    Line -(bx, ay)
    Line (171, 44)-(171, 436)
    Line -(ax, by)
    Paint (175, ay), 11, 7
    Line (ax, ay)-(171, 44)

    Line (171, 436)-(bx + 6, 436)
    Line -(bx + 6, 44)
    Paint (bx + 2, by), 12, 7
    Line (bx + 6, 436)-(bx, by), 13

    Line (171, 44)-(bx + 6, 436), 15, B

    Color 6
    setpal 6, 10, 43, 63
    For I% = 1 To 10
        Locate I% * 2 + 6, 30
        If s(I%) > 0 Then
            Print n$(I%), s(I%)
        End If
    Next I%

    Locate 5, 25 + Int(Len(Str$(s(1))) / 2)
    Color 1: Print "-";
    Color 2: Print "=";
    Color 3: Print " H I ";
    Color 4: Print "G H ";
    Color 5: Print "S ";
    Color 4: Print "C O ";
    Color 3: Print "R E ";
    Color 2: Print "=";
    Color 1: Print "-";

    If position% > 0 Then
        Locate position% * 2 + 6, 30
        Color 14
        Print name$, punkte
    End If

    For I% = 1 To 100
        x% = Int(Rnd * (bx - ax)) + ax
        y% = Int(Rnd * (by - ay)) + ay
        c% = Int(Rnd * (5)) + 8
        For u% = 1 To 20
            x% = Int(Rnd * (3)) + x% - 1
            y% = Int(Rnd * (3)) + y% - 1
            If Point(x%, y%) = 0 Then PSet (x%, y%), c%
        Next u%
    Next I%

    Open "O", #1, "didris.hsc"
    For I% = 1 To 10
        Print #1, n$(I%)
        Print #1, s(I%)
    Next I%
    Close #1

    Do
        x = x + .01
        c1 = Abs(Int(Sin(x) * 63))
        c2 = Abs(Int(Sin(x + 2 * _Pi / 3) * 63))
        c3 = Abs(Int(Sin(x + 4 * _Pi / 3) * 63))
        setpal 14, c1, c2, c3
        Wait &H3DA, 8
    Loop Until InKey$ <> ""

End Sub

Sub showpoints
    For I% = 2 To 0 Step -1
        Line (320 - (130 + I% * 10), 240 - (50 + I% * 10))-(320 + (130 + I% * 10), 190 + (50 + I% * 10)), I% + 11, BF
        Line (320 - 120, 240 - 40)-(320 + 120, 190 + 40), 0, BF
    Next I%
    Color 14
    Locate 14, 40 - Int((7 + Len(Str$(punkte))) / 2)
    Print "SCORE: " + Str$(punkte)

    Do
        x = x + .009
        c1 = Abs(Int(Sin(x) * 63))
        c2 = Abs(Int(Sin(x + 2 * _Pi / 3) * 63)) * 256
        c3 = Abs(Int(Sin(x + 4 * _Pi / 3) * 63)) * 256 ^ 2
        Palette 11, c1 + c2
        Palette 12, c1 + c3
        Palette 13, c2 + c3
        Palette 14, c1 + c2 + c3
    Loop Until InKey$ = Chr$(13)
End Sub

Sub strukturstart (struktur%)
    Select Case struktur%
        Case 1
            blockx%(1) = Int(fb / 2) + 1
            blocky%(1) = 2
            blockx%(2) = blockx%(1)
            blocky%(2) = 1
            blockx%(3) = blockx%(1) - 1
            blocky%(3) = 2
            blockx%(4) = blockx%(1) + 1
            blocky%(4) = 2
        Case 2
            blockx%(1) = Int(fb / 2)
            blocky%(1) = 1
            blockx%(2) = blockx%(1)
            blocky%(2) = 2
            blockx%(3) = blockx%(1) + 1
            blocky%(3) = 1
            blockx%(4) = blockx%(1) + 1
            blocky%(4) = 2
        Case 3
            blockx%(1) = Int(fb / 2) + 1
            blocky%(1) = 1
            blockx%(2) = blockx%(1) + 1
            blocky%(2) = 1
            blockx%(3) = blockx%(1) - 1
            blocky%(3) = 2
            blockx%(4) = blockx%(1)
            blocky%(4) = 2
        Case 4
            blockx%(1) = Int(fb / 2)
            blocky%(1) = 1
            blockx%(2) = blockx%(1) + 1
            blocky%(2) = 1
            blockx%(3) = blockx%(2) + 1
            blocky%(3) = 2
            blockx%(4) = blockx%(2)
            blocky%(4) = 2
        Case 5
            blockx%(1) = Int(fb / 2)
            blocky%(1) = 2
            blockx%(2) = blockx%(1)
            blocky%(2) = 1
            blockx%(3) = blockx%(1) + 1
            blocky%(3) = 1
            blockx%(4) = blockx%(1)
            blocky%(4) = 3
        Case 6
            blockx%(1) = Int(fb / 2) + 1
            blocky%(1) = 2
            blockx%(2) = blockx%(1)
            blocky%(2) = 1
            blockx%(3) = blockx%(1) - 1
            blocky%(3) = 1
            blockx%(4) = blockx%(1)
            blocky%(4) = 3
        Case 7
            blockx%(1) = Int(fb / 2) + 1
            blocky%(1) = 2
            blockx%(2) = blockx%(1)
            blocky%(2) = 1
            blockx%(3) = blockx%(1)
            blocky%(3) = 3
            blockx%(4) = blockx%(1)
            blocky%(4) = 4
        Case 99
            blockx%(1) = Int(fb / 2) + 1
            blocky%(1) = 1
            blockx%(2) = blockx%(1)
            blocky%(2) = 1
            blockx%(3) = blockx%(1)
            blocky%(3) = 1
            blockx%(4) = blockx%(1)
            blocky%(4) = 1
    End Select

    For I% = 1 To 4
        If feld%(blockx%(I%), blocky%(I%)) = belegt% Then
            farb% = Int(Rnd * (15)) + 1
            For i2% = 1 To 4
                kastl blockx%(i2%), blocky%(i2%), farb%
            Next i2%
            ausis
            Exit Sub
        End If
    Next I%
End Sub

Sub Tasten
    Dim a$(15)
    a$(1) = "Left......... Left      "
    a$(2) = "Right........ Right     "
    a$(3) = "Rotate....... Up / Enter"
    a$(4) = "Drop......... Down / 0  "
    a$(5) = "Acidrain..... Space bar "
    a$(7) = "Music on/off. m / s"
    a$(8) = "Music #1..... 1    "
    a$(9) = "Music #2..... 2    "
    a$(10) = "Music #3..... 3    "
    a$(12) = "Info......... F1 "
    a$(13) = "Pause........ p  "
    a$(14) = "Boss Key..... F10"
    a$(15) = "End.......... ESC"


    If yn(1) = 2 Then
        For I% = 7 To 10
            a$(I%) = a$(I% + 5)
            a$(I% + 5) = ""
        Next I%
    End If

    If yn(4) = 2 Then
        For I% = 5 To 14
            a$(I%) = a$(I% + 1)
            a$(15) = ""
        Next I%
    End If

    For I% = 1 To 15
        For x% = 1 To Len(a$(I%)) Step 2
            Locate 7 + I%, 54 + x%: Color Int(Rnd * (15)) + 1: Print Mid$(a$(I%), x%, 2)
        Next x%
    Next I%
End Sub

Sub Titel
    Palette
    a$ = "DIDI's"
    B$ = "DIDRIS"
    c$ = "1 9 9 8"

    zx = 320
    zy = 240
    zz = 60
    h = 5
    f = 5
    ff = 0
    fff = 100

    For ii% = 1 To 3
        Select Case ii%
            Case 1: xx$ = a$
            Case 2: xx$ = B$
            Case 3: xx$ = c$
        End Select
        Locate 1, 1: Print xx$ + "  "
        For y% = 1 To 15
            For I% = 1 To Len(xx$) * 8
                If Point(I%, y%) > 0 Then
                    farb% = Int(Rnd * (15)) + 1
                    Line (fax(320 - Len(xx$) * 20 + I% * 40 / 8, 0, zx, zz), fay(y% * f - ff + ii% * fff, 0, zy, zz))-(fax(320 - Len(xx$) * 20 + I% * 40 / 8, h, zx, zz), fay(y% * f - ff + ii% * fff, h, zy, zz)), farb%
                End If
            Next I%
        Next y%
    Next ii%
    Locate 1, 1: Print "                    "
    t = Timer
    Do
        x = x + .01
        c1 = Abs(Int(Sin(x) * 63))
        c2 = Abs(Int(Sin(x + 2 * _Pi / 3) * 63)) * 256
        c3 = Abs(Int(Sin(x + 4 * _Pi / 3) * 63)) * 256 ^ 2
        c4 = Abs(Int(Cos(x) * 63))
        c5 = Abs(Int(Cos(x + 2 * _Pi / 3) * 63)) * 256
        c6 = Abs(Int(Cos(x + 4 * _Pi / 3) * 63)) * 256 ^ 2
        Palette 7, c4 + c5
        Palette 8, c4 + c6
        Palette 9, c5 + c6
        Palette 10, c4 + c5 + c6
        Palette 11, c1 + c2
        Palette 12, c1 + c3
        Palette 13, c2 + c3
        Palette 14, c1 + c2 + c3
        z$ = InKey$
        _Limit 60
    Loop Until z$ <> "" Or Timer >= t + 15
    If UCase$(z$) = "M" Then yn(1) = 2

    Dim verz(3000)

    fa = 40
    fa2 = 2
    t = Timer
    Do
        x = Int(Rnd * (530 - fa)) + 100
        y = Int(Rnd * (370 - fa)) + 70
        Get (x, y)-(x + fa, y + fa), verz()
        Put (x, y + fa2), verz(), PSet
        z$ = InKey$
        Wait &H3DA, 8
    Loop Until z$ <> "" Or Timer >= t + 20

    If UCase$(z$) = "M" Then yn(1) = 2

    Palette
End Sub

