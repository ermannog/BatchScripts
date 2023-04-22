:: Name:     Write-UserSessionLogs.cmd
:: Purpose:  Creates log files named username@computername.txt and computername#username.txt containing the history of user sessions
:: Author:   Ermanno Goletto
:: Revision: 1.0 

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

REM Ricerca sessioni utente
FOR /F "SKIP=1 TOKENS=1,2,6,7 DELIMS=> " %%a IN ('QUERY USER') DO (
  SET User=%%a
  SET Session=%%b
  SET LogonDay=%%c
  SET LogonHour=%%d

  REM Creazione testo Log
  SET LogText=%YEAR%-%MONTH%-%DAY% %HOUR%:%MINUTE% Session: !Session! - Logon: !LogonDay! !LogonHour!

  REM Creazione file Utente@Computer.txt ordinato per data di log decrescente
  SET UserComputerLogFileNoExt=%LogsSubFolder%\!User!@%COMPUTERNAME%
  ECHO !LogText!>>!UserComputerLogFileNoExt!.tmp
  TYPE !UserComputerLogFileNoExt!.txt>>!UserComputerLogFileNoExt!.tmp
  MOVE /Y !UserComputerLogFileNoExt!.tmp !UserComputerLogFileNoExt!.txt

  REM Creazione file Computer#Utente.txt ordinato per data di log decrescente
  SET ComputerUserLogFileNoExt=%LogsSubFolder%\%COMPUTERNAME%#!User!
  ECHO !LogText!>>!ComputerUserLogFileNoExt!.tmp
  TYPE !ComputerUserLogFileNoExt!.txt>>!ComputerUserLogFileNoExt!.tmp
  MOVE /Y !ComputerUserLogFileNoExt!.tmp !ComputerUserLogFileNoExt!.txt
)