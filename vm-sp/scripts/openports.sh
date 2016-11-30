#!/bin/bash

# open HTTP ports
for port in "$@"; do
    firewall-cmd --zone=public --add-port="$port/tcp" --permanent
done
firewall-cmd --reload
