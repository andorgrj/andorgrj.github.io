TrustedHost megadása

Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*" -Force  -> * helyett ip cím megadható
Get-Item WSMan:\localhost\Client\TrustedHosts


-----------------------------------------------------------------------------------------------------------------------------
Remote Session / PSSession / Windows Remote Management


$username = "gandor"
$password = ConvertTo-SecureString "Password123!" -AsPlainText -Force
$gandorscred = New-Object System.Management.Automation.PSCredential ($username, $password)

New-PSSession -ComputerName 10.0.0.5 -Credential $gandorscred  -> belső ip címet kell megadni
Get-PSSession
Enter-PSSession 1 -> PSSession-be itt tudok belemenni (jelen esetben a core gépbe)

------------------------------------------------------------------------------------------------------------------------------
The Invoke-Command cmdlet runs commands on a local or remote computer and returns all output from the commands, including errors. Using a single Invoke-Command command, you can run commands on multiple computers.


Get-Service winrm


Invoke-Command -ScriptBlock {$env:COMPUTERNAME} -ComputerName 10.1.0.5
Invoke-Command -ScriptBlock {D:\ps.ps1} -ComputerName 10.1.0.5





