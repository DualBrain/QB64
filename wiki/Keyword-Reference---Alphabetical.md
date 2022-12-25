
# INDEX

## Original QBasic keywords

| [A](Keyword-Reference---Alphabetical#a) | [B](Keyword-Reference---Alphabetical#b) | [C](Keyword-Reference---Alphabetical#c) | [D](Keyword-Reference---Alphabetical#d) | [E](Keyword-Reference---Alphabetical#e) | [F](Keyword-Reference---Alphabetical#f) | [G](Keyword-Reference---Alphabetical#g) | [H](Keyword-Reference---Alphabetical#h) | [I](Keyword-Reference---Alphabetical#i) | J | [K](Keyword-Reference---Alphabetical#k) | [L](Keyword-Reference---Alphabetical#l) | [M](Keyword-Reference---Alphabetical#m) | 
| -- | -- | -- |  -- | -- | -- | -- | -- | -- | -- | -- | -- | -- | 
| [**N**](Keyword-Reference---Alphabetical#n) | [**O**](Keyword-Reference---Alphabetical#o) | [**P**](Keyword-Reference---Alphabetical#p) | **Q** | [**R**](Keyword-Reference---Alphabetical#r) | [**S**](Keyword-Reference---Alphabetical#s) | [**T**](Keyword-Reference---Alphabetical#t) | [**U**](Keyword-Reference---Alphabetical#u) | [**V**](Keyword-Reference---Alphabetical#v) | [**W**](Keyword-Reference---Alphabetical#w) | [**X**](Keyword-Reference---Alphabetical#x) | **Y** | **Z** |

##  QB64 specific keywords

| [_A](Keyword-Reference---Alphabetical#_a) | [_B](Keyword-Reference---Alphabetical#_b) | [_C](Keyword-Reference---Alphabetical#_c) | [_D](Keyword-Reference---Alphabetical#_d) | [_E](Keyword-Reference---Alphabetical#_e) | [_F](Keyword-Reference---Alphabetical#_f) | [_G](Keyword-Reference---Alphabetical#_g) | [_H](Keyword-Reference---Alphabetical#_h) | [_I](Keyword-Reference---Alphabetical#_i) | _J | [_K](Keyword-Reference---Alphabetical#_k) | [_L](Keyword-Reference---Alphabetical#_l) | [_M](Keyword-Reference---Alphabetical#_m) |
| -- | -- | -- |  -- | -- | -- | -- | -- | -- | -- | -- | -- | -- |
| [**_N**](Keyword-Reference---Alphabetical#_n) | [**_O**](Keyword-Reference---Alphabetical#_o) | [**_P**](Keyword-Reference---Alphabetical#_p) | **_Q** | [**_R**](Keyword-Reference---Alphabetical#_r) | [**_S**](Keyword-Reference---Alphabetical#_s) | [**_T**](Keyword-Reference---Alphabetical#_t) | [**_U**](Keyword-Reference---Alphabetical#_t) | [**_V**](Keyword-Reference---Alphabetical#_v) | [**_W**](Keyword-Reference---Alphabetical#_w) | **_X** | **_Y** | **_Z** |

## OpenGL specific keywords
| [_glA](Keyword-Reference---Alphabetical#_gla) | [_glB](Keyword-Reference---Alphabetical#_glb) | [_glC](Keyword-Reference---Alphabetical#_glb) | [_glD](Keyword-Reference---Alphabetical#_gld) | [_glE](Keyword-Reference---Alphabetical#_gle) | [_glF](Keyword-Reference---Alphabetical#_glf) | [_glG](Keyword-Reference---Alphabetical#_glg) | [_glH](Keyword-Reference---Alphabetical#_glh) |[ _glI](Keyword-Reference---Alphabetical#_gli) | _glJ | _glK | [_glL](Keyword-Reference---Alphabetical#_gll) | [_glM](Keyword-Reference---Alphabetical#_glm) |
| -- | -- | -- |  -- | -- | -- | -- | -- | -- | -- | -- | -- | -- |
| [**_glN**](Keyword-Reference---Alphabetical#_gln) | [**_glO**](Keyword-Reference---Alphabetical#_glo) | [**_glP**](Keyword-Reference---Alphabetical#_glp) | **_glQ.** | [**_glR**](Keyword-Reference---Alphabetical#_glr) | [**_glS**](Keyword-Reference---Alphabetical#_gls) | [**_glT**](Keyword-Reference---Alphabetical#_glt) | **_glU.** | [**_glV**](Keyword-Reference---Alphabetical#_glv) | **_glW.** | **_glX.** | **_glY.** | **_glZ.** |

***

##


## Original QBasic keywords:

**These QBasic keywords (with a few noted exceptions) will work in all versions of QB64.**

### A

* [ABS](ABS) (function) converts any negative numerical value to a positive value.
* [CALL ABSOLUTE](CALL-ABSOLUTE) (statement) is used to access computer interrupt registers.
* [ACCESS](ACCESS) (file statement) sets the read and write access of a file when opened.
* [ALIAS](ALIAS) (QB64 [DECLARE LIBRARY](DECLARE-LIBRARY) statement) denotes the actual name of an imported [FUNCTION](FUNCTION) or [SUB](SUB) procedure.
* [AND](AND) (logical operator) is used to compare two numerical values bitwise.
* [AND (boolean)](AND-(boolean)) conditional operator is used to include another evaluation in an [IF...THEN](IF...THEN) or [Boolean](Boolean) statement.
* [APPEND](APPEND) (file mode) creates a new file or allows an existing file to have data added using [WRITE (file statement)](WRITE-(file-statement)) or [PRINT (file statement)](PRINT-(file-statement))
* [AS](AS) is used to denote a variable type or file number.
* [ASC](ASC) (function) returns the [ASCII](ASCII) code number of a text [STRING](STRING) character.
* [ASC (statement)](ASC-(statement)) (QB64 only) sets the code value of an [ASCII](ASCII) text character at a designated [STRING](STRING) position.
* [ATN](ATN) (function) or arctangent returns the angle in radians of a numerical [TAN](TAN) value.

### B

* [BEEP](BEEP) (statement) creates an error sound of a fixed duration.
* [BINARY](BINARY) (file mode) creates or opens an existing file for [GET](GET) and [PUT](PUT) byte-wise access.
* [BLOAD](BLOAD) (statement) transfers the contents of a [BINARY](BINARY) [BSAVE](BSAVE) file to a specific [Arrays](Arrays).
* [BSAVE](BSAVE) (statement) transfers the contents of an [Arrays](Arrays) to a specified size [BINARY](BINARY) file.
* [BYVAL](BYVAL) (statement) assigns a numerical variable value by its value, not the name.

### C

* [CALL](CALL) (statement) optional statement that sends the program to a [SUB](SUB) procedure.  Requires parameters be enclosed in brackets(parenthesis).
* [CALL ABSOLUTE](CALL-ABSOLUTE) (statement) is used to access computer interrupt registers.
* [CASE](CASE) ([SELECT CASE](SELECT-CASE) condition) designates specific conditions in a [SELECT CASE](SELECT-CASE) statement block.
* [CASE ELSE](CASE-ELSE) ([SELECT CASE](SELECT-CASE) condition) designates an alternative condition to be evaluated in a [SELECT CASE](SELECT-CASE) statement block.
* [CASE IS](CASE-IS) ([SELECT CASE](SELECT-CASE) condition) designates specific conditions in a [SELECT CASE](SELECT-CASE) statement block.
* [CDBL](CDBL) (function) returns the closest [DOUBLE](DOUBLE) value of a number.
* [CHAIN](CHAIN) (statement) sends a program to another specified program module or compiled program.
* [CHDIR](CHDIR) (statement) changes the current program path for file access.
* [CHR$](CHR$) (function) returns a text [STRING](STRING) character by the specified [ASCII](ASCII) code number.
* [CINT](CINT) (function) returns the closest [INTEGER](INTEGER) value of a numerical value.
* [CIRCLE](CIRCLE) (statement) creates a circle, ellipse or arc at a designated graphical coordinate position.
* [CLEAR](CLEAR) (statement) sets all variable and array values to zero number values or empty [STRING](STRING)s.
* [CLNG](CLNG) (function) returns the closest [LONG](LONG) value of a numerical value.
* [CLOSE](CLOSE) (statement) closes specific file number(s) or all files when a number is not specified.
* [CLS](CLS) (statement) clears a program [SCREEN](SCREEN), [VIEW](VIEW) port or [WINDOW](WINDOW).
* [COLOR](COLOR) (statement) sets the current text foreground and/or background color to be used.
* [COMMAND$](COMMAND$) (function) returns the command line arguments passed when a program is run.
* [COMMON](COMMON) (statement) sets a variable name as shared by [CHAIN](CHAIN)ed program modules.
* [CONST](CONST) (statement) sets a variable name and its value as a constant value to be used by all procedures.
* [COS](COS) (function) returns the cosine of a radian angle value.
* [CSNG](CSNG) (function) returns the closest [SINGLE](SINGLE) value of a numerical value.
* [CSRLIN](CSRLIN) (function) returns the present [PRINT](PRINT) cursor text row [SCREEN](SCREEN) coordinate position.
* [CVD](CVD) (function) returns the [DOUBLE](DOUBLE) numerical value of an 8 byte [MKD$](MKD$) [STRING](STRING).
* [CVDMBF](CVDMBF) (function) returns the [DOUBLE](DOUBLE) numerical value of a [MKDMBF$](MKDMBF$) [STRING](STRING).
* [CVI](CVI) (function) returns the [INTEGER](INTEGER) numerical value of a 2 byte [MKI$](MKI$) [STRING](STRING).
* [CVL](CVL) (function) returns the [LONG](LONG) numerical value of a 4 byte [MKL$](MKL$) [STRING](STRING).
* [CVS](CVS) (function) returns the [SINGLE](SINGLE) numerical value of a 4 byte [MKS$](MKS$) [STRING](STRING).
* [CVSMBF](CVSMBF) (function) returns the [SINGLE](SINGLE) numerical value of a [MKSMBF$](MKSMBF$) [STRING](STRING).

### D

* [DATA](DATA) (statement) creates a line of fixed program information separated by commas.
* [DATE$](DATE$) (function) returns the present Operating System date [STRING](STRING) formatted as mm-dd-yyyy.
* [DATE$ (statement)](DATE$-(statement)) sets the date of the Operating System using a mm-dd-yyyy [STRING](STRING) format.
* DECLARE [SUB](SUB)/[FUNCTION](FUNCTION) (BASIC statement) declares a [SUB](SUB) or [FUNCTION](FUNCTION) procedure at the start of a program. Not required in QB64.
* [DECLARE LIBRARY](DECLARE-LIBRARY) declares a C++, SDL or Operating System [SUB](SUB) or [FUNCTION](FUNCTION) to be used.
* [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY) declares DYNAMIC, CUSTOMTYPE or STATIC  library(DLL) [SUB](SUB) or [FUNCTION](FUNCTION).
* [DEF SEG](DEF-SEG) (statement) defines a segment in memory to be accessed by a memory procedure.
* [DEFDBL](DEFDBL) (statement) defines a set of undefined variable name starting letters as [DOUBLE](DOUBLE) type numerical values.
* [DEFINT](DEFINT) (statement) defines a set of undefined variable name starting letters as [INTEGER](INTEGER) type numerical values.
* [DEFLNG](DEFLNG) (statement) defines a set of undefined variable name starting letters as [LONG](LONG) type numerical values.
* [DEFSNG](DEFSNG) (statement) defines a set of undefined variable name starting letters as [SINGLE](SINGLE) type numerical values.
* [DEFSTR](DEFSTR) (statement) defines a set of undefined variable name starting letters as [STRING](STRING) type values.
* [DIM](DIM) (statement) defines a variable as a specified type and can size a [STATIC](STATIC)  array.
* [DO...LOOP](DO...LOOP) (statement) sets a recursive procedure loop that can be ignored or exited using conditional arguments.
* [DOUBLE](DOUBLE) (numerical type #) 8 byte value limited to values up to 15 decimal places.
* [DRAW](DRAW) (statement) uses a special [STRING](STRING) format that draws graphical lines in specific directions.
* [$DYNAMIC]($DYNAMIC) ([Metacommand](Metacommand)) used at the start of a program to set all program arrays as changeable in size using [REDIM](REDIM).

### E

* [ELSE](ELSE) ([IF...THEN](IF...THEN) statement) is used to direct program flow when no other condition is evaluated as true.
* [ELSEIF](ELSEIF) ([IF...THEN](IF...THEN) statement) is used with [THEN](THEN) to set alternate conditional evaluations.
* [END](END) (statement) sets the end of a program, sub-procedure, statement block, [DECLARE LIBRARY](DECLARE-LIBRARY) or [TYPE](TYPE) definition.
* [IF...THEN](IF...THEN) (statement) [END](END)s an IF...THEN conditional block statement using more than one line of code.
* [ENVIRON](ENVIRON) (statement) temporarily sets an environmental key/pair value.
* [ENVIRON$](ENVIRON$) (function) returns a specified string setting or numerical position as an environmental [STRING](STRING) value.
* [EOF](EOF) (file function) returns -1 when a file [INPUT (file statement)](INPUT-(file-statement)) or [GET](GET) has reached the end of a file.
* [EQV](EQV) (logic operator) is used to compare two numerical values bitwise.
* [ERASE](ERASE) (statement) clears the values from [$STATIC]($STATIC) arrays and completely removes [$DYNAMIC]($DYNAMIC) arrays.
* [ERDEV](ERDEV) (function) returns an error code from the last device to create an error.
* [ERDEV$](ERDEV$) (function) returns the 8 character name of the last device to declare an error as a [STRING](STRING).
* [ERL](ERL) (error function) returns the closest line number before an error occurred if line numbers are used.
* [ERR](ERR) (function) returns the [ERROR Codes](ERROR-Codes) when a program error occurs.
* [ERROR](ERROR) (statement) sets a specific [ERROR Code](ERROR-Codes) to be simulated.
* [EVERYCASE](SELECT-CASE) Used on [SELECT CASE](SELECT-CASE) statement.
* [EXIT](EXIT) (statement) immediately exits a program [FOR...NEXT](FOR...NEXT), [DO...LOOP](DO...LOOP), [SUB](SUB) or [FUNCTION](FUNCTION) procedure.
* [EXP](EXP) (function) returns the value of e to the exponential power specified.

### F

* [FIELD](FIELD) (statement) defines the variable sizes to be written or read from a file.
* [FILEATTR](FILEATTR) (function) returns the current file access mode.
* [FILES](FILES) (statement) returns a list of files in the current directory path to the [SCREEN](SCREEN).
* [FIX](FIX) (function) returns the rounded [INTEGER](INTEGER) value of a numerical value.
* [FOR...NEXT](FOR...NEXT) (statement) creates a recursive loop procedure that loop a specified number of times.
* [FOR (file statement)](FOR-(file-statement)) used in an [OPEN](OPEN) file or device statement to indicate the access mode.
* [FRE](FRE) (function) returns the number of bytes of Memory available to running programs.
* [FREE (QB64 TIMER statement)](TIMER) frees a numbered TIMER event in QB64.
* [FREEFILE](FREEFILE) (file function) returns a file number that is currently not in use by the Operating System.
* [FUNCTION](FUNCTION) (procedure block) sub-procedure that can calculate and return one value to a program in its name.

### G

* [GET](GET) (file statement) reads a file sequentially or at a specific position and returns the value as the variable type used.
* [GET (TCP/IP statement)](GET-(TCP-IP-statement)) reads a connection port to return a value.
* [GET (graphics statement)](GET-(graphics-statement)) maps an area the current [SCREEN](SCREEN) video information and places it in an [INTEGER](INTEGER) [arrays](arrays).
* [GOSUB](GOSUB) (statement) sends the program to a designated line label procedure in the main program.
* [GOTO](GOTO) (statement) sends the program to a designated line number or line label in a procedure.

### H

* [HEX$](HEX$) (function) returns the hexadecimal (base 16) [STRING](STRING) representation of the [INTEGER](INTEGER) part of any value.

### I

* [IF...THEN](IF...THEN) (statement) a conditional block statement used control program flow.
* [IMP](IMP) (logic operator) is used to compare two numerical values bitwise.
* [$INCLUDE]($INCLUDE) ([Metacommand](Metacommand)) designates a text code library file to include with the program.
* [INKEY$](INKEY$) (function) [ASCII](ASCII) returns a [STRING](STRING) value entry from the keyboard.
* [INP](INP) (function) returns a numerical value from a specified port register address. See [Keyboard scancodes](Keyboard-Scancodes)
* [INPUT](INPUT) (statement) a user input that returns a value to one or more specified variable(s).
* [INPUT (file mode)](INPUT-(file-mode)) [OPEN](OPEN) statement that only allows an existing file to be read using [INPUT (file statement)](INPUT-(file-statement)) or [INPUT$](INPUT$).
* [INPUT (file statement)](INPUT-(file-statement)) reads a file sequentially using the variable types designated. 
* [INPUT$](INPUT$) (function) returns a designated number of [STRING](STRING) bytes from the keyboard entry or a file number.
* [INSTR](INSTR) (function) returns the position in a text [STRING](STRING) where a character sequence match starts.
* [INT](INT) (function) rounds a numerical value to an [INTEGER](INTEGER) value by removing the decimal point fraction.
* [INTEGER](INTEGER) (% numerical type) 2 byte whole values from -32768 to 32767.
* [INTERRUPT](INTERRUPT) (statement) is used to access computer interrupt registers.
* [INTERRUPTX](INTERRUPTX) (statement) is used to access computer interrupt registers.
* [IOCTL](IOCTL) (statement)
* [IOCTL$](IOCTL$) (function)

### K

* [KEY n](KEY-n) (statement) used with [ON KEY(n)](ON-KEY(n)) events to assign a "soft key" string to a key or create a  user defined key.
* [KEY(n)](KEY(n)) (statement) used with [ON KEY(n)](ON-KEY(n)) events to assign, enable, disable or suspend event trapping.
* [KEY LIST](KEY-LIST) (statement) lists the 12 Function key soft key string assignments going down left side of screen.
* [KILL](KILL) (statement) deletes the specified file without a warning. Remove empty folders with [RMDIR](RMDIR).

### L

* [LBOUND](LBOUND) (function) returns the lower boundary of the specified array.
* [LCASE$](LCASE$) (function) returns the lower case value of a [STRING](STRING).
* [LEFT$](LEFT$) (function) returns the specified number of text characters from the left end of a [STRING](STRING).
* [LEN](LEN) (function) returns the length or number of characters in a [STRING](STRING) value in bytes.
* [LET](LET) (statement) assigns a variable a literal value. Not required.
* [LINE](LINE) (statement) creates a graphic line or box on the [SCREEN](SCREEN).
* [LINE INPUT](LINE-INPUT) (statement) user input can be any text character including commas and quotes as a [STRING](STRING) value only.
* [LINE INPUT (file statement)](LINE-INPUT-(file-statement)) returns an entire text file line and returns it as a [STRING](STRING) value.
* [KEY LIST](KEY-LIST) displays the current [ON KEY(n)](ON-KEY(n)) function key (F1 to F10) "soft key" settings.
* [LOC](LOC) (function) returns the present file byte position or number of bytes in the [OPEN COM](OPEN-COM) buffer.
* [LOCATE](LOCATE) (statement) sets the text cursor's row and column position for a [PRINT](PRINT) or [INPUT](INPUT) statement. 
* [LOCK](LOCK) (statement) restricts access to portions or all of a file by other programs or processes.
* [LOF](LOF) (function) returns the size of an [OPEN](OPEN) file in bytes.
* [LOG](LOG) (function) returns the natural logarithm of a specified numerical value
* [LONG](LONG) (& numerical type) 4 byte whole values from -2147483648 to 2147483647.
* [DO...LOOP](DO...LOOP) (block statement) bottom end of a recursive DO loop.
* [LPOS](LPOS) (function) returns the printer head position.
* [LPRINT](LPRINT) (statement) sends [STRING](STRING) data to the default LPT or USB printer.
* [LPRINT USING](LPRINT-USING) (statement) sends template formatted text to the default LPT or USB  printer.
* [LSET](LSET) (statement) left justifies the text in a string so that there are no leading spaces.
* [LTRIM$](LTRIM$) (function) returns a [STRING](STRING) value with no leading spaces.

### M

* [MID$](MID$) (function) returns a designated portion of a [STRING](STRING).
* [MID$ (statement)](MID$-(statement)) redefines existing characters in a [STRING](STRING).
* [MKD$](MKD$) (function) returns an 8 byte [ASCII](ASCII) [STRING](STRING) representation of a [DOUBLE](DOUBLE) numerical value.
* [MKDIR](MKDIR) (statement) creates a new folder in the current or designated program path.
* [MKDMBF$](MKDMBF$) (function) returns an 8 byte Microsoft Binary Format [STRING](STRING) representation of a [DOUBLE](DOUBLE) numerical value.
* [MKI$](MKI$) (function) returns a 2 byte [ASCII](ASCII) [STRING](STRING) representation of an [INTEGER](INTEGER). 
* [MKL$](MKL$) (function) returns a 4 byte [ASCII](ASCII) [STRING](STRING) representation of a [LONG](LONG) numerical value.
* [MKS$](MKS$) (function) returns a 4 byte [ASCII](ASCII) [STRING](STRING) representation of a [SINGLE](SINGLE) numerical value.
* [MKSMBF$](MKSMBF$) (function) returns an 8 byte Microsoft Binary Format [STRING](STRING) representation of a [DOUBLE](DOUBLE) numerical value.
* [MOD](MOD) (math operator) performs integer remainder division on a numerical value.

### N

* [NAME](NAME) (statement) names an existing file name [AS](AS) a new file name.
* [NEXT](NEXT) (statement) bottom end of a [FOR...NEXT](FOR...NEXT) counter loop to returns to the start or a [RESUME](RESUME) error.
* [NOT](NOT) (logical operator) inverts the value of a logic operation or returns True when a [boolean](boolean) evaluation is False.

### O

* [OCT$](OCT$) (function) returns the octal (base 8) [STRING](STRING) representation of the [INTEGER](INTEGER) part of any value.
* [OFF](OFF) (event statement) turns off all [ON](ON) event checking.
* [ON COM(n)](ON-COM(n)) (statement) sets up a COM port event procedure call.
* [ON ERROR](ON-ERROR) (statement) sets up and activates an error event checking procedure call. Use to avoid program errors.
* [ON KEY(n)](ON-KEY(n)) (statement) sets up a keyboard key entry event procedure.
* [ON PEN](ON-PEN) (statement) sets up a pen event procedure call.
* [ON PLAY(n)](ON-PLAY(n)) (statement) sets up a [PLAY](PLAY) event procedure call.
* [ON STRIG(n)](ON-STRIG(n)) (statement) sets up a joystick button event procedure call.
* [ON TIMER(n)](ON-TIMER(n)) (statement) sets up a timed event procedure call.
* [ON UEVENT](ON-UEVENT) (statement) **Not implemented in QB64.**
* [ON...GOSUB](ON...GOSUB) (statement) sets up a numerical event procedure call.
* [ON...GOTO](ON...GOTO) (statement) sets up a numerical event procedure call.
* [OPEN](OPEN) (file statement) opens a file name for an access mode with a specific file number.
* [OPEN COM](OPEN-COM) (statement) opens a serial communication port for access at a certain speed and mode.
* [OPTION BASE](OPTION-BASE) (statement) can set the lower boundary of all arrays to 1.
* [OR](OR) (logic operator) is used to compare two numerical values bitwise.
* [OR (boolean)](OR-(boolean)) conditional operator is used to include an alternative evaluation in an [IF...THEN](IF...THEN) or [Boolean](Boolean) statement.
* [OUT](OUT) (statement) writes numerical data to a specified register port.
* [OUTPUT](OUTPUT) (file mode) creates a new file or clears all data from an existing file to access the file sequentially.

### P

* [PAINT](PAINT) (statement) fills an enclosed area of a graphics [SCREEN](SCREEN) with a color until it encounters a specific colored border.
* [PALETTE](PALETTE) (statement) sets the Red, Green and Blue color attribute intensities using a RGB multiplier calculation.
* [PALETTE USING](PALETTE-USING) (statement) sets the color intensity settings using a designated [arrays](arrays).
* [PCOPY](PCOPY) (statement) swaps two designated memory page images when page swapping is enabled in the [SCREEN](SCREEN) statement.
* [PEEK](PEEK) (function) returns a numerical value from a specified segment address in memory. 
* [PEN](PEN) (function) returns requested information about the light pen device used.
* [PEN (statement)](PEN-(statement)) enables/disables or suspends event trapping of a light pen device.
* [PLAY(n)](PLAY(n)) (function) returns the number of notes currently in the background music queue.
* [PLAY](PLAY) (statement) uses a special [STRING](STRING) format that can produce musical tones and effects.
* [PMAP](PMAP) (function) returns the physical or WINDOW view graphic coordinates.
* [POINT](POINT) (function) returns the color attribute number or 32 bit [_RGB32](_RGB32) value.
* [POKE](POKE) (statement) writes a numerical value to a specified segment address in memory.
* [POS](POS) (function) returns the current text column position of the text cursor.
* [PRESET](PRESET) (statement) sets a pixel coordinate to the background color unless one is specified.
* [PRINT](PRINT) (statement) prints text [STRING](STRING) or numerical values to the [SCREEN](SCREEN).
* [PRINT (file statement)](PRINT-(file-statement)) prints text [STRING](STRING) or numerical values to a file.
* [PRINT USING](PRINT-USING) (statement) prints a template formatted [STRING](STRING) to the [SCREEN](SCREEN).
* [PRINT USING (file statement)](PRINT-USING-(file-statement)) prints a template formatted [STRING](STRING) to a file.
* [PSET](PSET) (statement) sets a pixel coordinate to the current color unless a color is designated.
* [PUT](PUT) (file I/O statement) writes data sequentially or to a designated position using a variable value.
* [PUT (TCP/IP statement)](PUT-(TCP-IP-statement)) sends raw data to a user's connection handle.
* [PUT (graphics statement)](PUT-(graphics-statement)) places pixel data stored in an [INTEGER](INTEGER) array to a specified area of the [SCREEN](SCREEN).

### R

* [RANDOM](RANDOM) (file mode) creates a file or opens an existing file to [GET](GET) and [PUT](PUT) records of a set byte size.
* [RANDOMIZE](RANDOMIZE) (statement) sets the random seed value for a specific sequence of random [RND](RND) values.
* [RANDOMIZE](RANDOMIZE) restarts the designated seed value's random sequence of values from the beginning.
* [READ](READ) (statement) reads values from a [DATA](DATA) field. [ACCESS](ACCESS) READ is used with the [OPEN](OPEN) statement.
* [REDIM](REDIM) (statement) creates a new [$DYNAMIC]($DYNAMIC) array or resizes one without losing data when [_PRESERVE](_PRESERVE) is used.
* [REM](REM) (statement) or an apostrophe tells the program to ignore statements following it on the same line.
* [RESET](RESET) (statement)  closes all files and writes the directory information to a diskette before it is removed from a disk drive.
* [RESTORE](RESTORE) (statement) resets the [DATA](DATA) pointer to the start of a designated field of data.
* [RESUME](RESUME) (statement) an [ERROR Codes](ERROR-Codes) handling procedure exit that can send the program to a line number or the [NEXT](NEXT) code line.
* [RETURN](RETURN) (statement) returns the program to the code immediately following a [GOSUB](GOSUB) call.
* [RIGHT$](RIGHT$) (function) returns a specific number of text characters from the right end of a [STRING](STRING).
* [RMDIR](RMDIR) (statement) removes an empty folder from the current path or the one designated.
* [RND](RND) (function) returns a random number value from 0 to .9999999.
* [RSET](RSET) (statement) right justifies a string value so that any end spaces are moved to the beginning.
* [RTRIM$](RTRIM$) (function) returns a [STRING](STRING) with all spaces removed from the right end.
* [RUN](RUN) (statement) clears and restarts the program currently in memory or executes another specified program.

### S

* [SADD](SADD) (function) returns the address of a STRING variable as an offset from the current data segment.
* [SCREEN (function)](SCREEN-(function)) can return the [ASCII](ASCII) character code or color of the text at a text designated coordinate.
* [SCREEN](SCREEN) (statement) sets the display mode and size of the program window.
* [SEEK](SEEK) (function) returns the present byte position in an [OPEN](OPEN) file.
* [SEEK (statement)](SEEK-(statement)) moves to a specified position in an [OPEN](OPEN) file.
* [SELECT CASE](SELECT-CASE) (statement) a program flow block that can handle numerous conditional evaluations.
* [SETMEM](SETMEM) (function) sets the memory to use.
* [SGN](SGN) (function) returns -1 for negative, 0 for zero, and 1 for positive numerical values.
* [SHARED](SHARED) (statement) designates that a variable can be used by other procedures or the main procedure when in a sub-procedure.
* [SHELL](SHELL) (statement) sends [STRING](STRING) commands to the command line. SHELL calls will not affect the current path.
* [SHELL (function)](SHELL-(function)) executes an external command or calls another program. Returns codes sent by [END](END) or [SYSTEM](SYSTEM).
* [SIGNAL](SIGNAL) (OS 2 event)
* [SIN](SIN) (function) returns the sine of a radian angle.
* [SINGLE](SINGLE) (! numerical type) 4 byte floating decimal point values up to 7 decimal places.
* [SLEEP](SLEEP) (statement) pauses the program for a designated number of seconds or until a key is pressed.
* [SOUND](SOUND) (statement) creates a sound of a specified frequency and duration.
* [SPACE$](SPACE$) (function) returns a designated number of spaces to a [STRING](STRING).
* [SPC](SPC) (function) moves the text cursor a number of spaces on the [SCREEN](SCREEN).
* [SQR](SQR) (function) returns the square root of a non-negative number.
* [STATIC](STATIC) (statement) creates a [SUB](SUB) or [FUNCTION](FUNCTION) variable that retains its value.
* [$STATIC]($STATIC) ([Metacommand](Metacommand)) used at the start of a program to set all program arrays as unchangeable in size using [DIM](DIM).
* [STEP](STEP) (keyword) move relatively from one graphic position or change the counting increment in a [FOR...NEXT](FOR...NEXT) loop.
* [STICK](STICK) (function) returns the present joystick position.
* [STOP](STOP) (statement) stops a program when troubleshooting or stops an [ON](ON) event.
* [STR$](STR$) (function) returns a [STRING](STRING) value of a number with a leading space when it is positive.
* [STRIG](STRIG) (function) returns the joystick button press values when read.
* [STRIG(n)](STRIG(n)) (statement) 
* [STRING](STRING) ($ variable type) one byte text variable with [ASCII](ASCII) code values from 0 to 255.
* [STRING$](STRING$) (function) returns a designated number of string characters.
* [SUB](SUB) (procedure block) sub-procedure that can calculate and return multiple parameter values.
* [SWAP](SWAP) (statement) swaps two [STRING](STRING) or numerical values.
* [SYSTEM](SYSTEM) (statement) ends a program immediately.

### T

* [TAB](TAB) (function) moves a designated number of columns on the [SCREEN](SCREEN).
* [TAN](TAN) (function) returns the ratio of [SIN](SIN)e to [COS](COS)ine or tangent value of an angle measured in radians.
* [THEN](THEN) ([IF...THEN](IF...THEN) keyword) must be used in a one line [IF...THEN](IF...THEN) program flow statement.
* [TIME$](TIME$) (function) returns the present time setting of the Operating System as a  format hh:mm:ss [STRING](STRING).
* [TIMER](TIMER) (function) returns the number of seconds since midnight as a [SINGLE](SINGLE) value. 
* [TIMER (statement)](TIMER-(statement)) events based on the designated time interval and timer number.
* [TO](TO) indicates a range of numerical values or an assignment of one value to another.
* [TYPE](TYPE) (definition) defines a variable type or file record that can include any [STRING](STRING) or numerical types.

### U

* [UBOUND](UBOUND) (function) returns the upper-most index number of a designated [arrays](arrays).
* [UCASE$](UCASE$) (function) returns an uppercase representation of a specified [STRING](STRING).
* [UEVENT](UEVENT) (statement) **Not implemented in QB64.**
* [UNLOCK](UNLOCK) (statement) unlocks a designated file or portions of it.
* [UNTIL](UNTIL) (condition) evaluates a [DO...LOOP](DO...LOOP) condition until it is True.

### V

* [VAL](VAL) (function) returns the numerical value of a [STRING](STRING) number.
* [VARPTR](VARPTR) (function) returns the [segment](Segment) pointer address in memory.
* [VARPTR$](VARPTR$) (function) returns the string value of a numerical value in memory.
* [VARSEG](VARSEG) (function) returns the [segment](Segment) address of a value in memory.
* [VIEW](VIEW) (graphics statement) sets up a graphic view port area of the [SCREEN](SCREEN).
* [VIEW PRINT](VIEW-PRINT) (statement) sets up a text view port area of the [SCREEN](SCREEN).

### W

* [WAIT](WAIT) (statement) waits until a vertical retrace is started or a [SCREEN](SCREEN) draw ends.
* [WEND](WEND) (statement) the bottom end of a [WHILE...WEND](WHILE...WEND) loop.
* [WHILE](WHILE) (condition) evaluates a [DO...LOOP](DO...LOOP) or [WHILE...WEND](WHILE...WEND) condition until it is False.
* [WHILE...WEND](WHILE...WEND) (statement) sets a recursive procedure loop that can only be exited using the [WHILE](WHILE) conditional argument.
* [WIDTH](WIDTH) (statement) sets the text column and row sizes in several [SCREEN](SCREEN) modes.
* [WINDOW](WINDOW) (statement) maps a window size different from the program's window size.
* [WRITE](WRITE) (screen I/O statement) prints variable values to the screen with commas separating each value.
* [WRITE (file statement)](WRITE-(file-statement)) writes data to a file with each variable value separated by commas.

### X

* [XOR](XOR) (logic operator) is used to compare two numerical values bitwise.

## QB64 specific keywords

Keywords beginning with underscores are QB64 specific. **To use them without the prefix, use [$NOPREFIX]($NOPREFIX).** Also note that the underscore prefix is reserved for QB64 KEYWORDS only.

### _A

* [_ACCEPTFILEDROP](_ACCEPTFILEDROP) (statement) turns a program window into a valid drop destination for dragging files from Windows Explorer.
* [_ACOS](_ACOS) (function) arccosine function returns the angle in radians based on an input [COS](COS)ine value range from -1 to 1.
* [_ACOSH](_ACOSH) (function) Returns the nonnegative arc hyperbolic cosine of x, expressed in radians.
* [_ALLOWFULLSCREEN](_ALLOWFULLSCREEN) (statement) allows setting the behavior of the ALT+ENTER combo.
* [_ALPHA](_ALPHA) (function) returns the alpha channel transparency level of a color value used on a screen page or image.
* [_ALPHA32](_ALPHA32) (function) returns the alpha channel transparency level of a color value used on a 32 bit screen page or image.
* [_ASIN](_ASIN) (function) Returns the principal value of the arc sine of x, expressed in radians.
* [_ASINH](_ASINH) (function) Returns the arc hyperbolic sine of x, expressed in radians.
* [_ASSERT](_ASSERT) (statement) Performs debug tests.
* [$ASSERTS]($ASSERTS) (metacommand) Enables the [_ASSERT](_ASSERT) macro
* [_ATAN2](_ATAN2) (function) Returns the principal value of the [ATN](ATN) of y/x, expressed in radians.
* [_ATANH](_ATANH) (function) Returns the arc hyperbolic tangent of x, expressed in radians.
* [_AUTODISPLAY](_AUTODISPLAY) (statement) enables the automatic display of the screen image changes previously disabled by [_DISPLAY](_DISPLAY).
* [_AUTODISPLAY (function)](_AUTODISPLAY-(function)) returns the current display mode as true (-1) if automatic or false (0) if per request using [_DISPLAY](_DISPLAY).
* [_AXIS](_AXIS) (function) returns a [SINGLE](SINGLE) value between -1 and 1 indicating the maximum distance from the device axis center, 0.

### _B

* [_BACKGROUNDCOLOR](_BACKGROUNDCOLOR) (function) returns the current [SCREEN](SCREEN) background color.
* [_BIT](_BIT) (` numerical type) can return only signed values of 0 (bit off) and -1 (bit on). Unsigned 0 or 1.
* [_BLEND](_BLEND) (statement) statement turns on 32 bit alpha blending for the current image or screen mode and is default.
* [_BLEND (function)](_BLEND-(function)) returns -1 if enabled or 0 if disabled by [_DONTBLEND](_DONTBLEND) statement.
* [_BLINK](_BLINK) (statement) statement turns blinking colors on/off in SCREEN 0
* [_BLINK (function)](_BLINK-(function)) returns -1 if enabled or 0 if disabled by [_BLINK](_BLINK) statement.
* [_BLUE](_BLUE) (function) function returns the palette or the blue component intensity of a 32-bit image color.
* [_BLUE32](_BLUE32) (function) returns the blue component intensity of a 32-bit color value.
* [_BUTTON](_BUTTON) (function) returns -1 when a controller device button is pressed and 0 when button is released.
* [_BUTTONCHANGE](_BUTTONCHANGE) (function) returns -1 when a device button has been pressed and 1 when released. Zero indicates no change.
* [_BYTE](_BYTE) (%% numerical type) can hold signed values from -128 to 127 (one byte or _BIT * 8). Unsigned from 0 to 255.

### _C

* [_CAPSLOCK (function)](_CAPSLOCK-(function)) returns -1 when Caps Lock is on
* [_CAPSLOCK](_CAPSLOCK) (statement) sets Caps Lock key state
* [$CHECKING]($CHECKING) (QB64 C++ [Metacommand](Metacommand)) turns event error checking OFF or ON.
* [_CEIL](_CEIL) (function) Rounds x upward, returning the smallest integral value that is not less than x.
* [_CINP](_CINP) (function) Returns a key code from $CONSOLE input
* [_CLEARCOLOR (function)](_CLEARCOLOR-(function)) returns the current transparent color of an image.
* [_CLEARCOLOR](_CLEARCOLOR) (statement) sets a specific color index of an image to be transparent
* [_CLIP](_CLIP) ([PUT (graphics statement)](PUT-(graphics-statement)) graphics option) allows placement of an image partially off of the screen.
* [_CLIPBOARD$](_CLIPBOARD$) (function) returns the operating system's clipboard contents as a [STRING](STRING).
* [_CLIPBOARD$ (statement)](_CLIPBOARD$-(statement)) sets and overwrites the [STRING](STRING) value in the operating system's clipboard. 
* [_CLIPBOARDIMAGE (function)](_CLIPBOARDIMAGE-(function)) pastes an image from the clipboard into a new QB64 image in memory.
* [_CLIPBOARDIMAGE](_CLIPBOARDIMAGE) (statement) copies a valid QB64 image to the clipboard.
* [$COLOR]($COLOR) (metacommand) includes named color constants in a program
* [_COMMANDCOUNT](_COMMANDCOUNT) (function) returns the number of arguments passed to the compiled program from the command line.
* [_CONNECTED](_CONNECTED) (function) returns the status of a TCP/IP connection handle.
* [_CONNECTIONADDRESS$](_CONNECTIONADDRESS$) (TCP/IP function) returns a connected user's STRING IP address value using the handle.
* [$CONSOLE]($CONSOLE) (QB64 [Metacommand](Metacommand)) creates a console window that can be used throughout a program.
* [_CONSOLE](_CONSOLE) (statement) used to turn a console window OFF or ON or to designate [_DEST](_DEST) _CONSOLE for output.
* [_CONSOLEINPUT](_CONSOLEINPUT) (function) fetches input data from a [$CONSOLE]($CONSOLE) window to be read later (both mouse and keyboard)
* [_CONSOLETITLE](_CONSOLETITLE) (statement) creates the title of the console window using a literal or variable [STRING](STRING).
* [_CONTINUE](_CONTINUE) (statement) skips the remaining lines in a control block (DO/LOOP, FOR/NEXT or WHILE/WEND)
* [_CONTROLCHR](_CONTROLCHR) (statement) [OFF](OFF) allows the control characters to be used as text characters. [ON](ON) (default) can use them as commands.
* [_CONTROLCHR (function)](_CONTROLCHR-(function))   returns the current state of [_CONTROLCHR](_CONTROLCHR) as 1 when OFF and 0 when ON.
* [_COPYIMAGE](_COPYIMAGE) (function) copies an image handle value to a new designated handle.
* [_COPYPALETTE](_COPYPALETTE) (statement) copies the color palette intensities from one 4 or 8 BPP image to another image.
* [_CV](_CV) (function) converts any [_MK$](_MK$) [STRING](STRING) value to the designated numerical type value.
* [_CWD$](_CWD$) (function) returns the current working directory  as a [STRING](STRING) value.

### _D 

* [_D2G](_D2G) (function) converts degrees to gradian angle values.
* [_D2R](_D2R) (function) converts degrees to radian angle values.
* [$DEBUG]($DEBUG) (metacommand) enables debugging features, allowing you to step through your code line by line
* [DECLARE LIBRARY](DECLARE-LIBRARY) declares a C++, SDL or Operating System [SUB](SUB) or [FUNCTION](FUNCTION) to be used.
* [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY) declares [DYNAMIC](DYNAMIC), [CUSTOMTYPE](CUSTOMTYPE) or [STATIC](STATIC) library (DLL) [SUB](SUB) or [FUNCTION](FUNCTION).
* [_DEFAULTCOLOR](_DEFAULTCOLOR) (function) returns the current default text color for an image handle or page.
* [_DEFINE](_DEFINE) (statement) defines a range of variable names according to their first character as a data type.
* [_DEFLATE$](_DEFLATE$) (function) compresses a string
* [_DELAY](_DELAY) (statement) suspends program execution for a [SINGLE](SINGLE) number of seconds.
* [_DEPTHBUFFER](_DEPTHBUFFER) (statement) enables, disables, locks or clears depth buffering.
* [_DESKTOPHEIGHT](_DESKTOPHEIGHT) (function) returns the height of the desktop (not program window).
* [_DESKTOPWIDTH](_DESKTOPWIDTH) (function) returns the width of the desktop (not program window).
* [_DEST](_DEST) (statement) sets the current write image or [SCREEN](SCREEN) page destination for prints or graphics.
* [_DEST (function)](_DEST-(function)) returns the current destination screen page or image handle value.
* [_DEVICE$](_DEVICE$) (function) returns a [STRING](STRING) expression listing a designated numbered input device name and types of input.
* [_DEVICEINPUT](_DEVICEINPUT) (function) returns the [_DEVICES](_DEVICES) number of an [_AXIS](_AXIS), [_BUTTON](_BUTTON) or [_WHEEL](_WHEEL) event.
* [_DEVICES](_DEVICES) (function) returns the number of input devices found on a computer system including the keyboard and mouse.
* [_DIR$](_DIR$) (function) returns common paths in Windows only, like My Documents, My Pictures, My Music, Desktop.
* [_DIREXISTS](_DIREXISTS) (function) returns -1 if the Directory folder name [STRING](STRING) parameter exists. Zero if it does not.
* [_DISPLAY](_DISPLAY) (statement) turns off the [_AUTODISPLAY](_AUTODISPLAY) while only displaying the screen changes when called.
* [_DISPLAY (function)](_DISPLAY-(function)) returns the handle of the current image that is displayed on the screen.
* [_DISPLAYORDER](_DISPLAYORDER) (statement) designates the order to render software, hardware and custom-opengl-code.
* [_DONTBLEND](_DONTBLEND) (statement) statement turns off default [_BLEND](_BLEND) 32 bit [_ALPHA](_ALPHA) blending for the current image or screen.
* [_DONTWAIT](_DONTWAIT) ([SHELL](SHELL) action) specifies that the program should not wait until the shelled command/program is finished.
* [_DROPPEDFILE](_DROPPEDFILE) (function)  returns the list of items (files or folders) dropped in a program's window after [_ACCEPTFILEDROP](_ACCEPTFILEDROP) is enabled.

### _E

* [_ECHO](_ECHO) (statement) used in conjunction with $IF for the pre-compiler.
* [$ELSE]($ELSE) (Pre-Compiler [Metacommand](Metacommand)) used in conjunction with $IF for the pre-compiler.
* [$ELSEIF]($ELSEIF) (Pre-Compiler [Metacommand](Metacommand)) used in conjunction with $IF for the pre-compiler.
* [$END IF]($END-IF) (Pre-Compiler [Metacommand](Metacommand)) used in conjunction with $IF for the pre-compiler.
* [$ERROR]($ERROR)  (precompiler [metacommand](metacommand)) used to trigger compiler errors.
* [_ERRORLINE](_ERRORLINE) (function) returns the source code line number that caused the most recent runtime error.
* [_ERRORMESSAGE$](_ERRORMESSAGE$) (function) returns a human-readable message describing the most recent runtime error.
* [$EXEICON]($EXEICON) (Pre-Compiler [Metacommand](Metacommand)) used with a .ICO icon file name to embed the image into the QB64 executable.
* [_EXIT (function)](_EXIT-(function)) prevents a user exit and indicates if a user has clicked the close X window button or CTRL + BREAK.

### _F

* [_FILEEXISTS](_FILEEXISTS) (function) returns -1 if the file name [STRING](STRING) parameter exists. Zero if it does not.
* [_FINISHDROP](_FINISHDROP) (statement)  resets [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES) and clears the [_DROPPEDFILE](_DROPPEDFILE) list of items (files/folders).
* [_FLOAT](_FLOAT) (numerical type ##) offers the maximum floating-point decimal precision available using QB64.
* [_FONT](_FONT) (statement) sets the current font handle to be used by PRINT or [_PRINTSTRING](_PRINTSTRING).
* [_FONT (function)](_FONT-(function)) creates a new font handle from a designated image handle.
* [_FONTHEIGHT](_FONTHEIGHT) (function) returns the current text or font height.
* [_FONTWIDTH](_FONTWIDTH) (function) returns the current text or font width.
* [_FREEFONT](_FREEFONT) (statement) releases the current font handle from memory.
* [_FREEIMAGE](_FREEIMAGE) (statement) releases a designated image handle from memory.
* [_FREETIMER](_FREETIMER) (function) returns an unused timer number value to use with [ON TIMER(n)](ON-TIMER(n)).
* [_FULLSCREEN](_FULLSCREEN) (statement) sets the program window to full screen or OFF. Alt + Enter does it manually.
* [_FULLSCREEN (function)](_FULLSCREEN-(function)) returns the fullscreen mode in use by the program.

### _G

* [_G2D](_G2D) (function) converts gradian to degree angle values.
* [_G2R](_G2R) (function) converts gradian to radian angle values.
* [_GLRENDER](_GLRENDER) (statement) sets whether context is displayed, on top of or behind the software rendering.
* [_GREEN](_GREEN) (function) function returns the palette or the green component intensity of a 32-bit image color.
* [_GREEN32](_GREEN32) (function) returns the green component intensity of a 32-bit color value.

### _H

* [_HEIGHT](_HEIGHT) (function) returns the height of a designated image handle.
* [_HIDE](_HIDE) ([SHELL](SHELL) action)  hides the command line display during a shell.
* [_HYPOT](_HYPOT) (function) Returns the hypotenuse of a right-angled triangle whose legs are x and y.

### _I

* [$IF]($IF) (Pre-Compiler [Metacommand](Metacommand)) used to set an IF condition for the precompiler.
* [_ICON](_ICON) (statement) designates a [_LOADIMAGE](_LOADIMAGE) image file handle to be used as the program's icon or loads the embedded icon (see [$EXEICON]($EXEICON)).
* [_INCLERRORFILE$](_INCLERRORFILE$) {function) returns the name of the original source code $INCLUDE module that caused the most recent error.
* [_INCLERRORLINE](_INCLERRORLINE) (function) returns the line number in an included file that caused the most recent error.
* [_INFLATE$](_INFLATE$) (function) decompresses a string
* [_INSTRREV](_INSTRREV) (function) allows searching for a substring inside another string, but unlike [INSTR](INSTR) it returns the last occurrence instead of the first one.
* [_INTEGER64](_INTEGER64) (&& numerical type) can hold whole numerical values from -9223372036854775808 to 9223372036854775807.

### _K

* [_KEYCLEAR](_KEYCLEAR) (statement) clears the keyboard buffers for INKEY$, _KEYHIT, and INP.
* [_KEYHIT](_KEYHIT) (function) returns [ASCII](ASCII) one and two byte, SDL Virtual Key and [Unicode](Unicode) keyboard key press codes.
* [_KEYDOWN](_KEYDOWN) (function) returns whether CTRL, ALT, SHIFT, combinations and other keys are pressed.

### _L

* [$LET]($LET) (Pre-Compiler [Metacommand](Metacommand)) used to set a flag variable for the precompiler.
* [_LASTAXIS](_LASTAXIS) (function) returns the number of axis available on a specified number device listed by [_DEVICE$](_DEVICE$).
* [_LASTBUTTON](_LASTBUTTON) (function) returns the number of buttons available on a specified number device listed by [_DEVICE$](_DEVICE$). 
* [_LASTWHEEL](_LASTWHEEL) (function) returns the number of scroll wheels available on a specified number device listed by [_DEVICE$](_DEVICE$).
* [_LIMIT](_LIMIT) (statement) sets the loops per second rate to slow down loops and limit CPU usage.
* [_LOADFONT](_LOADFONT) (function) designates a [_FONT](_FONT) TTF file to load and returns a handle value.
* [_LOADIMAGE](_LOADIMAGE) (function) designates an image file to load and returns a handle value.

### _M

* [_MAPTRIANGLE](_MAPTRIANGLE) (statement) maps a triangular image source area to put on a destination area.
* [_MAPUNICODE](_MAPUNICODE) (statement) maps a [Unicode](Unicode) value to an [ASCII](ASCII) code number.
* [_MAPUNICODE (function)](_MAPUNICODE-(function)) returns the [Unicode](Unicode) (UTF32) code point value of a mapped [ASCII](ASCII) character code.
* [_MEM (function)](_MEM-(function)) returns [_MEM](_MEM) block referring to the largest continuous memory region beginning at a designated variable's offset.
* [_MEM](_MEM) (variable type) contains read only dot elements for the OFFSET, SIZE, TYPE and ELEMENTSIZE of a block of memory.
* [_MEMCOPY](_MEMCOPY) (statement) copies a value from a designated OFFSET and SIZE [TO](TO) a block of memory at a designated OFFSET.
* [_MEMELEMENT](_MEMELEMENT) (function) returns a [_MEM](_MEM) block referring to a variable's memory (but not past it).
* [_MEMEXISTS](_MEMEXISTS) (function) verifies that a memory block exists for a memory variable name or returns zero.
* [_MEMFILL](_MEMFILL) (statement) fills a designated memory block OFFSET with a certain SIZE and TYPE of value.
* [_MEMFREE](_MEMFREE) (statement) frees a designated memory block in a program. Only free memory blocks once.
* [_MEMGET](_MEMGET) (statement) reads a value from a designated memory block at a designated  OFFSET
* [_MEMGET (function)](_MEMGET-(function)) returns a value from a designated memory block and OFFSET using a designated variable [TYPE](TYPE).
* [_MEMIMAGE](_MEMIMAGE) (function) returns a [_MEM](_MEM) block referring to a designated image handle's memory
* [_MEMNEW](_MEMNEW) (function) allocates new memory with a designated SIZE and returns a [_MEM](_MEM) block referring to it.
* [_MEMPUT](_MEMPUT) (statement) places a designated value into a designated memory block OFFSET
* [_SCREENMOVE](_SCREENMOVE) (_SCREENMOVE parameter) centers the program window on the desktop in any screen resolution.
* [_MK$](_MK$) (function) converts a numerical value to a designated [ASCII](ASCII) [STRING](STRING) value.
* [_MOUSEBUTTON](_MOUSEBUTTON) (function) returns the status of a designated mouse button.
* [_MOUSEHIDE](_MOUSEHIDE) (statement) hides the mouse pointer from view
* [_MOUSEINPUT](_MOUSEINPUT) (function) returns a value if the mouse status has changed since the last read.
* [_MOUSEMOVE](_MOUSEMOVE) (statement) moves the mouse pointer to a designated position on the program [SCREEN](SCREEN).
* [_MOUSEMOVEMENTX](_MOUSEMOVEMENTX) (function) returns the relative horizontal position of the mouse cursor compared to the previous position.
* [_MOUSEMOVEMENTY](_MOUSEMOVEMENTY) (function) returns the relative vertical position of the mouse cursor compared to the previous position.
* [_MOUSEPIPEOPEN](_MOUSEPIPEOPEN) (function) creates a pipe handle value for a mouse when using a virtual keyboard.
* [_MOUSESHOW](_MOUSESHOW) (statement) displays the mouse cursor after it has been hidden or can change the cursor shape.
* [_MOUSEWHEEL](_MOUSEWHEEL) (function) returns the number of mouse scroll wheel "clicks" since last read.
* [_MOUSEX](_MOUSEX) (function) returns the current horizontal position of the mouse cursor.
* [_MOUSEY](_MOUSEY) (function) returns the current vertical position of the mouse cursor.

### _N

* [_NEWIMAGE](_NEWIMAGE) (function) creates a designated size program [SCREEN](SCREEN) or page image and returns a handle value.
* [$NOPREFIX]($NOPREFIX) (metacommand) allows QB64-specific keywords to be used without the underscore prefix.
* [_NUMLOCK (function)](_NUMLOCK-(function)) returns -1 when Num Lock is on
* [_NUMLOCK](_NUMLOCK) (statement) sets Num Lock key state

### _O

* [_OFFSET (function)](_OFFSET-(function)) returns the memory offset of a variable when used with [DECLARE LIBRARY](DECLARE-LIBRARY) or [_MEM](_MEM) only.
* [_OFFSET](_OFFSET) (%& numerical type) can be used store the value of an offset in memory when using [DECLARE LIBRARY](DECLARE-LIBRARY) or [MEM](MEM) only.
* [_OPENCLIENT](_OPENCLIENT) (TCP/IP function) connects to a Host on the Internet as a Client and returns the Client status handle.
* [_OPENCONNECTION](_OPENCONNECTION) (TCP/IP function) open's a connection from a client that the host has detected and returns a status handle.
* [_OPENHOST](_OPENHOST) (TCP/IP function) opens a Host and returns a Host status handle.
* [OPTION _EXPLICIT](OPTION--EXPLICIT) (Pre-compiler directive) instructs the compiler to require variable declaration with [DIM](DIM) or an equivalent statement.
* [OPTION _EXPLICITARRAY](OPTION--EXPLICITARRAY) (Pre-compiler directive) instructs the compiler to require array declaration with [DIM](DIM) or an equivalent statement. 
* [_OS$](_OS$) (function) returns the QB64 compiler version in which the program was compiled as [WINDOWS], [LINUX] or [MACOSX] and [32BIT] or [64BIT].

### _P

* [_PALETTECOLOR](_PALETTECOLOR) (statement) sets the color value of a palette entry of an image using 256 colors or less palette modes.
* [_PALETTECOLOR (function)](_PALETTECOLOR-(function)) return the 32 bit attribute color setting of an image or screen page handle's palette.
* [_PI](_PI) (function) returns the value of **π** or parameter multiples for angle or [CIRCLE](CIRCLE) calculations.
* [_PIXELSIZE](_PIXELSIZE) (function) returns the pixel palette mode of a designated image handle.
* [_PRESERVE](_PRESERVE) ([REDIM](REDIM) action) preserves the data presently in an array when [REDIM](REDIM) is used.
* [_PRINTIMAGE](_PRINTIMAGE) (statement) sends an image to the printer that is stretched to the current printer paper size.
* [_PRINTMODE](_PRINTMODE) (statement) sets the text or _FONT printing mode on a background when using PRINT or [_PRINTSTRING](_PRINTSTRING).
* [_PRINTMODE (function)](_PRINTMODE-(function)) returns the present [_PRINTMODE](_PRINTMODE) value number.
* [_PRINTSTRING](_PRINTSTRING) (statement) locates and prints a text [STRING](STRING) using graphic coordinates.
* [_PRINTWIDTH](_PRINTWIDTH) (function) returns the pixel width of a text string to be printed using [_PRINTSTRING](_PRINTSTRING).
* [_PUTIMAGE](_PUTIMAGE) (statement) maps a rectangular image source area to an image destination area.

### _R

* [_R2D](_R2D) (function) converts radians to degree angle values.
* [_R2G](_R2G) (function) converts radians to gradian angle values.
* [_RED](_RED) (function) function returns the palette or the red component intensity of a 32-bit image color.
* [_RED32](_RED32) (function) returns the red component intensity of a 32-bit color value.
* [_READBIT](_READBIT) (function) returns the state of the specified bit of an integer variable.
* [_RESETBIT](_RESETBIT) (function) is used to set the specified bit of an integer variable to 0.
* [$RESIZE]($RESIZE) ([Metacommand](Metacommand)) used with ON allows a user to resize the program window where OFF does not.
* [_RESIZE](_RESIZE) (statement) sets resizing of the window ON or OFF and sets the method as _STRETCH or _SMOOTH.
* [_RESIZE (function)](_RESIZE-(function)) returns -1 when a program user wants to resize the program screen.
* [_RESIZEHEIGHT](_RESIZEHEIGHT) (function) returns the requested new user screen height when [$RESIZE]($RESIZE):ON allows it.
* [_RESIZEWIDTH](_RESIZEWIDTH) (function) returns the requested new user screen width when [$RESIZE]($RESIZE):ON allows it.
* [_RGB](_RGB) (function) returns the closest palette index OR the [LONG](LONG) 32 bit color value in 32 bit screens.
* [_RGB32](_RGB32) (function) returns the [LONG](LONG) 32 bit color value in 32 bit screens only
* [_RGBA](_RGBA) (function) returns the closest palette index OR the [LONG](LONG) 32 bit color value in 32 bit screens with the [ALPHA](ALPHA)
* [_RGBA32](_RGBA32) (function) returns the [LONG](LONG) 32 bit color value in 32 bit screens only with the [ALPHA](ALPHA)
* [_ROUND](_ROUND) (function) rounds to the closest [INTEGER](INTEGER), [LONG](LONG) or [_INTEGER64](_INTEGER64) numerical value.

### _S

* [_SCREENCLICK](_SCREENCLICK) (statement) simulates clicking on a point on the desktop screen with the left mouse button.
* [_SCREENEXISTS](_SCREENEXISTS) (function) returns a -1 value once a screen has been created.
* [$SCREENHIDE]($SCREENHIDE) QB64 [Metacommand](Metacommand) hides the program window from view.
* [_SCREENHIDE](_SCREENHIDE) (statement) hides the program window from view.
* [_SCREENICON (function)](_SCREENICON-(function)) returns -1 or 0 to indicate if the window has been minimized to an icon on the taskbar. 
* [_SCREENICON](_SCREENICON) (statement) minimizes the program window to an icon on the taskbar. 
* [_SCREENIMAGE](_SCREENIMAGE) (function) creates an image of the current desktop and returns an image handle.
* [_SCREENMOVE](_SCREENMOVE) (statement) positions program window on the desktop using designated coordinates or the _MIDDLE option.
* [_SCREENPRINT](_SCREENPRINT) (statement) simulates typing text into a Windows program using the keyboard.
* [$SCREENSHOW]($SCREENSHOW) (QB64 [Metacommand](Metacommand)) displays that program window after it was hidden by [$SCREENHIDE]($SCREENHIDE).
* [_SCREENSHOW](_SCREENSHOW) (statement) displays the program window after it has been hidden by [_SCREENHIDE](_SCREENHIDE).
* [_SCREENX](_SCREENX) (function) returns the program window's upper left corner horizontal position on the desktop.
* [_SCREENY](_SCREENY) (function) returns the program window's upper left corner vertical position on the desktop.
* [_SCROLLLOCK (function)](_SCROLLLOCK-(function)) returns -1 when Scroll Lock is on
* [_SCROLLLOCK](_SCROLLLOCK) (statement) sets Scroll Lock key state
* [_SETALPHA](_SETALPHA) (statement) sets the alpha channel transparency level of some or all of the pixels of an image.
* [_SETBIT](_SETBIT) (function) is used to set the specified bit of an integer variable to 1.
* [_SHELLHIDE](_SHELLHIDE) (function) returns the code sent by a program exit using [END](END) or [SYSTEM](SYSTEM) followed by an [INTEGER](INTEGER) value.
* [_SHL](_SHL) (function) used to shift the bits of a numerical value to the left
* [_SHR](_SHR) (function) used to shift the bits of a numerical value to the right.
* [Mathematical Operations](Mathematical-Operations) (function) Returns the hyperbolic sine of x radians.
* [_SNDBAL](_SNDBAL) (statement) attempts to set the balance or 3D position of a sound file.
* [_SNDCLOSE](_SNDCLOSE) (statement) frees and unloads an open sound using the sound handle created by [_SNDOPEN](_SNDOPEN).
* [_SNDCOPY](_SNDCOPY) (function) copies a sound handle value to a new designated handle.
* [_SNDGETPOS](_SNDGETPOS) (function) returns the current playing position in seconds from a sound file.
* [_SNDLEN](_SNDLEN) (function) returns the length of a sound in seconds from a sound file.
* [_SNDLIMIT](_SNDLIMIT) (statement) stops playing a sound after it has been playing for a set number of seconds.
* [_SNDLOOP](_SNDLOOP) (statement) plays a sound repeatedly until [_SNDSTOP](_SNDSTOP) is used.
* [_SNDOPEN](_SNDOPEN) (function) loads a sound file and returns a sound handle.
* [_SNDOPENRAW](_SNDOPENRAW) (function) opens a new channel to shove [_SNDRAW](_SNDRAW) content into without mixing.
* [_SNDPAUSE](_SNDPAUSE) (statement) stops playing a sound file until resumed.
* [_SNDPAUSED](_SNDPAUSED) (function) returns the current pause status of a sound file handle.
* [_SNDPLAY](_SNDPLAY) (statement) plays a sound file handle that was created by [_SNDOPEN](_SNDOPEN) or [_SNDCOPY](_SNDCOPY).
* [_SNDPLAYCOPY](_SNDPLAYCOPY) (statement) copies a sound handle, plays it and automatically closes the copy when done.
* [_SNDPLAYFILE](_SNDPLAYFILE) (statement) directly plays a designated sound file.
* [_SNDPLAYING](_SNDPLAYING) (function) returns the current playing status of a sound handle.
* [_SNDRATE](_SNDRATE) (function) returns the sound card sample rate to set [_SNDRAW](_SNDRAW) durations.
* [_SNDRAW](_SNDRAW) (statement) creates mono or stereo sounds from calculated wave frequency values.
* [_SNDRAWDONE](_SNDRAWDONE) (statement) pads a [_SNDRAW](_SNDRAW) stream so the final (partially filled) buffer section is played.
* [_SNDRAWLEN](_SNDRAWLEN) (function) returns a value until the [_SNDRAW](_SNDRAW) buffer is empty.
* [_SNDSETPOS](_SNDSETPOS) (statement) sets the playing position of a sound handle.
* [_SNDSTOP](_SNDSTOP) (statement) stops playing a sound handle.
* [_SNDVOL](_SNDVOL) (statement) sets the volume of a sound file handle.
* [_SOURCE](_SOURCE) (statement) sets the source image handle.
* [_SOURCE (function)](_SOURCE-(function)) returns the present source image handle value.
* [_STARTDIR$](_STARTDIR$) (function) returns the user's program calling path as a [STRING](STRING).
* [_STRCMP](_STRCMP) (function) compares the relationship between two strings.
* [_STRICMP](_STRICMP) (function) compares the relationship between two strings, without regard for case-sensitivity.

### _T

* [Mathematical Operations](Mathematical-Operations) (function) Returns the hyperbolic tangent of x radians.
* [_TITLE](_TITLE) (statement) sets the program title [STRING](STRING) value.
* [_TITLE$](_TITLE$) (function) gets the program title [STRING](STRING) value.
* [_TOGGLEBIT](_TOGGLEBIT) (function) is used to toggle the specified bit of an integer variable from 1 to 0 or 0 to 1.
* [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES) (function)  returns the number of items (files or folders) dropped in a program's window after [_ACCEPTFILEDROP](_ACCEPTFILEDROP) is enabled.
* [_TRIM$](_TRIM$) (function) shorthand to [LTRIM$](LTRIM$)([RTRIM$](RTRIM$)("text"))

### _U

* [_UNSIGNED](_UNSIGNED) (numerical type) expands the positive range of numerical [INTEGER](INTEGER), [LONG](LONG) or [_INTEGER64](_INTEGER64) values returned.

### _V

* [$VERSIONINFO]($VERSIONINFO) ([Metacommand](Metacommand)) adds metadata to Windows only binaries for identification purposes across the OS.
* [$VIRTUALKEYBOARD]($VIRTUALKEYBOARD) ([Metacommand](Metacommand) - Deprecated) turns the virtual keyboard ON or OFF for use in touch-enabled devices

### _W

* [_WHEEL](_WHEEL) (function) returns -1 when a control device wheel is scrolled up and 1 when scrolled down. Zero indicates no activity.
* [_WIDTH (function)](_WIDTH-(function)) returns the width of a [SCREEN](SCREEN) or image handle.
* [_WINDOWHANDLE](_WINDOWHANDLE) (function) returns the window handle assigned to the current program by the OS. Windows-only.
* [_WINDOWHASFOCUS](_WINDOWHASFOCUS) (function) returns true (-1) if the current program's window has focus. Windows-only.

## OpenGL specific keywords

*All QB64 OpenGL keywords must use the underscore _gl prefix with the alphabetically listed function names.*

Use [$NOPREFIX]($NOPREFIX) to enable these to be used without the leading underscore.

> Important: See [SUB _GL](SUB-_GL)

### _glA

* [_glAccum](_glAccum) (statement) OpenGL command
* [_glAlphaFunc](_glAlphaFunc) (statement) OpenGL command
* [_glAreTexturesResident](_glAreTexturesResident) (statement) OpenGL command
* [_glArrayElement](_glArrayElement) (statement) OpenGL command

### _glB

* [_glBegin](_glBegin) (statement) OpenGL command
* [_glBindTexture](_glBindTexture) (statement) OpenGL command binds a named texture to a texturing target
* [_glBitmap](_glBitmap) (statement) OpenGL command
* [_glBlendFunc](_glBlendFunc) (statement) OpenGL command

### _glC

* [_glCallList](_glCallList) (statement) OpenGL command
* [_glCallLists](_glCallLists) (statement) OpenGL command
* [_glClear](_glClear) (statement) OpenGL command clears buffers to preset values
* [_glClearAccum](_glClearAccum) (statement) OpenGL command
* [_glClearColor](_glClearColor) (statement) OpenGL command specifies clear values for the color buffers
* [_glClearDepth](_glClearDepth) (statement) OpenGL command specifies the depth value used when the depth buffer is cleared. Initial value is 1.
* [_glClearIndex](_glClearIndex) (statement) OpenGL command
* [_glClearStencil](_glClearStencil) (statement) OpenGL command specifies the index used when the stencil buffer is cleared. Initial value is 0.
* [_glClipPlane](_glClipPlane) (statement) OpenGL command
* [_glColor3b](_glColor3b) (statement) OpenGL command
* [_glColor3bv](_glColor3bv) (statement) OpenGL command
* [_glColor3d](_glColor3d) (statement) OpenGL command
* [_glColor3dv](_glColor3dv) (statement) OpenGL command
* [_glColor3f](_glColor3f) (statement) OpenGL command
* [_glColor3fv](_glColor3fv) (statement) OpenGL command
* [_glColor3i](_glColor3i) (statement) OpenGL command
* [_glColor3iv](_glColor3iv) (statement) OpenGL command
* [_glColor3s](_glColor3s) (statement) OpenGL command
* [_glColor3sv](_glColor3sv) (statement) OpenGL command
* [_glColor3ub](_glColor3ub) (statement) OpenGL command
* [_glColor3ubv](_glColor3ubv) (statement) OpenGL command
* [_glColor3ui](_glColor3ui) (statement) OpenGL command
* [_glColor3uiv](_glColor3uiv) (statement) OpenGL command
* [_glColor3us](_glColor3us) (statement) OpenGL command
* [_glColor3usv](_glColor3usv) (statement) OpenGL command
* [_glColor4b](_glColor4b) (statement) OpenGL command
* [_glColor4bv](_glColor4bv) (statement) OpenGL command
* [_glColor4d](_glColor4d) (statement) OpenGL command
* [_glColor4dv](_glColor4dv) (statement) OpenGL command
* [_glColor4f](_glColor4f) (statement) OpenGL command
* [_glColor4fv](_glColor4fv) (statement) OpenGL command
* [_glColor4i](_glColor4i) (statement) OpenGL command
* [_glColor4iv](_glColor4iv) (statement) OpenGL command
* [_glColor4s](_glColor4s) (statement) OpenGL command
* [_glColor4sv](_glColor4sv) (statement) OpenGL command
* [_glColor4ub](_glColor4ub) (statement) OpenGL command
* [_glColor4ubv](_glColor4ubv) (statement) OpenGL command
* [_glColor4ui](_glColor4ui) (statement) OpenGL command
* [_glColor4uiv](_glColor4uiv) (statement) OpenGL command
* [_glColor4us](_glColor4us) (statement) OpenGL command
* [_glColor4usv](_glColor4usv) (statement) OpenGL command
* [_glColorMask](_glColorMask) (statement) OpenGL command enables and disables writing of frame buffer color components
* [_glColorMaterial](_glColorMaterial) (statement) OpenGL command
* [_glColorPointer](_glColorPointer) (statement) OpenGL command
* [_glCopyPixels](_glCopyPixels) (statement) OpenGL command
* [_glCopyTexImage1D](_glCopyTexImage1D) (statement) OpenGL command copies pixels into a 1D texture image
* [_glCopyTexImage2D](_glCopyTexImage2D) (statement) OpenGL command copies pixels into a 2D texture image
* [_glCopyTexSubImage1D](_glCopyTexSubImage1D) (statement) OpenGL command copies a one-dimensional texture subimage
* [_glCopyTexSubImage2D](_glCopyTexSubImage2D) (statement) OpenGL command copiess a two-dimensional texture subimage
* [_glCullFace](_glCullFace) (statement) OpenGL command

### _glD

* [_glDeleteLists](_glDeleteLists) (statement) OpenGL command
* [_glDeleteTextures](_glDeleteTextures) (statement) OpenGL command deletes named textures
* [_glDepthFunc](_glDepthFunc) (statement) OpenGL command specifies the value used for depth buffer comparisons
* [_glDepthMask](_glDepthMask) (statement) OpenGL command enables or disables writing into the depth buffer
* [_glDepthRange](_glDepthRange) (statement) OpenGL command specifies mapping of near clipping plane to window coordinates. Initial value 0.
* [_glDisable](_glDisable) (statement) OpenGL command
* [_glDisableClientState](_glDisableClientState) (statement) OpenGL command
* [_glDrawArrays](_glDrawArrays) (statement) OpenGL command
* [_glDrawBuffer](_glDrawBuffer) (statement) OpenGL command
* [_glDrawElements](_glDrawElements) (statement) OpenGL command
* [_glDrawPixels](_glDrawPixels) (statement) OpenGL command

### _glE

* [_glEdgeFlag](_glEdgeFlag) (statement) OpenGL command
* [_glEdgeFlagPointer](_glEdgeFlagPointer) (statement) OpenGL command
* [_glEdgeFlagv](_glEdgeFlagv) (statement) OpenGL command
* [_glEnable](_glEnable) (statement) OpenGL command
* [_glEnableClientState](_glEnableClientState) (statement) OpenGL command
* [_glEnd](_glEnd) (statement) OpenGL command
* [_glEndList](_glEndList) (statement) OpenGL command
* [_glEvalCoord1d](_glEvalCoord1d) (statement) OpenGL command
* [_glEvalCoord1dv](_glEvalCoord1dv) (statement) OpenGL command
* [_glEvalCoord1f](_glEvalCoord1f) (statement) OpenGL command
* [_glEvalCoord1fv](_glEvalCoord1fv) (statement) OpenGL command
* [_glEvalCoord2d](_glEvalCoord2d) (statement) OpenGL command
* [_glEvalCoord2dv](_glEvalCoord2dv) (statement) OpenGL command
* [_glEvalCoord2f](_glEvalCoord2f) (statement) OpenGL command
* [_glEvalCoord2fv](_glEvalCoord2fv) (statement) OpenGL command
* [_glEvalMesh1](_glEvalMesh1) (statement) OpenGL command
* [_glEvalMesh2](_glEvalMesh2) (statement) OpenGL command
* [_glEvalPoint1](_glEvalPoint1) (statement) OpenGL command
* [_glEvalPoint2](_glEvalPoint2) (statement) OpenGL command

### _glF

* [_glFeedbackBuffer](_glFeedbackBuffer) (statement) OpenGL command
* [_glFinish](_glFinish) (statement) OpenGL command
* [_glFlush](_glFlush) (statement) OpenGL command
* [_glFogf](_glFogf) (statement) OpenGL command
* [_glFogfv](_glFogfv) (statement) OpenGL command
* [_glFogi](_glFogi) (statement) OpenGL command
* [_glFogiv](_glFogiv) (statement) OpenGL command
* [_glFrontFace](_glFrontFace) (statement) OpenGL command
* [_glFrustum](_glFrustum) (statement) OpenGL command

### _glG

* [_glGenLists](_glGenLists) (statement) OpenGL command
* [_glGenTextures](_glGenTextures) (statement) OpenGL command
* [_glGetBooleanv](_glGetBooleanv) (statement) OpenGL command
* [_glGetClipPlane](_glGetClipPlane) (statement) OpenGL command
* [_glGetDoublev](_glGetDoublev) (statement) OpenGL command
* [_glGetError](_glGetError) (statement) OpenGL command
* [_glGetFloatv](_glGetFloatv) (statement) OpenGL command
* [_glGetIntegerv](_glGetIntegerv) (statement) OpenGL command
* [_glGetLightfv](_glGetLightfv) (statement) OpenGL command
* [_glGetLightiv](_glGetLightiv) (statement) OpenGL command
* [_glGetMapdv](_glGetMapdv) (statement) OpenGL command
* [_glGetMapfv](_glGetMapfv) (statement) OpenGL command
* [_glGetMapiv](_glGetMapiv) (statement) OpenGL command
* [_glGetMaterialfv](_glGetMaterialfv) (statement) OpenGL command
* [_glGetMaterialiv](_glGetMaterialiv) (statement) OpenGL command
* [_glGetPixelMapfv](_glGetPixelMapfv) (statement) OpenGL command
* [_glGetPixelMapuiv](_glGetPixelMapuiv) (statement) OpenGL command
* [_glGetPixelMapusv](_glGetPixelMapusv) (statement) OpenGL command
* [_glGetPointerv](_glGetPointerv) (statement) OpenGL command
* [_glGetPolygonStipple](_glGetPolygonStipple) (statement) OpenGL command
* [_glGetString](_glGetString) (statement) OpenGL command
* [_glGetTexEnvfv](_glGetTexEnvfv) (statement) OpenGL command
* [_glGetTexEnviv](_glGetTexEnviv) (statement) OpenGL command
* [_glGetTexGendv](_glGetTexGendv) (statement) OpenGL command
* [_glGetTexGenfv](_glGetTexGenfv) (statement) OpenGL command
* [_glGetTexGeniv](_glGetTexGeniv) (statement) OpenGL command
* [_glGetTexImage](_glGetTexImage) (statement) OpenGL command
* [_glGetTexLevelParameterfv](_glGetTexLevelParameterfv) (statement) OpenGL command
* [_glGetTexLevelParameteriv](_glGetTexLevelParameteriv) (statement) OpenGL command
* [_glGetTexParameterfv](_glGetTexParameterfv) (statement) OpenGL command
* [_glGetTexParameteriv](_glGetTexParameteriv) (statement) OpenGL command

### _glH

* [_glHint](_glHint) (statement) OpenGL command

### _glI

* [_glIndexMask](_glIndexMask) (statement) OpenGL command
* [_glIndexPointer](_glIndexPointer) (statement) OpenGL command
* [_glIndexd](_glIndexd) (statement) OpenGL command
* [_glIndexdv](_glIndexdv) (statement) OpenGL command
* [_glIndexf](_glIndexf) (statement) OpenGL command
* [_glIndexfv](_glIndexfv) (statement) OpenGL command
* [_glIndexi](_glIndexi) (statement) OpenGL command
* [_glIndexiv](_glIndexiv) (statement) OpenGL command
* [_glIndexs](_glIndexs) (statement) OpenGL command
* [_glIndexsv](_glIndexsv) (statement) OpenGL command
* [_glIndexub](_glIndexub) (statement) OpenGL command
* [_glIndexubv](_glIndexubv) (statement) OpenGL command
* [_glInitNames](_glInitNames) (statement) OpenGL command
* [_glInterleavedArrays](_glInterleavedArrays) (statement) OpenGL command
* [_glIsEnabled](_glIsEnabled) (statement) OpenGL command
* [_glIsList](_glIsList) (statement) OpenGL command
* [_glIsTexture](_glIsTexture) (statement) OpenGL command

### _glL

* [_glLightModelf](_glLightModelf) (statement) OpenGL command
* [_glLightModelfv](_glLightModelfv) (statement) OpenGL command
* [_glLightModeli](_glLightModeli) (statement) OpenGL command
* [_glLightModeliv](_glLightModeliv) (statement) OpenGL command
* [_glLightf](_glLightf) (statement) OpenGL command
* [_glLightfv](_glLightfv) (statement) OpenGL command
* [_glLighti](_glLighti) (statement) OpenGL command
* [_glLightiv](_glLightiv) (statement) OpenGL command
* [_glLineStipple](_glLineStipple) (statement) OpenGL command
* [_glLineWidth](_glLineWidth) (statement) OpenGL command
* [_glListBase](_glListBase) (statement) OpenGL command
* [_glLoadIdentity](_glLoadIdentity) (statement) OpenGL command
* [_glLoadMatrixd](_glLoadMatrixd) (statement) OpenGL command
* [_glLoadMatrixf](_glLoadMatrixf) (statement) OpenGL command
* [_glLoadName](_glLoadName) (statement) OpenGL command
* [_glLogicOp](_glLogicOp) (statement) OpenGL command

### _glM

* [_glMap1d](_glMap1d) (statement) OpenGL command
* [_glMap1f](_glMap1f) (statement) OpenGL command
* [_glMap2d](_glMap2d) (statement) OpenGL command
* [_glMap2f](_glMap2f) (statement) OpenGL command
* [_glMapGrid1d](_glMapGrid1d) (statement) OpenGL command
* [_glMapGrid1f](_glMapGrid1f) (statement) OpenGL command
* [_glMapGrid2d](_glMapGrid2d) (statement) OpenGL command
* [_glMapGrid2f](_glMapGrid2f) (statement) OpenGL command
* [_glMaterialf](_glMaterialf) (statement) OpenGL command
* [_glMaterialfv](_glMaterialfv) (statement) OpenGL command
* [_glMateriali](_glMateriali) (statement) OpenGL command
* [_glMaterialiv](_glMaterialiv) (statement) OpenGL command
* [_glMatrixMode](_glMatrixMode) (statement) OpenGL command
* [_glMultMatrixd](_glMultMatrixd) (statement) OpenGL command
* [_glMultMatrixf](_glMultMatrixf) (statement) OpenGL command

### _glN

* [_glNewList](_glNewList) (statement) OpenGL command
* [_glNormal3b](_glNormal3b) (statement) OpenGL command
* [_glNormal3bv](_glNormal3bv) (statement) OpenGL command
* [_glNormal3d](_glNormal3d) (statement) OpenGL command
* [_glNormal3dv](_glNormal3dv) (statement) OpenGL command
* [_glNormal3f](_glNormal3f) (statement) OpenGL command
* [_glNormal3fv](_glNormal3fv) (statement) OpenGL command
* [_glNormal3i](_glNormal3i) (statement) OpenGL command
* [_glNormal3iv](_glNormal3iv) (statement) OpenGL command
* [_glNormal3s](_glNormal3s) (statement) OpenGL command
* [_glNormal3sv](_glNormal3sv) (statement) OpenGL command
* [_glNormalPointer](_glNormalPointer) (statement) OpenGL command

### _glO

* [_glOrtho](_glOrtho) (statement) OpenGL command

### _glP

* [_glPassThrough](_glPassThrough) (statement) OpenGL command
* [_glPixelMapfv](_glPixelMapfv) (statement) OpenGL command
* [_glPixelMapuiv](_glPixelMapuiv) (statement) OpenGL command
* [_glPixelMapusv](_glPixelMapusv) (statement) OpenGL command
* [_glPixelStoref](_glPixelStoref) (statement) OpenGL command
* [_glPixelStorei](_glPixelStorei) (statement) OpenGL command
* [_glPixelTransferf](_glPixelTransferf) (statement) OpenGL command
* [_glPixelTransferi](_glPixelTransferi) (statement) OpenGL command
* [_glPixelZoom](_glPixelZoom) (statement) OpenGL command
* [_glPointSize](_glPointSize) (statement) OpenGL command
* [_glPolygonMode](_glPolygonMode) (statement) OpenGL command
* [_glPolygonOffset](_glPolygonOffset) (statement) OpenGL command
* [_glPolygonStipple](_glPolygonStipple) (statement) OpenGL command
* [_glPopAttrib](_glPopAttrib) (statement) OpenGL command
* [_glPopClientAttrib](_glPopClientAttrib) (statement) OpenGL command
* [_glPopMatrix](_glPopMatrix) (statement) OpenGL command
* [_glPopName](_glPopName) (statement) OpenGL command
* [_glPrioritizeTextures](_glPrioritizeTextures) (statement) OpenGL command
* [_glPushAttrib](_glPushAttrib) (statement) OpenGL command
* [_glPushClientAttrib](_glPushClientAttrib) (statement) OpenGL command
* [_glPushMatrix](_glPushMatrix) (statement) OpenGL command
* [_glPushName](_glPushName) (statement) OpenGL command

### _glR

* [_glRasterPos2d](_glRasterPos2d) (statement) OpenGL command
* [_glRasterPos2dv](_glRasterPos2dv) (statement) OpenGL command
* [_glRasterPos2f](_glRasterPos2f) (statement) OpenGL command
* [_glRasterPos2fv](_glRasterPos2fv) (statement) OpenGL command
* [_glRasterPos2i](_glRasterPos2i) (statement) OpenGL command
* [_glRasterPos2iv](_glRasterPos2iv) (statement) OpenGL command
* [_glRasterPos2s](_glRasterPos2s) (statement) OpenGL command
* [_glRasterPos2sv](_glRasterPos2sv) (statement) OpenGL command
* [_glRasterPos3d](_glRasterPos3d) (statement) OpenGL command
* [_glRasterPos3dv](_glRasterPos3dv) (statement) OpenGL command
* [_glRasterPos3f](_glRasterPos3f) (statement) OpenGL command
* [_glRasterPos3fv](_glRasterPos3fv) (statement) OpenGL command
* [_glRasterPos3i](_glRasterPos3i) (statement) OpenGL command
* [_glRasterPos3iv](_glRasterPos3iv) (statement) OpenGL command
* [_glRasterPos3s](_glRasterPos3s) (statement) OpenGL command
* [_glRasterPos3sv](_glRasterPos3sv) (statement) OpenGL command
* [_glRasterPos4d](_glRasterPos4d) (statement) OpenGL command
* [_glRasterPos4dv](_glRasterPos4dv) (statement) OpenGL command
* [_glRasterPos4f](_glRasterPos4f) (statement) OpenGL command
* [_glRasterPos4fv](_glRasterPos4fv) (statement) OpenGL command
* [_glRasterPos4i](_glRasterPos4i) (statement) OpenGL command
* [_glRasterPos4iv](_glRasterPos4iv) (statement) OpenGL command
* [_glRasterPos4s](_glRasterPos4s) (statement) OpenGL command
* [_glRasterPos4sv](_glRasterPos4sv) (statement) OpenGL command
* [_glReadBuffer](_glReadBuffer) (statement) OpenGL command
* [_glReadPixels](_glReadPixels) (statement) OpenGL command
* [_glRectd](_glRectd) (statement) OpenGL command
* [_glRectdv](_glRectdv) (statement) OpenGL command
* [_glRectf](_glRectf) (statement) OpenGL command
* [_glRectfv](_glRectfv) (statement) OpenGL command
* [_glRecti](_glRecti) (statement) OpenGL command
* [_glRectiv](_glRectiv) (statement) OpenGL command
* [_glRects](_glRects) (statement) OpenGL command
* [_glRectsv](_glRectsv) (statement) OpenGL command
* [_glRenderMode](_glRenderMode) (statement) OpenGL command
* [_glRotated](_glRotated) (statement) OpenGL command
* [_glRotatef](_glRotatef) (statement) OpenGL command

### _glS

* [_glScaled](_glScaled) (statement) OpenGL command
* [_glScalef](_glScalef) (statement) OpenGL command
* [_glScissor](_glScissor) (statement) OpenGL command
* [_glSelectBuffer](_glSelectBuffer) (statement) OpenGL command
* [_glShadeModel](_glShadeModel) (statement) OpenGL command
* [_glStencilFunc](_glStencilFunc) (statement) OpenGL command
* [_glStencilMask](_glStencilMask) (statement) OpenGL command
* [_glStencilOp](_glStencilOp) (statement) OpenGL command

### _glT

* [_glTexCoord1d](_glTexCoord1d) (statement) OpenGL command
* [_glTexCoord1dv](_glTexCoord1dv) (statement) OpenGL command
* [_glTexCoord1f](_glTexCoord1f) (statement) OpenGL command
* [_glTexCoord1fv](_glTexCoord1fv) (statement) OpenGL command
* [_glTexCoord1i](_glTexCoord1i) (statement) OpenGL command
* [_glTexCoord1iv](_glTexCoord1iv) (statement) OpenGL command
* [_glTexCoord1s](_glTexCoord1s) (statement) OpenGL command
* [_glTexCoord1sv](_glTexCoord1sv) (statement) OpenGL command
* [_glTexCoord2d](_glTexCoord2d) (statement) OpenGL command
* [_glTexCoord2dv](_glTexCoord2dv) (statement) OpenGL command
* [_glTexCoord2f](_glTexCoord2f) (statement) OpenGL command
* [_glTexCoord2fv](_glTexCoord2fv) (statement) OpenGL command
* [_glTexCoord2i](_glTexCoord2i) (statement) OpenGL command
* [_glTexCoord2iv](_glTexCoord2iv) (statement) OpenGL command
* [_glTexCoord2s](_glTexCoord2s) (statement) OpenGL command
* [_glTexCoord2sv](_glTexCoord2sv) (statement) OpenGL command
* [_glTexCoord3d](_glTexCoord3d) (statement) OpenGL command
* [_glTexCoord3dv](_glTexCoord3dv) (statement) OpenGL command
* [_glTexCoord3f](_glTexCoord3f) (statement) OpenGL command
* [_glTexCoord3fv](_glTexCoord3fv) (statement) OpenGL command
* [_glTexCoord3i](_glTexCoord3i) (statement) OpenGL command
* [_glTexCoord3iv](_glTexCoord3iv) (statement) OpenGL command
* [_glTexCoord3s](_glTexCoord3s) (statement) OpenGL command
* [_glTexCoord3sv](_glTexCoord3sv) (statement) OpenGL command
* [_glTexCoord4d](_glTexCoord4d) (statement) OpenGL command
* [_glTexCoord4dv](_glTexCoord4dv) (statement) OpenGL command
* [_glTexCoord4f](_glTexCoord4f) (statement) OpenGL command
* [_glTexCoord4fv](_glTexCoord4fv) (statement) OpenGL command
* [_glTexCoord4i](_glTexCoord4i) (statement) OpenGL command
* [_glTexCoord4iv](_glTexCoord4iv) (statement) OpenGL command
* [_glTexCoord4s](_glTexCoord4s) (statement) OpenGL command
* [_glTexCoord4sv](_glTexCoord4sv) (statement) OpenGL command
* [_glTexCoordPointer](_glTexCoordPointer) (statement) OpenGL command
* [_glTexEnvf](_glTexEnvf) (statement) OpenGL command
* [_glTexEnvfv](_glTexEnvfv) (statement) OpenGL command
* [_glTexEnvi](_glTexEnvi) (statement) OpenGL command
* [_glTexEnviv](_glTexEnviv) (statement) OpenGL command
* [_glTexGend](_glTexGend) (statement) OpenGL command
* [_glTexGendv](_glTexGendv) (statement) OpenGL command
* [_glTexGenf](_glTexGenf) (statement) OpenGL command
* [_glTexGenfv](_glTexGenfv) (statement) OpenGL command
* [_glTexGeni](_glTexGeni) (statement) OpenGL command
* [_glTexGeniv](_glTexGeniv) (statement) OpenGL command
* [_glTexImage1D](_glTexImage1D) (statement) OpenGL command
* [_glTexImage2D](_glTexImage2D) (statement) OpenGL command
* [_glTexParameterf](_glTexParameterf) (statement) OpenGL command
* [_glTexParameterfv](_glTexParameterfv) (statement) OpenGL command
* [_glTexParameteri](_glTexParameteri) (statement) OpenGL command
* [_glTexParameteriv](_glTexParameteriv) (statement) OpenGL command
* [_glTexSubImage1D](_glTexSubImage1D) (statement) OpenGL command
* [_glTexSubImage2D](_glTexSubImage2D) (statement) OpenGL command
* [_glTranslated](_glTranslated) (statement) OpenGL command
* [_glTranslatef](_glTranslatef) (statement) OpenGL command

### _glV

* [_glVertex2d](_glVertex2d) (statement) OpenGL command
* [_glVertex2dv](_glVertex2dv) (statement) OpenGL command
* [_glVertex2f](_glVertex2f) (statement) OpenGL command
* [_glVertex2fv](_glVertex2fv) (statement) OpenGL command
* [_glVertex2i](_glVertex2i) (statement) OpenGL command
* [_glVertex2iv](_glVertex2iv) (statement) OpenGL command
* [_glVertex2s](_glVertex2s) (statement) OpenGL command
* [_glVertex2sv](_glVertex2sv) (statement) OpenGL command
* [_glVertex3d](_glVertex3d) (statement) OpenGL command
* [_glVertex3dv](_glVertex3dv) (statement) OpenGL command
* [_glVertex3f](_glVertex3f) (statement) OpenGL command
* [_glVertex3fv](_glVertex3fv) (statement) OpenGL command
* [_glVertex3i](_glVertex3i) (statement) OpenGL command
* [_glVertex3iv](_glVertex3iv) (statement) OpenGL command
* [_glVertex3s](_glVertex3s) (statement) OpenGL command
* [_glVertex3sv](_glVertex3sv) (statement) OpenGL command
* [_glVertex4d](_glVertex4d) (statement) OpenGL command
* [_glVertex4dv](_glVertex4dv) (statement) OpenGL command
* [_glVertex4f](_glVertex4f) (statement) OpenGL command
* [_glVertex4fv](_glVertex4fv) (statement) OpenGL command
* [_glVertex4i](_glVertex4i) (statement) OpenGL command
* [_glVertex4iv](_glVertex4iv) (statement) OpenGL command
* [_glVertex4s](_glVertex4s) (statement) OpenGL command
* [_glVertex4sv](_glVertex4sv) (statement) OpenGL command
* [_glVertexPointer](_glVertexPointer) (statement) OpenGL command
* [_glViewport](_glViewport) (statement) OpenGL command

## Symbols

### QB64 and QB Symbols

*Note: All symbols below can also be used inside of literal quoted strings except for quotation marks.*

> **Print, Input or File Formatting**

* [Semicolon](Semicolon) after a [PRINT](PRINT) stops invisible cursor at end of printed value. Can prevent screen rolling. A [Semicolon](Semicolon) after the [INPUT](INPUT) prompt text will display a question mark after the text. 
* [Comma](Comma) after a [PRINT](PRINT) tabs invisible cursor past end of printed value. After the [INPUT](INPUT) prompt text a [comma](comma) displays no [Question mark](Question-mark).
* [Quotation mark](Quotation-mark) delimits the ends of a literal [STRING](STRING) value in a [PRINT](PRINT), [INPUT](INPUT) or [LINE INPUT](LINE-INPUT) statement.
* [Question mark](Question-mark) is a shortcut substitute for the [PRINT](PRINT) keyword. Will change to PRINT when cursor leaves the code line.

### Program Code Markers

* [Apostrophe](Apostrophe) ignores a line of code or program comment and MUST be used before a [Metacommand](Metacommand). Same as using [REM](REM).
* [Comma](Comma) is used to separate [DATA](DATA), [SUB](SUB) or [FUNCTION](FUNCTION) parameter variables. 
* [Colon](Colon)s can be used to separate two procedure statements on one code line.
* [Dollar_Sign](Dollar-Sign) prefix denotes a QBasic [Metacommand](Metacommand).
* [Parenthesis](Parenthesis) enclose a math or conditional procedure order, [SUB](SUB) or [FUNCTION](FUNCTION) parameters or to pass by value.
* [+](+) [concatenation](Concatenation) operator MUST be used to combine literal string values in a variable definition.
* [Quotation mark](Quotation-mark) designates the ends of a literal [STRING](STRING) value. Use [CHR$](CHR$)(34) to insert quotes in a text [STRING](STRING).
* [Underscore](Underscore) can be used to continue a line of code to the next program line in **QB64**.

### Variable Name Type Suffixes

* [STRING](STRING) text character type: 1 byte
* [SINGLE](SINGLE) floating decimal point numerical type (4 bytes)
* [DOUBLE](DOUBLE) floating decimal point numerical type (8 bytes)
* [_FLOAT](_FLOAT) **QB64** decimal point numerical type (32 bytes)
* [_UNSIGNED](_UNSIGNED) **QB64** [INTEGER](INTEGER) positive numerical type when it precedes the 6 numerical suffixes below:
* [INTEGER](INTEGER) [INTEGER](INTEGER) numerical type (2 bytes)
* [LONG](LONG) [INTEGER](INTEGER) numerical type (4 bytes}
* [_INTEGER64](_INTEGER64) **QB64** [INTEGER](INTEGER) numerical type (8 bytes) 
* [_BIT](_BIT) **QB64** [INTEGER](INTEGER) numerical type (1 bit) (Key below tilde (~) or [CHR$](CHR$)(96))
* [_BYTE](_BYTE) **QB64** [INTEGER](INTEGER) numerical type (1 byte)
* [_OFFSET](_OFFSET) **QB64** [INTEGER](INTEGER) numerical pointer address type (any byte size required)

### Numerical Base Prefixes

* [&B](&B)           Base 2:    Digits 0 or 1 [**QB64**]
* [&O](&O)            Base 8:    Digits 0 to 7
* [&H](&H) Base 16: Digits 0 to F

### [Mathematical Operations](Mathematical-Operations)

* [+](+) operator or sign
* [-](-) operator or sign
* [*](*) operator
* [/](/) (floating decimal point) operator
* [\\](\\) operator
* [^](^) operator
* [MOD](MOD) operator

### [Relational Operations](Relational-Operations)

* [Equal](Equal) Equal to condition
* [Not_Equal](Not-Equal) Not equal condition
* [Greater_Than](Greater-Than) Greater than condition
* [Less_Than](Less-Than) Less than condition
* [Greater_Than_Or_Equal](Greater-Than-Or-Equal) Greater than or equal to condition
* [Less_Than_Or_Equal](Less-Than-Or-Equal) Less than or equal to condition

## References

Got a question about something?

* [QB64 FAQ](QB64-FAQ)
* [Visit the QB64 Main Site](http://qb64.com)

Links to other QBasic Sites:

* [Member programs at QBasic Station](http://qbasicstation.com/index.php?c=p_member)
* [QBasic Forum at Network 54](http://www.network54.com/Index/10167)
* [Pete's QBasic Forum](http://www.petesqbsite.com/forum/)
* [Pete's QBasic Downloads](http://www.petesqbsite.com/downloads/downloads.shtml)
