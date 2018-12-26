sudo apt install python-dev  # Ensure Python2  is available
cd ~/odoo-dev
git clone https://github.com/odoo/odoo.git -b 10.0 --depth=1 odoo10
virtualenv odoo10env
source odoo10env/bin/activate
pip install -e ./odoo10
odoo --version
deactivate  # To finish working with this env
