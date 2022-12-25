The [_COMMANDCOUNT](_COMMANDCOUNT) function returns the number or arguments passed from the command line to the [COMMAND$](COMMAND$) function.

## Syntax

> result& = [_COMMANDCOUNT](_COMMANDCOUNT)

## Description

* The function returns the number of arguments passed from the command line to a program when it's executed.  
* Arguments are spaced as separate numerical or text values. Spaced text inside of quotes is considered as one argument. 
* In C, this function would generally be regarded as 'argc' when the main program is defined as the following: **int main(int argc, char *argv[])**

## Example(s)

The code below gets the number of parameters passed to our program from the command line with _COMMANDCOUNT: 

```vb

limit = _COMMANDCOUNT
FOR i = 1 TO limit
    PRINT COMMAND$(i)
NEXT

```

> *Explanation:* If we start *ThisProgram.exe* from the command window with **ThisProgram -l "loadfile.txt" -s "savefile.txt"**, the _COMMANDCOUNT would be 4, "-l", "loadfile.txt", "-s", "savefile.txt" command arguments passed to the program, which we could then read separately with COMMAND$(n).

## See Also

* [COMMAND$](COMMAND$)
* [SHELL](SHELL)
