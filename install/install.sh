#!/bin/bash

source .oraenv.sh

PRECISION100_USER=precision100
PRECISION100_USER_PASSWORD=Welcome123

ORACLE_DBA_USER=system
ORACLE_DBA_USER_PASSWORD=oracle
ORACLE_MIG_SID=mig

ORACLE_CONNECT_STRING=$ORACLE_DBA_USER/$ORACLE_DBA_USER_PASSWORD@$ORACLE_MIG_SID

echo "The user should be able to create the 'precison100' user and give it the"
echo "necessary privileges to create all the constructs" 

if [ -z "$1" ]
  then
    ORACLE_CONNECT_STRING=$ORACLE_DBA_USER/$ORACLE_DBA_USER_PASSWORD@$ORACLE_MIG_SID
  else
    ORACLE_CONNECT_STRING=$1
fi

if [ -z "$2" ]
  then
    PRECISION100_USER_PASSWORD=Welcome123
  else
    PRECISION100_USER_PASSWORD=$2
fi

if [ -z "$3" ]
  then
    PRECISION100_USER=precision100
  else
    PRECISION100_USER=$3
fi

sqlplus -s /nolog  <<EOF

connect $ORACLE_CONNECT_STRING;
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