#!/bin/bash
if [ -z "$1" ]
then
    echo "Need the installation directory as parameter.";
    echo "Usage: ./install_berkley_0_4_8.sh /home/guus/berkley";
    exit 1;
fi
if [ -z "$2" ]
then
    sudo apt update;
fi
sudo apt install autoconf pkg-config -y;
wget 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz';
tar -xzvf db-4.8.30.NC.tar.gz;
rm db-4.8.30.NC.tar.gz;
cd db-4.8.30.NC/build_unix/;
../dist/configure --enable-cxx --disable-shared --with-pic --prefix=$1;
echo 'Compiling berkely 4.8.30...';
make install > $1/build.txt 2>&1;
cd ../../;
rm -rfv db-4.8.30.NC;
echo "Berkley installed.";
exit 1;
