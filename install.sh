#!/bin/bash


DEFAULT_ORACLE_HOME=/usr/lib/oracle/18.3/client64/

DEFAULT_ORACLE_DBA_USER=system
DEFAULT_ORACLE_DBA_USER_PASSWORD=oracle
DEFAULT_SID=mig

DEFAULT_PRECISION100_USER=precision100
DEFAULT_PRECISION100_USER_PASSWORD=Welcome123

DEFAULT_PRECISION100_HOME=$HOME/precision100
DEFAULT_GIT_URL="http://localhost:50080/precision-100-migration-framework/precision-100-migration-templates.git"
DEFAULT_PROJECT_NAME=simple-demo

echo "The user should be able to create the '$DEFAULT_PRECISION100_USER' user and give it the"
echo "necessary privileges to create all the constructs" 

read -p "Enter Oracle Home [$DEFAULT_ORACLE_HOME] " INPUT_ORACLE_HOME 
ORACLE_HOME=${INPUT_ORACLE_HOME:-$DEFAULT_ORACLE_HOME}

read -p "Enter Oracle user name [$DEFAULT_ORACLE_DBA_USER]: " INPUT_DBA
ORACLE_DBA_USER=${INPUT_DBA:-$DEFAULT_ORACLE_DBA_USER}

read -p "Enter Oracle user password [$DEFAULT_ORACLE_DBA_USER_PASSWORD]: " INPUT_DBA_PASSWORD
ORACLE_DBA_USER_PASSWORD=${INPUT_DBA_PASSWORD:-$DEFAULT_ORACLE_DBA_USER_PASSWORD}

read -p "Enter Oracle SID [$DEFAULT_SID]: " INPUT_SID
ORACLE_MIG_SID=${INPUT_SID:-$DEFAULT_SID}

read -p "Enter Precision100 Oracle User [$DEFAULT_PRECISION100_USER]: " INPUT_PRECISION100_USER
PRECISION100_USER=${INPUT_PRECISION100_USER:-$DEFAULT_PRECISION100_USER}

read -p "Enter Precision100 Oracle User Password [$DEFAULT_PRECISION100_USER_PASSWORD]: " INPUT_PRECISION100_PASSWORD
PRECISION100_USER_PASSWORD=${INPUT_PRECISION100_PASSWORD:-$DEFAULT_PRECISION100_USER_PASSWORD}

read -p "Enter Precision100 installation folder [$DEFAULT_PRECISION100_HOME]: " INPUT_PRECISION100_FOLDER
PRECISION100_FOLDER=${INPUT_PRECISION100_FOLDER:-$DEFAULT_PRECISION100_HOME}

read -p "Enter GIT URL for the migration templates [$DEFAULT_GIT_URL] " INPUT_GIT_URL
GIT_URL=${INPUT_GIT_URL:-$DEFAULT_GIT_URL}

read -p "Enter migration project name [simple-demo]" INPUT_PROJECT_NAME
PROJECT_NAME=${INPUT_PROJECT_NAME:-$DEFAULT_PROJECT_NAME}

export ORACLE_HOME=/usr/lib/oracle/18.3/client64/
export LD_LIBRARY_PATH="$ORACLE_HOME"/lib
export PATH="$ORACLE_HOME/bin:$PATH"
export TNS_ADMIN="$ORACLE_HOME/lib/network/admin"

$ORACLE_HOME/bin/sqlplus -s /nolog  <<EOF

connect $ORACLE_DBA_USER/$ORACLE_DBA_USER_PASSWORD@$ORACLE_MIG_SID
CREATE USER $PRECISION100_USER IDENTIFIED BY "$PRECISION100_USER_PASSWORD";
GRANT CONNECT TO $PRECISION100_USER;
GRANT CONNECT, RESOURCE, DBA TO $PRECISION100_USER;
GRANT CREATE SESSION TO $PRECISION100_USER;
GRANT ALL PRIVILEGE TO $PRECISION100_USER;
GRANT UNLIMITED TABLESPACE TO $PRECISION100_USER;
exit;

EOF

$ORACLE_HOME/bin/sqlplus -s /nolog << FILE_LIST

connect $PRECISION100_USER/$PRECISION100_USER_PASSWORD@$ORACLE_MIG_SID
@install/sql/PERFORMANCE_LOGS.sql
@install/sql/PROGRESS_LOGS.sql

exit;

FILE_LIST


if [ ! -d "$PRECISION100_FOLDER/conf" ]; then
  mkdir -p "$PRECISION100_FOLDER/conf"
fi

if [ ! -d "$PRECISION100_FOLDER/log" ]; then
  mkdir -p "$PRECISION100_FOLDER/log"
fi

if [ ! -d "$PRECISION100_FOLDER/bin" ]; then
  mkdir -p "$PRECISION100_FOLDER/bin"
fi

cat > $PRECISION100_FOLDER/conf/.default.env.sh << DEFAULT_ENV
export EXECUTION_NAME=DEFAULT
export PRECISION100_WORK_FOLDER=$PRECISION100_FOLDER
DEFAULT_ENV

#Point .execution.env.sh to .default.env.sh
ln -s $PRECISION100_FOLDER/conf/.default.env.sh $PRECISION100_FOLDER/conf/.execution.env.sh

cat > $PRECISION100_FOLDER/conf/.oraenv.sh << ORAHOME
export ORACLE_HOME=$ORACLE_HOME
ORAHOME

cat >> $PRECISION100_FOLDER/conf/.oraenv.sh << 'ORAENV'

export LD_LIBRARY_PATH="$ORACLE_HOME"/lib
export PATH="$ORACLE_HOME/bin:$PATH"
export TNS_ADMIN="$ORACLE_HOME/lib/network/admin"

ORAENV

cat >> $PRECISION100_FOLDER/conf/.oraenv.sh << ORASECRET

export USERNAME=$PRECISION100_USER
export PASSWORD=$PRECISION100_USER_PASSWORD
export SID=$ORACLE_MIG_SID

ORASECRET

cat > $PRECISION100_FOLDER/conf/.env.sh << INSTALL_FOLDER

export PRECISION100_FOLDER=$PRECISION100_FOLDER
export PROJECT_NAME=$PROJECT_NAME

source $PRECISION100_FOLDER/conf/.oraenv.sh
source $PRECISION100_FOLDER/conf/.gitenv.sh

source $PRECISION100_FOLDER/conf/.execution.env.sh

INSTALL_FOLDER

cat >> $PRECISION100_FOLDER/conf/.env.sh << 'ENV'

export GIT_WORK_FOLDER=$PRECISION100_WORK_FOLDER/git-local
export SQLLDR_INPUT=$PRECISION100_WORK_FOLDER/input
export SQLLDR_LOG=$PRECISION100_WORK_FOLDER/sqlldr_log
export SQLLDR_BAD=$PRECISION100_WORK_FOLDER/sqlldr_bad
export SPOOL_PATH=$PRECISION100_WORK_FOLDER/spool

export CONTAINER_FOLDER="$GIT_WORK_FOLDER/$PROJECT_FOLDER/containers"
export PIPELINE_FOLDER="$GIT_WORK_FOLDER/$PROJECT_FOLDER/pipelines"
export DATAFLOW_FOLDER="$GIT_WORK_FOLDER/$PROJECT_FOLDER/dataflows"

ENV

cat > $PRECISION100_FOLDER/conf/.gitenv.sh << GITENV

export GIT_URL=$GIT_URL
export PROJECT_FOLDER=$PROJECT_NAME

GITENV

cp ./install/bin/*.sh $PRECISION100_FOLDER/bin
cp ./install/*.sh $PRECISION100_FOLDER
