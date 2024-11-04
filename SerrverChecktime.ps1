
<#Author
Hamdou Wane
Server Uptime Check Script
#This PowerShell script reads a list of servers from a text file and retrieves the last restart time for each server, outputting the results to a file.
#>
<# Description

The script performs the following operations:
1. Reads server names from a specified input file
2. Queries each server using WMI to get operating system information
3. Extracts the last boot time for each server
4. Writes the results to an output file
#>
<#Prerequisites

- PowerShell v3.0 or later
- Read access to the servers being queried
- WMI access to target servers
- Write permissions to the output file location
-Ensure Windows Firewall allows WMI traffic (TCP ports 135, 445, and dynamic ports)
#>
## Script Parameters
#>
$servers = get-content C:\MyFiles\ServerList.txt
foreach ( $server in $servers) {
    $serveroutput = Get-WmiObject -Class Win32_Operatingsystem -ComputerName $server | 
        Select-Object @{
            'Name'='ServerName'
            'Expression'= {$_.PSComputerName}
        }, 
        @{
            'Name'='Last Restart Time'
            'Expression'= {$_.ConvertToDateTime($_.LastBootUpTime)}
        }
    $serveroutput.ServerName, $serveroutput.'Last Restart Time' | 
        Out-File C:\MyFiles\outpout.txt -Append
}



