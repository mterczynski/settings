## IMPORTANT: This script is AI generated and may not be fully functional.
## It wasn't tested for all packages.

# Requires: Windows 10/11 with Winget installed

# Developer Tools
$devTools = @(
    @{ name = "Git.Git"; display = "Git (with Git Bash)" },
    @{ name = "OpenJS.NodeJS.LTS"; display = "Node.js (LTS, includes npm)" },
    @{ name = "Microsoft.VisualStudioCode"; display = "Visual Studio Code" },
    @{ name = "Python.Python.3"; display = "Python 3" },
    @{ name = "CoreyButler.NVMforWindows"; display = "NVM for Windows" }
)

# General Applications
$apps = @(
    @{ name = "Valve.Steam"; display = "Steam" },
    @{ name = "Signal.Signal"; display = "Signal" },
    @{ name = "Discord.Discord"; display = "Discord" },
    @{ name = "Telegram.TelegramDesktop"; display = "Telegram" }
)

function Install-Apps {
    param (
        [Parameter(Mandatory)]
        [array]$AppList,
        [string]$Category
    )

    Write-Host "`n### Installing $Category ###`n" -ForegroundColor Yellow

    foreach ($app in $AppList) {
        Write-Host "Installing $($app.display)..." -ForegroundColor Cyan
        winget install --id $app.name --silent --accept-source-agreements --accept-package-agreements
    }
}

# Install each category
Install-Apps -AppList $devTools -Category "Developer Tools"
Install-Apps -AppList $apps -Category "General Applications"