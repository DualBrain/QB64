Const xmax = 512, ymax = 512
_Title "Bubble Universe - ESC to exit" ' from johnno at RCBasic forum 2022-11-14
Screen _NewImage(xmax, ymax, 32)
' ---------------
' Paul Dunn posted this code but for SpecBAS in a facebook group.
' It looked so cool that I had to  rewrite it in Naalaa 7. Marcus
'
' bplus QB64 Mod of RCB version by Johnno56
TAU = 6.283185307179586
n = 200
r = TAU / 235
x = 0
y = 0
v = 0
t = 0
hw = xmax / 2
hh = ymax / 2
Do
    Color _RGB32(0, 0, 0)
    Cls
    For i = 0 To n
        For j = 0 To n
            u = Sin(i + v) + Sin(r * i + x)
            v = Cos(i + v) + Cos(r * i + x)
            x = u + t
            Color _RGB(i, j, 99)
            PSet (hw + u * hw * 0.4, hh + v * hh * 0.4)
        Next
    Next
    t = t + 0.001 ' slowed way way down from .025
    _Display
    _Limit 30
Loop Until _KeyDown(27)


