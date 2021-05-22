#!/bin/bash
set -x
USER_ID="testadmin"
CMD=`eval "$(pyenv init -)"`
DIR="/home/${USER_ID}/.pyenv"
#UPDATE
#=======
sudo apt -y update > /dev/null 2>&1


#install all of pyenv’s OR other binary dependencies:
#====================================================
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git > /dev/null 2>&1
sudo git init > /dev/null 2>&1

git clone https://github.com/pyenv/pyenv.git /home/${USER_ID}/.pyenv > /dev/null 2>&1
sudo chown -R ${USER_ID}:${USER_ID} /home/${USER_ID}/.pyenv > /dev/null 2>&1

sudo /bin/echo 'export PYENV_ROOT="$HOME/.pyenv"' >> /home/${USER_ID}/.bashrc 
sudo /bin/echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> /home/${USER_ID}/.bashrc
sudo /bin/echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> /home/${USER_ID}/.bashrc
sudo /bin/echo 'eval "$(pyenv init -)"' >> /home/${USER_ID}/.bashrc
source /home/${USER_ID}/.bashrc > /dev/null 2>&1
sleep 3
sudo ln -s /home/${USER_ID}/.pyenv/bin/pyenv /usr/local/bin > /dev/null 2>&1
#sudo /usr/local/bin/pyenv install 3.7.9
#cd /home/${USER_ID}/.pyenv/bin/ && sudo /home/${USER_ID}/.pyenv/bin/pyenv install 3.7.9
#/home/${USER_ID}/.pyenv/bin/pyenv versions




#Install PIP
#===========
sudo apt install -y python-pip > /dev/null 2>&1


#Install Az Cli
#==============
sudo apt update -y > /dev/null 2>&1
sudo apt install -y ca-certificates curl apt-transport-https lsb-release gnupg > /dev/null 2>&1
curl -sL https://packages.microsoft.com/keys/microsoft.asc |     gpg --dearmor |     sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null 2>&1
curl -sL https://packages.microsoft.com/keys/microsoft.asc |
    gpg --dearmor |
    sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list

sudo apt -y update > /dev/null 2>&1
sudo apt install -y azure-cli > /dev/null 2>&1
###

#INSTALL AZURE-CORE
#==================
pip install --upgrade --force-reinstall azure-core > /dev/null 2>&1

##
#INSTALL DOCKER
#==============
sudo apt-get install -y curl apt-transport-https ca-certificates software-properties-common > /dev/null 2>&1
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get -y update > /dev/null 2>&1
sudo apt-get install -y docker-ce > /dev/null 2>&1
# Linux post-install
sudo groupadd docker > /dev/null 2>&1
sudo usermod -aG docker ${USER_ID} > /dev/null 2>&1
docker info > /dev/null 2>&1

##
#INSTALL DOCKER COMPOSE
#======================
sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose > /dev/null 2>&1
sudo chmod +x /usr/local/bin/docker-compose > /dev/null 2>&1
###

#TOOLS
#======
mkdir /home/${USER_ID}/_tools && cd /home/${USER_ID}/_tools 
sudo ln -s /usr/bin/pip /home/${USER_ID}/_tools/
sudo ln -s /usr/bin/python /home/${USER_ID}/_tools/
sudo ln -s /home/testadmin/.pyenv/versions/3.7.9/bin/python3.7  /home/${USER_ID}/_tools/ > /dev/null 2>&1

#CREATING DIRECTORIES
#=======================================
mkdir -p /home/${USER_ID}/myagent/_work/ && cd /home/${USER_ID}/myagent/_work/
mkdir -p /home/${USER_ID}/myagent/_work/_tool/Python/3.7.9/x64 && cd /home/${USER_ID}/myagent/_work/_tool/Python/3.7.9/ > /dev/null 2>&1
touch x64.complete

#CREATE SYMLINKS
#================
cd /home/${USER_ID}/myagent/_work/_tool/Python/3.7.9/x64
#sudo ln -s /home/${USER_ID}/.pyenv/versions/3.7.9/bin/python3.7 /home/${USER_ID}/myagent/_work/_tool/Python/3.7.9/x64/python > /dev/null 2>&1
sudo ln -s /usr/bin/pip /home/${USER_ID}/myagent/_work/_tool/Python/3.7.9/x64/pip

echo "#INSTALLED PACKAGES"
echo "#=================="
#pyenv versions
pip --version
az --version
docker --version
docker-compose --version
#/home/${USER_ID}/.pyenv/versions/3.7.9/bin/python3.7 --version

#end#

