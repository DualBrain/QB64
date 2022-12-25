[LONG](LONG) defines a variable as a 4 byte number type definition for larger [INTEGER](INTEGER) values.

## Syntax

>  [DIM](DIM) variable AS [LONG](LONG)

* [LONG](LONG) integer values range from -2147483648 to 2147483647.
* **QB64**'s [_UNSIGNED](_UNSIGNED) [LONG](LONG) integer values range from 0 to 4294967295.
* **QB64** [_UNSIGNED](_UNSIGNED) [_INTEGER64](_INTEGER64) values range from 0 to 18446744073709551615.
* Decimal point values assigned to a [LONG](LONG) variable will be rounded to the nearest whole number.
* The LONG variable type suffix is & or ~& for [_UNSIGNED](_UNSIGNED). Suffix can also be placed after a literal or hexadecimal numerical value.
* [_INTEGER64](_INTEGER64) uses the **&&** or **~&&** [_UNSIGNED](_UNSIGNED) suffix.
* Values can be converted to 4 byte [ASCII](ASCII) string values using [MKL$](MKL$) and back with [CVL](CVL).
* **When a variable has not been assigned or has no type suffix, the type defaults to [SINGLE](SINGLE).**
* **Warning: QBasic keyword names cannot be used as numerical variable names with or without the type suffix.**

## See Also

* [DIM](DIM), [DEFLNG](DEFLNG)
* [LEN](LEN), [CLNG](CLNG)
* [MKL$](MKL$), [CVL](CVL) 
* [INTEGER](INTEGER), [_INTEGER64](_INTEGER64)
* [SINGLE](SINGLE), [DOUBLE](DOUBLE)
* [_DEFINE](_DEFINE), [_UNSIGNED](_UNSIGNED)
* [Variable Types](Variable-Types)
