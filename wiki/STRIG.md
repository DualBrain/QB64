The **STRIG** function returns button press True or False status of game port (&H201) or USB joystick control device(s).

## Syntax

> IF STRIG(button_function%) THEN ...

## QB64 Syntax

> IF STRIG(*button_function%*[, *device_number%*]) THEN ...

*Description:*
* Function returns -1 when a button event(even functions) has occurred or a button is pressed(odd functions). 
* STRIG will not read keyboard or mouse buttons detected by [_DEVICES](_DEVICES).
* The *device number* must be used with more than 2 devices. Use device 1 function numbers for just one joystick.
* **QB64** can read many buttons from many devices and allows the use of devices with more than 2 buttons.
* Returns True(-1) or False(0) button press values for 2 devices. Each leading STRIG checks for missed button press events:

```text

  **STRIG(0) = -1  'lower button 1 on device 1 pressed since last STRIG(0) read**
  **STRIG(1) = -1  'lower button 1 on device 1 currently pressed**
  STRIG(2) = -1  'lower button 1 on device 2 pressed since last STRIG(2) read
  STRIG(3) = -1  'lower button 1 on device 2 currently pressed
  **STRIG(4) = -1  'upper button 2 on device 1 pressed since last STRIG(4) read** 
  **STRIG(5) = -1  'upper button 2 on device 1 currently pressed**
  STRIG(6) = -1  'upper button 2 on device 2 pressed since last STRIG(6) read
  STRIG(7) = -1  'upper button 2 on device 2 currently pressed (maximum in QBasic)
  **STRIG(8) = -1  'button 3 on device 1 pressed since last STRIG(8) read**  'QB64 only
  **STRIG(9) = -1  'button 3 on device 1 currently pressed**           
  STRIG(10) = -1 'button 3 on device 2 pressed since last STRIG(10) read 'QB64 only
  STRIG(11) = -1 'button 3 on device 2 currently pressed

```

* STRIG(0), STRIG(2), STRIG(4), STRIG(6), STRIG(8), STRIG(10) are used to monitor any presses that might have been missed.
* **QB64** allows more than two controllers by using the second parameter as the stick number and the odd or even STRIG values:

```text

**STRIG(0, 3): STRIG(1, 3): STRIG(4, 3): STRIG(5, 3): STRIG(8, 3): STRIG(9, 3) 'device 3 {odd)**
STRIG(2, 4): STRIG(3, 4): STRIG(6, 4): STRIG(7, 4): STRIG(10, 4): STRIG(11, 4) 'device 4 (even)

```
 
> Odd devices use 0, 1, 4, 5, 8 and 9 and Even devices use 2, 3, 6, 7, 10 and 11 as first parameters with device number following.
* **There will not be an error if you try to read too many device axis or buttons!**

## Example(s)

Displays the input from 3 joysticks, all with dual sticks and 3 buttons.

```vb

DO: _LIMIT 10

  LOCATE 1, 1
  PRINT "JOY1: STICK"; STICK(0); STICK(1); STICK(0, 2); STICK(1, 2);_ 
  "STRIG"; STRIG(0); STRIG(1); STRIG(4); STRIG(5); STRIG(8); STRIG(9)

  PRINT "JOY2: STICK"; STICK(2); STICK(3); STICK(2, 2); STICK(3, 2);_ 
  "STRIG"; STRIG(2); STRIG(3); STRIG(6); STRIG(7); STRIG(10); STRIG(11)

  PRINT "JOY3: STICK"; STICK(4); STICK(5); STICK(4, 2); STICK(5, 2);_ 
  "STRIG"; STRIG(0, 3); STRIG(1, 3); STRIG(4, 3); STRIG(5, 3); STRIG(8, 3); STRIG(9, 3)
    
LOOP UNTIL INKEY$ > "" 

```

> *Explanation:* Notice the extra **QB64 only** parameters used to cater for the 2nd stick and the buttons of the 3rd joystick.

## See Also
 
* [STRIG(n)](STRIG(n)) (statement)
* [ON STRIG(n)](ON-STRIG(n)), [STICK](STICK)
* [_DEVICES](_DEVICES), [_DEVICE$](_DEVICE$), [_LASTBUTTON](_LASTBUTTON)
* [http://en.wikipedia.org/wiki/Analog_stick Single and Dual Stick Controllers]
