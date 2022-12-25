The **FILELIST$** function can be used in place of the old QBasic [FILES](FILES) statement to view a list of files. Displays long and short(8.3) DOS filenames with the last modified information. Function name returns the short filename while **SHARED** string variables **LFN$** and **Path$** return the long name and absolute path from the current root drive. The leading underscore should make it compatible with most older QBasic program code run in **QB64**. The function allows mouse click file selection, letter press searches, file name exist verification without a screen display, and many of the DIR options available in DOS. Including sorting by name, extension, attributes and more! **Your program screens are not changed after a display and the function can be integrated into a program using Putimage!**

```text

                             **FILELIST$ Function Features**

        1) **Only displays a file list when necessary.** Otherwise one or no files found
           work "silently". Can be used to check if a file exists without an error!

        2) **Completely restores the program screen after a file list display!** It is
           not necessary to create a new screen like you did after FILES. See Demo.

        3) Users can jump to the leading filename letter by pressing a letter key.

        4) Selection of files is done by a mouse click anywhere on a filename row.
           Clicking near the bottom or keypress can advance to the next page list.
          
        5) Does not require ***.***! Press Enter to display all files in current folder. 
           No program typing errors! Just press Enter after a valid path for list! 

        6) If it doesn't find a file, it returns a 0 length string. **NO FILE ERRORS!**
           Just check for empty or zero length string returns in your program.

        7) Includes various filename options for sorting as described below the code.

        8) To view the current sub-directories, use Spec$ = **"/A:D"** in any lettercase.
       
        9) Update: Display now **highlights** the mouse selection rows for clarity. Also
           Displays the present search path. Option **/S** will search all sub-directories.
           The file's actual **Path$** will be returned even if it was not displayed!

       10) The newest version sets up the entire process using two position parameters
           so that it can be viewed on your program screen area. See **[FILELIST$](FILELIST$)**

```

**[Screenshot](http://i301.photobucket.com/albums/nn53/burger2227/FILE-ss2.jpg)**

**The function is NOT a QB64 authorized function!** This program code is free to use in your programs! No claims are made as to the suitability of the code and the user is responsible for any damages. You are free to alter the code as you see fit.

**NOTE: IF [$STATIC]($STATIC) Metacommand is required, change function Arrays to [STATIC](STATIC) and [ERASE](ERASE) them at start and every loop!**

```vb

_TITLE "Demo of FILELIST$ Function by Ted Weissgerber 2010"
handle& = _NEWIMAGE(800, 600, 256) 'Demo code creates custom sized screen mode
SCREEN handle&
Align 15, 2, "SUPER " + QQ$("FILELIST$") + " SEARCH"
Align 10, 5, "The FILELIST$ function locates files from any input. Enter or " + QQ$("") + " same as " + QQ$("*.*")
Align 10, 6, "Shared variables Path$ and LFN$ return path and long name if available."
DO
  LOCATE 10, 20: PRINT SPACE$(70) 'entry below can enclose file names in quotes
  LINEPUT 14, 10, "Enter a filename Search spec: ", spec$
  IF UCASE$(spec$) = "END" THEN EXIT DO
  filename$ = FILELIST$(spec$)
  LOCATE 13, 20: PRINT SPACE$(70)
  Align 11, 13, filename$
  LOCATE 15, 1: PRINT SPACE$(90)
  Align 15, 15, Path$ + spec$
  Align 10, 17, "Note that your " + QQ$("spec$") + " also returns the selected file name."
  LOCATE 20, 20: PRINT SPACE$(50)
  Align 13, 20, "LFN$ = " + LFN$ + " LEN =" + STR$(LEN(LFN$))
  Align 11, 23, "Enter " + QQ$("END") + " to quit"
LOOP
SYSTEM
'----------------------------- End of Demo Code -------------------------------

SUB Align (c0l0r%, Tr0w%, t3xt$) 'auto centers printed text
Tc0l% = (_WIDTH \ 16) + 1 - (LEN(t3xt$) \ 2)
IF Tc0l% <= 0 THEN Tc0l% = 2
COLOR c0l0r%: LOCATE Tr0w%, Tc0l%: PRINT t3xt$;
END SUB

SUB LINEPUT (c0l0r%, Tr0w%, t3xt$, r3turn$)
'Auto centering LINE INPUT entry allows quotation marks around filenames with spaces
Tc0l% = ((_WIDTH \ 16) - 10) - (LEN(t3xt$) \ 2)
IF Tc0l% <= 0 THEN Tc0l% = 2
COLOR c0l0r%: LOCATE Tr0w%, Tc0l%: PRINT t3xt$;
LINE INPUT ; "", r3turn$ 'semicolon in case bottom 2 rows
END SUB

FUNCTION QQ$ (t3xt$) 'Quote unQuote text in quotes
QQ$ = CHR$(34) + t3xt$ + CHR$(34)
END FUNCTION

' >>>>>>>>> Place INCLUDE file reference here when used as library <<<<<<<<<

```

```vb

'****** NOTE: FILELIST$ Function can also be included as an external library(see below) ******

FUNCTION FILELIST$ (Spec$)
SHARED Path$, LFN$ 'values also accessable by main program
REDIM LGFN$(25), SHFN$(25), Last$(25), DIR$(25), Paths$(25) '<<< $DYNAMIC only
IF LEN(ENVIRON$("OS")) = 0 THEN EXIT FUNCTION 'DIR X cannot be used on Win 9X
f% = FREEFILE
SHELL _HIDE "CD > D0S-DATA.INF" '********************** Optional TITLE <<<<<<<<<<
OPEN "D0S-DATA.INF" FOR INPUT AS #f%
LINE INPUT #f%, current$
CLOSE #f% ' ******************************************** END TITLE(see _TITLE below)
Spec$ = UCASE$(LTRIM$(RTRIM$(Spec$)))
IF INSTR(Spec$, "/A:D") OR INSTR(Spec$, "/O:G") THEN
  DL$ = "DIR": BS$ = "\" 'directory searches only
ELSE: DL$ = SPACE$(3): BS$ = ""
END IF
mode& = _COPYIMAGE(0) 'save previous screen value to restore if files displayed.
' Get Specific file information if available
SHELL _HIDE "cmd /c dir " + Spec$ + " /X > D0S-DATA.INF" 'get data
Head$ = "      Short Name          Long Name                     Last Modified     "
tmp$ = " \ \  \          \   \                              \ \                  \"
OPEN "D0S-DATA.INF" FOR INPUT AS #f% 'read the data file
DO UNTIL EOF(f%)
  LINE INPUT #f%, line$
  IF INSTR(line$, ":\") THEN
    Path$ = MID$(line$, INSTR(line$, ":\") - 1)
    IF RIGHT$(Path$, 1) <> "\" THEN Path$ = Path$ + "\"
    setcode% = 0: filecode% = 0
  END IF
  IF LEN(line$) > 25 AND MID$(line$, 1, 1) <> " " THEN 'don't read other info
    IF format% = 0 THEN
      IF MID$(line$, 20, 1) = "M" OR INSTR(line$, "<") = 25 THEN
        Sst% = 40: Lst% = 53: Dst% = 26: format% = 1 ' XP
      ELSE: Sst% = 37: Lst% = 50: Dst% = 23: format% = 2 'VISTA
      END IF
    END IF
    IF LEN(line$) >= Lst% THEN filecode% = ASC(UCASE$(MID$(line$, Lst%, 1))) ELSE filecode% = 0
    D1R$ = MID$(line$, Dst%, 3) 'returns directories only with Spec$ = "/A:D" or "/O:G"
    IF D1R$ <> "DIR" THEN D1R$ = SPACE$(3) 'change if anything else
    IF D1R$ = DL$ AND filecode% >= setcode% THEN
      cnt% = cnt% + 1
      DIR$(cnt%) = D1R$: Paths$(cnt%) = Path$
      Last$(cnt%) = MID$(line$, 1, 20)
      IF MID$(line$, Sst%, 1) <> SPACE$(1) THEN
        SHFN$(cnt%) = MID$(line$, Sst%, INSTR(Sst%, line$, " ") - Sst%)
        LGFN$(cnt%) = MID$(line$, Lst%)
      ELSE: SHFN$(cnt%) = MID$(line$, Lst%): LGFN$(cnt%) = ""
      END IF
      IF LEN(Spec$) AND (Spec$ = UCASE$(SHFN$(cnt%)) OR Spec$ = UCASE$(LGFN$(cnt%))) THEN
        Spec$ = SHFN$(cnt%) + BS$: FILELIST$ = Spec$: LFN$ = LGFN$(cnt%) + BS$
        noshow = -1: GOSUB KILLdata ' verifies file exist query (no display)
      END IF
      IF page% > 0 THEN ' pages after first
        IF cnt% = 1 THEN GOSUB NewScreen
        COLOR 11: LOCATE , 3: PRINT USING tmp$; DIR$(cnt%); SHFN$(cnt%); LGFN$(cnt%); Last$(cnt%)
        IF DIR$(cnt%) = "DIR" AND LEFT$(SHFN$(cnt%), 1) = "." THEN SHFN$(cnt%) = "": LGFN$(cnt%) = ""
      ELSE 'first page = 0
        IF cnt% = 2 THEN 'only display to screen if 2 or more files are found
          FList& = _NEWIMAGE(640, 480, 256)
          SCREEN FList&: _TITLE current$: GOSUB NewScreen '********* Optional TITLE <<<<<<<
          COLOR 11: LOCATE , 3: PRINT USING tmp$; DIR$(1); SHFN$(1); LGFN$(1); Last$(1)
          _DISPLAY
          IF DIR$(1) = "DIR" AND LEFT$(SHFN$(1), 1) = "." THEN SHFN$(1) = "": LGFN$(1) = ""
        END IF
        IF cnt% > 1 THEN
          COLOR 11: LOCATE , 3: PRINT USING tmp$; DIR$(cnt%); SHFN$(cnt%); LGFN$(cnt%); Last$(cnt%)
          IF DIR$(cnt%) = "DIR" AND LEFT$(SHFN$(cnt%), 1) = "." THEN SHFN$(cnt%) = "": LGFN$(cnt%) = ""
        END IF
      END IF 'page%
      IF cnt% MOD 25 = 0 THEN 'each page holds 25 file names
        COLOR 14: LOCATE 28, 24: PRINT "Select file or click here for next."; '<<<< Prompt text can be changed
        GOSUB pickfile
        page% = page% + 1: cnt% = 0
        REDIM LGFN$(25), SHFN$(25), Last$(25), DIR$(25), Paths$(25) '<<< $DYNAMIC only
      END IF 'mod  25
    END IF 'DIR = DL$
  END IF 'len line$ > 25
LOOP
CLOSE #f%
last = 1: total% = cnt% + (page% * 25)
IF total% = 0 THEN FILELIST$ = "": Spec$ = "": LFN$ = "": noshow = -1: GOSUB KILLdata: 'no files(no display)
IF total% = 1 THEN   'one file(no display)
  Spec$ = SHFN$(1) + BS$: FILELIST$ = Spec$: LFN$ = LGFN$(1) + BS$: noshow = -1: GOSUB KILLdata 
END IF
IF DL$ = SPACE$(3) THEN
  COLOR 10: LOCATE 28, 65: PRINT total%; "Files"
ELSE: COLOR 10: LOCATE 28, 65: PRINT total%; "Folders"
END IF
COLOR 14: LOCATE 28, 24: PRINT "Select file or click here to Exit. "; '<<< Prompt text can be changed
pickfile:
_DEST FList&
ShowPath$ = RIGHT$(Path$, 78)
COLOR 15: LOCATE 29, 41 - (LEN(ShowPath$) \ 2): PRINT ShowPath$;
_DISPLAY
DO: Key$ = UCASE$(INKEY$): _LIMIT 30
  DO WHILE _MOUSEINPUT
    Tcol% = ((_MOUSEX - xpos%) \ 8) + 1 'mouse column with Putimage offset
    Trow% = ((_MOUSEY - ypos%) \ 16) + 1 'mouse row with offset
    Pick = _MOUSEBUTTON(1) ' get left button selection click
  LOOP
  IF Trow% > 2 AND Trow% < cnt% + 3 AND Tcol% > 0 AND Tcol% < 80 THEN 'when mouse in area
    R% = Trow% - 2
    IF P% = 0 OR P% > cnt% + 3 THEN P% = R%
    IF P% = R% THEN
      COLOR 15: LOCATE R% + 2, 3: PRINT USING tmp$; DIR$(R%); SHFN$(R%); LGFN$(R%); Last$(R%)
    ELSE
      COLOR 11: LOCATE P% + 2, 3: PRINT USING tmp$; DIR$(P%); SHFN$(P%); LGFN$(P%); Last$(P%)
    END IF
    _DISPLAY
    P% = R%
    IF Pick THEN
      Spec$ = SHFN$(R%)
      IF LEN(Spec$) THEN
        COLOR 13: LOCATE R% + 2, 3: PRINT USING tmp$; DIR$(R%); SHFN$(R%); LGFN$(R%); Last$(R%)
        _DISPLAY
        Spec$ = Spec$ + BS$: FILELIST$ = Spec$: Path$ = Paths$(R%)
        IF LEN(LGFN$(R%)) THEN LFN$ = LGFN$(R%) + BS$ ELSE LFN$ = ""
        _DELAY 1.5: CLS: SCREEN mode&: GOSUB KILLdata 'exit if user selection
      END IF
    END IF 'len spec
  END IF 'pick
  IF LEN(Key$) THEN usercode% = ASC(Key$) ELSE usercode% = 0
  IF usercode% > setcode% THEN setcode% = usercode% 'user can press letter to jump to
  IF Pick AND Trow% > 27 THEN EXIT DO
LOOP UNTIL LEN(Key$)
_DELAY .4 'adjust delay for page scroll speed
DO: Key$ = INKEY$: LOOP UNTIL Key$ = ""
IF last = 0 THEN RETURN 'exit if file no more data
FILELIST$ = "": Spec$ = "": LFN$ = ""
CLS: SCREEN mode& 'resets program screen to previous condition
KILLdata:
CLOSE #f%: KILL "D0S-DATA.INF" 'kill D0S-DATA.INF file and exit
IF FList& < -1 THEN _FREEIMAGE FList&
IF noshow = -1 AND mode& < -1 THEN _FREEIMAGE mode&
_AUTODISPLAY 'reset default settings
EXIT FUNCTION
RETURN
NewScreen: 'clear screen and set display format
LINE (0, 0)-(639, 499), 0, BF
COLOR 14: LOCATE 2, 3: PRINT Head$
LINE (4, 4)-(636, 476), 13, B: LINE (5, 5)-(635, 475), 13, B
RETURN
END FUNCTION * *      

```

Updated for VISTA screen format 8/20/2010. 

Updated for programs using $DYNAMIC Metacommand 9/16/2010.

Added option for current path to TITLE bar 11/16/2010

**[Function Screenshot](http://i301.photobucket.com/albums/nn53/burger2227/FILE-ss2.jpg)**

**CREATING A FILELIST$ $INCLUDE LIBRARY**

The Function can be also be added to any program as a text library by saving it as a text BI file!

Just [$INCLUDE]($INCLUDE) the BI text file (grey area above) at the end of your program AFTER the SUB procedures. 

To create a **BI** file use Notepad or another text editor, copy code in grey area  and Save as **ALL FILES** using *anyname.BI*

**NOTE: Once the program is compiled, the BI file is no longer needed with the stand alone EXE program!

```text

                     **FILELIST$(Spec$) OPTIONS** (/X already used!)
Syntax: 
                         
FILELIST$([drive:][path][filename][/A[:]attrib](:]attrib)[/L][/O[:]sortorder](:]sortorder)[/S][/T[:]timefield](:]timefield))

 NOTE: When path is specified, that path is returned to the SHARED Path$ variable. 

               The FILELIST$ function can use the following options:

             **/A** List by attribute. Syntax: /A:attribute 
                      :D Directories (use /A:D after any path or by itself)
                      :R Read-only files 
                      :H Hidden files 
                      :A Files ready for archiving 
                      :S System files 
                     - Prefix means not 

             **/L** Use lowercase.

             **/O** List of files in sorted order. Syntax: /O:sortorder
                      :N By name (alphabetical is default) 
                      :S By size (smallest first) 
                      :E By extension (alphabetical) 
                      :D By date/time (oldest first) 
                      :G Group directories only (/O:G)
                      - Prefix to reverse order 

             NOTE: Alphabetical keypress is disabled when using /O.

             **/S** Searches all directory and subdirectory files

             **/T** Time field displayed or used for sorting. Syntax: /T:timefield         
                      :A Last Access 
                      :C Creation 
                      :W Last Written 

   DIR commands that don't work: /B, /C, /D, /N, /P, /Q, and /W. (/X already used) 
            
               These options return nothing or do not change a search!

    **To Search filenames with spaces, add CHR$(34) quote to each side of the spec file name!**

                   filename$ = FILELIST$(CHR$(34) + Spec$ + CHR$(34))


 **NOTE: [LINE INPUT](LINE-INPUT) allows quoted entries such as: "free cell.ico" for filenames with spaces.**

```

**FILELIST$ Function can also be displayed on your program screen with Putimage!**

First use Flist& as the source in: _PUTIMAGE , Flist&, newimagepage&
Then Putimage again at a position on screen larger than 640 X 480 to display
 _DEST main&: _PUTIMAGE (x, y), newimagepage& 
Where DEST main& is the main program screen. Add the code to the function.

**[FILELIST$](FILELIST$)**

> *NOTE:* The data file name "D0S-DATA.INF" uses a zero instead of an "O" in D0S and is deleted after a search!

## See Also

* [FILES](FILES), [SHELL](SHELL)
* [_HIDE](_HIDE), [_COPYIMAGE](_COPYIMAGE), [_PUTIMAGE](_PUTIMAGE)
* [$INCLUDE]($INCLUDE) ([Metacommand](Metacommand))
