**Creating a QB64 Screen Saver**

Screen savers are simply graphics EXE programs renamed with the SCR file extension. The program should NOT use a lot of Window's CPU resources! To check the CPU usage, open **Task Manager** by pressing *Ctrl + Alt + Delete* keys and look for the QB64 program running in the *Processes* tab list. CPU usage should be less than 50% and ideally less than 20%. Use [_LIMIT](_LIMIT) or [SLEEP](SLEEP) when needed.

**Renaming an EXE Program to a SCR File and Installing**

The program can be renamed several ways using a program or batch file you make or doing it manually in Windows. In Windows you can open an **Explorer** window select the *Tools* menu and click *Folder Options...*. Select the *View* tab and uncheck the *Hide extensions for known file types* box. Then you can simply rename the program file changing the extension. Then 
either move the file or *Install* it as explained below:

> **Install* the program in the SCR file Right click pop-up menu.

> **Copy* the SCR program to the **C:\Windows\System32 folder** so that Windows will list it in the **Desktop Properties**. Select the *Screensaver* tab's drop-down Menu List and select the new screensaver from the list.

## Example(s)

A screen saver that un-organizes the Desktop.

```vb

S& = _SCREENIMAGE                  'get the image of the desktop
RANDOMIZE TIMER
screenx = _WIDTH(S&)    'use current screen resolution dimensions
screeny = _HEIGHT(S&)
SCREEN _NEWIMAGE(screenx, screeny, 32)
_FULLSCREEN
_DISPLAY
temp& = _NEWIMAGE(40, 40, 32)
DO: _LIMIT 10
  x1 = INT(RND * screenx)
  y1 = INT(RND * screeny)
  x2 = x1 + 40
  y2 = y1 + 40
  _PUTIMAGE , S&, temp&, (x1, y1)-(x2, y2)  'place partial image into page box
  xoff1 = INT(40 - RND * 81) + x1
  yoff1 = INT(40 - RND * 81) + y1
  xoff2 = INT(40 - RND * 81) + x2
  yoff2 = INT(40 - RND * 81) + y2
  _PUTIMAGE (xoff1, yoff1)-(xoff2, yoff2), temp&, 0    'place image on the screen
  _DISPLAY
  DO WHILE _MOUSEINPUT                'check for mouse movement
    mx = mx + _MOUSEMOVEMENTX
    my = my + _MOUSEMOVEMENTY
  LOOP
LOOP UNTIL INKEY$ > "" OR mx <> 0 OR my <> 0  'check for any key press
SYSTEM * *                     'close screen saver immediately

```
<sub>Code by DSMan</sub>

## See Also

* [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX), [_MOUSEMOVEMENTY](_MOUSEMOVEMENTY)
* [SCREEN (statement)](SCREEN-(statement)), [_SCREENIMAGE](_SCREENIMAGE)
* [SAVEIMAGE](SAVEIMAGE) (save image to bitmap program)
