#!/bin/bash


OPERATION_MODE=$1
REPO_ACTION=$2

case "$REPO_ACTION" in
  CHECKOUT) 
    cp -R $3/* $4
    ;;
  REFRESH)
    ;;
  BRANCH)
    ;;
  *)
    eval "${UNKNOWN_EXEC_OPERATOR} '$OPERATION_MODE' '$REPO_ACTION'"
    ;;
esac
