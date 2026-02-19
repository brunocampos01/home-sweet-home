Write-Host "=== Starship Prompt Setup ===" -ForegroundColor Cyan

# ---------- Check if Starship exists ----------
$starshipCmd = Get-Command starship -ErrorAction SilentlyContinue

if (-not $starshipCmd) {
  Write-Host "Starship not found. Installing..." -ForegroundColor Yellow

  $installScript = "$env:TEMP\install-starship.ps1"

  Invoke-WebRequest -Uri https://starship.rs/install.ps1 -OutFile $installScript
  powershell -ExecutionPolicy Bypass -File $installScript -Force
  Remove-Item $installScript -ErrorAction SilentlyContinue
}
else {
  Write-Host "Starship already installed." -ForegroundColor Green
}

# ---------- Ensure PowerShell profile exists ----------
if (!(Test-Path $PROFILE)) {
  New-Item -ItemType File -Path $PROFILE -Force | Out-Null
}

# ---------- Add Starship init to profile ----------
$profileContent = Get-Content $PROFILE -ErrorAction SilentlyContinue

if ($profileContent -notmatch "starship init") {
  Add-Content $PROFILE "`nInvoke-Expression (&starship init powershell)"
  Write-Host "Starship added to PowerShell profile." -ForegroundColor Green
}
else {
  Write-Host "Profile already configured." -ForegroundColor Green
}

# ---------- Create Starship config ----------
$configDir = "$env:USERPROFILE\.config"
$configFile = "$configDir\starship.toml"

if (!(Test-Path $configDir)) {
  New-Item -ItemType Directory -Path $configDir | Out-Null
}

$starshipConfig = @'
add_newline = false

format = """[$username$hostname](bold green) $directory $git_branch$git_status
$character"""

[username]
show_always = true
format = "$user"

[hostname]
ssh_only = false
format = "@$hostname"

[directory]
format = "📁 $path"
style = "bold blue"

[git_branch]
symbol = ""
format = "$branch"
style = "bold purple"

[python] 
symbol = "🐍 "  
style = "bg:yellow fg:black" 
format = "[ $symbol($version) ]($style)"

[java] 
symbol = "☕ " 
style = "bg:yellow fg:black" 
format = "[ $symbol($version) ]($style)" 

[cmd_duration] 
min_time = 500 
format = "[ ⏱ $duration ](bg:red fg:white)"

[character]
success_symbol = "[❯](bold green)" 
error_symbol = "[❯](bold red)"
'@

if (!(Test-Path $configFile)) {
    Set-Content -Path $configFile -Value $starshipConfig
    Write-Host "Starship configuration created at $configFile" -ForegroundColor Green
}
else {
    Write-Host "Starship config already exists at $configFile — skipping overwrite." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "✅ Installation complete!"
Write-Host "👉 Restart your terminal to see the new prompt."
