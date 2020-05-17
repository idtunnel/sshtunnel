/etc/init.d/nginx restart
/etc/init.d/php-fpm restart
/etc/init.d/vnstat restart
/etc/init.d/snmpd restart
/etc/init.d/sshd restart
/etc/init.d/dropbear restart
service stunnel start
/etc/init.d/squid start
/etc/init.d/webmin restart
/etc/init.d/fail2ban restart
/etc/init.d/crond restart
service iptables restart
badvpn-udpgw --listen-addr 127.0.0.1:7300 > /dev/null &
badvpn-udpgw --listen-addr 127.0.0.1:7200 > /dev/null &
