Option _Explicit
$Console:Only
Const False = 0
Const True = Not False

ReDim items(0) As String
Dim count As Integer
Dim i As Integer

count = FS_DirList("C:\", True, items())
Print "Child folders:"
For i = 1 To count
    Print "-> " + items(i)
Next i

count = FS_DirList("C:\", False, items())
Print "Child files:"
For i = 1 To count
    Print "-> " + items(i)
Next i

count = FS_DriveList(items())
Print "Drives:"
For i = 1 To count
    Print "-> " + items(i)
Next i



Function FS_DirList (path As String, dirmode As Integer, filenames() As String)
    Dim cmd As String

    ' Determine the OS-specific directory command
    $If WINDOWS Then
        If dirmode Then
            cmd = "dir /b /ad " + Chr$(34) + path + Chr$(34)
        Else
            cmd = "dir /b /a-d " + Chr$(34) + path + Chr$(34)
        End If
    $Else
        IF dirmode THEN
        cmd = "find " + CHR$(34) + path + CHR$(34) + " -maxdepth 1 -type d | sed '1d' | sed 's/.*\///g'"
        ELSE
        cmd = "ls -p " + CHR$(34) + path + CHR$(34) + " | grep -v / "
        END IF
    $End If

    Dim fcount As Integer
    If cmd <> "" Then
        Dim cmdResult As Integer, stdout As String, stderr As String
        cmdResult = pipecom(cmd, stdout, stderr)

        fcount = STR_Split(stdout, Chr$(10), filenames())
        fcount = fcount - 1 'Last line is blank
    End If

    ' Return the number of items in the result array
    FS_DirList = fcount
End Function

Function FS_DriveList (drives() As String)
    $If WINDOWS Then
        Dim cmdResult As Integer
        Dim stderr As String
        Dim text As String
        Dim count As Integer
        count = 0

        ' Get the drive list
        cmdResult = pipecom("cmd /c " + Chr$(34) + "fsutil fsinfo drives" + Chr$(34), text, stderr)
        text = GXSTR_Replace(text, "Drives: ", "")
        text = GXSTR_Replace(text, Chr$(10), "")
        text = GXSTR_Replace(text, "\", "")
        count = STR_Split(text, " ", drives())

        FS_DriveList = count
    $Else
        FS_DriveList = 0
    $End If
End Function

Function GXSTR_Replace$ (s As String, searchString As String, newString As String)
    Dim ns As String
    Dim i As Integer

    Dim slen As Integer
    slen = Len(searchString)

    For i = 1 To Len(s) '- slen + 1
        If Mid$(s, i, slen) = searchString Then
            ns = ns + newString
            i = i + slen - 1
        Else
            ns = ns + Mid$(s, i, 1)
        End If
    Next i

    GXSTR_Replace = ns
End Function

Function STR_Split (sourceString As String, delimiter As String, results() As String)
    ' Modified version of:
    ' https://www.qb64.org/forum/index.php?topic=1073.msg102711#msg102711
    Dim cstr As String, p As Long, curpos As Long, arrpos As Long, dpos As Long

    ' Make a copy of the source string
    cstr = sourceString

    ' Special case if the delimiter is space, remove all excess space
    If delimiter = " " Then
        cstr = RTrim$(LTrim$(cstr))
        p = InStr(cstr, "  ")
        While p > 0
            cstr = Mid$(cstr, 1, p - 1) + Mid$(cstr, p + 1)
            p = InStr(cstr, "  ")
        Wend
    End If
    curpos = 1
    arrpos = 0
    dpos = InStr(curpos, cstr, delimiter)
    Do Until dpos = 0
        arrpos = arrpos + 1
        ReDim _Preserve results(arrpos) As String
        results(arrpos) = Mid$(cstr, curpos, dpos - curpos)
        curpos = dpos + Len(delimiter)
        dpos = InStr(curpos, cstr, delimiter)
    Loop
    arrpos = arrpos + 1
    ReDim _Preserve results(arrpos) As String
    results(arrpos) = Mid$(cstr, curpos)

    STR_Split = arrpos
End Function

'$Include: 'pipecom.bm'
