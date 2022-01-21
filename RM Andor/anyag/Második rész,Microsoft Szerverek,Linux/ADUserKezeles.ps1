# Új ADUser

$UPN = "testlab.local"
$username = "valaki.lanya"
$firstname = "Valaki"
$lastname = "Lánya"
$OU = "OU=PeldaUsers,OU=Peldaceg,DC=testlab,DC=local"
$telephone = "+36305550101"
$company = "JólTeljesít Zrt."
$streetaddress = "Egyenes lejtő 2."
$city = "Sarokkő"
$zipcode = "8999"
$email = $username+"@"+$UPN

New-ADUser `
            -SamAccountName $username `
            -UserPrincipalName "$username@$UPN" `
            -Name "$firstname $lastname" `
            -GivenName $firstname `
            -Surname $lastname `
            -Enabled $True `
            -DisplayName "$lastname, $firstname" `
            -Path  $OU `
            -City $city `
            -PostalCode $zipcode `
            -Company $company `
            -StreetAddress $streetaddress `
            -OfficePhone $telephone `
            -EmailAddress $email `
            -AccountPassword (ConvertTo-SecureString  'Welcome01!' -AsPlainText -Force) -PasswordNeverExpires $true


# Lekérdezés
#Egyszerű

Get-ADUser -Filter *
Get-ADUser -Identity Administrator
Get-ADUser -SearchBase "OU=PeldaUsers, OU=Peldaceg,DC=testlab,DC=local"

#Formázott
$SearchLocDN = "OU=PeldaUsers, OU=Peldaceg,DC=testlab,DC=local"
Get-ADUser -searchbase "$SearchLocDN" -Properties * -Filter * |  
    Select-Object @{Label = "First Name";Expression = {$_.GivenName}},  
    @{Label = "Last Name";Expression = {$_.Surname}}, 
    @{Label = "Display Name";Expression = {$_.DisplayName}}, 
    @{Label = "Logon Name";Expression = {$_.sAMAccountName}}, 
    @{Label = "Full address";Expression = {$_.StreetAddress}}, 
    @{Label = "City";Expression = {$_.City}}, 
    @{Label = "State";Expression = {$_.st}}, 
    @{Label = "Post Code";Expression = {$_.PostalCode}}, 
    @{Label = "Country/Region";Expression = {if (($_.Country -eq 'GB')  ) {'United Kingdom'} Else {''}}}, 
    @{Label = "Job Title";Expression = {$_.Title}}, 
    @{Label = "Company";Expression = {$_.Company}}, 
    @{Label = "Description";Expression = {$_.Description}}, 
    @{Label = "Department";Expression = {$_.Department}}, 
    @{Label = "Office";Expression = {$_.OfficeName}}, 
    @{Label = "Phone";Expression = {$_.telephoneNumber}}, 
    @{Label = "Email";Expression = {$_.Mail}}, 
    @{Label = "Manager";Expression = {%{(Get-AdUser $_.Manager -server $Server -Properties DisplayName).DisplayName}}}, 
    @{Label = "Account Status";Expression = {if (($_.Enabled -eq 'TRUE')  ) {'Enabled'} Else {'Disabled'}}}, # the 'if statement# replaces $_.Enabled 
    @{Label = "Last LogOn Date";Expression = {$_.lastlogondate}}
    
    #Export CSV report 
    #|Export-Csv -Path $csvreportfile -utf8 -NoTypeInformation     