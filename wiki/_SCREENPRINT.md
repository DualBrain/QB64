The [_SCREENPRINT](_SCREENPRINT) statement simulates typing text into a Windows focused program.

## Syntax

> [_SCREENPRINT](_SCREENPRINT) text$

## Description

* [Keywords currently not supported](Keywords-currently-not-supported-by-QB64)
* text$ is the text to be typed into a focused program's text entry area, one character at a time.
* Set the focus to a desktop program by using the [_SCREENIMAGE](_SCREENIMAGE) handle as the [_SOURCE](_SOURCE). Use the image to map the desired area. 
* [_SCREENCLICK](_SCREENCLICK) can also be used to set the focus to a program's text entry area on the desktop.
* **Note: If the focus is not set correctly, the text may be printed to the QB64 IDE, if open, or not printed at all.**
* Ctrl + letter key shortcuts can be simulated using the appropriate [ASCII](ASCII) Control character codes 1 to 26 shown below:

```text

 CTRL + A = CHR$(1)   ☺  StartHeader (SOH)    CTRL + B = CHR$(2)   ☻  StartText         (STX)
 CTRL + C = CHR$(3)   ♥  EndText     (ETX)    CTRL + D = CHR$(4)   ♦  EndOfTransmit     (EOT)
 CTRL + E = CHR$(5)   ♣  Enquiry     (ENQ)    CTRL + F = CHR$(6)   ♠  Acknowledge       (ACK)
 CTRL + G = CHR$(7)   •  [BEEP](BEEP)        (BEL)    CTRL + H = CHR$(8)   ◘  **[Backspace]**       (BS)
 CTRL + I = CHR$(9)   ○  Horiz.Tab   **[Tab]**    CTRL + J = CHR$(10)  ◙  LineFeed(printer) (LF)
 CTRL + K = CHR$(11)  ♂  Vert. Tab   (VT)     CTRL + L = CHR$(12)  ♀  FormFeed(printer) (FF)
 CTRL + M = CHR$(13)  ♪  **[Enter]**     (CR)     CTRL + N = CHR$(14)  ♫  ShiftOut          (SO)
 CTRL + O = CHR$(15)  ☼  ShiftIn     (SI)     CTRL + P = CHR$(16)  ►  DataLinkEscape    (DLE)
 CTRL + Q = CHR$(17)  ◄  DevControl1 (DC1)    CTRL + R = CHR$(18)  ↕  DeviceControl2    (DC2)
 CTRL + S = CHR$(19)  ‼  DevControl3 (DC3)    CTRL + T = CHR$(20)  ¶  DeviceControl4    (DC4)
 CTRL + U = CHR$(21)  §  NegativeACK (NAK)    CTRL + V = CHR$(22)  ▬  Synchronous Idle  (SYN)
 CTRL + W = CHR$(23)  ↨  EndTXBlock  (ETB)    CTRL + X = CHR$(24)  ↑  Cancel            (CAN)
 CTRL + Y = CHR$(25)  ↓  EndMedium   (EM)     CTRL + Z = CHR$(26)  →  End Of File(SUB)  (EOF)                           

```

## Example(s)

Printing text into a Windows text editor (Notepad) and copying to the clipboard. May not work on all systems.

```vb

DEFLNG A-Z
SCREEN _NEWIMAGE(640, 480, 32)
PRINT "OPENing and MAXIMIZING Notepad in 5 seconds..."; : _DELAY 5
SHELL _DONTWAIT "START /MAX NotePad.exe"  'opens Notepad file "untitled.txt"
'detect notepad open and maximized
'condition: 80% or more of the screen is white
DO                     'read the desktop screen image for maximized window
  s = _SCREENIMAGE
  _SOURCE s
  z = 0
  FOR y = 0 TO _HEIGHT(s) - 1   'scan for large white area
    FOR x = 0 TO _WIDTH(s) - 1
       c = POINT(x, y)
       IF c = _RGB32(255, 255, 255) THEN z = z + 1
    NEXT
  NEXT
  IF z / (_HEIGHT(s) * _WIDTH(s)) > 0.8 THEN EXIT DO 'when 80% of screen is white
  _FREEIMAGE s   'free desktop image
  _LIMIT 1       'scans 1 loop per second
PRINT ".";
LOOP
PRINT
PRINT "NOTEPAD detected as OPEN and MAXIMIZED"

_SCREENPRINT "HELLO WORLD"
SLEEP 2
_SCREENPRINT CHR$(8) + CHR$(8) + CHR$(8) + CHR$(8) + CHR$(8) 'backspace 5 characters
SLEEP 3
_SCREENPRINT "QB64!"
SLEEP 2
_SCREENPRINT CHR$(1) 'CTRL + A select all
SLEEP 2
_SCREENPRINT CHR$(3) 'CTRL + C copy to clipboard
SLEEP 2
PRINT _CLIPBOARD$
_CLIPBOARD$ = "QB64 ROCKS!"
SLEEP 2
_SCREENPRINT CHR$(22) 'CTRL + V paste from clipboard
END 

```

> *Explanation:* If the Windows shortcuts are set up properly, printing ASCII Control characters acts like the user selected the control + letter combinations to *Select all* (CHR$(1)), *Copy* (CHR$(3)) and *Paste* (CHR$(22)) the text with the Windows Clipboard. If the editor program's CTRL key combinations are different, use the matching letter [ASCII](ASCII) code from A = 1 to Z = 26 in the text editor.

## See Also

* [_SCREENIMAGE](_SCREENIMAGE), [_SCREENCLICK](_SCREENCLICK)
* [_SCREENMOVE](_SCREENMOVE), [_SCREENX](_SCREENX), [_SCREENY](_SCREENY)
* [ASCII](ASCII)
