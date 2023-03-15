# COS8SVDSetup 
Version 0.1.0 Last commit: abc1234, 2023-03-15 10:30:00

![vdsetup_logo.png](/images/vdsetup_logo.png)
## Script for initial preparation of fresh VDS based on CentOS 8 Stream

```console
cd /root/ ; (dnf -y install rsync rsync-daemon git mc); (echo); (git clone https://github.com/giteed/COS8SVDSetup.git /root/.COS8SVDSetup) ; (/root/.COS8SVDSetup/bin/cos8svdsetup/preloader.sh) ;
```

  > В команде выше содержатся следующие действия:
  Не запускайте этот инсталлятор, 
  если в папке: ```/root/.COS8SVDSetup```
  содержатся нужные вам файлы:

- Удаление старой папки инсталлера и GitHub репо (если она уже была) /root/.COS8SVDSetup 

  ```rm -rf /root/.COS8SVDSetup ;``` (сделайте это вручную, если потребуется)
  
- Установка rsync rsync-daemon git mc:

  ```dnf -y install rsync rsync-daemon git mc ;```

- Клонирование репо с GitHub в локальный repo:

  ```git clone https://github.com/giteed/COS8SVDSetup.git /root/.COS8SVDSetup ;```

- Запуск установщика:

  ```/root/.COS8SVDSetup/bin/cos8svdsetup/preloader.sh ;```

- Запуск скрипта VDSetup после установки preloader.sh:

   ```# vdsetup ;```
  
+ Спасибо за проявленный интерес!
