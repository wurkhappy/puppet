#!/bin/bash


cd
mkdir -p /package
chmod 1755 /package
cd /package
wget http://cr.yp.to/daemontools/daemontools-0.76.tar.gz
tar -xzvf daemontools-0.76.tar.gz
rm daemontools-0.76.tar.gz
cd admin/daemontools-0.76
echo gcc -O2 -include /usr/include/errno.h > src/conf-cc
./package/install
echo "start on runlevel [12345]" > /etc/init/svscan.conf
echo "respawn" >> /etc/init/svscan.conf
echo "exec /command/svscanboot" >> /etc/init/svscan.conf
