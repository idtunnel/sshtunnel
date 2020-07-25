#!/bin/bash
#created : HideSSH
# Debian 9 dan wireguard

#Update Server
apt-get update -y && apt-get upgrade -y

#install WG
wget -O install-wireguard-engine "https://www.dropbox.com/s/3kg8d3qaot85pl6/install-wireguard-engine?dl=1" && chmod +x install-wireguard-engine && ./install-wireguard-engine
