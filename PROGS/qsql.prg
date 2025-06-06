Lparameters sqlquery, database, cursor

*!*	If Empty(cursor) or Upper(Transform(cursor)) = '.F.'
*!*		cursor = 'sql_tmp'
*!*	EndIf 

If !Empty(database)
	lcStringConnect = "DRIVER={MySQL ODBC 8.0 UNICODE Driver};SERVER=127.0.0.1;DATABASE=" + database + ";USER=root;PASSWORD=zwcd0;OPTION=3;"
Else
	lcStringConnect = "DRIVER={MySQL ODBC 8.0 UNICODE Driver};SERVER=127.0.0.1;USER=root;PASSWORD=zwcd0;OPTION=3;"
EndIf 

*---This part here sets connection errors hidden.
SQLSetprop(0, "DispLogin", 3)
SQLSetprop(0, "DispWarnings", .F.)

*---This is where the actual connection happens.
lnConnect = Sqlstringconnect(m.lcStringConnect)

*---The variable lnConnect holds the number returned by the function
*---SQLSTRINGCONNECT(), if the value is greater than zero (0) then
*---no error happened during the connection attempt. 

If m.lnConnect > 0
  	*--- List the databases in MYSQL.
  	SQLExec_str = ''
  	If Empty(cursor) or Upper(Transform(cursor)) = '.F.'
		SQLExec_str = 'SQLExec(m.lnconnect, sqlquery)'
	Else
		SQLExec_str = 'SQLExec(m.lnconnect, sqlquery, cursor)'
	EndIf 
	If &SQLExec_str < 1
 		MessageBox('Cannot make SQL query')
	EndIf 
   	
	SQLDisconnect(m.lnConnect) 
Else
	MESSAGEBOX('Cannot make connection', 16, 'SQL Connect Error')
	Return 
Endif

