#!/bin/bash
#
# Copyright licht8 v.0.1.7
#
# Some hints for this script:
# https://stackoverflow.com/questions/24270733/automate-mysql-secure-installation-with-echo-command-via-a-shell-script
# https://linuxconfig.org/install-wordpress-on-redhat-8
# https://www.8host.com/blog/sozdanie-samopodpisannogo-ssl-sertifikata-dlya-apache-v-centos-8/
# https://infoit.com.ua/linux/kak-ustanovit-stek-lamp-na-centos-8/

# Find the IP address of the server
ip_address=$(ip a | awk '/inet / && !/127.0.0.1/ {split($2,a,"/"); print a[1]}')

if [ -z "$ip_address" ]; then
  echo "Unable to find the IP address of the server."
  exit 1
fi

# Check OS version
if ! grep -qiE "fedora|centos" /etc/*release; then
    echo "Unsupported OS. This script only supports Fedora and CentOS."
    exit 1
fi

# Check if script is being run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

# Install required packages
echo "Installing required packages..."
echo "Please wait a sec..."
if ! dnf install -y php-mysqlnd php-fpm mariadb-server httpd tar curl php-json > /dev/null; then
  echo "Failed to install required packages."
  exit 1
fi

# Allow http and https traffic
echo "Opening HTTP and optionally HTTPS port 80 and 443 on your firewall..."
if ! firewall-cmd --permanent --zone=public --add-service=http && \
  firewall-cmd --permanent --zone=public --add-service=https && \
  firewall-cmd --reload; then
  echo "Failed to open ports on the firewall."
  exit 1
fi

# Start and enable services
systemctl start mariadb
systemctl start httpd
systemctl enable mariadb
systemctl enable httpd
clear

while true; do
  echo "Enter a new password for the root account in MySQL:"
  read -s root_pass
  if [ -n "$root_pass" ]; then
    break
  else
    echo "Password cannot be empty. Please try again."
  fi
done
echo "Password is set to: $root_pass"

# Securing your MariaDB installation and set root password
echo "UPDATE mysql.user SET Password=PASSWORD('$root_pass') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE db='test' OR db='test\_%';
FLUSH PRIVILEGES;
EXIT" > __TEMP__.sql
mysql -u root < __TEMP__.sql
rm -f __TEMP__.sql
clear

# Reading data to create a database

# Collecting this for the database
echo "Enter the name of the database (Press Enter for default: wordpress):"
read database
if [ -z "$database" ]; then
    database="wordpress"
fi

# Collecting this for the user
echo "Enter the name of the user (Press Enter for default: wpuser):"
read db_user
if [ -z "$db_user" ]; then
    db_user="wpuser"
fi

# Collecting this for the password of the user
echo "Enter the password of the user (Press Enter for default: wppass):"
read db_user_pass
if [ -z "$db_user_pass" ]; then
    db_user_pass="wppass"
fi

# Create the database
echo "CREATE DATABASE $database;
CREATE USER \`$db_user\`@\`localhost\` IDENTIFIED BY '$db_user_pass';
GRANT ALL ON $database.* TO \`$db_user\`@\`localhost\`;
FLUSH PRIVILEGES;
EXIT" > __TEMP__.sql
mysql -u root < __TEMP__.sql
rm -f __TEMP__.sql
clear
 
# Download and extract WordPress
if curl https://wordpress.org/latest.tar.gz --output wordpress.tar.gz && tar xf wordpress.tar.gz && cp -r wordpress /var/www/html; then
  rm -f wordpress.tar.gz && rm -f wordpress
  echo "WordPress successfully installed and the wordpress.tar.gz archive removed"
else
  echo "Error when installing WordPress"
  exit 1
fi

# Set permissions and security context
if ! chown -R apache:apache /var/www/html/wordpress; then
  echo "Failed to change ownership to apache:apache."
  exit 1
fi
chcon -t httpd_sys_rw_content_t /var/www/html/wordpress -R
clear 

# Log events and errors
LOG_FILE="/var/log/wp-install.log"
exec > >(tee -i "$LOG_FILE")
exec 2>&1

# The end of the install
echo "WordPress has been successfully installed!"
echo "Access WordPress installation wizard and perform the actual WordPress installation."
echo "Navigate your browser to http://"$ip_address"/wordpress and follow the instructions. "
echo ""
echo "--Your database's data--"
echo "Database: $database"
echo "User: $db_user"
echo "User's Password: $db_user_pass"

exit 1