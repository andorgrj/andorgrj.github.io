Kulcs és érték párok alapján tárolódik


$hash = @{ Number = 1; Shape = "Square"; Color = "Blue"}            -------> hash létrehozása

$hash = [ordered]@{ Number = 1; Shape = "Square"; Color = "Blue"}   -------> rendezett hash

$hash.keys
$hash.values
$hash.count

$hash.Add("Time", "Now")  ---------> érték hozzáadása

$t = "Today"    -----------> változként is lehet hozzáadni
$now = (Get-Date)
$hash.Add($t, $now)

$hash.Remove("Time")   -------> érték eltávolítása


-------------------------------------------------------------------------------------------------------------------------------------
Gyakorló feladat: az aktuális könyvtár útvonalát darabold fel a könyvtárakra és számold meg hányadik szinten van a könyvtár. A \ az 1.
- tipp: megpróbálhatod string fügvényekkel vagy a szülő könyvtár property használatával (Get-Item .).parent
- ha ez sikerült próbáld meg az eredményt hash táblában tárolni és táblázatban kiíratni fájlba/konzolra. 
- próbáld az eredméynt html, csv, json, xml formátumba elárolni (Get-Command -verb ConvertTo)


$currentDir = Get-Location
$currentDir = $currentDir.ToString()
$dirArray = $currentDir -split ""
$hash = @{}

for ($i = ($dirArray.Count - 1); $i -ge 0; $i--){
    $hash.add(($i+1).ToString(), $dirArray[$i])
}

$hash.GetEnumerator() | Sort-Object -Property key -Descending | Format-list 

$hash | ConvertTo-Json

--------------------------------------------------------------------------------------------------------------------------------------

$CurrentPath = Get-Location;
$Matches = Select-String -InputObject $CurrentPath -Pattern '\' -AllMatches
if ($CurrentPath.ToString().Length -eq 3) {
    Write-Host 'Szint: 1';
} else {
    Write-Host 'Szint:' ($Matches.Matches.Count+1);
}

--------------------------------------------------------------------------------------------------------------------------------------