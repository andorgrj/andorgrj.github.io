$csvutvonal = "C:\Users\Admin\ifksp\RM\users.csv"

IF (Test-Path -Path $csvutvonal) {
    $csvtartalom = Import-Csv -Path $csvutvonal
}
$csvtartalom.Name
$csvtartalom.Description

csvtartalom[0].Name

$jelszo = ConvertTo-SecureString $csvtartalom[0].Password -AsPlainText -Force
$jelszo2 = ConvertFrom-SecureString $jelszo
$jelszo3 =ConvertTo-SecureString $jelszo2

New-LocalUser -Name $csvtartalom[0].Name`
                 -FullName $csvtartalom[0].FullName`
                 -Description $csvtartalom[0].Description`
                 -Password (ConvertTo-SecureString $csvtartalom[0].Password -AsPlainText -Force)