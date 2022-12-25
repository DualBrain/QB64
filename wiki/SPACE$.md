The SPACE$ function returns a STRING consisting of a number of space characters.

## Syntax

> *result$* = **SPACE$(count&)**

## Parameter(s)

* count& is the number of space characters to repeat. Cannot use negative values!

## Usage

* Semicolons can be used to combine spaces with text [STRING](STRING) or numerical values.
* [Concatenation](Concatenation) using + can be used to combine [STRING](STRING) text values only.
* Spaces are often used to erase previous text PRINTs from the screen.
* The function result can also be used to [GET](GET) and [PUT](PUT) a number of bytes as zero characters: bytes$ = SPACE$(numbytes)
* Spaces can also be made using [SPC](SPC), [CHR$](CHR$)(32) or [STRING$](STRING$)(n%, 32).

*Differences between QB64 and QB 4.5:*

* **QB64** can use [LONG](LONG) values for count up to 2,147,483,647 while **QB 4.5** could only use [INTEGER](INTEGER) values up to 32,767.

## Example(s)

How to space text in a [PRINT](PRINT) statement using SPACE$ with string [concatenation](concatenation).

```vb

FOR count% = 0 TO 3
    PRINT "abc" + SPACE$( count% ) + "def"
NEXT count%

```

```text

abcdef
abc def
abc  def
abc   def

```

In [SCREEN](SCREEN) 0 SPACE$ can be used to change the background color to make an American flag.

```vb

 USA flag centered on screen with thin horizontal red & white stripes
' blue corner field with randomly twinkling stars
CLS
LOCATE 25, 1
PRINT "Press any key to stop twinkling";
COLOR , 4
z = 15
FOR x = 5 TO 19          '13 red & white stripes (x =5 to 21 for 15 stripes)
    IF z = 15 THEN z = 4 ELSE z = 15
    COLOR , z
    LOCATE x, 15
    PRINT SPACE$(55)
NEXT x
FOR x = 5 TO 11          'blue field in upper left quadrant (x = 5 to 13 to hold all 50 stars)
    COLOR 15, 1            'sits above 4th white stripe
    LOCATE x, 15
    PRINT SPACE$(23)
NEXT x
DO
    stop$ = INKEY$
    FOR x = 5 TO 10 STEP 2  '39 stars staggered across blue field (50 stars if x = 5 to 12)
        w = 16
        FOR y = 1 TO 6      '5 rows of 6 stars
            r = INT(RND * 6)
            IF r = 0 THEN z = 31 ELSE z = 15
            IF stop$ = "" THEN COLOR z ELSE COLOR 15
            LOCATE x, w
            w = w + 4
            PRINT "*";
        NEXT y
        w = 18
        FOR y = 1 TO 5      '5 rows of 5 stars
            r = INT(RND * 6)
            IF r = 0 THEN z = 31 ELSE z = 15
            IF stop$ = "" THEN COLOR z ELSE COLOR 15
            LOCATE x + 1, w
            w = w + 4
            PRINT "*";
        NEXT y
    NEXT x
    w = 16
    FOR y = 1 TO 6          '1 row of 6 stars
            r = INT(RND * 6)
            IF r = 0 THEN z = 31 ELSE z = 15
        IF stop$ = "" THEN COLOR z ELSE COLOR 15
        LOCATE x, w
        w = w + 4
        PRINT "*";
    NEXT y
    t = TIMER
    DO WHILE t + .2 >= TIMER: LOOP
LOOP WHILE stop$ = ""
COLOR 7, 0
END

```

> *Explanation:* In [SCREEN](SCREEN) 0, the background color is only placed with the the printed text and spaces. [CLS](CLS) can color the entire screen.

## See Also

* [PRINT](PRINT), [PRINT USING](PRINT-USING)
* [STRING$](STRING$), [CLS](CLS)
* [SPC](SPC), [TAB](TAB)
