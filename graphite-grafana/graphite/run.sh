#!/bin/bash

/opt/graphite/bin/carbon-cache.py start && {
    /etc/init.d/uwsgi restart
} && {
    /etc/init.d/nginx restart
} || {
    echo "Something gone wrong, Check state of services manually!"
}

/usr/sbin/sshd -D