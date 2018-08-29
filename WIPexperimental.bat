@echo off

:: Set variables
set desktop=%userprofile%\Desktop
set compfiles=%desktop%\Win7CompFiles
set pshellrun=@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command

:: Install git and download folders
cls
echo Installing git and downloading folders...
echo.
%pshellrun% "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco feature enable -n allowGlobalConfirmation
choco install git
cd %desktop%
git init
git remote add origin https://github.com/Marduk28/CyberPatriot_Windows_Scripts.git
git fetch origin master
git checkout origin/master Win7CompFiles OurGloriousChecklist2018_Windows.txt
echo.
echo Done!
echo.
pause

:: Apply SCM Baselines
cls
echo Applying SCM Baselines...
"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win7\Computer_Sec"
"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win7\Domain_Sec"
"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win7\User_Sec"
"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win7\BitLocker_Sec"
echo.
echo Done!
echo.
pause

:: Generate user list
cls
echo Generating user list...
echo.
%pshellrun% "Get-LocalUser > users.txt"
for /f "skip=3 tokens=1 usebackq" %%G in ("users.txt") do `echo %%G > %desktop%\userlist.txt`
del /f /q users.txt
echo.
echo Done!
echo.
pause