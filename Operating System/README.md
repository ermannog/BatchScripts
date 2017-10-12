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
