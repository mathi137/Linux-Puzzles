#!/bin/sh

WORKDIR=/usr/local/bin
PORT=2220
LEVELS=2


# Creating users
eval "${WORKDIR}/commands/create_users.sh"

# Creating levels
for i in `seq 0 $LEVELS`; do
    eval mkdir "${WORKDIR}/level${i}"
    eval "${WORKDIR}/levels/lvl${i}.sh"
done

# Setting up SSH server
apk add openssh && apk add --no-cache openrc

sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i "s/^#Port 22/Port ${PORT}/" /etc/ssh/sshd_config
mkdir -p /run/openrc && touch /run/openrc/softlevel


rc-update add sshd default
/usr/sbin/sshd -D

ssh-keygen -A
service sshd restart

# Deleting sensitive files
eval "${WORKDIR}/commands/delete.sh"