#!/bin/sh

# Designed for Ubuntu 20.04.2 LTS (GNU/Linux 5.8.0-53-generic x86_64)

# I want to setup a virtual machine to run docker as the 
# containers that run odoo can be sensitive and I do not want 
# to clutter my environment at all!

# Update apt
sudo apt update

# Update apt-get
sudo apt-get update

# List git version 
git --version

# List Python version
python3 --version

# List pip version
pip3 --version # Should fail

# Install python3 pip3sudo apt
sudo apt install python3-pip

# Install Docker
## Clean hanging docker installations
sudo apt-get remove docker docker-engine docker.io containerd runc
## Update apt-get, again...
sudo apt-get update
## Get required packages for docker
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release


# Install docker-compose
## Get the binary
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
## Make the binary executable
sudo chmod +x /usr/local/bin/docker-compose
## Create symbolic link
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
## Test docker-compose
docker-compose --version # Probably won't work until you restart the machine

# Restart environment
sudo shutdown -r now