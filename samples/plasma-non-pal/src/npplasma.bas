'///Non Palette rotated plasma
'///Relsoft 2003
'///Compile and see the speed.  Didn't optimize it as much as I want though...

$NoPrefix

$Resize:Smooth
Screen 13
FullScreen SquarePixels , Smooth

Dim Lsin1%(-1024 To 1024), Lsin2%(-1024 To 1024), Lsin3%(-1024 To 1024)
For I% = -1024 To 1024
    Lsin1%(I%) = Sin(I% / (128)) * 256 'Play with these values
    Lsin2%(I%) = Sin(I% / (64)) * 128 'for different types of fx
    Lsin3%(I%) = Sin(I% / (32)) * 64 ';*)
    If I% > -1 And I% < 256 Then Palette I%, 65536 * (Int(32 - 31 * Sin(I% * 3.14151693# / 128))) + 256 * (Int(32 - 31 * Sin(I% * 3.14151693# / 64))) + (Int(32 - 31 * Sin(I% * 3.14151693# / 32)))
Next
Def Seg = &HA000
Dir% = 1
Do
    Counter& = (Counter& + Dir%)
    If Counter& > 600 Then Dir% = -Dir%
    If Counter& < -600 Then Dir% = -Dir%
    Rot% = 64 * (((Counter& And 1) = 1) Or 1)
    StartOff& = 0
    For y% = 0 To 199
        For x% = 0 To 318
            Rot% = -Rot%
            C% = Lsin3%(x% + Rot% - Counter&) + Lsin1%(x% + Rot% + Counter&) + Lsin2%(y% + Rot%)
            Poke StartOff& + x%, C%
        Next
        StartOff& = StartOff& + 320
    Next
    Limit 60
Loop Until InKey$ <> ""

System 0
