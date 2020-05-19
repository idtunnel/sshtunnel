#squid
iptables -A INPUT -p tcp --dport 8888 -j ACCEPT
iptables -A INPUT -p tcp --dport 3128 -j ACCEPT
iptables -A INPUT -p tcp --dport 4343 -j ACCEPT
iptables -A INPUT -p tcp --dport 9090 -j ACCEPT

#stunnel
iptables -A INPUT -p tcp --dport 777 -j ACCEPT
iptables -A INPUT -p tcp --dport 444 -j ACCEPT
iptables -A INPUT -p tcp --dport 222 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

#ssh
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 143 -j ACCEPT
iptables -A INPUT -p tcp --dport 44 -j ACCEPT
iptables -A INPUT -p tcp --dport 77 -j ACCEPT

#lain nya
iptables -A INPUT -p tcp --dport 10000 -j ACCEPT
iptables -A INPUT -p tcp --dport 9000 -j ACCEPT
iptables -A INPUT -p tcp --dport 81 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

#simpan iptunnel
service iptables save
