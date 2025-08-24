:: Purpose:  Verifica IOC tramite il tool hashr rilasciato dal CERT-AGID
:: Author:   Ermanno Goletto
:: Notes:    Il tool hashr deve essere presente nella stessa cartella da cui viene avviato lo script batch
:: Revision: 1.0

@echo off
setlocal enabledelayedexpansion

REM *** Impostazioni Costanti
SET RootFolder=%SystemDrive%\
SET IoCAbsent=IoCAbsent

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

REM *** Controlla se la cartella IOC esiste.
SET IoCSubFolder=%~dp0IoC
IF NOT EXIST "%IoCSubFolder%" (
  ECHO La cartella %IoCSubFolder% non è stata trovata.
  GOTO :eof
)


REM *** Creazione cartella Out.
SET OutSubFolder=%~dp0Out
IF NOT EXIST "%OutSubFolder%" MKDIR "%OutSubFolder%"
IF NOT ERRORLEVEL 0 (
  ECHO Errore durante la creazione della cartella %OutSubFolder%.
  GOTO :eof
)

REM *** Creazione cartella LOG.
SET LogSubFolder=%~dp0Log
IF NOT EXIST "%LogSubFolder%" MKDIR "%LogSubFolder%"
IF NOT ERRORLEVEL 0 (
  ECHO Errore durante la creazione della cartella %LogSubFolder%.
  GOTO :eof
)

ECHO Avvio dell'analisi dei file nella cartella %IoCSubFolder%...
ECHO.

FOR %%f IN ("%IoCSubFolder%\*.*") DO (
    ECHO Esecuzione di hashr.exe per il file: %%f
    
    REM *** Ottiene il nome del file senza estensione.
    SET IoCFileName=%%~nf

    SET OutFile=%OutSubFolder%\!IoCFileName!.%COMPUTERNAME%

    IF EXIST "!OutFile!.%IoCAbsent%" (

      ECHO L'IoC %%f e' gia' stato verificato.

    ) ELSE (
  
      REM Esegui il comando hashr.exe.
      START /BELOWNORMAL /WAIT /B hashr.exe --hashlist "%%f" --rootdir %RootFolder% --output "!OutFile!" --log "%LogSubFolder%\!IoCFileName!.log"

      REM *** Controlla la dimensione del file di output.
      FOR %%s in ("!OutFile!") DO SET "OutFileSize=%%~zs"

      REM *** Ridenominazioe file di output.
      IF !OutFileSize! EQU 0 (
         Echo Il file !OutFile! e' vuoto, non sono stati rivelati IoC! Ridenominazione del file.
         MOVE /Y "!OutFile!" "!OutFile!.%IoCAbsent%"
      ) ELSE (
         Echo Il file !OutFile! non e' vuoto, sono stati rivelati IoC! Ridenominazione del file.
         MOVE /Y "!OutFile!" "!OutFile!.IoCFound.%YEAR%%MONTH%%DAY%%HOUR%%MINUTE%.txt"
         MSG * /time:0 "Attenzione Rilevati IoC '!IoCFileName!', avvertire gli amministratori di sistema."
      )

    )

    ECHO.
)

ECHO Analisi completata.

PAUSE