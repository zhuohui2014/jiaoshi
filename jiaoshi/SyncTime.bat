@echo off
chcp 65001 >nul  :: 设置为UTF-8编码，防止乱码
:: 设置NTP服务器列表
set NTP1=time.windows.com
set NTP2=ntp.aliyun.com
set NTP3=pool.ntp.org
set NTP4=ntp.ntsc.ac.cn
set NTP5=time.apple.com

:: 无限循环，每隔10分钟同步时间
:loop
echo 正在同步时间...

:: 随机选择一个NTP服务器进行同步
set /a choice=%random% %% 5 + 1
if %choice%==1 w32tm /config /manualpeerlist:%NTP1% /syncfromflags:manual /reliable:YES /update
if %choice%==2 w32tm /config /manualpeerlist:%NTP2% /syncfromflags:manual /reliable:YES /update
if %choice%==3 w32tm /config /manualpeerlist:%NTP3% /syncfromflags:manual /reliable:YES /update
if %choice%==4 w32tm /config /manualpeerlist:%NTP4% /syncfromflags:manual /reliable:YES /update
if %choice%==5 w32tm /config /manualpeerlist:%NTP5% /syncfromflags:manual /reliable:YES /update

:: 强制同步时间
w32tm /resync >nul 2>&1

:: 显示当前时间和同步结果
echo 当前时间: %time%
echo 等待10分钟进行下一次同步...
timeout /t 600 /nobreak >nul
goto loop
