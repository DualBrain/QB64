The [OPEN COM](OPEN-COM) statement is used to access a computer's serial port COM.

## Syntax

> **OPEN** "COMn: *Speed*, *Parity*, *Bits*, *Stopbit*, [*Options*]" [FOR {[RANDOM](RANDOM)|[BINARY](BINARY)|[OUTPUT](OUTPUT)|[INPUT (file mode)](INPUT-(file-mode))}] AS #*P* [LEN = byteSize]

## Parameter(s)

* *Speed* (baud rate): 50, 150, 300, 600, 1200, 1800, 2400, **9600** (QBasic's maximum), 19200 or **115200** (**QB64**'s maximum).
* *Parity*: **N** (none), E (even), O (odd), S (space) or M (mark). Note: If 8 bits, use parity N for numerical data.
* *Bits* = number of bits/byte: Valid numbers: 5, 6, 7 or **8**
* *Stopbit* = number of stop bits: Valid numbers: **1**, 1.5 or 2
* Optional COM port *Options* (separated by commas):
  * ASC : [ASCII](ASCII) byte mode. End of line = [CHR$](CHR$)(13). End of file = CHR$(26)
  * BIN : [Binary](Binary) byte mode. Default mode if ASC is not used(option not required).
> *Below ms is the timeout in milliseconds 1 to 65535. Zero ignores a timeout. Default without ms = 1000 :*
  * CD[ms] : Time until timeout of DCD (Carrier Detect) line in. CD0 ignores timeouts.
  * CS[ms] : Time until timeout of CTS (Clear to Send) line in. CS0 ignores timeouts.
  * DS[ms] : Time until timeout of DSR (Data Set Ready) line in. DS0 ignores timeouts.
  * OP[ms] : Time until data lines become active. If timeout then OPEN fails, OP0 ignores timeouts.
  * RB[b] : Size of receive buffer in bytes when used. Default when not used = 512 bytes
  * TB[b] : Size of transmit buffer in bytes when used. Default when not used = 512 bytes
  * RS  : Supress detection of Request to Send (RTS) line.

## Description

* **If any optional CD, CS, DS or OP timeouts occur the OPEN will fail or port access will stop. Try 0 to ignore.**		   
* **QB64** can open any COM*n* port number from 1 to 9.
* See Windows System **Device Manager** for COM port numbers and port addresses &H3F8, &H2F8, &H3E8 and &H2E8.
* Four commas are required after the Speed, Parity, Bits, and Stopbit, even if none of the Options are used.
* Other [OPEN](OPEN) *options* are optional and in any order separated by commas within the OPEN command [STRING](STRING).(See list below)
* The optional FOR access *mode* can be [OUTPUT](OUTPUT), [INPUT (file mode)](INPUT-(file-mode)) or [RANDOM](RANDOM) (default mode when no FOR statement is used). 
* **Currently, QB64 only supports [OPEN](OPEN) FOR [RANDOM](RANDOM) access using the [GET](GET)/[PUT](PUT) commands in [BINARY](BINARY) mode.**
* **Use the BIN option listed below for [BINARY](BINARY) byte mode port access.**
* The [LEN](LEN) statement is also optional. The default record size is 512 bytes when not used.
* Use the [LOC](LOC)(portnumber) function to determine that there is data in the receive buffer when the value is greater than 0.
* OPEN AS number can use a [FREEFILE](FREEFILE) value. Numbers used by files already open **cannot** be used by OPEN COM.
* [Keywords currently not supported](Keywords-currently-not-supported-by-QB64)

## Example(s)

Checking to see if a COM port exists. If the port does not exist QBasic will cause a Windows access error. 

```vb

ON ERROR GOTO Handler 
FF = FREEFILE
comPort$ = "COM1:"                         'try a COM port number that does not exist
CONST comMode$ = "9600,N,8,1,CS0,DS0"      'Use 0 to avoid timeouts 
OPEN comPort$ + comMode$ FOR RANDOM AS FF 
IF errnum = 0 THEN PRINT "COM exists!

K$ = INPUT$(1) 
END 

Handler: 
errnum = ERR 
PRINT "Error:"; errnum
RESUME NEXT 

```

> *Explanation:* QB64 may create error 68 if COM is not found. Use a zero CD, CS, DS or OP timeout value to avoid COM timeouts.

Opening a COM port with the BIN, CS0 and DS0 options in **QB64**.

```vb

DIM bytestr AS STRING * 1  'one byte transfers
INPUT "COM port number #", port$  'any COM port number available

OPEN "COM" + port$ + ":9600,N,8,1,BIN,CS0,DS0" FOR RANDOM AS #1
DO 'main loop
    'receive data in buffer when LOC > 0
    IF LOC(1) THEN 
       GET #1, , bytestr
       PRINT "[" + bytestr + "]";
    END IF
    'transmit (send)
    k$ = INKEY$  
    IF LEN(k$) = 1 THEN
       k = ASC(k$)
       IF k >= 32 THEN     'ignore control key codes
           PRINT ">" + k$ + "<";
           bytestr = k$: PUT #1, , bytestr
       END IF
    END IF
LOOP UNTIL k$ = CHR$(27)
CLOSE #1: PRINT "Finished!" 

```

Sending string data from one COM port to another requires predefined length strings:

```vb

DIM SHARED ByteIn AS STRING * 1 'One byte transfers
DIM SHARED Byte4 AS STRING * 4 'Four byte transfers

Byte4 = CHR$(254) + CHR$(175) + CHR$(0) + CHR$(3) 'Command code to query all 4 banks of switch input board.

OPEN "COM1:115200,N,8,1,BIN,CS0,DS0" FOR RANDOM AS #1 'Open port used to send commands.
OPEN "COM2:115200,N,8,1,BIN,CS0,DS0" FOR RANDOM AS #2 'Open port used to receive commands.

PUT #1, , Byte4 'Send the 4 byte command.

Start# = TIMER
DO UNTIL LOC(2) <> 0 'Check if there is data received at com2
    IF TIMER - Start# > .5 THEN EXIT DO 'Exit loop if no data arrives within .5 seconds.
LOOP

IF LOC(2) = 0 THEN 'If no data was received.....
    PRINT "No data received from COM port."
    END
END IF

PRINT "Received from COM2:";

DO UNTIL LOC(2) = 0 'Read data from COM2 until there is no more data.
    GET #2, , ByteIn
    PRINT ASC(ByteIn);
LOOP
END 

```

## See Also

* [BINARY](BINARY), [RANDOM](RANDOM) 
* [INPUT$](INPUT$), [PRINT (file statement)](PRINT-(file-statement))
* [LOC](LOC), [INKEY$](INKEY$), [OPEN](OPEN)
* [GET](GET), [PUT](PUT)
* [Port Access Libraries](Port-Access-Libraries) (Includes full LPT and COM port descriptions with downloadable DLL library)
* [Windows Libraries](Windows-Libraries)
