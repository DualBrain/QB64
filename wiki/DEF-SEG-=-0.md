The following **DOS BIOS** information can be used on Windows 9x machines. Not necessarily XP or NT! Each routine includes the hexadecimal and decimal registers. 

> **NOTE: Few of these addresses are currenly accessable in QB64! Some may never be due to OS changes.**

> **DEF SEG = 0 LOW MEMORY PORT ADDRESSES**
> #### #### #### #### #### #### #### 

> **PORT # | FUNCTION, DESCRIPTION OR COMMENTS FOR USE**
> #### #### #### #### #### #### #### #### #### #### =

## TIMER

* **&H42 (66)**

> SETS TIMER CHIP TO PRODUCE A FREQUENCY 20 TO 20,000 HZ:

```vb

   A = INT(1193182 / F)
   H = INT(A / 256)
   L = A - H * 256 
   OUT 66, L: OUT 66, H

```

* **&H43 (67)**

> OUT 67, 182 PREPARES TIMER CHIP TO RECEIVE A VALUE.

* **&H46C - &H46E (1132 - 1134)**

> ticks& = PEEK (1132) + 256 * PEEK (1133) + 65536 + PEEK (1134)

> WILL PROVIDE THE NUMBER OF CLOCK TICKS SINCE MIDNIGHT 1 TO 1,533,039 (18.2 PER SEC)

> USING A ONE TICK TIMER LOOP:

```vb

 DEF SEG = 0    ' set to PEEK and POKE TIMER
 POKE (1132), 0 ' zero Timer ticks
 DO
   key = INP(&H60) 
 LOOP UNTIL PEEK(1132) >= 1 ' until one tick (@ 1/18th sec.) has passed 
 DEF SEG

```

* **&H470 = 1136)**

DETERMINING THE DATE n DAYS FROM NOW. 

```vb

  A$ = DATE$: PRINT A$                'IMPORTANT! save original date!
  IF n <= 255 THEN POKE 1136, n
  IF n > 255 THEN     
     FOR D = 1 TO n: POKE 1136, 1: NEXT D
  END IF
  laterdate$ = DATE$
  PRINT laterdate$                    'resulting date n days from today
  DATE$ = A$                          'restore original computer date! 

```

## HARDWARE

* **&H61 (97)**

> OUT 97,INP(97) OR 3 TO     'TURN THE SPEAKER ON.
> OUT 97,INP(97) OR 8 TO     'TURN THE CASSETTE MOTOR OFF.
> OUT 97,INP(97) AND 247     'TO TURN THE CASSETTE MOTOR ON.
> OUT 97,INP(97) AND 252     'TO TURN THE SPEAKER OFF.
> POKE (97),PEEK(97) OR 128  ' DISABLES PC/XT KEYBOARDS.
> POKE (97),PEEK(97) AND 127 ' ENABLES PC/XT KEYBOARDS.

## PRINTER

* **&H62 (98)**

> PEEK (98)  PROVIDES CURRENT PRINTER WIDTH.
> POKE 98, w" SETS CURRENT PRINTER WIDTH TO w.


* **&H6C - &H6F (108 - 111)**

> POKE 108, 83: POKE 109, 255: POKE 110,0: POKE 111,240 'DISABLE CTRL-BRK.
> POKE 108, 240: POKE 109, 32: POKE 110,3: POKE 111,12 ' ENABLES CTRL-BRK.

## DISK

* **&H43F (1087)** 

Determining the status of a drive motor:

```vb

IF PEEK(1087) AND 128 = 128 THEN PRINT "drive write in progress"
IF PEEK(1087) AND 15  = 0 THEN PRINT "No drive being written to" 

```

Drive$ designated is A, B, C or D, and the letter must be in uppercase.

```vb

IF PEEK(1087) AND 2 ^ (ASC (Drive$) - 65) THEN PRINT "Drive: " Drive$ 

```
> **NOTE:** These value are not affected if an OUT was used to turn on the motor.


* **&H440 (1088)**   

 To turn on drive D for n seconds, where n is at MOST 14! :

```vb
                     
POKE 1088, 18 + 2 * n
OUT 1010, 2 ^ (ASC("D") - 61) + ASC("D") - 53   '1010 = &H3F2 

```
> **NOTE:** Location 1088 holds the countdown, in clock ticks, until the motor is shut off. To turn off all drives, send: OUT 1010, 12


* **&H445 (1093) **

track = PEEK(1093)  'determine the diskette track that was last accessed


* **&H446 (1094)**  

head = PEEK(1094)  'determine which diskette head (0 or 1) was last accessed


* **&H447 (1095)**   

sector = PEEK(1095)  'determine which diskette sector was last accessed

* **&H448  (1096)**   

bytes = 128 * 2 ^ PEEK(1096)  'number of bytes per sector on a diskette

* **&H78 - &H7B  (120 - 123)** 

The diskette parameter table consists of 11 bytes

```vb

DEF SEG = 0
D = PEEK(120) + 256 * PEEK(121) ' get value of Diskette

DEF SEG = PEEK(122) + 256 * PEEK(123) 'set to derive the following table
track = (PEEK(D) AND 240) \ 8 'time(milliseconds) required for diskette drive to move track to track
HUT = (PEEK(D) AND 15) * 32 ' head unload time(milliseconds) after read or write has occurred
HLT = (PEEK(D + 1) AND 240) \ 4 'head load time (in milliseconds)
DirMode = (PEEK(D + 1) AND 15) 'Direct Memory Access mode
WT = PEEK(D + 2) 'wait time until turning the motor off
BPS = PEEK(D + 3) 'number of bytes per sector on the disk. FOR v = 0 TO 3: 128 * 2 ^ v bytes per sector, 
SPT = PEEK(D + 4) 'number of sectors per track, usually 8 or 9
GapLen = PEEK(D + 5) 'gap length (in bytes) between sectors
DatLen = PEEK(D + 6) 'data length read or written into a sector when sector length not specified
GFLen = PEEK(D + 7) 'gap length used when formatting
FVal = PEEK(D + 8) 'value format operation uses to initialize diskette sectors, usually 256
HST = PEEK(D + 9) 'number of milliseconds for the heads to stabilize
MST = PEEK(D + 10) 'number of eighths of a second for motor startup
DEF SEG 

```

> **WARNING: Changing the values of PEEK(D + 3) and PEEK(D + 4) can modify the way that diskettes are read and might require you to format your diskettes manually!**

* **&H504 (1284)**

If a single diskette drive is used for both drives A: and B:, current role is:

> PRINT "Current Drive: " + CHR$(65 + PEEK(1284))

* **&H475 (1141)**

numHD% = PEEK (1141)  'provides number of hard drives installed

* **&H413 - &H414 (1043-44)**

PEEK (1043) + 256 * PEEK(1044) 'indicates the RAM installed in kilobytes

* **&H3F2 (1010)**

OUT 1010, 12 'will turn off all drives

## PORTS

**PRINTER LPT Ports**

> &H411
> numLPT% = (PEEK (1041) AND 192) / 64 = the number of LPT printer adaptors installed.

> &H406, &H407
> firstLPT = PEEK(1030 + 2 * n) + PEEK(1031 + 2 * n) * 256

To swap two printers, interchange their initial port numbers.
Denote the first port associated with LPTn by Pn. The value
of P1 will be 956 if LPT1 is attached to the IBM monochrome display
and parallel printer adapter.     

**RS-232 Serial port INTERFACE**

> &H411

The number of RS-232 cards attached can be found with: (PEEK(1041) AND 14)/2

> To determine the first of the seven ports associated with COMn:

> &H3FE, &H3FF
> PEEK(1022 + 2 * n) + 256 * PEEK(1023 + 2 * n).
> If this number is 0, then COMn is not available.

To swap two RS-232 interfaces, interchange their initial port numbers.

         Denote the initial port associated with COMn by Pn (Base).
         Normally, the value of P1 is 1016 and the value of P2 is 760.

                Interrupt enabling:     Base + 1 address
        OUT Pn + 1, 1 enables an interrupt when a character has been received
        OUT Pn + 1, 2 enables an interrupt when a character has been transmitted
        OUT Pn + 1, 4 enables an interrupt when an error has occurred
        OUT Pn + 1, 8 enables an interrupt when the modem status has changed

To enable several of the above interrupts at the same time, OUT the
         sum of the associated numbers to port Pn + 1.

To identify interrupts, use the port number determined above  Base + 2:

        X = INP(Pn + 2). 
        IntSet% = X AND 1       'has a value of 1 as long as no interrupts have been 
                                'issued because of communications port activity.

        IntHi% = X AND 6        'is used to identify the highest priority interrupt
                                'pending, as indicated in the table "Interrupt Control 
                                'Functions" in the IBM Technical Reference manual.

To establish the number of data bits (d), the number of stop bits (s), Base + 3
and the parity (p = 0 for no parity, p = 1 for odd parity, p = 3 for even parity),

       Send: OUT Pn + 3, (d - 5) + (4 * (s - 1) + 8 * p).

To establish the baud rate:  address = Base, Base + 1, Base + 3    
      H = INP(Pn + 3): OUT Pn + 3, H OR 128:
      OUT Pn, DL: OUT Pn + 1, DH: OUT Pn + 3, H. 
      
      Use values DL = 128 and DH = 1 for 300
      baud, and DL=96 and DH=0 for baud rate 1200.
 
      Otherwise, DL = d MOD 256 and DH = d \ 256
      Where d is the divisor number given by the IBM Technical Reference manual
           in the table "Baud Rate at 1.853 MHz."

To produce a break signal:  address = Base + 3 
      X = INP(Pn + 3)
      OUT Pn + 3, X OR 64:PLAY "MF":SOUND 32767,6: SOUND 32767,1: OUT Pn+3,X.

      The PLAY and SOUND statements produce a delay of 1/3 second.

To control the modem, use:  address = Base + 4 
       OUT Pn + 4, 1 to assert that the data terminal is ready (DTR)
       OUT Pn + 4, 2 to raise a request to send (RTS)
       OUT Pn + 4, 16 to perform loopback testing

     To accomplish several of the above tasks simultaneously, OUT the sum of the
     associated numbers to port Pn + 4.

To determine the status of data transfer, begin with Base + 5:
      LET X = INP(Pn + 5). Now:

      idle% = X AND 64  'has a value of 64 if the transmitter shift register is idle
      ready% = X AND 32 'is 32 if the transmitter holding register is ready to
                        'accept a character for transmission
      break% = X AND 16 'has the value 16 if the received data input is held in the
                        'spacing state too long (that is, if a break was received)
      nostop% = X AND 8 'has the value 8 if the received character did not have a
                        'valid stop bit; that is, if a framing error occurred
      noPar% = X AND 4  'has the value 4 if the received character does not have correct 
                        'parity
      overR% = X AND 2   'is 2 if the received data destroyed the previous character
                        '(an overrun error)
      RecRead% =  X AND 1 'has value 1 if a character is ready to be read from received 
                          'buffer register

      INP(Pn) will read the ASCII value of a character from the serial port,
   
            IF (INP(Pn + 5) AND 1) = 1 THEN char$ = CHR$(INP(Pn)) 

You can use OUT Pn, m to write the character with ASCII value m to the serial
           read Base + 5 first:
       IF (INP(Pn + 5) AND 32) = 32 THEN

       To determine the status of the modem, use Base + 6: 
       X = INP(Pn + 6). Then:
         X AND 128 has the value 128 if a Carrier signal has been detected
         X AND 64 is 64 if the modem is ringing
         X AND 32 has a value of 32 if the modem has asserted Data Set Ready
         X AND 16 is 16 if the modem has asserted Clear to Send
         X AND 8 is 8 if the Carrier Detect has changed state
         X AND 4 has the value 4 if the Ring Indicator input has changed from On to Off
         X AND 2 is 2 if the Data Set Ready input has changed state since last read
         X AND 1 has a value of 1 if the Clear to Send input has changed since last read


&H3FE = 1022   

> PROVIDES INFORMATION RELATED TO RS232 COMMUNICATIONS PORTS:

> PEEK(1022 + 2 * n) + PEEK(1023 + 2 * n) * 256 
> WHERE COMn value = 0 IF COMn: IS NOT AVAILABLE.

> &H411 = 1041   

> (PEEK (1041) AND 14)/2    'WILL PROVIDE NUMBER OF Serial RS232 PORTS INSTALLED.
> (PEEK (1041) AND 16)/16   'WILL PROVIDE NUMBER OF GAME PORTS INSTALLED.
> (PEEK (1041) AND 192)/64  'WILL PROVIDE NUMBER OF LPT Ports INSTALLED.

&H408 = 1032   | Provides Information on PRINTER PORTS (LPT)

> FOR i% = 1 TO 3
>   lpt% = PEEK(&H408 + (i% - 1) * 2) + PEEK(&H408 + (i% - 1) * 2 + 1) * 256
>   LOCATE , 23: PRINT "LPT"; HEX$(i%);
>   IF lpt% = 0 THEN
>     PRINT " not found"
>   ELSE : PRINT " found at &H"; HEX$(lpt%); " ("; LTRIM$(STR$(lpt%)); ")"
>   END IF
>   IF lpt% = 888 THEN port378% = i% ' usually the LPT1 port printer address
> NEXT

## DISPLAY

> **DEF SEG = 0 MONITOR INFORMATION**
> #### #### #### #### #### ## 

> To check the type of display:

> &H410 = 1040

> PEEK(1040) AND 48 = 0 ' is no monitors      ' &H410
> PEEK(1040) AND 48 = 16 ' is a 40 x 25 graphics monitor
> PEEK(1040) AND 48 = 32 ' is a 80 x 25 graphics monitor
> PEEK(1040) AND 48 = 48 ' is a monochrome display

> To select a display:
    
> POKE 1040, PEEK(1040) OR 48 ' Monochrome

> SCREEN 0: WIDTH 80: LOCATE ,,1,0,0
> POKE 1040,(PEEK(1040) AND 207) OR 16 ' graphics
> SCREEN 1,0,0,0:WIDTH 80:LOCATE ,,1,0,0.

> &H44A, &H44B = 1098, 1099 ' (DEF SEG = 0)

> columns = PEEK(1098) + 256 * PEEK(1099) 'gives the present screen width in columns.

> (DEF SEG = 64)
> DEF SEG = &H40: textcols = PEEK(&H4A): DEF SEG

> &H44E, &H44F = 1102, 1103

Graphics screen contents stored in a buffer at:

> PEEK(1102) + 256 * PEEK(1103).

memory that physically resides on a graphics board.

> &H44C, &H44D = 1100, 1101
> PEEK(1100) + 256 * PEEK(1101) ' Buffer size 

> The cursor locations for the various pages are given as follows:
> Let CR(n) and CC(n) be the Cursor Row and Cursor Column for page n.
> &H450, &H451 = 1004, 1005

> PEEK(1105) + 2 * n) ' has a value of CR(n) - 1,
     
> PEEK(1104 + 2 * n) ' has a value of CC(n) - 1.

> &H460 to &H462 = 1120 to 1122
> The shape of the cursor can be set as follows: LOCATE ,,,I,J.

> :PEEK(1121) AND 31 ' has value I
> :PEEK(1120) AND 31 ' has value J.
> :PEEK(1121) AND 32 ' = 32 then cursor is not displayed.
> :PEEK(1122)  ' will equal the active visual page.


To determine the active 6845 index register:

      &H463             &H464
"PEEK(1123) + 256 * PEEK(1124)" = 948 if monochrome display board in use.
= 980 for the color/graphics adapter.
          To check the 6845 mode settings:
            &H465
       PEEK(1125) AND 1 has value 1 if in text mode, width 80
       PEEK(1125) AND 2 has value 2 if in graphics mode
       PEEK(1125) AND 4 has value 4 if color is disabled.
       PEEK(1125) AND 8 has value 8 if video is enabled.
       PEEK(1125) AND 16 has value 16 if in high-resolution graphics mode
       PEEK(1125) AND 32 has value 32 if blinking is enabled

Background color and palette selected by COLOR bg,fc :
           &H466
      bg = (PEEK(1126) AND 15)    'background color
      fc = (PEEK(1126) AND 32)/32 'fore color
      bc = PEEK(1126) MOD 16      'border color


> &H410 = 1040   
> :| (PEEK (1040) AND 1) * (1 + PEEK (1040)) \ 64 PROVIDES NUMBER OF DRIVES.
> :|  PEEK (1040) AND 48
> :| 0 = NO MONITOR INSTALLED.
> :| 16 = 40 x 25 GRAPHICS.
> :| 32 = 80 x 25 GRAPHICS.
> :| 48 = MONOCHROME.

> :| "POKE (1040), PEEK(1040) OR 48" SELECTS MONOCHROME DISPLAY.
> :| "POKE (1040), PEEK(1040) AND 207 OR 32" SELECTS 80 x 25 GRAPHICS.
> ::NOTE: | SCREEN 0,0,0:WIDTH 80 SHOULD BE USED BEFORE CALLING MONOCHROME.
> ::NOTE: | SCREEN 1,0,0,0:WIDTH 80 SHOULD BE USED BEFORE CALLING 80 x 25 GRAPHICS
> ::NOTE: | SAVE VALUES IN PORTS 1097 THRU 1126 IN AN ARRAY FOR RESTORING IN THE EVENT THAT YOU WANT TO CHANGE BACK TO ORIGINAL DISPLAY WITH CONFIDENCE

> &H449 = 1097 PEEK (1097) PROVIDES DISPLAY MODE INFORMATION:
> : 0 = TEXT MODE, WIDTH 40, NO COLOR.
> : 1 = TEXT MODE, WIDTH 40, COLOR.
> : 2 = TEXT MODE, WIDTH 80, NO COLOR.
> : 3 = TEXT MODE, WIDTH 80, COLOR.
> : 4 = MEDIUM GRAPHICS MODE, COLOR.
> : 5 = MEDIUM GRAPHICS MODE, NO COLOR.
> : 6 = HIGH RESOLUTION GRAPHICS.
> : 7 = TEXT MODE, WIDTH 80, MONOCHROME.

> &H449 - &H44A = 1097-98
> : | POKE (1097),4:POKE (1098),40 ' PROVIDES SCREEN 2 WITH WIDTH 40.
> : | POKE (1097),6:POKE (1098),80 ' PROVIDES SCREEN 2 WITH WIDTH 80.

&H44C, &H44D, &H44E, &H44F = 1100-03 CONTAINS CONTENTS OF GRAPHICS MEMORY RESIDING ON THE DISPLAY CARD.
> : | SIZE = PEEK(1100) + 256 * PEEK(1101)
> : | LOCATION = PEEK(1102) + 256 * PEEK(1103)

> &H450 - &H451 = 1104-05 CONTAINS CURSON LOCATIONS FOR VARIOUS GRAPHICS MEMORY PAGES.
> :| COL = PEEK(1104 + 2 * n) 
> :| ROW = PEEK(1105 + 2 * n)" WHERE n IS THE PAGE.
       
> &H460 = 1120
> :| J = PEEK (1120) AND 31 ' REFLECTS VALUE OF LOCATE ,,,I,J.

> &H461 = 1121   
> :| I = PEEK (1121) AND 31 ' REFLECTS VALUE OF LOCATE ,,,I,J.
> :| PEEK (1121) AND 32 = 32 ' IF CURSOR ON / 0 IF OFF.
> :| POKE (1121),PEEK (1121) OR 32 ' TURNS OFF CURSOR.

> &H462 = 1122   
> :| PEEK (1122) ' RETURNS THE NUMBER OF ACTIVE SCREEN PAGES.

> &H465 = 1125   
> :| PEEK (1125) AND 1 = 1 ' IF ACTIVE CRT IS TEXT MODE WIDTH 80.
> :| PEEK (1125) AND 2 = 2 ' IF ACTIVE CRT IS IN GRAPHICS MODE.
> :| PEEK (1125) AND 4 = 4 ' IF ACTIVE CRT HAS COLOR DISABLED.
> :| PEEK (1125) AND 8 = 8 ' IF ACTIVE CRT HAS NOT BEEN BLANKED.
> :| PEEK (1125) AND 16 = 16 ' IF ACTIVE CRT IS IN HIGH RES. GRAPHICS.
> :| PEEK (1125) AND 32 = 32 ' IF ACTIVE CRT BLINKING IS ENABLED.

&H466 = 1126   
>  CONTAINS THE BACKGROUND COLOR AND PALETTE VALUES WHEN DISPLAY IS IN MEDIUM RESOLUTION.
> :| WHERE COLOR b, p:
> :| b = PEEK (1126) AND 15 
> :| p = (PEEK(1126) AND 32)/32
>  WHILE IN TEXT MODE, IT CONTAINS THE FOREGROUND AND BACKGROUND.
> :| WHERE COLOR f, b:
> :| f = PEEK (1126) AND 16 
> :| b = PEEK(1126) MOD 16

> &H7C, &H7D, &H7E, &H7F, &H80 = 124 - 128
> :| CONTAINS EXTENDED CHARACTER SET 128 THRU 254 IN GRAPHICS MODE.
> :| "n = PEEK (124) + 256 * PEEK (125)" WILL BE CHR$(128).
> :| "n = PEEK (126) + 256 * PEEK (127)" WILL BE CHR$(129).

&H3BE = 985    

> :| "POKE (985), x" CHANGES GRAPHICS COLOR WHERE x IS COLOR.

* **&H74 - 75 (116-117)** VIDEO PARAMETER TABLE.
> : **BE CAREFUL! - CHANGES HERE COULD PHYSICALLY DAMAGE A MONITOR!**





## KEYBOARD


> ::::**KEYBOARD Buffer**
> ::::#### ## 





> &H41A = 1050: &H41C = 1052
> :Keyboard buffer begins at PEEK(1050) + 1024 and ends at PEEK(1052) + 1023.
> :Ordinary characters use every other location. Extended characters use two locations, the first location containing the null character (CHR$(0)).
> ::POKE 1050, PEEK(1052) ' clears the keyboard buffer.
> :Buffer contents can be read by PEEK without being removed from the buffer.

> ::::::::**CTRL-Break**
> &H6C, &H6D, &H6E, &H6F = 108 to 111 
> :Before disabling Ctrl-Break, use PEEK to record the bytes in locations 108-111 !
                                         
> ::FOR I = 0 TO 3: Array(I) = PEEK(108 + I): NEXT I

> :To disable Ctrl-Break, enter: 
   
> ::FOR I = 0 TO 3: POKE(108 + I), PEEK(112 + I): NEXT I. 

> :To re-enable Ctrl-Break enter saved values from Array: 
                     
> ::FOR I = 0 TO 3: POKE(108 + I), Array(I): NEXT I

> &H471 = 1137

> :ChkCtrl% = PEEK(1137) AND 128 = 128 ' if Ctrl-Break used since start of a program.


> : NOTE: NT and XP computers will block some keyboard OUT changes!

>  &H61 = 97
> :To disable the keyboard (PC & XT only), send OUT 97, INP(97) OR 128. 
> :To enable the keyboard (PC & XT only), send OUT 97, INP(97) AND 127.  


>  &H21 = 33
To disable all keyboard interrupts: OUT 33, 130. 
To enable keyboard interrupts: OUT 33, 128.      


> For the PC-AT only, the green lights that indicate CapsLock, NumLock and the ScrollLock status can be turned on and off without altering any of the states.
> :: NOTE: NT or XP will block access to the keyboard lights!

> &H60 = 96
> The statement: OUT 96, 237: OUT 96, n produces the following results: 

> ::n = 7 all indicators on
> ::n = 6 ScrollLock indicator off, others on
> ::n = 5 NumLock indicator off, others on
> ::n = 4 CapsLock indicator on, others off
> ::n = 3 CapsLock indicator off, others on
> ::n = 2 NumLock indicator on, others off
> ::n = 1 ScrollLock indicator on, others off
> ::n = 0 all indicators off


&H417 = 1047 
> : PEEK (1047) AND 1 = 1 ' IF RIGHT SHIFT IS PRESSED
> : PEEK (1047) AND 2 = 2 ' IF LEFT SHIFT IS PRESSED 
> : PEEK (1047) AND 4 = 4 ' IF CTRL KEY IS PRESSED.
> : PEEK (1047) AND 8 = 8 ' IF ALT KEY IS PRESSED.
> : PEEK (1047) AND 16 = 16 ' IF SCROLL LOCK IS ON / 0 IF OFF.
> : PEEK (1047) AND 32 = 32 ' IF NUMBER PAD IS ON / 0 IF OFF.
> : PEEK (1047) AND 64 = 64 ' IF CAPS LOCK IS ON / 0 IF OFF.
> : PEEK (1047) AND 128 = 128 ' IF INSERT MODE IS ON / 0 IF OFF.

> :::::ENABLING MODES(will not affect lights)
> : POKE (1047),PEEK (1047) OR 16 ' ENABLES SCROLL LOCK.
> : POKE (1047),PEEK (1047) OR 32 ' ENABLES NUMBER LOCK.
> : POKE (1047),PEEK (1047) OR 64 ' ENABLES CAPS LOCK.
> : POKE (1047),PEEK (1047) OR 128 ' ENABLES INSERT MODE.


> :::::DISABLING MODES(will not affect lights)
> : POKE (1047),PEEK (1047) AND 239 ' TURNS OFF SCROLL LOCK.
> : POKE (1047),PEEK (1047) AND 223 ' TURNS OFF NUMBER LOCK.
> : POKE (1047),PEEK (1047) AND 191 ' TURNS OFF CAPS LOCK.
> : POKE (1047),PEEK (1047) AND 127 ' TURNS OFF INSERT MODE.


> :::::ALTERNATING MODES(will not affect lights)
> : POKE (1047),PEEK (1047) XOR 16 ' CHANGES SCROLL LOCK MODE.
> : POKE (1047),PEEK (1047) XOR 32 ' CHANGES NUMBER LOCK MODE.
> : POKE (1047),PEEK (1047) XOR 64 ' CHANGES CAPS LOCK MODE.
> : POKE (1047),PEEK (1047) XOR 128 ' CHANGES INSERT MODE.

> :::::::XP codes for Alt and Ctrl
> ::: DEF SEG = 0
> ::: DO
> :::: IF PEEK(1047) MOD 16 = 8 THEN SOUND 1000, 1: REM Alt
> :::: IF PEEK(1047) MOD 16 = 4 THEN SOUND 100, 1: REM Ctrl
> :::: IF INKEY$ = CHR$(27) THEN EXIT DO
> ::: LOOP
> ::: DEF SEG

> &H41A = 1050   
> : | KEYBOARD INPUT BUFFER STORED AT "PEEK(1050) + 1024" TO "PEEK(1052) + 1053"
> :: EACH CHARACTER HAS 2 BYTES RESERVED TO COVER EXTENDED CHARACTERS.






## OTHER


> &H50F = 1295   
> :|  POKE 1295,2
> :SYSTEM WILL LEAVE THE BASIC(A) FLAG SET TO INDICATE A SHELL TO DOS HAS OCCURRED AND PREVENT ACCESS TO BASIC(A) AGAIN.






> :::::**SPEAKER &H61**
> :::::### 




      To turn the speaker on, use: OUT 97,INP(97) OR 3
      Conversely, to turn the speaker off: OUT 97, INP(97) AND 252

> :::::**CASETTE PORT CONTROL  &H61**
> :::::#### #### #### #### =




      To turn the cassette motor on: OUT 97,INP(97) AND 247
      To turn the cassette motor off: OUT 97,INP(97) OR 8


> ::::**MISCELLANEOUS** 
> ::::#### 




&H411
1041  (PEEK (1041) AND 16)/16 = number of game adaptors attached.

&H413
1043  PEEK(1043) + 256 * PEEK(1044) = size of RAM in KB.

&H46C
1132  PEEK(1132) + 256 * PEEK(1133) + 65536 PEEK(1134) = number of ticks since midnight.
             With 18.2 ticks per second up to 1,533,039.
     Memory locations 1264 to 1279 are not used by either DOS or BASIC.
       Data can be passed from one program to another by POKEing and PEEKING.

&H50F
1295  To exit BASIC and complicate reinvoking it, you can: 
              POKE 1295, 2: SYSTEM.
      Memory location 1295 is set to 2 when the BASIC command SHELL is executed.

&H510 - &H511
1296-7 The segment number of BASIC's data segment may be found with:
             
              PEEK(1296) + 256 * PEEK(1297)

## BASICA



> :::::NOTE: DEF SEG BASIC(A) MEMORY PORT ADDRESSES





> :::**PORT # | FUNCTION, DESCRIPTION OR COMMENTS FOR USE**
> :::#### #### #### #### #### #### #### #### #### #### =




11-13    | USED BY BASIC(A) FOR RANDOM NUMBER GENERATION.

40       | CONTAINS LAST ERROR NUMBER IN BASIC(A).

41       | BASIC(A) SCROLLING LIMITER - SEE# 91 FOR MORE DETAILS.

44-45    | CONTAINS BASIC(A) ENVIRONMENT EQUATIONS.

46-47    | "PEEK (46)+256*PEEK(47)" RETURNS CURRENT BASIC(A) LINE NUMBER.

72       | "PEEK(72)" RETURNS CURRENT SCREEN MODE:
           0 = TEXT MODE, WIDTH 40, COLOR BURST DISABLED.
           1 = TEXT MODE, WIDTH 40, COLOR BURST ENABLED.
           2 = TEXT MODE, WIDTH 80, COLOR BURST DISABLED.
           3 = TEXT MODE, WIDTH 80, COLOR BURST ENABLED.
           4 = MEDIUM RESOLUTION GRAPHICS, COLOR BURST ENABLED.
           5 = MEDIUM RESOLUTION GRAPHICS, COLOR BURST DISABLED.
           6 = HIGH RESOLUTION GRAPHICS, COLOR BURST DISABLED.
           7 = MONOCHROME DISPLAY.

75       | "PEEK(75)" DETERMINES TEXT MODE FOREGROUND COLOR.

76       | "PEEK(76)" DETERMINES TEXT MODE BACKGROUND COLOR.

77       | "PEEK(77)" DETERMINES TEXT MODE BORDER COLOR.

78       | "PEEK(78) AND 3" DETERMINES MEDIUM RESOLUTION TEXT COLOR.
          "POKE 78,c" SETS MEDIUM RES. TO COLOR c=(1/2/3) OF PALETTE.

81       | "POKE (81) AND 15" PROVIDES MEDIUM RES. BACKGROUND COLOR.

82       | "POKE (82) MOD 2" PROVIDES MEDIUM PALETTE.

86       | "POKE (86)" PROVIDES CURSOR ROW NUMBER.

87       | "POKE (87)" PROVIDES CURSOR COLUMN NUMBER.

91-92    | USED TO CREATE SCROLLING LIMITERS.
          "POKE 41, c: POKE 91, a: POKE 92, b"
           WHERE: a=STARTING LINE b=ENDING LINE c=NUMBER OF POSITIONS.
         | "POKE 92,0" WILL PREVENT ALL SCROLLING.
         | "POKE 92,25" WILL SCROLL ALL 25 LINES.

100      | "PEEK (100)" RETURNS 1 IF CASSETTE MOTOR OFF / 0 IF OFF.

113      | "PEEK (113)" DETERMINES IF SOFTKEYS DISPLAYED.
            0 = IF SOFTKEYS NOT DISPLAYED.
            1 = ALWAYS DISPAYED.
            255 = INVOKED BY "KEY ON"

835-836  | "PEEK (835) + 256 * PEEK(836)" POINTS TO LAST STATEMENT EXECUTED.

837-838  | "PEEK (837) +256 * PEEK(838)" MEMORY LOCATION BY THE BASIC(A) STACK POINTER.

839-840  | "PEEK (839) + 256 * PEEK(840)" LINE NUMBER OF LAST BASIC(A) ERROR.
                  BASIC(A) STACK POINTER.

845-846  | "PEEK (845)+256*PEEK (846)" LINE NUMBER POINTED TO BY BASIC(A)
                 ON ERROR GOTO STATEMENT.

848-849  | "PEEK (848)+256*PEEK (849)" RETURNS BASIC(A) DATA SEGMENT.

862-863  | "PEEK (848)+256*PEEK (849)" POINTS TO NEXT BYTE OF LAST BASIC(A) DATA MOST 
                RECENLTY READ. (READ DATA LOOP)

1116     | "PEEK (1116)" RETURNS MINIMUM ALLOWABLE VALUE FOR ARRAY SUBSCRIPTS

1124     | "PEEK (1124) = 0 IF FILE IN MEMORY NOT PROTECTED.

1125     | "POKE 1125,255" PROTECTS BASIC(A) FILE IN MEMORY.
           "PEEK (1125) AND 1" WILL = 1 IF ACTIVE CRT IS TEXT MODE WIDTH 80.
           "PEEK (1125) AND 2" WILL = 2 IF ACTIVE CRT IS IN GRAPHICS MODE.
           "PEEK (1125) AND 4" WILL = 4 IF ACTIVE CRT HAS COLOR DISABLED.
           "PEEK (1125) AND 8" WILL = 8 IF ACTIVE CRT HAS NOT BEEN BLANKED.
           "PEEK (1125) AND 16" WILL = 16 IF ACTIVE CRT IS IN HIGH RES. GRAPHICS.
           "PEEK (1125) AND 32" WILL = 32 IF ACTIVE CRT BLINKING IS ENABLED.

1247     | "PEEK (1247)" REFLECTS NUMBER OF FILES SPECIFIED BY BASIC(A)/F
               COMMAND LINE PARAMETER.

1248-49  | "PEEK (1248)+256*PEEK(1249)" POINTS TO FILE CONTROL BLOCKS.

1264     | "CHR$(64 + PEEK(1264)) POINTS TO DRIVE LAST ACCESSED BY BASIC(A)
1265     | "A$="":FOR I = 1 TO 10 :A$ = CHR$(PEEK(1265+I)):NEXT I"
           POINTS TO FILE MOST RECENTLY ACCESSED BY BASIC(A).

1295     | "POKE 1295,2:SYSTEM" WILL LEAVE THE BASIC(A) FLAG SET TO INDICATE A
          SHELL TO DOS HAS OCCURRED AND PREVENT ACCESS TO BASIC(A) AGAIN.

1296-97  | BASIC(A) DATA SEGMENT NUMBER MAY BE FOUND. "PEEK(1296) + 256 * PEEK(1297)"

1339-40  | "PEEK (1339) + 256 * PEEK (1340)"POINTS TO Y COORDINATE LAST USED.

1341-42  | "PEEK (1341)+256*PEEK (1342)"POINTS TO X COORDINATE LAST USED.

1619 TO  | STRINGS OF 15 CHARACTERS SEPARATED BY A NULL CHARACTER ARE STORED
1772       HERE TO DEFINE THE VALUE OF THE SOFTKEYS. (FUNCTION KEYS 1 THRU 10).

1782     | "PEEK (1782) AND 3" PROVIDES THE CURRENT COLOR FOR DRAW STAT.
         | "POKE 1782, 85 * c" WILL CHANGE DRAW COLOR TO c.

1794-95  | "PEEK (1794) + 256 * PEEK (1795)" PROVIDES PROGRAM SEGMENT PREFIX.





## REFERENCE




## See Also
 

* [PEEK](PEEK), [POKE](POKE)

* [INP](INP), [OUT](OUT)

* [Screen Memory](Screen-Memory)




