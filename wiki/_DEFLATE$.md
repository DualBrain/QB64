The [_DEFLATE$](_DEFLATE$) function compresses a [STRING](STRING).

## Syntax

> result$ = [_DEFLATE$](_DEFLATE$)(stringToCompress$)

## Description

* result$ will contain the compressed version of stringToCompress$.
* To decompress the resulting string, use [_INFLATE$](_INFLATE$).

## Availability

* Version 1.4 and up.

## Example(s)

Compressing a long string of text.

```vb

a$ = "The quick brown fox jumps over the lazy dog. "
PRINT "Original string (a$): "; a$
FOR i = 1 TO 15
    a$ = a$ + a$
NEXT
 
PRINT "After concatenating it into itself several times, LEN(a$) ="; LEN(a$)
 
b$ = _DEFLATE$(a$)
PRINT "After using _DEFLATE$ to compress it, LEN ="; LEN(b$)
PRINT USING "(compressed size is #.###% of the original)"; ((LEN(b$) * 100) / LEN(a$))
c$ = _INFLATE$(b$)
PRINT "After using _INFLATE$ to decompress it, LEN ="; LEN(c$)
 
```

```text

Original string (a$): The quick brown fox jumps over the lazy dog
After concatenating it into itself several times, LEN(a$) = 1474560
After using _DEFLATE$ to compress it, LEN = 4335
(compressed size is 0.295% of the original)
After using _INFLATE$ to decompress it, LEN = 1474560

```

## See Also

* [_INFLATE$](_INFLATE$)
