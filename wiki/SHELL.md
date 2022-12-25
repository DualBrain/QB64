The [SHELL](SHELL) statement allows a program to run external programs or command line statements in Windows, macOS and Linux.

## Syntax

> [SHELL](SHELL) [DOSCommand$]

> [SHELL](SHELL) [**_DONTWAIT**] [**_HIDE**] [DOSCommand$]

## Description

* If the *DOSCommand$* [STRING](STRING) parameter isn't used, the "command console" is opened and execution is halted until the user closes it manually.
* If [_DONTWAIT](_DONTWAIT) is used, the **QB64** program doesn't wait for the SHELLed program/command to end.
* When the [_HIDE](_HIDE) action is used, the [_CONSOLE](_CONSOLE) window is hidden and screen info can be "redirected" (using redirection characters like >) to a file (recommended).
* Commands are external commands, according to the user's operating system, passed as [STRING](STRING) enclosed in quotes or string variables.
* Commands can be a mixture of [STRING](STRING) and string variables added together using the + [concatenation](concatenation) operator.
* Command text can be in upper or lower case. Use single spacing between items and options.
* **QB64** automatically uses CMD /C when using [SHELL](SHELL), but it is allowed in a command string. Note: CMD alone may lock up program.
* **Note: Some commands may not work without adding CMD /C to the start of the command line.**
* **QB64** program screens will not get distorted, minimized or freeze the program like QBasic full-screen modes would.
* **QB64** can use long path folder names and file names and [SHELL](SHELL) command lines can be longer than 124 characters.
* In Windows, use additional [CHR$](CHR$)(34) quotation marks around folder or file names that contain spaces.
* For other operating systems, both the quotation mark character and the apostrophe can be used to enclose a file name that contains spaces.
* **NOTE: Use [CHDIR](CHDIR) instead of CD as SHELL commands cannot affect the current program path.**

## QBasic

* **QBasic BAS files could be run like compiled programs without returning to the IDE when [SYSTEM](SYSTEM) was used to [END](END) them.**
* A user would invoke it with `SHELL "QB.EXE /L /RUN program.BAS"`

## Example(s)

When working with file or folder names with spaces, add quotation marks around the path and/or file name with [CHR$](CHR$)(34).

```vb

SHELL _HIDE "dir " + CHR$(34) + "free cell.ico" + CHR$(34) + " /b > temp.dir" 
SHELL "start Notepad temp.dir" ' display temp file contents in Notepad window 

```

> Contents of *temp.dir* text file:

```text

Free Cell.ico

```

Opening a Windows program (Notepad) to read or print a Basic created text file.

```vb

INPUT "Enter a file name to read in Notepad: ", filename$
SHELL "CMD /C start /max notepad " + filename$  ' display in Notepad full screen in XP or NT   

'SHELL "start /min notepad /p " + filename$ ' taskbar print using QB64 CMD /C not necessary

```

> *Explanation:* Notepad is an easy program to open in Windows as no path is needed. Windows NT computers, including XP, use CMD /C where older versions of DOS don't require any command reference. The top command opens Notepad in a normal window for a user to view the file. They can use Notepad to print it. The second command places Notepad file in the task-bar and prints it automatically. The filename variable is added by the program using proper spacing.

* **Start** is used to allow a Basic program to run without waiting for Notepad to be closed.
* **/min** places the window into the task-bar. **/max** is full-screen and no option is a normal window.
* Notepads **/p** option prints the file contents, even with USB printers.

Function that returns the program's current working path.

```vb

 currentpath$ = Path$ ' function call saves a path for later program use
 PRINT currentpath$

 FUNCTION Path$   
   SHELL _HIDE "CD > D0S-DATA.INF"   'code to hide window in **QB64**
   OPEN "D0S-DATA.INF" FOR APPEND AS #1  'this may create the file
        L% = LOF(1)          'verify that file and data exist
   CLOSE #1   
   IF L% THEN                       'read file if it has data
     OPEN "D0S-DATA.INF" FOR INPUT AS #1
     LINE INPUT #1, line$           'read only line in file
     Path$ = line$ + "\"            'add slash to path so only a filename needs added later
     CLOSE #1
   ELSE : Path = ""                 'returns zero length string if path not found
   END IF
   KILL "D0S-DATA.INF"              'deleting the file is optional
 END FUNCTION 

```

> *Explanation:* The **SHELL "CD"** statement requests the current working path. This info is normally printed to the screen, but the **>** pipe character sends the information to the DOS-DATA.INF file instead(**QB64** can use [_HIDE](_HIDE) to not display the DOS window). The function uses the [OPEN](OPEN) FOR [APPEND](APPEND) mode to check for the file and the data([INPUT (file mode)](INPUT-(file-mode)) would create an error if file does not exist). The current path is listed on one line of the file. The file is opened and [LINE INPUT (file statement)](LINE-INPUT-(file-statement)) returns one line of the file text. The function adds a "\" so that the Path$ returned can be used in another file statement by just adding a file name. Save the Path$ to another variable for later use when the program has moved to another directory.
> In **QB64** you can simply use the [_CWD$](_CWD$) statement for the same purpose of the example above.

Determining if a drive or path exists. Cannot use with a file name specification.

```vb

LINE INPUT "Enter a drive or path (no file name): ", DirPath$
IF PathExist%(DirPath$) THEN PRINT "Drive Path exists!" ELSE PRINT "Drive Path does not exist!"
END

FUNCTION PathExist% (Path$)
  PathExist% = 0
  IF LEN(Path$) = 0 THEN EXIT FUNCTION 'no entry
  IF LEN(ENVIRON$("OS")) THEN CMD$ = "CMD /C " ELSE CMD$ = "COMMAND /C "
  SHELL _HIDE CMD$ + "If Exist " + Path$ + "\nul echo yes > D0S-DATA.INF"
  OPEN "D0S-DATA.INF" FOR APPEND AS #1
  IF LOF(1) THEN PathExist% = -1             'yes will be in file if path exists
  CLOSE #1
  KILL "D0S-DATA.INF"               'delete data file optional
END FUNCTION 

```

> *Explanation: IF Exist* checks for the drive path. *\Nul* allows an empty folder at end of path. *Echo* prints **yes** in the file if it exists.
> In **QB64** you can simply use the [_FILEEXISTS](_FILEEXISTS) statement for the same purpose of the example above.

*Snippet 1:* When looking for **printers** this command gives you a file list with the default printer marked as **TRUE**:

```vb

SHELL _HIDE "CMD /C" + "wmic printer get name,default > default.txt"

```

> Created file's text:

```text

Default  Name                           
  FALSE    Microsoft XPS Document Writer 
  TRUE     HP Photosmart C7200 series     
  FALSE    HP Officejet Pro 8600         
  FALSE    Fax

```

> *Explanation:* [LINE INPUT](LINE-INPUT) could be used to find the printer names as [STRING](STRING) variables.

*Snippet 2:* Here is the code to set the default printer to the "HP Officejet Pro 8600":

```vb

SHELL _HIDE "CMD /C" + "wmic printer where name='HP Officejet Pro 8600' call setdefaultprinter"

```

> After executing this program, and then running the first snippet again, we see the following contents of the text file:

```text

Default  Name 
  FALSE    Microsoft XPS Document Writer 
  FALSE    HP Photosmart C7200 series     
  TRUE     HP Officejet Pro 8600         
  FALSE    Fax

```

### More examples

*See examples in:*

* [FILELIST$ (function)](FILELIST$-(function)) (member-contributed file search routine)
* *File Exist* C++ Function that does not create a temp file: [Windows Libraries](Windows-Libraries)

## See Also

* [SHELL (function)](SHELL-(function)), [_SHELLHIDE](_SHELLHIDE)
* [FILES](FILES), [CHDIR](CHDIR), [MKDIR](MKDIR)
* [_CWD$](_CWD$), [_STARTDIR$](_STARTDIR$)
* [_FILEEXISTS](_FILEEXISTS), [_DIREXISTS](_DIREXISTS)
* [RMDIR](RMDIR), [NAME](NAME), [KILL](KILL), [RUN](RUN)
* [_HIDE](_HIDE), [_DONTWAIT](_DONTWAIT)
* [_CONSOLE](_CONSOLE), [$CONSOLE]($CONSOLE)
* [$SCREENHIDE]($SCREENHIDE), [$SCREENSHOW]($SCREENSHOW) (QB64 [Metacommand](Metacommand)s)
* [_SCREENHIDE](_SCREENHIDE), [_SCREENSHOW](_SCREENSHOW)
* [FILELIST$](FILELIST$), [PDS (7.1) Procedures](PDS-(7.1)-Procedures) (member-contributed file list array function)

### Extra reference

* [Windows Libraries](Windows-Libraries)
* [C Libraries](C-Libraries)
* [Windows Printer Settings](Windows-Printer-Settings)
