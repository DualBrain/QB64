The **RESUME** statement is used with **NEXT** or a line number or label in an error handling routine.

## Syntax

> [RESUME](RESUME) {**NEXT**|lineLabel|lineNumber}

## Description

* **NEXT** returns execution to the code immediately following the error.
* A lineLabel or lineNumber is the code line to return to after an error.
* If the line label or number is omitted or the line number = 0, the code execution resumes at the code that created the original error.
* [RESUME](RESUME)can only be used in ERROR handling routines. Use [RETURN](RETURN) in normal [GOSUB](GOSUB) procedures.

## See Also

* [ON ERROR](ON-ERROR), [ERROR](ERROR)
* [RETURN](RETURN), [ERROR Codes](ERROR-Codes)
* [FOR...NEXT](FOR...NEXT) (counter loop)
