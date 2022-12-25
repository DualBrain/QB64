The [_FULLSCREEN](_FULLSCREEN) function returns the present full screen mode setting of the screen window.

## Syntax

> full% = [_FULLSCREEN](_FULLSCREEN-(function))

## Description

* *Function returns:*
  * 0 = _OFF (any positive non-0 value means fullscreen is on)
  * 1 = _STRETCH
  * 2 = _SQUAREPIXELS
* It **cannot** be assumed that calling [_FULLSCREEN](_FULLSCREEN) will succeed. It cannot be assumed that the type of full screen will match the requested one. **Always check the [_FULLSCREEN (function)](_FULLSCREEN-(function)) return in your programs.**
* **Warning:** Despite your software, the user's hardware, drivers and monitor may not function in some modes. Thus, it is highly recommended that you manually confirm with the user whether the switch to full screen was successful. This can be done "quietly" in some cases by getting the user to click on a button on screen with their mouse or press an unusual key. If the user does not respond after about 8 seconds, switch them back to windowed mode.

**Using large fonts with [_FULLSCREEN](_FULLSCREEN) can cause monitor or Windows Desktop problems or kill a program.**

## Example(s)

Shows how fonts and the _FULLSCREEN mode can resize a program window.

```vb

CLS
fontpath$ = ENVIRON$("SYSTEMROOT") + "\fonts\lucon.ttf" 'Find Windows Folder Path.
f& = _FONT: defaultf& = f&
DO
  INPUT "1) DEFAULT  2) SIZE WINDOW  3) FULL SCREEN   4) FULL STRETCHED  Q) QUIT: ", winmode$

  IF UCASE$(winmode$) = "Q" THEN EXIT DO

  style$ = "MONOSPACE"

  SELECT CASE winmode$
    CASE "1"
      full = _FULLSCREEN  'get current full screen mode
      IF full <> 0 THEN _FULLSCREEN _OFF
      GOSUB ChangeFont

    CASE "2"
      DO
        PRINT
        INPUT "Enter a FONT SIZE 5 to 25: ", fontsize%
      LOOP UNTIL fontsize% > 4 AND fontsize% < 26

      DO
        PRINT
        INPUT "Enter (0) for REGULAR or (1) for ITALIC FONT: ", italic%
      LOOP UNTIL italic% = 0 or italic% = 1

      DO
        PRINT
        INPUT "Enter (0) for REGULAR or (1) for BOLD FONT: ", bold%
      LOOP UNTIL italic% = 0 or italic% = 1

      IF italic% = 1 THEN style$ = style$ + ", ITALIC"
      IF bold% = 1 THEN style$ = style$ + ", BOLD"
      full = _FULLSCREEN  'get current full screen mode
      IF full <> 0 THEN _FULLSCREEN _OFF            
      GOSUB ChangeFont

    CASE "3"
      GOSUB ChangeFont
      _FULLSCREEN _SQUAREPIXELS
      GOSUB CheckFull

    CASE "4"
      GOSUB ChangeFont
      _FULLSCREEN _STRETCH
      GOSUB CheckFull
            
    END SELECT

    PRINT: PRINT "_FullScreen mode ="; _FULLSCREEN
    PRINT
LOOP
GOSUB ChangeFont
END

CheckFull:   '<<<<<<<<<<<<<< turn off full screen if function returns 0!
full = _FULLSCREEN  'get current full screen mode 
IF full = 0 THEN _FULLSCREEN _OFF: SOUND 100, .75
RETURN

ChangeFont:
IF winmode$ <> "2" THEN
  _FONT 16 'select inbuilt 8x16 default font
    currentf& = _FONT
ELSE
  currentf& = _LOADFONT(fontpath$, fontsize%, style$)
  _FONT currentf&
END IF

IF currentf& <> f& AND f& <> defaultf& THEN _FREEFONT f&
f& = currentf&
RETURN 

```

*Explanation:* The **_FULLSCREEN** function can avoid screen display and monitor problems when used to monitor the success of the full screen operation. If a full screen mode is **not** achieved (the function will return 0), **call [_FULLSCREEN](_FULLSCREEN) OFF**

## See Also

* [_FULLSCREEN](_FULLSCREEN) (statement)
* [_ALLOWFULLSCREEN](_ALLOWFULLSCREEN)
* [_SCREENMOVE](_SCREENMOVE), [_SCREENX](_SCREENX), [_SCREENY](_SCREENY)
