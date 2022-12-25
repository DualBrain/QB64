Optional **parameters** are values passed to [SUB](SUB) and [FUNCTION](FUNCTION) procedures. They are always enclosed in parenthesis inside the procedures.

## Syntax

> [SUB](SUB) SubName[**(*parameter*** [[AS](AS) [Type](Type)][**, ...**]**)**]

> [FUNCTION](FUNCTION) FunctionName[**(*parameter*** [[AS](AS) [Type](Type)][**, ...**]**)**]

> [CALL](CALL) SubName[**(*parameter***[**, ...**]**)**]

> SubName [***parameter***][**, ...**]

> FunctionName[**(*parameter***[**, ...**]**)**]

## Usage

* Inside of sub-procedures, multiple parameters variables are separated by [comma](comma)s in a list and always enclosed inside of parenthesis.
* When [CALL](CALL) is used to call a [SUB](SUB) procedure all parameters must be enclosed inside parenthesis too.
* When just the procedure name is used to call a [SUB](SUB), the parameters are listed after the name. Multiple parameters require commas.
* [FUNCTION](FUNCTION) procedure parameters are always enclosed in parenthesis. Multiple parameters are separated by commas.
* Parameters can be literal values or variables when a [SUB](SUB) procedure is called or a [FUNCTION](FUNCTION) procedure is referenced.
* To pass parameter variables [BYVAL](BYVAL) to protect the value in a call, parenthesis can be placed around each variable name also.
* To pass [arrays](arrays) to a sub-procedure use empty brackets after the name or indicate the index in the call.

## See Also

* [SUB](SUB)
* [FUNCTION](FUNCTION)
* [CALL](CALL)
