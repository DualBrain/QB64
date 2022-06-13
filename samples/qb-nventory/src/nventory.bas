DefInt A-Z
$Resize:Smooth
'$DYNAMIC

Const MAXWINDOW = 5
Const FALSE = 0
Const TRUE = Not FALSE

Type WindowStruct
    Frame As String * 6
    XPos As Integer
    YPos As Integer
    Foreground As Integer
    Background As Integer
    Length As Integer
    Height As Integer
    Title As String * 65
    Buffer As String * 2000
    Shadow As Integer
    ShadChar As String * 1
End Type

Dim Shared Handle(0 To MAXWINDOW + 1) As WindowStruct
Dim Shared WinCount
Dim Shared redraw
Dim Shared BackChar$
Dim Shared Fore
Dim Shared Back
Dim Shared Move$
Dim Shared Dur
Dim Shared choice
Dim Shared subchoice
Dim Shared DoubleFrame As String * 6
Dim Shared SingleFrame As String * 6
DoubleFrame = "É»È¼ºÍ"
SingleFrame = "Ú¿ÀÙ³Ä"

'Start of NVENTORY
Const STARTMAX = 1

Dim Shared MAXRECS
MAXRECS = STARTMAX

Type RecordStruct
    SerialNumber As String * 15
    Item As String * 20
    Model As String * 10
    Department As String * 10
    Location As String * 10
    Note1 As String * 10
    Note2 As String * 10
End Type
Dim Shared Equip As RecordStruct
Dim Shared EquipLength
EquipLength = Len(Equip)

Dim Shared PrintErr
Dim Shared IDNum$
Dim Shared MenuC1
Dim Shared MenuC2
Dim Shared ManipulateC1
Dim Shared ManipulateC2
Dim Shared InfoC1
Dim Shared InfoC2
Dim Shared PercentageChar$
Dim Shared Model$(19)
Dim Shared SortField
Dim Shared Directory$
Dim Shared RanFile$
Dim Shared PrintedLines

Dim Shared Info$(7, 2)
Dim Shared Title$(5)
Dim Shared Locs(5)

Title$(1) = "Serial Number"
Locs(1) = 1
Title$(2) = "Item Description"
Locs(2) = 16
Title$(3) = "Model Num"
Locs(3) = 37
Title$(4) = "Department"
Locs(4) = 48
Title$(5) = "Location"
Locs(5) = 59

On Error GoTo ErrorHandler


Locate , , 1, 11, 12
Print
Do
    Print "Are you using a (C)olor or (M)onochrome monitor?";
    GetKey Kbd$
    Print Kbd$;
    Kbd$ = UCase$(Kbd$)

    Select Case Kbd$
        Case "M"
            MenuC1 = 0
            MenuC2 = 7
            ManipulateC1 = 0
            ManipulateC2 = 7
            InfoC1 = 0
            InfoC2 = 7
            Exit Do

        Case "C"
            MenuC1 = 15
            MenuC2 = 4
            ManipulateC1 = 1
            ManipulateC2 = 3
            InfoC1 = 7
            InfoC2 = 1
            Exit Do

        Case Else
    End Select

Loop
Print

BarMenu

ErrorHandler:
Select Case Err
    Case 24, 25, 27
        PrintErr = TRUE
        BadPrint = ExplodeWindow(10, 13, 53, 1, 15, 4, SingleFrame, "ERROR!", 1, "")
        WinPrintCenter BadPrint, 1, "Printer not responding ... Any key to continue"
        Sound 1900, .2
        GetKey ""
        CloseWindow BadPrint
        Resume Next
    Case 7, 14
        Locate 2, 1, 1
        Color 7, 0
        Print "The program has run out of memory.  TERMINATING PROGRAM!";
        Sleep 5
        End
    Case 70
        Sleep 2
        Resume
    Case Else
End Select
Resume Next

Rem $STATIC
Sub AboutMenu
    Dim MenuItem$(1)

    MenuItem$(1) = " About..."
    Hot$ = "A"

    Do Until NewChoice < 0
        Color MenuC2, MenuC1
        Locate 1, 2
        Print " ð "

        NewChoice = Menu(NewChoice, 2, 1, 22, MenuC1, MenuC2, MenuItem$(), Hot$, 1)

        Select Case NewChoice
            Case 1
                GoSub ShowAboutStuff
            Case -2
                subchoice = -2
            Case -3
                subchoice = -3
            Case Else
        End Select
    Loop
    Exit Sub

    ShowAboutStuff:
    AboutWin = ExplodeWindow(7, 17, 45, 8, ManipulateC1, ManipulateC2, SingleFrame, "", 1, "")
    WinPrintCenter AboutWin, 2, "INVENTORY MANAGER"
    WinPrintCenter AboutWin, 3, "Version 4.8 Release 3"
    WinPrintCenter AboutWin, 4, "Copyright (C) Nathan Thomas, 1993."
    WinPrintCenter AboutWin, 5, "Produced by Independent Distributors"
    WinPrintCenter AboutWin, 7, String$(45, 196)
    WinPrintCenter AboutWin, 8, "<  OK  >"
       
    Kbd$ = ""
    Do Until Kbd$ = Chr$(13)
        Kbd$ = GetString$(AboutWin, 8, 22, "", "", 0, 0)
    Loop

    CloseWindow AboutWin
    Return

End Sub

Sub AddRecord
    Equip.SerialNumber = Chr$(255)
    Equip.Item = Chr$(255)
    Equip.Model = Chr$(255)
    Equip.Department = Chr$(255)
    Equip.Location = Chr$(255)
    Equip.Note1 = Chr$(255)
    Equip.Note2 = Chr$(255)
   
    AddWin = ExplodeWindow(3, 2, 74, 9, ManipulateC1, ManipulateC2, DoubleFrame, "Add an Item", 1, "")
    WinPrint AddWin, 2, 1, "Serial Number:_______________     Item Description:____________________"
    WinPrint AddWin, 3, 1, String$(74, 196)
    WinPrint AddWin, 4, 1, "Model:__________    Department:__________    Location:__________"
    WinPrint AddWin, 5, 1, String$(74, 196)
    WinPrint AddWin, 6, 1, "TAB        to move forward in fields       <ESC>   to abort input"
    WinPrint AddWin, 7, 1, "BACKTAB    to move backward in fields      <ENTER> to accept information"
    WinPrint AddWin, 8, 1, String$(74, 196)
    WinPrintCenter AddWin, 9, "Type a '?' in the Department field for a list of Departments"

    place = 1

    Do Until finished = TRUE
        If place = 1 Then
            Kbd$ = GetString$(AddWin, 2, 15, Serial$, Serial$, 15, 15)
            If Move$ = "TAB" Then place = 2
            If Move$ = "BKTAB" Then place = 5
            If Move$ = "ESC" Then CloseWindow AddWin: Exit Sub
            If Move$ = "RET" Then finished = TRUE
        End If
        If place = 2 Then
            Kbd$ = GetString$(AddWin, 2, 52, Item$, Item$, 20, 20)
            If Move$ = "TAB" Then place = 3
            If Move$ = "BKTAB" Then place = 1
            If Move$ = "ESC" Then CloseWindow AddWin: Exit Sub
            If Move$ = "RET" Then finished = TRUE
        End If
        If place = 3 Then
            Kbd$ = GetString$(AddWin, 4, 7, Model$, Model$, 10, 10)
            If Move$ = "TAB" Then place = 4
            If Move$ = "BKTAB" Then place = 2
            If Move$ = "ESC" Then CloseWindow AddWin: Exit Sub
            If Move$ = "RET" Then finished = TRUE
        End If
        If place = 4 Then
            Kbd$ = GetString$(AddWin, 4, 32, Department$, Department$, 10, 10)
            If RTrim$(Department$) = "?" Then
                GoSub ShowChoices
            End If
            If Move$ = "TAB" Then place = 5
            If Move$ = "BKTAB" Then place = 3
            If Move$ = "ESC" Then CloseWindow AddWin: Exit Sub
            If Move$ = "RET" Then finished = TRUE
        End If
        If place = 5 Then
            Kbd$ = GetString$(AddWin, 4, 55, Location$, Location$, 10, 10)
            If Move$ = "TAB" Then place = 1
            If Move$ = "BKTAB" Then place = 4
            If Move$ = "ESC" Then CloseWindow AddWin: Exit Sub
            If Move$ = "RET" Then finished = TRUE
        End If

        If finished = TRUE Then
            flag = 0
            If RTrim$(Serial$) = "" Then
                ErrorWin = ExplodeWindow(6, 25, 40, 1, 15, 4, SingleFrame, "ERROR!", 1, "")
                WinPrintCenter ErrorWin, 1, "Can't save without Serial Number!"
                Sound 1900, .2
                GetKey ""
                CloseWindow ErrorWin
                finished = FALSE
                flag = -1
            Else
                ShowMessage "Searching..."

                CalcMax
                Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
                For count = 1 To MAXRECS

                    Get #1, count, Equip

                    If RTrim$(UCase$(Equip.SerialNumber)) = RTrim$(UCase$(Serial$)) Then
                        flag = -1
                        Exit For
                    End If

                    If Asc(Equip.SerialNumber) = 255 Then
                        flag = count
                        Exit For
                    End If
                Next
                Close #1

                If flag = 0 Then
                    flag = count
                    finished = TRUE
                End If
                If flag = -1 Then
                    ErrorWin = ExplodeWindow(6, 25, 41, 1, 15, 4, SingleFrame, "ERROR!", 1, "")
                    WinPrintCenter ErrorWin, 1, "There's already an item by that number!"
                    Sound 1900, .2
                    GetKey ""
                    CloseWindow ErrorWin
                    finished = FALSE
                End If
                If flag >= 0 Then
                    finished = TRUE
                    ShowMessage "Writing Record..."
                                         
                    Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
                                  
                    Serial$ = UCase$(Serial$)
                    Department$ = UCase$(Department$)
                                  
                    If RTrim$(Item$) = "" Then Item$ = Chr$(255)
                    If RTrim$(Model$) = "" Then Model$ = Chr$(255)
                    If RTrim$(Department$) = "" Then Department$ = Chr$(255)
                    If RTrim$(Location$) = "" Then Location$ = Chr$(255)
                    Equip.SerialNumber = Serial$
                    Equip.Item = Item$
                    Equip.Model = Model$
                    Equip.Department = Department$
                    Equip.Location = Location$
                    Equip.Note1 = IDNum$
                    Equip.Note2 = ""
                    Put #1, flag, Equip
                    Close #1
                    ShowMessage "Inventory Manager  (c)Copyright 1993 by Nathan Thomas"
                End If
            End If
        End If
    Loop
    CloseWindow AddWin
    Exit Sub

    ShowChoices:
    For t = 1 To MAXRECS
        Model$(t) = ""
    Next
    ShowFlag = 0

    NumberOfChoices = 0
    Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
    num.recs = LOF(1) / EquipLength
    For count = 1 To num.recs
        Get #1, count, Equip
        If Asc(Equip.Department) <> 255 Then
            CurrentInfo$ = UCase$(RTrim$(Equip.Department))
            For t = 1 To NumberOfChoices
                If CurrentInfo$ = Model$(t) Then
                    ShowFlag = 1
                    Exit For
                End If
            Next
            If ShowFlag = 0 Then
                ShowFlag = 0
                Model$(NumberOfChoices + 1) = CurrentInfo$
                NumberOfChoices = NumberOfChoices + 1
            Else
                ShowFlag = 0
            End If
        End If
    Next
    Close #1

    Equip.SerialNumber = Serial$
    Equip.Item = Item$
    Equip.Model = Model$
    Equip.Location = Location$
    Equip.Note1 = Create$

    If NumberOfChoices > 18 Then NumberOfChoices = 18

    Model$(NumberOfChoices + 1) = "None!"

    NewChoice = Menu(NewChoice, 4, 4, 10, MenuC1, MenuC2, Model$(), Hot$, NumberOfChoices + 1)

    Move$ = ""

    If NewChoice = NumberOfChoices + 1 Or NewChoice < 1 Then Department$ = "": Return

    Department$ = RTrim$(Model$(NewChoice))

    Return
End Sub

Sub BarMenu
    BackChar$ = "±"
    PercentageChar$ = "²"
    Fore = 7
    Back = 0
    Dur = 3
    GetDirectory
    GenerateRandomFile
    WindowInitialize
    Intro

    choice = 2

    Do
        Select Case choice
            Case 1
                AboutMenu
            Case 2
                FileMenu
            Case 3
                EditMenu
            Case 4
                PrintMenu
            Case 5
                OptionsMenu
        End Select
      
        Select Case subchoice
            Case -2
                choice = choice - 1
                If choice = 0 Then choice = 5
            Case -3
                choice = choice + 1
                If choice = 6 Then choice = 1
        End Select
    Loop
End Sub

Function Browse% (currItem, X, Y, L, H, Shadow, ShadChar$, NumOfFields, Locs(), Title$(), NumOfInfo, WindowTitle$)
    BrowseC1 = ManipulateC1
    BrowseC2 = ManipulateC2

    Dim BInfo$(6, 20)

    DT = Dur
    Dur = 3

    BrowseWin = ExplodeWindow(X, Y, L, H, BrowseC1, BrowseC2, DoubleFrame, WindowTitle$, Shadow, ShadChar$)
    redraw = 0
    WinPrint BrowseWin, 1, Locs(1), Title$(1)
    For t = 2 To NumOfFields
        WinPrint BrowseWin, 1, Locs(t), "³" + Title$(t)
    Next
    WinPrint BrowseWin, 2, 1, String$(L, 196)
    For t = 2 To NumOfFields
        WinPrint BrowseWin, 2, Locs(t), "Å"
    Next
    WinRedraw BrowseWin

    FirstItem = 1
    If currItem > NumOfInfo Or currItem < 1 Then currItem = 1
    If currItem > H - 2 Then
        FirstItem = currItem
        currItem = 1
    End If

    BrowseWin1 = MakeWindow(X + 2, Y, L, H - 2, BrowseC1, BrowseC2, "", "", 0, "")

    redraw = 0
    BrowseWin2 = MakeWindow(X + 1 + currItem, Y, L, 1, BrowseC2, BrowseC1, "", "", 0, "")
    redraw = 1

    GoSub ShowItems

    finished = FALSE
    Do Until finished = TRUE
        GoSub ShowBar
        GetKey Kbd$

        Select Case Kbd$
            Case Chr$(0) + "H"
                currItem = currItem - 1
                If currItem = 0 Then
                    FirstItem = FirstItem - 1
                    If FirstItem = 0 Then FirstItem = 1
                    currItem = 1
                    GoSub ShowItems
                End If

            Case Chr$(0) + "P"
                currItem = currItem + 1
                If ((currItem + FirstItem) - 1) > NumOfInfo Then currItem = currItem - 1
                If currItem = H - 1 Then
                    FirstItem = FirstItem + 1
                    currItem = H - 2
                    GoSub ShowItems
                End If

            Case Chr$(0) + "I"
                FirstItem = FirstItem - (H - 2)
                If FirstItem < 1 Then FirstItem = 1: currItem = 1
                GoSub ShowItems

            Case Chr$(0) + "Q"
                FirstItem = FirstItem + (H - 2)
                If FirstItem + currItem - 1 > NumOfInfo Then FirstItem = NumOfInfo: currItem = 1
                GoSub ShowItems

            Case Chr$(27)
                Browse% = -1
                finished = TRUE

            Case Chr$(13)
                Browse% = ((currItem + FirstItem) - 1)
                finished = TRUE

            Case "P", "p"
                Browse% = ((currItem + FirstItem) - 1)
                finished = TRUE

            Case "A", "a"
                Browse% = ((currItem + FirstItem) - 1)
                finished = TRUE

            Case Else
                Sound 1900, .2
        End Select
    Loop

    redraw = 0
    CloseWindow BrowseWin2
    CloseWindow BrowseWin1
    CloseWindow BrowseWin
    redraw = 1
    RedrawAll

    Dur = DT
    Move$ = UCase$(Kbd$)
    ShowMessage "Inventory Manager  (c)Copyright 1993 by Nathan Thomas"
    Erase BInfo$
    Exit Function

    ShowItems:
    redraw = 0
    Handle(BrowseWin1).Buffer = ""
   
    Open Directory$ + RanFile$ For Random As #1 Len = EquipLength
    For count = 1 To H - 2
        Get #1, FirstItem + count - 1, Equip
        BInfo$(1, count) = Equip.SerialNumber
        BInfo$(2, count) = Equip.Item
        BInfo$(3, count) = Equip.Model
        BInfo$(4, count) = Equip.Department
        BInfo$(5, count) = Equip.Location
        BInfo$(6, count) = Equip.Note1
           
        For count1 = 1 To NumOfFields
            If count1 <> 1 Then
                WinPrint BrowseWin1, count, Locs(count1), "³" + BInfo$(count1, count)
            Else
                WinPrint BrowseWin1, count, Locs(count1), BInfo$(count1, count)
            End If
        Next
             
        If FirstItem + count - 1 >= NumOfInfo Then Exit For
    Next
    Close #1
    redraw = 1
    WinRedraw BrowseWin1
    Return

    ShowBar:
    Handle(BrowseWin2).Buffer = ""
    Handle(BrowseWin2).XPos = X + 1 + currItem
    WinRedraw BrowseWin1
    For count1 = 1 To NumOfFields
        If count1 <> 1 Then
            WinPrint BrowseWin2, 1, Locs(count1), "³" + BInfo$(count1, currItem)
        Else
            WinPrint BrowseWin2, 1, Locs(count1), BInfo$(count1, currItem)
        End If
    Next
    ShowMessage "(" + LTrim$(Str$(FirstItem + currItem - 1)) + " of" + Str$(NumOfInfo) + " R#" + LTrim$(RTrim$(BInfo$(6, currItem))) + ")"
    Return
End Function

Sub CalcMax
    Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
    MAXRECS = LOF(1) / EquipLength
    Close #1
End Sub

Sub ChangeDir
    DirWin = ExplodeWindow(8, 20, 46, 2, ManipulateC1, ManipulateC2, DoubleFrame, "", 1, "")
      
    WinPrint DirWin, 1, 1, "Enter the new directory location of the files"
    WinPrint DirWin, 2, 1, "Directory:"

    Kill Directory$ + RanFile$

    If Directory$ <> "" Then
        Directory$ = Left$(Directory$, Len(Directory$) - 1)
    End If
   
    Kbd$ = GetString$(DirWin, 2, 11, Directory$, Directory$, 35, 64)

    Directory$ = UCase$(RTrim$(Directory$))

    If Right$(Directory$, 1) <> "\" And Directory$ <> "" Then
        Directory$ = Directory$ + "\"
    End If

    ClearTemp
    CloseWindow DirWin
End Sub

Sub ChangeRecord

    finished = FALSE
    Do Until finished = TRUE
        MoveFile

        Sort 6, SortField, MAXRECS

        flag1 = Browse(flag1, 3, 5, 69, 15, 1, " ", 5, Locs(), Title$(), MAXRECS, "Change a Record - <ENTER> to change")

        If flag1 = -1 Then
            finished = TRUE
        End If
         
        If finished = FALSE Then
            Open Directory$ + RanFile$ For Random As #1 Len = EquipLength
            Get #1, flag1, Equip
            Close #1
            flag = Val(Equip.Note1)


            If Asc(Equip.SerialNumber) <> 255 Then
                Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
                Get #1, flag, Equip
                Close #1

                If RTrim$(Equip.Note2) <> "LOCKED" Then
                    Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
                    PLock flag
                    Close #1
                    Create$ = RTrim$(UCase$(Equip.Note1))

                    If IDNum$ = Create$ Or IDNum$ = "MANAGER" Then
                        Serial$ = Equip.SerialNumber
                        Item$ = RTrim$(Equip.Item)
                        If Asc(Item$) = 255 Then Item$ = ""
                        Model$ = RTrim$(Equip.Model)
                        If Asc(Model$) = 255 Then Model$ = ""
                        Department$ = RTrim$(Equip.Department)
                        If Asc(Department$) = 255 Then Department$ = ""
                        Location$ = RTrim$(Equip.Location)
                        If Asc(Location$) = 255 Then Location$ = ""
                        Create$ = RTrim$(UCase$(Equip.Note1))
          
                        ChangeWin = ExplodeWindow(3, 2, 74, 9, ManipulateC1, ManipulateC2, DoubleFrame, "Change an Item", 1, "")
                        WinPrint ChangeWin, 2, 1, "Serial Number:                    Item Description:____________________"
                        WinPrint ChangeWin, 3, 1, String$(74, 196)
                        WinPrint ChangeWin, 4, 1, "Model:__________    Department:__________    Location:__________"
                        WinPrint ChangeWin, 5, 1, String$(74, 196)
                        WinPrint ChangeWin, 6, 1, "TAB        to move forward in fields       <ESC>   to abort input"
                        WinPrint ChangeWin, 7, 1, "BACKTAB    to move backward in fields      <ENTER> to accept information"
                        WinPrint ChangeWin, 8, 1, String$(74, 196)
                        WinPrintCenter ChangeWin, 9, "Type a '?' in the Department field for a list of Departments"

                        WinPrint ChangeWin, 2, 15, UCase$(Serial$)
                        WinPrint ChangeWin, 2, 52, Item$
                        WinPrint ChangeWin, 4, 7, Model$
                        WinPrint ChangeWin, 4, 32, Department$
                        WinPrint ChangeWin, 4, 55, Location$
          
                        place = 1
           
                        Do
                            If place = 1 Then
                                Kbd$ = GetString$(ChangeWin, 2, 52, Item$, Item$, 20, 20)
                                Equip.Item = Item$
                                If Move$ = "TAB" Then place = 2
                                If Move$ = "BKTAB" Then place = 4
                                If Move$ = "ESC" Then Exit Do
                                If Move$ = "RET" Then Exit Do
                            End If
                            If place = 2 Then
                                Kbd$ = GetString$(ChangeWin, 4, 7, Model$, Model$, 10, 10)
                                If Move$ = "TAB" Then place = 3
                                If Move$ = "BKTAB" Then place = 1
                                If Move$ = "ESC" Then Exit Do
                                If Move$ = "RET" Then Exit Do
                            End If
                            If place = 3 Then
                                Kbd$ = GetString$(ChangeWin, 4, 32, Department$, Department$, 10, 10)
                                If RTrim$(Department$) = "?" Then
                                    GoSub ShowChangeChoices
                                End If
                                If Move$ = "TAB" Then place = 4
                                If Move$ = "BKTAB" Then place = 2
                                If Move$ = "ESC" Then Exit Do
                                If Move$ = "RET" Then Exit Do
                            End If
                            If place = 4 Then
                                Kbd$ = GetString$(ChangeWin, 4, 55, Location$, Location$, 10, 10)
                                If Move$ = "TAB" Then place = 1
                                If Move$ = "BKTAB" Then place = 3
                                If Move$ = "ESC" Then Exit Do
                                If Move$ = "RET" Then Exit Do
                            End If
                        Loop
               
                        Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
                        For t = 1 To LOF(1) / EquipLength
                            Get #1, t, Equip
                            If RTrim$(Equip.SerialNumber) = RTrim$(Serial$) Then
                                flag = t
                                Exit For
                            End If
                        Next
              
                        If Move$ = "RET" Then
                            Equip.SerialNumber = Serial$
                            Equip.Item = Item$
                            Equip.Model = Model$
                            Equip.Department = Department$
                            Equip.Location = Location$
                            Equip.Department = UCase$(Department$)
                            Put #1, flag, Equip
                        End If
                   
                        PUnlock flag
                        Close #1
              
                        CloseWindow ChangeWin
                    Else
                        ErrWin = ExplodeWindow(8, 5, 41, 5, 15, 4, DoubleFrame, "ERROR!", 1, "")
                        WinPrintCenter ErrWin, 1, "Your ID number does not match up with"
                        WinPrintCenter ErrWin, 2, "the ID number that created this item."
                        WinPrintCenter ErrWin, 3, "Therefore, YOU CANNOT CHANGE THIS ITEM!"
                        WinPrintCenter ErrWin, 5, "<Press any key to continue>"
                        Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
                        PUnlock flag
                        Close #1
                        GetKey ""
                        CloseWindow ErrWin
                    End If
                ElseIf RTrim$(Equip.Note2) = "LOCKED" Then
                    ErrWin = ExplodeWindow(7, 15, 50, 4, 15, 4, DoubleFrame, "ERROR!", 1, "")
                    WinPrintCenter ErrWin, 1, "You cannot change this record at this time."
                    WinPrintCenter ErrWin, 2, "Another user is accessing it."
                    WinPrintCenter ErrWin, 4, "<Press any key to continue>"
                    GetKey ""
                    CloseWindow ErrWin
                    Close #1
                End If
            Else
                ErrWin = ExplodeWindow(7, 15, 50, 3, 15, 4, DoubleFrame, "ERROR!", 1, "")
                WinPrintCenter ErrWin, 1, "You cannot change a nonexistent item!"
                WinPrintCenter ErrWin, 3, "<Press any key to continue>"
                Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
                PUnlock flag
                Close #1
                GetKey ""
                CloseWindow ErrWin
            End If
        End If
    Loop
    Exit Sub

    ShowChangeChoices:
    For t = 1 To MAXRECS
        Model$(t) = ""
    Next
    ShowFlag = 0

    Serial$ = RTrim$(Equip.SerialNumber)
    Item$ = RTrim$(Equip.Item)
    Model$ = RTrim$(Equip.Model)
    Department$ = RTrim$(Equip.Department)
    Location$ = RTrim$(Equip.Location)
    Create$ = RTrim$(UCase$(Equip.Note1))
             

    NumberOfChoices = 0
    Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
    num.recs = LOF(1) / EquipLength
    For count = 1 To num.recs
        Get #1, count, Equip
        If Asc(Equip.Department) <> 255 Then
            CurrentInfo$ = UCase$(RTrim$(Equip.Department))
            For t = 1 To NumberOfChoices
                If CurrentInfo$ = Model$(t) Then
                    ShowFlag = 1
                    Exit For
                End If
            Next
            If ShowFlag = 0 Then
                ShowFlag = 0
                Model$(NumberOfChoices + 1) = CurrentInfo$
                NumberOfChoices = NumberOfChoices + 1
            Else
                ShowFlag = 0
            End If
        End If
    Next
    Close #1

    Equip.SerialNumber = Serial$
    Equip.Item = Item$
    Equip.Model = Model$
    Equip.Location = Location$
    Equip.Note1 = Create$

    If NumberOfChoices > 18 Then NumberOfChoices = 18

    Model$(NumberOfChoices + 1) = "None!"

    NewChoice = Menu(NewChoice, 4, 4, 10, MenuC1, MenuC2, Model$(), Hot$, NumberOfChoices + 1)

    Move$ = ""

    If NewChoice = NumberOfChoices + 1 Or NewChoice < 1 Then Department$ = "": Return

    Department$ = RTrim$(Model$(NewChoice))

    Return
End Sub

Sub ChangeSortField
    Dim Item$(6)

    Item$(1) = " Serial Number"
    Item$(2) = " Item Description"
    Item$(3) = " Model Number"
    Item$(4) = " Department"
    Item$(5) = " Location"
    Item$(6) = " Quit!"
    Hot$ = "SIMDLQ"

    NewChoice = SortField

    NewChoice = Menu(NewChoice, 7, 10, 19, MenuC1, MenuC2, Item$(), Hot$, 6)

    If NewChoice > 5 Or NewChoice < 1 Then
        Exit Sub
    ElseIf NewChoice < 6 Then
        SortField = NewChoice
    End If

    Open Directory$ + Left$(IDNum$, 8) + ".INI" For Output As #1
    Print #1, SortField
    Close #1

End Sub

Sub ClearKey
    Do Until InKey$ = "": Loop
End Sub

Sub ClearRandom
    Kill Directory$ + "INVENRAN.DAT"
   
    Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
    For count = 1 To STARTMAX
        Get #1, count, Equip
        Equip.SerialNumber = Chr$(255)
        Equip.Item = Chr$(255)
        Equip.Model = Chr$(255)
        Equip.Department = Chr$(255)
        Equip.Location = Chr$(255)
        Equip.Note1 = Chr$(255)
        Equip.Note2 = Chr$(255)
        Put #1, count, Equip
    Next
    Close #1
End Sub

Sub ClearTemp
    Open Directory$ + RanFile$ For Random As #1 Len = EquipLength
    For count = 1 To MAXRECS
        Get #1, count, Equip
        If Asc(Equip.SerialNumber) <> 255 Then
            Equip.SerialNumber = Chr$(255)
            Equip.Item = Chr$(255)
            Equip.Model = Chr$(255)
            Equip.Department = Chr$(255)
            Equip.Location = Chr$(255)
            Equip.Note1 = Chr$(255)
            Equip.Note2 = Chr$(255)
            Put #1, count, Equip
        End If
    Next
    Close #1
End Sub

Sub CloseAll
    For i = 1 To WinCount
        CloseWindow WinCount
    Next
End Sub

Sub CloseWindow (WinNumber)
    If WinNumber = 0 Then Exit Sub
    If WinNumber > WinCount Then Exit Sub
    For count = WinNumber To WinCount
        Handle(count) = Handle(count + 1)
    Next
    WinCount = WinCount - 1
    If redraw = 1 Then RedrawAll
End Sub

Sub DeleteRecord
    Do Until finished = TRUE
        MoveFile

        Sort 6, SortField, MAXRECS

        flag1 = Browse(flag1, 3, 5, 69, 15, 1, " ", 5, Locs(), Title$(), MAXRECS, "Delete a Record - <ENTER> to Delete")
  
        If flag1 = -1 Then
            finished = TRUE
        End If

        If finished = FALSE Then
            Open Directory$ + RanFile$ For Random As #1 Len = EquipLength
            Get #1, flag1, Equip
            Close #1
            flag = Val(Equip.Note1)

            If Asc(Equip.SerialNumber) <> 255 And Move$ = Chr$(13) Then
                Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
                Get #1, flag, Equip
                Close #1
                Create$ = RTrim$(UCase$(Equip.Note1))

                If RTrim$(Equip.Note2) <> "LOCKED" Then
                    Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
                    PLock flag
                    Get #1, flag, Equip
                    Close #1
                    If IDNum$ = Create$ Or IDNum$ = "MANAGER" Then
                  
                        AskWin = ExplodeWindow(6, 7, 20, 1, InfoC1, InfoC2, DoubleFrame, "Delete", 1, "")
                        WinPrintCenter AskWin, 1, "Are you sure? "

                        Ask$ = ""
                        Do While UCase$(Ask$) <> "Y" And UCase$(Ask$) <> "N"
                            Kbd$ = GetString$(AskWin, 1, 17, "", Ask$, 1, 1)
                            Ask$ = UCase$(Ask$)
                            Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
                            For t = 1 To LOF(1) / EquipLength
                                Get #1, t, Equip
                                If RTrim$(Equip.SerialNumber) = RTrim$(Serial$) Then
                                    flag = t
                                    Exit For
                                End If
                            Next
                                   
                            If Ask$ = "Y" Then
                                Equip.SerialNumber = Chr$(255)
                                Equip.Item = Chr$(255)
                                Equip.Model = Chr$(255)
                                Equip.Department = Chr$(255)
                                Equip.Location = Chr$(255)
                                Equip.Note1 = Chr$(255)
                                Equip.Note2 = ""
                                Put #1, flag, Equip
                            ElseIf Ask$ = "N" Then
                                PUnlock flag
                            End If
                               
                            Close #1
                        Loop
                           
                        CloseWindow AskWin
                    Else
                        ErrWin = ExplodeWindow(8, 5, 41, 5, 15, 4, DoubleFrame, "ERROR!", 1, "")
                        WinPrintCenter ErrWin, 1, "Your ID number does not match up with"
                        WinPrintCenter ErrWin, 2, "the ID number that created this item."
                        WinPrintCenter ErrWin, 3, "Therefore, YOU CANNOT DELETE THIS ITEM!"
                        WinPrintCenter ErrWin, 5, "<Press any key to continue>"
                        Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
                        PUnlock flag
                        Close #1
                        GetKey ""
                        CloseWindow ErrWin
                    End If
                ElseIf RTrim$(Equip.Note2) = "LOCKED" Then
                    ErrWin = ExplodeWindow(7, 15, 50, 4, 15, 4, DoubleFrame, "ERROR!", 1, "")
                    WinPrintCenter ErrWin, 1, "You cannot change this record at this time."
                    WinPrintCenter ErrWin, 2, "Another user is accessing it."
                    WinPrintCenter ErrWin, 4, "<Press any key to continue>"
                    GetKey ""
                    CloseWindow ErrWin
                End If
            ElseIf Asc(Equip.SerialNumber) = 255 Then
                ErrWin = ExplodeWindow(7, 15, 50, 3, 15, 4, DoubleFrame, "ERROR!", 1, "")
                WinPrintCenter ErrWin, 1, "You cannot delete a nonexistent item!"
                WinPrintCenter ErrWin, 3, "<Press any key to continue>"
                Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
                PUnlock flag
                Close #1
                GetKey ""
                CloseWindow ErrWin
            End If
        End If
    Loop
End Sub

Sub DrawFrame (WinNumber)
    X = Handle(WinNumber).XPos
    Y = Handle(WinNumber).YPos
    L = Handle(WinNumber).Length
    H = Handle(WinNumber).Height
    F = Handle(WinNumber).Foreground
    B = Handle(WinNumber).Background
    Frame$ = Handle(WinNumber).Frame

    If X = 0 Or Y = 0 Or L = 0 Or H = 0 Or RTrim$(Frame$) = "" Then Exit Sub

    Color F, B
    Locate X, Y
    Print Left$(Frame$, 1); String$(L, Right$(Frame$, 1)); Mid$(Frame$, 2, 1);
    For count = 1 To H
        Locate X + count, Y
        Print Mid$(Frame$, 5, 1);
        Locate X + count, Y + L + 1
        Print Mid$(Frame$, 5, 1);
    Next
    Locate X + count, Y
    Print Mid$(Frame$, 3, 1); String$(L, Right$(Frame$, 1)); Mid$(Frame$, 4, 1);
End Sub

Sub DrawShadow (WinNumber)
    X = Handle(WinNumber).XPos
    Y = Handle(WinNumber).YPos
    F = Handle(WinNumber).Foreground
    B = Handle(WinNumber).Background
    L = Handle(WinNumber).Length
    H = Handle(WinNumber).Height
    Shadow = Handle(WinNumber).Shadow
    Shad$ = Handle(WinNumber).ShadChar
       
    If Shadow = 1 Then
        Color 7, 0
        YY = Y + L + 2
        XX = X
        For cnt = 1 To H + 1
            Locate XX + cnt, YY
            Print String$(2, Shad$);
        Next
        If X + H + 2 <= 25 Then Locate X + H + 2, Y + 2: Print String$(L + 2, Shad$);
        Color F, B
    End If
End Sub

Sub DrawTitle (WinNumber)
    X = Handle(WinNumber).XPos
    Y = Handle(WinNumber).YPos
    L = Handle(WinNumber).Length
    F = Handle(WinNumber).Foreground
    B = Handle(WinNumber).Background
    Title$ = Handle(WinNumber).Title
    If RTrim$(Title$) = "" Then Exit Sub

    Color F, B

    If RTrim$(Title$) <> "" And Len(RTrim$(Title$)) < (L - 2) Then
        YY = (Int(L / 2)) - (Int(Len(RTrim$(Title$)) / 2))
        Locate X, Y + YY: Print " "; RTrim$(Title$); " ";
    End If
End Sub

Sub EditMenu
    Dim MenuItem$(6)
  
    MenuItem$(1) = " Enter new Item..."
    MenuItem$(2) = " Delete Item(s)..."
    MenuItem$(3) = " Change Item(s)..."
    MenuItem$(4) = "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    MenuItem$(5) = " Browse through specified Items..."
    MenuItem$(6) = " Browse through all Items"
    Hot$ = "EDC SA"

    Do Until NewChoice < 0
        Color MenuC2, MenuC1
        Locate 1, 11
        Print " Edit "

        NewChoice = Menu(NewChoice, 2, 10, 36, MenuC1, MenuC2, MenuItem$(), Hot$, 6)

        Select Case NewChoice
            Case 1
                AddRecord
            Case 2
                DeleteRecord
            Case 3
                ChangeRecord
            Case 5
                SelectBrowse
            Case 6
                ShowAll
            Case -2
                subchoice = -2
            Case -3
                subchoice = -3
            Case Else
        End Select
    Loop
End Sub

Sub Ending
    WinRedraw 0
    FinalWindow = ExplodeWindow(5, 20, 40, 9, MenuC1, MenuC2, DoubleFrame, "Goodbye!", 1, "")
    WinPrintCenter FinalWindow, 1, "Thank you for using the"
    WinPrintCenter FinalWindow, 2, "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
    WinPrintCenter FinalWindow, 3, "³                                   ³"
    WinPrintCenter FinalWindow, 4, "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
    WinPrintCenter FinalWindow, 5, "Your records are safe with us!"
    WinPrintCenter FinalWindow, 8, "(c)Copyright 1993 by Nathan Thomas"
    WinPrintCenter FinalWindow, 9, "All Rights Reserved"
    FinalWindow1 = MakeWindow(7, 23, 35, 1, ManipulateC2, ManipulateC1, "", "", 0, "")
    WinPrintCenter FinalWindow1, 1, "I N V E N T O R Y   M A N A G E R"
    Sleep 4
    redraw = 0
    CloseAll
    ClearKey
    Color 7, 0
    Cls
    Kill Directory$ + RanFile$
    End
End Sub

Function ExplodeWindow% (X, Y, L, H, Fore, Back, Frame$, Title$, Shadow, ShadChar$)
    Dur = Int(Dur)
    If Dur < 1 Then Dur = 1
    WinCount = WinCount + 1
    Handle(WinCount).XPos = X
    Handle(WinCount).YPos = Y
    Handle(WinCount).Length = L
    Handle(WinCount).Height = H
    Handle(WinCount).Foreground = Fore
    Handle(WinCount).Background = Back
    Handle(WinCount).Frame = Frame$
    Handle(WinCount).Title = Title$
    Handle(WinCount).Shadow = Shadow
    Handle(WinCount).ShadChar = ShadChar$
    Handle(WinCount).Buffer = ""
 
    Color Fore, Back
    L1 = 0
    H1 = 0
    X1 = X + Int(H / 2) + 1
    Y1 = Y + Int(L / 2)
    Do
        Locate X1, Y1
        Print Left$(Frame$, 1); String$(L1, Right$(Frame$, 1)); Mid$(Frame$, 2, 1);
        For count = 1 To H1
            Locate X1 + count, Y1
            Print Mid$(Frame$, 5, 1); Space$(L1); Mid$(Frame$, 5, 1);
        Next
        Locate X1 + count, Y1
        Print Mid$(Frame$, 3, 1); String$(L1, Right$(Frame$, 1)); Mid$(Frame$, 4, 1);

        If L1 = L And H1 = H And X1 = X And Y1 = Y Then Exit Do

        If L1 + (Dur * 2) > L Then
            L1 = L
        Else
            L1 = L1 + (Dur * 2)
        End If

        If Y1 - Dur < Y Then
            Y1 = Y
        Else
            Y1 = Y1 - Dur
        End If

        If H1 + Dur > H Then
            H1 = H
        Else
            H1 = H1 + Dur
        End If

        If X1 - Dur < X Then
            X1 = X
        Else
            X1 = X1 - Dur
        End If
        For t = 1 To 500: Next
    Loop
    ExplodeWindow% = WinCount
    DrawTitle WinCount
    DrawShadow WinCount
End Function

Sub FileMenu
    Dim MenuItem$(6)

    MenuItem$(1) = " Clear Data File"
    MenuItem$(2) = "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    MenuItem$(4) = "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    MenuItem$(5) = " DOS Shell"
    MenuItem$(6) = " Exit"
    Hot$ = "C D SX"

    Do Until NewChoice < 0
        DD$ = Left$(Directory$ + "                    ", 20)
        If Len(DD$) < Len(Directory$) Then
            DD$ = Left$(DD$, 19) + Chr$(16)
        End If

        MenuItem$(3) = " Directory      " + DD$

        Color MenuC2, MenuC1
        Locate 1, 5
        Print " File "

        NewChoice = Menu(NewChoice, 2, 4, 38, MenuC1, MenuC2, MenuItem$(), Hot$, 6)

        Select Case NewChoice
            Case 1
                ClearRandom
            Case 3
                ChangeDir
            Case 5
                Color 7, 0
                Cls
                Color MenuC1, MenuC2
                Locate 8, 1: Print "Type EXIT to return to the Inventory Manager"
                Shell
                Locate 25, 30: Print "Press any key to return to the INVENTORY MANAGER...";
                GetKey ""
                RedrawAll
            Case 6
                CloseAll
                Ending
            Case -2
                subchoice = -2
            Case -3
                subchoice = -3
            Case Else
        End Select
    Loop
End Sub

Sub GenerateRandomFile
    Randomize Timer
    For t = 1 To 8
        cc = Int(Rnd(1) * 25) + 65
        RanFile$ = RanFile$ + Chr$(cc)
        Print Chr$(cc);
    Next
    RanFile$ = RanFile$ + ".TMP"
End Sub

Sub GetDirectory
    Shell "cd > CURRDIR"
    Open "CURRDIR" For Input As #1
    Line Input #1, Directory$
    Close #1
    Kill "CURRDIR"

    If Right$(Directory$, 1) <> "\" And Directory$ <> "" Then
        Directory$ = UCase$(Directory$) + "\"
    End If
End Sub

Sub GetKey (Char$)
    ClearKey

    Char$ = ""
    Do Until Char$ <> ""
        Char$ = InKey$
    Loop
End Sub

Function GetString$ (WinNumber, row, col, Start$, end$, Vis, MAX)
    Move$ = ""
    If WinNumber > WinCount Then Exit Function
    If WinNumber = 0 Then Exit Function
           
    X = Handle(WinNumber).XPos
    Y = Handle(WinNumber).YPos
    F = Handle(WinNumber).Foreground
    B = Handle(WinNumber).Background
    row = row + X
    col = col + Y
   
    curr$ = Left$(Start$, MAX)
    If curr$ = Chr$(8) Then curr$ = ""

    Locate , , 1
    Color F, B

    finished = FALSE
    Do
        GoSub GetStringShowText
        Kbd$ = ""
        GetKey Kbd$
        Locate , , 1

        Select Case Kbd$
            Case Chr$(0) + Chr$(15)
                Move$ = "BKTAB"
                finished = TRUE

            Case Chr$(9)
                Move$ = "TAB"
                finished = TRUE

            Case Chr$(27)
                Move$ = "ESC"
                finished = TRUE

            Case Chr$(13)
                Move$ = "RET"
                finished = TRUE
                GetString$ = Kbd$

            Case Chr$(27)
                finished = TRUE
                GetString$ = Kbd$
                Move$ = Kbd$
             
            Case Chr$(8)
                If curr$ <> "" Then
                    curr$ = Left$(curr$, Len(curr$) - 1)
                Else
                    Sound 1900, .2
                End If

            Case " " To Chr$(255)
                If Len(curr$) < MAX Then
                    curr$ = curr$ + Kbd$
                Else
                    Sound 1900, .2
                End If
             
            Case Else
                Sound 1900, .2
        End Select
   
    Loop Until finished

    end$ = curr$

    Locate , , 0
    Color F, B
    Exit Function

    GetStringShowText:
    Locate row, col, 0
    Color F, B
    If Len(curr$) > Vis Then
        WinPrint WinNumber, row - X, col - Y, Right$(curr$, Vis)
    Else
        WinPrint WinNumber, row - X, col - Y, curr$ + String$(Vis - Len(curr$), "_")
        Locate row, col + Len(curr$)
    End If
    Locate , , 1
    Return
End Function

Sub Intro
    FirstWin = ExplodeWindow(4, 18, 47, 9, 0, 7, SingleFrame, "Welcome!", 1, "")
    WinPrintCenter FirstWin, 2, "Welcome to Inventory Manager"
    WinPrintCenter FirstWin, 4, "Copyright (C) Nathan Thomas, 1993."
    WinPrintCenter FirstWin, 5, "All Rights Reserved."
    WinPrintCenter FirstWin, 7, String$(47, 196)
    WinPrintCenter FirstWin, 8, "Developed for NorthWest High School"
    WinPrintCenter FirstWin, 9, "Programmed by Nathan Thomas"


    InputWin = ExplodeWindow(16, 35, 34, 1, ManipulateC1, ManipulateC2, DoubleFrame, "", 1, "")
    WinPrint InputWin, 1, 3, "Enter your login ID:__________"

    Do Until IDNum$ <> "" And Pass$ = "INVENTORY"
        IDNum$ = UCase$(Environ$("ID"))
        Kbd$ = GetString$(InputWin, 1, 23, IDNum$, IDNum$, 10, 10)
        IDNum$ = UCase$(RTrim$(IDNum$))

        If IDNum$ = "MANAGER" Then
            PassWin = ExplodeWindow(17, 38, 34, 1, MenuC1, MenuC2, DoubleFrame, "", 1, "")
            WinPrint PassWin, 1, 3, "Enter the password:_________"
            Kbd$ = GetString$(PassWin, 1, 22, "", Pass$, 10, 10)
            Pass$ = UCase$(RTrim$(Pass$))
            If Pass$ <> "INVENTORY" Then CloseWindow PassWin
        Else
            Pass$ = "INVENTORY"
        End If
    Loop
    
    redraw = 0
    CloseAll
    redraw = 1
    RedrawAll

    WinInfo = MakeWindow(24, 0, 80, 1, InfoC1, InfoC2, "", "", 0, "")
    ShowMessage "Inventory Manager  (c)Copyright 1993 by Nathan Thomas"

    BarWin = MakeWindow(0, 0, 80, 1, MenuC1, MenuC2, "", "", 0, "")
    WinPrint BarWin, 1, 1, "  ð  File  Edit  Print  Options"
    WinPrint BarWin, 1, 61, "³Temp: " + RanFile$
    WinPrint BarWin, 1, (60 - Len(IDNum$)), IDNum$
    SortField = 1

    Open Directory$ + Left$(IDNum$, 8) + ".INI" For Input As #1
    Input #1, SortField
    Close #1
End Sub

Function MakeWindow% (X, Y, L, H, Fore, Back, Frame$, Title$, Shadow, ShadChar$)
    WinCount = WinCount + 1
    Handle(WinCount).XPos = X
    Handle(WinCount).YPos = Y
    Handle(WinCount).Length = L
    Handle(WinCount).Height = H
    Handle(WinCount).Foreground = Fore
    Handle(WinCount).Background = Back
    Handle(WinCount).Frame = Frame$
    Handle(WinCount).Title = Title$
    Handle(WinCount).Shadow = Shadow
    Handle(WinCount).ShadChar = ShadChar$
    Handle(WinCount).Buffer = ""
 
    Color Fore, Back
    If redraw = 1 Then
        DrawFrame WinCount
        DrawTitle WinCount
        DrawShadow WinCount
        For t = 1 To H
            Locate X + t, Y + 1
            Print Space$(L);
        Next
    End If
    MakeWindow% = WinCount
End Function

Function Menu% (currChoice, X, Y, Length, Fg, Bg, Item$(), Hot$, NumOfItems)

    Hot$ = UCase$(Hot$)
    If RTrim$(Hot$) <> "" Then Length = Length + 1

    Height = NumOfItems

    MenuWin = MakeWindow(X, Y, Length, Height, Fg, Bg, DoubleFrame, "", 1, "")
    For t = 1 To NumOfItems
        Item$(t) = Left$(Item$(t) + Space$(Length), Length)
        If RTrim$(Hot$) <> "" And Mid$(Hot$, t, 1) <> " " Then
            Item$(t) = Left$(Item$(t), Length - 1) + Mid$(Hot$, t, 1) + " "
        ElseIf Left$(Item$(t), 1) = "Ä" Then
            Item$(t) = Left$(Item$(t), Length - 1) + "Ä"
        End If
        WinPrint MenuWin, t, 1, Item$(t)
    Next

    If currChoice = 0 Then currChoice = 1

    redraw = 0
    MenuWin1 = MakeWindow(X + currChoice - 1, Y, Length, 1, Bg, Fg, "", "", 0, "")
    redraw = 1

    finished = FALSE
    Do Until finished = TRUE
        WinRedraw MenuWin
        WinPrint MenuWin1, 1, 1, Item$(currChoice)

        GetKey Kbd$
        Kbd$ = UCase$(Kbd$)

        Select Case Kbd$
            Case Chr$(0) + "H"
                currChoice = currChoice - 1
                If currChoice = 0 Then currChoice = NumOfItems
                If Left$(Item$(currChoice), 1) = "Ä" Or Left$(Item$(currChoice), 1) = "Í" Then
                    currChoice = currChoice - 1
                End If

            Case Chr$(0) + "P"
                currChoice = currChoice + 1
                If currChoice = NumOfItems + 1 Then currChoice = 1
                If Left$(Item$(currChoice), 1) = "Ä" Or Left$(Item$(currChoice), 1) = "Í" Then
                    currChoice = currChoice + 1
                End If

            Case Chr$(0) + "K"
                currChoice = -2
                finished = TRUE

            Case Chr$(0) + "M"
                currChoice = -3
                finished = TRUE

            Case Chr$(13)
                finished = TRUE

            Case "A" To "z"
                GoSub GetHotKey

            Case Else
                Sound 1900, .2
        End Select
       
        Handle(MenuWin1).XPos = X + currChoice - 1
        Handle(MenuWin1).YPos = Y
    Loop
    redraw = 0
    CloseWindow MenuWin1
    CloseWindow MenuWin
    redraw = 1
    RedrawAll
    Menu% = currChoice
    Exit Function

    GetHotKey:
    For MB = 1 To NumOfItems
        If UCase$(Mid$(Hot$, MB, 1)) = UCase$(Kbd$) Then
            finished = TRUE

            If MB <> currChoice Then
                Handle(MenuWin1).XPos = X + MB - 1
                Handle(MenuWin1).YPos = Y
                WinRedraw MenuWin
                WinPrint MenuWin1, 1, 1, Item$(MB)
                For t = 1 To 12000: Next
            End If

            currChoice = MB
        End If
    Next
    Return

End Function

Sub MoveFile
    CalcMax
    HoldOn = ExplodeWindow(10, 26, 27, 2, 0, 7, SingleFrame, "", 1, "")
    WinPrintCenter HoldOn, 1, "Updating..."
    WinPrint HoldOn, 2, 3, "[úúúúúúúúúúúúúúú]  0%  "

    Kill Directory$ + RanFile$
  
    st$ = "copy " + Directory$ + "INVENRAN.DAT " + Directory$ + RanFile$ + " > NUL"
  
    Locate , , , 16, 16
    Shell st$
    Locate , , , 11, 12

    Interval = Int(MAXRECS / 15)

    Open Directory$ + RanFile$ For Random As #1 Len = EquipLength
    For count = 1 To MAXRECS
        Get #1, count, Equip
        Equip.Note1 = Str$(count)
        Equip.Note2 = ""
        Put #1, count, Equip
      
        If count = count1 + Interval Then
            WinPrint HoldOn, 2, 22, LTrim$(RTrim$(Str$(Int(100 * (count / MAXRECS))))) + "%"
            If NumOfCounts < 15 Then WinPrint HoldOn, 2, 4 + NumOfCounts, PercentageChar$
            count1 = count
            NumOfCounts = NumOfCounts + 1
        End If
    Next
    WinPrint HoldOn, 2, 3, "[" + String$(15, PercentageChar$) + "]  100%"
    Close #1

    CloseWindow HoldOn
End Sub

Sub Optimize
    CalcMax
    Kill Directory$ + RanFile$
  
    st$ = "copy " + Directory$ + "INVENRAN.DAT " + Directory$ + RanFile$ + " > NUL"
  
    Locate , , , 16, 16
    Shell st$
    Locate , , , 11, 12

    Sort 7, SortField, MAXRECS

    Kill Directory$ + "INVENRAN.DAT"

    Open Directory$ + RanFile$ For Random As #1 Len = EquipLength
    num.recs = LOF(1) / EquipLength
    Open Directory$ + "INVENRAN.DAT" For Random As #2 Len = EquipLength
    For count = 1 To num.recs
        Get #1, count, Equip
        If Asc(Equip.SerialNumber) <> 255 Then
            Put #2, count, Equip
        End If
    Next
    Close #2
    Close #1
End Sub

Sub OptionsMenu
    Dim MenuItem$(3)

    Do Until NewChoice < 0

        MenuItem$(1) = " Change Sort Field..."
        If MenuC1 = 15 Then
            CSys$ = "Color"
        Else
            CSys$ = "Monochrome"
        End If
        MenuItem$(2) = " Toggle Colors    " + Right$("          " + CSys$, 10)
        MenuItem$(3) = " Optimize"
        Hot$ = "CTO"

        If IDNum$ = "MANAGER" Then ccs = 3 Else ccs = 2

        Color MenuC2, MenuC1
        Locate 1, 24
        Print " Options "

        NewChoice = Menu(NewChoice, 2, 23, 30, MenuC1, MenuC2, MenuItem$(), Hot$, ccs)

        Select Case NewChoice
            Case 1
                ChangeSortField
            Case 2
                If CSys$ = "Color" Then
                    MenuC1 = 0
                    Handle(2).Foreground = 0
                    MenuC2 = 7
                    Handle(2).Background = 7
                    ManipulateC1 = 0
                    ManipulateC2 = 7
                    InfoC1 = 0
                    Handle(1).Foreground = 0
                    InfoC2 = 7
                    Handle(1).Background = 7
                Else
                    MenuC1 = 15
                    Handle(2).Foreground = 15
                    MenuC2 = 4
                    Handle(2).Background = 4
                    ManipulateC1 = 1
                    ManipulateC2 = 3
                    InfoC1 = 7
                    Handle(1).Foreground = 7
                    InfoC2 = 1
                    Handle(1).Background = 1
                End If
                RedrawAll
            Case 3
                Optimize
            Case -2
                subchoice = -2
            Case -3
                subchoice = -3
            Case Else
        End Select
    Loop
End Sub

Sub PLock (RecordNum)
    Get #1, RecordNum, Equip
    Equip.Note2 = "LOCKED"
    Put #1, RecordNum, Equip
End Sub

Sub PrintAll
    PrintErr = FALSE
    LPrint
    If PrintErr = TRUE Then Exit Sub

    ShowMessage "Printing all Records..."
    Open Directory$ + RanFile$ For Random As #1 Len = EquipLength
    For count = 1 To MAXRECS
        Get #1, count, Equip
        flag = Val(Equip.Note1)
        If Asc(Equip.SerialNumber) <> 255 Then
            SendToPrinter flag
        End If
    Next
    Close #1
    ShowMessage "Inventory Manager  (c)Copyright 1993 by Nathan Thomas"
End Sub

Sub PrintMenu
    Dim MenuItem$(2)
  
    MenuItem$(1) = " Print All Records"
    MenuItem$(2) = " Form Feed Printer"
    Hot$ = "PF"

    Do Until NewChoice < 0
        Color MenuC2, MenuC1
        Locate 1, 17
        Print " Print "

        NewChoice = Menu(NewChoice, 2, 16, 20, MenuC1, MenuC2, MenuItem$(), Hot$, 2)

        Select Case NewChoice
            Case 1
                MoveFile
                PrintAll
            Case 2
                LPrint Chr$(12)
                PrintedLines = 0
            Case -2
                subchoice = -2
            Case -3
                subchoice = -3
            Case Else
        End Select
    Loop
End Sub

Sub PUnlock (RecordNum)
    Get #1, RecordNum, Equip
    Equip.Note2 = Chr$(255)
    Put #1, RecordNum, Equip
End Sub

Sub RedrawAll
    For WCount = 0 To WinCount
        WinRedraw WCount
    Next
    Color 7, 0
End Sub

Sub SelectBrowse
    Dim MenuItem$(4)

    MenuItem$(1) = " Show by Model"
    MenuItem$(2) = " Show by Location"
    MenuItem$(3) = " Show by Department"
    MenuItem$(4) = " Quit!"
    Hot$ = "MLDQ"

    Do Until NewChoice = 4
        ShowFlag = 0
        NewChoice = Menu(NewChoice, 7, 10, 21, MenuC1, MenuC2, MenuItem$(), Hot$, 4)

        ClearTemp

        Select Case NewChoice

            Case 1
                InputWin = ExplodeWindow(6, 10, 41, 1, InfoC1, InfoC2, DoubleFrame, "Browse Model Type", 1, "")
                WinPrintCenter InputWin, 1, "Enter the model number:          "
                Kbd$ = GetString$(InputWin, 1, 28, "", Model$, 10, 10)
                Model$ = RTrim$(UCase$(Model$))
                CloseWindow InputWin
           
                If Model$ <> "" Then
                    ShowFlag = 1
                    count = 1
                    ShowMessage "Searching..."
                    CalcMax
                    Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
                    Open Directory$ + RanFile$ For Random As #2 Len = EquipLength
                    For count1 = 1 To MAXRECS
                        Get #1, count1, Equip
                        If RTrim$(UCase$(Equip.Model)) = Model$ Then
                            Equip.Note1 = Str$(count1)
                            Put #2, count, Equip
                            count = count + 1
                        End If
                    Next
                    Close #2
                    Close #1
                End If

            Case 2
                InputWin = ExplodeWindow(6, 10, 41, 1, InfoC1, InfoC2, DoubleFrame, "Browse Location", 1, "")
                WinPrintCenter InputWin, 1, "Enter the Location:          "
                Kbd$ = GetString$(InputWin, 1, 26, "", Location$, 10, 10)
                Location$ = RTrim$(UCase$(Location$))
                If Location$ = "" Then CloseWindow InputWin: Return
                CloseWindow InputWin
       
                If Location$ <> "" Then
                    ShowFlag = 1
                    count = 1
                    ShowMessage "Searching..."
                    CalcMax
                    Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
                    Open Directory$ + RanFile$ For Random As #2 Len = EquipLength
                    For count1 = 1 To MAXRECS
                        Get #1, count1, Equip
                        If Left$(RTrim$(UCase$(Equip.Location)), Len(Location$)) = Location$ Then
                            Equip.Note1 = Str$(count1)
                            Put #2, count, Equip
                            count = count + 1
                        End If
                    Next
                    Close #2
                    Close #1
                End If
          
            Case 3
                InputWin = ExplodeWindow(6, 10, 41, 1, InfoC1, InfoC2, DoubleFrame, "Browse Department", 1, "")
                WinPrintCenter InputWin, 1, "Enter the Department:          "
                Kbd$ = GetString$(InputWin, 1, 27, "", Department$, 10, 10)
                Department$ = RTrim$(UCase$(Department$))
                If Department$ = "" Then CloseWindow InputWin: Return
                CloseWindow InputWin
       
                If Department$ <> "" Then
                    ShowFlag = 1
                    count = 1
                    ShowMessage "Searching..."
                    CalcMax
                    Open Directory$ + "INVENRAN.DAT" For Random As #1 Len = EquipLength
                    Open Directory$ + RanFile$ For Random As #2 Len = EquipLength
                    For count1 = 1 To MAXRECS
                        Get #1, count1, Equip
                        If Left$(RTrim$(UCase$(Equip.Department)), Len(Department$)) = Department$ Then
                            Equip.Note1 = Str$(count1)
                            Put #2, count, Equip
                            count = count + 1
                        End If
                    Next
                    Close #2
                    Close #1
                End If
       
            Case 4
                Exit Sub
            Case Else
                NewChoice = 1

        End Select

        ShowMessage "Inventory Manager  (c)Copyright 1993 by Nathan Thomas"
        If ShowFlag = 1 Then
            If choice < 4 And (count - 1 > 0) Then
                Sort 6, SortField, count - 1

                Do
                    flag1 = Browse(flag1, 3, 5, 69, 15, 1, "", 5, Locs(), Title$(), count - 1, "Browse through Items - <P> to print record / <A> to print all")
                    If flag1 = -1 Then Exit Do
       
                    If Move$ = "P" Then
                        Open Directory$ + RanFile$ For Random As #1 Len = EquipLength
                        Get #1, flag1, Equip
                        Close #1
          
                        If Val(Equip.Note1) <> 0 Then
                            flag = Val(Equip.Note1)
                            SendToPrinter flag
                        End If
                    ElseIf Move$ = "A" Then
                        PrintAll
                    End If
                Loop
            End If
        End If
    Loop
End Sub

Sub SendToPrinter (RecordNum)
    PrintErr = FALSE
   
    Open Directory$ + RanFile$ For Random As #1 Len = EquipLength
    Get #1, RecordNum, Equip
    Close #1

    LPrint
    If PrintErr = FALSE Then
        PrintWin = ExplodeWindow(9, 27, 25, 3, ManipulateC1, ManipulateC2, DoubleFrame, "Print", 1, "")
        WinPrintCenter PrintWin, 2, "Printing Record:" + Str$(RecordNum)

        LPrint "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿";
        LPrint "³ Serial Number:"; Equip.SerialNumber; "     Item Description:"; Equip.Item; "     ³";
        LPrint "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´";
        LPrint "³ Model:"; Equip.Model; "    Department:"; Equip.Department; "    Location:"; Equip.Location; "            ³";
        LPrint "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ";
        CloseWindow PrintWin
    End If
End Sub

Sub ShowAll

    MoveFile

    Sort 6, SortField, MAXRECS

    Do
        flag1 = Browse(flag1, 3, 5, 69, 15, 1, "", 5, Locs(), Title$(), MAXRECS, "Browse through Items - <P> to print / <A> to print all")
        If flag1 = -1 Then Exit Do
        If Move$ = "P" Then
            Open Directory$ + RanFile$ For Random As #1 Len = EquipLength
            Get #1, flag1, Equip
            Close #1

            If Val(Equip.Note1) <> 0 Then
                flag = Val(Equip.Note1)
                SendToPrinter flag
            End If
        ElseIf Move$ = "A" Then
            PrintAll
        End If
    Loop
End Sub

Sub ShowMessage (Message$)
    Message$ = RTrim$(LTrim$(Message$))

    WinPrint 1, 1, 1, Space$(80)
    WinPrintCenter 1, 1, Message$
    WinRedraw 1
End Sub

Sub Sort (NumOfFields, SortField, NumOfItems)
    If SortField < 1 Then Exit Sub

    ShowMessage "Sorting..."

    Open Directory$ + RanFile$ For Random As #1 Len = EquipLength
    num.recs = LOF(1) / EquipLength

    Offset = Int(num.recs / 2)

    Do While Offset > 0
        Limit = num.recs - Offset
        Do
            Switch = FALSE

            For X = 1 To Limit
                Get #1, X, Equip
                Info$(1, 1) = Equip.SerialNumber
                Info$(2, 1) = Equip.Item
                Info$(3, 1) = Equip.Model
                Info$(4, 1) = Equip.Department
                Info$(5, 1) = Equip.Location
                Info$(6, 1) = Equip.Note1
                Info$(7, 1) = Equip.Note2
                Get #1, X + Offset, Equip
                Info$(1, 2) = Equip.SerialNumber
                Info$(2, 2) = Equip.Item
                Info$(3, 2) = Equip.Model
                Info$(4, 2) = Equip.Department
                Info$(5, 2) = Equip.Location
                Info$(6, 2) = Equip.Note1
                Info$(7, 2) = Equip.Note2
           
                If UCase$(Info$(SortField, 1)) > UCase$(Info$(SortField, 2)) Then
                    For cnt = 1 To NumOfFields
                        Swap Info$(cnt, 1), Info$(cnt, 2)
                    Next
                    Equip.SerialNumber = Info$(1, 1)
                    Equip.Item = Info$(2, 1)
                    Equip.Model = Info$(3, 1)
                    Equip.Department = Info$(4, 1)
                    Equip.Location = Info$(5, 1)
                    Equip.Note1 = Info$(6, 1)
                    Equip.Note2 = Info$(7, 1)
                    Put #1, X, Equip
                    Equip.SerialNumber = Info$(1, 2)
                    Equip.Item = Info$(2, 2)
                    Equip.Model = Info$(3, 2)
                    Equip.Department = Info$(4, 2)
                    Equip.Location = Info$(5, 2)
                    Equip.Note1 = Info$(6, 2)
                    Equip.Note2 = Info$(7, 2)
                    Put #1, X + Offset, Equip
               
                    Switch = X
                End If
            Next

            Limit = Switch - Offset
        Loop While Switch

        Offset = Offset \ 2
    Loop
    Close #1

    ShowMessage "Inventory Manager  (c)Copyright 1993 by Nathan Thomas"
End Sub

Sub WindowInitialize
    Cls
    Locate 1, 1, 0, 11, 12
    View Print 1 To 25
    If BackChar$ = "" Then BackChar$ = " "
    WinCount = -1
    redraw = 0
    FirstWin = MakeWindow(1, 0, 80, 23, Fore, Back, "", "", 0, "")
    Handle(0).Buffer = String$(2000, BackChar$)
    redraw = 1
    WinRedraw 0
    RedrawAll
End Sub

Sub WinPrint (WinNumber, row, col, text$)
    If WinNumber > WinCount Then Exit Sub
    If WinNumber < 1 Then Exit Sub
    X = Handle(WinNumber).XPos
    Y = Handle(WinNumber).YPos
    L = Handle(WinNumber).Length
    H = Handle(WinNumber).Height
    Buffer$ = Handle(WinNumber).Buffer
  
    For t = 1 To row - 1
        place = place + L
    Next
    place = place + col
  
    Mid$(Buffer$, place, Len(text$)) = text$
    Handle(WinNumber).Buffer = Buffer$

    If redraw = 1 Then
        If WinNumber = WinCount Then
            X = Handle(WinNumber).XPos
            Y = Handle(WinNumber).YPos
            L = Handle(WinNumber).Length
            H = Handle(WinNumber).Height
            F = Handle(WinNumber).Foreground
            B = Handle(WinNumber).Background
            Buffer$ = Handle(WinNumber).Buffer
                
            Color F, B
              
            pl = 1
            For t = 1 To H
                Locate X + t, Y + 1
                Print Mid$(Buffer$, pl, L);
                pl = pl + L
            Next
        Else
            WinRedraw WinNumber
        End If
    End If
End Sub

Sub WinPrintCenter (WinNumber, X, text$)
    L = Handle(WinNumber).Length
    If Len(text$) > L Then text$ = Left$(text$, L)
    Y = (Int(L / 2)) - (Int(Len(text$) / 2)) + 1
    WinPrint WinNumber, X, Y, text$
End Sub

Sub WinRedraw (WinNumber)
    For i = WinNumber To WinCount
        X = Handle(WinNumber).XPos
        Y = Handle(WinNumber).YPos
        L = Handle(WinNumber).Length
        H = Handle(WinNumber).Height
        F = Handle(WinNumber).Foreground
        B = Handle(WinNumber).Background
        Buffer$ = Handle(WinNumber).Buffer
        
        Color F, B
        DrawFrame WinNumber
        DrawTitle WinNumber
        DrawShadow WinNumber
            
        pl = 1
        For t = 1 To H
            Locate X + t, Y + 1
            Print Mid$(Buffer$, pl, L);
            pl = pl + L
        Next
    Next
End Sub

