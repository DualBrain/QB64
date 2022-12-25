**Line numbers** or **line labels** are used to denote [GOTO](GOTO), [RUN](RUN) or [GOSUB](GOSUB) procedure lines or all code lines as in GW Basic.

## Number Syntax 

> **10** [GOTO](GOTO) {line number| line label}

## Label Syntax 

> **PictureData:**
>   [DATA](DATA) 0, 0, 12, 12, 14, 12, 12, 0, 0

* Line numbers are used to denote a specific line of code. No colon required.
* Line labels are used to denote a specific line of code with a [colon](colon) when separating it from a code line.
* [GOSUB](GOSUB) or [DATA](DATA) block line labels can be numerical or text line names. [RESTORE](RESTORE) can use the label to reuse data. 
* [GOSUB](GOSUB) blocks require a [RETURN](RETURN) to return to the original call or to a line label or number to return to.
* [ON ERROR](ON-ERROR) [GOTO](GOTO) line label or number calls use [RESUME](RESUME) [NEXT](NEXT) or a line label or number to resume to.
* [GOTO](GOTO) or [RUN](RUN) can refer to a specific numerical line number or text line label.
* Line numbers are no longer required in QB or QB64 except for [GOSUB](GOSUB), [RUN](RUN) or [GOTO](GOTO) situations.
* Line numbers and labels are not allowed after SUB/FUNCTION blocks. They are allowed inside SUB/FUNCTIONS though.

## See Also

* [GOTO](GOTO), [RUN](RUN) 
* [GOSUB](GOSUB), [RETURN](RETURN)
* [DATA](DATA), [RESTORE](RESTORE)
* [ON ERROR](ON-ERROR), [RESUME](RESUME), [NEXT](NEXT)
* [Line Number](Line-Number)
