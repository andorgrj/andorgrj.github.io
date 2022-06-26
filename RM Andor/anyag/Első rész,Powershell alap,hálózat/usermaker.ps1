<#
.SYNOPSIS
  Script to <what will the script do>
.DESCRIPTION
  This script will <Elaborate on what the script does>
.PARAMETER Param1
  Specifies <What? Is the parameter required?>
.INPUTS
  <Does the script accept an input>
.OUTPUTS
  A log file in the temp directory of the user running the script
.NOTES
  Version:        0.1
  Author:         Sven de Windt
  Creation Date:  <Date>
  Purpose/Change: Initial script development
.EXAMPLE
  .\konyvtarmaker.ps1 -csvpath .\folders.csv -startdir .\
#>

#requires -version 5.1

#-----------------------------------------------------------[Parameters]-----------------------------------------------------------
[CmdletBinding()]
Param (
   #[Parameter(ValueFromPipelineByPropertyName)]
   [Parameter(Mandatory)]
   [string] $csvpath
)
#---------------------------------------------------------[Initialisations]--------------------------------------------------------
# Write-Host $csvpath
# Write-Host $startdir
#----------------------------------------------------------[Declarations]----------------------------------------------------------

IF (Test-Path -Path $csvpath) {
    $csvtartalom = Import-Csv -Path $csvpath

    $valasz = @('&Yes', '&No')
    $dontes = $Host.UI.PromptForChoice('Felhasználók letrehozasa','Biztos benne?', $valasz, 1)
    If ($dontes -eq 0) {
        ForEach ($felhasznalo in $csvtartalom) {
            # Write-Host $felhasznalo.name
            #<#
            New-LocalUser -Name $felhasznalo.Name`
                     -FullName $felhasznalo.FullName`
                     -Description $felhasznalo.Description `
                     -Password (ConvertTo-SecureString $felhasznalo.Password -AsPlainText -Force)
            #>
            #Remove-LocalUser -Name $felhasznalo.Name
            Add-LocalGroupMember -Group $felhasznalo.Group -Member $felhasznalo.Name
        }
    }
    Else {
        Write-Host "Mégsem hozom létre a felhasználókat"
    }        
}
Else {
    Write-Host "Nem jó a csv utvonala"
}
#-----------------------------------------------------------[Functions]------------------------------------------------------------

#-----------------------------------------------------------[Execution]------------------------------------------------------------

#-----------------------------------------------------------[Finish up]------------------------------------------------------------
