arp -d * 
nbtstat -R 
nbtstat -RR
ipconfig /flushdns
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /registerdns

pause
