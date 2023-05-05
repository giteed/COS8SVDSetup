# COS8SVDSetup 
Version 2.1.1379

![vdsetup_logo.png](/images/vdsetup_logo.png)
## Script for initial preparation of fresh VDS based on CentOS 8 Stream

В начале :

- Удалите вручную старую папку /root/COS8SVDSetup (если она уже была)  

```rm -rf /root/COS8SVDSetup ;``` 


```console
Получите экспериментальный VDS хостинг всего за 7 рублей в день. 
1 ГБ / Память 
30 ГБ / Хранилище
1 core / Процессор
32 ТБ / Трафик
```
[Используя эту ссылку, вы также получите постоянную скидку на оплату в размере 10%.](https://vdsina.ru/?partner=mqre6jrnj3)

Затем скопируйте данную строку, и запустите на свежем VDS c Linux CentOS 8 Stream.

```console
cd /root/ ; (dnf -y install rsync rsync-daemon git); (echo); (git clone https://github.com/giteed/COS8SVDSetup.git /root/COS8SVDSetup) ; (/root/COS8SVDSetup/bin/cos8svdsetup/preloader.sh) ;
```


> В команде выше содержатся следующие действия:


- Установка rsync rsync-daemon git mc:

  ```dnf -y install rsync rsync-daemon git mc ;```

- Клонирование repo с GitHub в локальный repo:

  ```git clone https://github.com/giteed/COS8SVDSetup.git /root/COS8SVDSetup ;```

- Запуск установщика:

  ```/root/COS8SVDSetup/bin/cos8svdsetup/preloader.sh ;```

>  Запустите скрипт VDSetup после установки preloader.sh:

```console
vdsetup ;
```
  
# Спасибо за проявленный интерес!
:fox_face: Quick and easy, no need to flee -

:handshake: VDSetup's the way to glee!
