﻿

$InputFile = "C:\Users\nimrod.s\Desktop\scripts\1.txt"
$Computers = Get-Content -Path $InputFile


if(!(Test-Path $InputFile)) {
Write-Error "File ($InputFile) not found. Script is exiting"
exit
}

foreach ($Computer in $Computers) {
   $Computer    =    $Computer.toupper()
   $Isonline    =    "OFFLINE"
   $Status        =    "SUCCESS"
    Write-Verbose "Working on $Computer"
if((Test-Connection -ComputerName $Computer -count 1 -ErrorAction 0)) {
   $Isonline = "ONLINE"
   Write-Verbose "`t$Computer is Online"
} else { Write-Verbose "`t$Computer is OFFLINE" }



 
try {
        $Version = (Get-ChildItem -Path "\\$computer\c$\Program Files (x86)\Google\Chrome\Application" | where {$_.name -match "\d\d.*"}).Name
        "$computer - $Version"
       
}
catch {
  $status = "FAILED"
  Write-Verbose "`tFailed to check chrome version. Error: $_"
}
 
$obj = New-Object -TypeName PSObject -Property @{
  ComputerName = $Computer
  IsOnline = $Isonline
  version = $Version
}


$obj | Select ComputerName, IsOnline, version | Export-Csv "C:\Users\nimrod.s\Desktop\scripts\versions.csv" -NoTypeInformation -Append
 
if($Status -eq "FAILED" -or $Isonline -eq "OFFLINE") {
   $stream.writeline("$Computer `t $isonline `t $status")
}
 
}