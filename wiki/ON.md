ON creates event procedure calls or enables event trapping.

* Set the sub-procedure call for [KEY(n)](KEY(n)), [ON COM (n)](ON-COM-(n)), [PEN](PEN), [PLAY](PLAY), [STRIG(n)](STRIG(n)), [TIMER](TIMER), [UEVENT](UEVENT)
* To turn on event trapping for [ON COM (n)](ON-COM-(n)), [ON KEY (n)](ON-KEY-(n)), [ON PEN](ON-PEN), [ON PLAY (n)](ON-PLAY-(n)), [ON STRIG (n)](ON-STRIG-(n)), [ON TIMER (n)](ON-TIMER-(n)) and [ON UEVENT](ON-UEVENT). 
* In the case of [ON ERROR](ON-ERROR) the trap is also enabled until a subsequent ON ERROR statement.
* ON procedures should be used only in the main program module and not inside of SUB procedures!
* If you have used the [$CHECKING]($CHECKING):[OFF](OFF) metacommand, [$CHECKING]($CHECKING):**ON** will turn on c++ error checking again.

## See Also
 
* [ON...GOSUB](ON...GOSUB), [ON...GOTO](ON...GOTO) 
* [OFF](OFF), [STOP](STOP), [KEY](KEY)
* [$CHECKING]($CHECKING)
