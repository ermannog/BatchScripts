@echo off
SET OUTPUTFILE=%~dp0sigcheckout.txt
%~dp0sigcheck64 -vt -vs %1 > %OUTPUTFILE%
findstr /i /c:"VT link:" %OUTPUTFILE%
for /f "tokens=3" %%a in ('findstr /i /c:"VT link:" "%OUTPUTFILE%"') do set VTLink=%%a
"%ProgramFiles%\Internet Explorer\iexplore.exe" "%VTLink%"
