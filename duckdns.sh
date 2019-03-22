#!/bin/bash 

LASTIP='';

getIP (){
	IP=$(curl -qO- "http://myexternalip.com/raw");
	if [ $IP -ne $LASTIP ] ; 
		then 
		$LASTIP=$IP;
		echo "New IP Dectated: ${IP}";
	fi
	return IP;
}

buildUrl($TOKEN,$IP,$DOMAINS,$VERBOSE) {
	DDNSURL="https://www.duckdns.org/update?"
	$DDNSURL = ${DDNSURL}token=${TOKEN}&domains=${DOMAINS}&ip=${IP}&verbose={$VERBOSE}
	return $URL;
}
updateDNS($TOKEN, $IP, $DOMAINS,$VERBOSE){

	if [ -n "$IP" ]
	then
		IPANDURL="${DDNSURL}ip=$IP&"
	fi	
	USERAGENT="--user-agent=\"shell script/1.0 mail@mail.com\""
	
	$URL = buildUrl($TOKEN, $IP, $DOMAINS,$VERBOSE);

	return $(curl $URL)
}

if [ -z "$TOKEN" ]
then
	echo "No TOKEN was set."
	exit 20
fi


if [ -z "$DOMAINS" ]
then
	echo "No domains set."
	exit 30
fi


if [ -n "$DETECTIP" ]
then
	IP=getIP();
fi


if [ -n "$DETECTIP" ] && [ -z $IP ]
then
	RESULT="Could not detect external IP."
fi


if [[ $INTERVAL != [0-9]* ]]
then
	echo "Interval is not an integer."
	exit 35
fi
echo "Started $(date)"
echo "Update interval ${INTERVAL}m"

while :
do
	
	if [ -n "$DETECTIP" ]
	then
		IP=getIP();
	fi
	if [ -n "$DETECTIP" ] && [ -z $IP ]
	then
		RESULT="Could not detect external IP."
	fi

	RESULT=updateDNS($TOKEN, $IP, $DOMAINS);

	 
	echo "$(date): $RESULT"
	

	if [ $INTERVAL -eq 0 ]
	then
		break
	else
		sleep "${INTERVAL}m" 
	fi

done

exit 0