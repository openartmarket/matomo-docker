#!/bin/bash

# Install Docker
apt update
apt install -y apt-transport-https ca-certificates curl software-properties-common unattended-upgrades geoipupdate
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y docker-ce docker-ce-cli containerd.io

source .env
echo "AccountID ${MAXMIND_ACCOUNT_ID}" >> /etc/GeoIP.conf
echo "LicenseKey ${MAXMIND_LICENSE_KEY}" >> /etc/GeoIP.conf 
echo "EditionIDs GeoLite2-City GeoLite2-Country GeoLite2-ASN" >> /etc/GeoIP.conf
echo "DatabaseDirectory /var/lib/GeoIP" >> /etc/GeoIP.conf


geoipupdate
echo "50 2 * * 4 root /usr/bin/geoipupdate" >> /etc/cron.d/geoipupdate

# Start Docker service
systemctl start docker
systemctl enable docker

docker compose up -d