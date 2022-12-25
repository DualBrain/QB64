The **RSET** statement right-justifies a string according to length of the string expression. 

## Syntax

> RSET string_variable = string_expression

* If the *string_expression* is longer than a fixed length string variable the value is truncated from the right side in [LSET](LSET) or RSET.
* If the *string_expression* is smaller than the fixed length, spaces will occupy the extra positions in the string. 
* RSET can be used with a [FIELD](FIELD) or [TYPE](TYPE) string definition to set the buffer position before a [PUT](PUT).

## Example(s)

```vb

CLS
DIM thestring AS STRING * 10
PRINT "12345678901234567890"
RSET thestring = "Hello!"
PRINT thestring
anystring$ = SPACE$(20)
RSET anystring$ = "Hello again!"
PRINT anystring$
RSET thestring = "Over ten characters long"
PRINT thestring 

```

```text

12345678901234567890
    Hello!
        Hello Again!
Over ten c

```

> *Explanation:* Notice how "Hello!" ends at the tenth position because the length of *thestring* is 10. When we used SPACE$(20) the length of *anystring$* became 20 so "Hello Again!" ended at the 20th position. That is right-justified. The last line "Over ten c" is truncated as it didn't fit into *thestring**s length of only 10 characters.

## See Also
 
* [RTRIM$](RTRIM$), [FIELD](FIELD)
* [LSET](LSET), [LTRIM$](LTRIM$)
* [PUT](PUT), [GET](GET)
