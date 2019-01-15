export ORACLE_HOME=/usr/lib/oracle/18.3/client64/
export LD_LIBRARY_PATH="$ORACLE_HOME"/lib
export PATH="$ORACLE_HOME/bin:$PATH"
export TNS_ADMIN="$ORACLE_HOME/lib/network/admin"

export PRECISION100_FOLDER=$PWD
export PRECISION100_WORK_FOLDER=$PRECISION100_FOLDER
export INPUT_FILE=$PRECISION100_WORK_FOLDER/input
export SQLLDR_LOG=$PRECISION100_WORK_FOLDER/sqlldr_log
export SQLLDR_BAD=$PRECISION100_WORK_FOLDER/sqlldr_bad
export SPOOL_PATH=$PRECISION100_WORK_FOLDER/spool
export GIT_LOCAL_FOLDER=$PRECISION100_WORK_FOLDER/git-local

export GIT_URL=http://localhost:50080/precision-100-migration-framework/precision-100-migration-templates.git
export ROOT_FOLDER=simple-demo

export USERNAME=precision100
export PASSWORD=Welcome123
export SID=mig
