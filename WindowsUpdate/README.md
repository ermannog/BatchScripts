# Batch Scripts for Windows Update tasks

## WUForce.cmd
Script that performs a forced execution of Winwdows Update using the tool UsoClient.exe excuting the following steps:
- Scan Updates
- Download updates
- Install updates
- Restart Computer

## WUReset.cmd
Script that performs the reset of Windows Update excuting the following steps:
- Stop Automatic Update service and BITS service
- Delete folder %windir%\SoftwareDistribution
- Start Automatic Update service and BITS service
- Force expire of the WSUS cookie on client computer
- Initiates an asynchronous background search for applicable updates from WSUS server 

## WURebuild.cmd
Script that performs the rebuid of Windows Update excuting the following steps:
- Stop Automatic Update service and BITS service
- Delete folder %windir%\SoftwareDistribution
- Registration of Windows Update DLL
- Start Automatic Update service and BITS service
- Force expire of the WSUS cookie on client computer
- Initiates an asynchronous background search for applicable updates from WSUS server
