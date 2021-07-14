

$InputFile = "C:\Users\nimrod.s\Desktop\scripts\1.txt"
$Computers = Get-Content -Path $InputFile
$patches = 'KB5003203',
  'KB5003209',
  'KB5003208',
  'KB5003210',
  'KB5003220',
  'KB5003233',
  'KB5003197',
  'KB5003171',
  'KB5003172',
  'KB5003173',
  'KB5003174',
  'KB5003169'


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
        if(!(Get-Hotfix -ComputerName $Computer -Id $patches)){ Add-Content $computer -Path "C:\Users\nimrod.s\Desktop\scripts\WU.txt"} 
       
       
}
catch {
  $status = "FAILED"
  Write-Verbose "`tFailed to check windows updates. Error: $_"
}
 
$obj = New-Object -TypeName PSObject -Property @{
  ComputerName = $Computer
  IsOnline = $Isonline
  #version = $Version
}


#$obj | Select ComputerName, IsOnline, version | Export-Csv "C:\Users\nimrod.s\Desktop\scripts\versions.csv" -NoTypeInformation -Append
 
#if($Status -eq "FAILED" -or $Isonline -eq "OFFLINE") {
#   $stream.writeline("$Computer `t $isonline `t $status")
#}
 
}