echo -e '\n\033[36m\033[2m\033[1m\033[7mInstalling Epson ET-2750 printer\033[0m\n'

sudo apt install -y lsb

cd "$HOME"

wget "https://download3.ebz.epson.net/dsc/f/03/00/12/68/34/2e31ccec559abcb6d1071e71d379b92157501046/epson-inkjet-printer-escpr_1.7.10-1lsb3.2_amd64.deb" -O epson-inkjet-printer-escpr.deb
sudo apt install -y ./epson-inkjet-printer-escpr.deb
rm epson-inkjet-printer-escpr.deb

wget "https://download3.ebz.epson.net/dsc/f/03/00/12/70/13/58f31de84cf12b698276da9682dde9bf72cf70a9/epson-printer-utility_1.1.1-1lsb3.2_amd64.deb" -O epson-printer-utility.deb
sudo apt install -y ./epson-printer-utility.deb
rm epson-printer-utility.deb

wget "https://download2.ebz.epson.net/epsonscan2/common/deb/x64/epsonscan2-bundle-6.6.2.3.x86_64.deb.tar.gz" -O epsonscan2.deb.tar.gz
tar -xvf epsonscan2.deb.tar.gz
rm epsonscan2.deb.tar.gz
sudo ./epsonscan2-bundle-6.6.2.3.x86_64.deb/install.sh
rm -rf ./epsonscan2-bundle-6.6.2.3.x86_64.deb/


if [ -n "$SETUP_SYSTEM" ]; then

    echo "
|-------------------|
| Configure Printer |
|-------------------|
 - 'Settings' > 'Printer' > look in local WiFi
"
    read -p "Press a key to continue ..." -n1 -r

fi
