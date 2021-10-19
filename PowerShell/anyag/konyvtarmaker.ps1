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
   [string] $csvpath, 

   [Parameter()]
   [string] $startdir
)
#---------------------------------------------------------[Initialisations]--------------------------------------------------------
# Write-Host $csvpath
# Write-Host $startdir
#----------------------------------------------------------[Declarations]----------------------------------------------------------
If (Test-Path -Path $csvpath) {
    $konyvtarak = Import-Csv $csvpath     
    $konyvtarak   
}
Else {
    Write-Host "Nem jó a csv utvonala"
}
If ($startdir) {
  If (Test-Path -Path $startdir) {
    Set-Location $startdir  
    Write-Host "Van kezdo utvonal"
  } 
  Else {
    Write-Host "Nem jó a kezdő utvonal, az aktuális könyvtárba készülnek a könyvtárak"
  }     
}
Else {
    Write-Host "Hiányzik a kezdő utvonal, az aktuális könyvtárba készülnek a könyvtárak"
}

#-----------------------------------------------------------[Functions]------------------------------------------------------------

#-----------------------------------------------------------[Execution]------------------------------------------------------------

#-----------------------------------------------------------[Finish up]------------------------------------------------------------
