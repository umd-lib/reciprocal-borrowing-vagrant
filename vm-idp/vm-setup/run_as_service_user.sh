#!/bin/bash

# Note: This script MUST be run as the service user.

# Configure the environment
source /vagrant/vagrant_env_config.sh

# Configure Apache
bash /vagrant/vm-setup/apache_setup.sh

# Shibboleth IdP setup
bash /vagrant/vm-setup/shibboleth_idp_setup.sh

# Shibboleth IdP credentials setup
bash /vagrant/vm-setup/idp_credentials_setup.sh

# Tomcat setup
bash /vagrant/vm-setup/tomcat_idp_config_setup.sh

# Start Apache
echo --- Starting Apache ---
sudo /etc/init.d/httpd start

echo -- Starting Tomcat ---
cd /apps/tomcat
./control start

echo --- Done ---
