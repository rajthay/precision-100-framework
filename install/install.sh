#!/bin/bash

source .oraenv.sh

ORACLE_DBA_USER=system
ORACLE_DBA_USER_PASSWORD=oracle

PRECISION100_USER=precision100
PRECISION100_USER_PASSWORD=Welcome123

echo "The user should be able to create the 'precison100' user and give it the"
echo "necessary privileges to create all the constructs" 

read -p "Enter Oracle home [/usr/lib/oracle/18.3/client64/] " INPUT_ORACLE_HOME 
ORACLE_HOME=${INPUT_ORACLE_HOME:-/usr/lib/oracle/18.3/client64/}

read -p "Enter Oracle user name [system]: " INPUT_DBA
ORACLE_DBA_USER=${INPUT_DBA:-system}

read -p "Enter Oracle user password [oracle]: " INPUT_DBA_PASSWORD
ORACLE_DBA_USER_PASSWORD=${INPUT_DBA_PASSWORD:-oracle}

read -p "Enter Oracle SID [mig]: " INPUT_SID
ORACLE_MIG_SID=${INPUT_SID:-mig}

read -p "Enter Precision100 Oracle User Password [Welcome123]: " INPUT_PRECISION_PASSWORD
PRECISION100_USER_PASSWORD=${INPUT_PRECISION_PASSWORD:-Welcome123}

read -p "Enter Precision100 installation folder [$HOME/precision100]: " INPUT_PRECISION_FOLDER
PRECISION100_FOLDER=${INPUT_PRECISION_FOLDER:-$HOME/precision100}

read -p "Enter GIT URL for the migration templates [http://localhost:50080/precision-100-migration-framework/precision-100-migration-templates.git]" INPUT_GIT_URL
GIT_URL=${INPUT_GIT_URL:-http://localhost:50080/precision-100-migration-framework/precision-100-migration-templates.git}

#read -p "Enter migration template name [simple-demo]" INPUT_TEMPLATE_NAME
#ROOT_FOLDER=${INPUT_TEMPLATE_NAME:-simple-demo}

sqlplus -s /nolog  <<EOF

connect $ORACLE_DBA_USER/$ORACLE_DBA_USER_PASSWORD@$ORACLE_MIG_SID
CREATE USER $PRECISION100_USER IDENTIFIED BY "$PRECISION100_USER_PASSWORD";
GRANT CONNECT TO $PRECISION100_USER;
GRANT CONNECT, RESOURCE, DBA TO $PRECISION100_USER;
GRANT CREATE SESSION TO $PRECISION100_USER;
GRANT ALL PRIVILEGE TO $PRECISION100_USER;
GRANT UNLIMITED TABLESPACE TO $PRECISION100_USER;
exit;

EOF

sqlplus -s /nolog << FILE_LIST

connect $PRECISION100_USER/$PRECISION100_USER_PASSWORD@$ORACLE_MIG_SID
@sql/PERFORMANCE_LOGS.sql
@sql/PROGRESS_LOGS.sql


exit;

FILE_LIST


if [ ! -d "$PRECISION100_FOLDER/conf" ]; then
  mkdir -p "$PRECISION100_FOLDER/conf"
  mkdir -p "$PRECISION100_FOLDER/git-local"
fi

if [ ! -d "$PRECISION100_FOLDER/git-local" ]; then
  mkdir -p "$PRECISION100_FOLDER/git-local"
fi

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
export PRECISION100_FOLDER="$PRECISION100_FOLDER"
INSTALL_FOLDER

cat >> $PRECISION100_FOLDER/conf/.env.sh << 'ENV'

export PRECISION100_WORK_FOLDER=$PRECISION100_FOLDER
export INPUT_FILE=$PRECISION100_WORK_FOLDER/input
export SQLLDR_LOG=$PRECISION100_WORK_FOLDER/sqlldr_log
export SQLLDR_BAD=$PRECISION100_WORK_FOLDER/sqlldr_bad
export SPOOL_PATH=$PRECISION100_WORK_FOLDER/spool
export GIT_LOCAL_FOLDER=$PRECISION100_WORK_FOLDER/git-local


ENV

cat > $PRECISION100_FOLDER/conf/.gitenv.sh << GITENV

export GIT_URL=$GIT_URL
export ROOT_FOLDER=simple-demo

GITENV

