#!/bin/bash

# Optional: allow passing a custom commit message
COMMIT_MSG=${1:-"Auto-commit and deploy"}

# Get current branch name
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Check if on main, block deployment directly from main
if [ "$CURRENT_BRANCH" == "main" ]; then
  echo "❌ You are on the main branch. Make changes in a feature branch."
  exit 1
fi

echo "✅ Committing changes on $CURRENT_BRANCH..."
git add .
git commit -m "$COMMIT_MSG"

echo "🚀 Pushing branch '$CURRENT_BRANCH'..."
git push origin "$CURRENT_BRANCH"

echo "🔀 Switching to main..."
git checkout main

echo "📥 Pulling latest changes from main..."
git pull origin main

echo "🔁 Merging '$CURRENT_BRANCH' into main (auto message)..."
git merge "$CURRENT_BRANCH" --no-edit

echo "📤 Pushing main..."
git push origin main

echo "🔙 Switching back to '$CURRENT_BRANCH'..."
git checkout "$CURRENT_BRANCH"

echo "✅ Deployment complete!"
