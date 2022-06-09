'-----------------------------------------------------------------------------------------------------
'                                 SORTDEMO
' This program graphically demonstrates six common sorting algorithms.  It
' prints 25 or 43 horizontal bars, all of different lengths and all in random
' order, then sorts the bars from smallest to longest.
'
' The program also uses SOUND statements to generate different pitches,
' depending on the location of the bar being printed. Note that the SOUND
' statements delay the speed of each sorting algorithm so you can follow
' the progress of the sort.  Therefore, the times shown are for comparison
' only. They are not an accurate measure of sort speed.
'
' If you use these sorting routines in your own programs, you may notice
' a difference in their relative speeds (for example, the exchange
' sort may be faster than the shell sort) depending on the number of
' elements to be sorted and how "scrambled" they are to begin with.
'-----------------------------------------------------------------------------------------------------

'-----------------------------------------------------------------------------------------------------
' These are some metacommands and compiler options for QB64 to write modern & type-strict code
'-----------------------------------------------------------------------------------------------------
' This will disable prefixing all modern QB64 calls using a underscore prefix.
$NoPrefix
' Whatever indentifiers are not defined, should default to signed longs (ex. constants and functions).
DefInt A-Z
' All variables must be defined.
Option Explicit
' All arrays must be defined.
Option ExplicitArray
' Array lower bounds should always start from 1 unless explicitly specified.
' This allows a(4) as integer to have 4 members with index 1-4.
Option Base 1
' All arrays should be static by default. Allocate dynamic array using ReDim
'$Static
' This allows the executable window & it's contents to be resized.
$Resize:Smooth
FullScreen SquarePixels , Smooth
Title "Sort Demo"
'-----------------------------------------------------------------------------------------------------

' Define the data type used to hold the information for each colored bar:
Type SortType
    Length As Integer ' Bar length (the element compared in the different sorts)
    ColorVal As Integer ' Bar color
    BarString As String * 43 ' The bar (a string of 43 characters)
End Type

' Declare global constants:
Const FALSE = 0, TRUE = Not FALSE
Const LEFTCOLUMN = 49, NUMOPTIONS = 11, NUMSORTS = 6

' Declare global variables, and allocate storage space for them.  SortArray
' and SortBackup are both arrays of the data type SortType defined above:
Dim Shared SortArray(1 To 43) As SortType, SortBackup(1 To 43) As SortType
Dim Shared OptionTitle(1 To NUMOPTIONS) As String * 12
Dim Shared StartTime As Single
Dim Shared Foreground, Background, NoSound, Pause
Dim Shared Selection, MaxRow, InitRow, MaxColors

' Data statements for the different options printed in the sort menu:
Data Insertion,Bubble,Heap,Exchange,Shell,Quick,
Data Toggle Sound,,<   (Slower),>   (Faster)

' Begin logic of module-level code:

Initialize ' Initialize data values.
SortMenu ' Print sort menu.
Width 80, InitRow ' Restore original number of rows.
Color 7, 0 ' Restore default color
Cls
End

' GetRow, MonoTrap, and RowTrap are error-handling routines invoked by
' the CheckScreen SUB procedure.  GetRow determines whether the program
' started with 25, 43, or 50 lines.  MonoTrap determines the current
' video adapter is monochrome.  RowTrap sets the maximum possible
' number of rows (43 or 25).

GetRow:
If InitRow = 50 Then
    InitRow = 43
    Resume
Else
    InitRow = 25
    Resume Next
End If

MonoTrap:
MaxColors = 2
Resume Next

RowTrap:
MaxRow = 25
Resume

' =============================== BoxInit ====================================
'    Calls the DrawFrame procedure to draw the frame around the sort menu,
'    then prints the different options stored in the OptionTitle array.
' ============================================================================
'
Sub BoxInit Static
    DrawFrame 1, 22, LEFTCOLUMN - 3, 78
    Dim As Integer i

    Locate 3, LEFTCOLUMN + 2: Print "QUICKBASIC SORTING DEMO";
    Locate 5
    For i = 1 To NUMOPTIONS - 1
        Locate , LEFTCOLUMN: Print OptionTitle(i)
    Next i

    ' Don't print the last option (> Faster) if the length of the Pause
    ' is down to 1 clock tick:
    If Pause > 1 Then Locate , LEFTCOLUMN: Print OptionTitle(NUMOPTIONS);

    ' Toggle sound on or off, then print the current value for NoSound:
    NoSound = Not NoSound
    ToggleSound 12, LEFTCOLUMN + 12

    Locate NUMOPTIONS + 6, LEFTCOLUMN
    Print "Type first character of"
    Locate , LEFTCOLUMN
    Print "choice ( I B H E S Q T < > )"
    Locate , LEFTCOLUMN
    Print "or ESC key to end program: ";
End Sub

' ============================== BubbleSort ==================================
'    The BubbleSort algorithm cycles through SortArray, comparing adjacent
'    elements and swapping pairs that are out of order.  It continues to
'    do this until no pairs are swapped.
' ============================================================================
'
Sub BubbleSort Static
    Dim As Integer RowLimit, Switch, Row

    RowLimit = MaxRow
    Do
        Switch = FALSE
        For Row = 1 To (RowLimit - 1)

            ' Two adjacent elements are out of order, so swap their values
            ' and redraw those two bars:
            If SortArray(Row).Length > SortArray(Row + 1).Length Then
                Swap SortArray(Row), SortArray(Row + 1)
                SwapBars Row, Row + 1
                Switch = Row
            End If
        Next Row

        ' Sort on next pass only to where the last switch was made:
        RowLimit = Switch
    Loop While Switch
End Sub

' ============================== CheckScreen =================================
'     Checks for type of monitor (VGA, EGA, CGA, or monochrome) and
'     starting number of screen lines (50, 43, or 25).
' ============================================================================
'
Sub CheckScreen Static
    ' Try locating to the 50th row; if that fails, try the 43rd. Finally,
    ' if that fails, the user was using 25-line mode:
    InitRow = 50
    On Error GoTo GetRow
    Locate InitRow, 1

    ' Try a SCREEN 1 statement to see if the current adapter has color
    ' graphics; if that causes an error, reset MaxColors to 2:
    MaxColors = 15
    On Error GoTo MonoTrap
    Screen 1
    Screen 0

    ' See if 43-line mode is accepted; if not, run this program in 25-line
    ' mode:
    MaxRow = 43
    On Error GoTo RowTrap
    Width 80, MaxRow
    On Error GoTo 0 ' Turn off error trapping.
End Sub

' ============================== DrawFrame ===================================
'   Draws a rectangular frame using the high-order ASCII characters É (201) ,
'   » (187) , È (200) , ¼ (188) , º (186) , and Í (205). The parameters
'   TopSide, BottomSide, LeftSide, and RightSide are the row and column
'   arguments for the upper-left and lower-right corners of the frame.
' ============================================================================
'
Sub DrawFrame (TopSide, BottomSide, LeftSide, RightSide) Static
    Dim As Integer FrameWidth, Row

    Const ULEFT = 201, URIGHT = 187, LLEFT = 200, LRIGHT = 188
    Const VERTICAL = 186, HORIZONTAL = 205

    FrameWidth = RightSide - LeftSide - 1
    Locate TopSide, LeftSide
    Print Chr$(ULEFT); String$(FrameWidth, HORIZONTAL); Chr$(URIGHT);
    For Row = TopSide + 1 To BottomSide - 1
        Locate Row, LeftSide
        Print Chr$(VERTICAL); Spc(FrameWidth); Chr$(VERTICAL);
    Next Row
    Locate BottomSide, LeftSide
    Print Chr$(LLEFT); String$(FrameWidth, HORIZONTAL); Chr$(LRIGHT);
End Sub

' ============================= ElapsedTime ==================================
'    Prints seconds elapsed since the given sorting routine started.
'    Note that this time includes both the time it takes to redraw the
'    bars plus the pause while the SOUND statement plays a note, and
'    thus is not an accurate indication of sorting speed.
' ============================================================================
'
Sub ElapsedTime (CurrentRow) Static
    Const FORMAT = "  &###.### seconds  "

    ' Print current selection and number of seconds elapsed in
    ' reverse video:
    Color Foreground, Background
    Locate Selection + 4, LEFTCOLUMN - 2
    Print Using FORMAT; OptionTitle(Selection); Timer - StartTime;

    If NoSound Then
        Delay Pause / 15
    Else
        Sound 60 * CurrentRow, Pause ' Sound on, so play a note while
        Delay Pause / 15
    End If ' pausing.

    Color MaxColors, 0 ' Restore regular foreground and
    ' background colors.
End Sub

' ============================= ExchangeSort =================================
'   The ExchangeSort compares each element in SortArray - starting with
'   the first element - with every following element.  If any of the
'   following elements is smaller than the current element, it is exchanged
'   with the current element and the process is repeated for the next
'   element in SortArray.
' ============================================================================
'
Sub ExchangeSort Static
    Dim As Integer Row, SmallestRow, j

    For Row = 1 To MaxRow
        SmallestRow = Row
        For j = Row + 1 To MaxRow
            If SortArray(j).Length < SortArray(SmallestRow).Length Then
                SmallestRow = j
                ElapsedTime j
            End If
        Next j

        ' Found a row shorter than the current row, so swap those
        ' two array elements:
        If SmallestRow > Row Then
            Swap SortArray(Row), SortArray(SmallestRow)
            SwapBars Row, SmallestRow
        End If
    Next Row
End Sub

' =============================== HeapSort ===================================
'  The HeapSort procedure works by calling two other procedures - PercolateUp
'  and PercolateDown.  PercolateUp turns SortArray into a "heap," which has
'  the properties outlined in the diagram below:
'
'                               SortArray(1)
'                               /          \
'                    SortArray(2)           SortArray(3)
'                   /          \            /          \
'         SortArray(4)   SortArray(5)   SortArray(6)  SortArray(7)
'          /      \       /       \       /      \      /      \
'        ...      ...   ...       ...   ...      ...  ...      ...
'
'
'  where each "parent node" is greater than each of its "child nodes"; for
'  example, SortArray(1) is greater than SortArray(2) or SortArray(3),
'  SortArray(3) is greater than SortArray(6) or SortArray(7), and so forth.
'
'  Therefore, once the first FOR...NEXT loop in HeapSort is finished, the
'  largest element is in SortArray(1).
'
'  The second FOR...NEXT loop in HeapSort swaps the element in SortArray(1)
'  with the element in MaxRow, rebuilds the heap (with PercolateDown) for
'  MaxRow - 1, then swaps the element in SortArray(1) with the element in
'  MaxRow - 1, rebuilds the heap for MaxRow - 2, and continues in this way
'  until the array is sorted.
' ============================================================================
'
Sub HeapSort Static
    Dim As Integer i

    For i = 2 To MaxRow
        PercolateUp i
    Next i

    For i = MaxRow To 2 Step -1
        Swap SortArray(1), SortArray(i)
        SwapBars 1, i
        PercolateDown i - 1
    Next i
End Sub

' ============================== Initialize ==================================
'    Initializes the SortBackup and OptionTitle arrays.  It also calls the
'    CheckScreen, BoxInit, and RandInt% procedures.
' ============================================================================
'
Sub Initialize Static
    Dim TempArray(1 To 43)
    Dim As Integer i, MaxIndex, Index, BarLength

    CheckScreen ' Check for monochrome or EGA and set
    ' maximum number of text lines.
    For i = 1 To MaxRow
        TempArray(i) = i
    Next i

    MaxIndex = MaxRow

    Randomize Timer ' Seed the random-number generator.
    For i = 1 To MaxRow

        ' Call RandInt% to find a random element in TempArray between 1
        ' and MaxIndex, then assign the value in that element to BarLength:
        Index = RandInt%(1, MaxIndex)
        BarLength = TempArray(Index)

        ' Overwrite the value in TempArray(Index) with the value in
        ' TempArray(MaxIndex) so the value in TempArray(Index) is
        ' chosen only once:
        TempArray(Index) = TempArray(MaxIndex)

        ' Decrease the value of MaxIndex so that TempArray(MaxIndex) can't
        ' be chosen on the next pass through the loop:
        MaxIndex = MaxIndex - 1

        ' Assign the BarLength value to the .Length element, then store
        ' a string of BarLength block characters (ASCII 223: ß) in the
        ' .BarString element:
        SortBackup(i).Length = BarLength
        SortBackup(i).BarString = String$(BarLength, 223)

        ' Store the appropriate color value in the .ColorVal element:
        If MaxColors > 2 Then
            SortBackup(i).ColorVal = (BarLength Mod MaxColors) + 1
        Else
            SortBackup(i).ColorVal = MaxColors
        End If
    Next i

    For i = 1 To NUMOPTIONS ' Read SORT DEMO menu options and store
        Read OptionTitle(i) ' them in the OptionTitle array.
    Next i

    Cls
    Reinitialize ' Assign values in SortBackup to SortArray and draw
    ' unsorted bars on the screen.
    NoSound = FALSE
    Pause = 2 ' Initialize Pause to 2 clock ticks (@ 1/9 second).
    BoxInit ' Draw frame for the sort menu and print options.
End Sub

' ============================= InsertionSort ================================
'   The InsertionSort procedure compares the length of each successive
'   element in SortArray with the lengths of all the preceding elements.
'   When the procedure finds the appropriate place for the new element, it
'   inserts the element in its new place, and moves all the other elements
'   down one place.
' ============================================================================
'
Sub InsertionSort Static
    Dim TempVal As SortType
    Dim As Integer Row, TempLength, j

    For Row = 2 To MaxRow
        TempVal = SortArray(Row)
        TempLength = TempVal.Length
        For j = Row To 2 Step -1

            ' As long as the length of the J-1st element is greater than the
            ' length of the original element in SortArray(Row), keep shifting
            ' the array elements down:
            If SortArray(j - 1).Length > TempLength Then
                SortArray(j) = SortArray(j - 1)
                PrintOneBar j ' Print the new bar.
                ElapsedTime j ' Print the elapsed time.

                ' Otherwise, exit the FOR...NEXT loop:
            Else
                Exit For
            End If
        Next j

        ' Insert the original value of SortArray(Row) in SortArray(J):
        SortArray(j) = TempVal
        PrintOneBar j
        ElapsedTime j
    Next Row
End Sub

' ============================ PercolateDown =================================
'   The PercolateDown procedure restores the elements of SortArray from 1 to
'   MaxLevel to a "heap" (see the diagram with the HeapSort procedure).
' ============================================================================
'
Sub PercolateDown (MaxLevel) Static
    Dim As Integer i, Child

    i = 1

    ' Move the value in SortArray(1) down the heap until it has
    ' reached its proper node (that is, until it is less than its parent
    ' node or until it has reached MaxLevel, the bottom of the current heap):
    Do
        Child = 2 * i ' Get the subscript for the child node.

        ' Reached the bottom of the heap, so exit this procedure:
        If Child > MaxLevel Then Exit Do

        ' If there are two child nodes, find out which one is bigger:
        If Child + 1 <= MaxLevel Then
            If SortArray(Child + 1).Length > SortArray(Child).Length Then
                Child = Child + 1
            End If
        End If

        ' Move the value down if it is still not bigger than either one of
        ' its children:
        If SortArray(i).Length < SortArray(Child).Length Then
            Swap SortArray(i), SortArray(Child)
            SwapBars i, Child
            i = Child

            ' Otherwise, SortArray has been restored to a heap from 1 to MaxLevel,
            ' so exit:
        Else
            Exit Do
        End If
    Loop
End Sub

' ============================== PercolateUp =================================
'   The PercolateUp procedure converts the elements from 1 to MaxLevel in
'   SortArray into a "heap" (see the diagram with the HeapSort procedure).
' ============================================================================
'
Sub PercolateUp (MaxLevel) Static
    Dim As Integer i, Parent

    i = MaxLevel

    ' Move the value in SortArray(MaxLevel) up the heap until it has
    ' reached its proper node (that is, until it is greater than either
    ' of its child nodes, or until it has reached 1, the top of the heap):
    Do Until i = 1
        Parent = i \ 2 ' Get the subscript for the parent node.

        ' The value at the current node is still bigger than the value at
        ' its parent node, so swap these two array elements:
        If SortArray(i).Length > SortArray(Parent).Length Then
            Swap SortArray(Parent), SortArray(i)
            SwapBars Parent, i
            i = Parent

            ' Otherwise, the element has reached its proper place in the heap,
            ' so exit this procedure:
        Else
            Exit Do
        End If
    Loop
End Sub

' ============================== PrintOneBar =================================
'  Prints SortArray(Row).BarString at the row indicated by the Row
'  parameter, using the color in SortArray(Row).ColorVal.
' ============================================================================
'
Sub PrintOneBar (Row) Static
    Locate Row, 1
    Color SortArray(Row).ColorVal
    Print SortArray(Row).BarString;
End Sub

' ============================== QuickSort ===================================
'   QuickSort works by picking a random "pivot" element in SortArray, then
'   moving every element that is bigger to one side of the pivot, and every
'   element that is smaller to the other side.  QuickSort is then called
'   recursively with the two subdivisions created by the pivot.  Once the
'   number of elements in a subdivision reaches two, the recursive calls end
'   and the array is sorted.
' ============================================================================
'
Sub QuickSort (Low, High)
    Dim As Integer RandIndex, Partition, i, j

    If Low < High Then

        ' Only two elements in this subdivision; swap them if they are out of
        ' order, then end recursive calls:
        If High - Low = 1 Then
            If SortArray(Low).Length > SortArray(High).Length Then
                Swap SortArray(Low), SortArray(High)
                SwapBars Low, High
            End If
        Else

            ' Pick a pivot element at random, then move it to the end:
            RandIndex = RandInt%(Low, High)
            Swap SortArray(High), SortArray(RandIndex)
            SwapBars High, RandIndex
            Partition = SortArray(High).Length
            Do

                ' Move in from both sides towards the pivot element:
                i = Low: j = High
                Do While (i < j) And (SortArray(i).Length <= Partition)
                    i = i + 1
                Loop
                Do While (j > i) And (SortArray(j).Length >= Partition)
                    j = j - 1
                Loop

                ' If we haven't reached the pivot element, it means that two
                ' elements on either side are out of order, so swap them:
                If i < j Then
                    Swap SortArray(i), SortArray(j)
                    SwapBars i, j
                End If
            Loop While i < j

            ' Move the pivot element back to its proper place in the array:
            Swap SortArray(i), SortArray(High)
            SwapBars i, High

            ' Recursively call the QuickSort procedure (pass the smaller
            ' subdivision first to use less stack space):
            If (i - Low) < (High - i) Then
                QuickSort Low, i - 1
                QuickSort i + 1, High
            Else
                QuickSort i + 1, High
                QuickSort Low, i - 1
            End If
        End If
    End If
End Sub

' =============================== RandInt% ===================================
'   Returns a random integer greater than or equal to the Lower parameter
'   and less than or equal to the Upper parameter.
' ============================================================================
'
Function RandInt% (lower, Upper) Static
    RandInt% = Int(Rnd * (Upper - lower + 1)) + lower
End Function

' ============================== Reinitialize ================================
'   Restores the array SortArray to its original unsorted state, then
'   prints the unsorted color bars.
' ============================================================================
'
Sub Reinitialize Static
    Dim As Integer i

    For i = 1 To MaxRow
        SortArray(i) = SortBackup(i)
    Next i

    For i = 1 To MaxRow
        Locate i, 1
        Color SortArray(i).ColorVal
        Print SortArray(i).BarString;
    Next i

    Color MaxColors, 0
End Sub

' =============================== ShellSort ==================================
'  The ShellSort procedure is similar to the BubbleSort procedure.  However,
'  ShellSort begins by comparing elements that are far apart (separated by
'  the value of the Offset variable, which is initially half the distance
'  between the first and last element), then comparing elements that are
'  closer together (when Offset is one, the last iteration of this procedure
'  is merely a bubble sort).
' ============================================================================
'
Sub ShellSort Static
    Dim As Integer RowOffset, RowLimit, Switch, Row

    ' Set comparison offset to half the number of records in SortArray:
    RowOffset = MaxRow \ 2

    Do While RowOffset > 0 ' Loop until offset gets to zero.
        RowLimit = MaxRow - RowOffset
        Do
            Switch = FALSE ' Assume no switches at this offset.

            ' Compare elements and switch ones out of order:
            For Row = 1 To RowLimit
                If SortArray(Row).Length > SortArray(Row + RowOffset).Length Then
                    Swap SortArray(Row), SortArray(Row + RowOffset)
                    SwapBars Row, Row + RowOffset
                    Switch = Row
                End If
            Next Row

            ' Sort on next pass only to where last switch was made:
            RowLimit = Switch - RowOffset
        Loop While Switch

        ' No switches at last offset, try one half as big:
        RowOffset = RowOffset \ 2
    Loop
End Sub

' =============================== SortMenu ===================================
'   The SortMenu procedure first calls the Reinitialize procedure to make
'   sure the SortArray is in its unsorted form, then prompts the user to
'   make one of the following choices:
'
'               * One of the sorting algorithms
'               * Toggle sound on or off
'               * Increase or decrease speed
'               * End the program
' ============================================================================
'
Sub SortMenu Static
    Dim As String sEscape, sOption, sChoice

    sEscape = Chr$(27)

    ' Create a string consisting of all legal choices:
    sOption = "IBHESQ><T" + sEscape

    Do

        ' Make the cursor visible:
        Locate NUMOPTIONS + 8, LEFTCOLUMN + 27, 1

        sChoice = UCase$(Input$(1)) ' Get the user's choice and see
        Selection = InStr(sOption, sChoice) ' if it's one of the menu options.

        ' User chose one of the sorting procedures:
        If (Selection >= 1) And (Selection <= NUMSORTS) Then
            Reinitialize ' Rescramble the bars.
            Locate , , 0 ' Make the cursor invisible.
            Foreground = 0 ' Set reverse-video values.
            Background = 7
            StartTime = Timer ' Record the starting time.
        End If

        ' Branch to the appropriate procedure depending on the key typed:
        Select Case sChoice
            Case "I"
                InsertionSort
            Case "B"
                BubbleSort
            Case "H"
                HeapSort
            Case "E"
                ExchangeSort
            Case "S"
                ShellSort
            Case "Q"
                QuickSort 1, MaxRow
            Case ">"

                ' Decrease pause length to speed up sorting time, then redraw
                ' the menu to clear any timing results (since they won't compare
                ' with future results):
                Pause = (2 * Pause) / 3
                BoxInit

            Case "<"

                ' Increase pause length to slow down sorting time, then redraw
                ' the menu to clear any timing results (since they won't compare
                ' with future results):
                Pause = (3 * Pause) / 2
                BoxInit

            Case "T"
                ToggleSound 12, LEFTCOLUMN + 12

            Case sEscape

                ' User pressed ESC, so exit this procedure and return to
                ' module level:
                Exit Do

            Case Else

                ' Invalid key
        End Select

        If (Selection >= 1) And (Selection <= NUMSORTS) Then
            Foreground = MaxColors ' Turn off reverse video.
            Background = 0
            ElapsedTime 0 ' Print final time.
        End If

    Loop
End Sub

' =============================== SwapBars ===================================
'   Calls PrintOneBar twice to switch the two bars in Row1 and Row2,
'   then calls the ElapsedTime procedure.
' ============================================================================
'
Sub SwapBars (Row1, Row2) Static
    PrintOneBar Row1
    PrintOneBar Row2
    ElapsedTime Row1
End Sub

' ============================== ToggleSound =================================
'   Reverses the current value for NoSound, then prints that value next
'   to the "Toggle Sound" option on the sort menu.
' ============================================================================
'
Sub ToggleSound (Row, Column) Static
    NoSound = Not NoSound
    Locate Row, Column
    If NoSound Then
        Print ": OFF";
    Else
        Print ": ON ";
    End If
End Sub

