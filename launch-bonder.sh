#!/bin/bash

#ip_mlvp_1=$VAR_DOCKER_NETWORK.1
#ip_mlvp_2=$VAR_DOCKER_NETWORK.2
#ip_mlvp_3=$VAR_DOCKER_NETWORK.3
#ip_mlvp_4=$VAR_DOCKER_NETWORK.4
#ip_mlvp_5=$VAR_DOCKER_NETWORK.5

echo "START mlvpn1" && \
sh /root/mlvpn/launch-bonder-1.sh &

echo "START mlvpn2" && \
sh /root/mlvpn/launch-bonder-2.sh &

echo "START mlvpn3" && \
sh /root/mlvpn/launch-bonder-3.sh &

echo "START mlvpn4" && \
sh /root/mlvpn/launch-bonder-4.sh &

echo "START mlvpn5" &&\
sh /root/mlvpn/launch-bonder-5.sh && fg
