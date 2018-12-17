# db-backup-restore-automation
MySQL DB Backup and Restore Vagrant and Ansible Automation

Prerequisites
-----------

1 : Virtualbox 5.2.22 r126460

2 : Vagrant 2.2.2

3 : Ansible 2.7.4 installed in your local control machine or server.

4 : Ruby 2.5.3p105 and Ruby libraries like Bundle for running Kitchen-Ansible tests using Inspec.


Steps to execute
----------------

git clone https://github.com/chikeo/db-backup-restore-automation.git

cd db-backup-restore-automation/

./bootstrap.sh


Points to note
--------------

The password of the MySQL Server can be secured using Ansible Vault in a production application rather than the approach in this demo.
