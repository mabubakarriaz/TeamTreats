#! /bin/bash

echo "Provision post script started..."

echo "Initializing nginx configs..."
mv /tmp/nginx.conf /etc/nginx/http.d/default.conf
rc-service nginx restart # systemctl restart nginx

echo "Registering app service..."
mv /tmp/app.service /etc/systemd/system/app.service
rc-service --quiet --ifstarted reload # systemctl daemon-reload
rc-service app.service start # systemctl start app.service
rc-update add app.service default # systemctl enable app.service