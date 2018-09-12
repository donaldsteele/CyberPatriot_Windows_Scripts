@echo off

:: Start Message
title Despacito.exe
echo ==========================================
echo       Windows 10 CyberPatriot Script
echo            by Jackson Kauflin
echo.
echo     This script is dedicated to Drake
echo  because he make sure that north-side eat
echo ==========================================
echo.

pause

:: Setup
set automode=false
mode con: cols=100 lines=22
set desktop=%userprofile%\Desktop
set compfiles=%desktop%\Win10CompFiles
set pshellrun=@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command
set PATH=%PATH%;%programfiles%\Git\bin;%programfiles%\nodejs\node_modules\npm\bin;%appdata%\npm;%compfiles%
del /f /q C:\users.txt C:\approved_users.txt C:\approved_users_gucci.txt C:\users_admins.txt C:\mediafiles.txt C:\sketchyfiles.txt C:\eek.txt

:: Motivational Speech
cls
echo Reminders! PLEASE READ
echo.
echo - For any prompt, you can type "n" or "re"
echo   to skip that choice or go back to menu, respectively.
echo.
echo - Read the messages that show up so you don't forget stuff.
echo.
echo - MAKE NOTE of each step you have done in case
echo   of a screw up *ahem* Timon
echo.
echo - Follow checklist/script closely and don't forget simple stuff.
echo   (Also double, triple check cause script sometimes broken)
echo.
pause
echo.
echo Did ya read it all? DID YA?
echo.
pause

:: Set stickykeys to CMD
takeown /f "%systemroot%\System32\sethc.exe"
takeown /f "%systemroot%\System32\cmd.exe"
icacls "%systemroot%\System32\sethc.exe" /grant %username%:f
icacls "%systemroot%\System32\cmd.exe" /grant %username%:f
ren "%systemroot%\System32\sethc.exe" "%systemroot%\System32\sethc1.exe"
copy "%systemroot%\System32\cmd.exe" "%systemroot%\System32\sethc.exe"

:: Ask if first time setup
cls
set /p cont="Is this first time setup? (y/n) "
if %cont% == n goto autochoice

:: Install git and pull from master
cls
%pshellrun% "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

choco feature enable -n allowGlobalConfirmation

choco install git
set PATH=%programfiles%\Git\bin;%PATH%

cd %desktop%
git init
git remote add origin https://github.com/Marduk28/CyberPatriot_Windows_Scripts.git
git fetch origin master
git checkout origin/master Win10CompFiles OurGloriousChecklist2018_Windows.txt

:: Install diffchecker CLI
cls
choco install nodejs
call npm install -g diffchecker

:: Ask if menu or automode
:autochoice
cls
echo Menu is for quick stuff ya need to do, Auto mode is main option
echo.
echo Note: Auto mode will still take you to menu, you just choose where to start.
echo.
set /p autochoice="Menu or auto mode? (m/a) "

if %autochoice% == a (
	set automode=true
	goto menu
)
if %autochoice% == m (
	set automode=false
	start /d "%compfiles%" DankMMC.msc
	goto menu
)
else (
	cls
	echo That's not an option, ya gaylord!
	echo.
	pause
	goto autochoice
)

:: Menu
:menu
cls
echo 1) README                          f) Event Viewer
echo 2) Windows Update                  g) Sysinternals
echo 3) Inf files                       h) Install programs
echo 4) SCM OS baselines                i) Update programs
echo 5) Audit Policy                    j) Services
echo 6) Forensics                       k) Media files
echo 7) Add/Delete users                l) Remove programs + features
echo 8) Activate/Disable users          m) SCM IE baselines
echo 9) Add/Delete admins               n) Backup
echo a) Change passwords                o) Application Settings
echo b) Enable Firewall                 p) Hosts file
echo c) Nessus                          q) Operating system settings
echo d) MMC Stuff                       r) Defensive Countermeasures
echo e) Readme Requirements             s) Prohibited files
echo                                    t) Random list of things at the end
echo.
echo u) Open DankMMC
echo v) Open official checklist
echo w) Open master checklist
echo.

choice /c 123456789abcdefghijklmnopqrstuvw /n /m "Where would you like to start? "
goto %errorlevel%

:: README
:1
cls
echo Read the README, ya bigot higot!
echo.

pause

if %automode% == true goto 2

goto menu

:: Windows Update
:2
if %automode% == true (
	cls
	sc config wuauserv start= auto
	if %errorlevel% == 1 echo. && echo Uh oh. Error happened.
	sc start wuauserv
	if %errorlevel% == 1 echo. && echo Uh oh. Error happened.
	echo.

	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 4 /f

	cls
	echo Windows Update yeet
	echo Still gotta start it manually oof
	echo.
	start ms-settings:windowsupdate
	pause

	goto 3
)

cls
echo Set automatic updates.
echo.

start ms-settings:windowsupdate
pause

goto menu

:: Inf files
:3

cls
set /p inf="Good or Bad Inf? (g/b) "
if %inf% == g goto goodinf
if %inf% == b goto badinf
if %inf% == re goto menu
if %inf% == n (
	if %automode% == true goto 4
	goto menu
)

:goodinf
cls
secedit /configure /db "%systemroot%\dankdatabase1.db" /cfg "%compfiles%\Win10GoodInf.inf"
if %errorlevel% == 1 echo. && echo Uh oh. Error happened.
cls
echo Good INF Done!
echo.
echo Check the scoring report and copy/paste the vulnerabilities into notepad.
echo.

pause

goto 3

:badinf
cls
secedit /configure /db "%systemroot%\dankdatabase2.db" /cfg "%compfiles%\Win10BadInf.inf"
if %errorlevel% == 1 echo. && echo Uh oh. Error happened.
cls
echo Bad Inf Done!
echo.
echo Check the scoring report and copy/paste the vulnerabilities into notepad.
echo.

pause

goto 3

:: SCM OS Baselines
:4
cls
winver
set /p ver="Enter the version of windows this is... "
if %ver% == n (
	if %automode% == true goto 5
	goto menu
)
if %ver% == re goto menu

if %ver% == 1507 (
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1507\Computer_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1507\Computer_Sec_2"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1507\Domain_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1507\User_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1507\User_Sec_2"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1507\BitLocker_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1507\CredGuard_Sec"
	cls
	echo SCM Baselines Done!
	echo.
	echo Check the scoring report and copy/paste the vulnerabilities into notepad.
	echo.
	pause
	if %automode% == true goto 5
	goto menu
)

if %ver% == 1511 (
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1511\Computer_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1511\Computer_Sec_2"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1511\Domain_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1511\User_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1511\User_Sec_2"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1511\BitLocker_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1511\CredGuard_Sec"
	cls
	echo SCM Baselines Done!
	echo.
	echo Check the scoring report and copy/paste the vulnerabilities into notepad.
	echo.
	pause
	if %automode% == true goto 5
	goto menu
)

if %ver% == 1607 (
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1607_Server2016\Computer_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1607_Server2016\Computer_Sec_3"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1607_Server2016\Domain_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1607_Server2016\User_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1607_Server2016\User_Sec_2"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1607_Server2016\BitLocker_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1607_Server2016\CredGuard_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1607_Server2016\Defender_Sec"
	cls
	echo SCM Baselines Done!
	echo.
	echo Check the scoring report and copy/paste the vulnerabilities into notepad.
	echo.
	pause
	if %automode% == true goto 5
	goto menu
)

if %ver% == 1703 (
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1703\Computer_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1703\Computer_Sec_2"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1703\Domain_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1703\User_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1703\User_Sec_2"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1703\BitLocker_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1703\CredGuard_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1703\Defender_Sec"
	cls
	echo SCM Baselines Done!
	echo.
	echo Check the scoring report and copy/paste the vulnerabilities into notepad.
	echo.
	pause
	if %automode% == true goto 5
	goto menu
)

if %ver% == 1709 (
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1709\Computer_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1709\Computer_Sec_2"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1709\Domain_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1709\User_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1709\User_Sec_2"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1709\BitLocker_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1709\CredGuard_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1709\Defender_Sec"
	cls
	echo SCM Baselines Done!
	echo.
	echo Check the scoring report and copy/paste the vulnerabilities into notepad.
	echo.
	pause
	if %automode% == true goto 5
	goto menu
)

if %ver% == 1803 (
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1803\Computer_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1803\Computer_Sec_2"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1803\Domain_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1803\User_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1803\User_Sec_2"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1803\BitLocker_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1803\CredGuard_Sec"
	"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\Win10_1803\Defender_Sec"
	cls
	echo SCM Baselines Done!
	echo.
	echo Check the scoring report and copy/paste the vulnerabilities into notepad.
	echo.
	pause
	if %automode% == true goto 5
	goto menu
)

else (
	cls
	echo Oof try again.
	echo.
	pause
	goto 4
)

:: Audit Policy
:5
cls
echo Import the two audit templates (AllAudit then NoAudit)
echo.
echo Check the scoring report and copy/paste the vulnerabilities into notepad.
echo.
start gpedit.msc

pause

if %automode% == true goto gpting

goto menu

:: GPting
:gpting
cls
echo Alrighty, my dude. Cat-Lite scanner is gonna run now.
echo.
echo Look for failed things that aren't included in infs.
echo.
echo Get timon to be dank and read tings oof.
echo.
start /d "%compfiles%\cis-cat-lite" CISCAT.jar

pause

goto 6

:: Forensics
:6
cls
echo Hey! Do thein forensic question. Eek.
echo.

pause

if %automode% == true goto userfile

goto menu

:: Add users to file
:userfile
cls
echo Add the users to the user file.
echo.

net user

start /d "%compfiles%" users.txt

pause

goto 7

:: Add/Delete Users
:7
cls
net user

set /p choice="Add or remove user? (a/r) "
if %choice% == a goto addusers
if %choice% == r goto delusers
if %choice% == n (
	if %automode% == true goto 8
	goto menu
)
if %choice% == re goto menu

:addusers
cls
net user

set /p user="Enter a username and their password to add... "
if %user% == n goto 7
if %user% == re goto menu
net user "%user%" /add

goto addusers

:delusers
cls
net user

set /p user="Enter a user to delete... "
if %user% == n goto 7
if %user% == re goto menu
net user %user% /delete

goto delusers

:: Activate/Disable Users
:8
if %automode% == true (
	cls
	net user BroShirt /active:no
	net user BroPants /active:no
	for /f "skip=4 eol=;" %%a in (%compfiles%\users.txt) do net user %%a /active:yes
	goto 9
)

net user BroPants /active:no

cls
net user

echo Enable all accounts. Guest account has been disabled.
echo.

set /p choice="Activate or disable user? (a/d) "
if %choice% == a goto activateusers
if %choice% == d goto disableusers
if %choice% == n (
	if %automode% == true goto 9
	goto menu
)
if %choice% == re goto menu

:activateusers
cls
net user

set /p user="Enter a user to activate... "
if %user% == n goto 8
if %user% == re goto menu
net user %user% /active:yes

goto activateusers

:disableusers
cls
net user

set /p user="Enter a user to disable... "
if %user% == n goto 8
if %user% == re goto menu
net user %user% /active:no

goto disableusers

:: Deleting/adding admins
:9
cls
net localgroup administrators

set /p choice="Add or remove admin? (a/r) "

if %choice% == a goto addadmins
if %choice% == r goto deladmins
if %choice% == n (
	if %automode% == true goto 10
	goto menu
)
if %choice% == re goto menu

:addadmins
cls
net user
net localgroup administrators

set /p user="Enter a user to add to admin group... "
if %user% == n goto 9
if %user% == re goto menu
net localgroup administrators %user% /add

goto addadmins

:deladmins
cls
net localgroup administrators

set /p user="Enter a user to remove from admin group... "
if %user% == n goto 9
if %user% == re goto menu
net localgroup administrators %user% /delete

goto deladmins

:: Changing passwords
:10
if %automode% == true (
	cls
	for /f "skip=2 eol=;" %%a in (%compfiles%\users.txt) do net user %%a abc123ABC123@@
	goto 11
)

cls
net user

echo All users' passwords will be abc123ABC123@@
echo.

set /p user="Enter user for password change... "
if %user% == n (
	if %automode% == true goto 11
	goto menu
)
if %user% == re goto menu
net user %user% abc123ABC123@@

goto 10

:: Enable firewall + template
:11
cls
netsh advfirewall import "%compfiles%\Win10Firewall.wfw"
if %errorlevel% == 1 echo. && echo Uh oh. Error happened.
netsh advfirewall set allprofiles state on
if %errorlevel% == 1 echo. && echo Uh oh. Error happened.
cls
echo Check firewall exceptions for sketchiness...
echo.
firewall.cpl
pause

if %automode% == true goto 12

goto menu

:: Nessus
:12
cls
ipconfig
echo.

echo Run the Nessus immediately cause it might help and stuff yooo!
echo.

pause

if %automode% == true goto 13

goto menu

:: MMC Stuff
:13
:sharestart
cls
net share
echo.
set /p share="Choose a share to delete cause it sketchy... "
if %share% == n goto mmccont
if %share% == re goto menu
net share %share% /del
goto sharestart

:mmccont
cls
echo Check locked users/other user stuff
echo.
if %automode% == true start compmgmt.msc
pause

cls
echo Enable Windows Defender
echo.
if %automode% == true start gpedit.msc
pause

cls
echo Enable Smartscreen (doesn't apply to Server 2008)
echo.
pause

cls
echo Disable autoplay
echo.
pause

if %automode% == true goto 14

goto menu

:: README Requirements
:14
cls
echo Open the readme and do the specific things it says to do.
echo Could be enabling service, adding user/group, etc.
echo.

pause

if %automode% == true goto 15

goto menu

:: Event Viewer
:15
cls
echo Look at the Event Viewer for stuff that's BAD
echo.
start eventvwr.msc
pause

if %automode% == true goto 16

goto menu

:: Sysinternals
:16
cls Installing Sysinternals...
echo.
choco install sysinternals

cls
echo Opening TCPView, Process Explorer, and Autoruns...
echo.
echo Make sure to delete the file itself, not just the process
echo.
procexp
autoruns
tcpview
pause

if %automode% == true goto 17

goto menu

:: Install programs
:17
cls
echo The programs should open automatically after they all install,
echo but if not run the programs n stuff.
echo.

choco feature enable -n useFipsCompliantChecksums

cls
choco install firefox ie11 malwarebytes mbsa microsoftsecurityessentials jre8 --ignorechecksum --force
pause

start /d "%programfiles%\Malwarebytes\Anti-Malware" mbam.exe
start /d "%programfiles%\Microsoft Baseline Security Analyzer 2" mbsa.exe
start /d "%programfiles%\Microsoft Security Client" msseces.exe

if %automode% == true goto 18

goto menu

:: Update programs
:18
if %automode% == true (
	cls
	choco upgrade all
	goto install
)

:install
cls
echo PUT LOTS OF EFFORT INTO THIS AND DONT FORGET IT.
echo.
echo Install programs that need to be updated.
echo.

start firefox.exe chocolatey.org

set /p install="Enter a program to update... "
if %install% == n goto manualupdate
if %install% == re goto menu
echo.

choco install %install% --ignorechecksum
choco upgrade %install% --ignorechecksum

goto install

:manualupdate
cls
echo Update all programs you can't with chocolatey.
echo.

pause

if %automode% == true goto 19

goto menu

:: Services
:19
cls
if %automode% == true (
	sc stop tlntsvr
	sc config tlntsvr start= disabled
	sc stop msftpsvc
	sc config msftpsvc start= disabled
	sc stop snmptrap
	sc config snmptrap start= disabled
	sc stop ssdpsrv
	sc config ssdpsrv start= disabled
	sc stop termservice
	sc config termservice start= disabled
	sc stop sessionenv
	sc config sessionenv start= disabled
	sc stop remoteregistry
	sc config remoteregistry start= disabled
	sc stop Messenger
	sc config Messenger start= disabled
	sc stop upnphos
	sc config upnphos start= disabled
	sc stop WAS
	sc config WAS start= disabled
	sc stop RemoteAccess
	sc config RemoteAccess start= disabled
	sc stop mnmsrvc
	sc config mnmsrvc start= disabled
	sc stop NetTcpPortSharing
	sc config NetTcpPortSharing start= disabled
	sc stop RasMan
	sc config RasMan start= disabled
	sc stop TabletInputService
	sc config TabletInputService start= disabled
	sc stop RpcSs
	sc config RpcSs start= disabled
	sc stop SENS
	sc config SENS start= disabled
	sc stop EventSystem
	sc config EventSystem start= disabled
	sc stop XblAuthManager
	sc config XblAuthManager start= disabled
	sc stop XblGameSave
	sc config XblGameSave start= disabled
	sc stop XboxGipSvc
	sc config XboxGipSvc start= disabled
	sc stop xboxgip
	sc config xboxgip start= disabled
	sc stop xbgm
	sc config xbgm start= disabled
	sc stop SysMain
	sc config SysMain start= disabled
	sc config EventLog start= auto
	sc start EventLog
	goto manualserv
)

echo tlntsvr (Telnet)
echo msftpsvc (FTP)
echo snmptrap (SNMP Trap)
echo ssdpsrv (SSDP Discovery)
echo termservice, sessionenv (Remote Desktop Services) *Dont disable these if remote desktop is needed*
echo remoteregistry (Remote Registry)
echo Messenger (Windows Messenger)
echo upnphos (Universal Plug n Play)
echo WAS (Web server Service)
echo RemoteAccess (Routing and Remote Access)
echo mnmsrvc (NetMeeting Remote Desktop Sharing)
echo NetTcpPortSharing (Net.Tcp Port Sharing Service)
echo RasMan (Access for dial-up and VPN)
echo TabletInputService (Tablet crap)
echo RpcSs (Remote Procedure Call)
echo SENS (System Event Notification Service)
echo EventSystem (COM+ Event System)
echo XblAuthManager, XblGameSave, XboxGipSvc, xboxgip, xbgm (Xbox services)
echo SysMain (Superfetch)
echo EventLog (Event Log duh)
echo.

set /p choice="Enable or Disable Service? (e/d/def) "

if %choice% == e goto enableserv
if %choice% == d goto disablegud
if %choice% == n goto manualserv
if %choice% == re goto menu
if %choice% == def (
	sc stop tlntsvr
	sc config tlntsvr start= disabled
	sc stop msftpsvc
	sc config msftpsvc start= disabled
	sc stop snmptrap
	sc config snmptrap start= disabled
	sc stop ssdpsrv
	sc config ssdpsrv start= disabled
	sc stop termservice
	sc config termservice start= disabled
	sc stop sessionenv
	sc config sessionenv start= disabled
	sc stop remoteregistry
	sc config remoteregistry start= disabled
	sc stop Messenger
	sc config Messenger start= disabled
	sc stop upnphos
	sc config upnphos start= disabled
	sc stop WAS
	sc config WAS start= disabled
	sc stop RemoteAccess
	sc config RemoteAccess start= disabled
	sc stop mnmsrvc
	sc config mnmsrvc start= disabled
	sc stop NetTcpPortSharing
	sc config NetTcpPortSharing start= disabled
	sc stop RasMan
	sc config RasMan start= disabled
	sc stop TabletInputService
	sc config TabletInputService start= disabled
	sc stop RpcSs
	sc config RpcSs start= disabled
	sc stop SENS
	sc config SENS start= disabled
	sc stop EventSystem
	sc config EventSystem start= disabled
	sc stop XblAuthManager
	sc config XblAuthManager start= disabled
	sc stop XblGameSave
	sc config XblGameSave start= disabled
	sc stop XboxGipSvc
	sc config XboxGipSvc start= disabled
	sc stop xboxgip
	sc config xboxgip start= disabled
	sc stop xbgm
	sc config xbgm start= disabled
	sc stop SysMain
	sc config SysMain start= disabled
	sc config EventLog start= auto
	sc start EventLog
	goto 19
)

:enableserv
cls
echo tlntsvr (Telnet)
echo msftpsvc (FTP)
echo snmptrap (SNMP Trap)
echo ssdpsrv (SSDP Discovery)
echo termservice, sessionenv (Remote Desktop Services) *Dont disable these if remote desktop is needed*
echo remoteregistry (Remote Registry)
echo Messenger (Windows Messenger)
echo upnphos (Universal Plug n Play)
echo WAS (Web server Service)
echo RemoteAccess (Routing and Remote Access)
echo mnmsrvc (NetMeeting Remote Desktop Sharing)
echo NetTcpPortSharing (Net.Tcp Port Sharing Service)
echo RasMan (Access for dial-up and VPN)
echo TabletInputService (Tablet crap)
echo RpcSs (Remote Procedure Call)
echo SENS (System Event Notification Service)
echo EventSystem (COM+ Event System)
echo XblAuthManager, XblGameSave, XboxGipSvc, xboxgip, xbgm (Xbox services)
echo SysMain (Superfetch)
echo EventLog (Event Log duh)
echo.

set /p serv="Enter a service to enable... "
if %serv% == n goto 19
if %serv% == re goto menu

sc config %serv% start= auto
sc start %serv%

goto enableserv

:disablegud
cls
echo tlntsvr (Telnet)
echo msftpsvc (FTP)
echo snmptrap (SNMP Trap)
echo ssdpsrv (SSDP Discovery)
echo termservice, sessionenv (Remote Desktop Services) *Dont disable these if remote desktop is needed*
echo remoteregistry (Remote Registry)
echo Messenger (Windows Messenger)
echo upnphos (Universal Plug n Play)
echo WAS (Web server Service)
echo RemoteAccess (Routing and Remote Access)
echo mnmsrvc (NetMeeting Remote Desktop Sharing)
echo NetTcpPortSharing (Net.Tcp Port Sharing Service)
echo RasMan (Access for dial-up and VPN)
echo TabletInputService (Tablet crap)
echo RpcSs (Remote Procedure Call)
echo SENS (System Event Notification Service)
echo EventSystem (COM+ Event System)
echo XblAuthManager, XblGameSave, XboxGipSvc, xboxgip, xbgm (Xbox services)
echo SysMain (Superfetch)
echo EventLog (Event Log duh)
echo.

set /p serv="Enter a service to disable... "
if %serv% == n goto 19
if %serv% == re goto menu

sc stop %serv%
sc config %serv% start= disabled

goto disablegud

:manualserv
cls
echo Now look for sketchy services to disable and stuff
echo.
start services.msc
pause

if %automode% == true goto 20

goto menu

:: Media Files
:20

if %automode% == true goto deletemf

cls
set /p choice="Search for or delete media files? (s/d) "
if %choice% == s goto searchmf
if %choice% == d goto deletemf
if %choice% == n (
	if %automode% == true goto 21
	goto menu
)
if %choice% == re goto menu

:deletemf
cls
echo Note: "Couldn't find mediafiles.txt" is expected here.
echo.

del "%homedrive%\mediafiles.txt" /f /q

del /s "%homedrive%\*.mp3" /f /q /a
del /s "%homedrive%\*.mp4" /f /q /a
del /s "%homedrive%\*.avi" /f /q /a
del /s "%homedrive%\*.wmv" /f /q /a
del /s "%homedrive%\*.mid" /f /q /a
del /s "%homedrive%\*.mov" /f /q /a
del /s "%homedrive%\*.m4v" /f /q /a
del /s "%homedrive%\*.3gp" /f /q /a
del /s "%homedrive%\*.wma" /f /q /a

cls
echo Media files deleted.
echo.
echo Now check for ones missed. Wait for dis.
echo.

cd %homedrive%\
dir /s /a /b /o-d *.mp3 *.mp4 *.avi *.wmv *.mid *.mov *.m4v *.3gp *.wma *.wav >> mediafiles.txt

start mediafiles.txt

pause

if %automode% == true goto 21

goto 20

:searchmf
cls
echo Note: "Couldn't find mediafiles.txt" is expected here.
echo.
echo Searching for media files...
echo.

del "%homedrive%\mediafiles.txt" /f /q

cd %homedrive%\
dir /s /a /b /o-d *.mp3 *.mp4 *.avi *.wmv *.mid *.mov *.m4v *.3gp *.wma *.wav >> mediafiles.txt

start mediafiles.txt

pause

if %automode% == true goto 21

goto 20

:: Remove Programs + Features
:21
cls
echo MAKE SURE YOU DO ALL OF THE TINGS. DO IT GOOD.
echo.
echo Uninstall programs
echo.
echo Remove features
echo.
echo Remove folders in Program Files
echo.
echo Remove .zip, .exe, .msi
echo.

start appwiz.cpl
cd %homedrive%\
dir /s /a /b /o-d *.zip *.exe *.msi >> sketchyfiles.txt
start sketchyfiles.txt

pause

if %automode% == true goto 22

goto menu

:: SCM IE Baselines
:22
cls
"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\IE11_Com_Sec"
"%compfiles%\SCMBaselines\LGPO.exe" /g "%compfiles%\SCMBaselines\IE11_User_Sec"

if %automode% == true goto 23

goto menu

:: Backup
:23
cls
set /p location="Enter the drive letter for the backup location... "

wbadmin enable backup -addtarget:%location%: -include:C: -schedule:03:00 -quiet

if %automode% == true goto 24

goto menu

:: Application Settings
:24
cls
echo IF YOU'RE ON A SERVER OS, focus on this a little more.
echo.
echo Set all dem application security settings.
echo.
echo Firefox:
echo	- Warn when try to install addons
echo	- Popup blocker
echo	- other crap
echo.
echo See if there are security settings for other programs.
echo Use the interwebs to your advantage.
echo.

start firefox.exe

pause

if %automode% == true goto 25

goto menu

:: Hosts file
:25
cls
takeown /f "%systemroot%\system32\drivers\etc"

del "%systemroot%\system32\drivers\etc\hosts"
copy "%compfiles%\hosts" "%systemroot%\system32\drivers\etc\hosts"

if %automode% == true goto 26

goto menu

:: Operating System Settings
:26
cls
echo IF YOU'RE ON A SERVER OS, focus on this a little more.
echo.
echo Enable screen saver + check "logon on resume"
echo.
control desktop
pause

cls
echo Check file permissions for danko folders
echo.
pause

cls
echo Disable remote desktop
echo.
start sysdm.cpl
pause

cls
echo Check action center (doesn't apply to Server 2008)
start wscui.cpl
echo.
pause

cls
echo Enable UAC
echo.
pause

cls
echo What up it's ya boi cat-lite scanner here. imma scan and be cool.
echo.
start /d "%compfiles%\cis-cat-lite" CISCAT.jar
pause

if %automode% == true goto 27

goto menu

:: Defensive Countermeasures
:27
cls
echo Make sure windows defender is danko enabled
echo.
pause

cls
echo Make sure you have the security programs installed
echo.
pause

cls
echo Scan on all those programs
echo.
pause

if %automode% == true goto 28

goto menu

:: Prohibited files
:28
cls
echo Yaboi prohibited files.
echo.
echo - Look for xml, txt, etc. in notepad that will open in a second.
echo.
echo - Look in folders for files (sort by date modified)
echo.

cd %homedrive%\
dir /s /a /b /o-d >> eek.txt
start eek.txt

pause

if %automode% == true goto 29

goto menu

:: Random Things At The End
:29
cls
echo Check processes for sketchiness.
echo.
start taskmgr.exe
start firefox.exe www.processlibrary.com
pause

cls
echo Vulns from other images
echo.
pause

cls
echo Go through every single step again (extreme thorough-ness not super necessary)
echo.
pause

cls
echo Past comp vulns (Make Peter or someone read them)
echo.
pause

cls
echo Go through everthing AGAIN MY MAN
echo.
pause

cls
echo Official checklist
echo.
start /d "%compfiles%" OfficialWin10Checklist.docx
pause

if %automode% == true goto end

goto menu

:: End
:end
echo If you reached this screen, you did a good. Maybe. Idk man.
echo.
echo Sending you back to the menu now...
echo.

pause

goto menu

:: Open DankMMC
:30
start /d "%compfiles%" DankMMC.msc
goto menu

:: Open official checklist
:31
start /d "%compfiles%" OfficialWin10Checklist.docx
goto menu

:: Open master checklist
:32
start /d "%desktop%" OurGloriousChecklist2018_Windows.txt
goto menu
