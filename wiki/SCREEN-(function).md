The **SCREEN** function returns the [ASCII](ASCII) code of a text character or the color attribute at a set text location on the screen.

## Syntax

> codeorcolor% = **SCREEN (*row%*, *column%*** [, colorflag%]**)**

## Parameter(s)

* *row* and *column* are the [INTEGER](INTEGER) text coordinates of the [SCREEN](SCREEN) mode used.
* Optional *colorflag* [INTEGER](INTEGER) value can be omitted or 0 for [ASCII](ASCII) code values or 1 for color attributes.

## Usage

* The *code* value returned is the [ASCII](ASCII) code from 0 to 255. Returns 32([SPACE$](SPACE$)) when no character is found at a coordinate.
* If the *colorflag* value is omitted or it is 0, the function returns the [ASCII](ASCII) code of the text character at the position designated.
* When the *flag* value is greater than 0 in **SCREEN 0**, the function returns the foreground and background color attribute of text position.
  * The foreground color(0 to 15) is the returned SCREEN color value AND 15: **FG = SCREEN(1, 1, 1) AND 15**
  * The background color(0 to 7) is the returned SCREEN color value \ 16: **BG = SCREEN(1, 1, 1) \ 16**
* **QB64** can return color values in screen modes other than [SCREEN](SCREEN) 0. QBasic returned the wrong color values in graphic screen modes!

## Example(s)

Finding the text foreground and background colors in SCREEN 0 only:

```vb

SCREEN 0
COLOR 0, 15
CLS

PRINT "SCREEN ="; SCREEN(1, 1, 1)
PRINT "FG color:"; SCREEN(1, 1, 1) AND 15 'low nibble
PRINT "BG color:"; SCREEN(1, 1, 1) \ 16 'high nibble 

```

```text

**SCREEN = 112**
**FG color: 0**
**BG color: 7**

```

>  *Note:* How the SCREEN 0 background color can only be changed to colors 0 through 7! 7 * 16 = 112.

Reading the [ASCII](ASCII) code and color of a text character using the SCREEN function. Graphic colors were not reliable in QBasic!

```vb

SCREEN 12
row = 10: column = 10

COLOR 9: LOCATE row, column: PRINT "Hello"
code% = SCREEN(row, column, 0)     ' character code return parameter 0
attrib% = SCREEN(row, column, 1)   ' character color return parameter 1
COLOR 14: LOCATE 15, 10: PRINT "ASCII:"; code%, "COLOR:"; attrib%
END 

```

```text

         Hello

         ASCII: 72     COLOR: 9

```

> *Explanation:* The SCREEN function returns the [ASCII](ASCII) code for "H" and the color 9.

Finding the current program path placed on the screen using [FILES](FILES) and the SCREEN function in SCREEN 0.

```vb

SCREEN 0, 0, 0, 0
CLS
PRINT "This is a directory test..."
SCREEN 0, 0, 1, 0
COLOR 0 'blank out the screen text
FILES "qb64.exe"        'the current program's filename can also be used
FOR i = 1 TO 80
  a$ = a$ + CHR$(SCREEN(1, i)) 'scan the black text on the screen
NEXT
CLS
COLOR 7
a$ = RTRIM$(a$)
SLEEP
SCREEN 0, 0, 0, 0
LOCATE 3, 1: PRINT "The current directory is: "; a$
END 

```


> *Explanation:* The SCREEN page one is used to hide the [FILES](FILES) display using COLOR 0. The [SCREEN (function)](SCREEN-(function)) function reads the top of the screen page text and creates the current path string. It is then printed on the visual page.

## See Also
 
* [PRINT](PRINT), [SCREEN](SCREEN)
* [COLOR](COLOR), [CHR$](CHR$), [POINT](POINT)
* [CSRLIN](CSRLIN), [POS](POS), [ASCII](ASCII)
* [Screen Memory](Screen-Memory)
