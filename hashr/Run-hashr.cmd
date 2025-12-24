:: Purpose:		Verifica IOC tramite il tool hashr rilasciato dal CERT-AGID
:: Author:		Ermanno Goletto
:: Requirements:	I file contenenti gli hash degli IoC devono essere presenti nella subdirectory IoC della cartella da cui viene avviato lo script batch
:: Requirements:	Il tool hashr deve essere presente nella cartella da cui viene avviato lo script batch
:: Revision:		1.5

REM @echo off
setlocal enabledelayedexpansion

REM *** Impostazioni Costanti
SET IoCAbsent=IoCAbsent
SET PathFileLog=%~dp0%~n0.log

REM *** Gestione parametri
SET "RootFolder=%~1"
IF "%RootFolder%"=="" SET "RootFolder=%SystemDrive%\"

REM *** Impostazioni varabili 
SET MONTH=%DATE:~3,2%
SET DAY=%DATE:~0,2%
SET YEAR=%DATE:~6,4%


REM *** Clear Log
ECHO.>"%PathFileLog%"

CALL :Log "Avvio Analisi presenza IoC in %RootFolder%."

REM *** Controlla che il tool hashr.exe esiste.
SET PathHashr=%~dp0hashr.exe
IF NOT EXIST "%PathHashr%" (
  CALL :Log "Il tool %PathHashr% non è stato trovato."
  GOTO :End
)

REM *** Controlla se la cartella IOC esiste.
SET IoCSubFolder=%~dp0IoC
IF NOT EXIST "%IoCSubFolder%" (
  CALL :Log "La cartella %IoCSubFolder% non è stata trovata."
  GOTO :End
)

REM *** Creazione cartella Out.
SET OutSubFolder=%~dp0Out
IF NOT EXIST "%OutSubFolder%" MKDIR "%OutSubFolder%"
IF NOT ERRORLEVEL 0 (
  CALL :Log "Errore durante la creazione della cartella %OutSubFolder%."
  GOTO :End
)

REM *** Creazione cartella LOG.
SET LogSubFolder=%~dp0Log
IF NOT EXIST "%LogSubFolder%" MKDIR "%LogSubFolder%"
IF NOT ERRORLEVEL 0 (
  CALL :Log "Errore durante la creazione della cartella %LogSubFolder%."
  GOTO :End
)

CALL :Log "Ricerca file IoC nella cartella %IoCSubFolder% ..."

FOR %%f IN ("%IoCSubFolder%\*.*") DO (

  CALL :Log "Trovato file IoC %%f."
    
  REM *** Ottiene il nome del file senza estensione.
  SET IoCFileName=%%~nf

  SET OutFile=%OutSubFolder%\!IoCFileName!.%COMPUTERNAME%

  IF EXIST "!OutFile!.%IoCAbsent%.*" (

    CALL :Log "L'IoC %%f e' gia' stato verificato."

  ) ELSE (
  
    REM Esegui il comando hashr.exe.
    START /BELOWNORMAL /B /WAIT "Un hashr" "%PathHashr%" --hashlist "%%f" --rootdir "%RootFolder%" --output "!OutFile!" --log "%LogSubFolder%\!IoCFileName!.%COMPUTERNAME%.log"

    REM *** Controlla che non si siano verificati errori.
    IF !ERRORLEVEL! NEQ 0 (
      CALL :Log "Si sono verificati errori durante l'analisi dell'IoC %%f."
      TYPE NUL > !OutFile!.IoCError.%YEAR%-%MONTH%-%DAY%
    ) ELSE (

      REM *** Controlla la dimensione del file di output.
      FOR %%s in ("!OutFile!") DO SET "OutFileSize=%%~zs"

      REM *** Ridenominazioe file di output.
      IF !OutFileSize! EQU 0 (
        CALL :Log "Il file !OutFile! e' vuoto, non sono stati rivelati IoC."
        MOVE /Y "!OutFile!" "!OutFile!.%IoCAbsent%.%YEAR%-%MONTH%-%DAY%"
      ) ELSE (
        CALL :Log "Il file !OutFile! non e' vuoto, sono stati rivelati IoC."
        MOVE /Y "!OutFile!" "!OutFile!.IoCFound.%YEAR%-%MONTH%-%DAY%.txt"
        MSG * /time:0 "Attenzione Rilevati IoC '!IoCFileName!', avvertire gli amministratori di sistema."
      )

    )

  )

)

CALL :Log "Analisi completata."
:End
EXIT /b

:Log
SET "year=%DATE:~6,4%"
SET "month=%DATE:~3,2%"
SET "day=%DATE:~0,2%"
SET "hh=%TIME:~0,2%"
SET "hh=!hh: =0!"
SET "mm=%TIME:~3,2%"
SET "mm=!mm: =0!"
SET "ss=%TIME:~6,2%"
SET "ss=!ss: =0!"
ECHO %~1
>>"%PathFileLog%" ECHO [!year!-!month!-!day! !hh!:!!mm!:!ss!] %~1

EXIT /b
