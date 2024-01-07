#Zkontroluje, zda skript bìí s oprávnìním správce, jinak ho snovu spustí se svıšenım oprávnìním

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
#    Write-Host "Skript nebyl spuštìn jako Správce. Spouštím znovu."
#    timeout 3
    $scriptPath = $MyInvocation.MyCommand.Definition
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
    Exit
}

# Zkontroluje, jestli je Winget nainstalován (Nutné pouze pro Windows 10)
winget -v
if ($?) {
    Write-Host "WinGet je nainstalován, zahajuji instalaci balíèkù"
}
else {
    Write-Host "Správce balíèkù WinGet chybí! Prosím nainstalujte jej z Microsoft Store, poté nástroj znovu spuste"
    Timeout 7
    Start-Process "https://www.microsoft.com/store/productId/9NBLGGH4NNS1"
    Exit
}

winget install OBSProject.OBSStudio VideoLAN.VLC PeterPawlowski.foobar2000 Google.Chrome RustDesk.RustDesk --accept-source-agreements --accept-package-agreements

#Otevøe prohlíeè se stránkou staení Photobone Studio
Start-Process "https://photobone.com/cs/studio/koupit"