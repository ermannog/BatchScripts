REM WaitTime 30 minute (1800 sec)
SET WaitTime=1800

REM Scan Updates
%systemroot%\system32\UsoClient.exe StartScan

REM Wait scan to complete
timeout /t %WaitTime%

REM Download updates
%systemroot%\system32\UsoClient.exe StartDownload

REM Wait Download to complete
timeout /t %WaitTime%

REM Install updates
%systemroot%\system32\UsoClient.exe StartInstall

REM Wait Install to complete
timeout /t %WaitTime%

REM Restart Computer
shutdown /r /t 0 /c “Restart after force install updates by script”
