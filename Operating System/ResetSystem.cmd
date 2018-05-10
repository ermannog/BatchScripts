REM Reset WMI Repository
NET STOP winmgmt /y
winmgmt /resetrepository

REM Reset IP
NETSH int ip reset 

REM Reset Winsock
NETSH winsock reset

REM Restart computer
shutdown -r -t 0
