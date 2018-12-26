# Update Odoo source code
sudo su odoo
cd ~/odoo-12
git tag --force 12-last-prod
git pull
# ~/odoo-12/odoo-bin -d odoo-stage --http-port=8080 -c /etc/odoo/odoo.conf  # optionally add: -u base 
exit
sudo service odoo restart  # or: sudo systemctl restart odoo

# Undo code update
sudo su odoo
cd ~/odoo-12
git checkout 12-last-prod
exit

# Upgrade production database
sudo service odoo stop
sudo su -c "~/odoo-12/odoo-bin -c /etc/odoo/odoo.conf -u base --stop-after-init" odoo
sudo service odoo start
