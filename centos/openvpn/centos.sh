#!/bin/bash
# Centos 6 64bit ( TCP dan UDP : 992 & 2200 )
# Original script by white-vps
# Mod by hidessh
# ==================================================

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";

# Install terlebih dahulu paket-paket berikut ini
yum install wget
yum install gcc make rpm-build autoconf.noarch zlib-devel pam-devel openssl-devel -y
wget http://mirror.centos.org/centos/6/os/x86_64/Packages/lzo-2.03-3.1.el6_5.1.x86_64.rpm
wget http://vault.centos.org/6.10/os/Source/SPackages/lzo-2.03-3.1.el6_5.1.src.rpm

# setting repo centos 64bit
wget https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
rpm -Uvh epel-release-6-8.noarch.rpm && rpm -Uvh remi-release-6.rpm

# setting repo centos 32bit
# wget http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
# rpm -Uvh epel-release-6-8.noarch.rpm && rpm -Uvh remi-release-6.rpm

# Build paket RPM
rpmbuild --rebuild lzo-2.03-3.1.el6_5.1.src.rpm
rpm -Uvh lzo-*.rpm
rpm -Uvh rpmforge-release*

# install essential package
yum -y install screen vnstat git unrar unzip nano cmake make

# matiin exim
service exim stop
chkconfig exim off

# setting vnstat
vnstat -u -i eth0
echo "MAILTO=root" > /etc/cron.d/vnstat
echo "*/5 * * * * root /usr/sbin/vnstat.cron" >> /etc/cron.d/vnstat
service vnstat restart
chkconfig vnstat on

# install neofetch centos 6 64bit
git clone https://github.com/dylanaraps/neofetch
cd neofetch
make install
make PREFIX=/usr/local install
make PREFIX=/boot/home/config/non-packaged install
make -i install
cd
echo "clear" >> .bash_profile
echo "neofetch" >> .bash_profile

# Install OpenVPN, OpenSSL dan nano text editor
yum update -y
yum install openvpn -y
yum install easy-rsa -y
cp -R /usr/share/doc/openvpn-2.2.2/easy-rsa/ /etc/openvpn/

# konfigurasi OpenVPN pada VPS Centos server TCP 992
cat > /etc/openvpn/server-tcp-992.conf <<-END
port 992
proto tcp
dev tun
tun-mtu 1500
tun-mtu-extra 32
mssfix 1450
ca /etc/openvpn/ca.crt
cert /etc/openvpn/server.crt
key /etc/openvpn/server.key
dh /etc/openvpn/dh2048.pem
plugin /usr/lib/openvpn/plugins/openvpn-plugin-auth-pam.so /etc/pam.d/login
client-cert-not-required
username-as-common-name
server 10.8.0.0 255.255.255.0
#ifconfig-pool-persist ipp.txt
push "redirect-gateway def1"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
push "route-method exe"
push "route-delay 2"
keepalive 5 30
cipher AES-128-CBC
comp-lzo
persist-key
persist-tun
status server-tcp-992.log
verb 3
END

cd

# konfigurasi OpenVPN pada VPS Centos server UDP 992

cat > /etc/openvpn/server-udp-992.conf <<-END
port 992
proto udp
dev tun
tun-mtu 1500
tun-mtu-extra 32
mssfix 1450
ca /etc/openvpn/ca.crt
cert /etc/openvpn/server.crt
key /etc/openvpn/server.key
dh /etc/openvpn/dh2048.pem
plugin /usr/lib/openvpn/plugins/openvpn-plugin-auth-pam.so /etc/pam.d/login
client-cert-not-required
username-as-common-name
server 10.9.0.0 255.255.255.0
#ifconfig-pool-persist ipp.txt
push "redirect-gateway def1"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
push "route-method exe"
push "route-delay 2"
keepalive 5 30
cipher AES-128-CBC
comp-lzo
persist-key
persist-tun
status server-udp-992.log
verb 3
END

cd

# konfigurasi OpenVPN pada VPS Centos server TCP 2200

cat > /etc/openvpn/server-tcp-2200.conf <<-END
port 2200
proto tcp
dev tun
tun-mtu 1500
tun-mtu-extra 32
mssfix 1450
ca /etc/openvpn/ca.crt
cert /etc/openvpn/server.crt
key /etc/openvpn/server.key
dh /etc/openvpn/dh2048.pem
plugin /usr/lib/openvpn/plugins/openvpn-plugin-auth-pam.so /etc/pam.d/login
client-cert-not-required
username-as-common-name
server 10.6.0.0 255.255.255.0
#ifconfig-pool-persist ipp.txt
push "redirect-gateway def1"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
push "route-method exe"
push "route-delay 2"
keepalive 5 30
cipher AES-128-CBC
comp-lzo
persist-key
persist-tun
status server-tcp-2200.log
verb 3
END

cd

# konfigurasi OpenVPN pada VPS Centos server UDP 2200

cat > /etc/openvpn/server-udp-2200.conf <<-END
port 2200
proto udp
dev tun
tun-mtu 1500
tun-mtu-extra 32
mssfix 1450
ca /etc/openvpn/ca.crt
cert /etc/openvpn/server.crt
key /etc/openvpn/server.key
dh /etc/openvpn/dh2048.pem
plugin /usr/lib/openvpn/plugins/openvpn-plugin-auth-pam.so /etc/pam.d/login
client-cert-not-required
username-as-common-name
server 10.7.0.0 255.255.255.0
#ifconfig-pool-persist ipp.txt
push "redirect-gateway def1"
push "dhcp-option DNS 8.8.8.8"
push "dhcp-option DNS 8.8.4.4"
push "route-method exe"
push "route-delay 2"
keepalive 5 30
cipher AES-128-CBC
comp-lzo
persist-key
persist-tun
status server-udp-2200.log
verb 3
END

cd

# Directory Centos 6 X64 (64 bit)
mkdir -p /usr/lib/openvpn/plugins/
cp /usr/lib64/openvpn/plugin/lib/openvpn-auth-pam.so /usr/lib/openvpn/plugins/openvpn-plugin-auth-pam.so

# Download EasyRSA untuk generate key dan certificate
wget --no-check-certificate -O ~/easy-rsa.tar.gz https://github.com/OpenVPN/easy-rsa/archive/2.2.2.tar.gz
tar xzf ~/easy-rsa.tar.gz -C ~/
mkdir -p /etc/openvpn/easy-rsa/2.0/ && cp ~/easy-rsa-2.2.2/easy-rsa/2.0/* /etc/openvpn/easy-rsa/2.0/
cp -u -p /etc/openvpn/easy-rsa/2.0/openssl-1.0.0.cnf /etc/openvpn/easy-rsa/2.0/openssl.cnf
rm -rf ~/easy-rsa-2.2.2 && rm -rf ~/easy-rsa.tar.gz

# Masuk ke directory Easy-RSA & Buat certificate
cd /etc/openvpn/easy-rsa/2.0/
wget -O /etc/openvpn/easy-rsa/2.0/vars "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/centos/openvpn/vars.conf"

# eksekusi vars
source ./vars

# Build all
. /etc/openvpn/easy-rsa/2.0/clean-all

# Build CA
. /etc/openvpn/easy-rsa/2.0/build-ca

# buat key server
. /etc/openvpn/easy-rsa/2.0/build-key-server server

# buat key client
. /etc/openvpn/easy-rsa/2.0/build-key client

# Buat key Diffie Hellman
. /etc/openvpn/easy-rsa/2.0/build-dh

# back to root
cd

# copy semua file yang telah dibuat ke direktori instalasi OpenVPN sehingga dapat terbaca OpenVPN
cd /etc/openvpn/easy-rsa/2.0/keys
cp ca.crt ca.key dh2048.pem server.crt server.key /etc/openvpn

# Set agar OpenVPN otomatis menyala saat VPS direstart
chkconfig openvpn on && service openvpn start

# Set ipv4 public forward
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.d/rc.local
sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/sysctl.conf
chmod +x /etc/sysctl.conf

# initial IP address
MYIP=`curl icanhazip.com`;
MYIP2="s/xxxxxxxxx/$MYIP/g";

# Set IPTABLES Centos 6 32bit
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -I POSTROUTING -s 10.6.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -I POSTROUTING -s 10.7.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -I POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
iptables -t nat -I POSTROUTING -s 10.9.0.0/24 -o eth0 -j MASQUERADE
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 992 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 992 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 2200 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 2200 -j ACCEPT
iptables -A INPUT -i tun+ -j ACCEPT
iptables -A FORWARD -i tun+ -j ACCEPT
iptables -A FORWARD -i tun+ -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0 -o tun+ -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.6.0.0/24 -o eth0 -j SNAT --to xxxxxxxxx
iptables -t nat -A POSTROUTING -s 10.7.0.0/24 -o eth0 -j SNAT --to xxxxxxxxx
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j SNAT --to xxxxxxxxx
iptables -t nat -A POSTROUTING -s 10.9.0.0/24 -o eth0 -j SNAT --to xxxxxxxxx
iptables -A OUTPUT -o tun+ -j ACCEPT

# Save & restore IPTABLES Centos 6 64bit
service iptables save
sed -i $MYIP2 /etc/sysconfig/iptables;
cp /etc/sysconfig/iptables /etc/iptables.up.rules
chmod +x /etc/iptables.up.rules

# Restart openvpn
service openvpn restart
chkconfig openvpn on
cd

# set iptables tambahan
iptables -F -t nat
iptables -X -t nat
iptables -A POSTROUTING -t nat -j MASQUERADE
iptables-save > /etc/iptables-opvpn.conf
chmod +x /etc/iptables-opvpn.conf

# buat config untuk client
mkdir -p /home/vps/public_html

# Configurasi openvpn Client TCP 992
cat > /etc/openvpn/client-tcp-992.ovpn <<-END
##### WELCOME TO HIDESSH #####
##### WWW.HIDESSH.COM #####
##### DONT FORGET TO SUPPORT US #####
client
dev tun
proto tcp
remote xxxxxxxxx 992
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END

sed -i $MYIP2 /etc/openvpn/client-tcp-992.ovpn;

# Configurasi openvpn Client UDP 992
cat > /etc/openvpn/client-udp-992.ovpn <<-END
##### WELCOME TO HIDESSH #####
##### WWW.HIDESSH.COM #####
##### DONT FORGET TO SUPPORT US #####
client
dev tun
proto udp
remote xxxxxxxxx 992
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END

sed -i $MYIP2 /etc/openvpn/client-udp-992.ovpn;

# Configurasi openvpn Client TCP 2200
cat > /etc/openvpn/client-tcp-2200.ovpn <<-END
##### WELCOME TO HIDESSH #####
##### WWW.HIDESSH.COM #####
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

sed -i $MYIP2 /etc/openvpn/client-tcp-2200.ovpn;

# Configurasi openvpn Client UDP 2200
cat > /etc/openvpn/client-udp-2200.ovpn <<-END
##### WELCOME TO HIDESSH #####
##### WWW.HIDESSH.COM #####
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

# masukkan certificatenya ke dalam config client TCP 992
echo '<ca>' >> /etc/openvpn/client-tcp-992.ovpn
cat /etc/openvpn/ca.crt >> /etc/openvpn/client-tcp-992.ovpn
echo '</ca>' >> /etc/openvpn/client-tcp-992.ovpn

# masukkan certificatenya ke dalam config client UDP 992
echo '<ca>' >> /etc/openvpn/client-udp-992.ovpn
cat /etc/openvpn/ca.crt >> /etc/openvpn/client-udp-992.ovpn
echo '</ca>' >> /etc/openvpn/client-udp-992.ovpn

# Copy config OpenVPN client ke home directory root agar mudah didownload ( TCP 992 )
cp /etc/openvpn/client-tcp-992.ovpn /root/client-tcp-992.ovpn

# Copy config OpenVPN client ke home directory root agar mudah didownload ( UDP 992 )
cp /etc/openvpn/client-udp-992.ovpn /root/client-udp-992.ovpn

# masukkan certificatenya ke dalam config client ( TCP 2200 )
echo '<ca>' >> /etc/openvpn/client-tcp-2200.ovpn
cat /etc/openvpn/ca.crt >> /etc/openvpn/client-tcp-2200.ovpn
echo '</ca>' >> /etc/openvpn/client-tcp-2200.ovpn

# masukkan certificatenya ke dalam config client ( UDP 2200 )
echo '<ca>' >> /etc/openvpn/client-udp-2200.ovpn
cat /etc/openvpn/ca.crt >> /etc/openvpn/client-udp-2200.ovpn
echo '</ca>' >> /etc/openvpn/client-udp-2200.ovpn

# Copy config OpenVPN client ke home directory root agar mudah didownload ( TCP 2200 )
cp /etc/openvpn/client-tcp-2200.ovpn /root/client-tcp-2200.ovpn

# Copy config OpenVPN client ke home directory root agar mudah didownload ( UDP 2200 )
cp /etc/openvpn/client-udp-2200.ovpn /root/client-udp-2200.ovpn

# Simple password user
wget -O /etc/pam.d/system-auth "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/centos/pwd-vultr"
chmod +x /etc/pam.d/system-auth

# install squid
yum -y install squid
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/centos/squid-centos.conf"
sed -i $MYIP2 /etc/squid/squid.conf;
service squid restart
chkconfig squid on

# downlaod script
cd /usr/bin
wget -O speedtest "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/centos/speedtest_cli.py"
wget -O bench "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/centos/bench-network.sh"
wget -O mem "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/centos/ps_mem.py"
wget -O loginuser "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/centos/login.sh"
wget -O userlogin "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/centos/user-login.sh"
wget -O userexpire "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/centos/autoexpire.sh"
wget -O usernew "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/centos/create-user.sh"
wget -O renew "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/centos/user-renew.sh"
wget -O userlist "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/centos/user-list.sh" 
wget -O trial "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/centos/user-trial.sh"
wget -O jurus69 "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/centos/restart.sh"
wget -O delete "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/centos/expired.sh"
echo "cat log-install.txt" | tee info

# sett permission
chmod +x userlogin
chmod +x loginuser
chmod +x userexpire
chmod +x usernew
chmod +x renew
chmod +x userlist
chmod +x trial
chmod +x jurus69
chmod +x info
chmod +x speedtest
chmod +x bench
chmod +x mem
chmod +x delete

# cron
cd
service crond start
chkconfig crond on
service crond stop

cat > /etc/crontab <<-END
0 */6 * * * /usr/bin/jurus69
END

cd 

chmod +x /etc/crontab

# set time GMT +7
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Membuat user SSH baru dengan home directory tanpa akses shell
useradd -m -s /bin/false white-vps

# Setelah membuat username SSH, kita harus memberikan password kepada user tersebut
passwd white-vps

# menghapus user SSH/OpenVPN
# userdel USERNAME

# restart openvpn dan iptables centos 6 64bit
service iptables restart
service network restart
service openvpn restart
chkconfig openvpn on

# hapus autoscript insaller
rm -f /root/centos.sh
