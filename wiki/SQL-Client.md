**MySQL** is a database manager that is widely used on the internet with languages such as PHP. This is a DECLARE LIBRARY to allow access to MySQL databases.

**IMPORTANT**

> * 1) Make sure you are running QB64 V0.942 or higher
> * 2) Download 'mysql.dll' and place it in your qb64 folder (not provided)
> * 3) Create 'mysql_helper.h' in your QB64 folder (see below)
> * 4) Run & enjoy browsing our sample database as a member with read-only privileges.

>  *mysql_helper.h*

```text

  void *offset_to_offset(void* offset){
    return offset;
  }
  void *offset_at_offset(void** offset){
    return *offset;
  }

```

<sub>Code by Galleon</sub>

```vb

DECLARE CUSTOMTYPE LIBRARY "mysql_helper"
    FUNCTION offset_to_string$ ALIAS offset_to_offset (BYVAL offset AS _OFFSET)
    FUNCTION offset_at_offset%& (BYVAL offset AS _OFFSET)
END DECLARE

'#### mysql.dll not provided ####
DECLARE DYNAMIC LIBRARY "mysql"
    FUNCTION mysql_get_client_info$
    FUNCTION mysql_init%& (BYVAL x AS LONG)
    FUNCTION mysql_real_connect& (BYVAL mysql AS _OFFSET, host AS STRING, user AS STRING, password AS STRING, db AS STRING, BYVAL port AS _UNSIGNED LONG, BYVAL unix_socket AS _OFFSET, BYVAL client_flag AS _UNSIGNED _OFFSET)
    SUB mysql_close (BYVAL mysql AS _OFFSET)
    SUB mysql_query (BYVAL mysql AS _OFFSET, what AS STRING)
    FUNCTION mysql_store_result%& (BYVAL mysql AS _OFFSET)
    FUNCTION mysql_num_fields& (BYVAL result AS _OFFSET)
    FUNCTION mysql_fetch_row%& (BYVAL result AS _OFFSET)
    SUB mysql_free_result (BYVAL result AS _OFFSET)
    '...
END DECLARE

DIM conn AS _OFFSET

PRINT "MYSQL Client: " + mysql_get_client_info$

conn = mysql_init(0)
IF conn = 0 THEN PRINT "Could not init MYSQL client!": END

'*** Open the db ***
'PRINT mysql_real_connect(conn, "qb64db2.db.7445102.hostedresource.com", "", "", "qb64db2", 0, 0, 0)
PRINT mysql_real_connect(conn, "qb64db2.db.7445102.hostedresource.com", "qb64guest", "QB64forever", "qb64db2", 0, 0, 0)

'*** Write to the db (not possible as a guest!) ***
GOTO skip_write '(guests can't do this anyway)
mysql_query conn, "CREATE TABLE writers(name VARCHAR(25))"
mysql_query conn, "INSERT INTO writers VALUES('Leo Tolstoy')"
mysql_query conn, "INSERT INTO writers VALUES('Jack London')"
mysql_query conn, "INSERT INTO writers VALUES('Honore de Balzac')"
mysql_query conn, "INSERT INTO writers VALUES('Lion Feuchtwanger')"
mysql_query conn, "INSERT INTO writers VALUES('Emile Zola')"
skip_write:

'*** Read from the db ***
mysql_query conn, "SELECT * FROM writers"
DIM result AS _OFFSET
result = mysql_store_result(conn)
DIM num_fields AS LONG
num_fields = mysql_num_fields(result)
DIM row AS _OFFSET
DO
    row = mysql_fetch_row(result)
    IF row THEN
        FOR i = 0 TO num_fields - 1
            PRINT offset_to_string(offset_at_offset(row))
        NEXT
    END IF
LOOP UNTIL row = 0
mysql_free_result result

'*** Close the db ***
mysql_close con 

END 

```

>  Here's some code which uses 'mysql_fetch_fields': 

```vb

DECLARE CUSTOMTYPE LIBRARY "mysql_helper"
    FUNCTION offset_to_string$ ALIAS offset_to_offset (BYVAL offset AS _OFFSET)
    FUNCTION offset_at_offset%& (BYVAL offset AS _OFFSET)
END DECLARE

TYPE MYSQL_FIELD_TYPE '  typedef struct st_mysql_field {
    name AS _OFFSET '    char *name;  
    org_name AS _OFFSET '    char *org_name;  
    table AS _OFFSET '    char *table;   
    org_table AS _OFFSET '    char *org_table;   
    db AS _OFFSET '    char *db;   
    catalog AS _OFFSET '    char *catalog;   
    default AS _OFFSET '    char *def;   
    length AS _UNSIGNED _OFFSET '    unsigned long length;    
    max_length AS _UNSIGNED _OFFSET '    unsigned long max_length;   
    name_length AS _UNSIGNED LONG '    unsigned int name_length;   
    org_name_length AS _UNSIGNED LONG '    unsigned int org_name_length;   
    table_length AS _UNSIGNED LONG '    unsigned int table_length;    
    org_table_length AS _UNSIGNED LONG'  unsigned int org_table_length;    
    db_length AS _UNSIGNED LONG '    unsigned int db_length;   
    catalog_length AS _UNSIGNED LONG '    unsigned int catalog_length;    
    def_length AS _UNSIGNED LONG '    unsigned int def_length;    
    flags AS _UNSIGNED LONG '    unsigned int flags;    
    decimals AS _UNSIGNED LONG '    unsigned int decimals;    
    charsetnr AS _UNSIGNED LONG '    unsigned int charsetnr;    
    type AS _UNSIGNED LONG '    enum enum_field_types type;
END TYPE '  } MYSQL_FIELD;

DECLARE CUSTOMTYPE LIBRARY
    SUB OFFSETtoMYSQL_FIELD ALIAS memcpy (dest AS MYSQL_FIELD_TYPE, BYVAL source AS _OFFSET, BYVAL bytes AS LONG)
END DECLARE

'#### mysql.dll not provided ####
DECLARE DYNAMIC LIBRARY "mysql"
    FUNCTION mysql_get_client_info$
    FUNCTION mysql_init%& (BYVAL x AS LONG)
    FUNCTION mysql_real_connect& (BYVAL mysql AS _OFFSET, host AS STRING, user AS STRING, password AS STRING, db AS STRING, BYVAL port AS _UNSIGNED LONG, BYVAL unix_socket AS _OFFSET, BYVAL client_flag AS _UNSIGNED _OFFSET)
    SUB mysql_close (BYVAL mysql AS _OFFSET)
    SUB mysql_query (BYVAL mysql AS _OFFSET, what AS STRING)
    FUNCTION mysql_store_result%& (BYVAL mysql AS _OFFSET)
    FUNCTION mysql_num_fields& (BYVAL result AS _OFFSET)
    FUNCTION mysql_fetch_row%& (BYVAL result AS _OFFSET)
    SUB mysql_free_result (BYVAL result AS _OFFSET)
    FUNCTION mysql_fetch_fields%& (BYVAL result AS _OFFSET)
    '...
END DECLARE

DIM conn AS _OFFSET

PRINT "MYSQL Client: " + mysql_get_client_info$

conn = mysql_init(0)
IF conn = 0 THEN PRINT "Could not init MYSQL client!": END

'*** Open the db ***
'PRINT mysql_real_connect(conn, "qb64db2.db.7445102.hostedresource.com", "", "", "qb64db2", 0, 0, 0)
PRINT mysql_real_connect(conn, "qb64db2.db.7445102.hostedresource.com", "qb64guest", "QB64forever", "qb64db2", 0, 0, 0)

'*** Write to the db (not possible as a guest!) ***
GOTO skip_write '(guests can't do this anyway)
mysql_query conn, "CREATE TABLE writers(name VARCHAR(25))"
mysql_query conn, "INSERT INTO writers VALUES('Leo Tolstoy')"
mysql_query conn, "INSERT INTO writers VALUES('Jack London')"
mysql_query conn, "INSERT INTO writers VALUES('Honore de Balzac')"
mysql_query conn, "INSERT INTO writers VALUES('Lion Feuchtwanger')"
mysql_query conn, "INSERT INTO writers VALUES('Emile Zola')"
skip_write:

'*** Read from the db ***
mysql_query conn, "SELECT * FROM writers"
DIM result AS _OFFSET
result = mysql_store_result(conn)
DIM num_fields AS LONG
num_fields = mysql_num_fields(result)

f%& = mysql_fetch_fields(result)

DIM ft AS MYSQL_FIELD_TYPE
OFFSETtoMYSQL_FIELD ft, f%&, LEN(ft)
PRINT offset_to_string(ft.name)
PRINT offset_to_string(ft.org_name)
x%& = ft.length: PRINT x%& '***PRINT ft.length doesn't work in QB64 yet, this needs to be addressed***

END

DIM row AS _OFFSET
DO
    row = mysql_fetch_row(result)
    IF row THEN
        FOR i = 0 TO num_fields - 1
            PRINT offset_to_string(offset_at_offset(row))
        NEXT
    END IF
LOOP UNTIL row = 0
mysql_free_result result

'*** Close the db ***
mysql_close con
END 

```

## SQL Demo

This version has much the same functionality with a few bug fixes, better examples, the ability to switch between multiple open databases and a table-viewer SUB for visualising the results of SELECT queries. If anyone wants to code me up some more examples or suggest improvements feel free, I'll be glad to add them. Galleon

**IMPORTANT**

> * Download 'mysql.dll' and place it in your qb64 folder (not provided)
> * Find a SQL database server to connect to OR download your own [http://dev.mysql.com/downloads/] 
> * Setup you IP, username and password in the code below...

```vb

'the following section is used to help you get started with the examples
WIDTH 2000, 25
DIM SHARED sql_database_ip AS STRING
DIM SHARED my_password AS STRING
DIM SHARED my_username AS STRING
'NOTE: TO PROTECT YOU FROM ACCIDENTLY DISCLOSING YOUR PASSWORD WHEN ASKING FOR CODE SUPPORT
'      DO YOURSELF A FAVOUR AND PUT YOUR PASSWORD IN A FILE CALLED "password.txt"
user_password$ = "CREATE A TEXT FILE CALLED password.txt WITH YOUR PASSWORD"
fh = FREEFILE: OPEN "password.txt" FOR INPUT AS fh: LINE INPUT #fh, my_password$: CLOSE #fh
my_username = "root"
sql_database_ip = "127.0.0.1"

'http://dev.mysql.com/doc/refman/5.6/en/c-api-functions.html
DECLARE DYNAMIC LIBRARY "mysql"
    FUNCTION mysql_init%& (BYVAL always_0 AS _OFFSET)
    'MYSQL *mysql_init(MYSQL *mysql)
    FUNCTION mysql_error$ (BYVAL mysql AS _OFFSET)
    'const char *mysql_error(MYSQL *mysql)
    FUNCTION mysql_get_client_info$
    ' Returns a string that represents the client library version
    ' const char *mysql_get_client_info(void)
    FUNCTION mysql_real_connect%& (BYVAL mysql AS _OFFSET, host AS STRING, user AS STRING, password AS STRING, db AS STRING, BYVAL port AS _UNSIGNED LONG, BYVAL unix_socket AS _OFFSET, BYVAL client_flag AS _UNSIGNED _OFFSET)
    FUNCTION mysql_real_connect_dont_open%& ALIAS mysql_real_connect (BYVAL mysql AS _OFFSET, host AS STRING, user AS STRING, password AS STRING, BYVAL db AS _OFFSET, BYVAL port AS _UNSIGNED LONG, BYVAL unix_socket AS _OFFSET, BYVAL client_flag AS _UNSIGNED LONG)
    ' MYSQL *mysql_real_connect(MYSQL *mysql, const char *host, const char *user, const char *passwd, const char *db, unsigned int port, const char *unix_socket, unsigned long client_flag)
    '  The value of host may be either a host name or an IP address. If host is NULL or the string "localhost", a connection to the local host is assumed.
    '  db is the database name. If db is not NULL, the connection sets the default database to this value.
    '  If port is not 0, the value is used as the port number for the TCP/IP connection. Note that the host parameter determines the type of the connection.
    '  If unix_socket is not NULL, the string specifies the socket or named pipe to use. Note that the host parameter determines the type of the connection.
    '  The value of client_flag is usually 0, but can be set to a combination of the following flags to enable certain features.
    '  Return Value: A MYSQL* connection handle if the connection was successful, NULL if the connection was unsuccessful. For a successful connection, the return value is the same as the value of the first parameter.
    '*** REMEMBER, ALL STRINGS PASSED MUST BE NULL '+CHR$(0)' TERMINATED ***
    SUB mysql_query (BYVAL mysql AS _OFFSET, mysql_command AS STRING)
    FUNCTION mysql_query& (BYVAL mysql AS _OFFSET, mysql_command AS STRING)
    ' int mysql_query(MYSQL *mysql, const char *stmt_str)
    ' Executes the SQL statement pointed to by the null-terminated string stmt_str. Normally, the string must consist of a single SQL statement without a terminating semicolon (“;”) or \g. If multiple-statement execution has been enabled,
    'Returns Zero if the statement was successful. Nonzero if an error occurred.
    '*** REMEMBER, ALL STRINGS PASSED MUST BE NULL '+CHR$(0)' TERMINATED ***
    FUNCTION mysql_store_result%& (BYVAL mysql AS _OFFSET)
    ' MYSQL_RES *mysql_store_result(MYSQL *mysql)
    ' Returns a RESULT STRUCTURE
    FUNCTION mysql_num_fields~& (BYVAL result AS _OFFSET)
    ' unsigned int mysql_num_fields(MYSQL_RES *result)
    ' To pass a MYSQL* argument instead, use unsigned int mysql_field_count(MYSQL *mysql).
    ' Returns number of columns in result set
    FUNCTION mysql_num_rows&& (BYVAL result AS _OFFSET)
    ' my_ulonglong mysql_num_rows(MYSQL_RES *result)
    ' Returns the number of rows in the result set.
    FUNCTION mysql_fetch_row%& (BYVAL result AS _OFFSET)
    ' MYSQL_ROW mysql_fetch_row(MYSQL_RES *result)
    ' RETURNS A ROW STRUCTURE
    FUNCTION mysql_fetch_lengths%& (BYVAL result AS _OFFSET)
    ' unsigned long *mysql_fetch_lengths(MYSQL_RES *result)
    ' Returns the lengths of the columns of the current row within a result set.
    ' Returns a pointer to an array of lengths
    SUB mysql_close (BYVAL mysql AS _OFFSET)
    SUB mysql_free_result (BYVAL result AS _OFFSET)
END DECLARE


TYPE DB_TYPE
    Object AS _OFFSET
END TYPE
DIM SHARED DB_Version AS STRING: DB_Version = mysql_get_client_info$ 'currently "6.0.0" in Windows
DIM SHARED DB_Last AS LONG
DIM SHARED Database(DB_Last) AS DB_TYPE
DIM SHARED DB_Last_Error AS STRING
DIM SHARED DB_Selected AS LONG
DIM SHARED DB_Debug_Mode AS LONG: DB_Debug_Mode = 0
DIM SHARED DB_RESULT(1 + 1, 1 + 1) AS STRING '***DO NOT EDIT THIS LINE***

DO
    PRINT: PRINT: PRINT
    PRINT "CHOOSE AN EXAMPLE:"
    PRINT "1) Explore an existing database"
    PRINT "2) Create a new database"
    INPUT "Which example? (1-3) >", e
    IF e = 1 THEN EXAMPLE_1 ignore_this_value
    IF e = 2 THEN EXAMPLE_2 ignore_this_value
    IF e = 0 THEN EXIT DO
LOOP
PRINT "Bye!"
END

SUB DB_Critical_Error (message$)
SCREEN 2
PRINT message$
END
END SUB

FUNCTION DB_Open (host_ip$, user_name$, user_password$, DB_name$) 'if DB_name="" then no database is selected
DB_Last_Error = ""
'create new handle
FOR DB = 1 TO DB_Last
    IF Database(DB).Object = 0 THEN EXIT FOR
NEXT
IF DB > UBOUND(Database) THEN REDIM _PRESERVE Database(UBOUND(Database) + 10) AS DB_TYPE: DB_Last = DB
'create new object
Database(DB).Object = mysql_init(0): IF Database(DB).Object = 0 THEN DB_Critical_Error "mysql_init failed"
'attempt to connect
IF DB_name$ = "" THEN
    object%& = mysql_real_connect_dont_open(Database(DB).Object, host_ip$ + CHR$(0), user_name$ + CHR$(0), user_password$ + CHR$(0), 0, 0, 0, 0)
ELSE
    object%& = mysql_real_connect(Database(DB).Object, host_ip$ + CHR$(0), user_name$ + CHR$(0), user_password$ + CHR$(0), DB_name$ + CHR$(0), 0, 0, 0)
END IF
IF object%& = 0 THEN
    DB_Last_Error = mysql_error(Database(DB).Object)
    Database(DB).Object = 0 'free index
    EXIT FUNCTION
END IF
DB_Selected = DB
DB_Open = DB
END FUNCTION


FUNCTION DB_Create (host_ip$, user_name$, user_password$, DB_name$)
DB_Last_Error = ""
'create new handle
FOR DB = 1 TO DB_Last
    IF Database(DB).Object = 0 THEN EXIT FOR
NEXT
IF DB > UBOUND(Database) THEN REDIM _PRESERVE Database(UBOUND(Database) + 10) AS DB_TYPE: DB_Last = DB
'create new object
Database(DB).Object = mysql_init(0): IF Database(DB).Object = 0 THEN DB_Critical_Error "mysql_init failed"
'attempt to connect
object%& = mysql_real_connect_dont_open(Database(DB).Object, host_ip$ + CHR$(0), user_name$ + CHR$(0), user_password$ + CHR$(0), 0, 0, 0, 0)
IF object%& = 0 THEN
    DB_Last_Error = mysql_error(Database(DB).Object)
    Database(DB).Object = 0 'free index
    EXIT FUNCTION
END IF
'create new database
result = mysql_query(Database(DB).Object, "CREATE DATABASE " + DB_name$ + CHR$(0))
IF result THEN
    DB_Last_Error = mysql_error(Database(DB).Object)
    Database(DB).Object = 0 'free index
    EXIT FUNCTION
END IF
'select new database
result = mysql_query(Database(DB).Object, "USE " + DB_name$ + CHR$(0))
IF result THEN
    DB_Last_Error = mysql_error(Database(DB).Object)
    Database(DB).Object = 0 'free index
    EXIT FUNCTION
END IF
DB_Selected = DB
DB_Create = DB
END FUNCTION

SUB DB_Close
IF DB_Selected < 0 OR DB_Selected > DB_Last THEN DB_Critical_Error "DB_Close: Invalid handle"
IF Database(DB_Selected).Object = 0 THEN DB_Critical_Error "DB_Close: Invalid handle"
DB_Last_Error = ""
mysql_close Database(DB_Selected).Object
END SUB

SUB DB_QUERY (mysql_command$)
IF DB_Selected < 0 OR DB_Selected > DB_Last THEN DB_Critical_Error "DB_QUERY: Invalid handle"
IF Database(DB_Selected).Object = 0 THEN DB_Critical_Error "DB_QUERY: Invalid handle"
DB_Last_Error = ""
result = mysql_query(Database(DB_Selected).Object, mysql_command$ + CHR$(0))
IF result THEN
    DB_Last_Error = mysql_error(Database(DB_Selected).Object)
    EXIT SUB
END IF
DIM mysql_result AS _OFFSET
mysql_result = mysql_store_result(Database(DB_Selected).Object)
IF mysql_result = 0 THEN
    '...todo...
ELSE
    columns = mysql_num_fields(mysql_result)
    rows = mysql_num_rows(mysql_result)
    IF DB_Debug_Mode THEN PRINT "Columns:"; columns, "Rows:"; rows
    REDIM DB_RESULT(columns, rows) AS STRING
    FOR y = 1 TO rows
        DIM mysql_row AS _OFFSET
        mysql_row = mysql_fetch_row(mysql_result)
        DIM mem_mysql_row AS _MEM
        mem_mysql_row = _MEM(mysql_row, columns * LEN(an_offset%&)) 'The upper limit is unknown at this point
        DIM mysql_lengths AS _OFFSET
        mysql_lengths = mysql_fetch_lengths(mysql_result)
        DIM mem_mysql_lengths AS _MEM
        mem_mysql_lengths = _MEM(mysql_lengths, columns * 4)
        DIM mem_field AS _MEM
        FOR x = 1 TO columns
            length = _MEMGET(mem_mysql_lengths, mem_mysql_lengths.OFFSET + (x - 1) * 4, _UNSIGNED LONG)
            mem_field = _MEM(_MEMGET(mem_mysql_row, mem_mysql_row.OFFSET + (x - 1) * LEN(an_offset%&), _OFFSET), length)
            DB_RESULT(x, y) = SPACE$(length)
            _MEMGET mem_field, mem_field.OFFSET, DB_RESULT(x, y)
            _MEMFREE mem_field
            IF DB_Debug_Mode THEN
                posx = 1 + (x - 1) * 30: IF posx <= _WIDTH THEN LOCATE , posx
                PRINT "[" + LTRIM$(STR$(length)) + "]";
                posx = 1 + (x - 1) * 30 + 5: IF posx <= _WIDTH THEN LOCATE , posx
                PRINT DB_RESULT(x, y);
            END IF
        NEXT
        IF DB_Debug_Mode THEN PRINT 'new line
        _MEMFREE mem_mysql_lengths
        _MEMFREE mem_mysql_row
    NEXT
    mysql_free_result mysql_result
END IF
END SUB

SUB DB_Select (database_handle&)
IF database_handle& < 0 OR database_handle& > DB_Last THEN DB_Critical_Error "DB_Select: Invalid handle"
IF Database(database_handle&).Object = 0 THEN DB_Critical_Error "DB_Select: Invalid handle"
DB_Selected = database_handle&
END SUB


SUB DB_PRINT
columns = UBOUND(DB_RESULT): rows = UBOUND(DB_RESULT, 2)

FOR x = 1 TO columns
    IF LEN(DB_RESULT(x, 0)) > 0 THEN y1 = 0 ELSE y1 = 1
NEXT

width_characters = _WIDTH
DIM max_width(columns)
total_width = 1
FOR x = 1 TO columns
    max = 0
    FOR y = y1 TO rows
        IF LEN(DB_RESULT(x, y)) > max THEN max = LEN(DB_RESULT(x, y))
    NEXT
    max_width(x) = max
    total_width = total_width + max + 1
NEXT
PRINT "Columns:"; columns, "Rows:"; rows
PRINT CHR$(218);: FOR x = 1 TO columns: PRINT STRING$(max_width(x), CHR$(196)) + CHR$(194);: NEXT: LOCATE , POS(0) - 1: PRINT CHR$(191);: PRINT
FOR y = y1 TO rows
    x2 = 1
    FOR x = 1 TO columns
        a$ = DB_RESULT(x, y)
        LOCATE , x2
        PRINT CHR$(179) + a$;
        x2 = x2 + max_width(x) + 1
        LOCATE , x2
        PRINT CHR$(179);
    NEXT
    PRINT
    IF y < rows THEN
        PRINT CHR$(195);: FOR x = 1 TO columns: PRINT STRING$(max_width(x), CHR$(196)) + CHR$(197);: NEXT: LOCATE , POS(0) - 1: PRINT CHR$(180);: PRINT
    END IF
    IF INKEY$ <> "" THEN quick = 1
    IF quick = 0 THEN _LIMIT 10
NEXT
PRINT CHR$(192);: FOR x = 1 TO columns: PRINT STRING$(max_width(x), CHR$(196)) + CHR$(193);: NEXT: LOCATE , POS(0) - 1: PRINT CHR$(217);: PRINT
END SUB



SUB EXAMPLE_1 (you_can_delete_this_sub) 'open and explore an existing database
host_ip$ = sql_database_ip
user_password$ = my_password
user_name$ = my_username
mydb = DB_Open(host_ip$, user_name$, user_password$, "")
IF mydb = 0 THEN PRINT "Oops! " + DB_Last_Error$: END
DO
    DO
        DB_QUERY "SHOW DATABASES": DB_PRINT
        LINE INPUT "Use database named >", a$
        IF a$ = "" THEN GOTO Try_Again
        DB_QUERY "USE " + a$
    LOOP UNTIL LEN(DB_Last_Error$) = 0
    DO
        DB_QUERY "SHOW TABLES": DB_PRINT
        LINE INPUT "View table named >", a$
        IF a$ = "" THEN GOTO Try_Again
        DB_QUERY "SELECT column_name FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name='" + a$ + "' ORDER BY ordinal_position"
    LOOP UNTIL LEN(DB_Last_Error$) = 0
    'retrieve column headings and store in an array
    REDIM headings$(UBOUND(db_result, 2))
    FOR y = 1 TO UBOUND(db_result, 2)
        headings$(y) = DB_RESULT(1, y)
    NEXT
    DB_QUERY "SELECT * FROM " + a$
    'apply headings
    FOR x = 1 TO UBOUND(headings$)
        DB_RESULT(x, 0) = headings$(x)
    NEXT
    DB_PRINT
    Try_Again:
    LINE INPUT "View another?", yn$
    IF UCASE$(yn$) <> "Y" THEN
        DB_Close
        EXIT SUB
    END IF
LOOP
END SUB

SUB EXAMPLE_2 (you_can_delete_this) 'create a new database, a new table, a heading and enter some data
host_ip$ = sql_database_ip
user_password$ = my_password
user_name$ = my_username
LINE INPUT "What will you call your database? >", d$
mydb = DB_Create(host_ip$, user_name$, user_password$, d$)
IF LEN(DB_Last_Error$) <> 0 THEN PRINT "Oops! " + DB_Last_Error$: END
LINE INPUT "What will you call your table? >", t$
LINE INPUT "And what will be the first column's heading? >", h$
DB_QUERY "CREATE TABLE " + t$ + "(" + h$ + " text)"
IF LEN(DB_Last_Error$) <> 0 THEN PRINT "Oops! " + DB_Last_Error$: END
DO
    DB_QUERY "SELECT column_name FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name='" + t$ + "' ORDER BY ordinal_position"
    'retrieve column headings and store in an array
    REDIM headings$(UBOUND(db_result, 2))
    FOR y = 1 TO UBOUND(db_result, 2)
        headings$(y) = DB_RESULT(1, y)
    NEXT
    DB_QUERY "SELECT * FROM " + t$
    'apply headings
    FOR x = 1 TO UBOUND(headings$)
        DB_RESULT(x, 0) = headings$(x)
    NEXT
    DB_PRINT
    LINE INPUT "Type new entry's text >", c$
    IF c$ = "" THEN PRINT "Finished!": DB_Close: EXIT SUB
    DB_QUERY "INSERT INTO " + t$ + " VALUES ('" + c$ + "')"
    IF LEN(DB_Last_Error$) <> 0 THEN PRINT "Oops! " + DB_Last_Error$: END
LOOP 'infinite loop
END SUB 

```

## Linux Install:

This works in Linux (Ubuntu) too with minimal changes:

1. Use the 'Synaptic Package Manager' to install 'mysql-client-5.1'
2. Change: DECLARE DYNAMIC LIBRARY "mysql" to DECLARE DYNAMIC LIBRARY "mysqlclient:16.0.0" 

>  Or just copy this .so lib to your QB64 folder and rename it *libmysql.so*(do not use *.so* extension in [DECLARE LIBRARY](DECLARE-LIBRARY) name).

## See Also

* [DECLARE LIBRARY](DECLARE-LIBRARY)
* [ALIAS](ALIAS), [BYVAL](BYVAL)
* [_OFFSET](_OFFSET)
