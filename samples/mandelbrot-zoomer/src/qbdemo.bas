'QBDEMO (C) 2002 Tor Myklebust

'The fractal zoomer should run at 60FPS on a 500MHz machine.  I disabled
'vsync because it runs like shit on this 300MHz machine on the higher zoom
'levels (inconsistent 20-30 fps).  I basically just packed the rest of the
'demo with really shitty effects.  There is no music because I don't know
'a damn thing about sound coding (aside from the fact that you use Fourier
'transforms a hell of a lot), and I also don't know the first thing about
'art/music.

'The fractal zoomer uses a number of cheap hacks.  First, I only render
'the fractal image once per 50 frames.  It zooms in by a factor of two
'each time.  It is rendered at a resolution of 320*200, because we don't
'want blockies to show up on our 160*100 rendered image.  I've tried
'doing the "maximal" 224*141 (or thereabouts) image and it looked bad.
'We render four scanlines per frame, drawing as few pixels as possible.
'We zoom the 160*100 in the middle of the previous frame's 320*200 to take
'up every fourth pixel in the new frame, then (ab)using the intermediate
'value theorem for the pixels in between if the neighbour pixels are the
'same colour.  This causes some minor visual artefacts which you shouldn't
'be able to see (except the one white line where the yellow is disappearing)

'This code is VERY LOOSELY based on Alex Champandard's code in his "The Art
'of Demomaking" series.  I made up the zoom hack and the IVT hack because
'QB is more than twice as slow as DJGPP.  I thought his palette-cycling
'looked really stupid, so I omitted that.

'I shouldn't need to explain the shadebob effect.  Everyone knows how to do
'shadebobs, or can at least figure it out in two or three minutes.  No
'hacking was necessary here, as the effect is trivial to begin with.

'I also shouldn't need to explain plasma.  No hacking was involved here,
'either.

'I did the flag thing because I saw an american flag flying in some past demo
'which i just looked at (15 minutes before the deadline).  I didn't have time
'to code an american flag burning (I've done this in C by just rendering less
'and less of the flag (having the fire "crawl across" the flag) each frame,
'and using the "burning" areas to seed a fire.  Besides, burning is supposed
'to be a proper way to retire a flag, and we can't have that.

'I wanted to add a (phongshaded, swept) scrolltext, but time did not permit
'it.  You can see something like this in mesha or lbd or something (however,
'because QB is QB, it probably wouldn't be half the quality).

'I started this 27 hours before the deadline, and finished it _on_ the
'deadline.  Yay for me.

$NoPrefix
DefInt A-Z
'$DYNAMIC
$Resize:Smooth

Const XCENTRE# = -.577816001047738#
Const YCENTRE# = -.6311212235178052#

Screen 13
FullScreen SquarePixels , Smooth

Dim Shared totalframecount As Integer
Dim Shared fractal1(32000&) As Integer
Dim Shared fractal2(32000&) As Integer
For x = 0 To 63
    Out &H3C8, x
    Out &H3C9, x
    Out &H3C9, x
    Out &H3C9, 0
Next
For x = 64 To 127
    Out &H3C8, x
    Out &H3C9, 63
    Out &H3C9, 63
    Out &H3C9, x
Next
For x = 128 To 191
    Out &H3C8, x
    Out &H3C9, 0
    Out &H3C9, 0
    Out &H3C9, x
Next
For x = 191 To 255
    Out &H3C8, x
    Out &H3C9, x
    Out &H3C9, x
    Out &H3C9, 63
Next
Out &H3C8, 255: Out &H3C9, 0: Out &H3C9, 0: Out &H3C9, 0
Out &H3C8, 127: Out &H3C9, 0: Out &H3C9, 0: Out &H3C9, 0
ti1! = Timer
fractaleffect 2250
ti1! = Timer - ti1!
Color 63: Print ti1!
Erase fractal1
Erase fractal2
a$ = Input$(1)
Cls
unwhitefade 16
Dim Shared bobsprite(32, 32) As Integer
For x = 0 To 32
    For y = 0 To 32
        bobsprite(x, y) = 16 - Sqr((16 - x) ^ 2 + (16 - y) ^ 2)
        If bobsprite(x, y) < 0 Then bobsprite(x, y) = 0
    Next
Next
shadebobeffect 8192
Erase bobsprite
Cls
unwhitefade 16
plasma 1024
Cls
ohcanada 512 'ohcanada has a transition

End 0

Rem $STATIC
Sub drawbob (ofs)
    For y = 0 To 31
        ofs = ofs + 288
        For x = 0 To 31
            Poke ofs, Peek(ofs) + bobsprite(x, y)
            ofs = ofs + 1
        Next
    Next
End Sub

DefDbl A-Z
'
'distthr is 4 unless you know what you're doing
'maximum iteration number of 256 seems to be sufficient for most purposes.
'"renders" one scanline to fractal1.
'assumes that we have been DEF SEG'd to fractal1.
'
Sub fracline (y%, y1, y2, x1, x2, distthr)
    deltax = (x2 - x1) / 160
    deltay = (y2 - y1) / 160
    y = y1
    x% = 1
    y320% = y% * 320
    x = x1 + deltax / 2
    Do
        unf% = Peek(y320% + x% - 1)
        If unf% = Peek(y320% + x% + 1) And unf% > 0 Then
            iter% = unf%
        Else
            re = 0: im = 0: iter% = 0
            Do
                re2 = re * re
                im2 = im * im
                im = re * im
                im = im + im + y
                re = re2 - im2 + x
                iter% = iter% + 1
            Loop Until re2 + im2 >= distthr Or iter% = 255
        End If
        Poke x% + y320%, iter%
        x% = x% + 2
        If x% >= 320 Then Exit Do
        x = x + deltax
        y = y + deltay
    Loop
    x% = 160
    x = (x1 + x2) / 2
    re = 0: im = 0: iter% = 0
    Do
        temp = re * re - im * im
        im = re * im
        im = im + im + y
        re = temp + x
        iter% = iter% + 1
    Loop Until re * re + im * im >= distthr Or iter% = 255
    Poke x% + y320%, iter%
End Sub

'render odd scanlines like this
'just like fracline, but we cheat vertically.
Sub fracline2 (y%, y1, y2, x1, x2, distthr)
    'Dim scanline(320) As Integer
    deltax = (x2 - x1) / 320
    deltay = (y2 - y1) / 320
    y = y1
    x% = 0
    y320% = y% * 320
    x = x1
    Do
        If Peek(x% + y320% - 320) = Peek(x% + y320% + 320) Then
            iter% = Peek(x% + y320% - 320)
        Else
            re = 0: im = 0: iter% = 0
            Do
                re2 = re * re
                im2 = im * im
                im = re * im
                im = im + im + y
                re = re2 - im2 + x
                iter% = iter% + 1
            Loop Until re2 + im2 >= distthr Or iter% = 255
        End If
        Poke x% + y320%, iter%
        x% = x% + 1
        If x% >= 320 Then Exit Sub
        x = x + deltax
        y = y + deltay
    Loop

End Sub

DefInt A-Z
Sub fractaleffect (totalframes)
    Dim tmpshit(160, 100)
    ly = -100: f# = 1
    For f = 1 To totalframes
        ly0 = ly
        ly1 = ly + 1
        ly2 = ly + 2
        ly3 = ly + 3
        ly0# = ly0 / f# + YCENTRE
        ly1# = ly1 / f# + YCENTRE
        ly2# = ly2 / f# + YCENTRE
        ly3# = ly3 / f# + YCENTRE
        lx1# = XCENTRE - 160 / f#
        lx2# = XCENTRE + 160 / f#
        Def Seg = VarSeg(fractal1(0))
        distthr# = 4
        fracline ly0 + 100, ly0#, ly0#, lx1#, lx2#, distthr#
        fracline ly2 + 100, ly2#, ly2#, lx1#, lx2#, distthr#
        fracline2 ly1 + 100, ly1#, ly1#, lx1#, lx2#, distthr#
        fracline2 ly3 + 100, ly3#, ly3#, lx1#, lx2#, distthr#
        ly = ly + 4
        If ly >= 100 Then
            ly = -100
            f# = f# * 2
            o = 16080
            For y = 0 To 99
                For x = 0 To 159
                    tmpshit(x, y) = Peek(o)
                    o = o + 1
                Next
                o = o + 160
            Next
            o = 0
            For x = 0 To 32000
                fractal2(x) = fractal1(x)
                fractal1(x) = 0
            Next
            For y = 0 To 99
                For x = 0 To 159
                    Poke x * 2 + y * 640, tmpshit(x, y)
                Next
            Next

        End If
        Def Seg = VarSeg(fractal2(0))
        f50 = (f) Mod 50
        x1 = f50 * 1.6: y1 = f50
        x2 = 320 - f50 * 1.6: y2 = 200 - f50
        render x1, y1, x2, y2
        If Len(InKey$) Then Exit Sub
        totalframecount = totalframecount + 1
        Limit 60
    Next
End Sub

Sub ohcanada (totalframes)
    For x = 0 To 255
        Out &H3C8, x
        Out &H3C9, 63
        Out &H3C9, 63
        Out &H3C9, 63
    Next
    Def Seg = &HA000
    BLoad "canada.bsv", 0
    For x = 0 To 255
        Out &H3C8, x
        Out &H3C9, 63
        Out &H3C9, x \ 4
        Out &H3C9, x \ 4
    Next
    unwhitefade 256
    totalframecount = totalframecount + 16
    For f = 1 To totalframes
        Wait &H3DA, 8, 8
        Wait &H3DA, 8
        totalframecount = totalframecount + 1
        If InKey$ > "" Then Exit Sub
    Next
End Sub

Sub plasma (totalframes)
    Dim unf(320), unfunf(320)
    Dim sine(512)
    Dim fuh(128, 128)
    Def Seg = &HA000
    For x = 0 To 512
        sine(x) = Sin(x * 3.14 / 256) * 32 + 32
    Next
    For f = 1 To totalframes
        For x = 0 To 320
            unf(x) = sine((x + f) And 511) + sine((3 * x + 7 * f + 3) And 511)
        Next
        o = 0
        For y = 0 To 128
            unf2 = sine((y * 7 + f * 5) And 511) + sine((y * 14 + f * 11 + 1943) And 511)
            For x = 0 To 128
                fuh(x, y) = unf(x) + unf2
                o = o + 1
            Next
        Next
        For x = 0 To 320
            unf(x) = sine((x * 11 + f * 7) And 511) + sine((3 * x + 7 * f + 3) And 511)
            unfunf(x) = sine((x * 4 + f * 5) And 511) + sine((9 * x + 2 * f + 371) And 511)
        Next
        o = 0
        For y = 0 To 199
            unf2 = sine((y * 11 + f * 6) And 511) + sine((y * 14 + f * 11 + 1943) And 511)
            unf3 = sine((y * 9 + f * 4) And 511) + sine((y * 17 + f * 23 + 1943) And 511)
            For x = 0 To 319
                Poke o, fuh((unf(x) + unf2) And 127, (unfunf(x) + unf3) And 127)
                o = o + 1
            Next
        Next
        updpalplasma f
        totalframecount = totalframecount + 1
        If InKey$ > "" Then Exit Sub
        Limit 60
    Next
End Sub

'like a bf line with similar parameters. except we're "texturing"
'we are defsegged to fractal2.
Sub render (x1, y1, x2, y2)
    Dim unf(160, 100)
    deltay = y2 - y1
    deltax = x2 - x1
    yadd = deltay \ 100
    xadd = deltax \ 160
    deltax = deltax Mod 160
    deltay = deltay Mod 100
    y = y1
    For scry = 0 To 99
        x = x1
        xe = 0
        y320 = y * 320
        For scrx = 0 To 159
            unf(scrx, scry) = Peek(x + y320)
            xe = xe + deltax
            If xe > 160 Then xe = xe - 160: x = x + 1
            x = x + xadd
        Next
        ye = ye + deltay
        If ye > 100 Then ye = ye - 100: y = y + 1
        y = y + yadd
    Next
    Def Seg = &HA000
    o = 16080
    For y = 0 To 99
        For x = 0 To 159
            Poke o + x, unf(x, y)
        Next
        o = o + 320
    Next
    Def Seg = VarSeg(fractal2(0))

End Sub

Sub shadebobeffect (totalframes)
    Dim bob(4096) As Integer
    bobptr = 0
    Def Seg = &HA000
    For f = 1 To totalframes
        undrawbob (bob(bobptr))
        x = (Sin(f / 71) + Cos(f / 47 + 2) + Cos(f / 91 + 7)) * 48 + 160
        y = (Cos(f / 49 + 3) + Sin(f / 41 + 2) + Sin(f / 97 + 7)) * 28 + 100
        bob(bobptr) = x + y * 320
        drawbob (bob(bobptr))
        bobmax = f \ 2 + 1
        'IF bobmax > 4095 THEN bobmax = 4095
        bobptr = bobptr + 1
        bobptr = bobptr Mod bobmax
        totalframecount = totalframecount + 1
        If InKey$ > "" Then Exit Sub
        Limit 60
    Next
    Erase bob
End Sub

Sub undrawbob (ofs)
    For y = 0 To 31
        ofs = ofs + 288
        For x = 0 To 31
            Poke ofs, Peek(ofs) - bobsprite(x, y)
            ofs = ofs + 1
        Next
    Next
End Sub

Sub unwhitefade (totalframes)
    Dim pal(256, 3)
    For x = 0 To 255
        Out &H3C7, x
        pal(x, 0) = Inp(&H3C9)
        pal(x, 1) = Inp(&H3C9)
        pal(x, 2) = Inp(&H3C9)
    Next
    For f = 0 To totalframes
        f! = f / totalframes
        Wait &H3DA, 8, 8
        Wait &H3DA, 8
        For x = 0 To 255
            Out &H3C8, x
            Out &H3C9, pal(x, 0) * f! + 63 * (1 - f!)
            Out &H3C9, pal(x, 1) * f! + 63 * (1 - f!)
            Out &H3C9, pal(x, 2) * f! + 63 * (1 - f!)
        Next
        totalframecount = totalframecount + 1
    Next

End Sub

'essentially ripped from Alex Champandard.
'the code is exactly the same, +/- variable name changes, language, and
'abstraction.
Sub updpalplasma (f)
    For x = 0 To 255
        Out &H3C8, x
        Out &H3C9, 32 - 31 * Cos(x * Pi / 128 + f * .00141)
        Out &H3C9, 32 - 31 * Cos(x * Pi / 128 + f * .0141)
        Out &H3C9, 32 - 31 * Cos(x * Pi / 64 + f * .0136)
    Next
End Sub

Sub whitefade (totalframes)
    Dim pal(256, 3)
    For x = 0 To 255
        Out &H3C7, x
        pal(x, 0) = Inp(&H3C9)
        pal(x, 1) = Inp(&H3C9)
        pal(x, 2) = Inp(&H3C9)
    Next
    For f = totalframes To 0 Step -1
        f! = f / totalframes
        Wait &H3DA, 8, 8
        Wait &H3DA, 8
        For x = 0 To 255
            Out &H3C8, x
            Out &H3C9, pal(x, 0) * f! + 63 * (1 - f!)
            Out &H3C9, pal(x, 1) * f! + 63 * (1 - f!)
            Out &H3C9, pal(x, 2) * f! + 63 * (1 - f!)
        Next
        totalframecount = totalframecount + 1
        If Len(InKey$) Then Exit Sub
    Next
End Sub

