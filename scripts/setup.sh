#!/bin/bash

export DOCKER_COMMAND="2"

if [[ ! -e /etc/openvpn/server.conf ]]; then
        echo "Waiting for the good weather... ;)"
        sleep $((1 + $RANDOM % 15))
        bash /opt/openvpn-install-v2.sh
        echo "" > /etc/openvpn/.provisioned
        echo "    --= SETUP IS DONE ==-"
fi

# Apply FireWall rules
if [[ -f /etc/openvpn/set_fw.sh ]]; then 
     bash /etc/openvpn/set_fw.sh
fi

/usr/sbin/openvpn --status /run/openvpn/server.status 10 --cd /etc/openvpn --config /etc/openvpn/server.conf