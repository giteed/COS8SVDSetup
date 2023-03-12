#!/bin/bash

# Source global definitions
# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc


# --> Функция: проверка обновление или установка gitHub 
function GitHub_install() {
	# Fedora, CentOS, Red Hat Enterprise Linux (dnf)
	# Install from our package repository for immediate access to latest releases:
	# https://github.com/cli/cli/blob/trunk/docs/install_linux.md

# --> Функция: проверка обновление или установка gitHub при участии bat
function GitHub_install_bat() {
		sudo dnf install -y 'dnf-command(config-manager)' | bat --paging=never -l nix -p 2>/dev/null ;
		sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo | bat --paging=never -l nix -p 2>/dev/null ;
		sudo dnf install -y gh | bat --paging=never -l nix -p 2>/dev/null ;
	}
	
# --> Функция: проверка обновление или установка gitHub без участия bat	
function GitHub_install_NO_bat() {
		sudo dnf install -y 'dnf-command(config-manager)' ;
		sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo ;
		sudo dnf install -y gh ;
	}
	GitHub_install_bat || GitHub_install_NO_bat ;
}

# --> ФУНКЦИЯ: Проверка установки GitHub и если не найден - пишет "не найден" а затем запускает установку
 function GitHubCH() {
	 [[ -z $( ls /usr/bin/gh  ) ]] 2>/dev/null && echo -e " gh GitHub    : $( not_found_MSG ) \n" && GitHub_install || sudo yum update gh -y &>/dev/null  ;
	 
}

# --> ФУНКЦИЯ: Проверка установки GitHub и если не найден - пишет "не найден", если найден обновит sudo yum update gh -y и покажет версию
function GitHub_info_and_update() {
	echo -e "\n   Проверка установки GitHub: " ;
	echo -e " $(green_star) Если GitHub не установлен - будет произведена его установка " ;
	echo -e " $(green_star) Если GitHub установлен - будет произведено обновление\n" ;
	GitHubCH || echo -en " gh GitHub    : $(found_MSG) \n" && echo ; cat /etc/yum.repos.d/gh-cli.repo 2>/dev/null | grep name 2>/dev/null | bat --paging=never -l nix -p 2>/dev/null ; ww gh 2>/dev/null ; 
# --> ФУНКЦИЯ: покажет версию при участии bat
	function version_GH_bat() {
		echo -en $(green_star) ; echo -e " GitHub version : $( gh --version 2>/dev/null || $(not_found_MSG) )" | bat --paging=never -l nix -p 2>/dev/null ;
	}
# --> ФУНКЦИЯ: покажет версию без участия bat	
	function version_GH_NO_bat() {
		echo -en $(green_star) ; echo -en " GitHub version : $( gh --version 2>/dev/null || $(not_found_MSG) )" ;
		
	}
	version_GH_bat || version_GH_NO_bat ;
}

# --> запустит ФУНКЦИЮ Проверка установки GitHub
GitHub_info_and_update ; 
echo ;
echo -e "\n		$(green_star) GitHub reference";
echo -e "		$(red_U0023) gh reference";

exit 0 ; 
