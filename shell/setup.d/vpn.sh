echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling VPNs\033[0m\n'
sudo apt-get install -y\
    openvpn\
        openvpn-systemd-resolved\
        network-manager-openvpn\
        network-manager-openvpn-gnome

# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


echo -e "\nConfiguring NordVPN"
sudo mkdir /etc/openvpn/nordvpn
cd /etc/openvpn/nordvpn
# Try to download config files for some of NordVPN's servers
sudo wget https://downloads.nordcdn.com/configs/files/ovpn_legacy/servers/de678.nordvpn.com.tcp443.ovpn
sudo wget https://downloads.nordcdn.com/configs/files/ovpn_legacy/servers/de678.nordvpn.com.udp1194.ovpn
sudo wget https://downloads.nordcdn.com/configs/files/ovpn_legacy/servers/de789.nordvpn.com.tcp443.ovpn
sudo wget https://downloads.nordcdn.com/configs/files/ovpn_legacy/servers/de789.nordvpn.com.udp1194.ovpn

cd "$HOME"
# Try to install some of NordVPN's servers
if [ -f /etc/openvpn/nordvpn/de678.nordvpn.com.tcp443.ovpn ]; then
    echo "Installing NordVPN's de678 server"
    sudo nmcli connection import type openvpn file /etc/openvpn/nordvpn/de678.nordvpn.com.tcp443.ovpn
    sudo nmcli connection import type openvpn file /etc/openvpn/nordvpn/de678.nordvpn.com.udp1194.ovpn
fi
if [ -f /etc/openvpn/nordvpn/de789.nordvpn.com.tcp443.ovpn ]; then
    echo "Installing NordVPN's de789 server"
    sudo nmcli connection import type openvpn file /etc/openvpn/nordvpn/de789.nordvpn.com.tcp443.ovpn
    sudo nmcli connection import type openvpn file /etc/openvpn/nordvpn/de789.nordvpn.com.udp1194.ovpn
fi


echo "
|--------------------------------|
| Configure a NordVPN connection |
|--------------------------------|
 - use email and password below
 - must be entered in connection manager manually
 - add NordVPN's DNS service 103.86.96.100
 - verify VPN works
 - disconnect VPN
"
pass show tools/nordvpn.com
echo
read -p "Press a key to continue ..." -n1 -r


echo "
|-------------------------|
| Install WHU's Cisco VPN |
|-------------------------|
 - go to https://vpn.whu.edu
 - use credentials below
 - start AnyConnect
 - download client as bash script
 - sudo run the script
 - configure to start vpn when AnyConnect is started (only option)
 - connect to 212.184.196.196
"
pass show university/whu/whu.edu
echo
firefox --new-tab "https://vpn.whu.edu" &
read -p "Press a key to continue ..." -n1 -r
