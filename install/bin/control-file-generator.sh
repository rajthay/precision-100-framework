if [ -z "$CHAR_SET" ]; then
    CHAR_SET=${DEFAULT_CHAR_SET:-WE8ISO8859P1}
fi

lines="$( sqlplus -s /nolog <<EOF
CONNECT $USERNAME/$PASSWORD@$SID
set feedback off
SET VERIFY OFF
set head off
select column_name
from   user_tab_columns
where  table_name= upper('$1')
order by column_id;
exit;
EOF
)"
line_count=`echo $lines | wc -w `

counter=0;
echo "LOAD DATA"
echo "CHARACTERSET $CHAR_SET"
echo "INFILE *"
echo "TRUNCATE INTO TABLE $1"
echo "FIELDS TERMINATED BY ','"
echo "TRAILING NULLCOLS ("
for line in $lines; do
  counter=$counter+1;
  if [[ $counter -eq $line_count ]]; then
    echo $line;
  else
    echo "$line,"
  fi;
done;
echo ")"
