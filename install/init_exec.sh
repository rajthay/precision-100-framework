#!/bin/bash

source ./conf/.env.sh

DEFAULT_EXECUTION_NAME="mock1"
read -p "Enter Execution Name [$DEFAULT_EXECUTION_NAME] " INPUT_EXECUTION_NAME
EXECUTION_NAME=${INPUT_EXECUTION_NAME:-$DEFAULT_EXECUTION_NAME}

EXECUTION_CONF_FILE_NAME="$EXECUTION_NAME.env.sh"

cat > $PRECISION100_FOLDER/conf/$EXECUTION_CONF_FILE_NAME << EOL
export EXECUTION_NAME=$EXECUTION_NAME
export PRECISION100_WORK_FOLDER=$PRECISION100_FOLDER/$EXECUTION_NAME
EOL

ln -f -s $PRECISION100_FOLDER/conf/$EXECUTION_CONF_FILE_NAME $PRECISION100_FOLDER/conf/.execution.env.sh

source ./conf/.env.sh

mkdir -p "$SPOOL_PATH"
mkdir -p "$SQLLDR_LOG"
mkdir -p "$SQLLDR_BAD"
mkdir -p "$SQLLDR_INPUT"
mkdir -p "$GIT_WORK_FOLDER"

git clone "$GIT_URL" "$GIT_WORK_FOLDER"
#$PRECISION100_FOLDER/repo_clone.sh

cd "$GIT_WORK_FOLDER"

git branch "$EXECUTION_NAME"
git checkout "$EXECUTION_NAME"

git push -u origin "$EXECUTION_NAME"