#!/usr/bin/env bash

sudo echo "Commencing the MySQL backup job"
sudo echo "Stopping MySQL Server"
sudo service mysql stop

sudo echo "Creating the MySQL Data Files backup directory"
sudo mkdir -p /vagrant/db-backup/

sudo echo "Copying MySQL Data Files to the backup directory"
sudo cp -R /var/lib/mysql/. /vagrant/db-backup/

sudo echo "Compressing the MySQL Data Files into the tar.gz format"
sudo tar cvzf /vagrant/mysql-backup.tar.gz /vagrant/db-backup/
sudo echo "Checking the size of the just compressed archive..."
sudo du -h /vagrant/mysql-backup.tar.gz

sudo echo "Computing the checksum of the compressed backup archive"
sudo md5sum /vagrant/mysql-backup.tar.gz > /vagrant/backup-archive-md5.txt
sudo cat /vagrant/backup-archive-md5.txt

sudo echo "Starting MySQL Server"
sudo service mysql start
sudo echo "Completed the MySQL backup job"
