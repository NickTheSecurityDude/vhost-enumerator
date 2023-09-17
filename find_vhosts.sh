#!/bin/bash

HTTP=$1
DOMAIN=$2
WORDLIST=$3

if [[ $1 = "" || $2 = "" || $3 = "" || ! -f $3 ]];then
  echo "Usage: find_vhosts.sh <http/https>  <domain> <wordlist>"
  echo "ex: ./find_vhosts.sh http://stacked.htb /opt/SecLists/Discovery/DNS/subdomains-top1million-5000.txt >vhosts-out.txt"
  exit
fi

if [[ $1 != "http" && $1 != "https" ]];then
  echo "First parameter must be http or https"
  exit
fi

for i in `cat $WORDLIST`;do
  echo -n "$i "
  curl -s -w "%{http_code} %{size_download}"  -o /dev/null --header "Host: ${i}.${DOMAIN}" ${HTTP}://${DOMAIN}/ 
  echo ""
done
