@ECHO OFF

ECHO *** Stop service wuauserv ***
NET STOP wuauserv

ECHO *** Kill process service wuauserv ***
FOR /F "tokens=3" %%A IN ('SC QUERYEX wuauserv ^| FINDSTR PID') DO (SET pid=%%A)
IF "%pid%" NEQ "0" (
  taskkill /F /PID %pid%
)

ECHO *** Stop service bits ***
NET STOP bits

ECHO *** Kill process service bits ***
FOR /F "tokens=3" %%A IN ('sc queryex bits ^| FINDSTR PID') DO (SET pid=%%A)
IF "%pid%" NEQ "0" (
  ECHO taskkill /F /PID %pid%
)

ECHO *** Delete directory %windir%\SoftwareDistribution ***
RMDIR /S /Q %windir%\SoftwareDistribution

ECHO *** Stop service cryptsvc ***
NET STOP cryptsvc

ECHO *** Kill process service cryptsvc ***
FOR /F "tokens=3" %%A IN ('sc queryex cryptsvc ^| FINDSTR PID') DO (SET pid=%%A)
IF "%pid%" NEQ "0" (
  ECHO taskkill /F /PID %pid%
)

ECHO *** Delete directory %windir%\system32\catroot2 ***
RMDIR /S /Q %windir%\system32\catroot2

ECHO *** Start services wuauserv, bits and cryptsvc ***
NET START wuauserv
NET START bits
NET START cryptsvc

ECHO *** Start search updates ***
wuauclt.exe /resetauthorization /detectnow

PAUSE
