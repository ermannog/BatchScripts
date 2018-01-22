REM Reset WMI Repository
NET STOP winmgmt /y
winmgmt /resetrepository

REM Reset Winsock
NETSH winsock reset
