REM Removes all user-configured IPv4 (Internet Protocol version 4) settings.
REM Restarting the computer is required before the default settings will take effect.
netsh int ipv4 reset

REM Removes all user-configured IPv6 (Internet Protocol version 6) settings
REM Restarting the computer is required before the default settings will take effect.
netsh int ipv6 reset

REM Restores the Windows Firewall with Advanced Security policy to the default policy. 
netsh advfirewall reset

REM Resets Winsock Catalog to a clean state
netsh winsock reset

Pause

REM Restart the computer
shutdown /r /t 0
