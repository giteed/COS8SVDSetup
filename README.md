# COS8SVDSetup { version: 0.1.0 }

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
  
 



## Автоматизация присвоения версии скрипту
```Для автоматизации присвоения версии вашему скрипту используется следующий подход:```

__Используйте Git для хранения вашего кода и контроля версий.__

1. _Добавьте скрипт version.sh в ваш репозиторий и установите ему права на выполнение:_

```console
$ chmod +x version.sh
```
2. _Измените ваш скрипт таким образом, чтобы он считывал версию из файла VERSION:_

```console
#!/bin/bash
VERSION=$(cat VERSION)
echo "Running script version $VERSION"
# your script code here
```
3. _Создайте файл VERSION в корневой директории вашего репозитория и запишите в него начальную версию вашего скрипта:_

```console
1.0.0
```
4. _Используйте скрипт version.sh для обновления версии вашего скрипта. Каждый раз, когда вы готовы выпустить новую версию, запустите скрипт следующим образом:_

```console
$ ./version.sh patch # для изменения патч-версии (например, 1.0.0 -> 1.0.1)
$ ./version.sh minor # для изменения минорной версии (например, 1.0.0 -> 1.1.0)
$ ./version.sh major # для изменения мажорной версии (например, 1.0.0 -> 2.0.0)
```
5. _Сохраните изменения, сделанные в вашем скрипте, и закоммитьте их в Git, указав новую версию в сообщении коммита._

6. _Опубликуйте новую версию вашего скрипта в соответствующем формате, указав версию в названии файла, чтобы другие разработчики могли легко найти и использовать вашу новую версию._

```
Надеюсь, эта инструкция поможет другим разработчикам легко использовать автоматизацию присвоения версии вашему скрипту.
```

+ Спасибо за проявленный интерес! :)
