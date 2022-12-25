The [_WINDOWHANDLE](_WINDOWHANDLE) function returns the window handle assigned to the current program by the OS. Windows-only.

## Syntax

> hwnd%& = [_WINDOWHANDLE](_WINDOWHANDLE)

## Description

* The result is an [_OFFSET](_OFFSET) number assigned by Windows to your running program.
* Use it to make [Windows Libraries](Windows-Libraries) that require a window handle to be passed.
* [Keywords currently not supported](Keywords-currently-not-supported-by-QB64).

## Availability

* Build 20170924/68 and up.

## Example(s)

 Showing the system-default message box in Windows.

```vb

'Message Box Constant values as defined by Microsoft (MBType)
CONST MB_OK& = 0                'OK button only
CONST MB_OKCANCEL& = 1          'OK & Cancel 
CONST MB_ABORTRETRYIGNORE& = 2  'Abort, Retry & Ignore
CONST MB_YESNOCANCEL& = 3       'Yes, No & Cancel
CONST MB_YESNO& = 4             'Yes & No
CONST MB_RETRYCANCEL& = 5       'Retry & Cancel
CONST MB_CANCELTRYCONTINUE& = 6 'Cancel, Try Again & Continue
CONST MB_ICONSTOP& = 16         'Error stop sign icon
CONST MB_ICONQUESTION& = 32     'Question-mark icon
CONST MB_ICONEXCLAMATION& = 48  'Exclamation-point icon
CONST MB_ICONINFORMATION& = 64  'Letter i in a circle icon
CONST MB_DEFBUTTON1& = 0        '1st button default(left)
CONST MB_DEFBUTTON2& = 256      '2nd button default
CONST MB_DEFBUTTON3& = 512      '3rd button default(right)
CONST MB_APPLMODAL& = 0         'Message box applies to application only
CONST MB_SYSTEMMODAL& = 4096    'Message box on top of all other windows
CONST MB_SETFOCUS& = 65536      'Set message box as focus
CONST IDOK& = 1                 'OK button pressed
CONST IDCANCEL& = 2             'Cancel button pressed
CONST IDABORT& = 3              'Abort button pressed
CONST IDRETRY& = 4              'Retry button pressed
CONST IDIGNORE& = 5             'Ignore button pressed
CONST IDYES& = 6                'Yes button pressed
CONST IDNO& = 7                 'No button pressed
CONST IDTRYAGAIN& = 10          'Try again button pressed
CONST IDCONTINUE& = 1           'Continue button pressed
'----------------------------------------------------------------------------------------

DECLARE DYNAMIC LIBRARY "user32"
FUNCTION MessageBoxA& (BYVAL hwnd AS _OFFSET, Message AS STRING, Title AS STRING, BYVAL MBType AS _UNSIGNED LONG)
END DECLARE

DO
  msg& = 0: icon& = 0: DB& = 0
  INPUT "Enter Message Box type(0 to 6 other Quits): ", BOX&
  IF BOX& < 0 OR BOX& > 6 THEN EXIT DO

  INPUT "Enter Icon&(0=none, 1=stop, 2=?, 3=!, 4=info): ", Icon&
  
  IF BOX& THEN INPUT "Enter Default Button(1st, 2nd or 3rd): ", DB&
  IF DB& THEN DB& = DB& - 1     'adjust value to 0, 1, or 2
  msg& = MsgBox&("Box Title", "Box text message", BOX&, Icon&, DB&, 4096) 'on top of all windows

  PRINT "Button ="; msg&
LOOP
END

FUNCTION MsgBox& (Title$, Message$, BoxType&, Icon&, DBtn&, Mode&)
SELECT CASE Icon&
  CASE 1: Icon& = MB_ICONSTOP&          'warning X-sign icon
  CASE 2: Icon& = MB_ICONQUESTION&      'question-mark icon
  CASE 3: Icon& = MB_ICONEXCLAMATION&   'exclamation-point icon
  CASE 4: Icon& = MB_ICONINFORMATION&   'lowercase letter i in circle
  CASE ELSE: Icon& = 0 'no icon
END SELECT
IF BoxType& > 0 AND DBtn& > 0 THEN 'set default button as 2nd(256) or 3rd(512)
  SELECT CASE BoxType&    
    CASE 2, 3, 6
     IF DBtn& = 2 THEN Icon& = Icon& + MB_DEFBUTTON3& ELSE Icon& = Icon& + MB_DEFBUTTON2& '3 button
    CASE ELSE: Icon& = Icon& + MB_DEFBUTTON2& '2nd button default
  END SELECT
END IF
Focus& = MB_SetFocus&
MsgBox& = MessageBoxA&(_WINDOWHANDLE, Message$, Title$, BoxType& + Icon& + Mode& + Focus&) 'focus on button
END FUNCTION 

```

> *Explanation:* Notice how the call to the external dynamic library function MessageBoxA& passes _WINDOWHANDLE to the API and how the message box shown is created as a child of your program's window, not allowing the main window to be manipulated while the message box is open.

## See Also

* [_WINDOWHASFOCUS](_WINDOWHASFOCUS)
* [Windows Libraries](Windows-Libraries)
