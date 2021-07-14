$password = Read-Host "Enter the password" -AsSecureString
$confirmpassword = Read-Host "Confirm the password" -AsSecureString

$pwd1_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

$pwd2_text = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($confirmpassword))


if($pwd1_text -ne $pwd2_text) {
   Write-Error "Entered passwords are not same. Script is exiting"
exit
}

$InputFile = "C:\Users\gershon.m\Desktop\script\LOCAL_ADMIN\1.txt"
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
   $account = [ADSI]("WinNT://$Computer/Administrator,user")
   $account.psbase.invoke("setpassword",$pwd1_text)
   Write-Verbose "`tPassword Change completed successfully"
}
catch {
  $status = "FAILED"
  Write-Verbose "`tFailed to Change the administrator password. Error: $_"
}
 
$obj = New-Object -TypeName PSObject -Property @{
  ComputerName = $Computer
  IsOnline = $Isonline
  PasswordChangeStatus = $Status
}
 
$obj | Select ComputerName, IsOnline, PasswordChangeStatus
 
if($Status -eq "FAILED" -or $Isonline -eq "OFFLINE") {
   $stream.writeline("$Computer `t $isonline `t $status")
}
 
}