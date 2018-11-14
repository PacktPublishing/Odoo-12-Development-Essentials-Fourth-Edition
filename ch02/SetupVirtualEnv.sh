# Install Odoo from source
#mkdir ~/odoo-dev  # Create a directory to work in
#cd ~/odoo-dev  # Go into our work directory
#git clone https://github.com/odoo/odoo.git -b 12.0 --depth=1  # Get Odoo sources

# Create Odoo configuration file for Library project
#cd ~/odoo-dev
#git clone https://github.com/PacktPublishing/Odoo-12-Development-Essentials-Fourth-Edition library-app

# Create and activate virtualenv
virtualenv -p python3 ~/odoo-dev/odoo12env
source ~/odoo-dev/odoo12env/bin/activate

# Install Odoo in the virtualenv
pip install -e ~/odoo-dev/odoo
pip install num2words phonenumbers psycopg2-binary watchdog xlwt
odoo -c ~/odoo-dev/odoo12env/12-library.conf -d 12-library --addons-path=~/odoo-dev/library-app --save --stop-after-init
