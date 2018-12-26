sudo apt-get install nginx
sudo service nginx start  # start nginx, if not already started

sudo rm /etc/nginx/sites-enabled/default
sudo touch /etc/nginx/sites-available/odoo
sudo ln -s /etc/nginx/sites-available/odoo /etc/nginx/sites-enabled/odoo

# edit Nginx configuration file
# sudo nano /etc/nginx/sites-available/odoo

# create self signed certificate
sudo mkdir /etc/ssl/nginx && cd /etc/ssl/nginx
sudo openssl req -x509 -newkey rsa:2048 -keyout server.key -out server.crt -days 365 -nodes
sudo chmod a-wx *            # make files read only
sudo chown www-data:root *   # access only to www-data group


sudo nginx -t
sudo /etc/init.d/nginx reload
sudo systemctl reload nginx 
curl http://localhost
