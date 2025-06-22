# main.ps1 - Main setup script

# Run install-apps.ps1
Write-Host "Running install-apps.ps1..."
& "$PSScriptRoot/install-apps.ps1"

# Run git-config.sh
Write-Host "Running git-config.sh..."
& bash "$PSScriptRoot/git-config.sh"

# Run clone-all.py
Write-Host "Running clone-all.py..."
python "$PSScriptRoot/clone-all.py"

# Run windows-settings.ps1
Write-Host "Running windows-settings.ps1..."
& "$PSScriptRoot/windows-settings.ps1"

Write-Host "All setup steps completed."
