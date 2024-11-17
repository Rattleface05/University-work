#!/bin/bash
hostname=$1
ip=$2
dns="8.8.8.8"
if [[ -z $3 ]]; then
	dns=$3
fi
nslookup_ip=$(nslookup $hostname $dns | grep 'Address' | head -n 2 | tail -n 1 | awk '{print $2}')
if [[ "$ip" != "$nslookup_ip" ]]; then
	echo "Bogus IP for $hostname"
else
	echo "IP matches for $hostname"
fi
