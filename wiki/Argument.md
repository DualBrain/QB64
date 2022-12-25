An **argument** or parameter is information that a [statement](statement), [sub (explanatory)](sub-(explanatory)), [function (explanatory)](function-(explanatory)) or [metacommand](metacommand) needs to carry out the task it has been given. Sometimes a argument can be optional and is not needed for the task to be carried out, in such case it will use a default instead of the argument when carrying out the task.

It is currently not possible to make arguments optional in user-defined [SUB](SUB)s or [FUNCTION](FUNCTION)s, but Galleon (the creator of QB64) is planning that functionality in the future.

Arguments that are optional will be enclosed with [ and ] brackets in syntax descriptions.

More than one argument or parameter are separated by commas.

## Example(s)

The color argument in PSET is optional

```vb

SCREEN 13
PSET (160, 100)
PSET (165, 100), 15

```

Must place a comma to seperate arguments if you use any other argument after it.

```vb

SCREEN 13
LINE (160, 100)-(170, 110), , B
LINE (162, 102)-(168, 108), 4, BF

```

As you can see in the above example some statements have special arguments like B and BF in this case (B stands for Box and BF stands for Box Fill), if the argument isn't used then it will create a ordinary line.

## See Also

* [SUB](SUB), [FUNCTION](FUNCTION)
* [Statement](Statement), [Function (explanatory)](Function-(explanatory)), [Sub (explanatory)](Sub-(explanatory)), [Metacommand](Metacommand), [Expression](Expression)
