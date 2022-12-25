Any [Expression](Expression), including [CONST](CONST) and [Variable](Variable) all have an associated type to describe their value. QB64 has various built-in data types used to represent number and text values. [#Numeric types](#Numeric types) represent number values, while [#String types](#String types) represent text values.

## Numeric types

QB64 supports several numeric types, capable of representing a wide range of numbers. There are two kinds of numeric data type: *integer types* and *floating-point types*.

### Integer types

Integer types represent integer (whole number) values, such as 1 and 100. They are divided into two flavors: *signed* and *unsigned*.

#### Signed Integer types

Signed integers can represent positive and negative integer (whole number) values, such as 3, 10 and -16. These values are stored as a series of bits in [two's complement form](http://en.wikipedia.org/wiki/Two's_complement), a common representation that makes them both straightforward and efficient to perform calculations with.

Signed integers are typically used in simple mathematical equations.

The range of values that these types can represent is based on their size, in bits; the greater number of bits, the larger positive and lesser negative value the types can represent.

The signed integer types are: [_BYTE](_BYTE), [INTEGER](INTEGER), [LONG](LONG), [_INTEGER64](_INTEGER64) and [_OFFSET](_OFFSET)

```vb

DIM n AS INTEGER
n = -1
PRINT n

```

```text

-1

```

#### Unsigned Integer types

Unsigned integers can represent positive integer values only, such as 3, 10 and 16. These values are also stored as a series of bits, but unlike signed integers, all of the bits contribute to their value. Thus, these types can represent larger positive integer values than their signed counterparts.

Unsigned integers are typically used to represent a simple quantity, like a *count* or a *length*. They are also often used as *bit masks*, where certain bits that make up the value represent separate information (such as the state of one or more *flags*).

Types: [_UNSIGNED](_UNSIGNED) [_BYTE](_BYTE), [_UNSIGNED](_UNSIGNED) [INTEGER](INTEGER), [_UNSIGNED](_UNSIGNED) [LONG](LONG), [_UNSIGNED](_UNSIGNED) [_INTEGER64](_INTEGER64), [_UNSIGNED](_UNSIGNED) [_OFFSET](_OFFSET)

```vb

' display the largest value representable by an _UNSIGNED INTEGER:
DIM n AS _UNSIGNED INTEGER
n = -1
PRINT n

```

```text

65535

```

#### _OFFSET Integer types

Offset Integer types can be any byte size integer value that can be used to designate pointer offset positions in memory. DO NOT TRANSFER offset values to other Integer types!

### Floating-point types

Floating-point types can represent both positive and negative number values, as well as fractional number values, such as 1.2 and -34.56.

Floating-point types are used in mathematical equations where fractional precision is important, such as trigonometry.

The floating-point types are: [SINGLE](SINGLE), [DOUBLE](DOUBLE) and [_FLOAT](_FLOAT).

```vb

f! = 76.0
c! = (5.0 / 9.0) * (f! - 32.0)

PRINT f! ; "degrees Fahrenheit is" ; c! ; "degrees Celcius."

```

```text

76 degrees Fahrenheit is 24.44444 degrees Celcius.

```

## String types

QB64 has built-in support for strings, which are contiguous sequences of characters represented as [_UNSIGNED](_UNSIGNED) [_BYTE](_BYTE) values. Strings are usually used to store and manipulate text, but can also be used as a general storage area for arbitrary data (like a binary file).

Strings have a property called *length*, which is the number of characters currently stored in the string, and QB64 supports two kinds of string types based on this property: *variable-length strings* and *fixed-length strings*.

### Variable-length strings

Variable length strings are undefined length string variables. Fixed length strings MUST be defined in a program before they are used. Undefined strings can be up to 32767 characters in QBasic. 

```vb

message$ = "Hello"
message$ = message$ + " world!" 'add to string variables using string concatenation only! 
PRINT message$

```

```text

 Hello world!

```

### Fixed-length strings

Fixed length strings must be defined in a [DIM](DIM) statement, [SUB](SUB) or [FUNCTION](FUNCTION) parameter or [TYPE](TYPE) definition. The designated multiple is the maximum number of [STRING](STRING) character bytes that the variable or [Arrays](Arrays) can hold. Excess bytes will not be included. No error is created.

```vb

DIM message AS STRING * 5
message$ = "Hello"
message$ = message$ + " world!"
PRINT message$

```

```text

Hello

```

## Data type limits

The following table lists the numerical and string data types, their type suffix symbol, and the range of the values they can represent:

### Numerical Types

| Type Name | Symbol | Minimum Value | Maximum Value | Size (Bytes) |
| --------- | ------ | ------------- | ------------- | ------------ |
| _BIT | ` | -1 | 0 | 1/8 |
| _BIT * n | `n | -128 | 127 | n/8 |
| _UNSIGNED _BIT | ~` | 0 | 1 | 1/8 |
| _BYTE | %% | -128 | 127 | 1 |
| _UNSIGNED _BYTE | ~%% | 0 | 255 | 1 |
| INTEGER | % | -32,768 | 32,767 | 2 |
| _UNSIGNED INTEGER | ~% | 0 | 65,535 | 2 |
| LONG | & | -2,147,483,648 | 2,147,483,647 | 4 |
| _UNSIGNED LONG | ~& | 0 | 4,294,967,295 | 4 |
| _INTEGER64 | && | -9,223,372,036,854,775,808 | 9,223,372,036,854,775,807 | 8 |
| _UNSIGNED _INTEGER64 | ~&& | 0 | 18,446,744,073,709,551,615 | 8 |
| SINGLE | ! or none | -2.802597E-45 | +3.402823E+38 | 4 |
| DOUBLE | # | -4.490656458412465E-324 | +1.797693134862310E+308 | 8 |
| _FLOAT | ## | -1.18E−4932 | +1.18E+4932 | 32 (10 used) |
| _OFFSET | %& | -9,223,372,036,854,775,808 | 9,223,372,036,854,775,807 | Use LEN |
| _UNSIGNED _OFFSET | ~%& | 0 | 18,446,744,073,709,551,615 | Use LEN |
| _MEM | none | combined memory variable type | N/A | Use LEN |

*Note: For the floating-point numeric types [SINGLE](SINGLE) (default when not assigned), [DOUBLE](DOUBLE) and [_FLOAT](_FLOAT), the minimum values represent the smallest values closest to zero, while the maximum values represent the largest values closest to ±infinity. OFFSET dot values are used as a part of the [_MEM](_MEM) variable type in QB64 to return or set the position in memory.*

### String Text Type

| Type Name | Symbol | Minimum Length | Maximum Length | Size (Bytes) |
| --------- | ------ | -------------- | -------------- | ------------ |
| STRING | $ | 0 | 2,147,483,647 | Use LEN |
| STRING * *n* | $n | 1 | 2,147,483,647 | n |

*Note: For the fixed-length string type [STRING * n](STRING), where n is an integer length value from 1 (one) to 2,147,483,647.*
