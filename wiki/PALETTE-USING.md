The [PALETTE USING](PALETTE-USING) statement sets all RGB screen color intensities using values from an [Arrays](Arrays).

## Syntax

>  [PALETTE USING](PALETTE-USING) array%(startIndex%)


## Description

* The [Arrays](Arrays) holds the RGB color value using the color value as `red% + 256 * green% + 65536 * blue%`.
  * Color intensities range from 0 to 63.
* startIndex% indicates the index in the array from which the statement should start reading. The statement will read all color attributes available in that [SCREEN (statement)](SCREEN-(statement)) mode. The **number of values required** in the array is listed below:

```text

**              Screen mode       Attributes       Colors         Values**
                   0              0 - 15         0 - 63           16
                   1              0 - 3          0 - 3             4
                   2              0 - 1          0 - 1             2 
                   7              0 - 15         0 - 15           16
                   8              0 - 15         0 - 15           16
                   9              0 - 15         0 - 63           16
                  10              0 - 3          0 - 8             4
                  11              0 - 1          0 - 1             2
                  12              0 - 15         0 - 262,143      16
                  13              0 - 15         0 - 263,143     256 

```

* A color argument of -1 in the array leaves the attribute unchanged. Other negative numbers are invalid.

## See Also

* [PALETTE](PALETTE), [COLOR](COLOR)
* [_PALETTECOLOR](_PALETTECOLOR)
* [SCREEN (statement)](SCREEN-(statement))
