#!/bin/sh

export GID=`/usr/bin/id -g`

echo "${UID}:x:${UID}:${GID}:noone:${HOME}:/sbin/nologin" >> /etc/passwd
echo "${GID}:x:${GID}:${UID}" >> /etc/group
