[OFF](OFF) is a flag that disables event-trappping for [KEY(n)](KEY(n)), [STRIG(n)](STRIG(n)), [TIMER](TIMER).

## Description

* [OFF](OFF) can be used to turn off the display of soft-key assignments at the bottom of the screen using [KEY](KEY).
* [OFF](OFF) can also be used to disable an event-trapping in the following statements: [KEY(n)](KEY(n)), [STRIG(n)](STRIG(n)), [TIMER](TIMER). The trap can be turned back [ON](ON), but all events triggered since [OFF](OFF) was used are lost.
* [$CHECKING]($CHECKING):**OFF** is used to disable C++ error trapping (used for verified sections of code that require speed).

## See Also

* [ON](ON), [STOP](STOP), [KEY](KEY), [KEY(n)](KEY(n)), [$CHECKING]($CHECKING)
