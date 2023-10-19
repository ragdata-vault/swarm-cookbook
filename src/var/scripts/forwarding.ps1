Get-NetIPInterface | where {$_.InterfaceAlias -eq 'vEthernet (WSL)'} | Set-NetIPInterface -Forwarding Enabled -Verbose
Get-NetIPInterface | where {$_.InterfaceAlias -eq 'vEthernet (WSL)' -or $_.InterfaceAlias -eq 'vEthernet (Default Switch)'} | Set-NetIPInterface -Forwarding Enabled -Verbose
