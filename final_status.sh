#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
IP=( `jq -r ".[].Ip " $DIR/services.json` )
NAMES=( `jq -r ".[].Name " $DIR/services.json` )
for ix in ${!IP[@]}
do
	STATUS=`$DIR/wait-for-it.sh ${IP[$ix]} -t 600 --strict -- echo "UP"`
	if [ "$STATUS" == "UP" ]
	then
		echo "${NAMES[$ix]} is UP"
	else
		echo "${NAMES[$ix]} is DOWN"
		echo "${NAMES[$ix]} is DOWN" | mutt -s "Gamification  Servers Check" -- vemrohit@publicisgroupe.net
	fi
done
