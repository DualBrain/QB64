**Metacommands** are program wide commands that start with $.

##  QBasic/QuickBASIC - Legacy metacommands

### Syntax

> REM [$INCLUDE]($INCLUDE): '[QB.BI](QB.BI)' 'loads a reference file or library

> REM [$DYNAMIC]($DYNAMIC) 'enables resizing of array dimensions with REDIM

> REM [$STATIC]($STATIC) 'arrays cannot be resized once dimensioned

### Description

* QBasic Metacommands are normally used at the program start and are in effect throughout the program.
* QBasic Metacommands are always prefixed with $ and MUST be commented with an apostrophe or [REM](REM).
* [$INCLUDE]($INCLUDE) is always followed by a colon and the full text code file name is commented on both sides.
* [$DYNAMIC]($DYNAMIC) allows larger arrays that are changeable in size at runtime.
* [$STATIC]($STATIC) makes all arrays unchangeable in size.
* **QBasic metacommands should have their own program line because they are commented.**

## QB64 metacommands

### Syntax

> [$ASSERTS]($ASSERTS):CONSOLE

> [$CHECKING]($CHECKING){OFF|ON} 'disables QB64 C++ event and error checking (no spaces)

> [$COLOR]($COLOR)    'adds named color [CONST](CONST)antes to a program

> [$CONSOLE]($CONSOLE) 'creates a QB64 console window throughout the program

> [$DEBUG]($DEBUG) enables debugging features, allowing you to step through your code line by line
 
> [$ERROR]($ERROR) _MESSAGE_ triggers a compilation error MESSAGE.

> [$EXEICON]($EXEICON):'iconfile.ico' 'embeds an .ICO file into the final executable (Windows only)

> [$IF]($IF) ... [$ELSEIF]($IF) ... [$ELSE]($IF) ... [$END IF]($END-IF) 'precompiler directive

> [$LET]($LET) variable = expression

> [$RESIZE]($RESIZE):{ON|OFF|STRETCH|SMOOTH} 'determines if re-sizing of the program screen by the user is allowed

> [$SCREENHIDE]($SCREENHIDE) 'hides the QB64 program window throughout the program

> [$SCREENSHOW]($SCREENSHOW) 'displays the main QB64 program window

> [$VERSIONINFO]($VERSIONINFO):key=value 'embeds version info metadata into the final executable (Windows only)

> [$VIRTUALKEYBOARD]($VIRTUALKEYBOARD):{ON|OFF} 'DEPRECATED keyword 


### Description

* [$ASSERTS]($ASSERTS)_:CONSOLE_ Enables debug tests with the [_ASSERT](_ASSERT) macro.
* [$CHECKING]($CHECKING)_{OFF|ON}_ Should only be used with **errorless** code where every CPU cycle counts! Use **ON** to re-enable event checking. Event checking can be turned OFF or ON throughout a program.
* [$COLOR]($COLOR)  adds named color [CONST](CONST)antes to a program.
* [$CONSOLE]($CONSOLE) creates a console window which can be turned off later with [_CONSOLE](_CONSOLE) OFF.
* [$DEBUG]($DEBUG) enables debugging features, allowing you to step through your code line by line.
* [$ERROR]($ERROR) _MESSAGE_ triggers a error MESSAGE only during your program compilation.
* [$IF]($IF) ... [$ELSEIF]($IF) ... [$ELSE]($IF) ... [$END IF]($END-IF) allows selective inclusion of code in the final program.
* [$LET]($LET) _variable = expression_ sets a precompiler variable to a value.
* [$RESIZE]($RESIZE):{ON|OFF|STRETCH|SMOOTH} allows a user to resize the program window. OFF is default.
* [$SCREENHIDE]($SCREENHIDE) hides the QB64 program window throughout the program until [$SCREENSHOW]($SCREENSHOW) is used.
* [$VERSIONINFO]($VERSIONINFO):_key=value_ embeds version info metadata into the final executable (Windows only).

* **Do not comment out with ' or [REM](REM) QB64-specific metacommands.**

## See Also

* [Statement](Statement), [Function (explanatory)](Function-(explanatory))
* [REM](REM)
* [DIM](DIM), [REDIM](REDIM)
* [ON TIMER(n)](ON-TIMER(n))
