#This PowerShell script demonstrates secure credential management for remote system administration. 
# 1. Generate AES Key
$key = New-Object Byte[] 32
[security.cryptography.RNGCryptoserviceprovider]::Create().Getbytes($key)
$key | Out-File C:\PS\aes.key
# 2. Store Encrypted Credentials
(Get-Credential).Password | ConvertFrom-SecureString -Key (Get-Content C:\ps\aes.key) | Set-Content 'C:\ps\password.txt'
# 3. Load and Use Credentials
$password = Get-Content C:\ps\password.txt | ConvertTo-SecureString -key (Get-Content C:\ps\aes.key)
$credentials = New-Object System.Management.Automation.PSCredential("Labadmin",$password)

# 4. Query Remote System
Get-WmiObject -Class win32_operatingsystem -ComputerName CM1 -Credential $credential
