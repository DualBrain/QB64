| | INDEX | 
|:----:|--|
| 1| [**Arrays and Data Storage**](Keyword-Reference---By-Usage#arrays-and-data-storage) |
| | . . . [_Arrays_](Keyword-Reference---By-Usage#arrays)
| | . . . [_Fixed Program DATA_](Keyword-Reference---By-Usage#fixed-program-data)
| 2| [**Color and Transparency**](Keyword-Reference---By-Usage#color-and-transparency) |
| 3| [**Console Window**](Keyword-Reference---By-Usage#console-window) |
| 4| [**Conditional Operations**](Keyword-Reference---By-Usage/#conditional-operations) |
| | . . . [_Relational Operations_](Keyword-Reference---By-Usage#relational-operations) |
| 5| [**Definitions and Variable Types**](Keyword-Reference---By-Usage#definitions-and-variable-types) | 
| 6| [**External Disk and API calls**](Keyword-Reference---By-Usage#external-disk-and-api-calls) | 
| 7| [**Error Codes**](Keyword-Reference---By-Usage#error-codes) | 
| 8| [**Error Trapping**](Keyword-Reference---By-Usage#error-trapping) | 
| 9| [**Event Trapping**](Keyword-Reference---By-Usage#event-trapping) | 
| 10| [**File Input and Output**](Keyword-Reference---By-Usage#file-input-and-output)
| 11| [**Fonts**](Keyword-Reference---By-Usage#fonts)
| 12| [**Game Controller Input (Joystick)**](Keyword-Reference---By-Usage#game-controller-input-joystick)
| 13| [**Graphic Commands**](Keyword-Reference---By-Usage#graphic-commands)
| 14| [**Graphics and Imaging**](Keyword-Reference---By-Usage#graphics-and-imaging)
| 15| [**Keyboard Input**](Keyword-Reference---By-Usage#keyboard-input)
| 16| [**Libraries**](Keyword-Reference---By-Usage#libraries)
| 17| [**Logical Bitwise Operations**](Keyword-Reference---By-Usage#logical-bitwise-operations)
| 18| [**Mathematical Functions and Operations**](Keyword-Reference---By-Usage#mathematical-functions-and-operations)
| 19| [**Memory Handling and Clipboard**](Keyword-Reference---By-Usage#memory-handling-and-clipboard)
| 20| [**Functions/Statements using QB64's emulated 16 bit memory**](Keyword-Reference---By-Usage#functions-and-statements-using-qb64s-emulated-16-bit-memory)
| 21| [**Metacommands**](Keyword-Reference---By-Usage#metacommands)
| 22| [**Mouse Input**](Keyword-Reference---By-Usage#mouse-input)
| 23| [**Numerical Manipulation and Conversion**](Keyword-Reference---By-Usage#numerical-manipulation-and-conversion)
| 24| [**Port Input and Output (COM and LPT)**](Keyword-Reference---By-Usage#port-input-and-output-com-and-lpt)
| 25| [**Print formatting**](Keyword-Reference---By-Usage#print-formatting)
| 26| [**Printer Output (LPT and USB)**](Keyword-Reference---By-Usage#printer-output-lpt-and-usb)
| 27| [**Program Flow and Loops**](Keyword-Reference---By-Usage#program-flow-and-loops)
| 28| [**Sounds and Music**](Keyword-Reference---By-Usage#sounds-and-music)
| 29| [**String Text Manipulation and Conversion**](Keyword-Reference---By-Usage#string-text-manipulation-and-conversion)
| 30| [**Sub procedures and Functions**](Keyword-Reference---By-Usage#sub-procedures-and-functions)
| 31| [**TCP/IP Networking and Email**](Keyword-Reference---By-Usage#tcpip-networking-and-email)
| 32| [**Text on Screen**](Keyword-Reference---By-Usage#text-on-screen)
| 33| [**Time, Date and Timing**](Keyword-Reference---By-Usage#time-date-and-timing)
| 34| [**Window and Desktop**](Keyword-Reference---By-Usage#window-and-desktop)
| 35| [**QB64 Programming Symbols**](Keyword-Reference---By-Usage#qb64-programming-symbols)
| | . . . [_Print, Input or File Formatting_](Keyword-Reference---By-Usage#print-input-or-file-formatting)
| | . . .  [_Program Code Markers_](Keyword-Reference---By-Usage#program-code-markers)
| | . . . [_Variable Name Type Suffixes_](Keyword-Reference---By-Usage#variable-name-type-suffixes)
| | . . .  [_Numerical Base Prefixes_](Keyword-Reference---By-Usage#numerical-base-prefixes)
| | . . . [_Mathematical Operations_](Keyword-Reference---By-Usage/Mathematical-Operations)
| | . . . [_Relational Operations_](Keyword-Reference---By-Usage/Relational-Operations)
| 36| [**QB64 Programming References**](Keyword-Reference---By-Usage#qb64-programming-references)


***

## [Arrays](Arrays) and Data Storage

### Arrays

* [_DEFINE](_DEFINE) (statement)  defines a range of untyped variable names according to their first character as a datatype.
* [_PRESERVE](_PRESERVE) ([REDIM](REDIM) option) preserves the existing element values when an array is resized.
* [CLEAR](CLEAR) (statement) resets all variable values and array element values to 0 or null [STRING](STRING) and closes all open files.
* [DIM](DIM) (statement) dimensions(sizes) a [STATIC](STATIC) array and defines the type.
* [$DYNAMIC]($DYNAMIC) (metacommand) defines that all arrays are dynamic or changeable in size.
* [ERASE](ERASE) (array statement) clears a [STATIC](STATIC) array of all values and totally removes a [$DYNAMIC]($DYNAMIC) array.
* [LBOUND](LBOUND) (array function) returns the lowest valid index (lower boundary) of an [arrays](arrays).
* [OPTION BASE](OPTION-BASE) (statement) sets the default starting index of an array to 0 or 1.
* [REDIM](REDIM) (statement) re-dimensions the number of elements in a [$DYNAMIC]($DYNAMIC)(resizeable) [arrays](arrays) and defines the type.
* [SHARED](SHARED) (statement) designates variable values that can be shared with sub-procedures without using parameters.
* [STATIC](STATIC) (statement) defines a variable or list of variables that will retain their values after the sub-procedure is exited.
* [$STATIC]($STATIC) (metacommand) defines that all arrays are static or unchangeable in size.
* [SWAP](SWAP) (statement) trades the values of two numerical or string values or array elements.
* [UBOUND](UBOUND) (array function) returns the highest valid index (upper boundary) of an [arrays](arrays).

> See also: [Arrays](Arrays)

### Fixed Program DATA

* [DATA](DATA) (statement) creates a field of built-in program data values separated by commas.
* [READ](READ) (statement) reads the DATA from the data field sequentially.
* [RESTORE](RESTORE) (statement) sets the data pointer to the start of all DATA or a specified DATA field.

## [COLOR](COLOR) and Transparency

* [_ALPHA](_ALPHA) (function) returns the alpha channel transparency level of a color value used on a screen page or image.
* [_ALPHA32](_ALPHA32) (function) function returns the alpha channel level of a 32 bit color value only.
* [_BACKGROUNDCOLOR](_BACKGROUNDCOLOR) (function) returns the current background color.
* [_BLEND](_BLEND) (statement) turns on alpha blending for the current image or a specific one.
* [_BLEND (function)](_BLEND-(function)) returns if blending is enabled or disabled for the current window or a specified image handle.
* [_BLINK](_BLINK) (statement) statement turns blinking colors on/off in SCREEN 0
* [_BLINK (function)](_BLINK-(function)) returns -1 if enabled or 0 if disabled by [_BLINK](_BLINK) statement.
* [_BLUE](_BLUE) (function) returns the palette intensity OR the blue component intensity of a 32-bit image color.
* [_BLUE32](_BLUE32) (function) returns the blue component intensity of a 32-bit image color.
* [_CLEARCOLOR](_CLEARCOLOR) (statement) sets a specific color to be treated as transparent in an image
* [_CLEARCOLOR (function)](_CLEARCOLOR-(function)) returns the current transparent color of an image.
* [_COPYPALETTE](_COPYPALETTE) (statement) copies the color palette intensities from one image to another image or screen page.
* [_DEFAULTCOLOR](_DEFAULTCOLOR) (function) returns the current default text color for an image handle or page.
* [_DONTBLEND](_DONTBLEND) (statement) turns off alpha blending for an image handle.
* [_GREEN](_GREEN) (function) returns the palette index OR the green component intensity of a 32-bit image.
* [_GREEN32](_GREEN32) (function) returns the green component intensity of a 32-bit image color.
* [_NEWIMAGE](_NEWIMAGE) (function) prepares a custom sized program [SCREEN](SCREEN) or page surface that can use 256 or 32 bit colors.
* [_PALETTECOLOR](_PALETTECOLOR) (statement) sets the color value of a palette entry of an image using 256 color modes or less (4 or 8 BPP).
* [_PALETTECOLOR (function)](_PALETTECOLOR-(function)) returns the 32 bit attribute color setting of an image or screen page handle's palette.
* [_PIXELSIZE](_PIXELSIZE) (function) returns the color depth (Bits Per Pixel) of an image.
* [_RED](_RED) (function) returns the palette index OR the red component intensity of a 32-bit screen.
* [_RED32](_RED32) (function) returns the red component intensity of a 32-bit image color.
* [_RGB](_RGB) (function) returns the closest palette attribute index OR the [LONG](LONG) 32 bit color value in 32 bit screens.
* [_RGB32](_RGB32) (function) returns the [LONG](LONG) 32 bit color value only.
* [_RGBA](_RGBA) (function) returns the closest palette attribute index OR the [LONG](LONG) 32 bit color value in [_ALPHA](_ALPHA) screens.
* [_RGBA32](_RGBA32) (function) returns the [LONG](LONG) 32 bit [_ALPHA](_ALPHA) color value only.
* [_SETALPHA](_SETALPHA) (statement) sets the alpha channel transparency level of some or all of the pixel colors of an image.

* [CLS](CLS) (statement) clears the screen and can set the background color in QB64.
* [COLOR](COLOR) (statement) sets the current text color attribute or [_RGB](_RGB) value to be used or background colors in some screen modes.
* [INP](INP) (function) returns the RGB color intensity values from color port register &H3C9 for a specific attributes.
* [OUT](OUT) (statement) sets the color port access mode and sets the RGB color intensity values using &H3C9.
* [PALETTE](PALETTE) (statement) sets the Red, Green and Blue color attribute intensities using a RGB multiplier calculation.
* [PALETTE USING](PALETTE-USING) (statement) sets the color intensity settings using a designated [arrays](arrays).
* [POINT](POINT) (function) returns a pixel coordinate color attribute or the [LONG](LONG) [_RGB](_RGB) color value of a 32 bit color.
* [PRESET](PRESET) (statement) sets a pixel coordinate to the background color or a color specified.
* [PSET](PSET) (statement) sets a pixel coordinate a specified color or uses the current color when not designated.
* [SCREEN](SCREEN) sets the screen mode of a program which may determine the number of colors available in legacy modes.

## [Console Window](Console_Window)

* [$CONSOLE]($CONSOLE) (QB64 [Metacommand](Metacommand)) creates a console window throughout the program.
* [_CONSOLE](_CONSOLE) (statement) can be used to turn the console window OFF or ON or designate it as [_DEST](_DEST) _CONSOLE for output.
* [_CONSOLETITLE](_CONSOLETITLE) (statement) creates a title for the console window using a literal or variable [STRING](STRING).
* [$SCREENHIDE]($SCREENHIDE) (QB64 [Metacommand](Metacommand)) hides the program window throughout the program until [$SCREENSHOW]($SCREENSHOW) is used.
* [_SCREENHIDE](_SCREENHIDE) hides the main program window in a section of code until [_SCREENSHOW](_SCREENSHOW) is used.
* [$SCREENSHOW]($SCREENSHOW) (QB64 [Metacommand](Metacommand)) displays the main program window throughout the program after [$SCREENHIDE]($SCREENHIDE) has been used.
* [_SCREENSHOW](_SCREENSHOW) displays the main program window in a section of code after [_SCREENHIDE](_SCREENHIDE) has been used.
* [SHELL (function)](SHELL-(function)) executes a DOS command or calls another program. Returns codes sent by [END](END) or [SYSTEM](SYSTEM).
* [_SHELLHIDE](_SHELLHIDE) (function) hides a DOS command or call to another program. Returns codes sent by [END](END) or [SYSTEM](SYSTEM).

## Conditional Operations

* [AND (boolean)](AND (boolean)) returns True if all of the arguments are True.
* [NOT](NOT) (boolean) returns the opposite condition of an argument.
* [OR (boolean)](OR (boolean)) returns True if one of the arguments is True.
* [XOR (boolean)](XOR-(boolean)) returns True if only one of two arguments are True.

### Relational Operations

| Operation | Description |
| --- | --- |
| a = b | Tests if a is equal to b. |
| a <> b | Tests if a is not equal to b; equivalent to (NOT (a = b)). |
| a < b | Tests if a is less than b. |
| a > b | Tests if a is greater than b. |
| a <= b | Tests if a is less than or equal to b; equivalent to (NOT (a > b)). |
| a >= b | Tests if a is greater than or equal to b; equivalent to (NOT (a < b)). |

See also: [Logical Bitwise Operations](#logical-bitwise-operations) and [Relational Operations](#relational_operations)

## Definitions and Variable Types

* [_BIT](_BIT) {` numerical [TYPE](TYPE)) values of 0 (bit off) or -1 (bit on). [_UNSIGNED](_UNSIGNED) of 0 or 1.
* [_BYTE](_BYTE) {%% numerical [TYPE](TYPE)) values from -128 to 127 (one byte or 8 [_BIT](_BIT)s). [_UNSIGNED](_UNSIGNED) from 0 to 255.
* [_DEFINE](_DEFINE) (statement)  defines a range of untyped variable names according to their first character as a datatype.
* [_FLOAT](_FLOAT) {## numerical [TYPE](TYPE)) values offer the maximum floating-point decimal precision available using QB64.
* [_INTEGER64](_INTEGER64) (&& numerical [TYPE](TYPE)) values -9223372036854775808 to 9223372036854775807. [_UNSIGNED](_UNSIGNED) to 18446744073709551615.
* [_MEM](_MEM) (variable type) contains read only dot elements for the OFFSET, SIZE, TYPE and ELEMENTSIZE of a block of memory.
* [_OFFSET](_OFFSET)(%& variable type) can store any memory offset integer value when using [DECLARE LIBRARY](DECLARE-LIBRARY) or [_MEM](_MEM)ory only.
* [_UNSIGNED](_UNSIGNED) {~ numerical [TYPE](TYPE)) defines an integer numerical value as being positive only in QB64.
* [COMMON](COMMON) (statement) shares common variable values with other Linked or [CHAIN](CHAIN)ed programs.
* [COMMON SHARED](COMMON SHARED) (statement) shares common variable values with all sub-procedures and other Linked or CHAINed programs.
* [CONST](CONST) (statement) defines one or more named numeric or string shared values which can  not change in a program.
* [DEFDBL](DEFDBL) (statement) defines undefined variable starting letters AS [DOUBLE](DOUBLE) variables instead of the [SINGLE](SINGLE) type default.
* [DEFINT](DEFINT) (statement) defines undefined variable starting letters AS [INTEGER](INTEGER) variables instead of the [SINGLE](SINGLE) type default.
* [DEFLNG](DEFLNG) (statement) defines undefined variable starting letters AS [LONG](LONG) variables instead of the [SINGLE](SINGLE) type default.}}
* [DEFSNG](DEFSNG) (statement) defines undefined variable starting letters AS [SINGLE](SINGLE) variables instead of the [SINGLE](SINGLE) type default.
* [DEFSTR](DEFSTR) (statement) defines undefined variable starting letters AS [STRING](STRING) variables instead of the [SINGLE](SINGLE) type default.
* [DIM](DIM) defines a variable or size a [$STATIC]($STATIC) array and can define the type of value it returns.
* [DOUBLE](DOUBLE) {# numerical [TYPE](TYPE)) an 8 byte floating decimal variable type with numerical values up to 15 decimal places.
* [INTEGER](INTEGER) {% numerical [TYPE](TYPE)) a two byte variable type with values from -32768 to 32767. [_UNSIGNED](_UNSIGNED) to 65535.
* [LONG](LONG) {& numerical [TYPE](TYPE)) Integer values can be from -2147483648 to 2147483647. [_UNSIGNED](_UNSIGNED) values to 4294967295.
* [OPTION BASE](OPTION-BASE) (statement) sets the default starting index of an [arrays](arrays) to 0 or 1.
* [REDIM](REDIM) defines and sizes a [$DYNAMIC]($DYNAMIC)(changeable) array and can define the type of value returned.
* [SHARED](SHARED) (statement) designates variable values that can be shared with sub-procedures without using [SUB](SUB) parameters.
* [SINGLE](SINGLE) (! numerical [TYPE](TYPE)) a 4 byte floating decimal variable type with numerical values up to 7 decimal places.
* [STATIC](STATIC) (statement) defines a variable or list of variables that will retain their values after the sub-procedure is exited.
* [STRING](STRING) ($ variable type) one byte text variable with [ASCII](ASCII) code values from 0 to 255.
* [TYPE](TYPE) (statement) defines variable types that can hold more than one variable type value of a fixed byte length.

See also: [Variable Types](Variable_Types) and  [Libraries#C.2B.2B_Variable_Types](Libraries#C.2B.2B_Variable_Types)

## External Disk and API calls

* [_ACCEPTFILEDROP](_ACCEPTFILEDROP) (statement) turns a program window into a valid drop destination for dragging files from Windows Explorer.
* [_DEVICE$](_DEVICE$) (function) returns a [STRING](STRING) expression listing device names and input types of system input devices.
* [_DEVICES](_DEVICES) (function) returns the number of input devices found on a computer system.
* [_DIREXISTS](_DIREXISTS) (function) returns -1 if the directory folder name [STRING](STRING) parameter exists. Zero if it does not.
* [_DROPPEDFILE](_DROPPEDFILE) (function)  returns the list of items (files or folders) dropped in a program's window after [_ACCEPTFILEDROP](_ACCEPTFILEDROP) is enabled.
* [_CLIPBOARD$ (statement)](_CLIPBOARD$-(statement)) sends [STRING](STRING) data to the Clipboard.
* [_CLIPBOARD$](_CLIPBOARD$) (function) returns the current contents of the Clipboard as a [STRING](STRING).
* [_CLIPBOARDIMAGE (function)](_CLIPBOARDIMAGE-(function)) pastes an image from the clipboard into a new QB64 image in memory.
* [_CLIPBOARDIMAGE](_CLIPBOARDIMAGE) (statement) copies a valid QB64 image to the clipboard.
* [_CWD$](_CWD$) (function) returns the current working directory path as a [STRING](STRING).
* [_DONTWAIT](_DONTWAIT) (SHELL action) allows the program to continue without waiting for the other program to close.
* [_FILEEXISTS](_FILEEXISTS) (function) returns -1 if the file name [STRING](STRING) parameter exists. Zero if it does not.
* [_FINISHDROP](_FINISHDROP) (statement)  resets [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES) and clears the [_DROPPEDFILE](_DROPPEDFILE) list of items (files/folders).
* [_HIDE](_HIDE) ([SHELL](SHELL) action) hides the DOS screen output during a shell.
* [_LASTBUTTON](_LASTBUTTON) (function) returns the number of buttons available on a specified number device listed by [_DEVICE$](_DEVICE$). 
* [_OS$](_OS$) (function)  returns the QB64 compiler version in which the program was compiled as [WINDOWS](WINDOWS), [LINUX](LINUX) or [MACOSX](MACOSX) and [32BIT](32BIT) or [64BIT](64BIT).
* [_SCREENCLICK](_SCREENCLICK)  simulates clicking the mouse at a position on the screen to get focus.
* [_SCREENIMAGE](_SCREENIMAGE)  captures the current desktop screen image.
* [_SCREENPRINT](_SCREENPRINT)  simulates keyboard entries on the desktop. 
* [_SHELLHIDE](_SHELLHIDE) (function) executes a DOS command or calls another program. Returns codes sent by [END](END) or [SYSTEM](SYSTEM).
* [_STARTDIR$](_STARTDIR$) (function) returns the user's program calling path as a [STRING](STRING).
* [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES) (function)  returns the number of items (files or folders) dropped in a program's window after [_ACCEPTFILEDROP](_ACCEPTFILEDROP) is enabled.
* [CHDIR](CHDIR) (statement) changes the program path to a new path.
* [COMMAND$](COMMAND$) (function) returns command line parameters sent when a program is started.
* [ENVIRON](ENVIRON) (statement) temporarily sets an environmental key/pair value.
* [ENVIRON$](ENVIRON$) (function) returns the environmental settings of the computer.
* [FILES](FILES) (statement) displays a specified list of files.
* [MKDIR](MKDIR) (statement) creates a new directory folder in the designated path.
* [NAME](NAME) (statement) renames a file.
* [RMDIR](RMDIR) (statement) removes an empty directory folder from the specified path.
* [SHELL](SHELL) (statement) performs a command line operation in DOS.
* [SHELL (function)](SHELL-(function)) executes a DOS command or calls another program. Returns codes sent by [END](END) or [SYSTEM](SYSTEM).

## Error Codes

The following table describes the error codes that are reported by the QB64 compiler, as well as possible causes and solutions:

**QB/64 Error Codes**

| Code | Description | Common Cause/Resolution | QB64 Difference |
| --- | --- | --- | --- |
| 1 | [NEXT](NEXT) without [FOR](FOR) | Missing loop end or look for a missing [END IF](END-IF) or [END SELECT](END-SELECT) statement. | none |
| 2 | Syntax error | Mistyped keyword statements or punctuation errors can create syntax errors. | none |
| 3 | [RETURN](RETURN) without [GOSUB](GOSUB) | Place sub-procedure line label after program [END](END) or [EXIT](EXIT) in a [SUB](SUB)-procedure. | none |
| 4 | Out of [DATA](DATA) | A [READ](READ) has read past the end of [DATA](DATA). Use [RESTORE](RESTORE) to reset to data start. . | none |
| 5 | Illegal function call | A parameter passed does not match the function type or exceeds certain function limitations. See Illegal Function. | none |
| 6 | Overflow | A numerical value has exceeded the limitations of a variable type. | none |
| 7 | Out of memory | A module has exceeded the 64K memory limitation of QB. Try breaking the code up to smaller modules. | no limit |
| 8 | Label not defined | [GOTO](GOTO) or [GOSUB](GOSUB) tries to branch to a label that doesn't exist. | none |
| 9 | Subscript out of range | An array's upper or lower-dimensioned boundary has been exceeded. | none |
| 10 | Duplicate definition | You can't define a variable twice with [DIM](DIM), the first time a variable is used it is also defined. | none |
| 11 | Division by zero | You cannot divide any value by zero! Even using [MOD](MOD). | none |
| 12 | Illegal in direct mode | A statement (like [DIM](DIM)) in the Immediate window wasn't allowed. | N/A |
| 13 | Type mismatch | A [SUB](SUB) or [FUNCTION](FUNCTION) parameter does not match the procedure Declaration. | none |
| 14 | Out of string space | A module has exceeded the 32767 text character limit. Use SUB print procedures. | no limit. |
| 16 | String formula too complex. | A string formula was too long or [INPUT](INPUT) statement requested more than 15 strings | N/A |
| 17 | Cannot continue. | The program while debugging has changed in a way that it cannot continue. | no debug |
| 18 | Function not defined. | The function used by the program must be defined. Did you include the .bi file while using a library? | none |
| 19 | No [RESUME](RESUME). | Use [RESUME](RESUME) at the end of the [ON ERROR GOTO](ON-ERROR-GOTO) routine, not [RETURN](RETURN). | none |
| 20 | RESUME without error. | [RESUME](RESUME) can only be used in an error handler called by [ON ERROR GOTO](ON-ERROR-GOTO). | none |
| 24 | Device timeout. | Use DS0 (DSzero)in the [OPEN COM](OPEN-COM) statement to avoid modem timeouts. | none |
| 25 | Device fault. | Device not connected or does not exist. | none |
| 26 | [FOR](FOR) without [NEXT](NEXT). | Missing loop end or look for a missing [END IF](END-IF) or [END SELECT](END-SELECT) statement. | none |
| 27 | Out of paper | A printer paper error when using [LPRINT](LPRINT). | none |
| 29 | [WHILE](WHILE) without [WEND](WEND). | [WEND](WEND) must end a [WHILE](WHILE) loop. Otherwise look for missing [END IF](END-IF) or [END SELECT](END-SELECT) | none |
| 30 | [WEND](WEND) without [WHILE](WHILE) | Missing loop end or look for a missing [END IF](END-IF) or [END SELECT](END-SELECT) statement. | none |
| 33 | Duplicate label | Line numbers or labels cannot be used twice in a procedure. | none |
| 35 | Subprogram not defined. | Often occurs when the QuickBASIC Library is not used with [CALL ABSOLUTE](CALL-ABSOLUTE), [INTERRUPT](INTERRUPT), a [SUB](SUB) or [FUNCTION](FUNCTION) procedure has not been created for a [CALL](CALL). | none |
| 37 | Argument-count mismatch | The number of sub procedure parameters do not match the call. | none |
| 38 | Array not defined | Array's using more than 10 elements must be [DIM](DIM)ensioned. | none |
| 40 | Variable required. | [LEN](LEN) cannot read literal numerical values. A [GET](GET) or [PUT](PUT) statement must specify a variable when reading or writing a file opened in [BINARY](BINARY) mode. | none |
| 50 | [FIELD](FIELD) overflow. | A [FIELD](FIELD) statement tried to allocate more bytes than were specified for the record length of a random access file. | none |
| 51 | Internal error. | An internal malfunction occurred in QuickBASIC or QB64. | none |
| 52 | Bad file name or number. | The filename must follow the rules for filenames in the OS and use file numbers from 1 and 255. Use [FREEFILE](FREEFILE) to avoid | duplicate [OPEN](OPEN) file numbers. | none |
| 53 | File not found. | File not in current directory or path. Use [_FILEEXISTS](_FILEEXISTS) to verify file names. | none |
| 54 | Bad file mode. | File access mode does not match a current [OPEN](OPEN) file procedure. | none |
| 55 | File already open. | [CLOSE](CLOSE) a file to open it in a different mode. | none |
| 56 | FIELD statement active. | WRITEME | N/A |
| 57 | Device I/O error. | WRITEME | N/A |
| 58 | File already exists. | The filename specified in the [NAME](NAME) statement was identical to a file that already exists. | none |
| 59 | Bad record length. | Record length exceeds 32767 bytes or is 0 | none |
| 61 | Disk full. | The amount of data to write to the disk was more than the free space available, remove some files you don't need and try again. | none |
| 62 | Input past end of file. | Check for the end of file with [EOF](EOF) when reading from a file. | none |
| 63 | Bad record number. | [GET](GET) read exceeds number of records in a [RANDOM](RANDOM) file. | none |
| 64 | Bad file name | File name contains illegal characters or exceeds 12 characters. | none |
| 67 | Too many files | Over 15 files are open in QBasic. | none |
| 68 | Device unavailable. | Device does not exist, busy or not connected. | none |
| 69 | Communication-buffer overflow. | WRITEME | N/A |
| 70 | Permission denied | A file or port is in use on a network, blocked, read only or locked. | none |
| 71 | Disk not ready. | Disk is busy or has no media. | none |
| 72 | Disk-media error. | Improper media format or bad data. | none |
| 73 | Feature unavailable. | Based on the DOS version available. | none |
| 74 | Rename across disks. | WRITEME | N/A |
| 75 | Path/File access error. | File or path cannot be accessed. | none |
| 76 | Path not found. | Path is not access-able or does not exist. Use [_DIREXISTS](_DIREXISTS) to check paths. | none |
| 97 | (no error message) | Can be used to trigger an error trap event with [ERROR](ERROR) 97, nothing else will cause this error, so create your own errors for [ON ERROR](ON-ERROR). | none |
| 256 | Invalid handle | Zero or bad handle values cannot be used by the QB64 procedure creating the error. | N/A |

*N/A* means Not Available or Not Applicable to QB64.

## Error Trapping

* [_ASSERT](_ASSERT) (statement) Performs debug tests.
* [$ASSERTS]($ASSERTS) (metacommand) Enables the [_ASSERT](_ASSERT) macro* [$CHECKING]($CHECKING) ([Metacommand](Metacommand)) turns off or on error event checking and strips error code from compiled programs.
* [_ERRORLINE](_ERRORLINE) (function) returns the actual text code line where a program error occurred. 
* [ERR](ERR) (function) returns the error code number of the last error to occur.
* [ERROR](ERROR) (statement) simulates a program error based on the error code number used.
* [ERL](ERL) (function) returns the closest line number before an error occurred if the program uses them.
* [ON ERROR](ON-ERROR) (statement) [GOTO](GOTO) sends the program to a line number or label when an error occurs. Use to avoid program errors.
* [RESUME](RESUME) (statement) error statement sends the program to the [NEXT](NEXT) code line or a designated line number or label .

See the [ERROR Codes](ERROR-Codes) reference.

## Event Trapping

* [_AUTODISPLAY](_AUTODISPLAY) (statement) enables the automatic display of the screen image changes previously disabled by [_DISPLAY](_DISPLAY).
* [_DELAY](_DELAY) (statement) suspends program execution for a [SINGLE](SINGLE) value of seconds down to milliseconds.
* [_DISPLAY](_DISPLAY) (statement) turns off automatic display while only displaying the screen changes when called.
*[_EXIT (function)](_EXIT-(function)) prevents a user exit and indicates if a user has clicked the close X window button or CTRL + BREAK.
*[_FREETIMER](_FREETIMER) (function) returns a free TIMER number for multiple [ON TIMER(n)](ON-TIMER(n)) events.
* [_MOUSEINPUT](_MOUSEINPUT) (function) reports any changes to the mouse status and MUST be used to read those changes.
* [_SHELLHIDE](_SHELLHIDE) (function) returns the code sent by a program exit using [END](END) or [SYSTEM](SYSTEM) followed by an [INTEGER](INTEGER) value.

* [OFF](OFF) turns event checking off and does not remember subsequent events.
* [ON](ON) turns event checking on.
* [ON ERROR](ON-ERROR) [GOTO](GOTO) (event statement) executes when a program error occurs
* [ON KEY(n)](ON-KEY(n)) (event statement) executes when a key press or keypress combination occurs.
* [ON TIMER(n)](ON-TIMER(n)) (event statement) executes when a timed event occurs. QB64 can use multiple numbered timers.
* [ON...GOSUB](ON...GOSUB) (event statement) branches to a line number or label according to a numerical ordered list of labels.
* [ON...GOTO](ON...GOTO) (event statement) branches to a line number or label according to a numerical ordered list of labels.
* [STOP](STOP) suspends event checking and remembers subsequent events that are executed when events are turned back on.
* [TIMER](TIMER) (function) returns the number of seconds past the previous midnight down to a QB64 accuracy of one millisecond.
* [TIMER (statement)](TIMER (statement)) enables, turns off or stops timer event trapping. In QB64 TIMER(n) FREE can free multiple timers. 
* [WAIT](WAIT) (statement) normally used to delay program display execution during or after vertical retrace periods.

## File Input and Output

* [_DIREXISTS](_DIREXISTS) (function) returns -1 if the directory folder name [STRING](STRING) parameter exists. Zero if it does not.
* [_FILEEXISTS](_FILEEXISTS) (function) returns -1 if the file name [STRING](STRING) parameter exists. Zero if it does not.
* [ACCESS](ACCESS) (clause) used in a networking [OPEN](OPEN) statement to allow READ or WRITE access to files.
* [APPEND](APPEND) (file mode) opens or creates a file that can be appended with data at the end.
* [BINARY](BINARY) (file mode) opens or creates a file that can be byte accessed using both [GET](GET) and [PUT](PUT).
* [BLOAD](BLOAD) (statement) opens a binary file and loads the contents to a specific array.
* [BSAVE](BSAVE) (statement) creates a binary file that holds the contents of a specified array.
* [CHDIR](CHDIR) (statement) changes the program path to a new path.
* [CLOSE](CLOSE) (statement) closes a specified file or all open files.
* [EOF](EOF) (file function) returns -1 when the end of a file has been read.
* [FIELD](FIELD) (statement) creates a [STRING](STRING) type definition for a random-access file buffer.
* [FILEATTR](FILEATTR) (function) can return a file's current file mode or DOS handle number.
* [FILES](FILES) (statement) displays a specified list of files.
* [FREEFILE](FREEFILE) (file function) returns a file access number that is currently not in use.
* [GET](GET) (file I/O statement) reads file data by byte or record positions.
* [INPUT (file mode)](INPUT (file mode)) only [OPEN](OPEN)s existing sequential files for program INPUT.
* [INPUT (file statement)](INPUT-(file-statement)) reads sequential file data that was created using PRINT # or WRITE #. 
* [INPUT$](INPUT$) (function) reads a specific number of bytes from random or binary files.
* [KILL](KILL) (statement) deletes a specified file without asking for verification. Remove empty folders with [RMDIR](RMDIR).
* [LINE INPUT (file statement)](LINE-INPUT-(file-statement)) reads an entire text row of printed sequential file data.
* [LOC](LOC) (function) finds the current file location or size of a [COM](COM) port receive buffer.
* [LOCK](LOCK) (statement) prevents access to a file.
* [LOF](LOF) (file function) returns the size of a file in bytes.
* [MKDIR](MKDIR) (statement) creates a new folder in the designated path.
* [NAME](NAME) (statement) renames a file [AS](AS) a new file name.
* [OPEN](OPEN) (file I/O statement) opens a specified file FOR an access mode with a set reference number.
* [OUTPUT](OUTPUT) (file mode) opens or creates a new file that holds no data.
* [PRINT (file statement)](PRINT-(file-statement)) writes text and numerical data into a file.
* [PRINT USING (file statement)](PRINT USING (file statement))  writes template formatted text into a file.
* [PUT](PUT) (file I/O statement) writes data into a [RANDOM](RANDOM) or [BINARY](BINARY) file by byte or record position.
* [RANDOM](RANDOM) (file mode) opens or creates a file that can be accessed using both [GET](GET) and [PUT](PUT).
* [RESET](RESET) (statement) closes all files and writes the directory information to a diskette.
* [RMDIR](RMDIR) (statement) removes an empty folder from the specified path.
* [SEEK](SEEK) (function) returns the current read or write byte position in a file.
* [SEEK (statement)](SEEK (statement)) sets the current read or write byte position in a file.
* [UNLOCK](UNLOCK) (statement) unlocks access to a file.
* [WIDTH](WIDTH) (statement) sets the text width of a file.
* [WRITE (file statement)](WRITE (file statement)) writes numerical and string data to a sequential file using comma separators.

## Fonts

* [_FONT (function)](_FONT-(function)) creates a new alpha blended font handle from a designated image handle
* [_FONT](_FONT) (statement) sets the current [_LOADFONT](_LOADFONT) function font handle to be used by [PRINT](PRINT) or [_PRINTSTRING](_PRINTSTRING).
* [_FONTHEIGHT](_FONTHEIGHT) (function) returns the font height of a font handle created by [_LOADFONT](_LOADFONT).
* [_FONTWIDTH](_FONTWIDTH) (function) returns the font width of a MONOSPACE font handle created by [_LOADFONT](_LOADFONT).
* [_FREEFONT](_FREEFONT) (statement) frees a font handle value from memory
* [_LOADFONT](_LOADFONT) (function) loads a TrueType font (.TTF) file of a specific size and style and returns a font handle value.
* [_MAPUNICODE](_MAPUNICODE) (statement) maps a [Unicode](Unicode) value to an [ASCII](ASCII) character code value.
* [_PRINTMODE (function)](_PRINTMODE-(function)) returns the present [_PRINTMODE](_PRINTMODE) status as a numerical value.
* [_PRINTMODE](_PRINTMODE) (statement) sets the text or [_FONT](_FONT) printing mode on a background image when using [PRINT](PRINT) or [_PRINTSTRING](_PRINTSTRING).
  * _KEEPBACKGROUND (1): Text background transparent. Only the text is displayed over anything behind it.
  * _ONLYBACKGROUND (2): Text background is only displayed. Text is transparent to anything behind it.
  * _FILLBACKGROUND (3): Text and background block anything behind them like a normal [PRINT](PRINT). Default setting.
* [_PRINTSTRING](_PRINTSTRING) (statement) prints text or custom font strings using graphic column and row coordinate positions.
* [_PRINTWIDTH](_PRINTWIDTH) (function) returns the width in pixels of the [_FONT](_FONT) or text [STRING](STRING) that a program will print.
* [PRINT](PRINT) (statement) prints numeric or [STRING](STRING) expressions to the program screen.
* [PRINT USING](PRINT-USING) (statement) prints template formatted numeric or string values to the program screen.
* [WRITE](WRITE) (screen I/O statement) writes a comma-separated list of values to the screen.

## Game Controller Input (Joystick)

* [_AXIS](_AXIS) (function) returns a [SINGLE](SINGLE) value between -1 and 1 indicating the maximum distance from device axis center 0.
* [_BUTTON](_BUTTON) (function) returns -1 when a device button is pressed and 0 when button is released.
* [_BUTTONCHANGE](_BUTTONCHANGE) (function) returns -1 when a device button has been pressed and 1 when released. Zero indicates no change.
* [_DEVICE$](_DEVICE$) (function) returns a [STRING](STRING) expression listing a designated numbered input device name and types of input.
* [_DEVICEINPUT](_DEVICEINPUT) (function) returns the [_DEVICES](_DEVICES) number of an [_AXIS](_AXIS), [_BUTTON](_BUTTON) or [_WHEEL](_WHEEL) event.
* [_DEVICES](_DEVICES) (function) returns the number of input devices found on a computer system including the keyboard and mouse.
* [_LASTAXIS](_LASTAXIS) (function) returns the number of axis available on a specified number device listed by [_DEVICE$](_DEVICE$).
* [_LASTBUTTON](_LASTBUTTON) (function) returns the number of buttons available on a specified number device listed by [_DEVICE$](_DEVICE$). 
* [_LASTWHEEL](_LASTWHEEL) (function) returns the number of scroll wheels available on a specified number device listed by [_DEVICE$](_DEVICE$).
* [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX) (function) returns the relative horizontal position of the mouse cursor compared to the previous position.
* [_MOUSEMOVEMENTY](_MOUSEMOVEMENTY) (function) returns the relative vertical position of the mouse cursor compared to the previous position.
* [_WHEEL](_WHEEL) (function) returns -1 when a device wheel is scrolled up and 1 when scrolled down. Zero indicates no activity.
* [ON STRIG(n)](ON-STRIG(n)) (event statement) directs program flow upon a button press event of a game controller device.
* [STICK](STICK) (function) returns the directional axis coordinate values from 1 to 254 of game port (&H201) or USB controller devices.
* [STRIG](STRIG) (function) returns the True or False button press status of game port (&H201) or USB controller devices.
* [STRIG(n)](STRIG(n)) (statement) enables, suspends or disables event trapping of [STRIG](STRIG) button return values.

## Graphic Commands

* [_COPYIMAGE](_COPYIMAGE) (function) can copy a software surface to a hardware accelerated surface handle using mode 33.
* [_DISPLAY](_DISPLAY) (statement) renders surfaces visible in the [_DISPLAYORDER](_DISPLAYORDER) previously set in the QB64 program.
* [_DISPLAYORDER](_DISPLAYORDER) sets the rendering order of [_SOFTWARE](_SOFTWARE), [_HARDWARE](_HARDWARE) and [_GLRENDER](_GLRENDER) with [_DISPLAY](_DISPLAY).
* [_LOADIMAGE](_LOADIMAGE) (function) can load images as hardware accelerated using mode 33.
* [_MOUSESHOW](_MOUSESHOW) (statement) a special string parameter after command in GL allows some special cursor shapes.
* [_PUTIMAGE](_PUTIMAGE) (statement) can place GL surfaces and allows the _SMOOTH action to blend stretched surfaces.

## Graphics and Imaging

* [_AUTODISPLAY](_AUTODISPLAY) (statement) enables the automatic display of the screen image changes previously disabled by [_DISPLAY](_DISPLAY).
* [_CLIP](_CLIP) ([PUT (graphics statement)](PUT-(graphics-statement)) action) allows placement of an image partially off of the screen.
* [_COPYIMAGE](_COPYIMAGE) (function) function duplicates an image handle from a designated handle.
* [_COPYPALETTE](_COPYPALETTE) (statement) copies the color palette intensities from one image to another image or screen page.
* [_DEST](_DEST) (statement) sets the current write image or page. All graphics will go to this image.
* [_DEST (function)](_DEST-(function)) returns the current write destination image or page.
* [_DISPLAY](_DISPLAY) (statement) turns off automatic display while only displaying the screen changes when called.
* [_DISPLAY (function)](_DISPLAY-(function)) returns the handle of the current image that is displayed on the screen.
* [_FULLSCREEN (function)](_FULLSCREEN-(function)) returns the present full screen mode setting of the screen window.
* [_FULLSCREEN](_FULLSCREEN) (statement) sets the full screen mode of the screen window. Alt + Enter can do it manually.
* [_FREEIMAGE](_FREEIMAGE) (statement) releases an image handle value from memory when no longer needed.
* [_HEIGHT](_HEIGHT) (function) returns the height of an image handle or current write page.
* [_ICON](_ICON) (function) places an image in the title bar using a [_LOADIMAGE](_LOADIMAGE) handle.
* [_LOADIMAGE](_LOADIMAGE) (function) loads a graphic file image into memory and returns an image handle.
* [_MAPTRIANGLE](_MAPTRIANGLE) (statement) maps a triangular portion of an image to a destination image or screen page.
* [_NEWIMAGE](_NEWIMAGE) (function) prepares a window image or page surface and returns the handle value.
* [_PIXELSIZE](_PIXELSIZE) (function) returns the color depth (Bits Per Pixel) of an image.
* [_PRINTSTRING](_PRINTSTRING) (statement) prints text or custom font strings using graphic column and row coordinate positions.
* [_PUTIMAGE](_PUTIMAGE) (statement) maps a rectangular area of a source image to an area of a destination image in one operation
* [_SCREENIMAGE](_SCREENIMAGE) (function) creates an image of the current desktop and returns an image handle.
* [_SOURCE](_SOURCE) (statement) establishes the image SOURCE using a designated image handle
* [_SOURCE (function)](_SOURCE-(function)) returns the present image _SOURCE handle value.
* [_WIDTH (function)](_WIDTH-(function)) returns the width of an image handle or current write page.
* [CIRCLE](CIRCLE) (statement) is used in graphics SCREEN modes to create circles, arcs or ellipses.
* [CLS](CLS) (statement) clears a screen page or the program [SCREEN](SCREEN). QB64 can clear with a color.
* [COLOR](COLOR) (statement) sets the current text color attribute or [_RGB](_RGB) value to be used or background colors in some screen modes.
* [DRAW](DRAW) (statement) uses a special type of [STRING](STRING) expression to draw lines on the screen.
* [GET (graphics statement)](GET-(graphics-statement)) used to store a box area image of the screen into an [INTEGER](INTEGER) array.
* [LINE](LINE) (statement) used in graphic [SCREEN](SCREEN) modes to create lines or boxes.
* [PAINT](PAINT) (statement) used to color enclosed graphic objects with a designated fill color and border color.
* [PALETTE](PALETTE) (statement) can swap color settings, set colors to default or set the Red, Green, Blue color palette.
* [PALETTE USING](PALETTE-USING) (statement) sets all RGB screen color intensities using values from an array.
* [PCOPY](PCOPY) (statement) copies one source screen page to a destination page in memory.
* [PMAP](PMAP) (function) returns the physical or [WINDOW](WINDOW) view coordinates.
* [POINT](POINT) (function) returns the pixel [COLOR](COLOR) attribute or [_RGB](_RGB) value at a specified graphics coordinate.
* [PRESET](PRESET) (statement) sets a pixel coordinate to the background color or a designated color.
* [PSET](PSET) (statement) sets a pixel coordinate to the default color or designated color attribute.
* [PUT (graphics statement)](PUT-(graphics-statement)) statement is used to place [GET (graphics statement)](GET-(graphics-statement)) saved or [BSAVE](BSAVE)d images stored in an array.
* [SCREEN](SCREEN) sets the screen mode of a program. No statement defaults the program to SCREEN 0 text only mode.
* [STEP](STEP) (relational statement) is used to step through FOR loop values or use relative graphical coordinates.
* [VIEW](VIEW) (graphics statement) creates a graphics view port area by defining the coordinate limits to be viewed.
* [WINDOW](WINDOW) (statement) defines the coordinate dimensions of the current graphics viewport.

See also: [Bitmaps](Bitmaps), [Icons and Cursors](Icons_and_Cursors), [SAVEIMAGE](SAVEIMAGE), [GIF Images](GIF-Images)

## Keyboard Input

* [_CONTROLCHR](_CONTROLCHR) (statement) [OFF](OFF) allows the control characters to be used as text characters. [ON](ON)(default) can use them as commands.
* [_CONTROLCHR (function)](_CONTROLCHR-(function))   returns the current state of _CONTROLCHR as 1 when OFF and 0 when ON.
* [_EXIT (function)](_EXIT-(function)) prevents a program user exit and indicates if a user has clicked the close X window button or CTRL + BREAK.
* [_KEYDOWN](_KEYDOWN) (function) returns whether modifying keys like CTRL, ALT, SHIFT, and any other keys are pressed.
* [_KEYHIT](_KEYHIT) (function) returns ASCII one and two byte, SDL Virtual Key and Unicode keyboard key press codes.
* [_SCREENPRINT](_SCREENPRINT) (statement) simulates typing text into another OS program using the keyboard.
* [INKEY$](INKEY$) (function) returns the [ASCII](ASCII) [STRING](STRING) character of a keypress.
* [INPUT](INPUT) (statement) requests a [STRING](STRING) or numerical keyboard entry from a program user.
* [INPUT$](INPUT$) (function) used to get a set number of keypress characters or bytes from a file.
* [INP](INP) (function) returns a scan code value from keyboard register &H60(96) to determine key presses.
* [KEY n](KEY-n) (event statement) is used to assign a "softkey" string to a key and/or display them.
* [KEY(n)](KEY(n)) (event statement) assigns, enables, disables or suspends event trapping of a keypress.
* [KEY LIST](KEY-LIST) (statement) lists the 12 Function key soft key string assignments going down left side of screen.
* [LINE INPUT](LINE-INPUT) (statement) requests a [STRING](STRING) keyboard entry from a program user.
* [ON KEY(n)](ON-KEY(n)) (event statement) defines a line number or label to go to when a specified key is pressed.
* [SLEEP](SLEEP) (statement) pauses the program for a specified number of seconds or a until a key press.

See also: [Keyboard scancodes](Keyboard_scancodes), [ASCII](ASCII) references or [Windows Libraries](Windows-Libraries).

## [Libraries](Libraries)

* [_OFFSET (function)](_OFFSET-(function)) returns the memory offset of a variable when used with [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY) only.
* [_OFFSET](_OFFSET)(variable type) can be used store the value of an offset in memory when using [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY) only.

* [ALIAS](ALIAS) (statement) tells the program that you will use a different name than the name used in the Library file.
* [BYVAL](BYVAL) (statement) used to pass a parameter's value with sub-procedures from a Library.
* [DECLARE LIBRARY](DECLARE-LIBRARY) allows the use of OS specific, SDL or C++ external library [SUB](SUB) and [FUNCTION](FUNCTION) procedures
* [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY) declares DYNAMIC, CUSTOMTYPE or STATIC  library(DLL) [SUB](SUB)s or [FUNCTION](FUNCTION)s.
* [DECLARE LIBRARY](DECLARE-LIBRARY) required at the END of the block of Library declarations in QB64.

QB64 also supports [$INCLUDE]($INCLUDE) text code file Libraries. QB64 does not support QLB Libraries or OBJ files.

See also: [Libraries](Libraries)

## Logical Bitwise Operations

* [AND](AND) (operator) the bit is set when both bits are set.
* [EQV](EQV) (operator) the bit is set when both are set or both are not set.
* [IMP](IMP) (operator) the bit is set when both are set or both are unset or the second condition bit is set.
* [OR](OR) (operator) the bit is set when either bit is set.
* [NOT](NOT) (operator) the bit is set when a bit is not set and not set when a bit is set.
* [XOR](XOR) (operator) the bit is set when just one of the bits are set.

The results of the bitwise logical operations, where A and B are operands, and T and F indicate that a bit is set or not set:

**Operands and Operations**

| A | B |   | NOT B | A AND B | A OR B | A XOR B | A EQV B | A IMP B |
| - | - | - | - | - | - | - | - | - |
| T | T |   | F | T | T | F | T | T |
| T | F |   | T | F | T | T | F | F |
| F | T |   | F | F | T | T | F | T |
| F | F |   | T | F | F | F | T | T |

Relational Operations return negative one (-1, all bits set) and zero (0, no bits set) for *true* and *false*, respectively. This allows relational tests to be inverted and combined using the bitwise logical operations.

## Mathematical Functions and Operations

* [_ROUND](_ROUND) (function) rounds to the closest EVEN [INTEGER](INTEGER), [LONG](LONG) or [_INTEGER64](_INTEGER64) numerical value.

* [+](+)
* [-](-)
* [*](*)
* [/](/)
* [\\](\\)
* [^](^)
* [MOD](MOD)

* [ABS](ABS) (function) returns the the positive value of a variable or literal numerical value.
* [ATN](ATN) (function) or arctangent returns the angle in radians of a numerical [TAN](TAN) value.
* [CDBL](CDBL) (function) closest double rounding function
* [CINT](CINT) (function) closest integer rounding function
* [CLNG](CLNG) (function) closest long integer rounding function
* [COS](COS) (function) cosine of a radian angle
* [CSNG](CSNG) (function) closest single rounding function
* [EXP](EXP) (function) returns the value of e to the power of the parameter used.
* [FIX](FIX) (function) rounds positive or negative values to integer values closer to 0
* [INT](INT) (function) rounds to lower integer value
* [LOG](LOG) (function) natural logarithm of a specified numerical value.
* [SIN](SIN) (function) sine of a radian angle.
* [SQR](SQR) (function) square root of a positive number.
* [TAN](TAN) (function) returns the ratio of [SIN](SIN)e to [COS](COS)ine or tangent value of an angle measured in radians.

See also: [Mathematical Operations](Mathematical-Operations) and [#Logical Bitwise Operations:](#logical_bitwise_operations)

## Memory Handling and Clipboard

* [_CLIPBOARD$](_CLIPBOARD$) (function) returns the current [STRING](STRING) contents of the system Clipboard.
* [_CLIPBOARD$ (statement)](_CLIPBOARD$-(statement)) sets and overwrites the [STRING](STRING) contents of the current system Clipboard.
* [_MEM (function)](_MEM-(function)) returns _MEM block referring to the largest continuous memory region beginning at a designated variable's offset.
* [_MEM](_MEM) (variable type) contains read only dot elements for the OFFSET, SIZE, TYPE and ELEMENTSIZE of a block of memory.
* [_MEMCOPY](_MEMCOPY) (statement) copies a value from a designated OFFSET and SIZE [TO](TO) a block of memory at a designated OFFSET.
* [_MEMELEMENT](_MEMELEMENT) (function) returns a [_MEM](_MEM) block referring to a variable's memory (but not past it).
* [_MEMEXISTS](_MEMEXISTS) (function) verifies that a memory block exists for a memory variable name or returns zero.
* [_MEMFILL](_MEMFILL) (statement) fills a designated memory block OFFSET with a certain SIZE and TYPE of value.
* [_MEMFREE](_MEMFREE) (statement) frees a designated memory block in a program. Only free memory once!
* [_MEMGET](_MEMGET) (statement) reads a designated value from a designated memory OFFSET
* [_MEMGET (function)](_MEMGET-(function)) returns a value from a designated memory block and OFFSET using a designated variable [TYPE](TYPE).
* [_MEMIMAGE](_MEMIMAGE) (function) returns a [_MEM](_MEM) block referring to a designated image handle's memory
* [_MEMNEW](_MEMNEW) (function) allocates new memory with a designated SIZE and returns a [_MEM](_MEM) block referring to it.
* [_MEMPUT](_MEMPUT) (statement) places a designated value into a designated memory [_OFFSET](_OFFSET)
* [_OFFSET (function)](_OFFSET-(function)) returns the memory offset of a variable when used with [DECLARE LIBRARY](DECLARE-LIBRARY) or [_MEM](_MEM) only.
* [_OFFSET](_OFFSET)(%& numerical type) can be used store the value of an offset in memory when using [DECLARE LIBRARY](DECLARE-LIBRARY) or [_MEM](_MEM) only.

## Functions and statements using QB64's emulated 16 bit memory

* [DEF SEG](DEF-SEG) (statement) defines the segment address in memory.
* [PEEK](PEEK) (function) returns the value that is contained at a certain memory address offset.
* [POKE](POKE) (statement) sets the value of a specified memory address offset.
* [SADD](SADD) (function) returns the address of a STRING variable as an offset from the current data segment.
* [VARPTR](VARPTR) (function) returns an [INTEGER](INTEGER) value that is the offset pointer of the memory address within it's [segment](segment).
* [VARPTR$](VARPTR$) (function) returns a STRING representation of a variable's memory address value
* [VARSEG](VARSEG) (function) returns an [INTEGER](INTEGER) value that is the [segment](segment) part of a variable or array memory address.

See also: [Screen Memory](Screen_Memory) or [Using _OFFSET](Using_OFFSET)

## Metacommands

> Metacommands are commands that affect a program globally after they are in used. Error checking can be turned [OFF](OFF) or [ON](ON).

**QB64 [Metacommand](Metacommand)s do NOT allow commenting or [REM](REM)!**

* [$CHECKING]($CHECKING):OFF/ON (QB64 only) turns event and error checking ON and OFF. ON (default) can only be used after it is OFF.
* [$CONSOLE]($CONSOLE) creates a console window throughout the program.
* [$SCREENHIDE]($SCREENHIDE) hides the program window throughout the program until [$SCREENSHOW]($SCREENSHOW) is used.
* [$SCREENSHOW]($SCREENSHOW) displays the main program window throughout the program only after [$SCREENHIDE]($SCREENHIDE) or [_SCREENHIDE](_SCREENHIDE) has been used.

**QBasic [Metacommand](Metacommand)s do not require commenting or [REM](REM) in QB64!**

* '[$DYNAMIC]($DYNAMIC) defines that all arrays are dynamic or changeable in size using [DIM](DIM) or [REDIM](REDIM).
* '[$INCLUDE]($INCLUDE): 'filename$' includes a text library file with procedures to be used in a program. Comment both sides of file name also.
* '[$STATIC]($STATIC) defines that all arrays are static or unchangeable in size using [DIM](DIM).  

## Mouse Input

* [_AXIS](_AXIS) (function) returns a [SINGLE](SINGLE) value between -1 and 1 indicating the maximum distances from device center 0.
* [_BUTTON](_BUTTON) (function) returns -1 when a device button is pressed and 0 when button is released. 2 is the mouse center or scroll button
* [_BUTTONCHANGE](_BUTTONCHANGE) (function) returns -1 when a device button has been pressed and 1 when released. Zero indicates no change.
* [_DEVICE$](_DEVICE$) (function) returns a [STRING](STRING) expression listing device names and input types of system input devices.
* [_DEVICEINPUT](_DEVICEINPUT) (function) returns the [_DEVICES](_DEVICES) number of an [_AXIS](_AXIS), [_BUTTON](_BUTTON) or [_WHEEL](_WHEEL) event. Mouse is normally _DEVICEINPUT(2).
* [_DEVICES](_DEVICES) (function) returns the number of input devices found on a computer system. The mouse is normally device 2.
* [_EXIT (function)](_EXIT-(function)) prevents a program user exit and indicates if a user has clicked the close X window button or CTRL + BREAK.
* [_LASTAXIS](_LASTAXIS) (function) returns the number of axis available on a specified number device listed by [_DEVICE$](_DEVICE$).
*[_LASTBUTTON](_LASTBUTTON) (function) returns the number of buttons available on a specified number device listed by [_DEVICE$](_DEVICE$). 
* [_LASTWHEEL](_LASTWHEEL) (function) returns the number of scroll wheels available on a specified number device listed by [_DEVICE$](_DEVICE$).
* [_MOUSEBUTTON](_MOUSEBUTTON) (function) returns whether a specified mouse button number has been clicked. 3 is the mouse center or scroll button
* [_MOUSEHIDE](_MOUSEHIDE) (statement) hides the OS mouse pointer from view.
* [_MOUSEINPUT](_MOUSEINPUT) (function) must be used to monitor and read all changes in the mouse status.
* [_MOUSEMOVE](_MOUSEMOVE) (statement) moves the mouse cursor pointer to a designated coordinate.
* [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX) (function) returns the relative horizontal position of the mouse cursor.
* [_MOUSEMOVEMENTY](_MOUSEMOVEMENTY) (function) returns the relative vertical position of the mouse cursor.
* [_MOUSESHOW](_MOUSESHOW) (statement) displays(default) the mouse cursor after it has been hidden.
* [_MOUSEWHEEL](_MOUSEWHEEL) (function) returns a positive or negative count the mouse scroll wheel clicks since the last read.
* [_MOUSEX](_MOUSEX) (function) indicates the current horizontal position of the mouse pointer.
* [_MOUSEY](_MOUSEY) (function) indicates the current vertical position of the mouse pointer.
* [_SCREENCLICK](_SCREENCLICK)  simulates clicking the mouse at a position on the screen to get focus.
* [_WHEEL](_WHEEL) (function) returns -1 when a device wheel is scrolled up and 1 when scrolled down. Zero indicates no activity.

* [CALL ABSOLUTE](CALL-ABSOLUTE) (statement) used to access Interrupt vector &H33 to work with the mouse. Functions 0 to 3 implemented.
* [INTERRUPT](INTERRUPT) (statement) used to access Interrupt vector &H33 to work with the mouse. Functions 0 to 3 implemented. 

## Numerical Manipulation and Conversion

* [_CV](_CV) (function)  used to convert [_MK$](_MK$) [ASCII](ASCII) [STRING](STRING) values to specified numerical value types.
* [_MK$](_MK$) (function)  converts a specified numerical type into an [ASCII](ASCII) [STRING](STRING)  value that must be converted back using [_CV](_CV).
* [_PRESERVE](_PRESERVE) ([REDIM](REDIM) action) preserves the current contents of an [arrays](arrays), when re-dimensioning it.
* [_UNSIGNED](_UNSIGNED) {numerical [TYPE](TYPE)) defines a numerical value as being positive only using QB64.

* [ABS](ABS) (function) returns the the positive value of a variable or literal numerical value.
* [ASC](ASC) (function) returns the [ASCII](ASCII) code number of a certain [STRING](STRING) text character or a keyboard press.
* [CDBL](CDBL) (function) converts a numerical value to the closest [DOUBLE](DOUBLE)-precision value.
* [CHR$](CHR$) (function) returns the character associated with a certain [ASCII](ASCII) character code as a [STRING](STRING).
* [CINT](CINT) (function) returns the closest [INTEGER](INTEGER) value of a number.
* [CLEAR](CLEAR) (statement) clears all variable values to 0 or null [STRING](STRING) and closes all open files.
* [CLNG](CLNG) (function)  rounds decimal point numbers up or down to the nearest [LONG](LONG) integer value.
* [CSNG](CSNG) (function) converts a numerical value to the closest [SINGLE](SINGLE)-precision number.
* [CVD](CVD) (function) converts [STRING](STRING) values to [DOUBLE](DOUBLE) numerical values.
* [CVDMBF](CVDMBF) (function) converts a 8-byte Microsoft Binary format [STRING](STRING) value to a [DOUBLE](DOUBLE) precision number.
* [CVI](CVI) (function) converts 2 byte STRING values to [INTEGER](INTEGER) numerical values.
* [CVL](CVL) (function) converts 4 byte STRING values to [LONG](LONG) numerical values.
* [CVS](CVS) (function) converts 4 byte STRING values to [SINGLE](SINGLE) numerical values.
* [CVSMBF](CVSMBF) (function) converts a 4-byte Microsoft Binary format [STRING](STRING) value to a [SINGLE](SINGLE)-precision number.
* [DIM](DIM) (statement) used to declare a variable type or dimension a [STATIC](STATIC) array.
* [ERASE](ERASE) (array statement) clears a [STATIC](STATIC) array of all values and totally removes a [$DYNAMIC]($DYNAMIC) array.
* [HEX$](HEX$) (function) converts the [INTEGER](INTEGER) part of any value to hexadecimal [STRING](STRING) number value.
* [INT](INT) (function) rounds a numeric value down to the next whole number or [INTEGER](INTEGER) value.
* [LEN](LEN) (function) returns the byte size of strings or numerical variables.
* [OCT$](OCT$) (function) converts the [INTEGER](INTEGER) part of any value to octal [STRING](STRING) number value.
* [RANDOMIZE](RANDOMIZE) (statement) seeds the [RND](RND) random number generation sequence.
* [REDIM](REDIM) (statement) re-dimensions the number of elements in a [$DYNAMIC]($DYNAMIC)(resizeable) [arrays](arrays).
* [RND](RND) (function) returns a randomly generated number from 0 to .9999999
* [SGN](SGN) (function) returns the sign as -1 for negative, zero for 0 and 1 for positive numerical values.
* [STR$](STR$) (function) converts a numerical value to a [STRING](STRING) value.
* [SWAP](SWAP) (statement) trades the values of two numerical types or [STRING](STRING).
* [VAL](VAL) (function) converts number [STRING](STRING) into numerical values until it runs into a non-numeric character.

## Port Input and Output (COM and LPT)

* [COM(n)](COM(n)) (statement) used in an OPEN COM statement to open "COM1" or "COM2".

* [GET](GET) (file I/O statement) reads port data data by byte or record positions.
* [LOC](LOC) (function) finds the current file location or size of a [COM](COM) port receive buffer.

* [ON COM(n)](ON COM(n)) (event statement) branches to a line number or label when there is a value in the serial port specified.
* [OPEN COM](OPEN-COM) (statement) opens a computer serial COMmunications port.
* [OUT](OUT) (statement) sends values to register or port hardware addresses (emulated - limited access).

* [PRINT (file statement)](PRINT_(file_statement)) writes text and numerical data to a port transmit buffer.
* [PUT](PUT) (file I/O statement) writes data into a [RANDOM](RANDOM) or [BINARY](BINARY) port by byte or record position.

See [Port Access Libraries](Port_Access_Libraries) for other ways to access COM and LPT ports.

## Print formatting

* [LPRINT USING](LPRINT_USING) (statement) prints template formatted [STRING](STRING) text to an LPT or USB  printer page.
* [PRINT USING](PRINT_USING) (statement) prints template formatted [STRING](STRING) text to the screen.
* [PRINT USING (file statement)](PRINT_USING_(file_statement)) prints template formatted [STRING](STRING) text to a text file.

Template is a literal or variable string using the following formatting characters:

| Pattern | Description |
| -- | -- |
| & | Prints an entire string value. STRING length should be limited as template width will vary. |
| \  \ | Denotes the start and end point of a fixed string area with spaces between(LEN = spaces + 2). |
| ! | Prints only the leading character of a string value. Exclamation points require underscore prefix. |
| # | Denotes a numerical digit. An appropriate number of digits should be used for values received. |
| ^^^^ | After # digits prints numerical value in exponential E+xx format. Use ^^^^^ for E+xxx values.`*` |
| . | Period sets a number's decimal point position. Digits following determine rounded value accuracy. |
| ,. | Comma to left of decimal point, prints a comma every 3 used # digit places left of the decimal point. |
| + | Plus sign denotes the position of the number's sign. + or - will be displayed. |
| - | Minus sign (dash) placed after the number, displays only a negative value's sign. |
| $ | Prints a dollar sign immediately before the highest non-zero # digit position of the numerical value. |
| ** | Prints an asterisk in any leading empty spaces of a numerical value. Adds 2 extra digit positions. |
| **$ | Combines ** and $. Negative values will display minus sign to left of $. |
| _ | Underscore preceding a format symbol prints those symbols as literal string characters. |

Note: Any string character not listed above will be printed as a literal text character.

`*` Any # decimal point position may be specified. The exponent is adjusted with significant digits left-justified.

## Printer Output (LPT and USB)

* [_PRINTIMAGE](_PRINTIMAGE) (statement) prints an image stretched to the size of the paper setting of an LPT or USB printer.

* [LPOS](LPOS) (function) returns the current parallel(LPT) printer head position.
* [LPRINT](LPRINT) (statement) prints text to an LPT or USB printer page.
* [LPRINT USING](LPRINT_USING) (statement) prints template formatted [STRING](STRING) text to an LPT or USB  printer page.

QB64 will use the default system printer selected. [_PRINTIMAGE](_PRINTIMAGE) images will be stretched to the paper size setting.

## Program Flow and Loops

* [_CONTINUE](_CONTINUE) (statement) skips the remaining lines in a control block (DO/LOOP, FOR/NEXT or WHILE/WEND)
* [_DEST](_DEST) (statement) sets the current write image or page. All graphics will go to this image.
* [_DEST (function)](_DEST-(function)) returns the current write destination image or page.
* [_EXIT (function)](_EXIT-(function)) prevents a user exit and indicates if a user has clicked the close X window button or CTRL + BREAK.
* [_SOURCE](_SOURCE) (statement) establishes the image SOURCE using a designated image handle
* [_SOURCE (function)](_SOURCE-(function)) returns the present image _SOURCE handle value.
* [_SHELLHIDE](_SHELLHIDE) (function) returns the code sent by a program exit using [END](END) or [SYSTEM](SYSTEM) followed by an [INTEGER](INTEGER) value.

* [CALL](CALL) (statement) sends code execution to a subroutine procedure in a program.
* [CASE](CASE) ([SELECT CASE](SELECT_CASE) statement) used within a SELECT CASE block to specify a conditional value of the compared variable.
* [CASE ELSE](CASE_ELSE) ([SELECT CASE](SELECT_CASE) statement) used in a SELECT CASE block to specify an alternative to other CASE values.
* [CASE IS](CASE_IS) ([SELECT CASE](SELECT_CASE) statement) used within a SELECT CASE block to specify a conditional value of the compared variable.
* [DO...LOOP](DO...LOOP) (loop statement) used in programs to repeat code or return to the start of a procedure.
* [ELSE](ELSE) (statement) used in [IF...THEN](IF...THEN) statements to offer an alternative to other conditional statements.
* [ELSEIF](ELSEIF) (statement) used in [IF...THEN](IF...THEN) block statements to offer an alternative conditional statement.
* [END](END) (statement) ENDs a conditional block statement, a sub-procedure or ends the program with "Press any key..."
* [END IF](END-IF) (IF statement end) ENDs an IF statement block.
* [ERROR](ERROR) (error statement) used to simulate an error in a program.
* [EXIT](EXIT) (statement) exits a loop, function or sub-procedure early.
* [FOR...NEXT](FOR...NEXT) (statement) a counter loop procedure that repeats code a specified number of times.
* [GOSUB](GOSUB) (statement) send the program to a designated line label procedure in the main module or a [SUB](SUB) procedure.
* [GOTO](GOTO) (statement) sends the program to a designated line number or label.
* [IF...THEN](IF...THEN) (statement) a conditional flow statement or block of statements.
* [LOOP](LOOP) end of a DO...LOOP procedure that repeats code until or while a condition is true.
* [RESUME](RESUME) (error statement) an error statement that can return the program to the NEXT code line or a specific line number.
* [RETURN](RETURN) (statement) a sub-procedure statement that returns the program to the code immediately after the procedure call.
* [RUN](RUN) (statement) clears and restarts the program currently in memory or executes another specified program.
* [SELECT CASE](SELECT_CASE) (statement) determines the program flow by comparing the value of a variable to specific values.
* [SHELL](SHELL) (DOS statement) directly accesses the Operating System's command line procedures.
* [SLEEP](SLEEP) (statement) stops program progression for a specific number of seconds or until a key press is made.
* [STEP](STEP) (relational statement) is used to step through FOR loop values or use relative graphical coordinates.
* [STOP](STOP) (statement) is used when troubleshooting a program to stop the program at a specified code line.
* [SYSTEM](SYSTEM) (statement) immediately exits a program and closes the program window.
* [UNTIL](UNTIL) (conditional statement) continues a DO LOOP procedure until a condition is true.
* [WHILE](WHILE) (statement) continues a DO LOOP procedure while a condition is true.
* [WHILE...WEND](WHILE...WEND) (statement) a loop procedure that repeats code while a condition is true.

## Sounds and Music

* [_SNDBAL](_SNDBAL) (statement) sets the balance or 3D position of a sound.
* [_SNDCLOSE](_SNDCLOSE) (statement) frees and unloads an open sound using a _SNDOPEN or _SNDCOPY handle.
* [_SNDCOPY](_SNDCOPY) (function) copies a sound to a new handle so that two or more of the same sound can be played at once.
* [_SNDGETPOS](_SNDGETPOS) (function) returns the current playing position in seconds of a designated sound handle.
* [_SNDLEN](_SNDLEN) (function) returns the length of a sound in seconds of a designated sound handle.
* [_SNDLIMIT](_SNDLIMIT) (statement) stops playing a sound after it has been playing for a set number of seconds.
* [_SNDLOOP](_SNDLOOP) (statement) loops the playing of a specified sound handle.
* [_SNDOPEN](_SNDOPEN) (function) loads a sound file with certain capabilities and returns a handle value.
* [_SNDPAUSE](_SNDPAUSE) (statement) pauses a specified sound handle if it is playing.
* [_SNDPAUSED](_SNDPAUSED) (function) returns the pause status of a specified sound handle.
* [_SNDPLAY](_SNDPLAY) (statement) plays a designated sound file handle.
* [_SNDPLAYCOPY](_SNDPLAYCOPY) (statement) copies a sound, plays it and automatically closes the copy using a handle parameter
* [_SNDPLAYFILE](_SNDPLAYFILE) (statement) a simple command to play a sound file with limited options.
* [_SNDPLAYING](_SNDPLAYING) (function) returns whether a sound handle is being played.
* [_SNDRATE](_SNDRATE) (function) returns the sample rate frequency per second of the current computer's sound card.
* [_SNDRAW](_SNDRAW) (statement) plays sound wave sample frequencies created by a program.
* [_SNDRAWDONE](_SNDRAWDONE) (statement) pads a [_SNDRAW](_SNDRAW) stream so the final (partially filled) buffer section is played.
* [_SNDRAWLEN](_SNDRAWLEN) (function) returns the length, in seconds, of a _SNDRAW sound currently queued.
* [_SNDOPENRAW](_SNDOPENRAW) (function) returns a handle to a new, separate [_SNDRAW](_SNDRAW) audio stream.
* [_SNDSETPOS](_SNDSETPOS) (statement) changes the current/starting playing position of a sound in seconds.
* [_SNDSTOP](_SNDSTOP) (statement) stops a playing or paused sound handle.
* [_SNDVOL](_SNDVOL) (statement) sets the volume of a sound handle being played.

* [BEEP](BEEP) (statement) makes a beep sound when called or CHR$(7) is printed.
* [PLAY](PLAY) (music statement) uses a custom string statement to play musical notes.
* [SOUND](SOUND) (statement) creates sounds of a specified frequency for a set duration.

## String Text Manipulation and Conversion

* [_CLIPBOARD$](_CLIPBOARD$) (function) returns the current [STRING](STRING) contents of the system Clipboard.
* [_CLIPBOARD$ (statement)](_CLIPBOARD$-(statement)) sets the [STRING](STRING) contents of the current system Clipboard.
* [_CONTROLCHR](_CONTROLCHR) (statement) [OFF](OFF) allows the control characters to be used as text characters. [ON](ON)(default) can use them as commands.
* [_CONTROLCHR (function)](_CONTROLCHR-(function))   returns the current state of _CONTROLCHR as 1 when OFF and 0 when ON.
* [_CV](_CV) (function)  used to convert [_MK$](_MK$) [ASCII](ASCII) [STRING](STRING) values to numerical values.
* [_MK$](_MK$) (function)  converts any numerical type into an [ASCII](ASCII) [STRING](STRING)  value that must be converted back using [_CV](_CV).

* [ASC (statement)](ASC-(statement)) allows a QB64 program to change a character at any position of a predefined STRING.
* [HEX$](HEX$) (function) returns the base 16 hexadecimal representation of an [INTEGER](INTEGER) value as a [STRING](STRING). 
* [INSTR](INSTR) (function) searches for the first occurance of a search STRING within a string and returns the position.
* [LCASE$](LCASE$) (function) changes the uppercase letters of a STRING to lowercase.
* [LEFT$](LEFT$) (function) returns a part of a STRING from the start a designated number of character places.
* [LEN](LEN) (function) returns the number of bytes or characters in a [STRING](STRING) value.
* [LSET](LSET) (statement) left-justifies a fixed length string expression based on the size of the STRING.
* [LTRIM$](LTRIM$) (function) returns a string with all leading spaces removed.
* [MID$ (statement)](MID$-(statement)) returns a portion of a string from the start position a designated number of characters.
* [MKD$](MKD$) (function) converts a [DOUBLE](DOUBLE) numerical value into an 8 byte [ASCII](ASCII) [STRING](STRING) value.
* [MKDMBF$](MKDMBF$) (function) converts a double-precision number to a string containing a value in Microsoft Binary format.
* [MKI$](MKI$) (function) converts a numerical [INTEGER](INTEGER) value to a 2 byte [ASCII](ASCII) string value.
* [MKL$](MKL$) (function) converts a numerical [LONG](LONG) value to a 4 byte [ASCII](ASCII) string value.
* [MKS$](MKS$) (function) converts a numerical [SINGLE](SINGLE) value to a 4 byte [ASCII](ASCII) string value.
* [MKSMBF$](MKSMBF$) (function) converts a single-precision number to a string containing a value in Microsoft Binary format.}}
* [OCT$](OCT$) (function) returns the base 8 Octal representation of an INTEGER value.
* [RIGHT$](RIGHT$) (function) returns a set number of characters in a STRING variable starting from the end.
* [RSET](RSET) (statement) right-justifies a string according to length of the string expression.
* [RTRIM$](RTRIM$) (function) returns a string with all of the spaces removed at the right end of a string.
* [SPACE$](SPACE$) (function) returns a STRING consisting of a number of space characters.
* [STR$](STR$) (function) converts a numerical value to a [STRING](STRING).
* [STRING](STRING) ($ variable type) one byte text variable with [ASCII](ASCII) code values from 0 to 255.
* [STRING$](STRING$) (function)  returns a STRING consisting of a single character repeated a set number of times.
* [SWAP](SWAP) (statement)  used to exchange two string variable or array element values.
* [UCASE$](UCASE$) (function) returns a string with all letters as uppercase.
* [VAL](VAL) (function) converts a string number value to a numerical value.

## Sub procedures and Functions

* [CALL](CALL) (statement) sends code execution to a [SUB](SUB) procedure in a program. Parameter brackets are required when used.
* [CALL ABSOLUTE](CALL_ABSOLUTE) (statement) used to access Interrupts on the computer or execute assembly type procedures.
* [CHAIN](CHAIN) (statement) changes seamlessly from one program module to another.
* DECLARE (BASIC statement) used to tell that a SUB or FUNCTION is created to be used in the program. NOT USED by QB64!
* [END](END) (statement) ends a [SUB](SUB) or [FUNCTION](FUNCTION) procedure.
* [EXIT](EXIT) (statement) exits a [SUB](SUB) or [FUNCTION](FUNCTION) procedure early.
* [FUNCTION](FUNCTION) (statement) a procedure that holds ONE return value in the function's name which is a variable type. 
* [GOSUB](GOSUB) (statement) sends the program to a sub program that uses a line number or label.
* [$INCLUDE]($INCLUDE) (metacommand) used to insert a source code text file into your program at the point of the insertion.
* [INTERRUPT](INTERRUPT) (statement) a built in assembly routine for accessing computer information registers.
* [RETURN](RETURN) (statement) used in GOSUB procedures to return to the original call code line.
* [RUN](RUN) (statement)  flow statement that clears and restarts the program currently in memory or executes another specified program.
* [SHARED](SHARED) (statement) defines a variable or list of variables as shared with the main program module.
* [SHELL](SHELL) (statement) allows a program to use OS command lines.
* [STATIC](STATIC) (statement) defines a variable or list of variables that will retain their values after the sub-procedure is exited.
* [SUB](SUB) (statement) procedures are programs within programs that can return multiple calculations.

## TCP/IP Networking and Email

*All Statements and Functions Compile in QB64 Only!*

* [_CONNECTED](_CONNECTED) (function) returns the connection status of a TCP/IP connection handle.
* [_CONNECTIONADDRESS$](_CONNECTIONADDRESS$) (function)  function returns a connected user's [STRING](STRING) IP address value.

* [_OPENCLIENT](_OPENCLIENT) (function) connects to a Host on the Internet as a Client and returns the Client status handle.
* [_OPENCONNECTION](_OPENCONNECTION) (function) opens a connection from a client that the host has detected and returns a status handle.
* [_OPENHOST](_OPENHOST) (function) opens a Host which listens for new connections and returns a Host status handle.

* [CLOSE](CLOSE) (statement) closes an opened internet connection using the handle assigned in an OPEN statement.

* [GET (TCP/IP statement)](GET-(TCP-IP-statement)) reads unformatted(raw) data from an opened connection using the connection handle.

* [PUT (TCP/IP statement)](PUT-(TCP-IP-statement)) sends unformatted(raw) data to an open connection using a user's handle.

See also: [Downloading Files](Downloading_Files)

## Text on Screen

* [_CONTROLCHR](_CONTROLCHR) [OFF](OFF) allows [ASCII](ASCII) characters 0 to 31 to be used as text characters. [ON](ON)(default) resets to default usage.
* [_FONT (function)](_FONT-(function)) creates a new alphablended font handle from a designated image handle
* [_FONT](_FONT) (statement) sets the current [_LOADFONT](_LOADFONT) function font handle to be used by [PRINT](PRINT) or [_PRINTSTRING](_PRINTSTRING).
* [_MAPUNICODE](_MAPUNICODE) (statement) maps a [Unicode](Unicode) value to an [ASCII](ASCII) character code value.
* [_PRINTSTRING](_PRINTSTRING) (statement) prints text or custom font strings using graphic column and row coordinate positions.
* [_SCREENPRINT](_SCREENPRINT) (statement) simulates typing text into a Windows program using the keyboard.

* [CHR$](CHR$) (function) returns the text character associated with a certain [ASCII](ASCII) character code as a one byte [STRING](STRING).
* [CLS](CLS) (statement) clears a screen page or the program [SCREEN](SCREEN). QB64 can clear with a color.
* [COLOR](COLOR) (statement) used to change the color of the text and background in some legacy screen modes.
* [CSRLIN](CSRLIN) (function) returns the current print cursor row position on the screen.
* [INPUT](INPUT) (statement) requests a [STRING](STRING) or numerical keyboard entry from a program user.
* [KEY LIST](KEY-LIST) (statement) vertically lists all the [ON KEY(n)](ON-KEY(n)) soft key strings associated with each function key F1 to F12.
* [LINE INPUT](LINE-INPUT) (statement) requests a [STRING](STRING) keyboard entry from a program user.
* [LOCATE](LOCATE) (statement) locates the screen text row and column positions for a [PRINT](PRINT) or [INPUT](INPUT) procedure.
* [POS](POS) (function) returns the current print cursor column position.
* [PRINT](PRINT) (statement) prints numeric or [STRING](STRING) expressions to the program screen.
* [PRINT USING](PRINT-USING) (statement) prints template formatted numeric or string values to the program screen.
* [SCREEN](SCREEN) (statement) sets the screen mode of a program. No statement defaults the program to SCREEN 0 text mode.
* [SCREEN (function)](SCREEN-(function)) returns the [ASCII](ASCII) code of a text character or the color attribute at a set text location on the screen.
* [SPACE$](SPACE$) (function) returns a [STRING](STRING) consisting of a number of space characters.
* [SPC](SPC) (function) used in [PRINT](PRINT) and [LPRINT](LPRINT) statements to print or output a number of space characters.
* [STR$](STR$) (function) returns the [STRING](STRING) representation of a numerical value.
* [STRING$](STRING$)(function)  returns a [STRING](STRING) consisting of a single character repeated a set number of times.
* [TAB](TAB) (function) used in [PRINT](PRINT) and [LPRINT](LPRINT) statements to move to a specified text column position.
* [VIEW PRINT](VIEW-PRINT) (statement) defines the boundaries of a text view port [PRINT](PRINT) area.
* [WIDTH](WIDTH) (statement) changes the text dimensions of certain [SCREEN](SCREEN) modes or printer page widths
* [WRITE](WRITE) (screen I/O statement) writes a comma-separated list of values to the screen.

See also: [Fonts and Unicode](#fonts_and_unicode) or [ASCII](ASCII)

## Time, Date and Timing

* [_AUTODISPLAY](_AUTODISPLAY) (statement) enables the automatic display of the screen image changes previously disabled by [_DISPLAY](_DISPLAY).
* [_DELAY](_DELAY) (statement) suspends program execution for a [SINGLE](SINGLE) value of seconds down to milliseconds.
* [_DISPLAY](_DISPLAY) (statement) turns off automatic display while only displaying the screen changes when called.
*[_FREETIMER](_FREETIMER) (function) returns a free TIMER number for multiple [ON TIMER(n)](ON-TIMER(n)) events.
* [_KEYDOWN](_KEYDOWN) (function) returns whether modifying keys like CTRL, ALT, SHIFT, and any other keys are pressed.
* [_KEYHIT](_KEYHIT) (function) returns ASCII one and two byte, SDL Virtual Key and Unicode keyboard key press codes.
* [_LIMIT](_LIMIT) (statement) sets the loop repeat rate of a program to so many per second, relinquishing spare cpu cycles.

* [DATE$](DATE$) (function) returns the present computer date in a mm-dd-yyyy [STRING](STRING) format

* [INKEY$](INKEY$) (function)  can be used in a loop to wait for a key press or a [Ctrl] + letter key combination.
* [INPUT](INPUT) (statement) can be used to wait for an [Enter] key press or a text or numerical menu entry.
* [INPUT$](INPUT$) (function) can be used to wait for a key press or a fixed length text entry.
* [ON KEY(n)](ON-KEY(n)) (event statement) executes when a key press or keypress combination occurs.
* [ON TIMER(n)](ON-TIMER(n)) (event statement) executes when a timed event occurs. QB64 can use multiple numbered timer events.

* [SLEEP](SLEEP) (statement) pauses the program for a specified number of seconds or a until a key press is made.
* [TIME$](TIME$) (function) returns the present computer time in a hh:mm:ss 24 hour [STRING](STRING) format

* [TIMER](TIMER) (function) returns the number of seconds past the previous midnight down to a QB64 accuracy of one millisecond.
* [TIMER (statement)](TIMER (statement)) enables, turns off or stops timer event trapping. In QB64 TIMER(n) FREE can free multiple timers.

* [WAIT](WAIT) (statement) normally used to delay program display execution during or after vertical retrace periods.

## Window and Desktop

*All Statements and Functions except [SCREEN](SCREEN) Compile in QB64 Only!*

* [_FULLSCREEN (function)](_FULLSCREEN-(function)) returns the present full screen mode setting number of the screen window.
* [_FULLSCREEN](_FULLSCREEN) (statement) sets the full screen mode of the screen window. Alt + Enter can do it manually.
* [_HEIGHT](_HEIGHT) (function) returns the height of a [_SCREENIMAGE](_SCREENIMAGE) handle to get the desktop resolution.
* [_ICON](_ICON) (statement) creates a program icon from an image file handle created by [_LOADIMAGE](_LOADIMAGE). Cannot use .ICO files!
* [_NEWIMAGE](_NEWIMAGE) (statement) function prepares a window image surface and returns the handle value.
* [$RESIZE]($RESIZE) ([Metacommand](Metacommand)) used with ON allows a user to resize the program window where OFF does not.
* [_RESIZE (function)](_RESIZE-(function)) returns -1 when a program user attempts to resize the program screen.
* [_RESIZEHEIGHT](_RESIZEHEIGHT) (function) returns the requested new user screen height when [$RESIZE]($RESIZE):ON allows it.
* [_RESIZEWIDTH](_RESIZEWIDTH) (function) returns the requested new user screen width when [$RESIZE]($RESIZE):ON allows it.
* [_SCREENCLICK](_SCREENCLICK)  simulates clicking the mouse at a position on the screen to get focus.
* [_SCREENEXISTS](_SCREENEXISTS) (function) returns a -1 value once a screen has been created.
* [$SCREENHIDE]($SCREENHIDE) (QB64 [Metacommand](Metacommand)) hides the program window throughout the program until [$SCREENSHOW]($SCREENSHOW) is used.
* [_SCREENHIDE](_SCREENHIDE) (statement) hides the main program window in a section of code until [_SCREENSHOW](_SCREENSHOW) is used.
* [_SCREENIMAGE](_SCREENIMAGE) (function) creates an image of the current desktop and returns an image handle.
* [_SCREENMOVE](_SCREENMOVE) (statement) positions the program window on the desktop using designated coordinates or _MIDDLE.
* [_SCREENPRINT](_SCREENPRINT) (statement) simulates typing text into a Windows program using the keyboard.
* [$SCREENSHOW]($SCREENSHOW) (QB64 [Metacommand](Metacommand)) displays the main program window throughout the program after [$SCREENHIDE]($SCREENHIDE).
* [_SCREENSHOW](_SCREENSHOW) (statement) displays the main program window in a section of code after [_SCREENHIDE](_SCREENHIDE) has been used.
* [_SCREENX](_SCREENX) (function) returns the current program window's upper left corner column position on the desktop.
* [_SCREENY](_SCREENY) (function) returns the current program window's upper left corner row position on the desktop.
* [_TITLE](_TITLE) (statement) sets the program name [STRING](STRING) in the title bar of the program window.
* [_TITLE$](_TITLE$) (function) gets the program title [STRING](STRING) value.
* [_WIDTH (function)](_WIDTH-(function)) returns the width of a [_SCREENIMAGE](_SCREENIMAGE) handle to get the desktop resolution.

* [SCREEN](SCREEN) sets the screen mode of a program. No statement defaults the program to SCREEN 0 text mode.

See Also: [C Libraries](C-Libraries), [Windows Libraries](Windows-Libraries) or [Windows Libraries](Windows-Libraries)

## QB64 Programming Symbols

*Note: All symbols below can also be used inside of literal quoted strings except for quotation marks.*

### Print, Input or File Formatting

* [Semicolon](Semicolon) after a [PRINT](PRINT) stops the invisible cursor at end of the printed value. Can prevent screen rolling!
* [Comma](Comma) after a [PRINT](PRINT) tabs the invisible cursor past the end of the printed value.
* [Quotation mark](Quotation_mark) delimits the ends of a literal [STRING](STRING) value in a [PRINT](PRINT), [INPUT](INPUT) or [LINE INPUT](LINE_INPUT) statement. 
* [Question mark](Question_mark) is a shortcut substitute for the [PRINT](PRINT) keyword. Will change to PRINT when cursor leaves the code line.

### Program Code Markers

* [Apostrophe](Apostrophe) denotes a program comment, to ignore a code line or a QBasic [Metacommand](Metacommand). Same as using [REM](REM).
* [Comma](Comma) is a statement variable or [DATA](DATA), [SUB](SUB) or [FUNCTION](FUNCTION) parameter separator. 
* [: Colon](Colon)s can be used to separate two procedure statements on one code line.
* [Dollar_Sign](Dollar_Sign) prefix denotes a QBasic [Metacommand](Metacommand). Only QB64's event [$CHECKING]($CHECKING) should NOT be commented.
* [Parenthesis](Parenthesis) enclose a math or conditional procedure order, [SUB](SUB) or [FUNCTION](FUNCTION) parameters or to pass by value.
* [+](+) [concatenation](concatenation) operator MUST be used to combine literal string values in a variable definition.
* [Quotation mark](Quotation mark) delimits the ends of a literal [STRING](STRING) value. Use [CHR$](CHR$)(34) to insert quotes in a text [STRING](STRING).
* [REM](REM) or apostrophe are used to make comments or ignore code or precedes a [Metacommand](Metacommand).
* [Underscore](Underscore) at the end of a code line is used to continue a line of code to the next program line in **QB64 only**.

### Variable Name Type Suffixes

* [STRING](STRING) text character type: 1 byte
* [SINGLE](SINGLE) floating decimal point numerical type (4 bytes)
* [DOUBLE](DOUBLE) floating decimal point numerical type (8 bytes)
* [_FLOAT](_FLOAT) QB64 decimal point numerical type (32 bytes)
* [_UNSIGNED](_UNSIGNED) QB64 [INTEGER](INTEGER) positive numerical type when it precedes the 6 numerical suffixes below:
* [INTEGER](INTEGER) [INTEGER](INTEGER) numerical type (2 bytes)
* [LONG](LONG) [INTEGER](INTEGER) numerical type (4 bytes}
* [_INTEGER64](_INTEGER64) QB64 [INTEGER](INTEGER) numerical type (8 bytes)
* [_BIT](_BIT) QB64 [INTEGER](INTEGER) numerical type (1 bit)(Key below tilde(~) or [CHR$](CHR$)(96))
* [_BYTE](_BYTE) QB64 [INTEGER](INTEGER) numerical type (1 byte)
* [_OFFSET](_OFFSET) QB64 [INTEGER](INTEGER) numerical pointer address type (any byte size required)

### Numerical Base Prefixes

* [&B](&B)           base 2    Digits 0 or 1 [QB64]
* [&O](&O)            base 8    Digits 0 to 7
* [&H](&H) base 16: Digits 0 to F

### [Mathematical Operations](Mathematical-Operations)

* [+](+) operator or sign
* [-](-) operator or sign
* [*](*) operator
* [/](/) (floating decimal point) operator
* [\\](\\) operator
* [^](^) operator
* [MOD](MOD) operator

### [Relational Operations](Relational-Operations)

* [Equal](Equal) (Equal to condition)
* [Greater_Than](Greater_Than) (Greater than condition)
* [Less_Than](Less_Than) (Less than condition)
* [Not_Equal](Not_Equal) (Not equal to condition)
* [Greater_Than_Or_Equal](Greater_Than_Or_Equal) (Greater than or equal to condition)
* [Less_Than_Or_Equal](Less_Than_Or_Equal) (Less than or equal to condition)

## QB64 Programming References

Got a question about something?

* [QB64 FAQ](QB64-FAQ)
* [Visit the QB64 Main Site](http://qb64.com)
