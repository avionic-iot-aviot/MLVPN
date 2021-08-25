#!/bin/sh

SIZE=$1

/bin/dd if=/dev/urandom of=$SIZE.dat bs=$SIZE count=1
