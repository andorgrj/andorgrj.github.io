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
[CmdletBinding()] #hozzáköti a ps parancsot
Param (
   #[Parameter(ValueFromPipelineByPropertyName)]
   [Parameter(Mandatory)]
   [string] $csvpath, 

   [Parameter()]
   [string] $startdir
)
#---------------------------------------------------------[Initialisations]--------------------------------------------------------
  #Write-Host $csvpath
  #Write-Host $startdir
#----------------------------------------------------------[Declarations]----------------------------------------------------------
$valasz = @('&Yes', '&No')
$dontes = $Host.UI.PromptForChoice('Konyvtarak letrehozasa','Biztos benne?', $valasz, 1)
If ($dontes -eq 0) {
    $konyvtarak | ForEach-Object {Write-Host $_.Name}
}
Else {
    Write-Host "Faszt" -BackgroundColor DarkGreen
}



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

$csvimport = import-csv -Path $csvpath
Write-Host 'Könyvtárak száma:' $csvimport.Count

#-----------------------------------------------------------[Functions]------------------------------------------------------------

#-----------------------------------------------------------[Execution]------------------------------------------------------------

#-----------------------------------------------------------[Finish up]------------------------------------------------------------

IF (Test-Path -Path $csvpath) {
    $csvtartalom = Import-Csv -Path $csvutvonal

    $valasz = @('&Yes', '&No')
    $dontes = $Host.UI.Prompt
}