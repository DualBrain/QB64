SLEEP pauses the program indefinitely or for a specified number of seconds, program is unpaused when the user presses a key or when the specified number of seconds has passed.

## Syntax

> SLEEP [seconds]

* Seconds are an optional [INTEGER](INTEGER) value. If there is no parameter, then it waits for a keypress.
* Any user keypress will abort the SLEEP time.
* SLEEP does NOT clear the keyboard buffer so it can affect [INKEY$](INKEY$), [INPUT](INPUT), [INPUT$](INPUT$) and [LINE INPUT](LINE-INPUT) reads.
* Use an [INKEY$](INKEY$) keyboard buffer clearing loop when an empty keyboard buffer is necessary.
* SLEEP allows other programs to share the processor time during the interval.

## Example(s)

```vb

CLS 
PRINT "Press a key..."
SLEEP
PRINT "You pressed a key, now wait for 2 seconds."
SLEEP 2
PRINT "You've waited for 2 seconds."
PRINT "(or you pressed a key)"

```

```text

Press a key...
You pressed a key, now wait for 2 seconds.
You've waited for 2 seconds.
(or you pressed a key)

```

> *Explanation:* SLEEP without any arguments waits until a key is pressed, next SLEEP statement uses the argument 2 which means that it will wait for 2 seconds, any number of seconds can be specified.

## See Also
 
* [TIMER](TIMER), [INKEY$](INKEY$)
* [_DELAY](_DELAY), [_LIMIT](_LIMIT)
