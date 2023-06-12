#!/bin/bash 

cat - /etc/resolv.conf << EOF | sudo tee /etc/resolv.conf
nameserver 10.10.12.7
nameserver 10.10.12.9
EOF
