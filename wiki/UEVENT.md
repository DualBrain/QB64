The **UEVENT** Statement uses ON, OFF or STOP to enable, turn off or suspend user event trapping.

## Syntax
  
> UEVENT {ON|STOP|OFF}
 
* **[Keywords currently not supported](Keywords-currently-not-supported-by-QB64)**

* UEVENT ON enables user defined event-trapping as defined by the [ON UEVENT](ON-UEVENT) statement.

* UEVENT OFF disables the event-trapping routine. All events are ignored and are not remembered.

* UEVENT STOP suspends the event-trapping routine. An event is remembered, and the event-trapping routine will be performed as soon as a UEVENT ON statement re-enables the trapping.

## See Also

* [ON UEVENT](ON-UEVENT)
