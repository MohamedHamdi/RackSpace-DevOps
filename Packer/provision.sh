#!/bin/bash
set -e

echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections

sudo apt-get update -y

sudo apt-get -y upgrade

sudo apt-get install curl -y

sudo apt-get install unzip -y

sudo apt-get install apache2 php libapache2-mod-php -y

sudo apt-get install php-{bcmath,bz2,intl,gd,mbstring,mcrypt,mysqli,zip} -y

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install

sudo rm -rf /var/www/html/index.html

sudo aws s3 cp s3://websitefilesbucket/index.php /var/www/html

sudo service apache2 restart

