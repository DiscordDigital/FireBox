@echo off
:: Coded by discord.digital
color 0f
title FireBox Script
set version=1.0
set boxdrive=z
set boxname=default
set boxsize=3000M
:: Only edit following if you know what you're doing
set veracrypt="C:\Program Files\VeraCrypt\VeraCrypt.exe"
set veracryptformat="C:\Program Files\VeraCrypt\VeraCrypt Format.exe"
set firefox="C:\Program Files\Mozilla Firefox\firefox.exe"
echo --- FireBox %version% ---
if not exist getpwd.ps1 call :createpwd
if not exist %veracrypt% call :MissingBinary VeraCrypt.exe
if not exist %veracryptformat% call :MissingBinary VeraCrypt Format.exe
if not exist %firefox% call :MissingBinary firefox.exe
if not exist %boxname%.hc call :create_profile_container
if not exist %boxdrive%:\ call :mount_profile_container
if not exist %boxdrive%:\firefox call :create_firefox_profile
if "%1"=="dismount" goto dismount_box
echo Launching Firefox... Your data will be encrypted once you close firefox.
%firefox% -profile %boxdrive%:\firefox
%veracrypt% /q /d %boxdrive%
echo Done! This window will close in 5 seconds
ping localhost -n 5 > nul
exit

:createpwd
echo $password = Read-Host "Enter password" -AsSecureString > getpwd.ps1
echo $password = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($password) >> getpwd.ps1
echo $password = [Runtime.InteropServices.Marshal]::PtrToStringAuto($password) >> getpwd.ps1
echo echo $password >> getpwd.ps1
exit /b

:create_firefox_profile
%firefox% -CreateProfile "firefox %boxdrive%:\firefox"
exit /b

:mount_profile_container
echo Mounting %boxname%..
:set_password
if "%vcpass%"=="" for /f %%f in ('powershell -File getpwd.ps1') do set vcpass=%%f
if "%vcpass%"=="" goto set_password
cls
echo Decrypting information please wait..
%veracrypt% /v %boxname%.hc /l %boxdrive% /a /p %vcpass% /b /q /silent
if not exist %boxdrive%:\ echo Did you enter a wrong password?& goto set_password
echo Mounted %boxname%!
exit /b

:create_profile_container
echo --- FireBox Profile Setup ---
for /f %%f in ('powershell -File getpwd.ps1') do set vcpass=%%f
%veracryptformat% /create %boxname%.hc /hash sha512 /encryption AES(Twofish(Serpent)) /filesystem NTFS /size %boxsize% /force /password %vcpass%
echo Created %boxname%.hc
exit /b


:MissingBinary
echo FireBox can't find %*
echo Please install the programs needed or change the paths in the script
echo.
echo Press any key to exit
pause > nul
exit
