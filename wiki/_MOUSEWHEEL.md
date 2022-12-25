The [_MOUSEWHEEL](_MOUSEWHEEL) function returns a positive or negative [INTEGER](INTEGER) value indicating mouse scroll events since the last read of [_MOUSEINPUT](_MOUSEINPUT).

## Syntax

> scrollAmount% = [_MOUSEWHEEL](_MOUSEWHEEL)

## Description

* Returns -1 when scrolling up and 1 when scrolling down with 0 indicating no movement since last read.
* After an event has been read, the value resets to 0 automatically so cumulative position values must be added.
* If no movement on the wheel has occurred since the last [_MOUSEINPUT](_MOUSEINPUT) read, [_MOUSEWHEEL](_MOUSEWHEEL) returns 0.

## Example(s)

Reading the cumulative mouse wheel "clicks".

```vb

 DO: _LIMIT 100
    DO WHILE _MOUSEINPUT
      Scroll = Scroll + _MOUSEWHEEL
      LOCATE 10, 20: PRINT Scroll
    LOOP
 LOOP UNTIL INKEY$ = CHR$(13) ' press Enter to quit 

```

A simple text scrolling routine using the mouse wheel value to read a text array.

```vb

DIM Array$(100)
LINE INPUT "Enter a file name with 100 or more lines of text: ", file$
OPEN file$ FOR INPUT AS #1
DO UNTIL EOF(1)
  inputcount = inputcount + 1
  LINE INPUT #1, Array$(inputcount)
  IF inputcount = 100 THEN EXIT DO
LOOP
FOR n = 1 TO 21: PRINT Array$(n): NEXT
CLOSE #1
DO
  DO WHILE _MOUSEINPUT
    IF row >= 0 THEN row = row + _MOUSEWHEEL ELSE row = 0  'prevent under scrolling
    IF row > inputcount - 20 THEN row = inputcount - 20    'prevent over scrolling
    IF prevrow <> row THEN 'look for a change in row value
      IF row > 0 AND row <= inputcount - 20 THEN
        CLS: LOCATE 2, 1
        FOR n = row TO row + 20
          PRINT Array$(n)
        NEXT
      END IF
    END IF
    prevrow = row 'store previous row value
  LOOP
LOOP UNTIL INKEY$ > "" 

```

Note: You will need a text file that is large enough for this example.

## See Also

* [_MOUSEX](_MOUSEX), [_MOUSEY](_MOUSEY), [_MOUSEBUTTON](_MOUSEBUTTON)
* [_MOUSEINPUT](_MOUSEINPUT), [_MOUSEMOVE](_MOUSEMOVE) 
* [_MOUSESHOW](_MOUSESHOW), [_MOUSEHIDE](_MOUSEHIDE)
* [Controller Devices](Controller-Devices)
