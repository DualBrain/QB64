Screen _NewImage(800, 600, 32)

Do Until _ScreenExists: Loop

$ExeIcon:'./assets/Jaan-Jaak-Weather-Rain.ico'
'http://www.iconarchive.com/show/weather-icons-by-jaan-jaak/rain-icon.html
'Artist: Jaan-Jaak
'Iconset: Weather Icons (9 icons)
'License: CC Attribution-Share Alike 4.0
'Commercial usage: Allowed
_Icon

$VersionInfo:FILEVERSION#=0,0,0,1
$VersionInfo:PRODUCTVERSION#=0,0,0,1
$VersionInfo:CompanyName=Fellippe Heitor
$VersionInfo:FileDescription=Set Fire To The Rain game
$VersionInfo:FileVersion=0.1b
$VersionInfo:InternalName=setfire.bas
$VersionInfo:LegalCopyright=Open source
$VersionInfo:OriginalFilename=setfire.exe
$VersionInfo:ProductName=Set Fire To The Rain game
$VersionInfo:ProductVersion=0.1b
$VersionInfo:Comments=This is in no way shape or form endorsed by Adele. Made with QB64.
$VersionInfo:Web=http://www.qb64.net/forum/index.php?topic=14285.msg123566#msg123566

_Title "Set fire to the rain"

Color , 0

Type gridType
    x As Single
    y As Single
    xv As Single
    yv As Single
    size As Integer
    color As Single
End Type

s = 10

Dim grid(1 To Int(_Width / s), 1 To Int(_Height / s)) As gridType
Dim rainDrops(1 To 1000) As gridType
Dim smoke(1 To 1000) As gridType, smokeIndex As Integer

Dim Shared bgmusic As Long, theFont As Long

theFont = _LoadFont("ariblk.ttf", 32)
If theFont > 0 Then _Font theFont

m$ = "Get ready..."
_PrintString (_Width / 2 - _PrintWidth(m$) / 2, _Height / 2 - _FontHeight / 2), m$

f$ = "assets/setfire.mp3"
'from https://www.youtube.com/watch?v=sHosuM4TlFU
'http://www.mediafire.com/?jy4id9645i88kko
bgmusic = _SndOpen(f$, "vol,pause,setpos")

If bgmusic > 0 Then
    _SndSetPos bgmusic, 4.3
    _SndPlay bgmusic
End If

GoSub ResetRain

Do
    GoSub resetFire

    start# = Timer

    Do
        While _MouseInput: Wend

        Cls

        For i = 1 To UBound(smoke)
            If smoke(i).color > 0 Then
                Line (smoke(i).x, smoke(i).y)-Step(s - 1, s - 1), _RGB32(smoke(i).color, smoke(i).color, smoke(i).color), BF
                smoke(i).color = smoke(i).color - 10
                smoke(i).x = smoke(i).x
                smoke(i).y = smoke(i).y - s
            End If
        Next

        GoSub UpdateRain

        fullFire = -1
        For i = 1 To UBound(grid, 1)
            For j = 1 To UBound(grid, 2)
                If grid(i, j).color > 0 Then
                    Line (grid(i, j).x, grid(i, j).y)-Step(grid(i, j).size - 1, grid(i, j).size - 1), _RGB32(grid(i, j).color, map(grid(i, j).y, 0, _Height - 1, grid(i, j).color, grid(i, j).color / 3), 0), BF
                End If
                If grid(i, j).color < 255 Then fullFire = 0
                If grid(i, j).color > 245 Then GoSub addSmoke
            Next
        Next

        If _MouseX > 0 And _MouseY > 0 Then
            i = Int(_MouseX / s) + 1
            j = Int(_MouseY / s) + 1
            If _MouseButton(1) Then
                grid(i, j).color = 255
            End If
        End If

        radius = 2
        For i = 1 To UBound(grid, 1)
            For j = 1 To UBound(grid, 2)
                If grid(i, j).color > 150 Then
                    For k = -radius To radius
                        For l = -radius To radius
                            If i + k < 1 Or j + l < 1 Then GoTo skip
                            If i + k > UBound(grid, 1) Or j + l > UBound(grid, 2) Then GoTo skip
                            grid(i + k, j + l).color = grid(i + k, j + l).color + 2
                            If grid(i + k, j + l).color > 255 Then grid(i + k, j + l).color = 255
                            skip:
                        Next
                    Next
                ElseIf grid(i, j).color = 0 Then
                    For k = -radius To radius
                        For l = -radius To radius
                            If i + k < 1 Or j + l < 1 Then GoTo skip2
                            If i + k > UBound(grid, 1) Or j + l > UBound(grid, 2) Then GoTo skip2
                            grid(i + k, j + l).color = grid(i + k, j + l).color - 1.5
                            If grid(i + k, j + l).color < 0 Then grid(i + k, j + l).color = 0
                            skip2:
                        Next
                    Next
                End If
            Next
        Next

        _PrintString (0, _Height - _FontHeight), Str$(Int(Timer - start#)) + " s"

        k = _KeyHit
        If k = 27 Then System

        If k = Asc("m") Or k = Asc("M") Then
            mute = Not mute
            If bgmusic > 0 Then
                If _SndPlaying(bgmusic) Then
                    _SndPause bgmusic
                    _SndSetPos bgmusic, 4.3
                End If
            End If
        End If

        _Limit 60
        _Display
        If bgmusic > 0 Then
            If Not _SndPlaying(bgmusic) And Not mute Then _SndPlay bgmusic
        End If
    Loop Until fullFire

    finish# = Timer

    If bgmusic > 0 Then
        _SndSetPos bgmusic, 64.5
        If Not _SndPlaying(bgmusic) And Not mute Then _SndPlay bgmusic
    End If

    While _MouseButton(1): i = _MouseInput: Wend
    GoSub ResetRain
    Do
        While _MouseInput: Wend

        Cls

        For i = 1 To UBound(grid, 1)
            For j = 1 To UBound(grid, 2)
                If grid(i, j).color > 0 Then
                    Line (grid(i, j).x, grid(i, j).y)-Step(grid(i, j).size, grid(i, j).size), _RGB32(grid(i, j).color, map(grid(i, j).y, 0, _Height - 1, grid(i, j).color, grid(i, j).color / 3), 0), BF
                    grid(i, j).color = grid(i, j).color - 4
                End If
            Next
        Next

        GoSub UpdateRain

        Color _RGB32(0, 0, 0), 0
        m$ = "All's burned. Adele's so proud of you."
        _PrintString (_Width / 2 - _PrintWidth(m$) / 2 + 1, _Height / 2 - _FontHeight / 2 + 1), m$
        m$ = "It took you" + Str$(Int(finish# - start#)) + " seconds."
        _PrintString (_Width / 2 - _PrintWidth(m$) / 2 + 1, _Height / 2 - _FontHeight / 2 + _FontHeight + 1), m$
        m$ = "Click anywhere to restart"
        _PrintString (_Width / 2 - _PrintWidth(m$) / 2 + 1, _Height - _FontHeight + 1), m$

        Color _RGB32(255, 255, 255), 0
        m$ = "All's burned. Adele's so proud of you."
        _PrintString (_Width / 2 - _PrintWidth(m$) / 2, _Height / 2 - _FontHeight / 2), m$
        m$ = "It took you" + Str$(Int(finish# - start#)) + " seconds."
        _PrintString (_Width / 2 - _PrintWidth(m$) / 2, _Height / 2 - _FontHeight / 2 + _FontHeight), m$
        m$ = "Click anywhere to restart"
        _PrintString (_Width / 2 - _PrintWidth(m$) / 2 + 1, _Height - _FontHeight), m$

        _Limit 30
        _Display

    Loop Until _MouseButton(1) Or _KeyHit <> 0


    If bgmusic > 0 Then
        _SndSetPos bgmusic, 4.3
        If Not _SndPlaying(bgmusic) And Not mute Then _SndPlay bgmusic
    End If
Loop

UpdateRain:
For i = 1 To UBound(rainDrops)
    rainDrops(i).y = rainDrops(i).y + rainDrops(i).yv
    rainDrops(i).yv = rainDrops(i).yv + .1
    rainDrops(i).x = rainDrops(i).x + rainDrops(i).xv
    rainDrops(i).xv = rainDrops(i).xv - .1
    If rainDrops(i).y > _Height Or rainDrops(i).x < 0 Then
        rainDrops(i).yv = 0
        rainDrops(i).xv = 0
        rainDrops(i).x = Rnd * _Width * 2
        rainDrops(i).y = -Rnd * _Height
    End If
    Line (rainDrops(i).x, rainDrops(i).y)-Step(-2, 5), _RGB32(0, 89, 155)

    k = Int((rainDrops(i).x - 1) / s) + 1
    l = Int((rainDrops(i).y + 5) / s) + 1
    If k > 1 And k < UBound(grid, 1) And l > 1 And l < UBound(grid, 2) Then
        If grid(k, l).color < 200 And Not fullFire Then grid(k, l).color = 0
    End If
Next
Return

resetFire:
For i = 1 To UBound(grid, 1)
    For j = 1 To UBound(grid, 2)
        grid(i, j).x = s * i - s
        grid(i, j).y = s * j - s
        grid(i, j).size = s
        grid(i, j).color = 0
    Next
Next
Return

ResetRain:
For i = 1 To UBound(rainDrops)
    rainDrops(i).yv = 0
    rainDrops(i).xv = 0
    rainDrops(i).x = Rnd * _Width * 2
    rainDrops(i).y = -(Rnd * (_Height * 2))
Next
Return

addSmoke:
If j - 1 > 0 Then
    If grid(i, j - 1).color < 200 Then
        smokeIndex = smokeIndex + 1
        If smokeIndex > UBound(smoke) Then smokeIndex = 1
        smoke(smokeIndex).x = i * s - s
        smoke(smokeIndex).y = (j - 1) * s - s
        smoke(smokeIndex).color = 100
    End If
End If
Return


Function map! (value!, minRange!, maxRange!, newMinRange!, newMaxRange!)
    map! = ((value! - minRange!) / (maxRange! - minRange!)) * (newMaxRange! - newMinRange!) + newMinRange!
End Function

