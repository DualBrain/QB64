**SINGLE** variables are 4 byte floating decimal point numerical values up to seven digits in length.

## Syntax

> [DIM](DIM) *variable* AS SINGLE

## Description

* Values can range up to 7 digits. Decimal point accuracy depends on whole value places taken.
* Single is the **default variable type** assigned to undefined variables without a type suffix.
* Variable suffix type designation is **!**. Suffix can also be placed after a literal numerical value by user or automatically by the IDE.
* Values returned may be expressed using exponential or [scientific notation](scientific-notation) using **E** for SINGLE or **D** for DOUBLE precision.
* Floating decimal point numerical values cannot be [_UNSIGNED](_UNSIGNED)!
* Values can be converted to 4 byte [ASCII](ASCII) string values using [_MKS$](_MKS$) and back with [_CVS](_CVS).
* **Warning: QBasic keyword names cannot be used as numerical variable names with or without the type suffix!**

## See Also

* [DIM](DIM), [DEFSNG](DEFSNG)
* [MKS$](MKS$), [CVS](CVS)
* [DOUBLE](DOUBLE), [_FLOAT](_FLOAT)
* [LEN](LEN)
* [Variable Types](Variable-Types)
