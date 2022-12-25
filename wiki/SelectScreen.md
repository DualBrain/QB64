This screen mode selector shows a list of common video modes found on desktop and laptops graphics cards, and some square modes. It has full mouse support. It also has the ability to filter video modes for a specific aspect ratio.

Some of you might have seen this in my previous graphics program. I'm now releasing it as a library.

It's a two-part library that can be plugged into any program (using [$INCLUDE]($INCLUDE)). It's two-part because it contains definitions at the start of the program, and subroutines. Originally, [$INCLUDE]($INCLUDE) was made for compiled libraries, so there's no default support to include QuickBASIC code inside them, which is just what I've done. Therefore you need two **text** files included at different locations in a graphics program.

## Example(s)

*Example BAS Code:* SelectResolution.BAS Demo example should be compiled by QB64 only.

```vb

DEFINT A-Z

'$INCLUDE: 'selectResolution.bi'

PRINT "This is screen mode 0. Select another screen mode after pressing a key."
PRINT "Press any key..."
i$ = INPUT$(1)

selectResolution 4, width, height
IF width = 0 THEN
    PRINT
    PRINT "ESC pressed. Exiting."
    END
END IF

SCREEN _NEWIMAGE(width, height, 32) ' '
PRINT "This is your selected screen"
PRINT "mode. Press any key to select"
PRINT "another mode. To demonstrate"
PRINT "that it keeps your screen mode"
PRINT "in case you cancel, press ESC"
PRINT "when selecting a mode."
i$ = INPUT$(1)

selectResolution 4, width, height
IF width = 0 THEN
    PRINT
    PRINT "ESC pressed. Exiting."
    END
END IF

SCREEN _NEWIMAGE(width, height, 32)
PRINT "This is your selected screen mode."
PRINT "Press any key to end."
i$ = INPUT$(1)


'$INCLUDE: 'selectResolution.bm'

```

[$INCLUDE]($INCLUDE) the .bi file on top of your program and the .bm file at the bottom, after your own SUBs.

**To create the BI and BM files, copy them to Notepad and Save as *ALL FILES* with appropriate filename extensions!**

*SelectResolution.bi Code:*

```text

'#########################################################################################
'# Resolution selector v1.2 (include at top of program code)
'# By Zom-B
'#########################################################################################

videoaspect:
DATA "all aspect",15
DATA "4:3",11
DATA "16:10",10
DATA "16:9",14
DATA "5:4",13
DATA "3:2",12
DATA "5:3",9
DATA "1:1",7
DATA "other",8
DATA ,

videomodes:
DATA 256,256,7
DATA 320,240,1
DATA 400,300,1
DATA 512,384,1
DATA 512,512,7
DATA 640,480,1
DATA 720,540,1
DATA 768,576,1
DATA 800,480,2
DATA 800,600,1
DATA 854,480,3
DATA 1024,600,8
DATA 1024,640,2
DATA 1024,768,1
DATA 1024,1024,7
DATA 1152,768,5
DATA 1152,864,1
DATA 1280,720,3
DATA 1280,768,6
DATA 1280,800,2
DATA 1280,854,5
DATA 1280,960,1
DATA 1280,1024,4
DATA 1366,768,3
DATA 1400,1050,1
DATA 1440,900,2
DATA 1440,960,5
DATA 1600,900,3
DATA 1600,1200,1
DATA 1680,1050,2
DATA 1920,1080,3
DATA 1920,1200,2
DATA 2048,1152,3
DATA 2048,1536,1
DATA 2048,2048,7
DATA ,,


```

The [$INCLUDE]($INCLUDE) of the function should be after your main program! 

Otherwise you would get the error "Statement cannot be placed between SUB/FUNCTIONs"

*SelectResolution.bm Code:*

```text

'####################################################################################################################
'# Resolution selector v1.3 (routines)
'# By Zom-B
'# 'Start in any mode' feature by codeguy.
'####################################################################################################################

SUB selectResolution (row%, width%, height%)
    backupScreen& = _COPYIMAGE
    SCREEN 0

    ' Start neatly.
    COLOR 7

    yOffset% = row% - 1

    'READ the DATA from the include file, while storing it in local arrays.
    DIM aspectName$(0 to 9), aspectCol%(0 to 9)
    RESTORE videoaspect
    FOR y% = 0 TO 10
        READ aspectName$(y%), aspectCol%(y%)
        IF aspectCol%(y%) = 0 THEN numAspect% = y% - 1: EXIT FOR
    NEXT

    DIM vidX%(1 to 100), vidY%(1 to 100), vidA%(1 to 100)
    RESTORE videomodes
    FOR y% = 1 TO 100
        READ vidX%(y%), vidY%(y%), vidA%(y%)
        IF vidX%(y%) <= 0 THEN numModes% = y% - 1: EXIT FOR
    NEXT

    ' If not called from SCREEN 0, set the number of screen rows to maximum.
    ' Otherwise, the height of the old screen is re-used.
    IF _PIXELSIZE(backupScreen&) THEN WIDTH , numModes% + row%: _FONT 16

    ' Clip the number of modes to the height of the screen.
    IF numModes% > _HEIGHT - yOffset% - 1 THEN numModes% = _HEIGHT - yOffset% - 1

    ' Select the text mode's segment for later SCREEN 0 POKEing.
    DEF SEG = &HB800

    LOCATE yOffset% + 1, 1
    PRINT "Select video mode:"; TAB(61); "Click"

    ' Print the down-pointing triangle (which isn't a PRINTable character! (try it))
    POKE (yOffset% * 80 + 66) * 2, 31

    'Initialize some things before entering the loop.
    selectedAspect% = 0 ' The selected aspect ratio item
    lastY% = 0 ' The screen Y coordinate of the previously highlighted item
    reprint% = -1 ' Used to signal that a reprint of the screen is needed
    lastButton% = 0 ' memory variable to detect a 'depress' of the mouse button
    DO
        ' Cancel on ESC.
        IF INKEY$ = CHR$(27) THEN
            width% = 0
            height% = 0
            EXIT DO
        END IF

        ' Don't reprint every iteration, only when something changed.
        IF reprint% THEN
            reprint% = 0

            FOR x% = 1 TO numModes%
                LOCATE yOffset% + x% + 1, 1

                ' Print the video mode number in gray.
                COLOR 7, 0
                PRINT USING "##:"; x%;

                ' Print the video mode data in it's assigned aspect ratio color (if no aspect ratio is selected),
                ' otherwise, make matching video modes white and others dark gray.
                IF selectedAspect% = 0 THEN
                    COLOR aspectCol%(vidA%(x%))
                ELSEIF selectedAspect% = vidA%(x%) THEN
                    COLOR 15
                ELSE
                    COLOR 8
                END IF
                PRINT STR$(vidX%(x%)); ","; vidY%(x%);
            NEXT

            FOR x% = 0 TO numAspect%
                ' Print the aspect ratios. The selected one (if any) with dark cyan background.
                IF x% > 0 AND selectedAspect% = x% THEN
                    COLOR aspectCol%(x%), 3
                ELSE
                    COLOR aspectCol%(x%), 0
                END IF
                LOCATE yOffset% + x% + 2, 64
                PRINT "<"; aspectName$(x%); ">"
            NEXT
        END IF

        IF _MOUSEINPUT THEN
            IF lastY% > 0 THEN
                ' Un-highlight any selected item by reverting the color of the entire screen row (while leaving text intact).
                FOR x% = 0 TO 159 STEP 2
                    POKE lastY% + x%, PEEK(lastY% + x%) AND &HEF
                NEXT
            END IF

            x% = _MOUSEX
            y% = _MOUSEY - yOffset% - 1

            ' Check if we should highlight a video mode or aspect ratio.
            IF x% <= 60 THEN
                IF y% > 0 AND y% <= numModes% THEN
                    ' Exit if the highlighted video mode has been 'clicked' (ie. when the mouse button is depressed).
                    IF _MOUSEBUTTON(1) = 0 AND lastButton% THEN
                        width% = vidX%(y%)
                        height% = vidY%(y%)
                        EXIT DO
                    END IF

                    ' Highlight selected video mode by changing the color of the entire item (while leaving text intact).
                    y% = (yOffset% + y%) * 160 + 1
                    FOR x% = 0 TO 119 STEP 2
                        POKE y% + x%, PEEK(y% + x%) OR &H10
                    NEXT
                ELSE
                    y% = 0
                END IF
            ELSE
                IF y% > 0 AND y% - 1 <= numAspect% THEN
                    IF _MOUSEBUTTON(1) THEN
                        selectedAspect% = y% - 1
                        reprint% = -1
                    END IF

                    ' Highlight selected aspect ratio by changing the color of the entire item (while leaving text intact).
                    y% = (yOffset% + y%) * 160 + 1
                    FOR x% = 120 TO 159 STEP 2
                        POKE y% + x%, PEEK(y% + x%) OR &H10
                    NEXT
                ELSE
                    y% = 0
                END IF
            END IF
            lastY% = y%
            lastButton% = _MOUSEBUTTON(1)
        END IF
    LOOP

    ' Exit neatly.
    SCREEN backupScreen&
END SUB

```

## See Also

* [$INCLUDE]($INCLUDE) ([Metacommand](Metacommand))
* [PEEK](PEEK), [POKE](POKE)
* [SCREEN (statement)](SCREEN-(statement))
