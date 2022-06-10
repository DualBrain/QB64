'Maze of Misery
'By Steve M. (c),May 5,01
'****************

'Please visit my web page at:  www.angelfire.com/bc2/cuebasic/qpage.html
'
'Disclaimer: This program may not be distributed, modified or copied without
'written permission from the author at yochatwitme@yahoo.com.
'Not liable for system or hardware damage. Tho' I can assure you that you
'won't experience any problems. Email me at yochatwitme@yahoo.com about
'any concerns or difficulties you may be having.
'Finally, you have my permission to post the program on your web page.
'Hope you enjoy the game.
'
'Thanks. SM :)
'Gbgames Chatname: QB4ever

$NoPrefix
$Resize:Smooth

Const FALSE = 0, TRUE = Not FALSE

'CLEAR 2000, 2000
Dim T$(150), Wall%(1 To 300), Wall2%(1 To 300), Wall3%(1 To 300)
Dim Shared Player%(1 To 300), Maze$(768), Object$(20), Door%(1 To 300)
Dim EDoor%(1 To 300), Keylock%(1 To 300), Clrobject%(1 To 300)
'Dim Gold%(1 To 300)
Dim Treasure%(1 To 300), Diamond%(1 To 300)
'Dim Enemy%(1 To 300)
Dim Diamond2%(1 To 300), Gem%(1 To 300)
'Dim Enemydotpos(16)
Dim Spider%(1 To 300), Spider2%(1 To 300)
Dim Spike%(1 To 300), Spikemask%(1 To 300), Wallmask%(1 To 300)
Dim Web%(1 To 300), Wcs(64, 1), Keyfl(64), Clrkey(64)
Dim Spiderfr2%(1 To 300), Spiderpfr2%(1 To 300), Playerdeath%(1 To 300)
'Dim Shared Reptxt%(1 To 3000)

Start:
X = 154: Y = 40: MatrixY = 14: MatrixX = 6: Lives = 5: Health = 9000
En = 1: Dx = -30: Lx = -1: Dy = 1: SpacerX = 0: SpacerY = 0: EVL = 11
CIX1 = 275: CIY1 = 145: CIY2 = 90: Rm = 2: Web = 20: Glow = 1: Adv = 0
M2 = -1: V2x = 1: G = 1
Health$ = "Good": M1$ = "Mazes of Misery": Time$ = "00:00:00"
T$ = Chr$(0) + Chr$(63) + Chr$(48) + Chr$(48) + Chr$(60) + Chr$(48) + Chr$(48) + Chr$(48) + Chr$(0)
Restore Wallcols: For A = 1 To 64: Read Wcs(A, 0): Next
Restore Wallbord: For A = 1 To 64: Read Wcs(A, 1): Next

BegindotMaze:

'Setup array picture images

Screen 12
FullScreen SquarePixels , Smooth

Randomize Timer
GoSub Copydotwall: GoSub Cleardotplayer
GoSub Copydotwall2: GoSub Cleardotplayer
GoSub Copydotwall3: GoSub Cleardotplayer
GoSub CopydotPlayer: GoSub Cleardotplayer
GoSub CopydotCleardotObject 'This array clears the current image
GoSub CopydotDoor: GoSub Cleardotplayer
GoSub CopydotKeylock: GoSub Cleardotplayer
GoSub CopydotTreasure: GoSub Cleardotplayer
GoSub CopydotRing: GoSub Cleardotplayer
GoSub CopydotRing2: GoSub Cleardotplayer
GoSub CopydotGem: GoSub Cleardotplayer
GoSub CopydotSpider: GoSub Cleardotplayer
GoSub CopydotSpider2: GoSub Cleardotplayer
GoSub CopydotWeb: GoSub Cleardotplayer
GoSub CopydotSpike: GoSub Cleardotplayer
SpacerX = 0: SpacerY = 0: GoSub Titledotscr
Begin:
frm = 1: Screen 12: Cls: GoSub Builddotmazes
SpacerX = 0: SpacerY = 0: GoSub RoomdotCheck: GoSub Gamedotstatus
r = StartdotA: SpacerX = 0: SpacerY = 0

Kyboard:
Do: Loop While Timer = oldtimer!
oldtimer! = Timer
For i = 1 To 100
    GoSub Scandotmaze
Next
T$ = Mid$(Maze$(MatrixY), MatrixX, 1)
If T$ = "L" And (CT >= 1 And CT <= 20) Then GoSub Shocked
i$ = InKey$: If i$ = "" Then GoTo Kyboard

Oldx = X: Oldy = Y: Matrixydotold = MatrixY: Matrixxdotold = MatrixX
If Kytapfl < 1 Then
    If i$ = Chr$(0) + "M" Then GoSub Cleardotman: X = X + 30: MatrixX = MatrixX + 1: If X > 574 Then X = 4: Rm = Rm + 8: MatrixY = MatrixY + 96: MatrixX = 1: GoSub RoomdotCheck
    If i$ = Chr$(0) + "K" Then GoSub Cleardotman: X = X - 30: MatrixX = MatrixX - 1: If X < 4 Then X = 574: Rm = Rm - 8: MatrixY = MatrixY - 96: MatrixX = 20: GoSub RoomdotCheck
    If i$ = Chr$(0) + "H" Then GoSub Cleardotman: Y = Y - 36: MatrixY = MatrixY - 1: If Y < 4 Then Rm = Rm - 1: GoSub RoomdotCheck
    If i$ = Chr$(0) + "P" Then GoSub Cleardotman: Y = Y + 36: MatrixY = MatrixY + 1: If Y > 400 Then Rm = Rm + 1: GoSub RoomdotCheck
Else
    If i$ = "6" Then GoSub Cleardotman: X = X + 30: MatrixX = MatrixX + 1: If X > 574 Then X = 4: Rm = Rm + 8: MatrixY = MatrixY + 96: MatrixX = 1: GoSub RoomdotCheck
    If i$ = "4" Then GoSub Cleardotman: X = X - 30: MatrixX = MatrixX - 1: If X < 4 Then X = 574: Rm = Rm - 8: MatrixY = MatrixY - 96: MatrixX = 20: GoSub RoomdotCheck
    If i$ = "8" Then GoSub Cleardotman: Y = Y - 36: MatrixY = MatrixY - 1: If Y < 4 Then Rm = Rm - 1: GoSub RoomdotCheck
    If i$ = "2" Then GoSub Cleardotman: Y = Y + 36: MatrixY = MatrixY + 1: If Y > 400 Then Rm = Rm + 1: GoSub RoomdotCheck
End If
If i$ = Chr$(27) Then i$ = "": GoSub Menulist
T$ = Mid$(Maze$(MatrixY), MatrixX, 1)
If T$ = "#" Or T$ = "@" Or T$ = "%" Or T$ = "W" Then GoSub Recalldotolddotposition
If T$ = "B" And M > 11 Then GoSub Spiderdotbite
If T$ = "L" And (CT >= 1 And CT <= 20) Then GoSub Shocked
If T$ = "k" Then GoSub Keyfound
If T$ = "E" Then GoTo Escaped
If T$ = "D" Then Sx = X: Sy = Y: Svsx = Sx: Svsy = Sy: SMy = MatrixY: SMx = MatrixX: GoSub Recalldotolddotposition: GoSub Doordotroutine
If T$ = "t" Then GoSub Treasuredotroutine
If T$ = "g" Then GoSub Gemdotroutine
If T$ = "r" Then GoSub Ringdotroutine
If Flg Then GmdotTmr = Timer: DelTim = CPU * 15 + Sqr(2 / 2 + GmdotTmr + .6) + 800: For LL = 1 To DelTim: Next
If frm > 100 Then frm = 1
GoSub Displaydotman
GoTo Kyboard

Scandotmaze:
B = B + 1
T$ = Mid$(Maze$(r), B, 1): SPK$ = Mid$(Maze$(r), B, 1)
GoSub SkipdotX: Cnt = Cnt + 1
If T$ = "B" Or T$ = "S" Then Spx = SpacerX: Spy = SpacerY: GoSub Spiderdotroutine
If T$ = "L" Then Lex = SpacerX: Ley = SpacerY: GoSub Electricdotroutine
If T$ = "r" Then RingdotX = SpacerX: RingdotY = SpacerY + 6: GoSub Ringdotglow
If SPK$ = "s" Then SpikeX = SpacerX: SpikeY = SpacerY + 6: GoSub SpikedotMoving
If B < 20 Then Return
B = 1: SpacerX = 0: SpacerY = SpacerY + 36
If r < FinishdotA Then r = r + 1: Return
r = StartdotA: SpacerX = 0: SpacerY = 0
Return

SkipdotX:
SpacerX = SpacerX + 30
Return
 
Spiderdotroutine:
frm = frm + 1
If (T$ = "S") Then Poisondotspider = 1
T$ = Mid$(Maze$(MatrixY), MatrixX, 1)
If Demo Then T$ = Mid$(A$(Dmx), Dmy, 1)
If (T$ = "B" Or T$ = "S") And M > 11 Then GoSub Spiderdotbite
If T$ = "s" And M2 < 8 Then GoSub Spikedotstabb
M = M + Vx: If M > 31 Then Vx = -1
GoSub Showdotspider
If M < 1 Then Vx = 1
Line (Spx + 12, (Spy - Web))-(Spx + 12, (Spy - 10) + M), 8, BF
For H = 1 To 800 - Adv + DelTim: Next
Return

SpikedotMoving:
SPK$ = Mid$(Maze$(r), B, 1)
M2 = M2 + V2x: If M2 > 25 Then V2x = -1
If M2 < 1 Then V2x = 1
If Wm < 1 Then Get (SpikeX, SpikeY + 36)-(SpikeX + 26, SpikeY + 71), Spikemask%(): Wm = 1
Put (SpikeX, (SpikeY) + 11 + M2), Spike%(), PSet
If Wm2 < 1 Then Get (SpikeX, SpikeY + 5 + M2)-(SpikeX + 18, SpikeY + 36 + M2), Wallmask%(): Wm2 = 1
If T$ = "s" Then GoSub Displaydotman
Put (SpikeX, SpikeY + 5 + M2), Wallmask%(), And 'spike mask
Put (SpikeX, SpikeY + 36), Spikemask%(), PSet 'wall mask
Return

Showdotspider:
If Poisondotspider Then
    If Int(frm / 2) = frm / 2 Then
        Put (Spx - 1, (Spy - 30) + 10 + M), Spiderpfr2%(), PSet: Poisondotspider = 0: Return
    Else
        Put (Spx - 1, (Spy - 30) + 10 + M), Spider2%(), PSet: Poisondotspider = 0: Return
    End If

Else
    If Int(frm / 4) = frm / 4 Then
        Put (Spx - 1, (Spy - 30) + 10 + M), Spiderfr2%(), PSet: Return
    Else
        Put (Spx - 1, (Spy - 30) + 10 + M), Spider%(), PSet
    End If
End If
Return

Showdotspike:
Put (SpikeX, SpikeY + M2), Spike%(), PSet
Return

Electricdotroutine:
CT = CT + 1: If CT >= 1 And CT <= 20 Then GoTo EStart
If CT > 50 Then CT = 1
Return

EStart:
Randomize Timer
If G < 1 Then Gv = 1
G = G + Gv: If G > 5 Then Gv = -1
E1 = Rnd(6 * Rnd(0)): E2 = Rnd(6 * Rnd(0)): E3 = Fix(Rnd(6 * Rnd(0)))
E4 = Fix(6 * Rnd(0)): E5 = Fix(6 * Rnd(0)): E6 = Fix(Rnd(6 * Rnd(0)))
E7 = Fix(6 * Rnd(0)): E8 = Fix(6 * Rnd(0)): E9 = Fix(Rnd(6 * Rnd(0)))
Line (Lex + E1, Ley + 4)-(Lex + E2 * (G + 3), Ley + 9), 14
Line -(Lex + E3 + Sgn(G + 3), Ley + 15), 14
Line -(Lex + E4 * (G + 3), Ley + 20), 14
Line -(Lex + E5 + Sgn(G + 3), Ley + 26), 14
Line -(Lex + E6 * (G + 3), Ley + 32), 14
Line -(Lex + E7 + Sgn(G + 3), Ley + 38), 14
For H = 1 To 150 - Adv / 4: Next
Sx = SpacerX + 2: Sy = SpacerY + 4: GoSub Cleardotarea
Return

Spiderdotbite:
GoSub Displaydotman: M$ = "Yow! I've been bitten!": PS = 40 - Len(M$) / 2
Locate 30, PS: Print M$;: GoSub Hold: GoSub Clearline
Put (X, Y), Playerdeath%(), PSet: Sleep 1: Put (X, Y), Clrobject%(), PSet
Health = Health - Abs(75 * (T$ = "S") - 55)
If Health < 1 Then Locate 30, PS + 4: Print "You died!";: Sleep 2: GoSub Clearline: GoTo Fin
GoSub Gamedotstatus
Return

Spikedotstabb:
GoSub Displaydotman: M$ = "Yarrgghh! I've been sheared!": PS = 40 - Len(M$) / 2
Locate 30, PS: Print M$;: GoSub Hold: GoSub Clearline
Put (X, Y), Playerdeath%(), PSet: Sleep 1: Put (X, Y), Clrobject%(), PSet
Health = Health - Abs(75 * (T$ = "S") - 55)
If Health < 1 Then Locate 30, PS + 4: Print "You died!";: Sleep 2: GoSub Clearline: GoTo Fin
GoSub Gamedotstatus
Return

Shocked:
GoSub Displaydotman: M$ = "Arrggghh! I've been shocked!": PS = 40 - Len(M$) / 2
Locate 30, PS: Print M$;: GoSub Hold: GoSub Clearline
Put (X, Y), Playerdeath%(), PSet: Sleep 1: Put (X, Y), Clrobject%(), PSet
Health = Health - 25
If Health < 1 Then Locate 30, 30: Print "You died!";: Sleep 2: GoSub Clearline: GoTo Fin
GoSub Gamedotstatus
Return

Treasuredotroutine:
GoSub Replacedotchar: GoSub Openeddotchest
Return

Ringdotroutine:
Locate 30, 20: Print "You have found a diamond ring!";: GoSub Displaydotman
Sleep 2: GoSub Replacedotchar: GoSub Clearline: GoSub Cleardotarea
Fortune = 200: GoSub Tallydotpnts: GoSub Gamedotstatus
Return

Gemdotroutine:
Locate 30, 20: Print "You have found a valuable gem!!";: GoSub Displaydotman
Sleep 2: GoSub Replacedotchar: GoSub Clearline: GoSub Cleardotarea
Fortune = 400: GoSub Tallydotpnts: GoSub Gamedotstatus
Return

Ringdotglow:
If Glow Then Put (RingdotX, RingdotY), Diamond2%(), PSet: Glow = 0
If Right$(Time$, 2) < "01" Then Return
Glow = 1
If Glow Then Put (RingdotX, RingdotY), Diamond%(), PSet: Glow = 0
If Right$(Time$, 2) < "02" Then Return
Time$ = "00:00:00": Glow = 1
Return

Replacedotchar:
If T$ = "D" Then Sx = Svsx: Sy = Svsy: GoSub Cleardotarea
Showy = SMy: Showx = SMx
Sx = X: Sy = Y: SMy = MatrixY: SMx = MatrixX
If (T$ <> "r" And T$ <> "g") Then GoSub Recalldotolddotposition: GoSub Displaydotman
If T$ = "D" Then SMy = Showy: SMx = Showx
Mid$(Maze$(SMy), SMx, 1) = Chr$(32)
Return
 
Displaydotman:
Put (X, Y), Player%(), PSet: Return

Recalldotolddotposition:
X = Oldx: Y = Oldy: For A = 1 To 64
    Barrier = 1 * (T$ = "D" And Unl And Rm = A And Keyfl(Rm))
    If Barrier Then A = 1: Return
Next

Oldpl:
MatrixX = Matrixxdotold: MatrixY = Matrixydotold
Return

Keyfound:
For A = 1 To 64
    Keyfl(Rm) = Abs(1 * (Rm = A)): Unl = 1
    If Keyfl(Rm) And Unl Then A = 1: GoTo Keymes
Next
  
Keymes:
Color 15: Locate 30, 9: Print "You have found the key. ";
Print "Use it to unlock the door in this room.";:
GoSub Replacedotchar: GoSub Cleardotarea
Sleep 3: GoSub Clearline: Keys = Keys + 1: GoSub Gamedotstatus: Return

Doordotroutine:
For A = 1 To 64
    Kyfd = 1 * (Rm = A And Keyfl(Rm)): If Kyfd Then A = 1: GoTo Available
Next: Return

Available:
For A = 1 To 64
    Clrkey = 1 * (Rm = A And Keyfl(Rm)): If Clrkey > 0 Then Keyfl(Rm) = 0: A = 1: GoTo DOpen
Next

DOpen:
GoSub Displaydotman
Locate 30, 20: Print "Good Job! You have opened the door.";: Sleep 3:
GoSub Clearline: GoSub Replacedotchar: Unl = 0
Keys = Keys - 1: GoSub Gamedotstatus
Return

Openeddotchest:
Color 14: Tr = 1: Locate 29, 1: Print Space$(79);
Locate 30, 20: Print "You have found a treasure chest!";
Sleep 2: GoSub Clearline
Randomize Timer: Length = Fix(16 * Rnd(1)) + 1: Restore Makedotobj
N = Fix(50 * Rnd(1)) + 2
For T = 1 To Length: Read Object$(T): Next
L = Len(Object$(Length)): O$ = Mid$(Object$(Length), 3, L)
If Left$(O$, 2) = "No" Or Left$(O$, 3) = "Wat" Then
    Message$ = ""
Else
    Message$ = "a "
End If

Locate 30, 20: Print "It contains "; Message$; ""; O$; Space$(2); addon$;
Sleep 2: GoSub ObjectdotProperties: Message$ = "": addon$ = ""
O$ = "": Message$ = O$
If LO$ = "~" Then GoSub Clearline: Locate 30, 20: Print "There are " + Str$(N) + " of them.";: Sleep 2
GoSub Gamedotstatus: Tr = 0: addon$ = "": GoSub Clearline: GoSub Cleardotarea
Return

Clearline:
Locate 30, 1: Print Space$(79);: Return

Hold:
H$ = InKey$: If H$ = "" Then GoTo Hold
Return

Escaped:
Color 15
Line (110, 190)-(510, 255), 10, BF: Line (115, 200)-(500, 245), 14, BF
Line (115, 200)-(500, 245), 1, B
Locate 14, 25: Print "Congratulations Adventurer!"
Locate 15, 19: Print "You have escaped from this maze for now.": Sleep 4: System

'CopydotPlayer:
Line (CIX1 + 15, CIY1 + 23)-(CIX1 + 37, CIY1 + 45), 0, BF
Circle (CIX1 + 28, CIY1 + 35), 10, 15: Paint (CIX1 + 28, CIY1 + 35), 15
Circle (CIX1 + 28, CIY1 + 35), 10, 6: Circle (CIX1 + 28, CIY1 + 35), 9, 6
For E = 1 To 5: Circle (CIX1 + 28, CIY1 + 35), E, 0: Next
Circle (CIX1 + 28, CIY1 + 35), 1, 0
Get (CIX1 + 15, CIY1 + 23)-(CIX1 + 37, CIY1 + 45), Player%()
Return

CopydotPlayer:
X1 = 20: Y1 = 40: c = 1
Circle (X1, Y1), 9, 6: Paint (X1, Y1), 6: Circle (X1, Y1), 10, 4 'Body
Circle (X1 - 5, Y1 - 5), 3, 15: Paint (X1 - 5, Y1 - 5), 15 'left eye
Circle (X1 - 5, Y1 - 5), 3, c, -6.28, -3.14: Paint (X1 - 5, Y1 - 6), c
Circle (X1 - 5, Y1 - 5), 1, 0: Paint (X1 - 5, Y1 - 5), 0 'outline
Circle (X1 + 5, Y1 - 5), 3, 15: Paint (X1 + 5, Y1 - 5), 15 'right eye
Circle (X1 + 5, Y1 - 5), 3, c, -6.28, -3.14: Paint (X1 + 5, Y1 - 6), c
Circle (X1 + 5, Y1 - 5), 1, 0: Paint (X1 + 5, Y1 - 5), 0
Circle (X1, Y1), 2, 4: Paint (X1, Y1), 4: Circle (X1, Y1), 3, 1 'nose
Line (X1 - 2, Y1 + 5)-(X1 + 2, Y1 + 5), 5 'mouth(top)
Line (X1 - 1, Y1 + 6)-(X1 + 1, Y1 + 6), 5 'mouth(bottom)
Get (X1 - 10, Y1 - 10)-(X1 + 10, Y1 + 10), Player%()
GoSub CopydotPlayerdeath
Return

CopydotPlayerdeath:
X1 = 20: Y1 = 40: c = 4
Circle (X1, Y1), 9, 6: Paint (X1, Y1), 6: Circle (X1, Y1), 10, 4 'Body
Circle (X1 - 5, Y1 - 5), 5, 15: Paint (X1 - 5, Y1 - 5), 15 'left eye
Circle (X1 - 5, Y1 - 5), 1, 0: Paint (X1 - 5, Y1 - 5), 0 'outline
Circle (X1 + 5, Y1 - 5), 5, 15: Paint (X1 + 5, Y1 - 5), 15 'right eye
Circle (X1 + 5, Y1 - 5), 1, 0: Paint (X1 + 5, Y1 - 5), 0
Circle (X1, Y1), 2, 4: Paint (X1, Y1), 4: Circle (X1, Y1), 3, 1 'nose
Line (X1 - 2, Y1 + 5)-(X1 + 2, Y1 + 5), 5 'mouth(top)
Line (X1 - 1, Y1 + 6)-(X1 + 1, Y1 + 6), 5 'mouth(bottom)
Circle (X1, Y1 + 6), 2, c, , , .32: Paint (X1, Y1 + 6), c
Circle (X1, Y1 + 6), 3, 1, , , .32
Get (X1 - 10, Y1 - 10)-(X1 + 10, Y1 + 10), Playerdeath%()
Return

Copydotwall:
Line (CIX1 + 11, CIY1 + 21)-(CIX1 + 34, CIY1 + 50), Wcs(Rm, 0), BF
Line (CIX1 + 12, CIY1 + 20)-(CIX1 + 35, CIY1 + 51), Wcs(Rm, 1), B
Line (CIX1 + 36, CIY1 + 20)-(CIX1 + 36, CIY1 + 50), 10
For A = CIX1 + 12 To CIX1 + 34 Step 2: Line (A, CIY1 + 21)-(A, CIY1 + 50), 6
Next: Line (CIX1 + 11, CIY1 + 50)-(CIX1 + 34, CIY1 + 50), 1
Line (CIX1 + 11, CIY1 + 21)-(CIX1 + 11, CIY1 + 50), 8
'FOR A = CIY1 + 11 TO CIY1 + 50 STEP 2: LINE (CIX1 + 11, A)-(CIX1 + 35, A), 5: NEXT
Get (CIX1 + 11, CIY1 + 19)-(CIX1 + 36, CIY1 + 51), Wall%()
Return

Copydotwall2:
Line (CIX1 + 11, CIY1 + 20)-(CIX1 + 34, CIY1 + 50), Wcs(Rm, 0), BF
Line (CIX1 + 12, CIY1 + 19)-(CIX1 + 35, CIY1 + 51), Wcs(Rm, 1), B
Line (CIX1 + 36, CIY1 + 19)-(CIX1 + 36, CIY1 + 50), 10
For A = 0 To 41 Step 2
Line (CIX1 + 11, CIY1 + 20 + A)-(CIX1 + 33, CIY1 + A), 1: Next
Get (CIX1 + 11, CIY1 + 19)-(CIX1 + 42, CIY1 + 51), Wall2%()
Return

Copydotwall3:
WX = 26: WY = 32
Line (100, 75)-(100 + WX, 75 + WY), , B
T$ = T$ + Chr$(200) + Chr$(130) + Chr$(146) + Chr$(48) + Chr$(8) + Chr$(2) + Chr$(144) + Chr$(152) + Chr$(2)
Paint (102, 76), T$
Line (100, 75)-(100 + WX, 75 + WY), 4, B
Get (100, 75)-(100 + WX, 75 + WY), Wall3%()
Return

CopydotCleardotObject:
Line (CIX1 + 16, CIY1 + 50)-(CIX1 + 60, CIY1 + 80), 0, BF
Get (265, CIY1 + 20)-(290, CIY1 + 54), Clrobject%()
Return

CopydotDoor:
Line (CIX1 + 11, CIY1 + 20)-(CIX1 + 36, CIY1 + 52), 6, BF
Line (CIX1 + 13, CIY1 + 22)-(CIX1 + 33, CIY1 + 31), 12, BF
Line (CIX1 + 13, CIY1 + 40)-(CIX1 + 33, CIY1 + 48), 12, BF
Line (CIX1 + 13, CIY1 + 22)-(CIX1 + 33, CIY1 + 31), 0, B
Line (CIX1 + 13, CIY1 + 40)-(CIX1 + 33, CIY1 + 48), 0, B
Line (CIX1 + 10, CIY1 + 19)-(CIX1 + 37, CIY1 + 53), 1, B
Line (CIX1 + 37, CIY1 + 20)-(CIX1 + 37, CIY1 + 52), 12
Circle (CIX1 + 34, CIY1 + 36), 2, 14: Paint (CIX1 + 34, CIY1 + 36), 14
Circle (CIX1 + 34, CIY1 + 36), 2, 0
Get (CIX1 + 11, CIY1 + 20)-(CIX1 + 40, CIY1 + 53), Door%()
GoSub CopydotEDoor
Return

CopydotEDoor:
Line (CIX1 + 11, CIY1 + 20)-(CIX1 + 36, CIY1 + 52), 13, BF
Line (CIX1 + 13, CIY1 + 22)-(CIX1 + 33, CIY1 + 31), 2, BF
Line (CIX1 + 13, CIY1 + 40)-(CIX1 + 33, CIY1 + 48), 2, BF
Line (CIX1 + 13, CIY1 + 22)-(CIX1 + 33, CIY1 + 31), 0, B
Line (CIX1 + 13, CIY1 + 40)-(CIX1 + 33, CIY1 + 48), 0, B
Line (CIX1 + 10, CIY1 + 19)-(CIX1 + 37, CIY1 + 53), 1, B
Line (CIX1 + 37, CIY1 + 20)-(CIX1 + 37, CIY1 + 52), 12
Circle (CIX1 + 34, CIY1 + 36), 2, 14: Paint (CIX1 + 34, CIY1 + 36), 14
Circle (CIX1 + 34, CIY1 + 36), 2, 0
Get (CIX1 + 11, CIY1 + 20)-(CIX1 + 40, CIY1 + 53), EDoor%()
Return

CopydotKeylock:
Circle (CIX1 + 24, CIY1 + 35), 4, 7
Circle (CIX1 + 27, CIY1 + 40), 4, 7
Color 4: Line (CIX1 + 26, CIY1 + 39)-(CIX1 + 44, CIY1 + 21)
Line (CIX1 + 26, CIY1 + 40)-(CIX1 + 44, CIY1 + 22)
Color 6: Line (CIX1 + 34, CIY1 + 20)-(CIX1 + 39, CIY1 + 28)
Line (CIX1 + 35, CIY1 + 20)-(CIX1 + 40, CIY1 + 28)
Line (CIX1 + 35, CIY1 + 32)-(CIX1 + 31, CIY1 + 27)
Get (CIX1 + 15, CIY1 + 16)-(CIX1 + 39, CIY1 + 47), Keylock%()
Return

CopydotTreasure:
Line (CIX1 + 16, CIY1 + 65)-(CIX1 + 35, CIY1 + 80), 14, B
Line -(CIX1 + 40, CIY1 + 75), 14: Line -(CIX1 + 40, CIY1 + 60), 14
Line -(CIX1 + 35, CIY1 + 65), 14
Line (CIX1 + 16, CIY1 + 65)-(CIX1 + 21, CIY1 + 60), 14
Line -(CIX1 + 40, CIY1 + 60), 14
Line (CIX1 + 17, CIY1 + 66)-(CIX1 + 34, CIY1 + 79), 6, BF
Paint (CIX1 + 38, CIY1 + 68), 14
Line (CIX1 + 22, CIY1 + 60)-(CIX1 + 40, CIY1), 6, BF
Line (CIX1 + 40, CIY1 + 60)-(CIX1 + 40, CIY1), 12
Line (CIX1 + 22, CIY1 + 50)-(CIX1 + 40, CIY1 + 50), 12
Get (CIX1 + 16, CIY1 + 50)-(CIX1 + 40, CIY1 + 80), Treasure%()
Return

CopydotRing:
Circle (CIX1 + 28, CIY1 + 35), 5, 15: Circle (CIX1 + 28, CIY1 + 35), 6, 8
Circle (CIX1 + 28, CIY1 + 26), 3, 1: Paint (CIX1 + 28, CIY1 + 26), 13, 1
Line (CIX1 + 26, CIY1 + 24)-(CIX1 + 30, CIY1 + 24), 11
Circle (CIX1 + 28, CIY1 + 26), 2, 1: Circle (CIX1 + 28, CIY1 + 35), 4, 9
Get (CIX1 + 15, CIY1 + 20)-(CIX1 + 38, CIY1 + 45), Diamond%()
Return

CopydotRing2:
Circle (CIX1 + 28, CIY1 + 35), 5, 15: Circle (CIX1 + 28, CIY1 + 35), 6, 8
Circle (CIX1 + 28, CIY1 + 26), 3, 12: Paint (CIX1 + 28, CIY1 + 26), 13, 12
Line (CIX1 + 26, CIY1 + 24)-(CIX1 + 30, CIY1 + 24), 14
Circle (CIX1 + 28, CIY1 + 26), 2, 1: Circle (CIX1 + 28, CIY1 + 35), 4, 9
Get (CIX1 + 15, CIY1 + 20)-(CIX1 + 38, CIY1 + 47), Diamond2%()
Return

CopydotGem:
Circle (CIX1 + 28, CIY1 + 35), 5, 10: 'CIRCLE (CIX1 + 28, CIY1 + 35), 10, 8
Circle (CIX1 + 28, CIY1 + 26), 2: Paint (CIX1 + 28, CIY1 + 26), T$
Line (CIX1 + 26, CIY1 + 24)-(CIX1 + 30, CIY1 + 24), 1
Circle (CIX1 + 28, CIY1 + 35), 4, 9
Get (CIX1 + 15, CIY1 + 20)-(CIX1 + 38, CIY1 + 45), Gem%()
Return

CopydotSpider:
Circle (CIX1 + 28, CIY1 + 27), 3, 8: Paint (CIX1 + 28, CIY1 + 27), 8
Circle (CIX1 + 28, CIY1 + 20), 6, 8: Paint (CIX1 + 28, CIY1 + 20), 8
Circle (CIX1 + 28, CIY1 + 25), 6, 0
Line (CIX1 + 24, CIY1 + 25)-(CIX1 + 19, CIY1 + 30), 7: Line -(CIX1 + 22, CIY1 + 33), 7
Line (CIX1 + 32, CIY1 + 25)-(CIX1 + 37, CIY1 + 30), 7: Line -(CIX1 + 34, CIY1 + 33), 7
Line (CIX1 + 23, CIY1 + 22)-(CIX1 + 20, CIY1 + 25), 7
Line (CIX1 + 23, CIY1 + 16)-(CIX1 + 18, CIY1 + 21), 7
Line -(CIX1 + 18, CIY1 + 23), 7
Line (CIX1 + 33, CIY1 + 22)-(CIX1 + 36, CIY1 + 25), 7
Line (CIX1 + 33, CIY1 + 16)-(CIX1 + 38, CIY1 + 21), 7
Line -(CIX1 + 38, CIY1 + 23), 7
Line (CIX1 + 27, CIY1 + 29)-(CIX1 + 27, CIY1 + 31), 4
Line (CIX1 + 30, CIY1 + 29)-(CIX1 + 30, CIY1 + 31), 4
Get (CIX1 + 15, CIY1 + 10)-(CIX1 + 42, CIY1 + 40), Spider%()
GoSub CopydotSpiderfr2
Return

CopydotSpiderfr2:
Cls
Circle (CIX1 + 28, CIY1 + 27), 5, 8: Paint (CIX1 + 28, CIY1 + 27), 8
Circle (CIX1 + 28, CIY1 + 20), 6, 8: Paint (CIX1 + 28, CIY1 + 20), 8
Circle (CIX1 + 28, CIY1 + 25), 6, 0
Line (CIX1 + 24, CIY1 + 25)-(CIX1 + 19, CIY1 + 20), 7: Line -(CIX1 + 17, CIY1 + 24), 7
Line (CIX1 + 32, CIY1 + 25)-(CIX1 + 37, CIY1 + 20), 7: Line -(CIX1 + 40, CIY1 + 25), 7
Line (CIX1 + 24, CIY1 + 25)-(CIX1 + 22, CIY1 + 30), 7: Line -(CIX1 + 24, CIY1 + 33), 7
Line (CIX1 + 32, CIY1 + 25)-(CIX1 + 34, CIY1 + 30), 7: Line -(CIX1 + 32, CIY1 + 33), 7
Line (CIX1 + 27, CIY1 + 29)-(CIX1 + 27, CIY1 + 31), 4
Line (CIX1 + 30, CIY1 + 29)-(CIX1 + 30, CIY1 + 31), 4
Get (CIX1 + 14, CIY1 + 10)-(CIX1 + 44, CIY1 + 40), Spiderfr2%()
Return

CopydotSpider2:
Circle (CIX1 + 28, CIY1 + 27), 3, 10: Paint (CIX1 + 28, CIY1 + 27), 10
Circle (CIX1 + 28, CIY1 + 20), 6, 10: Paint (CIX1 + 28, CIY1 + 20), 10
Circle (CIX1 + 28, CIY1 + 25), 6, 0
Line (CIX1 + 24, CIY1 + 25)-(CIX1 + 19, CIY1 + 30), 7: Line -(CIX1 + 22, CIY1 + 33), 7
Line (CIX1 + 32, CIY1 + 25)-(CIX1 + 37, CIY1 + 30), 7: Line -(CIX1 + 34, CIY1 + 33), 7
Line (CIX1 + 23, CIY1 + 22)-(CIX1 + 20, CIY1 + 25), 7
Line (CIX1 + 33, CIY1 + 22)-(CIX1 + 36, CIY1 + 25), 7
Line (CIX1 + 23, CIY1 + 22)-(CIX1 + 20, CIY1 + 25), 7
Line (CIX1 + 23, CIY1 + 16)-(CIX1 + 18, CIY1 + 21), 7
Line -(CIX1 + 18, CIY1 + 23), 7
Line (CIX1 + 33, CIY1 + 22)-(CIX1 + 36, CIY1 + 25), 7
Line (CIX1 + 33, CIY1 + 16)-(CIX1 + 38, CIY1 + 21), 7
Line -(CIX1 + 38, CIY1 + 23), 7
Line (CIX1 + 27, CIY1 + 29)-(CIX1 + 27, CIY1 + 31), 4
Line (CIX1 + 30, CIY1 + 29)-(CIX1 + 30, CIY1 + 31), 4
Get (CIX1 + 15, CIY1 + 10)-(CIX1 + 43, CIY1 + 40), Spider2%()
GoSub CopydotSpiderpfr2
Return

CopydotSpiderpfr2:
Cls
Circle (CIX1 + 28, CIY1 + 27), 3, 10: Paint (CIX1 + 28, CIY1 + 27), 10
Circle (CIX1 + 28, CIY1 + 20), 6, 10: Paint (CIX1 + 28, CIY1 + 20), 10
Circle (CIX1 + 28, CIY1 + 25), 6, 0
Line (CIX1 + 24, CIY1 + 25)-(CIX1 + 19, CIY1 + 20), 7: Line -(CIX1 + 17, CIY1 + 24), 7
Line (CIX1 + 32, CIY1 + 25)-(CIX1 + 37, CIY1 + 20), 7: Line -(CIX1 + 40, CIY1 + 25), 7
Line (CIX1 + 23, CIY1 + 22)-(CIX1 + 20, CIY1 + 25), 7
Line (CIX1 + 33, CIY1 + 22)-(CIX1 + 36, CIY1 + 25), 7
Line (CIX1 + 23, CIY1 + 22)-(CIX1 + 20, CIY1 + 25), 7
Line (CIX1 + 23, CIY1 + 16)-(CIX1 + 18, CIY1 + 21), 7
Line (CIX1 + 24, CIY1 + 25)-(CIX1 + 23, CIY1 + 30), 7
Line (CIX1 + 32, CIY1 + 25)-(CIX1 + 34, CIY1 + 30), 7
Line (CIX1 + 33, CIY1 + 16)-(CIX1 + 38, CIY1 + 21), 7
Line (CIX1 + 27, CIY1 + 29)-(CIX1 + 27, CIY1 + 31), 4
Line (CIX1 + 30, CIY1 + 29)-(CIX1 + 30, CIY1 + 31), 4
Get (CIX1 + 15, CIY1 + 10)-(CIX1 + 42, CIY1 + 40), Spiderpfr2%()
Return

CopydotWeb:
T$ = Chr$(200) + Chr$(130) + Chr$(146) + Chr$(48) + Chr$(8) + Chr$(2) + Chr$(144) + Chr$(152) + Chr$(2)
Line (CIX1 + 8, CIY1 + 15)-(CIX1 + 35, CIY1 + 25), 1, B
Paint (CIX1 + 8, CIY1 + 15), T$
Line (CIX1 + 31, CIY1 + 15)-(CIX1 + 35, CIY1 + 30), 8
Get (CIX1 + 8, CIY1 + 15)-(CIX1 + 36, CIY1 + 25), Web%()
Return

CopydotSpike:
X1 = 10: Y1 = 15: Cls
Line (X1, Y1)-(X1 + 5, Y1 - 10), 7: Line -(X1 + 10, Y1), 7
Line -(X1, Y1), 7: Paint (X1 + 5, Y1 - 5), 7
Line (X1 - 1, Y1)-(X1 + 4, Y1 - 10), 14
Line (X1 - 1, Y1 + 1)-(X1 + 10, Y1 + 12), 7, BF
Line (X1 - 1, Y1 + 1)-(X1 - 1, Y1 + 12), 14, BF
Circle (X1 + 12, Y1 + 6), 5, 0: Paint (X1 + 10, Y1 + 6), 0
Line (X1 + 5, Y1 - 11)-(X1 + 5, Y1 - 10), 14, BF
Get (X1 - 5, Y1 - 12)-(X1 + 12, Y1 + 12), Spike%()
Return

ObjectdotProperties:
LO$ = Mid$(Object$(Length), 1, 1): HL = InStr(Object$(Length), "@")
If LO$ = "!" Then Health = Health + 25: Ob = Ob + 1
If LO$ = "$" Then Fortune = Fortune + 20
If LO$ = "%" Then Health = Health + 200 + (200 * (HL = 64))
GoSub Gamedotstatus: Objects = Objects + Ob: Ob = 0
Tallydotpnts:
Score = Score + Fortune: Fortune = 0
Return

Cleardotobject:
Put (Sx, Sy), Clrobject%(), PSet: Return

Cleardotplayer:
Line (265, 145)-(345, 215), 0, BF
Return

Cleardotman:
Put (X, Y), Clrobject%(), PSet: Return

Cleardotarea:
Line (Sx - 4, Sy)-(Sx + 23, Sy + 35), 0, BF
Return

Placedotwall:
If T$ = "@" Then Put (1 + SpacerX, 6 + SpacerY), Wall3%(), PSet: GoTo Skipdotover
If T$ = "%" Then Put (1 + SpacerX, 6 + SpacerY), Wall2%(), PSet: GoTo Skipdotover
Color 2: Put (1 + SpacerX, 6 + SpacerY), Wall%(), PSet
Skipdotover:
SpacerX = SpacerX + 30:
Return

Placedotdoor:
Put (SpacerX, 36 + SpacerY - 36 + 6), Door%()
SpacerX = SpacerX + 30
Return

PlacedotEdoor:
Put (SpacerX, 36 + SpacerY - 36 + 6), EDoor%()
SpacerX = SpacerX + 30
Return

Placedotkey:
Put (SpacerX, 36 + SpacerY - 36 + 6), Keylock%(), PSet
SpacerX = SpacerX + 30
Return

Placedotchest:
Put (SpacerX, 36 + SpacerY - 36 + 6), Treasure%(), PSet
SpacerX = SpacerX + 30
Return

Placedotring:
Put (SpacerX, 36 + SpacerY - 36 + 6), Diamond%(), PSet
SpacerX = SpacerX + 30
Return

Placedotgem:
Put (SpacerX, 36 + SpacerY - 36 + 6), Gem%(), PSet
SpacerX = SpacerX + 30
Return

Placedotweb:
Put (SpacerX, 36 + SpacerY - 36 + 6), Web%(), PSet
SpacerX = SpacerX + 30
Return

PlacedotSpike:
Put (SpacerX + 5, SpacerY + 36), Spike%(), PSet
SpacerX = SpacerX + 30
Return

Fin:
Screen 7: Cls: Locate 10, 15: Print "GAME": Locate 10, 20: Print "OVER"
If slc <> 4 Then Locate 13, 12: Print "SPACE - RESTART"
Locate 16, 15: Print "ESC - END"
WtdotKey:
T$ = InKey$: If T$ = "" Then GoTo WtdotKey
If T$ = Chr$(27) Then Cls: Screen 0: Print "THANKS FOR PLAYING!": System 0
If slc <> 4 Then If InKey$ = " " Then GoTo Start
If InKey$ = "" Then GoTo WtdotKey
GoTo WtdotKey

Checkdotkey:
i$ = InKey$
Select Case InKey$
    Case Chr$(27)
        Cls: System
    Case Chr$(32)
        GoTo Start

        If InKey$ = "" Then GoTo Checkdotkey
End Select
GoTo Checkdotkey

RoomdotCheck:
Cls: L = 0: LL = 0: SpacerX = 0: SpacerY = 0: Adv = 0: Wm = 0: Wm2 = 0
Eny = 0: Stringdotpnt = 0: Count = 0: EndotTally = 0
StartdotA = (12 * Rm) - 11: FinishdotA = 12 * Rm
If Y > 400 Then Y = 4
If Y < 4 Then Y = 400

Confirmdotrm:
GoSub Copydotwall: GoSub Cleardotplayer
For A = StartdotA To FinishdotA: For B = 1 To 20 'Height x Width
    T$ = Mid$(Maze$(A), B, 1)
    If T$ = " " Or T$ = "." Or T$ = "L" Then GoSub SkipdotX
        If T$ = "#" Then GoSub Placedotwall
        If T$ = "B" Or T$ = "S" Or T$ = "w" Then GoSub SkipdotX
        If T$ = "D" Then GoSub Placedotdoor
        If T$ = "E" Then GoSub PlacedotEdoor
        If T$ = "W" Then GoSub Placedotweb
        If T$ = "g" Then GoSub Placedotgem
        If T$ = "k" Then GoSub Placedotkey
        If T$ = "r" Then GoSub Placedotring
        If T$ = "s" Then GoSub PlacedotSpike
        If T$ = "t" Then GoSub Placedotchest
Next B: SpacerX = 0: SpacerY = SpacerY + 36: Next A: GoSub Displaydotman
T = 0: L = 0: SpacerX = 0: SpacerY = 0
If Rm = 0 Or Rm = 33 Or Rm = 64 Then Adv = 500
If Rm = 1 Or Rm = 5 Or Rm = 9 Or Rm = 17 Or Rm = 18 Or Rm = 19 Then Adv = 300
If Rm = 7 Or Rm = 8 Or Rm = 12 Or Rm = 16 Or Rm = 25 Or Rm = 28 Then Adv = 400
If Rm = 29 Or Rm = 31 Or Rm = 35 Or Rm = 39 Or Rm = 40 Or Rm = 41 Then Adv = 500
If Rm = 6 Or Rm = 10 Or Rm = 15 Or Rm = 20 Or Rm = 30 Then Adv = 450
If Rm = 42 Or Rm = 43 Or Rm = 44 Then Adv = 450
If Rm = 45 Or Rm = 46 Or Rm = 47 Or Rm = 54 Or Rm = 53 Or Rm = 55 Then Adv = 500
If Rm = 60 Or Rm = 61 Or Rm = 62 Then Adv = 500
r = StartdotA: B = 1: GoSub Gamedotstatus: Return

Gamedotstatus:
Color 2: Locate 29, 5: Print "LIVES:";: Color 15: Print Lives;
Color 2: Print Space$(4); "SCORE:";: Color 15: Print Score;
Color 2: Print Space$(5); "WEAPONS:";: Color 15: Print Objects;
Color 2: Print Space$(4); "HEALTH: ";: Color 15: Print Health;
Color 2: Print Space$(4); "KEYS:";: Color 15: Print Keys;
Return

Titledotscr:
Screen 12: Cls
W = (600 / 4) + 50: H = (400 / 4) + 40: CL = 1: Dmx = 1: Dmy = 1
CIX1 = 106: CIY1 = 279: Spx = 60: Spy = 243
SpacerX = Spx: SpacerY = Spy
Demo = TRUE: Plx% = CIX1 - 12: Ply% = CIY1 + (36 * 2)

Scandotmes:
Color 8: Locate 1, 1:
If (T < 1 Or T > 0) Then Print M1$
For A = 0 To 133: For B = 0 To 15

    Rand:
    Randomize Timer
    c = Fix(15 * Rnd(1)): If c = 8 Then GoTo Rand
        cx = W - 190 + A * 5: cy = H + 20 + (B * 5) - 80
        Pt = Point(A, B)
        If Pt = 8 And T < 1 Then GoSub CircdotFont: GoTo SkipdotPt
        If Pt = 8 And T > 0 Then GoSub Message

        SkipdotPt:
Next B, A: ht = CsrLin - 1: Locate ht, 1: Print Space$(16)
T = T + 1: M1$ = "ANY KEY TO START"
If T < 2 Then GoTo Scandotmes
GoSub Drawdotwall: Put (Plx%, Ply%), Player%(), PSet: A = 0: B = A: M = 5:
Aax = 30: BBx = 36: Playdotdemo = TRUE
Locate 10, 25: Print "Version 2.1: Trapped Forever"

Checkdotpress:
GoSub Spiderdotroutine: GoSub Ringdotglow: If Playdotdemo Then GoSub Demodotroutine
If InKey$ = "" Then GoTo Checkdotpress
CIX1 = 275: CIY1 = 145: CL = 0: Web = 5: Demo = FALSE
RingdotX = 0: RingdotY = 0: Return

Demodotroutine:
If A = (30 * 3) Then GoSub Listdotmes
If A = (30 * 5) Then GoSub Listdotmes2
If A = (30 * 9) And Not (Unlockeddotdoor) And Tr < 1 Then GoSub Listdotmes3
If A = (30 * 12) And Unlockeddotdoor < 1 And Tr < 1 Then GoSub Listdotmes4: Unlockeddotdoor = TRUE
Put (Plx% + A, Ply% - B), Player%(), PSet
For H = 1 To 1000: Next
Put (Plx% + A, Ply% - B), Player%()
If (A < 30 * 12) Then A = A + Aax
If (A <= (30 * 9)) And Tr Then GoSub Plotdotdemdotplr: GoSub Listdotmes5: Playdotdemo = FALSE: Return
If (A > (30 * 10) And Tr) Then A = A + Aax

If Unlockeddotdoor And Not (Tr) Then B = B + BBx: If B >= (36 * 2) Then GoSub Plotdotdemdotplr: Aax = -30: Tr = 1: Unlockeddotdoor = FALSE: Sleep 1
Null:
Return

Plotdotdemdotplr:
Put (Plx% + A, Ply% - B), Player%(), PSet: Return

Listdotmes:
GoSub Plotdotdemdotplr: GoSub Dmes1: Return

Listdotmes2:
GoSub Plotdotdemdotplr: GoSub Dmes2: Return

Listdotmes3:
GoSub Plotdotdemdotplr: GoSub Dmes3: Return

Listdotmes4:
GoSub Plotdotdemdotplr: GoSub Dmes4: Return

Listdotmes5:
GoSub Plotdotdemdotplr: GoSub Dmes5: Return

Dmes1:
A$ = "Avoid getting bit by the hanging spiders.": L = (80 - Len(A$)) * .5
A$(2) = "and don't touch the flashing electric pulses."
Color 15: Locate 12, L: Print A$
L2 = (80 - Len(A$(2))) * .5: Color 15: Locate 14, L2: Print A$(2): Sleep 6
Locate 12, L: Print Space$(Len(A$)):
Locate 14, L2: Print Space$(Len(A$(2)))
Return

Dmes2:
Line (Plx% + A - 4, Ply%)-(Plx% + A + 23, Ply% + 35), 0, BF
Put (Plx% + A, Ply%), Player%()
A$ = "Only the key you see in the same room as the door."
A$(2) = "will unlock that door."
L = (80 - Len(A$)) * .5: Color 15: Locate 12, L: Print A$
L2 = (80 - Len(A$(2))) * .5: Color 15: Locate 14, L2: Print A$(2): Sleep 6
Locate 12, L: Print Space$(Len(A$))
Locate 14, L2: Print Space$(Len(A$(2)))
Return

Dmes3:
A$ = "Collect rings, gems and treasures on your journey."
L = (80 - Len(A$)) * .5: Color 15: Locate 12, L: Print A$: Sleep 6
Locate 12, L: Print Space$(Len(A$)): Return

Dmes4:
A$ = "Now open the door with the key you found."
L = (80 - Len(A$)) * .5: Color 15: Locate 12, L: Print A$: Sleep 6
Locate 12, L: Print Space$(Len(A$)):
Line (Plx% + A - 4, (Ply%) - 36)-(Plx% + A + 23, (Ply% + 35) - 36), 0, BF
Return

Dmes5:
A$ = "Search for items and health potions in the treasure chests."
L = (80 - Len(A$)) * .5: Color 15: Locate 12, L: Print A$: Sleep 6
Locate 12, L: Print Space$(Len(A$)):
Return

CircdotFont:
Circle (cx, cy), 3, c: Paint (cx, cy), c: Circle (cx, cy), 1, 14
PSet (cx, cy), 0
Return

Message:
msx = W - 80 + A * 3: msy = H + 280 + B * 2
Circle (msx, msy), 2, CL
Inc = Inc + 1: If Fix(Inc / 45) = Inc / 45 Then CL = CL + 1
If CL = 8 Then CL = CL + 1
Return

Drawdotwall:
GoSub Demodotmaze: For A = 1 To 5: For L = 1 To 15
    S$ = Mid$(A$(A), L, 1)
    If S$ = "#" Then Put (SpacerX, SpacerY), Wall%(), PSet
        If S$ = "t" Then Put (SpacerX, SpacerY), Treasure%(), PSet
        If S$ = "D" Then Put (SpacerX, SpacerY), Door%(), PSet
        If S$ = "k" Then Put (SpacerX, SpacerY), Keylock%(), PSet
        If S$ = "r" Then RingdotX = SpacerX: RingdotY = SpacerY: Put (SpacerX, SpacerY), Diamond%(), PSet
        If S$ = "g" Then Put (SpacerX, SpacerY), Gem%(), PSet
        If S$ = "W" Then Put (SpacerX, SpacerY), Web%(), PSet
        If (S$ = "B" Or S$ = "S") Then Spx = SpacerX: Spy = SpacerY - 6: GoSub Spiderdotroutine
        SpacerX = SpacerX + 30
Next L: SpacerX = 60: SpacerY = SpacerY + 36: Next A
SpacerX = 60: SpacerY = 0
Return

Menulist:
Cls: Ky$(1) = "ARROW KEYS IN USE": Ky$(2) = "NUMPAD IN USE" + Space$(4)
Pntr = 190: SvspX = Spx: SvspY = Spy: slc = 1
Indent = 30: Dnx = 182: Bot = 410
'LINE (120, 100)-(490, 320), 7, BF
For O = 120 To 490 Step 2.1: Line (O, 100)-(O, Bot), 8: Next
Line (120 + Indent, 100 + Indent)-(490 - Indent, Bot - Indent), 7, BF
Line (120 + Indent + 10, 100 + Indent + 10)-(490 - Indent - 10, Bot - Indent - 10), 0, BF
Line (120 + Indent, 100 + Indent)-(490 - Indent, 320 - Indent), 14, B
Line (120 + Indent + 1, 100 + Indent + 1)-(490 - Indent - 1, Bot - Indent - 1), 4, B
Circle (190, 182), 6, 4: Paint (190, 182), 4: Circle (190, 182), 7, 14

Options:
Color 14
Locate 10, 26: Print "Use SPACE-BAR to select": Color 9
Locate 12, 28: Print "HELP (Game tips)"
Locate 14, 28: Print "GAME SPEED"
Locate 16, 28: Print Ky$(Kytapfl + 1)
Locate 18, 28: Print "ABORT THE GAME"
'LINE (120 + Indent + 10, 262 + Indent)-(490 - Indent - 10, Bot - Indent - 10), 15, BF
For O = 120 + Indent + 10 To 490 - Indent - 10 Step 2
Line (O, 262 + Indent)-(O, Bot - Indent - 10), 15: Next
Color 5: Locate 22, 26: Print "Press ESC to return to game"

OptiondotSel:
T$ = InKey$: If T$ = "" Then GoTo OptiondotSel
If T$ = Chr$(0) + "P" Then GoSub ErasedotPntr: Dnx = Dnx + 30: If Dnx > 272 Then Dnx = 272
If T$ = Chr$(0) + "H" Then GoSub ErasedotPntr: Dnx = Dnx - 30: If Dnx < 182 Then Dnx = 182
If T$ = Chr$(27) Then GoSub RoomdotCheck: Spx = SvspX: Spy = SvspY: Return
If T$ = Chr$(32) Then
    If slc = 1 Then
        GoSub Helpdotscr: GoTo Menulist
    Else
        If slc = 2 Then
            T$ = "": GoSub Alterdotdelay: GoTo Menulist
        Else
            If slc = 3 Then
                Kytapfl = Kytapfl + 1: If Kytapfl > 1 Then Kytapfl = 0
                Actiondotkey = (Kytapfl)
                GoTo Options
            Else
                If slc = 4 Then
                    Cls: GoTo Fin
                End If
            End If
        End If
    End If
End If
GoSub MovedotPntr
GoTo OptiondotSel

MovedotPntr:
slc = Int(Dnx / 30) - 5
Circle (190, Dnx), 6, 4: Paint (190, Dnx), 4: Circle (190, Dnx), 7, 14
Return

ErasedotPntr:
If Dnx >= 182 Or Dnx <= 242 Then Circle (190, Dnx), 7, 0: Paint (190, Dnx), 0
Return

Helpdotscr:
Cls: Far = 600: Line (0, 0)-(Far, 478), 15, BF
Line (40, 0)-(40, 478), 12, B: c = 0
For E = 0 To 478 Step 15.2: Line (0, E)-(Far, E), 3: Next
Circle (15, 10), 7, c: Paint (16, 11), c
Circle (15, 140), 7, c: Paint (16, 141), c: Circle (15, 270), 7, c
Paint (16, 271), c: Circle (15, 400), 7, c: Paint (16, 401), c
Color 6: Locate 5, 17: Print "You must navigate through a 64-room maze,"
Locate 7, 17: Print "all while avoiding dangling spiders, electric shocks"
Locate 9, 17: Print "and large knives that move up from the floor."
Locate 12, 17: Print "A word of advice: Time yourself when passing beyond"
Locate 14, 17: Print "spiders, electric shocks and moving knives."
Locate 17, 17: Print "Also make a hand-made map of the maze as you start"
Locate 19, 17: Print "advancing further and further into the labyrinth."
Locate 21, 17: Print "Finally, take advantage of the treasure chests and"
Locate 23, 17: Print "the helpful items inside."
Color 2: Locate 26, 23: Print "PRESS SPACE-BAR TO RETURN TO MENU"
Holddothelp:
T$ = InKey$: If T$ = "" Then GoTo Holddothelp
If T$ = Chr$(32) Then Return
GoTo Holddothelp


Demodotmaze:
A$(1) = "###############"
A$(2) = "#    r   t    #"
A$(3) = "####W########D#"
A$(4) = "#   S k   g   #"
A$(5) = "###############"
Return

Alterdotdelay:
Screen 12: Cls
Line (0, 0)-(600, 300), 8, BF: Line (0, 301)-(600, 315), 4, BF
For L = 2 To 598 Step 2.8: Line (L, 302)-(L, 314), 1: Next
For L = 1 To 598 Step 2.36: Line (L, 1)-(L, 298), 7: Next
CPU = 106: T = 1: c = 1
Color 15: Locate 10, 22: Print "GAME DELAY PERFORMANCE METER"
Color 2: Locate 22, 2: Print "USE THE LEFT & RIGHT ARROW KEYS TO SET A DELAY CHANNEL ";
Print "FOR THIS GAME."
Locate 23, 2: Print "YOU WILL THEN SEE A NUMERICAL COUNTER INCREMENTING ";
Print "OR DECREMENTING."
Locate 24, 2: Print "WHEN YOU HAVE THE DELAY YOU NEED, PRESS THE ";
Color 14: Print "SPACE BAR ";: Color 2: Print "TO EXIT."
Locate 25, 2: Print "USE CHANNEL ";: Color 14: Print "0 ";
Color 2: Print "FOR FASTEST SPEED."
Line (94, 100 + 80 - 6)-(456, 150 + 80 + 6), 0, B
Line (95, 100 + 80 - 5)-(455, 150 + 80 + 5), 9, BF
Line (100, 100 + 80)-(450, 150 + 80), 14, BF
Line (107, 190)-(107, 220), 6, BF
'Counter
Line (240, 245)-(300, 290), 0, BF: Line (239, 244)-(301, 291), 15, B
Line (241, 246)-(299, 289), 6, B: Line (243, 246)-(298, 288), 6, B
GoSub Cntr

Pskey:
i$ = InKey$: If i$ = "" Then GoTo Pskey
If i$ = Chr$(0) + "M" Then Flg = 1: T = 1: SL = 6: GoSub DrwMtr: GoSub Cntr: CPU = CPU + T: If CPU > 443 Then CPU = 443
If i$ = Chr$(0) + "K" Then T = -1: SL = 14: GoSub DrwMtr: CPU = CPU + T: GoSub DrwMtr: GoSub Cntr: If CPU < 105 Then CPU = 105
If i$ = Chr$(27) Then GoTo BegdotGame
If i$ = Chr$(32) Then Return
GoTo Pskey

Cntr:
c = c + T
If c < 1 Then c = 1: Flg = 0
If c > 340 Then c = 340
Color 7: Locate 17, 32: Print c - 1;
Return

BegdotGame:
If c - 1 < 2 Then Flg = 0: CPU = 0
Return

DrwMtr:
Line (CPU, 190)-(CPU, 220), SL, BF
Return

Builddotmazes:
'M:1   Maze 1
Maze$(1) = "######W#W#W#########"
Maze$(2) = "#t### S B S    #####"
Maze$(3) = "#t# # # ######   LL#"
Maze$(4) = "#t# # # ###### ###W#"
Maze$(5) = "#t# # # #         S."
Maze$(6) = "#r# # # # # ###W####"
Maze$(7) = "#g#t# # # #    SLk ."
Maze$(8) = "#t# # # # ##########"
Maze$(9) = "# # # # # #      # ."
Maze$(10) = "# W # # # ########W#"
Maze$(11) = "# B D # #         B."
Maze$(12) = "#######.############"

'M:9     Maze 2
Maze$(13) = "#######.############"
Maze$(14) = "#t #  # ####W#W###W#"
Maze$(15) = "#r #  # # # B B ttS."
Maze$(16) = "#r #  # # ##W#######"
Maze$(17) = "#  #  # # #kB      ."
Maze$(18) = "#  #  # # ##########"
Maze$(19) = "#  #  # #          ."
Maze$(20) = "#  #  # #######W####"
Maze$(21) = "#  #  # D    #rB   ."
Maze$(22) = "#  #  # #### #######"
Maze$(23) = "#  #  # #          ."
Maze$(24) = "#.##.##.######.#####"

'M:17
Maze$(25) = "#.##.##.######.#W###"
Maze$(26) = "#  #  # #gtrr   Brk#"
Maze$(27) = "#  #  # ############"
Maze$(28) = "#  #  #            ."
Maze$(29) = "#  #  ##############"
Maze$(30) = "#  #               #"
Maze$(31) = "#  #####D######### #"
Maze$(32) = "#  ####W W#     ## #"
Maze$(33) = "#  ##ttBgBt#    ## #"
Maze$(34) = "# ################ #"
Maze$(35) = "# #                ."
Maze$(36) = "#.#.################"

'M:25
Maze$(37) = "#.#.################"
Maze$(38) = "#                  ."
Maze$(39) = "# ##################"
Maze$(40) = "#                  ."
Maze$(41) = "# ################W#"
Maze$(42) = "#                 B."
Maze$(43) = "##W###W#############"
Maze$(44) = "#tBtttB    tt #    ."
Maze$(45) = "#rB r B       # ####"
Maze$(46) = "#######D##.W### ##W#"
Maze$(47) = "# rr  # #  B  # #kB."
Maze$(48) = "##..###.##.## #.####"

'M:33
Maze$(49) = "##..###.##.## #.####"
Maze$(50) = "#     # #  # k#    ."
Maze$(51) = "#W# ### ###W###W####"
Maze$(52) = "#B         B   B   ."
Maze$(53) = "# ##### ##### # ####"
Maze$(54) = "# #   # #   # # #  #"
Maze$(55) = "# #   # # r   # #  #"
Maze$(56) = "# #   # #   # # #  #"
Maze$(57) = "# #   # W#### # #  #"
Maze$(58) = "# #   # B     # #  #"
Maze$(59) = "#D#   # ##### # #  #"
Maze$(60) = "#.#####.#####.#.####"

'M:41
Maze$(61) = "#.#####.#####.#.####"
Maze$(62) = "# #   # #   # W##  #"
Maze$(63) = "# # t # #   # Bk#  #"
Maze$(64) = "# #   # #   #####  #"
Maze$(65) = "# #   # # ######## #"
Maze$(66) = "# # r # # #      # #"
Maze$(67) = "# #   # # # rrr  # #"
Maze$(68) = "# #   # # #      # #"
Maze$(69) = "# #     # # ttt  # #"
Maze$(70) = "# ############## #W#"
Maze$(71) = "#  D              B."
Maze$(72) = "####.###############"

'M:49
Maze$(73) = "####.#######W###W###"
Maze$(74) = "#  # #    # B   B  #"
Maze$(75) = "#  # #    # ### #  #"
Maze$(76) = "#  # #    # # # #  #"
Maze$(77) = "#  # #    # # # #  #"
Maze$(78) = "#  # ###  # # # #r #"
Maze$(79) = "#  #   #  # # # #  #"
Maze$(80) = "#  #   #  # # # # t#"
Maze$(81) = "#  # k #  # # # #  #"
Maze$(82) = "#  #####  # # # #W##"
Maze$(83) = "#   #r#   #D  #  B ."
Maze$(84) = "#####.#####.######.#"

'M:57
Maze$(85) = "#####.#####.######.#"
Maze$(86) = "#  t# #   # #    # ."
Maze$(87) = "#   # #   # #    ###"
Maze$(88) = "# ### ##### ##W#####"
Maze$(89) = "#           #kB L  ."
Maze$(90) = "# #######W##########"
Maze$(91) = "#        B         ."
Maze$(92) = "# ##################"
Maze$(93) = "# ## rr ggg ttt tt#."
Maze$(94) = "# #W ggg   tt  rr###"
Maze$(95) = "# DS g ggg ttt ttg #"
Maze$(96) = "####################"

'M:2
Maze$(97) = "####################"
Maze$(98) = "##WW##############W#"
Maze$(99) = "#kBS              SD"
Maze$(100) = "###W               #"
Maze$(101) = ".  B               ."
Maze$(102) = "#####W######W#######"
Maze$(103) = ".    B      B ttt# ."
Maze$(104) = "################## #"
Maze$(105) = ". #r             # #"
Maze$(106) = "################.# #"
Maze$(107) = ".                  #"
Maze$(108) = "####################"

'M:10
Maze$(109) = "####################"
Maze$(110) = "###W#######W######W#"
Maze$(111) = ".  B       S      S."
Maze$(112) = "########### ########"
Maze$(113) = ".         # #      ."
Maze$(114) = "######### # #      #"
Maze$(115) = ".       # #r#  ###W#"
Maze$(116) = "####### # ###  #  B."
Maze$(117) = ".     # #      #   #"
Maze$(118) = "##### # ########   #"
Maze$(119) = ".   # #            #"
Maze$(120) = "##.##.######.#######"

'M:18
Maze$(121) = "##.##.######.#####W#"
Maze$(122) = "#ggg# #   ## #    B."
Maze$(123) = "##W## #   ## #####t#"
Maze$(124) = "D B   #   ##k# r ###"
Maze$(125) = "####  ##   ### r r #"
Maze$(126) = "#  ##  ##    ##    ."
Maze$(127) = "#   ##  ## #########"
Maze$(128) = "#    ##  ##        ."
Maze$(129) = "#     # # # ##W## ##"
Maze$(130) = "####### # # #rB   W#"
Maze$(131) = ".     # # # #rB   B."
Maze$(132) = "#######.###.#.######"

'M:26
Maze$(133) = "#######.###.#.####W#"
Maze$(134) = ".   rr# ##  # ttt#B."
Maze$(135) = "####### ##  # rr # #"
Maze$(136) = ".   rr# ##  ###### #"
Maze$(137) = "######  ##  # rrr t#"
Maze$(138) = ".  #  D##   #### ###"
Maze$(139) = "#  #  #        #   #"
Maze$(140) = ".  #  #### ####W ###"
Maze$(141) = "####    ## #   B #k#"
Maze$(142) = "#W####  ## # #####L#"
Maze$(143) = ".B      ## #     # #"
Maze$(144) = "#######.##.#.#####.#"

'M:34
Maze$(145) = "#######.##.#.#####.#"
Maze$(146) = ".          # # #t# #"
Maze$(147) = "#######.#### # #t# #"
Maze$(148) = ".   L     #  # #r# #"
Maze$(149) = "### ##WW#D#  # # # #"
Maze$(150) = "# # # BB  # B# # # #"
Maze$(151) = "# # #   # # k# # # #"
Maze$(152) = "# # #  ####### # # #"
Maze$(153) = "# # #t #       # # ."
Maze$(154) = "# # #g #  W##### # #"
Maze$(155) = "# # #g #  B      # #"
Maze$(156) = "###.####.#########.#"

'M:42
Maze$(157) = "###.####.#########.#"
Maze$(158) = "# # # #  # #   #   #"
Maze$(159) = "# # # #  # # # # # #"
Maze$(160) = "# # # #t # # # # # #"
Maze$(161) = "# # # #  # # # # # #"
Maze$(162) = "# # # # r# # # # # #"
Maze$(163) = "# # # #  # # # # # #"
Maze$(164) = "# # # #  W## # # # #"
Maze$(165) = "# #k# #  B   #   # #"
Maze$(166) = "#W###############W #"
Maze$(167) = ".B  D            B #"
Maze$(168) = "### ############.###"

'M:50
Maze$(169) = "###.############.###"
Maze$(170) = "# # #         ## # #"
Maze$(171) = "# #L#       ##   # #"
Maze$(172) = "# # #     ##    ## #"
Maze$(173) = "# #k#   #W    ###  #"
Maze$(174) = "# ### ## B  ##  ##W#"
Maze$(175) = "#   ##    ## # t#tB."
Maze$(176) = "#  ##   ##   #L ## #"
Maze$(177) = "# ##  ##     #tt## #"
Maze$(178) = "##   ##  W#### L## #"
Maze$(179) = ".L #     Brr  tt##D#"
Maze$(180) = "##################.#  "

'M:58
Maze$(181) = "#W################.#"
Maze$(182) = ".B #             # #"
Maze$(183) = "# k############### #"
Maze$(184) = "#W#                #"
Maze$(185) = ".B  ############## #"
Maze$(186) = "### #              #"
Maze$(187) = ". # # ##############"
Maze$(188) = "# # ##############W#"
Maze$(189) = ". #               B."
Maze$(190) = "# ################W#"
Maze$(191) = "#                 BD"
Maze$(192) = "####################"

'M:3
Maze$(193) = "####################"
Maze$(194) = "####################"
Maze$(195) = ".                  #"
Maze$(196) = "######W###W#W##  # ."
Maze$(197) = ". L   S   S Sk#  # #"
Maze$(198) = "###############  # #"
Maze$(199) = ".             #  # #"
Maze$(200) = "########### # #  # #"
Maze$(201) = "#r r r      # #  # #"
Maze$(202) = "#  g  t     # #  # #"
Maze$(203) = "#           # #  #D#"
Maze$(204) = "########.####.#.##.#"

'M:11
Maze$(205) = "########.####.#.##.#"
Maze$(206) = "#######  Lt # #  # #"
Maze$(207) = ".     # Lt L# #  # #"
Maze$(208) = "#W### ####W## #  # #"
Maze$(209) = ".SW       B## #  # #"
Maze$(210) = "#kBs######g## #r # #"
Maze$(211) = "######ggt# ## #  # #"
Maze$(212) = ".    #trt# ## #  # #"
Maze$(213) = "#### #rrt# W# # r#D#"
Maze$(214) = "#tW# #   W B# #### #"
Maze$(215) = "# B  #   BsS  #    #"
Maze$(216) = "####.##########.##.#"

'M:19
Maze$(217) = "####.##########.##.#"
Maze$(218) = ".  # #           # ."
Maze$(219) = "## # # ####WW#W# ###"
Maze$(220) = "## # # # D BBsB    ."
Maze$(221) = "## # # # ##W########"
Maze$(222) = "## # # # #kBttL ttt#"
Maze$(223) = "## # # # # LLL LttL#"
Maze$(224) = ".    # # #  L  ttLt#"
Maze$(225) = "###  # # #   L LLtL#"
Maze$(226) = "#r#  # # # L  L   L#"
Maze$(227) = ". #  # # #L L   L  ."
Maze$(228) = "#.####.#.###########"

'M:27
Maze$(229) = "#.####.#.##W#W######"
Maze$(230) = ". ###  # #LStBt#rrr#"
Maze$(231) = "# #   ## # LLLL#   #"
Maze$(232) = "# # #### # r  LWrr #"
Maze$(233) = "# # #    #L  r S   #"
Maze$(234) = "# # # ###W L  L#rrr#"
Maze$(235) = "# # # #ttB r   #   #"
Maze$(236) = "# # # # ######## ###"
Maze$(237) = "# # # # r  g  ## # ."
Maze$(238) = "# # # #  r r t## # #"
Maze$(239) = "# # # # g  t  ## # #"
Maze$(240) = "#.#.#.##########.#.#"

'M:35
Maze$(241) = "#.#.#.##########.#.#"
Maze$(242) = "# #L# #          # #"
Maze$(243) = "# #t# ####W##### # #"
Maze$(244) = "# #g#     B        #"
Maze$(245) = "# ##################"
Maze$(246) = "# ##############W###"
Maze$(247) = "#               B  #"
Maze$(248) = "##W############### #"
Maze$(249) = ". B      rrLrrr k# #"
Maze$(250) = "###W############## #"
Maze$(251) = "#  B              D."
Maze$(252) = "##.#################"

'M:43
Maze$(253) = "##.#################"
Maze$(254) = "## ######W#W########"
Maze$(255) = "## #     SsS       ."
Maze$(256) = "## # ###W#########W#"
Maze$(257) = "## # #kgSs     L  S."
Maze$(258) = "## # ###############"
Maze$(259) = "## #               ."
Maze$(260) = "## #################"
Maze$(261) = "## #    sL        L#"
Maze$(262) = "## # #W#####W##### #"
Maze$(263) = "## # DS     Ss E## #"
Maze$(264) = "##.###############.#"

'M:51
Maze$(265) = "##.###########W###.#"
Maze$(266) = "## #          S  Ds#"
Maze$(267) = "## # ###############"
Maze$(268) = "## #               ."
Maze$(269) = "## ##W#####W###### #"
Maze$(270) = "#W   B     B     # #"
Maze$(271) = ".B #  #####W##L  # #"
Maze$(272) = "####  #    B # L#  #"
Maze$(273) = "#     # #### #k#  ##"
Maze$(274) = "# ttt # #  # ### #W#"
Maze$(275) = "#     # #        #B."
Maze$(276) = "#######.# ########.#"

'M:59
Maze$(277) = "#######.# W#######.#"
Maze$(278) = "#kttt # # S r t g# #"
Maze$(279) = "# tt L# ########D# #"
Maze$(280) = "# ttt # #tttttttt# #"
Maze$(281) = "#L L  # ########## #"
Maze$(282) = "#     #            #"
Maze$(283) = "###.##############W#"
Maze$(284) = "#      W       #  B."
Maze$(285) = ".  #   B  #        #"
Maze$(286) = "####################"
Maze$(287) = ".                  ."
Maze$(288) = "####################"

'M:4
Maze$(289) = "####################"
Maze$(290) = "####################"
Maze$(291) = "#######W###W####WW##"
Maze$(292) = ".      St# S    BBk."
Maze$(293) = "# #W###### #########"
Maze$(294) = "# .B tttt  LtLLtttt#"
Maze$(295) = "# #L ttt L  ttttLtt."
Maze$(296) = "# #  L L L LL LL  L#"
Maze$(297) = "# #L   L   LL  LL  ."
Maze$(298) = "# #####W##########W#"
Maze$(299) = "#     sS D        B."
Maze$(300) = "#########.##########"

'M:12
Maze$(301) = "#########.##########"
Maze$(302) = "#       # #        ."
Maze$(303) = "# ####### # ########"
Maze$(304) = "#         # ###W####"
Maze$(305) = "#L##### # # #ttS   ."
Maze$(306) = "# #     # # #####W##"
Maze$(307) = "# # ##### # # tt S ."
Maze$(308) = "#L# ###W# # # tt ###"
Maze$(309) = "#   L sB# # #      #"
Maze$(310) = "# ##### # # # rrrr #"
Maze$(311) = "#S     k# #D# rrrr #"
Maze$(312) = "#.#######.#.########"

'M:20
Maze$(313) = "#.#######.#.#W######"
Maze$(314) = ".     # # #  Btttts."
Maze$(315) = "### # # # # #WW#####"
Maze$(316) = ". # # # # #D BBLLtt#"
Maze$(317) = "# # # # # # # Bt##W#"
Maze$(318) = "# # # # # # #LWW#kS."
Maze$(319) = "# # # # # # #LBS####"
Maze$(320) = "# # # # # # #ttttt #"
Maze$(321) = "# # # # # # # tttt #"
Maze$(322) = "# # # # # # # tttt #"
Maze$(323) = ". # # # # # # tttt #"
Maze$(324) = "#.#.#.###.#.######.#"

'M:28
Maze$(325) = "#.#.#.###.#.######.#"
Maze$(326) = "#L# # #   # DrLrr#g#"
Maze$(327) = "# # #S# ### #rrr##W#"
Maze$(328) = "#L# ### #t# # Lr#kS."
Maze$(329) = "# # # W #t# #S L####"
Maze$(330) = "#L#r# B rt# #BBL   #"
Maze$(331) = "#t# # ##### #Lttt###"
Maze$(332) = "##### #     #LtLt# ."
Maze$(333) = ".  g# # #####LtLt# #"
Maze$(334) = "####W # #tttLttLt# #"
Maze$(335) = "#tttB # #gLtttLtt# #"
Maze$(336) = "#######.##########.#"

'M:36
Maze$(337) = "#######.########W#.#"
Maze$(338) = "# r r   #       Ss #"
Maze$(339) = "#  t  # # ######W# #"
Maze$(340) = "#####W# # #     Bs #"
Maze$(341) = "#    B  # # ###### #"
Maze$(342) = "# ####### # #ktgt# #"
Maze$(343) = "# #       # #L Lt# #"
Maze$(344) = "# #    #  # #r L # #"
Maze$(345) = "# #W## #  # #L   # #"
Maze$(346) = "# sS # #  #    L # #"
Maze$(347) = ".###D# #  # #  L # #"
Maze$(348) = "####.# ####.####.#.#"

'M:44
Maze$(349) = "####.# ####.####.#.#"
Maze$(350) = "#W## # #gg# #tt# #r#"
Maze$(351) = ".Ss  # #tt# #tt#####"
Maze$(352) = "#W#### #Lt# # ttL t#"
Maze$(353) = ".Bs    #tt#k#L   t #"
Maze$(354) = "#W######tt###  BS  #"
Maze$(355) = ".S###ttttL  L tttt #"
Maze$(356) = "# ###tttt L   tttt #"
Maze$(357) = "# ###rrrLr  L rrr  #"
Maze$(358) = "# #WW   rrrr  L  L #"
Maze$(359) = "# DSBrrrLrrL rrrr  #"
Maze$(360) = "#.##################"

'M:52
Maze$(361) = "#.W#################"
Maze$(362) = "# Ss               ."
Maze$(363) = "####W#######D#####W#"
Maze$(364) = ".k# B tttttL #  s B."
Maze$(365) = "###L LL L L  # ### #"
Maze$(366) = "# LL Ltttt   # ### #"
Maze$(367) = "#  L L LL L L# # # #"
Maze$(368) = "#rrLL L ttttL# # # #"
Maze$(369) = "#  rr  rr L L# # # #"
Maze$(370) = "#W############ # # #"
Maze$(371) = ".Sss             # #"
Maze$(372) = "##################.#"

'M:60
Maze$(373) = "################W#.#"
Maze$(374) = "#              sB  #"
Maze$(375) = "# ################L#"
Maze$(376) = "# #ttLL LL L LL L  ."
Maze$(377) = "# #W##############W#"
Maze$(378) = "# sS             sS."
Maze$(379) = "#W################W#"
Maze$(380) = ".B       L        B."
Maze$(381) = "####################"
Maze$(382) = "#W################W#"
Maze$(383) = ".S                S."
Maze$(384) = "####################"

'M:5 (5th row over)
Maze$(385) = "##################W#"
Maze$(386) = "##################S."
Maze$(387) = "####t t rrrrt##### #"
Maze$(388) = ".    B  L r LW##   #"
Maze$(389) = "#   B   L    B   L #"
Maze$(390) = "############### W###"
Maze$(391) = ".#g g         #sB#t#"
Maze$(392) = "############# ## # #"
Maze$(393) = ".  L rr    rr L# # #"
Maze$(394) = "################ # #"
Maze$(395) = ".      L t  ttk# D #"
Maze$(396) = "##################.#"

'M:13
Maze$(397) = "#W################.#"
Maze$(398) = ".B               . #"
Maze$(399) = "################## #"
Maze$(400) = "#W##############W# #"
Maze$(401) = ".S              B  #"
Maze$(402) = "#W###############WD#"
Maze$(403) = ".B L L LL L L LL S #"
Maze$(404) = "# tttttt L ttLtt ###"
Maze$(405) = "#L LL rrrr  rrL  #k#"
Maze$(406) = "#  rrLrr L rrrr L# #"
Maze$(407) = "# LL L L  L   L  #L#"
Maze$(408) = "################.#.#"

'M:21
Maze$(409) = "#W##############.#.#"
Maze$(410) = ".Sk# ttttt  LLt#D# #"
Maze$(411) = "####LLLLttttL##LL# #"
Maze$(412) = "#tttrrrLLLrrLrrL # #"
Maze$(413) = "##W#############W# #"
Maze$(414) = ". Ss           sS  #"
Maze$(415) = "# ################ #"
Maze$(416) = "# #LtLtt tttLL LL# #"
Maze$(417) = "# # LLL  LLLLL L # #"
Maze$(418) = "# #  ttttLLtttt L# #"
Maze$(419) = "# #L LLL   LLL tL# #"
Maze$(420) = "#.#.##############.#"

'M:29
Maze$(421) = "#.#.##############.#"
Maze$(422) = "# #              # #"
Maze$(423) = "# # ############ # #"
Maze$(424) = ". # #         t# # #"
Maze$(425) = "#L# # ## ##  tt# # #"
Maze$(426) = "# # #  # ## #### # #"
Maze$(427) = "# # #  # ## #    # #"
Maze$(428) = ". # #  # ## # ##W# #"
Maze$(429) = "### #  # ## # # Ss #"
Maze$(430) = "#   #  # ## # # ##W#"
Maze$(431) = "#   D  # ## # # #kS#"
Maze$(432) = "#####.##.##.#.#.##.#"

'M:37
Maze$(433) = "#####.##.##.#.#.##.#"
Maze$(434) = "#rrt#  # ## # # #  #"
Maze$(435) = "#LrL#  # ## # # #B #"
Maze$(436) = "#rr #  # ## # # #  #"
Maze$(437) = "# LL #D# ## # # # B#"
Maze$(438) = "# LLLL # ## # # #  #"
Maze$(439) = "# tLt  # ## # # #B #"
Maze$(440) = "#tLLLLL# ## # # #  #"
Maze$(441) = "#tttLLL# ## # # # B#"
Maze$(442) = "#LL###L# ## # # #  #"
Maze$(443) = "# t#k#t# ## # # #  #"
Maze$(444) = "#.##.###.##.#.#.##.#"

'M:45
Maze$(445) = "#.##.###.##.#.#.##.#"
Maze$(446) = "#  # # # ## # # #  #"
Maze$(447) = "#  # # # ## # # #  #"
Maze$(448) = "#  # # # ## # # #  #"
Maze$(449) = "#  # # # ## # # W# #"
Maze$(450) = "#  # # # ## # # Ss #"
Maze$(451) = "#tt# # # ## # #### #"
Maze$(452) = "#tt# # # ## # #### #"
Maze$(453) = "#tt# # # ## # #### #"
Maze$(454) = "#tt# # # ## # #W## #"
Maze$(455) = "#tt# # # ##L#  Ss  #"
Maze$(456) = "####.###.##.######.#"

'M:53
Maze$(457) = "#W##.###.##.######.#"
Maze$(458) = ".Ss  D #k # #rrrr  #"
Maze$(459) = "#### # #### #rrt   #"
Maze$(460) = ".  # # tt #r#rr    #"
Maze$(461) = "#  # #   L#r#tttt  #"
Maze$(462) = "#  # # tt #r#tttt  #"
Maze$(463) = "#  # # L  #r#tttt  #"
Maze$(464) = "# r# # tt #r#t L##W#"
Maze$(465) = "# r# #L L #r#ttt#rS."
Maze$(466) = "#r # # t L#W#   ##W#"
Maze$(467) = "#r # # L  sSs     B."
Maze$(468) = "####.###############"

'M:61
Maze$(469) = "##W#.###############"
Maze$(470) = "#kB# ###############"
Maze$(471) = "#L #      L       L#"
Maze$(472) = ".  ############### #"
Maze$(473) = "#W### tttL  Lrrr # #"
Maze$(474) = ".Bs #Lttt LL ttt # #"
Maze$(475) = "#W# # tttL  Lttt # #"
Maze$(476) = ".S# #L L  LLL L  # #"
Maze$(477) = "# # #L L L L L   # #"
Maze$(478) = "# # #######WD###W# #"
Maze$(479) = ". #       sS   sS  #"
Maze$(480) = "####################"

'M:6
Maze$(481) = "####################"
Maze$(482) = ". ########W#W#W#W###"
Maze$(483) = "# # D #ks B S S B  #"
Maze$(484) = "# # # ############ #"
Maze$(485) = "# # # gLtgtttggg # #"
Maze$(486) = "# # # rttgrrggtt # #"
Maze$(487) = "# # # LgtggLttttg# #"
Maze$(488) = "# # # LtttLLtttr # #"
Maze$(489) = "# # # rttgLLgLttr# #"
Maze$(490) = "# # ############## #"
Maze$(491) = "# #              # #"
Maze$(492) = "#.#.##############.#"

'M:14
Maze$(493) = "#.#.##W#W#W####W##D#"
Maze$(494) = "# # # B S S   LS # #"
Maze$(495) = "# # # # # # t t# # #"
Maze$(496) = "# #L# # # #tLtL#L# #"
Maze$(497) = "# # # # # #LL t# # #"
Maze$(498) = "# # # # # #LL L# # #"
Maze$(499) = "# # # # # #tLLL# #L#"
Maze$(500) = "# # # # # #LLLL# # #"
Maze$(501) = "# #L# # # #LttL# # #"
Maze$(502) = "# # # # ##k s  W # #"
Maze$(503) = "# # # # ## ### S # #"
Maze$(504) = "#.#.#.#.##.###.#.#.#"

'M:22
Maze$(505) = "#.#.#.#.##.###.#.#.#"
Maze$(506) = "# # # ###gggg L# # #"
Maze$(507) = "# # # #gggL ggg#k# #"
Maze$(508) = "# # #.#W########## #"
Maze$(509) = "# #    S         # #"
Maze$(510) = "# ##WL########## #D#"
Maze$(511) = "# # Ss             #"
Maze$(512) = "# # ########W#####W#"
Maze$(513) = "# # #ttttLrrSrrrr S."
Maze$(514) = "# # #############WW#"
Maze$(515) = "# #       s L    BB."
Maze$(516) = "#.##.###############"

'M:30
Maze$(517) = "#.##.###############"
Maze$(518) = "# ##sD             ."
Maze$(519) = "# #t#######W########"
Maze$(520) = "# #g# #r#ttB       ."
Maze$(521) = "# # # #r############"
Maze$(522) = "# # # # #L ttLttt  #"
Maze$(523) = "# # # # #  tttttt  ."
Maze$(524) = "#L# # # # L L rr L #"
Maze$(525) = "# # # # #B L       #"
Maze$(526) = "# # # # #######W####"
Maze$(527) = "# # # # #      Ssk ."
Maze$(528) = "#.#.#.#.#.##########"

'M:38
Maze$(529) = "#.W.#.#.#.W#########"
Maze$(530) = "# S # #   Ss       ."
Maze$(531) = "# # # # ########## #"
Maze$(532) = "# # # # #ttLtgL#k# ."
Maze$(533) = "# # # # #LtgLgt#L# #"
Maze$(534) = "# # # # # gttgL# # #"
Maze$(535) = "# # # # #LgLggL#L# #"
Maze$(536) = "# # # ### gtt t# # #"
Maze$(537) = "# # # ### LLL  # # #"
Maze$(538) = "# # # #W#D#L t #L# #"
Maze$(539) = "# # # sS# # L  # # #"
Maze$(540) = "#.#.#.#.#.######.#.#"

'M:46
Maze$(541) = "#.#.#.#.#.######.#.#"
Maze$(542) = "# # # # # #tttt# # #"
Maze$(543) = "# # # #   #LL L# # #"
Maze$(544) = "# # # # WW## rt# # #"
Maze$(545) = "# # # # SSk#tLL# # #"
Maze$(546) = "# # # # ####LLL# # #"
Maze$(547) = "# # # ###  tggt# # #"
Maze$(548) = "# # # # DLL ttr# # #"
Maze$(549) = "# # # # # gLgtg# # #"
Maze$(550) = "# # # # #LggLgt# # #"
Maze$(551) = "# # # # # gLLtg#   #"
Maze$(552) = "#.#.#.#.############"
 
'M:54
Maze$(553) = "#.#.#.#.W########W##"
Maze$(554) = "# # # # Ss       S ."
Maze$(555) = "# # # # ########## #"
Maze$(556) = "# # # # #LLtttttg# #"
Maze$(557) = "#L# # #L# LtLggt # #"
Maze$(558) = "# # # # #LLgttgLL# #"
Maze$(559) = "# # # # # ttrrt  # #"
Maze$(560) = "# # #L# #LLttLLLL# ."
Maze$(561) = ". # # # # gtrL#D## #"
Maze$(562) = "### # # # rt  #L # #"
Maze$(563) = ".k# # # # rgr # L# #"
Maze$(564) = "#.#.#.#.#######.##.#"

'M:62
Maze$(565) = "#.#.#.#.W####W#.##.#"
Maze$(566) = "# # # # B    S  #  ."
Maze$(567) = "# # # ####W#####W###"
Maze$(568) = "# # # #tttS     S  ."
Maze$(569) = "# # # ##############"
Maze$(570) = "# # # ############W#"
Maze$(571) = "# #              sS."
Maze$(572) = "# # ################"
Maze$(573) = "# #                ."
Maze$(574) = "# ################W#"
Maze$(575) = "#              L sB."
Maze$(576) = "####################"

'M:7
Maze$(577) = "##W#W##W###W#W#W#W##"
Maze$(578) = "#tB Ss Ss  B S B S #"
Maze$(579) = "### ## ### # # # # #"
Maze$(580) = "# #  # #t# # # # # #"
Maze$(581) = "# #  # # # # # # # #"
Maze$(582) = "# #  # # # # # # # #"
Maze$(583) = "# #  # # # # # # # #"
Maze$(584) = "# #  # # # # # # # #"
Maze$(585) = "# #  # # # # # # # #"
Maze$(586) = "# #  # #L# # # # # #"
Maze$(587) = "# #  # # # # # # # #"
Maze$(588) = "#.#.##.#.#.#.#.#.#.#"

'M:15
Maze$(589) = "#.#.##.#.#.#.#.#.#.#"
Maze$(590) = "# #L # # #L# # #L# #"
Maze$(591) = "# #  # # # # # # #L#"
Maze$(592) = "# # L# # # # # # # #"
Maze$(593) = "# #  # # # # # # # #"
Maze$(594) = "# #L # # # #t# # # #"
Maze$(595) = "# #  # # # #t# # # #"
Maze$(596) = "# # L# # # # # # # #"
Maze$(597) = "# #  # # # # # # # #"
Maze$(598) = "# #L # # # #t# # # #"
Maze$(599) = "# #  #L# # #t#L# # #"
Maze$(600) = "#.#.##.#.#.###.#.#.#"

'M:23
Maze$(601) = "#.#.##.#.#.###.#.#.#"
Maze$(602) = "# #k # # # #r# # # #"
Maze$(603) = "# #### # # #r# # # #"
Maze$(604) = "# #gt# # # # # # # #"
Maze$(605) = "# #gg# # # # # # # #"
Maze$(606) = "# ## # # # # # # # #"
Maze$(607) = "#      # #   #r# # #"
Maze$(608) = "#W###### W####W# # #"
Maze$(609) = ".S       S    B  # #"
Maze$(610) = "#W#######W######W# #"
Maze$(611) = ".S       B  L  sB  #"
Maze$(612) = "################.#D#"

'M:31
Maze$(613) = "#W##############.# #"
Maze$(614) = ".Bs          #t# # #"
Maze$(615) = "#W###### ### #t# # #"
Maze$(616) = ".S       #t# #t# # #"
Maze$(617) = "########## # #t# # #"
Maze$(618) = "#W######## # #t#t# #"
Maze$(619) = ".S      ## # #t#g# #"
Maze$(620) = "## rrgg ## # #t#t# #"
Maze$(621) = "########## #L# #t#L#"
Maze$(622) = "#W######## # # ### #"
Maze$(623) = ".B         # # ## s#"
Maze$(624) = "##########.#.#.##.##"

'M:39
Maze$(625) = "#W########.#.#.##.W#"
Maze$(626) = ".S      #### # #k B."
Maze$(627) = "#W#####    # # #####"
Maze$(628) = ".S     ### # #     ."
Maze$(629) = "####D# #t# # #####W#"
Maze$(630) = "#tttt# # # #     sB."
Maze$(631) = "#tttt# # # #######W#"
Maze$(632) = "#tttt# # # #     sS."
Maze$(633) = "#tttt# # # # #######"
Maze$(634) = "# t# # # # # #####W#"
Maze$(635) = "#tt# # # #   #rrrsS."
Maze$(636) = "######.#.#.#.#######"

'M:47
Maze$(637) = "##W###.#.#.#.####W##"
Maze$(638) = "#kS      # #    sB #"
Maze$(639) = "########W# ####### #"
Maze$(640) = "# r# #L BsD # #    #"
Maze$(641) = "#  # #ttt## # #  # #"
Maze$(642) = "#  # #tttt# # #  # #"
Maze$(643) = "#  # #tttt# # #  # #"
Maze$(644) = "#  # #tLtt# # #  # #"
Maze$(645) = "#  # #tttL# # #  # #"
Maze$(646) = "#  # ###### # #  # #"
Maze$(647) = "#    #    # # #  # #"
Maze$(648) = "####.####.#.#.####.#"

'M:55
Maze$(649) = "##W#.####.#.#.####.#"
Maze$(650) = ". B#          #### #"
Maze$(651) = "# W######## ###    #"
Maze$(652) = "# B       # # # ####"
Maze$(653) = "#     tt  # # # # k#"
Maze$(654) = "########### # # # L#"
Maze$(655) = "#W# rtttg # # # #  #"
Maze$(656) = ".B# tttgg # # # #LL#"
Maze$(657) = "### tgttt  D# # #  #"
Maze$(658) = "# rgttt ### # # # L#"
Maze$(659) = "#gttgtt ###   # #L #"
Maze$(660) = "#########.###.#.##.#"

'M:63
Maze$(661) = "#W#######.###.#.##.#"
Maze$(662) = ".Bs           # #  #"
Maze$(663) = "#W########### # #  #"
Maze$(664) = ".Bs           # #  #"
Maze$(665) = "############# # #  #"
Maze$(666) = "#W########### # #  #"
Maze$(667) = ".Bs           # #  #"
Maze$(668) = "#W############# #  #"
Maze$(669) = ".Bs                ."
Maze$(670) = "#W################W#"
Maze$(671) = ".Bs               B."
Maze$(672) = "####################"

'M:8
Maze$(673) = "#####W#W#W###W#W#W##"
Maze$(674) = "#k## S B B ##S S S #"
Maze$(675) = "# ## # #D# # # # # #"
Maze$(676) = "# ## # # # # # # # #"
Maze$(677) = "# ## # # # # # # # #"
Maze$(678) = "# ## # # # # # # # #"
Maze$(679) = "# ## # # # # # # # #"
Maze$(680) = "# ## # # # # # # # #"
Maze$(681) = "# ## # # # # # # # #"
Maze$(682) = "# ## # # # # # # # #"
Maze$(683) = "# ## # # # # # # # #"
Maze$(684) = "#.##.#.#.#.#.#.#.#.#"

'M:16
Maze$(685) = "#.##.#.#.#.#.#.#.#.#"
Maze$(686) = "# ## # # # # #L# #L#"
Maze$(687) = "# ## # # # # #t# # #"
Maze$(688) = "# ## # # # # #g# # #"
Maze$(689) = "# ## # # # # ### # #"
Maze$(690) = "# ## # # # # ### # #"
Maze$(691) = "# ## # #L# # ### # #"
Maze$(692) = "# ## # # # # ### # #"
Maze$(693) = "# ## # # # # ### # #"
Maze$(694) = "# ## # # # # ### # #"
Maze$(695) = "# ##L# # # # ### # #"
Maze$(696) = "#.##.#.#.#.#.###.#.#"

'M:24
Maze$(697) = "#.##.#.#.#.#.##W.#.#"
Maze$(698) = "# ## # # # # # S # #"
Maze$(699) = "# ## # # # # # # # #"
Maze$(700) = "# ## # # # # # # # #"
Maze$(701) = "# ## # # # # # # # #"
Maze$(702) = "# ## # # #L# # # # #"
Maze$(703) = "# ## #L# # # # # # #"
Maze$(704) = "# ## # # # # # # # #"
Maze$(705) = "# ## # # # # # # # #"
Maze$(706) = "# ## # # # # W # # #"
Maze$(707) = "# ## # # # # S # # #"
Maze$(708) = "#.##.#.#.#.#.###.#.#"

'M:32
Maze$(709) = "#.##.#.#.#.#.###.#.#"
Maze$(710) = "# ## # # # #D# # # #"
Maze$(711) = "# ## # # # # # # # #"
Maze$(712) = "# ## # # # #L# # # #"
Maze$(713) = "# ## #L# # # # # # #"
Maze$(714) = "# ## # # # # # # # #"
Maze$(715) = "# ## # # # # # # # #"
Maze$(716) = "# ## # # # # # # # #"
Maze$(717) = "# ## # # # # # # # #"
Maze$(718) = "# ## # # # W W # # #"
Maze$(719) = "# ##k# # # B S # # #"
Maze$(720) = "#.####.#.#.#.###.#.#"

'M:40
Maze$(721) = "#.####.#.#.#.###.#.#"
Maze$(722) = ". #  #t# # # ### # #"
Maze$(723) = "#W#  #W# # # ### # #"
Maze$(724) = ".S    S  # # ### # #"
Maze$(725) = "####W#W# # # ### # #"
Maze$(726) = ".   BsB  # # ### # #"
Maze$(727) = "#W###### # # ### # #"
Maze$(728) = ".S       # # ### # #"
Maze$(729) = "######## # # ### # #"
Maze$(730) = "##W###r# # # ### # #"
Maze$(731) = ". S k# #D# # ### # #"
Maze$(732) = "#.####.#.#.#.###.#.#"


'M:48
Maze$(733) = "#.####.#.#.#.###.#.#"
Maze$(734) = "#  #   # # # ###L# #"
Maze$(735) = "#  # # # # # ###t# #"
Maze$(736) = "#  # # #L# # ##### #"
Maze$(737) = "#  # # # # # ###t# #"
Maze$(738) = "#  # # #k# # ### # #"
Maze$(739) = "#  # # ### # ### #L#"
Maze$(740) = "#  # # #t# # ### # #"
Maze$(741) = "#  # # #t# # ### # #"
Maze$(742) = "#  # # # # # ### # #"
Maze$(743) = "#  # #L# # # ### #D#"
Maze$(744) = "#.##.#.#.#.#.###.#.#"

'M:56
Maze$(745) = "#.##.#.#.#.#.###.#.#"
Maze$(746) = "# ## # # # #k### # #"
Maze$(747) = "# ## # # # ###W# # #"
Maze$(748) = "# ## # # #    B  # #"
Maze$(749) = "# ## # # ####W##D# #"
Maze$(750) = "# ## #L# #tttBttr# #"
Maze$(751) = "# ## # # #gttt  L# #"
Maze$(752) = "# ## # # # trtSgL# #"
Maze$(753) = "# ## # # #rr rtrt# #"
Maze$(754) = "# #W # # #rtBgggt# #"
Maze$(755) = "# sB # # #gg ttrt# #"
Maze$(756) = "#.##.#.#.#########.#"

'M:64
Maze$(757) = "#.##.#.#.#########.#"
Maze$(758) = "#  # # # #ttt rrt# #"
Maze$(759) = "#  #L# # ####t tt# #"
Maze$(760) = "#  # # # # r rrr # #"
Maze$(761) = "# t# # # #Lrttrt # #"
Maze$(762) = "#t # # # # rrLrrL# #"
Maze$(763) = "# t#k# # #Stt tt # #"
Maze$(764) = "###### # #L     L# #"
Maze$(765) = ".      # #       # #"
Maze$(766) = "######W#.#####W# # #"
Maze$(767) = ".     Ss      SsD  #"
Maze$(768) = "####################"
Return

Makedotobj:
Data !?Short sword,!?Warriors sword,!?Magical sword
Data $/Amulet,%@Waters of healing,$/statue of a golden eagle
Data !?Whip,!?Knife,!?Shield
Data $/Chalice,$/bunch of golden coins,%/Healing potion
Data !?Iron fist,!?Detonator,%@Spider Antidote
Data |/Nothing at all

Wallcols:
Data 12,4,6,2,5,7,8,14,8,11,9,1,4,2,2,1,2,3,10,1,8,8
Data 2,13,2,5,6,7,9,11,3,3,4,6,12,9,3,5,7,2,4,12,9,4
Data 5,8,9,7,1,3,6,2,4,5,13,11,12,11,10,9,14,15,13,1

Wallbord:
Data 4,12,13,14,15,1,14,2,9,2,4,7,3,13,8,9,4,2,14,8,7
Data 1,13,3,15,4,4,10,2,4,14,1,11,14,1,1,13,12,14,14
Data 10,2,14,14,12,9,8,11,10,14,12,9,13,14,9,1,2,3,4
Data 5,8,8,2,14

Sub Cleardotarea
    Line (Sx - 4, Sy)-(Sx + 23, Sy + 35), 0, BF
    Return
End Sub

Sub CopydotPlayer
    Line (CIX1 + 15, CIY1 + 23)-(CIX1 + 37, CIY1 + 45), 0, BF
    Circle (CIX1 + 28, CIY1 + 35), 10, 15: Paint (CIX1 + 28, CIY1 + 35), 15
    Circle (CIX1 + 28, CIY1 + 35), 10, 6: Circle (CIX1 + 28, CIY1 + 35), 9, 6
    For E = 1 To 5: Circle (CIX1 + 28, CIY1 + 35), E, 0: Next
    Circle (CIX1 + 28, CIY1 + 35), 1, 0
    Get (CIX1 + 15, CIY1 + 23)-(CIX1 + 37, CIY1 + 45), Player%()
    Return

End Sub
