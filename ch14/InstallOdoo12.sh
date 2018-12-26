# Install the PostgreSQL database
sudo apt update
sudo apt upgrade -y
sudo apt install postgresql -y # Install PostgreSQL
sudo su -c "createuser -s $USER" postgres # Create db superuser

# Install the Odoo system dependencies
sudo apt install git  # Install Git
sudo apt install python3-dev python3-pip # Python 3 for dev
sudo apt install build-essential libxslt-dev libzip-dev libldap2-dev libsasl2-dev libssl-dev

# Install wkhtmltox, which is needed to print reports
wget "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox-0.12.5_linux-bionic-amd64.deb" -O /tmp/wkhtml.deb
sudo dpkg -i /tmp/wkhtml.deb
sudo apt-get -fy install  # Fix dependency errors

# Install Python dependencies
wget https://raw.githubusercontent.com/odoo/odoo/12.0/requirements.txt
sudo -H pip3 install -r requirements.txt

# Preparing a dedicated system user
sudo adduser --disabled-password --gecos "Odoo" odoo
sudo su -c "createuser odoo" postgres
createdb --owner=odoo odoo-prod

# Install Odoo from source
sudo su odoo
git clone https://github.com/odoo/odoo.git /home/odoo/odoo-12 -b 12.0 --depth=1
/home/odoo/odoo-12/odoo-bin --version
exit

# Setting up the configuration file
sudo su -c "~/odoo-12/odoo-bin -d odoo-prod --db-filter='^odoo-prod$' --without-demo=all -i base --save --stop-after-init" odoo
sudo mkdir /etc/odoo
sudo cp /home/odoo/.odoorc /etc/odoo/odoo.conf
sudo chown -R odoo /etc/odoo
sudo chmod u=r,g=rw,o=r /etc/odoo/odoo.conf  # for extra hardening

sudo mkdir /var/log/odoo
sudo chown odoo /var/log/odoo

# Edit the Odoo conf file
# sudo nano /etc/odoo/odoo.conf

# Check the server starts correctly
# sudo su -c "~/odoo-12/odoo-bin -c /etc/odoo/odoo.conf --stop" odoo

# Follow the server log
# sudo tail -f /var/log/odoo/odoo-server.log

# Creating systemd service (recent native Ubuntu)
# /lib/systemd/system/odoo.service
# sudo systemctl enable odoo.service
# sudo systemctl start odoo
# sudo systemctl status odoo
# sudo systemctl stop odoo

# Creating sysvinit service (older Ubuntu and WSL)
sudo cp /home/odoo/odoo-12/debian/init /etc/init.d/odoo
sudo chmod +x /etc/init.d/odoo
sudo ln -s /home/odoo/odoo-12/odoo-bin /usr/bin/odoo
sudo chown -h odoo /usr/bin/odoo
sudo /etc/init.d/odoo start
sudo /etc/init.d/odoo status
sudo /etc/init.d/odoo stop
sudo update-rc.d odoo defaults

# Using the service command
sudo service odoo start
sudo service odoo status
sudo service odoo stop

