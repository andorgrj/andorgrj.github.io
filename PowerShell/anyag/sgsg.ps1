IF (Test-Path -Path $csvpath) {
    $csvtartalom = Import-Csv -Path $csvutvonal

    $valasz = @('&Yes', '&No')
    $dontes = $Host.UI.Prompt
}