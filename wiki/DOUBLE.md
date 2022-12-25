[DOUBLE](DOUBLE) type floating point numerical values use 8 bytes per value.

## Syntax

> [DIM](DIM) variable [AS](AS) [DOUBLE](DOUBLE)

## Description

* Literal or variable values can range up to 15 decimal point places.
* The variable suffix type is **#**.
* Use DOUBLE and [_FLOAT](_FLOAT) variables sparingly as they use a lot of program memory.
* Values returned may be expressed using exponential or [scientific notation](scientific-notation) using **E** for SINGLE or **D** for DOUBLE precision.
* Floating decimal point numerical values cannot be [_UNSIGNED](_UNSIGNED).
* Values can be converted to 8 byte [ASCII](ASCII) string values using [_MKD$](_MKD$) and back with [_CVD](_CVD).
* **When a variable has not been defined or has no type suffix, the value defaults to [SINGLE](SINGLE).**
* **Warning: QBasic keyword names cannot be used as numerical variable names with or without the type suffix.**

## QBasic

* Results of mathematical calculations may be approximate or slow in QuickBASIC 4.5.

## See Also

* [DIM](DIM), [DEFDBL](DEFDBL)
* [MKD$](MKD$), [CVD](CVD)
* [SINGLE](SINGLE), [_FLOAT](_FLOAT)
* [LEN](LEN)
* [Variable Types](Variable-Types)
