#!/bin/bash

# This script downloads, installs, and configures the necessary components
# setting up the virtual machine.
#
# Note: This script MUST be run as the "vagrant" user.

# Configure the environment
source /vagrant/vagrant_env_config.sh

# Install Apache
echo --- Installing Apache ---
yum -y install httpd

# Install SSL
echo --- Installing SSL ---
yum -y install mod_ssl openssl

# Install Git
echo --- Installing Git ---
yum -y install git

# Install ipstables-services
echo --- Installing iptables-services ---
yum -y install iptables-services

# Install Shibboleth
echo --- Installing Shibboleth ---
sudo wget --quiet http://download.opensuse.org/repositories/security://shibboleth/CentOS_7/security:shibboleth.repo -O /etc/yum.repos.d/shibboleth.repo
sudo yum -y install shibboleth.x86_64

# Create APPS_DIR, if needed.
if [ ! -d "$APPS_DIR" ]; then 
  sudo mkdir -p $APPS_DIR
fi

# Ensure that APPS_DIR is owned by the service user
sudo chown $SERVICE_USER_ACCOUNT_NAME:$SERVICE_USER_ACCOUNT_NAME $APPS_DIR

# Run the rest of the script as the service user
sudo -i -u $SERVICE_USER_ACCOUNT_NAME bash /vagrant/vm-setup/run_as_service_user.sh
