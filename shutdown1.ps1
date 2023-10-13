$machines = Get-Content -Path "C:\list\ip.txt" 
$credential = Get-Credential
foreach ($machine in $machines)
{     
Write-Host "Shutting down $machine..."     
restart-Computer -ComputerName $machine -Force -Credential $credential
}