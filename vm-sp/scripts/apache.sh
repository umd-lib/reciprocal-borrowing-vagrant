#!/bin/bash

SERVICE_USER=vagrant
SERVICE_GROUP=vagrant

# runtime environment
mkdir -p /apps/borrow/apache/{bin,logs,run}
chown -R "${SERVICE_USER}:${SERVICE_GROUP}" /apps/borrow/apache

# symlink to system modules
ln -sf /usr/lib64/httpd/modules /apps/borrow/apache/modules

# compile the helper setuid program
cd /apps/borrow/apache/src
make SERVICE_USER="$SERVICE_USER" SERVICE_GROUP="$SERVICE_GROUP" install clean
