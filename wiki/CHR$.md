The [CHR$](CHR$) function returns the character associated with a certain [ASCII](ASCII) as a [STRING](STRING).

## Syntax

> result$ = [CHR$](CHR$)(code%)

## Description

* Valid ASCII code% numbers range from 0 to 255.
* The character code of a character can be found using [ASC](ASC).
* Some control codes below 32 will not [PRINT](PRINT) or will move the screen cursor, unless [_CONTROLCHR](_CONTROLCHR) is used.

## Example(s)

Outputs the characters of several character codes:

```vb

PRINT CHR$(65); CHR$(65 + 32)
PRINT CHR$(66); CHR$(66 + 32)

```

```text

Aa
Bb

```

> Explanation: 65 is the ASCII code for "A" and 65 + 32 is the ASCII code for "a". 66 is the ASCII code for "B" and 66 + 32 is the ASCII code for "b"

To cut down on typing CHR$(???) all day, define often used characters as variables such as Q$ = CHR$(34) as shown.

```vb

DIM Q AS STRING * 1   'define as one byte string(get rid of $ type suffix too)
Q = CHR$(34)          'Q will now represent the elusive quotation mark in a string

PRINT "This text uses "; Q; "quotation marks"; Q; " that could have caused a syntax error!"


```

```text

This text uses "quotation marks" that could have caused a syntax error!

```

Using [ASC](ASC) and [CHR$](CHR$) to *encrypt* a text file size up to 32K bytes

```vb

OPEN FileName$ FOR INPUT AS #1 ' FileName to be encrypted
IF LOF(1) <= 32000 THEN Text$ = INPUT$(LOF(1), 1) ' get Text as one string
CLOSE #1
Send$ = "" ' clear value
FOR i = 1 TO LEN(Text$)
    Letter$ = MID$(Text$, i, 1) ' get each character in the text
    Code = ASC(Letter$)
    IF (Code > 64 AND Code < 91) OR (Code > 96 AND Code < 123) THEN
        Letter$ = CHR$(Code + 130) ' change letter's ASCII character by 130
    END IF
    Send$ = Send$ + Letter$ ' reassemble string with just letters encrypted
NEXT i
OPEN FileName$ FOR OUTPUT AS #1 ' erase FileName to be encrypted
PRINT #1, Send$   ' Text as one string
CLOSE #1

```

> *Warning: The routine above will change an original text file to be unreadable. Use a second file name to preserve the original file.*

*Example 4:'Decrypting** the above encrypted text file (32K byte file size limit).

```vb

OPEN FileName$ FOR INPUT AS #1       ' FileName to be decrypted
    Text$ = INPUT$(LOF(1), 1)         ' open Text as one string
CLOSE #1
Send$ = ""
FOR i = 1 TO LEN(Text$)
    Letter$ = MID$(Text$, i, 1)
    Code = ASC(Letter$)
    IF (Code > 194 AND Code < 221) OR (Code > 226 AND Code < 253) THEN
        Letter$ = CHR$(Code - 130)  ' change back to a Letter character
    END IF
    Send$ = Send$ + Letter$ ' reassemble string as normal letters
    NEXT i
OPEN FileName$ FOR OUTPUT AS #1 ' Erase file for decrypted text
    PRINT #1, Send$ ' place Text as one string
CLOSE #1 

```

> *Explanation:* Examples 3 and 4 encrypt and decrypt a file up to 32 thousand bytes. [INPUT$](INPUT$) can only get strings less than 32767 characters. The upper and lower case letter characters are the only ones altered, but the encryption and decryption rely on the fact that most text files do not use the code characters above 193. You could alter any character from ASCII 32 to 125 without problems using the 130 adder. No [ASCII](ASCII) code above 255 is allowed. Don't alter the codes below code 32 as they are control characters. Specifically, characters 13 and 10 (CrLf) may be used for line returns in text files.

## See Also

* [ASC](ASC), [ASC (statement)](ASC-(statement))
* [INKEY$](INKEY$)
* [ASCII](ASCII)
