Screen 13, 0, 1, 0
For k = 1 To 100
    Circle (160, 100), k, Int(Rnd * 255) + 1
Next
Do
    PCopy 1, 0
    PSet (musx, musy), Point(musx, musy)
    Do
        musz = 0
        Do
            If _MouseButton(1) Then musz = musz Or 1
            If _MouseButton(2) Then musz = musz Or 2
            If _MouseButton(3) Then musz = musz Or 4
        Loop Until _MouseInput = 0
        musx = _MouseX
        musy = _MouseY
        If musz = 4 Then
            For siz = 1 To 10
                Circle (musx, musy), siz, Rnd * 255
            Next
        End If
        If musz = 3 Then Line -(musx, musy), c: c = c + 1: If c > 255 Then c = 0
        If musz = 2 Then c = c + 1: If c > 255 Then c = 0
        If musz = 1 Then Line -(musx, musy), c
    Loop Until musz = 0
    For x = 0 To 319
        For y = 0 To 199
            If Point(x - 1, y) <> 0 And Point(x + 1, y) <> 0 And Point(x, y - 1) <> 0 And Point(x, y + 1) <> 0 Then
                PSet (x, y), ((Point(x - 1, y) + Point(x + 1, y) + Point(x, y - 1) + Point(x, y + 1) + Point(x + 1, y + 1) + Point(x - 1, y - 1) + Point(x + 1, y - 1) + Point(x - 1, y + 1)) / (8 + Rnd * .5 - .25))
            End If
        Next
    Next
    If InKey$ = Chr$(27) Then End
Loop

