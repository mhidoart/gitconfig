#!/bin/bash

# Check if repository URL is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <repository_url> <email> <password>"
    exit 1
fi

repo_url="$1"
email="$2"
password="$3"

git config --global user.email "$email"
git config --global user.password "$password"

# Initialize Git repository if not already initialized
if [ ! -d .git ]; then
    git init
fi

# Add all files to staging area
git add .

# Commit changes
git commit -m "Initial commit"

# Add remote repository
git remote add origin "$repo_url"

# Push changes to remote repository
git push -u origin master

echo "Project pushed to remote repository."
