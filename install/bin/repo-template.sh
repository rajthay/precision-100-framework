#!/bin/bash

REPO_ACTION=$1
OPERATION_MODE=${EXECUTION_ENV:-DEV}

declare -A operator_map

while IFS=$',\r' read key value;
do
   operator_map["$key"]="$value"
done < <(cat $PRECISION100_REPO_OPERATORS_FOLDER/*/operator.reg)

echo "        executing operator ${operator_map[$REPO_TYPE]} '$REPO_ACTION'"

UNKNOWN_EXEC_OPERATOR=${operator_map['unknown-repo-type']}
if [ ${operator_map[$REPO_TYPE]+_} ]; then 
  EXEC_OPERATOR=${operator_map[$REPO_TYPE]}
else 
  EXEC_OPERATOR=$UNKNOWN_EXEC_OPERATOR
fi

case "$REPO_ACTION" in
  CHECKOUT) 
    eval "${EXEC_OPERATOR} '$OPERATION_MODE' '$REPO_ACTION' '$REPO_URL' '$REPO_WORK_FOLDER'"
    ;;
  REFRESH)
    eval "${EXEC_OPERATOR} '$OPERATION_MODE' '$REPO_ACTION'"
    ;;
  BRANCH)
    eval "${EXEC_OPERATOR} '$OPERATION_MODE' '$REPO_ACTION' '$EXECUTION_NAME'"
    ;;
  *)
    eval "${UNKNOWN_EXEC_OPERATOR} '$OPERATION_MODE' '$REPO_ACTION'"
    ;;
esac

#eval "${EXEC_STRING} '$CONTAINER' '$LINE'"
