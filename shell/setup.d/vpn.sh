echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling VPNs\033[0m\n'
sudo apt-get install -y\
    openvpn\
        openvpn-systemd-resolved\
        network-manager-openvpn\
        network-manager-openvpn-gnome\
        resolvconf\
    remmina

# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


echo -e "\nConfiguring NordVPN"
sudo mkdir /etc/openvpn/nordvpn
cd /etc/openvpn/nordvpn
sudo wget https://nordvpn.com/api/files/zip
sudo unzip -qq zip
sudo rm zip
cd "$HOME"
# Use NordVPN's nameserve to prevent leaks
echo "nameserver 103.86.96.100" | sudo tee -a /etc/resolvconf/resolv.conf.d/head > /dev/null
echo "nameserver 103.86.99.100" | sudo tee -a /etc/resolvconf/resolv.conf.d/head > /dev/null
# Try to install some of NordVPN's servers
if [ -f /etc/openvpn/nordvpn/de666.nordvpn.com.tcp443.ovpn ]; then
    echo "Installing NordVPN's de666 server"
    sudo nmcli connection import type openvpn file /etc/openvpn/nordvpn/de666.nordvpn.com.tcp443.ovpn
    sudo nmcli connection import type openvpn file /etc/openvpn/nordvpn/de666.nordvpn.com.udp1194.ovpn
elif [ -f /etc/openvpn/nordvpn/de777.nordvpn.com.tcp443.ovpn ]; then
    echo "Installing NordVPN's de777 server"
    sudo nmcli connection import type openvpn file /etc/openvpn/nordvpn/de777.nordvpn.com.tcp443.ovpn
    sudo nmcli connection import type openvpn file /etc/openvpn/nordvpn/de777.nordvpn.com.udp1194.ovpn
elif [ -f /etc/openvpn/nordvpn/de888.nordvpn.com.tcp443.ovpn ]; then
    echo "Installing NordVPN's de888 server"
    sudo nmcli connection import type openvpn file /etc/openvpn/nordvpn/de666.nordvpn.com.tcp443.ovpn
    sudo nmcli connection import type openvpn file /etc/openvpn/nordvpn/de888.nordvpn.com.udp1194.ovpn
else
    echo "WARNING: none of the listed NordVPN servers installed"
fi

echo "
|--------------------------------|
| Configure a NordVPN connection |
|--------------------------------|
 - use email and password below
 - must be entered in connection manager manually
 - verify VPN works
 - disconnect VPN
"
pass show tools/nordvpn.com
echo
read -p "Press a key to continue ..." -n1 -r

echo -e "\nSetting up the StB Rath VPN"
source "$SH_SCRIPTS/aliases.d/vaults.sh"
open-dropbox-vault
mkdir -p "$HOME/.cert/stb-rath"
cp $HOME/vaults/dropbox-vault/keys/stb-rath/* "$HOME/.cert/stb-rath/"
close-dropbox-vault
sudo nmcli connection import type openvpn file "$HOME/.cert/stb-rath/rath_local_Rath_RW.ovpn"
rm "$HOME/.cert/stb-rath/rath_local_Rath_RW.ovpn"

echo "
|----------------------------|
| Configure the StB Rath VPN |
|----------------------------|
 - use login and password below
 - must be entered in connection manager manually
 - rename the connection to 'StB Rath'
 - verify VPN works
 - disconnect VPN
"
pass show admin/stb-rath
echo
read -p "Press a key to continue ..." -n1 -r

echo -e "\nInstalling Remmina"
mkdir -p "$HOME/.config/remmina"
mv "$HOME/.cert/stb-rath/remmina.pref" "$HOME/.config/remmina/remmina.pref"
mkdir -p "$HOME/.local/share/remmina"
mv "$HOME/.cert/stb-rath/stb-rath.remmina" "$HOME/.local/share/remmina/stb-rath.remmina"
remmina >/dev/null 2>/dev/null &

echo "
|--------------------------------------|
| Check Remmina connection to StB Rath |
|--------------------------------------|
 - use credentials below
 - disconnect VPN
"
pass show admin/stb-rath
echo
read -p "Press a key to continue ..." -n1 -r
echo

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
pass show university/whu.edu
echo
firefox --new-tab "https://vpn.whu.edu" &
read -p "Press a key to continue ..." -n1 -r
