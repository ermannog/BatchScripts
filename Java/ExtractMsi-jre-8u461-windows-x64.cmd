@ECHO OFF
CLS

REM *** Configurazioni ***
SET PackageFileName=jre-8u461-windows-x64.exe
SET ExtractFolderName=jre1.8.0_461_x64

REM *** Impostazioni path ***
SET PackageFile="%~dp0%PackageFileName%"
SET MSISourceFolder="%UserProfile%\AppData\LocalLow\Oracle\Java\%ExtractFolderName%"
SET MSIDestinationFolder="%~dp0%ExtractFolderName%"

REM *** Controllo avvio con privilegi amministrativi ***
WHOAMI /GROUPS | FIND "S-1-16-12288" > nul
IF ERRORLEVEL 1 ECHO Lo script deve essere avviato con un utente che disponga di privilegi di amministratore locale & GOTO :END

REM *** Visualizzazione impostazioni ***
ECHO Java SE Runtime Environment MSI Extraction settings:
ECHO Package file: %PackageFile%
ECHO MSI source path: %MSISourceFolder%
ECHO MSI destination path: %MSIDestinationFolder%
ECHO.

REM *** Check Package File ***
IF NOT EXIST %PackageFile% ECHO Errore: Package Java SE Runtime Environment (%PackageFile%) non trovato! & GOTO :END

REM *** Start Setup ***
ECHO Avvio installazione Java SE Runtime Environment %PackageFileName%...
START "JRE Setup" %PackageFile%

REM *** Wait Start Setup for 10 seconds***
ECHO Attesa avvio setup...
TIMEOUT /T 10 /NOBREAK

REM *** COPY MSI in Extract Folder ***
ECHO Copia msi da directory temporanea nel profilo utente...
XCOPY %MSISourceFolder% %MSIDestinationFolder% /E /I

REM *** Quit Setup ***
ECHO Arresto installazione Java SE Runtime Environment %PackageFileName%...
TASKKILL /F /IM %PackageFileName%


REM *** Termine operazioni ***
:END
PAUSE