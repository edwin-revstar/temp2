#!/bin/sh
export PRINTER_NAME='Canon_MX450_series'
export FILE_TO_PRINT='./Profile.pdf'

ip="$(ip -j a | jq -r '.[2].addr_info[0].local')"
export ip
printf "%b\n" "Current ip: $ip"

#printf "Updating app.js with current ip...\n"
#sed -E -e "s/ip = '.*'/ip = '$ip'/" "./dashtic/app.js" > tmp && mv tmp "./dashtic/app.js"
#printf "Updated app.js with current ip\n"

pkill socat
printf "Starting REST server...\n"
socat TCP-LISTEN:1042,reuseaddr,pf=ip4,bind="$ip",fork system:"$HOME/sampo/sampo.sh" &
printf "Started REST server\n"

#cd ./dashtic/ || printf "dashtic folder not found\n"
#printf "%b\n" "Frontend is on http://$ip:5002"
printf "%b\n" "CUPS interface is on http://localhost:631"
npm start
