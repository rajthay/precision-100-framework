#!/bin/bash
MIGRATION=$1
MIGRATION_SCRIPT="$MIGRATION.sh"
filelines=`cat $MIGRATION_FOLDER/$MIGRATION.txt`
for pipeline in $filelines ; do
    $PRECISION100_FOLDER/create_pipeline_script.sh $pipeline
    echo "$PIPELINE_FOLDER/$pipeline".sh >> $MIGRATION_FOLDER/$MIGRATION_SCRIPT
done;
chmod u+x $MIGRATION_FOLDER/$MIGRATION_SCRIPT
