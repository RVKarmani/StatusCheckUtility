#!/bin/bash
#VARIANT 2 - ITERATING OVER ADDRESSES
IP=( `jq -r ".[].Ip " services.json` )
NAMES=( `jq -r ".[].Name " services.json` )
EMAIL_BODY=""

for ix in ${!IP[@]}
do
	STATUS=`./wait-for-it.sh ${IP[$ix]} --strict -- echo "UP"`
	if [ "$STATUS" == "UP" ]
	then
		echo "${NAMES[$ix]} is UP"
	else
		echo "${NAMES[$ix]} is DOWN"
		echo "${NAMES[$ix]} is DOWN" | mutt -s "Gamification  Servers Check" -- vemrohit@publicisgroupe.net
	fi
done
