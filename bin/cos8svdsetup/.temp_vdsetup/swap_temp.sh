
#!/bin/bash

# --> Прочитать настройки из /root/.bashrc
. /root/.bashrc

#!/bin/bash

# Установить требуемый размер SWAP-файла в гигабайтах
SWAP_SIZE_GB=4

# Найти существующий SWAP-файл или создать новый
if [ -f /swapfile ]; then
	echo "Существующий SWAP-файл найден."
else
	echo "Создание нового SWAP-файла..."
	fallocate -l ${SWAP_SIZE_GB}G /swapfile
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile
	echo "/swapfile none swap sw 0 0" >> /etc/fstab
	echo "SWAP-файл создан и включен."
	exit 0
fi

# Получить размер текущего SWAP-файла
CURRENT_SWAP_SIZE=$(free -h | awk '/^Swap:/ { print $2 }' | sed 's/G//')

# Если текущий размер меньше требуемого, то увеличить его
if (( $(echo "$CURRENT_SWAP_SIZE < $SWAP_SIZE_GB" | bc -l) )); then
	echo "Текущий размер SWAP-файла: $CURRENT_SWAP_SIZE GB."
	echo "Увеличение SWAP-файла до ${SWAP_SIZE_GB} GB..."
	swapoff /swapfile
	fallocate -l ${SWAP_SIZE_GB}G /swapfile
	chmod 600 /swapfile
	mkswap /swapfile
	swapon /swapfile
	echo "SWAP-файл увеличен до ${SWAP_SIZE_GB} GB."
else
	echo "Текущий размер SWAP-файла уже достаточный ($CURRENT_SWAP_SIZE GB)."
fi

# Вывести информацию о размере SWAP-памяти
free -h | grep -E '^(Mem|Swap):'

exit 0 ;
