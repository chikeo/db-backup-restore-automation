#!/usr/bin/env bash

sudo echo "Commencing the MySQL restore job"
sudo echo "Stopping MySQL Server"
sudo service mysql stop

sudo echo "Delete the MySQL Data Files"
sudo rm -rf /var/lib/mysql/ && sudo mkdir /var/lib/mysql/

sudo echo "Copy the backup archive from the shared location to the temporary directory"
sudo cp /vagrant/mysql-backup.tar.gz /tmp/

sudo echo Set the right permissions on /tmp
sudo chmod -R u+rwx,g+rwx,o+rwx /tmp

sudo echo "Compute the MD5 Checksum of the just copied backup archive"
sudo md5sum /tmp/mysql-backup.tar.gz > /tmp/backup-archive-md5.txt
sudo cat /tmp/backup-archive-md5.txt

sudo echo "Check the integrity of the backed up data files"
sudo /vagrant/db-datafiles-verify.sh

sudo echo "Extract /tmp/mysql-backup.tar.gz into /var/lib/mysql"
sudo tar xvf /tmp/mysql-backup.tar.gz -C /var/lib/mysql/
sudo echo "Checking the size of the extracted files and folders..."
sudo du -h /var/lib/mysql/

sudo echo "Set the permissions correctly for the MySQL daemon"
sudo chown -R mysql:mysql /var/lib/mysql

sudo echo "Starting MySQL Server"
sudo service mysql start

sudo echo Run the DB Restore Verification Script to test the backup and restore op.
sudo /vagrant/db-restore-test.sh 'mysql -u root -pfart -P3306'

sudo echo "Completed the MySQL restore job"

