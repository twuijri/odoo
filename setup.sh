#!/bin/bash


#add langoeg in python
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales


hostname=$(cat /etc/hostname)
sed -i "3i\127.0.1.1 $hostname" /etc/hosts


sudo apt -y update
sudo apt -y upgrade

#Install pip 3
sudo apt install -y python3-pip


sudo apt install -y build-essential python3-dev python2.7-dev libldap2-dev libsasl2-dev slapd ldap-utils python-tox lcov valgrind

sudo adduser --system --home=/opt/odoo --group odoo

#Install PostgreSQL:
sudo apt install -y postgresql
sudo su - postgres
createuser --createdb --username postgres --no-createrole --no-superuser --pwprompt odoo12
exit

sudo pip3 install Babel chardet decorator docutils ebaysdk feedparser gevent greenlet html2text Jinja2 libsass lxml Mako MarkupSafe mock num2words ofxparse passlib Pillow psutil psycopg2 pydot pyldap pyparsing PyPDF2 pyserial python-dateutil pytz pyusb PyYAML qrcode reportlab requests suds-jurko vatnumber vobject Werkzeug XlsxWriter xlwt xlrd

sudo apt install -y npm
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo npm install -g less less-plugin-clean-css
sudo apt install -y node-less

sudo wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb

sudo apt install -y git

sudo su - odoo -s /bin/bash
git clone https://www.github.com/odoo/odoo --depth 1 --branch 12.0 --single-branch
exit


sudo mkdir /var/log/odoo
sudo chown odoo:root /var/log/odoo
sudo mv /opt/odoo/odoo /opt/odoo/odoo1
sudo mv /opt/odoo/odoo1/* /opt/odoo
sudo rm -fr /opt/odoo/odoo1
sudo cp /opt/odoo/debian/odoo.conf /etc/odoo.conf
#print odoo.conf
cat > /etc/odoo.conf <<END
[options]
; This is the password that allows database operations:
; admin_passwd = admin
db_host = odoo
db_port = 8069
db_user = odoo
db_password = False
addons_path = /opt/odoo/addons
logfile = /var/log/odoo/odoo.log
END
done < "/etc/odoo.conf"

sudo chown odoo: /etc/odoo.conf
sudo chmod 640 /etc/odoo.conf

#print odoo.service
cat > /etc/systemd/system/odoo.service <<END
[Unit]
Description=Odoo
Documentation=http://www.odoo.com
[Service]
# Ubuntu/Debian convention:
Type=simple
User=odoo
ExecStart=/opt/odoo/odoo-bin -c /etc/odoo.conf
[Install]
WantedBy=default.target
END
done < "/etc/systemd/system/odoo.service"


sudo chmod 755 /etc/systemd/system/odoo.service
sudo chown root: /etc/systemd/system/odoo.service

sudo systemctl start odoo.service
sudo tail -f /var/log/odoo/odoo.log
sudo systemctl enable odoo.service

