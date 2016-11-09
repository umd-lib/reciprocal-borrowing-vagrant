#!/bin/bash

# Note: This script MUST be run as the service user.

# Configure the environment
source /vagrant/vagrant_env_config.sh

echo --- Configuring Tomcat Server ---
# Make backup of original file
cp -p $APACHE_TOMCAT_ALIAS_DIR/conf/server.xml $APACHE_TOMCAT_ALIAS_DIR/conf/server.xml.dist
sudo cp /vagrant/vm-setup/tomcat_config/conf/server.xml $APACHE_TOMCAT_ALIAS_DIR/conf/server.xml

echo --- Copying IdP War file ---
cp $SHIBBOLETH_IDP_INSTALL_DIR/war/idp.war $APACHE_TOMCAT_ALIAS_DIR/webapps