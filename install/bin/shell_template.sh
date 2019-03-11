echo "        START SHELL ADAPTOR $1"

if test "$2" = "TRUE"; then
   sleep $3;
   echo "        END SHELL ADAPTOR $1"
   exit;
fi

sqlplus -s /nolog << BEFORE_COMMAND 1> >(tee -a $PRECISION100_LOG_FOLDER/sql.log) 2> >(tee -a $PRECISION100_LOG_FOLDER/sql-err.log >&2)
CONNECT $USERNAME/$PASSWORD@$SID
SET FEEDBACK OFF
EXEC PROGRESS_LOGS_PKG.LOG('$0','PRE-SHELL','$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $1 ');
EXIT
BEFORE_COMMAND

$1 1> >(tee -a $PRECISION100_LOG_FOLDER/sh.log) 2> >(tee -a $PRECISION100_LOG_FOLDER/sh-err.log >&2)

sqlplus -s /nolog << AFTER_COMMAND 1> >(tee -a $PRECISION100_LOG_FOLDER/sql.log) 2> >(tee -a $PRECISION100_LOG_FOLDER/sql-err.log >&2)
CONNECT $USERNAME/$PASSWORD@$SID
SET FEEDBACK OFF
EXEC PROGRESS_LOGS_PKG.LOG('$0','POST-SHELL','$PROJECT_FOLDER / $EXECUTION_NAME / $OPERATION / $SIMULATION_MODE / $1 ');
EXIT
AFTER_COMMAND
echo "        END SHELL ADAPTOR $1"
