The **LOOP** statement denotes the end of a [DO...LOOP](DO...LOOP) where the program jumps to the beginning of the loop if the optional condition is true. 

## Syntax

> DO
>   .
>   .
>   .
> LOOP [{UNTIL|WHILE} *condition*]

* LOOP indicates the bottom or end of a [DO...LOOP](DO...LOOP) block of code. 
* Either the [DO...LOOP](DO...LOOP) statement or LOOP statement can set a condition to end the loop.
* When a loop uses a LOOP condition, the code inside of it will run at least ONCE.
>  * A [WHILE](WHILE) condition continues the loop until the condition is false. 
>  * An [UNTIL](UNTIL) condition continues the loop until the condition is true.
>  * If only DO and LOOP are used the loop will never end! **Ctrl-Break** can be used to stop an endless loop!
* DO LOOPs can also be exited using [EXIT DO](EXIT-DO) or [GOTO](GOTO).

## See Also
 
* [FOR...NEXT](FOR...NEXT) {counter loop)
* [WHILE...WEND](WHILE...WEND) (loop)
* [UNTIL](UNTIL), [WHILE](WHILE) {conditions)
* [DO...LOOP](DO...LOOP), [EXIT DO](EXIT-DO)
