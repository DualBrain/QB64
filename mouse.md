[Home](https://qb64.com) • [News](news.md) • [GitHub](https://github.com/QB64Official/qb64) • [Wiki](https://github.com/QB64Official/qb64/wiki) • [Samples](samples.md) • [InForm](inform.md) • [GX](gx.md) • [QBjs](qbjs.md) • [Community](community.md) • [More...](more.md)

## Articles - Mouse

*by Luke*

```text

An introductory text to the QB64 mouse interface
************************************************

High-level overview
-------------------
Whenever a mouse event occurs, the mouse generates a message, and adds it to the end of a queue. Every message contains the entire state of the mouse: its location and the state of all buttons.

A mouse event is generated on any of the following events: 
 - A button is pressed.
 - A button is released.
 - The mouse changes position.

Note that a message is *not* generated while a button is held down and the mouse is stationary. As long as you don't move the mouse, pressing and releasing a button will only generate two messages in total (one for press, one for release).


Dealing with the mouse queue
------------------------
To fetch messages from the queue (so their data can be read), the _MOUSEINPUT command is used. It has the following behaviour: if a new message is available in the queue, fetch that one, make it the 'current' message, and return -1. If no messages are available, leave the 'current' message untouched, and return 0.

To actually read data, the commands _MOUSEX, _MOUSEY and _MOUSEBUTTON are used. These three commands query the data contained in the current message, as set by _MOUSEINPUT (described above). As long as _MOUSEINPUT is not called, these functions will always be accessing the same message, and thus always return the same data.

By default, the current message is undefined, and calling the data-access functions without first loading a message with _MOUSEINPUT is pointless.


Commands to fetch data
----------------------
_MOUSEX, _MOUSEY: Returns the X & Y coordinates of the mouse described in the current message. In graphics modes, it is an integer value, equivalent to the pixel coordinate system used by graphics commands (i.e., PSET (_MOUSEX, _MOUSEY) will plot a point directly where the mouse is). For text mode, _MOUSEX & _MOUSEY will return a floating-point value. The coordinate are in character units but with the origin such that (1, 1) is the *middle* of the character located in the top-left corner. That is, (0.5, 0.5) is the top-left of the screen. Because the character cells are not square, 1 unit in the Y direction is a larger distance onscreen than 1 unit in the X direction.

_MOUSEBUTTON(n): Returns the state of button number n; -1 if the button is pressed, 0 if it is not. Programs can rely on the following button numbers:
  1 = left mouse button
  2 = right mouse button
  3 = middle mouse button
No other buttons are currently defined. On Windows, if the user has chosen to swap left and right mouse buttons, this setting will not be respected. Accessing this information in the registry is detailed below.

_MOUSEHWEEL: Returns the amount of scroll on the scroll wheel. Unlike other functions that simply inspect the current mouse message, _MOUSEHWEEL keeps a running tally of mouse wheel activity, examing every mouse message as it comes to the front of the queue automatically. Whenever _MOUSEHWEEL sees the wheel scrolled towards the user, it adds 1 to its internal count. When it is scrolled away, it subtracts 1. When _MOUSEWHEEL is read, its value is reset to 0. Thus, _MOUSEWHEEL's return value reflects the net amount of scroll since _MOUSEWHEEL was last called.

***************************************************
* Note: the scroll wheel does not function on OSX *
***************************************************

Code analysis
-------------
(We use a _LIMIT 30 in our main loops here. This is solely to show where a _LIMIT should be placed; no precise value is being recommended)


DO 'main program loop
    IF _MOUSEINPUT THEN
        'Do stuff with mouse
    END IF
    'do other stuff
    _LIMIT 30
LOOP
A naive implementation. Although this may suffice for trivial programs, as the "do stuff with mouse" increases in complexity, executing it with every mouse message quickly brings the main loop under its _LIMIT value. Remember, a mouse message is generated every time the mouse changes position, so a simple drag from one side of the window to the other will generate hundreds of messages.

***************************************

DO 'main program loop
    DO WHILE _MOUSEINPUT: LOOP
    'Access mouse data
    PRINT _MOUSEX; _MOUSEY
    'Do other stuff
    _LIMIT 30
LOOP
A solid improvement. The inner loop will continually fetch new messages from the queue until it is empty, leaving the last message as the current one. We then accesses data from that last message. Since the queue is a first-in first-out structure, this effectively loads the most recent mouse state. Although this avoids the message overload seen in the first method, it is entirely possible to miss mouse clicks.

****************************************

DO
    IF _MOUSEINPUT THEN
        IF _MOUSEBUTTON(1) = mouse_down THEN 'Is the button still in the same position?
            DO WHILE _MOUSEINPUT
                IF _MOUSEBUTTON(1) <> mouse_down THEN EXIT DO 'Process through the queue until the button changes state
            LOOP
        END IF
        mouse_down = _MOUSEBUTTON(1)
        'Do mouse processing here
    END IF
    'Do other stuff
    _LIMIT 30
LOOP
A more advanced method. Like above, we repeatedly call _MOUSEINPUT to skip over the many messages generated by movement. In addition, we stop going along the queue if the mouse button's state changes. Thus it is impossible to miss a mouse click, no matter how long the main loop takes. The author has used this technique with great success in a menu & button GUI library to detect mouse clicks.


Windows registry
----------------
On Windows, reversing the mouse buttons is not done by modifiying input to programs, but rather by setting a registry key and expecting programs to respect it. The following code, based on a demo by Michael Calkins, has proven useful:

$IF WINDOWS THEN
    'This code largely based on a demo by Michael Calkins
    DECLARE DYNAMIC LIBRARY "advapi32"
        FUNCTION RegOpenKeyExA& (BYVAL hKey AS _OFFSET, lpSubKey$, BYVAL ulOptions AS _UNSIGNED LONG, BYVAL samDesired AS _UNSIGNED LONG, BYVAL phkResult AS _OFFSET)
        FUNCTION RegCloseKey& (BYVAL hKey AS _OFFSET)
        FUNCTION RegQueryValueExA& (BYVAL hKey AS _OFFSET, lpValueName$, BYVAL lpReserved AS _OFFSET, BYVAL lpType AS _OFFSET, lpData$, BYVAL lpcbData AS _OFFSET)
    END DECLARE
    result$ = SPACE$(2)
    rsize = 2
    l1 = RegOpenKeyExA(&H80000001, "Control Panel\Mouse" + CHR$(0), 0, &H20019, _OFFSET(hkey%&))
    l2 = RegQueryValueExA(hkey%&, "SwapMouseButtons" + CHR$(0), 0, 0, result$, _OFFSET(rsize))
    l3 = RegCloseKey(hkey%&)
    IF l1 = 0 AND l2 = 0 AND left$(result$, 1) = "1" THEN
        Swapmouse = -1
    END IF
$END IF

The variable Swapmouse will then be -1 is the mouse buttons should be swapped, 0 otherwise. Note that on non-Windows (on Linux, at least. The author does not know the behaviour on OSX.) platforms, the program receives the buttons already swapped to the user's desire, so there is never any need to swap within the program.

```