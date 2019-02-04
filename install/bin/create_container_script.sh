#!/bin/bash

CONTAINER=$1
CONTAINER_SCRIPT="container.sh"
if [ -f $CONTAINER_FOLDER/$CONTAINER/file.txt ]; then
   filelines=`cat $CONTAINER_FOLDER/$CONTAINER/file.txt`
   for line in $filelines ; do
       filename=$(echo $line | cut -d ',' -f 2)
       filetype=$(echo $line | cut -d ',' -f 3)
       echo $filename $filetype
   
       if test "$filetype" = "sql"; then
          #echo 'sqlplus $USERNAME/$PASSWORD@$SID @'$CONTAINER_FOLDER/$CONTAINER/$filename >> $CONTAINER_FOLDER/$CONTAINER/$CONTAINER_SCRIPT
          echo "$PRECISION100_FOLDER/sql_template.sh $filename $CONTAINER_FOLDER/$CONTAINER/$filename" >> $CONTAINER_FOLDER/$CONTAINER/$CONTAINER_SCRIPT
       fi
   
       if test "$filetype" = "loader"; then
          ldrfilename=${filename%.*}
          echo $ldrfilename
          #echo 'sqlldr $USERNAME/$PASSWORD@$SID'" control=$CONTAINER_FOLDER/$CONTAINER/$ldrfilename.ctl data=$INPUT_FILE/$ldrfilename.dat log=$SQLLDR_LOG/$ldrfilename.log bad=$SQLLDR_BAD/$ldrfilename.bad direct=true errors=1000000 bindsize= 5048576 multithreading=true" >> $CONTAINER_FOLDER/$CONTAINER/$CONTAINER_SCRIPT
          echo "$PRECISION100_FOLDER/loader_template.sh $CONTAINER_FOLDER/$CONTAINER/$ldrfilename.ctl $INPUT_FILE/$ldrfilename.dat $SQLLDR_LOG/$ldrfilename.log $SQLLDR_BAD/$ldrfilename.bad" >> $CONTAINER_FOLDER/$CONTAINER/$CONTAINER_SCRIPT
       fi
   done;
   chmod u+x $CONTAINER_FOLDER/$CONTAINER/$CONTAINER_SCRIPT
fi
