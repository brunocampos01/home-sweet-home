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
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")

# Set log file
$log = "$env:USERPROFILE\choco_install_log.txt"
Start-Transcript -Path $log -Force

# Install packages
$packages = @(
    "python",
    "temurin17",
    "flameshot",
    "maven",
    "7zip.install",
    "sumatrapdf.install",
    "curl",
    "intellijidea-community",
    "pycharm-community",
    "vscode",
    "vscode-python",
    "googlechrome",
    "chocolatey-windowsupdate.extension",
    "wsl-ubuntu-2204",
    "git.install",
    "git-lfs",
    "vlc",
    "dotnetfx",
    "microsoft-teams.install",
    "spotify",
    "microsoft-windows-terminal",
    "jq"
)

foreach ($pkg in $packages) {
    try {
        Write-Host "Installing $pkg..."
        choco install $pkg --force --yes --no-progress
    }
    catch {
        Write-Warning "Failed to install ${pkg}: $_"
    }
}

Stop-Transcript

winget install Anthropic.ClaudeCode
winget install SlackTechnologies.Slack

Write-Host "All packages installed. Log saved at $log"
