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

#-----------------
# shib User Account
#-----------------
SERVICE_USER_ACCOUNT_NAME=borrow
SERVICE_USER_ACCOUNT_PASSWORD=borrow

#-----
# Java
#-----
JDK_RPM_FILE=/vagrant_shared/oracle_jdk/required/jdk-7u79-linux-x64.rpm
JAVA_HOME_DIR=/usr/java/jdk1.7.0_79

#-----
# Ruby
#-----
RUBY_VERSION=2.2.4

#-----
# Misc
#-----
HOSTNAME=192.168.33.20