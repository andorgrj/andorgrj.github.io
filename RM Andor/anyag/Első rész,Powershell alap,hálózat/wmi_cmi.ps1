Get-Command -name "*wmi*"
Get-Command -name "*cim*"
Get-CimClass -ClassName "*Network*"

$osztaly = Get-CimClass win32_process
$osztaly.CimClassMethods
$osztaly.CimClassMethods["Create"].Parameters
$osztaly | Invoke-CimMethod -MethodName Create -Arguments @{commandline='notepad.exe'}


Get-CimInstance -ClassName "CIM_NetworkAdapter" | Get-Member

Get-WmiObject -List

Get-WmiObject -class Win32_NetworkAdapter| Get-Member

Get-WmiObject -Class Win32_Bios | Get-Member

Get-WmiObject -Class "win32_computersystem" | Select-Object model
Get-WmiObject -Class "win32_computersystem" | Get-Member

Get-WmiObject -Class "win32_operatingsystem" | Get-Member

Get-WmiObject win32_operatingsystem -Property lastbootuptime

$datumotcserelek = Get-WmiObject win32_operatingsystem 
$most = (Get-Date).AddDays(-1)

$datumotcserelek.SetDateTime( $most )



$computer = "LocalHost" 
$namespace = "root\WMI" 
Get-WmiObject -class BatteryStatus -computername $computer -namespace $namespace


$computer = "LocalHost" 
$namespace = "root\CIMV2" 
Get-WmiObject -class Win32_Processor -computername $computer -namespace $namespace

$property = “systemname”,”maxclockspeed”,”addressWidth”,“numberOfCores”, “NumberOfLogicalProcessors”
Get-WmiObject -class win32_processor -Property  $property | Select-Object -Property $property

Get-WmiObject Win32_Processor | Measure-Object -Property LoadPercentage -Average | Select Average

Get-WmiObject Win32_Processor | Select LoadPercentage | Format-List


$computer = "LocalHost" 
$namespace = "root\CIMV2" 
Get-WmiObject -class Win32_Process | get-member 


$Disk = Get-WmiObject -Class Win32_logicaldisk | select *
Get-WmiObject -Class Win32_DiskPartition
Get-WmiObject -Class Win32_Fan

Get-WmiObject -Class Win32_PhysicalMemory


$Disk.GetRelationships() | Select-Object -Property __RELPATH

Get-CimInstance -Class CIM_LogicalDisk | Select-Object @{Name="Size(GB)";Expression={$_.size/1gb}}, @{Name="Free Space(GB)";Expression={$_.freespace/1gb}}, @{Name="Free (%)";Expression={"{0,6:P0}" -f(($_.freespace/1gb) / ($_.size/1gb))}}, DeviceID, DriveType 


$aa = Get-CimInstance -ClassName Win32_Process

Invoke-CimMethod -ClassName Win32_Process -MethodName "Create" -Arguments @{
  CommandLine = 'notepad.exe'; CurrentDirectory = "C:\windows\system32"}

$aa | Get-Member

Get-CimInstance -Namespace root/wmi -ClassName MsAcpi_ThermalZoneTemperature -Filter "Active='True' and CurrentTemperature<>2732" -Property InstanceName, CurrentTemperature |
    Select-Object InstanceName, @{n='CurrentTemperatureC';e={'{0:n0} C' -f (($_.CurrentTemperature - 2732) / 10.0)}}


$wmi = Get-WmiObject win32_networkadapterconfiguration -filter "ipenabled = 'true'"
$wmi.SetDNSServerSearchOrder("8.8.8.8")

$wmi.DNSServerSearchOrder


Get-Counter -ListSet * | Select-Object -ExpandProperty CounterSetName 
Get-Counter -ListSet *Hyper-V* | Select-Object CounterSetName, CounterSetType, Description, Paths | Out-GridView -Title "Hyper-V counters" 

$TotalCounter = Get-Counter -ListSet *
$TotalCounter | Measure-Object | select Count

(Get-Counter '\Hyper-V Dynamic Memory VM(*)\Average Pressure').CounterSamples[0].CookedValue 

$HyperVInformations = (get-counter -ListSet "Hyper-V hipervizor").paths
Get-Counter -Counter $HyperVInformations

Get-counter -ListSet *memória*

Get-counter -ListSet "Memória"