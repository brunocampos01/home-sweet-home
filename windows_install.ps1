# -----------------------------------------
#  Auto install Chocolatey + Apps (silent)
# -----------------------------------------

# Set policy for current process
Set-ExecutionPolicy Bypass -Scope Process -Force

# Enable TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 3072

# Install Chocolatey if not installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..."
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Optional: Refresh environment
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")

# Set log file
$log = "$env:USERPROFILE\choco_install_log.txt"
Start-Transcript -Path $log -Force

# Install packages
$packages = @(
    "python",
    "ojdkbuild8",
    "jre8",
    "jdk8",
    "maven",
    "7zip.install",
    "foxitreader",
    "flashplayerplugin",
    "curl",
    "intellijidea-community",
    "pycharm-community",
    "vscode",
    "vscode-python",
    "googlechrome",
    "chocolatey-windowsupdate.extension",
    "wsl-ubuntu-1804",
    "git.install",
    "git-lfs",
    "vlc",
    "dotnetfx",
    "ccleaner",
    "microsoft-teams.install",
    "spotify",
    "microsoft-windows-terminal",
    "jq"
)

foreach ($pkg in $packages) {
    Write-Host "Installing $pkg..."
    choco install $pkg --force --yes --ignore-checksums --no-progress
}

Stop-Transcript

Write-Host "All packages installed. Log saved at $log"

