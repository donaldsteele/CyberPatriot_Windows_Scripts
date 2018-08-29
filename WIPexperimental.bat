@echo off

:: Install git and download folders
cls
echo Installing git and downloading folders...
echo.
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco feature enable -n allowGlobalConfirmation
choco install git
cd %userprofile%\Desktop
git init
git remote add origin https://github.com/Marduk28/CyberPatriot_Windows_Scripts.git
git fetch origin master
git checkout origin/master Win7CompFiles OurGloriousChecklist2018_Windows.txt

:: Apply SCM Baselines
cls
echo Applying SCM Baselines...
"%USERPROFILE%\Desktop\Win7CompFiles\SCMBaselines\LGPO.exe" /g "%USERPROFILE%\Desktop\Win7CompFiles\SCMBaselines\Win7\Computer_Sec"
"%USERPROFILE%\Desktop\Win7CompFiles\SCMBaselines\LGPO.exe" /g "%USERPROFILE%\Desktop\Win7CompFiles\SCMBaselines\Win7\Domain_Sec"
"%USERPROFILE%\Desktop\Win7CompFiles\SCMBaselines\LGPO.exe" /g "%USERPROFILE%\Desktop\Win7CompFiles\SCMBaselines\Win7\User_Sec"
"%USERPROFILE%\Desktop\Win7CompFiles\SCMBaselines\LGPO.exe" /g "%USERPROFILE%\Desktop\Win7CompFiles\SCMBaselines\Win7\BitLocker_Sec"

:: Generate user list
cls
echo Generating user list...
echo.
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "Get-LocalUser > userlist.txt"