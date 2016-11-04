#!/bin/bash

# Note: This script MUST be run as the service user.

# Configure the environment
source /vagrant/vagrant_env_config.sh

# Install RVM
bash /vagrant/vm-setup/rvm_setup.sh

# Install Passenger Phusion
bash /vagrant/vm-setup/passenger_phusion_setup.sh

# Configure Apache
bash /vagrant/vm-setup/apache_setup.sh

# Setup Rails application
bash /vagrant/vm-setup/rails_app_setup.sh

# Configure Shibboleth client
bash /vagrant/vm-setup/shibboleth_sp_setup.sh

# Copy control script
echo --- Copying 'control' script ---
sudo cp /vagrant/vm-setup/control_script/control $APPS_DIR/
sudo chmod 755 $APPS_DIR/control

# Start the application
echo --- Starting the application ---
cd $APPS_DIR
./control start

echo --- Done ---
