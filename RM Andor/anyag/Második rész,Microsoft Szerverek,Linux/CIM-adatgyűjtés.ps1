Get-CimInstance -ClassName Win32_Desktop

Get-CimInstance -ClassName Win32_Desktop | Select-Object -ExcludeProperty "CIM*"

Get-CimInstance -ClassName Win32_BIOS

Get-CimInstance -ClassName Win32_Processor | Select-Object -ExcludeProperty "CIM*"

Get-CimInstance -ClassName Win32_ComputerSystem

Get-CimInstance -ClassName Win32_OperatingSystem |
  Select-Object -Property BuildNumber,BuildType,OSType,ServicePackMajorVersion,ServicePackMinorVersion



https://docs.microsoft.com/hu-hu/powershell/scripting/samples/collecting-information-about-computers?view=powershell-5.1