The [VIEW PRINT](VIEW-PRINT) statement defines the boundaries of a text viewport PRINT area.

## Syntax

>  **VIEW PRINT** [topRow% **TO** bottomRow%]

## Parameter(s)

* topRow% and bottomRow% specify the upper and lower rows of the text viewport. 
* If topRow% and bottomRow% are not specified when first used, the text viewport is defined to be the entire screen.

## Description

* A second [VIEW PRINT](VIEW-PRINT) statement without parameters can also disable a viewport when no longer needed.  
* [CLS](CLS) or [CLS](CLS) statement will clear the active text viewport area only, and reset the cursor location to topRow%.
* A [SCREEN](SCREEN) mode change or [RUN](RUN) statement can also clear and disable viewports.
* After active viewport is disabled, normal screen printing and clearing can begin.
* Row coordinates may vary when a [WIDTH](WIDTH) statement has been used.
* **Note: QB64 [RUN](RUN) statements will not close [VIEW PRINT](VIEW-PRINT), [VIEW](VIEW) or [WINDOW](WINDOW) view ports presently!**

## Example(s)

Demonstrates how text scrolls within the text viewport.

```vb

' clear the entire screen and show the boundaries of the new text viewport
CLS
PRINT "Start at top..."
LOCATE 9, 1: PRINT "<- row 9 ->"
LOCATE 21, 1: PRINT "<- row 21 ->"

' define new text viewport boundaries
VIEW PRINT 10 TO 20

' print some text that will scroll the text viewport
FOR i = 1 TO 15
  PRINT "This is viewport line:"; i
  SLEEP 1
NEXT i

' clear only the active text viewport with CLS or CLS 2
CLS
PRINT "After clearing, the cursor location is reset to the top of the text viewport."

' disable the viewport
VIEW PRINT
_DELAY 4
LOCATE 20, 20: PRINT "Print anywhere after view port is disabled"
_DELAY 4
CLS
PRINT "Back to top left after CLS!" 

```

> *Note:* The bottom row of the VIEW PRINT port can be used only when located or prints end with semicolons.

## See Also

* [CLS](CLS)
* [WINDOW](WINDOW)
* [VIEW](VIEW) (graphics view port)
* [LOCATE](LOCATE), [PRINT](PRINT)
