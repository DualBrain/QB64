The [MKS$](MKS$) function encodes a [SINGLE](SINGLE) numerical value into a 4-byte [ASCII](ASCII) [STRING](STRING) value.

## Syntax

>  result$ = [MKS$](MKS$)(singlePrecisionVariableOrLiteral#)

## Description

* singlePrecisionVariableOrLiteral# is converted to four ASCII characters. To see this in action, try `PRINT MKS$(1345678)`.
* [SINGLE](SINGLE) values can range up to 7 decimal point digits. Decimal point accuracy depends on whole value places taken.
* [MKS$](MKS$) string values can be converted back to SINGLE numerical values using the [CVS](CVS) function.
* [SINGLE](SINGLE) numerical variable values [PUT](PUT) into a [BINARY](BINARY) file are automatically placed as an [MKS$](MKS$) [ASCII](ASCII) string value.

## See Also

* [MKI$](MKI$), [MKD$](MKD$), [MKL$](MKL$)
* [CVD](CVD), [CVI](CVI), [CVS](CVS), [CVL](CVL)
* [_MK$](_MK$), [_CV](_CV)
