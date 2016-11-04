#!/bin/bash

# Script for downloading, installing, and configuring the Reciprocal Borrowing
# application

# Configure the environment
source /vagrant/vagrant_env_config.sh

echo --- Cloning Reciprocal Borrowing application from GitHub ---
cd $APPS_DIR
git clone https://github.com/umd-lib/reciprocal-borrowing.git

echo --- Setting up Reciprocal Borrowing application ---
cd reciprocal-borrowing
bundle install

