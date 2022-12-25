The [_MK$](_MK$) function can convert any numerical type into an [ASCII](ASCII) [STRING](STRING) value that can be converted back using [_CV](_CV).

## Syntax

> string_value$ = [_MK$](_MK$)(numericalType, numericalValue)

## Parameter(s)

* numericalType is any QB64 numerical type: [INTEGER](INTEGER), [LONG](LONG), [SINGLE](SINGLE), [DOUBLE](DOUBLE), [_INTEGER64](_INTEGER64), [_BYTE](_BYTE) and [_OFFSET](_OFFSET).
* Whole integer values can be signed or [_UNSIGNED](_UNSIGNED).
* numericalValue must match the numericalType used.

## Description

* Supports converting any QBasic or **QB64** numerical value into a string value. 
* Some resulting [ASCII](ASCII) string characters might not be able to be printed to the screen.

## See Also

* [_CV](_CV) (QB64 conversion function)
* [MKI$](MKI$), [CVI](CVI), [INTEGER](INTEGER)
* [MKL$](MKL$), [CVL](CVL), [LONG](LONG)
* [MKS$](MKS$), [CVS](CVS), [SINGLE](SINGLE)
* [MKD$](MKD$), [CVD](CVD), [DOUBLE](DOUBLE)
* [MKSMBF$](MKSMBF$), [CVSMBF](CVSMBF) (Microsoft Binary Format)
* [MKDMBF$](MKDMBF$), [CVDMBF](CVDMBF) (Microsoft Binary Format)
* [PDS (7.1) Procedures](PDS-(7.1)-Procedures)
