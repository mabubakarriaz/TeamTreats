#! /bin/bash

echo "Provision post script started..."

echo "Initializing nginx configs..."
mv /tmp/nginx.conf /etc/nginx/sites-available/default
systemctl restart nginx

echo "Registering api service..."
mv /tmp/api.service /etc/systemd/system/api.service
systemctl daemon-reload
systemctl start api.service
systemctl enable api.service