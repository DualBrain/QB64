The [INPUT](INPUT) statement requests a [STRING](STRING) or numerical keyboard entry from the user.

## Syntax

>  [INPUT](INPUT) [;] "[Question or statement text]"{,|;} variable[, ...]
>
>  [INPUT](INPUT) ; variable[, ...]

## Parameter(s)

* A [semicolon](semicolon) after the [INPUT](INPUT) keyword keeps the entry on the same row after enter is pressed  and prevents the screen contents from rolling up.
* The optional prompt "Question or statement text" must be a literal predefined [STRING](STRING). **The prompt cannot use a variable.**
* [Quotation mark](Quotation-mark)s are required except when a semicolon follows [INPUT](INPUT). A question mark will appear before the cursor.
* A [semicolon](semicolon) immediately after the text statement will display a question mark with a space after it. Use a [comma](comma) for input statements.

## Description

* **QB64** does not return *Redo from start* errors like QBasic did, as user input is limited to the scope of the variable [Data types](Data-types) used.
* Text entries (with a [STRING](STRING) variable]] can receive any characters, including numerical. **QB64 will ignore commas in single variable text entries.**
* The [Data types](Data-types) of the variable used to store user input determines the valid numerical range for value entries in QB64, with non-numerical characters limited to D, E, [&H](&H), [&O](&O) or [&B](&B).
  * For example, if you use an [INTEGER](INTEGER) variable, as in `INPUT "Initial value: ", myValue%`, the valid range is -32768 to 32767.
  * [INTEGER](INTEGER), [LONG](LONG), and [_INTEGER64](_INTEGER64) entries will ignore decimal points entered and will use all numbers.
  * INPUT can be used to get more than one variable value from the user. Do so by separating input variables with commas in the code.
  * The program must inform the user that more than one variable is requested, in order to enter each value separated with a comma at runtime.
  * [STRING](STRING) and numerical variables can both be used in multiple entry requests separated by commas.
  * **QB64**  allows comma separated entries to be skipped by the user without generating an error.
* **Use [LINE INPUT](LINE-INPUT) for text input entries that may contain commas such as address or name entries.**
* The user must press enter for the INPUT procedure to end. <!-- redundant: Multiple entries can be skipped. -->
* [INPUT](INPUT) accepts the [scientific notation](scientific-notation) letters D or E in [SINGLE](SINGLE) or [DOUBLE](DOUBLE) numerical values.
* Numerical values starting with [&H](&H), [&O](&O) and [&B](&B) can also be entered.
* INPUT removes all leading or trailing spaces in a string value entry. **QB64 does NOT remove those spaces!**
* The statement halts a program until enter is pressed, which may not be desired in programs using mouse input (see [INKEY$](INKEY$) loops).
* Use [_DEST](_DEST) [_CONSOLE](_CONSOLE) before INPUT statements to receive input from a [$CONSOLE]($CONSOLE) window.

## Example(s)

Using a variable in an input text message using PRINT. INPUT prompts cannot use variables.

```vb

INPUT "Enter your name: ", name$
PRINT name$ + " please enter your age: ";: INPUT "", age% 'empty string with comma
PRINT name$ + " how much do you weigh"; : INPUT weight%   'no text adds ? 

```

> *Explanation:* Use an empty string with a comma to eliminate the question mark that would appear without the string.

How QB64 avoids a *Redo from start* multiple entry error. Use commas between values.

```vb

DO
  INPUT "What is your name, age, and sex(M/F)"; name$, age%, sex$
LOOP UNTIL age%        'loop until age is not 0
IF age% >= 21 THEN PRINT "You can drink beer!" ELSE PRINT "You cannot drink beer yet!"
END 

```

```text

What is your name, age, and sex(M/F)? Tom,24,M
You can drink beer!

```

> *Explanation:* Try to enter text for the age value and it will not work. E or D should be allowed as decimal point numerical entries.

Preventing screen roll after an input entry on the bottom 2 screen rows.

```vb

SCREEN 12

COLOR 14: LOCATE 29, 2 '          place cursor at beginning of prompt line
PRINT "Enter a name to search for... "; 'print prompt on screen with input to follow
COLOR 15: INPUT ; "", name$ '       get search name from user
LOCATE 29, 2: PRINT SPC(78); '       erase previous prompt
n$ = UCASE$(name$) '                 convert search name to upper case
COLOR 14'                        change foreground color to yellow
LOCATE 29, 2: PRINT "Searching..."; 'print message
SLEEP 

```

```text

Enter a name to search for... █

```

>  *Explanation:* The red [semicolon](semicolon) after INPUT acts like a semicolon after a [PRINT](PRINT), which keeps the print cursor on the same row.

## See Also

* [INPUT$](INPUT$), [INKEY$](INKEY$)
* [LINE INPUT](LINE-INPUT), [LOCATE](LOCATE)
* [INPUT (file statement)](INPUT-(file-statement)), [LINE INPUT (file statement)](LINE-INPUT-(file-statement)) (file input)
* [_KEYHIT](_KEYHIT), [_KEYDOWN](_KEYDOWN)
* [Scancodes](Scancodes)
