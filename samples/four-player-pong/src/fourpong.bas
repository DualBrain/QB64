$NoPrefix
DefLng A-Z
$Resize:Smooth

Screen 12
FullScreen SquarePixels , Smooth

Randomize Timer
GoSub GameTitle
Width 80, 60
Dim tx(2 To 16) As Integer
Dim ty(2 To 16) As Integer
Dim itemx(1, 15) As Integer
Dim itemy(1, 15) As Integer
Dim demoitemx(1, 15) As Integer
Dim demoitemy(1, 15) As Integer
Dim symbolx(1 To 30) As Integer
Dim symboly(1 To 30) As Integer
Dim symbolt(1 To 30) As Integer
Dim symbolc(1 To 30) As Integer
Dim stime(1 To 30) As Integer
For i = 1 To 15
    demoitemx(1, i) = Int(Rnd * 74) + 14
    demoitemy(1, i) = Int(Rnd * 74) + 14
Next i
speed& = 1
pad& = 1
scoret& = 4
max& = 100
dir& = 1
it1& = 1
it2& = 1
it3& = 1
it4& = 1
it5& = 1
it6& = 1
it7& = 1
it8& = 1
ballx& = 50
bally& = 10
ballxs& = Int(Rnd * 2) + 1
ballys& = Int(Rnd * 2) + 1
pad1& = 50
pad2& = 50
pad3& = 50
pad4& = 50
p1& = 1
p2& = 1
p3& = 1
p4& = 1
co& = 1
items& = 1
it& = 15
GoTo start
new:
x& = 240
y& = 240
xs& = 0
ys& = 0
a& = speed&
If p1& = 0 Then ly1& = 57 Else ly1& = 1
If p2& = 0 Then lx1& = 57 Else lx1& = 1
If p3& = 0 Then ly2& = 423 Else ly2& = 479
If p4& = 0 Then lx2& = 423 Else lx2& = 479
started& = 1
If items& = 0 Then it& = 0
If p1& = 7 Then p1& = Int(Rnd * 5) + 2
If p2& = 7 Then p2& = Int(Rnd * 5) + 2
If p3& = 7 Then p3& = Int(Rnd * 5) + 2
If p4& = 7 Then p4& = Int(Rnd * 5) + 2
p1hyper& = 0
p2hyper& = 0
p3hyper& = 0
p4hyper& = 0
p1descore& = 0
p2descore& = 0
p3descore& = 0
p4descore& = 0
If scoret& = 3 Or scoret& = 6 Then
    p1descore& = max&
    p2descore& = max&
    p3descore& = max&
    p4descore& = max&
End If
If p1& = 0 Then p1descore& = -2000000000
If p2& = 0 Then p2descore& = -2000000000
If p3& = 0 Then p3descore& = -2000000000
If p4& = 0 Then p4descore& = -2000000000
p1score& = p1descore&
p2score& = p2descore&
p3score& = p3descore&
p4score& = p4descore&
p1des& = 240
p2des& = 240
p3des& = 240
p4des& = 240
p1pad& = 240
p2pad& = 240
p3pad& = 240
p4pad& = 240
p1size& = 0
p2size& = 0
p3size& = 0
p4size& = 0
p1desize& = 25
p2desize& = 25
p3desize& = 25
p4desize& = 25
p1dir& = 0
p2dir& = 0
p3dir& = 0
p4dir& = 0
p1scores& = 0
p2scores& = 0
p3scores& = 0
p4scores& = 0
p1speed& = pad& * 7
p2speed& = pad& * 7
p3speed& = pad& * 7
p4speed& = pad& * 7
center& = 0
serve& = 5
colo& = Int(Rnd * 5) + 1
For i = 1 To it&
    itemx(1, i) = Int(Rnd * 340) + 70
    itemy(1, i) = Int(Rnd * 340) + 70
Next i
retrylast:
lasthit& = Int(Rnd * 4) + 1
If lasthit& = 1 And p1& = 0 Then GoTo retrylast
If lasthit& = 2 And p2& = 0 Then GoTo retrylast
If lasthit& = 3 And p3& = 0 Then GoTo retrylast
If lasthit& = 4 And p4& = 0 Then GoTo retrylast
finished& = 0
subtract& = 0
startedd& = Timer
For i = 1 To 30
    stime(i) = 0
Next i
restart:
Cls
If p1& > 1 Then p1com& = 1 Else p1com& = 0
If p1& > 1 Then p1ac& = (6 - p1&) * 20
If p1& > 1 Then p1ai& = p1& * 80
If p2& > 1 Then p2com& = 1 Else p2com& = 0
If p2& > 1 Then p2ac& = (6 - p2&) * 20
If p2& > 1 Then p2ai& = p2& * 80
If p3& > 1 Then p3com& = 1 Else p3com& = 0
If p3& > 1 Then p3ac& = (6 - p3&) * 20
If p3& > 1 Then p3ai& = p3& * 80
If p4& > 1 Then p4com& = 1 Else p4com& = 0
If p4& > 1 Then p4ac& = (6 - p4&) * 20
If p4& > 1 Then p4ai& = p4& * 80
GoSub draww
scombo& = 0
Cls
View Screen(lx1&, ly1&)-(lx2&, ly2&)
Do

    'IF GameDelay& < 0 THEN GameDelay& = 0
    'FOR i = 1 TO GameDelay&
    'NEXT i
    Delay 0.03 + GameDelay& / 10000


    finished& = Timer
    If max& > 0 And (scoret& = 3 Or scoret& = 6) Then
        If p1& > 0 Then players& = players& + 1
        If p2& > 0 Then players& = players& + 1
        If p3& > 0 Then players& = players& + 1
        If p4& > 0 Then players& = players& + 1
        If p1descore& < 1 And p1& > 0 Then
            p1& = 0
            p1descore& = -players&
            ly1& = 57
            serve& = 5
            GoSub centerserve
            View
            Cls
            GoSub draww
        ElseIf p2descore& < 1 And p2& > 0 Then
            p2& = 0
            p2descore& = -players&
            lx1& = 57
            serve& = 5
            GoSub centerserve
            View
            Cls
            GoSub draww
        ElseIf p3descore& < 1 And p3& > 0 Then
            p3& = 0
            p3descore& = -players&
            ly2& = 423
            serve& = 5
            GoSub centerserve
            View
            Cls
            GoSub draww
        ElseIf p4descore& < 1 And p4& > 0 Then
            p4& = 0
            p4descore& = -players&
            lx2& = 423
            serve& = 5
            GoSub centerserve
            View
            Cls
            GoSub draww
        End If
        If players& = 1 Then GoTo theend
        players& = 0
    Else
        If (p1descore& > max& - 1 Or p2descore& > max& - 1 Or p3descore& > max& - 1 Or p4descore& > max& - 1) And max& > 0 Then GoTo theend
    End If
    If p1score& <> p1descore& And p1& > 0 Then
        For i = 1 To CLng(Abs(p1descore& - p1score&) / 10) + 1
            If p1descore& - p1score& > 0 Then p1score& = p1score& + 1
            If p1descore& - p1score& < 0 Then p1score& = p1score& - 1
        Next i
        Sound 1000, .1
        GoSub draww
    ElseIf p2score& <> p2descore& And p2& > 0 Then
        For i = 1 To CLng(Abs(p2descore& - p2score&) / 10) + 1
            If p2descore& - p2score& > 0 Then p2score& = p2score& + 1
            If p2descore& - p2score& < 0 Then p2score& = p2score& - 1
        Next i
        Sound 1000, .1
        GoSub draww
    ElseIf p3score& <> p3descore& And p3& > 0 Then
        For i = 1 To CLng(Abs(p3descore& - p3score&) / 10) + 1
            If p3descore& - p3score& > 0 Then p3score& = p3score& + 1
            If p3descore& - p3score& < 0 Then p3score& = p3score& - 1
        Next i
        Sound 1000, .1
        GoSub draww
    ElseIf p4score& <> p4descore& And p4& > 0 Then
        For i = 1 To CLng(Abs(p4descore& - p4score&) / 10) + 1
            If p4descore& - p4score& > 0 Then p4score& = p4score& + 1
            If p4descore& - p4score& < 0 Then p4score& = p4score& - 1
        Next i
        Sound 1000, .1
        GoSub draww
    End If

    If p1size& > p1desize& Then p1size& = p1size& - 1
    If p1size& < p1desize& Then p1size& = p1size& + 1
    If p2size& > p2desize& Then p2size& = p2size& - 1
    If p2size& < p2desize& Then p2size& = p2size& + 1
    If p3size& > p3desize& Then p3size& = p3size& - 1
    If p3size& < p3desize& Then p3size& = p3size& + 1
    If p4size& > p4desize& Then p4size& = p4size& - 1
    If p4size& < p4desize& Then p4size& = p4size& + 1

    If scombo& > -1 Then
        If scombo& > 0 Then Color 3 Else Color 0
        Locate 30, 30: Print combo&
        scombo& = scombo& - 1
    End If

    If Abs(xs&) < 8 And Abs(ys&) < 8 And serve& = 0 Then
        If Abs(xs&) > Abs(ys&) Then
            If xs& > 0 Then
                If ys& > 0 Then ys& = ys& + (8 / xs&)
                If ys& < 0 Then ys& = ys& - xs&
                xs& = 8
            ElseIf xs& < 0 Then
                If ys& > 0 Then ys& = ys& + (8 / Abs(xs&))
                If ys& < 0 Then ys& = ys& - (8 / Abs(xs&))
                xs& = -8
            End If
        ElseIf Abs(xs&) < Abs(ys&) Then
            If ys& > 0 Then
                If xs& > 0 Then xs& = xs& + (8 / ys&)
                If xs& < 0 Then xs& = xs& - (8 / ys&)
                ys& = 8
            ElseIf ys& < 0 Then
                If xs& > 0 Then xs& = xs& + (8 / Abs(ys&))
                If xs& < 0 Then xs& = xs& - (8 / Abs(ys&))
                ys& = -8
            End If
        ElseIf Abs(xs&) = Abs(ys&) And xs& <> 0 Then
            If xs& > 0 Then xs& = 8
            If xs& < 0 Then xs& = -8
            If ys& > 0 Then ys& = 8
            If ys& < 0 Then ys& = -8
        End If
    End If

    For ba = 1 To a&

        If x& < 65 And xs& = 0 Then xs& = -1
        If x& > 415 And xs& = 0 Then xs& = 1
        If y& < 65 And ys& = 0 Then ys& = -1
        If y& > 415 And ys& = 0 Then ys& = 1

        If serve& = 1 Then
            x& = p1pad&
            y& = 13
        ElseIf serve& = 2 Then
            x& = 13
            y& = p2pad&
        ElseIf serve& = 3 Then
            x& = p3pad&
            y& = 467
        ElseIf serve& = 4 Then
            x& = 467
            y& = p4pad&
        End If

        If serve& > 0 Then xs& = 0
        If serve& > 0 Then ys& = 0

        x& = x& + xs&
        y& = y& + ys&

        If x& < 60 And y& < 60 And p1& > 0 And p2& > 0 Then
            For i = 1 To 60
                If (x& - 3) < i And y& - 3 < (60 - i) Then
                    Swap xs&, ys&
                    xs& = -xs&
                    ys& = -ys&
                    If Abs(xs&) = Abs(ys&) Then xs& = xs& + 1
                    x& = i + 3
                    y& = 63 - i
                    Sound 750, .1
                End If
            Next i
        End If
        If x& < 60 And y& > 420 And p2& > 0 And p3& > 0 Then
            For i = 1 To 60
                If (x& - 3) < i And (y& + 3) > (420 + i) Then
                    Swap xs&, ys&
                    If Abs(xs&) = Abs(ys&) Then xs& = xs& + 1
                    x& = i + 3
                    y& = 417 + i
                    Sound 750, .1
                End If
            Next i
        End If
        If x& > 420 And y& < 60 And p4& > 0 And p1& > 0 Then
            For i = 1 To 60
                If (x& + 3) > (480 - i) And (y& - 3) < (60 - i) Then
                    Swap xs&, ys&
                    If Abs(xs&) = Abs(ys&) Then xs& = xs& + 1
                    x& = 477 - i
                    y& = 63 - i
                    Sound 750, .1
                End If
            Next i
        End If
        If x& > 420 And y& > 420 And p3& > 0 And p4& > 0 Then
            For i = 1 To 60
                If (x& + 3) > (480 - i) And (y& + 3) > (420 + i) Then
                    Swap xs&, ys&
                    xs& = -xs&
                    ys& = -ys&
                    If Abs(xs&) = Abs(ys&) Then xs& = xs& + 1
                    x& = 477 - i
                    y& = 417 + i
                    Sound 750, .1
                End If
            Next i
        End If
        If countdown& > 0 Then countdown& = countdown& - 1
        For i = 1 To it&
            If it1& = 0 And it2& = 0 And it3& = 0 And it4& = 0 And it5& = 0 And it6& = 0 And it7& = 0 And it8& = 0 Then Exit For
            If x& < itemx(1, i) + 9 And x& > itemx(1, i) - 9 And y& < itemy(1, i) + 9 And y& > itemy(1, i) - 9 Then
                If hit& = i And countdown& > 0 Then GoTo endder
                hit& = i
                countdown& = 20
                GoSub item
            End If
            endder:
        Next i
        If y& < 60 And p1& = 0 Then
            ys& = -ys&
            If ys& = 0 Then ys& = 1
            y& = 60
            Sound 500, .1
        ElseIf x& < 60 And p2& = 0 Then
            xs& = -xs&
            If xs& = 0 Then xs& = 1
            x& = 60
            Sound 500, .1
        ElseIf y& > 420 And p3& = 0 Then
            ys& = -ys&
            If ys& = 0 Then ys& = -1
            y& = 420
            Sound 500, .1
        ElseIf x& > 420 And p4& = 0 Then
            xs& = -xs&
            If xs& = 0 Then xs& = -1
            x& = 420
            Sound 500, .1
        End If
        If y& < 8 And ((x& > (p1pad& - p1size&) And x& < (p1pad& + p1size&)) Or p1hyper& > 0) Then
            ys& = Int(Rnd * 8) + 1
            If xs& = 0 Then xs& = Int(Rnd * 17) - 8
            lasthit& = 1
            If p1hyper& = 1 Then p1hyper& = 0
            y& = 8
            GoSub universal
        ElseIf x& < 8 And ((y& > (p2pad& - p2size&) And y& < (p2pad& + p2size&)) Or p2hyper& > 0) Then
            xs& = Int(Rnd * 8) + 1
            If ys& = 0 Then ys& = Int(Rnd * 17) - 8
            lasthit& = 2
            If p2hyper& = 1 Then p2hyper& = 0
            x& = 8
            GoSub universal
        ElseIf y& > 472 And ((x& > (p3pad& - p3size&) And x& < (p3pad& + p3size&)) Or p3hyper& > 0) Then
            ys& = -(Int(Rnd * 8) + 1)
            If xs& = 0 Then xs& = Int(Rnd * 17) - 8
            lasthit& = 3
            If p3hyper& = 1 Then p3hyper& = 0
            y& = 472
            GoSub universal
        ElseIf x& > 472 And ((y& > (p4pad& - p4size&) And y& < (p4pad& + p4size&)) Or p4hyper& > 0) Then
            xs& = -(Int(Rnd * 8) + 1)
            If ys& = 0 Then ys& = Int(Rnd * 17) - 8
            lasthit& = 4
            If p4hyper& = 1 Then p4hyper& = 0
            x& = 472
            GoSub universal
        End If
        If y& < 0 And p1& > 0 Then GoSub score1
        If x& < 0 And p2& > 0 Then GoSub score2
        If y& > 480 And p3& > 0 Then GoSub score3
        If x& > 480 And p4& > 0 Then GoSub score4
    Next ba

    PSet (tx(16), ty(16)), 0
    PSet (tx(15), ty(15)), 8
    PSet (tx(14), ty(14)), 8
    PSet (tx(13), ty(13)), 7
    PSet (tx(12), ty(12)), 7
    PSet (tx(11), ty(11)), 4
    Circle (tx(10), ty(10)), 1, 0
    PSet (tx(10), ty(10)), 4
    Circle (tx(9), ty(9)), 1, 4
    Circle (tx(8), ty(8)), 1, 4
    Circle (tx(7), ty(7)), 1, 4
    Circle (tx(6), ty(6)), 1, 12
    Circle (tx(5), ty(5)), 1, 12
    Circle (tx(4), ty(4)), 2, 0
    Circle (tx(4), ty(4)), 1, 12
    Circle (tx(3), ty(3)), 2, 4
    Circle (tx(3), ty(3)), 1, 14
    Circle (tx(2), ty(2)), 3, 0
    Circle (tx(2), ty(2)), 2, 4
    Circle (tx(2), ty(2)), 1, 14
    PSet (tx(2) - 1, ty(2) - 1), 0
    PSet (tx(2) + 1, ty(2) - 1), 0
    PSet (tx(2) - 1, ty(2) + 1), 0
    PSet (tx(2) + 1, ty(2) + 1), 0
    Line (x& - 1, y& - 1)-(x& + 1, y& + 1), 14, BF
    Circle (x&, y&), 2, 12
    Circle (x&, y&), 3, 4

    For i = 16 To 3 Step -1
        tx(i) = tx(i - 1)
        ty(i) = ty(i - 1)
    Next i
    tx(2) = x&
    ty(2) = y&

    If p1& > 0 And p1dir& = 2 Then p1pad& = p1pad& - p1speed&
    If p1& > 0 And p1dir& = 1 Then p1pad& = p1pad& + p1speed&
    If p2& > 0 And p2dir& = 2 Then p2pad& = p2pad& - p2speed&
    If p2& > 0 And p2dir& = 1 Then p2pad& = p2pad& + p2speed&
    If p3& > 0 And p3dir& = 2 Then p3pad& = p3pad& - p3speed&
    If p3& > 0 And p3dir& = 1 Then p3pad& = p3pad& + p3speed&
    If p4& > 0 And p4dir& = 2 Then p4pad& = p4pad& - p4speed&
    If p4& > 0 And p4dir& = 1 Then p4pad& = p4pad& + p4speed&

    If p1hyper& > 0 Then
        If serve& = 0 And p1hyper& > 1 Then p1hyper& = p1hyper& - 1
        If ys& < 0 Then p1pad& = x&
    End If
    If p2hyper& > 0 Then
        If serve& = 0 And p2hyper& > 1 Then p2hyper& = p2hyper& - 1
        If xs& < 0 Then p2pad& = y&
    End If
    If p3hyper& > 0 Then
        If serve& = 0 And p3hyper& > 1 Then p3hyper& = p3hyper& - 1
        If ys& > 0 Then p3pad& = x&
    End If
    If p4hyper& > 0 Then
        If serve& = 0 And p4hyper& > 1 Then p4hyper& = p4hyper& - 1
        If xs& > 0 Then p4pad& = y&
    End If

    If (p1pad& - p1size&) < 60 Then p1pad& = (60 + p1size&)
    If (p1pad& + p1size&) > 420 Then p1pad& = (420 - p1size&)
    If (p2pad& - p2size&) < 60 Then p2pad& = (60 + p2size&)
    If (p2pad& + p2size&) > 420 Then p2pad& = (420 - p2size&)
    If (p3pad& - p3size&) < 60 Then p3pad& = (60 + p3size&)
    If (p3pad& + p3size&) > 420 Then p3pad& = (420 - p3size&)
    If (p4pad& - p4size&) < 60 Then p4pad& = (60 + p4size&)
    If (p4pad& + p4size&) > 420 Then p4pad& = (420 - p4size&)

    For i = 1 To it&
        If it1& = 0 And it2& = 0 And it3& = 0 And it4& = 0 And it5& = 0 And it6& = 0 And it7& = 0 And it8& = 0 Then Exit For
        If items& = 0 Then Exit For
        Line (itemx(1, i) - 2, itemy(1, i) - 2)-(itemx(1, i) + 2, itemy(1, i) + 2), colo&, B
        Line (itemx(1, i) - 1, itemy(1, i) - 1)-(itemx(1, i) + 1, itemy(1, i) + 1), colo& + 8, B
        PSet (itemx(1, i), itemy(1, i)), 15
    Next i
    For i = 1 To 30
        If stime(i) > 0 Then
            If symbolt(i) = 3 Or symbolt(i) = 4 Or symbolt(i) = 5 Or symbolt(i) = 8 Or symbolt(i) = 9 Or symbolt(i) = 12 Or symbolt(i) = 13 Then symbolc(i) = 0
            PSet (symbolx(i), symboly(i)), symbolc(i)
            stime(i) = stime(i) - 1
            If symbolt(i) = 1 Then Draw "M-2,0 R4 U L4 BL2 C4 D BL2 U Bl2 D BR12 NE NR3 NF"
            If symbolt(i) = 2 Then Draw "M-2,0 R4 U L4 BL2 C2 D BL2 U Bl2 D BR15 NH NL3 NG"
            If symbolt(i) = 3 Then Draw "C4 E F C14 L1 C4 BD E BR2 NR3 NE NF BL5 L BR C0 U BL2 C8 G BE C0 L"
            If symbolt(i) = 4 Then Draw "C4 E F C14 L1 C4 BD E C2 BR5 NL3 NH NG C4 BL8 L BR C0 U BL2 C8 G BE C0 L"
            If symbolt(i) = 5 Then Draw "BD2 C8 F BU C0 L1 BM-2,-1 C12 R BG C0 U2 C4 U1 BD C0 L BU3 BR2 C14 R BR C4 G H E"
            If symbolt(i) = 8 Then Draw "C3 BL H2 BD2 E2 BM+3,-1 E R F D G3 R3"
            If symbolt(i) = 9 Then Draw "BM-1,-4 C14 R4 D L4 G R4 D L4 G R7 G L3 D R2 G L2 D R G L D"
            If symbolt(i) = 10 Then Draw "BL2 R4 U1 L4 BM-5,1 C2 NR3 NF NE BR14 NL3 NG NH"
            If symbolt(i) = 11 Then Draw "BL2 R4 U1 L4 BM-2,1 C4 NL3 NG NH BR8 NR3 NF NE"
            If symbolt(i) = 12 Then Draw "C3 BM-3,-1 R2 H D2 BR4 F R E U H L2 U2 R3"
            If symbolt(i) = 13 Then Draw "C3 BM-3,-1 R2 H D2 BR4 BU4 R F D G L D3 BE C0 L"
            If stime(i) < 5 Then Line (symbolx(i) - 10, symboly(i) - 10)-(symbolx(i) + 10, symboly(i) + 10), 0, BF
        End If
    Next i

    If lasthit& = 1 Then c& = 1
    If lasthit& = 2 Then c& = 4
    If lasthit& = 3 Then c& = 2
    If lasthit& = 4 Then c& = 6

    Line (lx1&, ly1&)-(lx2&, ly2&), c&, B
    Line (lx1& + 1, ly1& + 1)-(lx2& - 1, ly2& - 1), c& + 8, B

    If p1& = 0 Or p2& = 0 Then GoTo skip1:
    Line (3, 3)-(3, 60), 1
    Line (3, 3)-(60, 3), 1
    Line (60, 3)-(3, 60), 1
    Line (4, 4)-(4, 59), 1
    Line (4, 4)-(59, 4), 1
    Line (59, 3)-(3, 59), 1
    skip1:
    If p4& = 0 Or p1& = 0 Then GoTo skip2:
    Line (477, 3)-(477, 60), 14
    Line (477, 3)-(420, 3), 14
    Line (420, 3)-(477, 60), 14
    Line (476, 4)-(476, 59), 14
    Line (476, 4)-(421, 4), 14
    Line (421, 3)-(477, 59), 14
    skip2:
    If p2& = 0 Or p3& = 0 Then GoTo skip3:
    Line (3, 477)-(3, 420), 4
    Line (3, 477)-(60, 477), 4
    Line (60, 477)-(3, 420), 4
    Line (4, 476)-(4, 421), 4
    Line (4, 476)-(59, 476), 4
    Line (59, 477)-(3, 421), 4
    skip3:
    If p3& = 0 Or p4& = 0 Then GoTo skip4:
    Line (477, 477)-(477, 420), 2
    Line (477, 477)-(420, 477), 2
    Line (420, 477)-(477, 420), 2
    Line (476, 476)-(476, 421), 2
    Line (476, 476)-(421, 476), 2
    Line (421, 477)-(477, 421), 2
    skip4:

    If p1& > 0 Then Line (p1pad& - (p1size& - 1), 5)-(p1pad& + (p1size& - 1), 7), 1, BF
    If p1hyper& = 0 And p1& > 0 Then Line (p1pad& - p1size&, 4)-(p1pad& + p1size&, 8), 1, B
    If p1& > 0 Then Line (p1pad& - (p1size& + 1), 3)-(61, 9), 0, BF
    If p1& > 0 Then Line (p1pad& + (p1size& + 1), 3)-(419, 9), 0, BF
    If p2& > 0 Then Line (5, p2pad& - (p2size& - 1))-(7, p2pad& + (p2size& - 1)), 4, BF
    If p2hyper& = 0 And p2& > 0 Then Line (4, p2pad& - p2size&)-(8, p2pad& + p2size&), 4, B
    If p2& > 0 Then Line (3, p2pad& - (p2size& + 1))-(9, 61), 0, BF
    If p2& > 0 Then Line (3, p2pad& + (p2size& + 1))-(9, 419), 0, BF
    If p3& > 0 Then Line (p3pad& - (p3size& - 1), 475)-(p3pad& + (p3size& - 1), 473), 2, BF
    If p3hyper& = 0 And p3& > 0 Then Line (p3pad& - p3size&, 476)-(p3pad& + p3size&, 472), 2, B
    If p3& > 0 Then Line (p3pad& - (p3size& + 1), 477)-(61, 471), 0, BF
    If p3& > 0 Then Line (p3pad& + (p3size& + 1), 477)-(419, 471), 0, BF
    If p4& > 0 Then Line (475, p4pad& - (p4size& - 1))-(473, p4pad& + (p4size& - 1)), 14, BF
    If p4hyper& = 0 And p4& > 0 Then Line (476, p4pad& - p4size&)-(472, p4pad& + p4size&), 14, B
    If p4& > 0 Then Line (477, p4pad& - (p4size& + 1))-(471, 61), 0, BF
    If p4& > 0 Then Line (477, p4pad& + (p4size& + 1))-(471, 419), 0, BF
    a$ = InKey$
    If p1com& = 1 Then GoTo player1
    If a$ = "v" Then p1dir& = 2
    If a$ = "b" Then p1dir& = 0
    If a$ = "n" Then p1dir& = 1
    If a$ = "g" And serve& = 1 Then GoSub serve
    p2:
    If p2com& = 1 Then GoTo player2
    If a$ = "q" Then p2dir& = 2
    If a$ = "a" Then p2dir& = 0
    If a$ = "z" Then p2dir& = 1
    If a$ = "s" And serve& = 2 Then GoSub serve
    p3:
    If p3com& = 1 Then GoTo player3
    If a$ = Chr$(0) + "K" Then p3dir& = 2
    If a$ = Chr$(0) + "P" Then p3dir& = 0
    If a$ = Chr$(0) + "M" Then p3dir& = 1
    If a$ = Chr$(0) + "H" And serve& = 3 Then GoSub serve
    p4:
    If p4com& = 1 Then GoTo player4
    If a$ = "]" Then p4dir& = 2
    If a$ = "'" Then p4dir& = 0
    If a$ = "/" Then p4dir& = 1
    If a$ = ";" And serve& = 4 Then GoSub serve
    finish:
    If a$ = "=" Then GameDelay& = GameDelay& - 100
    If a$ = "-" Then GameDelay& = GameDelay& + 100
    If a$ = Chr$(27) Then
        subtract& = Timer
        GoTo start
    ElseIf a$ = "p" Then
        subtract& = Timer
        Color 3
        Locate 29, 29
        Print "PAUSED"
        Sleep
        Do
            c$ = InKey$
        Loop Until c$ <> "~"
        Cls
        subtract& = Timer - subtract&
        startedd& = startedd& + subtract&
    End If
    If serve& = 5 Then GoSub centerserve
Loop
universal:
If p1& > 1 Then p1ac2& = Int(Rnd * (p1ac& * 2)) - p1ac&
If p2& > 1 Then p2ac2& = Int(Rnd * (p2ac& * 2)) - p2ac&
If p3& > 1 Then p3ac2& = Int(Rnd * (p3ac& * 2)) - p3ac&
If p4& > 1 Then p4ac2& = Int(Rnd * (p4ac& * 2)) - p4ac&
combo& = combo& + 1
scombo& = 50
p1serve& = 0
p2serve& = 0
p3serve& = 0
p4serve& = 0
Sound 700, .1
Return

serve:
If serve& = 1 Then
    If p1dir& = 1 Then
        xs& = 8
        ys& = 8
    ElseIf p1dir& = 2 Then
        xs& = -8
        ys& = 8
    End If
    If p1dir& = 0 Then ys& = 8
    p1serve& = p1serve& + 1
ElseIf serve& = 2 Then
    If p2dir& = 1 Then
        xs& = 8
        ys& = 8
    ElseIf p2dir& = 2 Then
        xs& = 8
        ys& = -8
    End If
    If p2dir& = 0 Then xs& = 8
    p2serve& = p2serve& + 1
ElseIf serve& = 3 Then
    If p3dir& = 1 Then
        xs& = 8
        ys& = -8
    ElseIf p3dir& = 2 Then
        xs& = -8
        ys& = -8
    End If
    If p3dir& = 0 Then ys& = -8
    p3serve& = p3serve& + 1
ElseIf serve& = 4 Then
    If p4dir& = 1 Then
        xs& = -8
        ys& = 8
    ElseIf p4dir& = 2 Then
        xs& = -8
        ys& = -8
    End If
    If p4dir& = 0 Then xs& = -8
    p4serve& = p4serve& + 1
End If
serve& = 0
scombo& = 50
Return

centerserve:
x& = 240
y& = 240
xs& = 0
ys& = 0
center& = center& + 1
If center& = 25 Then
    scombo& = 50
    combo& = 5
ElseIf center& = 50 Then
    scombo& = 50
    combo& = 4
ElseIf center& = 75 Then
    scombo& = 50
    combo& = 3
ElseIf center& = 100 Then
    scombo& = 50
    combo& = 2
ElseIf center& = 125 Then
    scombo& = 50
    combo& = 1
ElseIf center& = 150 Then
    retry:
    xs& = Int(Rnd * 17) - 8
    ys& = Int(Rnd * 17) - 8
    If xs& = 0 And ys& = 0 Then GoTo retry
    If xs& = 0 And p1& = 0 And p3& = 0 Then GoTo retry
    If ys& = 0 And p2& = 0 And p4& = 0 Then GoTo retry
    Do
        lasthit& = Int(Rnd * 4) + 1
        If lasthit& = 1 And p1& > 0 Then Exit Do
        If lasthit& = 2 And p2& > 0 Then Exit Do
        If last7hit& = 3 And p3& > 0 Then Exit Do
        If lasthit& = 4 And p4& > 0 Then Exit Do
    Loop
    serve& = 0
    center& = 0
End If
Return

score1:
If scoret& < 4 Then combo& = 1
If scoret& = 1 Or scoret& = 4 Then
    If lasthit& = 2 Then p2descore& = p2descore& + combo&
    If lasthit& = 3 Then p3descore& = p3descore& + combo&
    If lasthit& = 4 Then p4descore& = p4descore& + combo&
    If lasthit& = 1 Then p1descore& = p1descore& - combo&
ElseIf scoret& = 2 Or scoret& = 5 Then
    p2descore& = p2descore& + combo&
    p3descore& = p3descore& + combo&
    p4descore& = p4descore& + combo&
ElseIf scoret& = 3 Or scoret& = 6 Then
    p1descore& = p1descore& - combo&
End If
If lasthit& = 2 Then p2scores& = p2scores& + 1
If lasthit& = 3 Then p3scores& = p3scores& + 1
If lasthit& = 4 Then p4scores& = p4scores& + 1
If lose& = 1 Then
    p1desize& = 25
    p1speed& = 4 + pad& * 3
End If
GoSub score
Return

score2:
If scoret& < 4 Then combo& = 1
If scoret& = 1 Or scoret& = 4 Then
    If lasthit& = 2 Then p2descore& = p2descore& - combo&
    If lasthit& = 3 Then p3descore& = p3descore& + combo&
    If lasthit& = 4 Then p4descore& = p4descore& + combo&
    If lasthit& = 1 Then p1descore& = p1descore& + combo&
ElseIf scoret& = 2 Or scoret& = 5 Then
    p1descore& = p1descore& + combo&
    p3descore& = p3descore& + combo&
    p4descore& = p4descore& + combo&
ElseIf scoret& = 3 Or scoret& = 6 Then
    p2descore& = p2descore& - combo&
End If
If lasthit& = 1 Then p1scores& = p1scores& + 1
If lasthit& = 3 Then p3scores& = p3scores& + 1
If lasthit& = 4 Then p4scores& = p4scores& + 1
If lose& = 1 Then
    p2desize& = 25
    p2speed& = 4 + pad& * 3
End If
GoSub score
Return

score3:
If scoret& < 4 Then combo& = 1
If scoret& = 1 Or scoret& = 4 Then
    If lasthit& = 2 Then p2descore& = p2descore& + combo&
    If lasthit& = 3 Then p3descore& = p3descore& - combo&
    If lasthit& = 4 Then p4descore& = p4descore& + combo&
    If lasthit& = 1 Then p1descore& = p1descore& + combo&
ElseIf scoret& = 2 Or scoret& = 5 Then
    p1descore& = p1descore& + combo&
    p2descore& = p2descore& + combo&
    p4descore& = p4descore& + combo&
ElseIf scoret& = 3 Or scoret& = 6 Then
    p3descore& = p3descore& - combo&
End If
If lasthit& = 1 Then p1scores& = p1scores& + 1
If lasthit& = 2 Then p2scores& = p2scores& + 1
If lasthit& = 4 Then p4scores& = p4scores& + 1
If lose& = 1 Then
    p3desize& = 25
    p3speed& = 4 + pad& * 3
End If
GoSub score
Return

score4:
If scoret& < 4 Then combo& = 1
If scoret& = 1 Or scoret& = 4 Then
    If lasthit& = 2 Then p2descore& = p2descore& + combo&
    If lasthit& = 3 Then p3descore& = p3descore& + combo&
    If lasthit& = 4 Then p4descore& = p4descore& - combo&
    If lasthit& = 1 Then p1descore& = p1descore& + combo&
ElseIf scoret& = 2 Or scoret& = 5 Then
    p1descore& = p1descore& + combo&
    p2descore& = p2descore& + combo&
    p3descore& = p3descore& + combo&
ElseIf scoret& = 3 Or scoret& = 6 Then
    p4descore& = p4descore& - combo&
End If
If lasthit& = 1 Then p1scores& = p1scores& + 1
If lasthit& = 2 Then p2scores& = p2scores& + 1
If lasthit& = 3 Then p3scores& = p3scores& + 1
If lose& = 1 Then
    p4desize& = 25
    p4speed& = 4 + pad& * 3
End If
GoSub score
Return

score:
combo& = 1
scombo& = 0
serve& = lasthit&
If p1serve& >= 5 Or p2serve& >= 5 Or p3serve& >= 5 Or p4serve& >= 5 Then
    p1serve& = 0
    p2serve& = 0
    p3serve& = 0
    p4serve& = 0
    serve& = 5
    GoSub centerserve
End If
If serve& = 1 Then
    x& = p1pad&
    y& = 13
ElseIf serve& = 2 Then
    x& = 13
    y& = p2pad&
ElseIf serve& = 3 Then
    x& = p3pad&
    y& = 467
ElseIf serve& = 4 Then
    x& = 467
    y& = p4pad&
End If
waits& = 100
GoSub draww
If p1& > 1 Then p1ac2& = Int(Rnd * (p1ac& * 2)) - p1ac&
If p2& > 1 Then p2ac2& = Int(Rnd * (p2ac& * 2)) - p2ac&
If p3& > 1 Then p3ac2& = Int(Rnd * (p3ac& * 2)) - p3ac&
If p4& > 1 Then p4ac2& = Int(Rnd * (p4ac& * 2)) - p4ac&
Color 0: Locate 30, 30: Print combo&
Return

draww:
View
p1loc& = 1
p2loc& = 1
p3loc& = 1
p4loc& = 1
If p1descore& <= p2descore& Then p1loc& = p1loc& + 1
If p1descore& <= p3descore& Then p1loc& = p1loc& + 1
If p1descore& <= p4descore& Then p1loc& = p1loc& + 1
If p2descore& <= p1descore& Then p2loc& = p2loc& + 1
If p2descore& <= p3descore& Then p2loc& = p2loc& + 1
If p2descore& <= p4descore& Then p2loc& = p2loc& + 1
If p3descore& <= p1descore& Then p3loc& = p3loc& + 1
If p3descore& <= p2descore& Then p3loc& = p3loc& + 1
If p3descore& <= p4descore& Then p3loc& = p3loc& + 1
If p4descore& <= p1descore& Then p4loc& = p4loc& + 1
If p4descore& <= p2descore& Then p4loc& = p4loc& + 1
If p4descore& <= p3descore& Then p4loc& = p4loc& + 1
Do
    If p1loc& = p2loc& Or p1loc& = p3loc& Or p1loc& = p4loc& Then p1loc& = p1loc& - 1
    If p2loc& = p1loc& Or p2loc& = p3loc& Or p2loc& = p4loc& Then p2loc& = p2loc& - 1
    If p3loc& = p1loc& Or p3loc& = p2loc& Or p3loc& = p4loc& Then p3loc& = p3loc& - 1
    If p4loc& = p1loc& Or p4loc& = p2loc& Or p4loc& = p3loc& Then p4loc& = p4loc& - 1
Loop Until (p1loc& <> p2loc& And p2loc& <> p3loc& And p3loc& <> p4loc& And p4loc& <> p1loc& And p2loc& <> p4loc& And p3loc& <> p1loc&)
Locate ((p1loc& - 1) * 15) + 2, 62
Color 1
If p1& = 0 Then Color 0
Print "Score:"; p1score&; "     "
Locate ((p1loc& - 1) * 15) + 3, 62
If p1com& = 1 Then
    If p1& = 2 Then Print "Computer Easiest"
    If p1& = 3 Then Print "Computer Easy   "
    If p1& = 4 Then Print "Computer Medium "
    If p1& = 5 Then Print "Computer Hard   "
    If p1& = 6 Then Print "Computer Hardest"
    Locate ((p1loc& - 1) * 15) + 4, 62: Print "         "
    Locate ((p1loc& - 1) * 15) + 5, 62: Print "         "
    Locate ((p1loc& - 1) * 15) + 6, 62: Print "         "
    Locate ((p1loc& - 1) * 15) + 7, 62: Print "         "
    Locate ((p1loc& - 1) * 15) + 8, 62: Print "         "
End If
If p1com& = 1 Then GoTo ppp2
Print "Human           "
Locate ((p1loc& - 1) * 15) + 4, 62: Print "Keys:"
Locate ((p1loc& - 1) * 15) + 5, 62: Print "G -Serve "
Locate ((p1loc& - 1) * 15) + 6, 62: Print "V -Left  "
Locate ((p1loc& - 1) * 15) + 7, 62: Print "B -Stop  "
Locate ((p1loc& - 1) * 15) + 8, 62: Print "N -Right "
ppp2:
Locate ((p2loc& - 1) * 15) + 2, 62
Color 4
If p2& = 0 Then Color 0
Print "Score:"; p2score&; "     "
Locate ((p2loc& - 1) * 15) + 3, 62
If p2com& = 1 Then
    If p2& = 2 Then Print "Computer Easiest"
    If p2& = 3 Then Print "Computer Easy   "
    If p2& = 4 Then Print "Computer Medium "
    If p2& = 5 Then Print "Computer Hard   "
    If p2& = 6 Then Print "Computer Hardest"
    Locate ((p2loc& - 1) * 15) + 4, 62: Print "         "
    Locate ((p2loc& - 1) * 15) + 5, 62: Print "         "
    Locate ((p2loc& - 1) * 15) + 6, 62: Print "         "
    Locate ((p2loc& - 1) * 15) + 7, 62: Print "         "
    Locate ((p2loc& - 1) * 15) + 8, 62: Print "         "
End If
If p2com& = 1 Then GoTo ppp3
Print "Human           "
Locate ((p2loc& - 1) * 15) + 4, 62: Print "Keys:"
Locate ((p2loc& - 1) * 15) + 5, 62: Print "S -Serve "
Locate ((p2loc& - 1) * 15) + 6, 62: Print "Q -Up    "
Locate ((p2loc& - 1) * 15) + 7, 62: Print "A -Stop  "
Locate ((p2loc& - 1) * 15) + 8, 62: Print "Z -Down  "
ppp3:
Locate ((p3loc& - 1) * 15) + 2, 62
Color 2
If p3& = 0 Then Color 0
Print "Score:"; p3score&; "     "
Locate ((p3loc& - 1) * 15) + 3, 62
If p3com& = 1 Then
    If p3& = 2 Then Print "Computer Easiest"
    If p3& = 3 Then Print "Computer Easy   "
    If p3& = 4 Then Print "Computer Medium "
    If p3& = 5 Then Print "Computer Hard   "
    If p3& = 6 Then Print "Computer Hardest"
    Locate ((p3loc& - 1) * 15) + 4, 62: Print "         "
    Locate ((p3loc& - 1) * 15) + 5, 62: Print "         "
    Locate ((p3loc& - 1) * 15) + 6, 62: Print "         "
    Locate ((p3loc& - 1) * 15) + 7, 62: Print "         "
    Locate ((p3loc& - 1) * 15) + 8, 62: Print "         "
End If
If p3com& = 1 Then GoTo ppp4
Print "Human           "
Locate ((p3loc& - 1) * 15) + 4, 62: Print "Keys:"
Locate ((p3loc& - 1) * 15) + 5, 62: Print Chr$(24); " -Serve "
Locate ((p3loc& - 1) * 15) + 6, 62: Print Chr$(17); " -Left  "
Locate ((p3loc& - 1) * 15) + 7, 62: Print Chr$(25); " -Stop  "
Locate ((p3loc& - 1) * 15) + 8, 62: Print Chr$(16); " -Right "
ppp4:
Locate ((p4loc& - 1) * 15) + 2, 62
Color 14
If p4& = 0 Then Color 0
Print "Score:"; p4score&; "     "
Locate ((p4loc& - 1) * 15) + 3, 62
If p4com& = 1 Then
    If p4& = 2 Then Print "Computer Easiest"
    If p4& = 3 Then Print "Computer Easy   "
    If p4& = 4 Then Print "Computer Medium "
    If p4& = 5 Then Print "Computer Hard   "
    If p4& = 6 Then Print "Computer Hardest"
    Locate ((p4loc& - 1) * 15) + 4, 62: Print "         "
    Locate ((p4loc& - 1) * 15) + 5, 62: Print "         "
    Locate ((p4loc& - 1) * 15) + 6, 62: Print "         "
    Locate ((p4loc& - 1) * 15) + 7, 62: Print "         "
    Locate ((p4loc& - 1) * 15) + 8, 62: Print "         "
End If
If p4com& = 1 Then GoTo fff
Print "Human           "
Locate ((p4loc& - 1) * 15) + 4, 62: Print "Keys:"
Locate ((p4loc& - 1) * 15) + 5, 62: Print "; -Serve "
Locate ((p4loc& - 1) * 15) + 6, 62: Print "] -Up    "
Locate ((p4loc& - 1) * 15) + 7, 62: Print "' -Stop  "
Locate ((p4loc& - 1) * 15) + 8, 62: Print "/ -Down  "

fff:

col1& = 0
col2& = 0
col3& = 0
col4& = 0
If p1& > 0 Then
    If p1loc& = 1 Then col1& = 1
    If p1loc& = 2 Then col2& = 1
    If p1loc& = 3 Then col3& = 1
    If p1loc& = 4 Then col4& = 1
End If
If p2& > 0 Then
    If p2loc& = 1 Then col1& = 4
    If p2loc& = 2 Then col2& = 4
    If p2loc& = 3 Then col3& = 4
    If p2loc& = 4 Then col4& = 4
End If
If p3& > 0 Then
    If p3loc& = 1 Then col1& = 2
    If p3loc& = 2 Then col2& = 2
    If p3loc& = 3 Then col3& = 2
    If p3loc& = 4 Then col4& = 2
End If
If p4& > 0 Then
    If p4loc& = 1 Then col1& = 6
    If p4loc& = 2 Then col2& = 6
    If p4loc& = 3 Then col3& = 6
    If p4loc& = 4 Then col4& = 6
End If
Line (481, 0)-(639, 118), col1&, B
If col1& = 0 Then col1& = -8
Line (482, 1)-(638, 117), col1& + 8, B
Line (481, 121)-(639, 239), col2&, B
If col2& = 0 Then col2& = -8
Line (482, 122)-(638, 238), col2& + 8, B
Line (481, 241)-(639, 359), col3&, B
If col3& = 0 Then col3& = -8
Line (482, 242)-(638, 358), col3& + 8, B
Line (481, 361)-(639, 479), col4&, B
If col4& = 0 Then col4& = -8
Line (482, 362)-(638, 478), col4& + 8, B

View Screen(lx1& - 1, ly1& - 1)-(lx2&, ly2&)
Return

item:
startitem:
For j = 1 To 30
    If stime(j) = 0 Then symbol& = j
Next j
item& = Int(Rnd * 9) + 1
symbolt(symbol&) = item&
If item& = 1 Then
    If it2& = 0 Then GoTo startitem
    If lasthit& = 1 Then p1speed& = p1speed& - 1
    If p1speed& < 1 Then p1speed& = 1
    If lasthit& = 2 Then p2speed& = p2speed& - 1
    If p2speed& < 1 Then p2speed& = 1
    If lasthit& = 3 Then p3speed& = p3speed& - 1
    If p3speed& < 1 Then p3speed& = 1
    If lasthit& = 4 Then p4speed& = p4speed& - 1
    If p4speed& < 1 Then p4speed& = 1
ElseIf item& = 2 Then
    If it2& = 0 Then GoTo startitem
    If lasthit& = 1 Then p1speed& = p1speed& + 1
    If p1speed& > 30 Then p1speed& = 30
    If lasthit& = 2 Then p2speed& = p2speed& + 1
    If p2speed& > 30 Then p2speed& = 30
    If lasthit& = 3 Then p3speed& = p3speed& + 1
    If p3speed& > 30 Then p3speed& = 30
    If lasthit& = 4 Then p4speed& = p4speed& + 1
    If p4speed& > 30 Then p4speed& = 30
ElseIf item& = 3 Then
    If it1& = 0 Then GoTo startitem
    a& = a& - 1
    If a& < 1 Then a& = 1
ElseIf item& = 4 Then
    If it1& = 0 Then GoTo startitem
    a& = a& + 1
    If a& > 4 Then a& = 4
ElseIf item& = 5 Then
    If it4& = 0 Then GoTo startitem
    rann:
    Do
        xs& = Int(Rnd * 17) - 8
        ys& = Int(Rnd * 17) - 8
    Loop Until (xs& <> 0 Or ys& <> 0)
    If xs& = 0 And p1& = 0 And p3& = 0 Then GoTo rann
    If ys& = 0 And p2& = 0 And p4& = 0 Then GoTo rann
ElseIf item& = 6 Then
    If it3& = 0 Then GoTo startitem
    rand& = Int(Rnd * 18) + 1
    padsize& = (rand& * 5) + 10
    If lasthit& = 1 Then
        If padsize& > p1desize& Then symbolt(symbol&) = 10 Else symbolt(symbol&) = 11
        p1desize& = padsize&
    ElseIf lasthit& = 2 Then
        If padsize& > p2desize& Then symbolt(symbol&) = 10 Else symbolt(symbol&) = 11
        p2desize& = padsize&
    ElseIf lasthit& = 3 Then
        If padsize& > p3desize& Then symbolt(symbol&) = 10 Else symbolt(symbol&) = 11
        p3desize& = padsize&
    ElseIf lasthit& = 4 Then
        If padsize& > p4desize& Then symbolt(symbol&) = 10 Else symbolt(symbol&) = 11
        p4desize& = padsize&
    End If
ElseIf item& = 7 Then
    If Int(Rnd * 5) + 1 = 1 Then
        If it8& = 0 Then GoTo startitem
        points& = Int(Rnd * 50) + 1
        symbolt(symbol&) = 13
    Else
        If it5& = 0 Then GoTo startitem
        symbolt(symbol&) = 12
        points& = 5
    End If
    If lasthit& = 1 Then p1descore& = p1descore& + points&
    If lasthit& = 2 Then p2descore& = p2descore& + points&
    If lasthit& = 3 Then p3descore& = p3descore& + points&
    If lasthit& = 4 Then p4descore& = p4descore& + points&
    GoSub draww
ElseIf item& = 8 Then
    If it6& = 0 Then GoTo startitem
    If Int(Rnd * 5) + 1 <> 1 Then GoTo startitem
    If combo& < 50000 Then combo& = combo& * 2
    scombo& = 50
ElseIf item& = 9 Then
    If it7& = 0 Then GoTo startitem
    If Int(Rnd * 3) + 1 <> 1 Then GoTo startitem
    Cls
    If lasthit& = 1 Then p1hyper& = Int(Rnd * 1001) + 500
    If lasthit& = 2 Then p2hyper& = Int(Rnd * 1001) + 500
    If lasthit& = 3 Then p3hyper& = Int(Rnd * 1001) + 500
    If lasthit& = 4 Then p4hyper& = Int(Rnd * 1001) + 500
End If
iitemx& = itemx(1, hit&)
iitemy& = itemy(1, hit&)
symbolx(symbol&) = iitemx&
symboly(symbol&) = iitemy&
If re& = 1 Then
    symbolx(symbol&) = iitemx& + 10
    symboly(symbol&) = iitemy& + 10
End If
stime(symbol&) = 100
If lasthit& = 1 Then symbolc(symbol&) = 1
If lasthit& = 2 Then symbolc(symbol&) = 4
If lasthit& = 3 Then symbolc(symbol&) = 2
If lasthit& = 4 Then symbolc(symbol&) = 14
Line (iitemx& - 2, iitemy& - 2)-(iitemx& + 2, iitemy& + 2), 0, BF
If re& = 1 Then Return
iitemx& = Int(Rnd * 340) + 70
iitemy& = Int(Rnd * 340) + 70
itemx(1, hit&) = iitemx&
itemy(1, hit&) = iitemy&
Return

player1:
If y& < p1ai& And ys& < 0 Then
    p1des& = x& - xs& * (y& / ys&)
    p1des& = p1des& + p1ac2&
Else
    If serve& = 0 And p1& > 2 Then p1des& = 240 Else p1des& = p1pad&
End If
If serve& = 2 And p1& > 3 Then
    p1des& = p2pad&
ElseIf serve& = 3 And p1& > 3 Then
    p1des& = p3pad&
ElseIf serve& = 4 And p1& > 3 Then
    p1des& = 480 - p4pad&
End If
If serve& = 1 Then
    If p2descore& < p4descore& Then p1des& = 0
    If p4descore& < p2descore& Then p1des& = 480
    If p2descore& = p4descore& Then p1des& = 240
End If
If p1des& > p1pad& Then p1dir& = 1
If p1des& < p1pad& Then p1dir& = 2
If p1des& > (p1pad& - p1speed&) And p1des& < (p1pad& + p1speed&) Then p1dir& = 0
If waits& > 0 Then waits& = waits& - 1
If serve& = 1 And waits& = 0 Then GoSub serve
GoTo p2

player2:
If x& < p2ai& And xs& < 0 Then
    p2des& = y& - ys& * (x& / xs&)
    p2des& = p2des& + p2ac2&
Else
    If serve& = 0 And p2& > 2 Then p2des& = 240 Else p2des& = p2pad&
End If
If serve& = 1 And p2& > 3 Then
    p2des& = p1pad&
ElseIf serve& = 3 And p2& > 3 Then
    p2des& = 480 - p3pad&
ElseIf serve& = 4 And p2& > 3 Then
    p2des& = p4pad&
End If
If serve& = 2 Then
    If p1descore& < p3descore& Then p2des& = 0
    If p3descore& < p1descore& Then p2des& = 480
    If p1descore& = p3descore& Then p2des& = 240
End If
If p2des& > p2pad& Then p2dir& = 1
If p2des& < p2pad& Then p2dir& = 2
If p2des& > (p2pad& - p2speed&) And p2des& < (p2pad& + p2speed&) Then p2dir& = 0
If waits& > 0 Then waits& = waits& - 1
If serve& = 2 And waits& = 0 Then GoSub serve
GoTo p3

player3:
If y& > (480 - p3ai&) And ys& > 0 Then
    p3des& = x& - xs& * ((480 - y&) / -ys&)
    p3des& = p3des& + p3ac2&
Else
    If serve& = 0 And p3& > 2 Then p3des& = 240 Else p3des& = p3pad&
End If
If serve& = 1 And p3& > 3 Then
    p3des& = p1pad&
ElseIf serve& = 2 And p3& > 3 Then
    p3des& = 480 - p2pad&
ElseIf serve& = 4 And p3& > 3 Then
    p3des& = p4pad&
End If
If serve& = 3 Then
    If p2descore& < p4descore& Then p3des& = 0
    If p4descore& < p2descore& Then p3des& = 480
    If p2descore& = p4descore& Then p3des& = 240
End If
If p3des& > p3pad& Then p3dir& = 1
If p3des& < p3pad& Then p3dir& = 2
If p3des& > (p3pad& - p3speed&) And p3des& < (p3pad& + p3speed&) Then p3dir& = 0
If waits& > 0 Then waits& = waits& - 1
If serve& = 3 And waits& = 0 Then GoSub serve
GoTo p4

player4:
If x& > (480 - p4ai&) And xs& > 0 Then
    p4des& = y& - ys& * ((480 - x&) / -xs&)
    p4des& = p4des& + p4ac2&
Else
    If serve& = 0 And p4& > 2 Then p4des& = 240 Else p4des& = p4pad&
End If
If serve& = 1 And p4& > 3 Then
    p4des& = 480 - p1pad&
ElseIf serve& = 2 And p4& > 3 Then
    p4des& = p2pad&
ElseIf serve& = 3 And p4& > 3 Then
    p4des& = p3pad&
End If
If serve& = 4 Then
    If p1descore& < p3descore& Then p4des& = 0
    If p3descore& < p1descore& Then p4des& = 480
    If p1descore& = p3descore& Then p4des& = 240
End If
If p4des& > p4pad& Then p4dir& = 1
If p4des& < p4pad& Then p4dir& = 2
If p4des& > (p4pad& - p4speed&) And p4des& < (p4pad& + p4speed&) Then p4dir& = 0
If waits& > 0 Then waits& = waits& - 1
If serve& = 4 And waits& = 0 Then GoSub serve
GoTo finish

GameTitle:
Width 80, 30
Color 4
Locate 1, 1: Color 8: Print "4 Player Pong"
For x = 0 To 64
    For y = 0 To 15
        Line ((x * 5) + 160, (y * 5) + 160)-((x * 5) + 165, (y * 5) + 165), Point(x, y) / 2, B
    Next y
Next x
For x = 0 To 40
    For y = 0 To 15
        Line ((x * 5) + 240, (y * 5) + 235)-((x * 5) + 245, (y * 5) + 240), Point(x + 72, y) / 2, B
    Next y
Next x
Locate 1, 1
Print "              "
Line (153, 149)-(481, 316), 14, B
Line (152, 148)-(482, 317), 6, B
Color 3: Locate 21, 31: Print "    By Matthew   "
Color 11
Line (640, 327)-(353, 327)
Line (0, 327)-(269, 327)
Line (269, 334)-(269, 320)
Line (353, 334)-(353, 320)
Line (353, 334)-(269, 334)
Line (353, 320)-(269, 320)
Do
    changeword& = changeword& + 1
    If changeword& = 2000 Then changeword& = 0
    If changeword& < 1001 Then Color 1
    If changeword& > 1000 Then Color 0
    Locate 27, 34: Print "Press any key"
    a$ = InKey$
Loop Until (a$ <> "")
Cls
Return

theend:
View
started& = 0
Cls
p1pl& = 1
p2pl& = 1
p3pl& = 1
p4pl& = 1
If p1descore& <= p2descore& Or p1& = 0 Then p1pl& = p1pl& + 1
If p1descore& <= p3descore& Or p1& = 0 Then p1pl& = p1pl& + 1
If p1descore& <= p4descore& Or p1& = 0 Then p1pl& = p1pl& + 1
If p2descore& <= p1descore& Or p2& = 0 Then p2pl& = p2pl& + 1
If p2descore& <= p3descore& Or p2& = 0 Then p2pl& = p2pl& + 1
If p2descore& <= p4descore& Or p2& = 0 Then p2pl& = p2pl& + 1
If p3descore& <= p1descore& Or p3& = 0 Then p3pl& = p3pl& + 1
If p3descore& <= p2descore& Or p3& = 0 Then p3pl& = p3pl& + 1
If p3descore& <= p4descore& Or p3& = 0 Then p3pl& = p3pl& + 1
If p4descore& <= p1descore& Or p4& = 0 Then p4pl& = p4pl& + 1
If p4descore& <= p2descore& Or p4& = 0 Then p4pl& = p4pl& + 1
If p4descore& <= p3descore& Or p4& = 0 Then p4pl& = p4pl& + 1
tie& = 0
If p1pl& = 1 Then
    If p1pl& = p2pl& Or p1pl& = p3pl& Or p1pl& = p4pl& Then tie& = 1
End If
If p2pl& = 1 Then
    If p2pl& = p3pl& Or p2pl& = p4pl& Then tie& = 1
End If
If p3pl& = 1 Then
    If p3pl& = p4pl& Then tie& = 1
End If
If p1pl& = 1 Then co1& = 1
If p2pl& = 1 Then co1& = 4
If p3pl& = 1 Then co1& = 2
If p4pl& = 1 Then co1& = 14
If tie& = 1 Then co1& = 15
If p1pl& = 1 Then co2& = 9
If p2pl& = 1 Then co2& = 12
If p3pl& = 1 Then co2& = 10
If p4pl& = 1 Then co2& = 6
If tie& = 1 Then co2& = 8
co& = co1&
ch& = 0
For i = 1 To 240
    ch& = ch& + 1
    If ch& = 10 And co& = co1& Then
        co& = co2&
    ElseIf ch& = 10 And co& = co2& Then
        co& = co1&
    End If
    If ch& = 10 Then ch& = 0
    Line (320 - i, 240 - i)-(320 + i, 240 + i), co&, B
Next i
For i = 1 To 100
    For d = 1 To 500
    Next d
    Line (320 - i, 240)-(320 + i, 240), 15
    Line (319 - i, 239)-(321 + i, 241), 7, B
Next i
For i = 1 To 100
    For d = 1 To 200
    Next d
    Line (220, 240 - i)-(420, 240 + i), 15, B
    Line (221, 241 - i)-(419, 239 + i), 7, B
    Line (219, 239 - i)-(421, 241 + i), 7, B
    Line (222, 242 - i)-(418, 238 + i), 0, BF
Next i
Color 3: Locate 20, 36: Print "Game Stats"
Line (279, 160)-(359, 160), 3
Color co1&
Locate 22, 30
IF tie& = 1 THEN PRINT "        Tie Game       " ELSE IF p1pl& = 1 THEN PRINT "Player 1 is the winner!" ELSE IF p2pl& = 1 THEN PRINT "Player 2 is the winner!" ELSE IF p3pl& = 1 THEN PRINT "Player 3 is the winner!" ELSE IF p4pl& = 1 THEN PRINT  _
"Player 4 is the winner!"
If p1& > 1 Then p1t$ = "Com " Else If p1& = 1 Then p1t$ = "Human" Else If p1& = 0 Then p1t$ = "Off "
If p2& > 1 Then p2t$ = "Com " Else If p2& = 1 Then p2t$ = "Human" Else If p2& = 0 Then p2t$ = "Off "
If p3& > 1 Then p3t$ = "Com " Else If p3& = 1 Then p3t$ = "Human" Else If p3& = 0 Then p3t$ = "Off "
If p4& > 1 Then p4t$ = "Com " Else If p4& = 1 Then p4t$ = "Human" Else If p4& = 0 Then p4t$ = "Off "
Do
    If p1pl& = p2pl& Or p1pl& = p3pl& Or p1pl& = p4pl& Then p1pl& = p1pl& - 1
    If p2pl& = p1pl& Or p2pl& = p3pl& Or p2pl& = p4pl& Then p2pl& = p2pl& - 1
    If p3pl& = p1pl& Or p3pl& = p2pl& Or p3pl& = p4pl& Then p3pl& = p3pl& - 1
    If p4pl& = p1pl& Or p4pl& = p2pl& Or p4pl& = p3pl& Then p4pl& = p4pl& - 1
Loop Until (p1pl& <> p2pl& And p2pl& <> p3pl& And p3pl& <> p4pl& And p4pl& <> p1pl& And p2pl& <> p4pl& And p3pl& <> p1pl&)
If p1& = 0 Then p1descore& = 0
If p2& = 0 Then p2descore& = 0
If p3& = 0 Then p3descore& = 0
If p4& = 0 Then p4descore& = 0
Color 3: Locate 24, 30: Print "Player   Score  Goals"
Color 1: Locate 24 + p1pl&, 31: Print "P1-"; p1t$
Locate 24 + p1pl&, 39: Print p1descore&
Locate 24 + p1pl&, 46: Print p1scores&
Color 4: Locate 24 + p2pl&, 31: Print "P2-"; p2t$
Locate 24 + p2pl&, 39: Print p2descore&
Locate 24 + p2pl&, 46: Print p2scores&
Color 2: Locate 24 + p3pl&, 31: Print "P3-"; p3t$
Locate 24 + p3pl&, 39: Print p3descore&
Locate 24 + p3pl&, 46: Print p3scores&
Color 14: Locate 24 + p4pl&, 31: Print "P4-"; p4t$
Locate 24 + p4pl&, 39: Print p4descore&
Locate 24 + p4pl&, 46: Print p4scores&
gts& = finished& - startedd&
Do
    If gts& >= 60 Then
        gts& = gts& - 60
        gtm& = gtm& + 1
    Else
        Exit Do
    End If
Loop
Do
    If gtm& >= 60 Then
        gtm& = gtm& - 60
        gth& = gth& + 1
    Else
        Exit Do
    End If
Loop
Color 3: Locate 30, 30: Print "Game time:"
Locate 31, 30: If gts& > -1 Then Print gts&; "sec" Else Print "Error"
Locate 31, 30: If gtm& > 0 Then Print gtm&; "min"; gts&; "sec"
Locate 31, 30: If gth& > 0 Then Print gth&; "hr"; gtm&; "min"; gts&; "sec"
Locate 33, 31: Print "ontinue"
Color 11: Locate 33, 30: Print "C"

Do While a$ <> "c"
    a$ = InKey$
    Swap co1&, co2&
    For i = 102 To 240
        ch& = ch& + 1
        If ch& = 10 And co& = co1& Then
            co& = co2&
        ElseIf ch& = 10 And co& = co2& Then
            co& = co1&
        End If
        If ch& = 10 Then ch& = 0
        Line (320 - i, 240 - i)-(320 + i, 240 + i), co&, B
    Next i
Loop

gts& = 0
gtm& = 0
gth& = 0

GoTo start

switch:
Color 5
a$ = InKey$
If a$ = Chr$(0) + "P" Then
    arrow& = arrow& + 1
ElseIf a$ = Chr$(0) + "H" Then
    arrow& = arrow& - 1
ElseIf a$ = " " Then
    If arrow& = 1 Then it1& = it1& + 1
    If arrow& = 2 Then it2& = it2& + 1
    If arrow& = 3 Then it3& = it3& + 1
    If arrow& = 4 Then it4& = it4& + 1
    If arrow& = 5 Then it5& = it5& + 1
    If arrow& = 6 Then it8& = it8& + 1
    If arrow& = 7 Then it6& = it6& + 1
    If arrow& = 8 Then it7& = it7& + 1
End If
If it1& = 2 Then it1& = 0
If it2& = 2 Then it2& = 0
If it3& = 2 Then it3& = 0
If it4& = 2 Then it4& = 0
If it5& = 2 Then it5& = 0
If it6& = 2 Then it6& = 0
If it7& = 2 Then it7& = 0
If it8& = 2 Then it8& = 0
If arrow& = 9 Then arrow& = 1
If arrow& = 0 Then arrow& = 8

Draw "BM583,130 C4 E F C14 L1 C4 BD E BR2 NR3 NE NF BL5 L BR C0 U BL2 C8 G BE C0 L"
Draw "BM583,134 C4 E F C14 L1 C4 BD E C2 BR5 NL3 NH NG C4 BL8 L BR C0 U BL2 C8 G BE C0 L"
Draw "BM578,138 C1 M-2,0 R4 U L4 BL2 C4 D BL2 U Bl2 D BR12 NE NR3 NF"
Draw "BM578,142 C1 M-2,0 R4 U L4 BL2 C2 D BL2 U Bl2 D BR15 NH NL3 NG"
Draw "BM585,146 C1 BL2 R4 U1 L4 BM-5,1 C2 NR3 NF NE BR14 NL3 NG NH"
Draw "BM585,150 C1 BL2 R4 U1 L4 BM-2,1 C4 NL3 NG NH BR8 NR3 NF NE"
Draw "BM574,156 BD2 C8 F BU C0 L1 BM-2,-1 C12 R BG C0 U2 C4 U1 BD C0 L BU3 BR2 C14 R BR C4 G H E"
Draw "BM583,164 C3 BM-3,-1 R2 H D2 BR4 F R E U H L2 U2 R3"
Draw "BM574,172 C3 BM-3,-1 R2 H D2 BR4 BU4 R F D G L D3 BE C0 L"
Draw "BM583,180 C3 BL H2 BD2 E2 BM+3,-1 E R F D G3 R3"
Draw "BM575,187 BM-1,-4 C14 R4 D L4 G R4 D L4 G R7 G L3 D R2 G L2 D R G L D"

Color 4
If arrow& = 1 Then Color 12 Else Color 4
Locate 17, 42
Print "Change Ball Speed -"
If arrow& = 2 Then Color 12 Else Color 4
Locate 18, 42
Print "Change Pad Speed -"
If arrow& = 3 Then Color 12 Else Color 4
Locate 19, 42
Print "Change Pad Size -"
If arrow& = 4 Then Color 12 Else Color 4
Locate 20, 42
Print "Change Ball Direction -"
If arrow& = 5 Then Color 12 Else Color 4
Locate 21, 42
Print "5 Point Bonus -"
If arrow& = 6 Then Color 12 Else Color 4
Locate 22, 42
Print "Major Point Bonus -"
If arrow& = 7 Then Color 12 Else Color 4
Locate 23, 42
Print "Combo Double -"
If arrow& = 8 Then Color 12 Else Color 4
Locate 24, 42
Print "Hyper Mode -"
If it1& = 1 Then Color 12 Else Color 4
Locate 17, 66
Print "On "
If it1& = 0 Then Color 12 Else Color 4
Locate 17, 69
Print "Off"
If it2& = 1 Then Color 12 Else Color 4
Locate 18, 66
Print "On "
If it2& = 0 Then Color 12 Else Color 4
Locate 18, 69
Print "Off"
If it3& = 1 Then Color 12 Else Color 4
Locate 19, 66
Print "On "
If it3& = 0 Then Color 12 Else Color 4
Locate 19, 69
Print "Off"
If it4& = 1 Then Color 12 Else Color 4
Locate 20, 66
Print "On "
If it4& = 0 Then Color 12 Else Color 4
Locate 20, 69
Print "Off"
If it5& = 1 Then Color 12 Else Color 4
Locate 21, 66
Print "On "
If it5& = 0 Then Color 12 Else Color 4
Locate 21, 69
Print "Off"
If it8& = 1 Then Color 12 Else Color 4
Locate 22, 66
Print "On "
If it8& = 0 Then Color 12 Else Color 4
Locate 22, 69
Print "Off"
If it6& = 1 Then Color 12 Else Color 4
Locate 23, 66
Print "On "
If it6& = 0 Then Color 12 Else Color 4
Locate 23, 69
Print "Off"
If it7& = 1 Then Color 12 Else Color 4
Locate 24, 66
Print "On "
If it7& = 0 Then Color 12 Else Color 4
Locate 24, 69
Print "Off"

If a$ = "d" Then
    Cls
    switch& = 0
End If
GoTo skip

start:
If it& = 0 Then it& = 15
fic& = Int(Rnd * 5) + 1
If p1r& = 1 Then p1m& = p1&
If p2r& = 1 Then p2m& = p2&
If p3r& = 1 Then p3m& = p3&
If p4r& = 1 Then p4m& = p4&
If p1r& = 1 Then p1& = 7
If p2r& = 1 Then p2& = 7
If p3r& = 1 Then p3& = 7
If p4r& = 1 Then p4& = 7
View
Cls
Do
    Color 14: Locate 1, 15: Print "Game Setup"
    Line (111, 8)-(191, 8)
    Color 2: Locate 3, 15: Print "Players ("
    Locate 3, 31: Print ")"
    Color 10: Locate 3, 24: Print "1,2,3,4"
    Color 1: Locate 4, 16: Print "P1 -"
    Locate 4, 21
    If p1& = 0 Then Print "Off               "
    If p1& = 1 Then Print "Human             "
    If p1& = 2 Then Print "Computer (Easiest)"
    If p1& = 3 Then Print "Computer (Easy)   "
    If p1& = 4 Then Print "Computer (Medium) "
    If p1& = 5 Then Print "Computer (Hard)   "
    If p1& = 6 Then Print "Computer (Hardest)"
    If p1& = 7 Then Print "Computer (Random) "
    Color 4: Locate 5, 16: Print "P2 -"
    Locate 5, 21
    If p2& = 0 Then Print "Off               "
    If p2& = 1 Then Print "Human             "
    If p2& = 2 Then Print "Computer (Easiest)"
    If p2& = 3 Then Print "Computer (Easy)   "
    If p2& = 4 Then Print "Computer (Medium) "
    If p2& = 5 Then Print "Computer (Hard)   "
    If p2& = 6 Then Print "Computer (Hardest)"
    If p2& = 7 Then Print "Computer (Random) "
    Color 2: Locate 6, 16: Print "P3 -"
    Locate 6, 21
    If p3& = 0 Then Print "Off               "
    If p3& = 1 Then Print "Human             "
    If p3& = 2 Then Print "Computer (Easiest)"
    If p3& = 3 Then Print "Computer (Easy)   "
    If p3& = 4 Then Print "Computer (Medium) "
    If p3& = 5 Then Print "Computer (Hard)   "
    If p3& = 6 Then Print "Computer (Hardest)"
    If p3& = 7 Then Print "Computer (Random) "
    Color 14: Locate 7, 16: Print "P4 -"
    Locate 7, 21
    If p4& = 0 Then Print "Off               "
    If p4& = 1 Then Print "Human             "
    If p4& = 2 Then Print "Computer (Easiest)"
    If p4& = 3 Then Print "Computer (Easy)   "
    If p4& = 4 Then Print "Computer (Medium) "
    If p4& = 5 Then Print "Computer (Hard)   "
    If p4& = 6 Then Print "Computer (Hardest)"
    If p4& = 7 Then Print "Computer (Random) "
    Color 4
    If items& = 1 Then
        Color 12: Locate 9, 48: Print "l"
        Color 4: Locate 9, 40: Print "Items Re"
        Locate 9, 49: Print "ocate when Hit"
        Locate 10, 41
        If re& = 1 Then Print "No "
        If re& = 0 Then Print "Yes"
        Color 12: Locate 12, 45: Print "U"
        Color 4: Locate 12, 40: Print "Lose "
        Locate 12, 46: Print "pgrades when Scored On"
        Locate 13, 41
        If lose& = 0 Then Print "No "
        If lose& = 1 Then Print "Yes"
        Locate 15, 40: Print "Item Switch"
        Color 12
        If switch& = 1 Then Color 4
        Locate 15, 46: Print "w"
        If switch& = 1 Then
            Color 4: Locate 15, 51: Print "(Press  "
            Locate 15, 60: Print "when done)"
            Color 12: Locate 15, 58: Print "D"
        End If
    End If
    Color 12: Locate 3, 40: Print "I"
    Color 4: Locate 3, 41: Print "tems"
    Locate 4, 41
    If items& = 1 Then Print "On "
    If items& = 0 Then Print "Off"
    If items& = 1 Then
        Color 12: Locate 6, 40: Print "N"
        Color 4: Locate 6, 41: Print "umber of Items"
        Locate 7, 40: Print it&
    End If
    Color 11: Locate 9, 15: Print "B"
    Color 3: Locate 9, 16: Print "all Speed"
    Locate 10, 16
    If speed& = 1 Then Print "Normal   "
    If speed& = 2 Then Print "Fast     "
    If speed& = 3 Then Print "Very Fast"
    If speed& = 4 Then Print "Too Fast "
    Color 11: Locate 12, 15: Print "P"
    Color 3: Locate 12, 16: Print "ad Speed"
    Locate 13, 16
    If pad& = 1 Then Print "Normal   "
    If pad& = 2 Then Print "Fast     "
    If pad& = 3 Then Print "Very Fast"
    If pad& = 4 Then Print "Too Fast "
    Color 9: Locate 15, 23: Print "M"
    Color 1: Locate 15, 15: Print "Scoring"
    Locate 15, 24: Print "ode"
    Locate 16, 16
    If scoret& = 1 Then Print "Basic           "
    If scoret& = 2 Then Print "All Gain        "
    If scoret& = 3 Then Print "One Lose        "
    If scoret& = 4 Then Print "Combo           "
    If scoret& = 5 Then Print "All Gain (Combo)"
    If scoret& = 6 Then Print "One Lose (Combo)"
    If scoret& = 3 Or scoret& = 6 Then
        Color 1: Locate 18, 15: Print "Start S"
        Locate 19, 15: Print max&
        Locate 18, 23: Print "ore 0 = No End "
        Color 9: Locate 18, 22: Print "c"
    Else
        Color 1: Locate 18, 15: Print "Ma"
        Locate 19, 15: Print max&
        Locate 18, 19: Print "Score 0 = Unlimited"
        Color 9: Locate 18, 17: Print "x "
    End If
    Color 13: Locate 15, 2: Print "S"
    Locate 17, 2: Print "R"
    Locate 19, 2: Print "Q"
    Color 5: Locate 15, 3: Print "tart"
    Locate 17, 3: Print "eturn"
    Locate 19, 3: Print "uit"
    o& = 0
    If p1& > 0 Then o& = o& + 1
    If p2& > 0 Then o& = o& + 1
    If p3& > 0 Then o& = o& + 1
    If p4& > 0 Then o& = o& + 1
    If switch& = 1 Then GoTo switch
    a$ = InKey$
    If a$ = "q" Then System 0
    If a$ = "r" Then Exit Do
    If a$ = "s" Then
        started& = 0
        Exit Do
    ElseIf a$ = "l" Then
        re& = -re& + 1
    ElseIf a$ = "u" Then
        lose& = -lose& + 1
    ElseIf a$ = "x" Or a$ = "c" Then
        Locate 19, 16
        Print "        "
        Color 1
        Locate 19, 16
        Input "", max&
        If max& > 500000 Then max& = 500000
        Cls
    ElseIf a$ = "m" Then
        scoret& = scoret& + 1
        If scoret& = 7 Then scoret& = 1
    ElseIf a$ = "w" And items& = 1 Then
        arrow& = 1
        switch& = 1
    ElseIf a$ = "b" Then
        speed& = speed& + 1
        If speed& > 4 Then speed& = 1
    ElseIf a$ = "p" Then
        pad& = pad& + 1
        If pad& = 5 Then pad& = 1
    ElseIf a$ = "n" Then
        it& = it& + 1
        If it& > 15 Then it& = 1: Cls
    ElseIf a$ = "i" Then
        items& = -items& + 1
        Cls
    ElseIf a$ = "1" Then
        p1& = p1& + 1
        If p1& = 8 And o& > 1 Then p1& = 0
        If p1& = 8 And o& < 2 Then p1& = 1
        started& = 0
        Cls
    ElseIf a$ = "2" Then
        p2& = p2& + 1
        If p2& = 8 And o& > 1 Then p2& = 0
        If p2& = 8 And o& < 2 Then p2& = 1
        started& = 0
        Cls
    ElseIf a$ = "3" Then
        p3& = p3& + 1
        If p3& = 8 And o& > 1 Then p3& = 0
        If p3& = 8 And o& < 2 Then p3& = 1
        started& = 0
        Cls
    ElseIf a$ = "4" Then
        p4& = p4& + 1
        If p4& = 8 And o& > 1 Then p4& = 0
        If p4& = 8 And o& < 2 Then p4& = 1
        started& = 0
        Cls
    End If
    skip:
    View Screen(0, 0)-(102, 102)
    If items& = 1 Then
        For i = 1 To it&
            If Abs(ballx& - demoitemx(1, i)) < 2 And Abs(bally& - demoitemy(1, i)) < 2 And re& = 0 Then
                Cls
                demoitemx(1, i) = Int(Rnd * 74) + 14
                demoitemy(1, i) = Int(Rnd * 74) + 14
            End If
            Line (demoitemx(1, i), demoitemy(1, i))-(demoitemx(1, i) + 1, demoitemy(1, i) + 1), fic&, BF
        Next i
    End If
    x1& = 0
    y1& = 0
    x2& = 102
    y2& = 102
    If p1& = 0 Then y1& = 12
    If p2& = 0 Then x1& = 12
    If p3& = 0 Then y2& = 90
    If p4& = 0 Then x2& = 90
    Line (x1&, y1&)-(x2&, y2&), co&, B
    If p1& > 0 And p2& > 0 Then
        Line (2, 2)-(2, 14), 1
        Line (2, 2)-(14, 2), 1
        Line (14, 2)-(2, 14), 1
    End If
    If p2& > 0 And p3& > 0 Then
        Line (2, 100)-(2, 88), 4
        Line (2, 100)-(14, 100), 4
        Line (14, 100)-(2, 88), 4
    End If
    If p3& > 0 And p4& > 0 Then
        Line (100, 100)-(100, 88), 2
        Line (100, 100)-(88, 100), 2
        Line (88, 100)-(100, 88), 2
    End If
    If p4& > 0 And p1& > 0 Then
        Line (100, 2)-(100, 14), 14
        Line (100, 2)-(88, 2), 14
        Line (88, 2)-(100, 14), 14
    End If
    If p1& > 0 Then Line (pad1& - 5, 2)-(pad1& + 5, 3), 1, BF
    If p2& > 0 Then Line (2, pad2& - 5)-(3, pad2& + 5), 4, BF
    If p3& > 0 Then Line (pad3& - 5, 100)-(pad3& + 5, 99), 2, BF
    If p4& > 0 Then Line (100, pad4& - 5)-(99, pad4& + 5), 14, BF

    If p1& > 0 Then Line (pad1& - 6, 2)-(15, 4), 0, BF
    If p1& > 0 Then Line (pad1& + 6, 2)-(87, 4), 0, BF
    If p2& > 0 Then Line (2, pad2& - 6)-(4, 15), 0, BF
    If p2& > 0 Then Line (2, pad2& + 6)-(4, 87), 0, BF
    If p3& > 0 Then Line (pad3& - 6, 100)-(15, 98), 0, BF
    If p3& > 0 Then Line (pad3& + 6, 100)-(87, 98), 0, BF
    If p4& > 0 Then Line (100, pad4& - 6)-(98, 15), 0, BF
    If p4& > 0 Then Line (100, pad4& + 6)-(98, 87), 0, BF

    If (bally& < 15 Or bally& > 87) And ballxs& = 0 Then ballxs& = 1
    If (ballx& < 15 Or ballx& > 87) And ballys& = 0 Then ballys& = 1

    If ballx& < 14 And bally& < 14 Then
        Swap ballxs&, ballys&
        ballxs& = -ballxs&
        ballys& = -ballys&
        If Abs(ballxs&) = Abs(ballys&) Then ballxs& = ballxs& + 1
        Line (ballx& - 1, bally& - 1)-(ballx&, bally&), 0, B
        bally& = 13
        ballx& = 13
        Sound 750, .1
    End If
    If ballx& < 14 And bally& > 88 Then
        Swap ballxs&, ballys&
        If Abs(ballxs&) = Abs(ballys&) Then ballxs& = ballxs& + 1
        Line (ballx& - 1, bally& - 1)-(ballx&, bally&), 0, B
        bally& = 89
        ballx& = 13
        Sound 750, .1
    End If
    If ballx& > 88 And bally& < 14 Then
        Swap ballxs&, ballys&
        If Abs(ballxs&) = Abs(ballys&) Then ballxs& = ballxs& + 1
        Line (ballx& - 1, bally& - 1)-(ballx&, bally&), 0, B
        bally& = 13
        ballx& = 89
        Sound 750, .1
    End If
    If ballx& > 88 And bally& > 88 Then
        Swap ballxs&, ballys&
        ballxs& = -ballxs&
        ballys& = -ballys&
        If Abs(ballxs&) = Abs(ballys&) Then ballxs& = ballxs& + 1
        Line (ballx& - 1, bally& - 1)-(ballx&, bally&), 0, B
        bally& = 89
        ballx& = 89
        Sound 750, .1
    End If
    Line (ballx& - 1, bally& - 1)-(ballx&, bally&), 0, B
    PSet (ballx2&, bally2&), 0
    PSet (ballx3&, bally3&), 0
    PSet (ballx4&, bally4&), 0
    bally4& = bally3&
    bally3& = bally2&
    bally2& = bally&
    ballx4& = ballx3&
    ballx3& = ballx2&
    ballx2& = ballx&
    bally& = bally& + ballys&
    ballx& = ballx& + ballxs&
    Line (ballx& - 1, bally& - 1)-(ballx&, bally&), 4, B
    PSet (ballx&, bally&), 14
    PSet (ballx2&, bally2&), 12
    PSet (ballx3&, bally3&), 12
    PSet (ballx4&, bally4&), 8

    If bally& < 1 Or (bally& < 14 And p1& = 0) Then
        If p1& > 0 Then co& = 1
        ballys& = Int(Rnd * 3) + 1
        Sound 500, .1
    ElseIf ballx& < 1 Or (ballx& < 14 And p2& = 0) Then
        If p2& > 0 Then co& = 4
        ballxs& = Int(Rnd * 3) + 1
        Sound 500, .1
    ElseIf ballx& > 100 Or (ballx& > 88 And p4& = 0) Then
        If p4& > 0 Then co& = 14
        ballxs& = -(Int(Rnd * 3) + 1)
        Sound 500, .1
    ElseIf bally& > 100 Or (bally& > 88 And p3& = 0) Then
        If p3& > 0 Then co& = 2
        ballys& = -(Int(Rnd * 3) + 1)
        Sound 500, .1
    End If

    If ballys& < 0 Then
        If ballx& > pad1& Then pad1& = pad1& + 3
        If ballx& < pad1& Then pad1& = pad1& - 3
        If pad1& > 82 Then pad1& = 82
        If pad1& < 20 Then pad1& = 20
    End If
    If ballxs& < 0 Then
        If bally& > pad2& Then pad2& = pad2& + 3
        If bally& < pad2& Then pad2& = pad2& - 3
        If pad2& > 82 Then pad2& = 82
        If pad2& < 20 Then pad2& = 20
    End If
    If ballys& > 0 Then
        If ballx& > pad3& Then pad3& = pad3& + 3
        If ballx& < pad3& Then pad3& = pad3& - 3
        If pad3& > 82 Then pad3& = 82
        If pad3& < 20 Then pad3& = 20
    End If
    If ballxs& > 0 Then
        If bally& > pad4& Then pad4& = pad4& + 3
        If bally& < pad4& Then pad4& = pad4& - 3
        If pad4& > 82 Then pad4& = 82
        If pad4& < 20 Then pad4& = 20
    End If
    View

    Limit 60
Loop
If (scoret& = 3 Or scoret& = 6) And o& = 1 Then GoTo start
If p1& = 7 Then p1r& = 1 Else p1r& = 0
If p2& = 7 Then p2r& = 1 Else p2r& = 0
If p3& = 7 Then p3r& = 1 Else p3r& = 0
If p4& = 7 Then p4r& = 1 Else p4r& = 0
If started& = 1 Then
    If p1r& = 1 Then p1& = p1m&
    If p2r& = 1 Then p2& = p2m&
    If p3r& = 1 Then p3& = p3m&
    If p4r& = 1 Then p4& = p4m&
End If
If started& = 1 Then startedd& = startedd& + subtract&
If started& = 0 Then GoTo new Else GoTo restart

