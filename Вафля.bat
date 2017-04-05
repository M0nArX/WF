@echo off
CLS
chcp 65001

:MENU
ECHO ------------------------------------------------------------------------------
ECHO Нажмите 1, 2, 3 или 4 для выбора задачи, или 5 для выхода.
ECHO.
ECHO 1 Задать параметры точки доступа WIFI (Далее ТДW)
ECHO 2 Запустить ТДW
ECHO 3 Остановить ТДW
ECHO 4 Починка
ECHO 5 Выход
ECHO ------------------------------------------------------------------------------
SET /P M=Выберите задачу и нажмите ENTER:
IF %M%==1 GOTO SET
IF %M%==2 GOTO START
IF %M%==3 GOTO STOP
IF %M%==4 GOTO RP
IF %M%==5 GOTO EOF

:SET
ECHO ------------------------------------------------------------------------------
SET /P I=Имя ТДW:
SET /P P=Пароль ТДW:
ECHO ------------------------------------------------------------------------------
ECHO.
netsh wlan set hostednetwork mode=allow ssid=%I% key=%P% keyusage=persistent
netsh wlan start hostednetwork
ECHO ------------------------------------------------------------------------------
ECHO Сейчас появится "Сетевые подключения".
ECHO Нужно выбрать подключение по умолчанию, зайти в его свойства,
ECHO далее вкладка доступ, в ней выбераем пункт
ECHO "Разрешить другим пользователям сети использовать подключение к Интернету...",
ECHO после в пункте "Подключение домашней сети:"
ECHO выбираем "Подключение по локальной сети...".
ECHO Нажимаем ОК, закрываем окно, возвращаемся сюда.
ECHO ------------------------------------------------------------------------------
ECHO.
pause
ncpa.cpl
pause
netsh wlan stop hostednetwork
netsh wlan start hostednetwork
GOTO MENU

:START
netsh wlan start hostednetwork
GOTO MENU

:STOP
netsh wlan stop hostednetwork
GOTO MENU

:RP
ECHO.
netsh wlan stop hostednetwork
netsh wlan set hostednetwork mode=disallow
netsh wlan set hostednetwork mode=allow
ECHO ------------------------------------------------------------------------------
ECHO Сейчас появится "Диспетчер устройств".
ECHO В категории "Сетевые адаптеры" нужно задействовать данное устройство:
ECHO "Microsoft Hosted Network Virtual Adapter",
ECHO а далее закрыть окно.
ECHO ------------------------------------------------------------------------------
ECHO.
pause
mmc devmgmt.msc
ECHO.
ECHO ------------------------------------------------------------------------------
ECHO Задание настроек ТДW заново. Нужно указать другое имя сети
ECHO (Потом можно поменять обратно).
GOTO SET
