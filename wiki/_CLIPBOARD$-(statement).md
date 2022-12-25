The [_CLIPBOARD$ (statement)](_CLIPBOARD$-(statement)) statement copies the specified [STRING](STRING) value into the operating system's clipboard.

## Syntax

> [_CLIPBOARD$ (statement)](_CLIPBOARD$-(statement)) = string_expression$

## Description

* string_expression$ is the string value to be sent to the clipboard.
* The string value will replace everything previously in the clipboard.
* Assemble long text into one string variable value before using this statement.
* Add CHR$(13) + CHR$(10) CRLF characters to move to a new clipboard line.
* When copying text files, end line CRLF characters 13 and 10 do not have to be added.
* Numerical values can be converted to strings using [STR$](STR$), [_MK$](_MK$), [MKI$](MKI$), [MKL$](MKL$), [MKS$](MKS$), [MKD$](MKD$), [HEX$](HEX$) or [OCT$](OCT$).
* The clipboard can be used to copy, paste and communicate between running programs.

## Example(s)

Set 2 lines of text in the clipboard using a carriage return to end text lines

```vb

DIM CrLf AS STRING * 2            'define as 2 byte STRING
CrLf = CHR$(13) + CHR$(10)        'carriage return & line feed 

_CLIPBOARD$ = "This is line 1" + CrLf + "This is line 2" 
PRINT _CLIPBOARD$                 'display what is in the clipboard

```

```text

This is line 1

This is line 2

```

> *Note:* The text in the clipboard could also be sent to a file using [PRINT (file statement)](PRINT-(file-statement)) [_CLIPBOARD$](_CLIPBOARD$).

## See Also

* [_CLIPBOARD$](_CLIPBOARD$) (function)
* [_CLIPBOARDIMAGE (function)](_CLIPBOARDIMAGE-(function)), [_CLIPBOARDIMAGE](_CLIPBOARDIMAGE) (statement)
* [CHR$](CHR$), [ASCII](ASCII) (code table)
