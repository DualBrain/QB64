'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
'  PIXELplus 256 User Subroutines & Functions
'  FREEWARE version 1.0 - (C)1995 Chris Chadwick. All rights reserved.
'  For QBASIC, QuickBASIC and Visual BASIC for MS-DOS
'
'  Consult your PIXELplus 256 User's Manual for full details on how to
'  incorporate and use the routines contained in this file.
'
'  Note: The routines contained in this file do not contain error
'        checking. This makes the code easier to understand.
'
'  *** BEFORE RUNNING THE DEMONSTRATION ***
'  Running the demonstration requires access to four files which should have
'  been supplied with this FREEWARE version of PIXELplus 256. They are:
'
'  CHARSET1.PUT
'  CHARSET2.PUT
'  CHARSET3.PUT
'  STANDARD.PAL
'
'  In your PIXELplus 256 directory (usually C:\PP256), the three .PUT files
'  should be located in the IMAGES subdirectory, and the .PAL file should be
'  located in the PALETTES subdirectory. If you have PIXELplus 256
'  installed in a directory other than C:\PP256 then the value of Path$
'  (see (*) below) should be altered appropriately before running the
'  demonstration.
'
'  Note that CHARSET2.PUT is only a partial character set image file that
'  does not include lower case letters so text to be displayed using it
'  should only contain upper case letters.
'
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Resize:Smooth

'Variable type to hold screen design item data.
Type DesignType
    ImageNo As Integer
    Xpos As Integer
    Ypos As Integer
    DisAct As Integer
End Type

DECLARE SUB InitPaletteData (FileName$, PaletteArray&())
DECLARE SUB InitDesignData (FileName$, DesignArray() AS DesignType)
DECLARE SUB InitImageData (FileName$, ImageArray%())
DECLARE SUB MakeImageIndex (ImageArray%(), IndexArray%())
DECLARE SUB DisplayDesign (DesignArray() AS DesignType, ImageArray%(), ImageIndex%(), ClsAction%)
DECLARE SUB ChangePalette (PaletteArray&())
DECLARE SUB FadePalette (Direction%, PaletteArray&())
DECLARE SUB RotatePalette (StartAttr%, EndAttr%, Direction%, PaletteArray&())
DECLARE SUB CharPrint (Text$, Fore%, Back%, CursorPos%, ImageArray%())
DECLARE SUB CharPrintXY (x%, y%, Text$, Fore%, Back%, CursorPos%, ImageArray%())
DECLARE SUB Scroller (ScrollAct%, ImageArray%(), IndexArray%())
DECLARE SUB WizzText (Text$, TopLine%, ImageArray%(), IndexArray%())
DECLARE SUB GraphicText (x%, y%, Text$, CursorPos%, ImageArray%(), IndexArray%())
DECLARE FUNCTION GetDepth% (ImNo%, ImageArray%(), IndexArray%())
DECLARE FUNCTION GetWidth% (ImNo%, ImageArray%(), IndexArray%())

DefInt A-Z

'Constants for subroutine parameters.
Const INITSCROLL = 0, UPDATESCROLL = 1
Const OVERPRINT = -1
Const CENTRETEXT = -1, FROMCURSOR = -2
Const FADEDOWN = 0, FADEUP = 1
Const ROTATELEFT = 0, ROTATERIGHT = 1
Const NEWLINE = 0, TEXTEND = 1

'Change to 320x200, 256 colour VGA screen mode.
Screen 13
_FullScreen _SquarePixels , _Smooth
Cls

'(*) If necessary, change Path$ to the path where
'    you have PIXELplus 256 installed.
Path$ = "."

'Load standard palette.
ReDim StandardPal&(1 To 1)
Call InitPaletteData(Path$ + "\palettes\standard.pal", StandardPal&())
Call ChangePalette(StandardPal&())

'Load character set used by CharPrint() and CharPrintXY() routines.
ReDim Set1Data(1 To 1)
Call InitImageData(Path$ + "\images\charset1.put", Set1Data())

'Load bitmapped character set used by WizzText() and Scroller() routines.
'This is a partial character set containing ASCII characters 32 (space)
'to 90 (Z) only.
ReDim Set2Data(1 To 1)
ReDim Set2Index(1 To 1)
Call InitImageData(Path$ + "\images\charset2.put", Set2Data())
Call MakeImageIndex(Set2Data(), Set2Index())

'Load bitmapped character set used by GraphicText() routine.
ReDim Set3Data(1 To 1)
ReDim Set3Index(1 To 1)
Call InitImageData(Path$ + "\images\charset3.put", Set3Data())
Call MakeImageIndex(Set3Data(), Set3Index())

'Initialize images used in GAME OVER screen design.
ReDim ImageData(1 To 1)
ReDim ImageIndex(1 To 1)
Restore SDImageData
Call InitImageData("", ImageData())
Call MakeImageIndex(ImageData(), ImageIndex())

'Initialize alternative palette.
ReDim NewPal&(1 To 1)
Restore NewPaletteData
Call InitPaletteData("", NewPal&())

'Initialize GAME OVER screen design.
ReDim GODesign(1 To 1) As DesignType
Restore DesignData
Call InitDesignData("", GODesign())

'*** Draw page 1 of demonstration ***

'Draw a background image so overprinting can be demonstrated properly.
For n = 1 To 12
    Line (0, 51 + n)-Step(318, 0), 30 - n
    Line (0, 53 - n)-Step(318, 0), 30 - n
Next n

'Demonstrate CharPrint() subroutine.
Call CharPrint("CharPrint() can be used as an", 40, 0, NEWLINE, Set1Data())
Call CharPrint("alternative to BASIC's own PRINT", 40, 0, NEWLINE, Set1Data())
Call CharPrint("statement. A user-defined character set", 40, 0, NEWLINE, Set1Data())
Call CharPrint("is used and text can either be displayed", 40, 0, NEWLINE, Set1Data())
Call CharPrint("with a ", 40, 0, TEXTEND, Set1Data())
Call CharPrint("BACKGROUND", 40, 44, TEXTEND, Set1Data())
Call CharPrint(" colour or...", 40, 0, NEWLINE, Set1Data())
Locate 7, 10
Call CharPrint("O V E R P R I N T E D", 40, OVERPRINT, NEWLINE, Set1Data())
Locate 9
Call CharPrint("on the existing screen image.", 40, 0, NEWLINE, Set1Data())

'Demonstrate CharPrintXY() subroutine.
Call CharPrintXY(0, 90, "CharPrintXY() is the same as", 33, 44, NEWLINE, Set1Data())
Call CharPrintXY(2, 99, "CharPrint() except it allows text", 33, 44, NEWLINE, Set1Data())
Call CharPrintXY(5, 109, "to be displayed at a graphics", 33, 44, NEWLINE, Set1Data())
Call CharPrintXY(9, 120, "screen coordinate.", 33, 44, NEWLINE, Set1Data())
Call CharPrintXY(CENTRETEXT, 135, "Single lines of", 33, 0, NEWLINE, Set1Data())
Call CharPrintXY(CENTRETEXT, FROMCURSOR, "text can", 33, 0, NEWLINE, Set1Data())
Call CharPrintXY(CENTRETEXT, FROMCURSOR, "also be automatically", 33, 0, NEWLINE, Set1Data())
Call CharPrintXY(CENTRETEXT, FROMCURSOR, "centred on-screen", 33, 0, NEWLINE, Set1Data())
Call CharPrintXY(CENTRETEXT, FROMCURSOR, "by using CharPrintXY()", 33, 0, NEWLINE, Set1Data())

'Demonstrate Scroller() subroutine and wait for a key press.
Restore ScrollMess1
Call Scroller(INITSCROLL, Set2Data(), Set2Index())
Do
    Call Scroller(UPDATESCROLL, Set2Data(), Set2Index())
Loop While InKey$ = ""

'*** Draw page 2 of demonstration ***
Cls

'Demonstrate GraphicText() subroutine.
Call GraphicText(0, 0, "The GraphicText() subroutine is used to display", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(FROMCURSOR, FROMCURSOR, "text that uses a bitmapped character set...", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(CENTRETEXT, 32, "WHICH CAN BE ANY", NEWLINE, Set2Data(), Set2Index())
Call GraphicText(CENTRETEXT, 48, "SIZE YOU LIKE!", NEWLINE, Set2Data(), Set2Index())
Call GraphicText(0, 72, "Use GraphicText() to display", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(1, 81, "fancy text at any position", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(5, 91, "on the screen by using", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(9, 102, "graphics screen coordinates.", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(0, 120, "Notice how text is displayed proportionally so", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(FROMCURSOR, FROMCURSOR, "narrow characters like 'i' are still displayed with", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(FROMCURSOR, FROMCURSOR, "the same spacing as wide characters like 'm'.", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(CENTRETEXT, 156, "There's an automatic", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(CENTRETEXT, FROMCURSOR, "centring option", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(CENTRETEXT, FROMCURSOR, "too!", NEWLINE, Set3Data(), Set3Index())

'Demonstrate Scroller() subroutine and wait for a key press.
Restore ScrollMess2
Call Scroller(INITSCROLL, Set2Data(), Set2Index())
Do
    Call Scroller(UPDATESCROLL, Set2Data(), Set2Index())
Loop While InKey$ = ""

'*** Draw page 3 of demonstration ***
Cls

'Demonstrate WizzText() subroutine.
Call WizzText("THE WIZZTEXT()", 30, Set2Data(), Set2Index())
Call WizzText("SUBROUTINE CAN BE", 50, Set2Data(), Set2Index())
Call WizzText("USED TO DISPLAY", 70, Set2Data(), Set2Index())
Call WizzText("AND CENTRE SINGLE", 90, Set2Data(), Set2Index())
Call WizzText("LINES OF BITMAPPED", 110, Set2Data(), Set2Index())
Call WizzText("TEXT IN A MORE", 130, Set2Data(), Set2Index())
Call WizzText("EXCITING WAY!", 150, Set2Data(), Set2Index())

'Demonstrate Scroller() subroutine and wait for a key press.
Restore ScrollMess2
Call Scroller(INITSCROLL, Set2Data(), Set2Index())
Do
    Call Scroller(UPDATESCROLL, Set2Data(), Set2Index())
Loop While InKey$ = ""

'*** Draw page 4 of demonstration ***
Cls

'Draw a palette grid showing all 256 available colours.
For rr = 0 To 15
    For cc = 0 To 15
        Line (32 + cc * 16, 40 + rr * 8)-Step(14, 6), (rr * 16) + cc, BF
    Next cc
Next rr

'Display explanation text.
Call GraphicText(0, 8, "Using the ChangePalette() subroutine allows you", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(FROMCURSOR, FROMCURSOR, "to quickly change palettes...", NEWLINE, Set3Data(), Set3Index())

'Demonstrate ChangePalette() subroutine.
For n = 1 To 5
    Sleep 1
    Call ChangePalette(StandardPal&())
    Sleep 1
    Call ChangePalette(NewPal&())
Next n

'Clear old text from top of screen.
Line (0, 0)-(319, 38), 0, BF

'Display explanation text.
Call GraphicText(0, 8, "Use the RotatePalette() subroutine to shift a", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(FROMCURSOR, FROMCURSOR, "range of colours to the left or right...", NEWLINE, Set3Data(), Set3Index())

'Demonstrate RotatePalette() subroutine.
For n = 1 To 8
    Sleep 1
    Call RotatePalette(32, 47, ROTATERIGHT, NewPal&())
Next n
For n = 1 To 8
    Sleep 1
    Call RotatePalette(32, 47, ROTATELEFT, NewPal&())
Next n

'Clear old text from top of screen.
Line (0, 0)-(319, 38), 0, BF

'Display explanation text.
Call GraphicText(0, 8, "Use the FadePalette() subroutine to gradually", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(FROMCURSOR, FROMCURSOR, "fade out the display...", NEWLINE, Set3Data(), Set3Index())

'Demonstrate FadePalette() subroutine.
Sleep 3
Call FadePalette(FADEDOWN, NewPal&())
Line (0, 0)-(319, 38), 0, BF
Call GraphicText(0, 8, "...then gradually fade it back in!", NEWLINE, Set3Data(), Set3Index())
Sleep 1
Call FadePalette(FADEUP, NewPal&())

'Demonstrate Scroller() subroutine and wait for a key press.
Restore ScrollMess2
Call Scroller(INITSCROLL, Set2Data(), Set2Index())
Do
    Call Scroller(UPDATESCROLL, Set2Data(), Set2Index())
Loop While InKey$ = ""

'*** Draw page 5 of demonstration ***
Cls

'Display explanation text.
Call GraphicText(0, 0, "This is a simple screen design and shows how", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(FROMCURSOR, FROMCURSOR, "RotatePalette() can be used to create", NEWLINE, Set3Data(), Set3Index())
Call GraphicText(FROMCURSOR, FROMCURSOR, "very colourful effects...", NEWLINE, Set3Data(), Set3Index())

'Display GAME OVER screen design.
Call DisplayDesign(GODesign(), ImageData(), ImageIndex(), 0)

'Demonstrate Scroller() and RotatePalette() subroutines
'while waiting for a key press.
Restore ScrollMess2
Call Scroller(INITSCROLL, Set2Data(), Set2Index())
Do
    'Scroller() is called more often than RotatePalette() so that
    'the palette isn't rotated too quickly.
    Call Scroller(UPDATESCROLL, Set2Data(), Set2Index())
    Call Scroller(UPDATESCROLL, Set2Data(), Set2Index())
    Call RotatePalette(176, 255, ROTATERIGHT, NewPal&())
Loop While InKey$ = ""

'Fade and blank screen before ending.
Call FadePalette(FADEDOWN, NewPal&())
Cls

'Restore standard palette.
Call ChangePalette(StandardPal&())


'*** Message text for Scroller() subroutine (upper case only) ***
ScrollMess1:
Data "THIS IS A SCROLLING MESSAGE DISPLAYED USING THE SCROLLER() ROUTINE..."
Data "                    "
ScrollMess2:
Data "PRESS A KEY TO CONTINUE..."
Data "                    "
Data ""

'*** Data for images used in GAME OVER screen design ***
SDImageData:
Data 360
Data 128,16,0,0,-8448,-8225,-8225,223,0,0,0,-8448,-8225,-8739,-8739,-8225,223,0,0,-8225
Data -8739,-9253,-9253,-8739,-8225,0,-8448,-8737,-9253,-9767,-9767,-9253,-8227,223,-8448,-9251,-9767,-10538,-10538,-9767
Data -8741,223,-8225,-9251,-10535,-11052,-11052,-9770,-8741,-8225,-8737,-9765,-11050,-11564,-11054,-10540,-9255,-8227,-8737,-9765
Data -11050,-12078,-11568,-10540,-9255,-8227,-8737,-9765,-11050,-12078,-11568,-10540,-9255,-8227,-8737,-9765,-11050,-11564,-11054,-10540
Data -9255,-8227,-8225,-9251,-10535,-11052,-11052,-9770,-8741,-8225,-8448,-9251,-9767,-10538,-10538,-9767,-8741,223,-8448,-8737
Data -9253,-9767,-9767,-9253,-8227,223,0,-8225,-8739,-9253,-9253,-8739,-8225,0,0,-8448,-8225,-8739,-8739,-8225
Data 223,0,0,0,-8448,-8225,-8225,223,0,0,128,16,-1,-1,255,0,0,-256,-1,-1
Data -1,255,0,0,0,0,-256,-1,-1,0,0,0,0,0,0,-1,255,0,0,0
Data 0,0,0,-256,255,0,0,0,0,0,0,-256,0,0,0,0,0,0,0,0
Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Data 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
Data 255,0,0,0,0,0,0,-256,255,0,0,0,0,0,0,-256,-1,0,0,0
Data 0,0,0,-1,-1,255,0,0,0,0,-256,-1,-1,-1,255,0,0,-256,-1,-1
Data 112,14,-8996,-11563,-9772,-8740,-10533,-11310,-9769,-10021,-11053,-9255,-9765,-10794,-11053,-9255,-10793,-10283,-10792,-11309
Data -10027,-11050,-9000,-10796,-11050,-11309,-10797,-9254,-11563,-9003,-11309,-11821,-10542,-8998,-9250,-11308,-9002,-11049,-11566,-10798
Data -8228,-9762,-10540,-8741,-9507,-10537,-10797,-8484,-11046,-10798,-8996,-8996,-9509,-9512,-9507,-11820,-10799,-9765,-9514,-8997
Data -8483,-10788,-12079,-10029,-10791,-9517,-8996,-8226,-11301,-11311,-10283,-10795,-9259,-10022,-8484,-11303,-10541,-11306,-10029,-9255
Data -10538,-9509,-10795,-10793,-11309,-9770,-8996,-9768,-10791,-9515,-10533,-9771,-10021,-8482,-9251,-11307,-8487,-10018,-10536,-11046

'*** Alternative palette data ***
NewPaletteData:
Data 0,2752512,10752,2763264,42,2752554,5418,2763306
Data 1381653,4134165,1392405,4144917,1381695,4134207,1392447,4144959
Data 8751,271408,534065,862258,1124915,1387572,1650229,1912886
Data 2240824,2503481,2766138,3028795,3291452,3619645,3882302,4144959
Data 4128768,4128784,4128799,4128815,4128831,3080255,2031679,1048639
Data 63,4159,7999,12095,16191,16175,16159,16144
Data 16128,1064704,2047744,3096320,4144896,4140800,4136704,4132864
Data 4136735,4136743,4136751,4136759,4136767,3612479,3088191,2563903
Data 2039615,2041663,2043711,2045759,2047807,2047799,2047791,2047783
Data 2047775,2572063,3096351,3620639,4144927,4142879,4140831,4138783
Data 4140333,4140337,4140342,4140346,4140351,3812671,3550527,3222847
Data 2960703,2961727,2963007,2964031,2965311,2965306,2965302,2965297
Data 2965293,3227437,3555117,3817261,4144941,4143661,4142637,4141357
Data 1835008,1835015,1835022,1835029,1835036,1376284,917532,458780
Data 921130,986666,986667,1052203,1052459,1117996,1183532,1183532
Data 1249069,1249069,1314605,1314606,1380398,1445934,1445935,1511471
Data 1511471,1577008,1642544,1642544,1708337,1708337,1773873,1839410
Data 1839410,1904946,1904947,1970483,1970739,2036276,2101812,2101812
Data 2167349,2167349,2232885,2298422,2298678,2364214,2364215,2429751
Data 2429751,2495288,2560824,2560824,2626617,2626617,2692153,2757690
Data 2757690,2823226,2823227,2888763,2954555,2954556,3020092,3020092
Data 3085629,3085629,3151165,3216702,3216958,3282494,3282495,3348031
Data 4128768,3867648,3606528,3280128,3019008,2757888,2496768,2235648
Data 1909248,1648128,1387008,1125888,864768,538368,277248,16128
Data 16132,16136,16140,16144,16148,16152,16156,16160
Data 16163,16167,16171,16175,16179,16183,16187,16191
Data 15167,14143,13119,12095,11071,10047,9023,7999
Data 7231,6207,5183,4159,3135,2111,1087,63
Data 262207,524351,786495,1048639,1310783,1572927,1835071,2097215
Data 2293823,2555967,2818111,3080255,3342399,3604543,3866687,4128831
Data 4128827,4128823,4128819,4128815,4128811,4128807,4128803,4128799
Data 4128796,4128792,4128788,4128784,4128780,4128776,4128772,4128768

'*** GAME OVER screen design data ***
DesignData:
Data 346
Data 2,72,40,5,1,72,40,3,2,64,32,5,1,64,32,3,2,56,32,5
Data 1,56,32,3,2,48,32,5,1,48,32,3,2,40,32,5,1,40,32,3
Data 2,32,40,5,1,32,40,3,2,32,48,5,1,32,48,3,2,32,56,5
Data 1,32,56,3,2,32,64,5,1,32,64,3,2,32,72,5,1,32,72,3
Data 2,32,80,5,1,32,80,3,2,40,88,5,1,40,88,3,2,48,88,5
Data 1,48,88,3,2,56,88,5,1,56,88,3,2,64,88,5,1,64,88,3
Data 2,72,80,5,1,72,80,3,2,72,72,5,1,72,72,3,2,72,64,5
Data 1,72,64,3,2,64,64,5,1,64,64,3,2,56,64,5,1,56,64,3
Data 2,96,88,5,1,96,88,3,2,96,80,5,1,96,80,3,2,96,72,5
Data 1,96,72,3,2,96,64,5,1,96,64,3,2,96,56,5,1,96,56,3
Data 2,96,48,5,1,96,48,3,2,104,40,5,1,104,40,3,2,112,32,5
Data 1,112,32,3,2,120,32,5,1,120,32,3,2,128,40,5,1,128,40,3
Data 2,136,48,5,1,136,48,3,2,136,56,5,1,136,56,3,2,136,64,5
Data 1,136,64,3,2,136,72,5,1,136,72,3,2,136,80,5,1,136,80,3
Data 2,136,88,5,1,136,88,3,2,128,64,5,1,128,64,3,2,120,64,5
Data 1,120,64,3,2,112,64,5,1,112,64,3,2,104,64,5,1,104,64,3
Data 2,160,88,5,1,160,88,3,2,160,80,5,1,160,80,3,2,160,72,5
Data 1,160,72,3,2,160,64,5,1,160,64,3,2,160,56,5,1,160,56,3
Data 2,160,48,5,1,160,48,3,2,160,40,5,1,160,40,3,2,160,32,5
Data 1,160,32,3,2,168,40,5,1,168,40,3,2,176,48,5,1,176,48,3
Data 2,184,56,5,1,184,56,3,2,192,48,5,1,192,48,3,2,200,40,5
Data 1,200,40,3,2,208,32,5,1,208,32,3,2,208,40,5,1,208,40,3
Data 2,208,48,5,1,208,48,3,2,208,56,5,1,208,56,3,2,208,64,5
Data 1,208,64,3,2,208,72,5,1,208,72,3,2,208,80,5,1,208,80,3
Data 2,208,88,5,1,208,88,3,2,232,32,5,1,232,32,3,2,232,40,5
Data 1,232,40,3,2,232,48,5,1,232,48,3,2,232,56,5,1,232,56,3
Data 2,232,64,5,1,232,64,3,2,232,72,5,1,232,72,3,2,232,80,5
Data 1,232,80,3,2,232,88,5,1,232,88,3,2,240,88,5,1,240,88,3
Data 2,248,88,5,1,248,88,3,2,256,88,5,1,256,88,3,2,264,88,5
Data 1,264,88,3,2,272,88,5,1,272,88,3,2,240,32,5,1,240,32,3
Data 2,248,32,5,1,248,32,3,2,256,32,5,1,256,32,3,2,264,32,5
Data 1,264,32,3,2,272,32,5,1,272,32,3,2,240,64,5,1,240,64,3
Data 2,248,64,5,1,248,64,3,2,256,64,5,1,256,64,3,2,264,64,5
Data 1,264,64,3,2,68,112,5,1,68,112,3,2,60,112,5,1,60,112,3
Data 2,52,112,5,1,52,112,3,2,44,112,5,1,44,112,3,2,36,120,5
Data 1,36,120,3,2,36,128,5,1,36,128,3,2,36,136,5,1,36,136,3
Data 2,36,144,5,1,36,144,3,2,36,152,5,1,36,152,3,2,36,160,5
Data 1,36,160,3,2,44,168,5,1,44,168,3,2,52,168,5,1,52,168,3
Data 2,60,168,5,1,60,168,3,2,68,168,5,1,68,168,3,2,76,160,5
Data 1,76,160,3,2,76,152,5,1,76,152,3,2,76,144,5,1,76,144,3
Data 2,76,136,5,1,76,136,3,2,76,128,5,1,76,128,3,2,76,120,5
Data 1,76,120,3,2,100,112,5,1,100,112,3,2,100,120,5,1,100,120,3
Data 2,100,128,5,1,100,128,3,2,100,136,5,1,100,136,3,2,100,144,5
Data 1,100,144,3,2,100,152,5,1,100,152,3,2,108,160,5,1,108,160,3
Data 2,116,168,5,1,116,168,3,2,124,168,5,1,124,168,3,2,132,160,5
Data 1,132,160,3,2,140,152,5,1,140,152,3,2,140,144,5,1,140,144,3
Data 2,140,136,5,1,140,136,3,2,140,128,5,1,140,128,3,2,140,120,5
Data 1,140,120,3,2,140,112,5,1,140,112,3,2,164,112,5,1,164,112,3
Data 2,164,120,5,1,164,120,3,2,164,128,5,1,164,128,3,2,164,136,5
Data 1,164,136,3,2,164,144,5,1,164,144,3,2,164,152,5,1,164,152,3
Data 2,164,160,5,1,164,160,3,2,164,168,5,1,164,168,3,2,172,168,5
Data 1,172,168,3,2,180,168,5,1,180,168,3,2,188,168,5,1,188,168,3
Data 2,196,168,5,1,196,168,3,2,204,168,5,1,204,168,3,2,172,112,5
Data 1,172,112,3,2,180,112,5,1,180,112,3,2,188,112,5,1,188,112,3
Data 2,196,112,5,1,196,112,3,2,204,112,5,1,204,112,3,2,172,144,5
Data 1,172,144,3,2,180,144,5,1,180,144,3,2,188,144,5,1,188,144,3
Data 2,196,144,5,1,196,144,3,2,236,112,5,1,236,112,3,2,244,112,5
Data 1,244,112,3,2,252,112,5,1,252,112,3,2,260,112,5,1,260,112,3
Data 2,268,120,5,1,268,120,3,2,268,128,5,1,268,128,3,2,268,136,5
Data 1,268,136,3,2,260,144,5,1,260,144,3,2,252,144,5,1,252,144,3
Data 2,244,144,5,1,244,144,3,2,236,144,5,1,236,144,3,2,268,168,5
Data 1,268,168,3,2,260,160,5,1,260,160,3,2,252,152,5,1,252,152,3
Data 2,228,112,5,1,228,112,3,2,228,120,5,1,228,120,3,2,228,128,5
Data 1,228,128,3,2,228,136,5,1,228,136,3,2,228,144,5,1,228,144,3
Data 2,228,152,5,1,228,152,3,2,228,160,5,1,228,160,3,2,228,168,5
Data 1,228,168,3,3,0,38,1,3,0,52,1,3,0,66,1,3,0,80,1
Data 3,0,94,1,3,0,108,1,3,0,122,1,3,0,136,1,3,0,150,1
Data 3,0,164,1,3,306,38,1,3,306,52,1,3,306,66,1,3,306,80,1
Data 3,306,94,1,3,306,108,1,3,306,122,1,3,306,136,1,3,306,150,1
Data 3,306,164,1

'* ChangePalette() subroutine:
'* Quickly changes the current colour palette to the colours held in
'* a palette array.
'*
'* Parameters:
'* PaletteArray&() - Long integer array holding the colours to be used as
'*                   the new colour palette. This array must have previously
'*                   been initialized by calling InitPaletteData().
'*
Sub ChangePalette (PaletteArray&())

    'Break down all 256 colours into their RGB values.
    Dim RGBval(0 To 255, 0 To 2)
    For n = 0 To 255
        c& = PaletteArray&(n)
        b = c& \ 65536: c& = c& - b * 65536
        g = c& \ 256: c& = c& - g * 256
        r = c&
        RGBval(n, 0) = r
        RGBval(n, 1) = g
        RGBval(n, 2) = b
    Next n

    'Write colours directly to the video card.
    Wait &H3DA, &H8, &H8: Wait &H3DA, &H8
    For n = 0 To 255
        Out &H3C8, n 'Select attribute.
        Out &H3C9, RGBval(n, 0) 'Write red.
        Out &H3C9, RGBval(n, 1) 'Write green.
        Out &H3C9, RGBval(n, 2) 'Write blue.
    Next n

End Sub

'* CharPrint() subroutine:
'* Displays a text string using a character set designed with PIXELplus 256.
'* Text can be displayed using both a foreground and background colour, or
'* can be overprinted on the existing screen image using the foreground
'* colour.
'*
'* Parameters:
'*        Text$ - The text string to be displayed.
'*         Fore - The foreground colour to display text in.
'*         Back - The background colour to display text in or use OVERPRINT
'*                to have the text overprinted on the existing screen image.
'*    CursorPos - Dictates where the text cursor should be left after
'*                the text has been displayed:
'*                Use NEWLINE to move the cursor to the start of a new line.
'*                Use TEXTEND to leave the cursor directly after the last
'*                character displayed.
'* ImageArray() - Image array holding the character set to be used. Each
'*                character must be an 8x8 image and be in the standard
'*                ASCII order, starting with the space character.
'*
Sub CharPrint (Text$, Fore, Back, CursorPos, ImageArray())

    'Create an 8x8 image array to build a character in.
    Dim NewChar(1 To 34)
    NewChar(1) = 64: NewChar(2) = 8
   
    'Convert text cursor position to graphics (x,y) coordinates.
    x = (Pos(0) - 1) * 8: y = (CsrLin - 1) * 8

    'Get high byte equivalent of Fore & Back colours.
    HighFore = 0: HighBack = 0
    Def Seg = VarSeg(HighFore)
    Poke VarPtr(HighFore) + 1, Fore
    Def Seg = VarSeg(HighBack)
    Poke VarPtr(HighBack) + 1, Back
    Def Seg

    If Back = OVERPRINT Then
        '*** Overprint text onto existing screen image ***

        'Loop to build and display each character of Text$.
        For j = 1 To Len(Text$)
            Get (x, y)-Step(7, 7), NewChar(1)

            BasePtr = (Asc(Mid$(Text$, j, 1)) - 32) * 34

            'Build new character image in NewChar().
            For n = 3 To 34
                PixPair = ImageArray(BasePtr + n)

                If (PixPair And &HFF) Then
                    LowByte = Fore
                Else
                    LowByte = NewChar(n) And &HFF
                End If

                If (PixPair And &HFF00) Then
                    NewChar(n) = HighFore Or LowByte
                Else
                    NewChar(n) = (NewChar(n) And &HFF00) Or LowByte
                End If
            Next n

            'Display the character.
            Put (x, y), NewChar(1), PSet

            'Find screen coordinates for next character.
            If x = 312 Then
                x = 0
                If y <> 192 Then y = y + 8
            Else
                x = x + 8
            End If
        Next j
    Else
        '*** Display text using foreground & background colours ***

        'Loop to build and display each character of Text$.
        For j = 1 To Len(Text$)
            BasePtr = (Asc(Mid$(Text$, j, 1)) - 32) * 34

            'Build new character image in NewChar().
            For n = 3 To 34
                PixPair = ImageArray(BasePtr + n)

                If (PixPair And &HFF) Then
                    LowByte = Fore
                Else
                    LowByte = Back
                End If

                If (PixPair And &HFF00) Then
                    NewChar(n) = HighFore Or LowByte
                Else
                    NewChar(n) = HighBack Or LowByte
                End If
            Next n

            'Display the character.
            Put (x, y), NewChar(1), PSet

            'Find screen coordinates for next character.
            If x = 312 Then
                x = 0
                If y <> 192 Then y = y + 8
            Else
                x = x + 8
            End If
        Next j
    End If

    'Update text cursor to required position before exiting.
    c = (x \ 8) + 1: r = (y \ 8) + 1
    If CursorPos = NEWLINE Then
        'Check a new line is actually required.
        If c <> 1 Then
            c = 1
            If r < 25 Then r = r + 1
        End If
    End If
    Locate r, c

End Sub

'* CharPrintXY() subroutine:
'* Displays a text string at a graphics screen coordinate, using a character
'* set designed with PIXELplus 256. Text can be displayed using both a
'* foreground and background colour, or can be overprinted on the existing
'* screen image using the foreground colour.
'*
'* Parameters:
'*            x - Horizontal coordinate of where printing should start or:
'*                Use FROMCURSOR to use the current graphics cursor X
'*                coordinate.
'*                Use CENTRETEXT to have the text centred.
'*            y - Vertical coordinate of where printing should start or
'*                use FROMCURSOR to use the current graphics cursor Y
'*                coordinate.
'*        Text$ - The text string to be displayed.
'*         Fore - The foreground colour to display text in.
'*         Back - The background colour to display text in or use OVERPRINT
'*                to have the text overprinted on the existing screen image.
'*    CursorPos - Dictates where the graphics cursor should be left after
'*                the text has been displayed:
'*                Use NEWLINE to move the cursor to the start of a new line.
'*                Use TEXTEND to leave the cursor directly after the last
'*                character displayed.
'* ImageArray() - Image array holding the character set to be used. Each
'*                character must be an 8x8 image and be in the standard
'*                ASCII order, starting with the space character.
'*
Sub CharPrintXY (x, y, Text$, Fore, Back, CursorPos, ImageArray())

    MessLen = Len(Text$)
    If x = CENTRETEXT Then
        'Find start X coordinate for centred text.
        w = MessLen * 8
        x = (320 - w) \ 2
    ElseIf x = FROMCURSOR Then
        'Use current X coordinate.
        x = Point(0)
    End If

    'Use current Y coordinate if requested.
    If y = FROMCURSOR Then y = Point(1)

    'Create an 8x8 image array to build a character in.
    Dim NewChar(1 To 34)
    NewChar(1) = 64: NewChar(2) = 8

    'Get high byte equivalent of Fore & Back colours.
    HighFore = 0: HighBack = 0
    Def Seg = VarSeg(HighFore)
    Poke VarPtr(HighFore) + 1, Fore
    Def Seg = VarSeg(HighBack)
    Poke VarPtr(HighBack) + 1, Back
    Def Seg

    If Back = OVERPRINT Then
        '*** Overprint text onto existing screen image ***

        'Loop to build and display each character of Text$.
        For j = 1 To Len(Text$)
            Get (x, y)-Step(7, 7), NewChar(1)

            BasePtr = (Asc(Mid$(Text$, j, 1)) - 32) * 34

            'Build new character image in NewChar().
            For n = 3 To 34
                PixPair = ImageArray(BasePtr + n)

                If (PixPair And &HFF) Then
                    LowByte = Fore
                Else
                    LowByte = NewChar(n) And &HFF
                End If

                If (PixPair And &HFF00) Then
                    NewChar(n) = HighFore Or LowByte
                Else
                    NewChar(n) = (NewChar(n) And &HFF00) Or LowByte
                End If
            Next n

            'Display the character.
            Put (x, y), NewChar(1), PSet

            'Find screen coordinates for next character.
            If x >= 305 Then
                x = 0
                If y >= 185 Then y = 192 Else y = y + 8
            Else
                x = x + 8
            End If
        Next j
    Else
        '*** Display text using foreground & background colours ***

        'Loop to build and display each character of Text$.
        For j = 1 To Len(Text$)
            BasePtr = (Asc(Mid$(Text$, j, 1)) - 32) * 34

            'Build new character image in NewChar().
            For n = 3 To 34
                PixPair = ImageArray(BasePtr + n)

                If (PixPair And &HFF) Then
                    LowByte = Fore
                Else
                    LowByte = Back
                End If

                If (PixPair And &HFF00) Then
                    NewChar(n) = HighFore Or LowByte
                Else
                    NewChar(n) = HighBack Or LowByte
                End If
            Next n

            'Display the character.
            Put (x, y), NewChar(1), PSet

            'Find screen coordinates for next character.
            If x >= 305 Then
                x = 0
                If y >= 185 Then y = 192 Else y = y + 8
            Else
                x = x + 8
            End If
        Next j
    End If

    'Update graphics cursor to required position before exiting.
    If CursorPos = NEWLINE Then
        'Check a new line is actually required.
        If x <> 0 Then
            x = 0
            If y < 185 Then y = y + 8
        End If
    End If
    PSet (x, y), Point(x, y)

End Sub

'* DisplayDesign() subroutine:
'* Displays the screen design held in DesignArray() using the images held
'* in ImageArray().
'*
'* Parameters:
'* DesignArray() - Dynamic, DesignType array holding screen design data.
'*  ImageArray() - Dynamic, integer array holding the images to use for
'*                 displaying the screen design.
'*  IndexArray() - Dynamic, integer array holding the index for images in
'*                 ImageArray().
'*     ClsAction - A non-zero value causes the screen to be cleared before
'*                 the screen design is displayed.
'*
Sub DisplayDesign (DesignArray() As DesignType, ImageArray(), ImageIndex(), ClsAction)

    'Only clear the screen if requested to.
    If ClsAction Then Cls

    LastItem = UBound(DesignArray)

    'Loop to display all items in the screen design.
    For n = 1 To LastItem
        ImageNo = DesignArray(n).ImageNo
        Xpos = DesignArray(n).Xpos
        Ypos = DesignArray(n).Ypos
        DisAct = DesignArray(n).DisAct

        'Mask-out high byte of DisAct to find display action code.
        Select Case (DisAct And &HFF)
            Case 1
                Put (Xpos, Ypos), ImageArray(ImageIndex(ImageNo)), PSet
            Case 2
                Put (Xpos, Ypos), ImageArray(ImageIndex(ImageNo)), PReset
            Case 3
                Put (Xpos, Ypos), ImageArray(ImageIndex(ImageNo)), Or
            Case 4
                Put (Xpos, Ypos), ImageArray(ImageIndex(ImageNo)), Xor
            Case 5
                Put (Xpos, Ypos), ImageArray(ImageIndex(ImageNo)), And
        End Select
    Next n

End Sub

'* FadePalette() subroutine:
'* Gradually fades the current display in or out by fading all the colours in
'* the currently active palette down (fade to black) or up (restore colours).
'*
'* Parameters:
'*       Direction - Dictates what direction the currently active colour
'*                   palette should be faded in:
'*                   Use FADEDOWN to fade down all colours to black.
'*                   Use FADEUP to fade up all colours from black to their
'*                   true colours.
'* PaletteArray&() - Palette array holding the colours of the currently
'*                   active colour palette.
'*
Sub FadePalette (Direction, PaletteArray&())

    If Direction = FADEDOWN Then
        '*** Fade palette down ***

        'Break down all 256 colours into their RGB values and
        'calculate how much each will need fading down by.
        Dim RGBval!(0 To 255, 0 To 2)
        Dim SubVal!(0 To 255, 0 To 2)
        For n = 0 To 255
            c& = PaletteArray&(n)
            b = c& \ 65536: c& = c& - b * 65536
            g = c& \ 256: c& = c& - g * 256
            r = c&
            RGBval!(n, 0) = r
            RGBval!(n, 1) = g
            RGBval!(n, 2) = b
            SubVal!(n, 0) = r / 63
            SubVal!(n, 1) = g / 63
            SubVal!(n, 2) = b / 63
        Next n

        'Fade down all 256 colours in 63 steps.
        For j = 1 To 63
            'Calculate new faded down RGB values.
            For n = 0 To 255
                RGBval!(n, 0) = RGBval!(n, 0) - SubVal!(n, 0)
                RGBval!(n, 1) = RGBval!(n, 1) - SubVal!(n, 1)
                RGBval!(n, 2) = RGBval!(n, 2) - SubVal!(n, 2)
            Next n

            'Write faded down colours directly to the video card.
            Wait &H3DA, &H8, &H8: Wait &H3DA, &H8
            For n = 0 To 255
                Out &H3C8, n 'Select attribute.
                Out &H3C9, RGBval!(n, 0) 'Write red.
                Out &H3C9, RGBval!(n, 1) 'Write green.
                Out &H3C9, RGBval!(n, 2) 'Write blue.
            Next n
        Next j
    Else
        '*** Fade palette up ***

        'Break down all 256 colours into their RGB values and
        'calculate how much each will need fading up by.
        Dim RGBval!(0 To 255, 0 To 2)
        Dim AddVal!(0 To 255, 0 To 2)
        For n = 0 To 255
            c& = PaletteArray&(n)
            b = c& \ 65536: c& = c& - b * 65536
            g = c& \ 256: c& = c& - g * 256
            r = c&
            AddVal!(n, 0) = r / 63
            AddVal!(n, 1) = g / 63
            AddVal!(n, 2) = b / 63
        Next n

        'Fade up all 256 colours in 63 steps.
        For j = 1 To 63
            'Calculate new faded up RGB values.
            For n = 0 To 255
                RGBval!(n, 0) = RGBval!(n, 0) + AddVal!(n, 0)
                RGBval!(n, 1) = RGBval!(n, 1) + AddVal!(n, 1)
                RGBval!(n, 2) = RGBval!(n, 2) + AddVal!(n, 2)
            Next n

            'Write faded up colours directly to the video card.
            Wait &H3DA, &H8, &H8: Wait &H3DA, &H8
            For n = 0 To 255
                Out &H3C8, n 'Select attribute.
                Out &H3C9, RGBval!(n, 0) 'Write red.
                Out &H3C9, RGBval!(n, 1) 'Write green.
                Out &H3C9, RGBval!(n, 2) 'Write blue.
            Next n
        Next j
    End If

End Sub

'* GetDepth() function:
'* Returns the depth (in pixels) of any image contained in an image array.
'*
'* Parameters:
'*         ImNo - The number of the image to return the depth of.
'* ImageArray() - Image array that contains the image.
'* IndexArray() - Index array for the images in ImageArray().
'*
Function GetDepth (ImNo, ImageArray(), IndexArray())

    GetDepth = ImageArray(IndexArray(ImNo) + 1)

End Function

'* GetWidth() function:
'* Returns the width (in pixels) of any image contained in an image array.
'*
'* Parameters:
'*         ImNo - The number of the image to return the width of.
'* ImageArray() - Image array that contains the image.
'* IndexArray() - Index array for the images in ImageArray().
'*
Function GetWidth (ImNo, ImageArray(), IndexArray())

    GetWidth = ImageArray(IndexArray(ImNo)) \ 8

End Function

'* GraphicText() subroutine:
'* Displays a text string at a graphics screen coordinate, using a bitmapped
'* character set.
'*
'* Parameters:
'*            x - Horizontal coordinate of where printing should start or:
'*                Use FROMCURSOR to use the current graphics cursor X
'*                coordinate.
'*                Use CENTRETEXT to have the text centred.
'*            y - Vertical coordinate of where printing should start or
'*                use FROMCURSOR to use the current graphics cursor Y
'*                coordinate.
'*        Text$ - The text string to be displayed.
'*    CursorPos - Dictates where the graphics cursor should be left after
'*                the text has been displayed:
'*                Use NEWLINE to move the cursor to the start of a new line.
'*                Use TEXTEND to leave the cursor directly after the last
'*                character displayed.
'* ImageArray() - Image array holding the character set to be used. Each
'*                character must in the standard ASCII order, starting with
'*                the space character.
'* IndexArray() - Index array for the character images in ImageArray().
'*
Sub GraphicText (x, y, Text$, CursorPos, ImageArray(), IndexArray())

    MessLen = Len(Text$)
    If x = CENTRETEXT Then
        'Find start X coordinate for centred text.
        w = 0
        For n = 1 To MessLen
            CharNo = Asc(Mid$(Text$, n, 1)) - 31
            w = w + GetWidth(CharNo, ImageArray(), IndexArray())
        Next n
        x = (320 - w) \ 2
    ElseIf x = FROMCURSOR Then
        'Use current X coordinate.
        x = Point(0)
    End If

    'Use current Y coordinate if requested.
    If y = FROMCURSOR Then y = Point(1)

    CharDepth = GetDepth(1, ImageArray(), IndexArray())

    'Loop to display each character of Text$.
    For n = 1 To MessLen
        CharNo = Asc(Mid$(Text$, n, 1)) - 31
        CharWidth = GetWidth(CharNo, ImageArray(), IndexArray())

        'Screen coordinate management for current character.
        If x + CharWidth > 320 Then
            x = 0
            If (y + CharDepth + CharDepth - 1) > 199 Then
                y = 200 - CharDepth
            Else
                y = y + CharDepth
            End If
        End If

        Put (x, y), ImageArray(IndexArray(CharNo)), PSet
        x = x + CharWidth
    Next n

    'Ensure x and y are valid screen coordinates.
    If x > 319 Then
        x = 0
        If (y + CharDepth + CharDepth - 1) > 199 Then
            y = 200 - CharDepth
        Else
            y = y + CharDepth
        End If
    End If

    'Update graphics cursor to required position before exiting.
    If CursorPos = NEWLINE Then
        'Check a new line is actually required.
        If x <> 0 Then
            x = 0
            If (y + CharDepth + CharDepth - 1) > 199 Then
                y = 200 - CharDepth
            Else
                y = y + CharDepth
            End If
        End If
    End If
    PSet (x, y), Point(x, y)

End Sub

'* InitDesignData() subroutine:
'* Initializes a DesignType array with screen design data - this must be done
'* before displaying a screen design using the DisplayDesign() routine. The
'* calling value of FileName$ dictates whether the data should be read
'* directly from a screen design file or from DATA statements (see below).
'*
'* Parameters:
'*     FileName$ - The name of the screen design file to load. This must
'*                 include the path to the file if it does not reside in the
'*                 current directory. If FileName$ is an empty string (""),
'*                 screen design data is read from DATA statements.
'* DesignArray() - Dynamic, DesignType array to hold the screen design data.
'*
'* Note: Before calling InitDesignData() to initialize a screen design from
'*       DATA statements, use an appropriate RESTORE statement to ensure the
'*       correct DATA statements are read.
'*
Sub InitDesignData (FileName$, DesignArray() As DesignType)

    If FileName$ <> "" Then
        '***** Read screen design data from file *****

        'Establish size of DesignType array required.
        FileNo = FreeFile
        Open FileName$ For Binary As #FileNo
        ItemCount = (LOF(FileNo) - 7) \ 8
        Close #FileNo
        ReDim DesignArray(0 To ItemCount) As DesignType

        'Load screen design data directly into array memory.
        Def Seg = VarSeg(DesignArray(0))
        BLoad FileName$, 0
        Def Seg
    Else
        '***** Read screen design data from DATA statements *****

        'Establish size of DesignType array required.
        Read ItemCount
        ReDim DesignArray(0 To ItemCount) As DesignType

        'READ screen design DATA into array.
        For n = 1 To ItemCount
            Read ImageNo, Xpos, Ypos, DisAct
            DesignArray(n).ImageNo = ImageNo
            DesignArray(n).Xpos = Xpos
            DesignArray(n).Ypos = Ypos
            DesignArray(n).DisAct = DisAct
        Next n
    End If

End Sub

'* InitImageData() subroutine:
'* Initializes an integer array with image data - this must be done before
'* displaying an image using the PUT(graphics) statement. The calling value
'* of FileName$ dictates whether the data should be read directly from an
'* image file or from DATA statements (see below).
'*
'* Parameters:
'*    FileName$ - The name of the image file to load. This must include the
'*                path to the file if it does not reside in the current
'*                directory. If FileName$ is an empty string (""), image
'*                data is read from DATA statements.
'* ImageArray() - Dynamic, integer array to hold the image data.
'*
'* Note: Before calling InitImageData() to initialize images from DATA
'*       statements, use an appropriate RESTORE statement to ensure the
'*       correct DATA statements are read.
'*
Sub InitImageData (FileName$, ImageArray())

    If FileName$ <> "" Then
        '***** Read image data from file *****

        'Establish size of integer array required.
        FileNo = FreeFile
        Open FileName$ For Binary As #FileNo
        Ints = (LOF(FileNo) - 7) \ 2
        Close #FileNo
        ReDim ImageArray(1 To Ints)

        'Load image data directly into array memory.
        Def Seg = VarSeg(ImageArray(1))
        BLoad FileName$, 0
        Def Seg
    Else
        '***** Read image data from DATA statements *****

        'Establish size of integer array required.
        Read IntCount
        ReDim ImageArray(1 To IntCount)

        'READ image DATA into array.
        For n = 1 To IntCount
            Read x
            ImageArray(n) = x
        Next n
    End If

End Sub

'* InitPaletteData() subroutine:
'* Initializes a long integer array with palette colour data - this must be
'* done before changing palettes with the PALETTE USING statement. The
'* calling value of FileName$ dictates whether the data should be read
'* directly from a palette file or from DATA statements (see below).
'*
'* Parameters:
'*       FileName$ - The name of the palette file to load. This must include
'*                   the path to the file if it does not reside in the
'*                   current directory. If FileName$ is an empty string (""),
'*                   palette data is read from DATA statements.
'* PaletteArray&() - Dynamic, long integer array to hold palette data.
'*
'* Note: Before calling InitPaletteData() to initialize a palette from DATA
'*       statements, use an appropriate RESTORE statement to ensure the
'*       correct DATA statements are read.
'*
Sub InitPaletteData (FileName$, PaletteArray&())

    'Size array to hold all 256 colours.
    ReDim PaletteArray&(0 To 255)

    If FileName$ <> "" Then
        '*** Read palette data from file ***
        FileNo = FreeFile
        Open FileName$ For Binary As #FileNo
        For n = 0 To 255
            Get #FileNo, , colour&
            PaletteArray&(n) = colour&
        Next n
        Close #FileNo
    Else
        '*** Read palette data from DATA statements ***
        For n = 0 To 255
            Read colour&
            PaletteArray&(n) = colour&
        Next n
    End If

End Sub

'* MakeImageIndex() subroutine:
'* Constructs an image position index for the images held in an image array.
'*
'* Parameters:
'* ImageArray() - Dynamic, integer array holding images to be indexed.
'* IndexArray() - Dynamic, integer array to hold the index for images in
'*                ImageArray().
'*
Sub MakeImageIndex (ImageArray(), IndexArray())

    'The index will initially be built in a temporary array, allowing
    'for the maximum 1000 images per file.
    Dim Temp(1 To 1000)
    Ptr& = 1: IndexNo = 1: LastInt = UBound(ImageArray)
    Do
        Temp(IndexNo) = Ptr&
        IndexNo = IndexNo + 1

        'Evaluate descriptor of currently referenced image to
        'calculate the beginning of the next image.
        x& = (ImageArray(Ptr&) \ 8) * (ImageArray(Ptr& + 1)) + 4
        If x& Mod 2 Then x& = x& + 1
        Ptr& = Ptr& + (x& \ 2)
    Loop While Ptr& < LastInt

    LastImage = IndexNo - 1

    'Copy the image index values into the actual index array.
    ReDim IndexArray(1 To LastImage)
    For n = 1 To LastImage
        IndexArray(n) = Temp(n)
    Next n

End Sub

'* RotatePalette() subroutine:
'* Rotates a contiguous range of colour attributes in the currently
'* active palette to the left or right.
'*
'* Parameters:
'*       StartAttr - First attribute of the range to be rotated.
'*         EndAttr - Last attribute of the range to be rotated.
'*       Direction - Dictates what direction the selected colours should
'*                   be rotated in:
'*                   Use ROTATELEFT to rotate colours to the left.
'*                   Use ROTATERIGHT to rotate colours to the right.
'* PaletteArray&() - Palette array holding the colours of the currently
'*                   active colour palette.
'*
Sub RotatePalette (StartAttr, EndAttr, Direction, PaletteArray&())

    'Rotate affected colours in PaletteArray&() in the requested direction.
    If Direction = ROTATERIGHT Then
        '*** Rotate right ***
        Lastc& = PaletteArray&(EndAttr)
        For n = EndAttr To StartAttr + 1 Step -1
            PaletteArray&(n) = PaletteArray&(n - 1)
        Next n
        PaletteArray&(StartAttr) = Lastc&
    Else
        '*** Rotate left ***
        Lastc& = PaletteArray&(StartAttr)
        For n = StartAttr To EndAttr - 1
            PaletteArray&(n) = PaletteArray&(n + 1)
        Next n
        PaletteArray&(EndAttr) = Lastc&
    End If

    'Break down the colours into their RGB values.
    Dim RGBval(StartAttr To EndAttr, 0 To 2)
    For n = StartAttr To EndAttr
        c& = PaletteArray&(n)
        b = c& \ 65536: c& = c& - b * 65536
        g = c& \ 256: c& = c& - g * 256
        r = c&
        RGBval(n, 0) = r
        RGBval(n, 1) = g
        RGBval(n, 2) = b
    Next n

    'Write colours directly to the video card.
    Wait &H3DA, &H8, &H8: Wait &H3DA, &H8
    For n = StartAttr To EndAttr
        Out &H3C8, n 'Select attribute.
        Out &H3C9, RGBval(n, 0) 'Write red.
        Out &H3C9, RGBval(n, 1) 'Write green.
        Out &H3C9, RGBval(n, 2) 'Write blue.
    Next n
    
End Sub

'* Scroller() subroutine:
'* Displays a scrolling message along the bottom of the screen, using a
'* bitmapped character set.
'*
'* Parameters:
'*    ScrollAct - Dictates what action should be done:
'*                Use INITSCROLL to initialize a new scroller message.
'*                Use UPDATESCROLL to update the scroller display.
'* ImageArray() - Image array holding the character set to be used. Each
'*                character must be a 16x8 image and be in the standard
'*                ASCII order, starting with the space character.
'* IndexArray() - Index array for the character images in ImageArray().
'*
'* Note: Before calling Scroller() to initialize a new scrolling message
'*       from DATA statements, use an appropriate RESTORE statement to
'*       ensure the correct DATA statements are read.
'*
Sub Scroller (ScrollAct, ImageArray(), IndexArray())

    'Retain variable settings between calls.
    Static MessChar(), FirstX, CharPtr, MessLen, ScrollMess$

    If ScrollAct = INITSCROLL Then
        '*** Initialize scroller ***
        ReDim MessChar(1 To 19)
        For n = 1 To 19: MessChar(n) = 1: Next n

        'Read entire scroller text into ScrollMess$ from module-level DATA.
        ScrollMess$ = ""
        Do
            Read x$
            ScrollMess$ = ScrollMess$ + x$
        Loop Until x$ = ""

        MessLen = Len(ScrollMess$)
        CharPtr = 1
        FirstX = 16
    Else
        '*** Update scroller message display ***
        x = FirstX
        Wait &H3DA, &H8, &H8: Wait &H3DA, &H8
        For n = 1 To 19
            Put (x, 192), ImageArray(MessChar(n)), PSet
            x = x + 16
        Next n

        'Display two end characters (spaces) to tidy up message appearance.
        Put (0, 192), ImageArray(IndexArray(1)), PSet
        Put (304, 192), ImageArray(IndexArray(1)), PSet

        'Variable management ready for next Scroller(UPDATESCROLL) call.
        FirstX = FirstX - 2
        If FirstX = 0 Then
            FirstX = 16
            For n = 1 To 18
                MessChar(n) = MessChar(n + 1)
            Next n

            If CharPtr > MessLen Then CharPtr = 1
            MessChar(19) = IndexArray(Asc(Mid$(ScrollMess$, CharPtr, 1)) - 31)
            CharPtr = CharPtr + 1
        End If
    End If

End Sub

'* WizzText() subroutine:
'* Centres a single line of text on the screen using a bitmapped character
'* set. Each character is whizzed across the screen in turn (from right to
'* left) to it's destination position.
'*
'* Parameters:
'*        Text$ - The single line text message to be displayed.
'*      TopLine - Screen Y coordinate to be the top line for the displayed
'*                text message.
'* ImageArray() - Image array holding the character set to be used. Each
'*                character must be a 16x8 image and be in the standard
'*                ASCII order, starting with the space character.
'* IndexArray() - Index array for the character images in ImageArray().
'*
Sub WizzText (Text$, TopLine, ImageArray(), IndexArray())

    'Calculate X coordinate for first character.
    MessLen = Len(Text$)
    HomeX = (320 - (MessLen * 16)) \ 2

    'Loop to display each character of Text$.
    For n = 1 To MessLen
        x$ = Mid$(Text$, n, 1)

        'Ignore space characters.
        If x$ <> Chr$(32) Then
            CharIdx = IndexArray(Asc(x$) - 31)
            OldX = 304

            'Move character across the screen to destination position.
            For x = 304 To HomeX Step -8
                Wait &H3DA, &H8, &H8: Wait &H3DA, &H8
                Line (OldX, TopLine)-Step(15, 7), 0, BF
                Put (x, TopLine), ImageArray(CharIdx), PSet
                OldX = x
            Next x
        End If

        HomeX = HomeX + 16
    Next n
    
End Sub

