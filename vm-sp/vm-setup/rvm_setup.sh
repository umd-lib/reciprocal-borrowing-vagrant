#!/bin/bash

# Script for downloading, installing, and configuring RVM.

# Configure the environment
source /vagrant/vagrant_env_config.sh

echo --- Installing Ruby via Yum for bootstrapping RVM ---

# Install Ruby (used to bootstrap RVM)
sudo yum -y install ruby

echo --- Installing RVM ---
cd ~
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable --path /home/$SERVICE_USER_ACCOUNT_NAME/.rvm

source /home/$SERVICE_USER_ACCOUNT_NAME/.rvm/scripts/rvm

echo --- Installing Ruby $RUBY_VERSION ---
rvm install $RUBY_VERSION

# Install bundler for all gemsets
rvm use $RUBY_VERSION
rvm @global do gem install bundler
