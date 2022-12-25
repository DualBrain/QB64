The [LOC](LOC) function returns the status of a serial (COM) port received buffer or the current byte position in an open file.

## Syntax

> bytes% = LOC(fileOrPortNumber%)

* fileOrPortNumber% is the number used in the port [OPEN](OPEN) AS statement.
* Returns 0 if the buffer is empty. Any value above 0 indicates the COM port has received data.
* Use it in conjunction with [INPUT$](INPUT$) to get the data bytes received.
* Can also be used to read the current position in a file routine. See [SEEK](SEEK).

## Example(s)

Reading and writing from a COM port opened in Basic.

```vb

OPEN "COM1: 9600,N,8,1,OP0" FOR RANDOM AS #1 LEN = 2048 ' random mode = input and output
  DO: t$ = INKEY$ ' get any transmit keypresses from user
    IF LEN(t$) THEN PRINT #1, t$ ' send keyboard byte to transmit buffer
    bytes% = LOC(1) ' bytes in buffer
    IF bytes% THEN ' check receive buffer for data"
      r$ = INPUT$(bytes%, 1)          ' get bytes in the receive buffer
      PRINT r$; ' print byte strings consecutively to screen"
    END IF    
  LOOP UNTIL t$ = CHR$(27) 'escape key exit
CLOSE # 

```

## See Also

* [PRINT](PRINT), [OPEN COM](OPEN-COM), [PRINT (file statement)](PRINT-(file-statement))
* [SEEK](SEEK)
