sudo apt-get remove --purge wkhtmltopdf
wget "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb" -O  /tmp/wkhtml.deb
sudo dpkg -i /tmp/wkhtml.deb
sudo apt-get -f install 
wkhtmltopdf --version
