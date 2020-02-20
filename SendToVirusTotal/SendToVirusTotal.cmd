@echo off
IF NOT EXIST %appdata%\Microsoft\Windows\SendTo\VirusTotal.lnk GOTO CreateSendToLink
IF "%~1" == "" GOTO End

SET OUTPUTFILE=%~dp0sigcheckout.txt
%~dp0sigcheck64 -vt -vs %1 > %OUTPUTFILE%
findstr /i /c:"VT link:" %OUTPUTFILE%
for /f "tokens=3" %%a in ('findstr /i /c:"VT link:" "%OUTPUTFILE%"') do set VTLink=%%a
"%ProgramFiles%\Internet Explorer\iexplore.exe" "%VTLink%"
GOTO End

:CreateSendToLink
%~dp0CreateSendToShortcut.vbs "VirusTotal" %0 %~dp0VirusTotal.ico %~dp0

:End
