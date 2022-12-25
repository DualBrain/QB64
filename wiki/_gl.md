In order to use OpenGL drawing commands, you must do so from inside a [SUB](SUB) procedure called **_GL**, which enables the commands to be rendered.

## Syntax

> [SUB](SUB) _GL
>   *REM Your OpenGL code here
> [END](END) [SUB](SUB)

## Description

* OpenGL commands are valid outside of **SUB _GL**, as long as the sub procedure exists in your code.
* Attempting to use OpenGL commands without having **SUB _GL** in a program will result in a **Syntax error**, even if the syntax is valid.
* SUB **_GL** cannot be invoked manually. The code inside it will be called automatically at approximately 60 frames per second.
* Using [INPUT](INPUT) inside SUB **_GL** will crash your program.
* If your program needs to perform any operations before SUB _GL must be run, it is recommended to use a shared variable as a flag to allow SUB _GL's contents to be run. See example below.

## Example

```vb

DIM allowGL AS _BYTE

'perform startup routines like loading assets

allowGL = -1 'sets allowGL to true so SUB _GL can run

DO
    _LIMIT 1 'runs the main loop at 1 cycle per second
    'notice how the main loop doesn't do anything, as SUB _GL will be running
    'continuously.
LOOP

SUB _GL
    IF NOT allowGL THEN EXIT SUB 'used to bypass running the code below until
    '                             startup routines are done in the main module

    'OpenGL code starts here
    'The code in this area will be run automatically at ~60fps
END SUB 

```

## See Also

* [_GLRENDER](_GLRENDER)
* [SUB](SUB)
