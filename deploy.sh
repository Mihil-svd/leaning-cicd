#!/bin/bash

# Get the current branch name
branch=$(git symbolic-ref --short HEAD)

echo "🚀 Deploying branch '$branch' to 'main'..."

# Step 1: Push current branch
git push origin "$branch"

# Step 2: Switch to main and pull latest
git fetch origin
git checkout main
git pull origin main

# Step 3: Merge feature branch into main
git merge "$branch"

# Step 4: Push main branch
git push origin main

# Step 5: Switch back to original branch
git checkout "$branch"

echo "✅ Deployment complete."
