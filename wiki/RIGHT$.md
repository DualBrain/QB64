The **RIGHT$** function returns a set number of characters in a [STRING](STRING) variable starting from the end and counting backwards.

## Syntax

> **RIGHT$(***stringvalue$, numberofcharacters%***)**

## Parameter(s)

* The *stringvalue$* can be any string of [ASCII](ASCII) characters as a [STRING](STRING) variable.
* The *numberofcharacters* [INTEGER](INTEGER) value determines the number of characters to return from the right end of the string.

## Description

* If the number of characters exceeds the string length([LEN](LEN)) the entire string is returned.
* RIGHT$ returns always start at the last character of the string, even if a space. [RTRIM$](RTRIM$) can remove ending spaces.
* **Number of characters cannot be a negative value.**

## Example(s)

Getting the right portion of a string value such as a person's last name. 

```vb

name$ = "Tom Williams"

Last$ = RIGHT$(name$, LEN(name$) - INSTR(name$, " ")) 'subtract space position from string length

PRINT Last$ 

```

```text

Williams 

```

Adding the leading zero in single digit [HEX$](HEX$) values using RIGHT to take the right two hexadecimal string digits.

```vb

SCREEN _NEWIMAGE(640, 480, 32) '32 bit screen modes ONLY!
red = 255
green = 0
blue = 128

Color32 red, green, blue
PRINT "Colored text"

SUB Color32 (R, G, B)
R = R AND &HFF: G = G AND &HFF: B = B AND &HFF '    limit values to 0 to 255
hexadecimal$ = "&HFF" + RIGHT$("0" + HEX$(R), 2) + RIGHT$("0" + HEX$(G), 2) + RIGHT$("0" + HEX$(B), 2)
PRINT hexadecimal$
COLOR VAL(hexadecimal$)
END SUB 

```

```text

**&HFFFF0080**
**Colored text**

```

>  *Note:* When a single hexadecimal digit is returned the resulting value will need the leading zero added. Otherwise the hexa- decimal value created will have a byte missing from the value. EX: Color &HFF000000 is valid while &HFF000 is not.

## See Also
 
* [LEFT$](LEFT$), [MID$](MID$) 
* [LTRIM$](LTRIM$), [RTRIM$](RTRIM$) 
* [INSTR](INSTR), [HEX$](HEX$)
