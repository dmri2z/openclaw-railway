#!/bin/bash
set -e

chown -R openclaw:openclaw /data
chmod 700 /data

if [ ! -d /data/.linuxbrew ]; then
  cp -a /home/linuxbrew/.linuxbrew /data/.linuxbrew
fi

rm -rf /home/linuxbrew/.linuxbrew
ln -sfn /data/.linuxbrew /home/linuxbrew/.linuxbrew

CREDENTIALS_DIR=/data/credentials
# ensure /data/credentials exists and is only accessible by root
mkdir -p $CREDENTIALS_DIR
chown root:root $CREDENTIALS_DIR
chmod 700 $CREDENTIALS_DIR

/root/github-app-auth/install.sh
exec gosu openclaw node src/server.js
