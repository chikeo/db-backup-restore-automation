#!/usr/bin/env bash

var_backup_hash=$(awk '{print $1}' /vagrant/backup-archive-md5.txt)
echo "Retrieving the MD5 hash computed during backup at server mysql1.local from shared location /vagrant/backup-archive-md5.txt"
echo "var_backup_hash=$var_backup_hash"

var_restore_copy_hash=$(awk '{print $1}' /tmp/backup-archive-md5.txt)
echo "Retrieving the MD5 hash computed during restore at server backup1.local from /tmp/backup-archive-md5.txt"
echo "var_restore_copy_hash=$var_restore_copy_hash"

if [ $var_backup_hash = $var_restore_copy_hash ]
then
  echo "OK: Data files integrity verified"
else
  echo "DIFFERS: Data files integrity compromised"
fi
