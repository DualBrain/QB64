'This is my starfield entry hacked down to 25 lines
'It needs a pretty fast computer...looks OK on my 1.5 GHz
'JKC 2003

$NoPrefix

$Resize:Smooth

Type star
    x As Integer
    y As Integer
    z As Integer
End Type

Dim astar(0 To 300) As star
Dim oldstar(0 To 300) As star
For i = 0 To 300
    astar(i).x = Rnd * 640
    astar(i).y = Rnd * 480
    astar(i).z = Rnd * 300
Next

Screen 11
FullScreen SquarePixels , Smooth

Do
    For i = 0 To 300
        If astar(i).z < 1 Then astar(i).z = 300 Else astar(i).z = astar(i).z - 1
        For p% = 0 To oldstar(i).z
            Circle (oldstar(i).x, oldstar(i).y), p%, 0
            If astar(i).z <> 300 Then Circle (Int(2 * astar(i).z + astar(i).x / (1 + astar(i).z / 30)), Int(astar(i).z + astar(i).y / (1 + astar(i).z / 30))), p%
        Next p%
        oldstar(i).x = Int(2 * astar(i).z + astar(i).x / (1 + astar(i).z / 30))
        oldstar(i).y = Int(astar(i).z + astar(i).y / (1 + astar(i).z / 30))
        oldstar(i).z = 5 / (1 + astar(i).z / 20)
    Next
    Limit 60
Loop Until InKey$ <> ""

System 0
