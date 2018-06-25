#!/bin/bash

COREAMOUNT=`grep -c ^processor /proc/cpuinfo`

if [[ -z "$1" ]] || [[ -z "$2" ]]
then
    echo "Need repositorie location and berkley install path as parameters (third param is optional for removing the .wispr folder)";
    echo "Usage example: ./rebuild_0_3_0_node.sh /home/guus/wisprnode/core /home/guus/berkelydb yes";
    exit 1;
fi

cd $1;
make clean;
if [[ -z "$3" ]]
then
    rm -rfv ~/.wispr/;
fi
git pull;
git checkout 0.3_RC;
./autogen.sh && ./configure LDFLAGS="-L$2/lib/" CPPFLAGS="-I$2/include/" && make -j$COREAMOUNT;
echo "Wispr core pulled & compiled!";
exit 1;
