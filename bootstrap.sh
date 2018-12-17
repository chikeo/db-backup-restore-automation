#!/usr/bin/env bash

cd mysql1/
vagrant up --provision

cd ../backup1/
vagrant up --provision

cd ../mysql1/
vagrant halt mysql1
vagrant destroy mysql1

cd ../backup1/
vagrant halt backup1
vagrant destroy backup1

echo "All Done!"
