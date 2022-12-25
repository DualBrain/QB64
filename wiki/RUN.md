**RUN** is a control flow statement that clears and restarts the program currently in memory or executes another specified program.

The multi-modular technique goes back to when QBasic and QuickBASIC had module size constraints. In QB64 it has been implemented so that that older code can still be compiled, though **it is advisable to use single modules for a single project (not counting [$INCLUDE]($INCLUDE) libraries), for ease of sharing and also because the module size constraints no longer exist.**

## Syntax

> **RUN** [{*line_number* | *filespec$*}] [*command_parameter(s)*]

## Parameter(s)

* *line number* specifies a line number in the main module code. 
* An optional *filespec* specifies a program to load into memory and run. 
    * BAS or EXE extensions are assumed to be the same as the calling module's extension, EXE or BAS (QBasic only).
    * *file names specs* with other extensions must use the full filename. No extension requires a dot.
* In **QB64** *command line parameters* can follow the program file name and be read using the [COMMAND$](COMMAND$) function later.

## Usage

* The starting [line number](line-number) MUST be one used in the main module code, even if RUN is called from within a SUB or FUNCTION.
* If no line number is given the currently loaded program runs from the first executable line.
* In **QB64** RUN can open any kind of executable program and provide case sensitive program specific parameters. 
  * Recommended practice to run external programs is to use [SHELL](SHELL).
* RUN closes all open files and closes the invoking program module before the called program starts.
* RUN resets the [RANDOMIZE](RANDOMIZE) sequence to the starting [RND](RND) function value.
* **Note: Calling RUN repeatedly may cause a stack leak in QB64 if it is called from within a [SUB](SUB) or [FUNCTION](FUNCTION). Avoid when possible.**

## Example(s)

Shows how RUN can reference multiple line numbers in the main module code. No line number executes first code line.

```vb

PRINT " A", " B", " C", " D"
10 A = 1
20 B = 2
30 C = 3
40 D = 4
50 PRINT A, B, C, D
60 IF A = 0 THEN 70 ELSE RUN 20    'RUN clears all values
70 IF B = 0 THEN 80 ELSE RUN 30
80 IF C = 0 THEN 90 ELSE RUN 40
90 IF D = 0 THEN 100 ELSE RUN 50
100 PRINT
INPUT "Do you want to quit?(Y/N)", quit$
IF UCASE$(quit$) = "Y" THEN END ELSE RUN  'RUN without line number executes at first code line

``` 

```text

A       B       C       D
1       2       3       4
0       2       3       4
0       0       3       4
0       0       0       4
0       0       0       0

Do you want to quit?(Y/N)_

```

## See Also
 
* [CHAIN](CHAIN), [SHELL](SHELL)
* [COMMAND$](COMMAND$)
