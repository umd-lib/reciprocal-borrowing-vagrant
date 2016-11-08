#!/bin/bash

# Note: This script MUST be run as the service user.

# Configure the environment
source /vagrant/vagrant_env_config.sh

echo --- Configuring IdP credentials ---

sudo mkdir /usr/local/idp/
sudo chown $SERVICE_USER_ACCOUNT_NAME:$SERVICE_USER_ACCOUNT_NAME /usr/local/idp
mkdir /usr/local/idp/credentials

expect <<- DONE
  spawn htpasswd -c /usr/local/idp/credentials/user.db $SAMPLE_USERNAME
  set timeout -1
  expect "New password"
  send "$SAMPLE_PASSWORD\r"
  expect "Re-type new password"
  send "$SAMPLE_PASSWORD\r"
  expect eof
DONE