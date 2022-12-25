The [INPUT$](INPUT$) function is used to receive data from the user's keyboard, an open file or an open port.

## Syntax

> result$ = [INPUT$](INPUT$)(numberOfBytes%[, fileOrPortNumber])

* Keyboard input is limited to the [INTEGER](INTEGER) numberOfBytes% (characters) designated by program.
* The keyboard is the default device when a file or port number is omitted. The numberOfBytes% is number of key presses to read.
* INPUT$ will wait until the number of bytes are read from the keyboard or port. One byte per loop is recommended with ports.
* [RANDOM](RANDOM) opened file bytes can be up to the [LEN](LEN) = recordLength statement, or 128 if no statement is used.
* fileOrPortNumber is the number that was used in the [OPEN](OPEN) AS statement.
* Returns [STRING](STRING) values including spaces or even extended [ASCII](ASCII) characters.
* Backspace key results in the [CHR$](CHR$)(8) character being added to an entry.
* Use `[LOCATE](LOCATE) , , 1` to view the cursor entry. Turn the cursor off using `LOCATE , , 0`.
* Use [_DEST](_DEST) [_CONSOLE](_CONSOLE) before INPUT$ is used  to receive input from a [$CONSOLE]($CONSOLE) window.

## QBasic

* numberOfBytes% could not exceed 32767 in [BINARY](BINARY) files or a QBasic error would occur. 
* Ctrl + Break would not interrupt the QBasic program until there was a full INPUT$ key entry. In **QB64** Ctrl + Break will immediately exit a running program.

## Example(s)

A keyboard limited length entry can be made with a fixed blinking cursor. Entry must be completed before it can be shown.

```vb

LOCATE 10, 10, 1         'display fixed cursor at location
year$ = INPUT$(4)        'waits until all 4 digits are entered
PRINT year$              'display the text entry 

```

Reading bytes from a text file for an 80 wide screen mode.

```vb

LOCATE 5, 5, 1                    'locate and display cursor
OPEN "Diary.txt" FOR INPUT AS #1  'open existing text file
text$ = INPUT$(70, 1)
LOCATE 5, 6, 0: PRINT text$       'print text and turn cursor off 

```

Getting the entire text file data as one string value.

```vb

OPEN "Diary.txt FOR BINARY AS #1  'open an existing file up to 32767 bytes
IF LOF(1) <= 32767 THEN Text$ = INPUT$(LOF(1), 1)
CLOSE #1 

```

> *Explanation:* The IF statement gets the entire contents when the file size is less than 32768. The program can then work with the string by using [MID$](MID$) or [INSTR](INSTR). Note: A text file string will also have **CrLf** line break end characters [CHR$](CHR$)(13) + [CHR$](CHR$)(10).

## See Also

* [INPUT](INPUT), [LINE INPUT](LINE-INPUT) (keyboard input)
* [INPUT (file mode)](INPUT-(file-mode)), [INPUT (file statement)](INPUT-(file-statement)), [LINE INPUT (file statement)](LINE-INPUT-(file-statement)) (file input)
* [OPEN](OPEN), [LOC](LOC) (file) 
* [LOCATE](LOCATE) (cursor on/off)
