The **&O** prefix denotes that an integer value is expressed in an Octal base 8 format.

## Syntax 

> a& = &O12345671234

* The base eight numbering system only uses octal digit values of 0 to 7.
* Leading zero values **can** be omitted as they add nothing to the return value.
* Decimal values returned can be any **signed** [INTEGER](INTEGER), [LONG](LONG) integer, or [_INTEGER64](_INTEGER64) value so use those type of variables when converting directly as shown above. The program ["overflow"](ERROR-Codes) error limits are listed as:
    * [INTEGER](INTEGER): 6 octal digits or a decimal value range from -32,768 to 32,767
    * [LONG](LONG): 11 octal digits or a decimal value range from -2,147,483,648 to 2,147,483,647
    * [_INTEGER64](_INTEGER64): 22 octal digits or decimal values from -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807.
* [LONG](LONG) Octal values can be expressed by appending &amp; after the number. Example: &O100000& = 32768

## Example(s)

*Example:* The maximum octal values of decimal value -1 in each numerical type are:

```vb

c&& = -1: d& = -1: e% = -1: f%% = -1
oc$ = OCT$(f%%)
PRINT "Max octal _BYTE = "; oc$; " with"; LEN(oc$); "digits ="; VAL("&O" + oc$)
oc$ = OCT$(e%)
PRINT "Max octal INTEGER = "; oc$; " with"; LEN(oc$); "digits ="; VAL("&O" + oc$)
oc$ = OCT$(d&amp;)
PRINT "Max octal LONG = "; oc$; " with"; LEN(oc$); "digits ="; VAL("&O}}" + oc$)
oc$ = OCT$(c&amp;&amp;)
PRINT "Max octal _INTEGER64 = "; oc$; " with"; LEN(oc$); "digits ="; VAL("&O" + oc$)

```

```text

Max octal _BYTE = 377 with 3 digits = 255
Max octal INTEGER = 177777 with 6 digits = 65535
Max octal LONG = 37777777777 with 11 digits = 4294967295
Max octal _INTEGER64 = 1777777777777777777777 with 22 digits =-1

```

## See Also

* [OCT$](OCT$), [HEX$](HEX$), [VAL](VAL)
* [&B](&B) (binary), [&H](&H) (hexadecimal)
* [Base Comparisons](Base-Comparisons)
