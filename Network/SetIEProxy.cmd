@ECHO OFF
ECHO Configurazione proxy in corso…
ECHO Riavviare Internet Explorer al termine della configurazione
TIMEOUT /T 3 /NOBREAK

REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v AutoDetect /t REG_DWORD /d 0 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "proxy.domain.ext:PortNumber" /f
