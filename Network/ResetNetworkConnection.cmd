netsh winsock reset
netsh int ip reset
arp -d * 
nbtstat -R 
nbtstat -RR
ipconfig /flushdns
ipconfig /release
ipconfig /renew
ipconfig /registerdns

pause
