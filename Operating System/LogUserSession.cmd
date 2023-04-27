:: Purpose:  Creates log files named computername.username containing the history of user sessions
:: Author:   Ermanno Goletto
:: Revision: 6.0 

@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

REM *** Impostazioni Costanti
REM Impostazione dimensione massima file di log in bytes (0=Nessuna limitazione)
SET LOGMAXSIZE=76800

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

  REM Creazione testo Log - Data esecuzione
  SET LogText=%YEAR%-%MONTH%-%DAY% %HOUR%:%MINUTE%

  REM Creazione testo Log - Sessione
  SET LogText=!LOGTEXT! Session: !Session!

  REM Creazione testo Log - Data logon
  SET LogText=!LOGTEXT! - Logon: !LogonDay! !LogonHour!

  REM Creazione testo Log - Indirizzi IP
  SET LogText=!LOGTEXT! - IP:
  FOR /F "TOKENS=2 DELIMS=:" %%a IN ('IPCONFIG ^| FINDSTR IPv4') DO (SET LogText=!LOGTEXT!%%a)
  
  REM Creazione file Computer.Utente ordinato per data di log decrescente
  SET ComputerUserLogFile=%LogsSubFolder%\%COMPUTERNAME%.!User!
  ECHO !LogText!>>!ComputerUserLogFile!.tmp
  TYPE !ComputerUserLogFile!>>!ComputerUserLogFile!.tmp
  MOVE /Y !ComputerUserLogFile!.tmp !ComputerUserLogFile!

  REM Impostazione max size del file di log
  IF %LOGMAXSIZE% NEQ 0 FSUTIL file seteof !ComputerUserLogFile! %LOGMAXSIZE%
)
