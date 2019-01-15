#!/bin/bash
source $PRECISION100_FOLDER/.env.sh

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <migration name> <run name> [pipeline name] [container name]"
    exit -1
fi
if [ "$#" -gt 4 ]; then
    echo "Usage: $0 <migration name> <run name> [pipeline name] [container name]"
    exit -1
fi

export MIGRATION_ARGUMENT=$1
export ITERATION_ARGUMENT=$2
export PIPELINE_ARGUMENT=$3
export CONTAINER_ARGUMENT=$4

export SPOOL_PATH="${SPOOL_PATH}/${ITERATION_ARGUMENT}"
export SQLLDR_LOG="${SQLLDR_LOG}/${ITERATION_ARGUMENT}"
export SQLLDR_BAD="${SQLLDR_BAD}/${ITERATION_ARGUMENT}"
export GIT_WORK_AREA="${GIT_LOCAL_FOLDER}/${ITERATION_ARGUMENT}"

mkdir -p "$SPOOL_PATH"
mkdir -p "$SQLLDR_LOG"
mkdir -p "$SQLLDR_BAD"
mkdir -p "$GIT_LOCAL_FOLDER"

git clone "$GIT_URL" "$GIT_WORK_AREA"

cd "$GIT_WORK_AREA"

git branch "$ITERATION_ARGUMENT"
git checkout "$ITERATION_ARGUMENT"

export CONTAINER_FOLDER="${GIT_WORK_AREA}/containers"
export PIPELINE_FOLDER="${GIT_WORK_AREA}/pipelines"
export MIGRATION_FOLDER="${GIT_WORK_AREA}/migrations"

##
## Now to generate the SCRIPTS
##
$PRECISION100_FOLDER/create_migration_script.sh $MIGRATION_ARGUMENT

git add --all
git commit -m "Added generated scripts for $MIGRATION_ARGUMENT - $ITERATION_ARGUMENT"

##
## Actually execute the created files
##
if test "$#" -eq 2; then
    MIGRATION_SCRIPT="${MIGRATION_ARGUMENT}.sh"
    $MIGRATION_FOLDER/$MIGRATION_SCRIPT
fi

if test "$#" -eq 3; then
    PIPELINE_SCRIPT="${PIPELINE_ARGUMENT}.sh"
    $PIPELINE_FOLDER/$PIPELINE_SCRIPT
fi

if test "$#" -eq 4; then
    CONTAINER_SCRIPT="${CONTAINER_ARGUMENT}/container.sh"
    $CONTAINER_FOLDER/$CONTAINER_SCRIPT
fi
