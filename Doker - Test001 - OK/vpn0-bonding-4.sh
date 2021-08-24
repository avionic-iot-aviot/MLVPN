#!/bin/bash

error=0 trap "error=$((error|1))" ERR
tuntap_intf="$1"
newstatus="$2"
rtun="$3"

#echo 'prima'
#echo 'tuntap_intf: $1'
#echo 'newstatus: $2'
#echo 'rtun: $3'
#echo 'dopo'

[ -z "$newstatus" ] && exit 1

(
#echo "tuntap_intf: $1"
#echo "newstatus: $2"
#echo "rtun: $3"
if [ "$newstatus" = "tuntap_up" ]; then
    echo "$tuntap_intf setup"
    ifconfig $tuntap_intf up
    ip link set dev $tuntap_intf mtu 1400 up
    # NAT thru our server (enp0s3 is our output interface on the server)
    # LAN 192.168.179.0/24 from "client"
    #/sbin/ip route add 192.168.179.0/24 dev $tuntap_intf
    route add -net $VAR_DOCKER_NETWORK.4 netmask 255.255.255.255 dev $tuntap_intf
    iptables -t nat -A POSTROUTING -o eth0 -s $VAR_DOCKER_NETWORK.4/32 -j MASQUERADE
elif [ "$newstatus" = "tuntap_down" ]; then
    /sbin/iptables -t nat -D POSTROUTING -o eth0 -s $VAR_DOCKER_NETWORK.4/32 -j MASQUERADE
fi
) >> /var/log/mlvpn_command.log 2>&1

exit $errors
