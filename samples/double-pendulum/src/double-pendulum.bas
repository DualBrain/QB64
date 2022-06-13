DefDbl A-Z: DefInt I-J, N
n = 5: nn = 0
Dim x(n), xx(n), f(n), c(4, n)
nextone:
Screen 0: Cls
_FullScreen
' option here to get the x-scale NOT magnified as in popular modern monitors
GoSub graphics
GoSub startup

agn:
Cls
Line (0, -a)-(0, a), 8
ph = -a * Cos(w * x(5))
Circle (0, ph), .025, 12: Paint (0, ph), 12
X1 = Sin(xx(1))
X2 = -Cos(xx(1)) + ph
X3 = Sin(xx(1)) + Sin(xx(3))
X4 = -Cos(xx(1)) - Cos(xx(3)) + ph
Line (0, ph)-(X1, X2), 12
Circle (X1, X2), .05, 9: Paint (X1, X2), 9
Line (X1, X2)-(X3, X4), 12
Circle (X3, X4), .05, 9: Paint (X3, X4), 9
_Delay .001
GoSub Runge
t = t + h
Locate 21, 6: Print CSng(t)
a$ = InKey$: If a$ = "" Then GoTo agn Else GoTo nextone

Equations:
Q = x(3) - x(1)
c = Cos(Q)
s = Sin(Q)
P = c * s
D = 1# - m * c ^ 2#
g = (1# + a * w ^ 2# * Cos(w * x(5)))
g1 = g * Sin(x(1))
g3 = g * Sin(x(3))
x22 = x(2) ^ 2#
x42 = x(4) ^ 2#
f(1) = x(2)
f(2) = -k * x(2) + (m * (x42 * s + x22 * P + g3 * c) - g1) / D
f(3) = x(4)
f(4) = -k * x(4) + (-x22 * s - m * x42 * P - g3 + g1 * c) / D
f(5) = 1#
Locate 7, 5: Print x(1)
Locate 8, 5: Print x(2)
Locate 9, 5: Print x(3)
Locate 10, 5: Print x(4)
Locate 11, 5: Print x(5)
_Display
Return

Runge:
For i = 1 To n: x(i) = xx(i): Next
GoSub Equations
For i = 1 To n: c(1, i) = h * f(i): Next
For i = 1 To n: x(i) = xx(i) + c(1, i) / 2#: Next
GoSub Equations
For i = 1 To n: c(2, i) = h * f(i): Next
For i = 1 To n: x(i) = xx(i) + c(2, i) / 2#: Next
GoSub Equations
For i = 1 To n: c(3, i) = h * f(i): Next
For i = 1 To n: x(i) = xx(i) + c(3, i): Next
GoSub Equations
For i = 1 To n: c(4, i) = h * f(i): Next
For i = 1 To n
    xx(i) = xx(i) + (c(1, i) + 2# * c(2, i) + 2# * c(3, i) + c(4, i)) / 6#
Next
Return

graphics:
Cls: Screen 9
Paint (1, 1), 9
View (220, 17)-(595, 330), 0, 14
Window (-3.6, -2.4)-(3.6, 2.8)
Locate 21, 2: Print "Time"
Return

startup:
k = .1#: m = .1#: xx(2) = 0: xx(4) = 0
'nn = 2
Select Case nn

    Case O
        k = .05#: m = .1#: xx(2) = 0: xx(4) = 0: xx(1) = .4: xx(3) = -.2
        Print "viscous damping k=0.05"
    Case 1
        k = 0#: m = .1#: xx(2) = 0: xx(4) = 0: xx(1) = 0: xx(3) = 3.1428
        Locate 5, 2
        Print " no viscous damping "
    Case 2
        a = .2: w = 10: xx(1) = 3.1: xx(3) = 1 'stable yet semi-hanging
        Locate 3, 1
        Print "stable yet top-hanging"
    Case 3
        a = .1: w = 3.696#: xx(1) = .01: xx(3) = .01: m = .5# 'fast mode
        Locate 3, 1
        Print "    fast-pump mode    "
    Case 4
        a = .1: w = 1.55#: xx(1) = .01: xx(3) = .01: m = .5#: k = .03# 'slow mode
        Locate 3, 1
        Print "    slow-pump mode    "
    Case 5
        a = .1: w = 1.55#: xx(1) = .1: xx(3) = .2: m = .5# 'k=.1 too much for slow
        Locate 3, 1
        Print " damping k=0.1 is too "
        Locate 4, 1
        Print "  much for slow mode  "
    Case 6
        a = .1: w = 2: xx(1) = .32: xx(3) = .32 'goes to down-hanging
        Locate 4, 1
        Print " goes to down-hanging "
    Case 7
        a = .1: w = 2: xx(1) = 1: xx(3) = -1 'stable fast swing
        Locate 3, 2
        Print "  stable fast swing "
    Case 8
        a = .25: w = 2: xx(1) = 1.5: xx(3) = -1.5 'stable fast swing
        Locate 3, 2
        Print "  stable fast swing "
    Case 9
        a = .25#: w = 2#: xx(1) = 1: xx(3) = -1: x(2) = 5: x(4) = 5: k = .05 'whirling
        Locate 3, 2
        Print "  whirling dervrish "
    Case 10
        m = .5#: k = .2#: xx(1) = 2.5: xx(3) = 1.9: a = .1: w = 25 'a<.3;w>1.85/a
        Locate 3, 2
        Print " Indian Rope Trick! "
    Case 11
        m = .5#: k = .2#: xx(1) = 2.6: xx(3) = -3.1: a = .1: w = 25 'a<.3;w>1.85/a
        Locate 3, 3
        Print "  teeter-totter "
    Case 12
        m = .5#: k = .2#: xx(1) = 3.1: xx(3) = 3.2: a = .04: w = 25 'collapse 1
        Locate 3, 4
        Print "   surprise!  "
    Case 13
        m = .5#: k = .2#: xx(1) = 3.1: xx(3) = 3.2: a = .15#: w = 25 'collapse 2
        Locate 3, 2
        Print "  this IS demo 13! "
    Case 14
        m = .5#: k = .2#: xx(1) = 3.05#: xx(3) = 3.25#: a = .11#: w = 25 'a<.3;w>1.85/a
    Case Is > 15
        Screen 0: Cls: Print "Only maths and physics types live in a LINEAR delusion"
        Print " where you can uncook eggs and correct errors!": End
End Select
If nn > 1 Then
    Locate 5, 4
    Print " damping k=";: Print Using "#.##"; k
Else
    Locate 3, 3
    Print " A double pendulum"
    Locate 4, 3
    Print "   swinging with  "
End If
Locate 25, 1: Print "press any key for next demo";
'IF nn < 0 THEN LOCATE 12, 2: INPUT "a,w"; a, w
t = 0#: xx(5) = 0#
'IF nn > 0 THEN LOCATE 14, 2: INPUT "ang1,ang2"; xx(1), xx(3)
h = .005#
nn = nn + 1
Return

