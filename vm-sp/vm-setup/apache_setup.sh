#!/bin/bash

# Script for configuring Apache

# Configure the environment
source /vagrant/vagrant_env_config.sh

echo --- Configuring Apache ---
sudo mkdir $APPS_DIR/apache

sudo chown $SERVICE_USER_ACCOUNT_NAME:$SERVICE_USER_ACCOUNT_NAME $APPS_DIR/apache

mkdir $APPS_DIR/apache/bin
mkdir $APPS_DIR/apache/conf
mkdir $APPS_DIR/apache/conf.d
mkdir $APPS_DIR/apache/conf.modules.d
mkdir $APPS_DIR/apache/src
mkdir $APPS_DIR/apache/html
mkdir $APPS_DIR/apache/logs

cp -r /vagrant/vm-setup/apache_config/* $APPS_DIR/apache

cp /etc/httpd/conf.modules.d/* $APPS_DIR/apache/conf.modules.d/
sudo ln -s /usr/lib64/httpd/modules/ $APPS_DIR/apache/modules

sed -i "s/SED_SERVICE_USER_ACCOUNT_NAME/$SERVICE_USER_ACCOUNT_NAME/g" $APPS_DIR/apache/src/httpdctl.c
sed -i "s/SED_SERVICE_USER_ACCOUNT_NAME/$SERVICE_USER_ACCOUNT_NAME/g" $APPS_DIR/apache/src/Makefile
cd $APPS_DIR/apache/src
sudo make install

sed -i "s/SED_HOSTNAME/$HOSTNAME/g" $APPS_DIR/apache/conf/env-variables
sed -i "s|SED_APPS_DIR|$APPS_DIR|g" $APPS_DIR/apache/conf/httpd.conf
sed -i "s/SED_SERVICE_USER_ACCOUNT_NAME/$SERVICE_USER_ACCOUNT_NAME/g" $APPS_DIR/apache/conf/httpd.conf

sed -i "s|SED_APPS_DIR|$APPS_DIR|g" $APPS_DIR/apache/conf.d/00-virtualhosts.conf
sed -i "s/SED_SERVICE_USER_ACCOUNT_NAME/$SERVICE_USER_ACCOUNT_NAME/g" $APPS_DIR/apache/conf.d/00-virtualhosts.conf

echo --- Copying SSL certificates ---
sudo cp /vagrant/vm-setup/ssl_certs/self_signed.crt /etc/pki/tls/certs/self_signed.crt
sudo cp /vagrant/vm-setup/ssl_certs/self_signed.key /etc/pki/tls/private/self_signed.key
sudo cp /vagrant/vm-setup/ssl_certs/self_signed.csr /etc/pki/tls/private/self_signed.csr
