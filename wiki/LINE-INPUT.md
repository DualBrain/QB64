The [LINE INPUT](LINE-INPUT) statement requests a [STRING](STRING) keyboard entry from a program user.

## Syntax

>  [LINE INPUT](LINE-INPUT) [;] "[text prompt or question]"{,|;} stringVariable$
>  [LINE INPUT](LINE-INPUT) ; stringVariable$

## Parameter(s)

* A [semicolon](semicolon) immediately after LINE INPUT stops the cursor after the entry and prevents screen roll on the lowest two screen rows.
* *text prompt or question* is optional, but quotes are necessary unless just a semicolon is used before the stringVariable$.
* Requires only one [STRING](STRING) variable to hold the entire text entry.

## Description

* Cannot use numerical [Variable Types](Variable-Types) variables or [comma](comma) separated variable lists for multiple entries.
* Allows [comma](comma)s and [quotation mark](quotation-mark)s in the user input, unlike [INPUT](INPUT) where commas denote extra input values and quotes delimit strings.
* The statement halts the program until an entry is made. Pressing Enter ends the entry and code execution resumes.
* LINE INPUT does not trim off leading or trailing spaces in the string entry like [INPUT](INPUT) string returns.
* Use [VAL](VAL) to convert string numbers and [&O](&O) (octal), [&H](&H) (hexadecimal) or [&B](&B) (binary) prefixed entries into numerical values. 
* Use [_DEST](_DEST) [_CONSOLE](_CONSOLE) before LINE INPUT statements to receive input from a [$CONSOLE]($CONSOLE) window.
* **Note: QB64** will not remove CHR$(0) from the end of LINE INPUT string return values like QBasic did.

## Example(s)

Preventing screen roll after an input entry on the bottom 2 screen rows. 

```vb

SCREEN 12

COLOR 14: LOCATE 29, 2 '          place dursor at beginning of prompt liine
PRINT "Enter a name to search for... "; 'print prompt on screen
COLOR 15: LINE INPUT ; "", name$ '       get search name from user
LOCATE 29, 2: PRINT SPC(78); '       erase previous prompt
n$ = UCASE$(name$) '                 convert search name to upper case
COLOR 14'                        change foreground color to yellow
LOCATE 29, 2: PRINT "Searching..."; 'print message
SLEEP 

```

```text

Enter a name to search for... █

```

> *Explanation:* The red [semicolon](semicolon) after LINE INPUT acts like a semicolon after a [PRINT](PRINT), which keeps the print cursor on the same row.

## See Also
 
* [INPUT (file mode)](INPUT-(file-mode)), [INPUT (file statement)](INPUT-(file-statement)), [LINE INPUT (file statement)](LINE-INPUT-(file-statement))
* [INPUT](INPUT), [INPUT$](INPUT$) (keyboard input)
* [COLOR](COLOR), [LOCATE](LOCATE) 
* [INKEY$](INKEY$)
* [_KEYHIT](_KEYHIT), [_KEYDOWN](_KEYDOWN)
