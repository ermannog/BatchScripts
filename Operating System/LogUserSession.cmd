:: Purpose:  Creates log files named computername.username containing the history of user sessions
:: Author:   Ermanno Goletto
:: Revision: 3.0 

@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM *** Impostazioni varabili 
SET MONTH=%DATE:~3,2%
SET DAY=%DATE:~0,2%
SET YEAR=%DATE:~6,4%

SET HOUR=%TIME:~0,2%
REM sostituzione spazi con 0
SET HOUR=%HOUR: =0%

SET MINUTE=%TIME:~3,2%
REM sostituzione spazi con 0
SET MINUTE=%MINUTE: =0%

REM Creazione SubDirectory Logs
SET LogsSubFolder="%~dp0Logs"
IF NOT EXIST %LogsSubFolder% MKDIR %LogsSubFolder%

REM Ricerca IP
FOR /F "TOKENS=4 DELIMS= " %%i in ('ROUTE PRINT ^| FIND " 0.0.0.0"') DO (SET IP=%%i & GOTO :NEXT)
:NEXT

REM Ricerca sessioni utente
FOR /F "SKIP=1 TOKENS=1,2,6,7 DELIMS=> " %%a IN ('QUERY USER') DO (
  SET User=%%a
  SET Session=%%b
  SET LogonDay=%%c
  SET LogonHour=%%d

  REM Creazione testo Log
  SET LogText=%YEAR%-%MONTH%-%DAY% %HOUR%:%MINUTE% Session: !Session! - Logon: !LogonDay! !LogonHour! - IP: %IP%

  REM Creazione file Computer.Utente ordinato per data di log decrescente
  SET ComputerUserLogFile=%LogsSubFolder%\%COMPUTERNAME%.!User!
  ECHO !LogText!>>!ComputerUserLogFile!.tmp
  TYPE !ComputerUserLogFile!>>!ComputerUserLogFile!.tmp
  MOVE /Y !ComputerUserLogFile!.tmp !ComputerUserLogFile!
)