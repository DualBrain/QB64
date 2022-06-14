REM Programming Combined Panels
REM \CHAP13\CH13_12.BAS

DECLARE SUB Answer (X0, Y0, LX, MaxLText, Text$, NumberText$)
DECLARE SUB Box (Row1%, Col1%, row2%, Col2%)
DECLARE SUB BoxDouble (Row1%, Col1%, row2%, Col2%)
DECLARE SUB ChoiceFields ()
DECLARE SUB ControlPanel ()
DECLARE SUB DemoText ()
DECLARE SUB FieldOpToSelect (RowField%, ColField%)
DECLARE SUB FileToProject (MaxRow%, Row1%, Col1%, RowField%, ColField%)
DECLARE SUB FileToSelect (MaxRow%, Row1%, Col1%, RowField%, ColField%)
DECLARE SUB Initialize ()
DECLARE SUB InitProject ()
DECLARE SUB InitSelect ()
DECLARE SUB PrintConditionals (CurRow%, CurCol%)
DECLARE SUB PrintMenuMain (Titl$(), Max%, Row1%, Col1%)
DECLARE SUB PrintMultiChoice (Tit$, Titl$(), Max%, Row1%, Col1%, BitPos%())
DECLARE SUB PrintWindow (Titl$(), Max%, RowH%, Row1%, Col1%)
DECLARE SUB PopUpWindow (Row1%, Coll1%, row2%, Coll2%)
DECLARE SUB PosMultiChoice (Tit$, Titl$(), Max%, Row1%, Col1%, BitPos%())
DECLARE SUB ResultProject ()
DECLARE SUB ResultSelect ()
DECLARE SUB SortAndOther ()

DECLARE FUNCTION MaxLen% (Array$(), MaxCol%)
DECLARE FUNCTION Number (Txt$)
DECLARE FUNCTION PosChoice% (Titl1$, Titl$(), Max%, Row1%, Col1%, CurPos%)
DECLARE FUNCTION PosMenuMain% (Titl$(), Max%, Row1%, Col1%, CurPos%)
DECLARE FUNCTION PosMenuWin% (Titl$(), Max%, Row1%, Col1%, CurPos%)

CONST TRUE = -1
CONST FALSE = NOT TRUE

DIM SHARED HelpMenu$(10)
DIM SHARED MenuW$(13), Menu$(13), PosFd%(13)
DIM SHARED ChoiFd$(20), ChoiceF$(20), ChoicOp$(20)
DIM SHARED PosFlds(3), PosOprs(3), Values$(3)
DIM SHARED PosFld%, PosOp%, PosF%, PosM%, PosW%
DIM SHARED MaxPos%, Key$, Titl1$, Titl2$, Titl3$
DIM SHARED Color1, Color2, Color3
DIM SHARED NumChoice, FinishMenu, FinishWindow

'F1 activates a pop-up help window
ON KEY(1) GOSUB F1help
KEY(1) ON

Initialize                         'Initialize program
ControlPanel                       'This is the main program
END

F1help:
'Activation of the pop-up help window
'parameters - coordinates of the window
    PopUpWindow 11, 21, 21, 61
    RETURN

SUB Answer (X0, Y0, LX, MaxLText, Text$, NumberText$)
' *******************************************
' * Entering a number or a character string *
' *******************************************
' NumberText$ = "Number" - entering number
' NumberText$ = "Text" - entering text
' X0, Y0 - coordinates of start of entry zone
' LX - length of entry zone  ( LX <= MaxLText )
' MaxLText - maximal length of the string to enter
' Text$ - result of entry

CI = 14                             'color of display
CB = 1                              'color background
GOSUB Init
GOSUB OnScreen
DO
  DO
    L$ = INKEY$
  LOOP WHILE L$ = ""
  SELECT CASE L$
  CASE CHR$(0) + CHR$(82)          'Ins
    GOSUB Insert
  CASE CHR$(0) + CHR$(83)          'Del
    GOSUB Delete
  CASE CHR$(0) + CHR$(75)          'Cursor-left
    GOSUB CursorLeft
  CASE CHR$(0) + CHR$(77)          'Cursor-right
    GOSUB CursorRight
  CASE CHR$(0) + CHR$(71)          'Home
    GOSUB Home
  CASE CHR$(0) + CHR$(79)          'End
    GOSUB End1
  CASE CHR$(8)                     'BackSpace
    GOSUB BackSpace
  CASE CHR$(13), CHR$(9)           'Enter, Tab
    IF NumberText$ = "Text" THEN
      Text$ = RTRIM$(Text$)
      LOCATE , , , 7
      EXIT DO
    ELSE
      GOSUB EnterNumber
      IF Number(Text$) = TRUE THEN
        LOCATE , , , 7
        EXIT DO
      END IF
    END IF
  CASE CHR$(32) TO CHR$(255)       'Characters
    GOSUB AddSymbol
  CASE ELSE
    BEEP
  END SELECT
LOOP
EXIT SUB
'===========================================================
Init:
' *** Initialization of procedure ***
  COLOR CI, CB
  LOCATE X0, Y0
  Text$ = SPACE$(MaxLText)
  PointerB = 1
  PointerC = 1
  Ins = FALSE
RETURN
'===========================================================
AddSymbol:
' *** Add character to string Text$ ***
  NL = PointerB + PointerC - 1
  SELECT CASE Ins
    CASE TRUE                          'insertion mode
      IF RIGHT$(Text$, 1) <> " " THEN
        BEEP
        PointerC = PointerC - 1
      ELSE
        IF NL = MaxLText THEN
          MID$(Text$, NL) = L$
        ELSE
          TL$ = LEFT$(Text$, NL - 1)
          TR$ = MID$(Text$, NL, MaxLText - NL)
          Text$ = LEFT$(TL$ + L$ + TR$, MaxLText)
        END IF
      END IF
    CASE FALSE                         'replacement mode
      IF PointerC <= LX THEN
        MID$(Text$, NL) = L$
      ELSE
        BEEP
      END IF
  END SELECT
  GOSUB CursorRight
  GOSUB OnScreen
RETURN
'===========================================================
Cursor:
' *** Change position of cursor ***
SELECT CASE Crsr$
  CASE "right"                   'move cursor right
    IF PointerC < LX THEN
      PointerC = PointerC + 1
    ELSE
      IF PointerB + PointerC - 1 < MaxLText THEN
        PointerB = PointerB + 1
      ELSE
        IF PointerC = LX THEN
          '*** cursor at end of word Text$ ***
          PointerC = PointerC + 1
        ELSE
          BEEP
        END IF
      END IF
    END IF
  CASE "left"                    'move cursor left
    IF PointerC > 1 THEN
      PointerC = PointerC - 1
    ELSE
      IF PointerB > 1 THEN
        PointerB = PointerB - 1
      ELSE                       'cursor at the beginning of word Text$
        BEEP
      END IF
    END IF
END SELECT
RETURN
'==========================================================
OnScreen:
' *** Output text fragment and cursor onto screen ***
  COLOR CI, CB
  LOCATE X0, Y0
  PRINT MID$(Text$, PointerB, LX);
  IF PointerC <= LX THEN
    NL = PointerB + PointerC - 1
    LOCATE X0, Y0 + PointerC - 1, 1
  ELSE
    LOCATE , , 0             'hide cursor
  END IF
RETURN
'===========================================================
Insert:
' *** Change value of Ins and the form of cursor ***
  IF Ins = TRUE THEN
    Ins = FALSE
    LOCATE X0, Y0, , 7
  ELSE
    Ins = TRUE
    LOCATE X0, Y0, , 0, 7
  END IF
  GOSUB OnScreen
RETURN
'===========================================================
CursorLeft:
' *** Move cursor left ***
  Crsr$ = "left"
  GOSUB Cursor
  GOSUB OnScreen
RETURN
'===========================================================
CursorRight:
' *** Move cursor right ***
  Crsr$ = "right"
  GOSUB Cursor
  GOSUB OnScreen
  RETURN
'===========================================================
BackSpace:
' *** Delete a character to the left from cursor ***
  NL = PointerB + PointerC - 1
  IF NL > 1 THEN
    TL$ = LEFT$(Text$, NL - 2)
    TR$ = RIGHT$(Text$, MaxLText - NL + 1)
    Text$ = TL$ + TR$ + " "
    GOSUB CursorLeft
    GOSUB OnScreen
  ELSE
    BEEP
  END IF
RETURN
'===========================================================
Delete:
' *** Delete a character at cursor ***
  NL = PointerB + PointerC - 1
  IF PointerC <= LX THEN
    TL$ = LEFT$(Text$, NL - 1)
    TR$ = RIGHT$(Text$, MaxLText - NL)
    Text$ = TL$ + TR$ + " "
    GOSUB OnScreen
  ELSE
    BEEP
  END IF
RETURN
'===========================================================
Home:
' *** Move cursor to the beginning of string ***
  PointerB = 1
  PointerC = 1
  GOSUB OnScreen
RETURN
'===========================================================
End1:
' *** Move cursor to end of string ***
  LTxt = LEN(RTRIM$(Text$))
  SELECT CASE LTxt
  CASE IS < LX
    PointerB = 1
    PointerC = LTxt + 1
  CASE IS = MaxLText
    PointerB = MaxLText - LX + 1
    PointerC = LX
  CASE IS >= LX
    PointerB = LTxt - LX + 2
    PointerC = LX
  END SELECT
  GOSUB OnScreen
RETURN
'===========================================================
EnterNumber:
' *** Complete entering number ***
  IF Number(Text$) = FALSE THEN
    PCOPY 0, 1
    X3 = 12: Y3 = 11
    'CALL Box(X3 + 1, Y3 + 1, X3 + 4, Y3 + 19, 4, 0, 4)
    'CALL Box(X3, Y3, X3 + 3, Y3 + 18, 2, 15, 5)
    'CALL Box(X3 + 1, Y3 + 1, X3 + 2, Y3 + 17, 4, 5, 15)
    COLOR 31, 5
    LOCATE 13, 18
    PRINT "Error!"
    COLOR 15, 5
    LOCATE 14, 12
    PRINT " Enter a number! "
    L$ = INPUT$(1)
    PCOPY 1, 0
    GOSUB OnScreen
  ELSE
    Text$ = RTRIM$(Text$)
  END IF
RETURN
'===========================================================


END SUB

SUB Box (Row1%, Col1%, row2%, Col2%) STATIC
'Box:
'  Draw a box on the screen between the given coordinates.

    BoxWidth = Col2% - Col1% + 1

    LOCATE Row1%, Col1%
    PRINT "⁄"; STRING$(BoxWidth - 2, "ƒ"); "ø";

    FOR a = Row1% + 1 TO row2% - 1
        LOCATE a, Col1%
        PRINT "≥"; SPACE$(BoxWidth - 2); "≥";
    NEXT a

    LOCATE row2%, Col1%
    PRINT "¿"; STRING$(BoxWidth - 2, "ƒ"); "Ÿ";


END SUB

SUB BoxDouble (Row1%, Col1%, row2%, Col2%) STATIC
'BoxDouble:
'  Draw a box on the screen between the given coordinates.

    BoxWidth = Col2% - Col1% + 1

    LOCATE Row1%, Col1%
    PRINT "…"; STRING$(BoxWidth - 2, "Õ"); "ª";

    FOR a = Row1% + 1 TO row2% - 1
        LOCATE a, Col1%
        PRINT "∫"; SPACE$(BoxWidth - 2); "∫";
    NEXT a

    LOCATE row2%, Col1%
    PRINT "»"; STRING$(BoxWidth - 2, "Õ"); "º";

END SUB

SUB ChoiceFields
    SELECT CASE PosF%
           CASE 1
ChoiFd$(0) = "Liner"
ChoiFd$(1) = "YearOfLaunch"
ChoiFd$(2) = "Dockyard"
ChoiFd$(3) = "Country"
ChoiFd$(4) = "Town"
ChoiFd$(5) = "ShipOwningCo"
MaxPos% = 6
          CASE 2
ChoiFd$(0) = "Liner"
ChoiFd$(1) = "Year"
ChoiFd$(2) = "Direct"
ChoiFd$(3) = "Days"
ChoiFd$(4) = "Hours"
ChoiFd$(5) = "Minutes"
ChoiFd$(6) = "Velocity"
MaxPos% = 7
         CASE 3
ChoiFd$(0) = "Liner"
ChoiFd$(1) = "YearOfLaunch"
ChoiFd$(2) = "Dockyard"
ChoiFd$(3) = "Country"
ChoiFd$(4) = "Town"
ChoiFd$(5) = "ShipOwningCo"
ChoiFd$(6) = "Year"
ChoiFd$(7) = "Direct"
ChoiFd$(8) = "Days"
ChoiFd$(9) = "Hours"
ChoiFd$(10) = "Minutes"
ChoiFd$(11) = "Velocity"
ChoiFd$(12) = ""
ChoiFd$(13) = ""
MaxPos% = 12
    END SELECT

END SUB

SUB ControlPanel
'Managing main menu and dialog window.

    'Set  Select for demonstration.
    PosM% = 3
    FinishMenu = FALSE

    'Cycle of activization of main menu and of corresponding dialog window
    DO
      DemoText
      PosM% = PosMenuMain(Menu$(), 7, 2, 7, PosM%)
      IF FinishMenu = TRUE THEN EXIT DO
      FinishWindow = FALSE
      SELECT CASE PosM%
        CASE 3
          InitSelect

          'Cycle of activization of selection fields and of window menu Select
          DO
            'Selection of file name
            FileToSelect 3, 11, 6, 7, 4
            IF FinishWindow = TRUE THEN EXIT DO
            'specifying several conditions for this file
            DO
              FieldOpToSelect 7, 4
              PosW% = PosMenuWin(MenuW$(), 3, 21, 3, PosW%)
              IF FinishWindow = TRUE THEN EXIT DO
              SELECT CASE PosW%
                CASE 1
                  PosW% = 1
                CASE 2
                  '"Plug" for the command Select.
                  ResultSelect
                  FinishWindow = TRUE: EXIT DO
                CASE 3
                  FinishWindow = TRUE: EXIT DO
                CASE 4
                  PosW% = 1: EXIT DO
              END SELECT
            LOOP
            IF FinishWindow = TRUE THEN EXIT DO
          LOOP
        CASE 5
          InitProject
          DO
            FileToProject 3, 8, 10, 7, 28
            IF FinishWindow = TRUE THEN EXIT DO
            SELECT CASE PosW%
              CASE 1
                '"Plug" for the command êroject.
                ResultProject
                EXIT DO
              CASE 2
                EXIT DO
              CASE 3
                PosW% = 1
            END SELECT
          LOOP
        CASE 7
          EXIT DO
        CASE ELSE
          '"Plug" for Edit, Sort, Print.
          SortAndOther
      END SELECT
    LOOP

END SUB

SUB DemoText
'Display of  framework of dialog window with reference information
    DIM X$(20)

    'Output of external framework of window
    COLOR Color2, Color3
    BoxDouble 1, 1, 25, 80
    COLOR Color1, Color2
    LOCATE 1, 30
    PRINT "  Demo Dialog Box  "
    'Framework of help window
    Box 7, 18, 21, 62

    X$(1) = "This is a demonstration program of working"
    X$(2) = "with dialog windows of data base     "
    X$(3) = "     BLUE RIBBON OF ATLANTIC         "
    X$(4) = "Windows for two commands             "
    X$(5) = "    <SELECT> and <PROJECT>           "
    X$(6) = "   are demonstrated                  "
    X$(7) = "Exit from dialog window by pressing"
    X$(8) = "         the Esc key                "
    X$(9) = "     is available."
    X$(10) = ""
    X$(11) = "Select a menu item corresponding    "
    X$(12) = "to indicated commands."

    'Output of help text
    FOR I = 1 TO 12
        LOCATE 8 + I, 20
        PRINT X$(I)
    NEXT I

END SUB

SUB FieldOpToSelect (RowField%, ColField%)
'Specifying a condition of the type "field - operation - value"

'list of fields
 ChoiceFields

'specify a condition number not exceeding 3
 NumChoice = NumChoice + 1
 IF NumChoice > 3 THEN NumChoice = 1

'activating a list for field selection
 PosFld% = PosChoice(Titl2$, ChoiFd$(), MaxPos%, RowField%, ColField%, PosFld%)
 IF FinishWindow = TRUE THEN EXIT SUB
'store number of field
 PosFlds(NumChoice) = PosFld%

'activating a list for operation selection
 PosOp% = PosChoice(Titl3$, ChoicOp$(), 6, RowField%, ColField% + 25, PosOp%)
 IF FinishWindow = TRUE THEN EXIT SUB
'store number of operation
 PosOprs(NumChoice) = PosOp%

'Entering value
 Box 7, 47, 9, 70
 LOCATE 7, 51
 PRINT " Value "
 Answer 8, 49, 20, 20, Values$(NumChoice), "Text"

'outputting a condition onto panel
 PrintConditionals 16, 27

END SUB

SUB FileToProject (MaxRow%, Row1%, Col1%, RowField%, ColField%)
  ChoiceFields
  PrintMultiChoice Titl2$, ChoiFd$(), MaxPos%, RowField%, ColField%, PosFd%()
  PosF% = PosChoice%(Titl1$, ChoiceF$(), MaxRow%, Row1%, Col1%, PosF%)
  IF FinishWindow = TRUE THEN EXIT SUB
  ChoiceFields
  PosMultiChoice Titl2$, ChoiFd$(), MaxPos%, 7, 28, PosFd%()
  IF FinishWindow = TRUE THEN EXIT SUB
  PosW% = PosMenuWin(MenuW$(), 2, 21, 3, PosW%)

END SUB

SUB FileToSelect (MaxRow%, Row1%, Col1%, RowField%, ColField%)
'Choosing a file name from selection list

ChoiceFields                                   'names of file fields
'outputting file list
 u% = PosChoice(Titl2$, ChoiFd$(), MaxPos%, RowField%, ColField%, 0)
'outputting list of fields of the first file
 u% = PosChoice(Titl3$, ChoicOp$(), 6, RowField%, ColField% + 25, 0)

'Framework for list of selected operations
 Box 7, 47, 9, 70
 LOCATE 7, 51
 PRINT " Value "
'outputting framework and field for conditions
 NumChoice = 0
 PrintConditionals 16, 27

 'Activating menu for selection of file name
 PosF% = 1                                      'number of active field
 PosF% = PosChoice%(Titl1$, ChoiceF$(), MaxRow%, Row1%, Col1%, PosF%)

 'Ouputting a chosen name
 LOCATE 14, 48
 PRINT "File: "; ChoiceF$(PosF% - 1); "   "

END SUB

SUB Initialize
'Colors of screen forms, texts of menus and prompts

Color1 = 1
Color2 = 15
Color3 = 3
Color4 = 0

Menu$(0) = " Edit "
Menu$(1) = " Sort "
Menu$(2) = " Select "
Menu$(3) = " Join "
Menu$(4) = " Project "
Menu$(5) = " Print "
Menu$(6) = " Exit "

HelpMenu$(1) = "     Editing reords of Data Base file           "
HelpMenu$(2) = "   Sorting file records by specified keys       "
HelpMenu$(3) = "Selecting by values of keys (no more than 3 keys"
HelpMenu$(4) = "    Joining records of Data Base files          "
HelpMenu$(5) = "Selecting fields of Data Base files for printing"
HelpMenu$(6) = " Outputting file records onto screen or printer "
HelpMenu$(7) = "     Quitting main menu of Data Base            "

'Names of selection fields
Titl1$ = " Files "
Titl2$ = " Fields "
Titl3$ = "Operations"

END SUB

SUB InitProject

MenuW$(0) = "OK-Execute and Exit to Menu"
MenuW$(1) = "Cancel- Exit to Menu"
PosW% = 1
PrintWindow MenuW$(), 2, 6, 21, 3

LOCATE 6, 25
PRINT Menu$(4)
LOCATE 25, 35
COLOR Color2, Color1
PRINT " <F1=Help> ";
ChoiceF$(0) = "LINERS.DBF"
ChoiceF$(1) = "RECORDS.DBF"
ChoiceF$(2) = "JOIN.DBF"

PosF% = 1
PosFd%(0) = 1
PosFd%(1) = 1
PosFd%(2) = 1
PosFd%(3) = 0
PosFd%(4) = 0
PosFd%(5) = 0
PosFd%(6) = 0
PosFd%(7) = 0
PosFd%(8) = 0
PosFd%(9) = 0
PosFd%(10) = 0
PosFd%(11) = 0
PosFd%(12) = 0

END SUB

SUB InitSelect
'Opens a dialog window Select

'Texts of window menus
MenuW$(0) = "Continue"
MenuW$(1) = "OK-Execute and Exit to Menu"
MenuW$(2) = "Cancel- Exit to Menu"

'Initial position of window menu
PosW% = 1
'Outputting of window menu without its activating
PrintWindow MenuW$(), 3, 6, 21, 3

'Title of window and help
LOCATE 6, 25
PRINT Menu$(2)
LOCATE 25, 35
COLOR Color2, Color1
PRINT " <F1=Help> ";

'Parameters of selection fields
PosF% = 1
PosFld% = 1
PosOp% = 1

'names of files
ChoiceF$(0) = "LINERS.DBF"
ChoiceF$(1) = "RECORDS.DBF"
ChoiceF$(2) = "JOIN.DBF"

'names of operations
ChoicOp$(0) = "  <=  "
ChoicOp$(1) = "  <   "
ChoicOp$(2) = "  >=  "
ChoicOp$(3) = "  >   "
ChoicOp$(4) = "  =   "
ChoicOp$(5) = "  <>  "

END SUB

FUNCTION MaxLen% (Array$(), MaxCol%)
'returns a maximal length of element (from 0 to MaxCol%) of the array Array$()
'Array$ - array of string fields
'MaxCol - number of fields to view
'MaxLen - maximal length of field from the array viewed elements

XMaxlen% = LEN(Array$(0))
FOR I = 1 TO MaxCol% - 1
    IF LEN(Array$(I)) > XMaxlen% THEN
        XMaxlen% = LEN(Array$(I))
    END IF
NEXT
MaxLen% = XMaxlen%

END FUNCTION

FUNCTION Number (Txt$)
' *************************
' * Txt$ - number or not? *
' *************************
T$ = Txt$
T$ = RTRIM$(T$)
T$ = LTRIM$(T$)
SELECT CASE LEN(T$)
CASE 0
  Flag = TRUE
CASE 1
  IF T$ < "0" OR T$ > "9" THEN Flag = FALSE ELSE Flag = TRUE
CASE IS > 1
  Flag = FALSE
  SELECT CASE LEFT$(T$, 1)
  CASE "+", "-", "0" TO "9"
    Flag = TRUE
  CASE "."
    IF INSTR(2, T$, ".") = 0 THEN Flag = TRUE
  END SELECT
END SELECT
IF Flag = TRUE THEN
  FOR I = 2 TO LEN(RTRIM$(T$))
    SELECT CASE MID$(T$, I, 1)
    CASE "."
      IF INSTR(I + 1, T$, ".") <> 0 THEN Flag = FALSE
    CASE IS < "0", IS > "9"
      Flag = FALSE
    END SELECT
    IF Flag = FALSE THEN EXIT FOR
  NEXT I
END IF
IF T$ = "+." OR T$ = "-." THEN Flag = FALSE
Number = Flag

END FUNCTION

DEFINT A-Z
'Activation of pop-up help window
SUB PopUpWindow (Row1, Col1, row2, Col2)
'Row1,Col1,Row2,Col2 - coordinates of pop-up help window
'Helpíxt$() - text of help
DIM HelpTxt$(10)
GOSUB HelpText

'Store position of cursor
CurRow = CSRLIN
CurCol = POS(0)

LenW = Col2 - Col1           'width of window
HigW = row2 - Row1           'height of window
'area for storing window - in bytes
DIM a(HigW, LenW * 2)

'Setting parameters of the screen area under window to store
DEF SEG = 0
'offset of active page in screen area
PagOff = PEEK(&H44E) + PEEK(&H44F) * 256
'lengh of Screen - °†©‚
LenScr = (PEEK(&H44A) + PEEK(&H44B) * 256) * 2
DEF SEG

'Storing information under window
'initial segment of display memory
DEF SEG = &HB800
FOR I = 0 TO HigW
  FOR j = 0 TO LenW * 2
    a(I, j) = PEEK(PagOff + 2 * Col1 + (I + Row1) * LenScr + j)
  NEXT
NEXT

'Drawing framework
BoxDouble Row1 + 1, Col1 + 1, Row1 + HigW + 1, Col1 + LenW
LOCATE Row1 + 1, Col1 + (LenW + 1 - LEN(HelpTxt$(0))) / 2

'Outputting text of help
PRINT HelpTxt$(0);
FOR I = 1 TO HigW - 1
    LOCATE Row1 + 1 + I, Col1 + 2
    PRINT HelpTxt$(I);
NEXT

'Waits for pressing any key
WHILE LEN(INKEY$) < 1
WEND

'Restore text under window
DEF SEG = &HB800
FOR I = 0 TO HigW
  FOR j = 0 TO 2 * LenW
    POKE PagOff + 2 * Col1 + (I + Row1) * LenScr + j, a(I, j)
  NEXT
NEXT
DEF SEG

'Restore cursor
LOCATE CurRow, CurCol
EXIT SUB

HelpText:
'Text of help popping  up on pressing  F1
u$ = CHR$(24) + " , " + CHR$(25) + " , " + CHR$(27) + ","
HelpTxt$(0) = "Help"
HelpTxt$(1) = " "
HelpTxt$(2) = " Cursor move   : TAB, " + u$ + CHR$(26)
HelpTxt$(3) = " File choice   : ENTER                "
HelpTxt$(4) = " Field choice  : ENTER                "
HelpTxt$(5) = " Exit of choice: TAB, ENTER           "
HelpTxt$(6) = " Exit to Menu  : Esc                  "
HelpTxt$(7) = "            _____________             "
HelpTxt$(8) = "                                      "
HelpTxt$(9) = "    Press any key to continue "
RETURN

END SUB

DEFSNG A-Z
FUNCTION PosChoice% (Titl1$, Titl$(), Max%, Row1%, Col1%, CurPos%)

'display and activation of one-alternative selection menu
'PosChoice% - ordinal number of menu position
'Titl1$ - title of selection menu
'Titl$ - total list of fields names
'Max% - number of fields to display
'row1%, Col1% - coordinates of upper left corner of framework
'CurPos% - initial position of selection cursor
'If CurPos% = 0 , then only printing without selection
'row2%, Col2% - coordinates of lower right corner of framework
row2% = Row1% + Max% + 1
Col2% = Col1% + MaxLen(Titl$(), Max%) + 8 '3

'shadow
COLOR Color4, Color4
Box Row1% + 1, Col1% + 2, row2% + 1, Col2% + 2

'framework
COLOR Color1, Color2
Box Row1%, Col1%, row2%, Col2%

'title
LOCATE Row1%, Col1% + 3
PRINT Titl1$

'printing for selection
FOR I% = 1 TO Max%
    IF I% = CurPos% THEN
        GOSUB PrintColor2
    ELSE
        GOSUB PrintNoColor2
    END IF
NEXT
IF CurPos% = 0 THEN EXIT FUNCTION     'only printing

'Activating selection
    I% = CurPos%
    DO
        DO
            LOCATE Row1% + I%, Col1% + 2, 1
            Key$ = INKEY$
        LOOP UNTIL Key$ <> ""

        SELECT CASE Key$
            CASE CHR$(0) + "H"
                GOSUB PrintNoColor2
                IF I% > 1 THEN
                    I% = I% - 1
                ELSE
                    I% = Max%
                END IF
                GOSUB PrintColor2
            CASE CHR$(0) + "P"
                 GOSUB PrintNoColor2
                 IF I% < Max% THEN
                     I% = I% + 1
                 ELSE
                     I% = 1
                 END IF
                 GOSUB PrintColor2
            CASE CHR$(13), CHR$(9)
                 EXIT DO
            CASE CHR$(27)
                 FinishWindow = TRUE
                 EXIT DO
            CASE ELSE
                 BEEP
        END SELECT
    LOOP

    PosChoice% = I%
    COLOR Color1, Color2
    EXIT FUNCTION

PrintColor2:
    COLOR Color2, Color1
    LOCATE Row1% + I%, Col1% + 2
    u$ = STRING$(Col2% - Col1% - LEN(Titl$(I% - 1)) - 3, " ")
    PRINT Titl$(I% - 1) + u$
    RETURN

PrintNoColor2:
    COLOR Color1, Color2
    LOCATE Row1% + I%, Col1% + 2
    u$ = STRING$(Col2% - Col1% - LEN(Titl$(I% - 1)) - 3, " ")
    PRINT Titl$(I% - 1) + u$
    RETURN

END FUNCTION

FUNCTION PosMenuMain% (Titl$(), Max%, Row1%, Col1%, CurPos%)
'PosMenuMain - number of control button selected by user
'Titl$ - total list of names of buttons
'Max% - number of buttons to display
'row1%, Col1% - coordinates of upper left corner of menu
'CurPos% - initial position of selection cursor

'Drawing menu
PrintMenuMain Titl$(), Max%, Row1%, Col1%

'Activating menu
DIM Position(0 TO 10)
Position(0) = Col1% + 2
FOR I% = 1 TO Max% - 1
    Position(I%) = Position(I% - 1) + LEN(Titl$(I% - 1)) + 1
NEXT
GOSUB PrintColor

   DO
       DO
         Key$ = INKEY$
       LOOP UNTIL Key$ <> ""
       SELECT CASE Key$
           CASE CHR$(0) + "K"
                GOSUB PrintNoColor
                IF CurPos% > 1 THEN
                    CurPos% = CurPos% - 1
                ELSE
                    CurPos% = Max%
                END IF
                GOSUB PrintColor
           CASE CHR$(0) + "M"
                GOSUB PrintNoColor
                IF CurPos% < Max% THEN
                    CurPos% = CurPos% + 1
                ELSE
                    CurPos% = 1
                END IF
                GOSUB PrintColor
           CASE CHR$(13)
                EXIT DO
           CASE CHR$(27)
                FinishMenu = TRUE
                EXIT DO
           CASE ELSE
                BEEP
       END SELECT
   LOOP
   PosMenuMain = CurPos%
   COLOR Color1, Color2
   EXIT FUNCTION

PrintColor:
    COLOR Color2, Color1
    LOCATE 23, 17
    PRINT HelpMenu$(CurPos%);
    LOCATE Row1% + 1, Position(CurPos% - 1), 1
    PRINT Titl$(CurPos% - 1)
    LOCATE Row1% + 1, Position(CurPos% - 1), 1
    RETURN

PrintNoColor:
    COLOR Color1, Color2
    LOCATE Row1% + 1, Position(CurPos% - 1), 1
    PRINT Titl$(CurPos% - 1)
    RETURN

END FUNCTION

FUNCTION PosMenuWin% (Titl$(), Max%, Row1%, Col1%, CurPos%)
'Activation of menu of dialog window
'PosMenuWin - number of control button selected by user
'Titl$ - total list of names of buttons
'Max% - number of buttons to display
'row1%, Col1% - coordinates of upper left corner of menu framework
'CurPos% - initial location of selection cursor
DIM Position(0 TO 10)
Position(0) = Col1% + 2
FOR I% = 1 TO Max% - 1
    Position(I%) = Position(I% - 1) + LEN(Titl$(I% - 1)) + 4
NEXT
'Until Enter Ær Esc or TAB are pressed
    GOSUB PrintColor1
    DO
        DO
          Key$ = INKEY$
        LOOP UNTIL Key$ <> ""
        SELECT CASE Key$
           CASE CHR$(9) ' + "M", CHR$(9)
                GOSUB PrintNoColor1
                CurPos% = CurPos% + 1
                IF CurPos% > Max% THEN EXIT DO
                GOSUB PrintColor1
           CASE CHR$(13)
                EXIT DO
           CASE CHR$(27)
                FinishWindow = TRUE
                EXIT DO
           CASE ELSE
                BEEP
        END SELECT
    LOOP
    PosMenuWin = CurPos%
    COLOR Color1, Color2
    EXIT FUNCTION

PrintColor1:
    COLOR Color2, Color2 '1
    LOCATE Row1% + 1, Position(CurPos% - 1), 1
    PRINT "<"
    LOCATE Row1% + 1, Position(CurPos% - 1) + LEN(Titl$(CurPos% - 1)) + 1
    PRINT ">"
    LOCATE Row1% + 1, Position(CurPos% - 1) + 1, 1
    COLOR Color1, Color2
    RETURN

PrintNoColor1:
    COLOR Color1, Color2
    LOCATE Row1% + 1, Position(CurPos% - 1), 1
    PRINT "<"
    LOCATE Row1% + 1, Position(CurPos% - 1) + LEN(Titl$(CurPos% - 1)) + 1
    PRINT ">"
    RETURN

END FUNCTION

SUB PosMultiChoice (Tit$, Titl$(), Max%, Row1%, Col1%, BitPos%())
'Activation of multialternative selection menu
'ReadKey% - number of list's element selected by user
'Titl$ - total list of fields names
'Max% - number of fields to display
'row1%, Col1% - coordinates of upper left corner of framework
'BitPos%() - initial array of states of elements to select (1,0)
'CurPos% - current position of selection cursor

'Output of menu onto screen
PrintMultiChoice Tit$, Titl$(), Max%, Row1%, Col1%, BitPos%()

'activation of selection
WorkCol% = Col1% + MaxLen(Titl$(), Max%) + 10
CurPos% = 1
   DO
        LOCATE Row1% + CurPos%, WorkCol%, 1
        DO
                Key$ = INKEY$
        LOOP UNTIL Key$ <> ""
        SELECT CASE Key$
           CASE CHR$(0) + "H"
                IF CurPos% > 1 THEN
                   CurPos% = CurPos% - 1
                ELSE
                   CurPos% = Max%
                END IF
           CASE CHR$(0) + "P"
                IF CurPos% < Max% THEN
                   CurPos% = CurPos% + 1
                ELSE
                   CurPos% = 1
                END IF
           CASE CHR$(13), " "
                IF BitPos%(CurPos% - 1) = 1 THEN
                    BitPos%(CurPos% - 1) = 0
                    PRINT " "
                ELSE
                    BitPos%(CurPos% - 1) = 1
                    PRINT "x" 'CHR$(17)
                END IF
           CASE CHR$(9)
                EXIT DO
           CASE CHR$(27)
                FinishWindow = TRUE
                EXIT DO
           CASE ELSE
                BEEP
       END SELECT
   LOOP

END SUB

SUB PrintConditionals (CurRow%, CurCol%)
'Output of selection conditions for  SELECT
'ChoiFds$() - array of field names
'PosFlds$() - array of positions for selected fields
'choicOp$() - array of operations
'PosOprs() - array of positions for selected operations
'Values$() - array of values for selected fields
'NumChoice -number of selected conditions

 Box CurRow%, CurCol% - 1, CurRow% + 4, CurCol% + 50
 LOCATE CurRow%, CurCol% + 20
 PRINT " Conditions: "
 FOR I = 1 TO NumChoice
     LOCATE CurRow% + I, CurCol%
     PRINT I;
     LOCATE CurRow% + I, CurCol% + 5
     PRINT ChoiFd$(PosFlds(I) - 1)
     LOCATE CurRow% + I, CurCol% + 20
     PRINT ChoicOp$(PosOprs(I) - 1)
     LOCATE CurRow% + I, CurCol% + 30
     PRINT Values$(I)
 NEXT I

END SUB

SUB PrintMenuMain (Titl$(), Max%, Row1%, Col1%)
'Procedure of drawing window for main menu
'Titl$() - total list of names of fields
'Max% - number of fields to display
'row1%, Col1% - coordinates of upper left corner of framework

LenAll% = 0
FOR I% = 0 TO Max% - 1
    LenAll% = LenAll% + LEN(Titl$(I%))
NEXT
row2% = Row1% + 2
Col2% = Col1% + LenAll% + Max% + 2
COLOR Color4, Color4
Box Row1% + 1, Col1% + 2, row2% + 1, Col2% + 2
COLOR Color1, Color2
Box Row1%, Col1%, row2%, Col2%
CurCol% = Col1% + 2
FOR I% = 1 TO Max%
    LOCATE Row1% + 1, CurCol%
    PRINT Titl$(I% - 1)
    CurCol% = CurCol% + LEN(Titl$(I% - 1)) + 1
NEXT

END SUB

SUB PrintMultiChoice (Tit$, Titl$(), Max%, Row1%, Col1%, BitPos%())
'procedure of creating window of multialternative selction
'Titl$ - title of window
'Titl$() - total list of names of fields
'Max% - number of fields to display
'row1%, Col1% - coordinates of upper left corner of window
'BitPos%() - positions of selection buttons (0,1).

row2% = Row1% + Max% + 1'2
Col2% = Col1% + MaxLen(Titl$(), Max%) + 13'7
COLOR Color4, Color4
Box Row1% + 1, Col1% + 2, row2% + 1, Col2% + 2
COLOR Color1, Color2
Box Row1%, Col1%, row2%, Col2%
LOCATE Row1%, Col1% + INT((Col2% - Col1% - LEN(Tit$)) / 2)
PRINT Tit$
FOR I% = 1 TO Max%
    LOCATE Row1% + I%, Col1% + 2
    PRINT Titl$(I% - 1)
    LOCATE Row1% + I%, Col2% - 4
    PRINT "[ ]"
    IF BitPos%(I% - 1) = 1 THEN
        LOCATE Row1% + I%, Col2% - 3
        PRINT "x" 'CHR$(17)
    END IF
NEXT

END SUB

SUB PrintWindow (Titl$(), Max%, RowH%, Row1%, Col1%)
'Procedure of drawing a dialog window for selection fields and
'control buttons
'Titl$() - total list of names of buttons
'Max% - number of buttons to display
'RowH% - coordinates of upper left corner of window
'Row1%,Col1% - coordinates of lower right corner of window.

'Fields for buttons
LenAll% = 0
FOR I% = 0 TO Max% - 1
    LenAll% = LenAll% + LEN(Titl$(I%)) + 4
NEXT

'Display of window
row2% = Row1% + 2
Col2% = Col1% + LenAll% + 1
COLOR Color4, Color4
Box RowH% + 1, Col1% + 2, row2% + 1, Col2% + 2
COLOR Color1, Color2
GOSUB Boxbig
Col1% = Col1% + 1

'texts of menus
FOR I% = 1 TO Max%
    LOCATE Row1% + 1, Col1%
    PRINT " " + "<" + Titl$(I% - 1) + ">" + " "
    Col1% = Col1% + LEN(Titl$(I% - 1)) + 4
NEXT

EXIT SUB

Boxbig:
'  Draw a big window on the screen .
    BoxWidth = Col2% - Col1% + 1

    LOCATE RowH%, Col1%
    PRINT "⁄"; STRING$(BoxWidth - 2, "ƒ"); "ø";
    FOR a = RowH% + 1 TO row2% - 1
        LOCATE a, Col1%
        PRINT "≥"; SPACE$(BoxWidth - 2); "≥";
    NEXT a
    LOCATE Row1%, Col1%
    PRINT "√"; STRING$(BoxWidth - 2, "ƒ"); "¥";
    LOCATE row2%, Col1%
    PRINT "¿"; STRING$(BoxWidth - 2, "ƒ"); "Ÿ";
    RETURN


END SUB

SUB ResultProject
'"Plug" for êroject.
'ChoiceF$() - array of names of Data Base files
'PosF% - number of position of selected file name
'ChoiFd$() - array of fields of selected file
'PosFd%() - array of numbers of positions of selected fields (0,1)

    Box 6, 3, 23, 59
    LOCATE 6, 25
    PRINT Menu$(4)                           'header
    LOCATE 8, 25
    PRINT ChoiceF$(PosF% - 1); ":"
    LOCATE 9, 22

    ChoiceFields
    k = 1
    FOR I = 1 TO MaxPos%
        IF PosFd%(I - 1) = 1 THEN
            LOCATE 8 + k, 29
            PRINT ChoiFd$(I - 1)
            k = k + 1
        END IF
    NEXT I

    LOCATE 22, 20
    PRINT "Press any key to return to Main menu"
    WHILE LEN(INKEY$) < 1: WEND

END SUB

SUB ResultSelect
'"Plug" for  Select.
'ChoiceF$() - array of names of Data Base files
'PosF% - number of position of selected file name

    Box 6, 3, 23, 76
    LOCATE 6, 32
    PRINT Menu$(2)                  'header
    LOCATE 11, 10
    PRINT ChoiceF$(PosF% - 1); ":"

   'outputting conditions onto screen
    PrintConditionals 12, 10

    LOCATE 22, 20
    PRINT "Press any key to return to Main menu"
    WHILE LEN(INKEY$) < 1: WEND

    END SUB

SUB SortAndOther
 '"Plug" for commands Edit, Sort, Print.

 Box 8, 20, 18, 59
 LOCATE 10, 35
 PRINT Menu$(PosM% - 1)   'name of menu button
 LOCATE 14, 29

 'Waits for a key pressing
 PRINT "Press any key to continue"
 WHILE LEN(INKEY$) < 1: WEND

END SUB

