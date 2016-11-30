#!/bin/bash

# Script for configuring the Reciprocal Borrowing application

source $HOME/.rvm/scripts/rvm

echo --- Setting up Rails application ---
cd /apps/borrow/reciprocal-borrowing

echo -- Installing Gems for Rails application ---
bundle install
