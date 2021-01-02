#! /bin/bash

SOURCE=/home/thomas/docker-domotic/data
BACKUP_ROOT=/mnt/external
RSYNC_LOG=/tmp/rsync.log

mkdir $BACKUP_ROOT

cp ./domotic-backup.service /tmp/
sed -i "s/\$SOURCE/${SOURCE//\//\\\/}/g" /tmp/domotic-backup.service
sed -i "s/\$BACKUP_ROOT/${BACKUP_ROOT//\//\\\/}/g" /tmp/domotic-backup.service
sed -i "s/\$RSYNC_LOG/${RSYNC_LOG//\//\\\/}/g" /tmp/domotic-backup.service

cp ./mnt-external.mount /etc/systemd/system/
cp /tmp/domotic-backup.service /etc/systemd/system/
cp ./domotic-backup.timer /etc/systemd/system/

systemctl daemon-reload

systemctl start mnt-external.mount
systemctl enable mnt-external.mount

systemctl start domotic-backup.timer
systemctl enable domotic-backup.timer

systemctl start domotic-backup.service
