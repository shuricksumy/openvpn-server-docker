#!/bin/bash

export DOCKER_COMMAND="2"

#export ENDPOINT="192.192.192.192" #experiment
#export IPV6_SUPPORT="n"
#export PORT_CHOICE="1" #PORT="1194"
#export PROTOCOL_CHOICE="1" #PROTOCOL="udp"
#export DNS="11" #11) AdGuard DNS (Anycast: worldwide)"
#export COMPRESSION_ENABLED="n"
#export CUSTOMIZE_ENC="y"
#export CIPHER_CHOICE="1" #CIPHER="AES-128-GCM"
#export CERT_TYPE="1" # 1) ECDSA"
#export CERT_CURVE_CHOICE="1" #CERT_CURVE="prime256v1"
#export CC_CIPHER_CHOICE="1" #CC_CIPHER="TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256"
#export DH_TYPE="1" #1) ECDH
#export DH_CURVE_CHOICE="1" #DH_CURVE="prime256v1"
#export HMAC_ALG_CHOICE="1" #1) SHA-256
#export TLS_SIG="2" #2) tls-auth"


if [[ ! -e /etc/openvpn/server.conf ]]; then
        echo "Waiting for the good weather... ;)"
        sleep $((1 + $RANDOM % 15))
        bash /opt/openvpn-install-v2.sh
        echo "" > /etc/openvpn/.provisioned
        echo "    --= SETUP IS DONE ==-"
fi

## Regenerate and firewall rules to get Internet from internal openvpn network
## if [[ ! -f /etc/openvpn/set_fw.sh ]]; then 
##     export DOCKER_COMMAND="5"
##     bash /opt/openvpn-install-v2.sh
## fi 

# Apply FireWall rules
if [[ -f /etc/openvpn/set_fw.sh ]]; then 
     bash /etc/openvpn/set_fw.sh
fi

/usr/sbin/openvpn --status /run/openvpn/server.status 10 --cd /etc/openvpn --config /etc/openvpn/server.conf