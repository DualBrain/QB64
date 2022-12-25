[_INTEGER64](_INTEGER64) is an 8 byte number type definition that can hold whole numerical values. 

## Syntax

> [DIM](DIM) variable [AS](AS) [_INTEGER64](_INTEGER64)

## Description

* Can be used in 32 or 64 bit computers.
* Signed numerical values can range from -9223372036854775808 to 9223372036854775807.
* [_UNSIGNED](_UNSIGNED) [_INTEGER64](_INTEGER64) values range from 0 to 18446744073709551615 on 64 bit computers.
* Variable type suffix is **&&** or **~&&** for [_UNSIGNED](_UNSIGNED). Suffix can also be placed after a literal or hexadecimal numerical value. 
* Values can be converted to 8 byte [ASCII](ASCII) character strings using [_MK$](_MK$) and back using [_CV](_CV).
* Equivalent to INT8 or unsigned as UINT8 in C programming.
* **When a variable has not been assigned or has no type suffix, the value defaults to [SINGLE](SINGLE).**

## See Also

* [INTEGER](INTEGER), [LONG](LONG)
* [_DEFINE](_DEFINE), [DIM](DIM)
* [_UNSIGNED](_UNSIGNED)
* [_CV](_CV), [_MK$](_MK$)
* [PDS (7.1) Procedures](PDS-(7.1)-Procedures)
* [Variable Types](Variable-Types)
