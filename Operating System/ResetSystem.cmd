@ECHO OFF

ECHO Reset WMI Repository
NET STOP winmgmt /y
winmgmt /resetrepository

ECHO Rebuild the performance counters
lodctr /r
ECHO You can check performance counters status after rebuild by running the following command:
ECHO lodctr /q or lodctr /q:[counter name]
ECHO If you see (Disabled) next to a counter, you can enable it by running the following command:
ECHO lodctr /e:[counter name]
ECHO lodctr /r

ECHO Reset IP
NETSH int ip reset 

ECHO Reset Winsock
NETSH winsock reset

ECHO Restart computer
shutdown -r -t 30
