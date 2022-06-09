'simple program in qbasic
'02/01/99
'if you want to tell me something on my prog or something else
'e mail me
'darokin@infonie.fr
'darokin        use it free and learn  (i know you can't learn
'                                       whith this but if that could help
'                                       someone ....)
'darokin '99
$NoPrefix

$Resize:Smooth
Screen 13
FullScreen SquarePixels , Smooth

etoile% = 150
Dim x%(1 To etoile%)
Dim y%(1 To etoile%)
Dim c%(1 To etoile%)
Dim v%(1 To etoile%)
For i% = 1 To etoile%
    x%(i%) = Int(Rnd * 320)
    y%(i%) = Int(Rnd * 129) + 40
    c%(i%) = Int(Rnd * 15) + 15
    v%(i%) = Int(Rnd * 3) + 2
Next i%

Dim txt(97)
Print "darokin"
Get (0, 0)-(54, 6), txt()

Cls

Dim balle(120)
Data 00,00,00,00,04,04,04,00,00,00,00
Data 00,00,04,04,04,04,04,04,04,00,00
Data 00,04,04,15,15,04,04,04,04,04,00
Data 00,04,04,15,15,04,04,04,04,04,00
Data 04,04,04,04,04,04,04,04,04,04,04
Data 04,04,04,04,04,04,04,04,04,04,04
Data 00,04,04,04,04,04,04,04,04,04,00
Data 00,04,04,04,04,04,04,04,04,04,00
Data 00,00,04,04,04,04,04,04,04,00,00
Data 00,00,00,00,04,04,04,00,00,00,00

xlenght = 11
ylenght = 10

For y% = 1 To ylenght
    For x% = 1 To xlenght
        Read z
        PSet (x%, y%), z
    Next x%
Next y%


x = 15: y = 55: xtxt = 35: ytxt = 3
xmax = 305: ymax = 160: xtxtmax = 200: ytxtmax = 15
a = 1: b = 1: c = 1: d = 1: e = 1
xmin = 5: ymin = 39: xtxtmin = 30: ytxtmin = 1
Get (0, 0)-(11, 10), balle()
Cls
Put (20, 5), txt()
Randomize Timer
Do
    Put (x, y), balle()
    For i% = 1 To etoile%
        PSet (x%(i%), y%(i%)), c%(i%)
        PSet (x%(i%), y%(i%)), 0
        x%(i%) = x%(i%) + v%(i%)
        If x%(i%) >= 320 Then
            x%(i%) = 1
            y%(i%) = Int(Rnd * 129) + 40
            c%(i%) = Int(Rnd * 15) + 15
            v%(i%) = Int(Rnd * 3) + 2
        End If
        PSet (x%(i%), y%(i%)), c%(i%)
    Next i%
    Put (xtxt, ytxt), txt()
    If c = 1 Then Cls
    c = c + 1
    If xtxt < xtxtmin Then d = -d
    If x < xmin Then a = -a
    If xtxt > xtxtmax Then d = -d
    If x > xmax Then a = -a
    If ytxt < ytxtmin Then e = -e
    If y < ymin Then b = -b
    If ytxt > ytxtmax Then e = -e
    If y > ymax Then b = -b
    x = x + a
    y = y + b
    xtxt = xtxt + d
    ytxt = ytxt + e
    Put (x, y), balle()
    Put (xtxt, ytxt), txt()
    For i = 1 To 5000
    Next i

    Limit 60
Loop While InKey$ = ""

System 0


