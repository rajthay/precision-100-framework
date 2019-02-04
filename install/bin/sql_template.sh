sqlplus -s /nolog << EOL
CONNECT $USERNAME/$PASSWORD@$SID

EXEC PROGRESS_LOGS_PKG.LOG('$1','START', 'EXECUTING: $2');
@$2
EXEC PROGRESS_LOGS_PKG.LOG('$1','END', 'EXECUTING: $2');
EXIT

EOL