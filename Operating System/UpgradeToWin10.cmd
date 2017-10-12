@ECHO OFF
CLS

REM Configurations
SET PathUNCSource=\\hosts\share
SET FolderNameOSFiles=W10Ent64Bit1703Ita
SET DriveSource=Z:
SET ConfirmMessage="Upgrade to Windows 10 Enterprise 64 Bit 1703 Italian (15063.251)"

REM Set destination path
SET PathDestination=%SystemDrive%\%FolderNameOSFiles%

REM Confirm request
CHOICE /C SN /M %ConfirmMessage%
IF ERRORLEVEL 2 GOTO exit

REM Mapping temporary source drive
NET USE %DriveSource% %PathUNCSource%\%FolderNameOSFiles% /PERSISTENT:NO
%DriveSource%

ECHO Copy file on system drive
IF NOT EXIST %PathDestination% MD %PathDestination%
XCOPY %PathSource%\*.* %PathDestination% /E /I /H /R /K /Y /D /Q /V
IF NOT ERRORLEVEL 0 GOTO errorcopy

ECHO Start installation
%SystemDrive%
CD %PathDestination%
START Setup /auto upgrade /DynamicUpdate enable /migratedrivers all /showoobe none /telemetry disable

GOTO exit

:errorcopy
ECHO Error during copy files
PAUSE
GOTO exit

:exit
TIMEOUT /T 30 /NOBREAK
NET USE %DriveSource% /DELETE
