The [AS](AS) keyword defines a variable data [Variable Types](Variable-Types).

## Description

* AS defines the variable or array type AS [_BIT](_BIT), [_BYTE](_BYTE), [INTEGER](INTEGER), [LONG](LONG), [_INTEGER64](_INTEGER64), [SINGLE](SINGLE), [DOUBLE](DOUBLE), [_FLOAT](_FLOAT) or [STRING](STRING).
* Specifies a variable's [Variable Types](Variable-Types) in a declarative statement or parameter list using:
  * [DIM](DIM) or [REDIM](REDIM)
  * [DECLARE LIBRARY](DECLARE-LIBRARY)
  * [SUB](SUB)
  * [FUNCTION](FUNCTION)
  * [TYPE](TYPE)
  * [SHARED](SHARED)
  * [COMMON SHARED](COMMON-SHARED)
  * [STATIC](STATIC)

### Details
* Specifies a **[parameter](parameter)** variable's type in a [SUB](SUB) or [FUNCTION](FUNCTION) procedure. **Cannot be used to define a function's [Variable Types](Variable-Types)**
* Specifies an element's type in a user-defined data [TYPE](TYPE).
* Assigns a file number to a file or device in an [OPEN](OPEN) statement.
* Specifies a field name in a random-access record (see [FIELD](FIELD))
* Specifies a new file name when you rename a file (see [NAME](NAME))
* **NOTE: Many QBasic keywords can be used as variable names if they are created as [STRING](STRING)s using the suffix **$**. You cannot use them without the suffix, use a numerical suffix or use [DIM](DIM), [REDIM](REDIM), [_DEFINE](_DEFINE), [BYVAL](BYVAL) or [TYPE](TYPE) variable [AS](AS) statements.**

## See Also

* [DIM](DIM), [REDIM](REDIM)
* [_DEFINE](_DEFINE) 
* [BYVAL](BYVAL), [TYPE](TYPE)
* [Variable Types](Variable-Types)
