## This script was AI generated and not tested by human.

# Set mouse pointer speed to 5/11 (MouseSensitivity=8; Windows 10-11 uses 1-20, 8 corresponds to 5/11 in the UI)
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name MouseSensitivity -Value 5
# Disable "Enhance pointer precision" (MouseSpeed=0 disables acceleration)
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name MouseSpeed -Value 0
# Disable first threshold for mouse acceleration (MouseThreshold1=0)
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name MouseThreshold1 -Value 0
# Disable second threshold for mouse acceleration (MouseThreshold2=0)
Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name MouseThreshold2 -Value 0

# Set system theme to dark
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name AppsUseLightTheme -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name SystemUsesLightTheme -Value 0

# Set Brave as default browser (requires Brave installed)
$braveProgId = "BraveHTML"
$assocList = @(".htm",".html",".shtml",".xht",".xhtml",".webp",".pdf",".svg",".xml",".mht",".mhtml",".ftp",".http",".https")
foreach ($ext in $assocList) {
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c ftype $braveProgId=\"C:\\Program Files\\BraveSoftware\\Brave-Browser\\Application\\brave.exe\" --single-argument %1" -Verb RunAs -Wait
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c assoc $ext=$braveProgId" -Verb RunAs -Wait
}

# Set language to Polish (Poland) and set as display language
Set-WinSystemLocale pl-PL
Set-WinUserLanguageList -LanguageList pl-PL -Force
Set-WinUILanguageOverride -Language pl-PL
Set-WinHomeLocation -GeoId 191

# Set date format to DD/MM/YYYY and time to 24h
Set-Culture pl-PL
Set-WinLocale pl-PL
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sShortDate -Value "dd/MM/yyyy"
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name sTimeFormat -Value "HH:mm"
Set-ItemProperty -Path "HKCU:\Control Panel\International" -Name iTime -Value 1

Write-Host "Windows settings applied. Some changes may require logoff or restart to take effect."
