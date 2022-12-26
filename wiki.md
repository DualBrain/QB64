[Home](https://qb64.com) • [Forums](https://qb64.boards.net/) • [News](news.md) • [GitHub](https://github.com/QB64Official/qb64) • [Wiki](wiki.md) • [Samples](samples.md) • [InForm](inform.md) • [GX](gx.md) • [QBjs](qbjs.md) • [Community](community.md) • [More...](more.md)

## Original QBasic keywords:

**These QBasic keywords (with a few noted exceptions) will work in all versions of QB64.**

### A

* [ABS](wiki/ABS) (function) converts any negative numerical value to a positive value.
* [CALL ABSOLUTE](wiki/CALL-ABSOLUTE) (statement) is used to access computer interrupt registers.
* [ACCESS](wiki/ACCESS) (file statement) sets the read and write access of a file when opened.
* [ALIAS](wiki/ALIAS) (QB64 [DECLARE LIBRARY](wiki/DECLARE-LIBRARY) statement) denotes the actual name of an imported [FUNCTION](wiki/FUNCTION) or [SUB](wiki/SUB) procedure.
* [AND](wiki/AND) (logical operator) is used to compare two numerical values bitwise.
* [AND (boolean)](wiki/AND-(boolean)) conditional operator is used to include another evaluation in an [IF...THEN](wiki/IF...THEN) or [Boolean](wiki/Boolean) statement.
* [APPEND](wiki/APPEND) (file mode) creates a new file or allows an existing file to have data added using [WRITE (file statement)](wiki/WRITE-(file-statement)) or [PRINT (file statement)](wiki/PRINT-(file-statement))
* [AS](wiki/AS) is used to denote a variable type or file number.
* [ASC](wiki/ASC) (function) returns the [ASCII](wiki/ASCII) code number of a text [STRING](wiki/STRING) character.
* [ASC (statement)](wiki/ASC-(statement)) (QB64 only) sets the code value of an [ASCII](wiki/ASCII) text character at a designated [STRING](wiki/STRING) position.
* [ATN](wiki/ATN) (function) or arctangent returns the angle in radians of a numerical [TAN](wiki/TAN) value.

### B

* [BEEP](wiki/BEEP) (statement) creates an error sound of a fixed duration.
* [BINARY](wiki/BINARY) (file mode) creates or opens an existing file for [GET](wiki/GET) and [PUT](wiki/PUT) byte-wise access.
* [BLOAD](wiki/BLOAD) (statement) transfers the contents of a [BINARY](wiki/BINARY) [BSAVE](wiki/BSAVE) file to a specific [Arrays](wiki/Arrays).
* [BSAVE](wiki/BSAVE) (statement) transfers the contents of an [Arrays](wiki/Arrays) to a specified size [BINARY](wiki/BINARY) file.
* [BYVAL](wiki/BYVAL) (statement) assigns a numerical variable value by its value, not the name.

### C

* [CALL](wiki/CALL) (statement) optional statement that sends the program to a [SUB](wiki/SUB) procedure.  Requires parameters be enclosed in brackets(parenthesis).
* [CALL ABSOLUTE](wiki/CALL-ABSOLUTE) (statement) is used to access computer interrupt registers.
* [CASE](wiki/CASE) ([SELECT CASE](wiki/SELECT-CASE) condition) designates specific conditions in a [SELECT CASE](wiki/SELECT-CASE) statement block.
* [CASE ELSE](wiki/CASE-ELSE) ([SELECT CASE](wiki/SELECT-CASE) condition) designates an alternative condition to be evaluated in a [SELECT CASE](wiki/SELECT-CASE) statement block.
* [CASE IS](wiki/CASE-IS) ([SELECT CASE](wiki/SELECT-CASE) condition) designates specific conditions in a [SELECT CASE](wiki/SELECT-CASE) statement block.
* [CDBL](wiki/CDBL) (function) returns the closest [DOUBLE](wiki/DOUBLE) value of a number.
* [CHAIN](wiki/CHAIN) (statement) sends a program to another specified program module or compiled program.
* [CHDIR](wiki/CHDIR) (statement) changes the current program path for file access.
* [CHR$](wiki/CHR$) (function) returns a text [STRING](wiki/STRING) character by the specified [ASCII](wiki/ASCII) code number.
* [CINT](wiki/CINT) (function) returns the closest [INTEGER](wiki/INTEGER) value of a numerical value.
* [CIRCLE](wiki/CIRCLE) (statement) creates a circle, ellipse or arc at a designated graphical coordinate position.
* [CLEAR](wiki/CLEAR) (statement) sets all variable and array values to zero number values or empty [STRING](wiki/STRING)s.
* [CLNG](wiki/CLNG) (function) returns the closest [LONG](wiki/LONG) value of a numerical value.
* [CLOSE](wiki/CLOSE) (statement) closes specific file number(s) or all files when a number is not specified.
* [CLS](wiki/CLS) (statement) clears a program [SCREEN](wiki/SCREEN), [VIEW](wiki/VIEW) port or [WINDOW](wiki/WINDOW).
* [COLOR](wiki/COLOR) (statement) sets the current text foreground and/or background color to be used.
* [COMMAND$](wiki/COMMAND$) (function) returns the command line arguments passed when a program is run.
* [COMMON](wiki/COMMON) (statement) sets a variable name as shared by [CHAIN](wiki/CHAIN)ed program modules.
* [CONST](wiki/CONST) (statement) sets a variable name and its value as a constant value to be used by all procedures.
* [COS](wiki/COS) (function) returns the cosine of a radian angle value.
* [CSNG](wiki/CSNG) (function) returns the closest [SINGLE](wiki/SINGLE) value of a numerical value.
* [CSRLIN](wiki/CSRLIN) (function) returns the present [PRINT](wiki/PRINT) cursor text row [SCREEN](wiki/SCREEN) coordinate position.
* [CVD](wiki/CVD) (function) returns the [DOUBLE](wiki/DOUBLE) numerical value of an 8 byte [MKD$](wiki/MKD$) [STRING](wiki/STRING).
* [CVDMBF](wiki/CVDMBF) (function) returns the [DOUBLE](wiki/DOUBLE) numerical value of a [MKDMBF$](wiki/MKDMBF$) [STRING](wiki/STRING).
* [CVI](wiki/CVI) (function) returns the [INTEGER](wiki/INTEGER) numerical value of a 2 byte [MKI$](wiki/MKI$) [STRING](wiki/STRING).
* [CVL](wiki/CVL) (function) returns the [LONG](wiki/LONG) numerical value of a 4 byte [MKL$](wiki/MKL$) [STRING](wiki/STRING).
* [CVS](wiki/CVS) (function) returns the [SINGLE](wiki/SINGLE) numerical value of a 4 byte [MKS$](wiki/MKS$) [STRING](wiki/STRING).
* [CVSMBF](wiki/CVSMBF) (function) returns the [SINGLE](wiki/SINGLE) numerical value of a [MKSMBF$](wiki/MKSMBF$) [STRING](wiki/STRING).

### D

* [DATA](wiki/DATA) (statement) creates a line of fixed program information separated by commas.
* [DATE$](wiki/DATE$) (function) returns the present Operating System date [STRING](wiki/STRING) formatted as mm-dd-yyyy.
* [DATE$ (statement)](wiki/DATE$-(statement)) sets the date of the Operating System using a mm-dd-yyyy [STRING](wiki/STRING) format.
* DECLARE [SUB](wiki/SUB)/[FUNCTION](wiki/FUNCTION) (BASIC statement) declares a [SUB](wiki/SUB) or [FUNCTION](wiki/FUNCTION) procedure at the start of a program. Not required in QB64.
* [DECLARE LIBRARY](wiki/DECLARE-LIBRARY) declares a C++, SDL or Operating System [SUB](wiki/SUB) or [FUNCTION](wiki/FUNCTION) to be used.
* [DECLARE DYNAMIC LIBRARY](wiki/DECLARE-DYNAMIC-LIBRARY) declares DYNAMIC, CUSTOMTYPE or STATIC  library(DLL) [SUB](wiki/SUB) or [FUNCTION](wiki/FUNCTION).
* [DEF SEG](wiki/DEF-SEG) (statement) defines a segment in memory to be accessed by a memory procedure.
* [DEFDBL](wiki/DEFDBL) (statement) defines a set of undefined variable name starting letters as [DOUBLE](wiki/DOUBLE) type numerical values.
* [DEFINT](wiki/DEFINT) (statement) defines a set of undefined variable name starting letters as [INTEGER](wiki/INTEGER) type numerical values.
* [DEFLNG](wiki/DEFLNG) (statement) defines a set of undefined variable name starting letters as [LONG](wiki/LONG) type numerical values.
* [DEFSNG](wiki/DEFSNG) (statement) defines a set of undefined variable name starting letters as [SINGLE](wiki/SINGLE) type numerical values.
* [DEFSTR](wiki/DEFSTR) (statement) defines a set of undefined variable name starting letters as [STRING](wiki/STRING) type values.
* [DIM](wiki/DIM) (statement) defines a variable as a specified type and can size a [STATIC](wiki/STATIC)  array.
* [DO...LOOP](wiki/DO...LOOP) (statement) sets a recursive procedure loop that can be ignored or exited using conditional arguments.
* [DOUBLE](wiki/DOUBLE) (numerical type #) 8 byte value limited to values up to 15 decimal places.
* [DRAW](wiki/DRAW) (statement) uses a special [STRING](wiki/STRING) format that draws graphical lines in specific directions.
* [$DYNAMIC](wiki/$DYNAMIC) ([Metacommand](wiki/Metacommand)) used at the start of a program to set all program arrays as changeable in size using [REDIM](wiki/REDIM).

### E

* [ELSE](wiki/ELSE) ([IF...THEN](wiki/IF...THEN) statement) is used to direct program flow when no other condition is evaluated as true.
* [ELSEIF](wiki/ELSEIF) ([IF...THEN](wiki/IF...THEN) statement) is used with [THEN](wiki/THEN) to set alternate conditional evaluations.
* [END](wiki/END) (statement) sets the end of a program, sub-procedure, statement block, [DECLARE LIBRARY](wiki/DECLARE-LIBRARY) or [TYPE](wiki/TYPE) definition.
* [IF...THEN](wiki/IF...THEN) (statement) [END](wiki/END)s an IF...THEN conditional block statement using more than one line of code.
* [ENVIRON](wiki/ENVIRON) (statement) temporarily sets an environmental key/pair value.
* [ENVIRON$](wiki/ENVIRON$) (function) returns a specified string setting or numerical position as an environmental [STRING](wiki/STRING) value.
* [EOF](wiki/EOF) (file function) returns -1 when a file [INPUT (file statement)](wiki/INPUT-(file-statement)) or [GET](wiki/GET) has reached the end of a file.
* [EQV](wiki/EQV) (logic operator) is used to compare two numerical values bitwise.
* [ERASE](wiki/ERASE) (statement) clears the values from [$STATIC](wiki/$STATIC) arrays and completely removes [$DYNAMIC](wiki/$DYNAMIC) arrays.
* [ERDEV](wiki/ERDEV) (function) returns an error code from the last device to create an error.
* [ERDEV$](wiki/ERDEV$) (function) returns the 8 character name of the last device to declare an error as a [STRING](wiki/STRING).
* [ERL](wiki/ERL) (error function) returns the closest line number before an error occurred if line numbers are used.
* [ERR](wiki/ERR) (function) returns the [ERROR Codes](wiki/ERROR-Codes) when a program error occurs.
* [ERROR](wiki/ERROR) (statement) sets a specific [ERROR Code](wiki/ERROR-Codes) to be simulated.
* [EVERYCASE](wiki/SELECT-CASE) Used on [SELECT CASE](wiki/SELECT-CASE) statement.
* [EXIT](wiki/EXIT) (statement) immediately exits a program [FOR...NEXT](wiki/FOR...NEXT), [DO...LOOP](wiki/DO...LOOP), [SUB](wiki/SUB) or [FUNCTION](wiki/FUNCTION) procedure.
* [EXP](wiki/EXP) (function) returns the value of e to the exponential power specified.

### F

* [FIELD](wiki/FIELD) (statement) defines the variable sizes to be written or read from a file.
* [FILEATTR](wiki/FILEATTR) (function) returns the current file access mode.
* [FILES](wiki/FILES) (statement) returns a list of files in the current directory path to the [SCREEN](wiki/SCREEN).
* [FIX](wiki/FIX) (function) returns the rounded [INTEGER](wiki/INTEGER) value of a numerical value.
* [FOR...NEXT](wiki/FOR...NEXT) (statement) creates a recursive loop procedure that loop a specified number of times.
* [FOR (file statement)](wiki/FOR-(file-statement)) used in an [OPEN](wiki/OPEN) file or device statement to indicate the access mode.
* [FRE](wiki/FRE) (function) returns the number of bytes of Memory available to running programs.
* [FREE (QB64 TIMER statement)](wiki/TIMER) frees a numbered TIMER event in QB64.
* [FREEFILE](wiki/FREEFILE) (file function) returns a file number that is currently not in use by the Operating System.
* [FUNCTION](wiki/FUNCTION) (procedure block) sub-procedure that can calculate and return one value to a program in its name.

### G

* [GET](wiki/GET) (file statement) reads a file sequentially or at a specific position and returns the value as the variable type used.
* [GET (TCP/IP statement)](wiki/GET-(TCP-IP-statement)) reads a connection port to return a value.
* [GET (graphics statement)](wiki/GET-(graphics-statement)) maps an area the current [SCREEN](wiki/SCREEN) video information and places it in an [INTEGER](wiki/INTEGER) [arrays](wiki/arrays).
* [GOSUB](wiki/GOSUB) (statement) sends the program to a designated line label procedure in the main program.
* [GOTO](wiki/GOTO) (statement) sends the program to a designated line number or line label in a procedure.

### H

* [HEX$](wiki/HEX$) (function) returns the hexadecimal (base 16) [STRING](wiki/STRING) representation of the [INTEGER](wiki/INTEGER) part of any value.

### I

* [IF...THEN](wiki/IF...THEN) (statement) a conditional block statement used control program flow.
* [IMP](wiki/IMP) (logic operator) is used to compare two numerical values bitwise.
* [$INCLUDE](wiki/$INCLUDE) ([Metacommand](wiki/Metacommand)) designates a text code library file to include with the program.
* [INKEY$](wiki/INKEY$) (function) [ASCII](wiki/ASCII) returns a [STRING](wiki/STRING) value entry from the keyboard.
* [INP](wiki/INP) (function) returns a numerical value from a specified port register address. See [Keyboard scancodes](wiki/Keyboard-Scancodes)
* [INPUT](wiki/INPUT) (statement) a user input that returns a value to one or more specified variable(s).
* [INPUT (file mode)](wiki/INPUT-(file-mode)) [OPEN](wiki/OPEN) statement that only allows an existing file to be read using [INPUT (file statement)](wiki/INPUT-(file-statement)) or [INPUT$](wiki/INPUT$).
* [INPUT (file statement)](wiki/INPUT-(file-statement)) reads a file sequentially using the variable types designated. 
* [INPUT$](wiki/INPUT$) (function) returns a designated number of [STRING](wiki/STRING) bytes from the keyboard entry or a file number.
* [INSTR](wiki/INSTR) (function) returns the position in a text [STRING](wiki/STRING) where a character sequence match starts.
* [INT](wiki/INT) (function) rounds a numerical value to an [INTEGER](wiki/INTEGER) value by removing the decimal point fraction.
* [INTEGER](wiki/INTEGER) (% numerical type) 2 byte whole values from -32768 to 32767.
* [INTERRUPT](wiki/INTERRUPT) (statement) is used to access computer interrupt registers.
* [INTERRUPTX](wiki/INTERRUPTX) (statement) is used to access computer interrupt registers.
* [IOCTL](wiki/IOCTL) (statement)
* [IOCTL$](wiki/IOCTL$) (function)

### K

* [KEY n](wiki/KEY-n) (statement) used with [ON KEY(n)](wiki/ON-KEY(n)) events to assign a "soft key" string to a key or create a  user defined key.
* [KEY(n)](wiki/KEY(n)) (statement) used with [ON KEY(n)](wiki/ON-KEY(n)) events to assign, enable, disable or suspend event trapping.
* [KEY LIST](wiki/KEY-LIST) (statement) lists the 12 Function key soft key string assignments going down left side of screen.
* [KILL](wiki/KILL) (statement) deletes the specified file without a warning. Remove empty folders with [RMDIR](wiki/RMDIR).

### L

* [LBOUND](wiki/LBOUND) (function) returns the lower boundary of the specified array.
* [LCASE$](wiki/LCASE$) (function) returns the lower case value of a [STRING](wiki/STRING).
* [LEFT$](wiki/LEFT$) (function) returns the specified number of text characters from the left end of a [STRING](wiki/STRING).
* [LEN](wiki/LEN) (function) returns the length or number of characters in a [STRING](wiki/STRING) value in bytes.
* [LET](wiki/LET) (statement) assigns a variable a literal value. Not required.
* [LINE](wiki/LINE) (statement) creates a graphic line or box on the [SCREEN](wiki/SCREEN).
* [LINE INPUT](wiki/LINE-INPUT) (statement) user input can be any text character including commas and quotes as a [STRING](wiki/STRING) value only.
* [LINE INPUT (file statement)](wiki/LINE-INPUT-(file-statement)) returns an entire text file line and returns it as a [STRING](wiki/STRING) value.
* [KEY LIST](wiki/KEY-LIST) displays the current [ON KEY(n)](wiki/ON-KEY(n)) function key (F1 to F10) "soft key" settings.
* [LOC](wiki/LOC) (function) returns the present file byte position or number of bytes in the [OPEN COM](wiki/OPEN-COM) buffer.
* [LOCATE](wiki/LOCATE) (statement) sets the text cursor's row and column position for a [PRINT](wiki/PRINT) or [INPUT](wiki/INPUT) statement. 
* [LOCK](wiki/LOCK) (statement) restricts access to portions or all of a file by other programs or processes.
* [LOF](wiki/LOF) (function) returns the size of an [OPEN](wiki/OPEN) file in bytes.
* [LOG](wiki/LOG) (function) returns the natural logarithm of a specified numerical value
* [LONG](wiki/LONG) (& numerical type) 4 byte whole values from -2147483648 to 2147483647.
* [DO...LOOP](wiki/DO...LOOP) (block statement) bottom end of a recursive DO loop.
* [LPOS](wiki/LPOS) (function) returns the printer head position.
* [LPRINT](wiki/LPRINT) (statement) sends [STRING](wiki/STRING) data to the default LPT or USB printer.
* [LPRINT USING](wiki/LPRINT-USING) (statement) sends template formatted text to the default LPT or USB  printer.
* [LSET](wiki/LSET) (statement) left justifies the text in a string so that there are no leading spaces.
* [LTRIM$](wiki/LTRIM$) (function) returns a [STRING](wiki/STRING) value with no leading spaces.

### M

* [MID$](wiki/MID$) (function) returns a designated portion of a [STRING](wiki/STRING).
* [MID$ (statement)](wiki/MID$-(statement)) redefines existing characters in a [STRING](wiki/STRING).
* [MKD$](wiki/MKD$) (function) returns an 8 byte [ASCII](wiki/ASCII) [STRING](wiki/STRING) representation of a [DOUBLE](wiki/DOUBLE) numerical value.
* [MKDIR](wiki/MKDIR) (statement) creates a new folder in the current or designated program path.
* [MKDMBF$](wiki/MKDMBF$) (function) returns an 8 byte Microsoft Binary Format [STRING](wiki/STRING) representation of a [DOUBLE](wiki/DOUBLE) numerical value.
* [MKI$](wiki/MKI$) (function) returns a 2 byte [ASCII](wiki/ASCII) [STRING](wiki/STRING) representation of an [INTEGER](wiki/INTEGER). 
* [MKL$](wiki/MKL$) (function) returns a 4 byte [ASCII](wiki/ASCII) [STRING](wiki/STRING) representation of a [LONG](wiki/LONG) numerical value.
* [MKS$](wiki/MKS$) (function) returns a 4 byte [ASCII](wiki/ASCII) [STRING](wiki/STRING) representation of a [SINGLE](wiki/SINGLE) numerical value.
* [MKSMBF$](wiki/MKSMBF$) (function) returns an 8 byte Microsoft Binary Format [STRING](wiki/STRING) representation of a [DOUBLE](wiki/DOUBLE) numerical value.
* [MOD](wiki/MOD) (math operator) performs integer remainder division on a numerical value.

### N

* [NAME](wiki/NAME) (statement) names an existing file name [AS](wiki/AS) a new file name.
* [NEXT](wiki/NEXT) (statement) bottom end of a [FOR...NEXT](wiki/FOR...NEXT) counter loop to returns to the start or a [RESUME](wiki/RESUME) error.
* [NOT](wiki/NOT) (logical operator) inverts the value of a logic operation or returns True when a [boolean](wiki/boolean) evaluation is False.

### O

* [OCT$](wiki/OCT$) (function) returns the octal (base 8) [STRING](wiki/STRING) representation of the [INTEGER](wiki/INTEGER) part of any value.
* [OFF](wiki/OFF) (event statement) turns off all [ON](wiki/ON) event checking.
* [ON COM(n)](wiki/ON-COM(n)) (statement) sets up a COM port event procedure call.
* [ON ERROR](wiki/ON-ERROR) (statement) sets up and activates an error event checking procedure call. Use to avoid program errors.
* [ON KEY(n)](wiki/ON-KEY(n)) (statement) sets up a keyboard key entry event procedure.
* [ON PEN](wiki/ON-PEN) (statement) sets up a pen event procedure call.
* [ON PLAY(n)](wiki/ON-PLAY(n)) (statement) sets up a [PLAY](wiki/PLAY) event procedure call.
* [ON STRIG(n)](wiki/ON-STRIG(n)) (statement) sets up a joystick button event procedure call.
* [ON TIMER(n)](wiki/ON-TIMER(n)) (statement) sets up a timed event procedure call.
* [ON UEVENT](wiki/ON-UEVENT) (statement) **Not implemented in QB64.**
* [ON...GOSUB](wiki/ON...GOSUB) (statement) sets up a numerical event procedure call.
* [ON...GOTO](wiki/ON...GOTO) (statement) sets up a numerical event procedure call.
* [OPEN](wiki/OPEN) (file statement) opens a file name for an access mode with a specific file number.
* [OPEN COM](wiki/OPEN-COM) (statement) opens a serial communication port for access at a certain speed and mode.
* [OPTION BASE](wiki/OPTION-BASE) (statement) can set the lower boundary of all arrays to 1.
* [OR](wiki/OR) (logic operator) is used to compare two numerical values bitwise.
* [OR (boolean)](wiki/OR-(boolean)) conditional operator is used to include an alternative evaluation in an [IF...THEN](wiki/IF...THEN) or [Boolean](wiki/Boolean) statement.
* [OUT](wiki/OUT) (statement) writes numerical data to a specified register port.
* [OUTPUT](wiki/OUTPUT) (file mode) creates a new file or clears all data from an existing file to access the file sequentially.

### P

* [PAINT](wiki/PAINT) (statement) fills an enclosed area of a graphics [SCREEN](wiki/SCREEN) with a color until it encounters a specific colored border.
* [PALETTE](wiki/PALETTE) (statement) sets the Red, Green and Blue color attribute intensities using a RGB multiplier calculation.
* [PALETTE USING](wiki/PALETTE-USING) (statement) sets the color intensity settings using a designated [arrays](wiki/arrays).
* [PCOPY](wiki/PCOPY) (statement) swaps two designated memory page images when page swapping is enabled in the [SCREEN](wiki/SCREEN) statement.
* [PEEK](wiki/PEEK) (function) returns a numerical value from a specified segment address in memory. 
* [PEN](wiki/PEN) (function) returns requested information about the light pen device used.
* [PEN (statement)](wiki/PEN-(statement)) enables/disables or suspends event trapping of a light pen device.
* [PLAY(n)](wiki/PLAY(n)) (function) returns the number of notes currently in the background music queue.
* [PLAY](wiki/PLAY) (statement) uses a special [STRING](wiki/STRING) format that can produce musical tones and effects.
* [PMAP](wiki/PMAP) (function) returns the physical or WINDOW view graphic coordinates.
* [POINT](wiki/POINT) (function) returns the color attribute number or 32 bit [_RGB32](wiki/_RGB32) value.
* [POKE](wiki/POKE) (statement) writes a numerical value to a specified segment address in memory.
* [POS](wiki/POS) (function) returns the current text column position of the text cursor.
* [PRESET](wiki/PRESET) (statement) sets a pixel coordinate to the background color unless one is specified.
* [PRINT](wiki/PRINT) (statement) prints text [STRING](wiki/STRING) or numerical values to the [SCREEN](wiki/SCREEN).
* [PRINT (file statement)](wiki/PRINT-(file-statement)) prints text [STRING](wiki/STRING) or numerical values to a file.
* [PRINT USING](wiki/PRINT-USING) (statement) prints a template formatted [STRING](wiki/STRING) to the [SCREEN](wiki/SCREEN).
* [PRINT USING (file statement)](wiki/PRINT-USING-(file-statement)) prints a template formatted [STRING](wiki/STRING) to a file.
* [PSET](wiki/PSET) (statement) sets a pixel coordinate to the current color unless a color is designated.
* [PUT](wiki/PUT) (file I/O statement) writes data sequentially or to a designated position using a variable value.
* [PUT (TCP/IP statement)](wiki/PUT-(TCP-IP-statement)) sends raw data to a user's connection handle.
* [PUT (graphics statement)](wiki/PUT-(graphics-statement)) places pixel data stored in an [INTEGER](wiki/INTEGER) array to a specified area of the [SCREEN](wiki/SCREEN).

### R

* [RANDOM](wiki/RANDOM) (file mode) creates a file or opens an existing file to [GET](wiki/GET) and [PUT](wiki/PUT) records of a set byte size.
* [RANDOMIZE](wiki/RANDOMIZE) (statement) sets the random seed value for a specific sequence of random [RND](wiki/RND) values.
* [RANDOMIZE](wiki/RANDOMIZE) restarts the designated seed value's random sequence of values from the beginning.
* [READ](wiki/READ) (statement) reads values from a [DATA](wiki/DATA) field. [ACCESS](wiki/ACCESS) READ is used with the [OPEN](wiki/OPEN) statement.
* [REDIM](wiki/REDIM) (statement) creates a new [$DYNAMIC](wiki/$DYNAMIC) array or resizes one without losing data when [_PRESERVE](wiki/_PRESERVE) is used.
* [REM](wiki/REM) (statement) or an apostrophe tells the program to ignore statements following it on the same line.
* [RESET](wiki/RESET) (statement)  closes all files and writes the directory information to a diskette before it is removed from a disk drive.
* [RESTORE](wiki/RESTORE) (statement) resets the [DATA](wiki/DATA) pointer to the start of a designated field of data.
* [RESUME](wiki/RESUME) (statement) an [ERROR Codes](wiki/ERROR-Codes) handling procedure exit that can send the program to a line number or the [NEXT](wiki/NEXT) code line.
* [RETURN](wiki/RETURN) (statement) returns the program to the code immediately following a [GOSUB](wiki/GOSUB) call.
* [RIGHT$](wiki/RIGHT$) (function) returns a specific number of text characters from the right end of a [STRING](wiki/STRING).
* [RMDIR](wiki/RMDIR) (statement) removes an empty folder from the current path or the one designated.
* [RND](wiki/RND) (function) returns a random number value from 0 to .9999999.
* [RSET](wiki/RSET) (statement) right justifies a string value so that any end spaces are moved to the beginning.
* [RTRIM$](wiki/RTRIM$) (function) returns a [STRING](wiki/STRING) with all spaces removed from the right end.
* [RUN](wiki/RUN) (statement) clears and restarts the program currently in memory or executes another specified program.

### S

* [SADD](wiki/SADD) (function) returns the address of a STRING variable as an offset from the current data segment.
* [SCREEN (function)](wiki/SCREEN-(function)) can return the [ASCII](wiki/ASCII) character code or color of the text at a text designated coordinate.
* [SCREEN](wiki/SCREEN) (statement) sets the display mode and size of the program window.
* [SEEK](wiki/SEEK) (function) returns the present byte position in an [OPEN](wiki/OPEN) file.
* [SEEK (statement)](wiki/SEEK-(statement)) moves to a specified position in an [OPEN](wiki/OPEN) file.
* [SELECT CASE](wiki/SELECT-CASE) (statement) a program flow block that can handle numerous conditional evaluations.
* [SETMEM](wiki/SETMEM) (function) sets the memory to use.
* [SGN](wiki/SGN) (function) returns -1 for negative, 0 for zero, and 1 for positive numerical values.
* [SHARED](wiki/SHARED) (statement) designates that a variable can be used by other procedures or the main procedure when in a sub-procedure.
* [SHELL](wiki/SHELL) (statement) sends [STRING](wiki/STRING) commands to the command line. SHELL calls will not affect the current path.
* [SHELL (function)](wiki/SHELL-(function)) executes an external command or calls another program. Returns codes sent by [END](wiki/END) or [SYSTEM](wiki/SYSTEM).
* [SIGNAL](wiki/SIGNAL) (OS 2 event)
* [SIN](wiki/SIN) (function) returns the sine of a radian angle.
* [SINGLE](wiki/SINGLE) (! numerical type) 4 byte floating decimal point values up to 7 decimal places.
* [SLEEP](wiki/SLEEP) (statement) pauses the program for a designated number of seconds or until a key is pressed.
* [SOUND](wiki/SOUND) (statement) creates a sound of a specified frequency and duration.
* [SPACE$](wiki/SPACE$) (function) returns a designated number of spaces to a [STRING](wiki/STRING).
* [SPC](wiki/SPC) (function) moves the text cursor a number of spaces on the [SCREEN](wiki/SCREEN).
* [SQR](wiki/SQR) (function) returns the square root of a non-negative number.
* [STATIC](wiki/STATIC) (statement) creates a [SUB](wiki/SUB) or [FUNCTION](wiki/FUNCTION) variable that retains its value.
* [$STATIC](wiki/$STATIC) ([Metacommand](wiki/Metacommand)) used at the start of a program to set all program arrays as unchangeable in size using [DIM](wiki/DIM).
* [STEP](wiki/STEP) (keyword) move relatively from one graphic position or change the counting increment in a [FOR...NEXT](wiki/FOR...NEXT) loop.
* [STICK](wiki/STICK) (function) returns the present joystick position.
* [STOP](wiki/STOP) (statement) stops a program when troubleshooting or stops an [ON](wiki/ON) event.
* [STR$](wiki/STR$) (function) returns a [STRING](wiki/STRING) value of a number with a leading space when it is positive.
* [STRIG](wiki/STRIG) (function) returns the joystick button press values when read.
* [STRIG(n)](wiki/STRIG(n)) (statement) 
* [STRING](wiki/STRING) ($ variable type) one byte text variable with [ASCII](wiki/ASCII) code values from 0 to 255.
* [STRING$](wiki/STRING$) (function) returns a designated number of string characters.
* [SUB](wiki/SUB) (procedure block) sub-procedure that can calculate and return multiple parameter values.
* [SWAP](wiki/SWAP) (statement) swaps two [STRING](wiki/STRING) or numerical values.
* [SYSTEM](wiki/SYSTEM) (statement) ends a program immediately.

### T

* [TAB](wiki/TAB) (function) moves a designated number of columns on the [SCREEN](wiki/SCREEN).
* [TAN](wiki/TAN) (function) returns the ratio of [SIN](wiki/SIN)e to [COS](wiki/COS)ine or tangent value of an angle measured in radians.
* [THEN](wiki/THEN) ([IF...THEN](wiki/IF...THEN) keyword) must be used in a one line [IF...THEN](wiki/IF...THEN) program flow statement.
* [TIME$](wiki/TIME$) (function) returns the present time setting of the Operating System as a  format hh:mm:ss [STRING](wiki/STRING).
* [TIMER](wiki/TIMER) (function) returns the number of seconds since midnight as a [SINGLE](wiki/SINGLE) value. 
* [TIMER (statement)](wiki/TIMER-(statement)) events based on the designated time interval and timer number.
* [TO](wiki/TO) indicates a range of numerical values or an assignment of one value to another.
* [TYPE](wiki/TYPE) (definition) defines a variable type or file record that can include any [STRING](wiki/STRING) or numerical types.

### U

* [UBOUND](wiki/UBOUND) (function) returns the upper-most index number of a designated [arrays](wiki/arrays).
* [UCASE$](wiki/UCASE$) (function) returns an uppercase representation of a specified [STRING](wiki/STRING).
* [UEVENT](wiki/UEVENT) (statement) **Not implemented in QB64.**
* [UNLOCK](wiki/UNLOCK) (statement) unlocks a designated file or portions of it.
* [UNTIL](wiki/UNTIL) (condition) evaluates a [DO...LOOP](wiki/DO...LOOP) condition until it is True.

### V

* [VAL](wiki/VAL) (function) returns the numerical value of a [STRING](wiki/STRING) number.
* [VARPTR](wiki/VARPTR) (function) returns the [segment](wiki/Segment) pointer address in memory.
* [VARPTR$](wiki/VARPTR$) (function) returns the string value of a numerical value in memory.
* [VARSEG](wiki/VARSEG) (function) returns the [segment](wiki/Segment) address of a value in memory.
* [VIEW](wiki/VIEW) (graphics statement) sets up a graphic view port area of the [SCREEN](wiki/SCREEN).
* [VIEW PRINT](wiki/VIEW-PRINT) (statement) sets up a text view port area of the [SCREEN](wiki/SCREEN).

### W

* [WAIT](wiki/WAIT) (statement) waits until a vertical retrace is started or a [SCREEN](wiki/SCREEN) draw ends.
* [WEND](wiki/WEND) (statement) the bottom end of a [WHILE...WEND](wiki/WHILE...WEND) loop.
* [WHILE](wiki/WHILE) (condition) evaluates a [DO...LOOP](wiki/DO...LOOP) or [WHILE...WEND](wiki/WHILE...WEND) condition until it is False.
* [WHILE...WEND](wiki/WHILE...WEND) (statement) sets a recursive procedure loop that can only be exited using the [WHILE](wiki/WHILE) conditional argument.
* [WIDTH](wiki/WIDTH) (statement) sets the text column and row sizes in several [SCREEN](wiki/SCREEN) modes.
* [WINDOW](wiki/WINDOW) (statement) maps a window size different from the program's window size.
* [WRITE](wiki/WRITE) (screen I/O statement) prints variable values to the screen with commas separating each value.
* [WRITE (file statement)](wiki/WRITE-(file-statement)) writes data to a file with each variable value separated by commas.

### X

* [XOR](wiki/XOR) (logic operator) is used to compare two numerical values bitwise.

## QB64 specific keywords

Keywords beginning with underscores are QB64 specific. **To use them without the prefix, use [$NOPREFIX](wiki/$NOPREFIX).** Also note that the underscore prefix is reserved for QB64 KEYWORDS only.

### _A

* [_ACCEPTFILEDROP](wiki/_ACCEPTFILEDROP) (statement) turns a program window into a valid drop destination for dragging files from Windows Explorer.
* [_ACOS](wiki/_ACOS) (function) arccosine function returns the angle in radians based on an input [COS](wiki/COS)ine value range from -1 to 1.
* [_ACOSH](wiki/_ACOSH) (function) Returns the nonnegative arc hyperbolic cosine of x, expressed in radians.
* [_ALLOWFULLSCREEN](wiki/_ALLOWFULLSCREEN) (statement) allows setting the behavior of the ALT+ENTER combo.
* [_ALPHA](wiki/_ALPHA) (function) returns the alpha channel transparency level of a color value used on a screen page or image.
* [_ALPHA32](wiki/_ALPHA32) (function) returns the alpha channel transparency level of a color value used on a 32 bit screen page or image.
* [_ASIN](wiki/_ASIN) (function) Returns the principal value of the arc sine of x, expressed in radians.
* [_ASINH](wiki/_ASINH) (function) Returns the arc hyperbolic sine of x, expressed in radians.
* [_ASSERT](wiki/_ASSERT) (statement) Performs debug tests.
* [$ASSERTS](wiki/$ASSERTS) (metacommand) Enables the [_ASSERT](wiki/_ASSERT) macro
* [_ATAN2](wiki/_ATAN2) (function) Returns the principal value of the [ATN](wiki/ATN) of y/x, expressed in radians.
* [_ATANH](wiki/_ATANH) (function) Returns the arc hyperbolic tangent of x, expressed in radians.
* [_AUTODISPLAY](wiki/_AUTODISPLAY) (statement) enables the automatic display of the screen image changes previously disabled by [_DISPLAY](wiki/_DISPLAY).
* [_AUTODISPLAY (function)](wiki/_AUTODISPLAY-(function)) returns the current display mode as true (-1) if automatic or false (0) if per request using [_DISPLAY](wiki/_DISPLAY).
* [_AXIS](wiki/_AXIS) (function) returns a [SINGLE](wiki/SINGLE) value between -1 and 1 indicating the maximum distance from the device axis center, 0.

### _B

* [_BACKGROUNDCOLOR](wiki/_BACKGROUNDCOLOR) (function) returns the current [SCREEN](wiki/SCREEN) background color.
* [_BIT](wiki/_BIT) (` numerical type) can return only signed values of 0 (bit off) and -1 (bit on). Unsigned 0 or 1.
* [_BLEND](wiki/_BLEND) (statement) statement turns on 32 bit alpha blending for the current image or screen mode and is default.
* [_BLEND (function)](wiki/_BLEND-(function)) returns -1 if enabled or 0 if disabled by [_DONTBLEND](wiki/_DONTBLEND) statement.
* [_BLINK](wiki/_BLINK) (statement) statement turns blinking colors on/off in SCREEN 0
* [_BLINK (function)](wiki/_BLINK-(function)) returns -1 if enabled or 0 if disabled by [_BLINK](wiki/_BLINK) statement.
* [_BLUE](wiki/_BLUE) (function) function returns the palette or the blue component intensity of a 32-bit image color.
* [_BLUE32](wiki/_BLUE32) (function) returns the blue component intensity of a 32-bit color value.
* [_BUTTON](wiki/_BUTTON) (function) returns -1 when a controller device button is pressed and 0 when button is released.
* [_BUTTONCHANGE](wiki/_BUTTONCHANGE) (function) returns -1 when a device button has been pressed and 1 when released. Zero indicates no change.
* [_BYTE](wiki/_BYTE) (%% numerical type) can hold signed values from -128 to 127 (one byte or _BIT * 8). Unsigned from 0 to 255.

### _C

* [_CAPSLOCK (function)](wiki/_CAPSLOCK-(function)) returns -1 when Caps Lock is on
* [_CAPSLOCK](wiki/_CAPSLOCK) (statement) sets Caps Lock key state
* [$CHECKING](wiki/$CHECKING) (QB64 C++ [Metacommand](wiki/Metacommand)) turns event error checking OFF or ON.
* [_CEIL](wiki/_CEIL) (function) Rounds x upward, returning the smallest integral value that is not less than x.
* [_CINP](wiki/_CINP) (function) Returns a key code from $CONSOLE input
* [_CLEARCOLOR (function)](wiki/_CLEARCOLOR-(function)) returns the current transparent color of an image.
* [_CLEARCOLOR](wiki/_CLEARCOLOR) (statement) sets a specific color index of an image to be transparent
* [_CLIP](wiki/_CLIP) ([PUT (graphics statement)](wiki/PUT-(graphics-statement)) graphics option) allows placement of an image partially off of the screen.
* [_CLIPBOARD$](wiki/_CLIPBOARD$) (function) returns the operating system's clipboard contents as a [STRING](wiki/STRING).
* [_CLIPBOARD$ (statement)](wiki/_CLIPBOARD$-(statement)) sets and overwrites the [STRING](wiki/STRING) value in the operating system's clipboard. 
* [_CLIPBOARDIMAGE (function)](wiki/_CLIPBOARDIMAGE-(function)) pastes an image from the clipboard into a new QB64 image in memory.
* [_CLIPBOARDIMAGE](wiki/_CLIPBOARDIMAGE) (statement) copies a valid QB64 image to the clipboard.
* [$COLOR](wiki/$COLOR) (metacommand) includes named color constants in a program
* [_COMMANDCOUNT](wiki/_COMMANDCOUNT) (function) returns the number of arguments passed to the compiled program from the command line.
* [_CONNECTED](wiki/_CONNECTED) (function) returns the status of a TCP/IP connection handle.
* [_CONNECTIONADDRESS$](wiki/_CONNECTIONADDRESS$) (TCP/IP function) returns a connected user's STRING IP address value using the handle.
* [$CONSOLE](wiki/$CONSOLE) (QB64 [Metacommand](wiki/Metacommand)) creates a console window that can be used throughout a program.
* [_CONSOLE](wiki/_CONSOLE) (statement) used to turn a console window OFF or ON or to designate [_DEST](wiki/_DEST) _CONSOLE for output.
* [_CONSOLEINPUT](wiki/_CONSOLEINPUT) (function) fetches input data from a [$CONSOLE](wiki/$CONSOLE) window to be read later (both mouse and keyboard)
* [_CONSOLETITLE](wiki/_CONSOLETITLE) (statement) creates the title of the console window using a literal or variable [STRING](wiki/STRING).
* [_CONTINUE](wiki/_CONTINUE) (statement) skips the remaining lines in a control block (DO/LOOP, FOR/NEXT or WHILE/WEND)
* [_CONTROLCHR](wiki/_CONTROLCHR) (statement) [OFF](wiki/OFF) allows the control characters to be used as text characters. [ON](wiki/ON) (default) can use them as commands.
* [_CONTROLCHR (function)](wiki/_CONTROLCHR-(function))   returns the current state of [_CONTROLCHR](wiki/_CONTROLCHR) as 1 when OFF and 0 when ON.
* [_COPYIMAGE](wiki/_COPYIMAGE) (function) copies an image handle value to a new designated handle.
* [_COPYPALETTE](wiki/_COPYPALETTE) (statement) copies the color palette intensities from one 4 or 8 BPP image to another image.
* [_CV](wiki/_CV) (function) converts any [_MK$](wiki/_MK$) [STRING](wiki/STRING) value to the designated numerical type value.
* [_CWD$](wiki/_CWD$) (function) returns the current working directory  as a [STRING](wiki/STRING) value.

### _D 

* [_D2G](wiki/_D2G) (function) converts degrees to gradian angle values.
* [_D2R](wiki/_D2R) (function) converts degrees to radian angle values.
* [$DEBUG](wiki/$DEBUG) (metacommand) enables debugging features, allowing you to step through your code line by line
* [DECLARE LIBRARY](wiki/DECLARE-LIBRARY) declares a C++, SDL or Operating System [SUB](wiki/SUB) or [FUNCTION](wiki/FUNCTION) to be used.
* [DECLARE DYNAMIC LIBRARY](wiki/DECLARE-DYNAMIC-LIBRARY) declares [DYNAMIC](wiki/DYNAMIC), [CUSTOMTYPE](wiki/CUSTOMTYPE) or [STATIC](wiki/STATIC) library (DLL) [SUB](wiki/SUB) or [FUNCTION](wiki/FUNCTION).
* [_DEFAULTCOLOR](wiki/_DEFAULTCOLOR) (function) returns the current default text color for an image handle or page.
* [_DEFINE](wiki/_DEFINE) (statement) defines a range of variable names according to their first character as a data type.
* [_DEFLATE$](wiki/_DEFLATE$) (function) compresses a string
* [_DELAY](wiki/_DELAY) (statement) suspends program execution for a [SINGLE](wiki/SINGLE) number of seconds.
* [_DEPTHBUFFER](wiki/_DEPTHBUFFER) (statement) enables, disables, locks or clears depth buffering.
* [_DESKTOPHEIGHT](wiki/_DESKTOPHEIGHT) (function) returns the height of the desktop (not program window).
* [_DESKTOPWIDTH](wiki/_DESKTOPWIDTH) (function) returns the width of the desktop (not program window).
* [_DEST](wiki/_DEST) (statement) sets the current write image or [SCREEN](wiki/SCREEN) page destination for prints or graphics.
* [_DEST (function)](wiki/_DEST-(function)) returns the current destination screen page or image handle value.
* [_DEVICE$](wiki/_DEVICE$) (function) returns a [STRING](wiki/STRING) expression listing a designated numbered input device name and types of input.
* [_DEVICEINPUT](wiki/_DEVICEINPUT) (function) returns the [_DEVICES](wiki/_DEVICES) number of an [_AXIS](wiki/_AXIS), [_BUTTON](wiki/_BUTTON) or [_WHEEL](wiki/_WHEEL) event.
* [_DEVICES](wiki/_DEVICES) (function) returns the number of input devices found on a computer system including the keyboard and mouse.
* [_DIR$](wiki/_DIR$) (function) returns common paths in Windows only, like My Documents, My Pictures, My Music, Desktop.
* [_DIREXISTS](wiki/_DIREXISTS) (function) returns -1 if the Directory folder name [STRING](wiki/STRING) parameter exists. Zero if it does not.
* [_DISPLAY](wiki/_DISPLAY) (statement) turns off the [_AUTODISPLAY](wiki/_AUTODISPLAY) while only displaying the screen changes when called.
* [_DISPLAY (function)](wiki/_DISPLAY-(function)) returns the handle of the current image that is displayed on the screen.
* [_DISPLAYORDER](wiki/_DISPLAYORDER) (statement) designates the order to render software, hardware and custom-opengl-code.
* [_DONTBLEND](wiki/_DONTBLEND) (statement) statement turns off default [_BLEND](wiki/_BLEND) 32 bit [_ALPHA](wiki/_ALPHA) blending for the current image or screen.
* [_DONTWAIT](wiki/_DONTWAIT) ([SHELL](wiki/SHELL) action) specifies that the program should not wait until the shelled command/program is finished.
* [_DROPPEDFILE](wiki/_DROPPEDFILE) (function)  returns the list of items (files or folders) dropped in a program's window after [_ACCEPTFILEDROP](wiki/_ACCEPTFILEDROP) is enabled.

### _E

* [_ECHO](wiki/_ECHO) (statement) used in conjunction with $IF for the pre-compiler.
* [$ELSE](wiki/$ELSE) (Pre-Compiler [Metacommand](wiki/Metacommand)) used in conjunction with $IF for the pre-compiler.
* [$ELSEIF](wiki/$ELSEIF) (Pre-Compiler [Metacommand](wiki/Metacommand)) used in conjunction with $IF for the pre-compiler.
* [$END IF](wiki/$END-IF) (Pre-Compiler [Metacommand](wiki/Metacommand)) used in conjunction with $IF for the pre-compiler.
* [$ERROR](wiki/$ERROR)  (precompiler [metacommand](wiki/metacommand)) used to trigger compiler errors.
* [_ERRORLINE](wiki/_ERRORLINE) (function) returns the source code line number that caused the most recent runtime error.
* [_ERRORMESSAGE$](wiki/_ERRORMESSAGE$) (function) returns a human-readable message describing the most recent runtime error.
* [$EXEICON](wiki/$EXEICON) (Pre-Compiler [Metacommand](wiki/Metacommand)) used with a .ICO icon file name to embed the image into the QB64 executable.
* [_EXIT (function)](wiki/_EXIT-(function)) prevents a user exit and indicates if a user has clicked the close X window button or CTRL + BREAK.

### _F

* [_FILEEXISTS](wiki/_FILEEXISTS) (function) returns -1 if the file name [STRING](wiki/STRING) parameter exists. Zero if it does not.
* [_FINISHDROP](wiki/_FINISHDROP) (statement)  resets [_TOTALDROPPEDFILES](wiki/_TOTALDROPPEDFILES) and clears the [_DROPPEDFILE](wiki/_DROPPEDFILE) list of items (files/folders).
* [_FLOAT](wiki/_FLOAT) (numerical type ##) offers the maximum floating-point decimal precision available using QB64.
* [_FONT](wiki/_FONT) (statement) sets the current font handle to be used by PRINT or [_PRINTSTRING](wiki/_PRINTSTRING).
* [_FONT (function)](wiki/_FONT-(function)) creates a new font handle from a designated image handle.
* [_FONTHEIGHT](wiki/_FONTHEIGHT) (function) returns the current text or font height.
* [_FONTWIDTH](wiki/_FONTWIDTH) (function) returns the current text or font width.
* [_FREEFONT](wiki/_FREEFONT) (statement) releases the current font handle from memory.
* [_FREEIMAGE](wiki/_FREEIMAGE) (statement) releases a designated image handle from memory.
* [_FREETIMER](wiki/_FREETIMER) (function) returns an unused timer number value to use with [ON TIMER(n)](wiki/ON-TIMER(n)).
* [_FULLSCREEN](wiki/_FULLSCREEN) (statement) sets the program window to full screen or OFF. Alt + Enter does it manually.
* [_FULLSCREEN (function)](wiki/_FULLSCREEN-(function)) returns the fullscreen mode in use by the program.

### _G

* [_G2D](wiki/_G2D) (function) converts gradian to degree angle values.
* [_G2R](wiki/_G2R) (function) converts gradian to radian angle values.
* [_GLRENDER](wiki/_GLRENDER) (statement) sets whether context is displayed, on top of or behind the software rendering.
* [_GREEN](wiki/_GREEN) (function) function returns the palette or the green component intensity of a 32-bit image color.
* [_GREEN32](wiki/_GREEN32) (function) returns the green component intensity of a 32-bit color value.

### _H

* [_HEIGHT](wiki/_HEIGHT) (function) returns the height of a designated image handle.
* [_HIDE](wiki/_HIDE) ([SHELL](wiki/SHELL) action)  hides the command line display during a shell.
* [_HYPOT](wiki/_HYPOT) (function) Returns the hypotenuse of a right-angled triangle whose legs are x and y.

### _I

* [$IF](wiki/$IF) (Pre-Compiler [Metacommand](wiki/Metacommand)) used to set an IF condition for the precompiler.
* [_ICON](wiki/_ICON) (statement) designates a [_LOADIMAGE](wiki/_LOADIMAGE) image file handle to be used as the program's icon or loads the embedded icon (see [$EXEICON](wiki/$EXEICON)).
* [_INCLERRORFILE$](wiki/_INCLERRORFILE$) {function) returns the name of the original source code $INCLUDE module that caused the most recent error.
* [_INCLERRORLINE](wiki/_INCLERRORLINE) (function) returns the line number in an included file that caused the most recent error.
* [_INFLATE$](wiki/_INFLATE$) (function) decompresses a string
* [_INSTRREV](wiki/_INSTRREV) (function) allows searching for a substring inside another string, but unlike [INSTR](wiki/INSTR) it returns the last occurrence instead of the first one.
* [_INTEGER64](wiki/_INTEGER64) (&& numerical type) can hold whole numerical values from -9223372036854775808 to 9223372036854775807.

### _K

* [_KEYCLEAR](wiki/_KEYCLEAR) (statement) clears the keyboard buffers for INKEY$, _KEYHIT, and INP.
* [_KEYHIT](wiki/_KEYHIT) (function) returns [ASCII](wiki/ASCII) one and two byte, SDL Virtual Key and [Unicode](wiki/Unicode) keyboard key press codes.
* [_KEYDOWN](wiki/_KEYDOWN) (function) returns whether CTRL, ALT, SHIFT, combinations and other keys are pressed.

### _L

* [$LET](wiki/$LET) (Pre-Compiler [Metacommand](wiki/Metacommand)) used to set a flag variable for the precompiler.
* [_LASTAXIS](wiki/_LASTAXIS) (function) returns the number of axis available on a specified number device listed by [_DEVICE$](wiki/_DEVICE$).
* [_LASTBUTTON](wiki/_LASTBUTTON) (function) returns the number of buttons available on a specified number device listed by [_DEVICE$](wiki/_DEVICE$). 
* [_LASTWHEEL](wiki/_LASTWHEEL) (function) returns the number of scroll wheels available on a specified number device listed by [_DEVICE$](wiki/_DEVICE$).
* [_LIMIT](wiki/_LIMIT) (statement) sets the loops per second rate to slow down loops and limit CPU usage.
* [_LOADFONT](wiki/_LOADFONT) (function) designates a [_FONT](wiki/_FONT) TTF file to load and returns a handle value.
* [_LOADIMAGE](wiki/_LOADIMAGE) (function) designates an image file to load and returns a handle value.

### _M

* [_MAPTRIANGLE](wiki/_MAPTRIANGLE) (statement) maps a triangular image source area to put on a destination area.
* [_MAPUNICODE](wiki/_MAPUNICODE) (statement) maps a [Unicode](wiki/Unicode) value to an [ASCII](wiki/ASCII) code number.
* [_MAPUNICODE (function)](wiki/_MAPUNICODE-(function)) returns the [Unicode](wiki/Unicode) (UTF32) code point value of a mapped [ASCII](wiki/ASCII) character code.
* [_MEM (function)](wiki/_MEM-(function)) returns [_MEM](wiki/_MEM) block referring to the largest continuous memory region beginning at a designated variable's offset.
* [_MEM](wiki/_MEM) (variable type) contains read only dot elements for the OFFSET, SIZE, TYPE and ELEMENTSIZE of a block of memory.
* [_MEMCOPY](wiki/_MEMCOPY) (statement) copies a value from a designated OFFSET and SIZE [TO](wiki/TO) a block of memory at a designated OFFSET.
* [_MEMELEMENT](wiki/_MEMELEMENT) (function) returns a [_MEM](wiki/_MEM) block referring to a variable's memory (but not past it).
* [_MEMEXISTS](wiki/_MEMEXISTS) (function) verifies that a memory block exists for a memory variable name or returns zero.
* [_MEMFILL](wiki/_MEMFILL) (statement) fills a designated memory block OFFSET with a certain SIZE and TYPE of value.
* [_MEMFREE](wiki/_MEMFREE) (statement) frees a designated memory block in a program. Only free memory blocks once.
* [_MEMGET](wiki/_MEMGET) (statement) reads a value from a designated memory block at a designated  OFFSET
* [_MEMGET (function)](wiki/_MEMGET-(function)) returns a value from a designated memory block and OFFSET using a designated variable [TYPE](wiki/TYPE).
* [_MEMIMAGE](wiki/_MEMIMAGE) (function) returns a [_MEM](wiki/_MEM) block referring to a designated image handle's memory
* [_MEMNEW](wiki/_MEMNEW) (function) allocates new memory with a designated SIZE and returns a [_MEM](wiki/_MEM) block referring to it.
* [_MEMPUT](wiki/_MEMPUT) (statement) places a designated value into a designated memory block OFFSET
* [_SCREENMOVE](wiki/_SCREENMOVE) (_SCREENMOVE parameter) centers the program window on the desktop in any screen resolution.
* [_MK$](wiki/_MK$) (function) converts a numerical value to a designated [ASCII](wiki/ASCII) [STRING](wiki/STRING) value.
* [_MOUSEBUTTON](wiki/_MOUSEBUTTON) (function) returns the status of a designated mouse button.
* [_MOUSEHIDE](wiki/_MOUSEHIDE) (statement) hides the mouse pointer from view
* [_MOUSEINPUT](wiki/_MOUSEINPUT) (function) returns a value if the mouse status has changed since the last read.
* [_MOUSEMOVE](wiki/_MOUSEMOVE) (statement) moves the mouse pointer to a designated position on the program [SCREEN](wiki/SCREEN).
* [_MOUSEMOVEMENTX](wiki/_MOUSEMOVEMENTX) (function) returns the relative horizontal position of the mouse cursor compared to the previous position.
* [_MOUSEMOVEMENTY](wiki/_MOUSEMOVEMENTY) (function) returns the relative vertical position of the mouse cursor compared to the previous position.
* [_MOUSEPIPEOPEN](wiki/_MOUSEPIPEOPEN) (function) creates a pipe handle value for a mouse when using a virtual keyboard.
* [_MOUSESHOW](wiki/_MOUSESHOW) (statement) displays the mouse cursor after it has been hidden or can change the cursor shape.
* [_MOUSEWHEEL](wiki/_MOUSEWHEEL) (function) returns the number of mouse scroll wheel "clicks" since last read.
* [_MOUSEX](wiki/_MOUSEX) (function) returns the current horizontal position of the mouse cursor.
* [_MOUSEY](wiki/_MOUSEY) (function) returns the current vertical position of the mouse cursor.

### _N

* [_NEWIMAGE](wiki/_NEWIMAGE) (function) creates a designated size program [SCREEN](wiki/SCREEN) or page image and returns a handle value.
* [$NOPREFIX](wiki/$NOPREFIX) (metacommand) allows QB64-specific keywords to be used without the underscore prefix.
* [_NUMLOCK (function)](wiki/_NUMLOCK-(function)) returns -1 when Num Lock is on
* [_NUMLOCK](wiki/_NUMLOCK) (statement) sets Num Lock key state

### _O

* [_OFFSET (function)](wiki/_OFFSET-(function)) returns the memory offset of a variable when used with [DECLARE LIBRARY](wiki/DECLARE-LIBRARY) or [_MEM](wiki/_MEM) only.
* [_OFFSET](wiki/_OFFSET) (%& numerical type) can be used store the value of an offset in memory when using [DECLARE LIBRARY](wiki/DECLARE-LIBRARY) or [MEM](wiki/MEM) only.
* [_OPENCLIENT](wiki/_OPENCLIENT) (TCP/IP function) connects to a Host on the Internet as a Client and returns the Client status handle.
* [_OPENCONNECTION](wiki/_OPENCONNECTION) (TCP/IP function) open's a connection from a client that the host has detected and returns a status handle.
* [_OPENHOST](wiki/_OPENHOST) (TCP/IP function) opens a Host and returns a Host status handle.
* [OPTION _EXPLICIT](wiki/OPTION--EXPLICIT) (Pre-compiler directive) instructs the compiler to require variable declaration with [DIM](wiki/DIM) or an equivalent statement.
* [OPTION _EXPLICITARRAY](wiki/OPTION--EXPLICITARRAY) (Pre-compiler directive) instructs the compiler to require array declaration with [DIM](wiki/DIM) or an equivalent statement. 
* [_OS$](wiki/_OS$) (function) returns the QB64 compiler version in which the program was compiled as [WINDOWS], [LINUX] or [MACOSX] and [32BIT] or [64BIT].

### _P

* [_PALETTECOLOR](wiki/_PALETTECOLOR) (statement) sets the color value of a palette entry of an image using 256 colors or less palette modes.
* [_PALETTECOLOR (function)](wiki/_PALETTECOLOR-(function)) return the 32 bit attribute color setting of an image or screen page handle's palette.
* [_PI](wiki/_PI) (function) returns the value of **π** or parameter multiples for angle or [CIRCLE](wiki/CIRCLE) calculations.
* [_PIXELSIZE](wiki/_PIXELSIZE) (function) returns the pixel palette mode of a designated image handle.
* [_PRESERVE](wiki/_PRESERVE) ([REDIM](wiki/REDIM) action) preserves the data presently in an array when [REDIM](wiki/REDIM) is used.
* [_PRINTIMAGE](wiki/_PRINTIMAGE) (statement) sends an image to the printer that is stretched to the current printer paper size.
* [_PRINTMODE](wiki/_PRINTMODE) (statement) sets the text or _FONT printing mode on a background when using PRINT or [_PRINTSTRING](wiki/_PRINTSTRING).
* [_PRINTMODE (function)](wiki/_PRINTMODE-(function)) returns the present [_PRINTMODE](wiki/_PRINTMODE) value number.
* [_PRINTSTRING](wiki/_PRINTSTRING) (statement) locates and prints a text [STRING](wiki/STRING) using graphic coordinates.
* [_PRINTWIDTH](wiki/_PRINTWIDTH) (function) returns the pixel width of a text string to be printed using [_PRINTSTRING](wiki/_PRINTSTRING).
* [_PUTIMAGE](wiki/_PUTIMAGE) (statement) maps a rectangular image source area to an image destination area.

### _R

* [_R2D](wiki/_R2D) (function) converts radians to degree angle values.
* [_R2G](wiki/_R2G) (function) converts radians to gradian angle values.
* [_RED](wiki/_RED) (function) function returns the palette or the red component intensity of a 32-bit image color.
* [_RED32](wiki/_RED32) (function) returns the red component intensity of a 32-bit color value.
* [_READBIT](wiki/_READBIT) (function) returns the state of the specified bit of an integer variable.
* [_RESETBIT](wiki/_RESETBIT) (function) is used to set the specified bit of an integer variable to 0.
* [$RESIZE](wiki/$RESIZE) ([Metacommand](wiki/Metacommand)) used with ON allows a user to resize the program window where OFF does not.
* [_RESIZE](wiki/_RESIZE) (statement) sets resizing of the window ON or OFF and sets the method as _STRETCH or _SMOOTH.
* [_RESIZE (function)](wiki/_RESIZE-(function)) returns -1 when a program user wants to resize the program screen.
* [_RESIZEHEIGHT](wiki/_RESIZEHEIGHT) (function) returns the requested new user screen height when [$RESIZE](wiki/$RESIZE):ON allows it.
* [_RESIZEWIDTH](wiki/_RESIZEWIDTH) (function) returns the requested new user screen width when [$RESIZE](wiki/$RESIZE):ON allows it.
* [_RGB](wiki/_RGB) (function) returns the closest palette index OR the [LONG](wiki/LONG) 32 bit color value in 32 bit screens.
* [_RGB32](wiki/_RGB32) (function) returns the [LONG](wiki/LONG) 32 bit color value in 32 bit screens only
* [_RGBA](wiki/_RGBA) (function) returns the closest palette index OR the [LONG](wiki/LONG) 32 bit color value in 32 bit screens with the [ALPHA](wiki/ALPHA)
* [_RGBA32](wiki/_RGBA32) (function) returns the [LONG](wiki/LONG) 32 bit color value in 32 bit screens only with the [ALPHA](wiki/ALPHA)
* [_ROUND](wiki/_ROUND) (function) rounds to the closest [INTEGER](wiki/INTEGER), [LONG](wiki/LONG) or [_INTEGER64](wiki/_INTEGER64) numerical value.

### _S

* [_SCREENCLICK](wiki/_SCREENCLICK) (statement) simulates clicking on a point on the desktop screen with the left mouse button.
* [_SCREENEXISTS](wiki/_SCREENEXISTS) (function) returns a -1 value once a screen has been created.
* [$SCREENHIDE](wiki/$SCREENHIDE) QB64 [Metacommand](wiki/Metacommand) hides the program window from view.
* [_SCREENHIDE](wiki/_SCREENHIDE) (statement) hides the program window from view.
* [_SCREENICON (function)](wiki/_SCREENICON-(function)) returns -1 or 0 to indicate if the window has been minimized to an icon on the taskbar. 
* [_SCREENICON](wiki/_SCREENICON) (statement) minimizes the program window to an icon on the taskbar. 
* [_SCREENIMAGE](wiki/_SCREENIMAGE) (function) creates an image of the current desktop and returns an image handle.
* [_SCREENMOVE](wiki/_SCREENMOVE) (statement) positions program window on the desktop using designated coordinates or the _MIDDLE option.
* [_SCREENPRINT](wiki/_SCREENPRINT) (statement) simulates typing text into a Windows program using the keyboard.
* [$SCREENSHOW](wiki/$SCREENSHOW) (QB64 [Metacommand](wiki/Metacommand)) displays that program window after it was hidden by [$SCREENHIDE](wiki/$SCREENHIDE).
* [_SCREENSHOW](wiki/_SCREENSHOW) (statement) displays the program window after it has been hidden by [_SCREENHIDE](wiki/_SCREENHIDE).
* [_SCREENX](wiki/_SCREENX) (function) returns the program window's upper left corner horizontal position on the desktop.
* [_SCREENY](wiki/_SCREENY) (function) returns the program window's upper left corner vertical position on the desktop.
* [_SCROLLLOCK (function)](wiki/_SCROLLLOCK-(function)) returns -1 when Scroll Lock is on
* [_SCROLLLOCK](wiki/_SCROLLLOCK) (statement) sets Scroll Lock key state
* [_SETALPHA](wiki/_SETALPHA) (statement) sets the alpha channel transparency level of some or all of the pixels of an image.
* [_SETBIT](wiki/_SETBIT) (function) is used to set the specified bit of an integer variable to 1.
* [_SHELLHIDE](wiki/_SHELLHIDE) (function) returns the code sent by a program exit using [END](wiki/END) or [SYSTEM](wiki/SYSTEM) followed by an [INTEGER](wiki/INTEGER) value.
* [_SHL](wiki/_SHL) (function) used to shift the bits of a numerical value to the left
* [_SHR](wiki/_SHR) (function) used to shift the bits of a numerical value to the right.
* [Mathematical Operations](wiki/Mathematical-Operations) (function) Returns the hyperbolic sine of x radians.
* [_SNDBAL](wiki/_SNDBAL) (statement) attempts to set the balance or 3D position of a sound file.
* [_SNDCLOSE](wiki/_SNDCLOSE) (statement) frees and unloads an open sound using the sound handle created by [_SNDOPEN](wiki/_SNDOPEN).
* [_SNDCOPY](wiki/_SNDCOPY) (function) copies a sound handle value to a new designated handle.
* [_SNDGETPOS](wiki/_SNDGETPOS) (function) returns the current playing position in seconds from a sound file.
* [_SNDLEN](wiki/_SNDLEN) (function) returns the length of a sound in seconds from a sound file.
* [_SNDLIMIT](wiki/_SNDLIMIT) (statement) stops playing a sound after it has been playing for a set number of seconds.
* [_SNDLOOP](wiki/_SNDLOOP) (statement) plays a sound repeatedly until [_SNDSTOP](wiki/_SNDSTOP) is used.
* [_SNDOPEN](wiki/_SNDOPEN) (function) loads a sound file and returns a sound handle.
* [_SNDOPENRAW](wiki/_SNDOPENRAW) (function) opens a new channel to shove [_SNDRAW](wiki/_SNDRAW) content into without mixing.
* [_SNDPAUSE](wiki/_SNDPAUSE) (statement) stops playing a sound file until resumed.
* [_SNDPAUSED](wiki/_SNDPAUSED) (function) returns the current pause status of a sound file handle.
* [_SNDPLAY](wiki/_SNDPLAY) (statement) plays a sound file handle that was created by [_SNDOPEN](wiki/_SNDOPEN) or [_SNDCOPY](wiki/_SNDCOPY).
* [_SNDPLAYCOPY](wiki/_SNDPLAYCOPY) (statement) copies a sound handle, plays it and automatically closes the copy when done.
* [_SNDPLAYFILE](wiki/_SNDPLAYFILE) (statement) directly plays a designated sound file.
* [_SNDPLAYING](wiki/_SNDPLAYING) (function) returns the current playing status of a sound handle.
* [_SNDRATE](wiki/_SNDRATE) (function) returns the sound card sample rate to set [_SNDRAW](wiki/_SNDRAW) durations.
* [_SNDRAW](wiki/_SNDRAW) (statement) creates mono or stereo sounds from calculated wave frequency values.
* [_SNDRAWDONE](wiki/_SNDRAWDONE) (statement) pads a [_SNDRAW](wiki/_SNDRAW) stream so the final (partially filled) buffer section is played.
* [_SNDRAWLEN](wiki/_SNDRAWLEN) (function) returns a value until the [_SNDRAW](wiki/_SNDRAW) buffer is empty.
* [_SNDSETPOS](wiki/_SNDSETPOS) (statement) sets the playing position of a sound handle.
* [_SNDSTOP](wiki/_SNDSTOP) (statement) stops playing a sound handle.
* [_SNDVOL](wiki/_SNDVOL) (statement) sets the volume of a sound file handle.
* [_SOURCE](wiki/_SOURCE) (statement) sets the source image handle.
* [_SOURCE (function)](wiki/_SOURCE-(function)) returns the present source image handle value.
* [_STARTDIR$](wiki/_STARTDIR$) (function) returns the user's program calling path as a [STRING](wiki/STRING).
* [_STRCMP](wiki/_STRCMP) (function) compares the relationship between two strings.
* [_STRICMP](wiki/_STRICMP) (function) compares the relationship between two strings, without regard for case-sensitivity.

### _T

* [Mathematical Operations](wiki/Mathematical-Operations) (function) Returns the hyperbolic tangent of x radians.
* [_TITLE](wiki/_TITLE) (statement) sets the program title [STRING](wiki/STRING) value.
* [_TITLE$](wiki/_TITLE$) (function) gets the program title [STRING](wiki/STRING) value.
* [_TOGGLEBIT](wiki/_TOGGLEBIT) (function) is used to toggle the specified bit of an integer variable from 1 to 0 or 0 to 1.
* [_TOTALDROPPEDFILES](wiki/_TOTALDROPPEDFILES) (function)  returns the number of items (files or folders) dropped in a program's window after [_ACCEPTFILEDROP](wiki/_ACCEPTFILEDROP) is enabled.
* [_TRIM$](wiki/_TRIM$) (function) shorthand to [LTRIM$](wiki/LTRIM$)([RTRIM$](wiki/RTRIM$)("text"))

### _U

* [_UNSIGNED](wiki/_UNSIGNED) (numerical type) expands the positive range of numerical [INTEGER](wiki/INTEGER), [LONG](wiki/LONG) or [_INTEGER64](wiki/_INTEGER64) values returned.

### _V

* [$VERSIONINFO](wiki/$VERSIONINFO) ([Metacommand](wiki/Metacommand)) adds metadata to Windows only binaries for identification purposes across the OS.
* [$VIRTUALKEYBOARD](wiki/$VIRTUALKEYBOARD) ([Metacommand](wiki/Metacommand) - Deprecated) turns the virtual keyboard ON or OFF for use in touch-enabled devices

### _W

* [_WHEEL](wiki/_WHEEL) (function) returns -1 when a control device wheel is scrolled up and 1 when scrolled down. Zero indicates no activity.
* [_WIDTH (function)](wiki/_WIDTH-(function)) returns the width of a [SCREEN](wiki/SCREEN) or image handle.
* [_WINDOWHANDLE](wiki/_WINDOWHANDLE) (function) returns the window handle assigned to the current program by the OS. Windows-only.
* [_WINDOWHASFOCUS](wiki/_WINDOWHASFOCUS) (function) returns true (-1) if the current program's window has focus. Windows-only.

## Symbols

### QB64 and QB Symbols

*Note: All symbols below can also be used inside of literal quoted strings except for quotation marks.*

> **Print, Input or File Formatting**

* [Semicolon](wiki/Semicolon) after a [PRINT](wiki/PRINT) stops invisible cursor at end of printed value. Can prevent screen rolling. A [Semicolon](wiki/Semicolon) after the [INPUT](wiki/INPUT) prompt text will display a question mark after the text. 
* [Comma](wiki/Comma) after a [PRINT](wiki/PRINT) tabs invisible cursor past end of printed value. After the [INPUT](wiki/INPUT) prompt text a [comma](wiki/comma) displays no [Question mark](wiki/Question-mark).
* [Quotation mark](wiki/Quotation-mark) delimits the ends of a literal [STRING](wiki/STRING) value in a [PRINT](wiki/PRINT), [INPUT](wiki/INPUT) or [LINE INPUT](wiki/LINE-INPUT) statement.
* [Question mark](wiki/Question-mark) is a shortcut substitute for the [PRINT](wiki/PRINT) keyword. Will change to PRINT when cursor leaves the code line.

### Program Code Markers

* [Apostrophe](wiki/Apostrophe) ignores a line of code or program comment and MUST be used before a [Metacommand](wiki/Metacommand). Same as using [REM](wiki/REM).
* [Comma](wiki/Comma) is used to separate [DATA](wiki/DATA), [SUB](wiki/SUB) or [FUNCTION](wiki/FUNCTION) parameter variables. 
* [Colon](wiki/Colon)s can be used to separate two procedure statements on one code line.
* [Dollar_Sign](wiki/Dollar-Sign) prefix denotes a QBasic [Metacommand](wiki/Metacommand).
* [Parenthesis](wiki/Parenthesis) enclose a math or conditional procedure order, [SUB](wiki/SUB) or [FUNCTION](wiki/FUNCTION) parameters or to pass by value.
* [+](wiki/+) [concatenation](wiki/Concatenation) operator MUST be used to combine literal string values in a variable definition.
* [Quotation mark](wiki/Quotation-mark) designates the ends of a literal [STRING](wiki/STRING) value. Use [CHR$](wiki/CHR$)(34) to insert quotes in a text [STRING](wiki/STRING).
* [Underscore](wiki/Underscore) can be used to continue a line of code to the next program line in **QB64**.

### Variable Name Type Suffixes

* [STRING](wiki/STRING) text character type: 1 byte
* [SINGLE](wiki/SINGLE) floating decimal point numerical type (4 bytes)
* [DOUBLE](wiki/DOUBLE) floating decimal point numerical type (8 bytes)
* [_FLOAT](wiki/_FLOAT) **QB64** decimal point numerical type (32 bytes)
* [_UNSIGNED](wiki/_UNSIGNED) **QB64** [INTEGER](wiki/INTEGER) positive numerical type when it precedes the 6 numerical suffixes below:
* [INTEGER](wiki/INTEGER) [INTEGER](wiki/INTEGER) numerical type (2 bytes)
* [LONG](wiki/LONG) [INTEGER](wiki/INTEGER) numerical type (4 bytes}
* [_INTEGER64](wiki/_INTEGER64) **QB64** [INTEGER](wiki/INTEGER) numerical type (8 bytes) 
* [_BIT](wiki/_BIT) **QB64** [INTEGER](wiki/INTEGER) numerical type (1 bit) (Key below tilde (~) or [CHR$](wiki/CHR$)(96))
* [_BYTE](wiki/_BYTE) **QB64** [INTEGER](wiki/INTEGER) numerical type (1 byte)
* [_OFFSET](wiki/_OFFSET) **QB64** [INTEGER](wiki/INTEGER) numerical pointer address type (any byte size required)

### Numerical Base Prefixes

* [&B](wiki/&B)           Base 2:    Digits 0 or 1 [**QB64**]
* [&O](wiki/&O)            Base 8:    Digits 0 to 7
* [&H](wiki/&H) Base 16: Digits 0 to F

### [Mathematical Operations](wiki/Mathematical-Operations)

* [+](wiki/+) operator or sign
* [-](wiki/-) operator or sign
* [*](wiki/*) operator
* [/](wiki//) (floating decimal point) operator
* [\\](wiki/\\) operator
* [^](wiki/^) operator
* [MOD](wiki/MOD) operator

### [Relational Operations](wiki/Relational-Operations)

* [Equal](wiki/Equal) Equal to condition
* [Not_Equal](wiki/Not-Equal) Not equal condition
* [Greater_Than](wiki/Greater-Than) Greater than condition
* [Less_Than](wiki/Less-Than) Less than condition
* [Greater_Than_Or_Equal](wiki/Greater-Than-Or-Equal) Greater than or equal to condition
* [Less_Than_Or_Equal](wiki/Less-Than-Or-Equal) Less than or equal to condition

## References

Got a question about something?

* [QB64 FAQ](wiki/QB64-FAQ)
* [Visit the QB64 Main Site](http://qb64.com)

Links to other QBasic Sites:

* [Member programs at QBasic Station](http://qbasicstation.com/index.php?c=p_member)
* [QBasic Forum at Network 54](http://www.network54.com/Index/10167)
* [Pete's QBasic Forum](http://www.petesqbsite.com/forum/)
* [Pete's QBasic Downloads](http://www.petesqbsite.com/downloads/downloads.shtml)

---

Although you can find several copies of the QB64 wiki on the internet, many of these exist as *backup copies* due to the past instability issues around QB64 .org and .net websites and (most likely) aren't currently maintained.

To remedy this, a recent project was begun to transition the wiki so that it is managed in the same way as the source code; meaning it is now directly managed and hosted within the [github repo](https://github.com/QB64Official/qb64). You can find this official wiki at:

- [QB64 Wiki on GitHub](https://github.com/QB64Official/qb64/wiki)

Archive / Backup:

- [Studio Pond](http://www.studiopond.uk/qb64wiki/index.html)
