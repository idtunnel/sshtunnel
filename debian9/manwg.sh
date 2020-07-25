#!/bin/bash
#created : HideSSH

# set time GMT +7 jakarta
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

#rertart server 00:00
cd
echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot


#auto deleted rules Password linux 
wget -O /etc/pam.d/common-password "https://raw.githubusercontent.com/idtunnel/sshtunnel/master/debian9/common-password-deb9"
chmod +x /etc/pam.d/common-password

#manajemen akun WG
wget -O install-wireguard "https://www.dropbox.com/s/p89ubjpypmk26rv/install-wireguard?dl=1" && chmod +x install-wireguard && ./install-wireguard


