Option _Explicit
On Error GoTo oops
$Resize:On

Dim As String temp
Dim As Long form, closebutton, button1, check1, label1, label2, label3
Dim As Long filemenu, filemenunew, filemenuexit
Dim As Long editmenu, editmenuundo, editmenuredo, editmenuproperties
Dim As Long viewmenu, viewmenusubs, viewmenulinenumbers, viewmenuwarnings
Dim As Long viewmenulinenumbersshowhide, viewmenulinenumbersshowbackground, viewmenulinenumbersshowseparator
Dim As Long statusbar

tui "set highintensity=true"
statusbar = tui("add type=label;name=statusbar;caption= Ready.;x=1;y=25;w=80;h=1;fg=0;bg=3")

tui "set defaults;fg=0;bg=7;fghover=7;bghover=0;fghotkey=15"

filemenu = tui("add type=menubar;parent=0;name=filemenu;caption=&File")
tui "set defaults;parent=filemenu"
filemenunew = tui("add type=menuitem;name=filemenunew;caption=&New  Ctrl+N")
tui "add type=menuitem;caption=-"
filemenuexit = tui("add type=menuitem;name=filemenuexit;caption=E&xit")

editmenu = tui("add type=menubar;parent=0;name=editmenu;caption=&Edit")
tui "set defaults;parent=editmenu"
editmenuundo = tui("add type=menuitem;name=editmenuundo;caption=&Undo  Ctrl+Z")
editmenuredo = tui("add type=menuitem;name=editmenuredo;caption=&Redo  Ctrl+Y;disabled=true")
tui "add type=menuitem;caption=-"
editmenuproperties = tui("add type=menuitem;name=editmenuproperties;caption=&Properties...")

viewmenu = tui("add type=menubar;parent=0;name=viewmenu;caption=&View")
tui "set defaults;parent=viewmenu"
viewmenusubs = tui("add type=menuitem;name=viewmenusubs;caption=&SUBs...  F2")
viewmenulinenumbers = tui("add type=menuitem;name=viewmenulinenumbers;caption=&Line Numbers;special=submenu")
tui "add type=menuitem;caption=-"
viewmenuwarnings = tui("add type=menuitem;name=viewmenuwarnings;caption=Compiler &Warnings...  Ctrl+W")

tui "set defaults;parent=viewmenulinenumbers"
viewmenulinenumbersshowhide = tui("add type=menuitem;name=viewmenulinenumbersshowhide;caption=&Show Line Numbers")
viewmenulinenumbersshowbackground = tui("add type=menuitem;name=viewmenulinenumbersshowbackground;caption=&Background Color;special=submenu")
viewmenulinenumbersshowseparator = tui("add type=menuitem;name=viewmenulinenumbersshowseparator;caption=Sho&w Separator")

tui "set defaults;parent=viewmenulinenumbersshowbackground"
tui "add type=menuitem;name=viewmenubgbright;caption=&Bright mode"
tui "add type=menuitem;name=viewmenubgdark;caption=&Dark side of the moon"

Dim As _Byte updateLabel
Dim As Long i
updateLabel = -1
Do
    While _Resize
        Dim As Integer newWidth, newHeight
        Dim As _Byte willResize
        newWidth = _ResizeWidth
        newHeight = _ResizeHeight
        willResize = -1
    Wend

    If willResize Then
        willResize = 0
        Width newWidth \ 8, newHeight \ 16
        tui "set control=statusbar;y=" + Str$(_Height) + ";w=" + Str$(_Width)
    End If

    Color 25, 0
    Cls
    For i = 1 To _Height
        _PrintString (1, i), String$(_Width, 176)
    Next

    If updateLabel Then
        If tui("get control=check1;value") Then
            tui "set control=label1;caption=The box is checked.;color=inherit"
        Else
            tui "set control=label1;caption=The box is unchecked.;color=inherit"
        End If
    End If

    temp$ = "get hover"
    tui temp$
    tui "set control=label2;caption=Hover: " + temp$ + ";color=inherit"

    temp$ = "get focus"
    tui temp$
    tui "set control=label3;caption=Focus: " + temp$ + ";color=inherit"

    If tui("clicked") Then
        tui "set control=statusbar;caption= Ready."
        Select Case tui("control")
            Case button1
                If tui("get control=editmenu;disabled") Then
                    tui "set control=editmenu;disabled=false"
                Else
                    tui "set control=editmenu;disabled=true"
                End If
            Case check1
                updateLabel = -1
            Case filemenuexit
                System
            Case closebutton
                tui "delete control=form1"
            Case filemenunew
                '---------------------------------------
                tui "set defaults;parent=0"
                form = tui("add type=form;name=form1;caption=Hello, world!;align=center;fghover=16;bghover=7;w=50;h=11")

                tui "set defaults;parent=form1"
                closebutton = tui("add type=button;name=closebutton;caption=[X];fg=20;fghover=28;y=0;align=top-right;shadow=false;canreceivefocus=false")
                check1 = tui("add type=checkbox;value=-1;name=check1;caption=&I'm a check box.;x=2;y=2")
                label1 = tui("add type=label;name=label1;caption=Nothing to show;x=2;y=3;bghover=-1;special=autosize")
                label2 = tui("add type=label;name=label2;caption=Hover:;x=2;y=4;bghover=-1;special=autosize")
                label3 = tui("add type=label;name=label3;caption=Focus:;x=2;y=5;bghover=-1;special=autosize")
                button1 = tui("add type=button;name=button1;caption=Click &me;align=center;y=8;w=20;fg=31;bg=9;fghover=16;bghover=7")

                'tui "set modal;control=form1"
                tui "set focus;control=check1"
                '---------------------------------------
            Case label1
                tui "set control=label1;caption=This is not a button!;fg=4;fghover=20"
                updateLabel = 0
            Case viewmenusubs
                tui "reset"
            Case Else
                temp$ = "get control=" + Str$(tui("control")) + ";name"
                tui temp$
                tui "set control=statusbar;caption= This control has no action assigned to it: " + temp$
        End Select
    End If
    _Display
    _Limit 30
Loop

oops:
Resume Next

Sub tui (action As String)
    Dim As Long result
    result = tui&(action)
End Sub

Function tui& (action As String) Static
    Type newControl
        As Long type, parent, x, y, w, h, value, keybind
        As Integer fg, bg, fghover, bghover, fghotkey, hotkeypos
        As String name, special, caption, text, hotkey
        As _Byte canReceiveFocus, active, disabled, hidden, shadow
    End Type

    Dim As String result, temp
    Dim As Long i, j, this, k, modalForm
    Dim As Long menuPanel(100), totalMenuPanels, totalMenuPanelItems
    Dim As String menuPanelParents
    Dim As Long x, y, mx, my, oldmx, oldmy, mb, hover, mouseDownOn, clicked, lastClickedControl, focus, prevFocus
    Dim As Long mouseDownX, mouseDownY, hotkeyX, hotkeyY
    Dim As Integer prevFG, prevBG
    Dim As _Byte setup, mouseDown, fetchMouse, showFocus, fetchedKeyboard
    Dim As _Byte draggingForm, highIntensity, captionSet, hasMenuBar
    Dim As _Byte keyboardControl, showHotKey, prevShowHotKey, willActivateMenu

    If setup = 0 Then
        ReDim control(100) As newControl
        Dim defaults As newControl
        defaults.shadow = -1
        defaults.fg = -1
        defaults.bg = -1
        defaults.fghover = -1
        defaults.bghover = -1
        fetchMouse = -1
        showFocus = -1
        hasMenuBar = 0
        setup = -1
    End If

    Select Case getAction$(action)
        Case "reset"
            ReDim control(100) As newControl
            modalForm = 0
            hasMenuBar = 0
        Case "add"
            this = 0
            For i = 1 To UBound(control)
                If control(i).active = 0 Then this = i: Exit For
            Next

            If this = 0 And i > UBound(control) Then
                ReDim _Preserve control(UBound(control) + 100) As newControl
                this = i
            End If

            control(this) = defaults

            If passed(action, "type") Then control(this).type = controlType(getParam(action, "type"))
            Select Case getParam(action, "type")
                Case "button", "checkbox", "textbox"
                    control(this).canReceiveFocus = -1
            End Select

            If passed(action, "name") Then control(this).name = getParam(action, "name")
            If passed(action, "parent") Then
                temp = getParam(action, "parent")
                GoSub getParentID
                control(i).parent = j
            End If
            If passed(action, "shadow") Then control(this).shadow = (LCase$(getParam(action, "shadow")) = "true")
            If passed(action, "canreceivefocus") Then control(this).canReceiveFocus = (LCase$(getParam(action, "canreceivefocus")) = "true")
            If passed(action, "hidden") Then control(this).hidden = (LCase$(getParam(action, "hidden")) = "true")
            If passed(action, "disabled") Then control(this).disabled = (LCase$(getParam(action, "disabled")) = "true")
            If passed(action, "caption") Then
                temp = getParam(action, "caption")
                control(this).caption = temp
                If control(this).type <> controlType("form") Then
                    control(this).hotkeypos = InStr(control(this).caption, "&")
                    If control(this).hotkeypos Then
                        control(this).caption = Left$(control(this).caption, control(this).hotkeypos - 1) + Mid$(control(this).caption, control(this).hotkeypos + 1)
                        control(this).hotkey = Mid$(control(this).caption, control(this).hotkeypos, 1)
                    End If
                End If
            End If
            If passed(action, "text") Then control(this).text = getParam(action, "text")

            If passed(action, "special") Then control(this).special = getParam(action, "special")
            Select Case control(this).special
                Case "autosize"
                    control(this).w = Len(control(this).caption)
            End Select

            If passed(action, "w") Then
                temp = getParam(action, "w")
                If temp = "auto" Then
                    GoSub setAutoWidth
                ElseIf Val(temp) > 0 Then
                    control(this).w = Val(temp)
                End If
            Else
                GoSub setAutoWidth
            End If

            If passed(action, "h") Then
                control(this).h = Val(getParam(action, "h"))
            Else
                control(this).h = 1
            End If

            result = getParam(action, "align")
            Select Case result
                Case "center"
                    If control(this).parent = 0 Then
                        control(this).x = (_Width - control(this).w) \ 2
                        control(this).y = (_Height - control(this).h) \ 2
                    Else
                        control(this).x = (control(control(this).parent).w - control(this).w) \ 2
                        control(this).y = (control(control(this).parent).h - control(this).h) \ 2
                    End If
                    While control(this).x < 1
                        control(this).x = control(this).x + 1
                    Wend
                    While control(this).y < 1
                        control(this).y = control(this).y + 1
                    Wend
                Case "bottom-center"
                    If control(this).parent = 0 Then
                        control(this).x = (_Width - control(this).w) \ 2
                        control(this).y = (_Height - control(this).h)
                    Else
                        control(this).x = (control(control(this).parent).w - control(this).w) \ 2
                        control(this).y = (control(control(this).parent).h - control(this).h) - 2
                    End If
                Case "bottom-right"
                    If control(this).parent = 0 Then
                        control(this).x = (_Width - control(this).w)
                        control(this).y = (_Height - control(this).h)
                    Else
                        control(this).x = (control(control(this).parent).w - control(this).w) - 2
                        control(this).y = (control(control(this).parent).h - control(this).h) - 2
                    End If
                Case "bottom-left"
                    control(this).x = 2
                    If control(this).parent = 0 Then
                        control(this).y = (_Height - control(this).h)
                    Else
                        control(this).y = (control(control(this).parent).h - control(this).h) - 2
                    End If
                Case "top-center"
                    control(this).y = 1
                    If control(this).parent = 0 Then
                        control(this).x = (_Width - control(this).w) \ 2
                    Else
                        control(this).x = (control(control(this).parent).w - control(this).w) \ 2
                    End If
                Case "top-right"
                    control(this).y = 1
                    If control(this).parent = 0 Then
                        control(this).x = (_Width - control(this).w)
                    Else
                        control(this).x = (control(control(this).parent).w - control(this).w) - 2
                    End If
                Case "top-left"
                    control(this).x = 2
                    control(this).y = 1
            End Select

            If passed(action, "x") Then control(this).x = Val(getParam(action, "x"))
            If passed(action, "y") Then control(this).y = Val(getParam(action, "y"))

            result = getParam(action, "color")
            If result = "inherit" And control(this).parent > 0 Then
                control(this).fg = control(control(this).parent).fg
                control(this).bg = control(control(this).parent).bg
                control(this).fghover = control(control(this).parent).fghover
                control(this).bghover = control(control(this).parent).bghover
            ElseIf result = "defaults" Then
                control(this).fg = defaults.fg
                control(this).bg = defaults.bg
                control(this).fghover = defaults.fghover
                control(this).bghover = defaults.bghover
                control(this).fghotkey = defaults.fghotkey
            End If

            If passed(action, "fg") Then control(this).fg = Val(getParam(action, "fg"))
            If passed(action, "bg") Then control(this).bg = Val(getParam(action, "bg"))
            If passed(action, "fghover") Then control(this).fghover = Val(getParam(action, "fghover"))
            If passed(action, "bghover") Then control(this).bghover = Val(getParam(action, "bghover"))

            If passed(action, "value") Then control(this).value = Val(getParam(action, "value"))
            If passed(action, "keybind") Then control(this).keybind = Val(getParam(action, "keybind"))

            If control(this).type = controlType("menubar") Then
                If hasMenuBar = 0 Then
                    hasMenuBar = -1
                    Dim As Long lastMenuBarX, lastMenuBarLen
                    lastMenuBarX = 3
                End If
                control(this).y = 1
                control(this).x = lastMenuBarX + lastMenuBarLen
                lastMenuBarX = control(this).x
                lastMenuBarLen = Len(control(this).caption) + 2
            End If

            control(this).active = -1
            tui& = this
        Case "clicked"
            PCopy 0, 127
            Do
                PCopy 127, 0
                If fetchMouse Or (control(focus).type = controlType("menubar") Or control(menuPanel(totalMenuPanels)).active) Then
                    While _MouseInput: Wend
                End If
                mx = _MouseX
                my = _MouseY

                If keyboardControl Then
                    If mx <> oldmx Or my <> oldmy Then
                        keyboardControl = 0
                    End If
                End If

                mb = _MouseButton(1)
                clicked = 0
                hover = 0
                fetchedKeyboard = 0
                prevFG = _DefaultColor
                prevBG = _BackgroundColor
                showHotKey = _KeyDown(100308) Or _KeyDown(100307)

                If showHotKey Then
                    If prevShowHotKey = 0 Then
                        prevShowHotKey = -1
                        willActivateMenu = -1
                    End If
                Else
                    prevShowHotKey = 0
                    If willActivateMenu = -1 And modalForm = 0 Then
                        willActivateMenu = 0
                        If control(focus).type = controlType("menubar") Then
                            If control(prevFocus).type <> controlType("menubar") Then focus = prevFocus
                        ElseIf control(focus).type <> controlType("menupanel") And control(focus).type <> controlType("menuitem") Then
                            For i = 1 To UBound(control)
                                If control(i).type = controlType("menubar") Then
                                    If control(focus).type <> controlType("menubar") Then prevFocus = focus
                                    focus = i
                                    Exit For
                                End If
                            Next
                        ElseIf control(focus).type = controlType("menuitem") Then
                            GoSub closeMenuPanel
                            focus = control(menuPanel(totalMenuPanels)).parent
                        End If
                    End If
                End If

                For i = 1 To UBound(control)
                    If control(i).active = 0 Then _Continue

                    If modalForm > 0 Then
                        'modal forms and their controls are drawn exclusively
                        If control(i).type = controlType("form") And i <> modalForm Then _Continue
                        If control(i).type <> controlType("form") And control(i).parent <> modalForm Then _Continue
                    End If

                    Select Case control(i).type
                        Case controlType("menubar"), controlType("menuitem")
                            'deal with menus last
                            _Continue
                    End Select

                    x = 0
                    y = 0
                    hotkeyX = 0
                    hotkeyY = 0
                    this = i
                    Do
                        x = x + control(this).x
                        y = y + control(this).y
                        this = control(this).parent
                    Loop While this > 0

                    If control(i).parent > 0 Then
                        tuiSetColor control(control(i).parent).fg, control(control(i).parent).bg
                    End If

                    tuiSetColor control(i).fg, control(i).bg

                    If keyboardControl = 0 And mx >= x And mx <= x + control(i).w - 1 And my >= y And my <= y + control(i).h - 1 Then
                        If Not draggingForm And Not control(menuPanel(totalMenuPanels)).active Then
                            hover = i
                            Select Case control(i).type
                                Case controlType("form")
                                Case Else
                                    tuiSetColor control(i).fghover, control(i).bghover
                            End Select
                        End If
                    End If

                    Select Case control(i).type
                        Case controlType("form")
                            If control(i).shadow Then
                                boxShadow x, y, control(i).w, control(i).h
                            Else
                                box x, y, control(i).w, control(i).h
                            End If
                            If Len(control(i).caption) Then
                                tuiSetColor control(i).fghover, control(i).bghover
                                _PrintString (control(i).x, control(i).y), Space$(control(i).w)
                                _PrintString (x + (control(i).w - (Len(control(i).caption)) + 2) \ 2, y), " " + control(i).caption + " "
                            End If
                            If focus = i Then Locate , , 0
                            showFocus = -1 'if a form is up, focus is always shown
                            k = _KeyHit 'read keyboard input if a form is up
                            fetchedKeyboard = -1
                        Case controlType("button")
                            If control(i).shadow And ((focus = i And _KeyDown(32)) Or (mouseDownOn = i And hover = i)) Then
                                x = x + 1
                            End If
                            _PrintString (x, y), Space$(control(i).w)
                            temp = Left$(control(i).caption, control(i).w)
                            _PrintString (x + (control(i).w - Len(temp)) \ 2, y), temp
                            hotkeyX = (x + (control(i).w - Len(temp)) \ 2) + control(i).hotkeypos - 1
                            hotkeyY = y
                            If control(i).shadow And (hover <> i Or (hover = i And mouseDownOn <> i)) And (focus <> i Or (focus = i And _KeyDown(32) = 0)) Then
                                If control(i).parent > 0 Then
                                    tuiSetColor 0, control(control(i).parent).bg
                                Else
                                    tuiSetColor 0, prevBG
                                End If
                                _PrintString (x + control(i).w, y), Chr$(220)
                                _PrintString (x + 1, y + 1), String$(control(i).w, 223)
                            End If
                            If showFocus And focus = i Then Locate y, x + (control(i).w - Len(control(i).caption)) \ 2, 1
                        Case controlType("checkbox")
                            If control(i).value Then
                                temp = "[X] "
                            Else
                                temp = "[ ] "
                            End If
                            _PrintString (x, y), temp + Left$(control(i).caption, control(i).w - 4)
                            hotkeyX = x + Len(temp) + control(i).hotkeypos - 1
                            hotkeyY = y
                            If showFocus And focus = i Then Locate y, x + 1, 1
                        Case controlType("label")
                            _PrintString (x, y), Space$(control(i).w)
                            _PrintString (x, y), Left$(control(i).caption, control(i).w)
                            hotkeyX = x + control(i).hotkeypos - 1
                            hotkeyY = y
                        Case controlType("textbox")
                            If focus = i And fetchedKeyboard = 0 Then
                                k = _KeyHit 'read keyboard input for textbox control
                                fetchedKeyboard = -1
                            End If
                    End Select

                    If control(i).hotkeypos > 0 And showHotKey And control(menuPanel(totalMenuPanels)).active = 0 Then
                        tuiSetColor control(i).fghotkey, -1
                        _PrintString (hotkeyX, hotkeyY), control(i).hotkey
                    End If
                Next

                If hasMenuBar Then
                    Dim firstMenuFound As _Byte
                    firstMenuFound = 0
                    For i = 1 To UBound(control)
                        If control(i).type = controlType("menubar") Then
                            If control(i).hidden Or control(i).active = 0 Then _Continue
                            If focus = i Then Locate , , 0
                            If firstMenuFound = 0 Then
                                x = control(i).x
                                tuiSetColor control(i).fg, control(i).bg
                                _PrintString (1, 1), Space$(_Width)
                                firstMenuFound = -1
                            Else
                                x = x + control(i).w + 2
                                control(i).x = x
                            End If
                            If modalForm Then
                                tuiSetColor 8, control(i).bg
                            Else
                                If keyboardControl = 0 And (modalForm = 0 And my = 1 And mx >= control(i).x And mx < control(i).x + Len(control(i).caption) + 2) Then
                                    If draggingForm = 0 And control(i).disabled = 0 Then
                                        tuiSetColor control(i).fghover, control(i).bghover
                                        hover = i
                                        If control(focus).type = controlType("menubar") Then focus = i
                                        If totalMenuPanels > 0 And control(menuPanel(totalMenuPanels)).parent <> focus Then GoSub openMenuPanel
                                    ElseIf control(i).disabled Then
                                        tuiSetColor 8, control(i).bg
                                    End If
                                    If focus = i Then Locate , , 0
                                ElseIf focus = i Or InStr(menuPanelParents, MKL$(i) + MKL$(-1)) > 0 Then
                                    tuiSetColor control(i).fghover, control(i).bghover
                                Else
                                    If control(menuPanel(totalMenuPanels)).parent <> i Or control(menuPanel(totalMenuPanels)).active = 0 Then
                                        If control(i).disabled Then
                                            tuiSetColor 8, control(i).bg
                                        Else
                                            tuiSetColor control(i).fg, control(i).bg
                                        End If
                                    ElseIf totalMenuPanels Then
                                        tuiSetColor control(i).fghover, control(i).bghover
                                    End If
                                End If
                            End If
                            _PrintString (x, 1), " " + control(i).caption + " "
                            If (control(focus).type = controlType("menubar") And control(i).disabled = 0) Or (modalForm = 0 And control(i).hotkeypos > 0 And showHotKey And totalMenuPanels = 0 And control(i).disabled = 0) Then
                                tuiSetColor control(i).fghotkey, -1
                                _PrintString (x + control(i).hotkeypos, 1), control(i).hotkey
                            End If
                        End If
                    Next
                End If

                If totalMenuPanels > 0 Then
                    Dim As String menuCaption, menuShortcut
                    Dim As Long willActivateMenuPanel
                    Dim As Single activateMenuPanelTimer

                    For this = 1 To totalMenuPanels
                        tuiSetColor control(menuPanel(this)).fg, control(menuPanel(this)).bg
                        boxShadow control(menuPanel(this)).x, control(menuPanel(this)).y, control(menuPanel(this)).w, control(menuPanel(this)).h
                        If keyboardControl = 0 And mx >= control(menuPanel(this)).x And mx <= control(menuPanel(this)).x + control(menuPanel(this)).w - 1 And my >= control(menuPanel(this)).y And my <= control(menuPanel(this)).y + control(menuPanel(this)).h - 1 Then
                            hover = menuPanel(this)
                        End If
                        For i = 1 To UBound(control)
                            If control(i).type = controlType("menuitem") And control(i).parent = control(menuPanel(this)).parent Then
                                If focus = i Then Locate , , 0
                                If control(i).caption = "-" Then
                                    tuiSetColor control(menuPanel(this)).fg, control(menuPanel(this)).bg
                                    _PrintString (control(i).x - 2, control(i).y), Chr$(195) + String$(control(menuPanel(this)).w - 2, 196) + Chr$(180)
                                Else
                                    menuShortcut = ""
                                    j = InStr(control(i).caption, Space$(2))
                                    If j > 0 And control(i).special <> "submenu" Then
                                        menuCaption = Left$(control(i).caption, j - 1)
                                        menuShortcut = Mid$(control(i).caption, j + 2)
                                    ElseIf control(i).special = "submenu" Then
                                        menuCaption = control(i).caption
                                        menuShortcut = Chr$(16)
                                    Else
                                        menuCaption = control(i).caption
                                    End If

                                    If keyboardControl = 0 And (mx >= control(i).x - 1 And mx <= control(menuPanel(this)).x + control(menuPanel(this)).w - 2 And my = control(i).y) Then
                                        hover = i
                                        focus = i
                                    End If

                                    If (focus = i And control(i).parent = control(menuPanel(totalMenuPanels)).parent) Or InStr(menuPanelParents, MKL$(i) + MKL$(-1)) > 0 Then
                                        tuiSetColor control(menuPanel(this)).fghover, control(menuPanel(this)).bghover
                                        _PrintString (control(i).x - 1, control(i).y), Space$(control(menuPanel(this)).w - 2)
                                        If focus = i And control(i).special = "submenu" And willActivateMenuPanel = 0 Then
                                            willActivateMenuPanel = i: activateMenuPanelTimer = Timer
                                        ElseIf focus = i And control(i).special <> "submenu" And willActivateMenuPanel > 0 Then
                                            willActivateMenuPanel = 0
                                        End If
                                    Else
                                        If control(i).disabled Then
                                            tuiSetColor 8, control(menuPanel(this)).bg
                                        Else
                                            tuiSetColor control(menuPanel(this)).fg, control(menuPanel(this)).bg
                                        End If
                                    End If
                                    _PrintString (control(i).x, control(i).y), menuCaption
                                    If Len(menuShortcut) Then
                                        _PrintString (control(menuPanel(this)).x + control(menuPanel(this)).w - Len(menuShortcut) - 2, control(i).y), menuShortcut
                                    End If
                                    If control(i).hotkeypos > 0 And control(i).disabled = 0 Then
                                        Color control(i).fghotkey
                                        _PrintString (control(i).x + control(i).hotkeypos - 1, control(i).y), control(i).hotkey
                                    End If
                                End If
                            End If
                        Next
                    Next
                End If

                If timeElapsedSince(activateMenuPanelTimer) >= .5 And willActivateMenuPanel > 0 And InStr(menuPanelParents, MKL$(willActivateMenuPanel) + MKL$(-1)) = 0 And keyboardControl = 0 Then
                    focus = willActivateMenuPanel
                    GoSub openMenuPanel
                    willActivateMenuPanel = 0
                ElseIf timeElapsedSince(activateMenuPanelTimer) >= .5 And willActivateMenuPanel > 0 Then
                    willActivateMenuPanel = 0
                End If

                If control(focus).type = controlType("menuitem") Then
                    While totalMenuPanels > 0 And control(menuPanel(totalMenuPanels)).parent <> control(focus).parent And control(menuPanel(totalMenuPanels)).parent <> focus
                        GoSub closeMenuPanel
                    Wend
                End If

                Color prevFG, prevBG

                If k Then GoSub enableKeyboardControl
                Select EveryCase k
                    Case -9, -25
                        this = focus
                        If _KeyDown(100304) Or _KeyDown(100303) Then
                            Do
                                focus = focus - 1
                                If focus < 1 Then focus = UBound(control)
                                If focus = this Then Exit Do
                            Loop While control(focus).canReceiveFocus = 0
                        Else
                            Do
                                focus = focus + 1
                                If focus > UBound(control) Then focus = 1
                                If focus = this Then Exit Do
                            Loop While control(focus).canReceiveFocus = 0
                        End If
                    Case -13
                        Select Case control(focus).type
                            Case controlType("button"), controlType("menuitem")
                                If control(focus).disabled = 0 Then clicked = focus Else Exit Case
                                If control(focus).type = controlType("menuitem") Then
                                    If control(focus).special = "submenu" Then
                                        clicked = 0
                                        GoSub openMenuPanel
                                    Else
                                        While totalMenuPanels
                                            GoSub closeMenuPanel
                                        Wend
                                    End If
                                End If
                            Case controlType("menubar")
                                GoSub openMenuPanel
                        End Select
                    Case -32
                        Select Case control(focus).type
                            Case controlType("button")
                                clicked = focus
                            Case controlType("checkbox")
                                control(focus).value = Not control(focus).value
                                clicked = focus
                        End Select
                    Case 27
                        If totalMenuPanels Then focus = control(menuPanel(totalMenuPanels)).parent: GoSub closeMenuPanel
                        k = 0
                    Case 18432 'up
                        Select Case control(focus).type
                            Case controlType("menubar")
                                GoSub openMenuPanel
                            Case controlType("menuitem")
                                this = focus
                                Do
                                    this = this - 1
                                    If this < 1 Then this = UBound(control)
                                    If this = focus Then Exit Do
                                    If control(this).type = controlType("menuitem") And control(this).parent = control(focus).parent And control(this).caption <> "-" And control(this).hidden = 0 Then
                                        focus = this
                                        Exit Do
                                    End If
                                Loop
                        End Select
                    Case 20480 'down
                        Select Case control(focus).type
                            Case controlType("menubar")
                                GoSub openMenuPanel
                            Case controlType("menuitem")
                                this = focus
                                Do
                                    this = this + 1
                                    If this > UBound(control) Then this = 1
                                    If this = focus Then Exit Do
                                    If control(this).type = controlType("menuitem") And control(this).parent = control(focus).parent And control(this).caption <> "-" And control(this).hidden = 0 Then
                                        focus = this
                                        Exit Do
                                    End If
                                Loop
                        End Select
                    Case 19200 'left
                        Select EveryCase control(focus).type
                            Case controlType("menubar"), controlType("menuitem")
                                If control(focus).type = controlType("menuitem") Then
                                    If control(control(menuPanel(totalMenuPanels)).parent).type = controlType("menuitem") Then
                                        focus = control(menuPanel(totalMenuPanels)).parent
                                        GoSub closeMenuPanel
                                        Exit Case
                                    Else
                                        focus = control(focus).parent
                                    End If
                                End If
                                this = focus
                                Do
                                    this = this - 1
                                    If this < 1 Then this = UBound(control)
                                    If this = focus Then Exit Do
                                    If control(this).type = controlType("menubar") And control(this).disabled = 0 And control(this).hidden = 0 Then
                                        focus = this
                                        If control(menuPanel(totalMenuPanels)).active Then GoSub openMenuPanel
                                        Exit Do
                                    End If
                                Loop
                        End Select
                    Case 19712 'right
                        Select Case control(focus).type
                            Case controlType("menubar"), controlType("menuitem")
                                If control(focus).type = controlType("menuitem") Then
                                    If control(focus).special = "submenu" Then
                                        GoSub openMenuPanel
                                        Exit Case
                                    Else
                                        focus = control(focus).parent
                                    End If
                                End If
                                this = focus
                                Do
                                    this = this + 1
                                    If this > UBound(control) Then this = 1
                                    If this = focus Then Exit Do
                                    If control(this).type = controlType("menubar") And control(this).disabled = 0 And control(this).hidden = 0 Then
                                        focus = this
                                        If control(menuPanel(totalMenuPanels)).active Then GoSub openMenuPanel
                                        Exit Do
                                    End If
                                Loop
                        End Select
                    Case 65 To 90, 97 To 122 'A-Z, a-z
                        If showHotKey Or control(menuPanel(totalMenuPanels)).active Or control(focus).type = controlType("menubar") Then
                            Dim As String hotkeySearch
                            hotkeySearch = UCase$(Chr$(k))
                            For i = 1 To UBound(control)
                                If UCase$(control(i).hotkey) = hotkeySearch Then
                                    If control(menuPanel(totalMenuPanels)).active = 0 Or (control(menuPanel(totalMenuPanels)).active And control(i).parent = control(menuPanel(totalMenuPanels)).parent) Or (control(menuPanel(totalMenuPanels)).active And control(i).type = controlType("menubar")) Then
                                        'alt+hotkey emulates click on control
                                        If control(i).type = controlType("menubar") Then
                                            If control(i).disabled = 0 And control(i).hidden = 0 Then
                                                mb = 0
                                                mouseDown = -1
                                                mouseDownOn = i
                                                hover = i
                                                prevFocus = focus
                                                GoSub openMenuPanel
                                            End If
                                        Else
                                            mb = 0
                                            mouseDown = -1
                                            mouseDownOn = i
                                            hover = i
                                            focus = i
                                        End If
                                        willActivateMenu = 0
                                        Exit For
                                    End If
                                End If
                            Next
                        End If
                    Case Else
                        If k > 0 Then
                            For i = 1 To UBound(control)
                                If control(i).keybind = k Then
                                    'hitting a control's keybind emulates click
                                    mb = 0
                                    mouseDown = -1
                                    mouseDownOn = i
                                    hover = i
                                    focus = i
                                    Exit For
                                End If
                            Next
                        End If
                End Select

                If mb Then
                    If mouseDown Then
                        'drag
                        If draggingForm Then
                            control(mouseDownOn).x = control(mouseDownOn).x - (mouseDownX - mx)
                            control(mouseDownOn).y = control(mouseDownOn).y - (mouseDownY - my)
                            If control(mouseDownOn).x < 1 Then control(mouseDownOn).x = 1
                            If hasMenuBar Then
                                If control(mouseDownOn).y < 2 Then control(mouseDownOn).y = 2
                            Else
                                If control(mouseDownOn).y < 1 Then control(mouseDownOn).y = 1
                            End If
                            If control(mouseDownOn).x + control(mouseDownOn).w > _Width Then control(mouseDownOn).x = _Width - control(mouseDownOn).w + 1
                            If control(mouseDownOn).y + control(mouseDownOn).h > _Height Then control(mouseDownOn).y = _Height - control(mouseDownOn).h + 1
                            mouseDownX = mx
                            mouseDownY = my
                        End If
                    Else
                        mouseDown = -1
                        mouseDownOn = hover
                        If hover = 0 Then
                            While totalMenuPanels
                                GoSub closeMenuPanel
                            Wend
                        ElseIf control(hover).type = controlType("form") Then
                            If my = control(hover).y Then draggingForm = -1
                        ElseIf control(hover).type = controlType("menubar") Then
                            If control(menuPanel(totalMenuPanels)).active And hover = control(menuPanel(totalMenuPanels)).parent Then
                                While totalMenuPanels
                                    GoSub closeMenuPanel
                                Wend
                            Else
                                GoSub openMenuPanel
                            End If
                        Else
                            draggingForm = 0
                            If control(mouseDownOn).canReceiveFocus Then focus = hover
                        End If
                        mouseDownX = mx
                        mouseDownY = my
                    End If
                Else
                    If mouseDown Then
                        If mouseDownOn > 0 And mouseDownOn = hover Then
                            If control(mouseDownOn).disabled = 0 Then
                                clicked = mouseDownOn

                                Select Case control(clicked).type
                                    Case controlType("checkbox")
                                        control(clicked).value = Not control(clicked).value
                                    Case controlType("menuitem")
                                        If control(clicked).special <> "submenu" Then
                                            While totalMenuPanels
                                                GoSub closeMenuPanel
                                            Wend
                                        Else
                                            GoSub openMenuPanel
                                        End If
                                End Select
                            End If
                        ElseIf mouseDownOn = 0 Then
                            focus = 0
                        End If
                        If focus = 0 And control(menuPanel(totalMenuPanels)).active Then GoSub closeMenuPanel
                    End If
                    mouseDown = 0
                    mouseDownOn = 0
                    draggingForm = 0
                End If

                If clicked Then
                    lastClickedControl = clicked
                    tui& = -1
                    Exit Function
                Else
                    If modalForm = 0 And control(focus).type <> controlType("menubar") And control(menuPanel(totalMenuPanels)).active = 0 Then
                        Exit Function
                    End If
                End If
                _Display
                _Limit 30
            Loop
        Case "control"
            tui& = lastClickedControl
        Case "get"
            temp = getParam(action, "control")

            If Len(temp) = 0 Then
                Select Case getNextParam(action)
                    Case "hover"
                        tui = hover
                        action = control(hover).name
                        Exit Function
                    Case "focus"
                        tui = focus
                        action = control(focus).name
                        Exit Function
                End Select
            End If

            GoSub getControlID

            For i = 1 To 2
                temp = getNextParam(action)
            Next

            Select Case temp
                Case "parent": tui& = control(this).parent
                Case "x": tui& = control(this).x
                Case "y": tui& = control(this).y
                Case "w": tui& = control(this).w
                Case "h": tui& = control(this).h
                Case "value": tui& = control(this).value
                Case "fg": tui& = control(this).fg
                Case "bg": tui& = control(this).bg
                Case "fghover": tui& = control(this).fghover
                Case "bghover": tui& = control(this).bghover
                Case "shadow": tui& = control(this).shadow
                Case "disabled": tui& = control(this).disabled
                Case "hidden": tui& = control(this).hidden
                Case "canreceivefocus": tui& = control(this).canReceiveFocus
                Case "name": action = control(this).name
                Case "caption": action = control(this).caption
                Case "text": action = control(this).text
            End Select
        Case "set"
            Do
                temp = getNextParam(action)
                If Len(temp) = 0 Then Exit Do
                result = getParam(action, temp)
                Select Case temp
                    Case "fetchmouse"
                        fetchMouse = (LCase$(result) = "true")
                    Case "showfocus"
                        showFocus = (LCase$(result) = "true")
                    Case "highintensity"
                        highIntensity = (LCase$(result) = "true")
                        If highIntensity Then _Blink Off Else _Blink On
                    Case "focus"
                        temp = getParam(action, "control")
                        GoSub getControlID
                        focus = this
                    Case "modal"
                        temp = getParam(action, "control")
                        GoSub getControlID
                        If this = 0 Then
                            modalForm = 0
                        ElseIf control(this).type = controlType("form") Then
                            modalForm = this
                        End If
                    Case "defaults"
                        temp = getParam(action, "parent")
                        If Len(temp) Then
                            GoSub getParentID
                            defaults.parent = j
                        End If

                        If passed(action, "w") Then defaults.w = Val(getParam(action, "w"))
                        If passed(action, "h") Then defaults.h = Val(getParam(action, "h"))
                        If passed(action, "x") Then defaults.x = Val(getParam(action, "x"))
                        If passed(action, "y") Then defaults.y = Val(getParam(action, "y"))
                        If passed(action, "value") Then defaults.value = Val(getParam(action, "value"))

                        If passed(action, "fg") Then defaults.fg = Val(getParam(action, "fg"))
                        If passed(action, "bg") Then defaults.bg = Val(getParam(action, "bg"))
                        If passed(action, "fghover") Then defaults.fghover = Val(getParam(action, "fghover"))
                        If passed(action, "bghover") Then defaults.bghover = Val(getParam(action, "bghover"))
                        If passed(action, "fghotkey") Then defaults.fghotkey = Val(getParam(action, "fghotkey"))

                        If passed(action, "shadow") Then defaults.shadow = (LCase$(getParam(action, "shadow")) = "true")
                    Case "control"
                        temp = getParam(action, temp)
                        GoSub getControlID

                        captionSet = 0
                        If passed(action, "caption") Then
                            control(this).caption = getParam(action, "caption")
                            captionSet = -1
                        End If

                        If passed(action, "text") Then
                            control(this).text = getParam(action, "text")
                        End If

                        If passed(action, "w") Then
                            control(this).w = Val(getParam(action, "w"))
                        ElseIf captionSet And control(this).special = "autosize" Then
                            Select Case control(this).type
                                Case controlType("label")
                                    control(this).w = Len(control(this).caption)
                                Case controlType("button")
                                    control(this).w = Len(control(this).caption) + 2
                                Case controlType("checkbox")
                                    control(this).w = Len(control(this).caption) + 4
                            End Select
                        End If

                        If passed(action, "h") Then control(this).h = Val(getParam(action, "h"))
                        If passed(action, "x") Then control(this).x = Val(getParam(action, "x"))
                        If passed(action, "y") Then control(this).y = Val(getParam(action, "y"))

                        result = getParam(action, "color")
                        If result = "inherit" And control(this).parent > 0 Then
                            control(this).fg = control(control(this).parent).fg
                            control(this).bg = control(control(this).parent).bg
                            control(this).fghover = control(control(this).parent).fghover
                            control(this).bghover = control(control(this).parent).bghover
                        ElseIf result = "defaults" Then
                            control(this).fg = defaults.fg
                            control(this).bg = defaults.bg
                            control(this).fghover = defaults.fghover
                            control(this).bghover = defaults.bghover
                            control(this).fghotkey = defaults.fghotkey
                        End If

                        If passed(action, "fg") Then control(this).fg = Val(getParam(action, "fg"))
                        If passed(action, "bg") Then control(this).bg = Val(getParam(action, "bg"))
                        If passed(action, "fghover") Then control(this).fghover = Val(getParam(action, "fghover"))
                        If passed(action, "bghover") Then control(this).bghover = Val(getParam(action, "bghover"))

                        If passed(action, "value") Then control(this).value = Val(getParam(action, "value"))
                        If passed(action, "keybind") Then control(this).keybind = Val(getParam(action, "keybind"))

                        If passed(action, "shadow") Then control(this).shadow = (LCase$(getParam(action, "shadow")) = "true")
                        If passed(action, "disabled") Then control(this).disabled = (LCase$(getParam(action, "disabled")) = "true")
                        If passed(action, "hidden") Then control(this).hidden = (LCase$(getParam(action, "hidden")) = "true")
                        If passed(action, "canreceivefocus") Then control(this).canReceiveFocus = (LCase$(getParam(action, "canreceivefocus")) = "true")
                End Select
            Loop
        Case "delete"
            temp = getParam(action, "control")
            If Len(temp) Then
                GoSub getControlID
                If this Then
                    control(this).active = 0
                    If modalForm = this Then modalForm = 0
                    For i = this + 1 To UBound(control)
                        If control(i).parent = this Then control(i).active = 0
                    Next
                End If
            End If
        Case Else
            Cls
            Print "unknown action: "; getAction(action)
            End
    End Select

    Exit Function

    getParentID:
    'temp contains the name of the parent control
    For j = 1 To UBound(control)
        If control(j).name = temp Then
            Return
        End If
    Next
    j = 0
    Return

    getControlID:
    'temp contains the name of the control we're looking for
    If Val(temp) > 0 Then
        this = Val(temp)
    Else
        this = 0
        For j = 1 To UBound(control)
            If control(j).name = temp Then
                this = j
                Return
            End If
        Next
    End If
    Return

    setAutoWidth:
    control(this).w = Len(control(this).caption)
    If control(this).type = controlType("checkbox") Then control(this).w = control(this).w + 4
    Return

    openMenuPanel:
    If control(hover).type <> controlType("menubar") And control(hover).type <> controlType("menuitem") Then hover = focus
    If control(hover).type <> controlType("menubar") And control(hover).type <> controlType("menuitem") Then Return
    If modalForm Then Return

    If control(menuPanel(totalMenuPanels)).parent = hover Then Return
    If control(hover).type = controlType("menuitem") And control(hover).special <> "submenu" Then Return

    If control(hover).type = controlType("menubar") Then
        While totalMenuPanels
            GoSub closeMenuPanel
        Wend
    End If

    totalMenuPanels = totalMenuPanels + 1
    menuPanel(totalMenuPanels) = tui("add type=menupanel;name=tuimenupanel" + Str$(totalMenuPanels))
    menuPanelParents = menuPanelParents + MKL$(hover) + MKL$(-1)
    control(menuPanel(totalMenuPanels)).fg = control(hover).fg
    control(menuPanel(totalMenuPanels)).bg = control(hover).bg
    control(menuPanel(totalMenuPanels)).fghover = control(hover).fghover
    control(menuPanel(totalMenuPanels)).bghover = control(hover).bghover

    If control(hover).type = controlType("menuitem") Then
        control(menuPanel(totalMenuPanels)).x = control(hover).x + control(menuPanel(totalMenuPanels - 1)).w - 2
        control(menuPanel(totalMenuPanels)).y = control(hover).y - 1
    Else
        control(menuPanel(totalMenuPanels)).x = control(hover).x
        control(menuPanel(totalMenuPanels)).y = control(hover).y + 1
    End If

    control(menuPanel(totalMenuPanels)).active = -1
    control(menuPanel(totalMenuPanels)).w = 4
    control(menuPanel(totalMenuPanels)).parent = hover

    totalMenuPanelItems = 0
    focus = 0
    For j = 1 To UBound(control)
        If control(j).type = controlType("menuitem") And control(j).parent = hover Then
            If focus = 0 Then focus = j
            totalMenuPanelItems = totalMenuPanelItems + 1
            control(j).x = control(menuPanel(totalMenuPanels)).x + 2
            control(j).y = control(menuPanel(totalMenuPanels)).y + totalMenuPanelItems
            If control(j).special = "submenu" And Right$(control(j).caption, 3) <> Space$(3) Then
                control(j).caption = control(j).caption + Space$(3)
            End If
            If control(menuPanel(totalMenuPanels)).w < Len(control(j).caption) + 4 Then control(menuPanel(totalMenuPanels)).w = Len(control(j).caption) + 4
        End If
    Next
    control(menuPanel(totalMenuPanels)).h = totalMenuPanelItems + 2

    While control(menuPanel(totalMenuPanels)).x + control(menuPanel(totalMenuPanels)).w > _Width
        control(menuPanel(totalMenuPanels)).x = control(menuPanel(totalMenuPanels)).x - 1
        If control(menuPanel(totalMenuPanels)).x < 1 Then
            Color 7, 0
            Cls
            Print "Error positioning menu on screen."
            End
        End If
        For j = 1 To UBound(control)
            If control(j).type = controlType("menuitem") And control(j).parent = control(menuPanel(totalMenuPanels)).parent Then control(j).x = control(j).x - 1
        Next
    Wend
    Return

    closeMenuPanel:
    If totalMenuPanels > 0 Then
        control(menuPanel(totalMenuPanels)).active = 0
        totalMenuPanels = totalMenuPanels - 1
        menuPanelParents = Left$(menuPanelParents, Len(menuPanelParents) - 8)
        If totalMenuPanels = 0 Then focus = prevFocus
    End If
    Return

    enableKeyboardControl:
    keyboardControl = -1
    oldmx = mx
    oldmy = my
    Return

End Function

Sub tuiSetColor (fg As Integer, bg As Integer)
    If fg > -1 Then Color fg
    If bg > -1 Then Color , bg
End Sub

Function controlType& (__a$)
    Dim typeList$
    typeList$ = "@form@button@checkbox@label@textbox@menubar@menuitem@menupanel@"

    controlType& = InStr(typeList$, LCase$("@" + __a$ + "@"))
End Function

Function getAction$ (__a$)
    Dim As Long position
    Dim As String result, sep

    sep = " "
    position = InStr(__a$, sep)
    If position = 0 Then
        getAction$ = __a$
        __a$ = ""
    Else
        result = LCase$(Left$(__a$, position - 1))
        If InStr(result, "=") > 0 Then Exit Function
        __a$ = Mid$(__a$, position + 1)
        getAction$ = result
    End If
End Function

Function passed%% (__action$, __parameter$)
    Dim As String s, p, os, sep
    Dim As Long position

    sep = ";"
    os = sep + __action$ + sep
    s = LCase$(os)
    p = sep + LCase$(__parameter$) + "="

    position = _InStrRev(s, p)
    passed%% = position > 0
End Function

Function getParam$ (__action$, __parameter$)
    Dim As String s, p, os, result, sep
    Dim As Long position

    sep = ";"
    os = sep + __action$ + sep
    s = LCase$(os)
    p = sep + LCase$(__parameter$) + "="

    position = _InStrRev(s, p)
    If position = 0 Then Exit Function

    result = Mid$(os, position + Len(p))
    getParam$ = Left$(result, InStr(result, sep) - 1)
End Function

Function getNextParam$ (__action$) Static
    Dim As String lastAction, thisAction, sep, temp
    Dim As Long position, prevPosition, findEqual

    sep = ";"

    If __action$ <> lastAction Then
        lastAction = __action$
        thisAction = sep + __action$ + sep
        position = 1
    End If

    prevPosition = position
    position = InStr(prevPosition + 1, thisAction, sep)
    If position Then
        temp = Mid$(thisAction, prevPosition + 1, position - prevPosition - 1)
        findEqual = InStr(temp, "=")
        If findEqual Then
            getNextParam$ = Left$(temp, findEqual - 1)
        Else
            getNextParam$ = temp
        End If
    End If
End Function


Sub box (x As Long, y As Long, w As Long, h As Long)
    Dim As Long y2

    _PrintString (x, y), Chr$(218) + String$(w - 2, 196) + Chr$(191)
    For y2 = y + 1 To y + h - 2
        _PrintString (x, y2), Chr$(179) + Space$(w - 2) + Chr$(179)
    Next
    _PrintString (x, y + h - 1), Chr$(192) + String$(w - 2, 196) + Chr$(217)
End Sub

Sub boxShadow (x As Long, y As Long, w As Long, h As Long)
    box x, y, w, h

    Dim As Long y2, x2

    'shadow
    Color 8, 0
    For y2 = y + 1 To y + h - 1
        For x2 = x + w To x + w + 1
            If x2 <= _Width And y2 <= _Height Then
                _PrintString (x2, y2), Chr$(Screen(y2, x2))
            End If
        Next
    Next

    y2 = y + h
    If y2 <= _Height Then
        For x2 = x + 2 To x + w + 1
            If x2 <= _Width Then
                _PrintString (x2, y2), Chr$(Screen(y2, x2))
            End If
        Next
    End If
End Sub

Function timeElapsedSince! (startTime!)
    If startTime! > Timer Then startTime! = startTime! - 86400
    timeElapsedSince! = Timer - startTime!
End Function

