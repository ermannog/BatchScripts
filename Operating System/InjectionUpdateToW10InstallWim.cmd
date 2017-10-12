@ECHO OFF
REM https://blogs.technet.microsoft.com/configmgrdogs/2012/02/14/applying-windows-updates-to-a-base-wim-using-dism-and-powershell/

REM Configurations
SET FolderNameOriginalWim=W10Ent64BitLTSB2016Ita
SET FolderNameDestinationWim=W10Ent64BitLTSB2016Ita-KB4041691
SET FolderNameUpdate=2017-10-KB4041691-W10V1607-x64
SET FolderNameTempMount=Temp-Mount

REM Set paths
SET FileOriginalWim=%~dp0%FolderNameOriginalWim%\install.wim
SET PathDestinationWim=%~dp0%FolderNameDestinationWim%
SET PathUpdate=%~dp0%FolderNameUpdate%
SET FileDestinationWim=%PathDestinationWim%\install.wim
SET PathTempMount=%~dp0%FolderNameTempMount%

ECHO Creation Directories
MD %PathDestinationWim%
MD %PathTempMount%

ECHO Copy wim file
COPY %FileOriginalWim% %PathDestinationWim%

ECHO Mount image
DISM /Mount-Wim /WimFile:%FileDestinationWim% /index:1 /Mountdir:%PathTempMount%

ECHO Inject the Update
DISM /image:%PathTempMount% /Add-Package /Packagepath:%PathUpdate%

ECHO Save and unmount the image
DISM /Unmount-Wim /Mountdir:%PathTempMount% /commit

ECHO Clean stale or corrupted files if issue with the mount points occurs
DISM /Cleanup-Wim

PAUSE
