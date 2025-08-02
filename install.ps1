# ⚙️ Auto Setup PowerShell Profile + PSFzf + Nerd Font
$ErrorActionPreference = 'Stop'

Write-Host "🚀 Starting PowerShell config setup..." -ForegroundColor Cyan

# 📁 Set paths
$profileDir = "$HOME\Documents\PowerShell"
$customProfilePath = "$profileDir\Microsoft.PowerShell_profile.ps1"
$configSource = "$PSScriptRoot\.config"

# 📝 Ensure profile directory exists
if (!(Test-Path -Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir | Out-Null
}

# 🔗 Create loader profile that loads from .config
$loaderContent = '. $env:USERPROFILE\.config\powershell\user_profile.ps1'
Set-Content -Path $customProfilePath -Value $loaderContent -Force
Write-Host "✅ Profile linked to .config version"

# 📦 Install PSFzf module
Write-Host "📦 Installing PSFzf module from PSGallery..."
Install-Module PSFzf -Scope CurrentUser -Force -AllowClobber

# 🔠 Install Hack Nerd Font
Write-Host "🔠 Installing Hack Nerd Font..."
$fontUrl = "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf"
$fontFile = "$env:TEMP\HackNerdFont-Regular.ttf"

Invoke-WebRequest -Uri $fontUrl -OutFile $fontFile

$ShellApp = New-Object -ComObject Shell.Application
$FontsFolder = $ShellApp.Namespace(0x14)
$FontsFolder.CopyHere($fontFile)
Write-Host "✅ Hack Nerd Font installed. Set this font in your terminal settings (e.g. Windows Terminal)."

Write-Host "🎉 Setup complete! Restart PowerShell or Windows Terminal to see changes." -ForegroundColor Green
