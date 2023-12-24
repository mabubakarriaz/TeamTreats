#!/bin/bash -ex

echo "Running pre.sh script"

# Update the package index for Alpine Linux
apk update

# uncomment the 'community' repository in '/etc/apk/repositories'
awk '/community/ {sub(/^#/, "", $0)} 1' /etc/apk/repositories > /tmp/tempfile
mv /tmp/tempfile /etc/apk/repositories

# install the 'ansible' package
#apk add ansible

# Remove the package cache to free up space
rm -rf /var/cache/apk/
