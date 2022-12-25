The [VAL](VAL) Function returns the decimal numerical equivalent value of a [STRING](STRING) numerical value.

## Syntax

> value = [VAL](VAL)(string_value$)

## Description

* VAL converts string numbers to numerical values including decimal point values and prefixed "[&H](&H)" hexadecimal, "[&O](&O)" octal. 
* VAL conversion stops at non-numeric characters except for letter "D" or "E" exponential notation values.
> String values with "D" and "E" letters between numbers may be converted also! EX: **VAL("9D4") = 90000**
* If the first string character is not a number VAL returns 0. VAL may return erratic values with "%" or "&" starting characters. 
* Hexadecimal [HEX$](HEX$) string values with the "[&H](&H)" prefix can be converted to a decimal value with digits 0 to 9 and letters A to F, like; dec = VAL("&H"+hexvar$). 
* Octal [OCT$](OCT$) string values with the "[&O](&O)" prefix can be converted to a decimal value with digits from 0 to 7 only.
* Presently VAL **cannot** convert QB64 binary [&B](&B) prefixed strings from binary to decimal in **QB64**.
* For character values of [ASCII](ASCII) data use [ASC](ASC) to get the value. 
* In QB64 use an [INTEGER](INTEGER) return variable to hold integer values  returned by VAL [HEX$](HEX$) strings: **value% = VAL("&HFFFF") = -1**

## Example(s)

Differences in values returned with QBasic and QB64:

```vb

PRINT VAL("&H") '203 in QB, 0 in QB64
PRINT VAL("&HFFFF") ' -1 QB, 65535 in QB64
PRINT VAL("&HFFFF&") '65535 in both 

```

> *Explanation:* A quirk in QBasic returned VAL values of 203 for "&" and "&H" that was never fixed until PDS(7.1).

Converting a string with some number characters

```vb

 text$ = "1.23Hello"
 number! = VAL(text$)
 PRINT number! 

```

```text

1.23

```

Converting literal and variable [STRING](STRING) values to numerical values.

```vb

a$ = "33"
PRINT VAL("10") + VAL(a$) + 1 

```

```text

44

```

> *Explanation:* 10 + 33 + 1 = 44, the strings were converted to values.

> You have to convert the string to values in order to use them in a mathematical expression also since mixing strings with numbers isn't allowed. VAL will stop at a text letter so VAL("123G56) would return 123.

> If VAL wasn't used the program would break with an error, as you can't add the value 1 to a string, if the 1 was a string ("1") then the program would return "10331", but now since we used VAL, the numbers were added as they should.

Converting a hexadecimal value to decimal value using HEX$ with VAL.

```vb

decnumber% = 96
hexnumber$ = "&H" + HEX$(decnumber%)  'convert decimal value to hex and add hex prefix
PRINT hexnumber$
decimal% = VAL(hexnumber$)
PRINT decimal% 

```

```text

&H60
 96

```

> *Explanation:* [HEX$](HEX$) converts a decimal number to hexadecimal, but [VAL](VAL) will only recognize it as a valid value with the "&H" prefix. Especially since hexadecimal numbers can use "A" through "F" in them. Create a converter function from this code!

## See Also

* [STR$](STR$), [HEX$](HEX$)
* [OCT$](OCT$), [ASC](ASC)
