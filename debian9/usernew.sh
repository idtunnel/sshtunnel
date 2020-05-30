# !/bin/bash
# Script auto create user SSH

read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif

IP=`curl icanhazip.com`
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
echo -e ""
echo -e "====Informasi SSH Account===="
echo -e "Host              : $IP" 
echo -e "Port OpenSSH      : 22,143"
echo -e "Dropebear         : 44,77"
echo -e "SSL/TLS           : 443,222,777,444"
echo -e "Squid             : 8888,3128,9090,4343"
echo -e "Username          : $Login "
echo -e "Password          : $Pass"
echo -e "-----------------------------"
echo -e "Aktif Sampai      : $exp"
echo -e "Config OpenVPN TCP (ORI): http://$IP:81/client-tcp-1194.ovpn"
echo -e "Config OpenVPN TCP (modif): http://$IP:81/client-tcp-2200.ovpn"
echo -e "Config OpenVPN UDP: http://$IP:81/client-udp-2200.ovpn"
echo -e "============================="

echo -e "Mod by HideSSH.com"
echo -e ""
