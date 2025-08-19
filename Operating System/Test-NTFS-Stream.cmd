PROMPT $
for /F "delims=#" %%E in ('"prompt #$E# & for %%E in (1) do rem"') do set "ESC=%%E"

SET SampleFileName=samplefile.txt
SET SampleFileNTFSADSName=%SampleFileName%:ADS.file
SET SampleSubDirName=SampleDir
SET SampleSubDirNTFSADSName=%SampleSubDirName%:ADS.dir

IF EXIST .\Test RD .\Test /S /Q
MD Test
CD Test
CLS

@ECHO %ESC%[92mCreazione file %SampleFileName%
ECHO Testo del file %SampleFileName% > %SampleFileName%"

@ECHO.
@ECHO %ESC%[94mCreazione NTFS ADS %SampleFileNTFSADSName%
ECHO Testo dell'NTFS ADS %SampleFileNTFSADSName% del file %SampleFileName% > %SampleFileNTFSADSName%

@ECHO.
@ECHO.
@ECHO %ESC%[93mCreazione directory %SampleSubDirName%
md %SampleSubDirName%

@ECHO.
@ECHO.
@ECHO %ESC%[95mCreazione NTFS Alternative Data Stream %SampleSubDirNTFSADSName%
ECHO Testo dell'NTFS Alternative Data Stream %SampleSubDirNTFSADSName% della directory %SampleSubDirName% > %SampleSubDirNTFSADSName%

@ECHO.
@ECHO.
@ECHO %ESC%[97mElenco file e cartelle
dir

@ECHO.
@ECHO %ESC%[96mElenco file e cartelle con visualizzazione dei NTFS Alternative Data Stream
dir /r

@ECHO.
@ECHO %ESC%[92mContenuto file %SampleFileName%
more < %SampleFileName%

@ECHO.
@ECHO.
@ECHO %ESC%[94mContenuto NTFS Alternative Data Stream %SampleFileNTFSADSName%
more < %SampleFileNTFSADSName%

@ECHO.
@ECHO.
@ECHO %ESC%[95mContenuto NTFS Alternative Data Stream %SampleSubDirNTFSADSName%
more < %SampleSubDirNTFSADSName%

PAUSE