#!/bin/bash
#Script auto create trial user SSH
#yg akan expired setelah 1 hari
#Script by admin@white-vps.com
Login=trial-`</dev/urandom tr -dc X-Z0-9 | head -c4`
masaaktif="1"
Pass=`</dev/urandom tr -dc a-f0-9 | head -c9`
IP=`dig +short myip.opendns.com @resolver1.opendns.com`
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "==== Informasi akun Trial ===="
echo -e "Host     : $IP" 
echo -e "Username : $Login "
echo -e "Password : $Pass"
echo -e "Openssh  : 22,143"
echo -e "Dropbear : 456,109"
echo -e "SSL/TLS  : 443"
echo -e "Squid    : 8080,3128,80"
echo -e "OpenVPN  : http://$IP:81/1194-client.ovpn"
echo -e "Akun ini hanya aktif 1 hari"
echo -e "============================="
echo -e "Created    : Team white-vps"
