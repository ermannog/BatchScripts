# Batch Scripts
Scripts batch

## WUReset.cmd
Script that performs the following steps:
- Stop Automatic Update service and BITS service
- Delete folder %windir%\SoftwareDistribution
- Start Automatic Update service and BITS service
- Force expire of the WSUS cookie on client computer
- Initiates an asynchronous background search for applicable updates from WSUS server 

## WURebuild.cmd
Delete user profiles on local or remote computer that match the search criteria
