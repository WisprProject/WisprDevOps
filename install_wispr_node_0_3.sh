#!/bin/bash
echo '## Updating and installing packages.';
sudo apt update && sudo apt upgrade -y;
sudo apt install git libqrencode-dev libssl-dev libdb++-dev libminiupnpc-dev build-essential libboost-all-dev libtool autotools-dev autoconf pkg-config libevent-dev -y;

COREAMOUNT=`grep -c ^processor /proc/cpuinfo`

if [[ -z "$1" ]]
then
    echo "Need berkley install path as parameters";
    echo "Usage example: ./install_wispr_node_0_3.sh /home/guus/berkelydb";
    echo "If you havent compiled or installed berkeleyDB yet, here is a install script: https://raw.githubusercontent.com/WisprProject/WisprDevOps/master/install_berkley_0_4_8.sh"
    exit 1;
fi

echo '## Increasing swap size.';
read -r -p "Do want to create a /swapfile of 1G in order to make sure the machine has anough RAM to compile the wallet? (Mainly used for devices with a small amount of ram)  [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
	sudo swapoff -a && sudo dd if=/dev/zero of=/swapfile bs=1M count=1024 && sudo mkswap /swapfile && sudo swapon /swapfile;
fi

echo '## Downloading & building Wispr wallet.';
git clone https://github.com/WisprProject/core.git wispr-src;
cd wispr-src;
## Temporary release candidate's branch. instead of the 0.3 tag.
git checkout 0.3_RC;

./autogen.sh && ./configure LDFLAGS="-L$1/lib/" CPPFLAGS="-I$1/include/" && make -j$COREAMOUNT;

echo '## Configuring wallet.';
mkdir ~/.wispr && cd ~/.wispr; && touch wispr.conf;
echo "maxconnection=16" >> wispr.conf;
echo "daemon=1" >> wispr.conf;
echo "rpcusername="$(openssl rand -base64 32) >> wispr.conf;
echo "rpcpassword="$(openssl rand -base64 32) >> wispr.conf;

echo '## Fetching and adding additional nodes.';
wget https://wispr.tech/nodes -O - >> wispr.conf;

echo '## Wallet can be launched at ~/core/src/wisprd'
