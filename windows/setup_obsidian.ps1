# ----------------------------------------------------------- #
# Obsidian setup (Windows)
#  1. clones the vault repo
#  2. installs Obsidian
#  3. installs every community plugin + theme the vault uses
#  4. registers the vault in Obsidian and opens it
#
# Plugin settings, theme choice, CSS snippets and core plugins
# live inside the vault repo (.obsidian\), so the clone brings
# the configuration; this script makes sure the code is there.
#
# Usage:
#   powershell -ExecutionPolicy Bypass -File .\windows\setup_obsidian.ps1
# ----------------------------------------------------------- #

param(
    [string]$VaultRepo = "brunocampos01/obsidian",                    # GitHub owner/repo of the vault
    [string]$CloneDir = "$env:USERPROFILE\projects\obsidian",          # where the repo is cloned
    [string]$VaultSubdir = "obsidian"                                  # vault folder inside the repo
)

$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 3072
$VaultDir = Join-Path $CloneDir $VaultSubdir
$Headers = @{ "User-Agent" = "obsidian-setup" }
$Raw = "https://raw.githubusercontent.com/obsidianmd/obsidian-releases/master"

function Write-Section($text) {
    Write-Host ""
    Write-Host "========================================"
    Write-Host $text
    Write-Host "========================================"
    Write-Host ""
}

function Update-Path {
    $env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User")
}

function Install-WithWinget($id) {
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        winget install --id $id -e --silent --accept-package-agreements --accept-source-agreements
        Update-Path
        return $true
    }
    return $false
}

# ----------------------------------- #
Write-Section "1/5 Prerequisites (git)"
# ----------------------------------- #
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    if (-not (Install-WithWinget "Git.Git")) {
        if (Get-Command choco -ErrorAction SilentlyContinue) { choco install git.install --yes --no-progress; Update-Path }
        else { throw "git is missing and neither winget nor choco is available" }
    }
}
git --version

# ----------------------------------- #
Write-Section "2/5 Clone vault repo ($VaultRepo)"
# ----------------------------------- #
if (Test-Path (Join-Path $CloneDir ".git")) {
    Write-Host "Repo already at $CloneDir, pulling latest..."
    git -C $CloneDir pull --ff-only
    if ($LASTEXITCODE -ne 0) { Write-Warning "pull failed (local changes?), continuing with current checkout" }
} else {
    New-Item -ItemType Directory -Force -Path (Split-Path $CloneDir) | Out-Null
    $ghOk = $false
    if (Get-Command gh -ErrorAction SilentlyContinue) {
        try { gh auth status *> $null; $ghOk = ($LASTEXITCODE -eq 0) } catch { $ghOk = $false }
    }
    if ($ghOk) {
        gh repo clone $VaultRepo $CloneDir
    } else {
        # private repo: Git Credential Manager opens a GitHub sign-in window
        git clone "https://github.com/$VaultRepo.git" $CloneDir
    }
    if ($LASTEXITCODE -ne 0) { throw "git clone failed" }
}
if (-not (Test-Path (Join-Path $VaultDir ".obsidian"))) { throw "Vault not found at $VaultDir (check -VaultSubdir)" }

# ----------------------------------- #
Write-Section "3/5 Install Obsidian"
# ----------------------------------- #
$ObsidianExe = Join-Path $env:LOCALAPPDATA "Programs\Obsidian\Obsidian.exe"
if (Test-Path $ObsidianExe) {
    Write-Host "Already installed: $ObsidianExe"
} elseif (-not (Install-WithWinget "Obsidian.Obsidian")) {
    $releases = Invoke-RestMethod -Headers $Headers "https://api.github.com/repos/obsidianmd/obsidian-releases/releases?per_page=10"
    $asset = $releases | Where-Object { -not $_.prerelease } | ForEach-Object { $_.assets } |
        Where-Object { $_.name -match '^Obsidian-[\d.]+\.exe$' } | Select-Object -First 1
    if (-not $asset) { throw "Could not find the Obsidian installer" }
    $installer = Join-Path $env:TEMP $asset.name
    Write-Host "Downloading $($asset.browser_download_url)"
    Invoke-WebRequest -Headers $Headers -Uri $asset.browser_download_url -OutFile $installer
    Start-Process -FilePath $installer -ArgumentList "/S" -Wait
    Remove-Item $installer -Force
}

# ----------------------------------- #
Write-Section "4/5 Community plugins + theme"
# ----------------------------------- #
# Installs the latest release of every plugin listed in .obsidian\community-plugins.json
# (from the official Obsidian registry) when its code is missing. Existing data.json
# settings are never touched.
$cfg = Join-Path $VaultDir ".obsidian"
$enabledFile = Join-Path $cfg "community-plugins.json"
$enabled = @()
if (Test-Path $enabledFile) { $enabled = Get-Content $enabledFile -Raw | ConvertFrom-Json }
$registry = Invoke-RestMethod -Headers $Headers "$Raw/community-plugins.json"
foreach ($pluginId in $enabled) {
    $pdir = Join-Path $cfg "plugins\$pluginId"
    if ((Test-Path (Join-Path $pdir "main.js")) -and (Test-Path (Join-Path $pdir "manifest.json"))) {
        Write-Host "ok (in repo)  $pluginId"
        continue
    }
    $entry = $registry | Where-Object { $_.id -eq $pluginId } | Select-Object -First 1
    if (-not $entry) { Write-Warning "SKIP ${pluginId}: not in the community registry"; continue }
    $rel = Invoke-RestMethod -Headers $Headers "https://api.github.com/repos/$($entry.repo)/releases/latest"
    New-Item -ItemType Directory -Force -Path $pdir | Out-Null
    foreach ($a in $rel.assets) {
        if (@("main.js", "manifest.json", "styles.css") -contains $a.name) {
            Invoke-WebRequest -Headers $Headers -Uri $a.browser_download_url -OutFile (Join-Path $pdir $a.name)
        }
    }
    Write-Host "installed     $pluginId $($rel.tag_name)"
}

$appearanceFile = Join-Path $cfg "appearance.json"
if (Test-Path $appearanceFile) {
    $theme = (Get-Content $appearanceFile -Raw | ConvertFrom-Json).cssTheme
    if ($theme) {
        $tdir = Join-Path $cfg "themes\$theme"
        if (Test-Path (Join-Path $tdir "theme.css")) {
            Write-Host "ok (in repo)  theme $theme"
        } else {
            $themeEntry = Invoke-RestMethod -Headers $Headers "$Raw/community-css-themes.json" | Where-Object { $_.name -eq $theme } | Select-Object -First 1
            if ($themeEntry) {
                New-Item -ItemType Directory -Force -Path $tdir | Out-Null
                foreach ($f in @("theme.css", "manifest.json")) {
                    Invoke-WebRequest -Headers $Headers -Uri "https://raw.githubusercontent.com/$($themeEntry.repo)/HEAD/$f" -OutFile (Join-Path $tdir $f)
                }
                Write-Host "installed     theme $theme"
            } else {
                Write-Warning "SKIP theme ${theme}: not in the community registry"
            }
        }
    }
}

# ----------------------------------- #
Write-Section "5/5 Register vault and open Obsidian"
# ----------------------------------- #
# Obsidian rewrites obsidian.json on exit, so close it before editing
Get-Process Obsidian -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Sleep -Seconds 2
$configDir = Join-Path $env:APPDATA "obsidian"
$configFile = Join-Path $configDir "obsidian.json"
New-Item -ItemType Directory -Force -Path $configDir | Out-Null
$config = if (Test-Path $configFile) { Get-Content $configFile -Raw | ConvertFrom-Json } else { [pscustomobject]@{} }
if (-not $config.PSObject.Properties["vaults"]) { $config | Add-Member -NotePropertyName vaults -NotePropertyValue ([pscustomobject]@{}) }
$vaultPath = (Resolve-Path $VaultDir).Path
$vaultId = $null
foreach ($p in $config.vaults.PSObject.Properties) {
    if ($p.Value.PSObject.Properties["open"]) { $p.Value.PSObject.Properties.Remove("open") }
    if ($p.Value.path -eq $vaultPath) { $vaultId = $p.Name }
}
if (-not $vaultId) { $vaultId = -join ((1..16) | ForEach-Object { "{0:x}" -f (Get-Random -Maximum 16) }) }
$entry = [pscustomobject]@{ path = $vaultPath; ts = [DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds(); open = $true }
$config.vaults | Add-Member -NotePropertyName $vaultId -NotePropertyValue $entry -Force
# write without BOM: Obsidian cannot parse obsidian.json with a UTF-8 BOM
[IO.File]::WriteAllText($configFile, ($config | ConvertTo-Json -Depth 10 -Compress))
Write-Host "vault registered: $vaultPath"

if (Test-Path $ObsidianExe) { Start-Process $ObsidianExe } else { Start-Process "obsidian://open" }
Write-Host ""
Write-Host "Done. On first open Obsidian asks 'Do you trust the author of this vault?' -> click 'Trust author and enable plugins'."
