#!/bin/bash

# Script for configuring the Shibboleth SP application

# Configure the environment
source /vagrant/vagrant_env_config.sh

# Copy shibboleth2.xml to application
echo --- Configuring Shibboleth SP client ---
sudo cp /vagrant/vm-setup/shibboleth_config/shibboleth2.xml /etc/shibboleth/shibboleth2.xml

sudo cp /vagrant/vm-setup/shibboleth_config/sp-cert.pem /etc/shibboleth/sp-cert.pem
sudo cp /vagrant/vm-setup/shibboleth_config/sp-key.pem /etc/shibboleth/sp-key.pem