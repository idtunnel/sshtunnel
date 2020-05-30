#!/bin/bash
#
# Original script by fornesia, rzengineer and fawzya
# Mod by admin Hidessh
# ==================================================

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# update repository
apt update -y

# Install PHP 5.6
apt-get install sudo -y
usermod -aG sudo root

sudo apt -y install ca-certificates apt-transport-https
wget -q https://packages.sury.org/php/apt.gpg -O- | sudo apt-key add -
echo "deb https://packages.sury.org/php/ stretch main" | sudo tee /etc/apt/sources.list.d/php.list

sudo apt update -y
sudo apt install php5.6 -y
sudo apt install php5.6-mcrypt php5.6-mysql php5.6-fpm php5.6-cli php5.6-common php5.6-curl php5.6-mbstring php5.6-mysqlnd php5.6-xml -y

# install webserver
cd
sudo apt-get -y install nginx
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/debian9/nginx-default.conf"
mkdir -p /home/vps/public_html
echo "<?php phpinfo() ?>" > /home/vps/public_html/info.php
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/debian9/vhost-nginx.conf"
/etc/init.d/nginx restart

# instal nginx php5.6 
apt-get -y install nginx php5.6-fpm
apt-get -y install nginx php5.6-cli
apt-get -y install nginx php5.6-mysql
apt-get -y install nginx php5.6-mcrypt
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/5.6/cli/php.ini

# cari config php fpm dengan perintah berikut "php --ini |grep Loaded"
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/5.6/cli/php.ini

# Cari config php fpm www.conf dengan perintah berikut "find / \( -iname "php.ini" -o -name "www.conf" \)"
sed -i 's/listen = \/run\/php\/php5.6-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/5.6/fpm/pool.d/www.conf
cd


# Edit port apache2 ke 8090
wget -O /etc/apache2/ports.conf "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/debian9/apache2.conf"

# Edit port virtualhost apache2 ke 8090
wget -O /etc/apache2/sites-enabled/000-default.conf "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/debian9/virtualhost.conf"

# restart apache2
/etc/init.d/apache2 restart

# Install OpenVPN dan Easy-RSA
apt install openvpn easy-rsa -y
apt install openssl iptables -y 

# copykan script generate Easy-RSA ke direktori OpenVPN
cp -r /usr/share/easy-rsa/ /etc/openvpn

# Buat direktori baru untuk easy-rsa keys
mkdir /etc/openvpn/easy-rsa/keys

# Kemudian edit file variabel easy-rsa
# nano /etc/openvpn/easy-rsa/vars
wget -O /etc/openvpn/easy-rsa/vars "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/debian9/vars.conf"
# edit projek export KEY_NAME="white-vps"
# Save dan keluar dari editor

# generate Diffie hellman parameters
openssl dhparam -out /etc/openvpn/dh2048.pem 2048

# inialisasikan Public Key
cd /etc/openvpn/easy-rsa

# inialisasikan openssl.cnf
ln -s openssl-1.0.0.cnf openssl.cnf
echo "unique_subject = no" >> keys/index.txt.attr

# inialisasikan vars
. ./vars

# inialisasikan Public clean all
./clean-all

# Certificate Authority (CA)
./build-ca

# buat server key name yang telah kita buat sebelum nya yakni "white-vps"
./build-key-server white-vps

# generate ta.key
openvpn --genkey --secret keys/ta.key

# Buat config server UDP 1194
cd /etc/openvpn

cat > /etc/openvpn/server-udp-1194.conf <<-END
port 1194
proto udp
dev tun
ca easy-rsa/keys/ca.crt
cert easy-rsa/keys/white-vps.crt
key easy-rsa/keys/white-vps.key
dh dh2048.pem
plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login
client-cert-not-required
username-as-common-name
server 10.5.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
keepalive 5 30
comp-lzo
persist-key
persist-tun
status server-udp-1194.log
verb 3
END

# Buat config server TCP 1194
cat > /etc/openvpn/server-tcp-1194.conf <<-END
port 1194
proto tcp
dev tun
ca easy-rsa/keys/ca.crt
cert easy-rsa/keys/white-vps.crt
key easy-rsa/keys/white-vps.key
dh dh2048.pem
plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login
client-cert-not-required
username-as-common-name
server 10.6.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
keepalive 5 30
comp-lzo
persist-key
persist-tun
status server-tcp-1194.log
verb 3
END

# Buat config server UDP 2200
cat > /etc/openvpn/server-udp-2200.conf <<-END
port 2200
proto udp
dev tun
ca easy-rsa/keys/ca.crt
cert easy-rsa/keys/white-vps.crt
key easy-rsa/keys/white-vps.key
dh dh2048.pem
plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login
client-cert-not-required
username-as-common-name
server 10.7.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
keepalive 5 30
comp-lzo
persist-key
persist-tun
status server-udp-2200.log
verb 3
END

# Buat config server TCP 2200
cat > /etc/openvpn/server-tcp-2200.conf <<-END
port 2200
proto tcp
dev tun
ca easy-rsa/keys/ca.crt
cert easy-rsa/keys/white-vps.crt
key easy-rsa/keys/white-vps.key
dh dh2048.pem
plugin /usr/lib/openvpn/openvpn-plugin-auth-pam.so login
client-cert-not-required
username-as-common-name
server 10.8.0.0 255.255.255.0
ifconfig-pool-persist ipp.txt
push "redirect-gateway def1"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
keepalive 5 30
comp-lzo
persist-key
persist-tun
status server-tcp-2200.log
verb 3
END

cd

cp /etc/openvpn/easy-rsa/keys/{white-vps.crt,white-vps.key,ca.crt,ta.key} /etc/openvpn
ls /etc/openvpn

# nano /etc/default/openvpn
sed -i 's/#AUTOSTART="all"/AUTOSTART="all"/g' /etc/default/openvpn
# Cari pada baris #AUTOSTART=”all” hilangkan tanda pagar # didepannya sehingga menjadi AUTOSTART=”all”. Save dan keluar dari editor

# restart openvpn dan cek status openvpn
/etc/init.d/openvpn restart
/etc/init.d/openvpn status

# aktifkan ip4 forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
# edit file sysctl.conf
# nano /etc/sysctl.conf
# Uncomment hilangkan tanda pagar pada #net.ipv4.ip_forward=1

# Konfigurasi dan Setting untuk Client
mkdir clientconfig
cp /etc/openvpn/easy-rsa/keys/{white-vps.crt,white-vps.key,ca.crt,ta.key} clientconfig/
cd clientconfig

# Buat config client UDP 1194
cd /etc/openvpn
cat > /etc/openvpn/client-udp-1194.ovpn <<-END
##### WELCOME TO HideSSH #####
##### WWW.HideSSH.COM #####
##### DONT FORGET TO SUPPORT US #####
client
dev tun
proto udp
remote xxxxxxxxx 1194
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END

sed -i $MYIP2 /etc/openvpn/client-udp-1194.ovpn;

# Buat config client TCP 1194
cat > /etc/openvpn/client-tcp-1194.ovpn <<-END
##### WELCOME TO HideSSH #####
##### WWW.HideSSHSSH.COM #####
##### DONT FORGET TO SUPPORT US #####
client
dev tun
proto tcp
remote xxxxxxxxx 1194
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END

sed -i $MYIP2 /etc/openvpn/client-tcp-1194.ovpn;

# Buat config client UDP 2200
cat > /etc/openvpn/client-udp-2200.ovpn <<-END
##### WELCOME TO HideSSH #####
##### WWW.HideSSH.COM #####
##### DONT FORGET TO SUPPORT US #####
client
dev tun
proto udp
remote xxxxxxxxx 2200
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END

sed -i $MYIP2 /etc/openvpn/client-udp-2200.ovpn;

# Buat config client TCP 2200
cat > /etc/openvpn/client-tcp-2200.ovpn <<-END
##### WELCOME TO HideSSH #####
##### WWW.HideSSH.COM #####
##### DONT FORGET TO SUPPORT US #####
client
dev tun
proto tcp
remote xxxxxxxxx 2200
##### Modification VPN #####
http-proxy-retry
http-proxy xxxxxxxxx 3128
http-proxy-option CUSTOM-HEADER Host google.com
##### DONT FORGET TO SUPPORT US #####
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END

cd

sed -i $MYIP2 /etc/openvpn/client-tcp-2200.ovpn;

# pada tulisan xxx ganti dengan alamat ip address VPS anda 
/etc/init.d/openvpn restart

# masukkan certificatenya ke dalam config client TCP 1194
echo '<ca>' >> /etc/openvpn/client-tcp-1194.ovpn
cat /etc/openvpn/ca.crt >> /etc/openvpn/client-tcp-1194.ovpn
echo '</ca>' >> /etc/openvpn/client-tcp-1194.ovpn

# masukkan certificatenya ke dalam config client UDP 1194
echo '<ca>' >> /etc/openvpn/client-udp-1194.ovpn
cat /etc/openvpn/ca.crt >> /etc/openvpn/client-udp-1194.ovpn
echo '</ca>' >> /etc/openvpn/client-udp-1194.ovpn

# Copy config OpenVPN client ke home directory root agar mudah didownload ( TCP 1194 )
cp /etc/openvpn/client-tcp-1194.ovpn /home/vps/public_html/client-tcp-1194.ovpn

# Copy config OpenVPN client ke home directory root agar mudah didownload ( UDP 1194 )
cp /etc/openvpn/client-udp-1194.ovpn /home/vps/public_html/client-udp-1194.ovpn

# masukkan certificatenya ke dalam config client TCP 2200
echo '<ca>' >> /etc/openvpn/client-tcp-2200.ovpn
cat /etc/openvpn/ca.crt >> /etc/openvpn/client-tcp-2200.ovpn
echo '</ca>' >> /etc/openvpn/client-tcp-2200.ovpn

# masukkan certificatenya ke dalam config client UDP 2200
echo '<ca>' >> /etc/openvpn/client-udp-2200.ovpn
cat /etc/openvpn/ca.crt >> /etc/openvpn/client-udp-2200.ovpn
echo '</ca>' >> /etc/openvpn/client-udp-2200.ovpn

# Copy config OpenVPN client ke home directory root agar mudah didownload ( TCP 2200 )
cp /etc/openvpn/client-tcp-2200.ovpn /home/vps/public_html/client-tcp-2200.ovpn

# Copy config OpenVPN client ke home directory root agar mudah didownload ( UDP 2200 )
cp /etc/openvpn/client-udp-2200.ovpn /home/vps/public_html/client-udp-2200.ovpn


# iptables-persistent
apt install iptables-persistent -y

# firewall untuk memperbolehkan akses UDP dan akses jalur TCP

iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -I POSTROUTING -s 10.5.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -I POSTROUTING -s 10.6.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -I POSTROUTING -s 10.7.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -I POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE

iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 3306 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 7300 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 7300 -j ACCEPT

iptables -t nat -I POSTROUTING -s 10.5.0.0/24 -o ens3 -j MASQUERADE
iptables -t nat -I POSTROUTING -s 10.6.0.0/24 -o ens3 -j MASQUERADE
iptables -t nat -I POSTROUTING -s 10.7.0.0/24 -o ens3 -j MASQUERADE
iptables -t nat -I POSTROUTING -s 10.8.0.0/24 -o ens3 -j MASQUERADE

iptables-save > /etc/iptables/rules.v4
chmod +x /etc/iptables/rules.v4

# Reload IPTables
iptables-restore -t < /etc/iptables/rules.v4
netfilter-persistent save
netfilter-persistent reload

# Restart service openvpn
systemctl enable openvpn
systemctl start openvpn
/etc/init.d/openvpn restart

# set iptables tambahan
iptables -F -t nat
iptables -X -t nat
iptables -A POSTROUTING -t nat -j MASQUERADE
iptables-save > /etc/iptables-opvpn.conf

# Restore iptables
wget -O /etc/network/if-up.d/iptables "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/debian9/iptables-local"
chmod +x /etc/network/if-up.d/iptables

# Restore iptables rc.local
# wget -O /etc/rc.local "https://raw.githubusercontent.com/whitevps2/sshtunnel/master/debian9/iptables-openvpn"
# chmod +x /etc/rc.local

# restart opevpn
/etc/init.d/openvpn restart

# Delete script
rm -f /root/openvpn.sh

