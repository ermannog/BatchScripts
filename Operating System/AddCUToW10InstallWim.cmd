@ECHO OFF
REM https://blogs.technet.microsoft.com/configmgrdogs/2012/02/14/applying-windows-updates-to-a-base-wim-using-dism-and-powershell/
REM https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/servicing-the-image-with-windows-updates-sxs

REM Configurations
SET FolderNameOriginalWim=W10EntLTSB1607-x64-ITA-RTM
SET FolderNameDestinationWim=W10EntLTSB1607-x64-ITA-Updated
SET FolderNameServiceUpdate=Updates\SUMag2018
SET FolderNameCumulativeUpdate=Updates\CUSet2018
SET FolderNameMount=Mount
SET FolderNameTemp=Temp
SET LogFileName=%~n0.log

REM Set paths
SET FileOriginalWim=%~dp0%FolderNameOriginalWim%\sources\install.wim
SET PathDestinationWim=%~dp0%FolderNameDestinationWim%
SET PathServiceUpdate=%~dp0%FolderNameServiceUpdate%
SET PathCumulativeUpdate=%~dp0%FolderNameCumulativeUpdate%
SET FileDestinationWim=%PathDestinationWim%\install.wim
SET PathMount=%~dp0%FolderNameMount%
SET PathTemp=%~dp0%FolderNameTemp%
SET PathFileLog=%~dp0%LogFileName%

ECHO Delete file log
IF EXIST %PathFileLog% DEL %PathFileLog%

ECHO Delete temp directory
IF EXIST %PathTemp% DEL %PathTemp% /Q

ECHO Creation Directories
MD %PathDestinationWim%
MD %PathMount%
MD %PathTemp%

ECHO Copy wim file
COPY %FileOriginalWim% %PathDestinationWim%

ECHO Mount image
DISM /Mount-Wim /WimFile:%FileDestinationWim% /index:1 /Mountdir:%PathMount% /LogPath=%PathFileLog%

ECHO Add the Service Update
DISM /Image:%PathMount% /Add-Package /Packagepath:%PathServiceUpdate% /LogPath=%PathFileLog%

ECHO Add the Cumulative Update
DISM /Image:%PathMount% /Add-Package /Packagepath:%PathCumulativeUpdate% /LogPath=%PathFileLog%

ECHO Lock in the updates so they are restored during a recovery
DISM /Cleanup-Image /Image:%PathMount% /StartComponentCleanup /ResetBase /ScratchDir:%PathTemp% /LogPath=%PathFileLog%

ECHO Verify the packages installed
Dism /Get-Packages /Image:%PathMount% /LogPath=%PathFileLog%
PAUSE

ECHO Save and unmount the image
DISM /Unmount-Wim /Mountdir:%PathMount% /Commit /LogPath=%PathFileLog%

ECHO Clean stale or corrupted files if issue with the mount points occurs
DISM /Cleanup-Wim /LogPath=%PathFileLog%

ECHO Get destination wim info
DISM /Get-WimInfo /WimFile:%FileDestinationWim% /index:1 /LogPath=%PathFileLog%

PAUSE