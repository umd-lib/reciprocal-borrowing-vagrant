#!/bin/bash

# Note: This script MUST be run as the service user.

# Configure the environment
source /vagrant/vagrant_env_config.sh

echo --- Installing Shibboleth IdP ---
cd /apps
curl -O http://shibboleth.net/downloads/identity-provider/2.3.8/shibboleth-identityprovider-2.3.8-bin.zip
unzip shibboleth-identityprovider-2.3.8-bin.zip


echo --- Configuring Shibboleth IdP ---
cd /apps/shibboleth-identityprovider-2.3.8
export JAVA_HOME=/usr/java/latest/

expect <<- DONE
  spawn /apps/shibboleth-identityprovider-2.3.8/install.sh
  set timeout -1
  expect "Where"
  send "/apps/shibboleth-idp\r"
  
  expect "*fully qualified hostname*"
  send "192.168.33.10\r"
  
  expect "*enter a password*"
  send "shib\r"
  expect eof
DONE

echo --- Copying endorsed jars from Shibboleth IdP to Tomcat ---
mkdir /apps/tomcat/endorsed
cp /apps/shibboleth-identityprovider-2.3.8/endorsed/*.jar /apps/tomcat/endorsed

echo --- Copying relying-party.xml ---
cp /vagrant/vm-setup/idp_config/conf/relying-party.xml /apps/shibboleth-idp/conf/relying-party.xml

echo --- Copying some-metadata.xml ---
cp /vagrant/vm-setup/idp_config/metadata/some-metadata.xml /apps/shibboleth-idp/metadata/some-metadata.xml
