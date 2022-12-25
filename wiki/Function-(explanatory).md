A BASIC **function** is a procedure that returns one value in it's name. A function can be used as a statement [argument](argument) or be assigned to a [variable](variable).

User-defined functions are possible and behave the same way, with the only exception that user-defined functions cannot currently have optional [argument](argument)s.

Altering the variables that are used as arguments within the function will cause the same changes to the variables outside of the function. This also applies to [Sub (explanatory)](Sub-(explanatory)). Variables that are not arguments of the function will not be changed if used within the function unless they are [SHARED](SHARED). See the second example of [sub (explanatory)](sub-(explanatory)) for a demonstration of this (it functions the same way in subs).

The arguments of a function need to be enclosed with parantheses (unless there are no arguments).

Function and [Sub (explanatory)](Sub-(explanatory)) procedures are placed after the main code body.

## Example(s)

Some BASIC functions.

```vb

a = ABS(-1)
b = INT(2.54)
c = CINT(2.54)
PRINT "ABS(-1) gives"; a
PRINT "INT(2.54) gives"; b
PRINT "CINT(2.54) gives"; c
PRINT "ATN(1) * 4 gives"; ATN(1) * 4

```

User-defined function.

```vb

d = dividebyhalf(4)

PRINT "dividebyhalf(4) gives"; d

FUNCTION dividebyhalf (number)
IF number <> 0 THEN
    half = number / 2
ELSE
    half = 0
END IF
dividebyhalf = half
END FUNCTION

```

> *Explanation:* The calculated value is assigned to the name of the function. When calculations require several changes, use an intermediary variable. Then assign that value to the function name.

## See Also

* [SUB](SUB). [FUNCTION](FUNCTION)
* [Statement](Statement), [Sub (explanatory)](Sub-(explanatory))
* [Argument](Argument)
