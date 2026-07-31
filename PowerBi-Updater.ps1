# Self-elevation to administrator
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Configuración inicial del entorno
Set-Location -Path $PSScriptRoot
$ErrorActionPreference = "Continue"

# Funciones auxiliares
function Ask-YesNo {
    param([string]$Prompt)
    while ($true) {
        $response = Read-Host "$Prompt (s/n)"
        if ($response -eq 's' -or $response -eq 'S') { return $true }
        if ($response -eq 'n' -or $response -eq 'N') { return $false }
    }
}

function Pause-Script {
    param([string]$Message = "Presiona ENTER para continuar...")
    Write-Host ""
    Read-Host -Prompt $Message
}


# Create the routes
md C:\DISCOS
md C:\DISCOS\Power Bi
Remove-Item -Path "C:\DISCOS\Power Bi\PBIDesktopSetup_x64.exe" -Force
clear
# Download the installer
Write-Host ""
Write-Host ""
Write-Host "Descargando instalador, espera a que termine."
Write-Host ""
Write-Host "Puede tardar unos minutos..."
Write-Host ""
Write-Host " ************************************ "
Write-Host " **** ¡NO CIERRES ESTA VENTANA! ***** "
Write-Host " ************************************ "
Write-Host ""
wget "https://download.microsoft.com/download/8/8/0/880bca75-79dd-466a-927d-1abf1f5454b0/PBIDesktopSetup_x64.exe" -OutFile "C:\DISCOS\Power Bi\PBIDesktopSetup_x64.exe"

clear

# Write the message on the screen.
Write-Host ""
Write-Host "Sigue los pasos de la instalación..."
Write-Host ""

# Run the installation.
Start-Process "C:\DISCOS\Power Bi\PBIDesktopSetup_x64.exe" -Wait

# Delete the installer.
# Otherwise, it won't download it when it needs to update again.
Remove-Item -Path "C:\DISCOS\Power Bi\PBIDesktopSetup_x64.exe" -Force

clear

Write-Host "¡Finalizado!"
Write-Host ""
Write-Host ""
Write-Host "Creado por @putodruida"
Pause-Script
exit
