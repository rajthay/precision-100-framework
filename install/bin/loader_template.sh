echo "        START SQL_LOADER ADAPTOR $2"

if test "$5" = "TRUE"; then
   sleep $6;
   echo "        END SQL_LOADER ADAPTOR $2"
   exit;
fi

sqlplus -s /nolog << BEFORE_COMMAND 1> >(tee -a $PRECISION100_LOG_FOLDER/sqlerr.log) 2> >(tee -a $PRECISION100_LOG_FOLDER/sqlerr.log >&2)
CONNECT $USERNAME/$PASSWORD@$SID
SET FEEDBACK OFF
EXEC PROGRESS_LOGS_PKG.LOG('$0','PRE-LOADER','$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $1 / $2 ');
EXIT
BEFORE_COMMAND

sqlldr control=$1 data=$2 log=$3 bad=$4 direct=true errors=1000000 bindsize=5048576 multithreading=true << LOADER 1> >(tee -a $PRECISION100_LOG_FOLDER/loadererr.log) 2> >(tee -a $PRECISION100_LOG_FOLDER/loadererr.log >&2)
$USERNAME/$PASSWORD@$SID
LOADER

sqlplus -s /nolog << AFTER_COMMAND 1> >(tee -a $PRECISION100_LOG_FOLDER/sqlerr.log) 2> >(tee -a $PRECISION100_LOG_FOLDER/sqlerr.log >&2)
CONNECT $USERNAME/$PASSWORD@$SID
SET FEEDBACK OFF
EXEC PROGRESS_LOGS_PKG.LOG('$0','POST-LOADER','$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $1 / $2 ');
EXIT
AFTER_COMMAND
echo "        END SQL_LOADER ADAPTOR $2"
