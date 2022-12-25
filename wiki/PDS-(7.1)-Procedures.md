QB64 is created to be compatible with Quick Basic 4.5 only as it was the most popular version. The following sub-procedures have been created to do things that were available in PDS versions of Quick Basic 7.0 and 7.1:

## CURRENCY

### MKC$

PDS could use the CURRENCY variable type and had the MKC$ function to convert those values to **8 byte** [ASCII](ASCII) string values. QB64 can convert [_FLOAT](_FLOAT) currency amounts to strings using [_MK$](_MK$) with [_INTEGER64](_INTEGER64) values:

```vb

SCREEN 12
DIM value AS _FLOAT
value = 12345678901234.6789 '    any currency value with up to 4 decimal point places

_PRINTSTRING (1, 50), "[" + MKC$(value) + "]" ' show ASCII string value

END

FUNCTION MKC$ (CurrVal AS _FLOAT) 'converts currency amount to PDS or VB currency string
DIM CVal AS _INTEGER64
CVal = CurrVal * 10000 '        multiply float value by 10 thousand
MKC = _MK$(_INTEGER64, CVal)
END FUNCTION 

```

> *Note:* The [_FLOAT](_FLOAT) currency amount must be multiplied by 10000 before it is converted to the [ASCII](ASCII) string value.

### CVC

PDS also had the CVC function to convert MKC$ currency string values back to currency amounts. QB64 can use [_CV](_CV) with [_INTEGER64](_INTEGER64) to convert those **8 byte** values back to [_FLOAT](_FLOAT) currency values. The procedure gets the currency string from a file:

```vb

SCREEN 12
DIM currency AS STRING * 8
OPEN "Currency.bin" FOR BINARY AS #1 'binary file with MKC$ values created by PDS or VB
GET #1, , currency
CLOSE #1

_PRINTSTRING (1, 10), "[" + currency + "]" 'show ASCII string value from file

_PRINTSTRING (1, 30), STR$(CVC##(currency))

END

FUNCTION CVC## (CurrStr AS STRING) 'converts currency string to a _FLOAT currency amount
DIM CV AS _INTEGER64
CV = _CV(_INTEGER64, CurrStr)
CVC = CV / 10000 '                   divide by 10 thousand
END FUNCTION 

```

> *Note:* The [_FLOAT](_FLOAT) currency amount must be divided by 10000 to create up to 4 decimal point places.

### PUT

Currency values can be [PUT](PUT) directly into [BINARY](BINARY) or [RANDOM](RANDOM) files using an [_INTEGER64](_INTEGER64) variable value.

```vb

DIM curr AS _INTEGER64, currency AS _FLOAT

currency = 9876.543
curr = currency * 10000 ' multiply currency value by 10000

OPEN "currency.bin" FOR BINARY AS #1 ' a binary file to hold PDS currency values
PUT #1, , curr
CLOSE #1

END 

```

### GET

When currency values are [PUT](PUT) directly into a [BINARY](BINARY) or [RANDOM](RANDOM) file, [_INTEGER64](_INTEGER64) can [GET](GET) them directly. Then divide by 10 ^ 4: 

```vb

DIM curr AS _INTEGER64, currency AS _FLOAT
OPEN "currency.bin" FOR BINARY AS #1 ' any binary file holding PDS currency values
GET #1, , curr
CLOSE #1

currency = curr / 10000 ' use any floating decimal point type within currency range

PRINT currency

END 

```

> *Note:* The currency value can be any [SINGLE](SINGLE), [DOUBLE](DOUBLE) or [_FLOAT](_FLOAT) floating decimal point value that will hold the range of values.

## DIR$

*Not to be confused with QB64's [_DIR$](_DIR$) function.*

This PDS(7.1) **derived DIR$ function** returns a filename or a list when more than one exist. The file spec can use a path and/or wildcards.

```vb

FOR i = 1 TO 2
  PRINT
  LINE INPUT "Enter a file spec: ", spec$
  file$ = DIR$(spec$) 'use a file spec ONCE to find the last file name listed
  PRINT DIRCount%, file$, 'function can return the file count using SHARED variable
  IF DIRCount% > 1 THEN
    DO
      K$ = INPUT$(1)
      file$ = DIR$("") 'use an empty string parameter to return a list of files!
      PRINT file$,
    LOOP UNTIL LEN(file$) = 0 'file list ends with an empty string
  END IF
NEXT

END

FUNCTION DIR$ (spec$)
CONST TmpFile$ = "DIR$INF0.INF", ListMAX% = 500 'change maximum to suit your needs
SHARED **DIRCount% 'returns file count if desired. MAY conflict with user's existing code**
STATIC Ready%, Index%, DirList$()
IF NOT Ready% THEN REDIM DirList$(ListMAX%): Ready% = -1 'DIM array first use
IF spec$ > "" THEN 'get file names when a spec is given
  SHELL _HIDE "DIR " + spec$ + " /b > " + TmpFile$
  Index% = 0: DirList$(Index%) = "": ff% = FREEFILE
  OPEN TmpFile$ FOR APPEND AS #ff%
  size& = LOF(ff%)
  CLOSE #ff%
  IF size& = 0 THEN KILL TmpFile$: EXIT FUNCTION
  OPEN TmpFile$ FOR INPUT AS #ff%
  DO WHILE NOT EOF(ff%) AND Index% < ListMAX%
    Index% = Index% + 1
    LINE INPUT #ff%, DirList$(Index%)
  LOOP
  DIRCount% = Index% 'SHARED variable can return the file count
  CLOSE #ff%
  KILL TmpFile$
ELSE IF Index% > 0 THEN Index% = Index% - 1 'no spec sends next file name
END IF
DIR$ = DirList$(Index%)
END FUNCTION 

```
<sub>Code by Ted Weissgerber</sub>

> *Explanation:* The function will verify that a file exists (even if it is empty) by returning it's name or it returns an empty string if no file exists. It can return a list of file names by using an empty string parameter("") after sending a wildcard spec to get the first file name. The number of file names found is returned by using the SHARED variable, **DIRCount%**. Unlike the PDS DIR$ function, **it MUST use an empty string parameter until QB64 supports optional parameters!** The function does NOT delete empty files.

## See Also

* [VB Procedures](VB-Procedures)
