#!/bin/bash
export DEBIAN_FRONTEND="noninteractive"
export TZ="Europe/London"
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

apt-get update && apt-get upgrade -y
apt-get install -y nginx

/etc/init.d/nginx start
rm /var/www/html/*
echo "AZ_$1" > /var/www/html/index.html
exit 0