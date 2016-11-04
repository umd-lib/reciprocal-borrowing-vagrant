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

echo --- Done ---
