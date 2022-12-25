The [MKD$](MKD$) function encodes a [DOUBLE](DOUBLE) numerical value into an 8-byte [ASCII](ASCII) [STRING](STRING) value.

## Syntax

>  result$ = [MKD$](MKD$)(doublePrecisionVariableOrLiteral#)

## Description

* doublePrecisionVariableOrLiteral# is converted to eight ASCII characters. To see this in action, try `PRINT MKD$(12345678)`.
* [DOUBLE](DOUBLE) values can range up to 15 decimal point digits. Decimal point accuracy depends on whole value places taken.
* The string value can be converted back to a DOUBLE numerical value using [CVD](CVD).
* [DOUBLE](DOUBLE) numerical variable values [PUT](PUT) into a [BINARY](BINARY) file are automatically placed as an MKD$ [ASCII](ASCII) string value.

## See Also

* [MKI$](MKI$), [MKS$](MKS$), [MKL$](MKL$)
* [CVD](CVD), [CVI](CVI), [CVS](CVS), [CVL](CVL)
* [_MK$](_MK$), [_CV](_CV)
