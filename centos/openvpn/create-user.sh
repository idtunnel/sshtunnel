#!/bin/bash
#Script auto create user SSH
#Script by admin@white-vps.com

read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif

IP=`dig +short myip.opendns.com @resolver1.opendns.com`
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "Informasi SSH"
echo -e "=========-account-=========="
echo -e "Host          : $IP"
echo -e "Username      : $Login "
echo -e "Password      : $Pass"
echo -e "Openssh       : 22,143"
echo -e "Dropebear     : 109,456"
echo -e "SSL/TLS       : 443"
echo -e "Squid         : 8080,3128,80"
echo -e "Config OpenVPN: http://$IP:81/client-tcp-2200.ovpn"
echo -e "Config OpenVPN: http://$IP:81/client-udp-2200.ovpn"
echo -e "-----------------------------"
echo -e "Aktif Sampai  : $exp"
echo -e "==========================="
echo -e "Copyright @ Team white-vps "
