Option _Explicit

Dim Shared gameVersion As Integer
'this is to be increased everytime the client
'becomes incompatible with previous versions
gameVersion = 3

$Let DEBUGGING = FALSE
$If DEBUGGING = TRUE Then
    $CONSOLE
$End If

$Console:Only
_Dest _Console

Const True = -1, False = 0

Const id_SERVERFULL = 1
Const id_PING = 2
Const id_ID = 3
Const id_NEWCOLOR = 4
Const id_NEWNAME = 5
Const id_COLOR = 6
Const id_POS = 7
Const id_NAME = 8
Const id_CHAT = 9
Const id_PLAYERONLINE = 10
Const id_PLAYEROFFLINE = 11
Const id_PONG = 12
Const id_PLAYERQUIT = 13
Const id_GAMEVERSION = 14
Const id_SHOOT = 15
Const id_SIZE = 16
Const id_UPDATESERVER = 17
Const id_KICK = 18

Type object
    name As String
    handle As Long
    x As Single
    xv As Single
    y As Single
    yv As Single
    state As Integer
    color As Integer
    basicInfoSent As _Byte
    broadcastOffline As _Byte
    ping As Single
    hasNewName As _Byte
    hasNewColor As _Byte
    hasNewPosition As String
    hasNewMessage As _Byte
    hasNewSize As _Byte
    size As Integer
End Type

Const maxUsers = 10

Dim Shared totalClients As Integer
Dim Shared playerStream(1 To maxUsers) As String
Dim Shared player(1 To maxUsers) As object
Dim Shared colors(1 To 12) As _Unsigned Long
Dim i As Long, j As Long
Dim newClient As Long, checkUpdate As _Byte, checkUpdateRequester As Integer
Dim id As Integer, value$
Dim packet$

Dim Shared endSignal As String
endSignal = Chr$(253) + Chr$(254) + Chr$(255)

Const timeout = 20

Dim Shared host As Long
Print Time$ + " Starting server (ver. "; _Trim$(Str$(gameVersion)); ")... ";
host = _OpenHost("TCP/IP:51512")
If host = 0 Then
    Print "Cannot listen on port 51512"
    System
End If
Print "Listening on port 51512"

Do
    newClient = 0
    newClient = _OpenConnection(host)
    If newClient Then
        If totalClients < maxUsers Then
            totalClients = totalClients + 1
            For i = 1 To maxUsers
                If player(i).state = False Then
                    playerStream(i) = ""
                    player(i).color = 0
                    player(i).handle = newClient
                    player(i).state = True
                    player(i).broadcastOffline = False
                    player(i).size = 15
                    sendData player(i), id_GAMEVERSION, MKI$(gameVersion)
                    sendData player(i), id_ID, MKI$(i)

                    'send existing players' data:
                    For j = 1 To maxUsers
                        If j = i Then _Continue
                        If player(j).state = True Then
                            sendData player(j), id_PLAYERONLINE, MKI$(i)

                            sendData player(i), id_PLAYERONLINE, MKI$(j)
                            sendData player(i), id_NAME, MKI$(j) + player(j).name
                            sendData player(i), id_COLOR, MKI$(j) + MKI$(player(j).color)
                            sendData player(i), id_POS, MKI$(j) + MKS$(player(j).x) + MKS$(player(j).y) + MKS$(player(j).xv) + MKS$(player(j).yv)
                            sendData player(i), id_SIZE, MKI$(j) + MKI$(player(j).size)
                        End If
                    Next

                    player(i).ping = Timer
                    Exit For
                End If
            Next
            Print Time$ + " User at " + _ConnectionAddress$(newClient) + " connected as client #" + LTrim$(Str$(i))
        Else
            packet$ = MKI$(id_SERVERFULL) + endSignal
            Put #newClient, , packet$
            Print Time$ + " Connection from " + _ConnectionAddress$(newClient) + " refused (server full)"
            Close newClient
        End If
    End If

    For i = 1 To maxUsers
        If player(i).state = False Then
            If player(i).broadcastOffline = False Then
                player(i).broadcastOffline = True
                For j = 1 To maxUsers
                    If j = i Or player(j).state = False Then _Continue
                    sendData player(j), id_PLAYEROFFLINE, MKI$(i)
                Next
            End If
            _Continue
        End If

        player(i).hasNewName = False
        player(i).hasNewColor = False
        player(i).hasNewPosition = ""
        player(i).hasNewMessage = False
        player(i).hasNewSize = False

        If timeElapsedSince(player(i).ping) > timeout Then
            'player inactive
            player(i).state = False
            Close player(i).handle
            Print Time$ + " Client #" + LTrim$(Str$(i)) + " (" + player(i).name + ") lost connection."
            totalClients = totalClients - 1
            _Continue
        End If

        getData player(i), playerStream(i)

        Do While parse(playerStream(i), id, value$)
            player(i).ping = Timer
            Select Case id
                Case id_NAME
                    player(i).hasNewName = True
                    player(i).name = value$
                    Dim attempt As Integer, checkAgain As _Byte, m$
                    m$ = ""
                    attempt = 0
                    Do
                        checkAgain = False
                        For j = 1 To maxUsers
                            If j = i Then _Continue
                            If attempt Then m$ = Str$(attempt)
                            If player(j).name = player(i).name + m$ Then
                                attempt = attempt + 1
                                checkAgain = True
                                Exit For
                            End If
                        Next
                    Loop While checkAgain
                    If attempt Then
                        player(i).name = player(i).name + m$
                        sendData player(i), id_NEWNAME, player(i).name
                    End If
                    Print Time$ + " Client #" + LTrim$(Str$(i)) + " has name " + player(i).name
                Case id_COLOR 'received once per player
                    player(i).hasNewColor = True
                    Dim newcolor As Integer, changed As _Byte
                    newcolor = CVI(value$)
                    changed = False
                    'check if this color is already in use, so another one can be assigned
                    For j = 1 To maxUsers
                        If player(j).state = True And player(j).color = newcolor Then
                            newcolor = newcolor + 1
                            If newcolor > UBound(colors) Then newcolor = 1
                            changed = True
                            j = 0 'check again
                        End If
                    Next
                    player(i).color = newcolor
                    If changed Then
                        sendData player(i), id_NEWCOLOR, MKI$(newcolor)
                    End If
                Case id_SHOOT
                    If player(CVI(value$)).size > 5 Then
                        player(CVI(value$)).size = player(CVI(value$)).size - 2
                    End If
                    For j = 1 To maxUsers
                        If player(j).state = False Then _Continue
                        sendData player(j), id_SHOOT, MKI$(i) + value$
                        sendData player(j), id_SIZE, value$ + MKI$(player(CVI(value$)).size)
                    Next
                Case id_POS
                    player(i).hasNewPosition = value$
                    player(i).x = getCVS(value$)
                    player(i).y = getCVS(value$)
                    player(i).xv = getCVS(value$)
                    player(i).yv = getCVS(value$)
                Case id_SIZE
                    player(i).hasNewSize = True
                    player(i).size = CVI(value$)
                Case id_GAMEVERSION
                    'player is signaling it will disconnect due to wrong version
                    player(i).x = -1
                    player(i).y = -1
                Case id_PLAYERQUIT
                    player(i).state = False
                    Close player(i).handle
                    totalClients = totalClients - 1
                    Print Time$ + " Client #" + LTrim$(Str$(i)) + " (" + player(i).name + ") quit";
                    If player(i).x = -1 And player(i).y = -1 Then
                        Print " - wrong version."
                    Else
                        Print "."
                    End If
                    Exit Do
                Case id_UPDATESERVER
                    'temporary solution for triggering auto-update checks
                    checkUpdate = True
                    checkUpdateRequester = i
                    Print Time$ + " Update check requested;"
                Case id_CHAT
                    Dim chatMessage$
                    player(i).hasNewMessage = True
                    chatMessage$ = value$
                Case id_PING
                    sendData player(i), id_PONG, ""
            End Select
        Loop

        If player(i).state = False Then
            _Continue
        Else
            'send this player's data to everybody else
            For j = 1 To maxUsers
                If j = i Then _Continue
                If player(j).state = True Then
                    If player(i).hasNewName Then sendData player(j), id_NAME, MKI$(i) + player(i).name
                    If player(i).hasNewColor Then sendData player(j), id_COLOR, MKI$(i) + MKI$(player(i).color)
                    If Len(player(i).hasNewPosition) Then sendData player(j), id_POS, MKI$(i) + player(i).hasNewPosition
                    If player(i).hasNewMessage Then sendData player(j), id_CHAT, MKI$(i) + chatMessage$
                    If player(i).hasNewSize Then sendData player(j), id_SIZE, MKI$(i) + MKI$(player(i).size)
                End If
            Next
        End If
    Next

    If checkUpdate Then
        Dim remoteFile$, result As Integer, file$, newVersion As Integer
        Dim fileHandle As Integer, updater$

        remoteFile$ = "www.qb64.org/amongst/amongst_version.txt"
        result = Download(remoteFile$, 30, file$)
        Select Case result
            Case 0 'success
                checkUpdate = False
                newVersion = Val(Mid$(file$, InStr(file$, "=") + 1))

                If newVersion > gameVersion Then
                    Print Time$ + " Downloading new version ("; LTrim$(Str$(newVersion)); ")... ";

                    If InStr(_OS$, "WIN") Then
                        remoteFile$ = "server_win.exe"
                        updater$ = "amongst_updater.exe"
                    ElseIf InStr(_OS$, "MAC") Then
                        remoteFile$ = "server_mac"
                        updater$ = "./amongst_updater"
                    Else
                        remoteFile$ = "server_lnx"
                        updater$ = "./amongst_updater"
                    End If

                    Do
                        result = Download("www.qb64.org/amongst/" + remoteFile$, 30, file$)

                        Select Case result
                            Case 0 'success
                                Print "done."
                                fileHandle = FreeFile
                                Open remoteFile$ For Binary As #fileHandle
                                Put #fileHandle, , file$
                                Close #fileHandle
                                If _FileExists(updater$) Then
                                    For j = 1 To maxUsers
                                        If player(j).state = False Then _Continue
                                        sendData player(j), id_KICK, "Server auto-updating; try again in a few moments."
                                    Next

                                    Close host
                                    Shell _DontWait Chr$(34) + updater$ + Chr$(34) + " " + Chr$(34) + Command$(0) + Chr$(34)
                                    System
                                Else
                                    packet$ = "Unable to update - missing '" + updater$ + "'."
                                    Print packet$
                                    sendData player(checkUpdateRequester), id_CHAT, MKI$(0) + packet$
                                    checkUpdate = False
                                    Exit Do
                                End If
                            Case 2, 3 'can't connect or timed out
                                packet$ = "Unable to download update; try again in a few moments."
                                Print packet$
                                sendData player(checkUpdateRequester), id_CHAT, MKI$(0) + packet$
                                checkUpdate = False
                                Exit Do
                        End Select
                        _Limit 10
                    Loop
                Else
                    packet$ = "No new version available."
                    Print packet$
                    sendData player(checkUpdateRequester), id_CHAT, MKI$(0) + packet$
                    checkUpdate = False
                End If
            Case 2, 3 'can't connect or timed out
                packet$ = "Unable to check new versions."
                Print packet$
                sendData player(checkUpdateRequester), id_CHAT, MKI$(0) + packet$
                checkUpdate = False
        End Select
    End If

    _Limit 60
Loop

Sub sendData (client As object, id As Integer, value$)
    Dim key$
    key$ = MKI$(id) + value$ + endSignal
    Put #client.handle, , key$
End Sub

Sub getData (client As object, buffer As String)
    Dim incoming$
    Get #client.handle, , incoming$
    buffer = buffer + incoming$
End Sub

Function parse%% (buffer As String, id As Integer, value$)
    Dim endMarker As Long
    endMarker = InStr(buffer, endSignal)
    If endMarker Then
        id = CVI(Left$(buffer, 2))
        value$ = Mid$(buffer, 3, endMarker - 3)
        buffer = Mid$(buffer, endMarker + Len(endSignal))
        parse%% = True
    End If
End Function

Function Download% (url$, timelimit, contents$)
    'adapted from http://www.qb64.org/wiki/Downloading_Files
    '
    'Usage:
    '    Call Download%() in a loop until one of the return codes
    '    bellow is returned. Contents downloaded are returned in
    '    the contents$ variable.
    '
    'Return codes:
    '    0 = success
    '    1 = still working
    '    2 = can't connect
    '    3 = timed out

    Static client As Long, l As Long
    Static prevUrl$, prevUrl2$, a$, a2$, url2$, url3$
    Static x As Long, i As Long, i2 As Long, i3 As Long
    Static e$, x$, t!, d$, fh As Integer

    If url$ = "" Then
        If client Then Close client: client = 0
        prevUrl$ = ""
        Exit Function
    End If

    If url$ <> prevUrl$ Then
        prevUrl$ = url$
        a$ = ""
        url2$ = url$
        x = InStr(url2$, "/")
        If x Then url2$ = Left$(url$, x - 1)
        If url2$ <> prevUrl2$ Then
            prevUrl2$ = url2$
            If client Then Close client: client = 0
            client = _OpenClient("TCP/IP:80:" + url2$)
            If client = 0 Then Download = 2: prevUrl$ = "": Exit Function
        End If
        e$ = Chr$(13) + Chr$(10) ' end of line characters
        url3$ = Right$(url$, Len(url$) - x + 1)
        x$ = "GET " + url3$ + " HTTP/1.1" + e$
        x$ = x$ + "Host: " + url2$ + e$ + e$
        Put #client, , x$
        t! = Timer ' start time
    End If

    Get #client, , a2$
    a$ = a$ + a2$
    i = InStr(a$, "Content-Length:")
    If i Then
        i2 = InStr(i, a$, e$)
        If i2 Then
            l = Val(Mid$(a$, i + 15, i2 - i - 14))
            i3 = InStr(i2, a$, e$ + e$)
            If i3 Then
                i3 = i3 + 4 'move i3 to start of data
                If (Len(a$) - i3 + 1) = l Then
                    d$ = Mid$(a$, i3, l)
                    fh = FreeFile
                    Download = 0
                    contents$ = d$
                    prevUrl$ = ""
                    prevUrl2$ = ""
                    a$ = ""
                    Close client
                    client = 0
                    Exit Function
                End If ' availabledata = l
            End If ' i3
        End If ' i2
    End If ' i
    If Timer > t! + timelimit Then Close client: client = 0: Download = 3: prevUrl$ = "": Exit Function
    Download = 1 'still working
End Function

Function getCVS! (buffer$)
    getCVS! = CVS(Left$(buffer$, 4))
    buffer$ = Mid$(buffer$, 5)
End Function

Function getCVI% (buffer$)
    getCVI% = CVI(Left$(buffer$, 2))
    buffer$ = Mid$(buffer$, 3)
End Function


Function timeElapsedSince! (startTime!)
    If startTime! > Timer Then startTime! = startTime! - 86400
    timeElapsedSince! = Timer - startTime!
End Function

