#!/bin/sh
  
/sbin/ifconfig eth0:0 192.168.180.1 netmask 255.255.255.0
/sbin/ifconfig eth0:1 192.168.181.1 netmask 255.255.255.0

