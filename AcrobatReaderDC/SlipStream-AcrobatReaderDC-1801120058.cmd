@ECHO OFF
CLS

REM *** Configurazioni ***
SET PackageFileNameAdobeReaderDCBase=AcroRdrDC1500720033_MUI.exe
SET PackageFileNameAdobeReaderDCUpdate=AcroRdrDCUpd1801120058_MUI.msp
SET FolderNameAdobeReaderDCBase=AcrobatReaderDC-Base
SET FolderNameAdobeReaderDCSlipstream=AcrobatReaderDC-Update1801120058

REM *** Impostazioni path ***
SET AdobeReaderDCFile="%~dp0%PackageFileNameAdobeReaderDCBase%"
SET AdobeReaderDCBaseExtractFolder="%~dp0%FolderNameAdobeReaderDCBase%"
SET AdobeReaderDCUpdateFile="%~dp0%PackageFileNameAdobeReaderDCUpdate%"
SET AdobeReaderDCSlipstreamFolder="%~dp0%FolderNameAdobeReaderDCSlipstream%"
SET AdobeReaderDCBaseExtractMsiFile="%~dp0%FolderNameAdobeReaderDCBase%\AcroRead.msi"
SET AdobeReaderDCSlipstreamMsiFile="%~dp0%FolderNameAdobeReaderDCSlipstream%\AcroRead.msi"
SET LOGFile="%~dpn0.log"

REM *** Visualizzazione impostazioni ***
ECHO Acrobat Reader DC Slipstream settings:
ECHO Base package file: %PackageFileNameAdobeReaderDCBase%
ECHO Update package file: %PackageFileNameAdobeReaderDCUpdate%
ECHO Estract path: %AdobeReaderDCBaseExtractFolder%
ECHO Splipstream path: %AdobeReaderDCSlipstreamFolder%
ECHO Log: %LOGFile%
ECHO.

REM *** Delete log file ***
IF EXIST %LOGFile% DEL /Q %LOGFile%

REM *** Check AdobeReaderDC Base ***
IF NOT EXIST %AdobeReaderDCFile% ECHO Errore: Package Adobe Reader DC Base (%PackageFileNameAdobeReaderDCBase%) non trovato! & GOTO :END

REM *** Check AdobeReaderDC Update ***
IF NOT EXIST %AdobeReaderDCUpdateFile% ECHO Errore: Package Adobe Reader DC Update (%PackageFileNameAdobeReaderDCUpdate%) non trovato! & GOTO :END

REM *** Estrazione package Adobe Reader DC Base ***
IF NOT EXIST %AdobeReaderDCBaseExtractFolder% (
  ECHO Estrazione package Adobe Reader DC Base %PackageFileNameAdobeReaderDCBase%...
  MD %AdobeReaderDCBaseExtractFolder%
  %AdobeReaderDCFile% -sfx_o%AdobeReaderDCBaseExtractFolder% -sfx_ne
  ECHO Estrazione package Adobe Reader DC Base eseguita.
  ECHO.
) ELSE (
  ECHO Directory estrazione package Adobe Reader DC Base presente.
  ECHO.
)

REM *** Installazione amministrativa Adobe Reader DC Base ***
ECHO Installazione amministrativa Adobe Reader DC Base %PackageFileNameAdobeReaderDCBase%...
IF EXIST %AdobeReaderDCSlipstreamFolder% RD /S /Q %AdobeReaderDCSlipstreamFolder%
MD %AdobeReaderDCSlipstreamFolder%
msiexec /a %AdobeReaderDCBaseExtractMsiFile% TARGETDIR=%AdobeReaderDCSlipstreamFolder% /qr /liwemo! %LOGFile%
IF %ERRORLEVEL% NEQ 0 ECHO Errore durante installazione amministrativa Adobe Reader DC Base! & GOTO :END
ECHO Installazione amministrativa Adobe Reader DC Base eseguita.
ECHO.

REM *** Slipstream AdobeReaderDC Update ***
ECHO Slipstream Adobe Reader DC Update %PackageFileNameAdobeReaderDCUpdate%...
msiexec /a %AdobeReaderDCSlipstreamMsiFile% /p %AdobeReaderDCUpdateFile% TARGETDIR=%AdobeReaderDCSlipstreamFolder%  /qr /liwemo!+ "%~dpn0.log"
IF %ERRORLEVEL% NEQ 0 ECHO Errore durate slipstream Adobe Reader DC Update! & GOTO :END
ECHO Slipstream Adobe Reader DC Update eseguito
ECHO.


REM *** Termine operazioni ***
:END
PAUSE