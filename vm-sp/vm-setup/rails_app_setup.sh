#!/bin/bash

# Script for downloading, installing, and configuring the Reciprocal Borrowing
# application

# Configure the environment
source /vagrant/vagrant_env_config.sh

source /home/$SERVICE_USER_ACCOUNT_NAME/.rvm/scripts/rvm

echo --- Setting up Rails application ---
cd $APPS_DIR/reciprocal-borrowing

echo -- Installing Gems for Rails application ---
bundle install

