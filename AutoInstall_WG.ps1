#Zkontroluje, zda skript b�� s opr�vn�n�m spr�vce, jinak ho snovu spust� se sv��en�m opr�vn�n�m

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
#    Write-Host "Skript nebyl spu�t�n jako Spr�vce. Spou�t�m znovu."
#    timeout 3
    $scriptPath = $MyInvocation.MyCommand.Definition
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
    Exit
}

# Zkontroluje, jestli je Winget nainstalov�n (Nutn� pouze pro Windows 10)
winget -v
if ($?) {
    Write-Host "WinGet je nainstalov�n, zahajuji instalaci bal��k�"
}
else {
    Write-Host "Spr�vce bal��k� WinGet chyb�! Pros�m nainstalujte jej z Microsoft Store, pot� n�stroj znovu spus�te"
    Timeout 7
    Start-Process "https://www.microsoft.com/store/productId/9NBLGGH4NNS1"
    Exit
}

winget install OBSProject.OBSStudio VideoLAN.VLC PeterPawlowski.foobar2000 Google.Chrome RustDesk.RustDesk --accept-source-agreements --accept-package-agreements

#Otev�e prohl�e� se str�nkou sta�en� Photobone Studio
Start-Process "https://photobone.com/cs/studio/koupit"