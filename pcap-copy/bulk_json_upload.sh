#!/bin/bash
input="strings.json"
output="bulk.log"
counter=0
max_rows=500
create='{"create": {}}'
bulk_data=$'\n'

echo "Indexing a template..."
curl -XPUT 'https://elastic:elasticpassword@localhost:9200/_template/strings' -H 'Content-Type: application/json' --insecure --data-binary @strings-template.json > "$output"

echo "Reading blogs from $input..."

while read -r log_event
do
  let "counter=counter+1"
  bulk_data+="$create"$'\n'"$log_event"$'\n'
  if [ $counter -eq $max_rows ]
  then
       echo "Indexing $counter documents..."
       bulk_data+=$'\n'
       echo "$bulk_data" | tee temp.json > /dev/null
       curl -XPOST 'https://elastic:elasticpassword@localhost:9200/strings/_bulk' -H 'Content-Type: application/json' --insecure --data-binary @temp.json > "$output"
       rm -rf temp.json
       counter=0
       bulk_data=$'\n'
  fi
done < "$input"

if [ $counter -lt $max_rows ] && [ $counter -gt 0 ]
then
       echo "Indexing $counter documents..."
       bulk_data+=$'\n'
       echo "$bulk_data" | tee temp.json > /dev/null
       curl -XPOST 'https://elastic:elasticpassword@localhost:9200/strings/_bulk' -H 'Content-Type: application/json' --insecure --data-binary @temp.json > "$output"
       rm -rf temp.json
fi