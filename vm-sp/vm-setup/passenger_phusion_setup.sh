#!/bin/bash

# Script for downloading, installing, and configuring Passenger Phusion

# Configure the environment
source /vagrant/vagrant_env_config.sh

echo --- Installing Passenger Phusion dependencies ---
sudo yum install -y curl gpg gcc gcc-c++ make

# Install NodeJS
sudo yum install -y epel-release
sudo yum install -y --enablerepo=epel nodejs npm

# Install EPEL
sudo yum install -y yum-utils
sudo yum-config-manager --enable epel

# Install Passenger Prerequsites
sudo yum install -y pygpgme curl
sudo curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo

echo --- Installing Passenger Phusion ---
sudo yum install -y mod_passenger

