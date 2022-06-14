REM Pull-down menu           
REM Demonstration in graphic mode
REM \CHAP13\CHAP13_6.BAS

DECLARE SUB MoveSPointer (SNP!, Esc!, Enter!)
DECLARE SUB InitTextSubMenu (SText$(), SHelp$(), WidthSM%)
DECLARE SUB MenuSub (SNP!, SMCol!, Esc!)
DECLARE SUB MovePointer (V!, Enter!)
DECLARE SUB Pointer (L%, A%())
DECLARE SUB SelectVersion (TextMN$(), MRow!(), MCol!(), Help$(), NV!())
DECLARE SUB InitTextMainMenu (TextMN$(), MRow!(), MCol!(), Help$(), NV!())
DECLARE SUB Box (Row1!, Col1!, Row2!, Col2!)
DECLARE SUB Triangle1 ()
DECLARE SUB Triangle2 ()
DECLARE SUB Triangle3 ()
DECLARE SUB Rectangle ()
DECLARE SUB trapesium ()
DECLARE SUB Circle1 ()
DECLARE SUB MenuMain ()
DECLARE SUB SelectSubVersion (WidthSM%, SNP!, SMCol!, SHelp$(), Esc!)

CONST True = -1
CONST False = NOT True
CONST HL% = 14               'height of a letter
CONST MaxX = 640             'horizontal size of screen
CONST MaxY = 350             'vertical size of screen

DIM SHARED NP                'number of items in main menu
DIM SHARED Version           'number of an item in main menu
DIM SHARED SV                'number of an item in submenu

SCREEN 9
COLOR 15, 1
CLS
Version = 1
MenuMain
COLOR 7, 0
CLS
LOCATE 12, 33
PRINT "G O O D  B U E"
END

SUB Box (Row1, Col1, Row2, Col2)
' **********************************************************
' * Draw a box on the screen between the given coordinates *
' **********************************************************
  BoxWidth = Col2 - Col1 + 1
  LOCATE Row1, Col1
  PRINT "Ú"; STRING$(BoxWidth - 2, "Ä"); "¿";
  FOR A = Row1 + 1 TO Row2 - 1
    LOCATE A, Col1
    PRINT "³"; SPACE$(BoxWidth - 2); "³";
  NEXT A
  LOCATE Row2, Col1
  PRINT "À"; STRING$(BoxWidth - 2, "Ä"); "Ù";
END SUB

SUB Circle1
'   *********************************
'   * Calculation of area of circle *
'   *********************************
CIRCLE (70, 60), 50
LINE (70, 15)-(70, 105), , , &HAAAA
LOCATE 7, 8
PRINT "D"
LOCATE 12, 1
PRINT "Enter parameter:"
PRINT
INPUT "D = ", D
S = D ^ 2 * 3.141593 / 4
PRINT
PRINT "S ="; S
END SUB

SUB InitTextMainMenu (TextMN$(), MRow(), MCol(), Help$(), NV())
'   *********************************************************
'   *                     Initialization                    *
'   *  of text, position of options, information messages   *
'   *                    of main menu                       *
'   *            and number of items in submenu             *
'   *********************************************************

' *** Text of menu ***
    TextMN$(1) = " Rectangle "
    TextMN$(2) = " Trapesium "
    TextMN$(3) = " Triangle "
    TextMN$(4) = " Circle "
    TextMN$(5) = " Exit "

' *** Arrangement of menu options ***
    MRow(1) = 2: MCol(1) = 2
    MRow(2) = 2: MCol(2) = 13
    MRow(3) = 2: MCol(3) = 24
    MRow(4) = 2: MCol(4) = 34
    MRow(5) = 2: MCol(5) = 42

' *** Information messages ***
    Help$(1) = "Data: two sides"
    Help$(2) = "Data: base and height"
    Help$(3) = "Three versions of data"
    Help$(4) = "Data: diameter"
    Help$(5) = "Exit to DOS"

' *** Number of items in submenu ***
    NV(1) = 0
    NV(2) = 0
    NV(3) = 3
    NV(4) = 0
    NV(5) = 0
END SUB

SUB InitTextSubMenu (SText$(), SHelp$(), WidthSM%)
'   *****************************************************
'   * Initialization of texts and information  messages *
'   * for corresponding pull-down submenus of main menu *
'   *****************************************************
' WidthSM% - width of submenu text

SELECT CASE Version
CASE 3
  GOSUB MenuTriangle
END SELECT
EXIT SUB

MenuTriangle:
  WidthSM% = 21

' *** Text of submenu ***
  SText$(1) = " Three sides         "
  SText$(2) = " Base and Height     "
  SText$(3) = " Two sides and angle "

' *** Information messages ***
  SHelp$(1) = "Three sides of triangle"
  SHelp$(2) = "Base and Height of triangle"
  SHelp$(3) = "Two sides and angle between them"
  RETURN

END SUB

SUB MenuMain
'   *****************
'   *   Main menu   *
'   *****************
NP = 5               'number of options in main menu
DIM TextMN$(NP), MRow(NP), MCol(NP), Help$(NP), NV(NP)
Box 1, 1, 3, 80
InitTextMainMenu TextMN$(), MRow(), MCol(), Help$(), NV()
FOR i = 1 TO NP
  LOCATE MRow(i), MCol(i)
  PRINT TextMN$(i);
NEXT i
LOCATE 24, 1
PRINT STRING$(80, "Ä");
LOCATE 25, 1
PRINT SPACE$(80);
SelectVersion TextMN$(), MRow(), MCol(), Help$(), NV()
END SUB

SUB MenuSub (SNP, SMCol, Esc)
'   ***********************************
'   *   Pull-down menu for  Version   *
'   ***********************************
' SNP - number of items in submenu Version
' SMCol - left column of submenu
' Esc = True - exit to main menu without an item selection
' Version - number of an option in main menu
' SV - number of an option in submenu

REDIM SText$(SNP), SHelp$(SNP)
InitTextSubMenu SText$(), SHelp$(), WidthSM%
X1 = (SMCol - 1) * 8 - 1
Y1 = 2 * HL
X2 = X1 + (WidthSM% + 4) * 8
Y2 = Y1 + (SNP + 3) * HL
' *** Store a screen section ***
Bt% = 4 + INT((X2 - X1 + 8) / 8) * 4 * (Y2 - Y1 + 1)
REDIM C%(Bt%)
GET (X1, Y1)-(X2, Y2), C%

Box 3, SMCol, 4 + SNP, SMCol + WidthSM% + 1      'framework
LINE (X1 + 16, Y2 - HL - 6)-(X2, Y2 - 6), 6, BF  'shadow
LINE (X2 - 18, Y1 + HL)-(X2, Y2 - 6), 6, BF      'shadow
FOR i = 1 TO SNP
  LOCATE i + 3, SMCol + 1
  PRINT SText$(i);
NEXT i

SelectSubVersion WidthSM%, SNP, SMCol, SHelp$(), Esc
PUT (X1, Y1), C%, PSET            'restore a screen section
END SUB

SUB MovePointer (V, Enter)
'   *************************************
'   *     Moving cursor in main menu    *
'   *************************************
' V - number of selected item
V = Version
Enter = False
DO
  DO
    Kbd$ = INKEY$
  LOOP UNTIL Kbd$ <> ""
  SELECT CASE Kbd$
  CASE CHR$(0) + CHR$(75)              'Left
    V = (NP + Version - 2) MOD NP + 1
    EXIT DO
  CASE CHR$(0) + CHR$(77)              'Right
    V = Version MOD NP + 1
    EXIT DO
  CASE CHR$(13)                        'Enter
    Enter = True
    EXIT DO
  CASE ELSE
    BEEP
  END SELECT
LOOP
END SUB

SUB MoveSPointer (SNP, Esc, Enter)
'   ********************************
'   *   Moving cursor of submenu   *
'   ********************************
' SNP - number of options in submenu Version
' SV - number an item in submenu
DO
  DO
    Kbd$ = INKEY$
  LOOP UNTIL Kbd$ <> ""
  SELECT CASE Kbd$
  CASE CHR$(0) + CHR$(72)                  'Up
    SV = (SNP + SV - 2) MOD SNP + 1
    EXIT DO
  CASE CHR$(0) + CHR$(80)                  'Down
    SV = SV MOD SNP + 1
    EXIT DO
  CASE CHR$(13)                            'Enter
    Enter = True
    EXIT DO
  CASE CHR$(27)                            'Esc
    Esc = True
    EXIT DO
  CASE ELSE
    BEEP
  END SELECT
LOOP
END SUB

SUB Pointer (L%, A%())
'   ********************************************
'   *   Defining a grapghic pointer (Cursor)   *
'   ********************************************
' L% - width of pointer in characters
' HL% -  height of letter in pixels
LP% = 8 * L%  '- width of pointer in pixels
SCREEN 9, , 1, 0
LINE (1, 1)-(LP%, HL% + 2), 4, BF
LM% = 4 + 12 * LP%
' *** Storing pointer in array A%() ***
REDIM A%(LM%)
GET (1, 1)-(LP%, HL% + 2), A%
SCREEN 9, , 0, 0
END SUB

SUB Rectangle
'   ****************************************
'   *   Calculation of area of rectangle   *
'   ****************************************
'SCREEN 2
CLS
LINE (20, 20)-(190, 60), , B
LOCATE 4, 14
PRINT "a"
LOCATE 6, 26
PRINT "b"
LOCATE 12, 1
PRINT "Enter parameters:"
PRINT
INPUT "a = ", A
INPUT "b = ", B
S = A * B
PRINT
PRINT "S ="; S
END SUB

SUB SelectSubVersion (WidthSM%, SNP, SMCol, SHelp$(), Esc)
'   ********************************
'   * Selection of item in submenu *
'   ********************************
' SNP - number of items in submenu Version
' SV - number of item in submenu
' SMCol - left column of submenu
' Version - number of an option in main menu
' Esc = True - exit to main menu without selecting an option

REDIM B%(10)                'array for storing cursor
Pointer WidthSM%, B%()      'initialize cursor
GOSUB ShowSPointer
Esc = False
Enter = False
  DO
    MoveSPointer SNP, Esc, Enter
    IF Enter = True OR Esc = True THEN
      EXIT DO
    END IF
    PUT (X, Y), B%, XOR
    GOSUB ShowSPointer
  LOOP
EXIT SUB

ShowSPointer:
' *** Output of cursor onto screen ***
  X = SMCol * 8
  Y = HL% * (SV + 2)
  PUT (X, Y), B%, XOR
' *** Output of information message ***
  LOCATE 25, 1
  PRINT SPACE$(80);
  LOCATE 25, 41 - LEN(SHelp$(SV)) / 2 'centering text
  PRINT SHelp$(SV);
  RETURN

END SUB

SUB SelectVersion (TextMN$(), MRow(), MCol(), Help$(), NV())
'   *******************************************
'   *    Selection of option in main menu     *
'   *                   +                     *
'   *   Call of corresponding procedure of    *
'   *      processing a selected option       *
'   *******************************************
' Version - number of option in main menu
REDIM A%(10)
GOSUB ShowPointer
DO
  DO
    MovePointer V, Enter
    PUT (X, Y), A%, XOR
    Version = V
    GOSUB ShowPointer
  LOOP UNTIL Enter = True
  SELECT CASE Version
  CASE 1
    GOSUB PartScreen
    Rectangle
    GOSUB AllScreen
  CASE 2
    GOSUB PartScreen

    trapesium
    GOSUB AllScreen
  CASE 3
    SV = 1
    MenuSub NV(Version), MCol(Version) - 1, Esc
    IF NOT Esc THEN
      SELECT CASE SV
      CASE 1
        GOSUB PartScreen
        Triangle1
        GOSUB AllScreen
      CASE 2
        GOSUB PartScreen
        Triangle2
        GOSUB AllScreen
      CASE 3
        GOSUB PartScreen
        Triangle3
        GOSUB AllScreen
      END SELECT
    END IF
    GOSUB ShowInformation
  CASE 4
    GOSUB PartScreen
    Circle1
    GOSUB AllScreen
  CASE 5
    EXIT DO
  END SELECT
LOOP
EXIT SUB

ShowPointer:
' *** Output of cursor onto screen ***
  L% = LEN(TextMN$(Version))
  Pointer L%, A%()
  X = 8 * MCol(Version) - 8
  Y = HL% * MRow(Version) - HL%
  PUT (X, Y), A%, XOR

ShowInformation:
' *** Output of information message ***
  LOCATE 25, 1
  PRINT SPACE$(80);
  LOCATE 25, 41 - LEN(Help$(Version)) / 2
  PRINT Help$(Version);
  RETURN

PartScreen:
  VIEW (0, HL% * 3 - 1)-(MaxX - 1, MaxY - 2 * HL% - 1)
  CLS
  WINDOW SCREEN (0, 0)-(MaxX - 1, MaxY - 1)
  VIEW PRINT 4 TO 23
  RETURN

AllScreen:
  VIEW PRINT
  VIEW (0, 0)-(MaxX - 1, MaxY - 1)
  RETURN

END SUB

SUB trapesium
'   *************************************
'   *  Calculation of area of trapesium *
'   *************************************
LINE (50, 20)-(180, 20)
LINE -(240, 60)
LINE -(20, 60)
LINE -(50, 20)
LINE (50, 20)-(50, 60), , , &HAAAA
LOCATE 4, 14
PRINT "a"
LOCATE 8, 14
PRINT "b"
LOCATE 6, 8
PRINT "h"
LOCATE 12, 1
PRINT "Enter parameters:"
PRINT
INPUT "a = ", A
INPUT "b = ", B
INPUT "h = ", H
S = (A + B) / 2 * H
PRINT
PRINT "S ="; S
END SUB

SUB Triangle1
'   **************************************************
'   * Calculation of area of triangle by three sides *
'   **************************************************
CLS
LINE (50, 20)-(240, 60)
LINE -(20, 60)
LINE -(50, 20)
LOCATE 5, 19
PRINT "c"
LOCATE 8, 14
PRINT "a"
LOCATE 5, 4
PRINT "b"
LOCATE 12, 1
PRINT "Enter parametrs:"
PRINT
INPUT "a = ", A
INPUT "b = ", B
INPUT "c = ", C
ABC = A > 0 AND B > 0 AND C > 0
IF A < B + C AND B < A + C AND C < A + B AND ABC THEN
  P = (A + B + C) / 2
  S = SQR((P - A) * (P - B) * (P - C) * P)
  S = CLNG(S * 100) / 100    'rounding off to 0.01
  PRINT
  PRINT "S ="; S;
ELSE
  PRINT
  PRINT "Such a triangle does not exist!";
END IF
END SUB

SUB Triangle2
'   ******************************************************
'   * Calculation of area of triangle by base and height *
'   ******************************************************
CLS
LINE (50, 20)-(240, 60)
LINE -(20, 60)
LINE -(50, 20)
LINE (50, 20)-(50, 60), , , &HAAAA
LOCATE 8, 14
PRINT "a"
LOCATE 6, 8
PRINT "h"
LOCATE 12, 1
PRINT "Enter parameters:"
PRINT
INPUT "a = ", A
INPUT "h = ", H
IF A > 0 AND H > 0 THEN
  S = A * H / 2
  PRINT
  PRINT "S ="; S
ELSE
  PRINT
  PRINT "Such a triangle does not exist!"
END IF
END SUB

SUB Triangle3
'   ***************************************
'   *   Calculation of area of triangle   *
'   * by two sides and angle between them *
'   ***************************************
CLS
LINE (80, 20)-(270, 100)
LINE -(55, 100)
LINE -(80, 20)
LOCATE 10, 19
PRINT "a"
LOCATE 7, 7
PRINT "b"
LOCATE 9, 6
PRINT "C"
LOCATE 12, 1
PRINT "Enter parameters:"
PRINT
INPUT "a = ", A
INPUT "b = ", B
INPUT "C = ", C
IF A > 0 AND B > 0 AND C > 0 AND C < 180 THEN
  Pi = 3.141593
  S = A * B / 2 * SIN(C * Pi / 180)
  S = CLNG(S * 100) / 100    'rounding off to 0.01
  PRINT
  PRINT "S ="; S
ELSE
  PRINT
  PRINT "Such a triangle does not exist!"
END IF
END SUB

