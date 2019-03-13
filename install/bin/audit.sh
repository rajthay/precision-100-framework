#!/bin/bash

echo "START AUDIT"

dbms_output=`sqlplus -s /nolog << EOL
CONNECT $USERNAME/$PASSWORD@$SID
SET FEEDBACK OFF


SET SERVEROUTPUT ON;
DECLARE 
EVENTTIME DATE;

BEGIN
PRECISION100.PROGRESS_LOGS_PKG.LOG('$1','$2','$3',EVENTTIME);
PRECISION100.PERFORMANCE_LOGS_PKG.LOG('$4', '$5', '$6', '$7');
dbms_output.enable;
 dbms_output.put_line(to_number(EVENTTIME - to_date('01-JAN-1970 00:00:00','DD-MON-YYYY HH24:MI:SS')) * (24 * 60 * 60 * 1000));
 END;
/

EXIT
EOL`
echo $dbms_output;


echo "END AUDIT"

