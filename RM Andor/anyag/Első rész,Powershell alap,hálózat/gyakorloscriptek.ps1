Get-Disk

$a = Get-Disk

$a | Select-Object -Property Number, HealthStatus

Get-Service | Where-Object {$_.Status -eq 'Running'}
Get-Service | Where-Object Status -EQ Running

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
Host fájl megkeresése ebben a példában

Get-ChildItem -File -Recurse -Path $env:SystemRoot\System32\Drivers\etc | Where-Object {$_.Name -eq 'hosts'} | Get-Content | Where-Object {$_[0] -ne 'Example'}


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
Show-Command Get-Service
Get-Help Get-Service -Examples
Get-Help About* -ShowWindow
Get-Command -Verb Get -Noun *net*
Get-Alias -Definition Get-ChildItem

Get-Process | Sort-Object -Property Status
Get-EventLog -LogName Security -Newest 30 | Sort-Object -Property TimeWritten -Descending

Get-Service | Measure-Object | Get-Member
Get-Process | Get-Member
Get-Process | Measure-Object -Property VM -Sum  #mennyi memóriát használ az adott process
Get-Process | Sort-Object -Property WM -Descending | Select-Object -First 10 #melyik 10 process használja a legtöbb memóriát

Get-EventLog -LogName Security -Newest 30 | Select-Object -Property EventID, TimeWritten  

Get-Volume | Select-Object -Property Size, SizeRemaining 
@{  n='Size';
    e= {'{0:N2}' -f($PSItem.Size/1GB)}
}

@{  n='Freespace';
    e= {'{0:N2}' -f($PSItem.SizeRemaining/1GB)}
}

Get-Content -Path $env:SystemRoot\System32\Drivers\etc\hosts | ? { $_[0] -ne "#" }

$b = Get-Partition -PartitionNumber 4
$b.Guid

Get-Command -Noun Disk

Get-Process | Where-Object {$_.ProcessName -eq 'svchost'} #----> megmutatja az összes olyan folyamatot aminek a neve egyenlő svchost-al







-----------------------------------------------------------------------------------------------------------------------------------------------------------------

Get-Command -Noun Process
Get-Command -Noun Service


Get-Service
Get-Service | Out-File C:\Users\admin\Desktop\elso.txt
notepad C:\Users\admin\Desktop\elso.txt
Remove-Item C:\Users\admin\Desktop\elso.txt 


Get-Service | Where-Object {$_.Status -eq 'Running'} | Out-File C:\Users\admin\Desktop\masodik.csv
Remove-Item C:\Users\admin\Desktop\masodik.txt
notepad C:\Users\admin\Desktop\masodik.csv

Get-Service | Where-Object {$_.Status -eq 'Running'} | Export-Csv C:\Users\admin\Desktop\service.csv
notepad C:\Users\admin\Desktop\service.csv
Remove-Item C:\Users\admin\Desktop\service.csv


Get-Service | ConvertTo-Html C:\Users\admin\Desktop\service.html
Get-Service | ConvertTo-Html | Out-File C:\Users\admin\Desktop\service.html
Remove-Item C:\Users\admin\Desktop\service.csv

Get-Service | ConvertTo-Json | Out-File C:\Users\admin\Desktop\service.json
notepad C:\Users\admin\Desktop\service.json

Get-Service -Name BITS
Get-Help Start-Service -ShowWindow

----------------------------------------------------------------------------------------------------------------------------------------------------------------

$a = "Berlin"
$b = "Vienna"

$a | foreach {Read-Host "This is $_."} 
$a | foreach {Write-Host "This is $PSItem" -ForegroundColor red -BackgroundColor Yellow}
$b | foreach {Read-Host "This is $_."}
$b | foreach {Write-Host "This is $PSItem" -ForegroundColor red -BackgroundColor Green}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

Get-PSDrive | Where-Object {$_.Free -gt 1} | ForEach-Object { Write-Host "Free Space for" $_.Root "is" ($_.Free/1gb) -ForegroundColor Red}
"{0:N0}" -f 1000
"{0:N2}" -f 1000
"{0:c2}" -f 1000
"{0:p2}" -f 1000


------------------------------------------------------------------------------------------------------------------------------------------------------------------

Test-NetConnection
Get-Help Tracert
Get-NetAdapter
$m = Get-NetAdapterAdvancedProperty 
$m | Get-Member
$m.SystemName

------------------------------------------------------------------------------------------------------------------------------------------------------------------

Get-NetAdapter | Where-Object {$PSItem.Name -eq 'Ethernet'} | Select-Object -Property Status, MacAdress



Get-NetIPAddress | Sort-Object -Property Name, Status, MacAdress | Format-Table

Get-NetAdapter | Sort-Object -Property Name, Status, MacAdress | Format-Table
$x = Get-NetIPAddress
$x | Get-Member
Get-NetIPAddress | Format-Table



Get-NetAdapter | Sort-Object -Property Name, Status, MacAdress | Format-Table
Get-NetAdapter | Where-Object Name -eq Ethernet | Sort-Object -Property Name, MacAdress
#Get-NetAdapter | Where-Object {$PSItem.Name -eq 'Ethernet'} | Select-Object -Property Status, MacAdress


Get-NetIPAddress | Format-Table
$q = Get-NetIPAddress
Get-NetIPAddress | Where-Object -Property PrefixOrigin -eq DHCP | Format-Table
Get-NetAdapter | Where-Object Name -eq Ethernet | Sort-Object -Property Name, MacAdress


$ifIndex = (Get-NetAdapter -Name "Wi-Fi 2").ifIndex
$ifIndex2 = Get-NetIPAddress | Where-Object InterfaceIndex -eq $ifIndex
$ifIndex3 = $ifIndex2 | Where-Object Addressfamily -eq "IPv4"
$ifIndex3 | Format-Table -AutoSize

$a=(get-netipaddress | where-object{($_.interfacealias -eq "Wi-Fi") -and ($_.addressfamily -eq "IPv4")}).interfaceindex
(get-netipaddress | where-object{($_.interfaceindex -eq $a) -and ($_.addressfamily -eq "IPv4")}).ipaddress

Get-NetAdapterStatistics -InterfaceAlias Ethernet




$q = Get-NetIPAddress
$q | Where-Object -Property PrefixOrigin -eq DHCP | Format-Table
Get-NetAdapter | Where-Object Name -eq Ethernet | Sort-Object -Property Name, MacAdress


---------------------------------------------------------------------------------------------------------------------------------------------------------

$x = [int] (Read-Host "Add meg,hogy hány sor magas legyen a háromszög") 
for($i=1; $i -le $x; $i++){ 
   
   for($k=1; $k -le $x -$i; $k++ ){
      Write-Host -NoNewLine " "
   }

   for($j=1; $j -le 2 * $i - 1; $j++){ 
     Write-Host -NoNewLine "*" 
   }

   Write-Host " "
}

------------------------------------------------------------------------------------------------------------------------------------------------------------
Custom Property létrehozása  @{n='neve' ;e={$PSItem.}} /nevet adok neki, psitem itt a computerinfoból érkező adatok közül a csdnhost, ami a gépnevet jelenti 


Get-ComputerInfo | Select-Object @{n='ComputerName' ;e={$PSItem.CsDNSHostName}}

------------------------------------------------------------------------------------------------------------------------------------------------------------
For ciklus és számok

# Kiürítem a képernyőt
Clear-Host;
# Kell egy random szám 1-10 = $number
$number = Get-Random -Maximum 11;
# kiírom a választott számot
Write-Host "A(z) $number a véletlenszerűen választott szám.`n";

# for $i 1-től 10-ig
For ($i=1; $i -le 10; $i++) {
#   szorzás elvégzése
    $result = $i * $number;
#   kiírni az adott sort
    Write-Host "$i * $number = $result";
# endfor
}

------------------------------------------------------------------------------------------------------------------------------------------------------------

Clear-Host
$num = [int] (Read-Host "Kérek egy számot")
$i=1
do
{
$res=$num*$i
echo "$num * $i = $res"
$i=$i+1
}while($i -le 10)

------------------------------------------------------------------------------------------------------------------------------------------------------------
Számok szorzás és kiiratás

$num = 5
1..10 | ForEach-Object {Write-Host $_ * $num = ($_ * $num)}


-------------------------------------------------------------------------------------------------------------------------------------------------------------
Kártyás játék

$ujra = $null

$pakli = "A♤", "A❤", "A♧", "A♢", "2♤", "2❤", "2♧", "2♢", "3♤", "3❤", "3♧", "3♢", "4♤", "4❤", "4♧", "4♢",
"5♤", "5❤", "5♧", "5♢", "6♤", "6❤", "6♧", "6♢", "7♤", "7❤", "7♧", "7♢", "8♤", "8❤", "8♧", "8♢",
"9♤", "9❤", "9♧", "9♢", "10♤", "10❤", "10♧", "10♢", "J♤", "J❤", "J♧", "J♢", "Q♤", "Q❤", "Q♧",
"Q♢", "K♤", "K❤", "K♧", "K♢"

$kislapok = "2", "3", "4", "5", "6", "7", "8", "9"

$nagylapok = "J", "Q", "K", "1"

$valassz = "l", "m"

while ($ujra -ne "n") {
    $lap = get-random -InputObject $pakli -Count 20
    $oszto = $lap[1]
    $te = $lap[0] + " " + $lap[2]
    $ujra = $null
    $cardvalue = @{}
    0..19 | ForEach-Object { if ($lap[$_][0] -in $kislapok) { (($cardvalue[$_] = $lap[$_][0]) / 1) }
        elseif ($lap[$_][0] -in $nagylapok) { $cardvalue[$_] = 10 }
        elseif ($lap[$_][0] -eq "A") { $cardvalue[$_] = 11 } }

    $tetotal = (([string]$cardvalue[0] / 1) + ([string]$cardvalue[2] / 1))
    Clear-Host
    write-host "Osztó lapjai: " $oszto "`r`n"
    write-host "Te lapjaid: " $te "        értéke: " $tetotal "`r`n"
    $move = $null
    $n = 4
    while ($tetotal -lt 22 -and $move -ne 'm') {
        $move = $null
        while ($move -notin $valassz) {
            $move = Read-Host -Prompt "Válassz!  'l' = lapot kérek, 'm' = megállok "
            if ($move -eq 'l') {
                Clear-Host; 
                $te = $te + " " + $lap[$n]
                $tetotal = ($tetotal) + ([string]$cardvalue[$n] / 1)
                $n++
                Clear-Host
                write-host "Osztó lapjai: " $oszto "`r`n"
                write-host "Te lapjaid: " $te "        értéke: " $tetotal "`r`n"
            }
            elseif ($move -eq 'm') {
                $oszto = $lap[1] + " " + $lap[3] 
                $osztototal = (([string]$cardvalue[1] / 1) + ([string]$cardvalue[3] / 1))
                while ($osztototal -lt 17) {
                    $oszto = $oszto + " " + $lap[$n]
                    $osztototal = ($osztototal) + ([string]$cardvalue[$n] / 1)
                    $n++
                    Clear-Host
                    write-host "Osztó lapjai: " $oszto "`r`n"
                    write-host "Te lapjaid: " $te "        értéke: " $tetotal "`r`n"
                    write-host "Válassz!  'l' = lapot kérek,    'm' = megállok"
                }
                Clear-Host
                if ($tetotal -gt $osztototal -or $osztototal -gt 21) {
                    Clear-Host
                    write-host "Osztó lapjai: " $oszto "        értéke: " $osztototal "`r`n"
                    write-host "Te lapjaid: " $te "        értéke: " $tetotal "`r`n"
                    write-host "Győztél!!!" "`r`n"
                }
                if ($tetotal -eq $osztototal -and $osztototal -le 21) {
                    Clear-Host
                    write-host "Osztó lapjai: " $oszto "        értéke: " $osztototal "`r`n"
                    write-host "Te lapjaid: " $te "        értéke: " $tetotal "`r`n"
                    write-host "Döntetlen" "`r`n"
                }
                if ($tetotal -lt $osztototal -and $osztototal -le 21) {
                    Clear-Host
                    write-host "Osztó lapjai: " $oszto "        értéke: " $osztototal "`r`n"
                    write-host "Te lapjaid: " $te "        értéke: " $tetotal "`r`n"
                    write-host "Talán legközelebb több szerencséd lesz !" "`r`n"
                }
            }
            else { write-host "Hibás parancs" }
        }
    }

    if ($tetotal -gt 21) {
        Clear-Host; 
        write-host "Osztó lapjai: " $oszto "        értéke: " $osztototal "`r`n"
        write-host "Te lapjaid: " $te "        értéke: " $tetotal "`r`n"
        write-host "Talán legközelebb több szerencséd lesz" "`r`n"
    }

    while ($ujra -ne "i" -and $ujra -ne "n") {
        $ujra = Read-Host -Prompt "Játszol még egyet?  i/n" 
    }
}

------------------------------------------------------------------------------------------------------------------------------------------
Kő-papír

$p1points = 0;
$p2points = 0;
Clear-Host;
while ($true) {
    
    $choice = @('&Rock','&Paper','&Scissors','&Lizard','&Spock');
    $decision = $Host.UI.PromptForChoice('Your decision','Select a weapon:',$choice,0);
    switch ($decision) {
        0 {$p1 = 'rock'; break;}
        1 {$p1 = 'paper'; break;}
        2 {$p1 = 'scissors'; break;}
        3 {$p1 = 'lizard'; break;}
        4 {$p1 = 'spock'; break;}
    }


    #$p1 = Get-Random -InputObject @('rock','paper','scissors','lizard','spock');
    $p2 = Get-Random -InputObject @('rock','paper','scissors','lizard','spock');
    Clear-Host;
    Write-Host 'Player: '$p1.ToUpper();
    Write-Host 'Machine: '$p2.ToUpper()`n`r;


    if ($p1 -eq $p2) {
        Write-Host 'Draw!'`n`r;
    }
    elseif (
        ($p1 -eq 'rock' -and (($p2 -eq 'scissors') -or ($p2 -eq 'lizard')) ) -or
        ($p1 -eq 'scissors' -and (($p2 -eq 'paper') -or ($p2 -eq 'lizard')) ) -or
        ($p1 -eq 'paper' -and (($p2 -eq 'rock') -or ($p2 -eq 'spock')) ) -or
        ($p1 -eq 'lizard' -and (($p2 -eq 'paper') -or ($p2 -eq 'spock')) ) -or
        ($p1 -eq 'spock' -and (($p2 -eq 'scissors') -or ($p2 -eq 'rock')) )
        ) {
        Write-Host 'Player won!'`n`r;
        $p1points ++;

    } 
    else {
        Write-Host 'Machine won!'`n`r;
        $p2points ++;
    }
        Write-Host 'Player points: '$p1points;
        Write-Host 'Machine points: '$p2points;
}

-----------------------------------------------------------------------------------------------------------------------------------------
Szó vizsgálat


$szo = Read-Host -Prompt "ird ide a vizsgálando szót: "
$charszo = $szo.ToCharArray()
[array]::Reverse($charszo)
$ujszo = -Join($charszo)
if ($szo -eq $ujszo) {Write-Host "ez palindrom"}
else {Write-Host "ez nem"}

-----------------------------------------------------------------------------------------------------------------------------------------
String keresése a szövegben vagy megadott fájlban

$SEL = Select-String -Path C:\Windows\System32\drivers\etc\hosts -Pattern "for example"

if ($SEL -ne $null)
{
    echo Contains String
}
else
{
    echo Not Contains String
}

------------------------------------------------------------------------------------------------------------------------------------------
palindrom szám vizsgálat

Clear-Host
[int]$number = Read-Host 'Írd be a három jegyű számot';

$lastdigit = $number % 10;

$firstdigit = [math]::floor($number / 100);

if ($firstdigit -eq $lastdigit) {
    Write-Host 'palindrom!';
}
else { 
    Write-Host 'nem az';
}

------------------------------------------------------------------------------------------------------------------------------------------
Hostfájlban olyan sorok keresése, ahol nem # -el kezdődik a sor

$hostfile = Get-Content -Path c:\windows\system32\drivers\etc\hosts
ForEach ($sor in $hostfile) {
    ($sor.Substring(0,1) -ne "#")
    if (($sor.Length -ne 0) -and ($sor.Substring(0,1) -ne "") ){ Write-Host $sor}
}

-----------------------------------------------------------------------------------------------------------------------------------------

Get-Date -DisplayHint Date
$DateStr = Get-Date -format "MMdd"
$birthdays = '0201', '0913', '0216', '0723', '0815', '0611', '0115', '0813', '1205', '0706', '0825', '0803', '1007', '0706', '0605', '1201', '1029', '0111', '0717', '0607', '0104', '1214', '1104', '0808'
if ($birthdays -contains $DateStr) { Write-Host "Ma valamelyikünknek a csoportból születésnapja van. Gratulálunk! Igyunk egyet az egészségére!"}
else {Write-Host "Ma nincs senkinek születésnapja a csoportból. Talán egy másik nap ünnepelhettek."}