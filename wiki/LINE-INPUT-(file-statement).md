The **LINE INPUT #** file statement reads an entire line from a text file into a string variable.

## Syntax

> **LINE INPUT** **#**fileNumber&**,** *stringVariable$*

## Parameter(s)

* fileNumber& is the [INTEGER](INTEGER) number of the file previously opened with the [OPEN](OPEN) statement.
* stringVariable$ holds the text line read from the file.

## Description

* Reads a file using the fileNumber& [OPEN](OPEN)ed in the [INPUT (file mode)](INPUT-(file-mode)) or [BINARY](BINARY) file mode as one file line text string.
* **NOTE:** [LINE INPUT (file statement)](LINE-INPUT-(file-statement)) will work faster in [BINARY](BINARY) mode than in [INPUT (file mode)](INPUT-(file-mode)) mode.
  * Using **LINE INPUT #** in [BINARY](BINARY) mode is possible in **version 1.000 and up**
* Can be used with [EOF](EOF) to count the number of lines of data (records) in a file using a loop.
* Use the [EOF](EOF) function to avoid going past the end of a file and creating an error.
* **LINE INPUT #** can even retain the original quotation marks in text.
* **Note: QB64** will not remove CHR$(0) from the end of **LINE INPUT #** string return values like QBasic did.

## Error(s)

* **If an "Input past End of file" error occurs, check for CHR$(26) (end of file character) in the files being read.**
* **Warning: files must exist to be opened in **INPUT** mode. Use [_FILEEXISTS](_FILEEXISTS) to avoid program [ERROR Codes](ERROR-Codes).**

## Example(s)

Finding the number of filenames listed in a file to dimension an array to hold them.

```vb

REDIM FileArray$(100) 'create dynamic array
SHELL _HIDE "DIR /B *.* > D0S-DATA.INF"  
IF _FILEEXISTS("D0S-DATA.INF") THEN 
  OPEN "D0S-DATA.INF" FOR INPUT AS #1 
  DO UNTIL EOF(1)
    LINE INPUT #1, file$        'read entire text file line
    filecount% = filecount% + 1
  LOOP
  CLOSE #1
END IF
REDIM FileArray$(filecount%)
PRINT filecount% 

```

## See Also

* [OPEN](OPEN), [CLOSE](CLOSE)
* [INPUT (file mode)](INPUT-(file-mode)), [INPUT (file statement)](INPUT-(file-statement)), [INPUT$](INPUT$) (file input)
* [INPUT](INPUT), [LINE INPUT](LINE-INPUT), [INPUT$](INPUT$) (keyboard input)
* [_FILEEXISTS](_FILEEXISTS), [_DIREXISTS](_DIREXISTS)
* [FILELIST$](FILELIST$) (member-contributed function replacement for [FILES](FILES))
