The [_HIDE](_HIDE) action is used to hide the console window opened by a [SHELL](SHELL) statement.

## Syntax

> [SHELL](SHELL) [**_HIDE**] StringCommandLine$

## Description

* Allows any command line window to be hidden from view without affecting the program.
* [_HIDE](_HIDE) must be used when sending ("piping") screen information to a file.
* **Note:** Some commands may not work without adding CMD /C to the start of the command line.

## Example(s)

Subprogram that displays long and short filenames using the DIR /X option (WindowsNT or above) in SCREEN 12:

```vb

SUB LFN
 IF LEN(ENVIRON$("OS")) = 0 THEN EXIT SUB   ' /X not available Win 9X and ME 
 SHELL _HIDE "cmd /c dir /x > DOS-DATA.INF" ' load display data to a file
 OPEN "DOS-DATA.INF" FOR INPUT AS #1
 IF LOF(1) THEN
   Header$ = SPACE$(10) + "Short" + SPACE$(16) + "Long" + SPACE$(20) + "Last Modified"
   tmp$ = "\   \  \          \      &" ' print using template format
   COLOR 14: LOCATE 2, 4: PRINT Header$
   DO UNTIL EOF(1)
    LINE INPUT #1, line$
    IF LEN(line$) AND MID$(line$, 1, 1) <> SPACE$(1) THEN ' ignore other file data
      cnt% = cnt% + 1
      last$ = MID$(line$, 1, 20): DIR$ = MID$(line$, 26, 3)
      IF MID$(line$, 40, 1) <> SPACE$(1) THEN ' found line with short and long name 
        SHFN$ = MID$(line$, 40, INSTR(40, line$, SPACE$(1)) - 1)
        LGFN$ = MID$(line$, 53)
      ELSE : SHFN$ = MID$(line$, 53): LGFN$ = "" ' found short name only
      END IF
      IF cnt% MOD 25 = 0 THEN ' pause every 25 files
        COLOR 14: LOCATE 29, 27 "Press a key for more files!"
        DO: LOOP UNTIL INKEY$ <> ""
        CLS: COLOR 14: LOCATE 2, 4: PRINT Header$
      END IF
      COLOR 11: LOCATE (cnt% MOD 25) + 3, 4
      PRINT USING tmp$; DIR$; SHFN$; LGFN$
      LOCATE (cnt% MOD 25) + 3, 58: PRINT last$
    END IF
   LOOP
 END IF
 COLOR 10: LOCATE CSRLIN + 1, 27 "Total folders and files ="; cnt%
 CLOSE #1
END SUB 

```

*Explanation:* The above routine can also be used to place the file name info into string arrays by using the count variable cnt% to determine the index. Long file names are normally returned by **QB64**. To keep older QBasic programs compatible, you may want to only use the short names when displaying the files on the screen.

## See Also

* [SHELL](SHELL), [_DONTWAIT](_DONTWAIT)
* [FILELIST$ (function)](FILELIST$-(function)) ([FILES](FILES) function, member-contributed)
