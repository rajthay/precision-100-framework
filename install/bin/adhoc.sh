#!/bin/bash

source ./conf/.env.sh

export OPERATION="ADHOC"

cd $GIT_WORK_FOLDER
git pull origin $EXECUTION_NAME

CONTAINER=$1
FILE_NAME=$2

LINE=`grep $FILE_NAME $CONTAINER_FOLDER/$CONTAINER/file.txt`

filename=$(echo $LINE | cut -d ',' -f 2)
filetype=$(echo $LINE | cut -d ',' -f 3)

$PRECISION100_FOLDER/exec_file.sh $CONTAINER $filename $filetype
