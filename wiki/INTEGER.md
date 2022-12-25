[INTEGER](INTEGER) is a 2-byte number type definition that can hold whole numerical values.

## Syntax

> [DIM](DIM) *variable* AS [INTEGER](INTEGER)

* Integers do not use decimal point values but will round those off to the nearest even whole number.
* QBasic integer values can range from -32768 to 32767 without an "overflow" error.
* For larger integer values use the [LONG](LONG) integer type.
* **QB64** [INTEGER](INTEGER) values greater than 32767 become negative signed values instead of throwing an "overflow" error, as the top bit designates a negative value. See example 1 below.
* **QB64** [_UNSIGNED](_UNSIGNED) integers can range from  0 to 65535.
* **QB64** _UNSIGNED [_INTEGER64](_INTEGER64) values range from 0 to 18446744073709551615
* Many graphic programs require [INTEGER](INTEGER) arrays.
* Variable type suffix is % or ~% for [_UNSIGNED](_UNSIGNED). Suffix can also be placed after a literal or hexadecimal numerical value.
* [LONG](LONG) integers use the **&** suffix and [_INTEGER64](_INTEGER64) use the **&&** suffix.
* Values can be converted to 2 byte [ASCII](ASCII) string values using [MKI$](MKI$) and back with [CVI](CVI).
* **When a variable has not been defined or has no type suffix, the value defaults to [SINGLE](SINGLE).**
* **Warning: QBasic keyword names cannot be used as numerical variable names with or without the type suffix.**

## Example(s)

QBasic signed integers were limited from -32768 to 32767, but could not exceed 32767 or it would error:

```vb

DO: _LIMIT 2000
  i% = i% + 1
  PRINT i%
LOOP UNTIL i% = 0 

```

> *Explanation:* In **QB64** the count will go to 32767, then count up from -32768 to 0 before repeating the process without error. 

When a signed **QB64** INTEGER value exceeds 32767, the value may become a negative value:

```vb

i% = 38000
PRINT i% 

```

```text

-27536

```

> *Explanation:* Use an [_UNSIGNED](_UNSIGNED) INTEGER or a ~% variable type suffix for only positive integer values up to 65535.

In **QB64** [_UNSIGNED](_UNSIGNED) INTEGER values greater than 65535 cycle over again from zero:

```vb

i~% = 70000
PRINT i~% 

```

```text

 4464

```

> *Explanation:* In QB64 an unsigned integer value of 65536 would be 0 with values increasing by the value minus 65536. 

## See Also

* [DIM](DIM), [DEFINT](DEFINT)
* [LONG](LONG), [_INTEGER64](_INTEGER64)
* [LEN](LEN), [MKI$](MKI$), [CVI](CVI)
* [_DEFINE](_DEFINE), [_UNSIGNED](_UNSIGNED)
* [Variable Types](Variable-Types)
* [&B](&B) (binary), [&O](&O) (octal), [&H](&H) (hexadecimal)
* [\](\), [MOD](MOD) (Integer remainder division)
