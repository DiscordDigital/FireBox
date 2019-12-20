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
call :createpwd
if not exist %veracrypt% call :MissingBinary VeraCrypt.exe
if not exist %veracryptformat% call :MissingBinary VeraCrypt Format.exe
if not exist %firefox% call :MissingBinary firefox.exe
if not exist %boxname%.hc call :create_profile_container
if not exist %boxdrive%:\ call :mount_profile_container
if not exist %boxdrive%:\firefox call :create_firefox_profile
echo Launching Firefox...
%firefox% -profile %boxdrive%:\firefox
echo.
echo To encrypt your firefox instance please close the firefox window,
echo then press any key to continue.
pause > nul
if not exist %boxdrive%: goto :boxalreadyunmounted
%veracrypt% /q /d %boxdrive%
:closewait
echo Done! This window will close in 5 seconds
ping localhost -n 5 > nul
goto :eof

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
for /f %%f in ('powershell -File getpwd.ps1') do set vcpass=%%f
if "%vcpass%"=="" goto set_password
echo Decrypting information please wait..
%veracrypt% /v %boxname%.hc /l %boxdrive% /a /p %vcpass% /b /q /silent
if not exist %boxdrive%:\ echo Did you enter a wrong password?& goto set_password
echo Mounted %boxname%!
exit /b

:create_profile_container
echo --- FireBox Profile Setup ---
:set_password2
echo Please define a new password. (Will be visible)
set /p vcpass=^> 
if "%vcpass%"=="" goto set_password2
%veracryptformat% /create %boxname%.hc /hash sha512 /encryption AES(Twofish(Serpent)) /filesystem NTFS /size %boxsize% /force /password %vcpass%
echo Created %boxname%.hc
exit /b

:boxalreadyunmounted
echo.
echo The profile is already unmounted.
echo.
goto closewait

:MissingBinary
echo FireBox can't find %*
echo Please install the programs needed or change the paths in the script
echo.
echo Press any key to exit
pause > nul
exit
