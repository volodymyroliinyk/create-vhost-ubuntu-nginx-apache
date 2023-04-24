#!/bin/bash
# Fast way create virtual host for Ubuntu Apache PHP.
# 1) Don`t use symbol "_" for local domain name.
# 2) Open file `/etc/hosts` and string `#localhost` to the end of file (one-time step).
# 3) Run script under `root` user: `sudo -s;sh create_host_apache.sh <your-domain-name.local>;`

new_site_name=$1
project_document_root="/var/www/html/$new_site_name"
project_sites_available="/etc/apache2/sites-available/$new_site_name.conf"
hosts_file="/etc/hosts"

echo "<VirtualHost $new_site_name:80>
	ServerName $new_site_name
	ServerAlias $new_site_name
	DocumentRoot $project_document_root

    <Directory $project_document_root>
            Options Indexes FollowSymLinks MultiViews
            AllowOverride All
            Order allow,deny
            allow from all
            Require all granted
    </Directory>


	ErrorLog /var/log/apache2/$new_site_name.error.log
	CustomLog /var/log/apache2/$new_site_name.access.log combined
</VirtualHost>" > $project_sites_available

mkdir $project_document_root
chmod 777 -R $project_document_root
echo "your first page" > $project_document_root/index.html
chmod 777 $project_document_root/index.html

ln -s $project_sites_available /etc/apache2/sites-enabled/

a2ensite $new_site_name.conf

sed -i "/\#localhost/a127.0.0.1 $new_site_name" $hosts_file

service apache2 restart
