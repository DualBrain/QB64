_Title "Files Function" ' b+ 2022-10-27

' direntry.h needs to be in QB64 folder  see end of code if don't have
Declare CustomType Library ".\direntry"
    Function load_dir& (s As String)
    Function has_next_entry& ()
    Sub close_dir ()
    Sub get_next_entry (s As String, flags As Long, file_size As Long)
End Declare

f$ = files$ ' gets files in _CWD$
ReDim currentDir$(1 To 1) ' redim makes dynamic storage array for files list
Split f$, Chr$(10), currentDir$()
For i = 1 To UBound(currentDir$)
    Print i, currentDir$(i)
    If i Mod 20 = 0 Then
        Print: Print "zzz...  press any to continue"
        Sleep
        Cls
    End If
Next


Function files$ ' mimics old QB45 files$ except that it is saved in a string you can process!
    ReDim dList$(0), fList$(0)
    ' the way GetLists is setup the 0 place is left blank, the ubound of list coming out should be number of items
    GetLists _CWD$, dList$(), fList$()
    'convert flist$ to an Astring$, dang there are empty strings, do manual join
    temp$ = ""
    For i = LBound(fList$) To UBound(fList$)
        If Len(fList$(i)) Then
            If Len(temp$) Then temp$ = temp$ + Chr$(10) + fList$(i) Else temp$ = fList$(i)
        End If
    Next
    files$ = temp$
End Function

Sub GetLists (SearchDirectory As String, DirList() As String, FileList() As String)
    Const IS_DIR = 1
    Const IS_FILE = 2
    Dim flags As Long, file_size As Long, DirCount As Integer, FileCount As Integer, length As Long
    Dim nam$
    ReDim _Preserve DirList(100), FileList(100)
    DirCount = 0: FileCount = 0

    If load_dir(SearchDirectory + Chr$(0)) Then
        Do
            length = has_next_entry
            If length > -1 Then
                nam$ = Space$(length)
                get_next_entry nam$, flags, file_size
                If (flags And IS_DIR) Then
                    DirCount = DirCount + 1
                    If DirCount > UBound(DirList) Then ReDim _Preserve DirList(UBound(DirList) + 100)
                    DirList(DirCount) = nam$
                ElseIf (flags And IS_FILE) Then
                    FileCount = FileCount + 1
                    If FileCount > UBound(FileList) Then ReDim _Preserve FileList(UBound(FileList) + 100)
                    FileList(FileCount) = nam$
                End If
            End If
        Loop Until length = -1
        'close_dir 'move to after end if  might correct the multi calls problem
    Else
    End If
    close_dir 'this  might correct the multi calls problem

    ReDim _Preserve DirList(DirCount)
    ReDim _Preserve FileList(FileCount)
End Sub

' note: I buggered this twice now, FOR base 1 array REDIM MyArray (1 to 1) AS ... the (1 to 1) is not same as (1) which was the Blunder!!!
'notes: REDIM the array(0) to be loaded before calling Split '<<<< IMPORTANT dynamic array and empty, can use any lbound though
'This SUB will take a given N delimited string, and delimiter$ and create an array of N+1 strings using the LBOUND of the given dynamic array to load.
'notes: the loadMeArray() needs to be dynamic string array and will not change the LBOUND of the array it is given.  rev 2019-08-27
Sub Split (SplitMeString As String, delim As String, loadMeArray() As String)
    Dim curpos As Long, arrpos As Long, LD As Long, dpos As Long 'fix use the Lbound the array already has
    curpos = 1: arrpos = LBound(loadMeArray): LD = Len(delim)
    dpos = InStr(curpos, SplitMeString, delim)
    Do Until dpos = 0
        loadMeArray(arrpos) = Mid$(SplitMeString, curpos, dpos - curpos)
        arrpos = arrpos + 1
        If arrpos > UBound(loadMeArray) Then ReDim _Preserve loadMeArray(LBound(loadMeArray) To UBound(loadMeArray) + 1000) As String
        curpos = dpos + LD
        dpos = InStr(curpos, SplitMeString, delim)
    Loop
    loadMeArray(arrpos) = Mid$(SplitMeString, curpos)
    ReDim _Preserve loadMeArray(LBound(loadMeArray) To arrpos) As String 'get the ubound correct
End Sub