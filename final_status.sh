#!/bin/bash
#VARIANT 2 - ITERATING OVER ADDRESSES
IP=( `jq -r ".[].Ip " services.json` )
NAMES=( `jq -r ".[].Name " services.json` )

for ix in ${!IP[@]}
do
	STATUS=`./wait-for-it.sh ${IP[$ix]} --strict -- echo "UP"`
	if [ "$STATUS" == "UP" ]
	then
		echo "${NAMES[$ix]} is UP"
	else
		echo "${NAMES[$ix]} is DOWN"
		rm ./"error.log"
		docker logs ${NAMES[$ix]} &> error.log
		echo "${NAMES[$ix]} is DOWN" | mutt -s "Gamification Utility Check" -a ./"error.log" -- vemrohit@publicisgroupe.net
	fi
done
