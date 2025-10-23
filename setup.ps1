# ----------------------------
# Root folder
# ----------------------------
$RootDir = Get-Location

# ----------------------------
# Repos to clone (URL|branch)
# ----------------------------
$Repos = @(
    "https://github.com/Swarch-2025ii-ProofLift/prooflift-fe-ssr.git|feature/deploy-config",
    "https://github.com/Swarch-2025ii-ProofLift/prooflift-auth-be.git|feature/userManagement",
    "https://github.com/Swarch-2025ii-ProofLift/prooflift-posts-be.git|feature/deploy-config",
    "https://github.com/Swarch-2025ii-ProofLift/prooflift-suggest-be.git|feature/deploy-config",
    "https://github.com/Swarch-2025ii-ProofLift/prooflift-mobile-fe.git|feature/deploy-config",
    "https://github.com/Swarch-2025ii-ProofLift/prooflift-notifications-be.git|develop"
)

# ----------------------------
# Clone and clean each repo
# ----------------------------
foreach ($repo in $Repos) {
    $parts = $repo -split '\|'
    $url = $parts[0]
    $branch = $parts[1]
    $repoName = ([System.IO.Path]::GetFileNameWithoutExtension($url))

    $repoPath = Join-Path $RootDir $repoName

    if (Test-Path $repoPath) {
        Write-Host "$repoName already exists, skipping clone..."
    } else {
        Write-Host "Cloning $repoName from branch $branch..."
        git clone --branch $branch $url $repoPath
    }

    Write-Host "Cleaning $repoName..."
    Get-ChildItem -Path $repoPath -Recurse -Include ".env*" -File | Remove-Item -Force
}

Write-Host "All repos cloned and cleaned successfully."
Write-Host "You can now use your generic docker-compose.yml and kong.yml files."
