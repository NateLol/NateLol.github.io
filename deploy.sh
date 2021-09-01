#!/bin/sh

# If a command fails then the deploy stops
#set -e

#printf "Deploying updates to GitHub...\n"

# Build the project.
#hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
#cd public

# Add changes to git.
#git add .

# Commit changes.

rm -rf .git
rm -f .gitmodules
rm -rf data
rm -rf themes

git init

git config --global submodule.recurse true

git submodule add git@github.com:natelol/loveit.git themes/loveit
git submodule add git@github.com:natelol/comments data/comments

git add .

msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

git branch -M main
git remote add origin natelol:/natelol/natelol.github.io.git

# Push source and build repos.
git push -u origin main --force


