# ==========================
# Configuration
# ==========================
$USERNAME = "brunocampos01"
$TOKEN = ""
$DEST_DIR = "C:\Users\$env:USERNAME\projects"

# ==========================
# Prepare folder
# ==========================
if (!(Test-Path $DEST_DIR)) {
    New-Item -ItemType Directory -Path $DEST_DIR | Out-Null
}

Set-Location $DEST_DIR

# ==========================
# Function: Clone or Update
# ==========================
function Sync-Repositories($repos) {

    foreach ($repo in $repos) {

        $repoName = $repo.name
        $cloneUrl = $repo.ssh_url   # use clone_url for HTTPS
        $repoPath = Join-Path $DEST_DIR $repoName

        if (Test-Path $repoPath) {

            Write-Host "Updating: $repoName"

            Set-Location $repoPath

            if (Test-Path ".git") {
                git pull
            }
            else {
                Write-Host "Folder exists but not a git repo. Skipping..."
            }

            Set-Location $DEST_DIR
        }
        else {

            Write-Host "Cloning: $repoName"
            git clone $cloneUrl
        }

        Write-Host "-----------------------------"
    }
}

# ==========================
# PART 1 — PUBLIC REPOS
# ==========================
Write-Host ""
Write-Host "===== Downloading PUBLIC repositories ====="

$page = 1
$publicRepos = @()

while ($true) {

    $url = "https://api.github.com/user/repos?visibility=public&per_page=100&page=$page"

    $response = Invoke-RestMethod `
        -Uri $url `
        -Headers @{
        Authorization = "token $TOKEN"
        Accept        = "application/vnd.github+json"
    }

    if ($response.Count -eq 0) { break }

    $publicRepos += $response
    $page++
}

Write-Host "Found $($publicRepos.Count) public repos"
Sync-Repositories $publicRepos


# ==========================
# PART 2 — PRIVATE REPOS
# ==========================
Write-Host ""
Write-Host "===== Downloading PRIVATE repositories ====="

$page = 1
$privateRepos = @()

while ($true) {

    $url = "https://api.github.com/user/repos?visibility=private&per_page=100&page=$page"

    $response = Invoke-RestMethod `
        -Uri $url `
        -Headers @{
        Authorization = "token $TOKEN"
        Accept        = "application/vnd.github+json"
    }

    if ($response.Count -eq 0) { break }

    $privateRepos += $response
    $page++
}

Write-Host "Found $($privateRepos.Count) private repos"
Sync-Repositories $privateRepos

Write-Host ""
Write-Host "Done ✅"
