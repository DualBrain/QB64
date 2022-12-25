The [LOCATE](LOCATE) statement locates the screen text row and column positions for a [PRINT](PRINT) or [INPUT](INPUT) procedure.

## Syntax

>  [LOCATE](LOCATE) [row%][, column%] [, cursor%][, cursorStart%, cursorStop%]

## Parameter(s)

* optional text row% [INTEGER](INTEGER) values are from 1 to 25, 43 or 50 in [SCREEN](SCREEN) 0 and  25 in most other legacy graphic screen modes, except screens 11 and 12 which can have 30 or 60 rows.  
* optional column% [INTEGER](INTEGER) values are from 1 to 40 or 80 in [SCREEN](SCREEN) 0 and 80 in all other legacy screen modes.
* optional cursor% value can be 0 to turn displaying the cursor off or 1 to turn it on.
* optional cursorStart% and cursorStop% values define the shape of the cursor by setting the start and stop scanline (values range from 0 to 31) for the cursor character.

## Description

* [WIDTH](WIDTH) statement can be used to determine the text width and height in [SCREEN](SCREEN) 0 and height of 30 or 60 in [SCREEN](SCREEN) 11 or 12.
* In [_NEWIMAGE](_NEWIMAGE) graphic screen the number of text *rows* are calculated as [_HEIGHT](_HEIGHT) \ 16 except when a [_FONT](_FONT) is used. Use [_FONTHEIGHT](_FONTHEIGHT) to calculate font rows.
* [_NEWIMAGE](_NEWIMAGE) graphic screen text *columns* are calculated as [_WIDTH (function)](_WIDTH-(function)) \ 8 except when a [_FONT](_FONT) is used. Use [_PRINTWIDTH](_PRINTWIDTH) to measure a line of font text.
* The text *row* position is not required if the [PRINT](PRINT) is going to be on the next row. The [comma](comma) and a *column* value are required to set the column.
* If only the *row* parameter is given, then the column position remains the same. **Neither *row* or *column* parameter can be 0.**
* When [PRINT](PRINT)ing on the bottom 2 *rows*, use a [semicolon](semicolon) after the PRINT expression to avoid a screen roll.
* If the cursorStart% line is given, the cursorStop% line must also be given. A wider range between them produces a taller cursor.
* If you use LOCATE beyond the current number of rows in text mode, QB64 will try to adapt the screen instead of tossing an error.
* When writing to the console, only the *row* and *column* arguments are used, all others are ignored. Furthermore, on non-Windows systems LOCATE statements that do not give both a *row* and *column* will be ignored entirely.

## Example(s)

Moving the cursor around (now you can finally create a Commodore 64 emulator!). **Default SCREEN 0 only:**

```vb

crx = 10
cry = 10
DO
  LOCATE cry, crx, 1, 0, 8
  a$ = INKEY$
  SELECT CASE a$
     CASE CHR$(0) + "H": IF cry > 1 THEN cry = cry - 1 'up
     CASE CHR$(0) + "P": IF cry < 25 THEN cry = cry + 1 'down
     CASE CHR$(0) + "K": IF crx > 1 THEN crx = crx - 1 'left
     CASE CHR$(0) + "M": IF crx < 80 THEN crx = crx + 1 'right
     CASE CHR$(27): END
  END SELECT
LOOP 

```

> Explanation: The CHR$(0) + "H", "P", "K", "M" represents the cursor arrow keys. start = 0, stop = 8 is the tallest cursor, experiment with the start and stop values for different effects (start = 8, stop = 8 is the default producing a _ cursor).

## See Also

* [CSRLIN](CSRLIN), [POS](POS) (cursor position)
* [SCREEN](SCREEN), [PRINT](PRINT), [COLOR](COLOR)
* [INPUT](INPUT), [LINE INPUT](LINE-INPUT), [INPUT$](INPUT$) (keyboard input)
* [WIDTH](WIDTH), [INPUT$](INPUT$), [INKEY$](INKEY$)
