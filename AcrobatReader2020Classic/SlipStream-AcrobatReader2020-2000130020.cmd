@ECHO OFF
CLS

REM *** Configurazioni ***
SET PackageFileNameAdobeReader2020Base=AcroRdr20202000130002_MUI.exe
SET PackageFileNameAdobeReader2020Update=AcroRdr2020Upd2000130020_MUI.msp
SET FolderNameAdobeReader2020Base=AcrobatReader2020-Base
SET FolderNameAdobeReader2020Slipstream=AcrobatReader2020Classic-Update2000130020

REM *** Impostazioni path ***
SET AdobeReader2020BaseFile="%~dp0%PackageFileNameAdobeReader2020Base%"
SET AdobeReader2020BaseExtractFolder="%~dp0%FolderNameAdobeReader2020Base%"
SET AdobeReader2020UpdateFile="%~dp0%PackageFileNameAdobeReader2020Update%"
SET AdobeReader2020SlipstreamFolder="%~dp0%FolderNameAdobeReader2020Slipstream%"
SET AdobeReader2020BaseExtractMsiFile="%~dp0%FolderNameAdobeReader2020Base%\AcroRead.msi"
SET AdobeReader2020SlipstreamMsiFile="%~dp0%FolderNameAdobeReader2020Slipstream%\AcroRead.msi"
SET LOGFile="%~dpn0.log"

REM *** Visualizzazione impostazioni ***
ECHO Acrobat Reader 2020 Slipstream settings:
ECHO Base package file: %PackageFileNameAdobeReader2020Base%
ECHO Update package file: %PackageFileNameAdobeReader2020Update%
ECHO Estract path: %AdobeReader2020BaseExtractFolder%
ECHO Splipstream path: %AdobeReader2020SlipstreamFolder%
ECHO Log: %LOGFile%
ECHO.

REM *** Delete log file ***
IF EXIST %LOGFile% DEL /Q %LOGFile%

REM *** Check AdobeReader2020 Base ***
IF NOT EXIST %AdobeReader2020BaseFile% ECHO Errore: Package Adobe Reader 2020 Base (%PackageFileNameAdobeReader2020Base%) non trovato! & GOTO :END

REM *** Check AdobeReader2020 Update ***
IF NOT EXIST %AdobeReader2020UpdateFile% ECHO Errore: Package Adobe Reader 2020 Update (%PackageFileNameAdobeReader2020Update%) non trovato! & GOTO :END

REM *** Estrazione package Adobe Reader 2020 Base ***
IF NOT EXIST %AdobeReader2020BaseExtractFolder% (
  ECHO Estrazione package Adobe Reader 2020 Base %PackageFileNameAdobeReader2020Base%...
  MD %AdobeReader2020BaseExtractFolder%
  %AdobeReader2020BaseFile% -sfx_o%AdobeReader2020BaseExtractFolder% -sfx_ne
  ECHO Estrazione package Adobe Reader 2020 Base eseguita.
  ECHO.
) ELSE (
  ECHO Directory estrazione package Adobe Reader 2020 Base presente.
  ECHO.
)

REM *** Installazione amministrativa Adobe Reader 2020 Base ***
ECHO Installazione amministrativa Adobe Reader 2020 Base %PackageFileNameAdobeReader2020Base%...
IF EXIST %AdobeReader2020SlipstreamFolder% RD /S /Q %AdobeReader2020SlipstreamFolder%
MD %AdobeReader2020SlipstreamFolder%
msiexec /a %AdobeReader2020BaseExtractMsiFile% TARGETDIR=%AdobeReader2020SlipstreamFolder% /qr /liwemo! %LOGFile%
IF %ERRORLEVEL% NEQ 0 ECHO Errore durante installazione amministrativa Adobe Reader 2020 Base! & GOTO :END
ECHO Installazione amministrativa Adobe Reader 2020 Base eseguita.
ECHO.

REM *** Slipstream AdobeReader2020 Update ***
ECHO Slipstream Adobe Reader 2020 Update %PackageFileNameAdobeReader2020Update%...
msiexec /a %AdobeReader2020SlipstreamMsiFile% /p %AdobeReader2020UpdateFile% TARGETDIR=%AdobeReader2020SlipstreamFolder%  /qr /liwemo!+ "%~dpn0.log"
IF %ERRORLEVEL% NEQ 0 ECHO Errore durate slipstream Adobe Reader 2020 Update! & GOTO :END
ECHO Slipstream AdobeReader2020 Update eseguito
ECHO.


REM *** Termine operazioni ***
:END
PAUSE