TABLE_NAME=$1

sqlplus -s /nolog  <<EOF >> /dev/null
connect $USERNAME/$PASSWORD@$SID
set head off
set feedback off
set term off
set pages 0
set trim on
set verify off
set markup csv on delimiter $2 quote $3
spool $SPOOL_PATH/$TABLE_NAME.csv
SELECT * from $TABLE_NAME;
spool off;
exit;

EOF
