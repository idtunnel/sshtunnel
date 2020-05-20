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

#squid
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 8888 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 8888 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 3128 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 3128 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 4343 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 4343 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 9090 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 9090 -j ACCEPT

#stunnel
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 777 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 777 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 444 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 444 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 222 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 222 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 443 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 443 -j ACCEPT

#ssh
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 22 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 143 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 143 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 44 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 44 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 77 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 77 -j ACCEPT

#lain nya
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 9000 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 9000 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 10000 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 10000 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 81 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 81 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 80 -j ACCEPT
iptables -A INPUT -i eth0 -m state --state NEW -p tcp --dport 80 -j ACCEPT


#simpan iptunnel
service iptables save
