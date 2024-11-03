$key=New-Object Byte[] 32
[security.cryptography.RNGCryptoserviceprovider]::Create().Getbytes($key)

$key  | Out-File C:\ps\aes.key

(Get-Credential).Password | ConvertFrom-SecureString -Key (Get-Content C:\ps\aes.key) | Set-Content 'C:\ps\password.txt'
$password=Get-Content C:\ps\password.txt |ConvertTo-SecureString -key (Get-Content C:\ps\aes.key)
$credentials=New-Object System.Management.Automation.PSCredential("appuser",$password)

Get-Service -ComputerName vm1 -credential $credentials