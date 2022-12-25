**QB64 uses more variable types than QBasic ever did. The variable type determines the size of values that numerical variables can hold.**

### Numerical Types

| Type Name | Symbol | Minimum Value | Maximum Value | Size (Bytes) |
| --------- | ------ | ------------- | ------------- | ------------ |
| _BIT | ` | -1 | 0 | 1/8 |
| _BIT * n | `n | -128 | 127 | n/8 |
| _UNSIGNED _BIT | ~` | 0 | 1 | 1/8 |
| _BYTE | %% | -128 | 127 | 1 |
| _UNSIGNED _BYTE | ~%% | 0 | 255 | 1 |
| INTEGER | % | -32,768 | 32,767 | 2 |
| _UNSIGNED INTEGER | ~% | 0 | 65,535 | 2 |
| LONG | & | -2,147,483,648 | 2,147,483,647 | 4 |
| _UNSIGNED LONG | ~& | 0 | 4,294,967,295 | 4 |
| _INTEGER64 | && | -9,223,372,036,854,775,808 | 9,223,372,036,854,775,807 | 8 |
| _UNSIGNED _INTEGER64 | ~&& | 0 | 18,446,744,073,709,551,615 | 8 |
| SINGLE | ! or none | -2.802597E-45 | +3.402823E+38 | 4 |
| DOUBLE | # | -4.490656458412465E-324 | +1.797693134862310E+308 | 8 |
| _FLOAT | ## | -1.18E−4932 | +1.18E+4932 | 32 (10 used) |
| _OFFSET | %& | -9,223,372,036,854,775,808 | 9,223,372,036,854,775,807 | Use LEN |
| _UNSIGNED _OFFSET | ~%& | 0 | 18,446,744,073,709,551,615 | Use LEN |
| _MEM | none | combined memory variable type | N/A | Use LEN |

*Note: For the floating-point numeric types [SINGLE](SINGLE) (default when not assigned), [DOUBLE](DOUBLE) and [_FLOAT](_FLOAT), the minimum values represent the smallest values closest to zero, while the maximum values represent the largest values closest to ±infinity. OFFSET dot values are used as a part of the [_MEM](_MEM) variable type in QB64 to return or set the position in memory.*

### String Text Type

| Type Name | Symbol | Minimum Length | Maximum Length | Size (Bytes) |
| --------- | ------ | -------------- | -------------- | ------------ |
| STRING | $ | 0 | 2,147,483,647 | Use LEN |
| STRING * *n* | $n | 1 | 2,147,483,647 | n |

If no suffix is used and no DEFxxx or _DEFINE command has been used and the variable hasn't been [DIM](DIM)med the **default variable type is [SINGLE](SINGLE)**. **[_MEM](_MEM) and [_OFFSET](_OFFSET) variable types cannot be cast to other variable types!**

All types dealing with number values are signed as a default. The symbol to define unsigned variables is ~ and is used just before the type suffix (~` is [_UNSIGNED](_UNSIGNED) _BIT, ~%% is [_UNSIGNED](_UNSIGNED) _BYTE, etc.).

**[SINGLE](SINGLE), [DOUBLE](DOUBLE) and [_FLOAT](_FLOAT) floating decimal point values cannot be [_UNSIGNED](_UNSIGNED)!**

**Defining variable types:**

> [DIM](DIM) *variable* [AS](AS) *type*
> [_DEFINE](_DEFINE) *range1-range2* [AS](AS) *value_type*
> [DEFINT](DEFINT) *range1-range2*
> [DEFLNG](DEFLNG) *range1-range2*
> [DEFSNG](DEFSNG) *range1-range2*
> [DEFDBL](DEFDBL) *range1-range2*

Where *range1* and *range2* are the range of first letters to be defined as the default *type* when the variable is having no suffix and are not otherwise defined, the starting letter of the variable then defines the *type* as specified by the DEFxxx and _DEFINE statements. The QB64 types can only be defaulted using [_DEFINE](_DEFINE).

*type* can be any of the types listed at the top and can also be preceeded with [_UNSIGNED](_UNSIGNED) for the unsigned version of the type.

*variable* is the name of the variable to be defined in the DIM statement.

**More information:**

More information on this page: [Data types](Data-types)
