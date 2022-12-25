The **comma** is used to [TAB](TAB) the cursor after a [PRINT](PRINT) statement's text to tab append another printed value.

## Usage

> INPUT "Name, age and sex(M or F): ", nm$, age%, sex$

* Commas in [PRINT](PRINT) statements [TAB](TAB) space values up to 15 column places with column 57 being the maximum per row. 
* A comma following the prompt text in an [INPUT](INPUT) statement does not display a question mark. A [Semicolon](Semicolon) or no prompt does.
* Commas are also used between [INPUT](INPUT) statement variables when more than one input is required.
* [LINE INPUT](LINE-INPUT) can use a comma or [semicolon](semicolon) after the prompt text. Neither will display a [question mark](question-mark).
* Commas are used as [argument](argument) separators in many kinds of QBasic statements and [SUB](SUB) or [FUNCTION](FUNCTION) parameter lists.
* [WRITE](WRITE) statements use commas to separate values printed to the screen or sent to a file **without tab spacing them**.
* **Literal numerical values entered into program code, [DATA](DATA), files or user [INPUT](INPUT) cannot contain comma separators!**

## Example(s)

Comparing [TAB](TAB) to [comma](comma) tab spacing.

```vb

PRINT TAB(15); "T"

PRINT , "T" 

```

Comparing PRINT and WRITE statement displays.

```vb

value1 = 23567: value2 = 45678: value3 = 354126
COLOR 14: LOCATE 2, 1: PRINT value1, value2, value3
COLOR 12: LOCATE 4, 1: WRITE value1, value2, value3

```

```text

23567        45678      354126

23567,45678,354126

```

> *Note:* [WRITE](WRITE) does not space any values. The commas separate the numerical values without the normal PRINT spacing.

## See Also

* [Semicolon](Semicolon), [Colon](Colon)
* [TAB](TAB), [SPC](SPC), [SPACE$](SPACE$)
* [PRINT](PRINT), [PRINT USING](PRINT-USING)
* [WRITE](WRITE), [INPUT](INPUT), [LINE INPUT](LINE-INPUT)
