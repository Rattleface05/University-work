#!/bin/bash

cat /etc/hosts | while read line; do
    if [[ "$line" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+[[:space:]]+ ]]; then
        ip=$(echo $line | awk '{print $1}')
        hostname=$(echo $line | awk '{print $2}')
        nslookup_ip=$(nslookup $hostname | grep 'Address' | head -n 2 | tail -n 1 | awk '{print $2}')
        if [[ "$ip" != "$nslookup_ip" ]]; then
            echo "Bogus IP for $hostname in /etc/hosts !"
        fi
    fi
done
