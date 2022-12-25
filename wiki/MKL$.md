The [MKL$](MKL$) function encodes a [LONG](LONG) numerical value into a 4-byte [ASCII](ASCII) [STRING](STRING) value.

## Syntax

>  result$ = [MKL$](MKL$)(longVariableOrLiteral&)

## Description

* longVariableOrLiteral& is converted to four ASCII characters. To see this in action, try `PRINT MKL$(12345678)`.
* The numerical data usually takes up less bytes than printing the [LONG](LONG) number to a file.
* [LONG](LONG) integer values can range from -2147483648 to 2147483647.
* Since the representation of a long number can use up to 10 ASCII characters (ten bytes), writing to a file using [MKL$](MKL$) conversion, and then reading back with the [CVL](CVL) conversion can save up to 6 bytes of storage space.
* [CVL](CVL) can convert the value back to a [LONG](LONG) numerical value.
* [LONG](LONG) numerical variable values [PUT](PUT) into a [BINARY](BINARY) file are automatically placed as an MKL$ [ASCII](ASCII) string value.

## Example(s)

* [SAVEIMAGE](SAVEIMAGE)
* [SaveIcon32](SaveIcon32)

## See Also

* [MKI$](MKI$), [MKS$](MKS$), [MKD$](MKD$)
* [CVD](CVD), [CVI](CVI), [CVS](CVS), [CVL](CVL)
* [_MK$](_MK$), [_CV](_CV)
