QB64 has console window support using the following QB64 [Metacommand](Metacommand) or keyword:

## Syntax

>  [$CONSOLE]($CONSOLE)

>  [_CONSOLE](_CONSOLE) [{ON|OFF}]

* _CONSOLE OFF turns the console window off once a console has been established using the [$CONSOLE]($CONSOLE) [Metacommand](Metacommand).
* _CONSOLE ON should only be used AFTER the console window has been turned OFF previously.
* [_DEST](_DEST) CONSOLE can be used to send screen output to the console window using QB64 commands such as [PRINT](PRINT).
* [_SCREENHIDE](_SCREENHIDE) or [_SCREENSHOW](_SCREENSHOW)(after window is hidden) can be used to hide or display the main program window.
* The [$SCREENHIDE]($SCREENHIDE) [Metacommand](Metacommand) can hide the main program window throughout a program when only the console is used.
* The [$SCREENSHOW]($SCREENSHOW) [Metacommand](Metacommand) can be used to display the main program window in a section of code after being hidden.
* When the program ends in the console window, a "Press Enter to continue" message will appear using QB64.

**Copying console screen text**

Console Window text can be copied by highlighting the text holding down the left mouse button. Once text is highlighted, right click the console window title bar to open the *Edit >* menu and click *Copy*. *Paste* and *Select All* are also available in the menu.

## Example(s)

Copying console window text is as simple as a right click on highlighted text areas. Another right click will close console.

```vb

$SCREENHIDE
$CONSOLE
_DEST _CONSOLE

PRINT
PRINT "Copy this text by highlighting and right clicking!" 

```

> *Note:* You may have to right click the title bar and select *Edit > Select All* to start a copy. Then re-highlight text area desired and right click *Edit > Copy* or press the *Enter* key. Right click in the title bar area only, not in the program window area!


> The copy procedure will also work in **CMD.EXE** console windows Run from the Start Menu or the **Command Prompt** shortcut. 

*Note:* A second right click may Paste the clipboard text to the DOS command line instead of closing console.

## See Also

* [$SCREENHIDE]($SCREENHIDE), [$SCREENSHOW]($SCREENSHOW)
* [$CONSOLE]($CONSOLE), [_CONSOLE](_CONSOLE), [_DEST](_DEST)
* [C_Libraries#Console_Window](C-Libraries#Console_Window)
