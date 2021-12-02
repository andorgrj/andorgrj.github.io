https://medium.com/@RealNetwork/windows-server-2019-product-family-editions-options-and-versions-explained-plus-comparison-6396f04e38d
https://e-learning.training360.com/courses/take/windows-serer-2019-hyper-v/lessons/18055889-bevezeto
https://www.altaro.com/hyper-v/23-best-practices-improve-hyper-v-vm-performance/
https://docs.microsoft.com/en-us/virtualization/
https://www.altaro.com/hyper-v/hyper-v-virtual-cpus-explained/
https://www.altaro.com/hyper-v/the-hyper-v-virtual-switch-explained-part-1/

--------------------------------------------------------------------------------------------------------------------------------------------------------
Hyper V alapok

# Hálózati kapcsoló (switch)
Get-VMSwitch | Select-Object *
New-VMSwitch -Name ExternalSwitch -NetAdapterName Ethernet -AllowManagementOS $true

# Virtuális gépek (VMs)
$vmname = 'vmAD'
Get-VM $vmname | Select-Object -ExpandProperty HardDrives
Get-VMIdeController -VMName $vmname # Gen1
Get-VMScsiController -VMName $vmname # Gen2
Get-VM $vmname | Select-Object -ExpandProperty NetworkAdapters | Select-Object IPAddresses

# Új virtuális lemez és csatolása Gen1 VM-hez (Gen2 SCSI nem ide)
New-VHD -Path 'C:\LocalVMs\Virtual Hard Disks\newvdisk.vhdx' -SizeBytes 50gb -Dynamic | Add-VMHardDiskDrive -VMName svtest -ControllerType IDE -ControllerNumber 1 -ControllerLocation 1



--------------------------------------------------------------------------------------------------------------------------------------------------------
New VM from hash

<#
#Get-VMSwitch | Select-Object Name, SwitchType
#Get-Vm

$switchnev = 'VNetInternal'
$vmnev = 'vmDC1'
$aa = "valami $vmnev"

$workvm = Get-VM -Name $vmnev
(($workvm).NetworkAdapters).Ipaddresses

Get-VMSwitch | Select-Object Name, SwitchType
$workvmswitch = Get-VMSwitch $switchnev
#>


$ujvm = 'cORESZERVERScriptbolszulettem'
$MemoryStartup=1GB
$VHDSize=20GB 
$ProcCount=1
$MemoryMinimum=512MB 
$MemoryMaximum=2GB
$DynamicMemory=$true

$ISO = "C:\Users\hidve\Documents\Progmasters\Images\WS2019USEval.iso"
$Switch = 'VNetInternal' 
$Path="C:\Users\hidve\Documents\Progmasters\VM"
$VHDPath= Join-Path "C:\Users\hidve\Documents\Progmasters\VM" "$($ujvm)_C.vhdx"

$ujvmhash = @{ 
 Name=$ujvm 
 SwitchName=$Switch 
 MemoryStartupBytes=$MemoryStartup
 Path=$Path 
 NewVHDPath=$VHDPath 
 NewVHDSizeBytes=$VHDSize  
 ErrorAction="Stop"
}

#Write-Host "Creating new virtual machine" 
#Write-Host ($ujvmhash | out-string)

#Write-Verbose "Creating new virtual machine" 
#Write-Verbose ($ujvmhash | out-string)

$VM = New-VM @ujvmhash

# dvd csatolása az új VM-hez
#Set-VMDvdDrive -vmname $ujvm -Path $iso -ErrorAction Stop
-----------------------------------------------------------------------------------------------------------------------------------------------
VM from template


#requires -version 3.0 
 
<# 
.Synopsis 
Provision a new Hyper-V virtual machine based on a template 
.Description 
This script will create a new Hyper-V virtual machine based on a template or 
hardware profile. You can create a Small, Medium or Large virtual machine. All 
virtual machines will use the same virtual switch and the same paths for the  
virtual machine and VHDX file.  All virtual machines will be created with dynamic 
VHDX files and dynamic memory. All virtual machines will mount the same Windows 
Server 2012 ISO file so that you can start the virtual machine and load an 
operating system. 
 
VM Types 
Small (default) 
        MemoryStartup=512MB 
        VHDSize=10GB 
        ProcCount=1 
        MemoryMinimum=512MB 
        MemoryMaximum=1GB 
 
Medium 
        MemoryStartup=512MB 
        VHDSize=20GB 
        ProcCount=2 
        MemoryMinimum=512MB 
        MemoryMaximum=2GB 
 
Large 
        MemoryStartup=1GB 
        VHDSize=40GB 
        ProcCount=4 
        MemoryMinimum=512MB 
        MemoryMaximum=4GB 
 
This script requires the Hyper-V 3.0 PowerShell module. 
.Example 
PS C:\Scripts\> .\New-VMFromTemplate WEB2012-01 -VMType Small -passthru 
 
Name       State CPUUsage(%) MemoryAssigned(M) Uptime   Status 
----       ----- ----------- ----------------- ------   ------ 
WEB2012-01 Off   0           0                 00:00:00 Operating normally 
.Link 
New-VM 
Set-VM 
#> 
[cmdletbinding(SupportsShouldProcess)] 
 
Param( 
[Parameter(Position=0,Mandatory,HelpMessage="Enter the name of your new virtual machine")] 
[ValidateNotNullOrEmpty()] 
[string]$Name, 
[ValidateSet("Small","Medium","Large", "AD")] 
[string]$VMType="Small", 
[switch]$Passthru 
) 
 
Write-Verbose "Creating new $VMType virtual machine" 
#universal settings regardless of type 
 
#the ISO for installing Windows 2012 
$ISO = "G:\iso\9200.16384.WIN8_RTM.120725-1247_X64FRE_SERVER_EVAL_EN-US-HRM_SSS_X64FREE_EN-US_DV5.ISO" 
#all VMs will be on the same network switch 
$Switch = "Work Network" 
#path for the virtual machine. All machines will use the same path. 
$Path="C:\VMs" 
#path for the new VHDX file. All machines will use the same path. 
$VHDPath= Join-Path "F:\VHD" "$($name)_C.vhdx" 
 
#define parameter values based on VM Type 
Switch ($VMType) { 
    "Small" { 
        $MemoryStartup=512MB 
        $VHDSize=10GB 
        $ProcCount=1 
        $MemoryMinimum=512MB 
        $MemoryMaximum=1GB 
    } 
    "Medium" { 
        $MemoryStartup=512MB 
        $VHDSize=20GB 
        $ProcCount=2 
        $MemoryMinimum=512MB 
        $MemoryMaximum=2GB 
    } 
    "Large" { 
        $MemoryStartup=1GB 
        $VHDSize=40GB 
        $ProcCount=4 
        $MemoryMinimum=512MB 
        $MemoryMaximum=4GB 
    } 
    "AD" { 
        $MemoryStartup=2GB 
        $VHDSize=40GB 
        $ProcCount=1
        $MemoryMinimum=1024MB 
        $MemoryMaximum=4GB 
    }
} #end switch 
 
#define a hash table of parameters for New-VM 
$newParam = @{ 
 Name=$Name 
 SwitchName=$Switch 
 MemoryStartupBytes=$MemoryStartup 
 Path=$Path 
 NewVHDPath=$VHDPath 
 NewVHDSizeBytes=$VHDSize 
 ErrorAction="Stop" 
} 
 
#define a hash table of parameters for Set-VM 
$setParam = @{ 
 ProcessorCount=$ProcCount 
 DynamicMemory=$True 
 MemoryMinimumBytes=$MemoryMinimum 
 MemoryMaximumBytes=$MemoryMaximum 
 ErrorAction="Stop" 
} 
 
if ($Passthru) { 
    $setParam.Add("Passthru",$True) 
} 
Try { 
    Write-Verbose "Creating new virtual machine" 
    Write-Verbose ($newParam | out-string) 
    $VM = New-VM @newparam 
} 
Catch { 
    Write-Warning "Failed to create virtual machine $Name" 
    Write-Warning $_.Exception.Message 
    #bail out 
    Return 
} 
 
if ($VM) { 
    #mount the ISO file 
    Try { 
        Write-Verbose "Mounting DVD $iso" 
        Set-VMDvdDrive -vmname  $vm.name -Path $iso -ErrorAction Stop 
    } 
    Catch { 
        Write-Warning "Failed to mount ISO for $Name" 
        Write-Warning $_.Exception.Message 
        #don't bail out but continue to try and configure virtual machine 
    } 
    Try { 
        Write-Verbose "Configuring new virtual machine" 
        Write-Verbose ($setParam | out-string) 
        $VM | Set-VM @setparam 
    } 
    Catch { 
    Write-Warning "Failed to configure virtual machine $Name" 
    Write-Warning $_.Exception.Message 
    #bail out 
    Return 
    } 
 
} #if $VM
------------------------------------------------------------------------------------------------------------------------------------------------