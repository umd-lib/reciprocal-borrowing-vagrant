#!/bin/bash

RUBY_VERSION=2.2.4

source $HOME/.rvm/scripts/rvm

# Install bundler for all gemsets
#TODO: this should go upstream in the ruby-vagrant
rvm $RUBY_VERSION@global do gem install bundler
# switch back to system ruby for puppet
rvm use system
