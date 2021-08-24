#!/bin/bash

chmod 700 /root/mlvpn/cfg/vpn0-bonding-4.sh
chmod 700 /root/mlvpn/cfg/vpn0-bonding-4.conf
echo "START"
/mlvpn/mlvpn/sbin/mlvpn --user root -c /root/mlvpn/cfg/vpn0-bonding-4.conf --debug -v
