# Creating sysvinit service (older Ubuntu and WSL)
sudo cp /home/odoo/odoo-12/debian/init /etc/init.d/odoo
sudo chmod +x /etc/init.d/odoo
sudo ln -s /home/odoo/odoo-12/odoo-bin /usr/bin/odoo
sudo chown -h odoo /usr/bin/odoo
sudo /etc/init.d/odoo start
sudo /etc/init.d/odoo status
sudo /etc/init.d/odoo stop
sudo update-rc.d odoo defaults
