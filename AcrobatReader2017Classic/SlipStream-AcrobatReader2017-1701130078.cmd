@ECHO OFF
CLS

REM *** Configurazioni ***
SET PackageFileNameAdobeReader2017Base=AcroRdr20171700830051_MUI.exe
SET PackageFileNameAdobeReader2017Update=AcroRdr2017Upd1701130078_MUI.msp
SET FolderNameAdobeReader2017Base=AcrobatReader2017-Base
SET FolderNameAdobeReader2017Slipstream=AcrobatReader2017-Update1701130078

REM *** Impostazioni path ***
SET AdobeReader2017BaseFile="%~dp0%PackageFileNameAdobeReader2017Base%"
SET AdobeReader2017BaseExtractFolder="%~dp0%FolderNameAdobeReader2017Base%"
SET AdobeReader2017UpdateFile="%~dp0%PackageFileNameAdobeReader2017Update%"
SET AdobeReader2017SlipstreamFolder="%~dp0%FolderNameAdobeReader2017Slipstream%"
SET AdobeReader2017BaseExtractMsiFile="%~dp0%FolderNameAdobeReader2017Base%\AcroRead.msi"
SET AdobeReader2017SlipstreamMsiFile="%~dp0%FolderNameAdobeReader2017Slipstream%\AcroRead.msi"
SET LOGFile="%~dpn0.log"

REM *** Visualizzazione impostazioni ***
ECHO Acrobat Reader 2017 Slipstream settings:
ECHO Base package file: %PackageFileNameAdobeReader2017Base%
ECHO Update package file: %PackageFileNameAdobeReader2017Update%
ECHO Estract path: %AdobeReader2017BaseExtractFolder%
ECHO Splipstream path: %AdobeReader2017SlipstreamFolder%
ECHO Log: %LOGFile%
ECHO.

REM *** Delete log file ***
IF EXIST %LOGFile% DEL /Q %LOGFile%

REM *** Check AdobeReader2017 Base ***
IF NOT EXIST %AdobeReader2017BaseFile% ECHO Errore: Package Adobe Reader 2017 Base (%PackageFileNameAdobeReader2017Base%) non trovato! & GOTO :END

REM *** Check AdobeReader2017 Update ***
IF NOT EXIST %AdobeReader2017UpdateFile% ECHO Errore: Package Adobe Reader 2017 Update (%PackageFileNameAdobeReader2017Update%) non trovato! & GOTO :END

REM *** Estrazione package Adobe Reader 2017 Base ***
IF NOT EXIST %AdobeReader2017BaseExtractFolder% (
  ECHO Estrazione package Adobe Reader 2017 Base %PackageFileNameAdobeReader2017Base%...
  MD %AdobeReader2017BaseExtractFolder%
  %AdobeReader2017BaseFile% -sfx_o%AdobeReader2017BaseExtractFolder% -sfx_ne
  ECHO Estrazione package Adobe Reader 2017 Base eseguita.
  ECHO.
) ELSE (
  ECHO Directory estrazione package Adobe Reader 2017 Base presente.
  ECHO.
)

REM *** Installazione amministrativa Adobe Reader 2017 Base ***
ECHO Installazione amministrativa Adobe Reader 2017 Base %PackageFileNameAdobeReader2017Base%...
IF EXIST %AdobeReader2017SlipstreamFolder% RD /S /Q %AdobeReader2017SlipstreamFolder%
MD %AdobeReader2017SlipstreamFolder%
msiexec /a %AdobeReader2017BaseExtractMsiFile% TARGETDIR=%AdobeReader2017SlipstreamFolder% /qr /liwemo! %LOGFile%
IF %ERRORLEVEL% NEQ 0 ECHO Errore durante installazione amministrativa Adobe Reader 2017 Base! & GOTO :END
ECHO Installazione amministrativa Adobe Reader 2017 Base eseguita.
ECHO.

REM *** Slipstream AdobeReader2017 Update ***
ECHO Slipstream Adobe Reader 2017 Update %PackageFileNameAdobeReader2017Update%...
msiexec /a %AdobeReader2017SlipstreamMsiFile% /p %AdobeReader2017UpdateFile% TARGETDIR=%AdobeReader2017SlipstreamFolder%  /qr /liwemo!+ "%~dpn0.log"
IF %ERRORLEVEL% NEQ 0 ECHO Errore durate slipstream Adobe Reader 2017 Update! & GOTO :END
ECHO Slipstream AdobeReader2017 Update eseguito
ECHO.


REM *** Termine operazioni ***
:END
PAUSE