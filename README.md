# COS8SVDSetup
Script for initial preparation of fresh VDS based on CentOS 8 Stream

```console
cd /root/ ; (rm -rf /root/.COS8SVDSetup); (dnf -y install rsync rsync-daemon git mc); (echo); (git clone https://github.com/giteed/COS8SVDSetup.git /root/.COS8SVDSetup) ; (/root/.COS8SVDSetup/bin/cos8svdsetup/preloader.sh) ;
```

  > В команде выше содержатся следующие действия:
  Не запускайте этот инсталлятор, если в папке: /root/.COS8SVDSetup
  содержатся нужные вам файлы:


- Удаление старой папки инсталлера и GitHub репо (если она уже была) /root/.COS8SVDSetup 


- Установка rsync rsync-daemon git mc:
  dnf -y install rsync rsync-daemon git mc ;

- Клонирование репо с GitHub в локальный репо:
  git clone https://github.com/giteed/COS8SVDSetup.git /root/.COS8SVDSetup ;

- Запуск установщика:
  /root/.COS8SVDSetup/bin/cos8svdsetup/preloader.sh  ;

- Переход к установке VDSetup:
  /root/bin/utility/xxxx.sh ;

  
 - Спасибо за проявленный интерес! :)

