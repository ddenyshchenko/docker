#!/bin/sh
set -e

#
# This script is meant for quick & easy install via:
#   
# wget -qO- http://docker-registry.domain.com:7081 | sh

REGURL='docker-registry.domain.com:5000'

sudo mkdir -p /etc/docker/certs.d/$REGURL

wget http://docker-registry.domain.com:8081/ca.crt -O /etc/docker/certs.d/$REGURL/ca.crt

echo "Restart your docker service to apply changes"
