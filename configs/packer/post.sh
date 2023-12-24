#!/bin/bash -ex

echo "Running post.sh script"

# Upgrade all installed packages to the latest version
apk upgrade -U --available

# Source information about the operating system
source /etc/os-release

# Disable root login and configure SSH to not use DNS
#sed -i '/^PermitRootLogin yes/d' /etc/ssh/sshd_config
echo "UseDNS no" >> /etc/ssh/sshd_config

# setup vagrant user & authorized keys
adduser -D vagrant
echo "vagrant:vagrant" | chpasswd

# Create the '.ssh' directory for the 'vagrant' user and download authorized keys
mkdir -pm 700 /home/vagrant/.ssh
curl -sSo /home/vagrant/.ssh/authorized_keys 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub'

# Set correct ownership and permissions for the '.ssh' directory
chown -R vagrant:vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh

# Configure sudo to not prompt for password for users in the 'wheel' group
adduser vagrant wheel
echo "Defaults exempt_group=wheel" > /etc/sudoers
echo "%wheel ALL=NOPASSWD:ALL" >> /etc/sudoers

# moving files
mv /tmp/motd /etc/motd

