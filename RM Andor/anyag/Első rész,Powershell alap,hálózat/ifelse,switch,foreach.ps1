ifelse


$freeSpace = 18GB

if ($freeSpace -le 2GB)
{
    Write-Host "Kevesebb, mint 2 GB hely van"
}
elseif ($freeSpace -le 5GB)
{
    Write-Host "Kevesebb, mint 5 GB hely van"
}
elseif ($freeSpace -le 10GB)
{
    Write-Host "Kevesebb, mint 10 GB hely van"
}
else
{
    Write-Host "Elég szabad hely van"
}

---------------------------------------------------------------------------------------------------------------------------------------------------
Switch

$car = "Ferrari"

$carType = "ismeretlen"

switch ($car)
{
    "Ferrari"
    {
        $carType = "Super Sport"
    }
    "Toyota"
    {
        $carType = "Hybrid car"
    }
    default
    {
        $carType = "Nem ismert típus"
    }
}

$output = "Márka: {0} - Típus; {1}" -f $car,$carType

Write-Host $output

---------------------------------------------------------------------------------------------------------------------------------------------
Foreach


$services = Get-Service

Write-Host "Szervizek száma: $($services.Count)"

$count = 0

foreach ($service in $services)
{
    $count = $count+1
    Write-Host "$count : Aktuális szerviz: $($service.Name)"
}

