#!/bin/bash

echo --- Installing Passenger Phusion ---
# passenger.repo file
# can't use puppet to fetch this since https URL file sources aren't supported in Puppet 3.x
curl --fail -sSLo /etc/yum.repos.d/passenger.repo https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo

yum install -y mod_passenger
