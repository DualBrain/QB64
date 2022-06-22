ReDim words$(0)

original$ = "The rain   in Spain  "
Print "Original string: "; original$
Print

split original$, " ", words$()

Print "Words:"
For i = LBound(words$) To UBound(words$)
    Print words$(i)
Next i
Print

Print "Joined with commas: "; join$(words$(), ",")

'Split in$ into pieces, chopping at every occurrence of delimiter$. Multiple consecutive occurrences
'of delimiter$ are treated as a single instance. The chopped pieces are stored in result$().
'
'delimiter$ must be one character long.
'result$() must have been REDIMmed previously.
Sub split (in$, delimiter$, result$())
    ReDim result$(-1)
    start = 1
    Do
        While Mid$(in$, start, 1) = delimiter$
            start = start + 1
            If start > Len(in$) Then Exit Sub
        Wend
        finish = InStr(start, in$, delimiter$)
        If finish = 0 Then finish = Len(in$) + 1
        ReDim _Preserve result$(0 To UBound(result$) + 1)
        result$(UBound(result$)) = Mid$(in$, start, finish - start)
        start = finish + 1
    Loop While start <= Len(in$)
End Sub

'Combine all elements of in$() into a single string with delimiter$ separating the elements.
Function join$ (in$(), delimiter$)
    result$ = in$(LBound(in$))
    For i = LBound(in$) + 1 To UBound(in$)
        result$ = result$ + delimiter$ + in$(i)
    Next i
    join$ = result$
end function

