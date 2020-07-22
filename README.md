# Login for Oracle

## Oracle SQL and PL/SQL solution to manage logins

## Why?
Because I needed it. :-)

## How?
There are 3 tables:

**LOGIN_LOG**   

This table stores the log of successful logins
A trigger sets the value of every column:
 * The login time in UTC
 * Oracle user
 * OS user
 * IP address of the client
 * Program / Application


**LOGIN_SCRIPTS**

This table stores the header of the different login scipts. 


**LOGIN_SCRIPT_LINES**

This table stores the login script lines. Those are SQL commands.
Usually "alter session" and other commands to set up the things for the user.<br>
See the example in the Install sql script!

...at the end one procedure:

**P_LOGIN**

This stored procedure can run the login script what is specified in its parameter by its code.
This procedure inserts the data into the **LOGIN_LOG** table too.

The procedure calls the **PKG_MYENV** package, but it is not a must, so it is removable. 
