Fájlba írás/pipe


Get-Date
$a = Get-ComputerInfo
$a.OsName

$filePath = "$env:USERPROFILE\Desktop\"
$fileName = "bbbbb.txt"

$filePath2 = "$env:USERPROFILE\Desktop\hhhhhh.txt"

$a.OsName | Out-File -FilePath $filePath2
Get-Date | Out-File -FilePath $filePath2 -Append

"ÉÉÉ ÍÍÍ ŐŐŐ" | Out-File -filePath $filePath2 -Append -Encoding utf8