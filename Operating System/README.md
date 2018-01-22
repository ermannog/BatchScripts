# Batch Scripts for operating system management

## UpgradeToWin10.cmd
Script that performs the upgrate of the operating system to Windows 10, the script is preconfigured for upgrade to Windows 10 1703 64 Bit Italian excuting the following steps:
- Copy source files from a network share Mapping a temporary drive to local system drive
- Start upgrade to Windows 10 excuting the setup from the local system drive copy with the following modes:
  - Performs an upgrade of Windows saving apps and data [Command line option: **/auto upgrade**]
  - Perform Dynamic Update operations (search, download, and install updates) [Command line option: **/DynamicUpdate enable**]
  - Migrate the drivers from the existing installation during the upgrade [Command line option: **/migratedrivers all**]
  - Skips OOBE and selects the default settings [Command line option: **/showoobe none**]
  - Setup does not capture and report installation data [Command line option: **/telemetry disable**]
## InjectionUpdateToW10InstallWim.cmd
Script that performs the injection of an update in an Windows 10 image file (install.wim), the script is preconfigured for the injection of the KB4041691 for Windows 10 1607 x64 in an Windows 10 Enteprise 64 Bit LTSB 2016 Italian excuting the following steps:
- Copy original wim file in a new folder
- Mount copied image
- Inject the Update
- Save and unmount the image
- Clean stale or corrupted files if issue with the mount points occurs
## ResetSystem.cmd
Script that performs the following operations:
- Reset WMI Repository
- Reset Winsock
- Restart computer
