echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Epson ET-2750 printer\033[0m\n'

sudo apt-get install -y lsb

cd "$HOME"

wget "https://download3.ebz.epson.net/dsc/f/03/00/10/49/18/41ef4e1bb2cb43759ae3173912fde3c37f9f4b98/epson-inkjet-printer-escpr_1.7.7-1lsb3.2_amd64.deb" -O epson-inkjet-printer-escpr.deb
sudo apt-get install -y ./epson-inkjet-printer-escpr.deb
rm epson-inkjet-printer-escpr.deb

wget "https://download3.ebz.epson.net/dsc/f/03/00/12/02/84/37855fd7347aeb11a3202c8b912088736f847653/epson-printer-utility_1.1.1-1lsb3.2_amd64.deb" -O epson-printer-utility.deb
sudo apt-get install -y ./epson-printer-utility.deb
rm epson-printer-utility.deb

wget "https://download2.ebz.epson.net/epsonscan2/common/deb/x64/epsonscan2-bundle-6.6.2.0.x64.deb.tar.gz" -O epsonscan2.deb.tar.gz
tar -xvf epsonscan2.deb.tar.gz
rm epsonscan2.deb.tar.gz
sudo ./epsonscan2-bundle-6.6.2.0.x86_64.deb/install.sh
rm -rf ./epsonscan2-bundle-6.6.2.0.x86_64.deb/


if [ -n "$SETUP_SYSTEM" ]; then

    echo "
|-------------------|
| Configure Printer |
|-------------------|
 - 'Settings' > 'Printer' > look in local WiFi
"
    read -p "Press a key to continue ..." -n1 -r

fi
