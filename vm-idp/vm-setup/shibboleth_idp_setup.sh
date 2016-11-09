#!/bin/bash

# Note: This script MUST be run as the service user.

# Configure the environment
source /vagrant/vagrant_env_config.sh

echo --- Installing Shibboleth IdP ---
cd $APPS_DIR
curl -O $SHIBBOLETH_IDP_URL
unzip $SHIBBOLETH_IDP_FILENAME


echo --- Configuring Shibboleth IdP ---
cd $APPS_DIR/$SHIBBOLETH_IDP_DIR
export JAVA_HOME=/usr/java/latest/

expect <<- DONE
  spawn $APPS_DIR/$SHIBBOLETH_IDP_DIR/install.sh
  set timeout -1
  expect "Where"
  send "$SHIBBOLETH_IDP_INSTALL_DIR\r"
  
  expect "*fully qualified hostname*"
  send "$HOSTNAME\r"
  
  expect "*enter a password*"
  send "$SERVICE_USER_ACCOUNT_NAME\r"
  expect eof
DONE

echo --- Copying endorsed jars from Shibboleth IdP to Tomcat ---
mkdir /apps/tomcat/endorsed
cp $APPS_DIR/$SHIBBOLETH_IDP_DIR/endorsed/*.jar $APACHE_TOMCAT_ALIAS_DIR/endorsed

echo --- Copying relying-party.xml ---
# Make backup of original file
cp -p $SHIBBOLETH_IDP_INSTALL_DIR/conf/relying-party.xml $SHIBBOLETH_IDP_INSTALL_DIR/conf/relying-party.xml.dist
cp /vagrant/vm-setup/idp_config/conf/relying-party.xml $SHIBBOLETH_IDP_INSTALL_DIR/conf/relying-party.xml

echo --- Copying attribute-resolver.xml ---
cp -p $SHIBBOLETH_IDP_INSTALL_DIR/conf/attribute-resolver.xml $SHIBBOLETH_IDP_INSTALL_DIR/conf/attribute-resolver.xml.dist
cp /vagrant/vm-setup/idp_config/conf/attribute-resolver.xml $SHIBBOLETH_IDP_INSTALL_DIR/conf/attribute-resolver.xml

echo --- Copying attribute-filter.xml ---
cp -p $SHIBBOLETH_IDP_INSTALL_DIR/conf/attribute-filter.xml $SHIBBOLETH_IDP_INSTALL_DIR/conf/attribute-filter.xml.dist
cp /vagrant/vm-setup/idp_config/conf/attribute-filter.xml $SHIBBOLETH_IDP_INSTALL_DIR/conf/attribute-filter.xml

echo --- Copying some-metadata.xml ---
# Not replacing a file, so no need for backup
cp /vagrant/vm-setup/idp_config/metadata/some-metadata.xml $SHIBBOLETH_IDP_INSTALL_DIR/metadata/some-metadata.xml
