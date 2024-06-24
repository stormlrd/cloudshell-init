# Cloudshell-init
A set of scripts to help you create a central bucket in an account to store an init.sh script for cloudshell to use.

## Files:
| Filename | Description |
|----------|-------------|
| create_bucket.ps1 | Powershell script to create the bucket and copy up the script |
| delete_bucket.ps1 | Powershell script to delete the bucket |
| update_init_script.ps1 | Powershell script to only copy the init.sh into the bucket for updates |
| init.sh | the script to run on cloudshell that is stored in the bucket |


## Usage:

Each ps1 script has a profile variable at the top you need to change to the profile you want to use.

Run the create_bucket.ps1 first.
This will create the bucket and two files in the local folder:
- bucketname.txt
- cloudshell_command.txt

Open cloudshell and then copy and paste the command from cloudshell_command.

Done. Your shell is now configured with the things you want.

## cloudshell_command.txt
This file contains the command you run on your cloudshell.
an example is:

# init.sh

Currently the init.sh will install goland and clone the useful repositories for managing cloud estates at scale. this is a WIP.
```
# Install Golang
sudo yum install golang

# Clone the cli stuff
git clone https://github.com/stormlrd/aws-federated-python-awscli-skeleton.git
git clone https://github.com/stormlrd/aws-federated-headless-login.git
git clone https://github.com/stormlrd/aws-federated-identity-scraper.git

cd aws-federated-headless-login/
go build -buildvcs=false
```

