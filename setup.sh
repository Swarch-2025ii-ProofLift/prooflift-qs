#!/bin/bash

# ----------------------------
# Root folder
# ----------------------------
ROOT_DIR=$(pwd)

# ----------------------------
# Repos to clone (URL|branch)
# ----------------------------
REPOS=(
  "https://github.com/Swarch-2025ii-ProofLift/prooflift-fe-ssr.git|develop"
  "https://github.com/Swarch-2025ii-ProofLift/prooflift-auth-be.git|development"
  "https://github.com/Swarch-2025ii-ProofLift/prooflift-posts-be.git|develop"
  "https://github.com/Swarch-2025ii-ProofLift/prooflift-suggest-be.git|development"
  "https://github.com/Swarch-2025ii-ProofLift/prooflift-mobile-fe.git|develop"
  "https://github.com/Swarch-2025ii-ProofLift/prooflift-notifications-be.git|develop"
  "https://github.com/Swarch-2025ii-ProofLift/prooflift-reverse-proxy.git|main"
)

# ----------------------------
# Clone and clean each repo
# ----------------------------
for repo in "${REPOS[@]}"; do
  IFS="|" read -r URL BRANCH <<< "$repo"
  REPO_NAME=$(basename "$URL" .git)

  if [ -d "$ROOT_DIR/$REPO_NAME" ]; then
    echo "$REPO_NAME already exists, skipping clone..."
  else
    echo "Cloning $REPO_NAME from branch $BRANCH..."
    git clone --branch "$BRANCH" "$URL" "$ROOT_DIR/$REPO_NAME"
  fi

  echo "Cleaning $REPO_NAME..."
  find "$ROOT_DIR/$REPO_NAME" -type f -name ".env*" -exec rm -f {} \;
  find "$ROOT_DIR/$REPO_NAME" -type f -name "docker-compose.yml" -exec rm -f {} \;
done

echo "All repos cloned/cleaned successfully."
