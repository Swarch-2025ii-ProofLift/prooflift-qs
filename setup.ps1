# ----------------------------
# Root folder
# ----------------------------
$RootDir = Get-Location

# ----------------------------
# Repos to clone (URL|branch)
# ----------------------------
$Repos = @(
    "https://github.com/Swarch-2025ii-ProofLift/prooflift-fe-ssr.git|develop",
    "https://github.com/Swarch-2025ii-ProofLift/prooflift-auth-be.git|development",
    "https://github.com/Swarch-2025ii-ProofLift/prooflift-posts-be.git|develop",
    "https://github.com/Swarch-2025ii-ProofLift/prooflift-suggest-be.git|development",
    "https://github.com/Swarch-2025ii-ProofLift/prooflift-mobile-fe.git|develop",
    "https://github.com/Swarch-2025ii-ProofLift/prooflift-notifications-be.git|develop",
    "https://github.com/Swarch-2025ii-ProofLift/prooflift-reverse-proxy.git|main"
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
    Get-ChildItem -Path $repoPath -Recurse -Include ".env.example" -File | Remove-Item -Force
    Get-ChildItem -Path $repoPath -Recurse -Include "docker-compose.yml" -File | Remove-Item -Force
}

Write-Host "All repos cloned and cleaned successfully."