Option _Explicit

Dim Shared gameVersion As Integer
'this is to be increased everytime the client
'becomes incompatible with previous versions
gameVersion = 3

$Let DEBUGGING = FALSE
$If DEBUGGING = TRUE Then
    $CONSOLE
$End If

Const True = -1, False = 0
Const mode_freeplay = 0
Const mode_onlineclient = 1

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

Const timeout = 20
Const dataSendThreshold = .5

Const windowWidth = 800
Const windowHeight = 600

Type object
    name As String
    handle As Long
    x As Single
    prevX As Single
    nextX As Single
    y As Single
    prevY As Single
    nextY As Single
    xv As Single
    yv As Single
    xa As Single
    ya As Single
    w As Integer
    h As Integer
    state As Integer
    start As Single
    duration As Single
    color As _Unsigned Long
    fgColor As _Unsigned Long
    basicInfoSent As _Byte
    stateSent As Single
    broadcastOffline As _Byte
    ping As Single
    id As Integer
    text As String
    size As Integer
    r As Integer
    g As Integer
    b As Integer
    gravity As Single
    delay As Single
End Type

Type colorType
    name As String
    value As _Unsigned Long
End Type

ReDim Shared ui(1 To 1) As object, mouseDownOn As Integer, uiClicked As _Byte
Dim Shared mouseIsDown As _Byte, mouseDownX As Integer, mouseDownY As Integer
Dim Shared mb1 As _Byte, mb2 As _Byte, mx As Integer, my As Integer
ReDim Shared serverList(0) As object, mouseWheel As Integer
Dim Shared focus As Integer
Dim Shared endSignal As String
Dim Shared mainWindow As Long, mapImage As Long, worldMapImage As Long
Dim Shared settingsScreenImage As Long, dialogImage As Long, chatLogImage As Long
Dim Shared scanLinesImage As Long
Dim Shared messageIcon As Long
Dim Shared particle(1000) As object
Dim Shared mode As Integer
Dim Shared totalClients As Integer
Dim Shared serverStream As String
Dim Shared player(1 To 10) As object, me As Integer
Dim Shared colors(1 To 12) As colorType, r As Integer, g As Integer, b As Integer
Dim Shared warning(1 To 30) As object
ReDim Shared chat(1 To 100) As object, hasUnreadMessages As _Byte, chatOpen As _Byte
Dim Shared chatScroll As Integer
Dim Shared chosenServer$
Dim Shared server As object
Dim Shared userName$, userColor%
Dim Shared exitSign As Integer
Dim Shared serverPing As Single
Dim Shared errorDialog As object
Dim radians As Single
Dim idSet As _Byte, shipMovement As _Byte
Dim currentPing As Single, waitingForPong As _Byte
Dim id As Integer, value$
Dim myMessage$, char$, tooFast As _Byte

Dim target As Integer
Dim score As Long
Dim i As Long
Dim x As Single, y As Single

endSignal = Chr$(253) + Chr$(254) + Chr$(255)

mainWindow = _NewImage(windowWidth, windowHeight, 32)
Screen mainWindow
Do Until _ScreenExists: _Limit 10: Loop
_Title "Amongst"
_PrintMode _KeepBackground
_ControlChr Off

readServerList
restoreColors
generateImages

intro
Do
    _Font 16
    settingsScreen

    'reset chat history, if any
    For i = 1 To UBound(chat)
        chat(i).state = False
    Next
    _Font 16
    If chatLogImage = 0 Then
        chatLogImage = _NewImage(windowWidth - 100, windowHeight - 100 - _FontHeight * 3, 32)
    End If
    chatScroll = -(_FontHeight * 2 * UBound(chat)) + _Height(chatLogImage)

    _Font 8
    _PrintMode _KeepBackground

    Dim Shared playerSpeed As Single
    Dim Shared camera As object

    Randomize Timer

    Const keyUP = 18432
    Const keyDOWN = 20480
    Const keyLEFT = 19200
    Const keyRIGHT = 19712
    Const keySPACE = 32

    Const cameraWindow = 100

    Const minSpeed = 3
    Const maxSpeed = 5

    playerSpeed = maxSpeed
    shipMovement = True

    uiReset
    i = addUiItem("messageicon", windowWidth - 50, 10, _Width(messageIcon), _Height(messageIcon))
    ui(i).handle = messageIcon
    ui(i).state = True
    ui(i).color = _RGB32(255)

    chatOpen = False
    myMessage$ = ""
    If mode > 0 Or server.handle <> 0 Then
        idSet = False
        If me Then player(me).basicInfoSent = False
    Else
        idSet = True
        me = 1
        player(me).name = userName$
        player(me).x = _Width / 2 + Cos(Rnd * _Pi) * (Rnd * 100)
        player(me).y = _Height / 2 + Sin(Rnd * _Pi) * (Rnd * 100)
        player(me).state = True
        player(me).color = userColor%
        player(me).size = 15
    End If

    Dim rx, ry, rr

    Do
        Cls

        Dim shipFlotation As Single, shipFloatAmplitude As Single
        If shipMovement Then
            shipFlotation = shipFlotation + .05
            If shipFlotation > _Pi(2) Then shipFlotation = shipFlotation - _Pi(2)
            shipFloatAmplitude = 1.5
        End If

        _DontBlend
        _PutImage (camera.x + Cos(shipFlotation) * shipFloatAmplitude, camera.y + Sin(shipFlotation) * shipFloatAmplitude), mapImage
        _Blend

        If mode = mode_onlineclient Or server.handle <> 0 Then
            If idSet Then
                If player(me).basicInfoSent = False Then
                    player(me).basicInfoSent = True
                    sendData server, id_COLOR, MKI$(player(me).color)
                    sendData server, id_NAME, player(me).name
                    sendData server, id_SIZE, MKI$(player(me).size)
                End If

                If timeElapsedSince(player(me).stateSent) > dataSendThreshold Or player(me).xv <> player(me).prevX Or player(me).yv <> player(me).prevY Then
                    player(me).prevX = player(me).xv
                    player(me).prevY = player(me).yv
                    player(me).stateSent = Timer

                    ' This number 50 is just made up, but it should be calculated form average ping.
                    sendData server, id_POS, MKS$(player(me).x + 50 * player(me).xv) + MKS$(player(me).y + 50 * player(me).yv) + MKS$(player(me).xv) + MKS$(player(me).yv)
                End If
            End If


            If waitingForPong = False Then
                serverPing = Timer
                sendData server, id_PING, ""
                waitingForPong = True
            End If

            getData server, serverStream
            While parse(serverStream, id, value$)
                Select EveryCase id
                    Case id_ID 'first piece of data sent by server if not full
                        idSet = True
                        me = CVI(value$)
                        player(me).name = userName$
                        player(me).x = _Width / 2 + Cos(Rnd * _Pi) * (Rnd * 100)
                        player(me).y = _Height / 2 + Sin(Rnd * _Pi) * (Rnd * 100)
                        player(me).nextX = player(me).x
                        player(me).nextY = player(me).y
                        player(me).state = True
                        player(me).color = userColor%
                        player(me).size = 15
                    Case id_NEWCOLOR 'server color changes must always be applied
                        player(me).color = CVI(value$)
                    Case id_NEWNAME 'server name changes must always be applied
                        player(me).name = value$
                    Case id_COLOR
                        player(CVI(Left$(value$, 2))).color = CVI(Right$(value$, 2))
                    Case id_SIZE
                        player(CVI(Left$(value$, 2))).size = CVI(Right$(value$, 2))
                    Case id_POS
                        'playerStream(CVI(LEFT$(value$, 2))) = playerStream(CVI(LEFT$(value$, 2))) + MID$(value$, 3)
                        id = getCVI(value$)
                        player(id).nextX = getCVS(value$)
                        player(id).nextY = getCVS(value$)
                        player(id).xv = getCVS(value$)
                        player(id).yv = getCVS(value$)
                    Case id_NAME
                        player(CVI(Left$(value$, 2))).name = Mid$(value$, 3)
                    Case id_CHAT
                        hasUnreadMessages = True
                        addMessageToChat CVI(Left$(value$, 2)), Mid$(value$, 3)
                    Case id_SHOOT
                        id = getCVI(value$)
                        If id = me Then _Continue
                        target = getCVI(value$)
                        If target = me Then score = score - 100
                        addParticles "explosion", player(target).x, player(target).y, 0, 0, 0, 5, 0, _RGB32(255), .3
                        addParticles "explosion", player(target).x, player(target).y, 0, 0, 0, 100, 0, colors(player(target).color).value, .3

                        radians = _Atan2(player(target).y - player(id).y, player(target).x - player(id).x)
                        For i = 1 To 20
                            addParticles "projectile", player(id).x + Cos(radians) * i, player(id).y + Sin(radians) * i, Cos(radians) * 5, Sin(radians) * 5, 2, 1, .5, colors(player(id).color).value, 0
                        Next
                    Case id_PLAYERONLINE
                        player(CVI(value$)).state = True
                    Case id_PLAYEROFFLINE
                        If player(CVI(value$)).state = True Then
                            player(CVI(value$)).state = False
                            addWarning player(CVI(value$)).name + " left the game."
                        End If
                    Case id_PONG
                        waitingForPong = False
                    Case id_KICK
                        setError "Kicked from server. Reason:" + Chr$(10) + value$, 3
                        Close server.handle
                        server.handle = 0
                        Exit Do
                End Select
            Wend

            totalClients = 0
            For i = 1 To UBound(player)
                If player(i).state = True Then totalClients = totalClients + 1
            Next
        End If

        If playerSpeed < minSpeed Then playerSpeed = minSpeed
        If playerSpeed > maxSpeed Then playerSpeed = maxSpeed

        If idSet Then
            If chatOpen = False Then
                player(me).xv = 0
                player(me).yv = 0
                If _KeyDown(keyUP) Then
                    player(me).nextY = player(me).y - playerSpeed
                    player(me).yv = -playerSpeed
                End If
                If _KeyDown(keyDOWN) Then
                    player(me).nextY = player(me).y + playerSpeed
                    player(me).yv = playerSpeed
                End If
                If _KeyDown(keyLEFT) Then
                    player(me).nextX = player(me).x - playerSpeed
                    player(me).xv = -playerSpeed
                End If
                If _KeyDown(keyRIGHT) Then
                    player(me).nextX = player(me).x + playerSpeed
                    player(me).xv = playerSpeed
                End If

                If player(me).x < 0 Then player(me).x = 0
                If player(me).y < 0 Then player(me).y = 0
                If player(me).x > _Width(mapImage) Then player(me).x = _Width(mapImage)
                If player(me).y > _Height(mapImage) Then player(me).y = _Height(mapImage)
            End If
            adjustCamera
        End If

        exitSign = _Exit
        If exitSign Then
            If mode = mode_onlineclient Or server.handle <> 0 Then sendData server, id_PLAYERQUIT, ""
            Exit Do
        End If

        If mode = mode_onlineclient Or server.handle <> 0 Then
            Dim k As Long
            k = _KeyHit

            If k = 27 Then
                If chatOpen Then
                    myMessage$ = ""
                    chatOpen = False
                End If
            End If

            Color _RGB32(255)

            Dim m$
            currentPing = timeElapsedSince(serverPing)
            If currentPing > timeout Then
                setError "Connection lost (timed out)", 4
                Close server.handle
                server.handle = 0
                Exit Do
            End If
            m$ = LTrim$(Str$(currentPing))
            m$ = Mid$(m$, InStr(m$, ".") + 1)
            m$ = Left$(String$(3 - Len(m$), "0") + m$, 3) + "ms"
            _PrintString (_Width - 150 - _PrintWidth(m$), 0), m$

            _Font 16
            m$ = LTrim$(Str$(totalClients)) + "/" + LTrim$(Str$(UBound(player)))
            _PrintString ((_Width - _PrintWidth(m$)) / 2, _Height - _FontHeight), m$
            _Font 8
        End If

        target = 0
        Dim testDist As Single, closest As Single
        closest = _Width
        For i = 1 To UBound(player)
            'proximity
            If i <> me And player(i).state = True Then
                testDist = dist(player(me).x, player(me).y, player(i).x, player(i).y)
                If testDist < 150 And testDist < closest Then
                    closest = testDist
                    target = i
                End If
            End If
        Next

        If target Then
            Dim targetAnimation As Single
            targetAnimation = targetAnimation - .1
            If targetAnimation < 0 Then targetAnimation = 5

            x = player(target).x + camera.x + Cos(shipFlotation) * shipFloatAmplitude
            y = player(target).y + camera.y + Sin(shipFlotation) * shipFloatAmplitude
            CircleFill x, y, player(target).size + 10 + targetAnimation, _RGB32(255, 0, 0, 100)
        End If

        For i = 1 To UBound(player)
            If player(i).state = False Or player(i).color = 0 Then _Continue

            rx = player(i).nextX - player(i).x
            ry = player(i).nextY - player(i).y
            rr = Sqr(rx ^ 2 + ry ^ 2)
            If rr > 5 Then
                rx = rx / rr
                ry = ry / rr
                player(i).x = player(i).x + rx * playerSpeed
                player(i).y = player(i).y + ry * playerSpeed
            Else
                rx = 0
                ry = 0
                player(i).x = player(i).nextX
                player(i).y = player(i).nextY
            End If

            x = player(i).x + camera.x + Cos(shipFlotation) * shipFloatAmplitude
            y = player(i).y + camera.y + Sin(shipFlotation) * shipFloatAmplitude
            CircleFill x, y + 6, player(i).size + 5, _RGB32(0, 50)
            CircleFill x, y, player(i).size + 5, _RGB32(0)
            CircleFill x, y, player(i).size, colors(player(i).color).value
            Color _RGB32(0)
            _PrintString (1 + x - _PrintWidth(player(i).name) / 2, 1 + y - 25), player(i).name
            Color _RGB32(255)
            _PrintString (x - _PrintWidth(player(i).name) / 2, y - 25), player(i).name
        Next

        If _KeyDown(keySPACE) And chatOpen = False Then
            Dim lastShot As Single
            If target > 0 Then
                If timeElapsedSince(lastShot) > .5 Then
                    lastShot = Timer
                    score = score + 100
                    sendData server, id_SHOOT, MKI$(target)
                    addParticles "explosion", player(target).x, player(target).y, 0, 0, 0, 5, 0, _RGB32(255), .3
                    addParticles "explosion", player(target).x, player(target).y, 0, 0, 0, 100, 0, colors(player(target).color).value, .3

                    radians = _Atan2(player(target).y - player(me).y, player(target).x - player(me).x)
                    For i = 1 To 20
                        addParticles "projectile", player(me).x + Cos(radians) * i, player(me).y + Sin(radians) * i, Cos(radians) * 5, Sin(radians) * 5, 2, 1, .5, colors(player(me).color).value, 0
                    Next
                End If
            End If
        End If

        updateParticles

        'LINE (_WIDTH / 2 - cameraWindow, _HEIGHT / 2 - cameraWindow)-STEP(cameraWindow * 2, cameraWindow * 2), , B

        'display warnings
        For i = 1 To UBound(warning)
            If warning(i).state = True Then
                Color _RGB32(0)
                _PrintString (11, 1 + _Height / 2 + _FontHeight * i), warning(i).name
                Color _RGB32(238, 50, 22)
                _PrintString (10, _Height / 2 + _FontHeight * i), warning(i).name
                If timeElapsedSince(warning(i).ping) > 2.5 Then warning(i).state = False
            End If
        Next

        'display UI
        If mode = mode_onlineclient Or server.handle <> 0 Then
            uiDisplay
            If hasUnreadMessages Then
                CircleFill _Width - 50, 10, 8, _RGB32(0)
                CircleFill _Width - 50, 10, 5, _RGB32(205, 6, 0)
            End If

            If chatOpen Then
                hasUnreadMessages = False
                Line (50, 50)-(_Width - 50, _Height - 50), _RGB32(0, 150), BF
                Line (50, 50)-(_Width - 50, _Height - 50), _RGB32(0), B

                _Dest chatLogImage
                _PrintMode _KeepBackground
                chatScroll = chatScroll - mouseWheel * 15
                If chatScroll < -(_FontHeight * 2 * UBound(chat)) + _Height(chatLogImage) Then
                    chatScroll = -(_FontHeight * 2 * UBound(chat)) + _Height(chatLogImage)
                End If
                If chatScroll > 0 Then chatScroll = 0
                Cls
                _ClearColor _RGB32(0)
                _Font 16
                Color _RGB32(0)
                For i = 1 To UBound(chat)
                    y = chatScroll + 15 + _FontHeight * ((i - 1) * 2)
                    If chat(i).state Then
                        If y > _Height(chatLogImage) Then Exit For
                        Line (5, y - 10)-(_Width - 5, y + 18), _RGB32(255, 100), BF
                        _Font 8
                        x = 10
                        If chat(i).id = me Then x = _Width - 10 - _PrintWidth(chat(i).name)
                        printOutline x, y - 8, chat(i).name, colors(chat(i).color).value, _RGB32(0)
                        _Font 16
                        x = 10
                        If chat(i).id = me Then x = _Width - 10 - _PrintWidth(chat(i).text)
                        printOutline x, y, Left$(chat(i).text, (_Width - 100) \ _FontWidth), _RGB32(255), _RGB32(0)
                    Else
                        If y > 0 And y < _Height(chatLogImage) Then
                            chatScroll = chatScroll - y
                            If chatScroll < -(_FontHeight * 2 * UBound(chat)) + _Height(chatLogImage) Then
                                chatScroll = -(_FontHeight * 2 * UBound(chat)) + _Height(chatLogImage)
                            End If
                        End If
                    End If
                Next
                _Dest 0
                _Font 16
                _PutImage (50, 50), chatLogImage

                'DIM SHARED mouseIsDown AS _BYTE, mouseDownX AS INTEGER, mouseDownY AS INTEGER
                'DIM SHARED mb1 AS _BYTE, mb2 AS _BYTE, mx AS INTEGER, my AS INTEGER
                If mouseIsDown Then
                    If mouseDownX > 50 And mouseDownX < 50 + _Width(chatLogImage) And mouseDownY > 50 And mouseDownY < 50 + _Height(chatLogImage) Then
                        'dragging the chat log
                        chatScroll = chatScroll - (mouseDownY - my)
                        mouseDownY = my
                    End If
                End If

                Const messageSpeed = 1.5
                char$ = InKey$
                Select Case char$
                    Case Chr$(22) 'ctrl+v
                        myMessage$ = myMessage$ + _Clipboard$
                    Case " " TO "z"
                        myMessage$ = myMessage$ + char$
                    Case Chr$(8)
                        If Len(myMessage$) Then
                            myMessage$ = Left$(myMessage$, Len(myMessage$) - 1)
                        End If
                    Case Chr$(13)
                        Dim lastSentChat As Single
                        If myMessage$ = ">reset" Then
                            player(me).size = 15
                            sendData server, id_SIZE, MKI$(player(me).size)
                            myMessage$ = ""
                            chatOpen = False
                        ElseIf myMessage$ = ">big" Then
                            player(me).size = 25
                            sendData server, id_SIZE, MKI$(player(me).size)
                            myMessage$ = ""
                            chatOpen = False
                        ElseIf myMessage$ = ">quit" Then
                            If mode = mode_onlineclient Or server.handle <> 0 Then sendData server, id_PLAYERQUIT, ""
                            Close server.handle
                            server.handle = 0
                            Exit Do
                        ElseIf myMessage$ = ">updateserver" Then
                            'temporary solution for triggering auto-update checks
                            sendData server, id_UPDATESERVER, ""
                            myMessage$ = ""
                            chatOpen = False
                        Else
                            If Len(myMessage$) > 0 Then 'AND timeElapsedSince(lastSentChat) > messageSpeed THEN
                                lastSentChat = Timer
                                addMessageToChat me, myMessage$
                                sendData server, id_CHAT, myMessage$
                                myMessage$ = ""
                                'ELSEIF LEN(myMessage$) > 0 AND timeElapsedSince(lastSentChat) < messageSpeed THEN
                                '    tooFast = True
                            End If
                        End If
                End Select

                Color _RGB32(0)
                _PrintString (61, _Height - 61 - _FontHeight * 1.5), "> " + myMessage$ + cursorBlink
                Color _RGB32(255)
                _PrintString (60, _Height - 60 - _FontHeight * 1.5), "> " + myMessage$ + cursorBlink
                _Font 8

                If tooFast Then
                    Dim s As Integer
                    s = _Ceil(messageSpeed - (timeElapsedSince(lastSentChat)))
                    m$ = "(too fast - wait" + Str$(s) + " second" + Left$("s", Abs(s > 1)) + ")"
                    y = _Height - 50 - _FontHeight
                    Color _RGB32(0)
                    _PrintString (61, 1 + y), m$
                    Color _RGB32(200, 177, 44)
                    _PrintString (60, y), m$
                    If timeElapsedSince(lastSentChat) > messageSpeed Then tooFast = False
                End If
            Else
                char$ = InKey$
                Select Case char$
                    Case Chr$(13)
                        chatOpen = True
                End Select
            End If
        End If

        If errorDialog.state Then
            _Font 16
            showError
            _Font 8
        End If

        uiCheck
        If uiClicked Then
            Select Case ui(mouseDownOn).name
                Case "messageicon"
                    If mode = mode_onlineclient Or server.handle <> 0 Then chatOpen = Not chatOpen
            End Select
            uiClicked = False
        End If

        If mode = mode_onlineclient Or server.handle <> 0 Then
            _Font 16
            printOutline 0, 0, "Score:" + Str$(score), _RGB32(255), _RGB32(0)
            _Font 8
        End If

        _Display
        _Limit 60
    Loop
    Close
Loop

Sub addMessageToChat (id As Integer, text$)
    Dim i As Integer
    If id > 0 Then
        For i = 2 To UBound(chat)
            Swap chat(i), chat(i - 1)
        Next
        chat(UBound(chat)).id = id
        chat(UBound(chat)).state = True
        chat(UBound(chat)).name = player(id).name
        chat(UBound(chat)).color = player(id).color
        chat(UBound(chat)).text = text$
    Else
        setError text$, 4
        'chat(UBOUND(chat)).name = "SYSTEM:"
        'chat(UBOUND(chat)).color = 7
        'chatOpen = True
    End If
End Sub

Sub addWarning (text$)
    Dim i As Integer
    For i = 1 To UBound(warning)
        If warning(i).state = False Then
            warning(i).state = True
            warning(i).name = text$
            warning(i).ping = Timer
            Exit For
        End If
    Next
End Sub

Sub sendData (client As object, id As Integer, value$)
    Dim packet$
    packet$ = MKI$(id) + value$ + endSignal
    If client.handle Then Put #client.handle, , packet$
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

Sub adjustCamera
    If player(me).x + camera.x > _Width / 2 + cameraWindow Then
        camera.x = _Width / 2 - player(me).x + cameraWindow
    ElseIf player(me).x + camera.x < _Width / 2 - cameraWindow Then
        camera.x = _Width / 2 - player(me).x - cameraWindow
    End If
    If camera.x > 0 Then camera.x = 0
    If camera.x < -(_Width(mapImage) - _Width) Then camera.x = -(_Width(mapImage) - _Width)

    If player(me).y + camera.y > _Height / 2 + cameraWindow Then
        camera.y = _Height / 2 - player(me).y + cameraWindow
    ElseIf player(me).y + camera.y < _Height / 2 - cameraWindow Then
        camera.y = _Height / 2 - player(me).y - cameraWindow
    End If
    If camera.y > 0 Then camera.y = 0
    If camera.y < -(_Height(mapImage) - _Height) Then camera.y = -(_Height(mapImage) - _Height)
End Sub


Sub CircleFill (CX As Integer, CY As Integer, R As Integer, C As _Unsigned Long)
    ' CX = center x coordinate
    ' CY = center y coordinate
    '  R = radius
    '  C = fill color
    Dim Radius As Integer, RadiusError As Integer
    Dim X As Integer, Y As Integer
    Radius = Abs(R)
    RadiusError = -Radius
    X = Radius
    Y = 0
    If Radius = 0 Then PSet (CX, CY), C: Exit Sub
    Line (CX - X, CY)-(CX + X, CY), C, BF
    While X > Y
        RadiusError = RadiusError + Y * 2 + 1
        If RadiusError >= 0 Then
            If X <> Y + 1 Then
                Line (CX - Y, CY - X)-(CX + Y, CY - X), C, BF
                Line (CX - Y, CY + X)-(CX + Y, CY + X), C, BF
            End If
            X = X - 1
            RadiusError = RadiusError - X * 2
        End If
        Y = Y + 1
        Line (CX - X, CY - Y)-(CX + X, CY - Y), C, BF
        Line (CX - X, CY + Y)-(CX + X, CY + Y), C, BF
    Wend
End Sub

Sub db (text$)
    $If DEBUGGING = TRUE Then
        _ECHO text$
    $Else
        Dim dummy$
        dummy$ = text$
    $End If
End Sub

Function dist! (x1!, y1!, x2!, y2!)
    dist! = _Hypot((x2! - x1!), (y2! - y1!))
End Function

Sub thickLine (x1 As Single, y1 As Single, x2 As Single, y2 As Single, lineWeight%, c~&)
    Dim a As Single, x0 As Single, y0 As Single
    Dim prevDest As Long
    Dim colorSample As Long

    colorSample = _NewImage(1, 1, 32)

    prevDest = _Dest
    _Dest colorSample
    PSet (0, 0), c~&
    _Dest prevDest

    a = _Atan2(y2 - y1, x2 - x1)
    a = a + _Pi / 2
    x0 = 0.5 * lineWeight% * Cos(a)
    y0 = 0.5 * lineWeight% * Sin(a)

    _MapTriangle _Seamless(0, 0)-(0, 0)-(0, 0), colorSample To(x1 - x0, y1 - y0)-(x1 + x0, y1 + y0)-(x2 + x0, y2 + y0), , _Smooth
    _MapTriangle _Seamless(0, 0)-(0, 0)-(0, 0), colorSample To(x1 - x0, y1 - y0)-(x2 + x0, y2 + y0)-(x2 - x0, y2 - y0), , _Smooth

    _FreeImage colorSample
End Sub

Sub addParticles (kind$, x As Single, y As Single, xv As Single, yv As Single, size As Integer, total As Integer, duration As Single, c As _Unsigned Long, delay As Single)
    Dim addedP As Integer, p As Integer
    Dim a As Single

    addedP = 0: p = 0
    Do
        p = p + 1
        If p > UBound(particle) Then Exit Do
        If particle(p).state = True Then _Continue
        addedP = addedP + 1
        particle(p).state = True
        particle(p).x = x
        particle(p).y = y
        particle(p).r = _Red32(c)
        particle(p).g = _Green32(c)
        particle(p).b = _Blue32(c)
        particle(p).start = Timer
        If duration Then
            particle(p).duration = duration
        Else
            particle(p).duration = Rnd
        End If
        particle(p).delay = delay

        Select Case kind$
            Case "explosion"
                a = Rnd * _Pi(2)
                particle(p).xv = Cos(a) * (Rnd * 10)
                particle(p).yv = Sin(a) * (Rnd * 10)
                particle(p).size = _Ceil(Rnd * 3)
                particle(p).gravity = .1
            Case "projectile"
                particle(p).xv = xv
                particle(p).yv = yv
                particle(p).size = size
                particle(p).gravity = 0
        End Select
    Loop Until addedP >= total
End Sub

Sub updateParticles
    Dim i As Integer

    For i = 1 To UBound(particle)
        If particle(i).state And (timeElapsedSince(particle(i).start) >= particle(i).delay) Then
            particle(i).xv = particle(i).xv + particle(i).xa
            particle(i).x = particle(i).x + particle(i).xv
            particle(i).yv = particle(i).yv + particle(i).ya + particle(i).gravity
            particle(i).y = particle(i).y + particle(i).yv

            If particle(i).x > _Width(mapImage) Or particle(i).x < 0 Or particle(i).y > _Height(mapImage) Or particle(i).y < 0 Then
                particle(i).state = False
            Else
                CircleFill particle(i).x + camera.x, particle(i).y + camera.y, particle(i).size, _RGB32(particle(i).r, particle(i).g, particle(i).b, map(timeElapsedSince(particle(i).start), 0, particle(i).duration, 255, 0))
            End If
        End If
    Next
End Sub

Function map! (value!, minRange!, maxRange!, newMinRange!, newMaxRange!)
    map! = ((value! - minRange!) / (maxRange! - minRange!)) * (newMaxRange! - newMinRange!) + newMinRange!
End Function


Sub generateImages
    Dim i As Long, j As Long
    Dim x As Integer, y As Integer
    Dim r As Integer, c As _Unsigned Long
    Dim red As Integer, green As Integer, blue As Integer, alpha As Integer

    mapImage = _NewImage(windowWidth * 4, windowHeight * 3, 32)
    _Dest mapImage
    Randomize 6
    For i = 1 To 15
        x = Rnd * _Width
        y = Rnd * _Height
        r = Rnd * 1000
        red = Rnd * 255
        green = Rnd * 255
        blue = Rnd * 255
        alpha = Rnd * 150
        c = _RGB32(red, green, blue, alpha)
        CircleFill x, y, r, c
    Next
    _Dest 0

    settingsScreenImage = _NewImage(windowWidth, windowHeight, 32)
    _Dest settingsScreenImage
    For i = 1 To 10
        x = Rnd * _Width
        y = Rnd * _Height
        r = Rnd * _Width
        alpha = Rnd * 150
        c = _RGB32(50, alpha)
        CircleFill x, y, r, c
    Next
    _Dest 0

    worldMapImage = _NewImage(800, 351, 32)
    _Dest worldMapImage
    Restore worldMapData
    Read j
    For i = 1 To j
        Read x, y
        CircleFill x, y, 1, _RGB32(0, 177, 0)
    Next
    For i = 0 To _Height Step 3
        Line (3, i)-(_Width - 4, i), _RGB32(0, 139, 0, 100)
    Next
    _Dest 0

    scanLinesImage = _NewImage(500, 60, 32)
    _Dest scanLinesImage
    For i = 0 To _Height / 2
        Line (3, i)-(_Width - 4, i), _RGB32(0, 139, 0, map(i, 0, _Height / 2, 0, 127))
    Next
    For i = _Height / 2 + 1 To _Height
        Line (3, i)-(_Width - 4, i), _RGB32(0, 139, 0, map(i, _Height / 2 + 1, _Height, 127, 0))
    Next
    _Dest 0

    dialogImage = _NewImage(500, 100, 32)
    _Dest dialogImage
    Line (0, 0)-(_Width - 1, _Height - 1), _RGB32(0, 180), BF
    Line (0, 0)-(_Width - 1, _Height - 1), _RGB32(0, 139, 0), B
    Line (2, 2)-(_Width - 3, _Height - 3), _RGB32(0, 139, 0), B
    For i = 4 To _Height - 5 Step 3
        Line (3, i)-(_Width - 4, i), _RGB32(0, 139, 0, 60)
    Next
    _Dest 0

    messageIcon = _NewImage(32, 32, 32)
    _Dest messageIcon
    Line (0, 0)-(31, 31), _RGB32(0), BF
    Line (4, 4)-(27, 27), _RGB32(200), BF
    For i = 8 To 23 Step 5
        Line (5, i)-(25, i), _RGB32(0)
    Next
    _Dest 0

    worldMapData:
    Data 1075
    Data 251,6,276,6,279,6,287,6,302,6,336,6,212,12,213,12,215,12,216,12,220,12,221,12
    Data 223,12,224,12,227,12,239,12,240,12,263,12,271,12,339,12,397,12,398,12,430,12,438,12
    Data 441,12,457,12,458,12,461,12,479,12,481,12,500,12,507,12,181,18,191,18,205,18,207,18
    Data 208,18,215,18,220,18,221,18,222,18,226,18,232,18,236,18,239,18,244,18,259,18,335,18
    Data 386,18,395,18,398,18,404,18,511,18,512,18,519,18,529,18,531,18,538,18,165,24,179,24
    Data 192,24,194,24,203,24,208,24,211,24,218,24,222,24,227,24,230,24,235,24,236,24,239,24
    Data 275,24,328,24,454,24,461,24,495,24,538,24,541,24,547,24,553,24,555,24,592,24,595,24
    Data 96,30,97,30,99,30,112,30,113,30,114,30,168,30,192,30,203,30,210,30,217,30,246,30
    Data 274,30,277,30,278,30,322,30,324,30,328,30,403,30,408,30,409,30,414,30,453,30,460,30
    Data 475,30,486,30,487,30,623,30,626,30,630,30,662,30,668,30,79,36,166,36,171,36,175,36
    Data 179,36,188,36,191,36,195,36,196,36,197,36,199,36,212,36,215,36,223,36,232,36,236,36
    Data 238,36,250,36,272,36,307,36,390,36,433,36,439,36,444,36,448,36,489,36,492,36,679,36
    Data 67,42,207,42,208,42,210,42,211,42,215,42,224,42,245,42,250,42,251,42,272,42,291,42
    Data 323,42,339,42,385,42,402,42,407,42,425,42,426,42,428,42,429,42,431,42,435,42,683,42
    Data 687,42,688,42,689,42,697,42,61,48,149,48,151,48,195,48,209,48,214,48,222,48,223,48
    Data 224,48,225,48,236,48,242,48,272,48,286,48,351,48,354,48,375,48,395,48,401,48,689,48
    Data 59,54,76,54,77,54,81,54,99,54,185,54,217,54,233,54,240,54,242,54,373,54,401,54
    Data 413,54,414,54,415,54,651,54,664,54,671,54,57,60,62,60,66,60,71,60,102,60,186,60
    Data 215,60,243,60,349,60,357,60,380,60,382,60,385,60,393,60,395,60,397,60,403,60,407,60
    Data 408,60,629,60,662,60,674,60,30,66,35,66,36,66,37,66,106,66,201,66,207,66,248,66
    Data 345,66,353,66,354,66,359,66,378,66,382,66,387,66,388,66,396,66,397,66,401,66,627,66
    Data 665,66,678,66,682,66,684,66,685,66,687,66,105,72,163,72,164,72,198,72,204,72,250,72
    Data 341,72,349,72,352,72,365,72,370,72,642,72,644,72,646,72,672,72,677,72,712,72,714,72
    Data 102,78,107,78,108,78,224,78,230,78,233,78,244,78,248,78,356,78,358,78,363,78,647,78
    Data 649,78,654,78,674,78,676,78,103,84,172,84,176,84,179,84,185,84,226,84,227,84,228,84
    Data 233,84,235,84,243,84,245,84,246,84,252,84,354,84,647,84,652,84,656,84,675,84,676,84
    Data 100,90,176,90,180,90,186,90,189,90,190,90,192,90,219,90,221,90,231,90,246,90,247,90
    Data 357,90,385,90,388,90,422,90,430,90,435,90,438,90,459,90,467,90,484,90,487,90,647,90
    Data 656,90,659,90,670,90,674,90,95,96,173,96,174,96,175,96,176,96,187,96,190,96,209,96
    Data 340,96,366,96,378,96,380,96,383,96,390,96,399,96,420,96,448,96,462,96,470,96,639,96
    Data 657,96,665,96,90,102,91,102,92,102,201,102,289,102,290,102,292,102,295,102,340,102
    Data 360,102,367,102,369,102,377,102,381,102,392,102,400,102,401,102,408,102,409,102,411,102
    Data 414,102,415,102,416,102,467,102,473,102,619,102,622,102,638,102,660,102,665,102,93,108
    Data 195,108,340,108,358,108,387,108,393,108,404,108,409,108,410,108,415,108,417,108,466,108
    Data 477,108,617,108,631,108,641,108,662,108,666,108,93,114,191,114,317,114,318,114,346,114
    Data 349,114,357,114,384,114,390,114,391,114,410,114,412,114,431,114,435,114,437,114,622,114
    Data 637,114,644,114,652,114,667,114,98,120,182,120,214,120,216,120,339,120,387,120,437,120
    Data 626,120,640,120,641,120,646,120,658,120,98,126,101,126,105,126,176,126,336,126,399,126
    Data 403,126,631,126,672,126,673,126,101,132,104,132,107,132,141,132,172,132,177,132,312,132
    Data 314,132,316,132,318,132,320,132,321,132,323,132,325,132,332,132,433,132,434,132,468,132
    Data 474,132,632,132,673,132,674,132,103,138,106,138,110,138,137,138,173,138,176,138,181,138
    Data 182,138,326,138,437,138,441,138,471,138,472,138,474,138,482,138,484,138,485,138,487,138
    Data 488,138,630,138,5,144,6,144,105,144,108,144,114,144,135,144,186,144,187,144,322,144
    Data 440,144,445,144,491,144,513,144,627,144,632,144,636,144,11,150,14,150,116,150,136,150
    Data 152,150,159,150,167,150,169,150,176,150,184,150,193,150,197,150,319,150,443,150,448,150
    Data 494,150,517,150,558,150,562,150,564,150,567,150,568,150,569,150,604,150,608,150,613,150
    Data 91,156,92,156,118,156,138,156,147,156,156,156,160,156,161,156,177,156,178,156,182,156
    Data 183,156,186,156,188,156,190,156,200,156,208,156,209,156,321,156,445,156,449,156,450,156
    Data 452,156,490,156,525,156,554,156,572,156,602,156,608,156,612,156,614,156,615,156,99,162
    Data 100,162,128,162,154,162,155,162,157,162,162,162,163,162,167,162,168,162,216,162,218,162
    Data 219,162,220,162,306,162,307,162,320,162,448,162,453,162,454,162,457,162,481,162,527,162
    Data 548,162,577,162,607,162,635,162,641,162,145,168,164,168,193,168,194,168,217,168,218,168
    Data 319,168,454,168,457,168,472,168,481,168,482,168,530,168,544,168,584,168,611,168,637,168
    Data 641,168,690,168,693,168,156,174,159,174,160,174,164,174,188,174,192,174,194,174,196,174
    Data 198,174,199,174,213,174,214,174,215,174,216,174,270,174,271,174,320,174,458,174,461,174
    Data 462,174,475,174,477,174,481,174,482,174,532,174,543,174,575,174,577,174,584,174,585,174
    Data 587,174,590,174,593,174,594,174,596,174,612,174,636,174,637,174,642,174,643,174,644,174
    Data 646,174,647,174,650,174,161,180,166,180,168,180,169,180,173,180,174,180,181,180,190,180
    Data 192,180,214,180,220,180,221,180,222,180,223,180,326,180,476,180,535,180,542,180,544,180
    Data 546,180,584,180,585,180,586,180,589,180,602,180,606,180,633,180,635,180,643,180,651,180
    Data 707,180,708,180,109,186,110,186,176,186,221,186,329,186,473,186,475,186,476,186,523,186
    Data 524,186,541,186,542,186,544,186,549,186,579,186,581,186,590,186,593,186,629,186,630,186
    Data 642,186,644,186,646,186,653,186,670,186,672,186,724,186,727,186,758,186,760,186,177,192
    Data 236,192,337,192,344,192,370,192,470,192,523,192,525,192,580,192,586,192,592,192,599,192
    Data 624,192,636,192,174,198,239,198,380,198,466,198,522,198,525,198,581,198,583,198,586,198
    Data 593,198,594,198,601,198,613,198,614,198,618,198,633,198,656,198,659,198,9,204,10,204
    Data 15,204,16,204,147,204,148,204,170,204,243,204,247,204,248,204,376,204,377,204,379,204
    Data 433,204,437,204,459,204,461,204,462,204,522,204,524,204,589,204,599,204,612,204,633,204
    Data 637,204,640,204,645,204,648,204,655,204,658,204,663,204,665,204,62,210,63,210,169,210
    Data 254,210,255,210,256,210,301,210,302,210,380,210,454,210,591,210,592,210,594,210,603,210
    Data 604,210,606,210,615,210,630,210,631,210,632,210,636,210,643,210,652,210,653,210,666,210
    Data 672,210,675,210,685,210,699,210,701,210,168,216,270,216,274,216,275,216,276,216,277,216
    Data 385,216,425,216,426,216,450,216,598,216,606,216,612,216,613,216,621,216,622,216,636,216
    Data 639,216,641,216,645,216,675,216,698,216,712,216,715,216,172,222,277,222,279,222,280,222
    Data 387,222,427,222,428,222,449,222,603,222,613,222,614,222,621,222,633,222,634,222,681,222
    Data 703,222,708,222,709,222,717,222,720,222,721,222,723,222,174,228,275,228,388,228,450,228
    Data 482,228,483,228,624,228,625,228,637,228,638,228,646,228,651,228,653,228,654,228,688,228
    Data 691,228,699,228,705,228,729,228,731,228,734,228,735,228,774,228,775,228,177,234,271,234
    Data 389,234,437,234,438,234,452,234,661,234,668,234,688,234,690,234,713,234,716,234,728,234
    Data 729,234,181,240,268,240,386,240,453,240,461,240,463,240,469,240,474,240,642,240,643,240
    Data 650,240,653,240,655,240,656,240,658,240,672,240,684,240,685,240,686,240,693,240,791,240
    Data 795,240,189,246,268,246,344,246,346,246,385,246,450,246,460,246,473,246,474,246,475,246
    Data 501,246,502,246,641,246,642,246,644,246,676,246,677,246,678,246,684,246,695,246,744,246
    Data 747,246,788,246,789,246,196,252,267,252,386,252,442,252,459,252,471,252,635,252,636,252
    Data 638,252,695,252,733,252,734,252,746,252,747,252,193,258,194,258,197,258,265,258,390,258
    Data 438,258,458,258,469,258,485,258,487,258,625,258,700,258,735,258,738,258,739,258,740,258
    Data 741,258,743,258,197,264,256,264,391,264,440,264,457,264,468,264,617,264,703,264,198,270
    Data 248,270,392,270,433,270,467,270,468,270,617,270,706,270,197,276,248,276,249,276,250,276
    Data 394,276,433,276,458,276,459,276,462,276,463,276,616,276,705,276,198,282,247,282,397,282
    Data 427,282,617,282,702,282,199,288,242,288,399,288,421,288,616,288,638,288,656,288,698,288
    Data 737,288,738,288,199,294,233,294,658,294,659,294,660,294,692,294,740,294,743,294,746,294
    Data 747,294,199,300,235,300,665,300,687,300,738,300,739,300,740,300,744,300,200,306,226,306
    Data 480,306,481,306,669,306,670,306,735,306,742,306,205,312,223,312,669,312,676,312,724,312
    Data 731,312,96,318,97,318,206,318,221,318,389,318,390,318,711,318,721,318,207,324,223,324
    Data 536,324,538,324,707,324,709,324,209,330,223,330,215,336,223,336,238,336,242,336,222,342
End Sub

Sub restoreColors
    Dim i As Integer

    playerColorPalette:
    Data 195,17,16,Red
    Data 14,51,196,Blue
    Data 18,125,46,Green
    Data 236,84,187,Pink
    Data 239,125,17,Orange
    Data 248,245,91,Yellow
    Data 62,71,77,Black
    Data 216,225,241,White
    Data 107,48,187,Purple
    Data 112,73,28,Brown
    Data 93,250,220,Cyan
    Data 79,240,58,Lime

    Restore playerColorPalette
    For i = 1 To UBound(colors)
        Read r%, g%, b%, colors(i).name
        colors(i).value = _RGB32(r%, g%, b%)
    Next
End Sub

Sub readServerList
    Restore serverList
    Dim i As Integer
    Read i
    ReDim serverList(1 To i) As object
    For i = 1 To i
        Read serverList(i).text, serverList(i).name, serverList(i).x, serverList(i).y
    Next

    serverList:
    Data 3
    Data spriggsyspriggs.ddns.net,North America,145,105
    Data alephc.xyz,Australia,662,270
    Data 187.94.219.178,Brazil,240,233
End Sub

Sub intro

End Sub

Sub settingsScreen
    Dim i As Long
    Dim x As Integer, y As Integer
    Dim item As Long, itemX As Integer, itemY As Integer
    Dim text As String
    Dim dummyPlayer As object
    Dim attemptingToConnect As _Byte, handshaking As _Byte
    Dim id As Integer, value$
    Dim attempt As Integer

    GoSub setUi
    Const maxAttempts = 5
    Const mapX = 0, mapY = 240

    Do
        If attemptingToConnect = False And handshaking = False And errorDialog.state = False Then
            uiCheck
        End If

        Dim shipFlotation As Single, shipFloatAmplitude As Single
        shipFlotation = shipFlotation + .05
        If shipFlotation > _Pi(2) Then shipFlotation = shipFlotation - _Pi(2)
        shipFloatAmplitude = 1.5

        _DontBlend
        _PutImage (Cos(shipFlotation) * shipFloatAmplitude, Sin(shipFlotation) * shipFloatAmplitude), settingsScreenImage
        _Blend

        x = dummyPlayer.x + Cos(shipFlotation) * shipFloatAmplitude
        y = dummyPlayer.y + Sin(shipFlotation) * shipFloatAmplitude
        CircleFill x, y + 6, dummyPlayer.size + 5, _RGB32(0, 50)
        CircleFill x, y, dummyPlayer.size + 5, _RGB32(0)
        CircleFill x, y, dummyPlayer.size, colors(dummyPlayer.color).value
        text = dummyPlayer.name

        _Font 8
        Color _RGB32(0)
        _PrintString (1 + x - _PrintWidth(text) / 2, 1 + y - 25), text + cursorBlink
        Color _RGB32(255)
        _PrintString (x - _PrintWidth(text) / 2, y - 25), text + cursorBlink
        _Font 16

        For i = 1 To UBound(colors)
            If dummyPlayer.color = i Then
                ui(i + 1).text = "*"
            Else
                ui(i + 1).text = ""
            End If
        Next

        Dim targetAnimation As Single
        targetAnimation = targetAnimation + .25
        If targetAnimation > 25 Then targetAnimation = 0

        For i = 1 To UBound(serverList)
            x = serverList(i).x + mapX
            y = serverList(i).y + mapY
            CircleFill x, y, 5 + targetAnimation, _RGB32(255, 0, 0, map(targetAnimation, 0, 25, 255, 0))
        Next

        uiDisplay

        _PutImage (mapX, mapY), worldMapImage

        Color _RGB32(255)

        If uiClicked Then
            Select Case Left$(ui(mouseDownOn).name, InStr(ui(mouseDownOn).name, ".") - 1)
                Case "color"
                    dummyPlayer.color = CVI(Right$(ui(mouseDownOn).name, 2))
                Case "freeplay"
                    mode = mode_freeplay
                    userName$ = dummyPlayer.name
                    If userName$ = "" Then userName$ = "Player"
                    userColor% = dummyPlayer.color
                    chosenServer$ = "localhost"
                    attempt = 0
                    attemptingToConnect = True
                Case "server"
                    mode = mode_onlineclient
                    userName$ = dummyPlayer.name
                    If userName$ = "" Then userName$ = "Player"
                    userColor% = dummyPlayer.color
                    chosenServer$ = serverList(CVI(Right$(ui(mouseDownOn).name, 2))).text
                    attempt = 0
                    attemptingToConnect = True
            End Select
            uiClicked = False
        End If

        If attemptingToConnect Then
            attempt = attempt + 1
            dialog "Attempting to connect to server..."
            If attempt = 1 Then _Display

            server.handle = 0
            server.handle = _OpenClient("TCP/IP:51512:" + chosenServer$)

            If server.handle Then
                serverStream = ""
                attemptingToConnect = False
                handshaking = True
                serverPing = Timer
            Else
                If attempt >= maxAttempts Then
                    attemptingToConnect = False
                    If mode = mode_freeplay Then
                        setError "Failed to connect to server. You're in free play mode.", 3
                        Exit Sub
                    Else
                        setError "Failed to connect to server. Try again later (or chose another).", 2
                        mode = 0
                    End If
                End If
            End If
        ElseIf handshaking Then
            progressDialog "Connected! Handshaking...", timeElapsedSince(serverPing), 10
            getData server, serverStream
            While parse(serverStream, id, value$)
                Select Case id
                    Case id_SERVERFULL
                        setError "Server full.", 2
                        handshaking = False
                        Close server.handle
                        server.handle = 0
                    Case id_GAMEVERSION
                        If CVI(value$) <> gameVersion Then
                            setError "Server version incompatible.", 2
                            sendData server, id_GAMEVERSION, ""
                            sendData server, id_PLAYERQUIT, ""
                            Close server.handle
                            server.handle = 0
                            handshaking = False
                        Else
                            Exit Sub
                        End If
                End Select
            Wend
            If timeElapsedSince(serverPing) > 10 Then
                If mode = mode_freeplay Then
                    setError "No response from server. You're in free play mode.", 3
                    Exit Sub
                Else
                    setError "No response from server.", 2
                    mode = 0
                End If
                handshaking = False
            End If
        ElseIf errorDialog.state Then
            showError
        Else
            'only get input if no dialog is being presented
            Dim char$
            char$ = InKey$
            Select Case char$
                Case " " TO "z"
                    If Len(dummyPlayer.name) < 20 Then dummyPlayer.name = dummyPlayer.name + char$
                Case Chr$(8)
                    If Len(dummyPlayer.name) Then
                        dummyPlayer.name = Left$(dummyPlayer.name, Len(dummyPlayer.name) - 1)
                    End If
                Case Chr$(27)
                    dummyPlayer.name = ""
            End Select
        End If

        exitSign = _Exit
        If exitSign Then
            System
        End If

        _Display
        _Limit 60
    Loop

    Exit Sub

    setUi:
    uiReset

    'color picker
    Const colorPickerSquareSize = 35
    itemX = 200
    itemY = 50

    item = addUiItem("colorpickerframe", itemX - 4, itemY - 4, colorPickerSquareSize * 3 + 8, colorPickerSquareSize * 4 + 8)
    ui(item).color = _RGB32(50)

    y = 1
    x = 0
    For i = 1 To UBound(colors)
        x = x + 1
        If x = 4 Then y = y + 1: x = 1
        item = addUiItem("color." + LCase$(colors(i).name) + "." + MKI$(i), itemX + (colorPickerSquareSize * (x - 1)), itemY + (colorPickerSquareSize * (y - 1)), colorPickerSquareSize - 2, colorPickerSquareSize - 2)
        ui(item).color = colors(i).value
        ui(item).fgColor = _RGB32(255)
        ui(item).state = True
    Next

    'server locations
    Const mapLocationsPickerSize = 16
    For i = 1 To UBound(serverList)
        itemX = mapX + serverList(i).x - mapLocationsPickerSize / 2
        itemY = mapY + serverList(i).y - mapLocationsPickerSize / 2
        item = addUiItem("server." + LCase$(serverList(i).name) + "." + MKI$(i), itemX, itemY, mapLocationsPickerSize, mapLocationsPickerSize)
        ui(item).color = _RGB32(105, 200, 50)
        ui(item).state = True
    Next

    'interface
    itemY = _FontHeight
    item = addUiItem("titleseparator", 0, itemY, _Width, 2)
    ui(item).color = _RGB32(200)
    ui(item).fgColor = _RGB32(0)

    item = addUiItem("titlelabel", 0, 0, 0, 0)
    ui(item).text = "AMONGST... WHO IS THE IMPOSTOR?"
    ui(item).w = _PrintWidth(ui(item).text) + 30
    ui(item).h = _FontHeight * 2
    ui(item).x = (_Width - ui(item).w) / 2
    ui(item).y = itemY - _FontHeight
    ui(item).color = _RGB32(200)
    ui(item).fgColor = _RGB32(0)

    itemX = 500
    itemY = 100
    text$ = "Free Play - local host"
    item = addUiItem("freeplay.", itemX, itemY, _PrintWidth(text$) + 30, _FontHeight * 2)
    ui(item).text = text$
    ui(item).color = _RGB32(200)
    ui(item).fgColor = _RGB32(0)
    ui(item).state = True

    itemY = 220 - _FontHeight
    item = addUiItem("mapseparator", 0, itemY + _FontHeight, _Width, 2)
    ui(item).color = _RGB32(200)
    ui(item).fgColor = _RGB32(0)

    item = addUiItem("serverlabel", 0, 0, 0, 0)
    ui(item).text = "Play online - Choose a server"
    ui(item).w = _PrintWidth(ui(item).text) + 30
    ui(item).h = _FontHeight * 2
    ui(item).x = (_Width - ui(item).w) / 2
    ui(item).y = itemY
    ui(item).color = _RGB32(200)
    ui(item).fgColor = _RGB32(0)

    dummyPlayer.x = 100
    dummyPlayer.y = 120
    dummyPlayer.size = 15
    If userColor% > 0 Then dummyPlayer.color = userColor% Else dummyPlayer.color = 1
    If Len(Command$) = 0 Then dummyPlayer.name = "Player 1" Else dummyPlayer.name = Command$
    If Len(userName$) > 0 Then dummyPlayer.name = userName$
    Return
End Sub

Sub uiCheck
    Dim i As Integer

    mouseWheel = 0
    If _MouseInput Then
        mouseWheel = mouseWheel + _MouseWheel
        If _MouseButton(1) = mb1 And _MouseButton(2) = mb2 Then
            Do While _MouseInput
                mouseWheel = mouseWheel + _MouseWheel
                If Not (_MouseButton(1) = mb1 And _MouseButton(2) = mb2) Then Exit Do
            Loop
        End If
        mb1 = _MouseButton(1)
        mb2 = _MouseButton(2)
        mx = _MouseX
        my = _MouseY
    End If

    focus = 0
    For i = UBound(ui) To 1 Step -1
        If ui(i).state And mx > ui(i).x And mx < ui(i).x + ui(i).w And my > ui(i).y And my < ui(i).y + ui(i).h Then
            focus = i
            Exit For
        End If
    Next

    If mb1 Then
        uiClicked = False
        If Not mouseIsDown Then
            mouseDownOn = focus
            mouseIsDown = True
            mouseDownX = mx
            mouseDownY = my
        End If
    Else
        If mouseIsDown Then
            If mouseDownOn Then
                uiClicked = True
            End If
        End If
        mouseIsDown = False
    End If

End Sub

Sub uiDisplay
    Dim i As Integer, x As Integer, y As Integer
    Dim tempColor As _Unsigned Long

    Const hoverIntensity = 30

    For i = 1 To UBound(ui)
        If i = focus Then _Continue 'draw focused clickable control last
        GoSub drawIt
    Next

    If focus Then
        If ui(focus).state Then
            i = focus
            GoSub drawIt
        End If
    End If
    Exit Sub

    drawIt:
    'shadow
    If ui(i).state Then
        x = ui(i).x + 4
        y = ui(i).y + 4
        Line (x, y)-Step(ui(i).w - 1 + (Abs(i = focus) * 4), ui(i).h - 1 + (Abs(i = focus) * 4)), _RGB32(0, 50), BF
    End If

    'surface
    If i = focus And ui(i).state Then
        tempColor = _RGB32(_Red32(ui(i).color) + hoverIntensity, _Green32(ui(i).color) + hoverIntensity, _Blue32(ui(i).color) + hoverIntensity)
        Line (ui(i).x - 2, ui(i).y - 2)-Step(ui(i).w - 1 + 4, ui(i).h - 1 + 4), tempColor, BF
    Else
        Line (ui(i).x, ui(i).y)-Step(ui(i).w - 1, ui(i).h - 1), ui(i).color, BF
    End If

    'custom image
    If ui(i).handle < -1 Then
        _PutImage (ui(i).x, ui(i).y), ui(i).handle
    End If

    'caption
    If Len(ui(i).text) Then
        x = ui(i).x + ((ui(i).w - _PrintWidth(ui(i).text)) / 2)
        y = ui(i).y + ((ui(i).h - _FontHeight) / 2)
        If i = focus And ui(i).state Then
            Color _RGB32(0, 50)
            _PrintString (x + 2, y + 2), ui(i).text
        End If
        Color ui(i).fgColor
        _PrintString (x, y), ui(i).text
    End If
    Return
End Sub

Sub uiReset
    ReDim ui(0) As object
    uiClicked = False
    mouseDownOn = 0
    focus = 0
End Sub

Function addUiItem& (name$, x As Integer, y As Integer, w As Integer, h As Integer)
    Dim i As Long
    i = UBound(ui) + 1
    ReDim _Preserve ui(1 To i) As object
    ui(i).name = name$
    ui(i).handle = 0
    ui(i).x = x
    ui(i).y = y
    ui(i).w = w
    ui(i).h = h
    ui(i).state = False
    addUiItem = i
End Function

Sub progressDialog (text$, value As Long, max As Long)
    Static prevText$

    If text$ <> prevText$ Then
        prevText$ = text$
    End If

    Dim x As Integer, y As Integer
    Dim percentage$

    drawDialogBox

    x = (_Width - _PrintWidth(text$)) / 2
    y = (_Height - _FontHeight) / 2 - _FontHeight / 2
    _PrintString (x, y), text$

    percentage$ = "[" + String$(map(value, 0, max, 0, 20), 254) + String$(map(value, 0, max, 20, 0), 250) + "] "
    x = (_Width - _PrintWidth(percentage$)) / 2
    y = (_Height - _FontHeight) / 2 + _FontHeight / 2
    _PrintString (x, y), percentage$
End Sub

Sub drawDialogBox
    Static scanY As Single

    Const scanLinesSpeed = .5

    _PutImage ((_Width - _Width(dialogImage)) / 2, (_Height - _Height(dialogImage)) / 2), dialogImage

    scanY = scanY + scanLinesSpeed
    If scanY > _Height(dialogImage) Then scanY = -_Height(scanLinesImage)
    If scanY < 0 Then
        _PutImage ((_Width - _Width(dialogImage)) / 2, (_Height - _Height(dialogImage)) / 2), scanLinesImage, , (0, Abs(scanY))-Step(_Width(scanLinesImage) - 1, _Height(scanLinesImage) - 1)
    ElseIf scanY > _Height(dialogImage) - _Height(scanLinesImage) Then
        _PutImage ((_Width - _Width(dialogImage)) / 2, scanY + (_Height - _Height(dialogImage)) / 2), scanLinesImage, , (0, 0)-Step(_Width(scanLinesImage) - 1, _Height(dialogImage) - scanY)
    Else
        _PutImage ((_Width - _Width(dialogImage)) / 2, scanY + (_Height - _Height(dialogImage)) / 2), scanLinesImage
    End If
End Sub

Sub dialog (__text$)
    Const maxLines = 4

    Static prevText$
    Static lines$(1 To maxLines), totalLines As Integer
    Dim text$, i As Integer
    Dim x As Integer, y As Integer

    text$ = StrReplace$(__text$, "\n", Chr$(10))
    If text$ <> prevText$ Then
        prevText$ = text$
        totalLines = 0
        x = InStr(text$, Chr$(10))
        If x Then
            While x
                totalLines = totalLines + 1
                If totalLines > maxLines Then totalLines = maxLines: Exit While
                lines$(totalLines) = Left$(text$, x - 1)
                text$ = Mid$(text$, x + 1)
                x = InStr(text$, Chr$(10))
            Wend
            If x = 0 And Len(text$) > 0 And totalLines < maxLines Then
                totalLines = totalLines + 1
                lines$(totalLines) = text$
            End If
        Else
            totalLines = 1
            lines$(1) = text$
        End If
    End If

    drawDialogBox

    For i = 1 To totalLines
        x = (_Width - _PrintWidth(lines$(i))) / 2
        y = (_Height / 2) - ((_FontHeight * totalLines) / 2) + ((i - 1) * _FontHeight)
        _PrintString (x, y), lines$(i)
    Next
End Sub


Sub setError (text$, duration As Single)
    errorDialog.text = text$
    errorDialog.state = True
    errorDialog.start = Timer
    errorDialog.duration = duration
End Sub

Sub showError
    If errorDialog.state Then
        dialog errorDialog.text
        If timeElapsedSince(errorDialog.start) > errorDialog.duration Then
            errorDialog.state = False
        End If
    End If
End Sub

Function cursorBlink$
    Static lastBlink
    If timeElapsedSince(lastBlink) < .5 Then
        cursorBlink$ = "_"
    Else
        cursorBlink$ = " "
    End If

    If timeElapsedSince(lastBlink) > 1 Then
        lastBlink = Timer
    End If
End Function

Function StrReplace$ (myString$, find$, replaceWith$) 'noncase sensitive
    Dim a$, b$, basei As Long, i As Long
    If Len(myString$) = 0 Then Exit Function
    a$ = myString$
    b$ = LCase$(find$)
    basei = 1
    i = InStr(basei, LCase$(a$), b$)
    Do While i
        a$ = Left$(a$, i - 1) + replaceWith$ + Right$(a$, Len(a$) - i - Len(b$) + 1)
        basei = i + Len(replaceWith$)
        i = InStr(basei, LCase$(a$), b$)
    Loop
    StrReplace$ = a$
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

Function lerp! (start!, stp!, amt!)
    lerp! = amt! * (stp! - start!) + start!
End Function

Sub printOutline (x As Integer, y As Integer, text$, fg As _Unsigned Long, bg As _Unsigned Long)
    Dim hlX As Integer, hlY As Integer
    Color bg
    For hlX = -1 To 1 Step 2
        For hlY = -1 To 1 Step 2
            _PrintString (x + hlX, y + hlY), text$
        Next
    Next

    Color fg
    _PrintString (x, y), text$
End Sub

