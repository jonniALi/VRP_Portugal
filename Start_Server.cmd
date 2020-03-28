@echo off
echo -
echo FXServer VRP
echo -
pause
start C:\FXServer\server\\run.cmd +set onesync_enabled 1 +exec server.cfg 
exit
