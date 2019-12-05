***********************************************************************
fix_for_ITAM
21/11/19
Created BY NIMROD SO IN YOUR FACE POWER RANGERS
************************************************************
while ((Read-Host -Prompt "get serial?") -eq "y"){
$Compname = Read-Host -Prompt 'what is the computer name?'
$Serial = Get-WmiObject Win32_SystemEnclosure -Computer $Compname | select serialnumber
Write-Host "the serial number is: '$Serial' have a nice day"
}

pause
