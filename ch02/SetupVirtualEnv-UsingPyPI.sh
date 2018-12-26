source ~/odoo-dev/odoo12env/bin/activate
pip install odoo12-addon-partner-fax
odoo -c ~/odoo-dev/odoo12-env/12-library.conf -i partner_fax --stop
