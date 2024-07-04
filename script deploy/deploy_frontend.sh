#!/bin/bash

# Update package list and install dependencies
apt-get update
apt-get install -y nginx wget

# Download and configure the frontend application
wget https://your-docker-registry-url/frontend.tar.gz -O /opt/frontend.tar.gz
tar -xzvf /opt/frontend.tar.gz -C /var/www/html

# Configure Nginx
cat <<EOT > /etc/nginx/sites-available/default
server {
    listen 80;
    server_name localhost;

    location / {
        root /var/www/html;
        index index.html;
        try_files \$uri \$uri/ /index.html;
    }

    location /api {
        proxy_pass http://backend:8080;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOT

# Restart Nginx
systemctl restart nginx
