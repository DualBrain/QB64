**STRING** variables or literal values are one byte per character length text or [ASCII](ASCII) characters.

## Syntax

> [**DIM**](DIM) variable [**AS**](AS) **STRING** [* byte_length]

* *Byte length* is optional in [DIM](DIM) statements, but is required in [TYPE](TYPE) definitions as a literal or [CONST](CONST) [INTEGER](INTEGER) value.
* Literal strings are defined by quotation marks on each end. The quotes will not [PRINT](PRINT) to the screen.
* Quotation marks cannot be placed inside of literal string values! Use [CHR$](CHR$)(34) to display " quotes.
* Semicolons and commas outside of the string can be used to combine strings in a [PRINT](PRINT) statement only. 
* [LEN](LEN) determines the number of bytes and number of string characters that are in a particular string.
* Literal string ends are designated by quotation marks such as: "text". Use [CHR$](CHR$)(34) to add quotes to string values.
* Variable suffix type definition is $ such as: text$.
* STRING values are compared according to the [ASCII](ASCII) code values from left to right until one string code value exceeds the other.

> **Creating a fixed length STRING variable**

  * Variable$ = " " ' 1 space creates a one [_BYTE](_BYTE) string length in a procedure(not fixed)
  * Variable$ = SPACE$(n%) ' defined as a n% length string in a procedure(not fixed)
  * [DIM](DIM) variable AS STRING * n% ' fixed string length cannot be changed later
  * Variable AS STRING * n% ' fixed string length in a [SUB](SUB) parameter or [TYPE](TYPE) definition.
  * [CONST](CONST) variables can also be used after the constant value is defined.
  * Fixed length strings may not be initialized with spaces and may contain only a series of CHR$(0) at program start.

> **QB64 fixed length string type suffixes**

* A number after the string variable name $ suffix denotes the fixed string length: **X$2** denotes a 2 byte string.

  * **String [Concatenation](Concatenation) (addition)**

> *Must be used when defining a string variable's literal value!*

* Concatenation uses the + addition symbol to add literal or variable parts to a string variable value.
* Quotation marks cannot be added. Use [CHR$](CHR$)(34) as quotes are used to define the ends of strings.
* Numerical values added must be converted to strings in string variable definitions. See the [STR$](STR$) function.
* Concatenation can be used in PRINT statements along with semicolons and commas used by PRINT ONLY.
* Semicolons or commas outside of quotes cannot be used to make a string variable's literal string value!

## Example(s)

Using a string type suffix with a fixed length byte size in QB64 only. The number designates the fixed string length.

```vb

var$5 = "1234567"

PRINT var$5 

```

```text

12345

```

> *Note:* The suffix must keep the same byte length or it is considered a different string variable with a different value!

Creating a string variable value by adding variable and literal string values. This procedure is called string [concatenation](concatenation).

```vb

age% = 10
a$ = "I am " + CHR$(34) + LTRIM$(STR$(age%)) + CHR$(34) + " years old."
b$ = "How old are you?"
question$ = a$ + SPACE$(1) + b$
PRINT question$

```

```text

I am "10" years old. How old are you? 

```

> *Note:* Since quotation marks are used to denote the ends of literal strings, [CHR$](CHR$)(34) must be used to place quotes inside them.

How QB64 string type suffixes can fix the length by adding a number of bytes after it.

```vb

strings$5 = "Hello world"

PRINT strings$5 

```

```text

Hello

```

STRING values can be compared by the [ASC](ASC) code value according to [ASCII](ASCII).

```vb

PRINT "Enter a letter, number or punctuation mark from the keyboard: ";
valu$ = INPUT$(1)
PRINT value$
value1$ = "A"
value2$ = "m"
value3$ = "z"

SELECT CASE value$
  CASE value1$: PRINT "A only"
  CASE value1$ TO value2$: PRINT "B to m" 'A is already evaluated
  CASE value1$, value2$, value3$: PRINT "z only" 'A and m are already evaluated
  CASE IS > value2$: PRINT "greater than m but not z" 'z is already evaluated
  CASE ELSE: PRINT "other value" 'key entry below A including all numbers
END SELECT 

```

> *Notes:* [STRING](STRING) values using multiple characters will be compared by the [ASCII](ASCII) code values sequentially from left to right. Once the equivalent code value of one string is larger than the other the evaluation stops. This allows string values to be compared and sorted alphabetically using [Greater Than](Greater-Than) or [Less Than](Less-Than) and to [SWAP](SWAP) values in [arrays](arrays) irregardless of the string lengths.

## See Also
 
* [DIM](DIM), [DEFSTR](DEFSTR) 
* [CHR$](CHR$), [ASC](ASC)
* [LEFT$](LEFT$), [RIGHT$](RIGHT$), [MID$](MID$)
* [LTRIM$](LTRIM$), [RTRIM$](RTRIM$) 
* [LCASE$](LCASE$), [UCASE$](UCASE$) 
* [STR$](STR$) (decimal to string value)
* [HEX$](HEX$) (decimal to [&H](&H) string value)
* [MKI$](MKI$), [MKL$](MKL$), [MKS$](MKS$), [MKD$](MKD$), [_MK$](_MK$) (numerical to [ASCII](ASCII) string)
* [CVI](CVI), [CVL](CVL), [CVS](CVS), [CVD](CVD), [_CV](_CV) ([ASCII](ASCII) string to numerical value)
* [LEN](LEN), [VAL](VAL) (function converts string to numerical value)
* [ASCII](ASCII), [DRAW](DRAW)
* [PRINT](PRINT), [PRINT USING](PRINT-USING), [WRITE](WRITE)
