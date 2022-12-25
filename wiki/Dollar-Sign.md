The **$** is used to denote QBasic [Metacommand](Metacommand)s or as a [STRING](STRING) variable type suffix.

## Usage

> $INCLUDE: 'QB.bi'

* [$STATIC]($STATIC) denotes that all arrays can only be dimensioned once using [DIM](DIM).
* [$DYNAMIC]($DYNAMIC) denotes that all arrays can be redimensioned using [REDIM](REDIM) ONLY.
* [$INCLUDE]($INCLUDE) includes a BI file or QBasic Library in a program. The file name requires a comment before and after the name.
* The [STRING](STRING) variable suffix MUST be used if the variable is not dimensioned in a DIM statement. The statement can also set a fixed string [LEN](LEN).

## See Also

* [DIM](DIM), [REDIM](REDIM)
* [Metacommand](Metacommand)
