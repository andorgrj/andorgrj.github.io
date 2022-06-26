Get-EventLog -LogName Application | Where-Object Source -Match defrag

Get-WinEvent -LogName Application | Where-Object { $_.ProviderName -Match 'defrag' }

Get-WinEvent -FilterHashtable @{
   LogName='Application'
   ProviderName='*defrag'
}


Get-WinEvent -FilterHashtable @{Logname='System';ID=7001,7002,3261,4624}| Select-Object ID,@{l='Category';e={Switch($_.ID){
    "7001" {"Logon"}
    "7002" {"Logoff"}
    "3261" {"JoinToWorkgroup"}
    "4624" {"*"}
    }
}},@{label='Time Created';expression={$_.TimeCreated.ToString("yyyy-M-d HH:mm:ss")}},Message | ft -autosize



Get-CimInstance -Namespace root/wmi -ClassName MsAcpi_ThermalZoneTemperature -Filter "Active='True' and CurrentTemperature<>2732" -Property InstanceName, CurrentTemperature |
    Select-Object InstanceName, @{n='CurrentTemperatureC';e={'{0:n0} C' -f (($_.CurrentTemperature - 2732) / 10.0)}}


Get-WinEvent -FilterHashtable @{LogName='Application'; 'Service'='Bits'}

Get-WinEvent -FilterHashtable @{
   LogName='Application'
}

Get-WinEvent -FilterHashtable @{
   LogName='Application'
   ProviderName='.NET Runtime'
}

[System.Diagnostics.Eventing.Reader.StandardEventLevel] | Get-Member -Static -MemberType Property


https://www.loggly.com/ultimate-guide/windows-logging-basics/

https://docs.microsoft.com/hu-hu/powershell/scripting/samples/creating-get-winevent-queries-with-filterhashtable?view=powershell-5.1

https://hu.univdesigntechnologies.com/how-work-with-custom-views-event-viewer

https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.diagnostics/get-winevent?view=powershell-5.1
