#!/bin/bash

# Note: This script MUST be run as the service user.

# Configure the environment
source /vagrant/vagrant_env_config.sh

echo --- Configuring Tomcat Server ---
sudo cp /vagrant/vm-setup/tomcat_config/conf/server.xml /apps/tomcat/conf/server.xml

echo --- Copying IdP War file ---
cp /apps/shibboleth-idp/war/idp.war /apps/tomcat/webapps