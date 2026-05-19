#!/bin/bash

# 1. Define Paths
TEMPLATE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOCAL_EXCLUDE="./.git/info/exclude"

echo "🚀 Starting Antigravity Template Injection..."

# 2. Copy Files (Excluding Git history, README, and the script itself)
if command -v rsync >/dev/null 2>&1; then
    rsync -av \
      --exclude='.git' \
      --exclude='inject.sh' \
      --exclude='README.md' \
      --exclude='.DS_Store' \
      "$TEMPLATE_DIR/" ./
else
    cp -R "$TEMPLATE_DIR/." ./
    rm -rf ./.git ./inject.sh ./README.md ./.DS_Store
fi

# 3. Handle Antigravity AI Visibility (The Secret Sauce)
if [ -d ".git" ]; then
    echo "📝 Adding rules to local git exclude (AI will see them, Git will ignore them)..."
    
    # Create the directory if it doesn't exist
    mkdir -p .git/info
    
    # Append your folders to the local exclude file if not already there
    {
        echo -e "\n# --- Antigravity Agent Rules (Local Only) ---"
        echo ".agents/"
        echo ".context/"
        echo ".cursorrules"
        echo "user_tasks.md"
        echo "roadmap/"
    } >> "$LOCAL_EXCLUDE"
    
    # Clean up double lines
    sort -u "$LOCAL_EXCLUDE" -o "$LOCAL_EXCLUDE"
    
    # Force Git to refresh index so AI sees the new files immediately
    git rm -r --cached .agents/ .context/ .cursorrules roadmap/ user_tasks.md 2>/dev/null
    
    echo "✅ Local exclusion configured."
else
    echo "⚠️  No .git folder found. AI might not respect rules until you run 'git init'."
fi

echo "✨ Injection complete! Antigravity Agent is now active."