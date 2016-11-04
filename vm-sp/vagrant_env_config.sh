#!/bin/bash

# This script contains the environment variables for the Vagrant
# configuration.
#
# Each script that requires access to these variables will "source"
# this file.

#---------------------
# System configuration
#---------------------
# APPS_DIR: Directory where downloaded applications are installed
APPS_DIR=/apps/borrow

#---------------------
# Service User Account
#---------------------
SERVICE_USER_ACCOUNT_NAME=vagrant
SERVICE_USER_ACCOUNT_PASSWORD=vagrant

#-----
# Ruby
#-----
RUBY_VERSION=2.2.4

#-----
# Misc
#-----
HOSTNAME=192.168.33.20