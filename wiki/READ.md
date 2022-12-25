The **READ** statement reads values from a [DATA](DATA) field and assigns them to one or a comma separated list of variables.

## Syntax

> [READ](READ) value1$[, value2!, value3%, ...]

* READ statements assign variables to [DATA](DATA) statement values on a one-to-one basis sequentially. 
* A single READ statement may access one or more [DATA](DATA) values. They are accessed in the order set. 
* Several READ statements may access the same [DATA](DATA) statement block at the following sequential position.
* [DATA](DATA) can be READ using [STRING](STRING) or numerical [TYPE](TYPE) variables singularly or in a comma separated list:
   - [STRING](STRING) READ variables can read quoted or unquoted text or numerical DATA values!
   - Numerical type READ variables can only read **unquoted** numerical DATA values! 
   - **If they do not agree, a [ERROR Codes](ERROR-Codes) may result when run reading string data as numerical values!**
* If the number of variables specified is fewer than the number of elements in the DATA statement(s), subsequent READ statements begin reading data at the next unread element. If there are no subsequent READ statements, the extra data is ignored.
* If variable reads exceed the number of elements in the DATA field(s), an [ERROR Codes](ERROR-Codes) will occur!
* Use the [RESTORE](RESTORE) statement to reread DATA statements from the start, with or without a line label as required.
* [ACCESS](ACCESS) READ can be used in an [OPEN](OPEN) statement to limit file access to read only, preserving file data.
* **WARNING! Do not place DATA fields after [SUB](SUB) or [FUNCTION](FUNCTION) procedures! QB64 will FAIL to compile properly!**
> QBasic allowed programmers to add DATA fields anywhere because the IDE separated the main code from other procedures.

## Example(s)

Placing data into an array.

```vb

DIM A(10) AS SINGLE
FOR I = 1 TO 10
   READ A(I)
NEXT I
FOR J = 1 TO 10
   PRINT A(J);
NEXT
END

DATA 3.08, 5.19, 3.12, 3.98, 4.24
DATA 5.08, 5.55, 4.00, 3.16, 3.37 

```

```text

 3.08  5.19  3.12  3.98  4.24  5.08  5.55  4  3.16  3.37

```

> *Explanation:* This program reads the values from the DATA statements into array A. After execution, the value of A(1) is 3.08, and so on. The DATA statements may be placed anywhere in the program; they may even be placed ahead of the READ statement.

Reading three pieces of data at once.

```vb

 PRINT " CITY ", " STATE  ", " ZIP"
 PRINT STRING$(30, "-")  'divider
   READ C$, S$, Z&
 PRINT C$, S$, Z&

 DATA "DENVER,", COLORADO, 80211 

```

```text

  CITY        STATE       ZIP
 ------------------------------
 DENVER,     COLORADO     80211

```

> *Note:* String DATA values do not require quotes unless they contain commas, end spaces or QBasic keywords.

## See Also
 
* [DATA](DATA), [RESTORE](RESTORE)
* [PRINT USING](PRINT-USING)
* [OPEN](OPEN) FOR [INPUT (file mode)](INPUT-(file-mode)) (file statement)
