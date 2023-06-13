# Setup of self hosted Matomo on a Hetzner server 

Follow these instructions in order to setup Matomo tracking

## Create server at Hetzner
- CPX11 should be enough
- Add SSH keys for easier access
- Create
### Connect to hetzner box
```sh
ssh root@<ip-address>
```
### Create .env and edit file
```sh
apt-get update
apt-get install -y git

git clone https://github.com/openartmarket/matomo-docker.git matomo
cd matomo
cp .env.example .env
vi .env
```
Copy and paste variables shared in secure storage and paste in

### Run setup script
```sh
source .env
chmod +x setup_server.sh
./setup_server.sh
```

### Update DNS
Go to your DNS Records and paste in the IP address in the A record for `metrics` or what you want to call it.

### Visit subdomain and setup matomo database
