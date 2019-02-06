TABLE_NAME=$1

source ./.env.sh

sqlplus -s /nolog  <<EOF
connect $USERNAME/$PASSWORD@$SID
set head off
set feedback off
set term off
set pages 0
set trimspool on
set markup csv on
spool $SPOOL_PATH/test.csv
SELECT * from $TABLE_NAME;
spool off;
exit;

EOF
