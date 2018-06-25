# WisprDevOps
Collections of scripts and tools to maintain various Wispr related services.

**[Install berkley 0.4.8](https://raw.githubusercontent.com/WisprProject/WisprDevOps/master/install_berkley_0_4_8.sh)**

Script to automatticly install berkley version 0.4.8.

Usage: `./install_berkley_0_4_8.sh /home/guus/berkley` <-- Parameter is the install directory.


**[Install Wispr node 0.2](https://raw.githubusercontent.com/WisprProject/WisprDevOps/master/install_wispr_node_0_2.sh)**

Script automatically fetches, compiles, configures and starts a Wispr node v0.2.

Usage: `./install_wispr_node_0_2.sh`


**[Rebuild Wispr node 0.3](https://github.com/WisprProject/WisprDevOps/raw/master/rebuild_0_3_0_node.sh)**

Script automatically redownload, compile and start a Wispr (testnet) node.

Need repository location and berkley install path as parameters (third param is optional for removing the .wispr folder)

Usage example: `./rebuild_0_3_0_node.sh /home/guus/wisprnode/core /home/guus/berkelydb yes`
