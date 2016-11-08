#!/bin/bash

# Note: This script MUST be run as the service user.

# Configure the environment
source /vagrant/vagrant_env_config.sh

echo --- Configuring Apache ---
sudo cp /vagrant/vm-setup/apache_config/conf/httpd.conf /etc/httpd/conf/httpd.conf