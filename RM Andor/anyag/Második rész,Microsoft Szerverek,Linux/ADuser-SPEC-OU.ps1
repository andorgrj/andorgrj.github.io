Automatikus user készítés / SpecOU csv fájl tartozik hozzá


Import-Module ActiveDirectory
  
# Store the data from NewUsersFinal.csv in the $ADUsers variable
$ADUsers = Import-Csv C:\Users\dani\Desktop\SpecOU.csv -Delimiter ","

# Define UPN
$UPN = "20dani.local"
$subtree = "DC=20dani,DC=local"
#$dep = @("Adminisztráció", "IT", "Marketing", "Pénzügy", "Területi képviselők", "Vezetés", "Call Center", "Recepció", "Gyártás", "Raktározás", "Szállítmányozás", "Tervezés")
# Loop through each row containing user details in the CSV file
foreach ($User in $ADUsers) {

    #Read user data from each field in each row and assign the data to a variable as below
    $username = $User.username
    $password = $User.password
    $firstname = $User.GivenName
    $lastname = $User.Surname
    #$initials = $User.initials
    $OU = $User.OU
    $email = $User.EmailAddress
    $streetaddress = $User.StreetAddress
    $city = $User.city
    $zipcode = $User.zipcode
    #$state = $User.state
    $telephone = ($User.TelephoneCountryCode +" "+ $User.TelephoneNumber)
    #$jobtitle = $User.jobtitle
    $company = $User.company
    #$department = $User.department
    $OU = (Get-ADOrganizationalUnit -SearchBase $subtree -SearchScope Subtree -Filter 'Name -like $OU').DistinguishedName


    # Check to see if the user already exists in AD
    if (Get-ADUser -F { SamAccountName -eq $username }) {
        
        # If user does exist, give a warning
        Write-Warning "A user account with username $username already exists in Active Directory."
    }
    else {

        # User does not exist then proceed to create the new user account
        # Account will be created in the OU provided by the $OU variable read from the CSV file
        New-ADUser `
            -SamAccountName $username `
            -UserPrincipalName "$username@$UPN" `
            -Name "$firstname $lastname" `
            -GivenName $firstname `
            -Surname $lastname `
            -Enabled $True `
            -DisplayName "$lastname, $firstname" `
            -Path  $OU`
            -City $city `
            -PostalCode $zipcode `
            -Company $company `
            -StreetAddress $streetaddress `
            -OfficePhone $telephone `
            -EmailAddress $email `
            -AccountPassword (ConvertTo-secureString $password -AsPlainText -Force) -ChangePasswordAtLogon $True `

        # If user is created, show message.
        Write-Host "The user account $username is created." -ForegroundColor Cyan
    }
}

Read-Host -Prompt "Press Enter to exit"