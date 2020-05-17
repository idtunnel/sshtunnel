* Setting Crontab 
```
$ export VISUAL=nano; crontab -e
$ 0 0,12,18 * * * /sbin/shutdown -r now >> auto reboot pukul 00:00,12:00,18:00 WIB
```
* SETUP SSH & VPN Debian 8 Terbaru
--------
```
$ wget https://raw.githubusercontent.com/whitevps2/sshtunnel/master/ssh-vpn-debian8.sh && chmod +x ssh-vpn-debian8.sh && bash ssh-vpn-debian8.sh
```

* SETUP OpenVPN OS Centos 6 32 / 64 bit ( TCP & UDP port 1194 & 443 ) Fixed work
--------
```
$ wget https://raw.githubusercontent.com/whitevps2/sshtunnel/master/openvpn-centos6-64bit.sh && chmod +x openvpn-centos6-64bit.sh && bash openvpn-centos6-64bit.sh
```
* SETUP SSH,VPN,SSL/TLS OS Debian 8 32 / 64 bit
--------
```
$ wget https://raw.githubusercontent.com/whitevps2/sshtunnel/master/debian7.sh && chmod +x debian7.sh && ./debian7.sh
```
* SETUP SSH,VPN,SSL/TLS OS UBUNTU 16.04 64bit terbaru
--------
```
$ wget https://raw.githubusercontent.com/whitevps2/sshtunnel/master/ubuntu.sh && chmod +x ubuntu.sh && ./ubuntu.sh
```
* SETUP SSH,VPN,SSL/TLS OS Debian 8 32 / 64 bit
--------
```
$ wget https://raw.githubusercontent.com/whitevps2/sshtunnel/master/deb8.sh && chmod +x deb8.sh && ./deb8.sh
```
* SETUP SSH,VPN,SSL/TLS OS debian9 terbaru
--------
```
$ wget https://raw.githubusercontent.com/whitevps2/sshtunnel/master/debian9.sh && chmod +x debian9.sh && ./debian9.sh
```
* SETUP OpenVPN OS Ubuntu 16.04 32 / 64 bit
--------
```
$ wget https://raw.githubusercontent.com/whitevps2/sshtunnel/master/vpn-ubuntu.sh && chmod +x vpn-ubuntu.sh && bash vpn-ubuntu.sh
```
* SETUP OpenVPN OS debian 8 32 / 64 bit
--------
```
$ wget https://raw.githubusercontent.com/whitevps2/sshtunnel/master/vpn-deb8.sh && chmod +x vpn-deb8.sh && bash vpn-deb8.sh
```
* SETUP OpenVPN OS debian 9 32 / 64 bit
--------
```
$ wget https://raw.githubusercontent.com/whitevps2/sshtunnel/master/vpn-deb9.sh && chmod +x vpn-deb9.sh && bash vpn-deb9.sh
```
* SETUP OpenVPN OS Centos 6 32 / 64 bit ( TCP & UDP port 1194 & 443 )
--------
```
$ wget https://raw.githubusercontent.com/whitevps2/sshtunnel/master/vpn-centos6.sh && chmod +x vpn-centos6.sh && bash vpn-centos6.sh
```
* SETUP OpenVPN OS Centos 6 32 / 64 bit ( TCP & UDP port 80 & 8080 )
--------
```
$ wget https://raw.githubusercontent.com/whitevps2/sshtunnel/master/vpn-centos.sh && chmod +x vpn-centos.sh && bash vpn-centos.sh
```
* Setup mysql-php-nginx debian 8 32 / 64 bit
--------

```
$ wget https://raw.githubusercontent.com/lenovo9/panel-ocs/master/deb8-mysql.sh && chmod +x deb8-mysql.sh && ./deb8-mysql.sh

++ Buat password mysql ( password harus di ingat karena saat set OCS mesti input ulang password mysql )
++ Test php info via website : http://ip-vps:81/info.php atau http://ip-vps:81/info.php
```
* Setup OCS PANEL debian 8 32 / 64 bit
--------

```
wget https://raw.githubusercontent.com/whitevps2/sshtunnel/master/deb8-ocspanel.sh && chmod +x deb8-ocspanel.sh && ./deb8-ocspanel.sh
```
* Setting OCS panel ( cara setting belum di update )
--------

```
# Masukan password mysql lalu isi file database di bawah ini
# Database mysql :
# CREATE DATABASE IF NOT EXISTS OCSPANEL;EXIT;


setting database admin OCS PANEL via website
============================================
# http://IP_VPS:81/
# Lakukan setting seperti berikut:

# DATABASE
# Database Host: localhost (WAJIB!)
# Database Name: OCSPANEL (WAJIB!)
# Database User: root (WAJIB!) 
# Database Pass: Password MySQL yang telah dibuat tadi

# ADMIN LOGIN
# Username: admin (WAJIB!)
# Password Baru: (WAJIB!) Isikan dengan password root vps bukan pass mysql
# Masukkan Ulang Password: Input ulang password
# Selesai,lalu hapus history istallasi ocs dengan command di bawah ini
# rm -R /home/vps/public_html/installation
# cp client.ovpn /home/vps/public_html/
```

