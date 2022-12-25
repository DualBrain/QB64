The [ENVIRON](ENVIRON) statement is used to temporarily set or change an environmental string value.

## Syntax

> [ENVIRON](ENVIRON) stringExpression$

## Description

* The stringExpression$ must include the environmental parameter ID and the setting:
  * Using an **=** sign: [ENVIRON](ENVIRON) "parameterID=setting"
  * Using a space: [ENVIRON](ENVIRON) "parameterID setting"
* If the parameter ID did not previously exist in the environmental string table, it is appended to the end of the table.
* If a parameter ID did exist, it is deleted and the new value is appended to end of the list.
* The [_ENVIRONCOUNT](_ENVIRONCOUNT) function returns the number of key/value pairs that currently exist.
* Any changes made at runtime are discarded when your program ends.

## See Also

* [ENVIRON$](ENVIRON$), [_ENVIRONCOUNT](_ENVIRONCOUNT)
* [Windows Environment](Windows-Environment)
