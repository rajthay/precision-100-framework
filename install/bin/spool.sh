echo "        START CSV ADAPTOR $1"
if test "$2" = "TRUE"; then
   sleep $3;
   echo "        END CSV ADAPTOR $1"
   exit;
fi
TABLE_NAME=$1

sqlplus -s /nolog  <<EOF
connect $USERNAME/$PASSWORD@$SID
set head off
set feedback off
set term off
set pages 0
set trimspool on
set markup csv on
EXEC PROGRESS_LOGS_PKG.LOG('$0','PRE-CSV','$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $1');
spool $SPOOL_PATH/$TABLE_NAME.csv
SELECT * from $TABLE_NAME;
spool off;
EXEC PROGRESS_LOGS_PKG.LOG('$0','POST-CSV','$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $1');
exit;

EOF
echo "        END CSV ADAPTOR $1"
