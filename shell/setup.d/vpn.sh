echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling VPNs\033[0m\n'


# Lines below this are only executed during installation.
[ -z "$SETUP_SYSTEM" ] && return


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
