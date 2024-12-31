#!/bin/sh

set -e  # Exit immediately if a command exits with a non-zero status

echo "Running pre.sh script..."

# Backup the original repositories file
cp /etc/apk/repositories /etc/apk/repositories.bak

# Uncomment the 'main' repository if it's commented out
sed -i '/^#.*main/s/^#//' /etc/apk/repositories

# Uncomment the 'community' repository if it's commented out
sed -i '/^#.*community/s/^#//' /etc/apk/repositories

# Alternatively, add the main and community repositories if they are missing
if ! grep -q 'http://dl-cdn.alpinelinux.org/alpine/v3.21/main' /etc/apk/repositories; then
    echo 'http://dl-cdn.alpinelinux.org/alpine/v3.21/main' >> /etc/apk/repositories
    echo "Added main repository to /etc/apk/repositories"
fi

# Alternatively, add the community repository if it's missing
if ! grep -q 'http://dl-cdn.alpinelinux.org/alpine/v3.21/community' /etc/apk/repositories; then
    echo 'http://dl-cdn.alpinelinux.org/alpine/v3.21/community' >> /etc/apk/repositories
    echo "Added community repository to /etc/apk/repositories"
fi

# Display the current repositories for verification
echo "Current /etc/apk/repositories:"
cat /etc/apk/repositories

# Update the package index for Alpine Linux
apk update

# Check disk usage before installation
echo "Disk usage before installation:"
df -h

# Install Ansible without using cache
echo "Installing Ansible..."
apk add --no-cache ansible

# Verify Ansible installation
if command -v ansible-playbook >/dev/null 2>&1; then
    echo "Ansible successfully installed."
else
    echo "ERROR: Ansible installation failed."
    exit 1
fi

# Remove the package cache to free up space
rm -rf /var/cache/apk/
