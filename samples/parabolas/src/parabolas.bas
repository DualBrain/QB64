'#lang "qb"              ' freebasic edit 2011-06
delayconst = 900000 ' freebasic edit 2011-06
'CLEAR                  ' freebasic edit 2011-06

Cls
Screen 12
Randomize Timer

Locate 1, 2: Input "Enter number of particles (default is 80): ", num
If num = 0 Then num = 80
Dim x(num), y(num), xold(num), yold(num), v0x(num), v0y(num), col(num)

start:
Cls
iterations = 0
'g = RND * 10 + 20
g = Rnd * 15 + 25
xdamp = Rnd * .15 + .55
ydamp = Rnd * .15 + .55
exploderadius = 200 '75
numobstacles = 0
iterationmax = 1200

choosecol:
bgcol = Int(Rnd * 14)
wallcol = 0 'INT(RND * 14)'change to zero for spider mode
If bgcol = wallcol Then GoTo choosecol

Line (1, 1)-(639, 479), bgcol, BF
Line (1, 1)-(639, 479), wallcol, B

'Draw obstacles randomly.
For i = 1 To numobstacles
    Line (Rnd * 640, Rnd * 480)-(Rnd * 640, Rnd * 480), wallcol, B
Next i

'Make predetermined obstacles.
'LINE (50, 75)-(600, 125), wallcol, B

'Toggle for random starting position.
xshift = Rnd * 640
yshift = Rnd * 480
'Toggle for fixed starting position
'xshift = 100
'yshift = 100

For i = 1 To num
    speed = Rnd * 90
    ang1 = Rnd * 2 * 3.141592653589793#
    ang2 = Rnd * 2 * 3.141592653589793#
    x(i) = xshift + Rnd * exploderadius * Cos(ang1)
    y(i) = yshift + Rnd * exploderadius * Sin(ang1)
    v0x(i) = 1.5 * speed * Cos(ang2)
    v0y(i) = speed * Sin(ang2)
    dotcol:
    col(i) = Int(Rnd * 13 + 1)
    If col(i) = bgcol Or col(i) = wallcol Then GoTo dotcol
    If Point(x(i), y(i)) = wallcol Or x(i) < 1 Or x(i) > 639 Or y(i) < 1 Or y(i) > 479 Then i = i - 1
    dv = Sqr((v0x(i)) ^ 2 + (v0y(i)) ^ 2)
    If dv > vmax Then vmax = dv
    PSet (x(i), y(i)), col(i)
Next

dt = .995 / vmax

Sleep 1

Do
    idel = 0: Do: idel = idel + 1: Loop Until idel > delayconst ' freebasic edit 2011-06

    iterations = iterations + 1
    smax = 0
    For i = 1 To num
        xold(i) = x(i)
        yold(i) = y(i)
        v0x(i) = v0x(i) + 0 * dt
        v0y(i) = v0y(i) + g * dt
        xtmp = x(i) + v0x(i) * dt
        ytmp = y(i) + v0y(i) * dt
        If Point(xtmp, yold(i)) = wallcol Then v0x(i) = v0x(i) * -1 * xdamp
        If Point(xold(i), ytmp) = wallcol Then v0y(i) = v0y(i) * -1 * ydamp
        x(i) = x(i) + v0x(i) * dt
        y(i) = y(i) + v0y(i) * dt
        'Recolor stagnant particles.
        xx = x(i) - xold(i)
        yy = y(i) - yold(i)
        If Sqr(xx ^ 2 + yy ^ 2) < .05 Then col(i) = bgcol
        PSet (xold(i), yold(i)), 0 'bgcol
        PSet (x(i), y(i)), col(i)
        ds = Sqr((y(i) - yold(i)) ^ 2 + (x(i) - xold(i)) ^ 2)
        If ds > smax Then smax = ds
    Next
    If smax > .95 Then dt = dt * (1 - .01)
    If smax < .9 Then dt = dt * (1 + .01)
    If iterations > iterationmax Then
        Sleep 2
        GoTo start
    End If
    Line (19, 459)-(151, 471), wallcol, B
    Line (20, 460)-(20 + 130 * (iterations / iterationmax), 470), 15, BF
Loop Until InKey$ <> ""
End

