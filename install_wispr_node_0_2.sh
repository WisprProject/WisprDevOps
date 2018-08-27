#!/bin/bash
echo '## Updating and installing packages.';
sudo apt update && sudo apt upgrade -y;
sudo apt install git libqrencode-dev libssl-dev libdb++-dev libminiupnpc-dev build-essential libboost-all-dev -y;

echo '## Increasing swap size.';
read -r -p "Do want to create a /swapfile of 1G in order to make sure the machine has anough RAM to compile the wallet? (Mainly used for devices with a small amount of ram)  [y/N] " response
if [[ $response = y ]]
then
	sudo swapoff -a && sudo dd if=/dev/zero of=/swapfile bs=1M count=1024 && sudo mkswap /swapfile && sudo swapon /swapfile;
fi

echo '## Downloading & building Wispr wallet.';
git clone https://github.com/WisprProject/core.git;
cd core/src;
git checkout v0.2.0;
make -f makefile.unix;

echo '## Configuring wallet.';
mkdir ~/.wispr && cd ~/.wispr && touch wispr.conf;
echo "maxconnection=16" >> wispr.conf;
echo "daemon=1" >> wispr.conf;
echo "rpcusername="$(openssl rand -base64 32) >> wispr.conf;
echo "rpcpassword="$(openssl rand -base64 32) >> wispr.conf;

echo '## Fetching and adding additional nodes.';
wget https://wispr.tech/nodes -O - >> wispr.conf;

echo '## Wallet can be launched at ~/core/src/wisprd'
