@echo off

ipconfig | wsl -e awk -e "$0 ~ /(IPv4).*?192\.[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+/" | wsl -e cut -d ":" -f 2 > tmpFile 
set /p myvar= < tmpFile 
del tmpFile 

ssh pi@raspberrypi "export DISPLAY=:0;export kosto_host='%myvar%' && python3 /home/pi/Desktop/pier1.py"