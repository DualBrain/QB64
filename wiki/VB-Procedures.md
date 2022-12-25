QB64 is created to be compatible with Quick Basic 4.5 only as it was the most popular version. The following sub-procedures have been created to do things that were available in Visual Basic:

## CURRENCY

### MKC$

> VB could use the CURRENCY variable type and had the MKC$ function to convert those values to [ASCII](ASCII) string values. QB64 can convert [_FLOAT](_FLOAT) currency values to **8 byte** strings using [_MK$](_MK$) with [_INTEGER64](_INTEGER64) values:

```vb

SCREEN 12
value = 12345.6789 '    any currency value with up to 4 decimal point places
_PRINTSTRING (1, 50), "[" + MKC$(value) + "]" ' show ASCII string value

END

FUNCTION MKC$ (CurrVal AS _FLOAT) 'converts currency amount to currency string
  DIM CVal AS _INTEGER64
  CVal = CurrVal * 10000
  MKC = _MK$(_INTEGER64, CVal)
END FUNCTION 

```

> The currency amount must be multiplied by 10000 before it is converted to the 8 byte [ASCII](ASCII) string value.

### CVC

> VB also had the CVC function to convert MKC$ currency **8 byte** string values back to currency amounts. QB64 can use [_CV](_CV) with [_INTEGER64](_INTEGER64) to convert those values back to [_FLOAT](_FLOAT) currency values:

```vb

SCREEN 12
DIM currency AS STRING * 8
OPEN "Currency.bin" FOR BINARY AS #1 'binary file with MKC$ values created by PDS or VB
GET #1, , currency
CLOSE #1

_PRINTSTRING (1, 10), "[" + currency + "]" 'show ASCII string value from file

_PRINTSTRING (1, 30), STR$(CVC##(currency))

END

FUNCTION CVC## (CurrStr AS STRING) 'converts currency string to currency amount
  DIM CV AS _INTEGER64
  CV = _CV(_INTEGER64, CurrStr)
  CVC = CV / 10000
END FUNCTION 

```

> The currency amount must be divided by 10000 to create up to 4 decimal point places.

### PUT

> Currency values can be [PUT](PUT) directly into [BINARY](BINARY) or [RANDOM](RANDOM) files using an [_INTEGER64](_INTEGER64) variable value.

```vb

DIM curr AS _INTEGER64, currency AS _FLOAT

currency = 9876.543
curr = currency * 10000 ' multiply currency value by 10000

OPEN "currency.bin" FOR BINARY AS #1 ' a binary file to hold VB currency values
PUT #1, , curr
CLOSE #1

END 

```

### GET

> If currency values are [PUT](PUT) directly into a [BINARY](BINARY) or [RANDOM](RANDOM) file, [_INTEGER64](_INTEGER64) can [GET](GET) them directly. Then divide by 10 ^ 4: 

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

## See Also

* [PDS (7.1) Procedures](PDS-(7.1)-Procedures)
