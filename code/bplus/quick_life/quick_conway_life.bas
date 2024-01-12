_Title "Quick Conway Life" ' b+ 2023-1-15
Screen _NewImage(710, 710, 32)
DefLng A-Z
Dim g(69, 69)

For y = 1 To 68 'seed g()
    For x = 1 To 68
        If Rnd < .33 Then g(x, y) = 1
    Next
Next

While _KeyDown(27) = 0
    ReDim ng(69, 69)
    Cls
    gen = gen + 1
    Print "Gen"; gen
    For y = 1 To 68
        For x = 1 To 68
            nc = g(x - 1, y - 1) + g(x, y - 1) + g(x + 1, y - 1) + g(x - 1, y) + g(x + 1, y) + g(x - 1, y + 1) + g(x, y + 1) + g(x + 1, y + 1)
            If g(x, y) Then
                Line (x * 10, y * 10)-Step(10, 10), &HFFFFFFFF, BF
                Line (x * 10, y * 10)-Step(10, 10), &HFF000000, B
                If nc = 2 Or nc = 3 Then ng(x, y) = 1
            Else
                If nc = 3 Then ng(x, y) = 1
            End If
        Next
    Next
    For y = 1 To 68 'transfer ng to g and erase
        For x = 1 To 68
            g(x, y) = ng(x, y)
        Next
    Next
    ReDim ng(69, 69)
    _Limit 10
Wend