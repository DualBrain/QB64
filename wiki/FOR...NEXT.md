The [FOR](FOR) statement creates a counter loop using specified start and stop numerical boundaries. The default increment is + 1.

## Syntax
 
>[FOR](FOR) counterVariable = startValue [TO](TO) stopValue [STEP increment]
>
>>.
>>
>>{code}
>>
>>.
>> 
>[NEXT](NEXT) [counterVariable]

## Parameter(s)

* The [FOR](FOR) counterVariable name is required to define the counter span and may also be used after the NEXT keyword.
* The startValue [TO](TO) stopValue can be any literal or variable numerical type. Both values are  required.
* [STEP](STEP) can be used for a loop increment other than the default *plus 1 and can be any positive or negative literal or variable numerical value as long as the STEP value corresponds to the loop's startValue and stopValue.
* [NEXT](NEXT) ends the [FOR](FOR) loop code block and increments the counter to the next value even when it exceeds the stop limit. 

## Description

* [FOR...NEXT](FOR...NEXT) counter loops must be within the proper start, stop and increment values or the entire loop code block will not be executed. 
* Avoid changing the FOR counterVariable's value inside of the loop. This obfuscates code and is a poor programming practice.
* Once the loop has been started, changing the variables holding the startValue, stopValue or increment value will not affect loop execution.
* **If the [STEP](STEP) *increment* value does not match the startValue [TO](TO) stopValue the FOR loop block will be ignored.**
  * If startValue is less than stopValue, use the default increment or positive [STEP](STEP) value or the loop will not be executed.
  * If startValue is more than stopValue, use a negative [STEP](STEP) interval or the loop will not be executed.
  * The [STEP](STEP) increment value cannot be changed inside of the loop.
* Use **[EXIT](EXIT) FOR** to leave a FOR loop early when a certain condition is met inside of the loop.
* Use [_CONTINUE](_CONTINUE) to skip the remaining lines in the current iteration of a FOR/NEXT block without leaving the loop.
* The [NEXT](NEXT) counter variable name is not required. NEXT loop increments can be separated by colons in nested FOR loops. 
* **NOTE: When the FOR loop is exited after the stopValue is reached, the counterVariable's value will be stopValue + 1 (or stopValue + increment)
* **Beware of FOR loop counts that exceed the counterVariable type limits and may repeat without error in QB64.**
  * For example, if counterVariable is of type [INTEGER](INTEGER) and the stop limit exceeds 32767, the counterVariable will reset back to -32768 and loop endlessly.

## Example(s)

Adding all of the even numbers from 10 to 0.

```vb

FOR i = 10 TO 0 STEP -2
  totaleven% = i + totaleven%
  PRINT totaleven%;
NEXT
PRINT "After loop, i ="; i 

```

```text

10 18 24 28 30 30 After loop, i = -2

```

> *Explanation:* The loop counts down from 10 to every even value below it. The counter keeps stepping down until the FOR stop limit is reached or exceeded. Note that the value of i is -2 after the loop is exited. [NEXT](NEXT) always increments the counter one last time.

How an entire FOR loop block is ignored when the start and stop limits do not match the default or [STEP](STEP) increment.

```vb

PRINT "hi"

FOR i = 10 TO 1 'requires a negative STEP value
  PRINT "lo"
NEXT

PRINT "bye"

```

```text

hi
bye 

```

## See Also

* [STEP](STEP) 
* [DO...LOOP](DO...LOOP), [WHILE...WEND](WHILE...WEND)
* [EXIT](EXIT), [_CONTINUE](_CONTINUE)
