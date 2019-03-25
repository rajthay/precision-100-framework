CONNECTION_NAME=$1

CONFIG_SEPARATOR=','

NAME_INDEX=1
TYPE_INDEX=2

LINE=$(cat $PRECISION100_FOLDER/conf/.connections.env.sh | grep -i $CONNECTION_NAME)
CONNECTION_TYPE=$(echo $LINE | cut -d "$CONFIG_SEPARATOR" -f $TYPE_INDEX)

declare -A connection_map

while IFS=$',\r' read key value;
do
   connection_map["$key"]="$value"
done < <(cat $PRECISION100_CONNECTORS_FOLDER/*/connection.reg)

if [ ${connection_map[$CONNECTION_TYPE]+_} ]; then 
  CONNECTION_STRING="$PRECISION100_CONNECTORS_FOLDER/${connection_map[$CONNECTION_TYPE]}"
else 
  CONNECTION_STRING="$PRECISION100_CONNECTORS_FOLDER/${connection_map['unknown-connection-type']}"
fi
eval "${CONNECTION_STRING} $LINE";

