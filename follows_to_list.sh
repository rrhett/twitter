idsToAdd=()

LIST=

start=0
end=$start+60

for i in ${!idsToAdd[@]}; do
  if [[ $i -ge $start && $i -lt $end ]]
  then
    echo "Going to add id $i: ${idsToAdd[$i]}"

    # Paste cURL here

    echo
  fi
done
