#!/bin/bash

# Install Serverless Framework
#sudo npm install -g serverless
#sudo npm install -g serverless-better-credentials

# Install Golang
sudo yum install golang

# Clone the cli stuff
git clone https://github.com/stormlrd/aws-federated-python-awscli-skeleton.git
git clone https://github.com/stormlrd/aws-federated-headless-login.git
git clone https://github.com/stormlrd/aws-federated-identity-scraper.git

cd aws-federated-headless-login/
go build -buildvcs=false
