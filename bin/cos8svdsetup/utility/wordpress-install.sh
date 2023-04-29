#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
source /root/.bashrc

echo ;


	lang=$1 ;
	if [[ $1 == "" ]] ; then lang=cr ; fi ;
function msg_preparation_for_WordPress() {

ttb=$(echo -e "
 ⎧ Подготовка сервера для установки  
 ⎩ WordPress под управлением Nginx.
   " ) && lang_cr && bpn_p_lang ; ttb=""  ;
   }

# Настройка безопасности в mariadb_server (стартовое сообщение)
function msg_start_mysql_secure_installation() {
	lang=nix
	
	ttb=$(echo -e "
 ⎧ 3) Для удобства, откройте в другой вкладке 
 | терминала еще одну ssh сессию и введите: 
 | # mysql_secure_installation
 | 
 | Затем в этой вкладке нажмите 'Enter'
 | Откроется краткая инструкция по настройке:
 | \"Secure MariaDB Server\"
 | (mysql_secure_installation)
 | 
 | В новой вкладке выполните все шаги 
 | описанные в этой инструкции и снова  
 ⎩ нажмите 'Enter' чтобы продолжить...
 " ) && bpn_p_lang ;

	lang=help
 ttb=$(echo -e " 
 The ${green}mysql_secure_installation${nc} command 
 helps us to improve the security of the MariaDB 
 installation.
 
 With this command,
 
 - You can ${green}set a password${nc} for root accounts.
 - You can ${green}remove root accounts${nc} that are 
 accessible from outside the local host.
 - You can ${green}remove anonymous-user accounts${nc}.
 - You can ${green}remove the test database${nc} 
 (which by default can be accessed by all users, 
 even anonymous users), and ${green}privileges${nc} that 
 permit anyone to access databases with names that 
 start ${green}with test_.${nc}
 
	") && bpn_p_lang ;
}

# Настройка безопасности в mariadb_server (Инструкция)
function msg_mysql_secure_installation() {
	lang=help
	clear ;
	ttb=$(echo -e "
	
 NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
 	  SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!
 In order to log into MariaDB to secure it, we'll need the current
 password for the root user.  If you've just installed MariaDB, and
 you haven't set the root password yet, the password will be blank,
 so you should just press enter here.
 Enter current password for root (enter for none):  ${green}<< ${cyan}Just Press Enter as password is not set yet ${nc}
 OK, successfully used password, moving on...
 Setting the root password ensures that nobody can log into the MariaDB
 root user without the proper authorisation.
 Set root password? [Y/n] ${green}Y  << Type Y ${cyan}to set MariaDB root password${nc}
 New password: ${green} << ${cyan}Enter MariaDB root password${nc}
 Re-enter new password:  ${green} << ${cyan}Confirm  MariaDB root password${nc}
 Password updated successfully!
 Reloading privilege tables..
  ${green}... Success!${nc}
 By default, a MariaDB installation has an anonymous user, allowing anyone
 to log into MariaDB without having to have a user account created for
 them.  This is intended only for testing, and to make the installation
 go a bit smoother.  You should remove them before moving into a
 production environment.
 Remove anonymous users? [Y/n] ${green}Y << Type Y ${red}to remove anonymous users${nc}
  ${green}... Success!${nc}
 Normally, root should only be allowed to connect from 'localhost'.  This
 ensures that someone cannot guess at the root password from the network.
 Disallow root login remotely? [Y/n] ${green}Y  << Type Y ${red}to disable root login remotely${nc}
  ${green}... Success!${nc}
 By default, MariaDB comes with a database named 'test' that anyone can
 access.  This is also intended only for testing, and should be removed
 before moving into a production environment.
 Remove test database and access to it? [Y/n] ${green}Y << Type Y ${red}to remove test database${nc}
  - Dropping test database...
  ${green}... Success!${nc}
  - Removing privileges on test database...
  ${green}... Success!${nc}
 Reloading the privilege tables will ensure that all changes made so far
 will take effect immediately.
 Reload privilege tables now? [Y/n] ${green}Y << Type Y ${cyan}to reload privillege table${nc}
  ${green}... Success!${nc}
 Cleaning up...
 ${green}All done!  ${cyan}If you've completed all of the above steps, your MariaDB
 installation should now be secure.
 Thanks for using MariaDB!${nc}
 
	" ) && bpn_p_lang ;
}

# Настройка безопасности в mariadb_server
function mysql_secure() {
	 
	msg_start_mysql_secure_installation && press_anykey && msg_mysql_secure_installation && press_anykey

}

# Установка запуск и добавление в автозагрузку mariadb
function install_start_enable_mariadb_server() {
	     
	 function install_mariadb() {
		 yum -y install mariadb mariadb-server  ;
	 }
	 
	 function enable_start_mariadb() {
		 systemctl start mariadb  ;
		 systemctl enable mariadb  ;
	 }
	 
	 function msg_done_install_start_enable_mariadb_server() {
		 lang=nix
 (ttb=$(echo -e "
 ⎧ База данных \"MariaDB\" успешно
 | установлена и добавлена в автозагрузку!
 | systemctl start  mariadb 'Done'
 ⎩ systemctl enable mariadb 'Done'
 " ) && bpn_p_lang ; ttb="" ) ;
	 }
	 
	 function msg_pre_install_start_enable_mariadb_server() {
		 lang=nix
 (ttb=$(echo -e "
 ⎧ 2) Пожалуйста подождите, устанавливаем
 | \"MariaDB\", добавляем в автозагрузку!
 | # systemctl start  mariadb
 ⎩ # systemctl enable mariadb
 " ) && bpn_p_lang ; ttb="" ) ;
	 }	 
	 
	 msg_pre_install_start_enable_mariadb_server ;
	 
	 ( install_mariadb && enable_start_mariadb ) && msg_done_install_start_enable_mariadb_server && msg_done || echo error msg_pre_install_start_enable_mariadb_server ;
}

# Добавление Remi_Repository
function Add_Remi_Repository() {
	lang=nix
	(ttb=$(echo -e " 
 ⎧ 1) Add Remi Repository
 | Remi, a third-party repository which offers 
 | multiple versions of PHP (7.4 / 7.3 / 7.2) 
 | for Red Hat Enterprise Linux.
 | Remi repository requires EPEL repository 
 | be enabled on your system.
 ⎩ Пожалуйста подождите...
 " ) && bpn_p_lang ; ttb="" ) ;
	
	
	rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm  ;
	( dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm  ) && msg_done || echo error Add_Remi_Repository ;
	
	(ttb=$(echo -e " 
 ⎧ List the available PHP module stream.
 ⎩ # dnf module list php" ) && bpn_p_lang ; ttb="" ) ;
 
 (ttb=$(echo -e "
 ⎧ If you have installed php not from remi-7.4 
 ${red}|${nc} and you need to manually change the 
 ${red}|${nc} repositories from CentOS Stream 8 - AppStream
 ${red}|${nc} to php:remi-7.4, enter the command in the console:
 ${red}| ${blink}#${red} dnf module reset php${nc}
 ⎩ and relaunch this script!
 " ) && lang=help && bpn_p_lang ; ttb="" ) ;
	
	dnf module list php ;

}

# Установка PHP_7_4
function Install_PHP_7_4() {
	lang=nix
	(ttb=$(echo -e "
 ⎧ 4) Install PHP 7.4 on CentOS 8 / RHEL 8
 | Enable php:remi-7.4 module to install PHP 7.4.
 | Пожалуйста подождите...
 |
 ⎩ Check PHP Version 
  " ) && bpn_p_lang ; ttb="" ) ;
  
  lang=c
  dnf module enable php:remi-7.4 -y  ;
  ( dnf install -y php php-cli php-common  ; ) && msg_done && echo || echo error Install_PHP_7_4;
  
  # Install_PHP_7_4 ;
  (ttb=$(echo -e "$(php -v)" ) && bpn_p_lang ; ttb="" ; echo ) ;
  
}

# Установка PHP-FPM
function Install_PHP_FPM() {
	lang=nix
	(ttb=$(echo -e " ⎧ 5) Install PHP-FPM
 | If you are setting up LEMP stack on RHEL 8, 
 | you might want to install php-fpm.
 ⎩ Пожалуйста подождите...
	" ) && bpn_p_lang ; ttb="" ) ;
	
	(dnf install -y php-fpm  ;) && msg_done || echo error Install_PHP_FPMs ;
}

# Установка PHP_Extensions
function Install_PHP_Extensions() {
	lang=nix
	(ttb=$(echo -e "
 ⎧ 6) Install PHP Extensions
 | PHP extensions are compiled libraries which 
 | enables specific support for your code.
 | To have MySQL support on your code, you can 
 | install php-mysqlnd package.
 ⎩ Пожалуйста подождите...
	" ) && bpn_p_lang ; ttb="" ) ;
	
	(dnf install -y php-mysqlnd  ;) && msg_done || echo error Install_PHP_Extensions ;
	#&>/dev/null
	lang=nix
	(ttb=$(echo -e "
 ⎧ Once you have installed MySQL extension, 
 ⎩ you can use the below command to verify it.	
  " ) && bpn_p_lang ; ttb="" ) ;
	lang=conf
	( ttb=$( php -m | grep -i mysql ) && bpn_p_lang ; ttb="" ) 
}

# Установка PHP_Extensions_for_WordPress
function PHP_Extensions_for_WordPress() {
	lang=nix
	(ttb=$(echo -e "
 ⎧ 7) PHP Extensions for WordPress
 | The following extensions are required 
 | to install and run WordPress on your RHEL 8 
 | machine. WordPress recommends PHP v7.3 for 
 | the installation.
 ⎩ Пожалуйста подождите...
	" ) && bpn_p_lang ; ttb="" ) ;
 
	(dnf install -y php-dom php-simplexml php-ssh2 php-xml php-xmlreader php-curl php-date php-exif php-filter php-ftp php-gd php-hash php-iconv php-json php-libxml php-pecl-imagick php-mbstring php-mysqlnd php-openssl php-pcre php-posix php-sockets php-spl php-tokenizer php-zlib ;) && msg_done || echo error PHP_Extensions_for_WordPress ;

}

# Установка PHP_Extensions_for_Joomla
function PHP_Extensions_for_Joomla() {
	lang=nix
	(ttb=$(echo -e "
 ⎧ PHP Extensions for Joomla
 | The following extensions are required to install
 | and run Joomla on your RHEL 8 machine. Joomla 
 | requires PHP v7.1 and above.
 ⎩ Пожалуйста подождите...
	" ) && bpn_p_lang ; ttb="" ) ;
	
	( dnf install -y php-mysqlnd php-zlib php-xml php-pear php-json php-mcrypt php-pecl-imagick ; ) && msg_done || echo error PHP_Extensions_for_Joomla ;

}

# Установка PHP_Extensions_for_Drupal
function PHP_Extensions_for_Drupal() {
	lang=nix
	(ttb=$(echo -e "
 ⎧ PHP Extensions for Drupal
 | The following extensions are required to install 
 | and run Joomla on your RHEL 8 machine. Drupal 
 | requires PHP v7.1 and above.
 ⎩ Пожалуйста подождите...
	" ) && bpn_p_lang ; ttb="" ) ;
	
	(dnf install -y php-mysqlnd php-date php-dom php-filter php-gd php-hash php-json php-pcre php-pdo php-session php-simplexml php-spl php-tokenizer php-xml ;) && msg_done || echo error PHP_Extensions_for_Drupal ;
}



function pre_install_wordpress() {
	
  # сообщение заголовока подготовки для вордпресса.
  msg_preparation_for_WordPress ;
  
	# 1) Добавление Remi_Repository
	Add_Remi_Repository ;
	
	# 2) Установка запуск и добавление в автозагрузку mariadb
	install_start_enable_mariadb_server ;
	
	# 3) Настройка безопасности в mariadb_server
	mysql_secure ;
	
	# 4) Установка PHP_7_4
	Install_PHP_7_4 ;
	
	# 5) Установка PHP-FPM
	Install_PHP_FPM ;
	
	# 6) Установка PHP_Extensions
	Install_PHP_Extensions ;
	
	# 7) Установка PHP_Extensions_for_WordPress
	PHP_Extensions_for_WordPress ;
	
	return ;
}


function virtual_host_file() {
	DName=$1

echo "
#	# Upstream to abstract backend connection(s) for php
#	upstream php {
#		server unix:/tmp/php-cgi.socket;
#		server 127.0.0.1:9000;
#	}

# Upstream to abstract backend connection(s) for php
 upstream php {
		server unix:/tmp/php-cgi.socket;
		server 127.0.0.1:9000;
	}
	
	server {
		## Your website name goes here.
		listen 80;
		server_name $DName;
		## Your only path reference.
		root /sites/$DName/public_html/;
		## This should be in your http block and if it is, it's not needed here.
		index index.html index.php;
		access_log /sites/$DName/logs/access.log;
		error_log /sites/$DName/logs/error.log;
		# Don't allow pages to be rendered in an iframe on external domains.
		add_header X-Frame-Options \"SAMEORIGIN\";
		# MIME sniffing prevention
		add_header X-Content-Type-Options \"nosniff\";
		# Enable cross-site scripting filter in supported browsers.
		add_header X-Xss-Protection \"1; mode=block\";
		# Prevent access to hidden files
		
	location ~* /\.(?!well-known\/) {
		deny all;
	}
		
	# Prevent access to certain file extensions
	location ~\.(ini|log|conf)$ {
		deny all;
	}

	# Enable WordPress Permananent Links
	# This is cool because no php is touched for static content.
	# include the \"?\$args\" part so non-default permalinks doesn't break when using query string
	location / {
		try_files \$uri \$uri/ /index.php?\$args;
	}
	
	location = /favicon.ico {
		log_not_found off;
		access_log off;
		}
	
	location = /robots.txt {
		allow all;
		log_not_found off;
		access_log off;
		}
	
	
	location ~ \.php$ {
		#NOTE: You should have \"cgi.fix_pathinfo = 0;\" in php.ini
		include /etc/nginx/fastcgi_params;
		fastcgi_intercept_errors on;
		fastcgi_pass php;
		#The following parameter can be also included in fastcgi_params file
		fastcgi_param  SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
	
		location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
		expires max;
		log_not_found off;
		}
	}
	}" 
	} > /etc/nginx/conf.d/$DName.conf



function Configure_Nginx_Server_block_for_WordPress() {
  
  function msg_found() {
      ttb=$(echo -e " 
 ⎧ The configuration file /etc/nginx/conf.d/$DName.conf 
 | already exists. To re-create the config, first delete
 | manually old $DName.conf and restart this script.
 ⎩ # rm /etc/nginx/conf.d/$DName.conf
 ") && lang=cr && bpn_p_lang ; ttb=""  ;
      
      
  }
		
ttb=$(echo -e "  
 ⎧ Configure Nginx Server block for WordPress
 | Let’s create a server block for WordPress installation. 
 | Virtual host configuration files can be found 
 ⎩ under /etc/nginx/conf.d directory." ) && lang=java && bpn_p_lang ; ttb=""  ;
     
ttb=$(echo -en " 
 ⎧ Enter a domain name for the Wordpress site" ) && bpn_p_lang ; 
 echo -en " $(black_U23A9) $(green_arrow) ${RED}:${GREEN} " ; read DName ;
    
	echo -e "${nc}"
	 
ttb=$(echo -e "
 ⎧ Creating a server block 
 ⎩ for the following:
      
 ⎧ Domain Name: $DName
 | Port No: 80
 | Document Root: /sites/$DName/public_html
 ⎩ Logs: /sites/$DName/logs
     
 ⎧ First, create a virtual host file. (ok)
 ⎩ nano /etc/nginx/conf.d/$DName.conf " ) && bpn_p_lang ; ttb=""  ;
     
ttb=$(echo -e " 
 ⎧ Place the following content. (ok)
 ⎩ # bat /etc/nginx/conf.d/$DName.conf" ) && bpn_p_lang ; ttb=""  ;
     
#if [[ -z /etc/nginx/conf.d/$DName.conf ]] ; then echo ok ; else msg_found && return ; fi

virtual_host_file $DName && msg_done ;
     
ttb=$(echo -e " 
 ⎧ Create document root and logs directory. (ok)
 | # sudo mkdir -p /sites/$DName/public_html/
 ⎩ # sudo mkdir -p /sites/$DName/logs/
     
" ) && bpn_p_lang ; ttb=""  ;
     
sudo mkdir -p /sites/$DName/public_html/ && msg_done ;
sudo mkdir -p /sites/$DName/logs/ && msg_done;
     
ttb=$(echo -e "
 ⎧ Verify the configuration files.
 ⎩ # nginx -t" ) && bpn_p_lang ; ttb=""  ;
     
	 echo -e "${green}"
nginx -t ;
     echo -e "${nc}"
ttb=$(echo -e "
 ⎧ The below output confirms that there is 
 | no syntax error in the server block.
 | 
 | nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
 ⎩ nginx: configuration file /etc/nginx/nginx.conf test is successful" ) && bpn_p_lang ; ttb=""  ;
     
ttb=$(echo -e "
 ⎧ Restart the services.
 | # systemctl restart nginx
 ⎩ # systemctl restart php-fpm
     
 ⎧ If you get any error while restarting the 
 | Nginx service, then disable 
 | SELinux on your machine.
 ⎩ # setenforce 0
 " ) && bpn_p_lang ; ttb=""  ;
     
press_anykey ;
systemctl restart nginx && msg_done ;
systemctl restart php-fpm && msg_done ;
     
}


function certbot_nginx() {
    
ttb=$(echo -e "
 ⎧ Установка Certbot на CentOS 8 для получения 
 ⎩ бесплатного SSL/TLS сертификата Let's Encrypt
 " ) && lang_cr && bpn_p_lang ; ttb=""  ;
 
ttb=$(echo -e "
 ⎧ 1. Включаем репозиторий EPEL в CentOS 8
 |
 ⎩ # yum install epel-release
 " ) && lang_nix && bpn_p_lang ; ttb=""  ;
 
     epel_repo_Check_or_install && msg_done ;

 
 ttb=$(echo -e "
 ⎧ 2. Устанавливаем Certbot
 | # snap install --classic certbot
 ⎩ # ln -s /snap/bin/certbot /usr/bin/certbot
 " ) && bpn_p_lang ; ttb=""  ;
 
     snap install --classic certbot && msg_done ;
     ln -s /snap/bin/certbot /usr/bin/certbot && msg_done

ttb=$(echo -e "
 ⎧ 3. Запускаем Certbot для получения сертификата 
 | для вашего домена под управлением nginx
 | Пожалуста внимательно прочтите сообщения Certbot,
 | согласитесь с условиями, введите e-mail адрес для 
 | дальнейшего администрирования данного сертификата
 | и его обновления в будущем.
 |
 ⎩ # certbot --nginx
 " ) && bpn_p_lang ; ttb=""  ;
 
     certbot --nginx && msg_done
}


pre_install_wordpress ;
Configure_Nginx_Server_block_for_WordPress ;
snap_install ;
certbot_nginx ;

exit 0 ;




------------
https://nodejs.org/ru/
dnf module install nodejs - не ставить

dnf module list nodejs - посмотреть что есть 10 или 18 или ничего
dnf module reset nodejs - сбросить если на 10
dnf module install nodejs:18/common - установить 18

--------


# dnf install snapd
# sudo systemctl enable snapd.socket --now
# sudo ln -s /var/lib/snapd/snap /snap

Хорошо, после включения Snap socket выйдите из системы один раз,
И войдите обратно, чтобы гарантировать обновление snap.
Теперь мы сможем устанавливать приложения из магазина snap.
(пример sudo snap install vlc)



⎧
⎩

# https://www.itzgeek.com/how-tos/linux/centos-how-tos/how-to-install-wordpress-with-nginx-on-centos-8-rhel-8.html

# https://www.itzgeek.com/how-tos/mini-howtos/securing-mysql-server-with-mysql_secure_installation.html

# https://www.itzgeek.com/how-tos/linux/centos-how-tos/how-to-install-php-7-3-on-rhel-8.html