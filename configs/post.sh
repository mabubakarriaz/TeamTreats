#! /bin/bash

echo "Provision post script started..."

echo "Initializing nginx configs..."
mv /tmp/nginx.conf /etc/nginx/sites-available/default
systemctl restart nginx

echo "Registering app service..."
mv /tmp/app.service /etc/systemd/system/app.service
systemctl daemon-reload
systemctl start app.service
systemctl enable app.service