The **PRINT #, USING** statement is used to [PRINT](PRINT) formatted text data to a file.

## Syntax

> **PRINT *filenumber%,*** [*text$*{;|,}] **USING *template$*; *variable***[; ...][{;|,}]

## Parameter(s)

* [INTEGER](INTEGER) *filenumber* refers to the file number [OPEN](OPEN)ed previously followed by a [comma](comma).
* Literal or variable [STRING](STRING) *text$* can be placed between PRINT and USING or it can be included in the *template*.
* A [semicolon](semicolon) or [comma](comma) may follow the *text* to stop or tab the print cursor before the *template* [PRINT](PRINT).
* The literal or variable [STRING](STRING) *template* should use the template symbols to display each variable [Variable Types](Variable-Types) in the list following it.
* The list of data *variables* used in the *template* are **separated by semicolons** after the template string value. 
* In **QB64** ONE [semicolon](semicolon) or [comma](comma) may follow the variable list to stop the print cursor for pending prints. QB only allowed a semicolon.

## Usage

* **If the *template* string is omitted or symbols don't match the *variable(s)* an "Illegal Function Call" [ERROR Codes](ERROR-Codes) will occur!**
* The list of data variables used in the template are **separated by semicolons** after the template string value. 
* The variables should be listed in the order that they are used in the template from left to right.
* Normal text is allowed in the template also (see example).
* **NOTE:** If the numerical value exceeds the template's integer digit range a % symbol will appear in the leftmost digit area.
* **WARNING: The numbers displayed are rounded so the actual values are never changed and are actually more accurate.**

Template is a literal or variable [string](STRING) using the following formatting characters:

| & | Prints an entire string value. STRING length should be limited as template width will vary. |
| -- | -- |
| \  \ | Denotes the start and end point of a fixed string area with spaces between(LEN = spaces + 2). |
| ! | Prints only the leading character of a string value. Exclamation points require underscore prefix. |
| # | Denotes a numerical digit. An appropriate number of digits should be used for values received. |
| ^^^^ | After # digits prints numerical value in exponential E+xx format. Use ^^^^^ for E+xxx values.* |
| . | Period sets a number's decimal point position. Digits following determine rounded value accuracy. |
| ,. | Comma to left of decimal point, prints a comma every 3 used # digit places left of the decimal point. |
| + | Plus sign denotes the position of the number's sign. + or - will be displayed. |
| - | Minus sign (dash) placed after the number, displays only a negative value's sign. |
| $ | Prints a dollar sign immediately before the highest non-zero # digit position of the numerical value. |
| ** | Prints an asterisk in any leading empty spaces of a numerical value. Adds 2 extra digit positions. |
| **$ | Combines ** and $. Negative values will display minus sign to left of $. |
| _ | Underscore preceding a format symbol prints those symbols as literal string characters. |

**Note: Any string character not listed above will be printed as a literal text character.**

* Any # decimal point position may be specified. The exponent is adjusted with significant digits left-justified.

## See Also
 
* [PRINT USING](PRINT-USING), [PRINT (file statement)](PRINT-(file-statement))
* [LPRINT USING](LPRINT-USING)
