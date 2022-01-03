$info = Get-Content -path C:\Windows\System32\drivers\etc\hosts
Get-Item 

Write-Host "Raw contains $($info.Count) lines."



$SEL = Select-String -Path C:\Windows\System32\drivers\etc\hosts -Pattern "for example"

if ($SEL -ne $null)
{
    echo Contains String
}
else
{
    echo Not Contains String
}



If (Get-Content C:\Windows\System32\drivers\etc\hosts | %{$_ -match "entry"}) 
{
    echo Contains String
}
else
{
    echo Not Contains String
}
