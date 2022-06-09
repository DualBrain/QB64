$NoPrefix
$Resize:Smooth
Screen 9
FullScreen SquarePixels , Smooth

Print "It`s great demo of my VIRTUAL SCREEN engine"
Print "Press Left, Right, Up, Down to move your soldier"
Print "Press Space to shoot"
Print
Print "This program written by Tsiplacov Sergey"
Print
Print "maple@arstel.ru                 Sergey, Russia"
rus:
a$ = InKey$
If a$ <> "" Then GoTo beg
GoTo rus


beg:
Screen 7
Screen , , 3, 2
Restore mdat
For f = 1 To 77
    Read a$
    Open a$ + ".sps" For Input As #2
    Input #2, r, ah, bh
    Close #2
    Open a$ + ".spr" For Input As #2
    Dim dd(ah, bh)
    For x = 1 To ah: For y = 1 To bh: Input #2, dd(x, y): PSet (x, y), dd(x, y): Next y: Next x
    Close #2
    If f = 1 Then Dim g1(r): Get (1, 1)-(ah, bh), g1()
    If f = 2 Then Dim g2(r): Get (1, 1)-(ah, bh), g2()
    If f = 3 Then Dim g3(r): Get (1, 1)-(ah, bh), g3()
    If f = 4 Then Dim wc(r): Get (1, 1)-(ah, bh), wc()
    If f = 5 Then Dim h1l(r): Get (1, 1)-(ah, bh), h1l()
    If f = 6 Then Dim h2l(r): Get (1, 1)-(ah, bh), h2l()
    If f = 7 Then Dim h1r(r): Get (1, 1)-(ah, bh), h1r()
    If f = 8 Then Dim h2r(r): Get (1, 1)-(ah, bh), h2r()
    If f = 9 Then Dim w1(r): Get (1, 1)-(ah, bh), w1()
    If f = 10 Then Dim w2(r): Get (1, 1)-(ah, bh), w2()
    If f = 11 Then Dim h1lm(r): Get (1, 1)-(ah, bh), h1lm()
    If f = 12 Then Dim h2lm(r): Get (1, 1)-(ah, bh), h2lm()
    If f = 13 Then Dim h1rm(r): Get (1, 1)-(ah, bh), h1rm()
    If f = 14 Then Dim h2rm(r): Get (1, 1)-(ah, bh), h2rm()
    If f = 15 Then Dim m1(r): Get (1, 1)-(ah, bh), m1()
    If f = 16 Then Dim m2(r): Get (1, 1)-(ah, bh), m2()
    If f = 17 Then Dim t1r(r): Get (1, 1)-(ah, bh), t1r()
    If f = 18 Then Dim t1l(r): Get (1, 1)-(ah, bh), t1l()
    If f = 19 Then Dim t1rm(r): Get (1, 1)-(ah, bh), t1rm()
    If f = 20 Then Dim t1lm(r): Get (1, 1)-(ah, bh), t1lm()
    If f = 21 Then Dim mr1r(r): Get (1, 1)-(ah, bh), mr1r()
    If f = 22 Then Dim mr2r(r): Get (1, 1)-(ah, bh), mr2r()
    If f = 23 Then Dim mr1l(r): Get (1, 1)-(ah, bh), mr1l()
    If f = 24 Then Dim mr2l(r): Get (1, 1)-(ah, bh), mr2l()
    If f = 25 Then Dim mr1rm(r): Get (1, 1)-(ah, bh), mr1rm()
    If f = 26 Then Dim mr2rm(r): Get (1, 1)-(ah, bh), mr2rm()
    If f = 27 Then Dim mr1lm(r): Get (1, 1)-(ah, bh), mr1lm()
    If f = 28 Then Dim mr2lm(r): Get (1, 1)-(ah, bh), mr2lm()
    If f = 29 Then Dim ff(r): Get (1, 1)-(ah, bh), ff()
    If f = 30 Then Dim ffm(r): Get (1, 1)-(ah, bh), ffm()
    If f = 31 Then Dim lkl(r): Get (1, 1)-(ah, bh), lkl()
    If f = 32 Then Dim lkr(r): Get (1, 1)-(ah, bh), lkr()
    If f = 33 Then Dim lklm(r): Get (1, 1)-(ah, bh), lklm()
    If f = 34 Then Dim lkrm(r): Get (1, 1)-(ah, bh), lkrm()
    If f = 35 Then Dim g4(r): Get (1, 1)-(ah, bh), g4()
    If f = 36 Then Dim g5(r): Get (1, 1)-(ah, bh), g5()
    If f = 37 Then Dim g6(r): Get (1, 1)-(ah, bh), g6()
    If f = 38 Then Dim g7(r): Get (1, 1)-(ah, bh), g7()
    If f = 39 Then Dim g8(r): Get (1, 1)-(ah, bh), g8()
    If f = 40 Then Dim g9(r): Get (1, 1)-(ah, bh), g9()
    If f = 41 Then Dim g10(r): Get (1, 1)-(ah, bh), g10()
    If f = 42 Then Dim g11(r): Get (1, 1)-(ah, bh), g11()
    If f = 43 Then Dim g12(r): Get (1, 1)-(ah, bh), g12()
    If f = 44 Then Dim tr1r(r): Get (1, 1)-(ah, bh), tr1r()
    If f = 45 Then Dim tr1l(r): Get (1, 1)-(ah, bh), tr1l()
    If f = 46 Then Dim tr1rm(r): Get (1, 1)-(ah, bh), tr1rm()
    If f = 47 Then Dim tr1lm(r): Get (1, 1)-(ah, bh), tr1lm()
    If f = 48 Then Dim bl1(r): Get (1, 1)-(ah, bh), bl1()
    If f = 49 Then Dim bl2(r): Get (1, 1)-(ah, bh), bl2()
    If f = 50 Then Dim bl3(r): Get (1, 1)-(ah, bh), bl3()
    If f = 51 Then Dim bl1m(r): Get (1, 1)-(ah, bh), bl1m()
    If f = 52 Then Dim bl2m(r): Get (1, 1)-(ah, bh), bl2m()
    If f = 53 Then Dim bl3m(r): Get (1, 1)-(ah, bh), bl3m()
    If f = 54 Then Dim dm1(r): Get (1, 1)-(ah, bh), dm1()
    If f = 55 Then Dim dm2(r): Get (1, 1)-(ah, bh), dm2()
    If f = 56 Then Dim dm1m(r): Get (1, 1)-(ah, bh), dm1m()
    If f = 57 Then Dim dm2m(r): Get (1, 1)-(ah, bh), dm2m()
    If f = 58 Then Dim dm3(r): Get (1, 1)-(ah, bh), dm3()
    If f = 59 Then Dim dm3m(r): Get (1, 1)-(ah, bh), dm3m()
    If f = 60 Then Dim mdl(r): Get (1, 1)-(ah, bh), mdl()
    If f = 61 Then Dim mdr(r): Get (1, 1)-(ah, bh), mdr()
    If f = 62 Then Dim mdlm(r): Get (1, 1)-(ah, bh), mdlm()
    If f = 63 Then Dim mdrm(r): Get (1, 1)-(ah, bh), mdrm()
    If f = 64 Then Dim am1(r): Get (1, 1)-(ah, bh), am1()
    If f = 65 Then Dim am2(r): Get (1, 1)-(ah, bh), am2()
    If f = 66 Then Dim am3(r): Get (1, 1)-(ah, bh), am3()
    If f = 67 Then Dim fc(r): Get (1, 1)-(ah, bh), fc()
    If f = 68 Then Dim am3m(r): Get (1, 1)-(ah, bh), am3m()
    If f = 69 Then Dim g13(r): Get (1, 1)-(ah, bh), g13()
    If f = 70 Then Dim g14(r): Get (1, 1)-(ah, bh), g14()
    If f = 71 Then Dim g15(r): Get (1, 1)-(ah, bh), g15()
    If f = 72 Then Dim g16(r): Get (1, 1)-(ah, bh), g16()
    If f = 73 Then Dim g17(r): Get (1, 1)-(ah, bh), g17()
    If f = 74 Then Dim g18(r): Get (1, 1)-(ah, bh), g18()
    If f = 75 Then Dim g19(r): Get (1, 1)-(ah, bh), g19()
    If f = 76 Then Dim g20(r): Get (1, 1)-(ah, bh), g20()
    If f = 77 Then Dim g21(r): Get (1, 1)-(ah, bh), g21()


    Erase dd
Next f
Cls
Screen , , 3, 3

mdat:
Data "gr1","gr2","gr3","wcl","m11l","m12l","m11r","m12r","wod1","wod2"
Data "m11lm","m12lm","m11rm","m12rm","man1","man2","t1r","t1l","t1rm","t1lm"
Data "mr1r","mr2r","mr1l","mr2l","mr1rm","mr2rm","mr1lm","mr2lm","fir","firm"
Data "luk1l","luk1r","luk1lm","luk1rm","cfon1","cfon2","cfon3","cfon4","cfon5","cfon6","cfon7","cfon8","cfon9"
Data "tr1r","tr1l","tr1rm","tr1lm","bl1","bl2","bl3","bl1m","bl2m","bl3m"
Data "dm1","dm2","dm1m","dm2m","dm3","dm3m","mdl","mdr","mdlm","mdrm"
Data "amm1","amm2","amm3","face","amm3m","cfon10","cfon11"
Data "cfon12","cfon13","cfon14","cfon15","cfon16","cfon17","cfon18","cfon19","cfon20"

Randomize 1000
intro = 1: inhod = 1: col = 7: cc = 1
Rem LOCATE 10, 12: PRINT "Program modified": END
Dim a(200, 10)
Dim b(200, 10)
Dim x(100, 10): Dim y(100, 10)
vid = 3
vir = 2
GoSub lod
a = 7: b = 6: h = 1: s = 1: hh = 1: hj = 0: fly = 0: op = 0: hod = 0
wh = 1
bx = 10: by = 10: dx = 4: dy = -.2: fire = 0
hodd = 0
brekhod = 0
Dim aa(100): Dim bb(100): Dim u(100): Dim s(100): Dim die(100)
f = 1

pow = 3: liv = 3: amm = 3: gold = 0: bom = 0

mig = 0: mag = 0
mdm = 0
For x = 1 To 200
    For y = 1 To 10
        If a(x, y) = 6 Then s(f) = -2.5: u(f) = 1: bb(f) = 1: aa(f) = x * 15: GoTo jj
        If a(x, y) = 7 Then s(f) = -4: u(f) = 2: bb(f) = 1: aa(f) = x * 15: GoTo jj
        If a(x, y) = 8 Then s(f) = -4: u(f) = 3: aa(f) = x * 15: bb(f) = y * 15: f = f + 1
        jj0:
    Next y
Next x
GoTo ser
jj:
If b(aa(f) / 15, bb(f) / 15) = 1 Then bb(f) = bb(f) - 15: GoTo jj2
bb(f) = bb(f) + 15
GoTo jj
jj2:
f = f + 1
GoTo jj0
ser:
For f = 1 To 10
    a$ = InKey$
Next f

gg:
Screen , , vid, vir
Screen , , vid, vir
GoSub act
Screen , vid, vid
vid = vid + 1: If vid > 4 Then vid = 2
vir = vir + 1: If vir > 4 Then vir = 2
GoTo gg


act:
If a$ = " " And intro = 1 Then intro = 0: hod = 0
If intro = 1 Then hod = hod + inhod: If hod > 91 Or hod < 1 Then inhod = -inhod
If hod < 2 And hodd < 0 Then hodd = 0
If hod > 91 And hodd > 0 Then hodd = 0: brekhod = 1
If hodd > 0 And brekhod = 0 Then hodd = hodd - 1: hod = hod + 1: a = a - 1: If fire = 1 Then bx = bx - 15
If hodd < 0 And brekhod = 0 Then hodd = hodd + 1: hod = hod - 1: a = a + 1: If fire = 1 Then bx = bx + 15
act2:
bl = Rnd
For yy = 1 To 10
    Put (0, yy * 15), wc(), PSet
    Put (20 * 15, yy * 15), wc(), PSet
Next yy
For x = 1 To 19
    For y = 1 To 10
        If a(x + Int(hod), y) = 1 Then Put (x * 15, y * 15), g1(), PSet: GoTo nn
        If a(x + Int(hod), y) = 2 Then Put (x * 15, y * 15), g2(), PSet: GoTo nn
        If a(x + Int(hod), y) = 3 Then Put (x * 15, y * 15), g3(), PSet: GoTo nn
        If a(x + Int(hod), y) = 4 And wh = 1 Then Put (x * 15, y * 15), w1(), PSet: GoTo nn
        If a(x + Int(hod), y) = 4 And wh = -1 Then Put (x * 15, y * 15), w2(), PSet: GoTo nn
        If a(x + Int(hod), y) = 5 And bl <= .95 Then Put (x * 15, y * 15), m1(), PSet: GoTo nn
        If a(x + Int(hod), y) = 5 And bl > .95 Then Put (x * 15, y * 15), m2(), PSet: GoTo nn
        If a(x + Int(hod), y) = 9 Then Put (x * 15, y * 15), g4(), PSet: GoTo nn
        If a(x + Int(hod), y) = 10 Then Put (x * 15, y * 15), g5(), PSet: GoTo nn
        If a(x + Int(hod), y) = 11 Then Put (x * 15, y * 15), g6(), PSet: GoTo nn
        If a(x + Int(hod), y) = 12 Then Put (x * 15, y * 15), g7(), PSet: GoTo nn
        If a(x + Int(hod), y) = 13 Then Put (x * 15, y * 15), g8(), PSet: GoTo nn
        If a(x + Int(hod), y) = 14 Then Put (x * 15, y * 15), g9(), PSet: GoTo nn
        If a(x + Int(hod), y) = 15 Then Put (x * 15, y * 15), g10(), PSet: GoTo nn
        If a(x + Int(hod), y) = 16 Then Put (x * 15, y * 15), g11(), PSet: GoTo nn
        If a(x + Int(hod), y) = 17 Then Put (x * 15, y * 15), g12(), PSet: GoTo nn
        If a(x + Int(hod), y) = 18 Then Put (x * 15, y * 15), am1(), PSet: GoTo nn
        If a(x + Int(hod), y) = 19 Then Put (x * 15, y * 15), am2(), PSet: GoTo nn
        If a(x + Int(hod), y) = 20 Then Put (x * 15, y * 15), am3(), PSet: GoTo nn
        If a(x + Int(hod), y) = 21 Then Put (x * 15, y * 15), g13(), PSet: GoTo nn
        If a(x + Int(hod), y) = 22 Then Put (x * 15, y * 15), g14(), PSet: GoTo nn
        If a(x + Int(hod), y) = 23 Then Put (x * 15, y * 15), g15(), PSet: GoTo nn
        If a(x + Int(hod), y) = 24 Then Put (x * 15, y * 15), g16(), PSet: GoTo nn
        If a(x + Int(hod), y) = 25 Then Put (x * 15, y * 15), g17(), PSet: GoTo nn
        If a(x + Int(hod), y) = 26 Then Put (x * 15, y * 15), g18(), PSet: GoTo nn
        If a(x + Int(hod), y) = 27 Then Put (x * 15, y * 15), g19(), PSet: GoTo nn
        If a(x + Int(hod), y) = 28 And bl > .7 Then Put (x * 15, y * 15), g21(), PSet: GoTo nn
        If a(x + Int(hod), y) = 28 And bl <= .7 Then Put (x * 15, y * 15), g20(), PSet: GoTo nn
        If a(x + Int(hod), y - 1) = 28 Or a(x + Int(hod), y - 1) = 27 Then Put (x * 15, y * 15), wc(), PSet: GoSub dddd: For ddt = 1 To 10: ddx = Rnd * 5 + 5: ddy = Rnd * ddd: PSet (x * 15 + ddx, y * 15 + ddy), 12: Next ddt: GoTo nn
        Put (x * 15, y * 15), wc(), PSet
        nn:
    Next y
    If mdm = 0 And intro = 0 Then GoSub kli
Next x
If intro = 1 Then GoSub intr: Return
If a <> hh Then h = -h: op = 1
If op1 = 1 Then op = 1
op1 = 0
hh = a
If b(a + hod, b + .9) = 0 Then fly = 1: b = b + hj: h = -1 Else fly = 0
If b(a + hod, b + .8) <> 0 Then b = b - .1: h = 1
If b(a + hod, b - .5) <> 0 Or b < 1.5 Then hj = .1
If hj < .5 Then hj = hj + .1
If a(a + hod - .2, b + .8) = 5 Then a(a + hod - .2, b + .8) = 0: gold = gold + 1: If gold > 9 Then gold = 0: liv = liv + 1
If a(a + hod - .2, b + .8) = 18 Then a(a + hod - .2, b + .8) = 0
If a(a + hod - .2, b + .8) = 19 Then a(a + hod - .2, b + .8) = 0: amm = amm + 1
If a(a + hod - .2, b + .8) = 20 Then a(a + hod - .2, b + .8) = 0: bom = bom + 1

If mdm <> 0 Then GoSub md: GoTo mf
If s = 1 And h = 1 And mig <> 1 Then Put (a * 15, b * 15), h1lm(), And: Put (a * 15, b * 15), h1l(), Xor
If s = 1 And h = -1 And mig <> 1 Then Put (a * 15, b * 15), h2lm(), And: Put (a * 15, b * 15), h2l(), Xor
If s = -1 And h = 1 And mig <> 1 Then Put (a * 15, b * 15), h1rm(), And: Put (a * 15, b * 15), h1r(), Xor
If s = -1 And h = -1 And mig <> 1 Then Put (a * 15, b * 15), h2rm(), And: Put (a * 15, b * 15), h2r(), Xor
mf:
If a > 15 Then hodd = 8
If a < 6 And hod > 1 Then hodd = -8
If fly = 1 Then GoSub ts: If t = 0 Then a = a + s / 3
wsp = wsp + 1: If wsp > 2 Then wsp = 0: wh = -wh
If fly = 0 Then op = 0
If brekhod = 0 Then GoSub mon
If fire = 1 Then If bx / 15 > 20 Or bx / 15 < 1 Then fire = 0: If bom > 0 Then bom = bom - 1
If b(bx / 15 + hod, by / 15) <> 0 And fire = 1 Then fire = 0: If bom > 0 Then bom = bom - 1
If fire = 1 And bom <= 0 Then Put (bx, by), ffm(), And: Put (bx, by), ff(), Xor: bx = bx + dx
If fire = 1 And bom > 0 Then Put (bx, by), am3m(), And: Put (bx, by), am3(), Xor: bx = bx + dx
Rem LOCATE 1, 1: PRINT mig; " "
ktm = ktm + 1
If mig <> 0 Then mig = mig + 1: If mig > 3 Then mig = 1
mag = mag - 1: If mag < 0 Then mig = 0
If mdm > 20 Then Locate 9, 14: Color 11: Print "Но это не конец"
GoSub panel
Return

md:
If s = -1 Then Put (a * 15, b * 15 + 1), mdrm(), And: Put (a * 15, b * 15 + 1), mdr(), Xor
If s = 1 Then Put (a * 15, b * 15 + 1), mdlm(), And: Put (a * 15, b * 15 + 1), mdl(), Xor
mdm = mdm + 1: If mdm = 50 Then End
Return

kli:

Limit 250

a$ = InKey$

' Exit program
If a$ = Chr$(27) Then System 0

' Left & right
If a$ = Chr$(0) + Chr$(75) And fly = 0 Then ktm = 0: s = -1: GoSub ts: If t = 0 Then a = a - .2
If a$ = Chr$(0) + Chr$(77) And fly = 0 Then ktm = 0: s = 1: GoSub ts: If t = 0 Then a = a + .2

' Jump
If a$ = Chr$(0) + Chr$(72) And fly = 0 And b > 2 Then hj = -.6: b = b - .2

' Left & right?
If a$ = Chr$(0) + Chr$(75) And fly = 1 Then op1 = 1: s = -1
If a$ = Chr$(0) + Chr$(77) And fly = 1 Then op1 = 1: s = 1

' Shoot
If a$ = Chr$(32) And fire = 0 Then fire = 1: GoSub firs

Return

firs:
If s = -1 Then bx = a * 15 - 10: by = b * 15 + 5: dx = -10
If s = 1 Then bx = a * 15 + 10: by = b * 15 + 5: dx = 10
If bom > 0 Then by = b * 15
Return

ts:
t = 0
If s = 1 Then If b(a + hod + .6, b + .6) = 1 Then t = 1
If s = -1 Then If b(a + hod - .6, b + .6) = 1 Then t = 1
If s = -1 And a < 1.5 Then t = 1
If ktm > 2 And op = 0 And fly = 1 Then t = 1
Return

mon:
For f = 1 To 100
    aaa = 0
    If hodd > 0 Then aa(f) = aa(f) - 15: aaa = 15: For sz = 1 To 10: x(f, sz) = x(f, sz) - 15: Next sz
    If hodd < 0 Then aa(f) = aa(f) + 15: aaa = -15: For sz = 1 To 10: x(f, sz) = x(f, sz) + 15: Next sz
    If die(f) <> 0 Then GoSub dm: GoTo ccc2
    If aa(f) / 15 > 1 And aa(f) / 15 < 19 Then GoTo ccc
    GoTo ccc2
    ccc:
    If fire = 1 And die(f) = 0 And bx > aa(f) - 5 And bx < aa(f) + 20 And by > bb(f) - 10 And by < bb(f) + 15 Then die(f) = -1: GoSub bm: For sz = 1 To 10: x(f, sz) = aa(f) + Rnd * 15: y(f, sz) = bb(f) + Rnd * 5: Next sz: GoTo ccc2
    If u(f) = 1 Then GoSub mon1
    If u(f) = 2 Then GoSub mon2
    If u(f) = 3 Then GoSub mon3
    If mig = 0 And a > aa(f) / 15 - 1 And a < aa(f) / 15 + 1 And b > bb(f) / 15 - 1 And b < bb(f) / 15 + 1 Then mag = 50: mig = 1: pow = pow - 1: If pow <= 0 Then mdm = 1
    ccc2:
    If die(f) <> 0 Then die(f) = die(f) - 1: GoSub mbl
    If die(f) = 0 Then x(f, 1) = aa(f): y(f, 1) = bb(f)
Next f
Return

bm:
If bom > 0 Then fire = 1 Else fire = 0
Return

dm:
If aa(f) / 15 > 1 And aa(f) / 15 < 19 Then GoTo dmm
Return
dmm:
If u(f) = 3 And bb(f) < 143 Then yu = b(aa(f) / 15 + hod + aaa / 15, bb(f) / 15 + .9)
If u(f) = 3 And bb(f) < 143 And a(aa(f) / 15 + hod + aaa / 15, bb(f) / 15) = 4 Then bb(f) = bb(f) - Rnd: GoTo dmmm
If u(f) = 3 And yu <> 1 Then bb(f) = bb(f) + 3
dmmm:
If u(f) = 1 Then Put (aa(f) + aaa, bb(f)), dm1m(), And: Put (aa(f) + aaa, bb(f)), dm1(), Xor
If u(f) = 2 Then Put (aa(f) + aaa, bb(f)), dm2m(), And: Put (aa(f) + aaa, bb(f)), dm2(), Xor
If u(f) = 3 And bb(f) < 143 Then Put (aa(f) + aaa, bb(f)), dm3m(), And: Put (aa(f) + aaa, bb(f)), dm3(), Xor
Return

mbl:
If y(f, 1) > 150 Then Return
For sz = 1 To 10
    For ssz = 1 To 2
        PSet (x(f, sz) + aaa + Rnd * 2, y(f, sz) + Rnd * 2 + 7), 12
        PSet (x(f, sz) + aaa + Rnd * 2, y(f, sz) + Rnd * 2 + 7), 4
    Next ssz
    y(f, sz) = y(f, sz) - die(f) / 5 - 2
    x(f, sz) = x(f, sz) + Rnd * 6 - 3
Next sz
Return

mon1:
If b(aa(f) / 15 + hod + .5 + aaa / 15, bb(f) / 15 + 1) <> 1 Then s(f) = -2.5
If b(aa(f) / 15 + hod - .5 + aaa / 15, bb(f) / 15 + 1) <> 1 Then s(f) = 2.5
If b(aa(f) / 15 + hod + .5 + aaa / 15, bb(f) / 15) = 1 Then s(f) = -2.5
If b(aa(f) / 15 + hod - .5 + aaa / 15, bb(f) / 15) = 1 Then s(f) = 2.5

aa(f) = aa(f) + s(f)
If s(f) = 2.5 And wh = 1 Then Put (aa(f) + aaa, bb(f) - 5), t1rm(), And: Put (aa(f) + aaa, bb(f) - 5), t1r(), Xor
If s(f) = 2.5 And wh = -1 Then Put (aa(f) + aaa, bb(f) - 5), tr1lm(), And: Put (aa(f) + aaa, bb(f) - 5), tr1l(), Xor
If s(f) = -2.5 And wh = 1 Then Put (aa(f) + aaa, bb(f) - 5), t1lm(), And: Put (aa(f) + aaa, bb(f) - 5), t1l(), Xor
If s(f) = -2.5 And wh = -1 Then Put (aa(f) + aaa, bb(f) - 5), tr1rm(), And: Put (aa(f) + aaa, bb(f) - 5), tr1r(), Xor
Return

mon2:
If b(aa(f) / 15 + hod + .5 + aaa / 15, bb(f) / 15 + 1) <> 1 Then s(f) = -4
If b(aa(f) / 15 + hod - .5 + aaa / 15, bb(f) / 15 + 1) <> 1 Then s(f) = 4
If b(aa(f) / 15 + hod + .5 + aaa / 15, bb(f) / 15) = 1 Then s(f) = -4
If b(aa(f) / 15 + hod - .5 + aaa / 15, bb(f) / 15) = 1 Then s(f) = 4

aa(f) = aa(f) + s(f)
If s(f) = 4 And wh = 1 Then Put (aa(f) + aaa, bb(f)), mr1rm(), And: Put (aa(f) + aaa, bb(f)), mr1r(), Xor
If s(f) = 4 And wh = -1 Then Put (aa(f) + aaa, bb(f)), mr2rm(), And: Put (aa(f) + aaa, bb(f)), mr2r(), Xor
If s(f) = -4 And wh = 1 Then Put (aa(f) + aaa, bb(f)), mr1lm(), And: Put (aa(f) + aaa, bb(f)), mr1l(), Xor
If s(f) = -4 And wh = -1 Then Put (aa(f) + aaa, bb(f)), mr2lm(), And: Put (aa(f) + aaa, bb(f)), mr2l(), Xor
Return

mon3:
If b(aa(f) / 15 + hod + .5 + aaa / 15, bb(f) / 15) = 1 Then s(f) = -4
If b(aa(f) / 15 + hod - .5 + aaa / 15, bb(f) / 15) = 1 Then s(f) = 4
If b(aa(f) / 15 + hod + .5 + aaa / 15, bb(f) / 15 + 1) = 1 Then s(f) = -4
If b(aa(f) / 15 + hod - .5 + aaa / 15, bb(f) / 15 + 1) = 1 Then s(f) = 4

If aa(f) / 15 > 18 Then s(f) = -4
If aa(f) / 15 < 2 Then s(f) = 4
aa(f) = aa(f) + s(f)
If s(f) = 4 Then Put (aa(f) + aaa, bb(f)), lkrm(), And: Put (aa(f) + aaa, bb(f)), lkr(), Xor
If s(f) = -4 Then Put (aa(f) + aaa, bb(f)), lklm(), And: Put (aa(f) + aaa, bb(f)), lkl(), Xor
Return

intr:
Locate 1, 1: Print "  Press ~SPACE~"
For f = 0 To 14
    For y = 0 To 10
        For x = 0 + f * 8 To 7 + f * 8
            aa = Point(x, y)
            If aa <> 0 Then PSet (x + 105, y + 120), 4
            If aa <> 0 And Rnd > y / 10 Then PSet (x + 105, y + 120), 12
        Next x
    Next y
Next f
Locate 1, 1: Print " * DEMO *       "
For y = 0 To 10
    For x = 0 To 72
        aa = Point(x, y)
        For vb = 1 To 6
            If aa <> 0 Then PSet (x * 2 + 90 + Rnd * 2, y * 2 + 20 + Rnd * (y + 2)), 12
        Next vb
    Next x
Next y
Locate 1, 1: Print "              ": Color 15
a$ = InKey$
Delay 0.1
Return

panel:
Put (16, 0), fc(), PSet
Locate 2, 6: Print "*"; liv
Put (76, 0), am1(), PSet
Locate 2, 13: Print "*"; pow
Put (136, 0), am3(), PSet
Locate 2, 20: Print "*"; bom
Put (196, 0), m1(), PSet
Locate 2, 28: Print "*"; gold
Put (256, 0), am2(), PSet
Locate 2, 36: Print "*"; amm
Return


dddd:
ddd = 1
ddd1:
If Rnd > .9 Then Return
ddd = ddd + 1: If ddd > 15 Then Return
GoTo ddd1

lod:
Open "demap.vir" For Input As #2
For sx = 1 To 200
    For sy = 1 To 10
        Input #2, a(sx, sy)
        Input #2, b(sx, sy)
    Next sy
Next sx
Close #2
Return

