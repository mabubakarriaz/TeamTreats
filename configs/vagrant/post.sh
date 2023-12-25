#! /bin/bash

echo "Provision post script started..."

echo "Initializing nginx configs..."
mv /tmp/nginx.conf /etc/nginx/http.d/default.conf
service nginx restart # systemctl restart nginx

echo "Registering app service..."
mv /tmp/teamtreats /etc/init.d/teamtreats
rc-service --quiet --ifstarted teamtreats # systemctl daemon-reload
chmod +x /etc/init.d/teamtreats
rc-service teamtreats start # systemctl start app.service
rc-update add teamtreats default # systemctl enable app.service