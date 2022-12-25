The [LOF](LOF) function is used to find the length of an [OPEN](OPEN) file in bytes.

## Syntax

> *totalBytes&* = [LOF](LOF)([#]fileNumber)

## Description

* LOF returns the number of bytes in an [OPEN](OPEN)ed designated fileNumber. File is empty if it returns 0.
* fileNumber is the number of the opened file. **#** is not required.
* Often used to determine the number of records in a [RANDOM](RANDOM) access file.
* Can also be used to avoid reading an empty file, which would create an error.
* LOF in **QB64** can return up to 9 GB (9,223,372,036 bytes) file sizes.

## Example(s)

Finding the number of records in a RANDOM file using a [TYPE](TYPE) variable.

```vb

  OPEN file$ FOR RANDOM AS #1 LEN = LEN(Type_variable)
  NumRecords% = LOF(1) \ RecordLEN%

```

## See Also

* [LEN](LEN), [EOF](EOF), [BINARY](BINARY), [RANDOM](RANDOM), [TYPE](TYPE)
