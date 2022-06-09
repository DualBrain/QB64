Option _Explicit

$Console:Only
_Dest _Console

Const true = -1, false = 0

Dim remoteFile$, localFile$
Dim newContents$

localFile$ = Command$
If Left$(localFile$, 2) = "./" Then localFile$ = Mid$(localFile$, 3)
If _FileExists(localFile$) = false Then
    Print "Incorrect usage."
    System
Else
    Print "*"; localFile$; "* found;"
End If

If InStr(_OS$, "WIN") Then
    remoteFile$ = "server_win.exe"
ElseIf InStr(_OS$, "MAC") Then
    remoteFile$ = "server_mac"
Else
    remoteFile$ = "server_lnx"
End If

If _FileExists(remoteFile$) Then
    Open remoteFile$ For Binary As #1
    newContents$ = Space$(LOF(1))
    Get #1, , newContents$
    Close #1

    Kill localFile$
    Open localFile$ For Binary As #1
    Put #1, , newContents$
    Close #1

    Kill remoteFile$
    If InStr(_OS$, "LINUX") Then Shell _Hide "chmod +x " + Chr$(34) + Command$ + Chr$(34)
    Shell _DontWait Chr$(34) + Command$ + Chr$(34)
    Print "Update successful."
    System
Else
    Print "Incorrect usage."
    System
End If

