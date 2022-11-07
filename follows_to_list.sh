idsToAdd=()

LIST=
TOKEN=

for i in ${!idsToAdd[@]}; do
  start=0
  end=$start+60
  if [[ $i -ge $start && $i -lt $end ]]
  then
    echo "Going to add id ${idsToAdd[$i]}"
    curl \
      -X POST \
      -H "Content-type: application/json" \
      -d "{\"user_id\":\"${idsToAdd[$i]}\"}" \
      -H "Authorization: Bearer $TOKEN" \
      "https://api.twitter.com/2/lists/${LIST}/members"
    echo
  fi
done
