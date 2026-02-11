#!/bin/bash

SERVER="ubuntu@16.171.38.133"

LATEST_BACKUP=$(ssh $SERVER "ls -t /var/www/backups | head -1")

echo "Rolling back to $LATEST_BACKUP"

ssh $SERVER << EOF
rm -rf /var/www/backend/*
tar -xzf /var/www/backups/$LATEST_BACKUP -C /
pm2 restart backend
EOF

echo "Rollback complete!"

