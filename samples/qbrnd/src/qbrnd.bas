DECLARE SUB DRAWNUMBERS ()
DECLARE SUB ANOTHERDRAW ()
DECLARE SUB PRINTNUMBERS (M%, N%, NUMBER%)

' QBRND.BAS
'   by Jeff Davis
' Copyright (C) 1994 DOS Resource Guide
' Published in Issue #15, May 1994, page 64

Clear
Option Base 1
Randomize Timer

Call DRAWNUMBERS
End

Sub ANOTHERDRAW
    Locate 23, 6
    Input "ANOTHER DRAW ? (Y/N) -> ", RESPONSE$
    If UCase$(RESPONSE$) = "Y" Then Call DRAWNUMBERS
End Sub

Sub DRAWNUMBERS
    Color 1, 7
    Cls
    Locate 2, 6
    Input "Sample Size?-> ", SAMPLE% 'From how many
    'numbers?
    Locate 2, 46
    Input "How Many Numbers?-> ", NUMBERS% 'Draw how
    'many numbers?

    ReDim CHECK%(SAMPLE%) 'CHECK() is used only to
    'check against ARRAY().
    ReDim ARRAY%(SAMPLE%) 'ARRAY() is where numbers
    'are drawn from.
    ReDim STORE%(NUMBERS%) 'STORE() is the final
    'product.
    TEMPSAMPLE% = SAMPLE%
    For A% = 1 To SAMPLE%
        CHECK%(A%) = A% 'Load arrays so CHECK%(1) =
        'ARRAY%(1) = NUMBER
        ARRAY%(A%) = A%
    Next A%
    For A% = 1 To NUMBERS%
        B% = Fix(Rnd * TEMPSAMPLE% + 1) 'Draw a random
        'number from sample
        STORE%(A%) = ARRAY%(B%) 'Load into store array
        'at position (1) the random number generated
        CHECK%(ARRAY%(B%)) = 0 'Replace that number in
        'check array with zero
        D% = 1
        For C% = 1 To SAMPLE% 'Was this number
            'already drawn?
            If CHECK%(C%) <> 0 Then 'If this number was
                'drawn, then it is removed from ARRAY() and
                ARRAY%(D%) = CHECK%(C%) 'can't be drawn
                'again.
                D% = D% + 1
            End If
        Next C%
        TEMPSAMPLE% = TEMPSAMPLE% - 1 'Reduce size of
        'sample by one
    Next A%
    M% = 4: N% = 5
    Color 4
    For A% = 1 To NUMBERS% 'Print out the numbers.
        PRINTNUMBERS M%, N%, STORE%(A%)
        N% = N% + 5
        If N% >= 77 Then
            M% = M% + 1
            N% = 5
        End If
    Next A%

    Call ANOTHERDRAW
End Sub

Sub PRINTNUMBERS (M%, N%, NUMBER%)
    Locate M%, N%
    Print NUMBER%
End Sub

