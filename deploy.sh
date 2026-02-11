#!/bin/bash

SERVER="ubuntu@YOUR_SERVER_IP"

echo "Creating backup..."
ssh $SERVER "tar -czf /var/www/backups/backend_$(date +%F_%T).tar.gz /var/www/backend || true"

echo "Deploying backend..."
scp -r backend/* $SERVER:/var/www/backend/

ssh $SERVER << EOF
cd /var/www/backend
npm install --production
pm2 delete backend || true
pm2 start index.js --name backend
pm2 save
EOF

echo "Deploying frontend..."
scp -r frontend/build/* $SERVER:/var/www/frontend/

ssh $SERVER "sudo systemctl reload nginx"

echo "Deployment completed!"
