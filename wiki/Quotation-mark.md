A **quotation mark** delimits the start and end of a literal [STRING](STRING) value. 

## Usage

> string_value$ = "This is a text STRING."

* The quotation mark must delimit the ends of a string or text prompt in a [PRINT](PRINT), [WRITE](WRITE), [INPUT](INPUT) or [LINE INPUT](LINE-INPUT) statement. 
* The IDE may add  a missing quotation mark at the end of a [SUB](SUB) or [FUNCTION](FUNCTION). 
* [LINE INPUT](LINE-INPUT) allows quotation marks to be entered as user input. The [LINE INPUT (file statement)](LINE-INPUT-(file-statement)) can transfer quotation marks.
* Quotation marks should be used when [comma](comma)s are used in a literal [WRITE](WRITE) or [INPUT (file statement)](INPUT-(file-statement)) text string. 
* To insert quotation marks in a [PRINT](PRINT) statement insert [CHR$](CHR$)(34) using string [concatenation](concatenation) or [semicolon](semicolon)s.
* String values can be [concatenation](concatenation) or added using the plus ([+](+)) operator. Cannot be used to combine numerical values!
* Concatenation MUST be used when combining literal [STRING](STRING) values in a variable definition.
* String values can be combined with other string or numerical values using [semicolon](semicolon)s or [comma](comma) tabs in a PRINT statement.
* Literal [DATA](DATA) strings do not require quotation marks unless the value is a keyword, uses commas or has end spaces.

## See Also

* [STRING](STRING), [PRINT](PRINT), [WRITE](WRITE)
* [CHR$](CHR$), [LINE INPUT](LINE-INPUT)
