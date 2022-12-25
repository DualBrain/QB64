The [RESTORE](RESTORE) statement is used to reset the DATA pointer to the beginning of the data.

## Syntax

> [RESTORE](RESTORE) [lineNumber|lineLabel]

## Description

* The line label or number enables a labeled data field to be [READ](READ) more than once as required.
* Datafield label names are not required when working with ONE or a progression of data fields in the main body of code.
* Label multiple data fields to restore them to use them again when necessary.
* If RESTORE is used with unlabeled data fields or no datafield is designated then the first data field is read.
* Use RESTORE to avoid an [ERROR Codes](ERROR-Codes) when reading a data field!
* See the [DATA](DATA) statement for [STRING](STRING) data value specifications.
* **Do not place [DATA](DATA) fields after [SUB](SUB) or [FUNCTION](FUNCTION) procedures! QB64 will FAIL to [RESTORE](RESTORE) properly!**
>  QBasic allowed programmers to add DATA fields anywhere because the IDE separated the main code from other procedures.

## Example(s)

Restoring a labeled DATA field to avoid going past the end of DATA.

```vb

DO
   INPUT "Enter a month number(1 to 12): ", monthnum%

   RESTORE Months
   FOR i = 1 TO monthnum%
      READ month$, days%   'variables must match data field types
   NEXT
   PRINT "The month "; month$; " has"; days%; "days."
LOOP UNTIL monthnum% < 1 OR monthnum% > 12

 Months:
 DATA January, 31, February, 28, March, 31, April, 30, May, 31, June, 30
 DATA July, 31, August, 31, September, 30, October, 31, November, 30, December, 31

```

```text

Enter a month number(1 to 12): 6
The month June has 30 days.

```

> *Note:* String DATA values do not require quotes unless they have commas, end spaces or QBasic keywords in them.

Using RESTORE to know the number of elements in the DATA in order to dimension and store the items in a array.

```vb

DO
READ dummy$ 'we won't actually use this string for anything else than to know when there is no more DATA.
count = count + 1
LOOP UNTIL dummy$ = "stop" 'when dummy$ = "stop" then we know that it is the last entry so it only does the above loop until then.

count = count - 1 'since the last string is "stop" and we don't want to store it in the array.

PRINT "The number of relevant entries are:"; count

DIM entry$(count) 'Now we know how many elements we need to make space for (DIM)

RESTORE 'We restore it so that it begins reading from the first DATA again.

FOR c = 1 TO count
READ entry$(c) 'read the DATA and store it into the array.
NEXT

'we can now print the contents of the array:

FOR c = 1 TO count 
PRINT entry$(c)
NEXT

END 

DATA "entry1", "entry2", "entry3", "stop"

```


```text

The number of relevant entries are: 3
entry1
entry2
entry3

```

*Note:* Now we can add any number of entries without further compensation to the code.

## See Also

* [DATA](DATA), [READ](READ)
* [line numbers](line-numbers) / line labels
