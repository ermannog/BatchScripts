# Batch Scripts for network tasks

## ResetNetworkAdapers.cmd
Script that perform the reset of the resetting your network adapters settings

## ResetNetworkConnection.cmd
Script that performs the reset of the network connection excuting the following steps:
- Restores the Winsock Catalog to a clean state and uninstalls all Winsock Layered Service Providers
- Reset TCP/IP
- Removes the listed entry from the ARP cache
- Purges the NetBIOS name cache and reloads all #PRE entries from LMHOSTS
- Releases and reregisters all NetBIOS names with the name server
- Removes all entries from the DNS name cache
- Releases the IP address
- Renews the IP address
- Refreshes all DHCP leases and reregisters DNS names

## SetIEProxy.cmd
Script that performs the set of the proxy in Internet Explorer. For more details see the post [Impostazione proxy tramite script](https://www.devadmin.it/2016/11/17/impostazione-proxy-tramite-script/)
