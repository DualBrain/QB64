The [MID$](MID$) statement substitutes one or more new characters for existing characters of a previously defined [STRING](STRING).

## Syntax

>  [MID$](MID$)(baseString$, startPosition%[, bytes%]) = replacementString$

## Description

* The baseString$ variable must exist and be large enough to contain the replacementString$.
* startPosition% specifies the string character position to start the overwrite.
* bytes% or number of characters is optional. Excess byte lenghts are ignored.
* The replacementString$ should be as long as the byte length reserved.
* The length of the original string is not changed in any case. If replacementString$ is longer, it gets clipped.

## Example(s)

Using [INSTR](INSTR) to locate the string positions and a [MID$ (statement)](MID$-(statement)) statement to change the words.

```vb

 text$ = "The cats and dogs were playing, even though dogs don't like cats."
 PRINT text$ 
 start% = 1          ' start cannot be 0 when used in the INSTR function!
 DO
   position% = INSTR(start%, text$, "dog")
   IF position% THEN            ' when position is a value greater than 0
	MID$(text$, position%, 3) = "rat" ' change "dog" to "rat" when found
     start% = position% + 1     ' advance one position to search rest of string
   END IF
 LOOP UNTIL position% = 0       ' no other matches found
 PRINT text$ 

```

```text

The cats and dogs were playing, even though dogs don't like cats.
The cats and rats were playing, even though rats don't like cats.

```

## See Also

* [MID$](MID$) (function)
* [LEFT$](LEFT$), [RIGHT$](RIGHT$) 
* [INSTR](INSTR), [ASCII](ASCII),  [STR$](STR$), [HEX$](HEX$), [Bitmaps](Bitmaps) (example)
* [MKI$](MKI$), [MKL$](MKL$), [MKS$](MKS$), [MKD$](MKD$)
